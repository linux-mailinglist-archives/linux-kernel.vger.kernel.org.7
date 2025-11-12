Return-Path: <linux-kernel+bounces-897967-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DE71C5408E
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 19:59:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 3F4A53460ED
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 18:59:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8658534C98A;
	Wed, 12 Nov 2025 18:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nncfSasT"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 720A4340DA6
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 18:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762973925; cv=none; b=E0qz9R9MZnyBV8s5at6DgwunxwQNt/2Q0mJ/azdLpNb0uHhXE+PAHL6R1xTKOl6U+830PCjQp+uEa06efWbNmG11fv0vTc5l2dD3yxnvXMysh4BB9DBRR3X2JvmssI8htyLUCVdvTg38cTDbebC0a5gKIfiefmnVKhGrwnJprSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762973925; c=relaxed/simple;
	bh=3/Vz0WT4gC1hndymh6gIvmz9w0Pvxo33wzsR8v46SX0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pNr9gbhrCQ6QS69UJnNCxq2j8otq4O9MCpDieaR9s2QMBS3uiENEUMVwzCpLt7LNOyMvl6r7xPfVEWUw5h+mtFp3wlDSzW3uoh3gfleu1i97IA6BkxxUDG/hEM3ju7FKKH7zpZBBhEXeGhF7ZctjQ8uJMai3udAKJ/URIMyRasg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nncfSasT; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-29586626fbeso11700775ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 10:58:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762973924; x=1763578724; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FOzeYRhvW6xlaG+pSPr/FnesrhCbCiDgfjq3/z1PcaI=;
        b=nncfSasTlHNemW4ZzKs1/lJOSW296qABIQ0bx1s4fJXcR1MweqRkgHTL4mxOvpk2kg
         1zvG9LUmLVBYpYB7bbEtzMuEDXpq1bU7jbqW8Q1T0dv3IVdhsY2zsNLxLOhkN9kCDTit
         fd6SWvbzRCRioc3Z4fOtVPffemhGaXOGvSS3ofl7etitelaiS59AzfcTiV5q/D1rkHE6
         cBOShvwBNERtWESNh0qqoXS6ZxKGWLDTFwnGxb5rIEbAt/CFYqXz+LZQhyx9Qn1kNG21
         M0bDerPYz3x2PWB214yC4GB/mHRXRrJCSklmASTdgmxFwzcHSoTvAKFbx4aTIggKvIAX
         hQpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762973924; x=1763578724;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FOzeYRhvW6xlaG+pSPr/FnesrhCbCiDgfjq3/z1PcaI=;
        b=EhR5PQ2aaL/f1TxhLJO+L6Afigwc5j1bGedfvdR/4X+6WFXehrUaAwytDCYAYk8jvo
         blpYs0s4urxOnAmOQxGqEBwl61vKY1xXCgAaUNfizMH/sKhccZCTf6vVV9PUC/TGFUvf
         rd3qkhdTe6ePD/K/Yo+0mB90DuotcJhfw8sgDulUSIvRtJQ09ufmYc5/QiR5ACqFySuU
         M9J9z576YLzjZZ6PVxlxnB2fe3oOXGKYKAOtF8Cn5j1aJmoyZkmmvkRHXFp3xXhQVmL5
         gfs9BJ8tmDZqvdgO/GmeKTInZTQ0uPklmywLy9d666tlUUkbzekiaCX/08DJAYG4AXO/
         Jtfg==
X-Forwarded-Encrypted: i=1; AJvYcCVl1wHuPLQKS0c+z75xZe1Fq4q1FE9w3Cq4nBlWwPjnqrufe72e9lK0O1o7caiJKZmmLBf8OVyWy+G0Uao=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBdETV/1xl9H1X5O7T3uKDlKmmkI3gVl6TLbPtHqWysFXYx6n1
	eMYjpIwZQvTOTT3kuRi3/3EwqteOZ6pg9rxbDbSeaIsS9LyqRkrtwZa8
X-Gm-Gg: ASbGncvWsXZlCFNghDAamxKOU6g9te2nWDJSvevWVSdpqRbfX4g/ZRTG8r2ANpmdreC
	WDyt1AQX4KDgFCHwGGqKrQwYeATUvQokCLTFFTnCLdP8W9x8XCzSguOv+gi+mvoo0XJdXFGQdmf
	3wFa71+lzmYIEfShI2M1ly9qBSCwmS0/QuYkCJ8wi8lVhf9/VC2GhD1VU8KdN3xI2Npb2TWj0hj
	ICwuV8xiMv1KCY/3KgFPSitqcL2VVJmgqMOnb3RtY6WFoUr3Py1REk9wEW01XhLZBjI5hS0m1Bh
	2jaVfwg92r2x72MDJ3vABVy9HHmKyhcQDb6AndRW7XmRgxaiAlfICo5tYG5Pv8N22LFPy8Wn93X
	Hd8eah7qQIOJET6OqgGq0JRG5yyIsjagyaGoLou39pjpdsCS0hFPa7UbHtYZ3DbuvlnLhUnNmBE
	XrIfwOiC4sa0RE9A74aXeNlJfrfzo8Cujo
X-Google-Smtp-Source: AGHT+IEJrBaRK17BHWcJTyjM/w29/bLHBps6owC9QTOW3jaEO5KXlOYxTfBkyQVQ+DswKdhsHIpiAA==
X-Received: by 2002:a17:902:dac3:b0:27e:ec72:f67 with SMTP id d9443c01a7336-2984ed27ec5mr50621645ad.6.1762973923702;
        Wed, 12 Nov 2025 10:58:43 -0800 (PST)
Received: from fedora (c-67-164-59-41.hsd1.ca.comcast.net. [67.164.59.41])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-343e06fe521sm3491565a91.1.2025.11.12.10.58.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Nov 2025 10:58:42 -0800 (PST)
From: "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
To: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Cc: Uladzislau Rezki <urezki@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Christoph Hellwig <hch@infradead.org>,
	"Vishal Moola (Oracle)" <vishal.moola@gmail.com>,
	Christoph Hellwig <hch@lst.de>
Subject: [PATCH v2 1/4] mm/vmalloc: warn on invalid vmalloc gfp flags
Date: Wed, 12 Nov 2025 10:58:30 -0800
Message-ID: <20251112185834.32487-2-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251112185834.32487-1-vishal.moola@gmail.com>
References: <20251112185834.32487-1-vishal.moola@gmail.com>
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
 mm/vmalloc.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 0832f944544c..802a189f8d83 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -3911,6 +3911,26 @@ static void *__vmalloc_area_node(struct vm_struct *area, gfp_t gfp_mask,
 	return NULL;
 }
 
+/*
+ * See __vmalloc_node_range() for a clear list of supported vmalloc flags.
+ * This gfp lists all flags currently passed through vmalloc. Currently,
+ * __GFP_ZERO is used by BPF and __GFP_NORETRY is used by percpu. Both drm
+ * and BPF also use GFP_USER, which is GFP_KERNEL | __GFP_HARDWALL.
+ */
+#define GFP_VMALLOC_SUPPORTED (GFP_KERNEL | GFP_ATOMIC | GFP_NOWAIT |\
+				__GFP_NOFAIL |  __GFP_ZERO | __GFP_NORETRY |\
+				__GFP_HARDWALL)
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
@@ -4092,6 +4112,8 @@ EXPORT_SYMBOL_GPL(__vmalloc_node_noprof);
 
 void *__vmalloc_noprof(unsigned long size, gfp_t gfp_mask)
 {
+	if (unlikely(gfp_mask & ~GFP_VMALLOC_SUPPORTED))
+		gfp_mask = vmalloc_fix_flags(gfp_mask);
 	return __vmalloc_node_noprof(size, 1, gfp_mask, NUMA_NO_NODE,
 				__builtin_return_address(0));
 }
@@ -4131,6 +4153,8 @@ EXPORT_SYMBOL(vmalloc_noprof);
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


