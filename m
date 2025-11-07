Return-Path: <linux-kernel+bounces-890180-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0963BC3F68F
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 11:25:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3318B4E9A20
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 10:25:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BACDD30505C;
	Fri,  7 Nov 2025 10:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g7Pke54a"
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B5053043D6
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 10:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762511114; cv=none; b=ldOeXvg1wk5ZOOPrGCF+aLWzGEBfi0hhLXk6P19lpOH5uODGnRwN9pKNLIAV2KpzYqNkYKl6T0zihjr34PnjRtHhjPR5xjdktuDQ5pwif1R7tIz9hB1jtlsDk75joiK5/sUb31MNZNAeE1wJglvgQyytkiJA7PXQm7NoSqeWSJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762511114; c=relaxed/simple;
	bh=IUUYLHIKD4aI0ypLpcDmYUaYJJUxDWp5WxLqwWMOv3g=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=oBer1Znh96i3MP4EECx5E+HuWuxtxT8llDKLqnIp90pjR8Sm0xbn8s1vgLhRyk17SB/qxF+D/yMBqMgQ/+xuU4vs3ExBjrmOCyjISacL8EhZFnS/6GnLrsOq0Piq1g8NysRTY5WhOiG5757lv7lDkvxf8FlBYxTsaAvZQ32jo98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g7Pke54a; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-429c48e05aeso327708f8f.1
        for <linux-kernel@vger.kernel.org>; Fri, 07 Nov 2025 02:25:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762511109; x=1763115909; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=I5EihXK8u2Mu0aJRNair/6wLWw4qo22bIK0FioiBQgQ=;
        b=g7Pke54ah5DzMzyx4yVYCNsZ7WB0GURZZYvzvmHm+RsHBNo75i2iNhqlG6Mn20xzhL
         x+CP3JZLvWSYXp/SMaRjqU+CtqNAQqu73MR0MYahssSFbkCVlu3OwLZzu3SZLXe8gQiK
         MjJKiv0pgtXJyQJmabRI9TFCsGYgTcY0E3XSwGK18HIXdY70kbMsBR70+Wzj51csnKm8
         k7MJJOeyeWJLi7CTeQdouZbyj2Xj35zH+ft7M1t182z+G19ikM0ymAZziH7wM27RHX2P
         6UaicQ9fQ38QLm4nkdGC6U/MEY/xXgjwEpcersOWvcRUBb1tUIOL6usNqDn6gZqv6n7d
         zTsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762511109; x=1763115909;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=I5EihXK8u2Mu0aJRNair/6wLWw4qo22bIK0FioiBQgQ=;
        b=T6cnn7VkfMBgfpMKyHp3trQ6O6J7x0u+407JosWxMZW0BBQywnLG3UMsE5WYO3HZHP
         Ib08dYws779LCruVd9zlzQeGW+gTp58MEj023AyxX98L86lP9BBMvuDjncON5wEVA0qb
         BlWJeA8hG2BTmvHXgzjAJQP4WIuQH9KANkUBvXRtJ6mN9hknXodmrxui6Qnl/ELMq6tL
         Vfm2e8QvFTUhl4SiodBPpdf31uasC+IVYNfDXQqfPFDuZ1pZt8+dM+2GN9zgWqy6CjHy
         EetnxrO+zJS1yARzfRbupwd5tHwIVPNUx+M5D5g5F7Uk0+3MHBt58j1FtNrPrPl4JqAE
         7vQA==
X-Forwarded-Encrypted: i=1; AJvYcCWReG1hCDtvYcsyEyxrUpfYZJGC9o+a8Ulqk3mxKsVfvC2fXJnths9wsmYlyEWkKzh8VVbyy1q3vlM2lBQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwvtvDV8lq1vOxZKcw03leJxDCt3cDtClmslwyauk6zGZBSm4KA
	TdijUu94E43PbNbIbz5h29bTEtfvkUGcIiRSIy8/CcI+Q9K2cPz68J8o
X-Gm-Gg: ASbGncsvA7LdcWjt8mX8sSuzbWhraN1rkqLBPGvgJUT9EblXnlJX4rBBVoOTGJ/+Tep
	2oJlVaZZCkFE/8BkijTy3CbyJee8h6Mn7k3BuYxIC2bwpTvcQEKrErrioHs5tjIYMZnMQbgUA/L
	nC3Gyall3XilJtkaTzQZz21u6o9BHz/IN4xKlPRESz5yUpVLbhTXTdqRDHHbHAIKHG5y/tgBDPH
	s79srwRWDWM0KiQcFtzgfFD4rce2SMI3K/sKr8Z3kn6oS/UWvHrigqRkikltog7Owf4XGw/dtB9
	5PLpAY7AEtC2EPivtSvSQF0L6WPP1IVDrVseN4r6q135+sUsw3TaLGk6q070FB/Z6wTfLZJA2AX
	4NTM2Wcln0LkhKjmbCup4yqEorq0guxQopPopOwnSPM2t6iy7syn2fcFtC3WG6hP4qte87AvX6w
	dqzEMIItSZLpWmuOX67Act5+nZc5BWlrmMccm/+PkgLWHAG/V4
X-Google-Smtp-Source: AGHT+IHQyUK4Su6rUoIp8KEg7T5eItbPyqxA7l8hrPET/61ltVWDpihHlU5m2GmVndigldsxCL/WvQ==
X-Received: by 2002:a05:6000:400a:b0:428:3bf5:b3a3 with SMTP id ffacd0b85a97d-42b26f4bb54mr1102527f8f.1.1762511109312;
        Fri, 07 Nov 2025 02:25:09 -0800 (PST)
Received: from ?IPv6:2001:818:ea56:d000:94c4:fb0e:28f:2a8d? ([2001:818:ea56:d000:94c4:fb0e:28f:2a8d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42ac675caecsm4523252f8f.30.2025.11.07.02.25.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Nov 2025 02:25:09 -0800 (PST)
Message-ID: <9aac9a66c02c691e073043f918fef055dca888e9.camel@gmail.com>
Subject: Re: [PATCH v3] iio: trigger: Fix error handling in
 viio_trigger_alloc
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Ma Ke <make24@iscas.ac.cn>, jic23@kernel.org, dlechner@baylibre.com, 
	nuno.sa@analog.com, andy@kernel.org
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	akpm@linux-foundation.org
Date: Fri, 07 Nov 2025 10:26:10 +0000
In-Reply-To: <20251107020200.6285-1-make24@iscas.ac.cn>
References: <20251107020200.6285-1-make24@iscas.ac.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2025-11-07 at 10:02 +0800, Ma Ke wrote:
> viio_trigger_alloc() initializes the device with device_initialize()
> but uses kfree() directly in error paths, which bypasses the device's
> release callback iio_trig_release(). This could lead to memory leaks
> and inconsistent device state.
>=20
> Additionally, the current error handling has the following issues:
> 1. Potential double-free of IRQ descriptors when kvasprintf() fails.

How? If I'm not missing nothing, your patch is the one bringing the above
issue.

> 2. The release function may attempt to free negative subirq_base.

Same question, how?

> 3. Missing mutex_destroy() in release function.
>=20

Mostly important for debugging mutexes but not super important.

> Fix these issues by:
> 1. Replacing kfree(trig) with put_device(&trig->dev) in error paths.
> 2. Removing the free_descs label and handling IRQ descriptor freeing
> =C2=A0=C2=A0 directly in the kvasprintf() error path.
> 3. Adding missing mutex_destroy().
>=20
> Found by code review.
>=20
> Signed-off-by: Ma Ke <make24@iscas.ac.cn>
> ---
> =C2=A0drivers/iio/industrialio-trigger.c | 11 ++++++-----
> =C2=A01 file changed, 6 insertions(+), 5 deletions(-)
>=20
> diff --git a/drivers/iio/industrialio-trigger.c b/drivers/iio/industriali=
o-
> trigger.c
> index 54416a384232..7576dedee68e 100644
> --- a/drivers/iio/industrialio-trigger.c
> +++ b/drivers/iio/industrialio-trigger.c
> @@ -524,6 +524,7 @@ static void iio_trig_release(struct device *device)
> =C2=A0			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 CONFIG_IIO_CONSUMERS_PER_TR=
IGGER);
> =C2=A0	}
> =C2=A0	kfree(trig->name);

Not that this is a problem, but now you can actually get in here with trig-=
>name =3D
NULL. And typically that's not a get pattern for your code.

> +	mutex_destroy(&trig->pool_lock);
> =C2=A0	kfree(trig);
> =C2=A0}
> =C2=A0
> @@ -575,8 +576,10 @@ struct iio_trigger *viio_trigger_alloc(struct device=
 *parent,
> =C2=A0		goto free_trig;
> =C2=A0
> =C2=A0	trig->name =3D kvasprintf(GFP_KERNEL, fmt, vargs);
> -	if (trig->name =3D=3D NULL)
> -		goto free_descs;
> +	if (trig->name =3D=3D NULL) {
> +		irq_free_descs(trig->subirq_base,
> CONFIG_IIO_CONSUMERS_PER_TRIGGER);
> +		goto free_trig;

I think now we do have double free of irq_free_descs(), or am I missing som=
ething?

> +	}
> =C2=A0
> =C2=A0	INIT_LIST_HEAD(&trig->list);
> =C2=A0
> @@ -594,10 +597,8 @@ struct iio_trigger *viio_trigger_alloc(struct device=
 *parent,
> =C2=A0
> =C2=A0	return trig;
> =C2=A0
> -free_descs:
> -	irq_free_descs(trig->subirq_base, CONFIG_IIO_CONSUMERS_PER_TRIGGER);
> =C2=A0free_trig:
> -	kfree(trig);
> +	put_device(&trig->dev);

Yes, device_initialize() docs do say that we should give the reference inst=
ead of
freeing the device but I'm not see how that helps in here. Maybe initializi=
ng the
device should be done only after all the resources are allocated so the cod=
e is a bit
more clear... But doing it like you're doing just means that we might get i=
nto the
release function with things that might or might not be allocated which is =
a pattern
I would prefer to avoid.

- Nuno S=C3=A1


> =C2=A0	return NULL;
> =C2=A0}
> =C2=A0

