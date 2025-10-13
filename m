Return-Path: <linux-kernel+bounces-850416-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B0196BD2BBB
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 13:09:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 04257189D51A
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 11:10:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61B3B2FFF92;
	Mon, 13 Oct 2025 11:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="o3ofcFc+"
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C45812040AB
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 11:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760353766; cv=none; b=D/uCtQ2QuxUYVmvPTeOmAD2DA2+br/ioUzXTVluQfk2R1T9Jt0+gXN3YT/HsZPBIcw8pevKiU9X1NAAz89oIMks/lJkTnsKIvhHySWzL0JPx9evR+Pj+NvScPqsfoq0MGRiZP1m4QU2UvIGHtwPcNMwI4ZJNJPHGa224JeKzC8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760353766; c=relaxed/simple;
	bh=MpT6hXn4aVzifNN3nBALGbtn4EidYShjvQJLlFyRGLc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nMEN7mWPenV+XYLgHhsW/xYMymYQZHToSZMv9OhD/ROKv/q+Q+OYsQUFNVhyGpcMcKKVVT3qUB+dYcK4p4/lSNEqMcjXWorfrdjz2iyBDqehtlXyFG2JlNwT7eflrxvudmaPn2dnbHSCVoD7ZVn2S+oAQE0bavQySGQV16/Gq0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=o3ofcFc+; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-362e291924aso28127191fa.1
        for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 04:09:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1760353763; x=1760958563; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MpT6hXn4aVzifNN3nBALGbtn4EidYShjvQJLlFyRGLc=;
        b=o3ofcFc+DdvBgK8rkMPM9JgYFKADSjoIfLneIiwLYNztzbRn4ynCGA8FXmTFrhbC0x
         ubpvDNhqJfyfEAyeyqrijPBwNIwax7Uu4nzhsRIPd+C1ttg5y/x/8QomgNuWmptXZZAC
         1jidbbhefQYUF48fJWnJYjH9MIPblQww8c4V8fZOHhFxmKJkAsN+9/JNrCULJQPwxURZ
         7k2IywOvJ72gJa2fBwEesr6iqhBCym2xWn/OemzH2palSMXygjz8iUEVPKIQTcSRUIVp
         YEGgRPCieDFKGLXq9ohGRXKe1IcKT/YiuUWD0KcaTXq8Dkb2al7rwvP1txrs8qKHmvjR
         hBHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760353763; x=1760958563;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MpT6hXn4aVzifNN3nBALGbtn4EidYShjvQJLlFyRGLc=;
        b=Cl9CW+c1N+nfvhUPEI3HEpEl/pieFJgj7M5hk5+WkJO9KJaYdnV6P+kwcq7lUBsx6/
         WmOs+cv93JLftL/htRqOAIEeBNtrpfKEdUObXuGdRVHmfRUoyYwCYRervHPN0Yins3oS
         nXp/pTyIfCRyTGU4lr1KB6PoQ+paUkiSAFI6kmkRxEBsebpE49z/Eh6X6wt3YYhrH4QR
         Hec9oXjRWjK3RetACI3fkyD5oeFjXn9ghmU90I7uSuoi5br7Lypu+FaDTD2uxpNDuyu4
         8fAGYHElb8s6NnblH631u2t74dsDaHhFfCc8IrGPq+gAQpeVdNwqNYI52McasAF4gaQ9
         etKA==
X-Forwarded-Encrypted: i=1; AJvYcCUL6C9PZmqebzfiidxGDsIbzz3upoLg2X/WRMbtXUrcVXJ/R4YgkoxrwMHZDT/0yDB1KETHK/Gff8GuVYk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOw6V1AP9ngUMY09pbI+XI/evKfAQ6asg8xnydwZwYO2954Yro
	QtTYJkERA7pa3T8P7UvqgNmhxfJvUb9dh3HU2kkVzDWlfKNdZIiGJSA4hYbssAqkFyPsbkomyeG
	LhQWCYf7JawrdLCL9bOMvyUq6Pu1YJEHMDOjbzyUXoQ==
X-Gm-Gg: ASbGncvZnCzzLdOkbleEMBayxM9YT3Mhe7EDF/ihlr7c19ZhVHQKEBKmNsAmdBQKFIK
	ZOtiZGpCETJwy5G1oyUzhw/QxFx6dx9+l33FgT7wvzLDTiveisZAbP/1FeyhoMuNa7t6TfNktCT
	aPttU0P2cJOEHecz6Z+77Dy5VW5Rmq3gn1oJ7KsnGAONjtLVygXDycCrIGy1sBfKfR1q1DR7kQz
	9MiBxHygzXMUwQocmEYGBSsIrEL6Q==
X-Google-Smtp-Source: AGHT+IHyxiqyIG1018vg7vc+mtcW6A59E8yUiwGYRJGG9KxCKw5fvAqslGiUqpn1l8NdSfenK2sicsLNKavqouk3DRw=
X-Received: by 2002:a2e:b8c1:0:b0:365:6b40:8656 with SMTP id
 38308e7fff4ca-37609eb8857mr54723711fa.35.1760353762857; Mon, 13 Oct 2025
 04:09:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251003-fix-mt8189-pinctrl-regnames-v1-1-408a2531b127@collabora.com>
In-Reply-To: <20251003-fix-mt8189-pinctrl-regnames-v1-1-408a2531b127@collabora.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 13 Oct 2025 13:09:11 +0200
X-Gm-Features: AS18NWCBPX6jrMPcN6UDT2y68ZZSKL5gcB8CFxgIkLczrmPbcNs-ikNBr_vqb3g
Message-ID: <CACRpkda_BUvjBsrjG33mg-xV2_X6UACUPKRQMF0k8c76fSoS3w@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: mediatek: mt8189: align register base names to
 dt-bindings ones
To: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
Cc: Sean Wang <sean.wang@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Cathy Xu <ot_cathy.xu@mediatek.com>, kernel@collabora.com, 
	linux-mediatek@lists.infradead.org, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 3, 2025 at 3:50=E2=80=AFPM Louis-Alexis Eyraud
<louisalexis.eyraud@collabora.com> wrote:

> The mt8189-pinctrl driver requires to probe that a device tree uses
> in the device node the same names than mt8189_pinctrl_register_base_names
> array. But they are not matching the required ones in the
> "mediatek,mt8189-pinctrl" dt-bindings, leading to possible dtbs check
> issues. The mt8189_pinctrl_register_base_names entry order is also
> different.
> So, align all mt8189_pinctrl_register_base_names entry names and order
> on dt-bindings.
>
> Fixes: a3fe1324c3c5 ("pinctrl: mediatek: Add pinctrl driver for mt8189")
> Signed-off-by: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>

Patch applied for fixes!

Yours,
Linus Walleij

