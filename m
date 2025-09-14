Return-Path: <linux-kernel+bounces-815605-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D85ACB568E4
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Sep 2025 14:45:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F74217C8AE
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Sep 2025 12:45:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 561DA25A2C6;
	Sun, 14 Sep 2025 12:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LVbpOZFE"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A48C19047F
	for <linux-kernel@vger.kernel.org>; Sun, 14 Sep 2025 12:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757853946; cv=none; b=Jqsz53c6ah9LLRHZMgEGc8lnRH2ckUGxYGhJ+dZQjkYkQhORACFtlilK3f+KLO44SnKC1CKli8NyLuup3HK+MEweE6JLSU9h7It5RlSWvAH/6UioaBGfYC3EbqgQmfYSQtt9dFfJmmLUTYdiHq9YMikZ3UKSG54lpsW32gaZkjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757853946; c=relaxed/simple;
	bh=hTT0SFWXVYmSef6AqsI8baV89m/pERrVDm3JwL+1MTE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=k/htgnZMYHIMnSga6GmMLeccb+S131wEyYEsrALjk43O3wcGMhDLbpt97CVF419SpCv01eEYZLhZqDnQTvpdZJQviMijbWZEGJ33S9WeCXa+4Tuuz4TDhfYpnTDrKjteaMu4Pxh13XjQCFgqaA7Hx16ZOQagEMBZa+XS2tF+NUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LVbpOZFE; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-b07e3a77b72so165078766b.0
        for <linux-kernel@vger.kernel.org>; Sun, 14 Sep 2025 05:45:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757853944; x=1758458744; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1wdmRHEmAHVOSBOBrzxtz578ieX6gx4KLEDwDT/YqvE=;
        b=LVbpOZFEEVE3i/nwroD+2J/mPdfK9bULqf7cWUCp6Lexu722p7EP5bOwKFjFgzbHZU
         X6Cauv10NPxOs1mcPwjbi87NDb/T9cQjh3/OXUFl+5u/Jb9GZtdjSR/5jEWN4SHDx5PD
         /Nu17mEL9TbXCo4WHcYq5nF8sqNPblILyCvSO8fYXG33EIVXKT12wgzpvcMT6zZENqcj
         FmvvIHoruQLFpHM44cCFJn0G8yI7CjVgcgJ+YaFhftrUwM0mugruqvPAKP0ix3Z2b37u
         w6iOgHVcF6sq5w5YDQEH3KWhzc9X659TfZ+cYRDHiruCMYbpE4+0HR3xDDLE9LUulNoK
         Wi8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757853944; x=1758458744;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1wdmRHEmAHVOSBOBrzxtz578ieX6gx4KLEDwDT/YqvE=;
        b=CMsJ8W04GWPchutHYPMzGiDgFzkJvuU5R0u3S9pOiflKcqCfIb5kyhopQhSCrmuL8d
         DaM21KZRYgNZ8wsOwujwDCmo0gi6SPnEcMU5yUHhpWRgEpFZSTcTBMKxIEP+XIIOYoGK
         BYom6vhXaEfUXF+YQNlm56LVN/roqnkerVRmgd0hXjfYgH+M2QXkvoMixDLghA459g0u
         tO2UVFxzRhkxzcSOKRYh1e89vwGwW0u0ONDd818+e427krdvv77JEolDmkPM8wQLJw+P
         lM36WYFMJILK7UuyXB/nD5C7lwnVE6Ne1Z/222F87hBnMXd9NpzEML7DhDK8YV5g/Wh4
         QFpA==
X-Forwarded-Encrypted: i=1; AJvYcCU1d15O/4jIOS/XV0jUwy38/3qG6uRARThbAdWQoAMCmVizVAsG5LdtjfFMmVIw7HwFJXqWu1oyvgmIB4A=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGUXJGZzuUSvAi1G3qUXsXwktZl8sDSTrl5ctgGJN21YhYQNaQ
	L6E1g/CrwNkTpkiz+w4LHbv2UsbPnVnK2aRu7uFANuqElQaYSBPqsP3t2bCxaXNL5QpYCSMljv3
	qmC5fNXoDdTWsxhC+xOF6MNfCPC3H2tQ=
X-Gm-Gg: ASbGncswdji9+Fz3mQB08X6nLBjBIt1EeLK82t3rekgapV0eICb7vA2u4c1fQP+m4YG
	NEtdqAi2Nr8BJim70xQihH+TAD7xeWgZSAQKsV0SfaQJs7E9FT1cgn6p+8+hnSBXpk2WnFCjPsJ
	4UkO48pIvDjtKOzTzqFFg4a/9vFD66qgTXr51XXvwQFJlk0HL5h91Vn5YindI+ED4ifdHtc7wO6
	G9mFME=
X-Google-Smtp-Source: AGHT+IEtfEan91BALs4Po9c+RE6VwouyDUghHj04bkj6Irc6eJvUcqzIE7KC/tkf9+pU07wCJjDUSRRePBYiNRi1ayU=
X-Received: by 2002:a17:907:608b:b0:afe:159:14b1 with SMTP id
 a640c23a62f3a-b07c2302760mr1089960366b.9.1757853943565; Sun, 14 Sep 2025
 05:45:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250913-b4-bma220_improvements-v3-0-0b97279b4e45@subdimension.ro>
 <20250913-b4-bma220_improvements-v3-4-0b97279b4e45@subdimension.ro>
In-Reply-To: <20250913-b4-bma220_improvements-v3-4-0b97279b4e45@subdimension.ro>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Sun, 14 Sep 2025 15:45:07 +0300
X-Gm-Features: Ac12FXyS6574oAs_xIOxLkg4nz_Mzu_EFU5Y9RC5k71xM2adfDrxksktzqJ0jnw
Message-ID: <CAHp75VdWQojOj2MLS4dOvMKjSGcAunc4ND9SPsGrZBBctPdQgQ@mail.gmail.com>
Subject: Re: [PATCH v3 04/18] iio: accel: bma220: split original driver
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
> In preparation for the i2c module, move the original code into multiple
> source files without any other functional change.
>
> Create the additional bma220_core module which currently is not
> providing an abstracted bus type (this will change with the regmap
> patch).
> Fix checkpatch warning about GPL v2 license in bma220_spi.c.

Wny not a prerequisite fix?

> Fix a few includes to make the change functional and prepare for the
> next patches.

Ditto?

...

>           To compile this driver as a module, choose M here: the
> -         module will be called bma220_spi.
> +         module will be called bma220_core and you will also get
> +         bma220_spi if SPI is enabled.

I'm not sure the last part is practical, as one needs to list all
buses next time a new one will be added.

...

> +++ b/drivers/iio/accel/bma220.h

> +#ifndef _BMA220_H
> +#define _BMA220_H
> +
> +#include <linux/pm.h>
> +
> +extern const struct dev_pm_ops bma220_pm_ops;

> +struct spi_device;

Besides the location of this (I would expect it to follow up include
linux/*) convert the existing driver to regmap first and remove this
unneeded churn.

> +int bma220_common_probe(struct spi_device *dev);
> +
> +#endif

...

> +#include <linux/bits.h>

> +#include <linux/kernel.h>

You should not use this header.

> +#include <linux/mod_devicetable.h>
> +#include <linux/module.h>
> +#include <linux/mutex.h>
> +#include <linux/pm.h>
> +#include <linux/types.h>
> +#include <linux/spi/spi.h>

...

> +       /**

Do not inherit problems from the past.

> +        * The chip can be suspended/woken up by a simple register read.
> +        * So, we need up to 2 register reads of the suspend register
> +        * to make sure that the device is in the desired state.
> +        */

...

I haven't reviewed the rest as I believe it's just ~1:1 copy of the
existing code, but I still think that the result will be better if
this series starts from small fixes, like kernel doc, and other
things, followed by the regmap conversion and only _after_ the split
is made.


--
With Best Regards,
Andy Shevchenko

