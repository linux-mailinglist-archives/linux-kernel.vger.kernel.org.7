Return-Path: <linux-kernel+bounces-893611-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68242C480E2
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 17:43:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD9FF4A27CE
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 16:08:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D38F276041;
	Mon, 10 Nov 2025 16:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y02j/7Hr"
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F8E927703E
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 16:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762790912; cv=none; b=HE/FSuTfXumqsL/8jpXHd/rey45n4KohZwNWDbGgbHBF1pAHy1qzVacFeif7MD6h75OkJnX0Ls+sgD4Dv3Q9HBPupKuf1mznkohVYQQ8oTzcmboVUhPKTmmWe2DESt//vqN0ipbZM/gYcP6qST3TiyGbTqJSqezGu4S4JEW8NmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762790912; c=relaxed/simple;
	bh=/bmmwutYCHH19yBtDP0+EGs0PtX/kZ6KDP1Ij/Jgksw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ki+njGm8qz/lfzNBl2ztRx71g9WdTnc1VLt5OIDVP7l5oiJlU9mx5GefXTMQ7Phsck9stcztmuye7gnMlPRIBu3/p/3j9NtP+B0CM31IDes5PMG7ebSyfdi6oKS5arnQ7gvP2u+FvtKc4+uAo8h460F15LT0EKCHUh/ZWOTG2hQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y02j/7Hr; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-7a9c64dfa8aso2657134b3a.3
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 08:08:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762790910; x=1763395710; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qsROCixNOuApxHyZK7gXdF4l+D+ySewC5WOa3I1V+Os=;
        b=Y02j/7HreEGaHgtOTzb134aBDBbY3PvwOB+4khb4KD1G5xF5OVVlKvC11uDTeqIDYD
         7sj+tfT09+kaGEJTt+69QwIO3fsRCBrJnyv2VstWQow78ZwLAhNv8oQXyeAkVtzUoLFh
         iOyK5nCLXCz46WoDRgRlT0liYsElRddQlxLyp2CKi+2+tICZn+Rxjy+4s+a8qYtj8dsE
         cGtTz2mwDbfg3ildVdOPWQtntp8vaIUjs+22BeksWTB0955wFuIJW6AwOb+ZOlx+l83b
         DaWKeF+xr/UX2KY1cJxU+KwzsafrC2m36iA8vhI2Ypg5D+9Q0wMUlLeWZtEu9XntqYX7
         eCGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762790910; x=1763395710;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qsROCixNOuApxHyZK7gXdF4l+D+ySewC5WOa3I1V+Os=;
        b=jO1K7VQnGmF7/+GCP5zcK9wbQm+lIYpFJx+w7Vy9TxYzMf3ikfxodVoO/TxWkKdlx3
         vj0E//exuXm2kGmxgLn0GclMkL93i4+/xiZ2GIgjBG/2SRikAXxazlxCSc2g9WfwhMQv
         6lG4kFQBAwSnJluQk2HzH1uJtyMnphNlI/k+7qZMBBPEB3m5DRxKSPQ0hC5a0IoY5EEf
         iweA9lxd3UUoBZz1sXEFk1VOSZQB7fdmU3CWVBU0fm+OoXes+l+ikxzR/i2FX0Mo7N5g
         GGkiJA8QKMpTjExSW2A7gP6YzZasy1lhYVq4IUSrF6S0Xpau6UKj5RXxK73rB2Q7kjAv
         O5LQ==
X-Gm-Message-State: AOJu0YxjY+nKkO1ruEL7JhCHmdH7aMgAaV09LrC0aX3mQKQlJFPrDMg7
	wIxqZ8/hqzd6DiHFYLAJRa8b8Ez7h7CvNM7fHDzObRMFXipP71xYbPHM2OuY31V2
X-Gm-Gg: ASbGncs6l/E/beCgjcx5WbIeP4NGhfLVZbz4gvY6i7vaWIcpG9Ja3QGcChXOEn56oUD
	OD79J+lbOady9xLGPjaDJoxSLqzU0QYmwBHjpFo5qrlHrdN5n4VS9A2cpGGV+47R3l/8Cp80lLb
	vtS0Ql+KLbAsAAPu0CLHsf87LcvG3/SdYg+VUZp43O3m9MfyIyEj/GE2PpbtcWf+H+cfK8gCK7r
	jaN4AVLakOQ+pwF8leVgyCWRDILZpCy0bB9NVaXHw4p7mZEY9LOu0vZpAc3F5yn2lxxjedxnFHt
	1QpXFXERCn+ZBzKE0utWG8K8CdBQGlf8pJAht6druTjNwps+4RnelqSZQ2b9cv6i4eVSNm8nED5
	IGpG2N1PaUISDbKPT+VqdzU8jD2BqyFYGzIzT6jZZiCILLwTitOR5USTd5P4nf03nsVjIU7mroV
	dzilnJxrUQQvztaPSnen8gQNQaab+GhnVR/HZu4OfCw+0=
X-Google-Smtp-Source: AGHT+IE0p9n8dZRGN9vzgSNrFPz/vcuJc13wQOFI6Ed74ktnG3oB8JYFFwon7pTE9YKVzLQLoDtHJg==
X-Received: by 2002:a17:90b:5103:b0:336:bfce:3b48 with SMTP id 98e67ed59e1d1-3436cb8e372mr12915080a91.9.1762790909887;
        Mon, 10 Nov 2025 08:08:29 -0800 (PST)
Received: from fedora (c-67-164-59-41.hsd1.ca.comcast.net. [67.164.59.41])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-34362f1f231sm9308893a91.10.2025.11.10.08.08.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Nov 2025 08:08:29 -0800 (PST)
From: "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
To: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Cc: Uladzislau Rezki <urezki@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Christoph Hellwig <hch@infradead.org>,
	"Vishal Moola (Oracle)" <vishal.moola@gmail.com>,
	Christoph Hellwig <hch@lst.de>
Subject: [PATCH 1/4] mm/vmalloc: warn on invalid vmalloc gfp flags
Date: Mon, 10 Nov 2025 08:04:54 -0800
Message-ID: <20251110160457.61791-2-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251110160457.61791-1-vishal.moola@gmail.com>
References: <20251110160457.61791-1-vishal.moola@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Vmalloc explicitly supports a list of flags, but we never enforce them.
vmalloc has been trying to handle unsupported flags by clearing and
setting flags wherever necessary. This is messy and makes the code
harder to understand, when we could simply check for a supported input
immediately instead.

Define a helper mask and function telling callers they have passed in
invalid flags, and clear those unsupported vmalloc flags.

Suggested-by: Christoph Hellwig <hch@infradead.org>
Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 mm/vmalloc.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 0832f944544c..40d4bdcadb6d 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -3911,6 +3911,24 @@ static void *__vmalloc_area_node(struct vm_struct *area, gfp_t gfp_mask,
 	return NULL;
 }
 
+/*
+ * See __vmalloc_node_range() for a clear list of supported vmalloc flags.
+ * This gfp lists all flags currently passed through vmalloc. Currently,
+ * __GFP_ZERO is used by BFP and __GFP_NORETRY is used by percpu.
+ */
+#define GFP_VMALLOC_SUPPORTED (GFP_KERNEL | GFP_ATOMIC | GFP_NOWAIT |\
+				__GFP_NOFAIL |  __GFP_ZERO | __GFP_NORETRY)
+
+static gfp_t vmalloc_fix_flags(gfp_t flags)
+{
+	gfp_t invalid_mask = flags & ~GFP_VMALLOC_SUPPORTED;
+
+	flags &= GFP_VMALLOC_SUPPORTED;
+	WARN(1, "Unexpected gfp: %#x (%pGg). Fixing up to gfp: %#x (%pGg). Fix your code!\n",
+			invalid_mask, &invalid_mask, flags, &flags);
+	return flags;
+}
+
 /**
  * __vmalloc_node_range - allocate virtually contiguous memory
  * @size:		  allocation size
@@ -4092,6 +4110,8 @@ EXPORT_SYMBOL_GPL(__vmalloc_node_noprof);
 
 void *__vmalloc_noprof(unsigned long size, gfp_t gfp_mask)
 {
+	if (unlikely(gfp_mask & ~GFP_VMALLOC_SUPPORTED))
+		gfp_mask = vmalloc_fix_flags(gfp_mask);
 	return __vmalloc_node_noprof(size, 1, gfp_mask, NUMA_NO_NODE,
 				__builtin_return_address(0));
 }
@@ -4131,6 +4151,8 @@ EXPORT_SYMBOL(vmalloc_noprof);
  */
 void *vmalloc_huge_node_noprof(unsigned long size, gfp_t gfp_mask, int node)
 {
+	if (unlikely(gfp_mask & ~GFP_VMALLOC_SUPPORTED))
+		gfp_mask = vmalloc_fix_flags(gfp_mask);
 	return __vmalloc_node_range_noprof(size, 1, VMALLOC_START, VMALLOC_END,
 					   gfp_mask, PAGE_KERNEL, VM_ALLOW_HUGE_VMAP,
 					   node, __builtin_return_address(0));
-- 
2.51.1


