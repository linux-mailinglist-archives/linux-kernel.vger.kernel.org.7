Return-Path: <linux-kernel+bounces-858690-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D316BEB6F9
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 22:02:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 93AA61AA734F
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 20:03:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A343B2638BC;
	Fri, 17 Oct 2025 20:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ndufresne-ca.20230601.gappssmtp.com header.i=@ndufresne-ca.20230601.gappssmtp.com header.b="VV1XvIul"
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3604233F8DB
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 20:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760731361; cv=none; b=m7Yo7Nh5oetC8C+aPD++xpOrqjkAlbfThcEmQS0ki2gvxpndrAhP7mdzraNwlb1mgJJaBD07mfkbIYob3P1/zsi6htJQpUyDkjqpZNM4RBsGjZDD/xZz8q3utQ0BLuB6GvqKqs/YMUTlULEGEiOVZJMquC5E0nmTj+9cRWrzylk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760731361; c=relaxed/simple;
	bh=YEmcixcro8qq5jyMdQ3+GPIbFdsNJT56ZX2qwi+396s=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=COWxxfa4dbtCWhPB65HvfMXTT65V2tUqDoayO1BXBJFzCn4DgKbbZBs+JGsadFWuRrw1VDQ8kvZbuGZDx6qZt8ZvI+xhi1+6aTIE+oFLahgFe/E4/t3Po7fdKOOzo4ePhpffd30ahykikpekzNvghzD6meA6T2l7056cwM+IKKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ndufresne.ca; spf=pass smtp.mailfrom=ndufresne.ca; dkim=pass (2048-bit key) header.d=ndufresne-ca.20230601.gappssmtp.com header.i=@ndufresne-ca.20230601.gappssmtp.com header.b=VV1XvIul; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ndufresne.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ndufresne.ca
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-7ea50f94045so51155506d6.1
        for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 13:02:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ndufresne-ca.20230601.gappssmtp.com; s=20230601; t=1760731357; x=1761336157; darn=vger.kernel.org;
        h=mime-version:user-agent:references:in-reply-to:date:cc:to:from
         :subject:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=J2tuttkyULuzLdFnQ9MtmS6DjBEIf7L0xEYqV2T+pNs=;
        b=VV1XvIulPtxO17/390LOp7rnC5kYGHLIF1e9gGzKuMqTUG0mfDoMFYjoFWqFF76IH4
         4Ac71YbDh59Ph/0pAUxCXrur7kz4LFILk/kwYG42zSPyo1uI+TMxzlOgj4EVwrceKAmg
         dCw9+F6cdfGm5ZLB1v8Rb1/bk95IK6G0EInPK10EcnPiOJjqEP/xVQYWAvMSPIwWjOYf
         RGS0UsCDHq72g4OeDTVUqEYOk7grJDIxftl13L+H0w27OYOUaz6V6OZRExsseL4NCwvt
         YB4cVIddo3OMNHXPx9a4Bq9bpI3I47TaoZb2BlCul8Xo+akzRToBfvx5YH1+xkcrsAEU
         bWcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760731357; x=1761336157;
        h=mime-version:user-agent:references:in-reply-to:date:cc:to:from
         :subject:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J2tuttkyULuzLdFnQ9MtmS6DjBEIf7L0xEYqV2T+pNs=;
        b=Lg+Qw+Uc++f473ENNnmpoXODdwtUUcBdKVWgY3o4XFQVzgu0s9THIM5kPoaXagYkg0
         /iwvh4iEwjhUUxCEgPaPiEXlW5lF0wdL8xLwGOCR1JpDVW0G+ncWSw7QhH2Wz15Wyvfn
         wyRcVIpZ9YZMFNeJ9TymkNZzG0m69evChrkDo0W/UcRviZIrya8A6UHAzBHrP+EpH6nS
         z0YBvaTZ2CI05RQ3z9X6UnZkJBuw6hn4A7l1knJOLxz2QP1RS46ZK8HRCehHoMGkIGVq
         THBANO/kXTijUY0De0KQYvApv4XD/mQjayPsHlktoFfcusSC2wVjUWcemNqXjDFvK0YO
         pPww==
X-Forwarded-Encrypted: i=1; AJvYcCXX93wrUl/aHmXmT9FEESSsgDDQlJ8StxosdiaIMehSt6Kf2OBp7x8Rz+eEZ5k2zrYKUH+PCeweilm2XpA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZVmgoafeKZG+9XVUIn0cOuIxtSlkFScStEendXFcfA6vb76Eg
	CIGBW3GXu5Cn/zxk0z1Hw5RukEUOy3eLYcWaRJKA4PSZQIdVjS1l3EOpHGlTpu8Z5X0=
X-Gm-Gg: ASbGncthPgnLsWzx8K0xzwWV6h/wUVThIVMV51PKKW3aFyEW7AhMfp4/koliPBV92Y9
	fEsapQ65FI9ygVv3FNU4eNINcm0Ec6+IidlH64HUeUlkaHEuCk1nI3cNqXYcSu93q+xxOh974W0
	KuMj7eqEB5q0DXAh7DB8nKIibn4xXcbtvGseKSwwAYbXxqm9JG8zuzMSHu7RapSWonx38VM3/Ay
	Y209rnQE0Ni9aKh0ahUMbxk6ZfdKSXSxZuaQv0FDpIOYmB3UmI21feXkjfCkL7fzeOWJ5cvUunq
	fq53Io9OusnbOGZaoSSDropMIlgsJ1Noh3SZ1g2f+m6DUBxgQVHnfCu367RuHhu93So5PQMzfO+
	fyaTQnI4lDEBVcY2u3r9A8QhKxBJONuNi0iVVflaVwwP1JVXmM6Goh7VXJIl3nV9q5moksJj8g7
	dzwnuWPtkYdJP8pXQYIEB7RVVdDL4=
X-Google-Smtp-Source: AGHT+IHSMUePxe/bPZ29PJJFlHHcFR6pMPe4oHFJ8eKH5Fc8kGyfOKlZkSlsIdgsAAbV4DdfW1pCaA==
X-Received: by 2002:ac8:7d05:0:b0:4e8:aaa3:8b6a with SMTP id d75a77b69052e-4e8aaa38d5cmr16697371cf.25.1760731356941;
        Fri, 17 Oct 2025 13:02:36 -0700 (PDT)
Received: from ?IPv6:2606:6d00:17:ebd3::5ac? ([2606:6d00:17:ebd3::5ac])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-87cf51fc208sm4660666d6.13.2025.10.17.13.02.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Oct 2025 13:02:36 -0700 (PDT)
Message-ID: <342257a17444d96eaaaa9392d157e85de679723b.camel@ndufresne.ca>
Subject: Re: [PATCH v2 2/5] media: v4l2: Add description for
 V4L2_PIX_FMT_AV1 in v4l_fill_fmtdesc()
From: Nicolas Dufresne <nicolas@ndufresne.ca>
To: Deepa Guthyappa Madivalara <deepa.madivalara@oss.qualcomm.com>, Mauro
 Carvalho Chehab <mchehab@kernel.org>, Vikash Garodia
 <vikash.garodia@oss.qualcomm.com>, Dikshita Agarwal	
 <dikshita.agarwal@oss.qualcomm.com>, Abhinav Kumar
 <abhinav.kumar@linux.dev>,  Bryan O'Donoghue	 <bod@kernel.org>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, kernel test robot <lkp@intel.com>
Date: Fri, 17 Oct 2025 16:02:35 -0400
In-Reply-To: <20251017-av1_irisdecoder-v2-2-964a5478139e@oss.qualcomm.com>
References: <20251017-av1_irisdecoder-v2-0-964a5478139e@oss.qualcomm.com>
	 <20251017-av1_irisdecoder-v2-2-964a5478139e@oss.qualcomm.com>
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-Urt5bDwGCibGgnCKgiP9"
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0


--=-Urt5bDwGCibGgnCKgiP9
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le vendredi 17 octobre 2025 =C3=A0 11:35 -0700, Deepa Guthyappa Madivalara =
a =C3=A9crit=C2=A0:
> Add a descriptive string for the AV1 pixel format to v4l_fill_fmtdesc(),
> enabling proper reporting of AV1 support via VIDIOC_ENUM_FMT.
>=20
> Signed-off-by: Deepa Guthyappa Madivalara <deepa.madivalara@oss.qualcomm.=
com>

Reviewed-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>

> ---
> =C2=A0drivers/media/v4l2-core/v4l2-ioctl.c | 1 +
> =C2=A01 file changed, 1 insertion(+)
>=20
> diff --git a/drivers/media/v4l2-core/v4l2-ioctl.c b/drivers/media/v4l2-
> core/v4l2-ioctl.c
> index
> 01cf52c3ea33e1a01e1b306036ba4e57ef5c95d0..bdfdf45c5de2f2ce885f219007718a5=
4b5c8
> 6251 100644
> --- a/drivers/media/v4l2-core/v4l2-ioctl.c
> +++ b/drivers/media/v4l2-core/v4l2-ioctl.c
> @@ -1542,6 +1542,7 @@ static void v4l_fill_fmtdesc(struct v4l2_fmtdesc *f=
mt)
> =C2=A0		case V4L2_PIX_FMT_QC10C:	descr =3D "QCOM Compressed 10-
> bit Format"; break;
> =C2=A0		case V4L2_PIX_FMT_AJPG:		descr =3D "Aspeed
> JPEG"; break;
> =C2=A0		case V4L2_PIX_FMT_AV1_FRAME:	descr =3D "AV1 Frame"; break;
> +		case V4L2_PIX_FMT_AV1:		descr =3D "AV1 OBU stream";
> break;
> =C2=A0		case V4L2_PIX_FMT_MT2110T:	descr =3D "Mediatek 10bit Tile
> Mode"; break;
> =C2=A0		case V4L2_PIX_FMT_MT2110R:	descr =3D "Mediatek 10bit
> Raster Mode"; break;
> =C2=A0		case V4L2_PIX_FMT_HEXTILE:	descr =3D "Hextile Compressed
> Format"; break;

--=-Urt5bDwGCibGgnCKgiP9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTvDVKBFcTDwhoEbxLZQZRRKWBy9AUCaPKg2wAKCRDZQZRRKWBy
9FtGAP9GU55FUgYIUK7UMe4RWo1rWcRc/rK/aIKD3lFJ+Tf72AEAyzhydjJDt7q0
d+DNRq/gFNH5HTnd8V7SL298V0H6TAc=
=gGm2
-----END PGP SIGNATURE-----

--=-Urt5bDwGCibGgnCKgiP9--

