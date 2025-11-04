Return-Path: <linux-kernel+bounces-885446-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BBB84C32E96
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 21:33:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 129EB4272C6
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 20:32:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8C5F2E92B3;
	Tue,  4 Nov 2025 20:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rong.moe header.i=i@rong.moe header.b="jrSZcQYA"
Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com [136.143.188.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 793CB8488;
	Tue,  4 Nov 2025 20:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762288374; cv=pass; b=PuVxhbemn1RQSr9g/McvMO+eRiZMhyt0qwz5qVg447BVaLHmPxbGoGnlIivGJnsb07JPASeoEGPBVpiK5rGlJ3rHYoJv+EEBVAtb+iMSaMiOrIYy3uAXViFBXJ+PZygUc1/Y/Y1XvaplZFDQg2Q7ewXbI9oVMgOhZo8qcAPPNgw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762288374; c=relaxed/simple;
	bh=3E+VHnrqkNodm6Fc5E88cjWJRM87oBbR3N7i0ju5PbA=;
	h=Message-ID:Subject:From:To:Cc:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=XrZVnN5N5yYI3dxX8V0Md1rMDGdBJbyeTkD26egF/7JkFqlV9Q9guz77L2+fkzT2hVNjy/1yi8e1aQ4QMNBzCEF00dFjKIgFbUQkTwzuHyfkFndrIy10eSqT9HIjqa+ahvMkF3gqrT0idS5kQqFr51InB4/mc0zDQfaU3sFPGds=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rong.moe; spf=pass smtp.mailfrom=rong.moe; dkim=pass (1024-bit key) header.d=rong.moe header.i=i@rong.moe header.b=jrSZcQYA; arc=pass smtp.client-ip=136.143.188.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rong.moe
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rong.moe
ARC-Seal: i=1; a=rsa-sha256; t=1762288348; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=lbgXn+7nm4fcSt8SXc6Eia2iAxrdnh01u6w0IeymErschQTsxqikk+/nRmiRuL8FMV3gV0HY+KNhtoSa3LJ+GLx/P1ZgpjKYT18Dvzm+RW3cB7NCbdxc4ASbgX1yj9czKT2TRQVhcduOx0qr8qeiFuWumMFMqy9/+ONzO2ATn0Y=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1762288348; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=HEizRozMMUwhsVY8JcDtM5wzB8PsV057OfnqtnuDHAY=; 
	b=HMazW8PrrQgD4ql+P6UcRDRb44jW+nlfeKrWHY8qVXJksCz5AAKVbFxOlfgqzDe0GiHYw2jEtCkXnv7w/XYUVDgg5tzO4mSH+DVeXc1olAqI6+ahtONKDYYw8MAFC8+uBwxwzRbjrJF4+T8YqTIAQfFeX8KC4TxzKgBnexjaKyM=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=rong.moe;
	spf=pass  smtp.mailfrom=i@rong.moe;
	dmarc=pass header.from=<i@rong.moe>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1762288348;
	s=zmail; d=rong.moe; i=i@rong.moe;
	h=Message-ID:Subject:Subject:From:From:To:To:Cc:Cc:In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date:Date:MIME-Version:Message-Id:Reply-To;
	bh=HEizRozMMUwhsVY8JcDtM5wzB8PsV057OfnqtnuDHAY=;
	b=jrSZcQYAd6TZj9Ghryuc0yxPEzBwA7XuKgQYlhziNgQqdJmSz3nWMa6a2IY7EvhT
	FkuFCUfuOcjFcesUyyoMCfgDWEOekUM20Bc/tYzQuix73DyefYFcMnocK+Do0kFx4uG
	Kcuk/zVncHEaFKutw0bWk4hXeLoNxrzKGKAG9cao=
Received: by mx.zohomail.com with SMTPS id 1762288345028674.076086595653;
	Tue, 4 Nov 2025 12:32:25 -0800 (PST)
Message-ID: <615beafaf18edfcf441d62a81c847f7624eef13c.camel@rong.moe>
Subject: Re: [PATCH v3 1/6] platform/x86: lenovo-wmi-helpers: Convert
 returned 4B buffer into u32
From: Rong Zhang <i@rong.moe>
To: Armin Wolf <W_Armin@gmx.de>, Mark Pearson <mpearson-lenovo@squebb.ca>, 
 "Derek J. Clark" <derekjohn.clark@gmail.com>, Hans de Goede
 <hansg@kernel.org>, Ilpo =?ISO-8859-1?Q?J=E4rvinen?=	
 <ilpo.jarvinen@linux.intel.com>
Cc: Guenter Roeck <linux@roeck-us.net>,
 platform-driver-x86@vger.kernel.org, 	linux-kernel@vger.kernel.org,
 linux-hwmon@vger.kernel.org
In-Reply-To: <a0b6d30b-3cba-4760-81dc-099e8fada7c0@gmx.de>
References: <20251031155349.24693-1-i@rong.moe>
	 <20251031155349.24693-2-i@rong.moe>
	 <a0b6d30b-3cba-4760-81dc-099e8fada7c0@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 05 Nov 2025 04:27:14 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Evolution 3.56.2-5 
X-ZohoMailClient: External

Hi Armin,

On Tue, 2025-11-04 at 21:13 +0100, Armin Wolf wrote:
> Am 31.10.25 um 16:51 schrieb Rong Zhang:
>=20
> > The Windows WMI-ACPI driver converts all ACPI objects into a common
> > buffer format, so returning a buffer with four bytes will look like an
> > integer for WMI consumers under Windows.
> >=20
> > Therefore, some devices may simply implement the corresponding ACPI
> > methods to always return a buffer. While lwmi_dev_evaluate_int() expect=
s
> > an integer (u32), convert returned 4-byte buffer into u32 to support
> > these devices.
> >=20
> > Suggested-by: Armin Wolf <W_Armin@gmx.de>
> > Link: https://lore.kernel.org/r/f1787927-b655-4321-b9d9-bc12353c72db@gm=
x.de/
> > Signed-off-by: Rong Zhang <i@rong.moe>
> > Reviewed-by: Derek J. Clark <derekjohn.clark@gmail.com>
> > Tested-by: Derek J. Clark <derekjohn.clark@gmail.com>
> > ---
> > Changes in v2:
> > - New patch (thanks Armin Wolf)
> > ---
> >   drivers/platform/x86/lenovo/wmi-helpers.c | 21 ++++++++++++++++++---
> >   1 file changed, 18 insertions(+), 3 deletions(-)
> >=20
> > diff --git a/drivers/platform/x86/lenovo/wmi-helpers.c b/drivers/platfo=
rm/x86/lenovo/wmi-helpers.c
> > index f6fef6296251..f3bc92ac505a 100644
> > --- a/drivers/platform/x86/lenovo/wmi-helpers.c
> > +++ b/drivers/platform/x86/lenovo/wmi-helpers.c
> > @@ -59,10 +59,25 @@ int lwmi_dev_evaluate_int(struct wmi_device *wdev, =
u8 instance, u32 method_id,
> >   		if (!ret_obj)
> >   			return -ENODATA;
> >  =20
> > -		if (ret_obj->type !=3D ACPI_TYPE_INTEGER)
> > -			return -ENXIO;
> > +		switch (ret_obj->type) {
> > +		/*
> > +		 * The ACPI method may simply return a 4-byte buffer when a u32
> > +		 * integer is expected. This is valid on Windows as its WMI-ACPI
> > +		 * driver converts everything to a common buffer.
> > +		 */
> > +		case ACPI_TYPE_BUFFER: {
> > +			if (ret_obj->buffer.length !=3D 4)
> > +				return -ENXIO;
>=20
> The Windows driver also accepts oversized buffers. I suggest that you fol=
low this behavior
> for the sake of compatibility.
>=20
> >  =20
> > -		*retval =3D (u32)ret_obj->integer.value;
> > +			*retval =3D *((u32 *)ret_obj->buffer.pointer);
>=20
> The buffer can be unaligned. Better use get_unaligned_le32() from linux/u=
naligned.h.

Thanks for your review and information. Will do in v4.

> Thanks,
> Armin Wolf

Thanks,
Rong

> > +			return 0;
> > +		}
> > +		case ACPI_TYPE_INTEGER:
> > +			*retval =3D (u32)ret_obj->integer.value;
> > +			return 0;
> > +		default:
> > +			return -ENXIO;
> > +		}
> >   	}
> >  =20
> >   	return 0;

