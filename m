Return-Path: <linux-kernel+bounces-858082-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D0070BE8D49
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 15:26:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CFE216E2AA5
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 13:25:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2B10350D41;
	Fri, 17 Oct 2025 13:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ua+b4fGY"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53252331A67
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 13:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760707547; cv=none; b=Fq2dVLw9z8VmkfQM+Xt55YzNVL2vQecklohU8dIs8Oy1nawxo4avq+nnC/NQsBSfSSsIwId60aisdys5oDHHyd23qBbjGG9ZzMrXGVBErDOUA51CcwrsSKsokvWyQXhIaTAyoAPj2jrRqSBPp4lS2IV+o4jpk2+MUt1oiIKOcmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760707547; c=relaxed/simple;
	bh=uSudNl+x6Xd9KAcDN+w65zp9X1SGg1eAjeVmyvdpkJI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=j8R3gUDsxqftknYMjIYx9UMvSoZUbWDsYdO0VUPt5hdiwsVC/bbJQfzkqEHZbJA5biq2tRkDCJ/n3nMo7AP7EtcOQeCuB8e2faoz+ibEHCjyMrJtTJWDRiB7VaIVmBznJJKCkLwYA02wHtaQKz/l0e9MF862mB32jX8lShyXDb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ua+b4fGY; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-46e3a50bc0fso14805535e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 06:25:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760707543; x=1761312343; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=K8lM7ZvUp1zMap3psFDgRuhP9QwjcdKf1uYP4pIRPcI=;
        b=Ua+b4fGYoR5K+ZC9JxJYlVCgD+JJqB/rKOeti6faznbQPiJ9kcY08Wf9PxWFHJgaj2
         oUelSQ8hcff8sYGhYugk8QaiaVjNGiiJz+DQ4CA7H+7yz0q/qqkT9UWtpGMlstWk20GO
         bMK2oGCkmLOWM3FA1XNJMvyBhlGUBI8C8daVcZ4Wg8PB2N4D40E73WKi3+9SuCHNAO7Z
         C4GFSaBnjgslN6iKwXvrhSHGf6RWKWLc/RjulCFXlg5xvPYdRePt7pSHuhjh1sJWOl+l
         i+lF+OIe8PL1003sSMRokG/A2NdzVB8ATtKBCJ7DH3pM8pjEYjhqrx9mwvro6VmDcTrl
         SdBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760707543; x=1761312343;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=K8lM7ZvUp1zMap3psFDgRuhP9QwjcdKf1uYP4pIRPcI=;
        b=R8niWeqaFAjMKTFoSSByecMGJ8kBh/2972pNZm8b4FBNlWzFUQbF5K97My0wybZQ0b
         VSqx5WjrOVJzC3JOk1Jbgz+BirwPAVbCJSxPvv+2BFW/o1tJ81X5gri81ZvjEEXT/lKj
         3GXVmWbwBbIIcjTndb/Jaa/oRQSeZG6GJXYqxiqEA1M1fFd8RAE5FtIsE/Dgh5j04kEv
         EWIM1nvLdaj3EcjcH7R1AddVr2kO4BCh4zL+2LDZgxgnH6wc/38Xw6JYiO1p1bI3hrj0
         dAnZzbeV/ry159dJjPSrCs+KFmc0z2xRCTSQAJmOii54aOWiqztVBF0UeKEiZBTczCPt
         svqg==
X-Forwarded-Encrypted: i=1; AJvYcCWAGV7DYgCxERGMPjXke/Tw0YkbvojJudpYx9vvKvN7mMKFm0XsGQHFbb3x6bo2wOcTMGSHP283+68r7PM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2y9OopflJ5z/eT3lPZmMFda2shLEh8P374lfGbAczbBoZV4vM
	sus0Rr3GjNN2qhO3lEOPCl60eWCs6C9bS9ZLMEokQDgZELgRwIP3lilJ
X-Gm-Gg: ASbGnctgxzKkseC+VX33kdLV9ucFo7LWnf6YYlYYEstOPSxb8LSr7o543xf32pJT4uw
	us3PArvYRgn+zULmvBIdMVp+v3QqD2ND9p8fHOfsZjpBJVXlLBqlRvE7qqmeZ/WS3zNvI68j2Kc
	GKVvBIKSUo5T2Ay/Tk8V8SwEuEiyJ0mHDaFXopEx/fYL9unAbgU+JIEdT7SYvLStQeoRIy78oVd
	N7YJGIbhh5lpEQ/1SSFTf3qJyL4HQtE+dEEOM9knmw8KV9glmKq4wMELUO68MiQc1U+laXmLpvP
	hCLaXvEtLRzcPgOnplGAOWjWgSMjPCDa1+so5Bd4+vIbq0ukRD3QRJnA/XSc8jCAmBU+C+0eaHM
	aI5RDcozl3LtG+IBa/labeJcLzzvoMBILY/yQoXkJr/NoVBGsN55Q2WH044yzhMay8v/qs2gcJs
	8LHaz67Dyt15D9bJ5dL7kSy1Yui5pB
X-Google-Smtp-Source: AGHT+IFMdil7b1DloC/aeqld8spghixzfaWyFDKRDf9hEI4e+WmQl+joRe2vmtjhz2LmX2ADYNftRg==
X-Received: by 2002:a05:600c:474a:b0:46f:b42e:e39c with SMTP id 5b1f17b1804b1-4711794902dmr26568555e9.41.1760707543361;
        Fri, 17 Oct 2025 06:25:43 -0700 (PDT)
Received: from giga-mm.home ([2a02:1210:8642:2b00:82ee:73ff:feb8:99e3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4710e7050c6sm51417735e9.1.2025.10.17.06.25.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Oct 2025 06:25:42 -0700 (PDT)
Message-ID: <d6bd466a5d11b016183db0ac3c25185fad3036fc.camel@gmail.com>
Subject: Re: [PATCH 1/3] ASoC: cs4271: Fix cs4271 I2C and SPI drivers
 automatic module loading
From: Alexander Sverdlin <alexander.sverdlin@gmail.com>
To: Herve Codina <herve.codina@bootlin.com>
Cc: David Rhodes <david.rhodes@cirrus.com>, Richard Fitzgerald	
 <rf@opensource.cirrus.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown
	 <broonie@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski	
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Jaroslav Kysela	
 <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Nikita Shubin	
 <nikita.shubin@maquefel.me>, Axel Lin <axel.lin@ingics.com>, Brian Austin	
 <brian.austin@cirrus.com>, linux-sound@vger.kernel.org, 
	patches@opensource.cirrus.com, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>
Date: Fri, 17 Oct 2025 15:25:42 +0200
In-Reply-To: <20251017083232.31e53478@bootlin.com>
References: <20251016130340.1442090-1-herve.codina@bootlin.com>
			<20251016130340.1442090-2-herve.codina@bootlin.com>
			<60fbaaef249e6f5af602fe4087eab31cd70905de.camel@gmail.com>
		 <20251017083232.31e53478@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.0 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Herve,

On Fri, 2025-10-17 at 08:32 +0200, Herve Codina wrote:
> ...
>=20
> > > In order to have the I2C or the SPI module loaded automatically, move
> > > the MODULE_DEVICE_TABLE(of, ...) the core to I2C and SPI parts.
> > > Also move cs4271_dt_ids itself from the core part to I2C and SPI part=
s
> > > as both the call to MODULE_DEVICE_TABLE(of, ...) and the cs4271_dt_id=
s
> > > table itself need to be in the same file.=C2=A0=20
> >=20
> > I'm a bit confused by this change.
> > What do you have in SYSFS "uevent" entry for the real device?
>=20
> Here is my uevent content:
> --- 8<---
> # cat /sys/bus/i2c/devices/3-0010/uevent=20
> DRIVER=3Dcs4271
> OF_NAME=3Dcs4271
> OF_FULLNAME=3D/i2c@ff130000/cs4271@10
> OF_COMPATIBLE_0=3Dcirrus,cs4271
> OF_COMPATIBLE_N=3D1
> MODALIAS=3Dof:Ncs4271T(null)Ccirrus,cs4271
> #=20
> --- 8< ---

that's what I get with SPI-connected CS4271, and this is actually what I'd
expect (linux-next as of 2433b8476165):

# cat /sys/bus/spi/devices/spi0.0/uevent
DRIVER=3Dcs4271
OF_NAME=3Dcodec
OF_FULLNAME=3D/soc/spi@808a0000/codec@0
OF_COMPATIBLE_0=3Dcirrus,cs4271
OF_COMPATIBLE_N=3D1
MODALIAS=3Dspi:cs4271

> > If you consider spi_uevent() and i2c_device_uevent(), "MODALIAS=3D" in =
the
> > "uevent" should be prefixed with either "spi:" or "i2c:".
> > And this isn't what you adress in your patch.
> >=20
> > You provide [identical] "of:" prefixed modalias to two different module=
s
> > (not sure, how this should work), but cs4271 is not an MMIO device,
> > so it should not generate an "of:" prefixed uevent.
> >=20
> > Could you please show the relevant DT snippet for the affected HW?
>=20
> And this is the related DT part:
> --- 8< ---
> &i2c3 {
>  status =3D "okay";
>=20
>  cs4271@10 {
>  compatible =3D "cirrus,cs4271";
>  reg =3D <0x10>;
>  clocks =3D <&cru SCLK_I2S_8CH_OUT>;
>  clock-names =3D "mclk";
>=20
>  ...
>  };
> };
> --- 8< ---
>=20
> i2c3 is the following node:
> https://elixir.bootlin.com/linux/v6.17.1/source/arch/arm64/boot/dts/rockc=
hip/rk3399-base.dtsi#L732

the above looks OK to me on the first glance, I'm really puzzled what
is the reason for "of:" prefixed MODALIAS in the uevent for an i2c device.

I still believe, that the culprit is the creation of a platform device
from the DT for an i2c device.

I don't have any real I2C-connected CS4271, but I think I could fake one
in any DT just to verify how uevents would look like on my side.

> About the related module, I have the following:

I assume, this is with your patch applied though.

> --- 8< ---
> # modinfo snd_soc_cs4271_i2c
> filename:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /lib/modules/6.18.0-rc1xxxx=
-00050-g4fa36970abe5-dirty/kernel/sound/soc/codecs/snd-soc-cs4271-i2c.ko
> license:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 GPL
> author:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Alexander Sverdli=
n <subaparts@yandex.ru>
> description:=C2=A0=C2=A0=C2=A0 ASoC CS4271 I2C Driver
> alias:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 i2c:cs4271
> alias:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 of:N*T*Ccirr=
us,cs4271C*
> alias:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 of:N*T*Ccirr=
us,cs4271
> depends:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 snd-soc-cs4271
> intree:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Y
> name:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 snd_soc=
_cs4271_i2c
> vermagic:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 6.18.0-rc1xxxx-00050-g4fa36=
970abe5-dirty SMP preempt mod_unload aarch64
> #=20
> --- 8< ---

--=20
Alexander Sverdlin.

