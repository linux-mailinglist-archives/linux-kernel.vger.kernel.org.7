Return-Path: <linux-kernel+bounces-899487-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E53E9C57EAC
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 15:24:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DC79B4EA082
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 14:19:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC572284884;
	Thu, 13 Nov 2025 14:19:14 +0000 (UTC)
Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com [209.85.217.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD22C283129
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 14:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763043554; cv=none; b=HTrk2cjfVCdkiGkmW/K+/eFq3tUWgT79ft1S6Z3jeQYzDN9u0eEd61YkDHRQs79NfNDWo2CtOpqojaNqCbvjyJ4Jgtg0yIyh3cVV21AcUYlC4Q6JpVN0BGm5gJz+BtyF7CPdvMbEGuc6GTzpxWIuid19Ouf0/LwqEGZ7HCDAz9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763043554; c=relaxed/simple;
	bh=vJVdsmeHsUXqAeVRdhsj7TQml+wrLBqo7mPbRPjpD20=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HBjSOaM9U8ozTY/hYlQVz4/mlaiJZLRbsnOAG/dWK/FxjelKNs6IUGWbCSZKusSxQ4YEzGAygGcl7J4pasfsKMXzPVS544aMK5g6KYB28uzG02Liox0EwkADiKBH2nOdhKI+y7LHn1ulqiQD0ATpH0BOoO36bW9y2Ne8e1I9ZAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.217.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f50.google.com with SMTP id ada2fe7eead31-5dfa9e34adbso678372137.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 06:19:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763043551; x=1763648351;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=icPVrj3OePZGMuahj/4/ViTGnP1F/ipWE8Dz8LO0Hro=;
        b=qMhSVyPnLsZ9kOlkpYA1npN/v1eNpIT2ONVnFxjjsHfXsfrMnksrZQ8AugN4/hBtu1
         QgWlP/BsIdfEKUCm+2SH+thQJ0HQ5J3ep4E+EWbhYavqAlENl71VrriGz19+/ORXStYt
         aUCBWWygrX+roEUc5yV8CU+SQg5yteD56t2V5uxIoPCx1K/fnT2Yk4oHmkP6B6NvhqWE
         23p/HEpQlkrSpIPKr+DYdyJ2Z96IfAR0CGn6zrqDL2PYdEMScVc5jFOhHofMOKx2OKwt
         in/2IOOT8F/74sKodWOMluxRjHhhyBLvqMVUyWJDxxpXWy1hh1XSwS5VEvwUTrGqTWuu
         UPZg==
X-Forwarded-Encrypted: i=1; AJvYcCWZbyHITWDrEWtBP/jG3wGcytShnNpfdtHbHgVF9AV9w0vXiDZ2qvgk/PWzjs2DUjMkFyfEoO2HK1B8vcU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxwqew4Wa8+av0u0QaA0umVXKRZ3NOsWyvXem+K6zzrhKIX8ZXv
	RNHEi5aWkMfW1tBEm5xmsOydUZ8LYNV3fG0gUlcwvGNddXkEJGfAv/K+nTu77Gub0xY=
X-Gm-Gg: ASbGncux+V2wxHag3+mM3os4KY+GphzscZSCbQa1N7Zha+WN5jVdJwMRV5o4dPkQLpU
	Lt/TLmMTlqp0paV8nkEC14vzMgIkSXn7bCYlmsHYEkTbY6yVR7CdkAsb7/akcF3kj82qE1TlsAd
	wn60De25OB6jamQ9nKDYexML4TswrArPF1fYH2kFEnFBr8BN4OqVXDxFPILjr3z9yynyxOdlddw
	LO0rLcK9IT3tht03nMHf9PEagu4DgiU8cwIFJGqYGZk0WX9u8wbLEAAYNe1M1H6a4x/chowzGxp
	M5Jak7BuDEh6CUq7INrXi/LPgnWjev/nRo0eV1RIzC857+GpNQQZDy7LFdS3huCnJICo35yk6S9
	Vy1Qo+mR55vMdlaq6FoUyF9/nrkgxG8YBi4IPoLEzAxFmb9uqZAq6aLrXi0cbB79iP3kGSyiBwv
	FkxSOJinH8O7WljzuX0Av04MYPXrTOm1lD8ZrIkw==
X-Google-Smtp-Source: AGHT+IF6UxPt0lRanHD+eFjGZdu6u1Yf+o8Kv9zGw4FKHtCD0dXAdDh+HQYWN5A9K4k066yLWEayfw==
X-Received: by 2002:a05:6102:41a4:b0:5db:e32d:a3f4 with SMTP id ada2fe7eead31-5de07cf68f9mr2774502137.2.1763043551156;
        Thu, 13 Nov 2025 06:19:11 -0800 (PST)
Received: from mail-ua1-f53.google.com (mail-ua1-f53.google.com. [209.85.222.53])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-937611e0a69sm668668241.15.2025.11.13.06.19.10
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Nov 2025 06:19:10 -0800 (PST)
Received: by mail-ua1-f53.google.com with SMTP id a1e0cc1a2514c-89018e9f902so489465241.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 06:19:10 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUnhtC4VJYwDgWiGuCQO4syHRG+zbU371NQYw4eyGzIoiW00SeyK7a3SNj9AtkcZsCp8gJh5ooCmPRJfZo=@vger.kernel.org
X-Received: by 2002:a05:6102:390a:b0:5db:d07c:21a9 with SMTP id
 ada2fe7eead31-5de07e67bc0mr2364221137.35.1763043549851; Thu, 13 Nov 2025
 06:19:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251107210706.45044-1-ovidiu.panait.rb@renesas.com> <20251107210706.45044-5-ovidiu.panait.rb@renesas.com>
In-Reply-To: <20251107210706.45044-5-ovidiu.panait.rb@renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 13 Nov 2025 15:18:58 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVSgpJ3khJGFn9__BW+W+zM+fgrEDFKuAZgQeXyWa6w-g@mail.gmail.com>
X-Gm-Features: AWmQ_bnydjHxg_KvXSzY7Vjv_ur8bfvy2AE8JWRXR2FRDM9SQFjKqTqegYDXS7g
Message-ID: <CAMuHMdVSgpJ3khJGFn9__BW+W+zM+fgrEDFKuAZgQeXyWa6w-g@mail.gmail.com>
Subject: Re: [PATCH v4 4/4] arm64: dts: renesas: r9a09g057h44-rzv2h-evk:
 Enable RTC
To: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
Cc: claudiu.beznea.uj@bp.renesas.com, alexandre.belloni@bootlin.com, 
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	magnus.damm@gmail.com, p.zabel@pengutronix.de, linux-rtc@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 7 Nov 2025 at 22:07, Ovidiu Panait <ovidiu.panait.rb@renesas.com> wrote:
> Enable RTC.
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

