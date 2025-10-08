Return-Path: <linux-kernel+bounces-844943-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A5A29BC31C6
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 03:37:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4CAAA4E31AA
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 01:37:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7637296BB8;
	Wed,  8 Oct 2025 01:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SxXUubGb"
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E3B329617D
	for <linux-kernel@vger.kernel.org>; Wed,  8 Oct 2025 01:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759887428; cv=none; b=PJQv1AaLOknGpNC65blZIxuHp65NPHIKgl5dhyVgt9zsFu8vY1NPgbbGPkPuASpSOP8FQMYQL/tOj3PszwEtGMxZCBTp1gkweqNNs5Gr3dFkQR4e1ya8Nf7R/HBbcs73MzDsyIRa7xyyeMZsJCMxN6CV7qDoz6IskokETVDRP/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759887428; c=relaxed/simple;
	bh=8QKl031r8nrFyfA+WWLFRj8+EAe2SLguM9/69lIdK4w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pnj89vpl+C39drArKjjvmW3Ze6i0bwWoShQ2LaoVjnsF1wQjKuPU4CpvgnV/S44nvfV//HSMfCoYJUAM6LeRufRdKP7EYVtUxu+HhOoMsmyOiA6Rk7gBJjpqLsd17erheCB3FnLqPpl+AwcsB/hH8QryhSaZxW0IrsNearb/RRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SxXUubGb; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-6395172532fso9689953a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 07 Oct 2025 18:37:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759887423; x=1760492223; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qTI9bX8kpTx6OwYWzqSJr3x9ShdcNTf18QQbs6hvqeM=;
        b=SxXUubGbgZ971eJlMxtQqQH5+iFh9Wa55qmm/pcc1v+1mgykDJmp6mLK7nSSFnS2YG
         LoR0U6G2UGwv/Sk4guqbJfD6MeaOm6f8fT499VEGBhPCVSx3QTaVRnDhkyXbzNa9jv2r
         2Xwn4dnG/Z1B/01/TLsqdozcqaoXv/pePylEAyCsk6ppUDMzcBYfO3yX31YJe/BKfNxB
         vMng638NzIxeWPedIGJk02ddXPE2OCoQ1I+Dl8zfmhuKzD1R57up3gQ6K/mkqp6WZb52
         l40jB3792OF+qETcWS9BlBGMJwHV+63xnk5rxobJPNcMH1MXNUutcucV2+T8+5vyNnF2
         u8MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759887423; x=1760492223;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qTI9bX8kpTx6OwYWzqSJr3x9ShdcNTf18QQbs6hvqeM=;
        b=kqsh+ittQUaTNHxZhIjgJccJ1pseRrGNjL/ntHLd+azkTcN8qsTWMtMpmWrjutMOPs
         UdolRguyk03CCKm70ShaRRSvO79gQAtpnnCv64QWX3FCAzYMy0vFuq+CSv4bnm/TTlnB
         nMlktXACFcHaVRt21IfYlFeSvwAqZmgY7DUh2BCqsBqx1YnhdfZ8tQTqetTmBTXxhfpX
         CKn82uF2cy/0ZepEAypnhUXqNQ5ibQMg+V9JUS+jNNjyqvTifYGZy38qrlLAUKFn31kt
         NVRrfh1Nvhp0SYrCE3A8r6fTo2AKGjfmOGrmse9qI7uFqxouPHF6mFChZa0cTdlEl0L4
         5BGw==
X-Forwarded-Encrypted: i=1; AJvYcCUPmjtR1ILXIF/2Cpw/14zPsCZmYZmbU6qRAn71FBtz70N6IceMiREt4fo7Fggwg3weqk+Kv+Sa32OYgI8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZrsiw/fnasqvhHwhiuItQP+RcbzBSXYWiuJ+Sxfxs7qjV0UlH
	tMLWE4z0tLfTrBIVQ/LZiMddbZxJ3BuvftExdJfCeU0r7ZNbfzcuDxnE
X-Gm-Gg: ASbGncvy/RTZJgDo6rhisbM/okpEaYhxrPrnkZ1lorzgLgrtIImaPHpEVTM6+RwKtz7
	FeTc4V0TY4GddD6moOwTpg+R0vSCuO48FXcl00AGA9TVzVXOJKsYBm+9+5n4QHiu0VSN7cYrqtT
	z9OjQz1oUmRnLVsCwsUUuUUS3174EQPd2O/kXrsLB2SnBR6lbg11kj3J6UTy502lTyqZu8lwzq1
	DMP6Deg2W10+PbB5eYUKOScVzECkni1fF4LBcSbBlqG1uutcb/CyjXKtQFZPl0F1xAoDTi6X1Pn
	5l5xO5km0jksnVyyMfQBjuD44juf62oC9vCoQOxwUu8VsVf9I5cmL0I0tUhf7502aDhZRDzX1Ia
	Kq0DFbqaaFxba7DfWFUDDvWGyfy/Xt9Ykt6hkgyd90YlYE3TjNg==
X-Google-Smtp-Source: AGHT+IHR71uTMt98eJmNaVJuPkc7yPWPra6MlvxsH6EwmRI4ppOh3ZZt/mIIYFoE0vXfD0Nc/DDTHA==
X-Received: by 2002:a17:907:c27:b0:b3e:256:8332 with SMTP id a640c23a62f3a-b50ac6d378amr191888766b.54.1759887423087;
        Tue, 07 Oct 2025 18:37:03 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b486a174a6dsm1527786466b.90.2025.10.07.18.37.02
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 07 Oct 2025 18:37:02 -0700 (PDT)
Date: Wed, 8 Oct 2025 01:37:02 +0000
From: Wei Yang <richard.weiyang@gmail.com>
To: Lance Yang <lance.yang@linux.dev>
Cc: David Hildenbrand <david@redhat.com>,
	Wei Yang <richard.weiyang@gmail.com>, akpm@linux-foundation.org,
	lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com,
	baohua@kernel.org, baolin.wang@linux.alibaba.com, dev.jain@arm.com,
	hughd@google.com, ioworker0@gmail.com, kirill@shutemov.name,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	mpenttil@redhat.com, npache@redhat.com, ryan.roberts@arm.com,
	ziy@nvidia.com
Subject: Re: [PATCH mm-new v2 1/1] mm/khugepaged: abort collapse scan on
 non-swap entries
Message-ID: <20251008013702.6cjaufazal6zpvga@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20251001032251.85888-1-lance.yang@linux.dev>
 <20251001085425.5iq2mgfom6sqkbbx@master>
 <1d09acbf-ccc9-4f06-9392-669c98e34661@linux.dev>
 <20251005010511.ysek2nqojebqngf3@master>
 <31c3f774-edb7-420a-a6a8-3e21f2abd776@linux.dev>
 <09eaca7b-9988-41c7-8d6e-4802055b3f1e@redhat.com>
 <29742109-13c2-4fa6-a3a1-d12b14641404@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <29742109-13c2-4fa6-a3a1-d12b14641404@linux.dev>
User-Agent: NeoMutt/20170113 (1.7.2)

On Tue, Oct 07, 2025 at 06:25:13PM +0800, Lance Yang wrote:
>
>
>On 2025/10/6 22:18, David Hildenbrand wrote:
>> On 05.10.25 04:12, Lance Yang wrote:
[...]
>> 
>> I was looking into some possible races with uffd-wp being set before we
>> enter do_swap_page(), but I think it might be okay (although very
>> confusing).
>
>How about the version below?
>
>```
>Currently, special non-swap entries (like PTE markers) are not caught
>early in hpage_collapse_scan_pmd(), leading to failures deep in the
>swap-in logic.
>
>A function that is called __collapse_huge_page_swapin() and documented
>to "Bring missing pages in from swap" will handle other types as well.
>
>As analyzed by David[1], we could have ended up with the following
>entry types right before do_swap_page():
>
>  (1) Migration entries. We would have waited.
>      -> Maybe worth it to wait, maybe not. We suspect we don't stumble
>         into that frequently such that we don't care. We could always
>         unlock this separately later.
>
>  (2) Device-exclusive entries. We would have converted to non-exclusive.
>      -> See make_device_exclusive(), we cannot tolerate PMD entries and
>         have to split them through FOLL_SPLIT_PMD. As popped up during
>         a recent discussion, collapsing here is actually
>         counter-productive, because the next conversion will PTE-map
>         it again.
>      -> Ok to not collapse.
>
>  (3) Device-private entries. We would have migrated to RAM.
>      -> Device-private still does not support THPs, so collapsing right
>         now just means that the next device access would split the
>         folio again.
>      -> Ok to not collapse.
>
>  (4) HWPoison entries
>      -> Cannot collapse
>
>  (5) Markers
>      -> Cannot collapse
>
>First, this patch adds an early check for these non-swap entries. If
>any one is found, the scan is aborted immediately with the
>SCAN_PTE_NON_PRESENT result, as Lorenzo suggested[2], avoiding wasted
>work.
>
>Second, as Wei pointed out[3], we may have a chance to get a non-swap
>entry, since we will drop and re-acquire the mmap lock before
>__collapse_huge_page_swapin(). To handle this, we also add a
>non_swap_entry() check there.
>
>Note that we can unlock later what we really need, and not account it
>towards max_swap_ptes.
>
>[1] https://lore.kernel.org/linux-mm/09eaca7b-9988-41c7-8d6e-4802055b3f1e@redhat.com
>[2] https://lore.kernel.org/linux-mm/7df49fe7-c6b7-426a-8680-dcd55219c8bd@lucifer.local
>[3] https://lore.kernel.org/linux-mm/20251005010511.ysek2nqojebqngf3@master
>```
>
>I also think it makes sense to fold the change that adds the
>non_swap_entry() check in __collapse_huge_page_swapin() into
>this patch, rather than creating a new patch just for that :)
>

Agree.

>Hmmm... one thing I'm not sure about: regarding the uffd-wp
>race you mentioned, is the pte_swp_uffd_wp() check needed
>after non_swap_entry()? It seems like it might not be ...
>
>```
>diff --git a/mm/khugepaged.c b/mm/khugepaged.c
>index f4f57ba69d72..bec3e268dc76 100644
>--- a/mm/khugepaged.c
>+++ b/mm/khugepaged.c
>@@ -1020,6 +1020,11 @@ static int __collapse_huge_page_swapin(struct
>mm_struct *mm,
> 		if (!is_swap_pte(vmf.orig_pte))
> 			continue;
>
>+		if (non_swap_entry(pte_to_swp_entry(vmf.orig_pte))) {
>+			result = SCAN_PTE_NON_PRESENT;
>+			goto out;
>+		}
>+
> 		vmf.pte = pte;
> 		vmf.ptl = ptl;
> 		ret = do_swap_page(&vmf);
>```
>
>@David does that sound good to you?

-- 
Wei Yang
Help you, Help me

