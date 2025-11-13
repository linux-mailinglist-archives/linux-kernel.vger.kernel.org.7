Return-Path: <linux-kernel+bounces-899477-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DA66C57E00
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 15:16:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BE7C44E66B5
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 14:12:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 820D3272818;
	Thu, 13 Nov 2025 14:12:23 +0000 (UTC)
Received: from mail-ua1-f43.google.com (mail-ua1-f43.google.com [209.85.222.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0555219ABDE
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 14:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763043143; cv=none; b=GbIjirExxr+FbFvKO00vQGxWfWAvt67OkbW8hZVbRuNWXeyBmIPClOKxN4rQYoJL5VoYGVUdDfphuSGz5S7XhIrwILfG63nmYwOT5yaL/FZgBtr9BT6GcgmhJvo4kcDooCtofDbcC9gFHvgyrReATMhVaYBZD3CDmlO3C3gkGtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763043143; c=relaxed/simple;
	bh=comZjXuDIDnizqUYHOKDvMQRgHC3+80Q+P6ov/b0Rc8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A0zymhZLjSOqJiyMadeDADzLoNt6Za3Yf8afxUQvLMqz784Gw+Oo02iqcAVazgFa9CsF8BVCnl4wcdwILff6J86hzm8A891RJ7mIOQd68oVMgtYv/3l70+Q/TDV6DcZh9MrIxg2qROg7y6Anzt3MIU5dZgLyrkQ/LBXBaXYqrCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f43.google.com with SMTP id a1e0cc1a2514c-9372a52af7eso237031241.3
        for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 06:12:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763043139; x=1763647939;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ulWJQ4QTuc71083HdY/1CUbZ5xknk1Yhidqn40qfX8s=;
        b=AYuTsma7s6ihNq7c1afzPRA3d7HGIyU34OVibhz2If4THJA8ewVHUr58wNFSkthvBk
         W4djqLQE9W2hRlmR3rxAm6o+ZYQgkpCTnsQFrkC6KcBkoK6xBK1GW70XlAC3D7Hey3OE
         T9/4w36cg4sN1guJ54/HTOUxTOpDhwy4YUAIVuHeX9fVWt3pweHxwpp2X6BnRaFQ9Fyd
         xKKZApVwcKRL7aGe+KxKH6SdVgYnRcH5oLoRt0YrpnhElaxIu3hDkVMav/fyPwXRNFM9
         twmJEomuWgcgNqD4efz/wFDqf/JODAHbZlXWTZk1nxM1wRYhdK29V66A3JQKA35UybZI
         TMyA==
X-Forwarded-Encrypted: i=1; AJvYcCVexQzzIdY4YxmHnqnBBmNHdIbC7FPgz9XUHlA1Yvhn8aplRC4xEBsWcMVNUE/y1Zp/XoSzckRq9PhSY+o=@vger.kernel.org
X-Gm-Message-State: AOJu0YxlYjVfcoYQ3ScSmOo2hF5Kf9rwjG+TfedGF5aeMS1MaSfcBmsg
	79Cw/24lQVYX0PNuuMbZkxtDIRhocRQgrB03WbToPV1ILv/oCBY93YRBuX+CUXfIDGY=
X-Gm-Gg: ASbGnctF81ENrbRjkr/53XuSYwMHmW35pJgnBoEu6aQxnuQAbADaI6cbi3R//2Y8vNf
	ZNUyaGSsjLP+mbzKgSyE86qxQOew50Ej1zRDzELzr3ZoJT/VfMcYeDHITW6qPUFisz4kyve5kYc
	nN9EUeKM8TPYVrNRabyXfZbPGY9cJ5bn0KHBEXfrZQA70aPGnT1qKjOPe0Qn0MXjgeGEa4bpxdT
	zsv8sG2s/UZ47t663J7vbm+qQCP0JGlI1KJ7lszUu6bGFGkBfZYKLZO6UCjwLb1A2g3kyM003Wz
	yq6K+CbIdXgdZOW8XGaDGMqDhjFUxyNhliiZwcApKtoT4ZGMUU8sNWw8kUNlKWX3tp7Zl606X4W
	ydr23H7K5Kpw2wrwunc/HspE/9x+8ruxs2hBFLLnNhOtOnRaATf+r21qfGkReV2BPGF5TSbyR+P
	Pj/gqevJNk7ERsCBuXvnt9Zvc1IGwAkrn5hQ2cvg==
X-Google-Smtp-Source: AGHT+IH8rQGBoOnvVzpKheeNAnvxcP21M3uk380nKMzbeRTt9piy5Nv8v6LZBjKmlTbEeYvMAMNE8Q==
X-Received: by 2002:a05:6102:c8e:b0:5db:f47c:15ff with SMTP id ada2fe7eead31-5de07f082ccmr2150415137.42.1763043139327;
        Thu, 13 Nov 2025 06:12:19 -0800 (PST)
Received: from mail-vs1-f43.google.com (mail-vs1-f43.google.com. [209.85.217.43])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-937611bf6fdsm619578241.12.2025.11.13.06.12.18
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Nov 2025 06:12:18 -0800 (PST)
Received: by mail-vs1-f43.google.com with SMTP id ada2fe7eead31-5dbe6be1ac5so325797137.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 06:12:18 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWcDCNGvs8/E4OS2vmLPskjiRaEiUlvmjwJ7cXaZpM0KGq0Z4FbnfIVFI0FF52fhp6kDxJA1wKHdD6IWnI=@vger.kernel.org
X-Received: by 2002:a05:6102:d93:b0:5db:20ea:2329 with SMTP id
 ada2fe7eead31-5de07eaedbdmr1809754137.35.1763043138634; Thu, 13 Nov 2025
 06:12:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251107210706.45044-1-ovidiu.panait.rb@renesas.com>
 <20251107210706.45044-2-ovidiu.panait.rb@renesas.com> <20251110-hardhead-upside-54baa149f453@spud>
In-Reply-To: <20251110-hardhead-upside-54baa149f453@spud>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 13 Nov 2025 15:12:07 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUUOMYZGF2xJWUnBi8i3eggxi2+j+FB0G-E7bMBwYAGhQ@mail.gmail.com>
X-Gm-Features: AWmQ_bnlPnhXhYldo17YNgMXfp15mj6ryj0q_5g1DZAmmEAVMaJw8DyorslMWa0
Message-ID: <CAMuHMdUUOMYZGF2xJWUnBi8i3eggxi2+j+FB0G-E7bMBwYAGhQ@mail.gmail.com>
Subject: Re: [PATCH v4 1/4] dt-bindings: rtc: renesas,rz-rtca3: Add RZ/V2H support
To: Conor Dooley <conor@kernel.org>
Cc: Ovidiu Panait <ovidiu.panait.rb@renesas.com>, claudiu.beznea.uj@bp.renesas.com, 
	alexandre.belloni@bootlin.com, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, geert+renesas@glider.be, magnus.damm@gmail.com, 
	p.zabel@pengutronix.de, linux-rtc@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Conor,

On Mon, 10 Nov 2025 at 19:50, Conor Dooley <conor@kernel.org> wrote:
> On Fri, Nov 07, 2025 at 09:07:03PM +0000, Ovidiu Panait wrote:
> > The Renesas RZ/V2H RTC IP is based on the same RTCA3 IP as RZ/G3S
> > (r9a08g045), with the following differences:
> > - It lacks the time capture functionality
> > - The maximum supported periodic interrupt frequency is 128Hz instead
> >   of 256Hz
> > - It requires two reset lines instead of one
> >
> > Add new compatible string "renesas,r9a09g057-rtca3" for RZ/V2H and update
> > the binding accordingly:
> > - Allow "resets" to contain one or two entries depending on the SoC.
> > - Add "reset-names" property, but make it required only for RZ/V2H.
> >
> > Signed-off-by: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
>
> Didn't Alexandre already apply this? The changed version is
> Acked-by: Conor Dooley <conor.dooley@microchip.com>
> in case this replaces the other.

Alexandre dropped it, so it is no longer found in next-20251107
and later.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

