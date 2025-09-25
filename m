Return-Path: <linux-kernel+bounces-832644-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 443D1BA0006
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 16:29:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 368E11891C28
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 14:27:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BE2F1FCFEF;
	Thu, 25 Sep 2025 14:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="js6KhFAa"
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ADB42BD5A8
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 14:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758810434; cv=none; b=H0656+jlGRRVCabg2TpdIdqi/LdV1QWr0wUng7lkcVAbQe6Dn0Yz8jS5J1a1CfCE6cQJeipiTG56vVSiyh8JLUEHZaW0eP0egz2GMkjaAXlXtwpwcdIRSwCeH5Bq9r6Q3Sf2tgxPGRPv+E2Bgp/H5A5v0lXQu2RYlhw4cUREQGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758810434; c=relaxed/simple;
	bh=CUiOFm5hwMEoRqR8C48BxuLPMKnSrYEFu/PW03tLYHI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TX5A2DjGnBNBIxlcnRNzd5dm4UsEo/yTzeGcSg0h0oKLnBGYdx0o1fSA41AYTcmuvmxGoRSc7u03HK6ev8muN7gDgchH6LDpnEYFkN23eLoVl4YOrMe/JvjgY8CjCAE1HH/8DX8ZpXN7HnOB1XBaJ9CzmvzB6k4gtJd0BoEN6Kk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=js6KhFAa; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-71d60110772so8713427b3.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 07:27:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1758810432; x=1759415232; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=CUiOFm5hwMEoRqR8C48BxuLPMKnSrYEFu/PW03tLYHI=;
        b=js6KhFAaBIEfm6/VQiorXnxWZmpyVmhhwUM41N94yuo6S5g+Q3Iq+RpsVrFAHea43s
         FHjZ4XlV3yv7wnnbrR/DGGYmo4vh8r8HpdaDnXyvuXIDHTujsr/zp6b9xH6/WahYXd6j
         8bfKPPD7Ggh311z66Sz6Hfux1Ngv0CJIErAzNOpK4ZydrC0g4dMCOIm/BaZZEn63/ZQJ
         Aq/43IxLGFbRpdM4uUq/1c2ycUsxj2lyqxPZuNhnMQAzBCqTbFTQKjxZ9vrdHAFGSspg
         QY+ftZI1l5wIxLqR+brw8iqu+upb8XBWm7E17NaoaK5p+alS7KeknHM/7TROEZ5ChQ6b
         BNcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758810432; x=1759415232;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CUiOFm5hwMEoRqR8C48BxuLPMKnSrYEFu/PW03tLYHI=;
        b=Paul74KEjtfuIOo5h21tnAYWS9/EcMCgANSazFyd9CzY2pHkuuhhUPUvyt6/Nqzjua
         l5zqGrhBTYbrBbPlqFsUXpry95mvcVKqDCtqU9g4GHNhHyAileqCiIRRtv/uxwpTYhTU
         LmtYYhcbUidi6Jt4Lz0qFrGFtL/5yuaqz0tX/Lw8qfqHAesRjsnTrTUv3WCDQQuDeupb
         cDFjuOCl83AbMqGE+Xys7JbD8ljYiuXIeJPUpjGEWA68YwdTa1S84T7CJudpVIP8uPi0
         WtobytSAQxq3x056gAxS5Z1gECHwVDhSXtJ5raEjvwnWeYxTh6MxAGmlokP9oLOLgTQX
         0MwQ==
X-Forwarded-Encrypted: i=1; AJvYcCXmXUaf7yPbahBDhV/F4PU0ZpRBobFi4x2H0wHpNODiI6hOqgEeUv/mKVU+EWjm5rpRIypRXmt9P3TXdTo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxqLPOSV/WyJyNT8AevloB6T6S3HsLemA2uPLtw6l5L8ilzF2/4
	cI12V1STIePULOFIgwKLwL2GEE1XvbnTRBROgMEeEyh67kzzbJs6gLn1GCFoPw3vc3UvvxzsBJ+
	ShydiTxL33cucttYE4vTJaSNs2ykx883EbuG4kW4mTA==
X-Gm-Gg: ASbGncuOD+cjoCyB//E5YAMW9hCpSM7SuCFDbyNN9uAxcOdn4cyDNh1WYU9uMoAeI96
	lHW1KlXFQ4BPorgo0JbbEfg8HDt7X4XQebCDUkLNoWdUT1RZ8If0vkDJczCuT6B4vm4LSLafNtS
	pUSWRaB81gTcAEpMA+8tX2MjTLS++g0qQYEFisa0VSArFyIihUhJE4XIz0+cbaJ5ZGmgCgFOeOy
	WxRnG4K
X-Google-Smtp-Source: AGHT+IGZDWxk3kUzyiqmiLMSS2P4wkC9enG4su6ICOnqjad1NL8jWqFtTK574aJMRmZcQx685zoXfiL7rhOftMqCoUI=
X-Received: by 2002:a05:690c:4a04:b0:737:e9f:92c3 with SMTP id
 00721157ae682-7640500f570mr38653867b3.41.1758810431921; Thu, 25 Sep 2025
 07:27:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250925115924.188257-1-ulf.hansson@linaro.org> <DD1XOHE6P5OC.2JUQRAGAE1KTU@cknow.org>
In-Reply-To: <DD1XOHE6P5OC.2JUQRAGAE1KTU@cknow.org>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 25 Sep 2025 16:26:35 +0200
X-Gm-Features: AS18NWAs7GCXJJuWoTSq1H6YyuNpTzQ2hjA2VwzXclsSEUVoMXRaFtxKv4YK58g
Message-ID: <CAPDyKFrKP2bdpKTHzqDdhEpRAjYu+PFd2Bst=-WPddByxcAX_w@mail.gmail.com>
Subject: Re: [PATCH] driver core: fw_devlink: Don't warn in fw_devlink_dev_sync_state()
To: Diederik de Haas <didi.debian@cknow.org>
Cc: Saravana Kannan <saravanak@google.com>, "Rafael J . Wysocki" <rafael@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-pm@vger.kernel.org, 
	Geert Uytterhoeven <geert@linux-m68k.org>, 
	Nicolas Frattaroli <nicolas.frattaroli@collabora.com>, Heiko Stuebner <heiko@sntech.de>, 
	Sebastian Reichel <sebastian.reichel@collabora.com>, Sebin Francis <sebin.francis@ti.com>, 
	Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>, Jon Hunter <jonathanh@nvidia.com>, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 25 Sept 2025 at 15:59, Diederik de Haas <didi.debian@cknow.org> wrote:
>
> Hi,
>
> On Thu Sep 25, 2025 at 1:59 PM CEST, Ulf Hansson wrote:
> > Due to the wider deployment of the ->sync_state() support, for PM domains
> > for example, we are receiving reports about the messages that are being
> > logged in fw_devlink_dev_sync_state(). In particular as they are at the
> > warning level, which doesn't seem correct.
> >
> > Even if it certainly is useful to know that the ->sync_state() condition
> > could not be met, there may be nothing wrong with it. For example, a driver
> > may be built as module and are still waiting to be initialized/probed.
>
> "there may be nothing wrong with it" doesn't sound very convincing.
> So there *can* be something wrong with it, so warning sounds
> appropriate? If there is (certainly) something wrong with it, I expect
> an error.

Sorry if I was too vague. See more below.

> FWIW: most of my drivers/modules are built as modules.
> I do seem to run into 'problems' more then average because of that, but
> to me it just signals there is something wrong ... which should be
> fixed. Not silenced.

Well, why is it wrong to have drivers being built as modules? They
just happen to be probed at some point later, then why should we have
warnings printed in the log due to this?

>
> You're the expert, but I'm not so sure this is an improvement.
> I do regularly check dmesg level 0, 1, 2, 3 and 4, hence it landed on my
> radar. I do not regularly check all the dmesg msgs, so this change would
> result it dropping off my (immediate) radar.

I personally don't have a strong opinion about the log level here, but
the reports I have received so far, clearly indicated to me that we
should not be using the warn level for these messages.

In the end, it seems like these prints are not as straight-forward
when it comes to deciding what level to log things on.

Let's see what other people think about it.

[...]

Kind regards
Uffe

