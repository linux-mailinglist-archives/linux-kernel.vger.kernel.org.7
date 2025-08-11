Return-Path: <linux-kernel+bounces-763613-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B6632B21778
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 23:33:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 45E0517C506
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 21:32:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 453D528505F;
	Mon, 11 Aug 2025 21:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="H2I28ApE"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC3C9285078
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 21:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754947939; cv=none; b=WTMkPiZva2lf8yJTVl0KScDQ/+zxMyUtLXtYG0PpxpIJmxPq/Vnj2DNkcFsDqdKFHekDcoRhjm+2rDrzeExT/Teku2p+KyedY2cOFJ1Rn0DqGtQMy+K5kzj8+O/nYt3CXyAvtyv0OTDMM5WevLxBmfmrE625zHdpYBAgSqxtRbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754947939; c=relaxed/simple;
	bh=Wp2SaX8CG7tM/UQZ7ITcbfAUzMlUdJy5a17ix7IDRPk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gTs3x1fUJ0++kI2KszPOQtX/gGM/Vjh74I/12DzP0RrUCVeBWB/SE5Y6otzCpfONyE1RsGEWPxMcZXgy6pWSBQSQoMRn5a09Fl7tuPuHqcKmI5DfchlH9COFUlzTQ0bv52/qUzYf2gTIDnyZvBVWxk8BIjsQNQD1X5sKDdWodFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=H2I28ApE; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-af93c3bac8fso686398166b.2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 14:32:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1754947936; x=1755552736; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nq/BuyAKv3pgMr4iqsCzwNSRSbvLzOuBXkj4nE74O0A=;
        b=H2I28ApEhCgfH5kAOBKRWZkuGDRBkQ9wH/XC2O9e3ldw8BmOEuBi3zFZ3kFbG+Z4yg
         M1aR/oUlPfskb63CwsuAP4OxyqGyNEnYzp+tT8l8U5AAuWs7/arlifwSNxoN/YOkJh1b
         /5bjhDinPe3fnKt5JMT/KXnNi/F1fFcFTUVFTIwQomlIMd/ngSe/sXigMjLsuSuS/k1R
         D6SG1Ww5qH6k+ppMBRLTQKMbinXW9u2MOVhpLnuOpXxOdXhsULBR4L5XJen9vEP2cJ9z
         rFgPgeDkTm+0mmuIqRfwmtvnTCgFnuDb/U7H5RLY32kPiksqh/MAOWOgb7CpcGI5yGnp
         TaeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754947936; x=1755552736;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nq/BuyAKv3pgMr4iqsCzwNSRSbvLzOuBXkj4nE74O0A=;
        b=HjsLjBohU7T3Jrz3/DbaMU6QqwJEnLDJz1foG6oKMZDME8ZpxlTop4KjVAFbvPZG09
         5UE/72UdIqrmi7PXM0Qu+1Mn3od6B10cDkP3Hm5ZObqxdcWd7pkVqhmgZgF5hhKt6MYF
         TB5o7cGZr3WBZ0UnMjWa67Owm9filKtMAzVWRMZp4Lf2oORt3gTYqXO2CWaEoO65woeo
         iEf0Cgmdi84El4FwhjFVGQnYU3+PWP40Oh694B7Rjx+5cj19pWQ4eOqSARyOswBWurcR
         vIMdby5du13G3myvSswieie/fRbTzQlqjG3gG7/locnIefTLgiWYR9C14Rqk/C/x1mxg
         NU4g==
X-Forwarded-Encrypted: i=1; AJvYcCW4H2KG3DwGNPzJufNtQNlPLsr9/pP3yl6Ip0csQkSREJo6H8UjD4RlX5TRMquJXqss0gMBEJ3E1VU59aQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzU2iW9te0QyEFHZgHA+4ixWIERAKOYNP21zgpQ2hms4zuZom92
	GgMBEYvSXlKQlu8u1rF3pA5yAP8yQxaQ07ZFYHHEYdySeEIYITN0dHW1kL09Xb2LfKwgG4K5UI2
	f0X9c
X-Gm-Gg: ASbGncumraHN0DFwqWIohPxwbGZkJhCTmmRnFpAiL6u54i1qPlBGfCeKJ2yO9mfD973
	q0jv1h3LfX8Nm4Sj0uV85sr0/pjyvXGa6YLuGCf/JnC2Dh2PV1cZVHM0MhJ4l600dJy5+CcRmmv
	udDu2I708bb56VN3mqmtBbc07w3LKmJ6AJX/NtvvhuzrYPGdgaoFVBqlnfW38MJOw+XhiUbmFHr
	eGgRhlU3sx0d1tMUbNyNMkpIk36JNz2eKKuwXxQwJ9Z2Bp9PFEcBSKZcGQlauO8jK3jNaLXfM2F
	ur+wGzXyCQ1Fw3bfthLRxpRYZWTDS5+YlBpWSzBpVg7FmKJgDa9Son8IAYToh7BJnsmszsodJGt
	5jJauXjZ818lI
X-Google-Smtp-Source: AGHT+IEpI2h9lIY/AO/fTtYcOoO4khM0ZEAiZvU2fi3EuMjQtsrWd8CdH2Opy3n0PnI33xPN+ZeMCQ==
X-Received: by 2002:a17:907:7247:b0:af9:6813:892e with SMTP id a640c23a62f3a-af9c653ab3dmr1329549066b.51.1754947935930;
        Mon, 11 Aug 2025 14:32:15 -0700 (PDT)
Received: from blackbook2 ([84.19.86.74])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af91a0a3981sm2069766266b.35.2025.08.11.14.32.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 14:32:15 -0700 (PDT)
Date: Mon, 11 Aug 2025 23:32:13 +0200
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: kernel test robot <oliver.sang@intel.com>
Cc: Shashank Balaji <shashank.mahadasyam@sony.com>, oe-lkp@lists.linux.dev, 
	lkp@intel.com, linux-kernel@vger.kernel.org, Tejun Heo <tj@kernel.org>, 
	cgroups@vger.kernel.org
Subject: Re: [linus:master] [selftests/cgroup]  954bacce36:
 kernel-selftests.cgroup.test_cpu.test_cpucg_max.fail
Message-ID: <lsnebzejrxrpulxxmyvkfdrsplbi2ft2n5zuux3dl3ewt5ihrs@j3umrzndddsb>
References: <202508070722.46239e7c-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="35rdoq4zxkxl7xa4"
Content-Disposition: inline
In-Reply-To: <202508070722.46239e7c-lkp@intel.com>


--35rdoq4zxkxl7xa4
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [linus:master] [selftests/cgroup]  954bacce36:
 kernel-selftests.cgroup.test_cpu.test_cpucg_max.fail
MIME-Version: 1.0

Hello.

On Thu, Aug 07, 2025 at 01:52:31PM +0800, kernel test robot <oliver.sang@in=
tel.com> wrote:
> dfe25fbaedfc2a07 954bacce36d976fe472090b5598
> ---------------- ---------------------------
>        fail:runs  %reproduction    fail:runs
>            |             |             |
>            :6           100%          6:6     kernel-selftests.cgroup.tes=
t_cpu.test_cpucg_max.fail
>            :6           100%          6:6     kernel-selftests.cgroup.tes=
t_cpu.test_cpucg_max_nested.fail
>=20
>=20
> not sure if there are any necessary env setting? thanks

The selftest commit essentially changed the tolerance margin from
ridiculously large to something that looked statistically appropriate
[1].
However, when I run the test (30x) on the 954bacce36 I get:

quantile([D1 D2 D8])  # 1 2 and 8 vCPUs respectively
ans =3D

   1.3086e+04   1.1559e+04   1.1177e+04 # min
   1.5109e+04   1.2936e+04   1.2989e+04
   1.5791e+04   1.3938e+04   1.3788e+04 # median
   1.6159e+04   1.5385e+04   1.4980e+04
   1.8757e+04   1.8699e+04   1.9494e+04 # max

I obtain similar values also on v6.15 (the kernel + 954bacce36
selftest). So it's not anything in throtlling implementation affecting
this.

The tests above were with HZ=3D250, for HZ=3D1000, I get slightly smaller
results with D2:
   1.1753e+04 # min
   1.2634e+04
   1.3208e+04 # median
   1.4010e+04
   1.6937e+04 # max

But still nowhere the 20% margin (i.e. values_close(...10%)), these
values would demand up to 100% (values_close(..., 50%)). Or add a bias
derived from sched_cfs_bandwidth_slice_us or increase the tested quota
=66rom 1% to 5%, that'd be an improvement:

   48882 # min
   52450
   52941 # median
   54284 # 75th percentile
   73186 # max (limit would be 60000)

I'm not sure how big overrun we want to accept as a pass.

Michal

[1] lore.kernel.org/r/20250701-kselftest-cgroup-fix-cpu-max-v1-2-049507ad68=
32@sony.com

--35rdoq4zxkxl7xa4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRCE24Fn/AcRjnLivR+PQLnlNv4CAUCaJphRAAKCRB+PQLnlNv4
CDorAP4j+gBfzJ9mjsTBBUy9uD3wIzoL2opwDNhFmTuGsKuCuQEA3ayfCV8VdA6/
OKdE1A/l6w776aNK35BBRJ+Oz9FgxAE=
=A67z
-----END PGP SIGNATURE-----

--35rdoq4zxkxl7xa4--

