Return-Path: <linux-kernel+bounces-662271-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D6A15AC37F8
	for <lists+linux-kernel@lfdr.de>; Mon, 26 May 2025 04:25:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7CABF1892A2B
	for <lists+linux-kernel@lfdr.de>; Mon, 26 May 2025 02:25:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D765155C83;
	Mon, 26 May 2025 02:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="IWQRHBlF"
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B072324B26;
	Mon, 26 May 2025 02:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748226301; cv=none; b=CNIir1bCljiATN7uBpY56Mg2BPVav93p0gkqMi6+daW45CUnQFJcb5gFP2Z6IoaU+h0uxrVKe59UREb9QI+ilauqLf5VS41fjZQZJnAVWi7k7xU51+71OrjNkBVS++RYlypABhz8ADqksjkweVigm8wNZfOoDAhvwsNqYX2M0Uk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748226301; c=relaxed/simple;
	bh=8oFnaDx8yWVXgMM76SE9vU05ZBgM/KqyVMU9quvFQu8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=CzTwPZkGtf+7e4JWmtoJKSgh6gl8gytUb/viyoAoeZ3E96eiQPfP2WTbz6tESA6zyw1IOgopaaf9yyQAZi+3wjWlUwlahEYIwtV05nh56No7XmnUHuTQOUZ3iLMBdR+Ix/jaHVP2eGzFfRGKvFPSsmnlelQMxUeVGEVmtbjnIKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=IWQRHBlF; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=We
	qACTZgfJCdNsvenNHl/KCtlQOAdLai2F3zW9rTuY4=; b=IWQRHBlFjkcYxj57iH
	uOdjLmFcSgibNF0j54QslfKu1lyUkDRHK2ud9XrqQNYp8s16EZ54zDcupUXQiDm/
	1xbJRdt3v4L6K/bU/5risITnj96Z7FgnM3rx11xT+K36HyRHVVHlLD9bhUi4WslW
	opvgPXvxeATs4z50q2z7X57bw=
Received: from icess-ProLiant-DL380-Gen10.. (unknown [])
	by gzga-smtp-mtada-g0-0 (Coremail) with SMTP id _____wCH3tPA0DNoKCDCDw--.56100S4;
	Mon, 26 May 2025 10:24:02 +0800 (CST)
From: Haoxiang Li <haoxiang_li2024@163.com>
To: tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	hpa@zytor.com,
	haoxiang_li2024@163.com,
	dan.j.williams@intel.com
Cc: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] x86/pmem: Fix a null pointer dereference in register_e820_pmem()
Date: Mon, 26 May 2025 10:23:58 +0800
Message-Id: <20250526022358.3657209-1-haoxiang_li2024@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wCH3tPA0DNoKCDCDw--.56100S4
X-Coremail-Antispam: 1Uf129KBjvdXoWruw48urWkAr1Dur1DWrWkXrb_yoW3Awb_Kr
	17K3yDurWFvr929F13Aw4fZr1fJwn7tFWF9r1UKFnavr90gr45X3yjqFWFyr43XrZ7KrWU
	XasxCrZxGFy7CjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRNg4S7UUUUU==
X-CM-SenderInfo: xkdr5xpdqjszblsqjki6rwjhhfrp/1tbiqAhZbmgzzXaLUQAAst

Add check for the return value of platform_device_alloc()
to prevent null pointer dereference.

Fixes: 7a67832c7e44 ("libnvdimm, e820: make CONFIG_X86_PMEM_LEGACY a tristate option")
Cc: stable@vger.kernel.org
Signed-off-by: Haoxiang Li <haoxiang_li2024@163.com>
---
 arch/x86/kernel/pmem.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/x86/kernel/pmem.c b/arch/x86/kernel/pmem.c
index 23154d24b117..04fb221716ff 100644
--- a/arch/x86/kernel/pmem.c
+++ b/arch/x86/kernel/pmem.c
@@ -27,6 +27,8 @@ static __init int register_e820_pmem(void)
 	 * simply here to trigger the module to load on demand.
 	 */
 	pdev = platform_device_alloc("e820_pmem", -1);
+	if (!pdev)
+		return -ENOMEM;
 
 	rc = platform_device_add(pdev);
 	if (rc)
-- 
2.25.1


