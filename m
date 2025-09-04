Return-Path: <linux-kernel+bounces-801562-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C46CCB446AA
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 21:44:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 31E821891E94
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 19:45:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2223273D9A;
	Thu,  4 Sep 2025 19:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="i0LplclM"
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 950B326C391
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 19:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757015088; cv=none; b=mU+sTlalms8Z9jw1mYtWUrtNPoXLMNa/5zsi4B/xE2S+49htpvOBUQ06isQWWj3LkYkFSx7nIlyZJm6ekef2ye8vGJLT2TBAycufFNmP7l/M/t7dfG2qaiOcHxiBcK+YIAw/dqlC3J81HGxEwwidjTxfPWDM6xXRZK0sSSlN0tE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757015088; c=relaxed/simple;
	bh=nrsoN2cRsUh6+oDjNodKxMkbhTbg0va/okCb6ReI6KA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=piX1uKJzn/ei2gyOmm+ZSBXLKALLKdom2qhh/Yjo+apAbbMXzacqfLiDr3Il8T9sl/PveZT4Q8MWp4Of/HaS8G0Qvph+QAhKWQeAgQeSNDC3YiFYbA/Fp3BcxZsmM8o10r+3N1PWZasZvtd15taREhPYSprKQryvfAVzaKUzyc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=i0LplclM; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-336dd55aae1so13659831fa.1
        for <linux-kernel@vger.kernel.org>; Thu, 04 Sep 2025 12:44:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757015084; x=1757619884; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nrsoN2cRsUh6+oDjNodKxMkbhTbg0va/okCb6ReI6KA=;
        b=i0LplclM94LFldL9ko/QvOW6Ciko3G24cPFgu18SC2Kb390tSTAaMgXg1VoynRyO+h
         JiNod07ixWaXyVg9MjoHkp4p/RHWgi40hh9BA4OW/QVC1nxGblOqegSOEnPT53lNSfhk
         CJTVM8xTd3FaxA02cUp/V60yxbZO6+0872xjdtm5fyttblceL4VxLZWMTSL3WR55zbHI
         o7BsI14It8N0anthekCv98klkrA7SNhejV8fvUg6TsziqSXbdTqEDzISXuHqau0me7Zu
         AcjdbtmXY9vy+uqsFHHuPx1KkwfA++QwntBO6+y5OfzmtVJTI2P8R+7Amc9OLhQFlevL
         AeFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757015084; x=1757619884;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nrsoN2cRsUh6+oDjNodKxMkbhTbg0va/okCb6ReI6KA=;
        b=w/ZFp6/39Y3gHwnNJ61wQkimumUIUnnh67MpECFfZ3CiXF0Q7zM9Ki6Kjv812TYfYs
         EAv7H3eiv/EWtkuUJwJIYN1m408vwiAnzHojnmYKFOs6JETY1AQfBC4eTpCsKorw6WT5
         HGA2nbkVUFd39DCJR7gB1xV+J2sMk3u7PJewMh5mHrY1LCHCa9WZ38BXb6ouvcv6VsJ5
         staDczn6Xra0l4M0MbsO5H7rPxcJCJxLuYsrDXoMHV0CYLaRSJPmYLvQy1BYtDsysfrN
         YAoOl0FgyOxWzWiOprGdvxuom0d9GOS0ZAjXGbl9SWtq8IYx3Z2Q561f+MhhtIq4emXq
         oMKw==
X-Forwarded-Encrypted: i=1; AJvYcCW07TumRpLVmWJawNI641Bky+o/RGJAkWJTyrNcYXlF6zcGU/9fwq7CPPoTBwc0Js0J0s5S9ougusD7pW0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxfFXgAk9WBv2CQI2IGCmfEUVESExXg3vvPSrA9fjGMyS/V9kgK
	c88NnHtmIKyHHx8ryPScrcqgHUdzAm73omFKZcCrnfcp5CZOb5hV8Yh8ZfRp2DcCuRzydZpIAiV
	g8ARk0pKFfyM5ZbJ7sHqn0jTCsGIWtclPPrDCXNdieg==
X-Gm-Gg: ASbGnctttmuRsah4Fm288NoFVyj62aGZhgo4ITLxukIfZo1QKgcfHKmWz/OwlJX2D2J
	Y02t4NN5pgZoxtuiWrrQ8ZRYFopASTc34OVSBvY8rNZ8E+ls+7ESUI2lj3qlElrvC5IqX0AwuYL
	9cJUbkavpt3qgW8CBxyDVBhOzEy/DmQgkxJuthF6tQfAMzq3AVmfSaXOqMHonfWjJA7z1wm5v8v
	P/bYxJVvbukvFxpJw==
X-Google-Smtp-Source: AGHT+IGW3Q5mVQSa4T86jRPxMcDx+PrjgBKT3CCZeXO2AlCJTgPkak9+H+1Qa+5a1Zu0cS0PJQgLLRFuw4VSi8OlYhY=
X-Received: by 2002:a05:651c:1118:10b0:334:45a:6e65 with SMTP id
 38308e7fff4ca-336ca9dc2e6mr50813331fa.18.1757015083748; Thu, 04 Sep 2025
 12:44:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250904013438.2405-1-ziyao@disroot.org> <20250904013438.2405-3-ziyao@disroot.org>
In-Reply-To: <20250904013438.2405-3-ziyao@disroot.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 4 Sep 2025 21:44:31 +0200
X-Gm-Features: Ac12FXzijnUJnUS4O1_UBtocPghj3eDGF7zfv9ZNj6v1waFbdxgsEZ7rJIcKPss
Message-ID: <CACRpkdZJ16O+t87aB6dVm7kqCNkiFQiExDVjRJCRgNUhDbzV4w@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] gpio: loongson-64bit: Add support for
 Loongson-2K0300 SoC
To: Yao Zi <ziyao@disroot.org>
Cc: Yinbo Zhu <zhuyinbo@loongson.cn>, Bartosz Golaszewski <brgl@bgdev.pl>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>, 
	Philipp Zabel <p.zabel@pengutronix.de>, linux-gpio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	loongarch@lists.linux.dev, Mingcong Bai <jeffbai@aosc.io>, 
	Kexy Biscuit <kexybiscuit@aosc.io>, Huacai Chen <chenhuacai@loongson.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 4, 2025 at 3:35=E2=80=AFAM Yao Zi <ziyao@disroot.org> wrote:

> This controller's input and output logic is similar to previous
> generations of SoCs. Additionally, it's capable of interrupt masking,
> and could be configured to detect levels and edges, and is supplied with
> a distinct reset signal.
>
> The interrupt functionality is implemented through an irqchip, whose
> operations are written with previous generation SoCs in mind and could
> be reused. Since all Loongson SoCs with similar interrupt capability
> (LS2K1500, LS2K2000) support byte-control mode, these operations are for
> byte-control mode only for simplicity.
>
> Signed-off-by: Yao Zi <ziyao@disroot.org>
> Reviewed-by: Huacai Chen <chenhuacai@loongson.cn>

Uses generic GPIO IRQCHIP which is great,
and generic_handle_domain_irq() so I think it looks
great.
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

