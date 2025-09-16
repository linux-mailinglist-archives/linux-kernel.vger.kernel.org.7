Return-Path: <linux-kernel+bounces-819256-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 524E0B59D65
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 18:21:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 108611892A6A
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 16:21:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A02742DC78E;
	Tue, 16 Sep 2025 16:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FAlF6tEM"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 370FD30C616
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 16:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758039660; cv=none; b=I+6gw6XzaRD9zzP9EKoahFb+tTzfhK8MkF3K3mNQg4HJym3wMig2DEbmGMLtkZ99KW/KhEYD1h9ouug7fzHWnc7bxOBvGMA8W2w6HP1AXkdsKsnRMckHhzhdhb7GkzK2FTsg8Kfuflsd6v8EZf6wEMFzx6p0SBvgojkoTCBRp/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758039660; c=relaxed/simple;
	bh=ulrBpmULpfIvUTZuGDI6k7fL4z+It/qAwTU3sy4JRNA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lcz/M62NlTBJobNokSfDvPtWnf480dPltyQU3KG2RkIr7D64aAVG6/ihEEt90k2xVXayM3xomLLh7PR1nwLXYEtbCEkJsfWDJwWAP3p4G2UvvwmD7zi9JiLCjJaf+3ig98QeHkku7GnvclcUFDwVMjGX9b9H3EPKCYS4+8hlow4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FAlF6tEM; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-b07dac96d1eso2140266b.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 09:20:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758039656; x=1758644456; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ulrBpmULpfIvUTZuGDI6k7fL4z+It/qAwTU3sy4JRNA=;
        b=FAlF6tEMVhLJBRSiGqNvlLzuyefv2GGW/3r4gmVNhxQ2oN703pMr7WRxPba/N1MaYX
         ly9UbOtCDrQsdUnwZflXE2Ftc/3qOJuF+MAfPivUqvGu39nKjZ8AbUv/YnQiDbVcn/Ji
         qKk1zz5uw8ZJRMJHfplWtpERA01Cv52kmzQM57sCd9c6z1cPSRny8/UC4oNbLjGugWCb
         f8JQzy6lZ78kwuzKE7aWa5WHYXekfhFE4Ow+gpZzvvC4Ol4duJSU2dGExPp//kNgmMOd
         0grEIfR70SFZnqM1p5vdPFRSG16S4BS1RZp/XsWbuq6rbxY5gvc5oRcs5i6/slwZ/ySN
         td+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758039656; x=1758644456;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ulrBpmULpfIvUTZuGDI6k7fL4z+It/qAwTU3sy4JRNA=;
        b=ORM0fEm4untcgRUzdrO2EX3TZcA/iLIZ30Lb8HuGbigqWD0IILBQXfN63DBBBXzR+1
         ii07xVLBUvacKvhaj13NAo0+vNY42K7hVbnRrrEUp6mu1q7cPuQ4Mf1QTXmr4YxrmKkX
         54vwo5YOkWk1vPvf2vmIRp3Xu1eRWZGVRRA4kNbQTbSgyVynlmA/xnYXsprIq9V0Kd/B
         L/HzsZNUEQcqL7VkX9tT88AcZlXGsSLKdUUFEJNtLzUWK+4q+VtzlzEIZ9a6mgMfeRqz
         gPrtuI2tlRkuoYTZ8PDv+3RI4UY3MO5EtKkerR0/QQT60Xl6T/dnPvPjR+CfIROfG1oR
         2SYQ==
X-Forwarded-Encrypted: i=1; AJvYcCXzIf5vlHA83ojO/j5mGWBdoAJ0AZv/RXmJpWh3qArHY4zAfN6acCj8yyhK2UWPLADGizi39RQ6h/J5fj0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwM75tOwoQIhu4ed8Z6QlHHxeoecw+JsRzgnRU1hiMVBwYcXr3m
	cJ/WGwuwCsFj72eT35Nl/ofHslPmu0hMzeuVUbcyaWuf1u42gV2UPZvLbKUgp6I1779RDnljPCK
	prBaSVPzq36y239XWm6nuNeNuAq+nuho=
X-Gm-Gg: ASbGnct4zAtfaV3/aNsGnEUeoa/cf9C2u5xpQd1sIzQB/2++YIzwOqignFwrIhjUp/v
	JdMzifvAg/JqiOTfGj9/vcm2IAJXABJm4JJLp4ILO85w6v1rsNPlQmIB8KBoVEZP+I+RjBxqeM+
	Xkh8MvjHY9H3WRCi66yEp6wSLPCrtqhLaQgWfExU5izP+MdFvzVg5kPsUExVtRSm4+ZrWLouqgx
	IJt2o72DpUEyhT+D9Sp
X-Google-Smtp-Source: AGHT+IGA8Hqku61GdN0tv82dLQSpehp3yOORqLZ98SpsQ5y7NQFjpoQmHrSdJ6nWYWpl2lgbZa5OwvxQ8sZ190mW4i0=
X-Received: by 2002:a17:907:3ea6:b0:aff:1586:14c2 with SMTP id
 a640c23a62f3a-b167ea602f4mr354112766b.4.1758039656243; Tue, 16 Sep 2025
 09:20:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250916084445.96621-1-angelogioacchino.delregno@collabora.com>
 <20250916084445.96621-3-angelogioacchino.delregno@collabora.com>
 <t3uk3k4h3l53yajoe3xog2njmdn3jhkmdphv3c4wnpvcqniz4n@opgigzazycot>
 <aMlnp4x-1MUoModr@smile.fi.intel.com> <mknxgesog6aghc6cjzm63g63zqbqvysxf6ktmnbrbtafervveg@uoiohk3yclso>
In-Reply-To: <mknxgesog6aghc6cjzm63g63zqbqvysxf6ktmnbrbtafervveg@uoiohk3yclso>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Tue, 16 Sep 2025 19:20:20 +0300
X-Gm-Features: AS18NWDRlilzMzu6AWDLe7t6r54-DCtwvznfQrFZlMZ-V39YV0OjdaouC0GJw1E
Message-ID: <CAHp75Vf7KrsN7Ec9zOvJoRuKvkbrJ5sMv7pVv6+88tPX-j_9ZA@mail.gmail.com>
Subject: Re: [PATCH v4 2/7] nvmem: qcom-spmi-sdam: Migrate to devm_spmi_subdevice_alloc_and_add()
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@baylibre.com>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, sboyd@kernel.org, 
	jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org, 
	arnd@arndb.de, gregkh@linuxfoundation.org, srini@kernel.org, vkoul@kernel.org, 
	kishon@kernel.org, sre@kernel.org, krzysztof.kozlowski@linaro.org, 
	linux-arm-msm@vger.kernel.org, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org, 
	linux-pm@vger.kernel.org, kernel@collabora.com, wenst@chromium.org, 
	casey.connolly@linaro.org, Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>, 
	Neil Armstrong <neil.armstrong@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 16, 2025 at 6:11=E2=80=AFPM Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@baylibre.com> wrote:
> On Tue, Sep 16, 2025 at 04:35:35PM +0300, Andy Shevchenko wrote:
> > On Tue, Sep 16, 2025 at 03:24:56PM +0200, Uwe Kleine-K=C3=B6nig wrote:
> > > On Tue, Sep 16, 2025 at 10:44:40AM +0200, AngeloGioacchino Del Regno =
wrote:

...

> > > > +MODULE_IMPORT_NS("SPMI");
> > >
> > > If it's exactly the files that #include <linux/spmi.h> should have th=
at
> > > namespace import, you can put the MODULE_IMPORT_NS into that header.
> >
> > Which makes anyone to import namespace even if they just want to use so=
me types
> > out of the header.
>
> Notice that I carefully formulated my suggestion to cope for this case.

And I carefully answered. Your proposal won't prevent _other_ files to
use the same header in the future without needing a namespace to be
imported.

> > This is not good solution generally speaking. Also this will
> > diminish one of the purposes of _NS variants of MODULE*/EXPORT*, i.e. m=
ake it
> > invisible that some of the code may become an abuser of the API just by=
 someone
> > include the header (for a reason or by a mistake).
>
> Yeah, opinions differ. In my eyes it's quite elegant.

It's not a pure opinion, it has a technical background that I
explained. The explicit usage of MODULE_IMPORT_NS() is better than
some header somewhere that might even be included by another and be
proxied to the code that doesn't need / want to have this namespace to
be present. Puting MODULE_IMPORT_NS() into a _header_ is a minefield
for the future.

--=20
With Best Regards,
Andy Shevchenko

