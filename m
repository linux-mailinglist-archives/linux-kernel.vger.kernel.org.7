Return-Path: <linux-kernel+bounces-749433-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D8BDB14E54
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 15:25:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 85BF154150F
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 13:25:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA7381ACEDD;
	Tue, 29 Jul 2025 13:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Id0gMo4b"
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A53A91F7554;
	Tue, 29 Jul 2025 13:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753795543; cv=none; b=ioJIAAb+McfTagtdXt8vGjNXMBxQnUYqd2SXBhu3CqnFnOEe9j8tQH2IkqofDDQrSeuFy5CWcnyKTyG2N1WQK/Qdnce6ZVI9ph0zrUDli5y4Gz3pKVwsh3UZrDDdxkNNWm0GkLhTuOOPWURwiWfkkJEEU6kX8ylre3HU/WWWlwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753795543; c=relaxed/simple;
	bh=4MaNWKs7TaCzthrdXDGRFTeWf8nejV3Z8R/aIGF+vAk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tO5BP6yveCFh9lKCc/lk6UJD/mGiQwBfHxqTrG3hv+VINmvcDS+yxNsNTBZVXE4YoKboLn8ygRGZ/8/kf2sALhh+u+uNfZWod0GqaLY0To4hlOTaLrxyHfGJkAA1FBs3XepalFBXQRTmFMIMOggGGS2jrxMmKwbur4udvQLARbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Id0gMo4b; arc=none smtp.client-ip=209.85.219.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-e8e21180c55so1318892276.3;
        Tue, 29 Jul 2025 06:25:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753795540; x=1754400340; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=4MaNWKs7TaCzthrdXDGRFTeWf8nejV3Z8R/aIGF+vAk=;
        b=Id0gMo4b9q6BdqrRlP9+cuTo9cAiplIUuqBX1Fc6oykIqTbOLcnFAX8vtcsCXd+COt
         rFPI+KLPiyXjbEuEZzX1shyCS0W2PLOetrEYsDrhxrCT1fbsDEmsTFNjF/8Wu1KiPXFj
         kx+qYVl0qkQZF2fUILdP6sqJXhwgmCqPUGPfPIgzTXwfAdOOai4oWirRYxBTF0nSr/gT
         W/qWbETbzWM8MQsvFOXUdUHkJD0jCOMxiwpcVlnTt5OYPog6QrFO7anbqam6FLNZxDWk
         2dCVEt0U1ykTp1rrFv0J/i1lEzpJXLv9waj4UWSZ6I1z0Mx3wZiqTekAqsOBqd3wgNqr
         BKDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753795540; x=1754400340;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4MaNWKs7TaCzthrdXDGRFTeWf8nejV3Z8R/aIGF+vAk=;
        b=QuGysrXdytMHIWyM1yKpdmYbBiYYC4qqzWSzofBe1R9bTN+kRpN5Ia4mACw8JT59fM
         cjmOsBYuXVfv8TLY5aUE63b+qV8RQHRakuZQ0Of3EqdYPaldYpRARLpJBmueo1ea/FdS
         Tii+pSw5PPITE4kCJ2WWnCJFvkysMhbr521TxF/1aF01vnbWSLetBdZFX0aBr5iggQIs
         3GmldsRf+ciF/kFYT5QCaCBN6VU0VeOoD9r6YtMV7nA9kw3N6e0uQSBsg8jCAuYbnh5o
         A0XsjlMnTS5JGpnU0W+T1wXz4Hk23PYmLWJMwMAbcgT6SGi1KNs6IIKBqqzaxbUMDDJf
         RWGA==
X-Forwarded-Encrypted: i=1; AJvYcCV5ln/Y1OHRgoSzZcPTxstldPZUWRQa94FYI+IKkgRhlUMzfPPtp/z+FV0Tx2nQn21MR3FiD6D6TZwv@vger.kernel.org, AJvYcCWHr07RMjfJ8wPm8A/2fMd2oFzQFIxDm+92IicFXEdv6crxT0CWvFwKhKjfTdkW+0o000cn0KFcuJ0tssui@vger.kernel.org
X-Gm-Message-State: AOJu0YwLdNfFAXIbOgyBen09XoZUsAHcF4tg1EhryGaUPK8/xJtEwvpn
	LAHkKmU870doKR0eY/Tn4DY+C5EEbv2X+BsK2/BbQCgTZdX+HpM4uvzawTLAriBDEbXyZSF+H4X
	EodRE27ri7sHiSxtQl+NX9F0PfwxIZW4=
X-Gm-Gg: ASbGncuCBNirTJgBuIaSb1vn+rFKHsq8KJulyh7OGy7JV4cB6y0p2/WuRWrEb0J7dx/
	iV4GulCid8jeTIohlpRVI5b2jGVNHWjzWD0rW5fiBHaaqJu+9f0aqurFeotiXEu/tzcF/11/KJY
	GwiGwTzJoTWFi4tlPaD/ML8TQLvlH2PxdqbkcXxzNHlxU21aStG2pXtrEGy74Bc0iNPIWB0I2Rh
	f0zibnw
X-Google-Smtp-Source: AGHT+IHL20IVMBOPEcWqdaoF2zTGYAx5AWr+HHlIlUbQ23WbctxapIVl9GiiFgzBb8rsi6tFDPZtaW3tcEhbVEYQMqE=
X-Received: by 2002:a05:6902:18d2:b0:e8e:265a:c36b with SMTP id
 3f1490d57ef6-e8e265ae45bmr3085334276.7.1753795540205; Tue, 29 Jul 2025
 06:25:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250717135336.3974758-1-tmaimon77@gmail.com> <20250717135336.3974758-2-tmaimon77@gmail.com>
 <db07c25c-4064-4330-8bdb-8a619b0b2915@linaro.org> <CAP6Zq1jDCfhOWj4JwORy22TDZRBr0fnuy5-=G4WO9DFRv7pTdQ@mail.gmail.com>
 <61a0c875-89cd-4040-af15-79f57b53f377@linaro.org>
In-Reply-To: <61a0c875-89cd-4040-af15-79f57b53f377@linaro.org>
From: Tomer Maimon <tmaimon77@gmail.com>
Date: Tue, 29 Jul 2025 16:25:29 +0300
X-Gm-Features: Ac12FXzajzgJganh_OGaQ0PgxM_llQhwooXsnSSLuQX4GroBGdFGCQXd6d8NdSM
Message-ID: <CAP6Zq1inUdfX5cmv7LHrgOBQ6LPYY_2t5o8LD0oW4rUO191_tw@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] arm64: dts: nuvoton: npcm845: Add peripheral nodes
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, 
	avifishman70@gmail.com, tali.perry1@gmail.com, joel@jms.id.au, 
	venture@google.com, yuenn@google.com, benjaminfair@google.com, 
	openbmc@lists.ozlabs.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Krzysztof,

On Tue, 29 Jul 2025 at 09:21, Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 28/07/2025 13:30, Tomer Maimon wrote:
> > Hi Krzysztof
> >
> > Thanks for your comments
> >
> > On Thu, 17 Jul 2025 at 17:05, Krzysztof Kozlowski
> > <krzysztof.kozlowski@linaro.org> wrote:
> >>
> >> On 17/07/2025 15:53, Tomer Maimon wrote:
> >>> Enable peripheral support for the Nuvoton NPCM845 SoC by adding device
> >>> nodes for Ethernet controllers, MMC controller, SPI controllers, USB
> >>> device controllers, random number generator, ADC, PWM-FAN controller,
> >>> and I2C controllers. Include pinmux configurations for relevant
> >>> peripherals to support hardware operation. Add an OP-TEE firmware node
> >>> for secure services.
> >>> This patch enhances functionality for NPCM845-based platforms.
> >>
> >> Drop this sentence, redundant and not in style (see submitting patches).
> >>>
> >>> Depends-on: ARM: dts: nuvoton: npcm845: Add pinctrl groups
> > Maybe it's an issue with our work mail server,
> > https://patchwork.ozlabs.org/project/openbmc/patch/20250706153551.2180052-1-tmaimon77@gmail.com/
> > I believe you didn't receive the patches below as well, since I didn't
> > see any comments. Am I correct?
>
> How is it related?
Not related, I will send the question in a separate email.
>
> > https://patchwork.ozlabs.org/project/openbmc/patch/20250706134207.2168184-2-tmaimon77@gmail.com/
> > https://patchwork.ozlabs.org/project/openbmc/patch/20250706134207.2168184-3-tmaimon77@gmail.com/
> >
> >>
> >> There is no such tag.
>
> Do you understand this?
Sure, will use changelog or b4 dependencies next version
>
> >>
> >> Use changelog for this purpose or b4 dependencies.
>
> Do you understand this?
yes
>
>
> Best regards,
> Krzysztof

Thanks,

Tomer

