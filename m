Return-Path: <linux-kernel+bounces-883577-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3058EC2DCAC
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 20:04:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7189518987AA
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 19:05:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F796296BA2;
	Mon,  3 Nov 2025 19:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WhuIUObr"
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 265D742A96
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 19:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762196684; cv=none; b=BkYIhFQTczQMDzj+cb06TLFV6D1jxdR87XHzmqL5nc8s2Z5eja7+2LHPoiXgGBx68y/rC9jmxrZCDLQ0cKGomtr13GUHh1MpbthyvIn7ubXFfFQugPyXcwmccUp7bBBF+Ro0kVGWrlZVIqoov0VBqArzl2GBVAeDyofvziRuld4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762196684; c=relaxed/simple;
	bh=Acu6nCSNSvz8pS2BvfksrtSxYWT6mvoKfQUBf7Y90g8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Vs0fQQIgXCGPsh7/uhHZFd5JBPK+vr56SmtKJ3BnSGUGgqgqRKgD/K3TckfAwjP6Y3Ib29dBbxldnznmvhG3ZcQbKYFNEFJ1TJXpvCAV0nq4cDkUE1oNk0BWAQRuxhOL7dzLjXOADQHcdPOy2dN3TWsoJ2JfyogyE1GSKPxEs98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WhuIUObr; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-421851bca51so4144678f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 03 Nov 2025 11:04:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762196681; x=1762801481; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZMnUjWbVQkFZgBYpGN6KEYbsBeg0MOvMFQqI7fxTNmc=;
        b=WhuIUObr+D/s9gsmb7cHMWwkU7bsu3TU6iS9cJ34I1S7db6JOIL+By5hY4tC3CAX96
         DHam/Khs1RfIDCYk4QZ/w9ltXN99RuRU3xIfme3MiojQcP1drPM90uuxPjKggPmsv0a4
         aDkw/8o8ZL5YpZ5rFq3eFY+ap9DYjID4rEEw+GefnXGeyveeQc7/SmW3m+Ng7MLVpvIr
         zddQRWEDAdrhNetFXrZKaTnEDZ4tFv2Yjbky3T2uVPP1ITz7DntNVFe/FpQIRTmT7D8N
         iKSjNSr08iVquc1F4GB29CuXtiwjXVr45Vonbt3OqTVp9I0UbARRk9ClfP28mu1Ywtwf
         zalA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762196681; x=1762801481;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZMnUjWbVQkFZgBYpGN6KEYbsBeg0MOvMFQqI7fxTNmc=;
        b=vOaT4eHBh7gftdRxIPvrubbv4jGH78UxkI/jQVO9hIGOu3w3xkxgq2yssQWN83jeAz
         fJUmvq2rAQ5r288qUiuwdnhOPXZgIB9QUWxn7qWwb/V0ulDEPhHbFiP/clNzUiO9MS6L
         ioJKMrQ2v3N5B2cC3j76kzqHZBF8Bm/2TqM1SjJ/OOCDlbWelsErak16ai+9k5YexhsF
         1fq4jBejKU6lN7mvB7L5X048l9zG7quCf6D8QtEZSrCqMNqGHl1m3GCbboOR46zGfWEU
         xv9Xr9NolR2+ZBAweS4cilWpsQmZcC9qPAdmzbWXdVhsTmztNEVcjDpJAenxzMMBI8cA
         /v0g==
X-Gm-Message-State: AOJu0YwM+kg47wkfIDn1127XYo8MzVE+r2fB+Kxoh1Kbn/6Rst1bycrc
	rtkrGBkCWdVTXkZWeWoC+Cc7cyBry/TpolXYD2aHaAuQxObKEqqOAx3ZPRcO2HiS
X-Gm-Gg: ASbGncu2yD2XwTwg0d4f59u+uGQf82CpW5uBmFMt/avH+hS/jk7QBMnn27uSf9tC4/F
	ADL8dV+aamBBwfN8OUvWwNrODAnRVBkg502sUWr6yeyquPxdSCs8O5GzRQfVSDPcLH7J4LorWaU
	BsFojRE+7cpgRzkK4yMuXJIGrUlakYPaFKV25L6E8XKs5tdox+sg8cSS86YqnJqnAelHNATKat5
	udel2wKtPr+pm39Y1shLhWdaR6J8K4ilJdEYRRCHbvg0qmrnnzCjpRNTGHdR4dAxDqaYtwhl6hJ
	gUiYgpsTrGLMh2jaovY47lmgz0QS3j+tEGfcT8Wgmfl/vwFzCwPC8Gwvw4iOvAdqsnPkPDHYfhE
	FE4EM/zs8ZL3ASGodIUxZGTKA45uhurNmY2R56A1tDPGXD71dBItefq5ANh5f5+veHT6uoJdNmy
	/PDxDoNBntCPOxf+da6JPFFUiNkFSFYmJW7u39FY9XA4o/KQYyF3E=
X-Google-Smtp-Source: AGHT+IFX6uSEmtDxOm0TWD6UoPf5193LhYGsOHconnTVDoJa6z3u55A5GqdprLwahRV5aW/TdqHiEw==
X-Received: by 2002:a05:6000:2dc5:b0:429:d3c9:b88f with SMTP id ffacd0b85a97d-429d3c9bb11mr2872576f8f.8.1762196680880;
        Mon, 03 Nov 2025 11:04:40 -0800 (PST)
Received: from fedora (cpc92878-cmbg18-2-0-cust539.5-4.cable.virginm.net. [86.16.54.28])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-429dc192ac4sm327407f8f.17.2025.11.03.11.04.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Nov 2025 11:04:40 -0800 (PST)
From: "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
To: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Cc: Uladzislau Rezki <urezki@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Christoph Hellwig <hch@infradead.org>,
	"Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Subject: [RFC PATCH v2 1/4] mm/vmalloc: warn on invalid vmalloc gfp flags
Date: Mon,  3 Nov 2025 11:04:26 -0800
Message-ID: <20251103190429.104747-2-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251103190429.104747-1-vishal.moola@gmail.com>
References: <20251103190429.104747-1-vishal.moola@gmail.com>
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
---
 mm/vmalloc.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 0832f944544c..290016c7fb58 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -3911,6 +3911,26 @@ static void *__vmalloc_area_node(struct vm_struct *area, gfp_t gfp_mask,
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
+	pr_warn("Unexpected gfp: %#x (%pGg). Fixing up to gfp: %#x (%pGg). Fix your code!\n",
+			invalid_mask, &invalid_mask, flags, &flags);
+	dump_stack();
+
+	return flags;
+}
+
 /**
  * __vmalloc_node_range - allocate virtually contiguous memory
  * @size:		  allocation size
@@ -4092,6 +4112,8 @@ EXPORT_SYMBOL_GPL(__vmalloc_node_noprof);
 
 void *__vmalloc_noprof(unsigned long size, gfp_t gfp_mask)
 {
+	if (gfp_mask & ~GFP_VMALLOC_SUPPORTED)
+		gfp_mask = vmalloc_fix_flags(gfp_mask);
 	return __vmalloc_node_noprof(size, 1, gfp_mask, NUMA_NO_NODE,
 				__builtin_return_address(0));
 }
@@ -4131,6 +4153,8 @@ EXPORT_SYMBOL(vmalloc_noprof);
  */
 void *vmalloc_huge_node_noprof(unsigned long size, gfp_t gfp_mask, int node)
 {
+	if (gfp_mask & ~GFP_VMALLOC_SUPPORTED)
+		gfp_mask = vmalloc_fix_flags(gfp_mask);
 	return __vmalloc_node_range_noprof(size, 1, VMALLOC_START, VMALLOC_END,
 					   gfp_mask, PAGE_KERNEL, VM_ALLOW_HUGE_VMAP,
 					   node, __builtin_return_address(0));
-- 
2.51.1


