Return-Path: <linux-kernel+bounces-840225-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7470CBB3DF7
	for <lists+linux-kernel@lfdr.de>; Thu, 02 Oct 2025 14:23:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 347F916DCF0
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Oct 2025 12:23:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CED593101BD;
	Thu,  2 Oct 2025 12:23:04 +0000 (UTC)
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB3963101A5
	for <linux-kernel@vger.kernel.org>; Thu,  2 Oct 2025 12:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759407784; cv=none; b=XEbt6PbFkrzjs9eUPSAlS2HRFX9YS5D9rUdy/BRUaVJeQnxZXbunwicWrMZx9F2udkgpKUNC08EsjWNSzg9rDegJk4A6pInOJYp1eBA7C4UtNk4Pi3RJg9qko6Z/maSJJG7Uaq4s9DjINP9e0yydAcuFo5Xg0skvv5kfR+3Vz+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759407784; c=relaxed/simple;
	bh=Tqtk/3Mjh7EHlittC8esBGgOeAbCYg7iKT03peJmm8E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jE2WUL4Hkr4lVl3AfegOEyD4RN8i/6Yac/W7Yvs5WvjCTxYHTG3RqM5NSbnQhpqZczVvpu4KMp7Y2E0tEdb/6a+H3qhZDNI0Xm/7DkSvRdXYPbIXc4faOdjzexJDsQY6MDseOy1ZMue1OZ/eZBLKFfRal3360igyajukc2Buj0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-afcb7ae6ed0so161110966b.3
        for <linux-kernel@vger.kernel.org>; Thu, 02 Oct 2025 05:23:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759407779; x=1760012579;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8Va9V2uUOhWQg20/22Fe+/4og8vX6tT9a0pItbdogQI=;
        b=ijFSkDm963woikaTJx3pm7bn+tE90Bmt1zkKbzCZfaB5TSya19uUt5BdAbOdXCTFnn
         fvIqXekZ1D+iAPddWgKR/bUEpaS5drWtzAAvTXavysBJn7fosZARBRaNi6YKwsrWQ9uV
         Qa+lShwVEFu9q9QoL3aD4hwJyPt5bxIDc5B4lNbZOXx7F6xcZahvRvuVI+K3e1xd14kc
         dk5xKlGQKdUJ1VWySi/BeiWO9ajBavZgINMJOB3mSICcxx7GLdG9miqTuc36hfbCWgKN
         iXsBTg4zkofshoXi0FknqUEal4V4qiJaFolvxjp8Zhzws6jqCdOFBNZ4HqFUK56Rs3j/
         UvQQ==
X-Forwarded-Encrypted: i=1; AJvYcCX5iBmWgcjShqmao61e7U2m1HCayo1q1uPfhlztpyhBVUy1pAkUio+G1p1yJhQYWxqWkhzZZYZqH/QE5oE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6TQ+Hv6NV8/Bm86W/WoWWg6bz+BeEnjfInLKbQ3j8VZy7zadP
	Whzsc0IUXX6vF/0TBlL2IEwusS1G6ujLxHLHcT+7uQ8VNG26HkPMar0ZeFObR3LWNpw=
X-Gm-Gg: ASbGncuhNH5Br/csCFjuScBGm/jUs1rY7YijVbBSyakO9LsSHTNMpmjcj//AYrz7QZC
	XGDxH7KMiXeKyA9YVfO7ve9DpOEuohj3j8RxxvKNzVeXkboHOTW0K5RWvDGE0xphOR5ujV1fKBh
	qJaIDi4WX60J7Yld/ECqk8qLiTF0pitTXd02nCqAow6G2mNBfoHAc+jBfLDRp6jkZ//VRnm0ehP
	NDJ0b+09fj1q+3n1LDxgnEeI5nqPTkJKCILdRewGZXhZGLd7sVL8n7TWXSDUSASTWtgyNGzcIeE
	xiLYdZGbk4qI0rOL+j9tSOY5N2paHXlyEaTUYiKAMzRWeMnW9mUxJ49sp3jI7yKFE++M9+2E4rv
	RWTsYShOPfIij1qAGPKZUSYxHoeAN6lTcyR0IPR0f9DUOyKd6x3UciqfdRCRrQxjdRuXIOO52QN
	py/SLY9re0R81znUzwjow=
X-Google-Smtp-Source: AGHT+IH2YyZihoygUgR3vDPGIXvvwQ2w2JtSgPccpelZmacJuitH0MqGpoazGaR1FXedop2GeQU+dg==
X-Received: by 2002:a17:907:3ea1:b0:b44:8fc5:15cf with SMTP id a640c23a62f3a-b46e6226b67mr957234166b.25.1759407778416;
        Thu, 02 Oct 2025 05:22:58 -0700 (PDT)
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com. [209.85.208.50])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b486a173a5dsm188479166b.85.2025.10.02.05.22.56
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Oct 2025 05:22:56 -0700 (PDT)
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-61feb87fe26so1450777a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 02 Oct 2025 05:22:56 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUCkK7jcVLA1st+wTGZwxqzpDb0Pb/spHbHSxtVrt5OO9QflPyZ3Fb3ixUC4jVYDIRej2GXL7SOB5qM7CA=@vger.kernel.org
X-Received: by 2002:a05:6402:518d:b0:62f:2b53:5f7c with SMTP id
 4fb4d7f45d1cf-63678c4d329mr7937739a12.19.1759407776512; Thu, 02 Oct 2025
 05:22:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251001122326.4024391-1-cosmin-gabriel.tanislav.xa@renesas.com> <20251001122326.4024391-5-cosmin-gabriel.tanislav.xa@renesas.com>
In-Reply-To: <20251001122326.4024391-5-cosmin-gabriel.tanislav.xa@renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 2 Oct 2025 14:22:39 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWF9ZLrUMrk0LvDqVTPPnm8bAvqf3-hvtobpZpL=S=XSw@mail.gmail.com>
X-Gm-Features: AS18NWBgQP_ruL9GwGLtrsdk2TQDw2PTGEAqKYNAvgwmaawF9Btroxq-FKYQXOI
Message-ID: <CAMuHMdWF9ZLrUMrk0LvDqVTPPnm8bAvqf3-hvtobpZpL=S=XSw@mail.gmail.com>
Subject: Re: [PATCH v3 4/7] arm64: dts: renesas: r9a09g077: Add ADCs support
To: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Magnus Damm <magnus.damm@gmail.com>, linux-iio@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 1 Oct 2025 at 14:24, Cosmin Tanislav
<cosmin-gabriel.tanislav.xa@renesas.com> wrote:
> Renesas RZ/T2H (R9A09G077) includes three 12-Bit successive
> approximation A/D converters, two 4-channel ADCs, and one 6-channel ADC.
>
> Add support for all of them.
>
> Signed-off-by: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

