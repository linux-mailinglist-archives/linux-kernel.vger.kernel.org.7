Return-Path: <linux-kernel+bounces-771526-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9BF4B2886A
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 00:43:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 327EA604C6A
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 22:42:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3488B2620F5;
	Fri, 15 Aug 2025 22:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JuZ9gEdL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 903BA317715
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 22:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755297762; cv=none; b=fvPXDzKaKYs7rbncy/dHRQy7fM63w9exnq2kd7kJWacJEoAY7weSHes7ngtqjOTP5rJ43roez29LNjQ/nglPZn/3BrK/oQljrhuPxQ+NBGX14kcZIKWVRodB3B/hoUap94xQKqCBVGXgV1djCv1Zc84caaQ96sk80VJnCIat2gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755297762; c=relaxed/simple;
	bh=YmNKpXV6F1ufPkWgoTk31tNHiYahxKYmUsoHxcoDQcw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fITZ/U4/ev1CaYrqNwZDxOZZLku1lNE5IZolNoKMC2/XJ43gPz5Ly5miCc8RD4WhJPiqeq3ew6rEf/wEzlqSQHSFxRO/vE/wGS/KCeYB0mj0FmXkQywVEqXqb75i27AIgg2GXT+m+JsgX+dAsB7sZtwfDOOSXP6jtl1bMdcbNJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JuZ9gEdL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F30EDC4CEFB
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 22:42:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755297762;
	bh=YmNKpXV6F1ufPkWgoTk31tNHiYahxKYmUsoHxcoDQcw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=JuZ9gEdLwMFkHi9xlKKQL1f0tVcHWizxCRIl1TJqoZFPMJsrfOu7E3alxZbWj7jFd
	 IbHAou1jeKUv1InGqGeoT2jkDCV8d5rATdmZgf0g5RVGNhN+z0syIxv+pD2y4MWIlu
	 eoSK4K40uNLPJYi+3LWG8I5HC/1eZ1g/z0aMeNjVUjxVfMe/aLAYq67arhdkEok2od
	 o5YOSvYzPNYuJqT3YVmRVkoBTQi/QfW0430fsZaw614KHNrXqUz/Rrrpi+BfibbYBG
	 VUJmvUfc93QZbZoqNPX8F6HE4Tg/BlsSKEnfRPmDcxpzHSrf1Fuu3dg382z96BGo/K
	 LTCB88YCCZ4lg==
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-459fc675d11so9695e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 15:42:41 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXVvmUkmCyF+wb8nJpTYUB4UzUtMUuKe/ZfIWOE634guJJnQWwUQ5xVaNWqkRoJgzWozclGz2VTitMxI5c=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHazs3P1PbbUl0G1t9xgDeExfYoDP7Z80vnSyQZJyx2OAZy4mO
	NszuKe2kmm1So0lpwNaMma0GUvmxzjKpp0rFaAGdMVtajjbxCUSIPmD4HDElgLTZjGLu0holCUk
	f1DVq5670CMT/ZF3NWQwmowBejtqqbWPQLcKuS0d4
X-Google-Smtp-Source: AGHT+IFNk5da7XaAM+/ANdl0I0NOeA18DEJrxF0sOna4KC5smln9g8k/0ZOuHnYlCfXg0UdOUq3LmP4nrSW3Y2IvPG4=
X-Received: by 2002:a05:600c:870c:b0:459:d7da:3179 with SMTP id
 5b1f17b1804b1-45a26f07dcbmr155955e9.5.1755297760615; Fri, 15 Aug 2025
 15:42:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250812170046.56468-1-sj@kernel.org> <CAF8kJuN1BH0rqC6czj9govNOugd_5K9ijYcxbWYpEpUdQKn0-A@mail.gmail.com>
 <uo6vtumoy4txklyqy4njitf5ex4eanudncicbbzknmuowopd7v@jm4ao4qapiza>
In-Reply-To: <uo6vtumoy4txklyqy4njitf5ex4eanudncicbbzknmuowopd7v@jm4ao4qapiza>
From: Chris Li <chrisl@kernel.org>
Date: Fri, 15 Aug 2025 15:42:28 -0700
X-Gmail-Original-Message-ID: <CAF8kJuNRTTaFxa7fOJi-4QcQfb2ydvfnQVz1_3fKmo-v__qGsg@mail.gmail.com>
X-Gm-Features: Ac12FXwdNeuamxbqZnoUCF7dzA-ckXSYAzpoX9giTHu9V_MAXpUzgnrqkH0RsDU
Message-ID: <CAF8kJuNRTTaFxa7fOJi-4QcQfb2ydvfnQVz1_3fKmo-v__qGsg@mail.gmail.com>
Subject: Re: [PATCH v2] mm/zswap: store <PAGE_SIZE compression failed page as-is
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: SeongJae Park <sj@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Chengming Zhou <chengming.zhou@linux.dev>, David Hildenbrand <david@redhat.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, Nhat Pham <nphamcs@gmail.com>, 
	Yosry Ahmed <yosry.ahmed@linux.dev>, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	Takero Funaki <flintglass@gmail.com>, Hugh Dickins <hughd@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 13, 2025 at 12:42=E2=80=AFPM Shakeel Butt <shakeel.butt@linux.d=
ev> wrote:
>
> On Wed, Aug 13, 2025 at 10:07:18AM -0700, Chris Li wrote:
> >
> > If you store uncompressed data in the zpool, zpool has metadata
> > overhead, e.g. allocating the entry->handle for uncompressed pages.
> > If the page is not compressed, another idea is just skip the zpool,
> > store it as a page in the zswap entry as page. We can make a union of
> > entry->handle and entry->incompressble_page. If entry->length =3D=3D
> > PAGE_SIZE, use entry->incompressable_page as a page.
>
> The main problem being solved here is to avoid the scenario where the
> incompressible pages are being rotated in LRUs and zswapped multiple
> times and wasting CPU on compressing incompressible pages. SJ's approach
> solves the issue but with some memory overhead (zswap entry). With your
> suggestion and to solve the mentioned issue, we will need to change some
> core parts of reclaim (__remove_mapping()), LRU handling (swap cache
> pages not in LRUs) and refault (putting such pages back in LRU and

No, that is not what I have in mind. I mean store a separate page and
memcpy into it, keep the swap cache folio still reclaimed as normal.
Not much different from a store in the zpool.

The cons really are migration etc. We might have to get it in zsmalloc late=
r.

> should it handle read and write faults differently). So, the cons of
> that approach is more complex code.
>
> Personally I would prefer a simple solution with some overhead over a
> more complicated and error prone solution without overhead. Or maybe you
> have a more simplied approach instead?

Ack, there is more complexity to get the last bit of performance gain.
Maybe in zsmalloc later.

Chris

