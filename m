Return-Path: <linux-kernel+bounces-753385-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 07A18B1822A
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 15:07:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 676E11893F61
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 13:08:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFA8F248863;
	Fri,  1 Aug 2025 13:07:43 +0000 (UTC)
Received: from mail-m49209.qiye.163.com (mail-m49209.qiye.163.com [45.254.49.209])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0399724888F
	for <linux-kernel@vger.kernel.org>; Fri,  1 Aug 2025 13:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.209
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754053663; cv=none; b=AIf0qj3+gSWz7MnPeJfrq//jyfvyDrV1/8XosRyp3XyRy9Z8udG6GDLlbhSG+ddhNbvJbd05T9pZe5BD/oBgpH3PTyT0LcOct6ehG1HGkCV80f/nRIuvmtEWU0jma6LCvhWVfu/AZs4k0XEMGf4MTq9W28wD/KGiXUgD44DcTQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754053663; c=relaxed/simple;
	bh=xBjwl1bA2FRmWOAyE5kgiZK7QB4YfWpe9UEwYfWq6Ik=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=O/KkVCId/IbyBB8KfHdI2yQGtKCOxw92BVF1/+mgA1OkCnENLD5gubhQqQwpJQU7jFikwE6UiXtAXykyOTCH7u+mWIAUwM01TfjvhH8X2JukZyccrhCTmorbVdcUcSh7uyxTGrKIFVavhJDtFK+q0Sl/Gaoay+vdI/HjW1selXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=easystack.cn; spf=pass smtp.mailfrom=easystack.cn; arc=none smtp.client-ip=45.254.49.209
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=easystack.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=easystack.cn
Received: from localhost.localdomain (unknown [218.94.118.90])
	by smtp.qiye.163.com (Hmail) with ESMTP id dfd58cf5;
	Fri, 1 Aug 2025 17:38:17 +0800 (GMT+08:00)
From: Zhen Ni <zhen.ni@easystack.cn>
To: rmk+kernel@armlinux.org.uk
Cc: linux-kernel@vger.kernel.org,
	Zhen Ni <zhen.ni@easystack.cn>
Subject: [PATCH] fs/adfs: bigdir: Restore EIO errno return when checkbyte mismatch
Date: Fri,  1 Aug 2025 17:38:06 +0800
Message-Id: <20250801093806.1223287-1-zhen.ni@easystack.cn>
X-Mailer: git-send-email 2.20.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9864ff1d5d0229kunm7c5194bb1fe438
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFJQjdXWS1ZQUlXWQ8JGhUIEh9ZQVkaGUhLVhoZSUxITBkeHx5LSVYVFAkWGhdVGRETFh
	oSFyQUDg9ZV1kYEgtZQVlJSkNVQk9VSkpDVUJLWVdZFhoPEhUdFFlBWU9LSFVKS0lPT09IVUpLS1
	VKQktLWQY+

Fix smatch warn:
fs/adfs/dir_fplus.c:146 adfs_fplus_read() warn: missing error code 'ret'

Signed-off-by: Zhen Ni <zhen.ni@easystack.cn>
---
 fs/adfs/dir_fplus.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/adfs/dir_fplus.c b/fs/adfs/dir_fplus.c
index 4a15924014da..4334279409b2 100644
--- a/fs/adfs/dir_fplus.c
+++ b/fs/adfs/dir_fplus.c
@@ -143,6 +143,7 @@ static int adfs_fplus_read(struct super_block *sb, u32 indaddr,
 
 	if (adfs_fplus_checkbyte(dir) != t->bigdircheckbyte) {
 		adfs_error(sb, "dir %06x checkbyte mismatch\n", indaddr);
+		ret = -EIO;
 		goto out;
 	}
 
-- 
2.20.1


