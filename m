Return-Path: <linux-kernel+bounces-862345-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 206ECBF50EC
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 09:48:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 49A7C4FF2D7
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 07:46:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A68DA285074;
	Tue, 21 Oct 2025 07:46:33 +0000 (UTC)
Received: from mail-vk1-f173.google.com (mail-vk1-f173.google.com [209.85.221.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B436E284881
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 07:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761032793; cv=none; b=YkxIzNM9Z0vBGLJBlyO4xLzliUN1U/vfi5rir4UHaa6hOFwTveQO40sFLbsogFBvJzTlLccIW3oG/SlIwG0FUS/7p/qMPNTIBRhR7vBeZCGbGCCSCgNRsIBZsPqv1FuzwBX7HQejFX1bdeDyLXfEhMOYEZyIHEZ//rrbICMJF3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761032793; c=relaxed/simple;
	bh=5G4JqyuB+1jfwF+3s2F0oLxHOIeUzEWkM1tGorit4ZQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IBdqpQuqRaR3suAjDM/DXne7XCkK2Tz+XcKoLSKij1LRjpPAjb28qaomuLuWo1/jeA+D6GXziU1dKJqPXtVX+1k8MZc7d8l22AV+LaJ7mBsmTsQpjg+BkiP4gFrYzDv4FL7aJa/wdXh3VZj2DhlE4uYgmbtunfOQEwHdrih1aUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f173.google.com with SMTP id 71dfb90a1353d-554eb1f3118so1860889e0c.0
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 00:46:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761032790; x=1761637590;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SOVef87yu8OWyluOAjGxPlGJdL3ZMdICelAlkVBkCao=;
        b=viZLkowgrrPsrux2rRNFqWzSGIpIV6eaOas+Y1LHAxUsZy0mAHUuf2tqOUgKmkqDDo
         S/jJX2zdrlCwa+C7nqf+NdK7RVf7p6vkNu1iMohmYPn7W5KJEk3JMZp9eEXbmqh84s68
         rArpxoHBN6jHH/C9fPuaOgT4+ZRw8fo6zrRfX+tUWPbfQHneENV1uFqCwixY1FjPKA6o
         bqqOYgGHG+Wt/qOAxDaDUXwWpFq2+Z4eDBcOKZBfMiptTYNWXoRYCcdBNyHUw72joWI4
         6gJiVSj8MuWsZEyXslhLNGS/DewfgMSp89czTgkdr68qISjqsiQUth3gdJxh/olOw32Z
         9weg==
X-Forwarded-Encrypted: i=1; AJvYcCUToNHRYWIR5z6BbpD7DhSUbZXOoeKiD9iMumgjwrTab7l4z8J0miVhJnvkIL494xvt62RLW/Fvj9Wux+k=@vger.kernel.org
X-Gm-Message-State: AOJu0YwxjynyX75hBK5hkaJ7xzpLJrleiLDYZSIvm3QuxJgA90j+klCm
	iWdZyJfTp8+a6Magn3p9TOjvDzUe83fY7EFEZgrYYJYIR3H+aH1VrdEXa+SUHdUb
X-Gm-Gg: ASbGncv7R0Dhd+jrv4MFSG4fnodEDEBMbtsbmM3VLlZSawqv8+GO9U9xp9raNEbrkYF
	pjmFaL5V0Cqh2bT8fOU3JkiX3Uau0ScZzIo1RRRp0LatXU9c1jJ3XjKkw05bROgey/3a319EZRc
	+KvMXwxoEeaLjqZigWZXBpqE8zULJ95enn603QMY+Jfb3Oo3vOW4uubh9JsF095HJTqRgRdKQ8x
	thIj7Tm1baV3ZzdjPYPE8SEV/fNzNrHWJlbtXwg6TEvZ87g9QXjSeyeewbc3O210wZz/7EFBNsE
	4ayBWVYwZs1Ym26QQTxDaiY5xzHZGb/LLgt9kqJEahGpFD+s+69hG4FgQ+rmOx9R6rlR6tvU0+9
	2mh06pQYnLj6H9OaBgdaTbbXq/mPJu9/02FP14vvpOYGvvqmSFJnDVEuqDeLwfeBGvGoWCoOV4G
	jyexusKHKzUyS13pVc9PxdRulprNghuOVkHXOgi5QUcVZUANYM
X-Google-Smtp-Source: AGHT+IFk46bv5Lu3xU2/f+Y3GuRCLii2iMVjKGbEDO0nzERt4jpc7n8WmKcJc7dLSRAPOg/t8Df7tQ==
X-Received: by 2002:a05:6122:3183:b0:54a:9927:7ab7 with SMTP id 71dfb90a1353d-5564ee4b9b8mr5379530e0c.4.1761032790302;
        Tue, 21 Oct 2025 00:46:30 -0700 (PDT)
Received: from mail-ua1-f46.google.com (mail-ua1-f46.google.com. [209.85.222.46])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-556621280fdsm3071162e0c.26.2025.10.21.00.46.29
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Oct 2025 00:46:29 -0700 (PDT)
Received: by mail-ua1-f46.google.com with SMTP id a1e0cc1a2514c-932c4832197so889230241.3
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 00:46:29 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWfUyKLquGfIUl3cRKVqQ5evPSScbC/mTcrOD4SeWYXEcxoJVtj4+PnvgSoksIWOaeYPbyV37jJzm+Q4sM=@vger.kernel.org
X-Received: by 2002:a67:e101:0:20b0:5d6:18ea:a52f with SMTP id
 ada2fe7eead31-5d9773551a6mr1568570137.41.1761032789407; Tue, 21 Oct 2025
 00:46:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251005111323.804638-1-cosmin-gabriel.tanislav.xa@renesas.com> <20251005111323.804638-5-cosmin-gabriel.tanislav.xa@renesas.com>
In-Reply-To: <20251005111323.804638-5-cosmin-gabriel.tanislav.xa@renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 21 Oct 2025 09:46:18 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXcfw5LNHJzb6wPhhr_+PhqTXW7vVsPh0Jh4C37sH_1RA@mail.gmail.com>
X-Gm-Features: AS18NWCrnqUjqenK4TJrNwGcosBJE6DKtmO9ndJuUuCBGZAhQh3Anhkt0sj-6Uo
Message-ID: <CAMuHMdXcfw5LNHJzb6wPhhr_+PhqTXW7vVsPh0Jh4C37sH_1RA@mail.gmail.com>
Subject: Re: [PATCH v4 4/6] arm64: dts: renesas: r9a09g087: Add ADCs support
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
> Renesas RZ/T2H (R9A09G087) includes three 12-Bit successive
> approximation A/D converters, two 4-channel ADCs, and one 15-channel
> ADC.
>
> Add support for all of them.
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

