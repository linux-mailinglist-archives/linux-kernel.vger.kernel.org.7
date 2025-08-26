Return-Path: <linux-kernel+bounces-787286-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BF90B37417
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 22:56:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 39E716885B7
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 20:56:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5E9728D850;
	Tue, 26 Aug 2025 20:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XRgdwATw"
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2BDE2253FE
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 20:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756241791; cv=none; b=nuAvOxavehHpl/l1e4NWvviSRqirmykOt9r0XLR/hI1MKSZsy4QiOLUSsGYQat485cL0idqoWn+N6OIeSio7vX3iBwii89zQjNstRsbyuXPa8PZo1YL4KeVkOMr/EBPrxRO0AztneALscQKLV8QMcP0/lLN+cGspA3cjuUaUBlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756241791; c=relaxed/simple;
	bh=nI8xu3KIEajYGlBiYCqw1m4Zcn63CxE5+8UzDzA5g2o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hhdoA7Wfn+WZwRo0UN+VuMlFMKX/mDFwguMuFmxCHQKa4at2jfkGR3ZTivMEau7q1uwKlmkx6nJ8DDZSaYT4igmNgqNyrwlTMuui+i4RsPeGBJ6U08ouan/Y6CuiLgVhE3GixZF3djcb+RDkLWROpoweOR53uW8xQnfZTl8QF+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XRgdwATw; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-770530175b2so2514285b3a.3
        for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 13:56:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756241789; x=1756846589; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=13eUYaWgF2/Nh4T0vIZSvkzZBvGNF1e6n77XFGF+zTg=;
        b=XRgdwATwXckwJZs/vV+OmToIdvp4h4YfWGKho2MZPKa5lpdlgBFiSZ/Jn8QPFP779j
         ZfSg8f2JRWk/lrB1VcJlOKbYTtLIuG/OAm3YksH9o2dSO8lmPQZ/pviRv5zYgQct9SuI
         tJ52OI4DdNHbeC0g1DwXrDtJYCnjSmbYUkoUcGdZfiKYGiqY4teEsR8ozHKt/8Ltt7gh
         mCdP42oWsIRN2i7Wc212IqYCemBywUYuUN4ScfmVDNQWN48rRQ26AG8PCNLSSdHkLmWr
         nmVivUB8ZV1GwbwKzl0hO9x5HazpCk9+lWdOtmG1OYyR4QqBhcSNcN7/h7WDVbBaNlQ/
         ECiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756241789; x=1756846589;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=13eUYaWgF2/Nh4T0vIZSvkzZBvGNF1e6n77XFGF+zTg=;
        b=rEvJOJH1x4SIjz/tofVD2fFHsPuKx6/fV5cI21t7enEH4351K/dudxAwK2U1beriRs
         7UvGWv0dm6Jj6Po01bpvBDadZML5TuEOblZOUUBFTieL7vrvU6SG0sAkWLtbPPsncvWe
         /D2BLyn/dkNU14xhO1mw6m1dm0u47iaelfcjFFszuXuKUYc8yDq6lfFPt8XSTNTrG4Ax
         dNOAsh7PBmnXBJzDz2aNG8abMdu7nL+ZwBV6q4lN/kt2XieIR0EUpbgkj2QLtJLLYZb2
         epq88gc8f+BZl+A7pzY9gVbqJAEMr9L77S3Sf8rYxv+RyoqTkdRCYIIvI6D2qzcKOjYl
         7G+w==
X-Gm-Message-State: AOJu0YwqYZ+zzOwRvNPoKJjSyYhKqj97JBNzac6Tn7Lo8HwyZvO01sE6
	8auXVVB5swMrg9hH0bMOtekf2PbEcKv9oVw9sMqA/KlDZUbuWcscb0+m
X-Gm-Gg: ASbGncsoufivxcA7IBoTyxYFOyW6ou52P1Ov5+4VTPlYjmBT4GYaEfTgVHQlDfpMofR
	PUR8xjOL2rUyJ4lPz5sQCX50eiEYBcBGm9pew479aSPbqb3VJgA2OQQlrELCa97xD/37Z9GPRRV
	EQe3IxwaXmUjbfx+muKb4QV14C4Rfvzuf9b0qdkrdAFIZoElHBakRHDHGwevKIDaOfUMfDS03+i
	/mE83shfyu4Usqum7ltwrTkXTM7ie0rA0pBHkrvgqiwDZ2SjHpH3ThgVmipDlezNResKdzjKwp3
	RammF2GWOfQkJUi3o+9Fz7UHytIAhRC9mOI63VYbru8KBoGLXkXxMFBmnombhllWksq0YyczLIG
	x6alywMcrjmfplReumh8Fjz+5GRUHII4iegHvRrNbg//lTa8oz5Zd0A==
X-Google-Smtp-Source: AGHT+IFhlIB5+rmQM4mUW5f08KcYHWotYT+bmRUhVcM2aNuDqBXEScj2FBR386dOVdHUaSBcALsk5g==
X-Received: by 2002:a05:6a00:13aa:b0:771:edda:1b9c with SMTP id d2e1a72fcca58-771edda1de7mr8650847b3a.14.1756241789054;
        Tue, 26 Aug 2025 13:56:29 -0700 (PDT)
Received: from fedora (c-67-164-59-41.hsd1.ca.comcast.net. [67.164.59.41])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-771e814cbccsm5817935b3a.35.2025.08.26.13.56.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Aug 2025 13:56:28 -0700 (PDT)
From: "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
To: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	"Vishal Moola (Oracle)" <vishal.moola@gmail.com>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH v2 1/7] mm/page_alloc: Add kernel-docs for free_pages()
Date: Tue, 26 Aug 2025 13:56:11 -0700
Message-ID: <20250826205617.1032945-2-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250826205617.1032945-1-vishal.moola@gmail.com>
References: <20250826205617.1032945-1-vishal.moola@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add kernel-docs to free_pages(). This will help callers understand when
to use it instead of __free_pages().

Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 mm/page_alloc.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index baead29b3e67..f5ab7d5bcbd7 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -5270,6 +5270,15 @@ void free_pages_nolock(struct page *page, unsigned int order)
 	___free_pages(page, order, FPI_TRYLOCK);
 }
 
+/**
+ * free_pages - Free pages allocated with __get_free_pages().
+ * @addr: The virtual address tied to a page returned from __get_free_pages().
+ * @order: The order of the allocation.
+ *
+ * This function behaves the same as __free_pages(). Use this function
+ * to free pages when you only have a valid virtual address. If you have
+ * the page, call __free_pages() instead.
+ */
 void free_pages(unsigned long addr, unsigned int order)
 {
 	if (addr != 0) {
-- 
2.51.0


