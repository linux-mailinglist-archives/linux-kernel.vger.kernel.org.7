Return-Path: <linux-kernel+bounces-794618-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DF8FB3E44D
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 15:14:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C0AA18977C6
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 13:13:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 585BF211290;
	Mon,  1 Sep 2025 13:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jVE+raH5"
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFC4B149C6F
	for <linux-kernel@vger.kernel.org>; Mon,  1 Sep 2025 13:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756732300; cv=none; b=pCWRT9Pww9HmlQeJVgAIBscyA4jGC7ksL14t1rXnVLh05SPJSfHeudC3I9DXASSJEWpj38cUDr2oYy6DdNW61+VDQGn5k1KDu2599yRrV/MEbryIX81Mpc6tA3PL3p/TMeYnib2nqobjdzwe+0cveAg4Qf/QxaHbulYtYvaceIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756732300; c=relaxed/simple;
	bh=o1/2ukhzETswBvigFCZUS4xPD90/kXRG6GUxtAy8yc0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tNPDgFOuHxDluOwz2rYN8gEObDkZxRH0V8kt56799tx/X1Rog+w3i5lxOxW//WgYCdRp+s9ZFOotPPAD8zR14oBCbKPL0kgG9O2yFlCbG6qkWQPJx7bWdFAweQrYBuPOME/830STXHRlxhU6yhwx2a/twbWTyGS9GDoOvC8YiU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=jVE+raH5; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-55f6507bd53so4046583e87.3
        for <linux-kernel@vger.kernel.org>; Mon, 01 Sep 2025 06:11:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756732296; x=1757337096; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o1/2ukhzETswBvigFCZUS4xPD90/kXRG6GUxtAy8yc0=;
        b=jVE+raH5W4w3/+ewfdBBbCYw0l98atQRkgjDtidnGbysDP2Pyi4HkQ0BoReQ/hgbqK
         nm+FrFgbt/tdN8nFsi1JxDK+/pC15i1XYtRO1Yp4PwS8p7S9DyR5jIFX0CujYWwVYu/e
         Noxrm3zCcucDeFuBkSWI9z/ckEZlt8RQUlp7pTzZ+BgYWOf6UW/sRMBzkv2uv62+Q7Pd
         E2r4MtFfeeDlzIPqP3tWuJvxr6E+3i//oKYlVSXaIsaFpzfDu6XvmnXZ6xeKo0nEZAoc
         pULBQE9cEzNOj3WNwahS5o6pAdCmh3Ys6xaDHnVrVYGLV9Si01LMWEJ2pF4L2K68dHfn
         cWhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756732296; x=1757337096;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o1/2ukhzETswBvigFCZUS4xPD90/kXRG6GUxtAy8yc0=;
        b=cLakaiYGIbcGVTjF+Wp5uvMalirXVkLC6KfKH0nHuBYtR8O/0ZqT83TFT0P/jtx0qY
         /lU1d+HJuHFNtlk1joYzSHKBJ0m5w7v6GyJOZQHAS/KwL15bXEmFkN70FCIss4evhz+4
         02tIhcOtu9mmd3Sagr0ozblK311UGvz1au8SjRG5bV4FXld0AuVRo/2fBcNKrkK7UF0Z
         HjEAQLD67aLn1aapPvAvFPcb/w67Sd8OUF5EHiZ46yv4V2pEscAr6i6/OCevX91O3eji
         LMfmUQL5l0oLcuw4My2soQHPoTt4JF73UVgLom0WskIuXDoo6c9sBrKESUdSKn5tfpks
         8mvQ==
X-Forwarded-Encrypted: i=1; AJvYcCWRhDi11tLtwOTgKo3GuVBLd0dmZxkrPQ8RS5ECJqczf1ZfYGW7l/hQZGRDxv4FqSNm/dYeBjBPqABPX8c=@vger.kernel.org
X-Gm-Message-State: AOJu0YxS6FI/MlwVzjjdwk4J2DnBcMHLmr1pPyqd0CFCrUjiVf/tX6vv
	J9UjO5WeHKoxsIb2v3M0tI1Z10BgzBXrYy7IJENHeRHBwZy8DHPIvXWQpRDnQfT6hWp0lz1vk6o
	l2/bce6VRM6N6zPI7R6CWJUrdhGT5qnp6tUDqDJc7cQ==
X-Gm-Gg: ASbGncstXvLlthsmDHn7PNUkzJ6BJoyDl1PtEzeL6ZszQIx+L2inBaiFeYwkSMhgUxY
	nxJsflb6m9EWqHYLaTJ3KvbCYEfllSHFIJjpB59iVsI5W32DYLjRZ9k8AbD97x6ksXKO3GAbt8I
	8U//nNNMx6tqmgOtUzWLgOUM2+g8nQk0lZm/z3W0mYeIl6jw1eEVFGwJwTcbgSPncU1PpwiaNVA
	4qjegE=
X-Google-Smtp-Source: AGHT+IFdtZUV12X2qQohTcmgXoI8sX/n2MdDB3IP/SMHaxKOnh4rNFzghcV2U9qSUnmpWORF0iKHeIacxU0C0GZ7Nxw=
X-Received: by 2002:a05:6512:2353:b0:55f:6a6a:4955 with SMTP id
 2adb3069b0e04-55f708bff41mr1832610e87.25.1756732296026; Mon, 01 Sep 2025
 06:11:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250831084958.431913-1-rongqianfeng@vivo.com> <20250831084958.431913-2-rongqianfeng@vivo.com>
In-Reply-To: <20250831084958.431913-2-rongqianfeng@vivo.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 1 Sep 2025 15:11:25 +0200
X-Gm-Features: Ac12FXzMx74oEGw0sys3dqlvnEr6aJBPDjUSlodZm8Lf6MbYZWveT4WA0nkRQcE
Message-ID: <CACRpkdY14ZuAp+mg==M62draaaf897Ry-Nkh93UR132iUqnLvw@mail.gmail.com>
Subject: Re: [PATCH 1/3] pinctrl: armada-37xx: Use int type to store negative
 error codes
To: Qianfeng Rong <rongqianfeng@vivo.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Gregory Clement <gregory.clement@bootlin.com>, 
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Bartosz Golaszewski <brgl@bgdev.pl>, 
	"moderated list:ARM/Marvell Kirkwood and Armada 370, 375, 38x,..." <linux-arm-kernel@lists.infradead.org>, 
	"open list:PIN CONTROL SUBSYSTEM" <linux-gpio@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 31, 2025 at 10:50=E2=80=AFAM Qianfeng Rong <rongqianfeng@vivo.c=
om> wrote:

> In armada_37xx_gpio_direction_output(), the 'ret' variable might store
> the negative error codes returned by regmap_update_bits(), and in
> armada_37xx_edge_both_irq_swap_pol(), the 'ret' variable directly
> stores -1, so the type of the 'ret' variable needs to be changed to
> int in both cases.
>
> No effect on runtime.
>
> Signed-off-by: Qianfeng Rong <rongqianfeng@vivo.com>

This patch (1/3) applied for next in the pinctrl tree.

Yours,
Linus Walleij

