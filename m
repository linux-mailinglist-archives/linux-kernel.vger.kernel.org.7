Return-Path: <linux-kernel+bounces-783869-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EBE3B333A5
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 03:42:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 538E2174EE7
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 01:42:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D94522577C;
	Mon, 25 Aug 2025 01:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="EqeY0KOZ"
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ACA3225A23
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 01:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756086156; cv=none; b=qdDO08yFUTcGUrBQXKRjCEVaEsH9i6LiMbA0oTASOAalrNF1e+KNIZmj8fynx+CiZss/jRz2qma8NwgEZevNdHnz6mOOBpyaC9ddceRiZB/2nFKTplW8FZWxSmrZwVfjE3SL3e/ZiRHaCbhhm+ob0AwkjiqocQWY7bRO7VkuTlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756086156; c=relaxed/simple;
	bh=025IzmbW4Wc3EeyOm9XQcrgIQYgzrZ8MDSsacAZRxIc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=pyfMjfxke/QwobyDv3ZTSSVRHas7+IYUjt/8FCqUzfstzeXU6yOkRulZKO3D86W3EMwQvdVZ7DvO6b48kQgPN17NPAP8QWlw173TGzLznFfkVgZFXiHyN+CFqhb5KCNSsEvAycZkQcUwDqxjPjbVYrKBkESnMujWhX5tKJaMFZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=EqeY0KOZ; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=wi
	3bgEDBM9Uf2jfHLmZUkwbG/cbmvBsTkTYC1hpNh4E=; b=EqeY0KOZyDbLjqYVre
	KTIfyWWaLFZHGlMK5Y6h4uOUSGk4MXmd0LIPTtHBP4c0iO12yhATwhkWB/ouhY/q
	F6UXwRqwa/gImM/rlysxRxKY3+m+Dk7tzzH9OM7lQibVhqsLJCgKdMHLXumttO5I
	LkVT1yOwKZJawvaiIPDPYrkKg=
Received: from thinkpadx13gen2i.. (unknown [])
	by gzga-smtp-mtada-g0-0 (Coremail) with SMTP id _____wDXf4l3v6to2wewEA--.14893S2;
	Mon, 25 Aug 2025 09:42:16 +0800 (CST)
From: Zongmin Zhou <min_halo@163.com>
To: david.e.box@linux.intel.com
Cc: linux-kernel@vger.kernel.org,
	Zongmin Zhou <zhouzongmin@kylinos.cn>
Subject: [PATCH] tools/arch/x86/intel_sdsi: Fix memory leak when No command specified
Date: Mon, 25 Aug 2025 09:42:11 +0800
Message-Id: <20250825014211.11943-1-min_halo@163.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDXf4l3v6to2wewEA--.14893S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7GF48WFy7ZrW7Cw1rWw4rXwb_yoW3XFX_uF
	13Ww48CryrtFWrXFnYyr4S9rnavasrGFZ5Ary7Jw13Aa4IyF13GFWDA34UXrZY9a1qg3y3
	Aay3XryrAF4akjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUjiZ2DUUUUU==
X-CM-SenderInfo: pplqsxxdorqiywtou0bp/xtbBFAOuq2ikH3e69gABs7

From: Zongmin Zhou <zhouzongmin@kylinos.cn>

Just give devno and don't specified the command,return -1 on
default case directly can result to memory leak.

Signed-off-by: Zongmin Zhou <zhouzongmin@kylinos.cn>
---
 tools/arch/x86/intel_sdsi/intel_sdsi.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/arch/x86/intel_sdsi/intel_sdsi.c b/tools/arch/x86/intel_sdsi/intel_sdsi.c
index 766a5d26f534..dcdb88c21134 100644
--- a/tools/arch/x86/intel_sdsi/intel_sdsi.c
+++ b/tools/arch/x86/intel_sdsi/intel_sdsi.c
@@ -856,7 +856,8 @@ int main(int argc, char *argv[])
 			break;
 		default:
 			fprintf(stderr, "No command specified\n");
-			return -1;
+			ret = -1;
+			break;
 		}
 
 		sdsi_free_dev(s);
-- 
2.34.1


