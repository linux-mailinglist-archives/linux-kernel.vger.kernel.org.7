Return-Path: <linux-kernel+bounces-839427-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 926AEBB1980
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 21:28:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 570944A3F20
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 19:28:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26D15305040;
	Wed,  1 Oct 2025 19:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YOGDEZSR"
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F32E303A02
	for <linux-kernel@vger.kernel.org>; Wed,  1 Oct 2025 19:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759346820; cv=none; b=GPcW6b1CN0WXWvpF+OgL+JTTTxy6eNto/qpnsuLncFuLOVFl4IKXU5xVYJCCH6XZtrcWHlJ5Mv01/b7QV/j8Uqc2eaSHG/+TdXoISqOzV4BH6EG2mFcojJ0sdm5DwQ12d9tXaY90d1l03y/wjoWCgdpXbETnP4fDMffh3m/0EmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759346820; c=relaxed/simple;
	bh=Q9aVOYkAKq2gHcgevzm/IrzdwFh0JNa81Fz6ubWQC+8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HiMFKEIEkBvFEYlxGhykuXXyRXlMaHIQ0Jo0AUfU4xuqM3hepu+C3zcl8tLgaPamvtf1rBTYEelytrwP1Qm8YbaVILPsXkVKmIEJ+5PsJz/tpvFiP9YnVIgt0HkSV3y3oCZZjwiLwKBlOErvoUAioOzzrSlpbtSQGyd4OC2hs3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YOGDEZSR; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-57a604fecb4so262372e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 01 Oct 2025 12:26:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759346817; x=1759951617; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IbYRlCl/Dzj0Jt1PXEP3jL/F9CvbCkzzyw4wzC1Iq2o=;
        b=YOGDEZSRQjqh5pU15EFAjzCDhP/V+pcdk4KtwSl2SfYnLqCY9EC7hMUBkWrE5BBBV3
         8wMfujXitOzknSt0jJZWbLATlIAws29crFmyeipAadvSK8LujfbTd4v2aoGvZZwcRREt
         Tkjob7QyGUVFs12RlGhIjtSBMILjiIbpS7AqQGrMaxx/6nnk+frY2emoXOosChq2xwMQ
         3ZlrKQqNg08dWOKf6Lkbspi7n7mq8dDEHpizy5raf05mvMJcAq9tDa1w05CDJ6e0cg5J
         TcSc9WE0iRJVPK3G7EBkp4Ge+JIL2zcwpb4lGkis+myTWlmUYBbczgnagI3fniHK8DzQ
         utpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759346817; x=1759951617;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IbYRlCl/Dzj0Jt1PXEP3jL/F9CvbCkzzyw4wzC1Iq2o=;
        b=rdnklM6Iocj5UXK+5Y724Hn6bIpTdvXHoMFoRedj4v9o4iV5lWcpDUfKlXJb+3pe8p
         rHA21NIWEsUtsvJ3bmJVSOvie6elBZWnM2GsnHNDDcqBjA+vIjHGRuQk2afCHDo83RCb
         4vNGkviVpSwLBaD90dpdj75FJK97qwlr/6AEZLhI8jrXcZ5lo1kCVGpHExum5qHGzhH6
         4RaMvS7BcHshXatklhqaMLTIFi3Bag4KdinAgGalHMNi49iikrpqM1kHf+HXYhfGcc8F
         MEyQBexUGs3V1ERDIt4iRC3MCvoTM7ah1MSAGTW0YdFS8Sd7t5/UIUQjJ9Ups/le8e3M
         JL+w==
X-Forwarded-Encrypted: i=1; AJvYcCWvYtB5sGah5FdHVglgHO8I0YmO02nvoBdSTz+VJxV/x3hGY7Gizo0hWvut96z8lJrLqs+sNYThrKvqr84=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/yf+Z7s6PKabs0wnjjoc30klrGsCjAEFHdmxB0yMBvBx/QbdG
	As6qwf4VXNYXPA18yrg1d9iHDqx1pIQB4Mfdp3LTaU7auTAKFjIywgwc
X-Gm-Gg: ASbGncvjFA11oFJYgl5nkTxn3H9WPNshoscSgaHPq43lSpfuRdEvqNta5tzU9k4ttKA
	CkFarnpxpXzzQNs8VfPtuaY8paiH+OlgsJ6GbT9hYhBI60sUia34xq6dDpqV9z7/od2OtzvPrZt
	cblQObo4JAjHs5RjgOwz5xHRxj3lN8Cy4kWfoV6rmjsutpFwWrFDVI5wwRqCEsqclKBLISbQq85
	levlC6RHvQkcRe6Hhuzf+YzM1McTZIxwfgFAvoOHXlL9+AUiomjAABnY5ifMs9N6mxxf1Ii3bdO
	M1mwupnFEE2HhXd6i9M81JXU9L3Q1uj9xBswCDkfZ8RQuPU3naRpLo66B2sTGpFp8YY/zSwVkGF
	bIi5V/kkagbRVDqWuydxc9E3wiDe3YcIAWlvF+GAK
X-Google-Smtp-Source: AGHT+IF9llFN2LXsjgVGkXyRw7BDqyfzeD80j0uo5mXamBd03EZQeOTEdSwaixEgJc8AVhTRjW6k2Q==
X-Received: by 2002:a05:6512:3d01:b0:579:e5da:e530 with SMTP id 2adb3069b0e04-58af9efd33amr1535887e87.10.1759346816620;
        Wed, 01 Oct 2025 12:26:56 -0700 (PDT)
Received: from localhost.localdomain ([2001:9b1:d5a0:a500::24b])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-58b0112414fsm136627e87.28.2025.10.01.12.26.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Oct 2025 12:26:56 -0700 (PDT)
From: "Uladzislau Rezki (Sony)" <urezki@gmail.com>
To: linux-mm@kvack.org,
	Andrew Morton <akpm@linux-foundation.org>
Cc: Michal Hocko <mhocko@kernel.org>,
	Baoquan He <bhe@redhat.com>,
	LKML <linux-kernel@vger.kernel.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Michal Hocko <mhocko@suse.com>
Subject: [PATCH v3 09/10] mm/vmalloc: Update __vmalloc_node_range() documentation
Date: Wed,  1 Oct 2025 21:26:45 +0200
Message-ID: <20251001192647.195204-10-urezki@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251001192647.195204-1-urezki@gmail.com>
References: <20251001192647.195204-1-urezki@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

__vmalloc() function now supports non-blocking flags such as
GFP_ATOMIC and GFP_NOWAIT. Update the documentation accordingly.

Acked-by: Michal Hocko <mhocko@suse.com>
Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
---
 mm/vmalloc.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index d7e7049e01f8..2b45cd4ce119 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -3881,19 +3881,20 @@ static void *__vmalloc_area_node(struct vm_struct *area, gfp_t gfp_mask,
  * @caller:		  caller's return address
  *
  * Allocate enough pages to cover @size from the page level
- * allocator with @gfp_mask flags. Please note that the full set of gfp
- * flags are not supported. GFP_KERNEL, GFP_NOFS and GFP_NOIO are all
- * supported.
- * Zone modifiers are not supported. From the reclaim modifiers
- * __GFP_DIRECT_RECLAIM is required (aka GFP_NOWAIT is not supported)
- * and only __GFP_NOFAIL is supported (i.e. __GFP_NORETRY and
- * __GFP_RETRY_MAYFAIL are not supported).
+ * allocator with @gfp_mask flags and map them into contiguous
+ * virtual range with protection @prot.
  *
- * __GFP_NOWARN can be used to suppress failures messages.
+ * Supported GFP classes: %GFP_KERNEL, %GFP_ATOMIC, %GFP_NOWAIT,
+ * %GFP_NOFS and %GFP_NOIO. Zone modifiers are not supported.
+ * Please note %GFP_ATOMIC and %GFP_NOWAIT are supported only
+ * by __vmalloc().
+
+ * Retry modifiers: only %__GFP_NOFAIL is supported; %__GFP_NORETRY
+ * and %__GFP_RETRY_MAYFAIL are not supported.
  *
- * Map them into contiguous kernel virtual space, using a pagetable
- * protection of @prot.
+ * %__GFP_NOWARN can be used to suppress failure messages.
  *
+ * Can not be called from interrupt nor NMI contexts.
  * Return: the address of the area or %NULL on failure
  */
 void *__vmalloc_node_range_noprof(unsigned long size, unsigned long align,
-- 
2.47.3


