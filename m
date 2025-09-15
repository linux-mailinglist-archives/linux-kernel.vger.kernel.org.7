Return-Path: <linux-kernel+bounces-816909-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9993DB57AA1
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 14:23:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AFD3B1AA06F8
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 12:22:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A41430AAB6;
	Mon, 15 Sep 2025 12:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="A0svqQWY"
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECC1A30AAC6
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 12:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757938865; cv=none; b=hRa9UvI+afo+/kuM54ZAR0R87tlNp2CxP5aKDzefoYpFDTNey8/HGyVhaoDEZaZ2o/ioeizjDU9RTADAizntoNDjaELzbjfhOnASN+C88fF6kLqi8hG1AG1Mkj20CibnCseasS6WSg71bfl+DYSK9m/GvJ6xqWJ0Y9oGdEY+T+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757938865; c=relaxed/simple;
	bh=dRXGhWojN/zmxVhLhhV7UBCFaTwMPK23OlCcE6/vJA0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SE1LEmwhmW7WbPWu5dqmbU/FUvsxJxqoH4/ZxkILlSDsVFCxzktI8WfK2gEUrF0yNY5Fb+7z9pVuJU6Rxr1S1qlBYZk2jLnPcsLKSe+z7cfF+gY2aKaMQoO7Np7rcNXMkEaTxQVAmvxo3Q7+dm9CE6LcU0Lc4L4rf1wBK+dlkdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=A0svqQWY; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3e8ef75b146so1164277f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 05:21:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1757938862; x=1758543662; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dRXGhWojN/zmxVhLhhV7UBCFaTwMPK23OlCcE6/vJA0=;
        b=A0svqQWYY98nAXTi9kuDSTEPPipJjudbrmhCo2ftEGwGqaqCr9QiYUsuHjrBfWrfAD
         +Uan2JVN+pog/3GfkAhB5tvG2HWwNGSS2DkT+/bqXwcrzDh4oAPFcltxjeShd9BzrxE9
         dCLq9atUMYZHGakoVjG59DEO8Y4YRX7d37eV4KQ+LctVHUnIB0lcVEiUaMF5s1So/P7z
         sTY7dXsQaHTYiNUmB5pSr5F7vpRbJ9MWO7XDcYMrAnt1sW6etYKyPuT+fGRKs57wfj0O
         8vQuNXDUnvTWxiPeO8Fr32Y4BCpfD1AZmeXRehOH9CqysvfDylpp5FfWZN3YcJWIFso0
         eD1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757938862; x=1758543662;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dRXGhWojN/zmxVhLhhV7UBCFaTwMPK23OlCcE6/vJA0=;
        b=oVh47HPvpBJ4rHe4nqzo0EoyEyLg9/flLwCDFTfr5zUdh6IdAj48EM/MxfrAH9sB17
         QwxN7RxBWkLRpTrOsFtmLpL5twBzmY73X8QncbhWnQP6lxvGf5DPI3QTelEMYKwhrOHJ
         I8299NJoH+Q+SonrIRzVT6engNaZX+7q/oox6ORMYPYhl7v1gXcqpJWooVzm+qJDQzyu
         VwLjnjYPYrubtfej1tACUFPOfLCoA4adQ13+kDfkyJsSIGkTn2MQpQz0zGSl1IFeS/gW
         ugFt3oKnduPb3nNKaNO5QmwRzcD4yU7jJ2O4CEd7jkfqGFXyNmdc4Qq1HIVz0aGLynkn
         87AA==
X-Gm-Message-State: AOJu0YxDANtCXdJaxRiVRb8wrqxM1q1YXhCcl/UmGg38iRYHXMULqK+L
	F+cwbYhEXlYiCYjmWY2XdbzjnHx76iKulD4GA0ga1MnivM777MVtZTDBrze0+jC0G4M=
X-Gm-Gg: ASbGncsH3W3GjDh8qeiQzWOZ3SAchUv5eJRhAIEG+tE8eE5YSQgNH2lt7wjLw9vwMVg
	eZxYxshYD88hMP079RD+gEyY+VcuPoMrxlFBd45QmL3HQ8ztzHHkISzwiXmPUKbNX7EQbr8Q4Cg
	CaPY9j61CW+f4s1TEdHjVPtnfRckvHUAFLmOyr2uZ3Y+JdvNl6e0lth2e07pZiY0+HsYDewpdRE
	OuAhn78P2602sOzjtT2LjEzBQ755u1woE3rxqUN0F72YBEmOCCZZUtBeg3zrzrQgqSzfO1JpQvX
	BN5ZQVORSiCMYq8vC8XsID4MnmkJtF7azQis7bKhau/ri5jU+XPrgj0+Cc2nRcAEZvYzBzQYPEj
	SDIdZBha7xZnUh0jhFznup/oT
X-Google-Smtp-Source: AGHT+IHZxjPiVftQFFSVsD2VxpuAkBezLqcbHM5N6FMX7Nja48uVvgnW5IZJk5T4dZviTmbAHvCxyQ==
X-Received: by 2002:a5d:64c3:0:b0:3d1:42dc:c710 with SMTP id ffacd0b85a97d-3e76579317emr9382433f8f.16.1757938862113;
        Mon, 15 Sep 2025 05:21:02 -0700 (PDT)
Received: from blackbook2 ([84.19.86.74])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e96dee54d8sm7498070f8f.12.2025.09.15.05.21.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Sep 2025 05:21:01 -0700 (PDT)
Date: Mon, 15 Sep 2025 14:20:59 +0200
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Bagas Sanjaya <bagasdotme@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	Linux Documentation <linux-doc@vger.kernel.org>, Linux cgroups <cgroups@vger.kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Andrea Righi <arighi@nvidia.com>, Johannes Bechberger <me@mostlynerdless.de>, 
	Changwoo Min <changwoo@igalia.com>, Shashank Balaji <shashank.mahadasyam@sony.com>, 
	Ingo Molnar <mingo@kernel.org>, Jake Rice <jake@jakerice.dev>, Cengiz Can <cengiz@kernel.wtf>, 
	Mauro Carvalho Chehab <mchehab@kernel.org>
Subject: Re: [PATCH v2 2/4] Documentation: cgroup-v2: Add section numbers
Message-ID: <duppgeomaflt6fbymdk5443glmw7d3bgli2yu7gx6awb7q2dhn@syjq5mmia6pb>
References: <20250915081942.25077-1-bagasdotme@gmail.com>
 <20250915081942.25077-3-bagasdotme@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ml2yrs6lektswjhv"
Content-Disposition: inline
In-Reply-To: <20250915081942.25077-3-bagasdotme@gmail.com>


--ml2yrs6lektswjhv
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Subject: Re: [PATCH v2 2/4] Documentation: cgroup-v2: Add section numbers
MIME-Version: 1.0

On Mon, Sep 15, 2025 at 03:19:25PM +0700, Bagas Sanjaya <bagasdotme@gmail.com> wrote:
> Add section numbers, following the numbering scheme in the manual
> toctree. Note that sectnum:: directive cannot be used as it also
> numbers the docs title.

Erm, so in addition to keeping manual ToC in sync, we'd also need to
maintain the section numbers manually?

What about dropping the numbers from manual ToC and sections? (If manual
ToC is to be preserved.)

Thanks,
Michal

--ml2yrs6lektswjhv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJEEABYKADkWIQRCE24Fn/AcRjnLivR+PQLnlNv4CAUCaMgEqBsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMSwyLDIACgkQfj0C55Tb+AgBMAEA5FwahNfScmcGEHeTMPg/
fK1406QYr3ODWMP8GdbwXk8A/3ZGZNF3X3LOGQ4Okk40J612ukJscIDXRv9sFEbP
V8UC
=5Zpi
-----END PGP SIGNATURE-----

--ml2yrs6lektswjhv--

