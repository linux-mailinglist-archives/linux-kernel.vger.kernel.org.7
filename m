Return-Path: <linux-kernel+bounces-889717-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id AF616C3E4E5
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 04:08:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 940694E4BF1
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 03:07:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C76E125A630;
	Fri,  7 Nov 2025 03:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lDhAPZJr"
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FD412AF1B
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 03:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762484872; cv=none; b=jIH7WOtQe1ElUjbKmt9oxHAfJeBCLIkJPpGg9CfdFIclAN/2kr0rcyVDLC6tc6If09uwUt4OxHvM6sTI0SDcEg8rIhV/CyIwlgSLEFtKAehYJdfiedZHkCRAEPEuVEMDKgRs/rn5ipRMsBMql8/5L2/1nH259rLuYQao6VIXpzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762484872; c=relaxed/simple;
	bh=0lht7F0suzttGel6sZjkadZBWJ9xsrtfuoMFuni74uY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aLkb4WQAWDMDdMRhjCOwF3j/ynTGirGL2frJC7lXSfxnou26w2ZSYsZMRrBybzivqAAdSiq8A+PH4ZVUZAXCEB/dia5+vJfwaMWWjineIHd4s/cMn6Rb3qScHnjUxFJbLmvrQJ1RirUN0GAixV0xdNUCxZLxGgdJaSWc8kLbg1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lDhAPZJr; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-88056cab4eeso1834026d6.2
        for <linux-kernel@vger.kernel.org>; Thu, 06 Nov 2025 19:07:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762484869; x=1763089669; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mBCUg/9XCUiNk2sm5BPZW1kXc1XAzZmmErC9z5fdCQI=;
        b=lDhAPZJrMGjwb0Nblai+IsychJYbSvCezBkCD5YacG52wmOmSn3l+YCbrf0Lbm6hRJ
         nOgIuPiQ2fbvIDFDIiZyQeOVHx2EMRb52a2tzEQU2oRJBi/U7haSO8TISOsARIQM5nn7
         1gsqsw3kR3qHJv5XSVqV1xhHqNR0ce56rxH3csq2aSzLMzOUGUQRphmZcqFJgYqF65Sx
         lv2d1Ono7c8plvXbzeeS+kIeu49FJiFXQdhaUw8fJRY0CDbcEReEUshPdFUapBsenL6M
         jWohM5t//gWirpp9wPOUGnV3KLUNXS6aODBUm3aPlAie4PtCJSiFt+BNr7Ux/haSXEEM
         m2PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762484869; x=1763089669;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mBCUg/9XCUiNk2sm5BPZW1kXc1XAzZmmErC9z5fdCQI=;
        b=rwAPO4k6yNtFdHKhry45cUW17a2fVqaHCkXyg1r8/htga3sG1qsSjszWSwsw72VGY6
         HSoBpH+vmziY0mgEdZPht1sU5Ykg7ydJholZFr6uOiP3jdOObdJ/tGiLfZ3n4GUw6s6L
         EKW3GcdsRZo0yC32r7IKgCzMbj6DNmdFml9vqlymoJEuUmkyFHgCnF+rpBi58pEw8fRd
         VbFmJeYvhM8O1uBBTcdWxxFS9lx2rwuznfMD4+1ifiLB3EgZGBYCm6l0YgTlaJW6ASPI
         PvrhLqIF0h8ePzeOcaQFzVg6YEMu7uZtY6mRFOJcNSwZKunmHhl99SBMd06FDYNZwiFP
         M3Yg==
X-Forwarded-Encrypted: i=1; AJvYcCXoJAh8GP02PxGqZsLgQugcRDwQL+vzZxyGeQoWuZCo7qcusff4vnwIdQ/ii9LhXkEgchYT7zY1zkPppHQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxokWVSfdU72bGyzgy9kf53Hjv3asdG4U2gypu3zDNR4ZFkoAmI
	reRKEruCIbkwVWbrZIIl7SP3DeGJBYkkSvQkdLQMyEva7JKyJJuOmb+bfCzfYXuaQvB6vJa5yyx
	qH9r/6Cv693IxuivBk5gmp61BcUmZFHE=
X-Gm-Gg: ASbGncuBJSVrG496D4ujXAWerEESBjh4BVZJ83xFlN5txbKUe/BXJVUF8gNBtpbrWBb
	b2XY8Z/xTu9LZqvOviPbtefvSy1nij6e8SFiQ8Hmey1ruIpGJXudG3OWf6dCsu1XNnjQHa84NV1
	XquyH6FLjO81Lf6kjvWx/x5h/nJsk9tZv17czhBeVjUbQZShvAbgBctB0pI9m2ZIpGl1C4Mb8nY
	QKTMPzrRi0RY8u70B4Q2jEUOB8TwaZVO3m9JCpC1lJRv7Ye49HnLhTaHHMx3JWNvJzfn+LyK5hs
	vMMilK76ukTl+GLVYW1FgD1xWoQ=
X-Google-Smtp-Source: AGHT+IGAVK/as/fsnQC6Rzqp5n8giqY9RSCAVH0zLL61+rGwA+Bbr+alJLMG/WG+f+kye53EtjwheHwxoumU1v/Fn0M=
X-Received: by 2002:a05:6214:240b:b0:880:4c73:9e3b with SMTP id
 6a1803df08f44-88167b08793mr23624806d6.15.1762484869338; Thu, 06 Nov 2025
 19:07:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251029-swap-table-p2-v1-0-3d43f3b6ec32@tencent.com> <20251029-swap-table-p2-v1-13-3d43f3b6ec32@tencent.com>
In-Reply-To: <20251029-swap-table-p2-v1-13-3d43f3b6ec32@tencent.com>
From: Barry Song <21cnbao@gmail.com>
Date: Fri, 7 Nov 2025 11:07:38 +0800
X-Gm-Features: AWmQ_bl9OdAJp-MTk2PhcU5P1TAkG1rr8LH-PKPTp8sGVlXRVHPN5AzCsOi4VdA
Message-ID: <CAGsJ_4xquj2Kbc2qu0vtY6Q+-q3sg56BgKEdPs8eHtKxLBk0gQ@mail.gmail.com>
Subject: Re: [PATCH 13/19] mm, swap: remove workaround for unsynchronized swap
 map cache state
To: Kairui Song <ryncsn@gmail.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>, 
	Baoquan He <bhe@redhat.com>, Chris Li <chrisl@kernel.org>, Nhat Pham <nphamcs@gmail.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, Yosry Ahmed <yosry.ahmed@linux.dev>, 
	David Hildenbrand <david@redhat.com>, Youngjun Park <youngjun.park@lge.com>, 
	Hugh Dickins <hughd@google.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	"Huang, Ying" <ying.huang@linux.alibaba.com>, Kemeng Shi <shikemeng@huaweicloud.com>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	"Matthew Wilcox (Oracle)" <willy@infradead.org>, linux-kernel@vger.kernel.org, 
	Kairui Song <kasong@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

>  struct folio *swap_cache_alloc_folio(swp_entry_t entry, gfp_t gfp_mask,
>                                      struct mempolicy *mpol, pgoff_t ilx,
> -                                    bool *new_page_allocated,
> -                                    bool skip_if_exists)
> +                                    bool *new_page_allocated)
>  {
>         struct swap_info_struct *si =3D __swap_entry_to_info(entry);
>         struct folio *folio;
> @@ -548,8 +542,7 @@ struct folio *swap_cache_alloc_folio(swp_entry_t entr=
y, gfp_t gfp_mask,
>         if (!folio)
>                 return NULL;
>         /* Try add the new folio, returns existing folio or NULL on failu=
re. */
> -       result =3D __swap_cache_prepare_and_add(entry, folio, gfp_mask,
> -                                             false, skip_if_exists);
> +       result =3D __swap_cache_prepare_and_add(entry, folio, gfp_mask, f=
alse);
>         if (result =3D=3D folio)
>                 *new_page_allocated =3D true;
>         else
> @@ -578,7 +571,7 @@ struct folio *swapin_folio(swp_entry_t entry, struct =
folio *folio)
>         unsigned long nr_pages =3D folio_nr_pages(folio);
>
>         entry =3D swp_entry(swp_type(entry), round_down(offset, nr_pages)=
);
> -       swapcache =3D __swap_cache_prepare_and_add(entry, folio, 0, true,=
 false);
> +       swapcache =3D __swap_cache_prepare_and_add(entry, folio, 0, true)=
;
>         if (swapcache =3D=3D folio)
>                 swap_read_folio(folio, NULL);
>         return swapcache;

I wonder if we could also drop the "charged" =E2=80=94 it doesn=E2=80=99t s=
eem
difficult to move the charging step before
__swap_cache_prepare_and_add(), even for swap_cache_alloc_folio()?

Thanks
Barry

