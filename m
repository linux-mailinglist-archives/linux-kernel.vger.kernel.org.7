Return-Path: <linux-kernel+bounces-877505-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FF19C1E506
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 05:00:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A3A753BC4E9
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 04:00:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 156ED2DA779;
	Thu, 30 Oct 2025 04:00:42 +0000 (UTC)
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AA451A23A4
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 04:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761796841; cv=none; b=tQ4bNX4BFcGH+MqW7se/Nz17Sn7FViAs271TGrcNp8LtQbi/I5806FOdQm2pxBkZ5xw3fzqIkF/LKoSwSXbRHy84U7y6dTpxM835KGNLBpv+Iedymf6FXsmZdMWzSp/dcGNK+K7uCn83RVXDpZ8tgsbTtvR1f33vUDdwcbXkfKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761796841; c=relaxed/simple;
	bh=OPqga+jPvzjiv0t7E/GuszX8kP8cT705M59xu+M/iJU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W4cznysVHVvo6+fYtI4f9cVKBiUhCa5fWsE+7C3wQAOevzDj8qJVtB7wNn2TOHPZHRghQGVltfGmq479uwyebUYNcDyH3Tk0CndLyB0J5InHiY6l6qm1mvfwq+MkomqnieW0F5GvfkgDjBV4u6X7Nrwd7OTxmTFUbqgzncaEsMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-8a84ba42abbso66422385a.3
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 21:00:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761796839; x=1762401639;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V7UkojjVw8iM7ylju2DINYd3+c72O+36Bo2eWT6QfKQ=;
        b=oHzCvP7V0mrwWLLJj2TZ09DDJG+z0DWqY+k2E1Mqq4pV9M2hyw+fwElhVg9wN83gYd
         fmg7lcKZe/x3ibK/T2dC4eH4Z+NUGpHi0D+6Ao9NRJ+Wp5S6uZV/CbRAEjpZqd2rpUMP
         lG+epWGdGAIlNq/iz36aoM3D3kZbbTZdmBEU3VZG/ZMWr7ugFvwe/pGBgxJem0deC5yN
         piLmEVYbWdG+MH0McJU/frkn5obRFkfTeY1LsrHXvGCXROwiCD7ToQ3a5PEW3kfWhvPU
         PB3G82rOm4edBZzJN4ppQwyVO+RX37pEe5L9jgP2WzGP0ix+8mdNbGF/YHgebr8UZ4Fw
         O6Lw==
X-Forwarded-Encrypted: i=1; AJvYcCW6k/mqJf65XJOsi6MaMu2R1BE1Lk4IMtPPItWpTu41Eg9hZJyMaGqNtqHsmhPOcwrikG6AEEOCgr5suFo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzgb8z79Ea5RV69TX7jwv+TjaZj1Z42qQRTJhYMqf/MTGZYwXcm
	/3DE/mi9iBh5tVnrIukwgVTNJx4LrfL05JC1E3lUf4yIAQOkPObZUG1JczT3QSVGx97a87N/zLn
	CldXK6dYhwwFH0sSfimsOjb1KRg3H2Ng=
X-Gm-Gg: ASbGnct9/X6au2kVjG1A+0TgT5ML0QKDWr+3wLFHXPhXqZNnJuLNhDI4Xlb711rJGtC
	N+A73P/XFhbNtNUCrm2dzlRmBzVTIZ2bY3dYPSBrwjFZPF3At4o7spwsNVasbuISoSQfo3AqkZu
	lheKBqIhDCYvwuNdcOjusTM6z8VZZ5ltQ1KUabgRTex6FRAKDhQ9uNLTRA3VGTO5FhNU2BLLLs7
	ElGqqt8QJLUDDC7VIS4Lun2tm5ga11TNAsdQUIt+dfBNwRdexANGxAQ+BW1oIrj466btMoW/5YF
	wiGG3kxywWEMyRAuiBAeLVLBqLc=
X-Google-Smtp-Source: AGHT+IHKRNW9sNDGCaX61D0IJSW//S9X5fcnVpi2KVH8DIVv8SCmHI0Nvj5CkCvxgW//clbJrEgQFB4JLZk0JktmY2M=
X-Received: by 2002:a05:620a:3915:b0:811:33d6:1aca with SMTP id
 af79cd13be357-8a8e34d3881mr764987085a.1.1761796838904; Wed, 29 Oct 2025
 21:00:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251030014020.475659-1-ziy@nvidia.com> <20251030014020.475659-3-ziy@nvidia.com>
In-Reply-To: <20251030014020.475659-3-ziy@nvidia.com>
From: Barry Song <baohua@kernel.org>
Date: Thu, 30 Oct 2025 12:00:27 +0800
X-Gm-Features: AWmQ_bmug-ryKCzBbavCMxdeQ4VhZPQSA41Fu9mlb8w6XWO_CcoeHvXWOnYu5Oo
Message-ID: <CAGsJ_4xWOhG5dfVZ2XmmVcXDPicRKiBB__=3W6Z9umXjn4M-Ww@mail.gmail.com>
Subject: Re: [PATCH v4 2/3] mm/memory-failure: improve large block size folio handling.
To: Zi Yan <ziy@nvidia.com>
Cc: linmiaohe@huawei.com, david@redhat.com, jane.chu@oracle.com, 
	kernel@pankajraghav.com, akpm@linux-foundation.org, mcgrof@kernel.org, 
	nao.horiguchi@gmail.com, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, 
	Lance Yang <lance.yang@linux.dev>, "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
	Wei Yang <richard.weiyang@gmail.com>, Yang Shi <shy828301@gmail.com>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 30, 2025 at 9:40=E2=80=AFAM Zi Yan <ziy@nvidia.com> wrote:
>
> Large block size (LBS) folios cannot be split to order-0 folios but
> min_order_for_folio(). Current split fails directly, but that is not
> optimal. Split the folio to min_order_for_folio(), so that, after split,
> only the folio containing the poisoned page becomes unusable instead.
>
> For soft offline, do not split the large folio if its min_order_for_folio=
()
> is not 0. Since the folio is still accessible from userspace and prematur=
e
> split might lead to potential performance loss.
>
> Suggested-by: Jane Chu <jane.chu@oracle.com>
> Signed-off-by: Zi Yan <ziy@nvidia.com>
> Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>
> Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

Reviewed-by: Barry Song <baohua@kernel.org>

> ---
>  mm/memory-failure.c | 31 +++++++++++++++++++++++++++----
>  1 file changed, 27 insertions(+), 4 deletions(-)
>
> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
> index f698df156bf8..acc35c881547 100644
> --- a/mm/memory-failure.c
> +++ b/mm/memory-failure.c
...
> @@ -2294,7 +2298,16 @@ int memory_failure(unsigned long pfn, int flags)
>                  * page is a valid handlable page.
>                  */
>                 folio_set_has_hwpoisoned(folio);
> -               if (try_to_split_thp_page(p, false) < 0) {
> +               err =3D try_to_split_thp_page(p, new_order, /* release=3D=
 */ false);
> +               /*
> +                * If splitting a folio to order-0 fails, kill the proces=
s.
> +                * Split the folio regardless to minimize unusable pages.
> +                * Because the memory failure code cannot handle large
> +                * folios, this split is always treated as if it failed.
> +                */
> +               if (err || new_order) {
> +                       /* get folio again in case the original one is sp=
lit */
> +                       folio =3D page_folio(p);

It=E2=80=99s a bit hard to follow that we implicitly use p to get its origi=
nal
folio for splitting in try_to_split_thp_page(), and then again use p to
get its new folio for kill_procs_now(). It might be more readable to move
try_to_split_thp_page() into a helper like try_to_split_folio(folio, =E2=80=
=A6),
so it=E2=80=99s explicit that we=E2=80=99re splitting a folio rather than a=
 page?

Thanks
Barry

