Return-Path: <linux-kernel+bounces-869611-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D4C3C08517
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Oct 2025 01:33:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 9E8093470E6
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 23:33:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACCC1303CB7;
	Fri, 24 Oct 2025 23:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="g6m6IVA8"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E4A422FE0A
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 23:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761348779; cv=none; b=lWJD/wTcTOCTe5pkeemJB712ixBX1QEZCN0AFidazLtaLfY6L4pSyr3AhCLA542hSQuC2DTWgB3G2xH2INdUiu3NtvvNBHXTMFy9KxtFyR7VgHMVpzqgrm9l3soq/VdHCT2tNYI2LAhB4YPUfGHaZcYWZmi+H/XD1BAsqWTfKsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761348779; c=relaxed/simple;
	bh=uTAvhktvg0QkcPyr0Q0jFjF0psJGVFRyizayHmkabGk=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=YIXCqTiqxEaNm3e8srUFWpZbqthoEfCFX6L874NFjjfo1Mna9nRby/lr0QUbjYncDNWCsb/Q2VCixIiurqAhMxbIS9S15XyxU5CkVLRBa12koVKiAFTWxs8qWPJS+4ESRde8fPjb1wCxGBG6zXdJbeJmk3Y21UtfHa7Xrm7c3VQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=g6m6IVA8; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-47112a73785so16987655e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 16:32:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761348776; x=1761953576; darn=vger.kernel.org;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uTAvhktvg0QkcPyr0Q0jFjF0psJGVFRyizayHmkabGk=;
        b=g6m6IVA87/GJJD3ajlCcB5mbco1inUtXBb29ngwEz+UlyLtfO7o1SDUOt7KRPkUN3d
         xseovnqYPPnyZtl6eiSZsomtkBdydtDl6uW9JG9AsU8LLCs4DJdnTNyieJzPf+XQbxUg
         eb8kLwiusjAqiJKvOMnr6hThcKURx7oTGYgUAYpVc7Ninf/LBC2ZqCeyQPSOg7NpVHqv
         WtoShpKH3T/x9ThuF/6zDujqgusvu0Iw9SPjHJdePP7qugd/Lz7+gYcWUeupYzvd3LdH
         0fBpwgsj6eskwRr+v5bW72PZPZbzw6Nfj+ZuaHecOcTfu/Mm6s4IeckmDqyeCCWpcQw9
         lt7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761348776; x=1761953576;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=uTAvhktvg0QkcPyr0Q0jFjF0psJGVFRyizayHmkabGk=;
        b=d+5uKAOrD+72UCQOe7mVjpR+PRw717ffJ4qKbHCLv+m/I2WDvu9heOqSSizr3s2zD8
         3XL5F9ZL9QOjx9Y4/3DxUtL71XorLtwY5PN3fogCxECpp4OSEfr16ThYfniWDrrPgEqz
         lsvWOkvQOmsW51JwkDfwcuHq4EjTbkwv1sUU9RmUqrADOKA974UoUsFAiXo/co/OKDYT
         b9icbfb5RAFGzH1pJfR9fu+rX3HEEFhy3HkhVWLPbAnOf0B/TfHFa3wsFXBuYFZ6h0XD
         QIgaSKuUHurKGi0ae+tnpv5w4NDddmi4l1n9ZfyIbCzCLWfyn+u7SQYIRC2lm979M6qf
         OUSg==
X-Forwarded-Encrypted: i=1; AJvYcCV+R3qR5kvruc0E9sABN/acqkBoOcs34QLODenPGn1J1HVjmW+XncpDZmza0I7n/snwaio9OqyLE/PAE6I=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywj6SteYUZ4q8u/FXRp+Nqw6rB0ihZdk4S5W1R/ANjpIJ3xuOAR
	pTXTe2GVp6tFFuwZXV/9zv2oqJyArTUgulN1BCHPn6akw6qNe+9Gdl2/qNct1VfuCMQ=
X-Gm-Gg: ASbGncvKc//pA2mHKkmLg+74lylkjodhxvymV57OY+7yYam1MPugKSgxe535zz7QVhp
	kpj168OhngU17U830c6OgwzcTyHh0oG+i/OGSuP8MfPVPClf3pLBDzGzaPVV71byJBNIxwE5vrO
	DtCONjrpo7d3lg/m42B3I012yFt6gkOmcKXJQyNDBpsK8MeBsGIwxZcEfyW4iawEsG8uW3mSMBW
	pEJVG4B5KhGT2ShdfqRTxyfCSZCksfGfpAZ2k/ZrMqhV06CrvhIs1qQvHe+/uHdJLWvqChDTPI3
	NjDdo/IzG8LdAC+eZOnAiQaiFmwKiSC/H+/yDareHi1G2u0kySxau39lJX8nLXMaTiB5Vs5K0W9
	giQGvvQAqkfbsZr8FGmsDQ7dp5+ocaFNyx0dohyKI2D867RI+SJ4PLz8gntqJnqB+wujoqrDyc1
	hKXhqGjevXGDMgThs=
X-Google-Smtp-Source: AGHT+IGpS+9bXxIYVkmYN3aYKTkh9rmryEYIUIEOWTNg7RqiVEj4YoqfyQVte/UCsJWhkp/A2ApwYQ==
X-Received: by 2002:a05:600d:630a:b0:471:1b25:fa00 with SMTP id 5b1f17b1804b1-4711b25fd7cmr148300005e9.36.1761348775627;
        Fri, 24 Oct 2025 16:32:55 -0700 (PDT)
Received: from localhost ([2a02:c7c:7259:a00:7969:1fa8:db69:6159])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-475dd47794asm6627875e9.1.2025.10.24.16.32.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Oct 2025 16:32:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 25 Oct 2025 00:32:54 +0100
Message-Id: <DDQY14HJJS8U.30QSLJ4PCYJQ@linaro.org>
Subject: Re: [PATCH v2 08/10] ASoC: wsa881x: drop
 GPIOD_FLAGS_BIT_NONEXCLUSIVE flag from GPIO lookup
From: "Alexey Klimov" <alexey.klimov@linaro.org>
To: "Bartosz Golaszewski" <brgl@bgdev.pl>
Cc: "Kees Cook" <kees@kernel.org>, "Mika Westerberg" <westeri@kernel.org>,
 "Dmitry Torokhov" <dmitry.torokhov@gmail.com>, "Andrew Morton"
 <akpm@linux-foundation.org>, "Linus Walleij" <linus.walleij@linaro.org>,
 "Manivannan Sadhasivam" <mani@kernel.org>, "Rob Herring" <robh@kernel.org>,
 "Krzysztof Kozlowski" <krzk+dt@kernel.org>, "Conor Dooley"
 <conor+dt@kernel.org>, "Saravana Kannan" <saravanak@google.com>, "Greg
 Kroah-Hartman" <gregkh@linuxfoundation.org>, "Andy Shevchenko"
 <andy@kernel.org>, "Catalin Marinas" <catalin.marinas@arm.com>, "Will
 Deacon" <will@kernel.org>, "Srinivas Kandagatla" <srini@kernel.org>, "Liam
 Girdwood" <lgirdwood@gmail.com>, "Mark Brown" <broonie@kernel.org>,
 "Jaroslav Kysela" <perex@perex.cz>, "Takashi Iwai" <tiwai@suse.com>,
 <linux-hardening@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-gpio@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
 <linux-sound@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>, "Bartosz
 Golaszewski" <bartosz.golaszewski@linaro.org>
X-Mailer: aerc 0.20.0
References: <20251022-gpio-shared-v2-0-d34aa1fbdf06@linaro.org>
 <20251022-gpio-shared-v2-8-d34aa1fbdf06@linaro.org>
In-Reply-To: <20251022-gpio-shared-v2-8-d34aa1fbdf06@linaro.org>

On Wed Oct 22, 2025 at 2:10 PM BST, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>
> This driver is only used on Qualcomm platforms which now select
> HAVE_SHARED_GPIOS so this flag can be dropped.
>
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

I tested the whole series on db845 RB3 board, looks ok.

Reviewed-and-tested-by: Alexey Klimov <alexey.klimov@linaro.org> # RB3


Thanks,
Alexey

