Return-Path: <linux-kernel+bounces-854957-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1486BDFD69
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 19:26:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 79D8E486C52
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 17:26:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F5E4338F21;
	Wed, 15 Oct 2025 17:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="PIR457Mw"
Received: from mail-vs1-f100.google.com (mail-vs1-f100.google.com [209.85.217.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D32452D5957
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 17:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760549161; cv=none; b=R6TJ4WqtU7qlxPxlth2KUg5bKVLGxtwNB+eqxP3jpVu6LR48DP9krfqle/ll+lDmhT2aGQ7DDt0IVOcGhinIcNooU6cD+SultI500mX0xwQS0ZJcKu7n2t1csSLPiye0azezrZjVQQfBIHMZNWjc1aQ+CGm5KJIA9upVekr9qxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760549161; c=relaxed/simple;
	bh=JB5oFzqmNqnAnPByzKv3TD4SI4/gUXMe6Yt/XtVTZxo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EZIoubtdtIdwM81WJsFDrn3xEj8zwsYrZwavqDIJLjAHM450v72uO/o6MRzvzeeh+eRc3AWJ1s9tR95CR9bV+RCJgH2NwJXL0XFxFV1Jmvlo8cXgOeRxdSRTnoupTfAw87ThnhhclGO+KY0gAPIWYjCBDeuBGTVwnO1cVh2A/G8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=PIR457Mw; arc=none smtp.client-ip=209.85.217.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-vs1-f100.google.com with SMTP id ada2fe7eead31-57f496e96d6so451287137.0
        for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 10:25:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1760549159; x=1761153959; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8a0FBTWbRkzlovsTrElybeARL/kMTLRwEd+6K2uwZkE=;
        b=PIR457MwBUzF9YGnn9XoWgp1FewRVHpdJFvQpOPbAOXOWIS5J8cyBezuLCfUc05kUN
         0+BLS1xVgnkOrQAOqHRgZqjDW+5HzYNBcnk8aIkXrbcPesw/YBFp8vn0oat8DZiQuM8C
         6knu0QmINxALoyiB5tCgQVCR4Zh+OLNdVM8vIsTo05sd0ZpJQOiVlE/arGsY0nCTHE7c
         lg14OmuKDSQDEl0unTWOvMDLWhJgKuoJedejpLTQKD9AskcEiKGSTfjBi8cyf6dveRem
         K3/oS0CgqKAE4X/BzozaDh4duoafrTcV5Rhuo49w5X4TgxkwtWYbIz73FKu4PFkDJbwT
         sMKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760549159; x=1761153959;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8a0FBTWbRkzlovsTrElybeARL/kMTLRwEd+6K2uwZkE=;
        b=S4k8k5F8kOqGHzOvv5aPZXTFopu9I73Knxk0rlqSx6Wu57x7+MrPBWN5ncLHgmZG5/
         6H1fH5UvmrTQBSmXf+fi4STZ6QSL8sAdOptdQ5v8e4DZLlO/t5/wn3RPk/Evzwiq+uxp
         VJKoiiYZqasrhRw9C7Fv0hSe8l5aVdyknHdvWz3vw5wHGHi6lFDFU84pRlq8g2FXwnqR
         09Vs+FAd9fnUBM+pKajj0TGtda60xqQ/VXpy6fXAvSP9siMVNwOeSGH4xLvamnA/n2Bm
         JD2auWYFrUrcfZyWPL1wq9cmZNjpZry/I6Ze8n8p3kgp/Q+WtODbVpKwsjaKGY0rS1Gt
         1BnA==
X-Forwarded-Encrypted: i=1; AJvYcCVS+3BfahA5SaYR+gk2n0sKhbSP1idcNTuWtbrZXpIeokwYiHb9izPRvKZymMVTILhRChLX11h4By/nkJ4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwW8nHrcdNSuDKq1xZvuQ6XTEX3bqpMqNPYW4XXRncFywe1+/t/
	gFpN6J2lvrXgngUDEETXCpzUgGmZoN3fjdvOsBBVE+lO3slhf+BmmVFiaqQijCPei39SL2E/Qk9
	sDBEVH6F1MzOOQZsEPZjDy/HMoamMLQbyDCnH
X-Gm-Gg: ASbGncsWSkQOtUOPNyHzMouESgCSgDXJMuxMlHWlMbtIaPjQ4d9BjbggxPEajuocgCS
	vVj8ZTmVKm2QoErV0schPgk1obyHoqG+dRQ97uCiYviYMVZiFRg9DcvQhxmNPJuzPGGLYzcCqia
	mnNFPBen3Nx5nWmgmGeby4PTaVkvqs7QrA32OgejfLhcAM0ObKNghddeDW/x//1pITu1srVQYSU
	uGuGkl4+Ho+Gsy3kTE3UrZloT4M7Og0cAxYurVAiCOoXNL6BH6t3fg3QbvFFlKdf1Q0f8JPtpLW
	xi7I16gLxv9enA2Rt++SVs72pzos92cUbyrUWnyPaMBw0HKgxSq4HE+E7nmTtnu2TjRUnpO0
X-Google-Smtp-Source: AGHT+IEyCGl9AhptKS4IDg6E1CU4cRmqkZiT6EIc5uRSVlidSgZPLElf0iGy34FDQOT0X6ZobQurYjmqAj3u
X-Received: by 2002:a05:6102:3581:b0:55d:b35e:7a67 with SMTP id ada2fe7eead31-5d5e21f14famr5081188137.2.1760549158620;
        Wed, 15 Oct 2025 10:25:58 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([208.88.159.128])
        by smtp-relay.gmail.com with ESMTPS id ada2fe7eead31-5d5fc4d87cfsm2010256137.0.2025.10.15.10.25.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 10:25:58 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.7.70.37])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id E7560340576;
	Wed, 15 Oct 2025 11:25:57 -0600 (MDT)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id E03A3E41EAD; Wed, 15 Oct 2025 11:25:57 -0600 (MDT)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: Caleb Sander Mateos <csander@purestorage.com>,
	io-uring@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] io_uring/memmap: return bool from io_mem_alloc_compound()
Date: Wed, 15 Oct 2025 11:25:54 -0600
Message-ID: <20251015172555.2797238-1-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

io_mem_alloc_compound() returns either ERR_PTR(-ENOMEM) or a virtual
address for the allocated memory, but its caller just checks whether the
result is an error. Return a bool success value instead.

Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
---
 io_uring/memmap.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/io_uring/memmap.c b/io_uring/memmap.c
index 2e99dffddfc5..b53733a54074 100644
--- a/io_uring/memmap.c
+++ b/io_uring/memmap.c
@@ -13,30 +13,30 @@
 #include "memmap.h"
 #include "kbuf.h"
 #include "rsrc.h"
 #include "zcrx.h"
 
-static void *io_mem_alloc_compound(struct page **pages, int nr_pages,
-				   size_t size, gfp_t gfp)
+static bool io_mem_alloc_compound(struct page **pages, int nr_pages,
+				  size_t size, gfp_t gfp)
 {
 	struct page *page;
 	int i, order;
 
 	order = get_order(size);
 	if (order > MAX_PAGE_ORDER)
-		return ERR_PTR(-ENOMEM);
+		return false;
 	else if (order)
 		gfp |= __GFP_COMP;
 
 	page = alloc_pages(gfp, order);
 	if (!page)
-		return ERR_PTR(-ENOMEM);
+		return false;
 
 	for (i = 0; i < nr_pages; i++)
 		pages[i] = page + i;
 
-	return page_address(page);
+	return true;
 }
 
 struct page **io_pin_pages(unsigned long uaddr, unsigned long len, int *npages)
 {
 	unsigned long start, end, nr_pages;
@@ -157,18 +157,16 @@ static int io_region_allocate_pages(struct io_ring_ctx *ctx,
 {
 	gfp_t gfp = GFP_KERNEL_ACCOUNT | __GFP_ZERO | __GFP_NOWARN;
 	size_t size = (size_t) mr->nr_pages << PAGE_SHIFT;
 	unsigned long nr_allocated;
 	struct page **pages;
-	void *p;
 
 	pages = kvmalloc_array(mr->nr_pages, sizeof(*pages), gfp);
 	if (!pages)
 		return -ENOMEM;
 
-	p = io_mem_alloc_compound(pages, mr->nr_pages, size, gfp);
-	if (!IS_ERR(p)) {
+	if (io_mem_alloc_compound(pages, mr->nr_pages, size, gfp)) {
 		mr->flags |= IO_REGION_F_SINGLE_REF;
 		goto done;
 	}
 
 	nr_allocated = alloc_pages_bulk_node(gfp, NUMA_NO_NODE,
-- 
2.45.2


