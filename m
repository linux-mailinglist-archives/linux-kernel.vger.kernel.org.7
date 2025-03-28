Return-Path: <linux-kernel+bounces-579697-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0463FA74838
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Mar 2025 11:27:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D6DBE189B88A
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Mar 2025 10:27:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCF2B219A8A;
	Fri, 28 Mar 2025 10:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="umW9MFd0"
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C18F48F49
	for <linux-kernel@vger.kernel.org>; Fri, 28 Mar 2025 10:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743157658; cv=none; b=AkIEhwBoHbYO5+/Np1lZOGv3Smm+aDfPx77hUJr42Onws2MxOdYX/V9Q/W5Bd4Uwl/0G6VpfaAr9IhLGfEq2cf4y3BhvKcKEI3/Zo0GlqGDvgpyG9sMYkfgvWbvWf3U4KZZ070j2EF5VLe5i9Sf4NBrvjN9WUal5NiH8S4XWGCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743157658; c=relaxed/simple;
	bh=i7mKZzkMcZp9ZJNbdNTwSjYL8EgM/QpuemcpfsUTFPY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lyEmhzFUds4xYjddei8PVsUBbCpuaBNPBhRndq5/LEWwwrNdtfd8CL6mi/iXreJ1dOu+44D99zkXA0fRSuOHKP0kFiwcG0KvooI8kgF+tr/vIzVAZ29PesyMQR6ln09UFVjLYoxyVOlKwDgscI42jY6+eDeCjqB8X+lwrNAOZ7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=umW9MFd0; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3912c09be7dso1170074f8f.1
        for <linux-kernel@vger.kernel.org>; Fri, 28 Mar 2025 03:27:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1743157654; x=1743762454; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Eax7YxGwWpnNu4N9Cuk0JD950DXdwRHhk8wiSiixGbg=;
        b=umW9MFd0krK7a+hul5ik+iolir9Sw1NcDEW3w7a9PXLJaWJQWd+PZoEm+a/vdKVsaF
         cislUlDX5ZaJ08+ov+HAjhyvijx4XPpCMGG/Xj0DVzWgmqlyV0AgsFUk4HBzbzz2+2wx
         X95KJs4+aOC7XHailEqaA2ol1knWdDi7Ccj/CswHCsgLJzR8gdLhDqVI/H51Fmboqtl8
         CeSvyIC5wTa0R7ZrVkx5rUkMICW2TKZDPfZI7smrUYPFuFFOOgWgXRCu2crmxLOXmTbt
         m55gAxqIKquyUYqQwmhHHceQq1bO063B4t0E/DP6b0HqZka+zg1iCBXNV/fNIw6hSte8
         JMAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743157654; x=1743762454;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Eax7YxGwWpnNu4N9Cuk0JD950DXdwRHhk8wiSiixGbg=;
        b=SmFzf8e1wI5kfjxbxwBhUxAezupvBRu4Urb8YwT1SEaPQS2fQ3C2O0mlTXP1FNJYDe
         3Wer9+mzc3jsrfp/9Zlp+8QFTDgpyh6Zt5KVCJ6L+3JBCCnsdo74LPOov9BQug6L6olA
         MWOHKurCsoZX7VCLMMlWD8UQ510ZJC/VhzIlf4RB+4JbiIv6cpIe/8uxhAl7jqRXaVXC
         gnp/0swxf9bq4aTfixEqLxN5FqN0vlBcS9BF9yY6tQekAIXlkCah1G76q4Y8crkhSQdS
         PSne2TqsW6h29nw7RE+MIZSCyltqKINr1ZdsEb/0j0uB12eKxBmoocHT+6g4F4c/F3Yu
         UE4Q==
X-Gm-Message-State: AOJu0YxC7qIvb8J7ODy5dqa+F8kCy7tFWUmBowE+jJdCk6vktp/dKQNA
	1J8/SQeXa37hRGJWp4YMDSjF+Awm/T3igBcc9uXSfIy0Pm5ljgsv70100QRCj1w=
X-Gm-Gg: ASbGncvsvCdgysuN9+4gIuCJrbvxwl2QsH4ZiY7uFXLV+iV15xnMAbXlQt+rbdhpog8
	qjXcAYMHlsOzeRKfPMxLi9ZCfz/b5zAXbyDZN1L9b+kiGIPsyNr4cYOX3dbGoTF8OdYzMUIM8Ud
	l5nw+eOfENHQSZhpU+q7/WD+dl5usq3ux4cqeFJaXjBJRyP20SKUpim0S4YbW8VNKk9cR+3zsIA
	gaVg2wy9ex1+SXh2wFR1D9f/zOHVadn7pyJgk5Ujo82zrzIZrbvB0EQw7SP9lOoL8oXWjIruAVJ
	MuDw6PNqZKX5MuxxL2AnSdgmvDjb+bb8ZFvD58gD8nw3ZyH5Ds6o/u/QoKnBm257sIUQ2+pt1Xa
	T7h7E1LIeNAk=
X-Google-Smtp-Source: AGHT+IEKgI3nQYHCH8DidEWqf2UoGJFR4wRiYpFWDfNslXOnE0ABJu9zI68fN3BS8uzY8lwCUjes4A==
X-Received: by 2002:a05:6000:4284:b0:391:3aab:a7d0 with SMTP id ffacd0b85a97d-39ad1749aa3mr6077097f8f.19.1743157653814;
        Fri, 28 Mar 2025 03:27:33 -0700 (PDT)
Received: from localhost (p200300f65f14610400000000000001b9.dip0.t-ipconnect.de. [2003:f6:5f14:6104::1b9])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39c0b6588d0sm2148585f8f.7.2025.03.28.03.27.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Mar 2025 03:27:33 -0700 (PDT)
Date: Fri, 28 Mar 2025 11:27:31 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Nylon Chen <nylon.chen@sifive.com>
Cc: linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org, 
	devicetree@vger.kernel.org, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Samuel Holland <samuel.holland@sifive.com>, linux-riscv@lists.infradead.org
Subject: Re: [PATCH v10 0/3] Change PWM-controlled LED pin active mode and
 algorithm
Message-ID: <ktmanz3mufxvme3gspm46p7vyjxsmzfxckqxg2e5a2mbqc5pxe@uc56iqoryuzr>
References: <20241224093902.1632627-1-nylon.chen@sifive.com>
 <zqkx7cx5nalslfmxeoxdnsjbvrvzajrjybsmsyeyc65a64sntr@gpc5qp6aoyp7>
 <CAHh=Yk_j1ZnJ+=XQ_geN1sXMaye=P4jk-vduwj0-1soM7d+wQw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="c2otz6rwcboba37k"
Content-Disposition: inline
In-Reply-To: <CAHh=Yk_j1ZnJ+=XQ_geN1sXMaye=P4jk-vduwj0-1soM7d+wQw@mail.gmail.com>


--c2otz6rwcboba37k
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v10 0/3] Change PWM-controlled LED pin active mode and
 algorithm
MIME-Version: 1.0

On Fri, Mar 28, 2025 at 05:41:37PM +0800, Nylon Chen wrote:
>  * (T) period.
> > > The `frac` variable is pulse "inactive" time so we need to invert it.
> >
> > I'm trying to understand that. You're saying that the PWMCMP register
> > holds the inactive time. Looking at the logic diagram (Figure 29) of
> > "SiFive FU740-C000 Manual v1p6" that is because pwms is feed into the
> > comparator after going through that XNOR where the lower input is always
> > 0 (as pwmcmpXcenter is always 0) and so effectively counts backwards,
> > right?
> > In that case the sentence "The output of each comparator is high
> > whenever the value of pwms is greater than or equal to the corresponding
> > pwmcmpX." from the description of the Compare Registers is wrong.
> >
> Hi Uwe, I've contacted the spec's author, and he is willing to correct
> the spec-related error.
>=20
> Based on your suggestions, I think we have two approaches
> 1. First add comments explaining where the spec and implementation
> don't match, then after the spec is corrected, submit another patch to
> remove the comments
> 2. No need to add this error explanation part, because the spec will
> be corrected later.
>=20
> I don't have a preference, so I wanted to check with you - do you lean
> more toward option 1 or option 2

I would go for 1, mentioning the version of the broken documenatation
and the expectation that this will be fixed in later revisions. So there
is no confusion when the documenatation is fixed but the comments not
removed yet.

Best regards
Uwe

--c2otz6rwcboba37k
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmfmeZEACgkQj4D7WH0S
/k44egf+LuxtxM7lTyagceD7gOIIrg8b15gWwsEr7jfLegP4q6GIa2Y25I+zqTqA
AdjCfRboH1x1fp8tD2TIsb/fE4lZa0ywNQSCr3UVyW3CUSrjGCDxB0NuqxI5oaGb
8mP+9Doa3A4UgYviPaeBxrK5pN5yPOJwigwyPzADtwMi/u18bn38sRDlGmRfQAbp
AzzpywbZHJIhcBXCDM6j5bhsQD0jWiQM7/YBkHF1Ftiwx87wNmcOJGR8o9C0LKDG
xfad+UWIz0nVJiGXxnFyeG6+quS7uUglSv0mvtLseWlh7pQ17MLVQkmnRILaESYy
Ginzw97MvNyFjEns8lQWRr/yidY+rQ==
=uVv6
-----END PGP SIGNATURE-----

--c2otz6rwcboba37k--

