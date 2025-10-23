Return-Path: <linux-kernel+bounces-866805-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1938DC00B02
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 13:21:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 64DD73AB5A8
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 11:21:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E69130DD0B;
	Thu, 23 Oct 2025 11:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="biB1smbd"
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AED9E3016F4
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 11:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761218463; cv=none; b=G7p32HQfOicXMO338I9WPJCTFIWU/C/zus1tqQDsjhjwwZSJALPsRHk1KHmGyqaUTPikxr+WkNe7MKBrYGiE3iSkXUKyviCFeTTQz2dFetFlqGrH4T+Tu3ZAMf2X8bpQVzEFIjpV6zI3NIQNzctSlQVo+o1RxwFNhmdgxlrpbGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761218463; c=relaxed/simple;
	bh=q/qJpLLyrX5Nc3Q2omEC8YYlMcA+3Kq6qylaMFQ9vec=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YG1zyM1hB0Xw+s67HWAr//LGMt1UIiBtdtEMdV8wmlCylTvHXo0/4xQA3Z7I+ffKnzfzjHO8EwHHaUrbNrzDubYnA9RnaibUSMekzhlXPulz7tfq64gIHhBrSdy/cNwE8vvTTDry52JepyFbxJWVH3ZbMnnA4S8OOA62LtjF/bw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=biB1smbd; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-63b9da57cecso1091721a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 04:21:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761218460; x=1761823260; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=20wqx529NmUv2TAIjzcQAgielck21eRDYr7Trm09NWM=;
        b=biB1smbdAHigm7WVn406+ivwKctGXaLBdP+ux3WLCTqXpZW+TvcGRBR6+moUScJsZT
         CyojP3Yn16p3If6c3HVl7uKm6xT3NKwaH5WvgbDF6XKdG9WDj5/qp2VZbmusxKMvaBrj
         3EO7+zs7aDuW3tObZf27W6GIWtqBHjJnVUd/eU5mkWTKZfv2Tx7izMj2rddAvjqiUu8b
         hoLHuzIP429lsVbhnT3Kctf0IZ/PhSuP94luWrpB57CNTSCTN1anWsOS2gxgvBJmGw6b
         Y0C2xTV2XCequKK++GOfFHZ0bZi493hjxv3hsAIfVe9pyH51VrbNObp2VkoIt4Mkl4kU
         Quwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761218460; x=1761823260;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=20wqx529NmUv2TAIjzcQAgielck21eRDYr7Trm09NWM=;
        b=uzV8TZyoYvhF56rrVyB3ve0uptmv7nCRiWK50xywhVjt0soTtpIQIhhhMF3cB3fcf7
         zvc73Qra8sEq2L51NzOsy0FMM4qy27UNCyRMXoyS5mmH1pCaI5Jc/JufhPtmOLV8FDOc
         t0s9FPGFd1aQWya/wNCho3Xrx5iVUMaHUclxjbwOjw6UEF8TyazhirCnREw8g7H66yQR
         0drvFcCwg8k1GNpAAI3DaNeBRZ/B6DFn7c4pw+96j+6qL5ZNsjwWwWwQsdiNbYUY6vyo
         A/3hrhxZonM8h7JI+krjBgLLILflyxbcOmZ83RkuEyIc8AYRlUrTwIAa3SFBZ8F3ymAg
         fiGA==
X-Forwarded-Encrypted: i=1; AJvYcCUGZUwZp1YClWPBfHB5CqYR1j8naxPtcbRh9PulkVZjLPQfFsw1kWrpAJX9gEl4OarLXuzzomjbDMX8TlU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWptH2VmEEgPaLHZj+Mw7nC1yB2/FHUt0itP7MQj46alqctBMb
	oy0SpYt3qH/eJZiyk44wvVL65ciRZo1+mR0JUPLcqw2X/yBe+RKFnxxMF4ohBvv9iF+cvRVZpBQ
	YYRKtzPg6SpXrqmdihmMjDxX74RIN3rc=
X-Gm-Gg: ASbGncsJhj646xW9UNNQfPQJi+L5wbOIzFneHJqZt10VQLR3hJnualQzuecqd89dc8s
	ZtuXt3RNyr2aMF6gv6ajEsI1SL9xpwnp9+DM5gCffcMnUt4qvS4GqAzwROjbKmy9hFAcuXi5ZJ8
	nDXHmnv8+pXcgH8mdbg5e2cVekG88eNJDWSxZ1WgbwBcvbZAS2mnoxCGCacet9bqbklD+rNjZT0
	g2k3Bfxxqp86880/dzlDuNr811QXBR2vzWP1NoZvon9VrbXBKCXfxYbdIoY+fiK9Alks2I5
X-Google-Smtp-Source: AGHT+IECMTs07V+C8/F4VRvVGlIMJgQ3W/ZfLjGZF9KufbRJpag6/hAomvYZxGBIvmY1gHksfnM+tDSbC1u/macZLbM=
X-Received: by 2002:a05:6402:2791:b0:63e:23c0:c33e with SMTP id
 4fb4d7f45d1cf-63e23c0c43amr5617590a12.27.1761218459828; Thu, 23 Oct 2025
 04:20:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251020093941.548058-1-dolinux.peng@gmail.com>
 <20251020093941.548058-5-dolinux.peng@gmail.com> <ec7ecc7d47540bba04f6a0b7e0cf74f4ef7a84bb.camel@gmail.com>
In-Reply-To: <ec7ecc7d47540bba04f6a0b7e0cf74f4ef7a84bb.camel@gmail.com>
From: Donglin Peng <dolinux.peng@gmail.com>
Date: Thu, 23 Oct 2025 19:20:48 +0800
X-Gm-Features: AS18NWD5siYzpgEti8IF-bhopY-X3-rGAw9ck7MaAicD2GKSDf0VbnqIZZ8PYa4
Message-ID: <CAErzpmt4ju_YhNm5CiZqDc_o12jOhMwDA0bNkP_ZoYUOJohhDg@mail.gmail.com>
Subject: Re: [RFC PATCH v2 4/5] selftests/bpf: add tests for BTF deduplication
 and sorting
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: ast@kernel.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	Andrii Nakryiko <andrii.nakryiko@gmail.com>, Alan Maguire <alan.maguire@oracle.com>, 
	Song Liu <song@kernel.org>, pengdonglin <pengdonglin@xiaomi.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 22, 2025 at 3:07=E2=80=AFAM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
>
> On Mon, 2025-10-20 at 17:39 +0800, Donglin Peng wrote:
>
> [...]
>
> > +{
> > +     .descr =3D "dedup_sort: strings deduplication",
> > +     .input =3D {
> > +             .raw_types =3D {
> > +                     BTF_TYPE_INT_ENC(NAME_NTH(1), BTF_INT_SIGNED, 0, =
32, 4),
> > +                     BTF_TYPE_INT_ENC(NAME_NTH(2), BTF_INT_SIGNED, 0, =
64, 8),
> > +                     BTF_TYPE_INT_ENC(NAME_NTH(3), BTF_INT_SIGNED, 0, =
32, 4),
> > +                     BTF_TYPE_INT_ENC(NAME_NTH(4), BTF_INT_SIGNED, 0, =
64, 8),
> > +                     BTF_TYPE_INT_ENC(NAME_NTH(5), BTF_INT_SIGNED, 0, =
32, 4),
> > +                     BTF_END_RAW,
> > +             },
> > +             BTF_STR_SEC("\0int\0long int\0int\0long int\0int"),
> > +     },
> > +     .expect =3D {
> > +             .raw_types =3D {
> > +                     BTF_TYPE_INT_ENC(NAME_NTH(1), BTF_INT_SIGNED, 0, =
32, 4),
> > +                     BTF_TYPE_INT_ENC(NAME_NTH(2), BTF_INT_SIGNED, 0, =
64, 8),
> > +                     BTF_END_RAW,
> > +             },
> > +             BTF_STR_SEC("\0int\0long int"),
> > +     },
> > +     .opts =3D {
> > +             .sort_by_kind_name =3D true,
> > +     },
> > +},
>
> I think that having so many tests for this feature is redundant.
> E.g. above strings handling test does not seem necessary,
> as btf__dedup_compact_and_sort_types() does not really change anything
> with regards to strings handling.
> I'd say that a single test including elements with and without names,
> and elements of different kind should suffice.

Thanks for the suggestion.

>
> [...]

