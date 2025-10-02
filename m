Return-Path: <linux-kernel+bounces-840227-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 50481BB3E18
	for <lists+linux-kernel@lfdr.de>; Thu, 02 Oct 2025 14:23:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A29219C790B
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Oct 2025 12:24:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 940953101D5;
	Thu,  2 Oct 2025 12:23:54 +0000 (UTC)
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88D973101B5
	for <linux-kernel@vger.kernel.org>; Thu,  2 Oct 2025 12:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759407834; cv=none; b=jlvO2v9djysjFRwvJFAe+UK0CW9M4Fkn4L9lOMaHe5jmMISqF/LfEvWTmMZzXLgkpWraC5Ngb2KQv7umNrLYTrqsxdDaeCFXdE6Eq1KyIjqdpnScj2nkI+i+G/uA30dFkcbdJN2GIeOPuz6KhnnEZ8loAyQKvMGZmcon0SVAZqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759407834; c=relaxed/simple;
	bh=AC0onUH/KWR12euPrEMMEF6CxzSfY+hS18p7k/rNiSI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YDhijl1qjIgWFKh4NiBO2bMZsdcKhJsWW/zdWwx6XaM1IQqNFHpd/M3hjWjRbnHt7V0ITBnqJ5PMSJ51v7hE3stdk28GRHGfSHx+jPLLHCnxqWFon4HyeTtm5Lo4y8uZ1aY8h2N0sWdCelmIoaZpoA42UPOWXtm/pYilLftYhyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-62fca216e4aso2128337a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 02 Oct 2025 05:23:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759407829; x=1760012629;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JHq3klzPYB8yjcAVOmszOfkdhflrtsWL0PRMLhhvkhU=;
        b=nBBRoDDGvCYHW6ege+4UdZQ2DE+qNi3uj0XHdRvLD4EjU9PGKZX7kBJknOomlFUs/O
         t7D/lk2iiaakxBVcRMGEfoGAw3EcW4hZJC4pqUtw4X3ujwTIYSqy2FEeCPTPci7PbFCp
         6pTNfhAAKcb8lAWN1tOBSep/AluOWyZxZvdCp/U2AgmZ/pexjuCwp/R9Htoxix4fl90f
         B+HKIC4vFryftU0wiGiGe2F022QLpJUmTUzBsvZBoO7Ni6WOm0ZDJ3TU0PgxP7cjROpm
         B6f6xYqSmestk4uXAu9TOwx5Wkak2rUaGMu08pWUucalNmBVKyCx4J1SRz3AFEDsAJO+
         1wdg==
X-Forwarded-Encrypted: i=1; AJvYcCX9WoF08bxruEgRUL5q4bj9ZVrmnRwt6ePn420U725n19SPCNyERr5GlGJStheFfKTDH/zzrFgNxyZc9n8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5lptrFjWq6jD95dakNQeNwJM6SjRXFkGqItsOWJzvOn7fTrnx
	+p/Dk8L67jp0lVs4MlyEQV9Akz+STCkBjlxgmIKRykQm9o4uPgdWh8/Mli0Aukv4nag=
X-Gm-Gg: ASbGncvoPGzCLAdVT3jMciLRCwf3bnNVxNLBww3JH47uJmxhWg/ar65POkuMizh3CxI
	2ZCj71RddnyzE9KSsaeO7kwLPGvQh/O4PT8TqM3We9QKZ23pSW8KaITOAqayLY4LnJechoA4A5+
	GVoFTua4FZhYyYPQ1H1SN1xCkflXLWkUU3uHHayXzjywiqn3cEb74CUr/7BLZ+ayxVwQHAQemxt
	FP3ahKKA/eemtSsF3VZ7EYHy+wWGEkfpAD5ZgnZJaC8Vw3UbQWiPotc2obIYuK/muuq4FAvNwnR
	tSq7DjzuWUpBri7bpjw+B6AzTbqUZvrFCFLsQsaOosEttyz/A3qdksZTYs01W+R5nC/nGibWZBT
	4MwejdmenWvbNinfkuP3qJ57ANJ9kDVosno465HwJN1pC8JKtzKx6s28c8T/9xIsEn3aQIpzBr9
	GgsDuDmOICf9ZMBkVzuHWa88AqzzIgeQ==
X-Google-Smtp-Source: AGHT+IG/UNG1w1GMbI90A6htc52w2xMrWB192K5hQl3K8CMEUq7aN/i2Doc8vtnUeBqy+lgw1ieSPQ==
X-Received: by 2002:a05:6402:1809:b0:62f:2b4a:fb34 with SMTP id 4fb4d7f45d1cf-63787ea6e70mr2741268a12.14.1759407829271;
        Thu, 02 Oct 2025 05:23:49 -0700 (PDT)
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com. [209.85.208.43])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-637880ffdf7sm1770136a12.28.2025.10.02.05.23.45
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Oct 2025 05:23:45 -0700 (PDT)
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-62fca216e4aso2128002a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 02 Oct 2025 05:23:45 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXqCyMURekp/8XdJ/YuopE0o7L5JMnYOnlrWYuC0pv+5f5AAKBaMPb7BfcK9BYs6d3mM0CT7fjbzIGNiOQ=@vger.kernel.org
X-Received: by 2002:a50:99db:0:b0:631:6acd:fa3a with SMTP id
 4fb4d7f45d1cf-6376a8cbaebmr2386247a12.4.1759407825048; Thu, 02 Oct 2025
 05:23:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251001122326.4024391-1-cosmin-gabriel.tanislav.xa@renesas.com> <20251001122326.4024391-8-cosmin-gabriel.tanislav.xa@renesas.com>
In-Reply-To: <20251001122326.4024391-8-cosmin-gabriel.tanislav.xa@renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 2 Oct 2025 14:23:31 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWQZzgv-St7a05Z0nr6ijDG=a5UT6dkz0apx4Ympxowgw@mail.gmail.com>
X-Gm-Features: AS18NWAPPSWmlScZEb54OFRRxiDbKu9VBgdxP80maayV33NLkOLsg7T87DMtor8
Message-ID: <CAMuHMdWQZzgv-St7a05Z0nr6ijDG=a5UT6dkz0apx4Ympxowgw@mail.gmail.com>
Subject: Re: [PATCH v3 7/7] arm64: defconfig: enable RZ/T2H / RZ/N2H ADC driver
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
> Renesas RZ/T2H (R9A09G077) and RZ/N2H (R9A09G087) SoCs include three
> 12-Bit successive approximation A/D converters.
>
> RZ/T2H has two ADCs with 4 channels and one with 6.
> RZ/N2H has two ADCs with 4 channels and one with 15.
>
> Enable the driver for them.
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

