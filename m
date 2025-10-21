Return-Path: <linux-kernel+bounces-862347-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BBB48BF50E7
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 09:48:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 42CB6468071
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 07:47:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C06C285CB3;
	Tue, 21 Oct 2025 07:47:42 +0000 (UTC)
Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com [209.85.217.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 659882857FC
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 07:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761032861; cv=none; b=aLPReKb+OOKA51/D+m5zYtIlTdgsIIL9kJC8ldFq9RFzb599CMwzDhhIpZ9gHABMdLu1NqQYqf3bP+IQC90IsedCH1AnkpiEQ7x7x0cj5zpPF1Lhny9AfnvI2ryjXlLqwzipRhCVzE9ScIpiknPHo8QxViiYGjOR1gG+nI0r5Qk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761032861; c=relaxed/simple;
	bh=LgD3fmQmo2Vj3ctKAuzbU8OX0SkBcW7bbU6i+teUALM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fBj4VjYGhAkCkkqKadqr19TdnhXSkJeDcJqN+nqcesdbNs9JQkEf+xMEIkOkaXmZyGzZ46avcK6T90ulPiIXD5GuHoB3C+J6mb2FiALcsi6MH57iXoi2nBQwBqNlxYCl097dVB/lbAiIwmgH18auHeSrZnf8swlSrp4XBHqZ7eA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.217.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f50.google.com with SMTP id ada2fe7eead31-5d3fb34ba53so4492711137.1
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 00:47:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761032859; x=1761637659;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9RAzApxyYEKbjbp0xhiRiTTYJ8A63jge42aUGr1Ascc=;
        b=I8Q+rk1DgxrZ0Gg6n/TzRdeIMAVwbqXti/4fK48nm9XsoOUBzGO0j61yr1SC2ksOX5
         2x0D5bPf5xVKMXRc6f9NLxgMYO+LkP7pSzpnMkyqXSldp/ioS39+II/1h3KuJLGXbtUF
         haENs7m05GaHO10j7qSST83ZxpN5vAmln09x3G7Ip2U/Y2gn9KQv8mRP1RT0YKwiaX0c
         LsCYRkwkKaUN4A4RdEUjnm62pC4QbXAM3MoMO8FiPFcx4rQ+XLI4WlqkhI//rA3CkQ7G
         BHnrPzni8bjvQJDbPwdwWteRDNn5VvDjG3oy/1wmUAYqbuD+PhKrBVaeLx3JJS4MrFLL
         ARyQ==
X-Forwarded-Encrypted: i=1; AJvYcCVyLAKNKiQ/qDT5C/siWXOKEBFb8nqIst0IZ96OshLr8ccVJKLa9TxvTfH+zau4c41UTsXsiyQKvCyQVnY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOzqeZu1drJeJmh635l48K3YoW6GxEBVDgwS5+p7qo+IpQEjHM
	A5h1a5/wCMEiDBvU4i0zZZ1fyn4JAzqkL4Vz2O2JJQsuDtQ2omzdKVMGNiyRzsLm
X-Gm-Gg: ASbGncug5dMLyqzOQjEiZLfE++WtR1ztc+DbGT0xTHtJnlBs0L+bjzpz7sYhhSqYWRb
	c9RgBi7VuJGmQfNlig9ktquwitaLYnqr2s6YGMJI8KPKPvqP6fEpRN6BJDnqy5Xpe7iPtekA0a6
	dHLCHJnbgC2yrZwKfffX8rzA5Fy88oRKIdWrPf7VXPkSxOIAt9jC98M1fzO3T/GXeIakH5VY+jU
	9w85bZXGrB9MBlxdWjnlErkNdukx4AyconMKZqwEMmhAbroI826nFUG1zL2E5mFbdv356eniPRe
	M2t1UkGEOVrcf4VGofGsgSGq9aIWR8i0vlX0XtqgHL0IJUP09Y6Pzo9sJ4eohOBA9wehscM/fxX
	qU6bkCLsaG67vvLAvLuRKCETbUTmbAeW9fjGcSeGd6GEvI7Ku0F/cCK0dmpsfl3L6nTyjuqwfgf
	wMgGqAu99wO4mg9TMwuPgMkzQlw4QJLniItIFJoA==
X-Google-Smtp-Source: AGHT+IGuU9DUG4x2xIGumzs5MhsJbBzddEmBlnz+UgO5rdurnzsBiEs++tH2j8wm2eMMkiFLP7ljHQ==
X-Received: by 2002:a05:6102:3ec1:b0:5d3:ff01:363d with SMTP id ada2fe7eead31-5d7dd6a3ad7mr5249913137.21.1761032859048;
        Tue, 21 Oct 2025 00:47:39 -0700 (PDT)
Received: from mail-vs1-f43.google.com (mail-vs1-f43.google.com. [209.85.217.43])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-5d96c25dd20sm3339819137.11.2025.10.21.00.47.37
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Oct 2025 00:47:38 -0700 (PDT)
Received: by mail-vs1-f43.google.com with SMTP id ada2fe7eead31-5d3fb34ba53so4492687137.1
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 00:47:37 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU+DoevFkDpJcqOpCPkaXuU3V2oiGbgTdwE8ZBZjuxKh8XbFLp9FXbja1IUZqirTRlycIqiP4U+yRBp37Q=@vger.kernel.org
X-Received: by 2002:a05:6102:3594:b0:5d6:218c:c737 with SMTP id
 ada2fe7eead31-5d7dd55ac83mr5106961137.7.1761032857706; Tue, 21 Oct 2025
 00:47:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251005111323.804638-1-cosmin-gabriel.tanislav.xa@renesas.com> <20251005111323.804638-7-cosmin-gabriel.tanislav.xa@renesas.com>
In-Reply-To: <20251005111323.804638-7-cosmin-gabriel.tanislav.xa@renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 21 Oct 2025 09:47:26 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVU7dxJdZ-Fc0+KtH=vXt4iTA+uzEvAxu3xRR8KSVgg6A@mail.gmail.com>
X-Gm-Features: AS18NWDjbmYiPPiW4sH01TT_kOMR7nPnFgygby00VrAZBRa3sfL3fwyjeGQ-q4o
Message-ID: <CAMuHMdVU7dxJdZ-Fc0+KtH=vXt4iTA+uzEvAxu3xRR8KSVgg6A@mail.gmail.com>
Subject: Re: [PATCH v4 6/6] arm64: defconfig: enable RZ/T2H / RZ/N2H ADC driver
To: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Magnus Damm <magnus.damm@gmail.com>, linux-iio@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sun, 5 Oct 2025 at 13:15, Cosmin Tanislav
<cosmin-gabriel.tanislav.xa@renesas.com> wrote:
> Renesas RZ/T2H (R9A09G077) and RZ/N2H (R9A09G087) SoCs include three
> 12-Bit successive approximation A/D converters.
>
> RZ/T2H has two ADCs with 4 channels and one with 6.
> RZ/N2H has two ADCs with 4 channels and one with 15.
>
> Enable the driver for them.
>
> Signed-off-by: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Thanks, will queue in renesas-devel for v6.19.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

