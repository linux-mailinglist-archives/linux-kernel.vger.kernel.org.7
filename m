Return-Path: <linux-kernel+bounces-627042-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A7C12AA4A93
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Apr 2025 14:04:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 471EC1BA35DC
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Apr 2025 12:05:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C2F7248F51;
	Wed, 30 Apr 2025 12:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="YqZc4dGS"
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A21961E47B4
	for <linux-kernel@vger.kernel.org>; Wed, 30 Apr 2025 12:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746014686; cv=none; b=Gart6OtT/mVQVuAlSgIYCSLEMCfQCk14H7yI3Fu1Ig7tkEh4bkW6t6dEktsh+cXWfvkO4sdGKfiihQhrseeXbAi233/hWQvjL8uExUx6qSP12y5z9W2T/f8Lb42AFcPqhBIvo+wh5MZJZIKIA6FIAF19zVZ5l3COpoK+et8YxMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746014686; c=relaxed/simple;
	bh=G+5FibWWWLvg7K1gCq7/ZEbzCv/dW8PKVC/LnlsXxO8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oI1kgghXLQ3rOWYB5zxaHMBjY7gs0t/M9/AwCevk+q2HaqxhGuCaWr0gIkcUv9Fwa/bZwWacRzsrVcjyXoSbztUGnFem1BLq9jGXsuB3NTdvQrf29mV2CYUNo/HjGL1m5XTkQS3GXMs4DJaCxTsTk/wi0PI2kFwHdXcufDnaJYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=YqZc4dGS; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3912d2c89ecso5479616f8f.2
        for <linux-kernel@vger.kernel.org>; Wed, 30 Apr 2025 05:04:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1746014683; x=1746619483; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=G+5FibWWWLvg7K1gCq7/ZEbzCv/dW8PKVC/LnlsXxO8=;
        b=YqZc4dGS9JJgicN7LUwJ+HOvDnQlEuN4fYj3vIXp3VefP+jYaWIpJWijMiC3e9xs+E
         zy7EcmUSCKSr2+0jl4UbswxesvLHQMllLruXcOmeY4rz8cbhobj6nIPe7fj69tgnjVWi
         axp31JY41LE0uNJwZSBsUL79c0wsRr6bQXSEjSEeJA5Er2EuVh5kYTfCVjnZbnDfjyDE
         FPRJBPHPWnlr9VrVlS7x0ZDqkDl8JOd2wn4dXJovfTe3s8VbXOanf+NcmBGEw/WYADs1
         Uwpw8MVmSsbJGn98M1GuJQWffK37898z58OA6/D24LCax2TkDMA3BlfEC7RnFEfEJIH6
         1w7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746014683; x=1746619483;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G+5FibWWWLvg7K1gCq7/ZEbzCv/dW8PKVC/LnlsXxO8=;
        b=HMjrS4mUEEdfbhBWYvAz2GDpCqWKQmkKZrzd4naXeYX1x527C7PaV7eNcx1jPt+SYe
         81utoD+iSC7SLjKtcBoS674Ln45q0Usf6ZsN8tAb48N3XIX1O1mbCdJf8MLcVhau+7mD
         cSUdpSP1ZJ11e06Eu6Nj4YSYoyTDwCFXTWGg4Gaf/UEyjJJNbCFtnIGLhy2GJnCs+klE
         i5C9r63AGQbkwkrUK5uXY1NPeGqYTTRZAF0RUncKatRCEw3J6HifYqKl8ot0H/ucTDDz
         ZSQ3YG0zzFUa5EFHmXXc4aj5OUkiI+6Sl2pxc/ZMIb/wHqrTQaX8QOrC9hgR5SoOkITb
         RjHA==
X-Forwarded-Encrypted: i=1; AJvYcCU8wNEetMah7f4zKhJ+rW/r023dwFiH5OKlO37DGt1PWy4jGBXC5dI0uoH1dyo/7WBJxZYmAQ7tX0aMcx8=@vger.kernel.org
X-Gm-Message-State: AOJu0YykDAPk+5NB31DaYxhF+B9GhaNfgJU6S8kOqUf84mjeog8207Pq
	oqNj0lK48NjAeoIr7u6D6IE79Amad7kTZe71qA8hxtDiY7zS5cFYETeWNz4mw1g=
X-Gm-Gg: ASbGncv8w6K5SXkYzNKg+5UrrDSmNZMSuv0G/Yuryc3vfUownYYGMVbynhr0Yl0FEZV
	I46hD7PE31TsNl139RTDroaVRKKwjwXfxGcSankAuKDGVwr4q6fmLzji5ldX/4vvwhPiQNEjFbW
	IOyK+4yeiQyNqqrs7hcot9lwhN4fODbaQWYJv7LQ+QP82D8qO2CCRoJgKTE9u4QD2m1sVit+Zgx
	0VpxX8OsdKjplHBp3IqMJjgNHJ2b001MbCYjVcgRjU91Vs/0B4oyshp8ERiZPG3e0bj0UIPUPur
	K4e3tookfHhgy7BJLkq++iVJicWE7SesWhZczQUNNHBW13HhFOWBudWKXziqw5x4IjZLwvj2X9+
	AecoqG8aMQUAqDJxEqw==
X-Google-Smtp-Source: AGHT+IGd3vdiUTiLVBgnDR5dqhZhw5L0hduc6PSmeXt0yr8SkjJ5vxlE0r/PJfRQd5VE73nzXn2pcA==
X-Received: by 2002:a05:6000:2510:b0:39c:12ce:6a0 with SMTP id ffacd0b85a97d-3a08f764e8cmr2752357f8f.21.1746014682794;
        Wed, 30 Apr 2025 05:04:42 -0700 (PDT)
Received: from localhost (p200300f65f00780800000000000001b9.dip0.t-ipconnect.de. [2003:f6:5f00:7808::1b9])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3a073e4684csm16797700f8f.76.2025.04.30.05.04.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Apr 2025 05:04:41 -0700 (PDT)
Date: Wed, 30 Apr 2025 14:04:38 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: linux-pwm@vger.kernel.org
Cc: David Lechner <dlechner@baylibre.com>, 
	Kent Gibson <warthog618@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 0/4] pwm: userspace support
Message-ID: <suxk5xq2qcr47ltpi37ynh4hov5ppyptwg3q2zpqqbsegz7m6k@r4yrog3uzgby>
References: <cover.1746010245.git.u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="p7s4k6i3ogher2ir"
Content-Disposition: inline
In-Reply-To: <cover.1746010245.git.u.kleine-koenig@baylibre.com>


--p7s4k6i3ogher2ir
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v7 0/4] pwm: userspace support
MIME-Version: 1.0

On Wed, Apr 30, 2025 at 01:55:57PM +0200, Uwe Kleine-K=F6nig wrote:
> after the feedback I got from David on v7[1] and some internal
> discussion here comes a new version of the patch.

So given that v7 was the previous revision of this patch set this should
have been v8. :-\

I hope all the annoyance that results from that fat-fingering is on my
side only. Sorry.

Best regards
Uwe

--p7s4k6i3ogher2ir
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmgSEdQACgkQj4D7WH0S
/k6sMAf8DX1WYTAxw7X5OV77oIWpx/9jKPfbrbgkR3iu2ak/bjGZ0oJLf67jjl5B
pUTToSA88nqW3gvlSGnlnipvncX+lPFDSq4jmj8+tAQR9KAvSwG0bLcZVW24q9M4
Z6SY2xzmI7yCZto9qRpZQASSaly+ZTUd5iRfZmLTkZVLv8dvP1+/hAncjT3shr+l
WaRqg+KWbO/VB8I3D/e6XLm/77+mWx2Qe8ne9vKkzElR2MhrnJtgX3HGtfo8Skn+
fsUSXMiRu2dh1rRPxl81qcjT4hLHagLB6jAfp/Qf7czTfcn5zjZPnaczbuEXSwMd
S/ILPPAnLYdpiGvEB6a1d5bEdgOjOg==
=L/3N
-----END PGP SIGNATURE-----

--p7s4k6i3ogher2ir--

