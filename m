Return-Path: <linux-kernel+bounces-845399-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D78BBC4BA7
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 14:15:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8D6B54E94DA
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 12:15:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B5B31A76D4;
	Wed,  8 Oct 2025 12:15:44 +0000 (UTC)
Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com [209.85.217.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A5791397
	for <linux-kernel@vger.kernel.org>; Wed,  8 Oct 2025 12:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759925744; cv=none; b=USeRpdUhRNIGo4QG1P5pxI4WgBsd7Y7ugAfFVsTgEAUvcaTlIuwMqvE1aOQiEUyKC+T0+qu5jzo0XKRL/5qmEO56IArLSNw6cAP9ZZx6SwMYMmKSb9hN72maIzegCf0OdWHJ6RF4fzqTorrO8R3TTOSyQvs6vBLu0aQeWQ8/IRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759925744; c=relaxed/simple;
	bh=LHfdiCrUQuEcAm5u+oBtBSBCUhJhATTh4SH+rcshlXw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ig9xBFu61OfZoHz9h+duPWCFxjXQzHhhspSuwgHgjLsOor4nSwN4f16llfss3mpCge3fWwJ2bSKgl3GjBoEtSiQWfQCrhe2ovJRYZ8Ue/+y7/v57n2yyQK+Csl5MTCISKBD9JlySxszhAJYQKywZSGDf8vv/1aobniOrwcVoXtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.217.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f50.google.com with SMTP id ada2fe7eead31-51d14932f27so3651817137.2
        for <linux-kernel@vger.kernel.org>; Wed, 08 Oct 2025 05:15:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759925741; x=1760530541;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9odJo6RABd099SWeo1M5TAe6eHvzwU6j0ndjMHRUm3I=;
        b=dPRceWG0XKHsFUvtAoSKrK3X9UhQlPI6FKg5yTqkTlix+7kSzbL8S4bYndKJtYZDu2
         YtTkMR/lVYvK25WT3z4jSyjGNRxAPSRgnai8DseFWuTv9pzkfusJaMoFFXflyFOEfM9V
         ThGiJU1TgZ81LLzK90dF67Nk3oh1Qrn75W14ghIF2DcRORXp7KOrXEorVqDFbEIjvuu6
         sxbHtQpu4StXIxFncyVvOPwRKNFl1UHmmvE7XTIiOGnqMGGrxlRJBFbPUXSwhLzBqu5v
         1f9B3McsOteABheTs9AKiOBG78WNx+FUhov6mwJEGnA55Ty8iCLP5vUOkJOatYqpf5jn
         G8XQ==
X-Forwarded-Encrypted: i=1; AJvYcCXt1WGYg8KXkmbKqF95g4pPzAWS89rCxTKyfGImr0B/KgNMIE5PwJ6Z13HS0G3iEuqMWvUDTNeKcWBZ4cE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzlwOoYX18KK3Dvz1NAcR6X9ethdEVTMlsCXqGvuGIRsCD0RLPj
	wR41jYbT3JpeaCUuRR4NL+kRJPgPXtOCdWswSdJ6xyMFVCkmr5sDozzwctU62T2y
X-Gm-Gg: ASbGncvc7VrCBvFN2om2IxmAnNFFE6roOgwKtscer48qGXFst1j5UfQ8fUj4S6HHZdC
	VHYxgs1mxhAofb10jwDBZn8wkvPxpmS5xfP+Ei8OSGRtsZdnJqHeMDlZ9yJ08lvfqEarrI19Fv0
	yE034QiX/F7aHjY0f6mf64AnKy3ZrdC1Y+9NtUxr9XI1v2kS/vBj0OGvhOLFZ4QYPOF1SVF64Tb
	tnBScsKpcf4ZRzX77VT2k9lD5PwzNo14wRbo90dF+eBOC3+quN2t5/2J8iqfmN843HvyZ1qJCSX
	UWjsD1vx3AgHg295zdCrgXBWJDya5vrNaockQQyyY9Yelsuf3eBExpcf9BkG0i5jRSDTCiVEc1p
	TiJybrypuYPIy0KqxDcdIqxe8xxo1uOJGA+JC6psQ+2G30nGIg3eKLiBjiY4eGpqLzjW33VtdRm
	6sPVxKOhh7
X-Google-Smtp-Source: AGHT+IFgHNmpAHP2T9UZZzR0fqSzc/L0pZiQ3GkpXP7uAMHowJjUU0577emtiCdYytCeq4iEWdOqmw==
X-Received: by 2002:a05:6102:b02:b0:534:24ad:358a with SMTP id ada2fe7eead31-5d5e21fb189mr1079410137.6.1759925741049;
        Wed, 08 Oct 2025 05:15:41 -0700 (PDT)
Received: from mail-vs1-f49.google.com (mail-vs1-f49.google.com. [209.85.217.49])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-5d5d3861b29sm1530555137.4.2025.10.08.05.15.36
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Oct 2025 05:15:39 -0700 (PDT)
Received: by mail-vs1-f49.google.com with SMTP id ada2fe7eead31-5c72dce3201so3094733137.3
        for <linux-kernel@vger.kernel.org>; Wed, 08 Oct 2025 05:15:36 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU+7asQnJipLbKp8mvcw/jmSwtqcqDPvd+4MDKGeTaRvv+rfJ1DYc8KCSqvAW9Q9SbNOfWZNG9vB8glab8=@vger.kernel.org
X-Received: by 2002:a05:6102:44c9:10b0:5d5:dd07:902b with SMTP id
 ada2fe7eead31-5d5e224f3eemr892009137.13.1759925735291; Wed, 08 Oct 2025
 05:15:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251007133657.390523-1-claudiu.beznea.uj@bp.renesas.com> <20251007133657.390523-5-claudiu.beznea.uj@bp.renesas.com>
In-Reply-To: <20251007133657.390523-5-claudiu.beznea.uj@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 8 Oct 2025 14:15:23 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXe+hU5ryDOhdyL3Ng6Dd=+Xj-S585-duRgq5kcm9SHBg@mail.gmail.com>
X-Gm-Features: AS18NWC41OCxyAm3HqpYys4LAep69bTxUP4YHs1nq_HCZwAoIiGa8nxTffJE60o
Message-ID: <CAMuHMdXe+hU5ryDOhdyL3Ng6Dd=+Xj-S585-duRgq5kcm9SHBg@mail.gmail.com>
Subject: Re: [PATCH v5 4/6] arm64: dts: renesas: rzg3s-smarc-som: Add PCIe
 reference clock
To: Claudiu <claudiu.beznea@tuxon.dev>
Cc: lpieralisi@kernel.org, kwilczynski@kernel.org, mani@kernel.org, 
	robh@kernel.org, bhelgaas@google.com, krzk+dt@kernel.org, conor+dt@kernel.org, 
	magnus.damm@gmail.com, p.zabel@pengutronix.de, linux-pci@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"

On Tue, 7 Oct 2025 at 15:37, Claudiu <claudiu.beznea@tuxon.dev> wrote:
> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>
> Versa3 clock generator available on RZ/G3S SMARC Module provides the
> reference clock for SoC PCIe interface. Update the device tree to reflect
> this connection.
>
> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> ---
>
> Changes in v5:
> - this patch is the result of dropping the updates to dma-ranges for
>   secure area and keeping only the remaining bits

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

