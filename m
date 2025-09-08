Return-Path: <linux-kernel+bounces-805796-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BAAAB48D8C
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 14:32:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E79A17B703
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 12:31:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DA4B137932;
	Mon,  8 Sep 2025 12:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N+zbDYuF"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 716064690
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 12:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757334699; cv=none; b=CgYmPS2O4k2TpeZWOn98bQNmcABm91d478FKev/u0vwaTl344Ouy7EXTLAbt3ZOviga3H7Hm4fKnLHnJVSehQCEhmoh4xxxm8U3lhLY58CtzgO+9ymsuez6Poa42YV91CIIp8tWswqf2MMJBBgQnt7WXQx/qvqf2tA2RPuHNqhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757334699; c=relaxed/simple;
	bh=twuXHPE3vjnD84NvuzbSivgqcNkSP2NRFC4ur0rjF0w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=e2Zxj5p+Js+zIB4IVcG/Lf05dGqPE9mqqbghC2dXmCxH3IdnhEW2v3EK+fsb1bzvUbEZUuUUufXs68BUsD8OW2yx4EI8GeIw5y+MEblkee0wuoP05Bzxz9Qlsdx7dgiSDn/4tLHWyjJXoOlz8k1+CX41oHRI/OvgDTungMleM+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N+zbDYuF; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-25669596955so9634645ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 08 Sep 2025 05:31:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757334697; x=1757939497; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lKA8CeH1Jf9s6GMGryOJofCBa7AiapRIomxST1vM7SM=;
        b=N+zbDYuF0HWjizIBOijLUXM71g8VAWWAid11nnf4RKFhdSgHUZygkQfxjsUUyTwADX
         9zTD1OMBJf7Faf8PM/3Zpail3l3YjwmXSVpJJtuMCaam7Rh5ErcCxVtV1uKVj7fM+tlW
         6yTS85qGe076GYUvoJ1tKoOtNCbYK+In0Vwp9kCDsQGwGmF3b23z51wXXCcGv9IGaaln
         hVYX1SrZ/z/qh8lG9khIRrGAHg5y8dU17rCML45TI0jOdMs0+ThlmWWHeies8itkYS/M
         oVYTUgNaOnqnWIMfo84BzZ3J9EixhQSvGqvljbj424w6CO5mWHMBEM+zSPXiztiRVYvh
         BnuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757334697; x=1757939497;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lKA8CeH1Jf9s6GMGryOJofCBa7AiapRIomxST1vM7SM=;
        b=HxA3RsjYswuHw9mCYxaMZr05qaUDy3OIfQ/ZrMwrgplcrlBD6o+Zk4h9Sx2ainawFi
         oPICev8obqDTDH6cxo0xgR8ZT55s12F+iMWZR6AMQft4WLQPJbGKAP1vWqWmmyg02kMk
         LLdkRsQ4hhfYwgA+UHt5RfJBigs9QppGG3rJq186IeZPnc/0b9EuacwrBkM6K8zCF2Ej
         kUzVn9fVktvJkcyTgvOWd3qWjF1XTdwzYw5U8ZTgjWFkGtx3YKSKgvrELPeEXeUyaLWF
         L0R9rUgJJz7g2HoJrJaf4/CZUsHW4KBxJgnYz4HstB+xe8mZbNEGqD5PEwNKBdTfjXAk
         VyuA==
X-Forwarded-Encrypted: i=1; AJvYcCX2/QMNAxnQOL1KYOTeZAxnhE9A+GF9cgd3ZOy6e74ChX57qmatZSY7FAVLdYuSabTA1aJe5ULxUFCep6Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YwhTL109Lb3IBQIaXpXcKx9/Y5VrnL5KUT9HrgmayAS4LyUDgtq
	jd5F2GQgCA+JynsUIrErhoqwxDAx/5DKh2Z39PvSgrgHjDHmbIvHtH+MjQtsTA==
X-Gm-Gg: ASbGncvCfm1oJ0MmVHPcbl6RyqoPICUrGvSk3p5F6NnduOZR7KoE+aHcybCAZzCvFNg
	Q1Rvu/qp3iB+fQP1BNfnpNzDPe4s09dMax7q0fycW2+f6a6BdJ9Dr+LM9BbQKukR2A+TlD++VA4
	+kkWxPVjJH/nqY09tKnX7hOpC3RPxAymwMuCxI9XxrTw+XHX8nFdNOrgVTdcm6UU7A5unbMZvbu
	HgNpbM50TW+K5dLAVCEsVqKRKun+VvwOHupaFL2e27aSF5vcmS58Nps+43Jtc93DRNA7JThwNRM
	PLgAitVmFbQfMcERTkhR2VCNo0o8DjtWy/9miO6kNnenhk2+kvHCkvdo42fxwyBBoD+MHtbb3YN
	wwaxzTLTns868qE29A0peSO8rGluq8hO3g/vU
X-Google-Smtp-Source: AGHT+IGqbl9K/vxumxwyrMQMiImYe1FTUxMy6YSu8nnGoC0kccw1+3rbsfuMZVqUmMYoE1fzMKt/8g==
X-Received: by 2002:a17:902:dad0:b0:24c:e3bf:b469 with SMTP id d9443c01a7336-2516fbdb555mr127178775ad.15.1757334696591;
        Mon, 08 Sep 2025 05:31:36 -0700 (PDT)
Received: from localhost.localdomain ([180.121.125.237])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24c9e3909cesm136315815ad.70.2025.09.08.05.31.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Sep 2025 05:31:36 -0700 (PDT)
From: Vernon Yang <vernon2gm@gmail.com>
To: hughd@google.com,
	baolin.wang@linux.alibaba.com,
	akpm@linux-foundation.org,
	da.gomez@samsung.com
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Vernon Yang <yanglincheng@kylinos.cn>
Subject: [PATCH] mm: shmem: fix too little space for tmpfs only fallback 4KB
Date: Mon,  8 Sep 2025 20:31:28 +0800
Message-ID: <20250908123128.900254-1-vernon2gm@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Vernon Yang <yanglincheng@kylinos.cn>

When the system memory is sufficient, allocating memory is always
successful, but when tmpfs size is low (e.g. 1MB), it falls back
directly from 2MB to 4KB, and other small granularity (8KB ~ 1024KB)
will not be tried.

Therefore add check whether the remaining space of tmpfs is sufficient
for allocation. If there is too little space left, try smaller large
folio.

Fixes: acd7ccb284b8 ("mm: shmem: add large folio support for tmpfs")
Signed-off-by: Vernon Yang <yanglincheng@kylinos.cn>
---
 mm/shmem.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/mm/shmem.c b/mm/shmem.c
index 8c592c6db2a0..b20affd57b23 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -1820,6 +1820,7 @@ static unsigned long shmem_suitable_orders(struct inode *inode, struct vm_fault
 					   unsigned long orders)
 {
 	struct vm_area_struct *vma = vmf ? vmf->vma : NULL;
+	struct shmem_sb_info *sbinfo = SHMEM_SB(inode->i_sb);
 	pgoff_t aligned_index;
 	unsigned long pages;
 	int order;
@@ -1835,6 +1836,18 @@ static unsigned long shmem_suitable_orders(struct inode *inode, struct vm_fault
 	while (orders) {
 		pages = 1UL << order;
 		aligned_index = round_down(index, pages);
+
+		/*
+		 * Check whether the remaining space of tmpfs is sufficient for
+		 * allocation. If there is too little space left, try smaller
+		 * large folio.
+		 */
+		if (sbinfo->max_blocks && percpu_counter_read(&sbinfo->used_blocks)
+						+ pages > sbinfo->max_blocks) {
+			order = next_order(&orders, order);
+			continue;
+		}
+
 		/*
 		 * Check for conflict before waiting on a huge allocation.
 		 * Conflict might be that a huge page has just been allocated
-- 
2.51.0


