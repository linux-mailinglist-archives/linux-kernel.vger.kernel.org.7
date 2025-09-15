Return-Path: <linux-kernel+bounces-817274-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EA62B58005
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 17:10:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F2CF16FE40
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 15:08:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FFDD32ED5F;
	Mon, 15 Sep 2025 15:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DUPYwRGe"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC88415D1
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 15:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757948866; cv=none; b=EzBT1wZRcUIOhc+7V+wOKz1PoeH3VW+atHCuFuwBC3lBjFStiQtSAmDQKeXO7SIOFIUQFGbidp2mMbAIYcGI0G1cwqCwPZBHOq3XVtzwKS6j+iWxOnKPg3z5ZtIoGALZs+hzVy+RamHhNTDPU6fFIoM8EbKPycWHAuVCZk5humc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757948866; c=relaxed/simple;
	bh=lbCbHZj7vfmABIBv408giulALA9kMK1IB9J3cmB5oYA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Tq7nEU/ziYjgnnQsFfina9EW+JtrGusmUSvPUcKSKrVGP305E7eWiIES+SCioSUYFdigUjuAddyoJtADhXtpzXuqUg3vqIwqqY36M0SfMHciAFK2nfH1AFfJ2ez3c9ixqr58yfuYfWbazCqgIfo+m6+NN1qeBceZV6FWrI6GK+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DUPYwRGe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CB1EC4CEFD
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 15:07:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757948866;
	bh=lbCbHZj7vfmABIBv408giulALA9kMK1IB9J3cmB5oYA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=DUPYwRGetiwBtqToVa3mN0ORT3D72xTqd5CkfqrL5OKuXcHrHZPTsPkmgQIk5xvZb
	 8Gbnw7KKoZP++icj/e8mQGBPn3ZaZLvhfLZRnrjQ/rj2SkTIVlC/zs/04r37QsBry1
	 2KhCxGdAao9ZIdXMJ3TXd2Kyog4EqRE9EdbgZt7gl5HMXBEHO0yxR8VpjwF2mKQZdL
	 TGPSLSsynhPsW/KUeC8PG40xlbequa9M7Dhcg7SVRiXWVRqnstM1F5IKFs5k2AGOyI
	 SxTMQD/DDG0zLQWeeybcuFqAGJLcM2if4N4GgNOMUudXl2R/0fHjJaHzj9u+N9Vtea
	 Q+J4jC16iPWEg==
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-45f2fa8a1adso6469025e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 08:07:46 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUfljmdf7KRzUFz9TAwfGsaLbi+J5Ry+EAukkgW8zOoaKPxSWGjPj669el7AagILxdg40WSUOyH/0Wkidc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMFMnKWb9vhMqlMzuIHfuzBQgbFhIE84BJJBWxbmB6Ti4smPV9
	3TnvMuuaBlsRsuO+65u8ZxXP9oNFeRiGqosCUnIwIcfz/2EvtgIvUfSooh2vc0PqKhL3jq4ocy1
	rWeUOcV/1oRHpcrccZc7AUs8ou5f5bzqSnHl+uRmPKg==
X-Google-Smtp-Source: AGHT+IGhuPmaGbUuWGfTk4lCZHKMHwj2fhjE+kTpWT6mdDBdnrkVFrFl26qtvg+vJOM3dKP52DILM0q3LcZL1isatKE=
X-Received: by 2002:a05:6000:2f81:b0:3e5:5261:9fae with SMTP id
 ffacd0b85a97d-3e75e0fd387mr17332464f8f.12.1757948865195; Mon, 15 Sep 2025
 08:07:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250910160833.3464-1-ryncsn@gmail.com> <20250910160833.3464-6-ryncsn@gmail.com>
In-Reply-To: <20250910160833.3464-6-ryncsn@gmail.com>
From: Chris Li <chrisl@kernel.org>
Date: Mon, 15 Sep 2025 08:07:32 -0700
X-Gmail-Original-Message-ID: <CACePvbX4juhR5jry0Bi202qo=nfFVZkztHzo8KxKMW_yKBseyA@mail.gmail.com>
X-Gm-Features: AS18NWBcTBl91C5Xf37GBuC1knYSyNgjXDoI6S9qWcNEbUHt8JHt-T38VvczERs
Message-ID: <CACePvbX4juhR5jry0Bi202qo=nfFVZkztHzo8KxKMW_yKBseyA@mail.gmail.com>
Subject: Re: [PATCH v3 05/15] mm, swap: always lock and check the swap cache
 folio before use
To: Kairui Song <ryncsn@gmail.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>, 
	Matthew Wilcox <willy@infradead.org>, Hugh Dickins <hughd@google.com>, Barry Song <baohua@kernel.org>, 
	Baoquan He <bhe@redhat.com>, Nhat Pham <nphamcs@gmail.com>, 
	Kemeng Shi <shikemeng@huaweicloud.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	Ying Huang <ying.huang@linux.alibaba.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	David Hildenbrand <david@redhat.com>, Yosry Ahmed <yosryahmed@google.com>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Zi Yan <ziy@nvidia.com>, 
	linux-kernel@vger.kernel.org, Kairui Song <kasong@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 10, 2025 at 9:09=E2=80=AFAM Kairui Song <ryncsn@gmail.com> wrot=
e:
> @@ -2004,6 +2002,13 @@ static int unuse_pte(struct vm_area_struct *vma, p=
md_t *pmd,
>         bool hwpoisoned =3D false;
>         int ret =3D 1;
>
> +       /*
> +        * If the folio is removed from swap cache by others, continue to
> +        * unuse other PTEs. try_to_unuse may try again if we missed this=
 one.
> +        */

It took me a while to figure out why we add a
folio_matches_swap_entry() check here but we don't have an existing
check for folio swap entry matching in this function. Can you confirm
that if a race has happened causing the folio swap entry mismatch,
then try_to_usue() MUST try again rather than "may" try again. It
seems to me that it is a MUST rather than "may". I am curious in what
condition the mismatch happens and the try_to_unuse() does not need to
try again.

BTW, this function has three types of return value, 1, 0, and negative
for error. The 0 and 1 are ignored by the caller, the caller only
cares about the negative value. Overall this unuse_pte() and
try_to_unuse() walk feels complicated and maybe a candidate for later
clean up. That is not your patch's fault. I am not requesting a
cleanup in this series.

With that Nitpick,

Acked-by: Chris Li <chrisl@kernel.org>

Chris

> +       if (!folio_matches_swap_entry(folio, entry))
> +               return 0;
> +
>         swapcache =3D folio;
>         folio =3D ksm_might_need_to_copy(folio, vma, addr);
>         if (unlikely(!folio))
> --
> 2.51.0
>

