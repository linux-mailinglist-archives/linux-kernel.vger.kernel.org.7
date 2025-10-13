Return-Path: <linux-kernel+bounces-850140-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 44DB5BD2005
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 10:22:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1C1DE4ED1D9
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 08:22:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFFA12F28EE;
	Mon, 13 Oct 2025 08:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="N+0q9GZl"
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 318C32EACF9
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 08:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760343721; cv=none; b=AR6vzLPwu1KO3y1VxBe02S1z08TFC8Er/RE2uK21HbGzc7ypD8dFz0fFapxnJqk49j5mYSLmrH540vEPfhs36ZaEbgCsL74wPWH4oqx197N2+ueIm9Eqzx5qx8ZiXS9ziCV/O1+CbOrBShwE+sXHgeiZyxpXjvW4mev5xw7psE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760343721; c=relaxed/simple;
	bh=eAD0+1vST5dCT18sRVdP+XYndG11q3exTERbaeCwb7E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qLOs6CK8BCb8ZcJgZchmlyNeACUjbao6QfLq8Ada0BNjLuQIo78zFl+jcmmokA7YxPxpuB+koy6BJy/HkQ02tTvivJxYGwArf5+rr3HlBsKXi3SK8l1yPamoYYsU5v2hTU0no+vh7OIIdSSa1ce8VuJpYJHgQnXDDADzfFnEXdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=N+0q9GZl; arc=none smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-7b4f7a856acso1530624a34.3
        for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 01:21:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1760343719; x=1760948519; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PfkSUSbV0vhiMznuifIKRudfUsRdigA3bUiVnoZZFkE=;
        b=N+0q9GZlzcMVOGl75nNjmjutZV2g/nlm+9VFV+F0o/j2FXrsbNnURWXIZfSQfviX8b
         bWoy84Eg7iyUjrjJ0OsNJfsHGZu6PVzaIJNtdj46rVDpQFcR+AZRp2Jgw+F0UdCg6fpY
         N3Dx///YF9zpELfn3r+VBimlK1KotkddrDXGOOBk+yYFBjh3HYEuSyhpTKW8nmLpw4g1
         L6ZjSCovrL+89Gbr7uEl9gNBeguSo5zT1SDjfCoYpESKTV+4LV3ylQp0eVvBvQEN0Uje
         KOIH6UUY8mVBXWmJna481IN5SLSne6Fb19CBGTslN3j7NYUSWNH+5hEGLQiZvcdEnt8/
         V0Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760343719; x=1760948519;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PfkSUSbV0vhiMznuifIKRudfUsRdigA3bUiVnoZZFkE=;
        b=D18WYG/xokBOrpoSGkdIhWPFLCBg87ozxRSrICD1llwHmNLpyS5/BQDkevR+HoyD3j
         4rzg0ZauJkCBQlAzDe/y1s/9RWfLJpMD9fe7m1m4AmTka6Z6OlD5NeBx2xrqFlM2yrFF
         0+p2CTU/EUgxn/8bO9FoBTozEID8uJDwZUVD/ogpcVfWqcsMSvXIM38u9zTaxF2dHGF5
         GMGvewpJRBn1AKCsFNLsKd0lgIN7IwBcumlPUIDzRR7yLM6aQplcMEXwVjAid77HXAPK
         sQRYkBacqd1cabwG5Ef6MuKTz7L4EpaSZ2ABu4LaCwUMeou7A9+OhixeIWvAdEEDhVwZ
         pZvQ==
X-Forwarded-Encrypted: i=1; AJvYcCXk9ZXDpLLnbikZzo6kgWU8DBUM0DDx1VRcd5Cy+zoGRoEQhAJ/uS5ZP4VbsG530dK11W0PVYLjdJJVEpw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXSkwZvKFrUD58cZloGCmL51b2RJpcyEffvlbUDKRAbAQRODFJ
	hTbGpjd9AD55bpPdF3VSuCESmzoMagaQMMSSDMXwU7FXavl0a+rzthwEeYXOkeBCDkw/cyCK/xR
	7bJ6ce+5xXXgs7aGI3/fCYqK2wGw/fyDKj62HJl2WcwT4GZzqKTrV/5U=
X-Gm-Gg: ASbGncuwEIksdWu47QYQdeutEMEHNrCjKE0681pBb0N/5wWHKHyOs9epYs5Yw1gWlzP
	ol+NDXX4IfEWz5SLiLcMSr6lit9HBnJbxi0WeTLmHUne21KF+W+wnbJGGUKgCYjeSSwG+6ksmpM
	qa3WIY/DwRsAfel8pFsvb2iGhIqxl2Dm94LSxeg7TZsXEp4omopmkDiG/mkcJgyQD/FxmbsJ6ZG
	pCAZI633YqFtSU9628lkE9k69lw
X-Google-Smtp-Source: AGHT+IHbBJMX3XQXIUnh0eL9Gqqi1OX8ycJZAvF31um7+RQ7SUC6Nq+yI9wt5/rT+c82tvoUj+Wt+PHgwJvmIyZts1I=
X-Received: by 2002:a05:6808:50a0:b0:43f:713c:a38e with SMTP id
 5614622812f47-4417b393963mr8040987b6e.30.1760343719075; Mon, 13 Oct 2025
 01:21:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251001060805.26462-1-beanhuo@iokpp.de> <20251001060805.26462-4-beanhuo@iokpp.de>
 <CAHUa44HA0uoXbkKgyvF4Rb9OJa1Qj-Wh7QAmQxXYAf3grLdktw@mail.gmail.com> <893731e9c8e4e74bb0d967ab2e7039e862896dc5.camel@gmail.com>
In-Reply-To: <893731e9c8e4e74bb0d967ab2e7039e862896dc5.camel@gmail.com>
From: Jens Wiklander <jens.wiklander@linaro.org>
Date: Mon, 13 Oct 2025 10:21:47 +0200
X-Gm-Features: AS18NWDSwHNWbhvfTfZVBBArRE_Meet5w9zINg4FG3XlfoXhTtWNhOWUG_vlJ4s
Message-ID: <CAHUa44HdV8FJMayVg6TFz7oGZc1b6QntxMsUN8mdTV7pm7vkKQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] scsi: ufs: core: Add OP-TEE based RPMB driver for
 UFS devices
To: Bean Huo <huobean@gmail.com>
Cc: avri.altman@wdc.com, bvanassche@acm.org, alim.akhtar@samsung.com, 
	jejb@linux.ibm.com, martin.petersen@oracle.com, can.guo@oss.qualcomm.com, 
	ulf.hansson@linaro.org, beanhuo@micron.com, linux-scsi@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Bean,



On Wed, Oct 8, 2025 at 5:07=E2=80=AFPM Bean Huo <huobean@gmail.com> wrote:
>
> Jens,
>
> I incorporated your suggestions in my v3 excpet these two:
>
>
> On Wed, 2025-10-01 at 09:50 +0200, Jens Wiklander wrote:
> > > diff --git a/drivers/ufs/core/Makefile b/drivers/ufs/core/Makefile
> > > index cf820fa09a04..51e1867e524e 100644
> > > --- a/drivers/ufs/core/Makefile
> > > +++ b/drivers/ufs/core/Makefile
> > > @@ -2,6 +2,7 @@
> > >
> > >   obj-$(CONFIG_SCSI_UFSHCD)              +=3D ufshcd-core.o
> > >   ufshcd-core-y                          +=3D ufshcd.o ufs-sysfs.o uf=
s-mcq.o
> > > +ufshcd-core-$(CONFIG_RPMB)             +=3D ufs-rpmb.o
> >
> > SCSI_UFSHCD might need the same trick ("depends on RPMB || !RPMB") in
> > Kconfig as we have for MMC_BLOCK.
> >
> > >
> When RPMB=3Dm and SCSI_UFSHCD=3Dy, the ufs-rpmb.o is compiled into the bu=
ilt-in
> ufshcd-core, ufs-rpmb.c calls functions from the OP-TEE RPMB subsystem mo=
dule,
> The kernel allows built-in code to reference module symbols (they become =
runtime
> dependencies, not link-time), please check, I tested.
>
> > >
> > >
> >
> > > +
> > > +       struct rpmb_descr descr =3D {
> > > +               .type =3D RPMB_TYPE_UFS,
> >
> > We'll need another type if the device uses the extended RPMB frame
> > format. How about you clarify this, where RPMB_TYPE_UFS is defined to
> > avoid confusion?
>
> As ufs-bsg.c, we could use ARPMB_TYPE_UFS for UFS advanced RPMB frame, if=
 it is
> RPMB, we take it as normal RPMB, the frame should be the same as MMC RPMB=
.

Isn't it a bit confusing to set the type to RPMB_TYPE_EMMC when it's
actually a UFS RPMB, even if it's supposedly compatible enough?

While the frame format works, I'm concerned about the CID. It's
essentially a namespace of its own for eMMC, and at least the OP-TEE
implementation makes assumptions about the format by masking out the
PRV (Product Revision) and CRC (CRC7 checksum) fields from the CID
when deriving the RPMB key. For this to work reliably, the CID must be
guaranteed to be unique per RPMB device.

From what I understand, for UFS, the serial number is only guaranteed
to be unique if the manufacturer and the product name are taken into
account. Combined, these fields can be much larger than 16 bytes, and
we also have the partition number to consider.

By using RPMB_TYPE_UFS we can define a device ID tailored for UFS with
all the fields we need. Thoughts?

Cheers,
Jens

