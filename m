Return-Path: <linux-kernel+bounces-852368-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id B6F8EBD8C75
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 12:34:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 419B135278D
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 10:34:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 636842EA14E;
	Tue, 14 Oct 2025 10:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="K6nK6nN1"
Received: from mail-yx1-f41.google.com (mail-yx1-f41.google.com [74.125.224.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 401912DC794
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 10:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760438033; cv=none; b=XOVZOGLR81IGkYeiwQPCK369Rg3D4XBBGN1mgYsKeD/Of2CniDdG2BTCbtsCcmRULMeX6Sp3lMnq8SwGV3CnyVEaLOCjFsan4SCafZhl2uUj1UIR2QLQkLpXfVWO0C1fV0cyeLLJ1Ee54oo6XxOkVksN4Z4ARjW/7RLB3X8n3M4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760438033; c=relaxed/simple;
	bh=QuEinUhar14YF6Y240Ai1C75X6imD/kq72QMKNsJnaw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nta6Ddwj+JrwpCcPh3GaZ3tnE3UMiQaKowXOIlGjQ/p2u0az2V4u76JOoo/MbGhz/Iu1D4sOBTS/an8y48eEyl5UhrjxnwOpJ99pqcG1TgCAXXjD2F8LiJZKeX2Cj2LhzSgOvmxUpFKK504ZdsV5LEAICIzNC49nk/YVb4Fbq0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=K6nK6nN1; arc=none smtp.client-ip=74.125.224.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yx1-f41.google.com with SMTP id 956f58d0204a3-6360397e8c7so5368644d50.0
        for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 03:33:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1760438031; x=1761042831; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QuEinUhar14YF6Y240Ai1C75X6imD/kq72QMKNsJnaw=;
        b=K6nK6nN1LZvtp0hED3zEFDzNNzywxC7uHu5qIoAYDTMOe2xFKwCCMppI9y2WiakW6z
         t2GFxrxJVJKp5AmXIfQKMwzJVpjEgc2yqkYjXvBziCM37VNwY9oVrntdOZCYIBLKf6Co
         K1JTtw09FIbGrZkzLbB4gi9QXNjiLZwtPjhP6OqGY1YWI1vPM5UPoqQsPqP2cymCjpee
         +Aful/AlBTAerfWQLlN2v1lSsSm0L1MoRvCpyO5v022/6XWUki199KpnMr39xFU0X4hF
         uuRPDsHZbz/FyjuDW3+AuqpCxfW2/z5QVMvu69PmTaetzYkjt2As9VSd+vk5c52vnEpX
         3CCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760438031; x=1761042831;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QuEinUhar14YF6Y240Ai1C75X6imD/kq72QMKNsJnaw=;
        b=hiYi7jPqSfVolww1GX4w3eCKwbBu3bWuQg2RzPu44O0FsjsSrhWqDBhs3WeSi8bXDS
         bnHaZpFCd71qdTVI0CS0id7cD4ffDMY1XU0Q1jvHtko7qZXZZYNWwSj8VTDeCTP/ARFm
         tkQRMa7C+MqYkkVjDo86VHp5AG5VfU8XA2Fl3I12mtav2kTfWxCkl0GWBhdIxXMXpxo1
         yWoh+q07Md/uY52I2qyBt1lvp3M01mwANBPciUX9/06nZkPYtDY/Ba4ubT5ArgRqzXbr
         VfBj09VY9KuZtT/wnDp7BNVp6wVJotoAz3/nPRdRB0nTtIimC07IEd8CHznfTsIB2hTH
         lObQ==
X-Forwarded-Encrypted: i=1; AJvYcCWYaNmnug+x8oXqPZjvxbOsJ/F8qB/+U1QNQx66a4zsvvhNdsSkZ0viseSzFpYxjTQXvbfWcjE7Wiarhe4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxwIabOH6d2wazA7TWhjS1BNvZX3mtDiooQYjBQPHWWgFTs1fWC
	P3nbvJd1Gll4g4Ox1gL4Ln3rG1lof4P5h1tBOXomZsqM0Z7D6LilTk/PVA+5cQKobsSt+Q48dC1
	IFPWqlJC1uJfzQbmkBS+3qfw1Wa3RskMEbVlhoqVAXg==
X-Gm-Gg: ASbGncuLgp1LjT1pnuTFtJP6KvlmfDwWjclkvU0YeyDPVo5w7UR/72+peRm3/T1wq83
	eKoSuDaDeVYzbx5OXiAGd5BSiMsOG1hWHem/HC/l2Q/8rJlFikEGQML4vmeaR1MbC/Ccn+i1pzj
	XqPS29/1apI6yVVpuqXWRD5WI904QE4rswCXUqVXXjGqS9d8VayCwIcxFJzdFtSLwY4Ps67whTk
	biXNpsXGcKLko1G+ZMvFD7V0w8PzdRsWKNqBKCh
X-Google-Smtp-Source: AGHT+IHeonKC9+QYhOM7VuQykvKPFitUUF6gnFNcpL2LefNyxqXwa4BkJdaKg1KHUyXSH+yyFuP/4//FX0boj6kq7HM=
X-Received: by 2002:a53:b243:0:b0:63b:9347:1a5c with SMTP id
 956f58d0204a3-63ccb9035bcmr14962219d50.40.1760438031225; Tue, 14 Oct 2025
 03:33:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250926-manpower-glacial-e9756c82b427@spud> <CACRpkdYXh2MCs=vAif7BpxfYVRuDTkYYNwpV2t=J_ZRW+N4Vyg@mail.gmail.com>
 <20251001-unfreeze-ludicrous-9d744548bf65@spud> <20251009-amendable-trimming-da31551d730b@spud>
 <CACRpkdYssH8zObJTUH2VVB7FrVFmJUd+Ea7etTGbicQgkuU=CA@mail.gmail.com> <20251013-prune-deflector-b10b84425a33@spud>
In-Reply-To: <20251013-prune-deflector-b10b84425a33@spud>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 14 Oct 2025 12:33:36 +0200
X-Gm-Features: AS18NWDV62aIljpFKFrK57lWd5X1J4MSy0Hiz2Im8y-KTaCpfNHGRNY7xZpNzks
Message-ID: <CACRpkdaat_pNJ=_r51JuXXggDtmRrfjmN1AQffJVEA29yoojKg@mail.gmail.com>
Subject: Re: [RFC 0/5] microchip mpfs/pic64gx pinctrl questions
To: Conor Dooley <conor@kernel.org>
Cc: Conor Dooley <conor.dooley@microchip.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-gpio@vger.kernel.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 13, 2025 at 3:55=E2=80=AFPM Conor Dooley <conor@kernel.org> wro=
te:

[me]
> > entanglement of the GPIO function with another function, then
> > there is the recent patch from Bartosz in commit
> > 11aa02d6a9c222260490f952d041dec6d7f16a92
> > which makes it possible to give the pin control framework
> > an awareness of what a GPIO function is by reading hardware
> > properties, and that it is sometimes separate from other functions.
>
> That is unrelated, but interesting. What I don't really understand from
> the commit message itself is whether this is useful if the pinctrl
> driver is not also acting as a gpiochip driver. In my case, the pinctrl
> hardware is not capable of doing anything more than muxing functions,
> and the gpio function I talk about means routing a "real" gpio
> controller's IO to the pins controlled by the driver I am talking about.
> The 2 in "gpio 2" refers to the specific controller.
> The rest of that thread makes it seem like this is intended for some
> qcom devices where the pinctrl hardware is also a gpiochip.

It's useful if you want to use the .strict setting on the pin
controller and implement the shortcut GPIO enablement functions
such as .gpio_request_enable, .gpio_disable_free
and .gpio_set_direction.

These are often preferred when using the pin control driver
as a "back-end" for a GPIO "front-end".

Yours,
Linus Walleij

