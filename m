Return-Path: <linux-kernel+bounces-862343-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6456BF50C2
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 09:47:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 890553B6145
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 07:46:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3536528000F;
	Tue, 21 Oct 2025 07:46:16 +0000 (UTC)
Received: from mail-vs1-f47.google.com (mail-vs1-f47.google.com [209.85.217.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E7B2263C69
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 07:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761032775; cv=none; b=kVtHoxE94tf88V3bbH4XXP5yOkFxdrfITWd5nsPyetR2ng1beCAMOsUPEcwOfaLS0jOqfxHqNZ7cB9dNVq1+YGnujBPkyEJjYyQntpz7YFRTXu1QSEZRNet6KUJFrTcHhjV967sLx010uNvuKTGRiN+Bv/IFzQIToVHHcgep94c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761032775; c=relaxed/simple;
	bh=8b3HA5v4yZAxTJ8eIP9xopr8fWpaOCAQs9WFX5TX3YA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=q9yUsntutD+5Fb3oEhiejTFbQWQvDCYV2hKJ8brt3scDWfEMS2kms12FePfJUSZ0LJ53uQ7B+MQv1tvVGe7SWprL3W7aTUqNTTQ+JI+NnncRGeBVX3tZkkwqEdgyBw371T6ZnZLIl91ckbeWa0azY2DIwUYQyvoEOwq6/6emnKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.217.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f47.google.com with SMTP id ada2fe7eead31-5c7fda918feso4653503137.0
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 00:46:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761032773; x=1761637573;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dz+xjmqR6cEerBTfm3rdjied7saH40mVkJYUcW/wH5Y=;
        b=i6Fp9c6Kfr/+ECZ8f0ZXPqZzTCEkFmccRo/ZKELEGOhlQLY6ek3gBB275npRlhsaZB
         qrach54X7TloF+bRKaFtrnUxORWyFc+1VBdAIUhSHBe5XXdIctbD2UOopP42C1U191kj
         FuhfW0WjHjyAz+Aj9P/zAWOqXm7xXleOVUro5Rn0iRNh1VRIdyBL8/15CiEiA3wSDMb6
         0KyziRu35km3qY3DzoImKHpBQD0H0b1cjUi6S3/sUIXR54dYbtYN35+ka7uexK8Qyrfd
         ZhSB6xNNL+zwt6QtVrIpnb5NGask2GOaGd6QSKlOsrbCzXuRTq9OHV7ttPsMjq6MPUPt
         s80g==
X-Forwarded-Encrypted: i=1; AJvYcCUD98itc4ZuW0fWQCY93Q/ZMKFUxkm8oeL+cmv+UeSSXfHnqpdZsM37Y+Ps5YrbLvkQxH5ZFqsc/nVoeNU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5ZNl4DFtbxF+kjezWiAbX+nMBW1w16XTd1UcCE+mAZAqDCSnG
	hq9Iyw5LxXlXmaeAcSJBmWey7rE8/kYt9CAKr3jfgkVj4/L4zkbfUtDzYfKe4795
X-Gm-Gg: ASbGncuyFy/tK3ZaTe09QxS4l9/z4vqG/SEJB9A62xPHAfS1pOh+MdK/2mj9C6NmNYb
	RpDoDdZ+hwKlgc3QQFzafQAAzpQvIXmwnnzmajtSBJlMnFyU6juSFT+6dr7FJMKV4gMT3oso2xE
	X5NnyrT+duTmkszv5LgQabZYwmbasDT/WLtVJq91mAVr/uyCcQZxyrP6TkJgZSuaOIJXGfwUg9o
	UPcufVwocgTmB1rYA8hj2nqbIIS+Tt5lk12Nlopx/0gaZeFGHkmp5txqEw8oUbvJY3QdrhLbVSW
	VhbzxgFWKJMg/ku4zuYon+m3qIIB0Ie1mBbMUmSL1Q/zgfttOXsEb9/piobLvN5W+EsD8552QQt
	jrgSBdMulw3RCiPKQadO/xD6R6f3Ctc2YjI6fTd7BCAUEZJISsQXlsTMyCNPQaTQjuCofOPd1M6
	vo5StoyOpbnD8O7eN6Y5KR2DVdVB22rT+vbFOlYZsL5QEuIDWF15YoAYkOye4=
X-Google-Smtp-Source: AGHT+IHkwK2NAe/7NQt7gij/7Y0M9feIs0t9eazrCfueczXAwZqEYYjy+Q94KhDaw/xwS9KVJKfdYQ==
X-Received: by 2002:a05:6102:3a11:b0:5a3:1889:a326 with SMTP id ada2fe7eead31-5d7dd42f367mr6072198137.2.1761032772933;
        Tue, 21 Oct 2025 00:46:12 -0700 (PDT)
Received: from mail-vs1-f42.google.com (mail-vs1-f42.google.com. [209.85.217.42])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-556620d8cfbsm3101420e0c.20.2025.10.21.00.46.12
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Oct 2025 00:46:12 -0700 (PDT)
Received: by mail-vs1-f42.google.com with SMTP id ada2fe7eead31-58de3ab1831so3993997137.3
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 00:46:12 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUAUW7NeQOkfumr9xCmK7XLju4dPn9lvJA7jjJ5AnsNcwVdwpBNIdUbhE8LXqxnZ33t+WWyND+j2pVzWuw=@vger.kernel.org
X-Received: by 2002:a05:6102:374d:b0:59d:b0f7:664c with SMTP id
 ada2fe7eead31-5d7dd5ecfc8mr4994352137.35.1761032772016; Tue, 21 Oct 2025
 00:46:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251005111323.804638-1-cosmin-gabriel.tanislav.xa@renesas.com> <20251005111323.804638-4-cosmin-gabriel.tanislav.xa@renesas.com>
In-Reply-To: <20251005111323.804638-4-cosmin-gabriel.tanislav.xa@renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 21 Oct 2025 09:46:00 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWZKDmME8vtCOR6xdtKxXO6YdR=60Nti8_Dc0SH8TnVwA@mail.gmail.com>
X-Gm-Features: AS18NWB6U78jSeH5jtDsRrmJGY1udV7PT7USkr6r0d8-dTFiq84SEiscvsgnda4
Message-ID: <CAMuHMdWZKDmME8vtCOR6xdtKxXO6YdR=60Nti8_Dc0SH8TnVwA@mail.gmail.com>
Subject: Re: [PATCH v4 3/6] arm64: dts: renesas: r9a09g077: Add ADCs support
To: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Magnus Damm <magnus.damm@gmail.com>, linux-iio@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sun, 5 Oct 2025 at 13:14, Cosmin Tanislav
<cosmin-gabriel.tanislav.xa@renesas.com> wrote:
> Renesas RZ/T2H (R9A09G077) includes three 12-Bit successive
> approximation A/D converters, two 4-channel ADCs, and one 6-channel ADC.
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

