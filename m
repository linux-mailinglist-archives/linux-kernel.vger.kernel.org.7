Return-Path: <linux-kernel+bounces-720845-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A1AEAFC119
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 05:00:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D1331AA57EF
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 03:00:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 268891E8328;
	Tue,  8 Jul 2025 03:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="UsudPzGE"
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D37CF9E8
	for <linux-kernel@vger.kernel.org>; Tue,  8 Jul 2025 03:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751943627; cv=none; b=ljMTH88akVlgA1HOUFAq4rZS7o6t2jjUbw6oteMZ/wm9p4/1T2VbQT1M8MiSjwKeyJKKPjzvad7QhzkDkgvr5yoh92mBknyp0Ioorf4XWoMdVVcADWU/+TsY3u6mThC78HnnYhMRsWXsJZ+FDqfNhANzsrKHBIG7pLquaJ+tQMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751943627; c=relaxed/simple;
	bh=WMhgcSeohrqilWlbvY9PZXYZsd0ZvU6eqOQQdw7z46Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HidV2iv1sIMWmiQ8T6zTPGlxFa7ChWiJsMmIQIX0sS7ZqWQp+L2XxgvSTZcG+jl7LVpzpVG0PbWHNovixPQTU4lbaiHeqrfkS/SItSGoVxGv87BZVRlewOwXotkeIdIA+YhRuA92Dx4JEcerXhPatH8+Au1psK7QlKV2graQP4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=UsudPzGE; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-311ef4fb43dso3085947a91.3
        for <linux-kernel@vger.kernel.org>; Mon, 07 Jul 2025 20:00:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1751943625; x=1752548425; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bMrKKC1vkb61pVbzzmeJOBgVccrTmC1tTEZe+RTgQIY=;
        b=UsudPzGEV9JgH/FxBaWxFPXHu0RDglfD79L+wa7zEUiXF4H9zF8Y2lhcEDkML6Ykx+
         TX/8DkT+/ikqLG28YNNMqgDZEbPEUo/3/fV718IiWLxnAdmGrAjaKpzNFwuzMgKoQso0
         HFXtIA6SHuj5kWSd2/f4/WGFctmCQGoVPDbAkWd4xALch0BmE8u7NaPvmXw2IsKnxCRf
         Elkh0So8GdrKjfX+Cid+INx/1nNhGzbIYDr7YxBLBDYQRcJalyzdCc7qLuguf/OXQwxR
         FZvS/UHqce2j/k8yAfFEZnkVqhTmLtTBzNoR76HGceAwrtMWMlfGfveNXqKmP8mqx/4Y
         lchQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751943625; x=1752548425;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bMrKKC1vkb61pVbzzmeJOBgVccrTmC1tTEZe+RTgQIY=;
        b=BQ51Ej3eg0nRQCkE4t7cxucPfwhbUy69IrP/3XYFIGMOe7Isx+vv7qs+wGJJmTeeXA
         5dsL0rE8vkSOhx52O1hwkCaPKAbhoJ5wvUSXs3n8JySjLNh/tpbAbZBKwFdipgjR2jdW
         o2bjLIB/wVaL33P5DYJs6tFrj/VwcyObK/oas/v7x8GHW3CBkk3Ee9UAvJjEQZDrtZ1L
         Ac60eoq5UO9E6hcM/jPWFUoi/64esr/5qDUBZltdA3YhwqqyLb+NP/eQjQyP5DgaWw/n
         MhPUU8scoxkVJ0Ccw3d5Bm8cwSExqVPOUxHCRVhGlJn5m3uGbMp3L921ZoZmaT8gUR90
         gOvw==
X-Forwarded-Encrypted: i=1; AJvYcCV4USLpznHxBfujhqeGZ+cA6bEjw/2FffJ3x00z9ueubvgnk2NjoMpFUeN6Mt1WFROs99Ea4CZnuoDl7yY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwjNVLuPYDa54epX4fd2RzeA8sw2PxoiZaOVlNYumKYXWH7ZPsA
	/B1/C48bz9zRT2vsp8JD6pfJshlfrYMgP3Bujl3Bg28XQkVyd7SxcBlInN3B8XAsXaM=
X-Gm-Gg: ASbGnctblXGL6DqibywPZ6fVp16AdoH+E/4Yx4CtP8q6yy/AMne7/MBwvulfktZgYwk
	HnBhEcMbiXU4fInScvqWCWsPEAsD7ybLL0a8irCafj1J82ATl2YsaZmWPzoweQMjVtgBqT8OCG9
	Fb0Dm+6cN/Hz89Okv9cOnZo+LrMIVdXqQo1owXrWiJUJzEYNvStNI7tPeHcDh0mWl24WM/91MdS
	XF1sW4/R9RH6Rajt6kgwzG+uc7mdY37a/ZTKmgtsBDOtvqohpMGBznNwZ5gxcPIv6K8iAo3E/HC
	cI+Np1IK5s8vsw8RkCHrgkVxhGhMZPbt9LeADpyj/j0VS39WkKcfzYt3ns8Tb8PDH4kS8Szl0BM
	PG0dLWiPabvu1VA==
X-Google-Smtp-Source: AGHT+IGONuKHAlHSkdF9dYjKJobYsaQXINAC8otRUB02iJ7r7RxJpmX1c4M/LkCrqml5u544gUG41g==
X-Received: by 2002:a17:90b:2ed0:b0:311:f30b:c21 with SMTP id 98e67ed59e1d1-31aadd9fd46mr17327109a91.26.1751943624853;
        Mon, 07 Jul 2025 20:00:24 -0700 (PDT)
Received: from localhost.localdomain ([203.208.189.10])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b38ee450fcbsm10029952a12.12.2025.07.07.20.00.21
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 07 Jul 2025 20:00:24 -0700 (PDT)
From: lizhe.67@bytedance.com
To: david@redhat.com
Cc: akpm@linux-foundation.org,
	alex.williamson@redhat.com,
	jgg@ziepe.ca,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	lizhe.67@bytedance.com,
	peterx@redhat.com
Subject: Re: [PATCH v3 2/5] vfio/type1: optimize vfio_pin_pages_remote()
Date: Tue,  8 Jul 2025 11:00:17 +0800
Message-ID: <20250708030017.46848-1-lizhe.67@bytedance.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <9d74e93d-5a5f-4ffa-91fa-eb2061080f94@redhat.com>
References: <9d74e93d-5a5f-4ffa-91fa-eb2061080f94@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 7 Jul 2025 09:29:30 +0200, david@redhat.com wrote:
 
> > @@ -680,32 +724,47 @@ static long vfio_pin_pages_remote(struct vfio_dma *dma, unsigned long vaddr,
> >   		 * and rsvd here, and therefore continues to use the batch.
> >   		 */
> >   		while (true) {
> > +			long nr_pages, acct_pages = 0;
> > +
> >   			if (pfn != *pfn_base + pinned ||
> >   			    rsvd != is_invalid_reserved_pfn(pfn))
> >   				goto out;
> >   
> > +			/*
> > +			 * Using GUP with the FOLL_LONGTERM in
> > +			 * vaddr_get_pfns() will not return invalid
> > +			 * or reserved pages.
> > +			 */
> > +			nr_pages = num_pages_contiguous(
> > +					&batch->pages[batch->offset],
> > +					batch->size);
> > +			if (!rsvd) {
> > +				acct_pages = nr_pages;
> > +				acct_pages -= vpfn_pages(dma, iova, nr_pages);
> > +			}
> > +
> >   			/*
> >   			 * Reserved pages aren't counted against the user,
> >   			 * externally pinned pages are already counted against
> >   			 * the user.
> >   			 */
> > -			if (!rsvd && !vfio_find_vpfn(dma, iova)) {
> > +			if (acct_pages) {
> >   				if (!dma->lock_cap &&
> > -				    mm->locked_vm + lock_acct + 1 > limit) {
> > +						mm->locked_vm + lock_acct + acct_pages > limit) {
> 
> Weird indentation change.
> 
> It should be
> 
> if (!dma->lock_cap &&
>      mm->locked_vm + lock_acct + acct_pages > limit) {
> 
>      ^ aligned here

Thank you! We need the following fixup code.

diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
index 03fce54e1372..6909275e46c2 100644
--- a/drivers/vfio/vfio_iommu_type1.c
+++ b/drivers/vfio/vfio_iommu_type1.c
@@ -750,7 +750,7 @@ static long vfio_pin_pages_remote(struct vfio_dma *dma, unsigned long vaddr,
 			 */
 			if (acct_pages) {
 				if (!dma->lock_cap &&
-						mm->locked_vm + lock_acct + acct_pages > limit) {
+				     mm->locked_vm + lock_acct + acct_pages > limit) {
 					pr_warn("%s: RLIMIT_MEMLOCK (%ld) exceeded\n",
 						__func__, limit << PAGE_SHIFT);
 					ret = -ENOMEM;


> Please don't drop acks/rbs already given in previous submissions.

Sorry for the inconvenience it may have caused.

> Acked-by: David Hildenbrand <david@redhat.com>

Thank you once again for your review.

Thanks,
Zhe

