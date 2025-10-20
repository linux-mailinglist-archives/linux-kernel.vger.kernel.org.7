Return-Path: <linux-kernel+bounces-861820-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D3FFBF3BA8
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 23:26:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED79F401E15
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 21:26:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F6E6334C0F;
	Mon, 20 Oct 2025 21:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="T7MAEpQk"
Received: from mail-yx1-f41.google.com (mail-yx1-f41.google.com [74.125.224.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0349C334698
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 21:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760995560; cv=none; b=OlModTS1skJNbPXFqwRfAkIeuxJxUs3H5+bLuS7EqG1hTXhVVM0I7qE0vRo7w3xdEVDl7gHefcUQz/EJjUlXqsgTHuM60GJthzejAsju9DUV+eJUc0qa547Xc6uH9w6dC3DHRSWY7h86f1lnc99ebhbVAVMxxErFMc6sQ1dzt2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760995560; c=relaxed/simple;
	bh=3ficstr08eO/ho+LvgoSlORtGJi90d5fGOsDZArihyE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bdFUHaHPdtrtAAvQSQn3sTNOpOG/V/4u9usT00QuxaS7VBH3gVl1Q6VvPBdjTnwJyB8aBROtpmztJU2tkrBfHqBGP3SmVoc1k1sBeOHpl8aO9UeHg4GlXKGkGM+x8G2E7DEEHIAQXScuFo1Z+yuujvB5KEHblpTLaQWVztDKmMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=T7MAEpQk; arc=none smtp.client-ip=74.125.224.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yx1-f41.google.com with SMTP id 956f58d0204a3-63e1c0fd7ddso3254027d50.0
        for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 14:25:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1760995558; x=1761600358; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3ficstr08eO/ho+LvgoSlORtGJi90d5fGOsDZArihyE=;
        b=T7MAEpQkVpGf+lELgQcarCHJ7WfDW76bSwYS25Bouli5STkVhZ0xIorybcjQzOVGeg
         UUcqRPedHJqHdW3KnqaXyyD6v0+bqV/pfZ1Z0vv6jlrSXif1atKM91WdS5nqRv/enrke
         osXULzwnQmS3n0omif9E4ewC0mcmjZdQrxZioeLwZyyLiGEydfI6C1kWtuCK5FmaE2/L
         t4vIVxQSBPy0SQerNyju3kg25mypmH+zDldvugz9FrIJOPWIuEQ8je4ZNFQUAqruXIMK
         QFyeSPmrIwhMtzX5YzjmEwwu1y5eaJJZkVPXvG4jeJTL/IpLKExUUQ/ZIqsrE6w9iv4M
         Gjgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760995558; x=1761600358;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3ficstr08eO/ho+LvgoSlORtGJi90d5fGOsDZArihyE=;
        b=Urk6JcnMJsT89NMeeNE89DrCBnQdPL9NGDLtRLrtcXCaG1Pw/mwXr5zmRZU9lnch3g
         Mf4vKZ8xA3UdxCmptww+4mGeulaUeTiD+22zMNouZ/GY7ozb+EQvazabzg4cu2D5EFxv
         KW3KmbAmX6pi+EV2DdA+bD+GUX0qY1qDXd880X1ZFEjOvtXOjSwyV3U1LSMK2e+JIKUh
         v7234BNUno4/6uosD35e3ijBCUBVr1G5ddmj3zxHeGmM4lTAz1AQv244zHacxuC5aAxZ
         lSfAx4+yc43090vANgea4WfiAHW1D3NervvBWhFeYAMPznZJpoUtE1V6p2QQS3XIwckY
         wJig==
X-Forwarded-Encrypted: i=1; AJvYcCUyB2sQ2vQMFpXcXkrZrQD7QXDgEyfSZjZxD8vDa4g2Q4xYMY5iPQvkecTcmYU+8GUKlLNGYakVsOVldyw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3nFfMHG0zG06toXYkKCxG5vcSlqjuddi0HN8V+SSwN/wxn+L9
	GV252lXVZPelr0C/D+0DLLQUWajsCX/zBK4T27r+PNp76LMFlPP/Y4IPf2ppsc0ciW6H851c3gu
	QusnoNqI8oaPkgTUkxD3fhT9M9/P0fvX1a+9yQksSCQ==
X-Gm-Gg: ASbGncsL4obYgS4FlrbLrUGf8anmx1PNbS2x7JWxbTPw+IjhPjKLPAidfxUayvyKI/a
	RISRUtI5cvrfTTqznWotHGE8OEVWhklwqFiw/BAiC2lqLzfcWaRgrX64JCQksGuWEkXifrgMPIo
	6VurbT3MLhoyWo0DF7dHrKj1UE1DHLNspa60OmTOFdHJM5GCoxRQZFSEiSAvDyZGe4CTQ6qZsmL
	IW35KXG46Ja/yLEMoziGKpDZjlSx6omESerwKZAd8CiJcjB08urSnvzIdnAkJbT5d1+r8A=
X-Google-Smtp-Source: AGHT+IFEK+u7rcHcFq2YCBURn2SZqsS5EQVHgyo+WSTkrxddRAm9NFxgRGfkZifZkr4k8srGrUAoxt4PUGQB/cXcduk=
X-Received: by 2002:a05:690e:2505:10b0:63c:efd6:c607 with SMTP id
 956f58d0204a3-63e160d904emr10557853d50.3.1760995557991; Mon, 20 Oct 2025
 14:25:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251014191121.368475-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <20251014191121.368475-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20251014191121.368475-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 20 Oct 2025 23:25:45 +0200
X-Gm-Features: AS18NWAZD7qKc4BMmb2MB0EYqlsiZhHQMPkiNfMmUGQwwkY6EwztrFsHH2m1viI
Message-ID: <CACRpkdaNJ4g_yYkwJHORtOdtxgYWMgmN1FZNj6yjDtZyc01CYg@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: pinctrl: renesas,r9a09g077: Document pin
 configuration properties
To: Prabhakar <prabhakar.csengg@gmail.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Magnus Damm <magnus.damm@gmail.com>, linux-renesas-soc@vger.kernel.org, 
	linux-gpio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Biju Das <biju.das.jz@bp.renesas.com>, 
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 14, 2025 at 9:11=E2=80=AFPM Prabhakar <prabhakar.csengg@gmail.c=
om> wrote:

> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>
> Document the pin configuration properties supported by the RZ/T2H pinctrl
> driver. The RZ/T2H SoC supports configuring various electrical properties
> through the DRCTLm (I/O Buffer Function Switching) registers.

I was going to provide some comments but Conor had already given
exactly the same comments that I would add myself, so looking
forward to the next version.

Yours,
Linus Walleij

