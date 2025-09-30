Return-Path: <linux-kernel+bounces-837552-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 30AFBBAC8C8
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 12:48:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 22F0A7A6373
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 10:46:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A71D5246327;
	Tue, 30 Sep 2025 10:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b="eZeZ8GT0"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC1207D07D
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 10:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759229295; cv=none; b=TFjKtSk20d+wHbLbouEicL1MaUK8ButN/7Wbj2VzuKuflgABJchvtjxe1BdOP5VYJ3qWL7Smh8w1Xahlhwzv1HxBJISR+P1etXMkUtuuoC4cmsRjFBSHfvYM7Sea8BLRFFkuismP98GLZzmEjJtlQ66zZR+0ksvmARMbhU31iTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759229295; c=relaxed/simple;
	bh=nV3bejKOePKliVyl0zfUUpgLWXiBna2xWHLBgxQxNyY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DeTADdTZG+kSGBUx0j2J+jC+lzIETyPOq1rD5uj3yJRJBMSLY7j6GhdJRtwY7v0mO8KfLVRN4W8sWeiEcu+L3ZQXV620zjPj4UEP5PkCtGoJeVx0/QJRqWSTiCYJC4sB9fi5pUtxEJqhtmh7y2XjF5+geqT/L0uY9xdIzj+HNqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=raspberrypi.com; spf=pass smtp.mailfrom=raspberrypi.com; dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b=eZeZ8GT0; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=raspberrypi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=raspberrypi.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-b3727611c1bso1062480066b.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 03:48:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raspberrypi.com; s=google; t=1759229290; x=1759834090; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=KZ0CnHPdlZrSsgwV+MI1ugRW5zrN2qsnIK75AqoOWqA=;
        b=eZeZ8GT02FUZpdTmP6ZJxN2EeC5xpyzE52oG5/wF0l3tswZkrApNZ0wUIbl2x275rI
         y0swHxHOZ88P+DZjCbNGFmx4PoRifitUabNzpJBcuWYGDTRLg0Y+ATYs5wV2emPDp92k
         mNYGv6S/BSGhwjUihf/1NUQCTjTm9rtJNQUl+p6CYPsQ5CT0IlNRWdcRnyYkRVoX7anQ
         S00qPXwZrNv7uatQrrXPOVLZEkia6iASAHLN99TCoTUg++2p1Nvb5IhdBcJyRqM8GGEO
         Ar+NPscSYXd/mWgtW18UWHgOgp4X/go3VVC/vVHrFLRDJ9E/yPf7jNfeJSd+uF7gQx8R
         RD3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759229290; x=1759834090;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KZ0CnHPdlZrSsgwV+MI1ugRW5zrN2qsnIK75AqoOWqA=;
        b=vDpkWoL3NOkcCq5u+L4qhW15krDmHvVbzpQYRfXJTP8JR107HvKc6/tHosQ0wpBOX4
         yCJSYZVrivznFC5lB142EfwwU4PePrfVnkaCcuOVJxDwT5F81zfzojGfF+VIbxKr2+k6
         IGkTghZWyAcrJ7dPVqAjf6yEmMr9S6qy+xIKW/MFZfoK3GLQO0ZnK0IjZH5TLcOfHHhK
         S5wVyuZzvNRL3V5Fn1xqinfb02zObwFsywIxTATT2cGMhwPsRbs5/7Ko0rwOGTVxUIr+
         Iw0UsJnoZ59vSj7kENYvRxR88b8lvDTV3HweCmh2R6EwCvyRM3LJ2UlxMbkOpasRr9Cu
         LFcQ==
X-Forwarded-Encrypted: i=1; AJvYcCU9T6FXc9oq0q/nUzExfL7xGNRLxNK9i0a8WSszadbTyQpcmcXZpiqbZmlNbJI7y3Q6BppjMlY5m+y1cv8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzkX+ctlNMkKNtCMcIgoRcmFLUn2J3uHBvSzhLvl6JBmX+EcdfA
	NfdB5Ommo6fDar+St3KucxvV15hmiLQXkhPG1uKKVnpN3ZdbPUUlLx4EcT4Rlvprabdx6cSHgvN
	vJF4HFh0HzKwyPdnx6HTPR5/9aeEzNQUUUDREGPYnLA==
X-Gm-Gg: ASbGncsZGeAxDRi5BYwUjoxU+uwEOiP213pZQR34PJt/txH3M/H+k/pnXNuzWykU4zO
	ueQfvP6VNroVWuVpkFXQQZFl6c7JaHiEXqTEs7i98jU7osJXDcYLOwrOUqQ0bA42Rq1flzCj1Wx
	o0V5WMatFnLtSho4MKJlafA9NMaMGjg244yVFT7zd0gvvyDeWW+gzYeU8viOHG14bXlqvvN51w9
	N+y1YutkwchWc4q88QPWZjpV3DnpgKp7j5gH8aOPFGc8QRqGVSgLbBmIIkXMTx/xrvNw7wn
X-Google-Smtp-Source: AGHT+IGX6zNpxjsPjtC0C+vJp47Ah8di0xP4NLfAUEWW/OF5HmCNHB9bJwapc+3TAx0PM7pbADgUcyt3dY7ecyU5L7E=
X-Received: by 2002:a17:907:2d1e:b0:b3f:1028:a866 with SMTP id
 a640c23a62f3a-b3f1028b3c3mr763065766b.15.1759229290129; Tue, 30 Sep 2025
 03:48:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250925000416.2408457-1-svarbanov@suse.de> <20250925000416.2408457-2-svarbanov@suse.de>
 <20250925-outlying-causal-015d8ba33c53@spud> <89dd04b9-e261-4bdd-83ab-499e46fc9c01@roeck-us.net>
 <88bd67f2-de8c-407b-ba98-08663eee2d7e@suse.de>
In-Reply-To: <88bd67f2-de8c-407b-ba98-08663eee2d7e@suse.de>
From: Phil Elwell <phil@raspberrypi.com>
Date: Tue, 30 Sep 2025 11:47:58 +0100
X-Gm-Features: AS18NWD2rGnxVnwcFBxYV1aba-fyNrawMU6W-du0N-jpjKmm4LpdaR5Bhec5eAQ
Message-ID: <CAMEGJJ0KqPX462iigbMP+fwoyZgZ1J1PqaWt82MrNTW1VMwbpQ@mail.gmail.com>
Subject: Re: [PATCH 1/4] dt-bindings: Add Raspberry Pi's RP1 ADC
To: Stanimir Varbanov <svarbanov@suse.de>
Cc: Guenter Roeck <linux@roeck-us.net>, Conor Dooley <conor@kernel.org>, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-rpi-kernel@lists.infradead.org, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, linux-hwmon@vger.kernel.org, 
	Jean Delvare <jdelvare@suse.com>, Rob Herring <robh@kernel.org>, 
	Florian Fainelli <florian.fainelli@broadcom.com>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Andrew Lunn <andrew@lunn.ch>, Stefan Wahren <wahrenst@gmx.net>, 
	Saenz Julienne <nsaenz@kernel.org>, Andrea della Porta <andrea.porta@suse.com>, 
	Jonathan Bell <jonathan@raspberrypi.com>, Dave Stevenson <dave.stevenson@raspberrypi.com>
Content-Type: text/plain; charset="UTF-8"

Hi Stanimir, Guenter,

On Tue, 30 Sept 2025 at 11:21, Stanimir Varbanov <svarbanov@suse.de> wrote:
>
> Hi,
>
> On 9/25/25 11:37 PM, Guenter Roeck wrote:
> > On Thu, Sep 25, 2025 at 08:40:54PM +0100, Conor Dooley wrote:
> >> On Thu, Sep 25, 2025 at 03:04:13AM +0300, Stanimir Varbanov wrote:
> >>> Document dt-bindings for Raspberry Pi's RP1 ADC.
> >>>
> >>> Signed-off-by: Stanimir Varbanov <svarbanov@suse.de>
> >>> ---
> >>>  .../bindings/hwmon/raspberrypi,rp1-adc.yaml   | 46 +++++++++++++++++++
> >>>  1 file changed, 46 insertions(+)
> >>>  create mode 100644 Documentation/devicetree/bindings/hwmon/raspberrypi,rp1-adc.yaml
> >>>
> >>> diff --git a/Documentation/devicetree/bindings/hwmon/raspberrypi,rp1-adc.yaml b/Documentation/devicetree/bindings/hwmon/raspberrypi,rp1-adc.yaml
> >>> new file mode 100644
> >>> index 000000000000..5266b253fd2b
> >>> --- /dev/null
> >>> +++ b/Documentation/devicetree/bindings/hwmon/raspberrypi,rp1-adc.yaml
> >>> @@ -0,0 +1,46 @@
> >>> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> >>> +%YAML 1.2
> >>> +---
> >>> +$id: http://devicetree.org/schemas/hwmon/raspberrypi,rp1-adc.yaml#
> >>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> >>> +
> >>> +title: Rasberry Pi RP1 ADC device
> >>> +
> >>> +maintainers:
> >>> +  - Stanimir Varbanov <svarbanov@suse.de>
> >>> +
> >>> +description: |
> >>> +  The RP1 ADC is a five input successive-approximation ADC with 12-bit
> >>> +  resolution (ENOB 9.5-bit) at 500kSPS. It has four external inputs
> >>> +  and one internal temperature sensor.
> >>> +
> >>> +properties:
> >>> +  compatible:
> >>> +    const: raspberrypi,rp1-adc
> >>> +
> >>> +  reg:
> >>> +    maxItems: 1
> >>> +
> >>> +  clocks:
> >>> +    maxItems: 1
> >>> +
> >>> +  vref-supply:
> >>> +    description:
> >>> +      Reference voltage regulator 3.3V.
> >>
> >> Looks like you're missing the io-channels-cells property that allows
> >> this device to be a provider of adc channels to other devices.
> >>
> > Only makes sense if the driver is implemented as iio driver.
> > Which would be fine with me, assuming this is a generic ADC.
> > The iio -> hwmon bridge can then be used to instantiate a
> > hwmon device if needed.
> >
>
> According to the RP1 peripheral document the information about ADC is
> limited and I cannot be 100% sure that this is generic ADC, but it looks
> like it is. On RPi5 board the ADC inputs are not configurable, but that
> could change on another board.
>
> I personally don't have objections to implement it as IIO driver.
>
> Phil, are you fine with implementing the driver as IIO?

The problem with adding unused functionality, apart from the effort
involved, is that testing it is harder. Will the IIO driver be
inherently better/simpler because some of the hwmon support gets
picked up by the generic IIO/HWMON bridge?

Ultimately we'll make whatever changes are considered necessary in
order to get this simple driver accepted, but it would be nice to feel
there was some real world benefit now for the work, not on Pi 6/7/etc.

Phil

