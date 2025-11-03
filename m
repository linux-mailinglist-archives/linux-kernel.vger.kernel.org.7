Return-Path: <linux-kernel+bounces-883010-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DA8CC2C42F
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 14:53:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 947AB4E9099
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 13:50:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94B9F274B2A;
	Mon,  3 Nov 2025 13:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="s50QJ4fx"
Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32613269D17
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 13:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762177806; cv=none; b=K6UHUGGUqSSMmEa1l8ucxquxG7O2RBgnsrI94JbaRJ9pjvP87nyI50k/NoWh+XY9znsyQvQXKsY7v3ESVTSz4So/hgp4BIyPLqWHHiwS2YpXg20Fh7kq0iW7mwDz22JX7b4UGXsVj/hyRIEk2r/m9aKejQZ05MfYrEEiFFc5GXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762177806; c=relaxed/simple;
	bh=TsvnfzRwsbf7wGlFzdjo71TLJrNDdp/a+dRwvaix3co=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SypMbZH83lpIr7I2NIlVfPXb7Op62fyp+CUg38MU4sNarjmv+hXkilB+WGVUUi0jYz8zaItDr7dReYrznHr0H/SIh+eRaseYw99FNpTZoI82omeqv0erpd2RGXez/keuMXHqHWR3QCTRsnzcTZwvEwprBPn4NoBUzEf3jUKKvGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=s50QJ4fx; arc=none smtp.client-ip=209.85.160.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-3d3e9a34eeaso1655961fac.3
        for <linux-kernel@vger.kernel.org>; Mon, 03 Nov 2025 05:50:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1762177804; x=1762782604; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=TsvnfzRwsbf7wGlFzdjo71TLJrNDdp/a+dRwvaix3co=;
        b=s50QJ4fx+PMJ+Rf+UE86QYB9Vmy3XErnLyHATB1i/CC6KG9A86sMAY5v9BDGSyO31J
         9teUFNB1n7pCK+6rpEY3tLe9yRJngDGkQtkhfRGEUPt6Ufzo9Rs8hmYIeYOt4A3IhXAL
         fPH+w2M+6/e0ecbpTM3LTgIW2K6XILgwr+eH7buoQVIFrNPGphqVdmnSjEJphNRXuhf/
         JhPNOSH09Jt2wQXbFvTLVHGCTbZvyMB/Ljg+Ab3QbC+v0v3BgtWN0WWqK7nCt3nMT9f2
         iqGHP2N+aj3WcNpe9HJvKCzniYIS5XL/shOsq8z3oc/QKy7JniMOZ+3my2pB2q6w4KUr
         6Csw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762177804; x=1762782604;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TsvnfzRwsbf7wGlFzdjo71TLJrNDdp/a+dRwvaix3co=;
        b=UOb5SAy2tcjTQUT1UqpEmiY8aUr8oMI3cvrq4mDx0slrl9T0Jgz13Zp3QU+at9NVkJ
         tqePMdpTjLXromh0ky5WO+1r41andBHxLw1MOwxZRWLyjnRzOI9REV8LDWNooRpmKuSg
         TyD1Duf7jlMatQxs5MyqIrXOHojiSErAP2pboKMqwbm/ml/Efw2wGZu/pOgpH0ZAizBd
         mBG47ObeFN3XC4cVwOOp/Yye0C1LR1qbEMRwzyfZAdeD6U3qIopyugXmIbrBjpLlDI5t
         khQfPV+i4YY+KlLg9pwlYf27yJEflWyD0nrdcItm99VLJmeDphhgywCkDI0L22HSqOXs
         2VAg==
X-Forwarded-Encrypted: i=1; AJvYcCVIxl+c9np6Uavh2rddhLrSa8yidFMu3ynFNCnC34OhZMZJ6dhk8rb+QQux93h6Ez/aI+q8Yh8spkDXEtg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwdSLQlZ7p6CWN3Qqyiy46SL+Y8EoWq7nK1K9O1dphEwFcaPqVQ
	VCO07LVoC8QFK9I+68Uab+aKqcoWzVPGyaMd0b4u//0tW9c41Hwzzmc/CJSbfdFHeKW1qvDbCrx
	dipPuMYTNdkpi9eGUXH2TAv6YIoavPtLG6Z9Gcp76/Q==
X-Gm-Gg: ASbGncvRNVy8k7oA3tl5cwlddqaGZDUBaisckFWmkuIFvG6/c1BN+uTBTTAWumM5/w5
	LxQpQyoRmClb/1gDH5J3LOnFpE+mrZ4acKaTzRSzQ33ioFlATS6swAMf1MSnIEnAkTw7+3AFCsn
	d9m6CzraHr617pPefbaWKIt7yHLQfx22TZNpGa7ru/EVur+FMBTTylegmNbVYJe4IYVCGKIpAfe
	6mLTMsr4i+IDl8qeriG1JQmOAQeyDvOiVyKI3p3q/seAP6NUyXNED8TFL1vnTvOKLJCDuTG
X-Google-Smtp-Source: AGHT+IEvvbnuEgVymC79WaE8covKlgmCh0NOsdeyracVXZX/SVCozVOiOeq8HhVtYvKE2fZAbBNornSKI+Cu+lra0Ak=
X-Received: by 2002:a05:6870:8e07:b0:337:74c4:8f18 with SMTP id
 586e51a60fabf-3dacc5d1f80mr5149154fac.6.1762177804047; Mon, 03 Nov 2025
 05:50:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251102-automatic-clocks-v3-0-ff10eafe61c8@linaro.org>
 <20251102-automatic-clocks-v3-1-ff10eafe61c8@linaro.org> <20251103-smoky-rustling-bloodhound-7590ce@kuoka>
In-Reply-To: <20251103-smoky-rustling-bloodhound-7590ce@kuoka>
From: Peter Griffin <peter.griffin@linaro.org>
Date: Mon, 3 Nov 2025 13:49:53 +0000
X-Gm-Features: AWmQ_blfrAzZoKwokZQZXo0nzPx9hZ0JYCMuGx_l22LwSjR0d1KXfaSrBbDofEM
Message-ID: <CADrjBPpjX_qSehbNkaAG03f=whs09qFzzgNiY3sztk7v0QeCFw@mail.gmail.com>
Subject: Re: [PATCH v3 1/4] dt-bindings: clock: google,gs101-clock: add
 samsung,sysreg property as required
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Alim Akhtar <alim.akhtar@samsung.com>, 
	=?UTF-8?Q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>, 
	Tudor Ambarus <tudor.ambarus@linaro.org>, Michael Turquette <mturquette@baylibre.com>, 
	Stephen Boyd <sboyd@kernel.org>, Sam Protsenko <semen.protsenko@linaro.org>, 
	Sylwester Nawrocki <s.nawrocki@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, 
	Will McVicker <willmcvicker@google.com>, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, 
	kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"

Hi Krzysztof,

Thanks for the review feedback!

On Mon, 3 Nov 2025 at 09:41, Krzysztof Kozlowski <krzk@kernel.org> wrote:
>
> On Sun, Nov 02, 2025 at 08:27:14PM +0000, Peter Griffin wrote:
> > Each CMU (with the exception of cmu_top) has a corresponding sysreg bank
> > that contains the BUSCOMPONENT_DRCG_EN and MEMCLK registers.
> >
> > If present these registers need to be initialised
>
>
> ... for what exactly? What would happen if this was not initialized?

The BUSCOMPONENT_DRCG_EN register enables dynamic root clock gating of
bus components. So it is related to the automatic clock gating feature
that is being enabled in this series. Things still work without
initializing this register, but the bus components won't be
automatically clock gated leading to increased dynamic power
consumption. Similarly the memclk register enables/disables sram clock
gate. Up until now we've not been initializing the registers as
everything from Linux PoV has been in manual clock gating mode and
until starting to implement this I wasn't aware there were some clock
related registers in the corresponding sysreg. Additionally with
Andre's work enabling power domains it has become clear we should be
saving/restoring these two sysreg clock registers when the power
domain is turned off and on.

> What is the exact justification for ABI break - wasn't this working
> before? Or new feature will not work (thus no ABI break allowed)?

No, automatic clocks and dynamic root clock gating were not working
prior to this series. Currently power domains and system wide
suspend/resume aren't enabled upstream either. As we work on enabling
these features we are finding some things that in an ideal world we
would have known about earlier. Unfortunately it's not so obvious just
from studying the downstream code either as they rely heavily on
CAL-IF layer that has peeks/pokes all over the memory map especially
for power/clock related functionality.

Whilst it is technically an ABI break, I've tried to implement it in a
backwards compatible way (i.e. an old DT without the samsung,sysreg
phandle specified) will just fallback to the current behavior of not
initializing these registers. Things will still work to the extent
they did prior to this series. With a new DT the registers will be
initialized, and dynamic power consumption will be better.

>
> You need to provide rationale and "driver needs to do something" is not
> enough, because everything could be justified that way.

Apologies for not being more verbose in the commit message on the
technical details, hopefully the above helps explain it better.

regards,

Peter

