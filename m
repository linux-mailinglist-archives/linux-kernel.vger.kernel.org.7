Return-Path: <linux-kernel+bounces-890256-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 445EEC3F9F0
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 12:02:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 84C5A4F1718
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 11:02:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75B1831AF1D;
	Fri,  7 Nov 2025 11:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rVv4kHIN"
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 115E52E7166
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 11:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762513322; cv=none; b=ZvVGPBHsL8zdN878OfIXj7wnjmDh/AP9kJ/5mML/Lm2XJzJrVpetovfp0sgnXrs5kX0oEU9LVBJVGb2244Wme7FFjwyDbCXUTWFAjmWpyK/VXDLr0eV0ZnHnkPh20Dt9Or7+Cbq94Lh8ax050pVP45LScHSRftx/9nDsxp2X/+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762513322; c=relaxed/simple;
	bh=oIe/oaHgQwNjBV5UTPEvhpn/AHX5Js+8Yh8l+CiK11M=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YTyawNGetAemcd53vUpR8ce3C4ifnaioAjmbjRibvdSxtwLptWsp2sNp3u2iZ9octJR8T7ZX4iillHfrc/utYOKnehtAmjv86cNd4bE3D0/WpwcFyByNO4ZuCI99Is/0/xe2elyo24wN33iKTRohfHX9lMzWk92UKxUa4iw9Bx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=rVv4kHIN; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-64034284521so1001239a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 07 Nov 2025 03:02:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1762513319; x=1763118119; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=oIe/oaHgQwNjBV5UTPEvhpn/AHX5Js+8Yh8l+CiK11M=;
        b=rVv4kHINydsSw5IBxFuk3qlNgHkvkBkaRPEzwdK24tH5a2QD1M34a+wWmKgUxem+al
         6SwFEPxUslc+5/VIhjUll2mPf0VetI3ofBq+up8ZnNr0reeN8vr1OPgIhjRKDVS2u7dK
         HDOE6yBjg9WdwELGArqjSgOHHIE5qsMLKDdmnZ+H/rrDsKQh6jcolioUP94DZ050CAzV
         RF91F5TXTZrhulKybVlkP3YUn6L+4m4+f2rJjHwKUV/0tlDjiC0NJMWrK5XlSt5HPxva
         NCho4CJj9t7Yaxnbx4rDgXtn1v+BPJtjd/1GksYbTbx7pjSktOrdh5ASMagsOSgKx0U7
         tJGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762513319; x=1763118119;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oIe/oaHgQwNjBV5UTPEvhpn/AHX5Js+8Yh8l+CiK11M=;
        b=mesRFkpLDmfznUZeEO1hys0I4xDFq/rFAjPsM9SW0eoK99n3fi0YBWPoa5tWH7LN+S
         6PcMTP3jbcOQpNkeVreSV4JBbUictIw7IjHG/hjv8aw0uj44SCvv8w3JhLg4qEo/yLFz
         pIba9U69gIoN8LfvtVwb98tRO0Bbmk3wIu+HT3wRMx6ZdgWFzHrf8iFH559xBBP6j6f/
         J4xTZWVhAjhQEbAEI5UrRrcPowfU9R6tPy7unDtrx4mjMpiDwrjn/8RQYOSeF5B8DlOy
         YVd+l5lNaLGS7EtB9ZBD6l9COiu+q8xOR314TioK8zHMfxrZUIuN47U+dth2dGW6tEzG
         X1EA==
X-Forwarded-Encrypted: i=1; AJvYcCWRTIfTFpm8CnAMso6+pAUCJ/DJQibprtywt8834HIWqZ0LWTrxKYoZu96uH1+W1wm8qt7BbTI6iYbu2Xs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzsKc7Ovy1Z96BKcj4P6+c9Yl26Njp3Kj8gJo91C8h2kLJax0+n
	ahdhty3CU00W4E6TpEaS5+NXAfuyH1+5BfvGjwTf/AVYL9ggMeHyactLm7dVmWPGRiI=
X-Gm-Gg: ASbGncuze/KiYAXISQkHGUJCZ2Cr6QO8CJ7nhQchdm/5In8hTotskmgM8MwdkrNxRKx
	1AZg2hk7PGCjpKgzeOd0OwgTkgizaYRx8iLNlxf8JMQGy0e0YcFnU2Ena9K3qTcllP00AKSW7GS
	if3AZSJZcLl/ucD/V7BhQ5oZRB28KuldzsW7an54O5+awhHpita7luO60vzCT7omoxO6kcPUjo1
	aRnUtvB9d6injX+DwjuuFay2UNq5qjBmerMGgPG3wbx/7Bm0FWusk7fPd+sjALCeEYu7hurZorb
	d3CaCqLjfJh25lD0NeqzRWy0yqDVci7X8EHSVm48dEk5oufJJsy6mkG6X6bz+ayUG72q52yuMlL
	MUP9r6OxuAKgobbDpyfVQG/wg3Ksi79i8rxhR9BjfY+ze89N0xHTAS7MAL3WMulAloSD79dNu/Q
	EjDVhVCS5GxFtMOf/exmSl5mpK5B1TXi6aLQ==
X-Google-Smtp-Source: AGHT+IFk0e/C96dMXnjyE1xo1+GSR/mT2N99AaE/c44DQdiQ046jLT2uBYcSUl46ZYSZfSsKq3vwBA==
X-Received: by 2002:a05:6402:1d55:b0:640:980c:a952 with SMTP id 4fb4d7f45d1cf-6413eed163dmr2286341a12.11.1762513319349;
        Fri, 07 Nov 2025 03:01:59 -0800 (PST)
Received: from [172.20.148.133] ([87.213.113.147])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6411f713a7esm3841624a12.7.2025.11.07.03.01.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Nov 2025 03:01:59 -0800 (PST)
Message-ID: <729dcf73a1c3d03ca2b22dd278cb0bc502b6b7d5.camel@linaro.org>
Subject: Re: [PATCH v3 02/20] dt-bindings: mfd: samsung,s2mps11: split
 s2mpg10 into separate file
From: =?ISO-8859-1?Q?Andr=E9?= Draszik <andre.draszik@linaro.org>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Tudor Ambarus <tudor.ambarus@linaro.org>, Rob Herring <robh@kernel.org>,
  Conor Dooley <conor+dt@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>,  Lee Jones <lee@kernel.org>, Linus Walleij
 <linus.walleij@linaro.org>, Bartosz Golaszewski	 <brgl@bgdev.pl>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Peter Griffin	 <peter.griffin@linaro.org>,
 Will McVicker <willmcvicker@google.com>, 	kernel-team@android.com,
 linux-kernel@vger.kernel.org, 	linux-samsung-soc@vger.kernel.org,
 devicetree@vger.kernel.org, 	linux-gpio@vger.kernel.org
Date: Fri, 07 Nov 2025 11:01:58 +0000
In-Reply-To: <20251104-armored-vehement-boar-55bde4@kuoka>
References: <20251103-s2mpg1x-regulators-v3-0-b8b96b79e058@linaro.org>
	 <20251103-s2mpg1x-regulators-v3-2-b8b96b79e058@linaro.org>
	 <20251104-armored-vehement-boar-55bde4@kuoka>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-2+build3 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Krzysztof,

Thanks for your review.

On Tue, 2025-11-04 at 09:26 +0100, Krzysztof Kozlowski wrote:
> On Mon, Nov 03, 2025 at 07:14:41PM +0000, Andr=C3=A9 Draszik wrote:
> > +properties:
> > +=C2=A0 compatible:
> > +=C2=A0=C2=A0=C2=A0 const: samsung,s2mpg10-pmic
> > +
> > +=C2=A0 clocks:
> > +=C2=A0=C2=A0=C2=A0 $ref: /schemas/clock/samsung,s2mps11.yaml
> > +=C2=A0=C2=A0=C2=A0 description:
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Child node describing clock provider.
> > +
> > +=C2=A0 interrupts:
> > +=C2=A0=C2=A0=C2=A0 maxItems: 1
> > +
> > +=C2=A0 regulators:
> > +=C2=A0=C2=A0=C2=A0 type: object
> > +=C2=A0=C2=A0=C2=A0 description:
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 List of child nodes that specify the re=
gulators.
> > +
> > +=C2=A0 system-power-controller: true
> > +
> > +=C2=A0 wakeup-source: true
> > +
> > +required:
> > +=C2=A0 - compatible
> > +=C2=A0 - interrupts
> > +=C2=A0 - regulators
> > +
> > +additionalProperties: false
>=20
> You need a complete example here.

Patch 7 adds / updates the example for these to the ACPM binding. I can ext=
end that
example, but I'd prefer to keep it there to give it a bit more context. Add=
ing an
example here would duplicate things.

Do you agree to that approach?

Thanks,
Andre


