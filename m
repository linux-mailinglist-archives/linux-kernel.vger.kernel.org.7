Return-Path: <linux-kernel+bounces-866898-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9520AC00F9B
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 14:06:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 428B54F4FD9
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 12:05:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57FF330DED8;
	Thu, 23 Oct 2025 12:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="m1Pm6e72"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69FF730C353
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 12:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761221110; cv=none; b=I6eE0kGRUMYJRYqeFLwuXbpUua2/TLW/Gqx1E2jk4wf32hxIojoSCv2ivvKoBpyFlJqDjo63DdFeS8JgYY24jDl1itgL5M6lJhLIack/1pFPJakhanl0ULIEWJWHoaRAVNc1CYv1Os+gifXeZ8At1KL0rnrvCI1Zt8LMH81E0ZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761221110; c=relaxed/simple;
	bh=WpzVhlH6L5AkRapx+eMs89/euds3JYyN+OBht8HURKg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RfDyBMS7ChJsv6ETzPtJL7Cl1jGHW20buzw+a7zTXNOut0Fo1CA5IondKfMO2UTmL1KdnTlWFkeU+HZ1dExTcObdxg7WpKiLXTRL3kt8MW2L1oQl5xGGaA8kCfloN/Ua6r65Eha+bDWOiV5MXteFa6Ez1lN1hpGr5PmNnX678yo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=m1Pm6e72; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-58afb2f42e3so1066084e87.2
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 05:05:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1761221106; x=1761825906; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WpzVhlH6L5AkRapx+eMs89/euds3JYyN+OBht8HURKg=;
        b=m1Pm6e72lHEvj03b+lJz7MncyfSnipL7Zcdpyq77BN542VN19vrtcKanYLH0HgxMDR
         hS+bmx0Tul+6AGYPuowW4G+0axnFcfSWv7Y6hGI3fAc5FVQ2/PWD44FZD+MMBhhaJ01z
         JhifW6XhrfnZ8pRQdJntviXoTbX117KsMttH8TtbEAzRLSeIE+fOW5qndq255w5j1G72
         YlzO5bY9QZnF9BvILiH4RirC+3nSZZFDMFve0Y0vII0mJ5vWqHRop1He0IxqDl0HUg2+
         JCdQz6c8yy00bsN/zxJRL50OkXr15CjTW9oYjM8YIQQbxapE3E1WQnEIM6ehQ7pIYAxF
         9N1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761221106; x=1761825906;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WpzVhlH6L5AkRapx+eMs89/euds3JYyN+OBht8HURKg=;
        b=hFYQRz3Dl90TJRczJGlB5HKv6qwtp9/ql6qJSMNV6EtO9rGt3fGUOubZXh69LtUsTd
         mHWWiPtAXRdTx4HFO5heLlskG6PLOqo1PI532+vEkt3roVlNr/LouXT+j0CZU2DAxDCb
         aVQEBhf5EC8Nvnc+t7N0IPinCLxONlWitJxdk/ryNoInfuBFPoshAthqNkTgw7AUJT2f
         YT7VhZx4jExf5wckpWKD/Q88aOh4jp+dJZ1YB3NQcBXYZ5mFh9LJF7LtSZiXM2RSuT2n
         Cys+UQS5kEo/RVTVgscePDiqSxxM1XAkF7otDTE04JBasrAc37IlqDRUPkeeZihtJCu7
         K0MQ==
X-Forwarded-Encrypted: i=1; AJvYcCXkClmEPPcEHvHmsLEhwoiva5LnNs+SYSk2+1/csfnS0vBqgWSuhumo5zTW64cPsWXWacu4jqIDN23ksFw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzW03D4pW2WM7De5e50EViCjxeKqww8OOPUlJGvce9Rtm0Rp8eK
	z7o9vhxju0KsKQFXi/Nr/kbtbME1UvnHJjPrQVAfmD9Qs/zqPZDv0V9kH3ZYI7oslJz7tptdsWi
	jQa8dXhFXmKot7MOAednBD6LjQugNfeI1YSA26azsCA==
X-Gm-Gg: ASbGncv4UZbYMibyIZPKYR3UGm8+h1+viEogdKBISkLZxRq1hYdC6bHE3hDKir7GEd/
	xg3OUmfgduustDgKUDM/A7vgwAY3bVWUSF5dwwLsdzOCWl0TeVZHB/apU9SO4mbP33YYGXlOe9P
	vNOMNLKmfgmeyLJI4mHqQBYoW2FVrtGaAqhLOmh6n/ZeVp91fdtG6x4IlXcNQD7+U5Kj+ZEstqs
	3g9ntdxuMSdeCUPSWLFhKOVtGLTm7XjcSpsUtxrRKjihJYluzRsrBXjsAfIuMYWOcKwRwxtR2jx
	59EVD7FwJVmlBTA=
X-Google-Smtp-Source: AGHT+IGlzLnIdBxYP5gkrUBr0y+WXdWx3RC6UOujYySjsBNEN0SUYLkItuLvZ+pLZ3k3ctKUbha66ijMjfariFR2N0I=
X-Received: by 2002:a05:6512:3e29:b0:570:8bc4:9549 with SMTP id
 2adb3069b0e04-591d855a889mr6716233e87.27.1761221106288; Thu, 23 Oct 2025
 05:05:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAMuHMdXqHncXxBZ00mxV=pzdgQEU4ju2F9XMejnibbu=QnLfDg@mail.gmail.com>
 <aPEAx8ZGHBcWZKJF@shikoro> <CAMRc=McsbAirEYjoo455mbKU495VEvPmMEqBmZCq2hw113YHOg@mail.gmail.com>
 <aPIfF-3SgzW5V_gs@shikoro> <CAMRc=MfVPO292xmnXBWJzWuhNADA_u1yvpJ4kkK8TgZyQgaP+A@mail.gmail.com>
 <aPInv9NELU7N9QDn@shikoro> <CAMRc=MdWS2OSeJAkTRnAFMtXcVukwQ=JAWwJ3OHxogmgZnan6g@mail.gmail.com>
 <5c9761d5a6a14d4c250df6cc4201bca72d963133.camel@pengutronix.de>
 <aPnz6U-fcodRoobU@shikoro> <CAMRc=MejA6DsnOW3hS+aFtecXn38UypJU2TUrAWPoo9Ly341uw@mail.gmail.com>
 <aPoPGauSQCoaonl8@shikoro>
In-Reply-To: <aPoPGauSQCoaonl8@shikoro>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Thu, 23 Oct 2025 14:04:53 +0200
X-Gm-Features: AS18NWAA79R1X5Xxu7QaJvk3bQaFzhvQoUsFM7Nqc6jJMQESUruL6wkYpjE2WHc
Message-ID: <CAMRc=MeOsUOJTx1-UVdQQzxk=KWyOoO7NwfAhrNDJmUv7kOScw@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] reset: always include RESET_GPIO driver if possible
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: Philipp Zabel <p.zabel@pengutronix.de>, Geert Uytterhoeven <geert@linux-m68k.org>, 
	linux-renesas-soc@vger.kernel.org, 
	Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, 
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 23, 2025 at 1:18=E2=80=AFPM Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:
>
> > > I see. That kind of spoils my assumption that it is a fallback suppor=
ted
> > > by the core. Darn, I would still like to have it, but it seems more
> > > complicated than I have time for it :(
> > >
> >
> > As soon as my two other reset series land in next, I will finish my
> > work on converting the reset core to fwnode which should help.
>
> Cool! Then you bring back my argument, that it should be always compiled
> in because it is a core feature ;)
>

No, I still think it should be a module by default with an option to
build it in if the platform demands it. Just like 95% of the drivers
out there.

Bartosz

