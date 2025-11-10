Return-Path: <linux-kernel+bounces-894286-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C65DAC49AD5
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 00:00:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 551A93A6EB4
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 23:00:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93C462FB988;
	Mon, 10 Nov 2025 23:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="L6+UtSP0"
Received: from mail-yx1-f46.google.com (mail-yx1-f46.google.com [74.125.224.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D7A9246788
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 23:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762815615; cv=none; b=khhuJp8494p+5RkPmR4Wx75eSgdys5Vrp5JNHPr7wyc+CRQzdMO+oZg8GnljCD4GmybKLWt8YJbCX6QH/RoloC51jq2gkJECnjeiZpjmTLzs9CUQJh9f3Wpx/IZbzBltT8Gu0ac/G7scJ2qo9NZWOaZlaw/Ayf4eNiWVneCuzUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762815615; c=relaxed/simple;
	bh=5g2st9wc6PSphLv2rTXtzyso52RIhR8FQuQh5VZ2AAs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AvnhB7xtvQSrAYszYsDUZqgKeY+yiKzHYT447+hCbftbnJYasExF7vFrDWYRTpO1CEaUgbkZkdjw74Q+Fu1yLlnKxGU40TwyamGH8fccvyHKzU5TGaxvj0SI0f/Wd9xvPwfWkGi4voWFBfWEbhyO8+UH7YfQKCIpF4uQCg9YyNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=L6+UtSP0; arc=none smtp.client-ip=74.125.224.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yx1-f46.google.com with SMTP id 956f58d0204a3-640e065991dso2430381d50.3
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 15:00:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1762815612; x=1763420412; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5g2st9wc6PSphLv2rTXtzyso52RIhR8FQuQh5VZ2AAs=;
        b=L6+UtSP0evWjXL1jvVkWwadBiRytM2dX0PWXrVibM1Op9Ckonp9NiCk4rZInynhf+Z
         CDUERdDkJcP9u+bdEHNfEcQjblTwjYrBdIoQCJxsQ38T0HnqGSWak7ePtDhkTnlSa2q/
         jKRSJujgerDq2htTZJQ6AKTbTHagttmIaKJTd49eKOWCo0Z5rrflDC37aDchLzdrgrNu
         2rN9uT5kgTND4EVg1L0K4aTexywCVGPGQz7crBb/K/2OMkTXo80ACSZz2kOqETyjpYG+
         8m2y45DhZBse7CCIwfQbH3Ap7+qHVrchrWvgcUYm6LM+23tg0jDpznvf7VifaNGAqoc/
         08Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762815612; x=1763420412;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5g2st9wc6PSphLv2rTXtzyso52RIhR8FQuQh5VZ2AAs=;
        b=dxiwJN+irCgbtFsjDB0rAB9oSAJuA7L8u6SIby2/t4IE+wx0AlRWVB0a9VwFw/YlGY
         y542K0n9Iu01JwMqyQPMoDtc0vWL7UbBe8OAQD8sH/bLD2MuFe/roDGeM1Fk95pH//xZ
         b1yoij28WqPhq4VjLQMYplBv1TZ48EBPtcjnuDmameykb8mwWF2CDKXrpUgO/XUO4aeD
         zQ9T+o2w/WNrFDF3PK/aHnMeG11fPB4hIwNdoeYy2poJ2Ycq0KV2BDO/BT1m23tks+Cg
         DPikLgnARhRHKL+r+XGb1q50Z+7C98Xi57L8ivXWzvGgwyVNzkCGEEWbMX3YsWy5B3Lx
         dqcw==
X-Forwarded-Encrypted: i=1; AJvYcCWEWLrlPh9QKHAOI1niA4WkRUtAJfrSsomQNLy7Iuso8xh/Nc2t0e4lWNQW8TZHnMjEhGXs1UZRDn4DvUc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXyLvVjEq6O4PB/FRmhRdx51ft0wkG/iYwXS+gOPJ7ZFXjO6Od
	4+m8PCyXmMVJ/XDYM73bgNVPgaseXz9XqDOb1tIk/7VDsEn/QI33PrtT4YwUsq7QeEM0bh9mvEJ
	hlpb6Wi3g8V0c5iMBC5x6V2sERkE0mlt8Zzd1SYDA9Q==
X-Gm-Gg: ASbGncu+8guSg36qOSea3tQGD3oCSgO7IWjTnXLVukqja/6hvTRMQLFVX1C5BKJDSo4
	/s8sZKIogU6Gertg/YDo5s7ZF+kfxsI3QvNHFkg3Z1p9KpZKynPeSm3cBBM9C7YKdlz8SDwhkEl
	YdBkSy2XQmxEh3y5q9HDX7yo78Q83R/cgQCtQapgq75tAOSdVKqpTjoC2+RSGgKjymqbmdy/20Y
	ccR6jrqJ1QRwf2VwUGRYKjzc1g6RG60icePCceVxEZbuh3/CAlqUMBrOStRSZl7Wr+FSwjI1ySl
	RJfMVQ==
X-Google-Smtp-Source: AGHT+IF8ly9VGsM78kkecljV7QbSku7Ug4S6qy5rbzWNA7QZtQnG4yF7xb8sJiiWVsPr6iJZaHBVJJja0GkrFNx95t8=
X-Received: by 2002:a05:690e:d41:b0:63f:a3bf:b7ff with SMTP id
 956f58d0204a3-640d4521905mr8009773d50.2.1762815612050; Mon, 10 Nov 2025
 15:00:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251105-gpio_semaphore-v1-1-f73de44310dd@foss.st.com>
In-Reply-To: <20251105-gpio_semaphore-v1-1-f73de44310dd@foss.st.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 10 Nov 2025 23:59:21 +0100
X-Gm-Features: AWmQ_bnOOnJKFTCi7QK6iL3YzdjswL_EdXBkwAsVR9l7bqs8icN9mSLR-Gbon98
Message-ID: <CACRpkdZcqM5JzvoTUk+cAFrtvQjHdRiaV0MF8ZipPTWxfqBxZg@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: stm32: handle semaphore acquisition when
 handling pinctrl/pinmux
To: Gatien Chevallier <gatien.chevallier@foss.st.com>
Cc: Antonio Borneo <antonio.borneo@foss.st.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, linux-gpio@vger.kernel.org, 
	linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 5, 2025 at 11:50=E2=80=AFAM Gatien Chevallier
<gatien.chevallier@foss.st.com> wrote:

> When a GPIO RIF configuration is in semaphore mode, and the semaphore
> hasn't been taken before configuring the GPIO, the write operations
> silently fail.
>
> To avoid a silent fail when applying a pinctrl, if the pins that are
> being configured are in semaphore mode, take the semaphore. Note that
> there is no proper release of the RIF semaphore yet for pinctrl.
>
> Signed-off-by: Gatien Chevallier <gatien.chevallier@foss.st.com>

Patch applied.

Yours,
Linus Walleij

