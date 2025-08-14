Return-Path: <linux-kernel+bounces-769007-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EDCC3B26900
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 16:20:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 37586AA1474
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 14:10:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2D2722CBF1;
	Thu, 14 Aug 2025 14:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="eP0iJqwA"
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3942226173
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 14:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755180236; cv=none; b=pcb4dHjfbRwO1giRvt6KN6mIvreOsEvBD6H5WkRIoHxFjpwl18+6FTN7VyWRtNX7pX6FQ3ckwV0VFg20apL1wN29FMKdKM5XrMhE82RDOx2eIz9E/dX4xkL7Now0vNpICD3gzt9e8f1MAfW/DWmzjVlsH0TxTIcg0KLjgtesLF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755180236; c=relaxed/simple;
	bh=kUvFkcwSLbLCzsw6hNYErVoVnOChgljOxpotCjsrSz4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HWOkyJRNDM0PmRK2txFb3dGRNhsrqyBBDSS7cVjZ1PsaZFlhzo0tQPX7eug8PVFVF+/0TcGHNXp7aMAfYKWwbA2WhUhNW+g2axZJpQATO0Ura9dBlj5lvUg3d1P7Ed036Gg1fJMd38/pMO2EkQu5j7UCMs4QRACt5TgAJFedTNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=eP0iJqwA; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3b9dc52c430so496240f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 07:03:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1755180233; x=1755785033; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lC65XYVp3GguS5ZtQw5kqmm56yzuVcq1hmEZc/3UkP8=;
        b=eP0iJqwAbzqP66MxQ2VnB41oHNDlPSnNN7Xob9qQXOKKpGoTj0fBPThMMzKWuKCsjr
         ItmNhjnkPuU/uaU1eYf7WJyV3IZhlODc+BiHjTGantbF2LBT3Edx2tux6XezKltPhomS
         4h/wSRQwZfMknlAPx7LXmZ15QXAsqHDhqs3rMqDSgy8rp4Ju02LpgpXRu/Xcq3rkl9No
         qhjf+tlQSQbfpfbBCf0McoqhSmqy9HIcyKG/Z4rkSwtiaaQ+qrKhTgCnbCp/NEoBYRR7
         /5170eY4OkoUivysasZcGul3QxzCEJiYnbzvRO0kns1Ed87S+SzD/O9IHpnRYJxYtmLx
         g0Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755180233; x=1755785033;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lC65XYVp3GguS5ZtQw5kqmm56yzuVcq1hmEZc/3UkP8=;
        b=wnyBrSgD9EXdxfFRwK8b4MF7obl3JA2MSNRa2jhVCcUhej/dpxXmoaclWgrCzBlsy7
         HQVCM5E2+pcSV+90IPG2IlfNPCE8XI/8EtflTYaMvZbpyn2X0MFKE8d4Ci+9IDvyWW1g
         QEQ+VOlM6q8JH9O3BSH/lExE4SS35aC9Lp06Ko3XcfIGXpJIrjFj6DZhIboWeZO6oCRr
         yAEcxqY/sCkprrJnFH+ZdfH8IAsxfPdATSxFvOy86lEuTVKRZB3JMuPW1zVlZt4B1F9+
         iJjJtrqn9NYN9LW4BSQ7FVTmSOY85/BR6qOUOHhs9CBdryDqdjTk+7xeScXPOI5ALTq6
         to3w==
X-Forwarded-Encrypted: i=1; AJvYcCW/zgBeitRMpqL7HTyZvNWMcqi9dnoBRxeceGyQqK8xMXNZP0thTaQVEwDw+4m0BvL4gF2ixozRzEjMYPs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKmDE2bZaofLxpSrNPpGWJ8v9dM8yXFLgmmmUoo56czetMDHYC
	iOsFUzXOvXhPdG+T857FCvbMGw3cocFQWklhYZEGIyAEtQW99qh5NICpOt4VWbnUZi4=
X-Gm-Gg: ASbGnctfI7kiOGN15cFDHKO8BDgk2VZYV059/ucL5QdrCVXNw9Ht73DznTU5CTnO7mb
	BKE0NJOgdet7vEEoXyYuYy2r14Dt4+eT/vL/rS2PzdcYKhPc5Kt+scE1jaKZySYLNPFIjCNHZiJ
	STJhqY/PAo3+bE7QAh5EGqHE5bXmPAt+zfzlFiCPxVKeLqWgRkt5enUCmSPuJsHZmGA8DcfmK65
	QrLflxXCKD1rYgrRLtgHvvHjHTUooesdr5BfH4iBzTmGKtWtBd/BtHzOMcb5+fKZ3rR/7ucr3+W
	s21bkCtoDhsJgspNQHRqHAP2PisjjzcVOrkyCniO2jcK1pIwUjiA5XDBsmm865HfgZDEq51aIGJ
	6cqbL7ZRqvKm8xahz9h2SHq+mSK+C1UEx9fJ6p1NNiw==
X-Google-Smtp-Source: AGHT+IFepIfEgCQYh8ddmvzxRHyhlH/Icj4lFNZlo25smTmLumPxpWK7npvv59MNJPG2u//aqGvssA==
X-Received: by 2002:a05:6000:3108:b0:3b9:16e5:bd36 with SMTP id ffacd0b85a97d-3ba50cc8b0bmr2180594f8f.15.1755180232712;
        Thu, 14 Aug 2025 07:03:52 -0700 (PDT)
Received: from blackdock.suse.cz (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b422bac12d4sm29684671a12.32.2025.08.14.07.03.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 07:03:51 -0700 (PDT)
Date: Thu, 14 Aug 2025 16:03:36 +0200
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: YoungJun Park <youngjun.park@lge.com>
Cc: akpm@linux-foundation.org, hannes@cmpxchg.org, mhocko@kernel.org, 
	roman.gushchin@linux.dev, shakeel.butt@linux.dev, muchun.song@linux.dev, 
	shikemeng@huaweicloud.com, kasong@tencent.com, nphamcs@gmail.com, bhe@redhat.com, 
	baohua@kernel.org, chrisl@kernel.org, cgroups@vger.kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, gunho.lee@lge.com, iamjoonsoo.kim@lge.com, taejoon.song@lge.com
Subject: Re: [PATCH 1/4] mm/swap, memcg: Introduce infrastructure for
 cgroup-based swap priority
Message-ID: <uyxkdmnmvjipxuf7gagu2okw7afvzlclomfmc6wb6tygc3mhv6@736m7xs6gn5q>
References: <20250716202006.3640584-1-youngjun.park@lge.com>
 <20250716202006.3640584-2-youngjun.park@lge.com>
 <jrkh2jy2pkoxgsxgsstpmijyhbzzyige6ubltvmvwl6fwkp3s7@kzc24pj2tcko>
 <aH+apAbBCmkMGPlO@yjaykim-PowerEdge-T330>
 <aH/baxIgrBI3Z1Hl@yjaykim-PowerEdge-T330>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="6rfjwiky6sklgybr"
Content-Disposition: inline
In-Reply-To: <aH/baxIgrBI3Z1Hl@yjaykim-PowerEdge-T330>


--6rfjwiky6sklgybr
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 1/4] mm/swap, memcg: Introduce infrastructure for
 cgroup-based swap priority
MIME-Version: 1.0

On Wed, Jul 23, 2025 at 03:41:47AM +0900, YoungJun Park <youngjun.park@lge.=
com> wrote:
> This leaves us with a few design options:
>=20
> 1. Treat negative values as valid priorities. Once any device is
>    assigned via `memory.swap.priority`, the NUMA autobind logic is
>    entirely disabled.
>    - Pros: Simplifies implementation; avoids exposing NUMA autobind via
>      cgroup interface.
>    - Cons: Overrides autobind for all devices even if only one is set.
>=20
> 2. Continue to treat negative values as NUMA autobind weights, without
>    implicit shifting. If a user assigns `-3`, it is stored and used
>    exactly as `-3`, and does not affect other devices.
>    - Pros: Simple and intuitive; matches current implementation
>      semantics.
>    - Cons: Autobind semantics still need to be reasoned about when
>      using the interface.
>=20
> 3. Disallow setting negative values via `memory.swap.priority`.
>    Existing NUMA autobind config is preserved, but no new autobind
>    configuration is possible from cgroup interface.
>    - Pros: Keeps cgroup interface simple; no autobind manipulation.
>    - Cons: Autobind infra remains partially active, increasing code
>      complexity.
>=20
> 4. Keep the current design: allow setting negative values to express
>    NUMA autobind weights explicitly. Devices without overridden values
>    continue to follow NUMA-based dynamic selection.
>    - Pros: Preserves current flexibility; gives users control per device.
>    - Cons: Slightly more complex semantics; NUMA autobind remains a
>      visible part of the interface.
>=20
> After thinking through these tradeoffs, I'm inclined to think that
> preserving the NUMA autobind option might be the better path forward.
> What are your thoughts on this?
>=20
> Thank you again for your helpful feedback.

Let me share my mental model in order to help forming the design.

I find these per-cgroup swap priorities similar to cpuset -- instead of
having a configured cpumask (bitmask) for each cgroup, you have
weight-mask for individual swap devices (or distribution over the
devices, I hope it's not too big deviation from priority ranking).
Then you have the hierarchy, so you need a method how to combine
child+parent masks (or global/root) to obtain effective weight-mask (and
effective ranking) for each cgroup.

Furthermore, there's the NUMA autobinding which adds another weight-mask
to the game but this time it's not configured but it depends on "who is
asking". (Tasks running on node N would have autobind shifted towards
devices associated to node N. Is that how autobinding works?)

=46rom the hierarchy point of view, you have to compound weight-masks in
top-down preference (so that higher cgroups can override lower) and
autobind weight-mask that is only conceivable at the very bottom
(not a cgroup but depending on the task's NUMA placement).

There I see conflict between the ends a tad. I think the attempted
reconciliation was to allow emptiness of a single slot in the
weight-mask but it may not be practical for the compounding (that's why
you came up with the four variants). So another option would be to allow
whole weight-mask being empty (or uniform) so that it'd be identity in
the compounding operation.
The conflict exists also in the current non-percg priorities -- there
are the global priorities and autobind priorities. IIUC, the global
level either defines a weight (user prio) or it is empty (defer to NUMA
autobinding).

[I leveled rankings and weight-masks of devices but I left a loophole of
how the empty slots in the latter would be converted to (and from)
rankings. This e-mail is already too long.]


An very different alternative that comes to my mind together with
autobinding and leveraging that to your use case:
- define virtual NUMA nodes [1],
- associate separate swap devices to those nodes,
- utilize task (or actual (mem)cpuset) affinity to those virtual NUMA
  nodes based on each process's swap requirements,
- NUMA autobinding would then yield the device constraints you sought.


HTH,
Michal


[1] Not sure how close this is to the linked series [2] which is AFAIU
    a different kind of virtualization that isn't supposed to be exposed
    to userspace(?).
[2] https://lore.kernel.org/linux-mm/20250429233848.3093350-1-nphamcs@gmail=
=2Ecom/


--6rfjwiky6sklgybr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRCE24Fn/AcRjnLivR+PQLnlNv4CAUCaJ3stQAKCRB+PQLnlNv4
CFBgAP0YLsIMSEwHcqH0D9nz6CywkXUaQ5+rGzpsZ9ThrHtU1wEApCgAfBGTFDNp
6bjzuw0DnamTil8xVsgM0FRkjUunhg0=
=bJ1Z
-----END PGP SIGNATURE-----

--6rfjwiky6sklgybr--

