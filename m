Return-Path: <linux-kernel+bounces-878692-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B9E7C21478
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 17:47:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D5CFD4EFF37
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 16:44:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B6DA366FA2;
	Thu, 30 Oct 2025 16:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d6eSlvLk"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 219E22E339B
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 16:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761842626; cv=none; b=q31HG2EtHKn6TW9/AzCM2jd/EWSzMhRTob4gcQPFkTFOTSUuQPx5mzLVbvK2f7/Az9GZlNK8S1xYXQxXlR+i4WM1fcZgNTvdzKOsFWyPR2PKORg+7fXcvPP8INd5PBKI5I5drFHZXYpR2uNRutTbtUIbNWxQQYwdE0q9K/obbSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761842626; c=relaxed/simple;
	bh=290DYZFol6HilP4Nzr77qjGUwDD1KEpSFbWkYRqaoVE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R9kljI+ELhO+OiVnNiEA8vGONdgTiDXG20cFeIqWtPx0mWDKzKbpcBvB5fG47Mpoe8fs+cRYPXRM7rPQQxHxjjcM5EE/U4TWd1JLYQseBdk5qn3db/YxHvz0OxerKA3OtS/WfgSboYV48q6sMhp3CnWCNR3Y6UG85kgj4w3Bwk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d6eSlvLk; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-47117f92e32so11571085e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 09:43:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761842623; x=1762447423; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8rJR2QNXI8LxWN+nXgPzLnA8HQF9631natZVXu0HRJo=;
        b=d6eSlvLkhja4Riz0IsosPsY3TrnhxwHI2xeCEJjSGNNWhU9OgoncvFAoKRHaJ2b/5e
         ZxRTXYBXd64v7yh3ZYIcYWegpF6OwQxP69Gs7QHvUJPgQikmZf2DIkEAkFRaIYOXjc4u
         +R2/0qiOJDXKaus5RYHeHoXie3KGahhuUEqKPWj29x7hvFLdcPZp4aYSmK/cUwMSKhYJ
         w2WD3w1+j6WsJEZPHhQ0EWflBpQQWrDCFTTlgEvstXMRevrhqf6SJceX9HNDZl+FZAkl
         i4USECH3h4R8aOjNSFMRf+JR0Rhx4pQE+3SxDg/H2Dq0CQ5aZDFwY6TPQ+UQFi6GY00Z
         Wnlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761842623; x=1762447423;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8rJR2QNXI8LxWN+nXgPzLnA8HQF9631natZVXu0HRJo=;
        b=Vmcxz3nQ/9m6bFoYsYmv1dru+oeZH85R5C2/K0+XvB0SL4JF137Kb8Fhqc3BtK56em
         MWXis8ALVc3XHenk+ZwAZzOHv1Y7hHt16dnPtGWh1y2F5NYx0q/PpEzDvn85zyWgy6mN
         FagSwSNEGXaFElXTg8IwyTF4n532mkdczHrecH++dCwxlubA9jgwULz7N54gVy2p374o
         hzn4qHbUquH0wMrN0hDnYcT5Zgfp8ilsS96DmqPKHSuStEF9p5bjoKC93c+r2dwIBx+7
         gfb9TzO9GMVMnxz/LxyRnEsT5TZ7xq5yjrzTrW4U3LP9hocA0+XypvEOYpsfIP9Mpl4f
         NxNQ==
X-Gm-Message-State: AOJu0Yy7STfFGvXmxO5PyUeTKFfTZoyxI8nPBjyVjpSvCQXkVkUeoQu/
	2WG9ZVUJjQ6RbKFJOOSUZdYjmmDU8NI8uVq6uH0fYaQJHfZc5hj0HWHjSZV+aKQ/7XM=
X-Gm-Gg: ASbGncskFHV+c8bQzNYICgvhZnGomrhy53AW7HW9yNLltBGksrPcTnPkioRx/fcv5TW
	vtlW3Ae5vZTRptIGLsglKK5tbzwJ2+Kvb3HYgrOk9hbBKRE4qJOP2Iz/iN0lRZXbPYJOgnGRn6j
	GQwREEIfyQQ1KbdIJTwmTFSBPGCNOuGCKA/QPqfcrADVhpnJpF8ZKeaCSj604iVXo2F6kPLYjDA
	AFYGkoo9J0n01i6bKbaVrD/q2tYVP/O7nmGZ8q25ZTsruYhV4mKa//fyKB7WaSihxYnO/APRuun
	pfgTa/drW0F/9eba6dDRxbxtcmQlTEoP4ivy5xBr76RqVAIrbECxxbFZGK83+pWP6Ze8nQq3K8a
	IZaAUYOkn4a41WD4pduTl5KXXF+Sd2h20dfYakZ7eK0bV54eycacd3iG+eJU+bQX3gOf9tbOoSO
	c1wRYmQNrRRSy2YMBRvogP1vhJfexe+DXjEO/DQIkEr1wNTUK9q9w=
X-Google-Smtp-Source: AGHT+IFa/gh3+Fp0odQqkPcLPVFbb3qYZsshUGdgRE0/AtPjK60ClOXH6LeV96AFHVdSxao7UDWNdQ==
X-Received: by 2002:a05:6000:186c:b0:427:490:68d2 with SMTP id ffacd0b85a97d-429bd6887d2mr229192f8f.10.1761842622808;
        Thu, 30 Oct 2025 09:43:42 -0700 (PDT)
Received: from fedora (cpc92878-cmbg18-2-0-cust539.5-4.cable.virginm.net. [86.16.54.28])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-429952df62dsm36796839f8f.45.2025.10.30.09.43.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Oct 2025 09:43:42 -0700 (PDT)
From: "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
To: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Cc: Uladzislau Rezki <urezki@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Christoph Hellwig <hch@infradead.org>,
	"Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Subject: [RFC PATCH 1/4] mm/vmalloc: warn on invalid vmalloc gfp flags
Date: Thu, 30 Oct 2025 09:43:27 -0700
Message-ID: <20251030164330.44995-2-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251030164330.44995-1-vishal.moola@gmail.com>
References: <20251030164330.44995-1-vishal.moola@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There are some gfp flags that are not supported by vmalloc.
vmalloc has been trying to handle these by clearing and setting flags
wherever necessary. This is messy and makes the code harder to
understand, when we could simply check for these unsupported flags
immediately.

Define a helper mask and function telling callers they have passed in
invalid flags, and clear those unsupported vmalloc flags.

Suggested-by: Christoph Hellwig <hch@infradead.org>
Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
---
 mm/vmalloc.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 0832f944544c..b86c36d51833 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -3911,6 +3911,20 @@ static void *__vmalloc_area_node(struct vm_struct *area, gfp_t gfp_mask,
 	return NULL;
 }
 
+#define GFP_VMALLOC_BUG_MASK (__GFP_COMP|__GFP_RETRY_MAYFAIL|\
+			      ~__GFP_BITS_MASK)
+static gfp_t vmalloc_fix_flags(gfp_t flags)
+{
+	gfp_t invalid_mask = flags & GFP_VMALLOC_BUG_MASK;
+
+	flags &= ~GFP_VMALLOC_BUG_MASK;
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
@@ -3961,6 +3975,9 @@ void *__vmalloc_node_range_noprof(unsigned long size, unsigned long align,
 		return NULL;
 	}
 
+	if (unlikely(gfp_mask & GFP_VMALLOC_BUG_MASK))
+		gfp_mask = vmalloc_fix_flags(gfp_mask);
+
 	if (vmap_allow_huge && (vm_flags & VM_ALLOW_HUGE_VMAP)) {
 		/*
 		 * Try huge pages. Only try for PAGE_KERNEL allocations,
-- 
2.51.1


