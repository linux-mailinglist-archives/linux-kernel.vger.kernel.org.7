Return-Path: <linux-kernel+bounces-836063-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A370BA8A71
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 11:35:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A6A43B507F
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 09:33:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4093C2C2376;
	Mon, 29 Sep 2025 09:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aBhg3nRC"
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD350288525
	for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 09:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759138289; cv=none; b=NorhGVXmB95IRe4GyocGmT0lLKupgtXUqQp1Bj3wUq9tNJppEVA4tc0U+4eebhPHaEhw+xvARK4TYf2539WClUV6FX8cMa0YKLMPiOcQrWotcDxLAf15QtjNRDxB+lJ2pb93BOMFEG2CII7DHS1xTTJjRL5kO1a6kYjgiWk7UWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759138289; c=relaxed/simple;
	bh=0seYOOKfhRxSaRtbJv3opFssAUw4AxrKK0HRe+hoIgM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ci1mFcFIWTLy1Ryyuv2dIqN3dfuGPCRC9YhLoptSefdmXaGptHrcxT6cUuizz9Fg973h0F0YD0cstGql5wjxByjbiXN6iEVgZSg1tBFO5GKjKI03xyIyh80xMg4onlJTeF5BEV+5ytxzxfsQOt0dcJLB2KUv1wKOCK8LZZ/bBCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=aBhg3nRC; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-71d5fb5e34cso59837597b3.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 02:31:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1759138287; x=1759743087; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=H948Ks4FyotvIgoJWFnIQzusTpF3IW3EYA8On9YnJSE=;
        b=aBhg3nRCNrOZI3zJ/CuTn/6LfD9CnOhIY4rgsVxov7IDK83E4XlsR6EGFEwNrY+UOk
         XfXSI00onkgDDM7OQ4QDQVnQ59BlwRQDe+NkUZR02WTmeZeTPemgKO160mzwaY5bKlut
         Kr3w2pkzkpkX7cpNFDMEfZNY0uJa5+BxJTLhZgGodmLLIi5RMO1tOlgBvYunwTBfYMEW
         tvPiIeKYQOx7vGKgQ7Q5mcqUvKEL9Qdye7iyvJc5Z8WmCAgcg0OchhCpwxC7P+KTbQh0
         HroxSp9b9AbJ8xFL+vZ9RS66hPvPoEvUD3c5MAQ5SRbaz2l8gAcLMsQag02sxuvvkv9Z
         Mgbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759138287; x=1759743087;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=H948Ks4FyotvIgoJWFnIQzusTpF3IW3EYA8On9YnJSE=;
        b=N9j5pFHKg9YVZLQyyH16tCiadXZhzUuyybLs2QDnH3OAyq5JhHlFh7M5UPT8+Caj7Y
         bIpASLccuIfFV2lWKoV2090WBxfZx1JpetewxvL3DDLM74W2cZfN2tTGgEExbYopEAKj
         aizZnstu8G+YWCfn8q1nUTUvYQKEm27hwVdmRdYFMFYdgttPl2ULv+m/yaIKefG3epe7
         mvuD8PpLkdjcP0wA2YXtBHA14b5vwRibE+iVTpiJd9i0CnevFWR9iaN+JgZe6JHoX51J
         Xm9J1omGIVh2v2DcdeL63GM1oMcSoRtCtE7jXgII3ztceXtUDGEGaPF8B2CdaMr1ptY6
         lSsw==
X-Forwarded-Encrypted: i=1; AJvYcCWlcuGIgbC+adWNQH9ehiXkOHAYuabbNotk/qjkmqWoG+emh7zNMy8W8JxPgbRSwK98B0KvcUbop4PqgvU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzmkkdtKGoWPpjBy3t6EFZQkkCl1i9jS+NkuRsE5+OUydZ3PMDI
	xUD9/fMHul6b7361R8h6tx1/xRFHoumsLCY01yCltSmlUi5t0IstWtYKGjId6KWADEoeMD/5Wxv
	V2+4E5ZJmz+jQVr06t826Ttrfw2TEiqF93F+2LemUlg==
X-Gm-Gg: ASbGncvjyV0FxSlhX99QlccJAz/L09UniedokGJUuNf4e92GvbhsJ3tnf1R3/AQE0EX
	LB+XihY7FDEAyXacDc4lEOZzSfdGQcRtnnwo1yk2Bo0e3LDEQ+6sIj9e807ZH/bVkmiVLtnEiqX
	A3wdRlivVkh6mj4HCx7Kxwerlw4UKubL4YDCwz3AzwQIXbdQ4beAC/NZ7PnMDGJ/HdKVqXn0k64
	FMpEDLz
X-Google-Smtp-Source: AGHT+IFXTh55gLh86/vkdYVr+heB/S126ORlkozE21AFNkj/jMs7BoGlJ6IMgFlkmd0UlQRqUYqeDkRaveHfjIEl1aA=
X-Received: by 2002:a53:c345:0:b0:5f3:317e:40af with SMTP id
 956f58d0204a3-636dddd2c3fmr6803730d50.19.1759138286766; Mon, 29 Sep 2025
 02:31:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250922-pm-v4-v4-0-ef48428e8fe0@nxp.com> <CAPDyKFqQgS9j4uGkTL_taPTL96su1tqpyoek1cpZgTiaaBMpCA@mail.gmail.com>
 <20250929034048.GD29690@nxa18884-linux.ap.freescale.net>
In-Reply-To: <20250929034048.GD29690@nxa18884-linux.ap.freescale.net>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Mon, 29 Sep 2025 11:30:50 +0200
X-Gm-Features: AS18NWDsIyPq6WyP-cYDKXj4NowCxNtd4ELMHIi6ak8TqMmTMVVwpzVIqFM3mSo
Message-ID: <CAPDyKFp1NrdA6nZMQFrgrpc5Ub4osgYTiSJ=Gf1m1q4X8RYCmA@mail.gmail.com>
Subject: Re: [PATCH v4 0/5] pmdomain: core: Introduce device_set_out_band_wakeup
 and use it in usb
To: Peng Fan <peng.fan@oss.nxp.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Peng Fan <peng.fan@nxp.com>, Pavel Machek <pavel@kernel.org>, 
	Len Brown <lenb@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Danilo Krummrich <dakr@kernel.org>, Peter Chen <peter.chen@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, 
	Fabio Estevam <festevam@gmail.com>, Thinh Nguyen <Thinh.Nguyen@synopsys.com>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, imx@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, Xu Yang <xu.yang_2@nxp.com>
Content-Type: text/plain; charset="UTF-8"

On Mon, 29 Sept 2025 at 04:28, Peng Fan <peng.fan@oss.nxp.com> wrote:
>
> Hi Ulf,
>
> On Tue, Sep 23, 2025 at 12:07:02PM +0200, Ulf Hansson wrote:
> >On Mon, 22 Sept 2025 at 04:21, Peng Fan <peng.fan@nxp.com> wrote:
> >>
> ...
> >> ---
> >> Peng Fan (4):
> >>       PM: wakeup: Add out-of-band system wakeup support for devices
> >>       PM: domains: Allow power-off for out-of-band wakeup-capable devices
> >>       usb: chipidea: ci_hdrc_imx: Set out of band wakeup for i.MX95
> >>       usb: dwc3: imx8mp: Set out of band wakeup for i.MX95
> >>
> >> Xu Yang (1):
> >>       usb: chipidea: core: detach power domain for ci_hdrc platform device
> ...
> >
> >Rafael, I intend to pick up this series via my pmdomain tree shortly,
> >unless you have some objections, of course.
>
> Sorry for an early ping. I see v6.17 is released. Just want to know whether
> you would pick this up for 6.18.

If we have had another week, then v6.18 should have worked. That said,
I plan to queue this for v6.19 as soon as we have v6.18-rc1.

Kind regards
Uffe

