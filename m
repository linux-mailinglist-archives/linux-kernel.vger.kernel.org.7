Return-Path: <linux-kernel+bounces-893652-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E3DFC47F53
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 17:33:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7331F188CCCB
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 16:33:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C6B527F4E7;
	Mon, 10 Nov 2025 16:32:57 +0000 (UTC)
Received: from mail-vk1-f174.google.com (mail-vk1-f174.google.com [209.85.221.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F60126C399
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 16:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762792377; cv=none; b=e+IV9ZL5S6rOqsKCb9ziaeEeUKZY3os35BO3fDal/m44W8GLi7Z8FBmk3lY3N3Srn/EB8GKL1IDZGs0R0jgxE2nkxe9/Gp27cQl7bLMHVKbDKTpOmA5OPXZ9CbozvMhSxvrw2EY2Ne3Kifseyscv43hq9KERtNROJkYJslD3crk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762792377; c=relaxed/simple;
	bh=vGMbit6ddUlwoxrUxi6IwHq4K44T3JViUun4qtrQOtk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KUxYmJkvIVNGsoocfKGldf3fuUTO6kK6W4uANNsX59wRHGZ6M7Welh4VB4tP3Nw0Ce4jGN4Ub5b65KRJ4w11NVSiTi5V1pZ0bcyBSFpOluKkCfF1nhAjo4vIcQtD19E0GxuFqT4Y+eK/9pXVrVVFzxDn54qC+W8f46g6lhiA6Fk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f174.google.com with SMTP id 71dfb90a1353d-54a8f6a2d80so714781e0c.3
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 08:32:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762792374; x=1763397174;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dHzMucwowrWDP2Qt+Y+UWKgurmYAh4juIylWzobpf/s=;
        b=bg+YGzl/aU4A3jL24tAkxVjLxyylNZwUljOPnk8vOyw549zVn9N4VQCTd1OC37SNDL
         hUzRaL6wOW7kVw93jOP06HnqXeZkJql4pcx9PGAgo0dmstg3lrODGeNRqgoVwN4ook58
         /mI7nKZjRD4k0YM4s9SlJItsYVWSC7DYYHBzefVI7D/jcADyG/CclvVHPYjWrQHfI2eo
         +GzqgjqJ1qTMXf9nR8Da/7CcnrnSofQKBAhRtTC0e5E7ygunhNKC2USQ+rJGxkwVFNb7
         aK10RbxBx3/xeE6suioliuBwXdSn9FJGm6hzLaNevRH/h6OcyQL05mJd2aQajC4YxX8X
         SXwg==
X-Forwarded-Encrypted: i=1; AJvYcCVqgziQxOliQ9Nf8gpEk9eBaeaP3AAluBUvfQLLgh+xwcOQF47/bUrXsK6y33KF1dis1qyJdLP4qhekwCo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/0OupU+lco6PhuYlips87o7y7skZuorrhTFn1tj9zatFW7p+Q
	LTq6f2UC55louWQRBm/IEIk5JxOVbxeSS7jtWVEdYiLOjhiQsdRas9fA9tyC1Vr4
X-Gm-Gg: ASbGncui1RfmjY+hp9RDivGTbi8Morymiqo0GobiW+gFNEVVAnrSJkQ1P2QuDDrI+Xk
	wvMpSHb5TDeiNEis4SPg4y4sLXRe1NpqQFS/rNR0GregM4DReIEgBlWC3+yMJcx+f5PBVUNVnIf
	ZuqVNsXz4XIO4w4+kbn4lIYVeyLNQQdyOGqEYOnrEnNlZxvoG9CTC7p7A9wi9i5T/sNAeGa5i/I
	Zh6yvGWmHDhb24dp1BSgx5p+LlZWCdLCvMGBfwEU09y0cLubWY4YIlVnDWsmooQRx17zNZsEg+1
	WCSz3dwSkZOKVoi9a05W946R2oOpoh8IPgtItfZflSvz+Zz6bLfAAud/Emn2b8dswDU2Lnz4drl
	1s6/PYYvcv6waZNkvCcbMNGPB0M4ClKZG45PF0GmwgNYSRW+BJZFJCb8q/2zwOaGc0ZyJEavUay
	DtcrKqCtsoax5PEmwIkZTaGFJI9ExOCIveqdmJslkGX6c7lUva
X-Google-Smtp-Source: AGHT+IHryTVptWq6oTS7gMRfKpTwP+n1whZyKXo6pWgtFRWlRHnZgW3j6MoqZnDEssSTOAHqELgvoQ==
X-Received: by 2002:a05:6122:8c0c:b0:54c:3fe6:627b with SMTP id 71dfb90a1353d-559b31f9c8cmr2853871e0c.3.1762792373969;
        Mon, 10 Nov 2025 08:32:53 -0800 (PST)
Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com. [209.85.222.52])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-559957fb32csm7375824e0c.13.2025.11.10.08.32.52
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Nov 2025 08:32:52 -0800 (PST)
Received: by mail-ua1-f52.google.com with SMTP id a1e0cc1a2514c-935356590ddso902188241.1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 08:32:52 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVnw2wpuUEgpoCCEVi4Cf9uZVt0+x4IjxtmcfusUrupJ/o1QkbpxOSMoDfo/om0pWlj3q5PB+j14xqau9M=@vger.kernel.org
X-Received: by 2002:a05:6102:c8e:b0:519:534a:6c5e with SMTP id
 ada2fe7eead31-5ddd57eb0b0mr1693520137.33.1762792372340; Mon, 10 Nov 2025
 08:32:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251103141834.71677-1-herve.codina@bootlin.com> <20251103141834.71677-4-herve.codina@bootlin.com>
In-Reply-To: <20251103141834.71677-4-herve.codina@bootlin.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 10 Nov 2025 17:32:41 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWFOQANqnBX7nNST+WRxYz2j3gznohEZXF1SC-GyjDuGw@mail.gmail.com>
X-Gm-Features: AWmQ_bl9D3O0uVkd9QcrhvhsjRnIq7PDvVWO1-VB9dJdhU03nrwxJGeIcNitAIk
Message-ID: <CAMuHMdWFOQANqnBX7nNST+WRxYz2j3gznohEZXF1SC-GyjDuGw@mail.gmail.com>
Subject: Re: [PATCH v3 3/4] ARM: dts: renesas: r9a06g032: Add the ADC device
To: "Herve Codina (Schneider Electric)" <herve.codina@bootlin.com>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, Jonathan Cameron <jic23@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Magnus Damm <magnus.damm@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>, 
	Mark Brown <broonie@kernel.org>, linux-iio@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Pascal Eberhard <pascal.eberhard@se.com>, 
	Miquel Raynal <miquel.raynal@bootlin.com>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Content-Type: text/plain; charset="UTF-8"

On Mon, 3 Nov 2025 at 15:19, Herve Codina (Schneider Electric)
<herve.codina@bootlin.com> wrote:
> The ADC available in the r9a06g032 SoC can use up to two internal ADC
> cores (ADC1 and ADC2) those internal cores are handled through ADC
> controller virtual channels.
>
> Describe this device.
>
> Signed-off-by: Herve Codina (Schneider Electric) <herve.codina@bootlin.com>
> Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
i.e. will queue in renesas-devel for v6.19.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

