Return-Path: <linux-kernel+bounces-885728-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 743B8C33C8D
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 03:40:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F113718C5B4F
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 02:40:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57D172248B4;
	Wed,  5 Nov 2025 02:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="IR9Kdhti"
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C762156F20
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 02:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762310409; cv=none; b=Xdra6W/erHyKUOl8pmT5nWAMfayo1M/EhrhplFCvp5I2JoEQHHtCm8hjTxnxky4EGGnrHLUfVXs8MrX0RtXgsdt+14wC6VMbyhV6UFC4IF3e0XiG566G9MAU1vgUPT7lmWApYb7MlV85hDhSXei5fDcnv0GhzpSEdrn1++5QDTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762310409; c=relaxed/simple;
	bh=1rDTaHNFekXE6fYEIVxyVAYs5ptPRi9ZwWsq8XdzXQU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=bBlYA2tMy86hWaGmIZmjFvEV2Enr8SnqTVB8+77ShiHNJFJw4UWrLnSizmol/DkB+Ai5qlpgwREyFbvtiaAoHcYSr5ft4nExypN9Gzk3RZG1sX8+LCdmO5p0v6VyfGn3aEqOOUvMYwwYwS94jL/DxGjFD568x5NTQsizPceQ4Lo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=IR9Kdhti; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=BZ
	pnaGngs562nOrD3YutHkLMT0eZNZA+nV/m/y76+ho=; b=IR9KdhtikcbbuVqQ6A
	PGB/4WTyvNUzTln4jBqin4k1RNzDPVOmBwyyCqCUim0RcGb0QwiH5barC4TH0Zmy
	5SQO2yatcIVuGH80SydTyrUn2sFTfrwfS6u6M0mZUxPwbNfHnPz45CvdksIOrSZr
	NYDZUbl8kOLDwa40m4znHMHW4=
Received: from zengchi (unknown [])
	by gzga-smtp-mtada-g0-3 (Coremail) with SMTP id _____wDnb9vfuAppK7GSBg--.32612S2;
	Wed, 05 Nov 2025 10:39:28 +0800 (CST)
From: zeng_chi911@163.com
To: akpm@linux-foundation.org,
	surenb@google.com,
	kent.overstreet@linux.dev
Cc: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	zengchi@kylinos.cn
Subject: [PATCH] alloc_tag: Use %pe format specifier
Date: Wed,  5 Nov 2025 10:39:25 +0800
Message-Id: <20251105023925.1447482-1-zeng_chi911@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDnb9vfuAppK7GSBg--.32612S2
X-Coremail-Antispam: 1Uf129KBjvdXoWruw4fuFW3Jw4ktr15trW8WFg_yoWDCFb_G3
	45Jr4v934DGF1v9FsYvrnYqryqkw1v9F4rCrn5uws3J3srGwn5Xr18Xrn8AF13Ar429FyD
	KwsxWr1vva1a9jkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUnEfO5UUUUU==
X-CM-SenderInfo: 52hqws5fklmiqr6rljoofrz/1tbiRwv8u2kKtTARfAABsB

From: Zeng Chi <zengchi@kylinos.cn>

The %pe format specifier is designed to print error pointers. It prints
a symbolic error name (eg. -EINVAL) and it makes the code simpler by
omitting PTR_ERR();

This patch fixes this cocci report:
lib/alloc_tag.c:776:63-70: WARNING: Consider using %pe to print PTR_ERR()

Signed-off-by: Zeng Chi <zengchi@kylinos.cn>
---
 lib/alloc_tag.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/alloc_tag.c b/lib/alloc_tag.c
index f26456988445..27fee57a5c91 100644
--- a/lib/alloc_tag.c
+++ b/lib/alloc_tag.c
@@ -845,7 +845,7 @@ static int __init alloc_tag_init(void)
 
 	alloc_tag_cttype = codetag_register_type(&desc);
 	if (IS_ERR(alloc_tag_cttype)) {
-		pr_err("Allocation tags registration failed, errno = %ld\n", PTR_ERR(alloc_tag_cttype));
+		pr_err("Allocation tags registration failed, errno = %pe\n", alloc_tag_cttype);
 		free_mod_tags_mem();
 		shutdown_mem_profiling(true);
 		return PTR_ERR(alloc_tag_cttype);
-- 
2.25.1


