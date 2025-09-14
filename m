Return-Path: <linux-kernel+bounces-815576-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id CC959B56866
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Sep 2025 14:13:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CFFAA4E1381
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Sep 2025 12:13:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCA0C247287;
	Sun, 14 Sep 2025 12:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yq+GNMsA"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 965FC1F8728
	for <linux-kernel@vger.kernel.org>; Sun, 14 Sep 2025 12:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757851978; cv=none; b=L2P2dyhe3MRhdLcs0BuCNeuGXj3O5mPwrF89mf5nFoRiO6jTcwg+8u76k5emaLcMWZes96ErVJ5XaRL0chzrmV9vn7KxZjNoLje3OydNszlEuqaX/WJ0eom+wQVRtKDNBCQm9G0L+LZ1p7GAqDi7gWt1NhPfX4L0dZV+wE38nb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757851978; c=relaxed/simple;
	bh=S18Nk/t4XHFpCMqoHzbNFyX8hx3rWcnESm/Q9vJKcIw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UrSXoUIeFQlIJ3ZGji/38JDZIJKVXVoOH8GFvVZ6pfclHOpePZvrC+HmvSueGJEagwSG4UaNAlFne2NmhXoHgI76QrA1BS4lqoI2LuVtC/A/mDvIzT4H2Ez2dnoDgbtElCgT106XdpYo2XKMnktpNOQr9dwtmMRSBdJSHbwDfHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yq+GNMsA; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-b0b6bf0097aso129927666b.1
        for <linux-kernel@vger.kernel.org>; Sun, 14 Sep 2025 05:12:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757851975; x=1758456775; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E1cTWAXE/bpvy6KSJJ5Ye7rEIskUL2V9bppKI05b4W4=;
        b=Yq+GNMsAzLRl36zaRWX+IFale1uE/j0jMO6w4w2XdRdldtV85lJ0mLlD52WI5Ez1uY
         TGeOILrZHVdk06KWWc7pp1j72bPSpUMG96nCwGgG3Jvx2BO9uM+H0sVivxIYq0NehwVj
         rdlNa5At+GyG/IZyuWycD/zgkVCnTjj0Iwjg4mMwZuQrNuA3e0DR8he5r/7TkHy51Owr
         FuWpzI017RHZnFRB5FezuLMyAiOq0vQgyhNO5/Nvqs02HcajbCjVrP3yiZqhXV1O7z0Y
         BvjvqSn5i9JYFBeWUK+fzpul9t7g0SHEfUXW3dNlV+1C0x02JyOuX4GzEOHYHR2ragV9
         2EsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757851975; x=1758456775;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E1cTWAXE/bpvy6KSJJ5Ye7rEIskUL2V9bppKI05b4W4=;
        b=kKVDJEy37HQeC7Sxt8NCtdTWuiYa5vOSi3WH7mb0ddZQCc5zmGFk/+9yRn4v3j93HN
         BTJKLDLJqyxnlB7WL/Xy+QGJB8XEsSu8OIOp66DxpJrVOEzbL93v5WCTRBdL6jW4WamR
         7RuOFGwWY2uOQ6nXIpMeXutHW83+thK+rVnpUbYEnaf7ER7uklK/9S4lxmprPhe46Inh
         x6bJY1cz6ijMrxBtECddSo/vyOwhbOcFAqgaRqA+EokgJ3FdSHDYppUTiul5FlAxg+aH
         8Qe3pFgP81Xm0ATWqU5/Tcsx7mQfP6jA1J0accn7i/AkMRkRKRrJ5VzHnHd8hxnmz78d
         +w9Q==
X-Forwarded-Encrypted: i=1; AJvYcCWCxur87POOTmohBFJrRvwgaYAs7nXcPyKIQVrOh7aojhTRaXiNpAp6wm10CEK0zkm50WMtaAT2twEPRRI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHe0uOxiKram2+RVDYfq5uMKyqqzubdvvHi/47qXQmaBVAi1mc
	lVaHG+1AWmKFh4PPB81yxx9YF41T8O71xgNpjU+w+u2Ze23jco95abCA55nVyjdxz6zToHjVv+h
	wxnBuwWqR9uEMg65d4GptubYP/qHv+yo=
X-Gm-Gg: ASbGncupaHrYcPZJZJ6GAVFWujSyP+YW1OO4pJWDPUHKltnAmr9Q46RGeRfNxmVh8Mk
	HN+bPHXjBmmktOjqVNRMA5t18MQ/ifrv+qhU2zyxkdb0DsOB6jYIhMj2bnquU6Z/s8+etniDTq0
	wOeU50BBPo0jjZNMTMs+nmXa8WrkPLM5ycd0dDfyUOjyHU7XrJnMvPW5+Onn0y9ZNdCSgpEXAPS
	cMgPcr7m4/GiHqKdA==
X-Google-Smtp-Source: AGHT+IHMOD2r7oAjScFXqQAfquD6e1GHazsoKOYP9hLU4ZZbkB66vBGtSq7JioFLu/7nG8DWg1Or/mHgUYhNFlN5UHA=
X-Received: by 2002:a17:907:8689:b0:b04:84db:c83 with SMTP id
 a640c23a62f3a-b07c35ccf80mr943803966b.27.1757851974805; Sun, 14 Sep 2025
 05:12:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250913-b4-bma220_improvements-v3-0-0b97279b4e45@subdimension.ro>
 <20250913-b4-bma220_improvements-v3-15-0b97279b4e45@subdimension.ro>
In-Reply-To: <20250913-b4-bma220_improvements-v3-15-0b97279b4e45@subdimension.ro>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Sun, 14 Sep 2025 15:12:18 +0300
X-Gm-Features: Ac12FXxE_8xmiRPoeELPTlFvORzOiFwPn-3LteckGMnSFCYCcRucG6K_zqiQ6tA
Message-ID: <CAHp75VcTY_Mks6AvTXBtOefy8PTomMk+ZvgeVEKby8-B_RnZ3Q@mail.gmail.com>
Subject: Re: [PATCH v3 15/18] iio: accel: bma220: add interrupt trigger
To: Petre Rodan <petre.rodan@subdimension.ro>
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Jonathan Cameron <Jonathan.Cameron@huawei.com>, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 13, 2025 at 6:40=E2=80=AFPM Petre Rodan <petre.rodan@subdimensi=
on.ro> wrote:
>
> Add interrupt trigger.

...

> +static irqreturn_t bma220_irq_handler(int irq, void *private)
> +{
> +       struct iio_dev *indio_dev =3D private;
> +       struct bma220_data *data =3D iio_priv(indio_dev);

> +       int rv;

Be consistent with the variable namings. This sounds like 'ret' to me.

> +       unsigned int bma220_reg_if1;
> +
> +       guard(mutex)(&data->lock);
> +       rv =3D regmap_read(data->regmap, BMA220_REG_IF1, &bma220_reg_if1)=
;
> +       if (rv)
> +               return IRQ_NONE;
> +
> +       if (FIELD_GET(BMA220_IF_DRDY, bma220_reg_if1)) {
> +               iio_trigger_poll_nested(data->trig);
> +
> +       return IRQ_HANDLED;
> +}

...

> +               ret =3D devm_request_threaded_irq(dev, irq, NULL,
> +                                               &bma220_irq_handler,
> +                                               IRQF_TRIGGER_RISING | IRQ=
F_ONESHOT,

Why is it okay to override firmware provided IRQ flags, please?

> +                                               indio_dev->name, indio_de=
v);
> +               if (ret)
> +                       return dev_err_probe(dev, ret,
> +                                            "request irq %d failed\n", i=
rq);


--=20
With Best Regards,
Andy Shevchenko

