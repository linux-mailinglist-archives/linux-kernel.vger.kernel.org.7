Return-Path: <linux-kernel+bounces-811070-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 25ABEB523E2
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 23:53:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CDD2E48610F
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 21:53:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7122A3101A2;
	Wed, 10 Sep 2025 21:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="k8YjWIwN"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D3F330DEC5
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 21:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757541227; cv=none; b=aPRX2Ud/2xNwUaSrUWzNjasYeIN5l3a5nCr0xhijFfchieqqeghewh2K50d2T+qKUHDBhqPyEg3T3koJTheH9/PLfDvtW2xwbBf5mAsfQ2pTPREIrnFRj1qTkPcnUzxSb2X3BjRnQBC3tsg8vlWpzxDMDo6x0pErgXihyWgyamg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757541227; c=relaxed/simple;
	bh=q//PQSm+h1ITIo5hhQmSWhiVmrcAM9Xk9nSTnv4AmqI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oMpAj+bh+rDMs/YL3YOb1D4SlpnaxCiP1Kw2u+YGULDJft1atJkG8Csr9aSCdJT4g3CND0ZtYalij1UjL0j7m3XhmhVeXdtScbZtzgm9+EcyvkJjsJAjyds9t5DCBmNwvjCHzKY9b/D6jfLDKpyq/qWrVv3Y9C3TU6ATpVnJKKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=k8YjWIwN; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-56d1b40ed70so1616e87.3
        for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 14:53:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757541224; x=1758146024; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q//PQSm+h1ITIo5hhQmSWhiVmrcAM9Xk9nSTnv4AmqI=;
        b=k8YjWIwNXt9AhpBsZYI5c1P1Ult0DUK9SpR/tWT25rBCQSdlpnUf//JMDtG4eRwY91
         P5sTeu2g8LjVmdc/avNABQrvxxui+wT5lST7QMDFqd4zbL0P9MJiFQjqQ9WVUaeAyFDw
         V5vtE41Bc4SUHz/2K0EIBL/gFXvuljDbqJhQpptMA8689Qr6WLyRM0p2JGTsYam3zcyT
         BagzspZUBRYpe9pGhtVxlLkXxYp3VO1mPPmPnbG4m0tGcbhEgeH7Eyjx/s6KR0fYeacQ
         qDxibPg5KB47cNSr59UleFSOZaGrIL7rE5JC5WjbrCTHUq4oN9A82geZ9dC/rtKgJfXh
         k67g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757541224; x=1758146024;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q//PQSm+h1ITIo5hhQmSWhiVmrcAM9Xk9nSTnv4AmqI=;
        b=rTYUODSc+Oey1gmxoLxlA9wGRib24kAcHw+PjWWgMZPavXu5/uD11KmViqJE1Aay0b
         D8l/Csikr5UTUsGI4al+RY77yfJKzFU4ss1xi9dgKOrwxjqnwQyoe9JbHEXSXFLaLgWi
         vedhCKAR0v/OUmpeRH5amqAnpBEuQczLXRtyM7eJPjn+6NVdN9LFtWNr3vz54vaBfzpc
         QyYqSJQuBFZ05tdCmP+nUHFzk51iW9uhMzayLYwQ+6uEIitD90DPk3GkwfTmdQm/3e3h
         /4OpbJC8HYcF5c73RJc3ZK+dGPzWRMosgaCCwYANmxKh1Q9jCdF6wIB8PsPgsdkHZZdn
         8nLg==
X-Forwarded-Encrypted: i=1; AJvYcCV+uU2KFFHYX2WxZS22Udn1v68JnBaVeHxwlmYRhdiW3RzHDERKwEFm86VFnDB0xruFHQVeY8ordMjUkeI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzt//iEe3lUSk9lRJWdpYwVc5DSfrmoY9OEGSRtH4ZxM+Cu1ruQ
	Jf4d9ujMxSUFZF8DIOyFsl5qoYNdOK4pHxlp/mhq2ZgpVxLTtrvzKCWlrS8CHFck6ClIWUGZKMi
	ofbsyFcm6SMpxyJbtcY3JsdVew43ZJmESLr4jBZ3feG7+Cbkfd5zzUIE=
X-Gm-Gg: ASbGncsCHnxrX5kbneUhUC/++v7wdo8M9/IDg7BRuWMru0CysPOihBSRwW8ogmKLz8J
	C/yt6qHVsCcn5zXXz5aOJ3/xZct8jxOujx41Tg46rlu/xHA5bZ2RBALw/tBK3xetxxnVhWmZ9bS
	W/ozYa7p1LWUpbfZIinGZkE/jlEghjUZEETVRdHpbD9yF5Glx1dlC4P0tfh9JB834VpznoD7mqI
	PPWJ3U=
X-Google-Smtp-Source: AGHT+IH3I4tPdCs41TsyB8DNSw/AUL2jC4I7vr2eCoO2ENLBclkXCb0BiXvJWpuRW0sLm6X70ksUUgQXaXO8K7LFJSg=
X-Received: by 2002:a05:6512:ba2:b0:55c:c9f3:6ed9 with SMTP id
 2adb3069b0e04-56261bc58e8mr5471578e87.35.1757541224157; Wed, 10 Sep 2025
 14:53:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250909-rename-gpio-flags-v1-1-bda208a40856@linaro.org>
In-Reply-To: <20250909-rename-gpio-flags-v1-1-bda208a40856@linaro.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 10 Sep 2025 23:53:33 +0200
X-Gm-Features: Ac12FXxLPdZ38un1m9ptC603ZmrUP6by2OMkj-xvoDoxfyG3HCKzWeGPfFD0A5U
Message-ID: <CACRpkdaFj7okjN+n2+kRAopf17DV1QGV2mbmndVtDoi=GuqAug@mail.gmail.com>
Subject: Re: [PATCH] gpiolib: add a common prefix to GPIO descriptor flags
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Kent Gibson <warthog618@gmail.com>, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 9, 2025 at 2:28=E2=80=AFPM Bartosz Golaszewski <brgl@bgdev.pl> =
wrote:

> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>
> While these flags are private within drivers/gpio/, when looking at the
> code, it's not really clear they are GPIO-specific. Since these are GPIO
> descriptor flags, prepend their names with a common "GPIOD" prefix.
>
> While at it: update the flags' docs: make spelling consistent, correct
> outdated information, etc.
>
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

That's a good patch.
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

