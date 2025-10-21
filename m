Return-Path: <linux-kernel+bounces-863026-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 68A78BF6D22
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 15:38:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 88FAB189033D
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 13:37:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D5191F0E26;
	Tue, 21 Oct 2025 13:37:01 +0000 (UTC)
Received: from mail-ua1-f48.google.com (mail-ua1-f48.google.com [209.85.222.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FD5E22B8CB
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 13:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761053821; cv=none; b=IoRQ4AXa8ohSVyNz0GoLwyUqliGIlC6y+B+OGm39xQXzF6ko7nro2b+jxUKL1u/moXmPIxjCY2qaPrxd9JbUM0duKHLj72uStIAnDrN5Z60gTULdCMPQv3ROZKrmS+l4mn2cVKpSDefpgAAhm1v2OZCFq8blpORvQOhtHPBpNsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761053821; c=relaxed/simple;
	bh=rFDpMMd/J7LmBoOgvX90w3JvXvtchMw0C13OGNdvG04=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J7+fU13g2u5r3DO+GH5Zam7KDkhxIrg/p4HbPkkeqz2CC/Fv6TuSwnd7aGaAzXDP2vRquqWom/DEkGi3F3fbS49bj74h1HpigELE802O+Jc51UHQZo9FYlYej1PYFW7wE+ty+Zzlk0QO+fnHn61Y5d7gptxbrNfgeu/Qr30NX5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f48.google.com with SMTP id a1e0cc1a2514c-930c4cd6ccbso3500452241.3
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 06:36:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761053818; x=1761658618;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=b78/bqYwVh1ldrSw5qZkZyL5FOTBO1IYeO3ztxHSC8M=;
        b=fHLjTclSB6TafAJE5tNMafzFD7Nmu4G12cNP88GuPqVZer03EOl0Dv0DKCi2qkC3oN
         FnUcy87ynLzoWh+RxO8WrbhB14XiRbpImG8GsefbS/lkTYOCfqU2z/uAxB3xKFEP+QhR
         CwxDx0oRALC1FkCPZjndTFJ5P8OwAB8s6uXp9/++J3VhF9vHsvEyYL8CHSeFQWyFGvTD
         Wy2bntgbfM2Qa3nCC9UFNlv8PAkDKTcqEeC98Xw36H1cCbjp4lqcOKypEi0KtpIB7KG+
         gpqemOhNkfo6gnCkJ2eSN1J80dKlACTl31qA9dgyNmPSl+2wtNvhFlxLnkNF8jtoZDcN
         R7jQ==
X-Forwarded-Encrypted: i=1; AJvYcCWf4zH6U+FmmxLb8c64o2A3AITnbjGMFcjccQHKNS8txWtwB3HUt+PlD8ItN61DXADjHjJs8Dl3mv6tC4s=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJxNQv6TvaFHIROIXj9EwTmieQRXIyWN0h0QpI+HW9P+XHcQaJ
	opYuMji84Fh3Ssfp8E/TNarQMHY1IZjVliZmhjV7QBbJiMTCmMRUGeSevdSfofYc
X-Gm-Gg: ASbGnculnk23p/zZmfJjil68HZhBcnCNFZSgzrqf3MfKYZPMrvwd/TBrjfCc5/tOxgo
	7ExNTC+QGtCwjBeUtTHljT0MlCJbuZiM7R6gU7VmAuouU6hz1CZuYyE1FSF8bim2EFWEh+67Zoo
	Kl6W8UVgmjh3RypP2J7riYMpmn4ijZylcyJmys7eC6nhnOLrTFzFBJuN6dp7yu2zSbmbNgczo+T
	QiqEW305/GI6zvuqb7RtipJDUX6METvtmSZtpuhE87d9RVEHSsH2q9xlazucTl6t3WZaMCgdtWF
	Kn6+VtqT8hE6KBBnbTobjjPPWVhklFWu79GdB9sKAGlUdT5Au3iVLTsU9Y30IrFQjPyfqA0b+Ux
	7MUOVp3i98Buywsi/Wyl6nPpNSHZrcRzg7LHIkGwKNP6WlawgEGGnYFQKHAZdskCrf1a9MF3Nha
	9rn+hcxvfnV0WnF3IDaxtpySKi+B4OJjJaL56GUw==
X-Google-Smtp-Source: AGHT+IEciwP6ftfc+7lRudALNerik/KbdWRMAwR5XIzU2+ZGiEk9LzrpPIUBHuYBZMAKmSHdxYhf1Q==
X-Received: by 2002:a05:6102:418d:b0:5d6:5d9:dc0a with SMTP id ada2fe7eead31-5d7dd4650bcmr5276830137.10.1761053818228;
        Tue, 21 Oct 2025 06:36:58 -0700 (PDT)
Received: from mail-ua1-f45.google.com (mail-ua1-f45.google.com. [209.85.222.45])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-5d96c0ba5b8sm3593678137.2.2025.10.21.06.36.55
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Oct 2025 06:36:56 -0700 (PDT)
Received: by mail-ua1-f45.google.com with SMTP id a1e0cc1a2514c-930ff50d181so3748760241.1
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 06:36:55 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWanHp27v8MhkPB2YtYg8R3ET4LamxR4KPjY37FAu0p49az6pjM3ybV4i83vahHbavOcjM+yHmtxCJbLgE=@vger.kernel.org
X-Received: by 2002:a05:6102:441d:b0:519:534a:6c4f with SMTP id
 ada2fe7eead31-5d7dd5ee60fmr6017748137.33.1761053815204; Tue, 21 Oct 2025
 06:36:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251020143107.13974-1-ovidiu.panait.rb@renesas.com> <20251020143107.13974-2-ovidiu.panait.rb@renesas.com>
In-Reply-To: <20251020143107.13974-2-ovidiu.panait.rb@renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 21 Oct 2025 15:36:44 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWNq-DFG4_i9CN+Rb2RSgO1Sxph7HO7SNhnr0d1=LoW0g@mail.gmail.com>
X-Gm-Features: AS18NWBYsMSpOo4y4kMiKki8g1BkhV5Ulk8TYURDjYYjSArsxY_VVDXQMAlwt_w
Message-ID: <CAMuHMdWNq-DFG4_i9CN+Rb2RSgO1Sxph7HO7SNhnr0d1=LoW0g@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] clk: renesas: r9a09g057: Add clock and reset
 entries for TSU
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
> Add module clock and reset entries for the TSU0 and TSU1 blocks on the
> Renesas RZ/V2H (R9A09G057) SoC.
>
> Signed-off-by: Ovidiu Panait <ovidiu.panait.rb@renesas.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
i.e. will queue in renesas-clk for v6.19.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

