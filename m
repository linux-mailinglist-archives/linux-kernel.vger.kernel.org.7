Return-Path: <linux-kernel+bounces-850486-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E8F54BD2F3B
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 14:22:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A52A189E010
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 12:23:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B21E926FDA8;
	Mon, 13 Oct 2025 12:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NM08LBS3"
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2587A248F4F
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 12:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760358161; cv=none; b=aNQnVxJyN+vwTSirLRw1D/Bdx+o/AUiWwrkGp0UYX1tNewvMxGO9Yi+GITdW0I2SwifqjwqJH7fAYIb/nPRE4eFaRhD1AxU1cIG4AIxN1olxjUwdJ9xeZRS1PLzxpU36fMS5ob47aDcG2BZga/otp2KXKcjYfhTAYFvAjzFhmFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760358161; c=relaxed/simple;
	bh=JEEN7l5OkeehFLiZUEvyupoTz1eaKnAjMCWZiLK9Ih4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rGZjnaSObOPxN5hPru+vFOAMWTm868G266+liG451trob8U6lBIk69TKbt8Y9ycdF1eptev8Dt4DTce1JhnSYTs3KPe7OW45Pdc/TciASz0D2uOalvb5ceHSs2D3ODmgBlCwxoS0hqbRowpzBN1K9MWw4VNQ16egg/vYe3v8z4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=NM08LBS3; arc=none smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-7c0dd405c38so2762663a34.0
        for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 05:22:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1760358158; x=1760962958; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ckdYgWLf7VpMshdwBHgpN9kuuhu3Zm0WzeZ4ZRa+ctc=;
        b=NM08LBS3P8vvoiHLBCutnXDx2tQU/EgRFw2KKTWE9rFl5QN7gzoxH6YbTcjN1mdjUL
         7Cr0uICvcv6S9/SYR1J9294R7ihHm7SAtHrOfw3rCSWVBIa7BCfZyHLS6QytMb1VYGS/
         ZnZBrBzRep4CG0s9lwDdrxHCsAm0WI3d596pV9hHmt460Sfu9Vi97dXlKOKlDirVFZwE
         tW4HNSBikaZhMzDVAwHb8kiIbJi6GJJH0b7y2QiGyB8bYRwzUP1eaT1I85iTaleFzHWk
         z6JXhFD+oCg5L4yj1YdBSh8uRsfIxy2jtE3NH3M6JTY5Q6z08+9NJ75OBdrjau9W2Ag4
         nMKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760358158; x=1760962958;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ckdYgWLf7VpMshdwBHgpN9kuuhu3Zm0WzeZ4ZRa+ctc=;
        b=EDfHx7jJu9dBxxMn9otwXAgSabh34UySECLfm+Zp4uaSGIb99JxlQNoOrQIkvA5K/r
         x3HjOWJbvMB0Q+o99MgsLjWns52iIWlp5V0tbeBwgnOqWzXnp5tE8tU4RDzedy8wYc9Y
         pMDhW6uxkA1t0oDSmGoa3pgS+ADa2tcdFjxxrCuXo27QIJ78Ccrlml5ZPSIpVrM+9jlo
         dWp6VjT6dJSoxtYykJwrNu0ZSsAiF8lIvDBucmRjjU+8o7LDKvkMqaOIeoq+zx7ssoME
         XaDplWTi+1hepKEjnezVW/e9Wd6fggVxIA2V+fM47d96uKxTAFZQDpHFR8RycN/f/LWh
         mp0Q==
X-Forwarded-Encrypted: i=1; AJvYcCXvWLPPYZLQxV3C4NObASgGwvFsQXV/YzohOUd+Tx4mbkvg1V4j2nrh9EwfV3bsvG3FYd7WFXcAqxfu1/o=@vger.kernel.org
X-Gm-Message-State: AOJu0YzvTL0/x9hq2dh6NhgbVRuQfppq0MHUIdz7Xqlai50P2f7QWB71
	FDDBm0+Cfn0JHbuUSPt07YAj413aOVXT1xMXqPhbCJ5uNc3oRZdgn8hwRWa42JvJEh1n0W6up1q
	+6z6IjiWwpJ7FKXM7MMW6Wgd7QQ8GdR7qzGNKp1fP6A==
X-Gm-Gg: ASbGncs/VE+unvEcltUv0Uygy2KZn6oS8cMXG8fa9V0lMeKtYUiS2l9UC92Ppc78Jcd
	lEhLWpmxr2ut6N50UILf1ntmorqgLHmCXyTb4UN2CUPi3+04ddBa736N9VQOcpuRk0kYtLCK3bz
	KRVYon7RWYHquJJ8dVvQPZVujs1Wb7DoFqkAKCDWHa97xY09HnONtsrjJ1lJu9vQDQZvwmIBQjJ
	WI//Vlfl6cvyZWsRzBAxA6M8+wQ
X-Google-Smtp-Source: AGHT+IEoQBCqLH2ozdoVH1sRcw07pPQAKVgvNijfvoDm483d6lTz9yEb87u/4psYc3vMcbxKtwk9tX7qFa/t5Bfgqog=
X-Received: by 2002:a05:6808:2120:b0:43f:1c66:bbab with SMTP id
 5614622812f47-4417b48080amr9203732b6e.47.1760358158056; Mon, 13 Oct 2025
 05:22:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251001060805.26462-1-beanhuo@iokpp.de> <20251001060805.26462-4-beanhuo@iokpp.de>
 <CAHUa44HA0uoXbkKgyvF4Rb9OJa1Qj-Wh7QAmQxXYAf3grLdktw@mail.gmail.com>
 <893731e9c8e4e74bb0d967ab2e7039e862896dc5.camel@gmail.com>
 <CAHUa44HdV8FJMayVg6TFz7oGZc1b6QntxMsUN8mdTV7pm7vkKQ@mail.gmail.com> <a040353e95a67dc3bde09b5f3866aa628150c9db.camel@gmail.com>
In-Reply-To: <a040353e95a67dc3bde09b5f3866aa628150c9db.camel@gmail.com>
From: Jens Wiklander <jens.wiklander@linaro.org>
Date: Mon, 13 Oct 2025 14:22:26 +0200
X-Gm-Features: AS18NWBUqqhs4ywfNiDQRHxZL7fNzXhVoY3zu19jmmL8xI5PDTBl5irSqdAZHmo
Message-ID: <CAHUa44HYNgiRU5yOrVq8gBwHEEAxGz6TyT0PrBpVOiFfKxYhOQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] scsi: ufs: core: Add OP-TEE based RPMB driver for
 UFS devices
To: Bean Huo <huobean@gmail.com>
Cc: avri.altman@wdc.com, bvanassche@acm.org, alim.akhtar@samsung.com, 
	jejb@linux.ibm.com, martin.petersen@oracle.com, can.guo@oss.qualcomm.com, 
	ulf.hansson@linaro.org, beanhuo@micron.com, linux-scsi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, beanhuo@iokpp.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 13, 2025 at 2:04=E2=80=AFPM Bean Huo <huobean@gmail.com> wrote:
>
> On Mon, 2025-10-13 at 10:21 +0200, Jens Wiklander wrote:
> > Hi Bean,
> >
> >
> >
> > On Wed, Oct 8, 2025 at 5:07=E2=80=AFPM Bean Huo <huobean@gmail.com> wro=
te:
> > >
> > > Jens,
> > >
> > > I incorporated your suggestions in my v3 excpet these two:
> > >
> > >
> > > On Wed, 2025-10-01 at 09:50 +0200, Jens Wiklander wrote:
> > > > > diff --git a/drivers/ufs/core/Makefile b/drivers/ufs/core/Makefil=
e
> > > > > index cf820fa09a04..51e1867e524e 100644
> > > > > --- a/drivers/ufs/core/Makefile
> > > > > +++ b/drivers/ufs/core/Makefile
> > > > > @@ -2,6 +2,7 @@
> > > > >
> > > > >   obj-$(CONFIG_SCSI_UFSHCD)              +=3D ufshcd-core.o
> > > > >   ufshcd-core-y                          +=3D ufshcd.o ufs-sysfs.=
o ufs-
> > > > > mcq.o
> > > > > +ufshcd-core-$(CONFIG_RPMB)             +=3D ufs-rpmb.o
> > > >
> > > > SCSI_UFSHCD might need the same trick ("depends on RPMB || !RPMB") =
in
> > > > Kconfig as we have for MMC_BLOCK.
> > > >
> > > > >
> > > When RPMB=3Dm and SCSI_UFSHCD=3Dy, the ufs-rpmb.o is compiled into th=
e built-in
> > > ufshcd-core, ufs-rpmb.c calls functions from the OP-TEE RPMB subsyste=
m
> > > module,
> > > The kernel allows built-in code to reference module symbols (they bec=
ome
> > > runtime
> > > dependencies, not link-time), please check, I tested.
> > >
> > > > >
> > > > >
> > > >
> > > > > +
> > > > > +       struct rpmb_descr descr =3D {
> > > > > +               .type =3D RPMB_TYPE_UFS,
> > > >
> > > > We'll need another type if the device uses the extended RPMB frame
> > > > format. How about you clarify this, where RPMB_TYPE_UFS is defined =
to
> > > > avoid confusion?
> > >
> > > As ufs-bsg.c, we could use ARPMB_TYPE_UFS for UFS advanced RPMB frame=
, if it
> > > is
> > > RPMB, we take it as normal RPMB, the frame should be the same as MMC =
RPMB.
> >
> > Isn't it a bit confusing to set the type to RPMB_TYPE_EMMC when it's
> > actually a UFS RPMB, even if it's supposedly compatible enough?
> >
>
> The RPMB data format is the same for both eMMC RPMB and standard UFS RPMB=
.
> However, the application commands used to access RPMB differ =E2=80=94 eM=
MC uses MMC
> commands, while UFS uses SCSI commands.
>
> Additionally, UFS RPMB supports more RPMB operations than eMMC RPMB. Ther=
efore,
> we need to distinguish between them:
>
> RPMB_TYPE_EMMC for eMMC RPMB
>
> RPMB_TYPE_UFS for standard UFS RPMB
>
> ARPMB_TYPE_UFS for advanced UFS RPMB.

Good. A distinction was what I was asking for.

>
>
> > While the frame format works, I'm concerned about the CID. It's
> > essentially a namespace of its own for eMMC, and at least the OP-TEE
> > implementation makes assumptions about the format by masking out the
> > PRV (Product Revision) and CRC (CRC7 checksum) fields from the CID
> > when deriving the RPMB key. For this to work reliably, the CID must be
> > guaranteed to be unique per RPMB device.
> >
> > From what I understand, for UFS, the serial number is only guaranteed
> > to be unique if the manufacturer and the product name are taken into
> > account. Combined, these fields can be much larger than 16 bytes, and
> > we also have the partition number to consider.
> >
> > By using RPMB_TYPE_UFS we can define a device ID tailored for UFS with
> > all the fields we need. Thoughts?
> >
>
> For certain memory vendors, the serial number is guaranteed to be unique =
among
> all devices.

This is supposed to be generic and not rely on the behavior of only
some vendors.

>
> For partitions or regions, we have appended the region number to the end =
of the
> CID =E2=80=94 please check the patch for details.

Yes, but how do you know that you don't overwrite a part of the serial numb=
er?

>
> Regarding improving CID uniqueness, we could include the OEM ID or produc=
t
> number. However, this would make the CID longer than 16 bytes.

UFS doesn't have a CID, but there's no need for one either. struct
rpmb_descr has dev_id and dev_id_len. It can be any length, within
reason.

Cheers,
Jens

>
>
>
> Kind regards,
> Bean
>
> > Cheers,
> > Jens
>

