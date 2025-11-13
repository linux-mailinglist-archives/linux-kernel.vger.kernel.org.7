Return-Path: <linux-kernel+bounces-899506-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EFF4C57F5B
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 15:35:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 236F74E4EEA
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 14:28:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F29712BF001;
	Thu, 13 Nov 2025 14:28:45 +0000 (UTC)
Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com [209.85.221.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1329E29B8E0
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 14:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763044125; cv=none; b=p7au4YjEzDomWkoe92YofZfpYra1Sxv2XesbIrYCL1HX1aruOp4gjhfYRmayICrWt7wgsbiDZbtl6I2BQ429UtsEHivK3qbaElXLTPZ8tIvna6FGPPQJQAg01q+OaE/Bq8V5za51T0MFt1yZ71NUsCfVjlUx4wm7GD9t7CHwYM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763044125; c=relaxed/simple;
	bh=A55pVaLB1a5M/183qzOCCCtVLqILltVvYYcujE/3gBY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZPur8Aa+h1bYncTZ4C/BJbPMaERN1IVTTkWbADILJ9Nh+EJBkzbbaDxWI4bKjFzxqTDzuqbhrzPpMx6KHJWRKXDiBZoHfQVPOcZx4zMT+onzi18DW0X4pgZv6BGJysTs7lNO6UYTTzCnezmIgrA9weSLhvPLmnR8jrVrVgffBd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f178.google.com with SMTP id 71dfb90a1353d-55982d04792so562558e0c.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 06:28:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763044123; x=1763648923;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SPVdv+Cr3ZbcMU8t075Et/PpRUdOj7rpDshXN3z13xs=;
        b=ryTzZHJbFNH2d/5Xxq5K6qbQ+sqgRAJE0ca+0lB+P449gUyL7mv/oM97kTSuYY2ZBi
         TYF4yn69ICo19xocgYgXj+ysEdKReAnfeNf2CEC0Uq3l0z5qRyQFZMEmWBCDV9B/hTGd
         1oNaO6sHVE3hCLCXzYfdn/XnpY9zTlsp7TvJ64DVBmXYfV7OSrf24w4m6UqV760PLFnF
         nbqpxOKts5w678JkADNCypwntJ02JLodXHzqkO5Sw1gFvVVPVEc8h4755C+Zh072Gbcu
         5WrM5pEGU89CU9+qHlVE8q/ZLI1Wx8uPbRZWoawWrIDdt9BsBTmtKA+3qGlBT3KjAnAY
         0FwQ==
X-Forwarded-Encrypted: i=1; AJvYcCUUBQO/qMK+rsPl0tojr8HuI1tNlWc+PChII2DMrNMFdgXPLlhBU6AlfVU9OwbafR4XWH2CiPCxARuB/X8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxd5l0q6vULsw8g8/iim2fUc47rKysM3hh1kbKs94IgmmtoeQB4
	QrcV9tcZIBcc/FXR5qpG77Gb/eQfWuo2L8LqXCFvTFTzkuTGaKD4cv3sn7vqkJ05SaA=
X-Gm-Gg: ASbGncvkzDpCj8vht2jOSSAYzPZJESVdHQRzGeeM34eNn2d/XZp/PD7KgAC+JTW3AHX
	6abQBJYOCOWWKkxmWujhBiEFuK8J8j0pePOkTXJ2N05uJgh/a8gW+VvBF7/hsONIp2SIQs5VDkJ
	K6tpxWJSF7blx1Lo+nXaHuXQ8dJFCzfkGkNqj87tkYqA5TvWS70EYLfKLtRXsB9kpcoMxvzTKPx
	1o2GXhMKErGmEKwNQaKAu8+wlszdzItfNYoTlzQC2Rp4lIVn3SDWItYcqQ4IvkR0PzX4uQeuf6i
	Y2oRkquEdaBKPAlOkpJxgbjeHrGNpHkxCL51wTjZmRgXgVz17vubQ4bchf7+5tzs5YikoO5ULeq
	MztKKZTfZ6foeYWmzmoYZQ/XKYmPWxBj+qK3KB7FujqLLKoMhIEr19ybOVgTUMYSKEn+Xxzu8zA
	K6+/WnzevhgKwkoETX9Ei6SYP/rmmE3oIDTXHFX0WPnRN551+n
X-Google-Smtp-Source: AGHT+IEqYhJMSMtBbf0FnBmB7NUXSYPtMBZpdiKgkljIJ0iMniUumFFSiAY2Wb7Q5qwb+MKOgd3RrQ==
X-Received: by 2002:a05:6122:62a8:b0:55b:14ec:6faf with SMTP id 71dfb90a1353d-55b14ec7257mr576980e0c.16.1763044122469;
        Thu, 13 Nov 2025 06:28:42 -0800 (PST)
Received: from mail-vs1-f46.google.com (mail-vs1-f46.google.com. [209.85.217.46])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-55b0f4426a5sm709247e0c.12.2025.11.13.06.28.41
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Nov 2025 06:28:41 -0800 (PST)
Received: by mail-vs1-f46.google.com with SMTP id ada2fe7eead31-5dfae681ff8so535692137.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 06:28:41 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCX3v+i9jzpcMqa1q3PIJiLn//vmKWa7gajFb96kE+FM3gPGZOZBtpr9jL7Ag7tB33EM3p2hHi3mZIPcoDU=@vger.kernel.org
X-Received: by 2002:a05:6102:4b85:b0:5df:af0f:308c with SMTP id
 ada2fe7eead31-5dfaf0f34c8mr2015901137.38.1763044121413; Thu, 13 Nov 2025
 06:28:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251020143107.13974-1-ovidiu.panait.rb@renesas.com> <20251020143107.13974-4-ovidiu.panait.rb@renesas.com>
In-Reply-To: <20251020143107.13974-4-ovidiu.panait.rb@renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 13 Nov 2025 15:28:30 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUz=f5ArCV-w7dcyEdqhsZJrKyf=KwY18mwOgVdt5TQDw@mail.gmail.com>
X-Gm-Features: AWmQ_bnUzqLPji7mNY2mLpWw72wOSZDLLWSl0uz9lB3HUP0ZZ52peqFQbz3UfMc
Message-ID: <CAMuHMdUz=f5ArCV-w7dcyEdqhsZJrKyf=KwY18mwOgVdt5TQDw@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] arm64: dts: renesas: r9a09g057: Add TSU nodes
To: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
Cc: john.madieu.xa@bp.renesas.com, rafael@kernel.org, 
	daniel.lezcano@linaro.org, rui.zhang@intel.com, lukasz.luba@arm.com, 
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	magnus.damm@gmail.com, mturquette@baylibre.com, sboyd@kernel.org, 
	linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
	linux-clk@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 20 Oct 2025 at 16:31, Ovidiu Panait
<ovidiu.panait.rb@renesas.com> wrote:
> The Renesas RZ/V2H SoC includes a Thermal Sensor Unit (TSU) block designed
> to measure the junction temperature. The device provides real-time
> temperature measurements for thermal management, utilizing two dedicated
> channels for temperature sensing:
> - TSU0, which is located near the DRP-AI block
> - TSU1, which is located near the CPU and DRP-AI block
>
> Since TSU1 is physically closer the CPU and the highest temperature
> spot, it is used for CPU throttling through a passive trip and cooling
> map. TSU0 is configured only with a critical trip.
>
> Add TSU nodes along with thermal zones and keep them enabled in the SoC
> DTSI.
>
> Signed-off-by: Ovidiu Panait <ovidiu.panait.rb@renesas.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
i.e. will queue in renesas-devel for v6.19.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

