Return-Path: <linux-kernel+bounces-856428-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84C3ABE4272
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 17:14:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E04A3B5340
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 15:10:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58832340D87;
	Thu, 16 Oct 2025 15:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="OE9uEDAz"
Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2F6F31A7F3
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 15:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760627439; cv=none; b=nO6Rb0M0V479qfxVsqZtd5gCzbRbFyLxLy/Tdk0GNrhtup46wsNgMo0CqqFn9pOFXfQaDAbrsGmKtl7WmkYY0jy6GKqa7qxNtJg12b5NGyfr3xn+XzjDC7I0hSrxJoasyko4/Pi0ZAMnHH6EU7PZer4ewQA2GI5TxAf4uo5PeD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760627439; c=relaxed/simple;
	bh=MDirpUl1bUjzWCSY6OXLZq3F46Gc1NOvJ61vW/NCGbA=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=dmee8XpLfilLPkFswMrXGgHPtMBD7EeUEprGSpVqK9HpEMhrYyyWP6C/ZCeDmUYIOTW065FqVFA7HLelefmgsG18KhhkpmqDWHhGX/Tm6JhKVKeV1IiLCfPPQUEvEqHnH/JnEsUEAW0go5fF9z+NATGFS4qmdt3VCdHIJ/wGjUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=OE9uEDAz; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1760627434;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4Rbje5syNIXzuMkCbsb/LVpw2Q98dHUG/YI0JY1KZoI=;
	b=OE9uEDAzCUn91z/a7mgLOA5W0yKF8eYNp31jtjS2Dsm51tmeu0kbQvHjf3pt7IOvUbS4Lg
	yzhK/BlaIQDY7YAjZiGISs9JXUxA9QNQcj3hVGuAvM9UUm6VNNfxeMOfGfzeJbx8hy5WAX
	/MrNQrHjgIB0ao0rifAMmZYD2EJ1ZFQ=
Date: Thu, 16 Oct 2025 15:10:31 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Jiayuan Chen" <jiayuan.chen@linux.dev>
Message-ID: <46df65477e0580d350e6e14fea5e68aee6a2832b@linux.dev>
TLS-Required: No
Subject: Re: [PATCH v1] mm/vmscan: Add retry logic for cgroups with
 memory.low in kswapd
To: "Michal Hocko" <mhocko@suse.com>
Cc: linux-mm@kvack.org, "Andrew Morton" <akpm@linux-foundation.org>, "Axel
 Rasmussen" <axelrasmussen@google.com>, "Yuanchu Xie"
 <yuanchu@google.com>, "Wei Xu" <weixugc@google.com>, "Johannes Weiner"
 <hannes@cmpxchg.org>, "David Hildenbrand" <david@redhat.com>, "Qi Zheng"
 <zhengqi.arch@bytedance.com>, "Shakeel Butt" <shakeel.butt@linux.dev>,
 "Lorenzo Stoakes" <lorenzo.stoakes@oracle.com>,
 linux-kernel@vger.kernel.org
In-Reply-To: <aPEGDwiA_LhuLZmX@tiehlicka>
References: <20251014081850.65379-1-jiayuan.chen@linux.dev>
 <aO4Y35l12Cav-xr4@tiehlicka>
 <a6cd4eb712f3b9f8898e9a2e511b397e8dc397fc@linux.dev>
 <aPEGDwiA_LhuLZmX@tiehlicka>
X-Migadu-Flow: FLOW_OUT

October 16, 2025 at 22:49, "Michal Hocko" <mhocko@suse.com mailto:mhocko@=
suse.com?to=3D%22Michal%20Hocko%22%20%3Cmhocko%40suse.com%3E > wrote:


> >=20=20
>=20>  Thanks Michal, let me explain the issue I encountered:
> >=20=20
>=20>  1. When kswapd is triggered and there's no reclaimable memory (sc.=
nr_reclaimed =3D=3D 0),
> >  this causes kswapd_failures counter to continuously accumulate until=
 it reaches
> >  MAX_RECLAIM_RETRIES. This makes the kswapd thread stop running until=
 a direct memory
> >  reclaim is triggered.
> >=20
>=20While the definition of low limit is rather vague:
>  Best-effort memory protection. If the memory usage of a
>  cgroup is within its effective low boundary, the cgroup's
>  memory won't be reclaimed unless there is no reclaimable
>  memory available in unprotected cgroups.
>  Above the effective low boundary (or
>  effective min boundary if it is higher), pages are reclaimed
>  proportionally to the overage, reducing reclaim pressure for
>  smaller overages.
> which doesn't explicitly rule out reclaim from the kswapd context but
> historically we relied on the direct reclaim to detect the "no
> reclaimable memory" situation as it is much easier to achieve in that
> context. Also you do not really explain why backing off kswapd when all
> the reclaimable memory is low limit protected is bad.

Thanks for providing this context.


> >=20
>=20> 2. We observed a phenomenon where kswapd is triggered by watermark_=
boost rather
> >  than by actual memory watermarks being insufficient. For boost-trigg=
ered
> >  reclamation, the maximum priority can only be DEF_PRIORITY - 2, maki=
ng memory
> >  reclamation more difficult compared to when priority is 1.
> >=20
>=20Do I get it right that you would like to break low limits on
> watermark_boost reclaim? I am not sure I follow your priority argument.
>=20
>=20--=20
>=20Michal Hocko
> SUSE Labs
>

The issue we encountered is that since the watermark_boost parameter is e=
nabled by
default, it causes kswapd to be woken up even when memory watermarks are =
still relatively
high. Due to rapid consecutive wake-ups, kswapd_failures eventually reach=
es MAX_RECLAIM_RETRIES,
causing kswapd to stop running, which ultimately triggers direct memory r=
eclaim.

I believe we should choose another approach that avoids breaking the memo=
ry.low semantics.
Specifically, in cases where kswapd is woken up due to watermark_boost, w=
e should bypass the
logic that increments kswapd_failures.

