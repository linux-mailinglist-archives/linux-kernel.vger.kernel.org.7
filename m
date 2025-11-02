Return-Path: <linux-kernel+bounces-881988-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id DD235C29616
	for <lists+linux-kernel@lfdr.de>; Sun, 02 Nov 2025 21:12:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 6263B346B69
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Nov 2025 20:12:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E31C52F851;
	Sun,  2 Nov 2025 20:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZkrogTDT"
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A80A972614
	for <linux-kernel@vger.kernel.org>; Sun,  2 Nov 2025 20:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762114366; cv=none; b=QHdMElaups+qbWkQRNt1ctHIB11sZPVS/5P0lv6FmGIenIjANoGdpSondjzt7g34tqA5cZJM7kqmmIlaFBfacoobq2eHtaqW8N3Sr3gN3TzDtRKgxuUso8u7RQZY7/RU0OHOLewXabcxWz3Bhhbr5DyZ+qEPILDmSdcKNpBV2FU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762114366; c=relaxed/simple;
	bh=vQ70zOQjf6dVyMCSPPI6U5RCv7r28t20uFINZMdYEbw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iDxtBkM+sB1Y/tzZ+ckcpxUq9vUIsZFC9dEqrEPJ19iOK+A8NDHTW1phZcgbGXfrG+71321KXnK0qrgutuKAyel3pKZWHZkc7Q/swTUoivzTZln/Xc5xthrVoeFBJ0NTYNRJYFbob8IDucz7nIPA9pvX/drOJ53yfTJ22lcdYNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZkrogTDT; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-3408dd56b15so1824363a91.1
        for <linux-kernel@vger.kernel.org>; Sun, 02 Nov 2025 12:12:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762114364; x=1762719164; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fqxd8GSbRVyInLqowSB5ULzNB5fuvN606M77nsm3p08=;
        b=ZkrogTDT8ZnAO/WAVbFOFStqbQj0f82M6BzcYyJSHBI2N9DFyvCXl2x6hipJJQtiGf
         85cqS0PEXpbNro2dy99ByoJ7/rnww58tYa105G3bjRV3qEiZvcbYZhgj4sK3kFAySgrd
         mNqy4M2gjumG7sIgEAm0Bg1xQn7GXFEIbpl7AiYXJS432+flqWfOsmv5n8PHO189lR8T
         7thrU9/q0pNytaBeBowxjKaxXfQdAuaO0Ju/CgEeFr6HYWC6PGInfBcOd/lc+NglbopD
         rTVljUcSa85zS21k4lE10XoQqK4AtQOef4fnODOMbYgXkOq5Yf+D9cw2qtIACubsBtul
         NCSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762114364; x=1762719164;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Fqxd8GSbRVyInLqowSB5ULzNB5fuvN606M77nsm3p08=;
        b=qcahPbvzkoXptWAg0BJm8T6wTZ1guNCBa1kHVgQZCkYbqX4EsxtE+DxB8R/yZZGbT+
         cPxwfbneOX5bXhyjqKSHMvl16ByoMztBuo5QtroxMVnmus9UifHNDfg5BMGF3CaYEo1q
         n0BhS5JZ0Id/3VlLc8k1hwMj2LDJgqrJ2fDylMEolU09t3RiWr5T0SD9+hwPJE6cV9ZF
         sWqKk+XMQyRRzc+9ukOk+j6UuuLH+ZjHRIaWOJmlJXArbI9bqjA5vnKINBOWicVeBIAK
         EON2xas4tGwgGaAf9dIgcn2LVInNvFKfAcFScpYoklIyMfGuu7Q94aT2H41rTVETxJFH
         078Q==
X-Forwarded-Encrypted: i=1; AJvYcCUFV4SwIYBY83d1PqDahidzvEdiVYjykqdpYsvmTT12Bwr3foVGH++9/sU8M2ttzeTpGNu2daTgnCadt6k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzt3IIajBxcFvFTgheJVNdyMZt716EdDVG2FSwSuRWnTuQ6AbQs
	UXcAeegAwgO6E8vmTAFCH2HDPCaSr4bzlIaFY9NXxi4iaOSvJpRLj34lXHa8H8osK3PAcAVbOGr
	qDeEIVOPAztV5lsi0mLFzYUAQCBVo5w==
X-Gm-Gg: ASbGnctsGSesjXC7+HDcdMi1dJSJGeau5PmPOLG8zQmBQ6MaiK5Xwv2qK8s283idHdX
	FrReoBJhikdoVVJhMzkvYV8HBJra0ulAqeOIA5TNFDYf6dwFlou6x91PLDpCKNFCLdkjFbu20b+
	frBhBy27wn3Azte3KybPLswiTovh6V6HFYBky+02co0IX/IpyiajlaPTMgRkKPZQCyQCyedIPJm
	pqJUG3YpfpVL51BPw1dAhPDhZtSqcsH6iOMw37xIuIefaPZVwOueQX5sPChUoUNVOdihT/eIxAg
	18FiFPX0lSiuebimE9DI4Qljqc9s
X-Google-Smtp-Source: AGHT+IHXziArp6Fwc3IW8oTuA21TaRtuWLVaUnoj/Nrt7XJBhwyf4bvwfdqUr10ASbu5qVVj+3mWPLSdt0i0Iz+0gWE=
X-Received: by 2002:a17:90b:2885:b0:340:e8e9:cc76 with SMTP id
 98e67ed59e1d1-340e8e9cd0bmr5531518a91.11.1762114363950; Sun, 02 Nov 2025
 12:12:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250821194710.16043-1-jihed.chaibi.dev@gmail.com>
In-Reply-To: <20250821194710.16043-1-jihed.chaibi.dev@gmail.com>
From: Jihed Chaibi <jihed.chaibi.dev@gmail.com>
Date: Sun, 2 Nov 2025 21:12:31 +0100
X-Gm-Features: AWmQ_bnYDJMb8ZNLbIwTQjuhi9qVx6pKfUX_tadjCSJdooWWkHy06CGTs7XIWPE
Message-ID: <CANBuOYqaLMV3rvdf=YcWTjiqn2A3h0a-QYM77VJvSJtSDSe9pQ@mail.gmail.com>
Subject: Re: [PATCH v5] dt-bindings: gpio: ti,twl4030: Correct the schema $id path
To: linus.walleij@linaro.org, brgl@bgdev.pl
Cc: krzk+dt@kernel.org, robh@kernel.org, conor+dt@kernel.org, 
	peter.ujfalusi@gmail.com, lee@kernel.org, devicetree@vger.kernel.org, 
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, shuah@kernel.org, 
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, aaro.koskinen@iki.fi, 
	Andreas Kemnade <andreas@kemnade.info>, khilman@baylibre.com, rogerq@kernel.org, 
	Tony Lindgren <tony@atomide.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 21, 2025 at 9:47=E2=80=AFPM Jihed Chaibi <jihed.chaibi.dev@gmai=
l.com> wrote:
>
> The $id for a binding should match its file path. The ti,twl4030-gpio
> binding is located in the gpio/ subdirectory but was missing this from
> its $id.
>
> Correct the path to follow the standard convention.
>
> Fixes: 842dcff8e2d6 ("dt-bindings: gpio: Convert ti,twl4030-gpio to DT sc=
hema")
>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Signed-off-by: Jihed Chaibi <jihed.chaibi.dev@gmail.com>
>
> ---
> Changes in v5:
>  - No changes, only added 'Fixes' tag.
>
> Changes in v4:
>  - No changes.
>  - This patch is split from larger series per maintainer feedback.
>  - v3 link:
>     https://lore.kernel.org/all/20250816021523.167049-1-jihed.chaibi.dev@=
gmail.com/
>
> Changes in v3:
>  - This patch was added to the patch series in v3.
> ---
>  Documentation/devicetree/bindings/gpio/ti,twl4030-gpio.yaml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/devicetree/bindings/gpio/ti,twl4030-gpio.yaml =
b/Documentation/devicetree/bindings/gpio/ti,twl4030-gpio.yaml
> index 5e3e199fd..96d50d14c 100644
> --- a/Documentation/devicetree/bindings/gpio/ti,twl4030-gpio.yaml
> +++ b/Documentation/devicetree/bindings/gpio/ti,twl4030-gpio.yaml
> @@ -1,7 +1,7 @@
>  # SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>  %YAML 1.2
>  ---
> -$id: http://devicetree.org/schemas/ti,twl4030-gpio.yaml#
> +$id: http://devicetree.org/schemas/gpio/ti,twl4030-gpio.yaml#
>  $schema: http://devicetree.org/meta-schemas/core.yaml#
>
>  title: TI TWL4030 GPIO controller
> --
> 2.39.5
>

Hi Bartosz, Linus,

Gentle ping on this fix,
It was reviewed by Krzysztof a couple of months ago. I wonder if it's
ready to be picked up.

Cheers,

