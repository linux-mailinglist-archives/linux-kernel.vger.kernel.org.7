Return-Path: <linux-kernel+bounces-850467-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F0D2BD2E64
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 14:04:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 139E94F0CF7
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 12:04:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C43CD26AA94;
	Mon, 13 Oct 2025 12:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ib10ocHX"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2913D26A0EB
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 12:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760357069; cv=none; b=TISlHyp2l3xrlYh9/yCOfXgG9DjBFXQffXwGETV2XVTf9sTBk3PC0xoRCMsxpMn7UTgsimSk3WEzvYrCz1chq9N+NtndWUnp2rltuuZcVm2f6N0ncI+RwKipzKRMHU71Vk9gn08WNUtYgpLs8XxNllg2FkoiZYA4i+P+VFSK/fk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760357069; c=relaxed/simple;
	bh=v0K7ZywmUV5QPqpo9PzmGZDpDzdU4ARzvGPKzS4ALQA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KEJ9yGFmC4jVPI5U9LTS/5WRoih4uKAOMRWQ76UUx9BWPseeMoq85pwMD8daYFNtG6m8zKLAyqCaXcGZhIsCfMW15TTurwDzcvqlrAlebS/LNd345RgVyj+oayom9RemBCNBQLVOmI8a/HfMVufdUco5RlluZv1tbZasGMay/HQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ib10ocHX; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-62fc89cd68bso4171987a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 05:04:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760357065; x=1760961865; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=v0K7ZywmUV5QPqpo9PzmGZDpDzdU4ARzvGPKzS4ALQA=;
        b=ib10ocHXNAUd49IJ+pYY1Wr4U1uO/ei8wkUJy2x5Ym7VKzQNKt809vfB6zZDw0Vm4x
         cfurXlej5nSJ3fllpKwrKtVk3x+itXwjSBxw8byUZjoBfeiPb9xL9vLRWvz6zMe5plC2
         DdurUTE+UNx/JKgxh77erasZX6frUaeVsK+WwOTFvwRInGNisd4335yrorNWvoW4sQ7q
         Z9yMySHqeTy3asbbCt25+14NBQcKa69F0NS6x4ZyfmRRHMTNohWTSoS+vtYMGJf/+Xbw
         gvUQLnhh1T22yasT/IM5AfkjKRihoAj7fHh2P6a0fF+N0wIUU/kYmInevI/BB3iSR0Y/
         6dFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760357065; x=1760961865;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=v0K7ZywmUV5QPqpo9PzmGZDpDzdU4ARzvGPKzS4ALQA=;
        b=wF+U7fFpGZUobIkuRdu7RVdFdCiAa2bi0JK6g4RPQM0bb5J0de0Tq/s8yJzCxYX9FB
         zTjhKTRq1GgK68R61iAkFSXAFlfIMxOAoCI7wtKJkY6mz9T49v1lEPnBntpYsbyadcG4
         bQLldcM8MEJkE/H8YTgylGMYuaNmywJKHN1tu+aF1SnZSsgh27lVlq02+5mkgx/phmtH
         1f3K4KDwAzHNHUB4bDqwApguI0B/1KZQ85nzU4psVML6qINVzeoA3cFK1UmvevtUaVce
         F4lBOfVwuQn3iEoOp4QFrx5Xip+0Suq//+KsfQ+42ddPHd2Ulfdx+SeW4v30tHGpr4Td
         Khdw==
X-Forwarded-Encrypted: i=1; AJvYcCXWSgU4wIdZtXnLvfU0UNMDtP5o0ab9S2ZrJX5WvAyw/jbqCGXJLo2u272vrRZKlGJQR+cNQmRqEbA4gRs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGFoLD8ySD3cuxyVmWodjQRIkRQmUURnKZNVhmhQrWVhH5JME+
	XozKSrTrMiW3ABoddssh1cqKj61pUQULKOygKTbMisJK7Ig46EzxxU0S
X-Gm-Gg: ASbGncuDKWyJISr7JZNX4clLtoj9a1xIKt9Q/KmEYLjK+RhkjA07tzDpD4tTVjUUsZt
	jvumRxJ1n9Qon8GHai7QLQ2CsIUj3W6wPgdigqou2DgW8WdBmo0Uogxxb4qkOsCP2L/gX3n1jrJ
	NAn2L9TEeLpg1UJXVTKUJqaIA+r6PJJAZxSiLbQ0AGtkulz0bAg8T61iotpAiEtzpovgviHZfHD
	u/6HDuEQIKc3Ww3DPz/7AQ2JlAmW8+J8f2BZAXUuAdEFy0sy+mdGXGMtEgqfl6nnm5u9AN5UNB/
	FcY05b/7XEIT833yHGh08b/kZjem6W1NoOp79FprPfLUHtiUsHmY/YFZKKW9qocsnOVbhRzyLRQ
	i8M/E7pHxCwhc/NTo1C6m6DB6O2afB6JxLb+KpB5eJ+QQ0zzmZHusyqw=
X-Google-Smtp-Source: AGHT+IEwlwnayx0gzu14dd9W3bXJDuF7IW9hSKpZxRxRk5DSh9CB/z4CK6mSYE7XddK8vBzlO98UIQ==
X-Received: by 2002:a17:907:7f0e:b0:b3f:33f6:fb57 with SMTP id a640c23a62f3a-b50a9d59a3bmr1974300466b.9.1760357065125;
        Mon, 13 Oct 2025 05:04:25 -0700 (PDT)
Received: from [10.176.235.211] ([137.201.254.43])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b55d8c124a8sm913666766b.51.2025.10.13.05.04.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Oct 2025 05:04:24 -0700 (PDT)
Message-ID: <a040353e95a67dc3bde09b5f3866aa628150c9db.camel@gmail.com>
Subject: Re: [PATCH v2 3/3] scsi: ufs: core: Add OP-TEE based RPMB driver
 for UFS devices
From: Bean Huo <huobean@gmail.com>
To: Jens Wiklander <jens.wiklander@linaro.org>
Cc: avri.altman@wdc.com, bvanassche@acm.org, alim.akhtar@samsung.com, 
	jejb@linux.ibm.com, martin.petersen@oracle.com, can.guo@oss.qualcomm.com, 
	ulf.hansson@linaro.org, beanhuo@micron.com, linux-scsi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, beanhuo@iokpp.de
Date: Mon, 13 Oct 2025 14:04:23 +0200
In-Reply-To: <CAHUa44HdV8FJMayVg6TFz7oGZc1b6QntxMsUN8mdTV7pm7vkKQ@mail.gmail.com>
References: <20251001060805.26462-1-beanhuo@iokpp.de>
	 <20251001060805.26462-4-beanhuo@iokpp.de>
	 <CAHUa44HA0uoXbkKgyvF4Rb9OJa1Qj-Wh7QAmQxXYAf3grLdktw@mail.gmail.com>
	 <893731e9c8e4e74bb0d967ab2e7039e862896dc5.camel@gmail.com>
	 <CAHUa44HdV8FJMayVg6TFz7oGZc1b6QntxMsUN8mdTV7pm7vkKQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2025-10-13 at 10:21 +0200, Jens Wiklander wrote:
> Hi Bean,
>=20
>=20
>=20
> On Wed, Oct 8, 2025 at 5:07=E2=80=AFPM Bean Huo <huobean@gmail.com> wrote=
:
> >=20
> > Jens,
> >=20
> > I incorporated your suggestions in my v3 excpet these two:
> >=20
> >=20
> > On Wed, 2025-10-01 at 09:50 +0200, Jens Wiklander wrote:
> > > > diff --git a/drivers/ufs/core/Makefile b/drivers/ufs/core/Makefile
> > > > index cf820fa09a04..51e1867e524e 100644
> > > > --- a/drivers/ufs/core/Makefile
> > > > +++ b/drivers/ufs/core/Makefile
> > > > @@ -2,6 +2,7 @@
> > > >=20
> > > > =C2=A0 obj-$(CONFIG_SCSI_UFSHCD)=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 +=3D ufshcd-core.o
> > > > =C2=A0 ufshcd-core-y=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 +=3D ufshcd.o ufs-sysfs.o ufs-
> > > > mcq.o
> > > > +ufshcd-core-$(CONFIG_RPMB)=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 +=3D ufs-rpmb.o
> > >=20
> > > SCSI_UFSHCD might need the same trick ("depends on RPMB || !RPMB") in
> > > Kconfig as we have for MMC_BLOCK.
> > >=20
> > > >=20
> > When RPMB=3Dm and SCSI_UFSHCD=3Dy, the ufs-rpmb.o is compiled into the =
built-in
> > ufshcd-core, ufs-rpmb.c calls functions from the OP-TEE RPMB subsystem
> > module,
> > The kernel allows built-in code to reference module symbols (they becom=
e
> > runtime
> > dependencies, not link-time), please check, I tested.
> >=20
> > > >=20
> > > >=20
> > >=20
> > > > +
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct rpmb_descr descr =3D {
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 .type =3D RPMB_TYPE_UFS,
> > >=20
> > > We'll need another type if the device uses the extended RPMB frame
> > > format. How about you clarify this, where RPMB_TYPE_UFS is defined to
> > > avoid confusion?
> >=20
> > As ufs-bsg.c, we could use ARPMB_TYPE_UFS for UFS advanced RPMB frame, =
if it
> > is
> > RPMB, we take it as normal RPMB, the frame should be the same as MMC RP=
MB.
>=20
> Isn't it a bit confusing to set the type to RPMB_TYPE_EMMC when it's
> actually a UFS RPMB, even if it's supposedly compatible enough?
>=20

The RPMB data format is the same for both eMMC RPMB and standard UFS RPMB.
However, the application commands used to access RPMB differ =E2=80=94 eMMC=
 uses MMC
commands, while UFS uses SCSI commands.

Additionally, UFS RPMB supports more RPMB operations than eMMC RPMB. Theref=
ore,
we need to distinguish between them:

RPMB_TYPE_EMMC for eMMC RPMB

RPMB_TYPE_UFS for standard UFS RPMB

ARPMB_TYPE_UFS for advanced UFS RPMB.


> While the frame format works, I'm concerned about the CID. It's
> essentially a namespace of its own for eMMC, and at least the OP-TEE
> implementation makes assumptions about the format by masking out the
> PRV (Product Revision) and CRC (CRC7 checksum) fields from the CID
> when deriving the RPMB key. For this to work reliably, the CID must be
> guaranteed to be unique per RPMB device.
>=20
> From what I understand, for UFS, the serial number is only guaranteed
> to be unique if the manufacturer and the product name are taken into
> account. Combined, these fields can be much larger than 16 bytes, and
> we also have the partition number to consider.
>=20
> By using RPMB_TYPE_UFS we can define a device ID tailored for UFS with
> all the fields we need. Thoughts?
>=20

For certain memory vendors, the serial number is guaranteed to be unique am=
ong
all devices.

For partitions or regions, we have appended the region number to the end of=
 the
CID =E2=80=94 please check the patch for details.

Regarding improving CID uniqueness, we could include the OEM ID or product
number. However, this would make the CID longer than 16 bytes.



Kind regards,
Bean

> Cheers,
> Jens


