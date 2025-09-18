Return-Path: <linux-kernel+bounces-822365-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ECC9B83A1C
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 10:58:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C6405167DAA
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 08:58:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D02B52E7635;
	Thu, 18 Sep 2025 08:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="B0QcICyR"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECA662F8BD3
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 08:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758185885; cv=none; b=loveRRO6oFji7C/Kp5KtDR2eJNgnBu/5BGr1BOM2BHBiabhxkzj2/EjicCwe/Hjl/dOLBR19H8TQCkWHuciDkTHSiU2TDDfjPg0aitlYmm4D6kviAMPEtqBnKikZCdSVG7lK7NKKoMeqgH3py+SWqbBd7SNagAExFUuR+zTRhU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758185885; c=relaxed/simple;
	bh=/PYnZTkZG30EJGZkQy0B+vpJnkbqnXRnk+m65H+ZaNA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Am6+YPKUcwhUCvQVUuxAwRpe4d/e1wZpF89WJL7OrX650sNqCcF5xVdasoiqf9cbaDeuNeAb4Kg6ZX3U3TIp3pXSIATx2YdYt1GYXDahO0Li/TIgDuhZVINzNwn0fQrWqNI5G8baExHli7b5HHx8H5qLbdigQDoVPUIv/AS27ws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=B0QcICyR; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4619eb18311so4453795e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 01:58:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1758185880; x=1758790680; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pmEt68RRoB+wd57eSZ3i30ZBtY+HefiEC4Icljd4gvI=;
        b=B0QcICyRH/l4XzZWHMeHrtTnt53GjpgN2HBxCWsLIQvlYouenlIwyxJdTrVOy6bX9p
         IQPQo79kv20yaZk2Jp11gdwXzm7/eQiO75xDgmKFp85sphy+DWWGjd7qNGAhJzLruFwr
         vpxfsN8FxfmNoJsqzdBnA5t2n+4U2lDUZA1r2de9Y1pM7Y7T9x9DUeKdgqvuFLgsTvrB
         YdVkaqveeFL+++Zx60ujDfNzMlNwzzV0KoYlAVB6bc7lcoJRnkIuLw7UbV2Y4VTcBlQA
         XXXBoHpiBB7DDY/tMkigLf2bTLeAwNKOJOXUkDo38ap1QcISfHzoRWelIgB/qSWnAixA
         eZYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758185880; x=1758790680;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pmEt68RRoB+wd57eSZ3i30ZBtY+HefiEC4Icljd4gvI=;
        b=WrZXy/+BU3s8cy2TvDC28gFxn0fF1zS2s9xCeWk0OFZO4sD+1oXWCN250Q3XZ7KtRt
         5D5dQigGAqt+0RGsa6IvxAtgeoy/FUixoqMxTyJ8KKP7I8tZ4T/zhKRrjpJE3Bj2kw2z
         x5Oown1xxMAGj75dFaQtKTtAES+KTt9FIwmlDLMTln06fZ2T0NUnhav8/ehDqnG8a1oY
         6FC/E8Ax+GzxvX9euGQ9vLKB6/L0UXTQKkSHK41FicXdDvoE02Y95rGua3MXjdwvZ+6D
         BZxvf49Hv15VRGz7YvZk0tTWYh8YLP0c6s3IDyrtupx90UaCv5Yx5a7Js+G7+KS1IJRJ
         Pc2A==
X-Forwarded-Encrypted: i=1; AJvYcCUTn4u2x1T28QDBMQdzGmc55Wm1c7NFKBUf0fKFvd2PiSTBPQJ0tU2c3kZJXvVkg+zDDXSYIsPC4+E7Gu4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCy3+oX8jvXmOiVaF8kQKit1iO4wpiQeiA2sD0DAr7mMA+/iA5
	/5OLHEsK41Wvmas1wLU47WsA/vbuCfgvwk+e5LDCjYz3rskPVsYTo/rNLwBzqY0kYQc=
X-Gm-Gg: ASbGnctQiuzc6J9ncjdcNNcIezGdA+gkhkj6hOk+XqqJ8m27+m6Yll6lT+VIjxNWjSs
	KDLxOdYeD/+lYdztrt3OqdjfkM/yqxdEhkwy1fLrdA5C76NAuePDDKzyKEmU3LJDFPnbs7HpUwK
	eTKvIJGALfZ5tYtvQWgXTzdXYRvapQq7n+SqZhFmi16+ZIjg7tiN/NFsz5ogbRZazyLb7pGOoBe
	IkFKXG4ooZfOuXudRl8HcZygqDpCeR+eUuKt936rwoJ6GRDEVUmiuXyqCdQFEsZojCLxlJb6YqZ
	VGBzMrZ4AaojjX+jZ3/iopIwZm7iI5g8dyg4iKPOlqDBMUiSIPma3lGpNmtI48HHrzWlyNkVqXz
	nf6ZMwGWwRk84SXlU5khvWXTpRXTO46pJxbtGleF+MrNyE5ZM593/FZG0d3Bw9CIEKgAu3IX9V0
	ppoSHOPsA=
X-Google-Smtp-Source: AGHT+IEPNIa6fkNRCUJ18lBtEgyz/AhKS+iFA/LDaNtIde2Og2VBavczJaF+qUErWN+CRoWjhTjEyA==
X-Received: by 2002:a05:600c:470f:b0:45b:615c:cd2 with SMTP id 5b1f17b1804b1-46201f8a4b9mr55194505e9.8.1758185880114;
        Thu, 18 Sep 2025 01:58:00 -0700 (PDT)
Received: from localhost (p200300f65f06ab0400000000000001b9.dip0.t-ipconnect.de. [2003:f6:5f06:ab04::1b9])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3ee0fbefd5csm2895856f8f.51.2025.09.18.01.57.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Sep 2025 01:57:59 -0700 (PDT)
Date: Thu, 18 Sep 2025 10:57:58 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Thorsten Sperber <lists+debian@aero2k.de>
Cc: 1111027@bugs.debian.org, Thomas Gleixner <tglx@linutronix.de>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: NMI: IOCK error (debug interrupt?) for reason 71 on CPU 0
Message-ID: <2pdp3kq4qebdxizprbnaq6omh4dvxdlktokvr37b7nlkf4po3b@fxzmgmi47wxx>
References: <tfwuhg7fxlvb3iix2k4qqh74dcmwgcipprlehy7zlaz3btmtym@2x2vsccw5yzs>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="wwf2na3ggz3ik3cv"
Content-Disposition: inline
In-Reply-To: <tfwuhg7fxlvb3iix2k4qqh74dcmwgcipprlehy7zlaz3btmtym@2x2vsccw5yzs>


--wwf2na3ggz3ik3cv
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Subject: Re: NMI: IOCK error (debug interrupt?) for reason 71 on CPU 0
MIME-Version: 1.0

Hello Thorsten,

after writing the mail to Rafael Thomas provided the idea on irc to test
using

	intel_idle.max_cstate=2

(or =1 or =0) on the kernel command line given that the splat hints at
this happening for C3.

Can you please add this (with =2) to your bootloader and if the problem
happens again, tell us here and reduce the number further?

Best regards
Uwe

--wwf2na3ggz3ik3cv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmjLyZMACgkQj4D7WH0S
/k4Nlgf8CTeOR517VNnBhWurEM5MvPOVJA8+E7xY6D88IqaHQCZUI+noiuKO2pZF
zNIAqWA2RM54RGqRe5f2xzw60CVnbUogYdxCj7hK+Zpkw4ovs7lBbhpUExVrHhsu
H39uZcaQAuzmh7+L15BGeKD+oJBgaqT1/VSIIMu4vJftSe00ifUXgIWcblj31a2Y
WPC9nVxE7w1Tj7p9GXM4bF+53jm+pIJH+G+4l1qws1xR8RF32F8o1n1Cf0ZkNAc0
LpbUn1l+C9RPfBh+J2/49s+gpXRaOfEnjPa8zizfGtQqawcqENU1LHaemtQBQ9bp
/d5DPDyilwgrolQNsQcihX6DT0dS3Q==
=AKKo
-----END PGP SIGNATURE-----

--wwf2na3ggz3ik3cv--

