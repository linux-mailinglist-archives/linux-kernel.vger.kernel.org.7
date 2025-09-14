Return-Path: <linux-kernel+bounces-815569-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BFCF0B5684C
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Sep 2025 14:06:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 38559189C402
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Sep 2025 12:06:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66A8C24EAB2;
	Sun, 14 Sep 2025 12:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dl5FykkL"
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B27523A984
	for <linux-kernel@vger.kernel.org>; Sun, 14 Sep 2025 12:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757851586; cv=none; b=OAANnNwS/z8OYaTDapzZUUxO5yNnQ4cp1EpuQdRbs7SGkC/uNygbj1ltD67mhL2WfwPj4/WOj1l5XCbQ/P/BhlqhBL4sGAWooQNQbQA/K5QN0seN+9eypOrxiiljGl7h4WYvFoGgmK9TzGK8Ijw3BSoI+ZGaLDne8WL1la/xiVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757851586; c=relaxed/simple;
	bh=U4ZwaARrhVJRhKGwMnmqzVABRhfraMrOEXvy3azq4WA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Jkcs6uHhw0bI6prC+w3swUKzcVLaFCRD5gqi6iuXvZf1BBcbX1uACeUP7Oxqz/raP0mSlMtx9VLj3J50kaQJ0xch2r0yh9AwCSpsrtbOkFbC/IpMA+XZ3vuENNHVqFHsnihSQW8FfcqDYol7+EjKvuAfn5tCcmjtob2yra25UO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Dl5FykkL; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-62f1987d49fso1421720a12.2
        for <linux-kernel@vger.kernel.org>; Sun, 14 Sep 2025 05:06:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757851583; x=1758456383; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0YLyZ8HqzpH0evIE3A2q6klrMOvuxtmz4l/kw0/w76g=;
        b=Dl5FykkLJH4NA3wlST1FaYCIX2DuJIs10rYIF+vF+Zc9NMXoF1dAtHwrA1LW6iD8gi
         8Jid2/J3U5fMY8DQ9HfG5pyQX2+fAvNLkcROkOMd/bi2UxJhzGSaaoXbLF9CMNFF8bEv
         VrcANhtHsfh2+yC/QNNkSTpj5864YNdP9LbL93klV5faEXB2m+21Vgvfjx2B30zdaQlk
         McyW+N+vtQMgaLCPPZilbFngop/f/eezWhyXU1lY8VUBpNA3hHuzIFbUBE3sAdBH429X
         flqZ98dJ+zOZ+FiBv0Vq0oEp8nHa1BtBpIUyyhBzOxFO3hOkAL7ENvlr0V9lhZsqWxMh
         lMAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757851583; x=1758456383;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0YLyZ8HqzpH0evIE3A2q6klrMOvuxtmz4l/kw0/w76g=;
        b=K8I5zdZj8ascimLt+cd7XQhLOFG5J0CBYPH4qlO27MUbFcAMYk/6iBP1DK4NLxfW9j
         /ADWSVGDPtjHDpwLpjPhCtAmFPYSyAaeG8pmLBp5Q91u/FVTwH3mrmge5Pn7RtaDjsKb
         jK6Ei+2sDYxWjGVreXuNjHQD9XvnYMaOG6jod/It7o3tx8fDnNYolHUiP/wqrWPga2XJ
         m2JjU6Q7DfLB9lYjwdOA2Yk6mESoYs99qKIpWC5LxeI83wr7UHxS9xZwAjWE4zBc64yO
         DKvQSIp1P0ZmI5cPWuAaDZQbWHGmpru8tT0dKRq+t3LnA9iDoo1KlZAIUT2IHV12zwms
         sDKQ==
X-Forwarded-Encrypted: i=1; AJvYcCUzsW4ee3M5pNCZ5hTrIydYzueppab3p0GPXEfYm1TwdGMTYY3LPpQMJIwffXovsRbHynW3phoDGHUVJYc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz25j8fPvKhKSzXLHIN36KztBsrBH40q9SE8C80ndL3I5iAp5hc
	36g+GwoM1kuUOlq3kw/qlSFNoE8oLjGmeP/ctKgP1B9UYVkvYdKTxUH8zWj3HNejn6ReolAY8iX
	mc/3wwENH7uRRF1r/Q8hI3Xj4H7zosCE=
X-Gm-Gg: ASbGncv7B+TcT0vJe8vqHFZfKlzsB0r1NvFMxb5hrbsnpFG/H1wcxX50NtGitJWEnK1
	3YuwuTXdXgN54BzreHgSg9Doccv5/Ya+EcH8AWker9tQOERYwjCkevm+NlXzuIsBtvrwG4FRCpz
	RdB75+kW2BuDOg5WSLGlnziZWNGjBX9zxUXVW3Oli2zxieysaREmY1swWRjFMZrfCGwI0rrwO7s
	kg++odU6OTqI6E6CQ==
X-Google-Smtp-Source: AGHT+IE00u9Vz/nbU03onsaPBDXPOf9Sej8zP0eI2NU1Y77NBz90d/AzKuwkrkiv+XuudBZP445kgkSiTLMmVLwF81k=
X-Received: by 2002:a17:907:d28:b0:afe:93e2:3984 with SMTP id
 a640c23a62f3a-b07c354e9a9mr918694166b.8.1757851583397; Sun, 14 Sep 2025
 05:06:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250913-b4-bma220_improvements-v3-0-0b97279b4e45@subdimension.ro>
 <20250913-b4-bma220_improvements-v3-7-0b97279b4e45@subdimension.ro>
In-Reply-To: <20250913-b4-bma220_improvements-v3-7-0b97279b4e45@subdimension.ro>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Sun, 14 Sep 2025 15:05:47 +0300
X-Gm-Features: Ac12FXzlod_4HW5XsON8nSZC57Q9z1TIkzdx7fKnaT0YVraOiI4v2aOT5pPKdvY
Message-ID: <CAHp75Vc4TUu497JMuU0-bU0aqew9vUXLTDqDoqLMLkAC43Qv9g@mail.gmail.com>
Subject: Re: [PATCH v3 07/18] iio: accel: bma220: move bma220_power() fct
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
> Move bma220_power() fct before bma220_init() since it will make the
> next patch cleaner.

...

> +static int bma220_power(struct spi_device *spi, bool up)
> +{
> +       int i, ret;
> +
> +       /**

It's not a kernel doc, do not inherit the mistakes from the past.

> +        * The chip can be suspended/woken up by a simple register read.
> +        * So, we need up to 2 register reads of the suspend register
> +        * to make sure that the device is in the desired state.
> +        */
> +       for (i =3D 0; i < 2; i++) {
> +               ret =3D bma220_read_reg(spi, BMA220_REG_SUSPEND);
> +               if (ret < 0)
> +                       return ret;
> +
> +               if (up && ret =3D=3D BMA220_SUSPEND_SLEEP)
> +                       return 0;
> +
> +               if (!up && ret =3D=3D BMA220_SUSPEND_WAKE)
> +                       return 0;
> +       }
> +
> +       return -EBUSY;
> +}


--=20
With Best Regards,
Andy Shevchenko

