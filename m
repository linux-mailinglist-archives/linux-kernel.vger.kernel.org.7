Return-Path: <linux-kernel+bounces-860069-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 13055BEF3BD
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 06:19:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF8A11899E36
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 04:20:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B242A2BEC2E;
	Mon, 20 Oct 2025 04:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JcQj5RPH"
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF1B92BE035
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 04:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760933985; cv=none; b=Kh4fshJ40kl2Z176ZNMvJw6ZOwsFvaxWiXSEC6+xlbu00IaJfSeTUeWbwMPW+0NyHXvzupBgwR1mZLK2/WNhsg4PNvQsObjhNIwHptO1mwlzZjm0YP6DxnGX7321H+15GF40PD2gHZAOtR2Fznal5hWM49igDRzXN12Vh0IVefQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760933985; c=relaxed/simple;
	bh=s3zAr2Lw3rD/hCeK/LxHqHkhg0wpepJJnQXf3fhGEoA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Aqy0pEGQRan4jKZ2iiIuQB6HCBLbOrQiHDl3nveqd3KDbiERdOq6S6ozy6L7Wy1X48R6lZaL21lO+n2ahiLsJnB2xMuxOsg34ABbfeq3AKNobTWE9+gS8Ejhw6/0kuIdf/3FL6X5eZFFSAPsKZp991HfqqvDICB7VXq2c7YlwwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JcQj5RPH; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-7a23208a0c2so1068242b3a.0
        for <linux-kernel@vger.kernel.org>; Sun, 19 Oct 2025 21:19:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760933983; x=1761538783; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SWRlJEZdwGAnIwAauINa4R3cyyZ8Vt+QqKXF4C/l9tg=;
        b=JcQj5RPHWujfCC3Vp3fxckb+Z4suvrkwe0eRJnBjybmx/djHhdLKufoBCTJ734JnV6
         09GsMfB9w4ctiYupw/N0rqoc23WL4Apmt6LxrAep/nJVxPSdSL5Ogkx8w0i0ReUf0Zm/
         Nmz4/H+M5/3NG4e7nrBZA0BVlRAI9u6UNhRawC5F8YZSEgPbEAhzJhd/oWKfSH1QhI2h
         f4gBf5fTEvXUrK6z30qcf8fSmJcRaQ6e76V+dA/khkxx4A/oMQbjUIywZMYsbylIZsc9
         29BQLt+soP2q2WBQclaUX07ufads66uxz0J30BpkJVzmjAyeR9dThWlv2dD5VcEiSGuF
         pMzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760933983; x=1761538783;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SWRlJEZdwGAnIwAauINa4R3cyyZ8Vt+QqKXF4C/l9tg=;
        b=gpoFdE0E9b7XapbK61JHO24cmIelYRkixWCwu71QvUsmXFyzlBBEc4WrIe7x1Mmd3W
         TG2C7BuHEKWF4zzE1c2Pp4+jJZYIeEuURAKZe4toYN4xVeX4DVC7KTkr20/2YqrwF/rY
         NM3Y11QFVf7moFolHztO7kamEkYYsaRlb2E1Lz6HuZXZMxHoVjk6U02hfgYHGXXoOWqM
         yucdtBQ2uHt8aWav294Ag5uiGMPl4bJvwseUkWs0fsAbLlXf9d5xkXQvFKPsysLpOjXQ
         VDPVT6UPqCu1j60zcDXFaaqi/o5VJxX2AWSmYubGJVHX6Gho/TAeVm+zYhl+upQTOeKN
         jQ2A==
X-Forwarded-Encrypted: i=1; AJvYcCUQd4dxOA9yqOZqXPOW/aEgcAYmFPJ7Hs6Y2UWsELLFtVDa4o0960QIM8zwCYuuakB6SiuQmguquKivGJc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxs/eQqwn34MJ5aoLJf9rjO7eym/l5khiKLB38AwS6tnxxuM7lU
	CxOgL/EueTtafWm5OlzEsMYF57U15sWSG+7B4B7m7ynJC168IYvZb/89
X-Gm-Gg: ASbGncsQ7ASHJ2+hqoeY27i5pVBYwZKjgkVo0IX9aAYu9Zw3RzAklO2pNtYtlAx2EIb
	7ub8pXXSwLBpKKFp0rP5CL84YjeMTqeHm2JctqzXYV3pXpSgIV7fnmFU6+kylADx6iZsRGIGaNu
	uhaNfEsi1ygu4rSBGizaX+YATJ3yKEpTqBh5RepA2uazU4Kg+cRBY+9fy/gIWiEdPxTfVxtmWLU
	MhX6Zprtw39c4OFZHoag3d/az183cOH/FojwGx1YGcAShY+KWzIIfsvlxUc4gDmwu57gOy2Opgk
	VXPmT8iiZ214vHtZq8EklRuQQTdlBZIU+ZpVdJO+prdgldFXE7uu3uSlB+JdNtRSFY1oX/BdEoW
	wPRncAGkls4dkZ1aDqGa91zHhMaulLjlZ3FtA2zKlfxMk+CzBWrOPzRrEVviPiQ0YcaXC4Ox1ay
	Dx/hOa0IOH47ZJmw==
X-Google-Smtp-Source: AGHT+IFgXTzodinLLkmL+sZBQeQk+ymkQXYFzmC5F7odb2hPBu8wYY31SZhor2FAQq/w5Rr23U2jYA==
X-Received: by 2002:a05:6a21:6da8:b0:252:9bf:ad9c with SMTP id adf61e73a8af0-334a8629f82mr15461749637.51.1760933982959;
        Sun, 19 Oct 2025 21:19:42 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a2300f253csm6975121b3a.47.2025.10.19.21.19.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Oct 2025 21:19:41 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id D938941E481B; Mon, 20 Oct 2025 11:19:39 +0700 (WIB)
Date: Mon, 20 Oct 2025 11:19:39 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Baoquan He <bhe@redhat.com>, Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build warning after merge of the mm-unstable tree
Message-ID: <aPW4W8cmRS9w3lpw@archie.me>
References: <20251020134517.795a133d@canb.auug.org.au>
 <aPWvfu5MQROcWKOf@MiWiFi-R3L-srv>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ACjYVYqtsauwiUs9"
Content-Disposition: inline
In-Reply-To: <aPWvfu5MQROcWKOf@MiWiFi-R3L-srv>


--ACjYVYqtsauwiUs9
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 20, 2025 at 11:41:50AM +0800, Baoquan He wrote:
> diff --git a/Documentation/admin-guide/mm/index.rst b/Documentation/admin=
-guide/mm/index.rst
> index ebc83ca20fdc..bbb563cba5d2 100644
> --- a/Documentation/admin-guide/mm/index.rst
> +++ b/Documentation/admin-guide/mm/index.rst
> @@ -39,7 +39,6 @@ the Linux memory management.
>     shrinker_debugfs
>     slab
>     soft-dirty
> -   swap_numa
>     transhuge
>     userfaultfd
>     zswap

LGTM, thanks!

--=20
An old man doll... just what I always wanted! - Clara

--ACjYVYqtsauwiUs9
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCaPW4VwAKCRD2uYlJVVFO
oxZAAQC5wdKajBQyJLJrs49+X5zKeEvwkgxMr8ESkCVYMsSVSgEAxXXgFHFvTKqT
iDSaU2Ad2+9Xs1jakCfqypLctL5sKQg=
=jxQm
-----END PGP SIGNATURE-----

--ACjYVYqtsauwiUs9--

