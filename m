Return-Path: <linux-kernel+bounces-731538-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 825E0B055EF
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 11:11:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A82AD3AD269
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 09:10:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D51002D5420;
	Tue, 15 Jul 2025 09:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b/0Jf5N7"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F3972D3A7D
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 09:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752570656; cv=none; b=iDgzpWyGSPr91rkJsKaGqFCzBHa9lW7H0s78BJ6bi5MqaSEtHzId0JWa4r06EuoYoy/vuBYSOi7oV8L4Pm7MkIxibGvmzDQyneRWOC6by/2LEU/5KjvEeSaZ1s4mB79ni58/cIUjJIHgufKvTUsN6WnPK76Kw7/BG8ca9hxtvd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752570656; c=relaxed/simple;
	bh=N3v6yre1w59ynmHLJIPCSWSZrxzyqtlDbvmNV1Ort1U=;
	h=From:Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:To:
	 References:In-Reply-To; b=otJLG5PAMNRkKSU/Wc6utL11QHrO6xpbGhicI44ZHCgQt5LqXenrkKLPcQlS3XFrCwX8eMpe/7jX0raof/WCQxLESRMfN+0+aOw8Fdi40fpJjf+j9eA46fE+9fc7KY69RXfJtnmN72y4AMerbDDAOIyKrDduwZle/pKDbguAQts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b/0Jf5N7; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4561a4a8bf2so19295345e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 02:10:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752570653; x=1753175453; darn=vger.kernel.org;
        h=in-reply-to:references:to:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o1h5Pc6jSMg8b1cL/wTGNUWLlJ8UBTATqjvEdBDjUk0=;
        b=b/0Jf5N7XsX3RD37tc7HZyATcszBoOyURksjHu9+EcVK0KvBOTc+QzBuKsWb+wVZtG
         6TJkvvv/jCuz7OuaZ4EFKO2cZ4upuCCfu6sC0Ou2hoIiQ02v+HxE3IeYQgytLireEw0R
         5xuXgpHHeSpl0OdmcSJ0H1sak9UrXaO7cwFVlX8R8QtUs2srLeccfnPrRRDXzYWPYUsL
         o8wOZB/gsZMid1HBpZnkLz2VEqm1/z2IlH46WTIiDCgk3aWT++ctHvQicdXUu2GQRnTI
         OpRGLi8K8l08mL9t/NLULa5jgCin9Ryl5+bU0ewRs2T/fEBmsJqpVp6M00ScibbRedfQ
         VtlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752570653; x=1753175453;
        h=in-reply-to:references:to:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=o1h5Pc6jSMg8b1cL/wTGNUWLlJ8UBTATqjvEdBDjUk0=;
        b=SYVtMYC92OC2fQBj2mAdTYnL+l636Q1a3ppYZYhVQw6LJlhIgU+UmD+fkjML+7KBAq
         pXBvB2u5C3CqyM99OkMTh2YdxCkLQ4fFbfE8/ry+PF5OZgAkR/uMmGA6DTkoiuinNuho
         04a4W2uJ8Lg4PZiObEC1nDaZkiy8znBpwiqMr5rMJ0sL8zIuEEtOatCPENZM8IRcSxcm
         kvu2V2Tb9a53RrJJZJwbB3lxHHOH5tlQS1G5xYMuXAbEkpg/uD578BkpwRDf++F9CVO4
         HpEjdzvZ/JvHP3Nr9xVzV/PydkGDsm5k34tUZPSogPOpXjg4N/ktvd7gK9ZZZqON1nQn
         gdLQ==
X-Forwarded-Encrypted: i=1; AJvYcCXAUA0RbM5tXbjgRh8yx+k+ObDG6FWdlbUxA/vsc4o42K9VfLwVdDGI8RgRcDBUUWbHSbNZUiNn0VyBRCE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJ3GtiIlDKMjfwRecGfQtw3nceAp0UVGPEGKEPOVuQpx+1SzLI
	I4X1jmIZHvodiy9IVTpuZ/OMd4YTCeBY0b/bYRXxTi3Ky3a/d3E62m+w
X-Gm-Gg: ASbGncthRrDlYz68mmcQUzsSQMVIZEP/Ds9xDA1MPKDdW57Jai1J2Glmjn6t94NrfLO
	j0KWeici4jS2IWBM/NW0z9GlrnohX6L68rx03x97bYh3OKfYZ5+5/odtMxt8IFO7HOLHzzyng8u
	qzYgbo6oZZ6GbVpghtMfGRLupmEtv56QQg4WlE8+20ze1YESG9URGceQGxlRbQKYf+L6abLmi8z
	r2y8m+E9upkwvgBiIDSQVH/GGNpVk3aNHn091nSgvJhgEN7J7ADpuoAjdyMpnztG/ISX5f69hIM
	64e2v/hV6uYdLqMDCCa/0j5sf9Iu6k0QQl+ukeL26aRKUHAz3UDJOuTPkMMbUdc21XbmB3bLBmh
	oqJGtqi/CVfaLjhnsajclEveq3mINqXR02rqOdK2bAPy8zf4W1g==
X-Google-Smtp-Source: AGHT+IG8LxAVomRTxHB3htRD5s0m3l9g2VSOjPHXCnIu+z0xdDALWIcnXTdVY9yN2PnTDlOwgoRERg==
X-Received: by 2002:a05:600c:3589:b0:456:1c4a:82b2 with SMTP id 5b1f17b1804b1-4561c4a856amr67890905e9.10.1752570652494;
        Tue, 15 Jul 2025 02:10:52 -0700 (PDT)
Received: from localhost (a95-94-245-170.cpe.netcabo.pt. [95.94.245.170])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-454dd538b63sm156999395e9.19.2025.07.15.02.10.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jul 2025 02:10:52 -0700 (PDT)
From: Rui Miguel Silva <rmfrfs@gmail.com>
X-Google-Original-From: "Rui Miguel Silva" <rui.silva@linaro.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 15 Jul 2025 10:10:51 +0100
Message-Id: <DBCIG2AHAZHR.31GUITYRTUZXJ@linaro.com>
Cc: "Akhil Varkey" <akhilvarkey@disroot.org>,
 <greybus-dev@lists.linaro.org>, <linux-staging@lists.linux.dev>,
 <linux-kernel@vger.kernel.org>, <johan@kernel.org>, <elder@kernel.org>,
 <~lkcamp/patches@lists.sr.ht>, <koike@igalia.com>
Subject: Re: [PATCH] staging: greybus: power_supply fix alignment
To: "Greg KH" <gregkh@linuxfoundation.org>, "Rui Miguel Silva"
 <rmfrfs@gmail.com>
References: <20250714135606.41671-1-akhilvarkey@disroot.org>
 <DBBXCAEMM5ZO.GTKVMMR2XDJ7@linaro.com> <2025071540-sepia-amuck-c757@gregkh>
In-Reply-To: <2025071540-sepia-amuck-c757@gregkh>

Hey Greg,
On Tue Jul 15, 2025 at 9:05 AM WEST, Greg KH wrote:

> On Mon, Jul 14, 2025 at 05:38:31PM +0100, Rui Miguel Silva wrote:
>> Hey Akhil,
>> Thanks for your patch.
>>=20
>> All looks good with the exception of a small nit...
>>=20
>> On Mon Jul 14, 2025 at 2:56 PM WEST, Akhil Varkey wrote:
>>=20
>> > Fix checkpatch check "CHECK:Alignment should match open parenthesis"
>> >
>> > Signed-off-by: Akhil Varkey <akhilvarkey@disroot.org>
>> > ---
>> >
>> > Hello, This is my first patch, I appreciate any feedbacks. Thanks!!
>>=20
>> Welcome, and continue...
>>=20
>> > ---
>> >  drivers/staging/greybus/power_supply.c | 14 +++++++-------
>> >  1 file changed, 7 insertions(+), 7 deletions(-)
>> >
>> > diff --git a/drivers/staging/greybus/power_supply.c b/drivers/staging/=
greybus/power_supply.c
>> > index 2ef46822f676..a484c0ca058d 100644
>> > --- a/drivers/staging/greybus/power_supply.c
>> > +++ b/drivers/staging/greybus/power_supply.c
>> > @@ -324,7 +324,7 @@ static struct gb_power_supply_prop *get_psy_prop(s=
truct gb_power_supply *gbpsy,
>> >  }
>> > =20
>> >  static int is_psy_prop_writeable(struct gb_power_supply *gbpsy,
>> > -				     enum power_supply_property psp)
>> > +				 enum power_supply_property psp)
>> >  {
>> >  	struct gb_power_supply_prop *prop;
>> > =20
>> > @@ -493,7 +493,7 @@ static int gb_power_supply_description_get(struct =
gb_power_supply *gbpsy)
>> >  	if (!gbpsy->model_name)
>> >  		return -ENOMEM;
>> >  	gbpsy->serial_number =3D kstrndup(resp.serial_number, PROP_MAX,
>> > -				       GFP_KERNEL);
>> > +					GFP_KERNEL);
>> >  	if (!gbpsy->serial_number)
>> >  		return -ENOMEM;
>> > =20
>> > @@ -546,7 +546,7 @@ static int gb_power_supply_prop_descriptors_get(st=
ruct gb_power_supply *gbpsy)
>> >  	}
>> > =20
>> >  	gbpsy->props =3D kcalloc(gbpsy->properties_count, sizeof(*gbpsy->pro=
ps),
>> > -			      GFP_KERNEL);
>> > +			       GFP_KERNEL);
>> >  	if (!gbpsy->props) {
>> >  		ret =3D -ENOMEM;
>> >  		goto out_put_operation;
>> > @@ -634,8 +634,8 @@ static int __gb_power_supply_property_get(struct g=
b_power_supply *gbpsy,
>> >  }
>> > =20
>> >  static int __gb_power_supply_property_strval_get(struct gb_power_supp=
ly *gbpsy,
>> > -						enum power_supply_property psp,
>> > -						union power_supply_propval *val)
>> > +						 enum power_supply_property psp,
>> > +						 union power_supply_propval *val)
>>=20
>> Here you fix the alignment, but the last line goes over column 81, even
>> though 80 is not really one hard requirement anymore, all code
>> (strings is ok to go over to be easier to grep for messages) is on that
>> register.
>>=20
>> So, to be coherent, if you could please send a V2 without this specific =
change
>> would be great, Or even better, if you could get rid of all the _ and __
>> prefixes in functions names that would be great, and will give more
>> space for function paramethers.
>> Your call.
>
> Nah, this is fine as-is, we can go over the limit to 100 for tiny stuff
> like this.
>
> And the __ prefixes should be there to show no locking, or "internal"
> functions, right?  So changing the name needs to happen very carefully.

Yup, we can go either way here. I do not have strong feelings about
this.

So, LGTM, Thanks Akhil.
Reviewed-by: Rui Miguel Silva <rui.silva@linaro.org>

Cheers,
    Rui

>
> thanks,
>
> greg k-h




