Return-Path: <linux-kernel+bounces-826943-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C6FDB8FB24
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 11:06:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CCB023AC4B1
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 09:06:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 259F627B34A;
	Mon, 22 Sep 2025 09:06:41 +0000 (UTC)
Received: from cmccmta2.chinamobile.com (cmccmta8.chinamobile.com [111.22.67.151])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5F6027C145
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 09:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.22.67.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758532000; cv=none; b=Vnc5Yklnt4IGJzxLDb5gDELa/9DoT0kYer+LCdSJMVGyl2HpGPViQ/2yE3knNMu4lF6/QsHvhPF9mm3wvhhFTV6846gbsOBKDkhJ2pE8gcuT4vYzIBMUeV/rAgqhtyXy++ErGlaWhjBgiXMPsfqodQKzHDkA3nPR3gzscaGZKik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758532000; c=relaxed/simple;
	bh=oDeIf1xa35tx31JztYqK1THQyqYY2PAChkYgXng55Ko=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=f7k/NI1iq1hvNxl6ZePrHaxk9lS29kKe36zRC/DV4qEqLrkZ09iga/WGaL7ibtg28TMMYBXUzcgNq2qQyqMEyyIPr2WCzaEd6X0hO13IxT+SMLgcmq1cBfCmGQH/A5LQXNguLsyE9rZkNQnt6ThWiycweRoU5IQrT/+AHHlgpYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com; spf=pass smtp.mailfrom=cmss.chinamobile.com; arc=none smtp.client-ip=111.22.67.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app06-12006 (RichMail) with SMTP id 2ee668d110dedd2-fb76a;
	Mon, 22 Sep 2025 17:03:27 +0800 (CST)
X-RM-TRANSID:2ee668d110dedd2-fb76a
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from localhost.localdomain (unknown[10.55.1.70])
	by rmsmtp-syy-appsvr01-12001 (RichMail) with SMTP id 2ee168d110deefd-9d6ff;
	Mon, 22 Sep 2025 17:03:27 +0800 (CST)
X-RM-TRANSID:2ee168d110deefd-9d6ff
From: liujing <liujing@cmss.chinamobile.com>
To: jpoimboe@kernel.org
Cc: peterz@infradead.org,
	linux-kernel@vger.kernel.org,
	liujing <liujing@cmss.chinamobile.com>
Subject: [PATCH] objtool: fix memory leak in tools/objtool/elf.c
Date: Mon, 22 Sep 2025 17:03:24 +0800
Message-Id: <20250922090324.2598-1-liujing@cmss.chinamobile.com>
X-Mailer: git-send-email 2.27.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If calloc succeeds but malloc fails (i.e., sym != NULL but name == NULL),
then memory has already been allocated for sym via calloc, but atthis
point sym is not freed, leading to a memory leak.

Signed-off-by: liujing <liujing@cmss.chinamobile.com>
---
 tools/objtool/elf.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/objtool/elf.c b/tools/objtool/elf.c
index ca5d77db692a..69766f8a49d6 100644
--- a/tools/objtool/elf.c
+++ b/tools/objtool/elf.c
@@ -859,6 +859,8 @@ elf_create_prefix_symbol(struct elf *elf, struct symbol *orig, long size)
 
 	if (!sym || !name) {
 		ERROR_GLIBC("malloc");
+		free(sym);
+		free(name);
 		return NULL;
 	}
 
-- 
2.27.0




