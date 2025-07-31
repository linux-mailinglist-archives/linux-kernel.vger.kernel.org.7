Return-Path: <linux-kernel+bounces-752315-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C50EB173ED
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 17:26:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B8185845A1
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 15:26:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2B511DD529;
	Thu, 31 Jul 2025 15:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Azrhfok/"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CFC2156C69
	for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 15:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753975595; cv=none; b=rLNENLv9YLUuIWgnLoeCwgpe2OHw9oxiadgBNafhQUToy4prZvUK0gsxS7kyfml+V1RvGD9P7XZi0v9cASYxpPV2sAG5BtleoF3l/RUcZNNViG0PPor6IIJtsVG2cTLiPdbt4uq4D1XlMsiSamlKqT2Js1e6Uzul099wuw8l2c0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753975595; c=relaxed/simple;
	bh=9juaDkkLRGmc8ob7w3T4Osbk94u62LnIkmznSae3mdw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lJ6uF03O7hN44IknGBPAC2EYmzDUaIo/sUJMp6m9yCWm1ytre2yWUNZdYSrRdbcUXRAuXMFjFaSd38WYkpqZoNVeUlUtJ9AHEC4ONMEVFTJvcmSJl1IMmne7I7NXPvCHLLGbcaVskq89fZJG11A7uRsN0EvdWkbQja54Mv2uVc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Azrhfok/; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-455b002833bso4063495e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 08:26:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1753975590; x=1754580390; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9juaDkkLRGmc8ob7w3T4Osbk94u62LnIkmznSae3mdw=;
        b=Azrhfok/TWrImiBSL9E80nt3ytazljmPJ5rUFRtrVlezIhGKOlves3IHvNYAO4OnOl
         2nSfope8RGkC8h1KdSNP9fNfVZSvkoEMtEVRHL3Ky3v5fyUzqEXJV3dGiBE7iTQXHlIM
         G8s6qcotzs6VjE7xMbvFyiOVXRzgC9sU/Bsk2xhwWuSS744xEbV+9uGbMUbFNYl+5t36
         C09vVLiW4mZFBcV/s/ZthE8cdnwe4cq40tKm+zmhQ0PPnapzZNc6jciMsFQgB/gYUzGr
         Myhw6dzZPsrRqZEqnqK+/img89zxsh6BWAFAOS0Yso/Wp12gBVNsBITN6WlZFDMmyjMC
         v/9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753975590; x=1754580390;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9juaDkkLRGmc8ob7w3T4Osbk94u62LnIkmznSae3mdw=;
        b=MrbsSB4wPxUANhX9vcsQRtALGHrdrolokebqx/4p1wpZMG0WLxn//PYzjNiU4n+yND
         SNGkHg7kymJQL2nVAyIzsfY73Tk1stgfnwABhXZWrgpXKXnXnL9xaXRplMAOIc1+fXnb
         TOBSZLJv8AjeRbM/VRIA2r7p4NeF/8cgZfJcA7jp0V5jvFLNfa8UWWDFl1QfepIuMwBx
         W/hKsxIRXO3sYYmWACPebaQ7TDjmhFrwG/6tN8XLzIlbbHlLkytSHpFWgI67mJL7zbXe
         69e8DPlyTKfcJgG1k2dD+gSGcqwAyaa+mEXoJq89j98480Jv5g/0nLsfY51KpDWMPXiM
         7mJA==
X-Forwarded-Encrypted: i=1; AJvYcCU+AwbXyUXGs6B0ScJUKjuSrXyJ9V/4q3Fos4sDBww15Yxb+EdyGY1jdD88wfSUPuQvAmfYuTFWK/vERmQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxzDPA+Y59fEXLAKGZhp2m7bYRXVKgqhm2JHpYvgRgJ/1sLimDY
	oo9uxMu6GeS2aDECj1PbY774aLFEjPAgbvaLie2zeA3OdBR5Ucu/Cb6jmgEZno9WSb/4RsaUpRQ
	kglhK
X-Gm-Gg: ASbGncsH9r+N169An4ysLDOame5ZMaxgcvlHBbC7mEJ7Mqn1XjvAQ00LerURDA8zDIi
	M3dXp4uAaBhHbWoQlUeN84btKHSDB1fpS9FpSUT1rdYsD8r6v3f44mbbwNhIboMD8Wd0BU0cfeB
	4nhmTJCSXVd/RCxpScLb+FB6KevQNiTsYXmy98F/7fbRiM8SspRaO3bWk3AY0l4gxB86cG2JeOj
	YEqIzIx4bcntc4CcVU+ronSN9e9qvptOAIe2ywAtSPO5zM+gtjjPqo8cnAlPv1W7CnyQw6LDBI7
	IMhO0qwkovFwEA+tw2na41AzH/MX7SPcI3YsIIQXO5vSo6rHjhBIauFSDz8D0+vsL40Hv4TaGLx
	oylvO+dZUB3BQRoutfSOhbne+V/zVkT3S+zuSjmbiIw==
X-Google-Smtp-Source: AGHT+IHosNTNqSAYsiaRoVcj5bbYqHUmmD3ECRLqjZ0BCWAL/u1qGF9hjcwGucQfYS+n1yPTnFEUpg==
X-Received: by 2002:a05:6000:4287:b0:3b7:7633:4e71 with SMTP id ffacd0b85a97d-3b794fecc7cmr6509494f8f.13.1753975590264;
        Thu, 31 Jul 2025 08:26:30 -0700 (PDT)
Received: from blackdock.suse.cz (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b79c3c51e2sm2651464f8f.32.2025.07.31.08.26.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Jul 2025 08:26:29 -0700 (PDT)
Date: Thu, 31 Jul 2025 17:26:28 +0200
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Bertrand Wlodarczyk <bertrand.wlodarczyk@intel.com>
Cc: tj@kernel.org, hannes@cmpxchg.org, cgroups@vger.kernel.org, 
	linux-kernel@vger.kernel.org, shakeel.butt@linux.dev, inwardvessel@gmail.com
Subject: Re: [PATCH] cgroup/rstat: move css_rstat_lock outside cpu loop
Message-ID: <v572yf2qnle6ikxjb2ofvcmkuvpantmngrprrofd4kcia4xtld@uge7ti65njyj>
References: <20250722124317.2698497-3-bertrand.wlodarczyk@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="gfal7nrfele3ayud"
Content-Disposition: inline
In-Reply-To: <20250722124317.2698497-3-bertrand.wlodarczyk@intel.com>


--gfal7nrfele3ayud
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Subject: Re: [PATCH] cgroup/rstat: move css_rstat_lock outside cpu loop
MIME-Version: 1.0

On Tue, Jul 22, 2025 at 02:43:19PM +0200, Bertrand Wlodarczyk <bertrand.wlodarczyk@intel.com> wrote:
> By moving the lock outside the CPU loop, we reduce the frequency
> of costly lock acquisition.

So IIUC, mere acquisition is so costly that it dwarves actual holding
(flushing) as there are presumbly no updates collected.

As Shakeel wrote, there are reasons for not holding this lock for very
long (beside that being a general rule).

> This adjustment slightly improves performance in scenarios where
> multiple CPUs concurrently attempt to acquire the lock for
> the same css.

It means they can read cpu.stat more frequently but will they get any
fresher or more precise data? This is not clear to me, I understand why
this benchmark improves but does it represent some real world
improvement?

Thanks,
Michal

--gfal7nrfele3ayud
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRCE24Fn/AcRjnLivR+PQLnlNv4CAUCaIuLIgAKCRB+PQLnlNv4
CNeaAQC+/JNywSmgXWFmYEIKoxAL9joW7RMKPLnEE16OZ45WpAD+I/LqOgwJh0Dk
RkEoupDQifaFFt68kTjVnu03PgaTGAU=
=+FI6
-----END PGP SIGNATURE-----

--gfal7nrfele3ayud--

