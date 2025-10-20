Return-Path: <linux-kernel+bounces-860738-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id DA694BF0D41
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 13:27:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D44BF4E9506
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 11:27:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A53E2F617B;
	Mon, 20 Oct 2025 11:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="MEQ/zL/P"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB4A61922FD
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 11:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760959634; cv=none; b=USNcbbq+5ZAPIgBHPNZr8fWz6bUiPVl/FQ2MYelpK/q2c10JMeBVeVEl6fR3LVgyb0EuWK6SQrZcqkE5uISpkMk4CDTkIWowpEA7jw4Iho2W2jAcaPs7xLBFG2fDeZK6j756xkqeg1bp9BUDoah+rjym7bqyzKx5bcLioBpWZj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760959634; c=relaxed/simple;
	bh=wQwaXwcsfbQNWY+bTgc6E4fl7f0YQBbZmM/0LtL4aKA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=g+5IVkcPsgCHVszlDk9RRJuFCJ7AeMzHqBm39q5gviSOkKZteX8/Ba+Paa5BBWIrQmiK6vJ/yTcmdSymhFxBEHttcNfjQr3RqERnHscfh6Tw8ol3RG/iW7Sv84Uunswx1wRhmgnmEZaNfzt+qdV0NJJyI8qs8qde0e2hCGXw0ak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=MEQ/zL/P; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-591c9934e0cso4708271e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 04:27:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1760959631; x=1761564431; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wQwaXwcsfbQNWY+bTgc6E4fl7f0YQBbZmM/0LtL4aKA=;
        b=MEQ/zL/P1ReGHxk5Bh0jEmlfctk/m5IH3TkQJDzqLkNXCHeqjDb1jQvDdcWJcvUP2Z
         ax54OtEGEswXgEEcSgfAgadh40ljLhJpPKVlN1+rWCha28WfXif7r6vPbmHcWtbiDFQ+
         gDpc6KAqeAdg7afFdOesZIVjbSHNXY+CBhHDwU5wDl6AKReby99M8obgMznJjgGBrXJo
         oHzmx7DpZD7IDCd/qwVbPfMdHjUAein8v8CcvMZxbnSeJNEjX1pe03FEvgNr83YaV/u5
         Oi8SH+pAAlaTvJcqnYX+mau+j0h9y1XnaqX2C0tgQnXC/kDQwRMhwNlb/yEOwUVwqqKc
         FO7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760959631; x=1761564431;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wQwaXwcsfbQNWY+bTgc6E4fl7f0YQBbZmM/0LtL4aKA=;
        b=CVV844zQ4YQyJoEVN5I6pBFYXjw7+vWGnEZa15h2H43zq/B0odJA8qrpokQ2hPdrP9
         90uCE5QMDPEvJgCsNqUuRq//4uetIKPAF7QdR/sgr/K3Hr2ruGy/82x3XdhouHpyK1XS
         7jrLXj4YwXD0k3fgu1YmS8rBbpVqWRstdISjGWLfZCvBRSeiKcCPDi2Qot6O5nTlVeay
         ToRcTi5eJ3q2mcRWjI6jmiXJKnF/0TKkgMi+BA5wFpDAb68vZnbWkR/PgCERFo12sBQg
         mOvvNBBZrpfc1OHVl+hDQ7y5C9fBoL8C8Xl7eE2l+SkUuPnTjg3VOnn+o85kNituA8Ea
         IBPg==
X-Forwarded-Encrypted: i=1; AJvYcCXr7QStgvlHyJX6JjS8N4UM4wOODOw+pd28FF/XFaCREWOznbDye7uzS/R2oiLpBMTwVqYDJ2doKc6Gym4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQwinaTS1FG6NDnbTZYLmeIne1BdPTNh0FkY6Czr/yPqVCe8wo
	T6TVb1YvdfPluQN41YcZTSYz6Gpjt2gWuXKm8bvmrPc7yKEjgIZArDV+ZsOwrmACwfmx009OSKz
	Px8K9y57iq2a72syOIAr2OV9Elwm8ZFf5hIBKNK3phQ==
X-Gm-Gg: ASbGnctkfqIAzh4m6Ph/2iQyhkFWii9paJ09ENa5ScXHq2mmNSpEf8RO4HMu1VeioTY
	odVoCs2pgatH7dGFWTUw+tm1S59JRRiVLj0cnK3wjxlNxBTxsKfK5GtxNSjJYR4wtSCVLD9Kne+
	WFE0/qIc6vEh9yyaxS7emzX8Ghymrl3/uQgi721KgGnJyeHgYXCBliaoMFOMSEGmxLR4N70RzU7
	8X7Eu5A+W6EcKJ/UtLnNl6s7LEywQlM2jlo/WnqEXuyxJ78Ju/dKB9ewbjG4fVBZxUNKITLTJD0
	bUIwRoOmutvWkbzYJa2dwA5PU10=
X-Google-Smtp-Source: AGHT+IGalTfddMYmqPUMb4AlapgNAjae0CM9hNu+IF9T0qg8x8cTp34CDOE8QlIQcTGSDLGSSRT9k3sM5LmDBCOqf2k=
X-Received: by 2002:a05:6512:1044:b0:55f:4746:6202 with SMTP id
 2adb3069b0e04-591d84cfe56mr3806231e87.11.1760959631042; Mon, 20 Oct 2025
 04:27:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251006-reset-gpios-swnodes-v1-0-6d3325b9af42@linaro.org>
 <20251006-reset-gpios-swnodes-v1-3-6d3325b9af42@linaro.org>
 <aO1dBgPZfDJTsPfE@smile.fi.intel.com> <CAMRc=MfOoHn+mLRpQBEsC3g5sM=VZBgVffsm68CAXJBHffPxdA@mail.gmail.com>
 <aPYJeqFY_9YV9AQn@ashevche-desk.local>
In-Reply-To: <aPYJeqFY_9YV9AQn@ashevche-desk.local>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Mon, 20 Oct 2025 13:26:59 +0200
X-Gm-Features: AS18NWBbGp8rhOGqx7d1wIA8a09Onzo3YSJmCbDM3PxUzN3ptqkGsqAXJsQs1_k
Message-ID: <CAMRc=McBTgnQXkPoOUYC=PDDwFXuVqfMFuiwZTW7ODb6owJbeg@mail.gmail.com>
Subject: Re: [PATCH 3/9] software node: allow referencing firmware nodes
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, Daniel Scally <djrscally@gmail.com>, 
	Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, 
	Krzysztof Kozlowski <krzk@kernel.org>, linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-acpi@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 20, 2025 at 12:05=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> > >
> > > Can't we always have an fwnode reference?
> >
> > Unfortunately no. A const struct software_node is not yet a full
> > fwnode, it's just a template that becomes an actual firmware node when
> > it's registered with the swnode framework. However in order to allow
> > creating a graph of software nodes before we register them, we need a
> > way to reference those templates and then look them up internally in
> > swnode code.
>
> Strange that you need this way. The IPU3 bridge driver (that creates a gr=
aph of
> fwnodes at run-time for being consumed by the respective parts of v4l2
> framework) IIRC has no such issue. Why your case is different?
>

From what I can tell the ipu-bridge driver only references software
nodes (as struct software_node) from other software nodes. I need to
reference ANY implementation of firmware node from a software node.

Bartosz

