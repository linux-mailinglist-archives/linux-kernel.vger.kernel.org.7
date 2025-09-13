Return-Path: <linux-kernel+bounces-815168-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 67D4EB5607E
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Sep 2025 13:30:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 921DF1BC573E
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Sep 2025 11:30:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39AA22773C9;
	Sat, 13 Sep 2025 11:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PYQRnEbH"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 103F7284B42
	for <linux-kernel@vger.kernel.org>; Sat, 13 Sep 2025 11:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757763016; cv=none; b=opu3UMMdJWdH5LiCqCNyeRrVzJEu4Ts3QcHcYVNQVRIZ8psbLAAl5uhxI2PaN916IfdNXmOtkQJWQyk5hUNLr5e2yqB76fcdSrRT0MZjVdGZnGB7pyD86S7mvGpS8aqSNMRXiIMCq6yZSTQgu+YuyLiQSttnTTiqqceSYJrDxT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757763016; c=relaxed/simple;
	bh=x7djyqcnacv1DN7MFD9deVtmkZvxAh8dRtXGYaZoXno=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ON8upZbej6a6fzeYYdF/O/iSKcwSWFf6eM6ABtSBRPOXf87z+57Sh+swJEx7q6vDMrbnHLbjecbePu5L4gRpQk2MrfCivmkQtGg2edaak1HGCvTUWqWRA9q8B3m7j7qcrJzuQm2FVixuUH66f8e0qjCNunfi7VhuigOLctQzpU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PYQRnEbH; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-b0473327e70so461685066b.3
        for <linux-kernel@vger.kernel.org>; Sat, 13 Sep 2025 04:30:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757763013; x=1758367813; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vM/wOHbGgB/+niDKSnNnlcAAPUzV0FZzOUIFNQXZ5cc=;
        b=PYQRnEbHjEe0Ti84EVD0gMk0InqJQo8jzCXSJTzExiUn7oSRecH4mkyXMGG/7pIXqC
         oMZSseshivrQIxS5uYjk0hQRC40BOmqWObm9uJhXfPV5qNfo9QDHSpaGfX0vfbLyUiA+
         2qxI2PNqKrOkGVSlWjT4MHShidtCFAPNYf1nZy5KMdztHdemkOi2Y1FO2knr6b08FK1i
         lwinu9xiHhRzy63+63hA6NwpFM/m8BALMkRheu18gsHi5y/2YApCpMP+zk1J9b7ewNqN
         st/qFh7pRoFx94QlPnautAFz80hX9PQafFzUSwf597yMts2mAMfrnrKZB4Q36QwbCpa7
         5byQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757763013; x=1758367813;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vM/wOHbGgB/+niDKSnNnlcAAPUzV0FZzOUIFNQXZ5cc=;
        b=VeXuM/pfAvgT34uOKJqPL92Ts3MxgX0iT68UmeDoIEBopt9ynMOovtjfNwT8Z/KpjX
         hNCmzGkYxy4Us18uMRoI2R7mpVE+kexzP7fBMCGpXI35xKoeObLW0ZR/aLrjgMzqdEkI
         u0kwD09aCiK67XrGtDg6H+/5x48aHtbgBO6L855DPvS3KjHdIGMuZJrJUXft/HIbV45T
         5171ds69wgu72YqrB2afo4cktMp/7W6+pToyxyZkqRKp7u0sLl8yKMO3yWQinvwge2Cx
         /6ugwxmcyL8M0Z+uKkJwODoLFW1SDrWc5HXlquso4/JaLA2h+hCD9souFQvW5Ww9/LQj
         u7qQ==
X-Forwarded-Encrypted: i=1; AJvYcCWGTrvfWPgSytPwJw+5Mf7VgRLg+vL3wPpbF9dadAD0w6DTFCOwAXBJ/ncfzjl5X53cdcnB1yqVJPIiPzg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxjGo6JxE3xISvrv4Le4gQgCUYncsGkVBWrLddgvoqxhlh8bnc8
	xKvlo8Jy/TKEqcc2KiXpb6tazv5LcLdQtkBy3LxBdW1YbWhfUy6cmPbB
X-Gm-Gg: ASbGncsvoIsstGdB9oVyQNbjSY4YfbZEqzCc93fCh5l7ZAr5GnjRwdXOaz4ZQKXd3oR
	gW8aUiQe0HKoJhjTd/L9L1yH+Cy3wmiAAJZ7Hg/SW8ppFADf6Cvs2ZT9I8HT3hntzTXqaSASk9l
	xVsRwWvOSrMlPniidQGx6vGUtfh+Mqwhs4OSK4/NaN+ZDgasy48KR6oV/Jztzi/fqwg8bbFhoBx
	s3pNLrQjmhE8mKwqSRbdfJ5XQhn3Zlm0b/qWCTmQvUn1MtuL6tJFec4sUR5oVeKtQ4fxlRqQrWU
	QwP2tGw2wryASGiOiIJuTFHnxVv8DjIHC72hdtS3W7l/D7mVwTwzA1YMfOnZRHfmxHDvh1XpuGt
	FvMyFUWqgJUHfO2QVVcjeLKptJ3tkzV0AfGo61eHcZZwoRhl+tZ/nO70=
X-Google-Smtp-Source: AGHT+IHGrkQn7+NmuVgBdc10MUVOT+vd1j8NXgn0gL8ncYy9IeCu/BFaE0KTAPOvNiL0g93r6GOAgw==
X-Received: by 2002:a17:907:3f16:b0:b04:5a74:b674 with SMTP id a640c23a62f3a-b07c3a88730mr640143666b.58.1757763013249;
        Sat, 13 Sep 2025 04:30:13 -0700 (PDT)
Received: from jernej-laptop.localnet ([188.159.248.16])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b07b334e720sm551560166b.104.2025.09.13.04.30.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Sep 2025 04:30:12 -0700 (PDT)
From: Jernej =?UTF-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To: Chen-Yu Tsai <wens@csie.org>, Jernej Skrabec <jernej@kernel.org>,
 Samuel Holland <samuel@sholland.org>,
 Andre Przywara <andre.przywara@arm.com>, Chen-Yu Tsai <wens@kernel.org>
Cc: linux-sunxi@lists.linux.dev, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject:
 Re: [PATCH 1/3] arm64: dts: allwinner: a527: cubie-a5e: Drop external 32.768
 KHz crystal
Date: Sat, 13 Sep 2025 13:30:10 +0200
Message-ID: <6190895.lOV4Wx5bFT@jernej-laptop>
In-Reply-To: <20250913102450.3935943-1-wens@kernel.org>
References: <20250913102450.3935943-1-wens@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

Dne sobota, 13. september 2025 ob 12:24:48 Srednjeevropski poletni =C4=8Das=
 je Chen-Yu Tsai napisal(a):
> From: Chen-Yu Tsai <wens@csie.org>
>=20
> The Radxa Cubie A5E has empty pads for a 32.768 KHz crystal, but it is
> left unpopulated, as per the schematics and seen on board images. A dead
> give away is the RTC's LOSC auto switch register showing the external
> OSC to be abnormal.
>=20
> Drop the external crystal from the device tree. It was not referenced
> anyway.
>=20
> Fixes: c2520cd032ae ("arm64: dts: allwinner: a523: add Radxa A5E support")
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>

Reviewed-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej

> ---
>  arch/arm64/boot/dts/allwinner/sun55i-a527-cubie-a5e.dts | 7 -------
>  1 file changed, 7 deletions(-)
>=20
> diff --git a/arch/arm64/boot/dts/allwinner/sun55i-a527-cubie-a5e.dts b/ar=
ch/arm64/boot/dts/allwinner/sun55i-a527-cubie-a5e.dts
> index 71074b072184..e333bbaf01d3 100644
> --- a/arch/arm64/boot/dts/allwinner/sun55i-a527-cubie-a5e.dts
> +++ b/arch/arm64/boot/dts/allwinner/sun55i-a527-cubie-a5e.dts
> @@ -24,13 +24,6 @@ chosen {
>  		stdout-path =3D "serial0:115200n8";
>  	};
> =20
> -	ext_osc32k: ext-osc32k-clk {
> -		#clock-cells =3D <0>;
> -		compatible =3D "fixed-clock";
> -		clock-frequency =3D <32768>;
> -		clock-output-names =3D "ext_osc32k";
> -	};
> -
>  	leds {
>  		compatible =3D "gpio-leds";
> =20
>=20





