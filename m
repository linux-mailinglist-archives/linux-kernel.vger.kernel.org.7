Return-Path: <linux-kernel+bounces-876458-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E9CFEC1B7DF
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 15:59:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 014FF349F90
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 14:59:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B547E2E093C;
	Wed, 29 Oct 2025 14:58:29 +0000 (UTC)
Received: from mail-ua1-f46.google.com (mail-ua1-f46.google.com [209.85.222.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DF6A2E03FE
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 14:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761749909; cv=none; b=hKlwDeXKuCVNaozOJ/xIklerlCHwAc5OG3KsIbi/n+XsyJELbvv30qopiqsnTDZpTqkfNez+QZrugDynF8iAQI6QMoO4zyg0eBJx7Bog8uhW1lQ6YARUuQXVw8jasS3rII+gL2d891qvz2rShZ+tzTeVCiBZfzsACZg7DzWbBNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761749909; c=relaxed/simple;
	bh=hSYrwqd1mkixtFP54xQA+PcDnrci1mz4DAuMcvpZcs0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=r1J8+gfJ6kgbdcXRBBg57OPISSxNONMjJnbdGqEiG/IPD5HSfanwjmOjoNEVM5wG4t8cP5SXuKR4CdyEDhXtpxhO+N8Uzw/7YDIaOJPax1PrroF3BFHCbaa1f5wyUe7Kr7coMbc78BY9GU/VpH3CXppghqCnqYw8LwqBM5D0tF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f46.google.com with SMTP id a1e0cc1a2514c-89019079fbeso2670660241.2
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 07:58:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761749906; x=1762354706;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fd/ArEYxAAEUYhnoA0Oh/vNlB/6p6wwqYSN+YEbBwcA=;
        b=Ypz1nWV4tq6PiX1y/6hMPtMA9d6Osi9SsLYLaOH2Jc6LailDOa1Cd1vvMI6h/XISqd
         JraBceG1xEw+W9nFB600Rpe50Km8B1B1ABkHhwyFFQ8rqiOJEKYfBfDI2S0FY+lofsqj
         gC66qcO7a0Pnn60JJsWskpFvm6S+P57QeAdh96EWr8Vb62hxGjSU+DjVn5yM8xKfl901
         fuPCzlhuoWF5q/NNZPUPfMj01b8Tu8fGZVdzAiRNnXz9ZboA9wJ/2P9p8bY/s88Q+vvD
         pTIMl6BBbrQ2s1kJtFYMTdghyfbmkSI0t0GK7KW1b3V79GKEla9q1XtfXTKR3ZDa5g/T
         RUvQ==
X-Forwarded-Encrypted: i=1; AJvYcCU0inf7pVhRgGdNaMIC2kaT9M/n0th2oEq+V/JE1daGrGeAqSCuDw9AEvFIQRgaOoAZgdYHGh1ZOTs960E=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWCfeN1dNaKCg69ERGvnzE/cIACs0FBAiSTPrhafES82uSbvQF
	c6A02i0r4N9AR5VMaH9xMNANlWjcA3AKIeE/SSLZENBhookgGv2DV5Fy14Ea4pfx
X-Gm-Gg: ASbGncsoBPs8meGC+T8aXj1jJPxZz8XI5gUWNIvyXxtPFNcHnSwhCoLP6HAX6qYpcm0
	P73Jo9cTnOQbdoZNI3XK9dq3WKMt5WDmjkumsO7BqF1PwIkOfD/EUM0rtWVnigcR382m7NuqQKm
	OqtVPYggOAfts+KNDs8cdMHC7b9mRHo4Ii8jqEWznrdgYvShVr1z9EbhdJiukg8+Nmho+PV1SD1
	0259iG6RoAsHeGQU3Cnzu+ZO/Hk8zrg4z97VKg4cEa56wJkt6RG0W/6xdvPmZWx7T0HCrcHIbJ4
	FzfchdIvpBYb08ze3VvwR7hNkzHC/2cyQ9B+s1MzYX/TDdyUEiVx1Mkwb/89yr/riMRoaKXBNUL
	AG0C08Q1z7lnYfJ4ZiWsni+8u4FARlvnyEWtp+YsntOxcd73uNL4yUmLDBnij/maVVhoyLQgAgc
	MB/M3VpQAqZKZU32/r6ZgmpfQMxQowVO9ZalszJY8f5tH2J4BTQ+VJ
X-Google-Smtp-Source: AGHT+IHS8ncq8audnBqMXhEA2M03eKcIhuFacn9x7ac55v3Rh0W8IseTorlZi+cOVK5e5Y4NczslNw==
X-Received: by 2002:a05:6122:46a7:b0:552:2c5a:c057 with SMTP id 71dfb90a1353d-55814273ff2mr919097e0c.13.1761749905735;
        Wed, 29 Oct 2025 07:58:25 -0700 (PDT)
Received: from mail-ua1-f46.google.com (mail-ua1-f46.google.com. [209.85.222.46])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-557ddb09e9dsm5493273e0c.7.2025.10.29.07.58.24
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Oct 2025 07:58:24 -0700 (PDT)
Received: by mail-ua1-f46.google.com with SMTP id a1e0cc1a2514c-932cf276843so2733833241.1
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 07:58:24 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXdhZDS0YCdy6G2gI1I8VIOYMhyEq249v2HvpHOUtZH27PZD9xOo3PtJzZaHsNfVAlieTi9gpne0Kbowk8=@vger.kernel.org
X-Received: by 2002:a05:6102:290d:b0:4f7:d553:3cfa with SMTP id
 ada2fe7eead31-5db90606601mr813077137.12.1761749904411; Wed, 29 Oct 2025
 07:58:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251027211249.95826-1-marek.vasut+renesas@mailbox.org>
 <20251027211249.95826-2-marek.vasut+renesas@mailbox.org> <CAMuHMdV2Kr4WcYRERHCYR1zGAh0n2N3D=LYbRSYLJnRTYDB4+w@mail.gmail.com>
In-Reply-To: <CAMuHMdV2Kr4WcYRERHCYR1zGAh0n2N3D=LYbRSYLJnRTYDB4+w@mail.gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 29 Oct 2025 15:58:13 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWyKeQq31GEK+-y4BoaZFcCxJNac63S7NoocMj1cYKniw@mail.gmail.com>
X-Gm-Features: AWmQ_bkK_riw2DJ8GdGhH8UFTwbp-0GBHO60gLWdbse1YNVgueoQrpv6rrq65Pk
Message-ID: <CAMuHMdWyKeQq31GEK+-y4BoaZFcCxJNac63S7NoocMj1cYKniw@mail.gmail.com>
Subject: Re: [PATCH 2/5] arm64: dts: renesas: r8a77960-salvator-x: Enable GPU support
To: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: linux-arm-kernel@lists.infradead.org, Conor Dooley <conor+dt@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Magnus Damm <magnus.damm@gmail.com>, 
	Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Marek,

On Wed, 29 Oct 2025 at 15:52, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> On Mon, 27 Oct 2025 at 22:13, Marek Vasut
> <marek.vasut+renesas@mailbox.org> wrote:
> > Enable GPU on Salvator-X with R-Car M3-W.
> >
> > Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

(no cover letter, so just replying here)

I am a bit reluctant to queue this, as apparently there is a bug/race
condition in the PowerVR driver: if the firmware is not available,
the kernel may crash during boot due to a NULL pointer dereference.
I could trigger this on Salvator-X with R-Car M3-W after applying your
series to renesas-drivers-2025-10-28, and adding two debug prints:

--- a/drivers/pmdomain/core.c
+++ b/drivers/pmdomain/core.c
@@ -256,12 +256,14 @@ struct device *dev_to_genpd_dev(struct device *dev)
 static int genpd_stop_dev(const struct generic_pm_domain *genpd,
                          struct device *dev)
 {
+pr_info("==== %s/%s: stop\n", genpd->name, dev_name(dev));
        return GENPD_DEV_CALLBACK(genpd, int, stop, dev);
 }

 static int genpd_start_dev(const struct generic_pm_domain *genpd,
                           struct device *dev)
 {
+pr_info("==== %s/%s: start\n", genpd->name, dev_name(dev));
        return GENPD_DEV_CALLBACK(genpd, int, start, dev);
 }

See also my original report "drm/imagination: genpd_runtime_suspend()
crash"[1] on Gray Hawk Single.

[1] https://lore.kernel.org/all/CAMuHMdWapT40hV3c+CSBqFOW05aWcV1a6v_NiJYgoYi0i9_PDQ@mail.gmail.com

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

