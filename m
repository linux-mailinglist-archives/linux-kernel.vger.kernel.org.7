Return-Path: <linux-kernel+bounces-850583-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 62F9EBD3381
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 15:34:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD2BB189D6A4
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 13:34:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D6FF307AF4;
	Mon, 13 Oct 2025 13:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Il1iOi1K"
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 931951547D2
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 13:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760362432; cv=none; b=QMoo7v3wYqsxAOY6c7EnLTPFeR273F/RjPBLX2wAh9NIC0metRGbuen1kr6IlQVevTQGJJO2FE+6Pe5SOBxNEGNOVZD0Du/+GKjUYV296Vbjd2EwiUdeDNqiKpxRaFM46eyF3u63W8H/cV1q+DhaS1B9msHjGW8m1rR2+jLb8us=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760362432; c=relaxed/simple;
	bh=H2juMaGdKsnPU2tLSraoa5b9/EA9CP4IrGvXhZXInKU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BBzwfDgaXpJVQFi0VHKBVwhjJbiGcDSRNKPyaiB6ibPLh1p2HNRlAmS9eUYRU3kNNRVqnRS10fvidsbgOsWQrq7DrpzLqUWw2nO4sO91sCt6CfZKCrJkrB207sTRJfuEhMwYOC1RDNNef2OX457KYT5RszkdenwQ+2q3MV1TeSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Il1iOi1K; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-36527ac0750so34700721fa.3
        for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 06:33:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1760362429; x=1760967229; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n2vv6Elqb0iIv4dJrDSGaSWX9dF6LnvkTkr6vnIRmSI=;
        b=Il1iOi1Ke9mYn701Z3hZ9CwnowgWOxGNyHtLZczDfTGk3SDf1bsRREX20pRJ1b/qub
         D70NGVCu5bdGNCXlryDUrR0bMHEek6Zf8cVAz4BL34WHhMLMyoujyF+/xsNUe+myqyiE
         CnDbbD9JZTAM1b0t8jB8i4IBIDUvpUVg8Jcw6CVHaoqu1QqMvFRqxQWzSs9iac90IFOU
         eAbr7KHm7pqKOulO1+tEEnCfL0uA12f0DvfRPSJEJ7g9fswOoFoO4Tc2VUAD4mCtHxs7
         T2CgwZLipX8IRMP0lbFP/sg8xJjtHY18E9xDctka1VR7+QUm1yUTgbso6Ko2V70zg43K
         vjqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760362429; x=1760967229;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n2vv6Elqb0iIv4dJrDSGaSWX9dF6LnvkTkr6vnIRmSI=;
        b=xQSeQTC6fMKIDrI3MOjDa5wjmb/eFZH6BQ78ddH/S0KQO+5LFFYvrswNl0Je+/gQ5t
         0j0mkJqLSAE9WzIBTqQFiQt2KkqyK7Bz/+EcpxXjZF0k2v8ikLqvEu83tOvCr4UcC2M6
         DYETlxPcOkn02zQjeB5qLZjVRHn5mptTWfMmgSJezpuo14NrLHU+RcX2o3vD8zw5m5f2
         oUcRdnFF05ecs8i3qbIU/RH690or2e89Uw2HoL9A5teZU8ZupMEIEpQ4nAg1V/cEzbHp
         gkuHV9z1r+uBHtRBYH0EdPavxQ8k0VS/yxAWzGkVKH06QCRm9ZF4KkT8CeK3h2TBhKcG
         tYNw==
X-Forwarded-Encrypted: i=1; AJvYcCVODpn7lWBwyDixJp2W4ETvxgws/e4MKRIpdcBVCF2teQCWSQB8G41oMRgsWN5NHuI3euoYqzCkuqDLQz8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFuKHV/ZeQSeHr2ZRizIsowhmMjJOXw9y6+/OQOGp4gMskBl1+
	pf63fsKE1E5CihohuaCLhMFu37cjqnxlsaa/PCn8B3a7vP5FFvJCReDHHjAJykUtNlekge+7iaV
	ArC3qKys02VDbA4DOlM4u2PGiALsriySft17JuEVuug==
X-Gm-Gg: ASbGncttYV+Ta18VyVK7N6JnmBX+9C92hjxMY4iavNWDPDvEAeZapZ4Jlgg2CwKdHZ7
	leLrrzc18fKhBxdHY49w3mKiMSEC2tmeLYUHUBoDFVXX5g6XReKPYiqIoNYELIqjt0hptAeYm1x
	oVpiYolLZGgcrOiX1mbqR4RW8G9MzBS2N8afxbsujzPkLE8pAs2bFHFl6yemkjVvV8IyynIscQX
	+03KSKMrfUku6XMLanoP2qRLfl+OpNjlemGYwvm
X-Google-Smtp-Source: AGHT+IHgmK1HRnpsjGLKqPnG70DMAC1goUv3OwVcHtnyu/bV4k7lGHTS4AnKXk+tRstKPxroMpvqgq8QwqZeDkRf4ek=
X-Received: by 2002:a05:651c:1ca:b0:36b:8361:15c7 with SMTP id
 38308e7fff4ca-37609ee797dmr52547101fa.42.1760362428700; Mon, 13 Oct 2025
 06:33:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251009222716.394806-1-shenwei.wang@nxp.com> <20251009222716.394806-4-shenwei.wang@nxp.com>
 <eb99d9a8-eb96-445d-899a-6e1d9b6f6c69@lunn.ch> <aOk0y8xTi9hoGvyX@p14s>
In-Reply-To: <aOk0y8xTi9hoGvyX@p14s>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 13 Oct 2025 15:33:36 +0200
X-Gm-Features: AS18NWBC-gdxliFCyTe38OsztEkF4HyZ8vB9ddnx1Arh4R638fPWDwBoKXMNGso
Message-ID: <CACRpkdaTp4SPj1DvJUD+ThBuQRrK+0ciVE0j92P9_c7EVvF0Jw@mail.gmail.com>
Subject: Re: [PATCH v3 3/4] gpio: imx-rpmsg: add imx-rpmsg GPIO driver
To: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Andrew Lunn <andrew@lunn.ch>, Shenwei Wang <shenwei.wang@nxp.com>, 
	Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
	Bartosz Golaszewski <brgl@bgdev.pl>, Pengutronix Kernel Team <kernel@pengutronix.de>, 
	Fabio Estevam <festevam@gmail.com>, Peng Fan <peng.fan@nxp.com>, linux-remoteproc@vger.kernel.org, 
	devicetree@vger.kernel.org, imx@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-imx@nxp.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 10, 2025 at 6:31=E2=80=AFPM Mathieu Poirier
<mathieu.poirier@linaro.org> wrote:
> On Fri, Oct 10, 2025 at 12:58:38AM +0200, Andrew Lunn wrote:
> > On Thu, Oct 09, 2025 at 05:27:15PM -0500, Shenwei Wang wrote:
> > > On i.MX SoCs, the system may include two processors:
> > >     - An MCU running an RTOS
> > >     - An MPU running Linux
> > >
> > > These processors communicate via the RPMSG protocol.
> > > The driver implements the standard GPIO interface, allowing
> > > the Linux side to control GPIO controllers which reside in
> > > the remote processor via RPMSG protocol.
> >
> > I've not seen the discussion on earlier versions of this patchset, so
> > i might be asking something already asked and answered. Sorry if i am.
> >
> > Is there anything IMX specific in here? This appears to be the first
> > RPMSG GPIO driver. Do we have the opportunity here to define a
> > protocol for all future RPMSG GPIO drivers, which any/all vendors
> > should follow, so we don't have lots of different implementations of
> > basically they same thing? So this would become gpio-rpmsg.c and a
> > Document somewhere describing the protocol?
> >
>
> I haven't looked at this patchset yet but I think Andrew's proposal has m=
erit.

Yeah this was my comment on v2 as well :D

I even posted a bug to the AMP mailing list to elicit some attention
from that camp. It worked because now Arnaud is on board reviewing
the patch set from an ST PoV.

Maybe it is possible to split the driver in one generic part and one
i.MX part, so it is easy to reuse for other SoCs?

Yours,
Linus Walleij

