Return-Path: <linux-kernel+bounces-850546-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id EFF31BD3248
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 15:11:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2D5B44ECF67
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 13:10:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C5BE2EC08B;
	Mon, 13 Oct 2025 13:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hysCUdZn"
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C16232BCFB
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 13:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760361055; cv=none; b=HVXCBd6d4geUPvUafqG9+LThc4BIqRTs1w1pOB35UkMTN9NIBCedoVq7A6BYRJZ0J+PpVRiuS+HwF9gMsxbrd3ywvNVMSy0fZrcVeiOcTiz1b6f2igNloZsH4m58ekSN6LUkKEnueHmeY1d7/21K2apRqja+RvmeEr20vrWhf8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760361055; c=relaxed/simple;
	bh=6PQLnSSGAkRkKVpnNFnjlQ7pqzYi6bHY7zbvd/j9x5M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=jLrLauwyqXcA84TRLt47+6RnHJc+TOUyf+xEqt93cAOOxYaa+ddrEfE8V0B7s6Mmvr1OdR+tc5sWLNIb8x2y5XA196QyGS2MKUgeMsVChshfTXa7zADmdShZoMeU5olZBWuHuUKFQEFrwobUVWnLSoy6OkDDDOCHAAtENUuzwN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=hysCUdZn; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-3635bd94f3eso37386111fa.0
        for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 06:10:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1760361052; x=1760965852; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6PQLnSSGAkRkKVpnNFnjlQ7pqzYi6bHY7zbvd/j9x5M=;
        b=hysCUdZnyx4FNeY1IpSy49i1sgyx7ccFxB809SFCP30ouDQ0l5hK5dKiecJpRvTn7I
         XdRmbyQzDMwXtwoGj1nKLn40QVLH0i+4ds6z9F5E83BXLJAMczCoBqbQDXcGpenEHPQd
         GqsnTQPUn6lukzs7y9hiavdL2KuzMMV56dH7/jf6VBS5gflA3jik5hNCbVBERJPsGKW2
         f73M/RLZbYgrEpYn2GvcybAmdHOdHIQHaT33PpeLNsnrhAzv34iK/9KInuOafv5jkv8r
         rFCqI0Czv7vgd4ez0XVmO7oqyn4qKyaQTbE5pzB4DHip4ElCvJVy6e+Y5LRg6dMna6i2
         fK3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760361052; x=1760965852;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6PQLnSSGAkRkKVpnNFnjlQ7pqzYi6bHY7zbvd/j9x5M=;
        b=CdAebtmeoE1IgnIpduTrBfTS+mIpL76zQpbAqX/KGYjc07wuLdTKjn1RZaKW22IimW
         13QrAVr18sEt/TkCZ7ezdAMy0c9miDMPICYsMZY12Q4SHQ9DiQvsBVW9dqa5y+DZBkh8
         oQzXoFVFL5ZrT1ABTCXX3Xgho4saNmG6QVBzOJuLyguYeD4FsuOVKbUZKAU4H3wjJzVy
         EhnIFK3qrEzj91wAA54jwrHNsfkK8tHd/sLU4RuW8KEj7SSVVE1nq6zLtLe1+AIkHUd0
         Yo+Q1bAZsbVN705GPrccagncDq8R3+1BemxLHs/v6nY+15Ftemo81/s7goyYqOCnSq5k
         VOqg==
X-Forwarded-Encrypted: i=1; AJvYcCVRf6ahVgH2/ULVfL036cWCCndQd4IngpZLv0Yns+3vWPr0ZkbZW2IPjAT0ZbwW0XOVdK4ugtkbZsBi7lY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBLj/uqQlbqGOIxVVZ47gayT+5asHojUDOCw04JB9Nw7wm7zYV
	iHf/4b6ypWkt4a+YbcciDaP+qpV/t3K2rsET7PnV06spixkxwSSztPoJfynuD9ueETYXVQRU2Fv
	1ox5o2MKKbO9Ml4rLJo5W+N9pGC8OTJs07lJmNIJmLg==
X-Gm-Gg: ASbGncuNZTDOxStxx2C2klvrWJr7Do1rjS1F86nfWdi+RyV7pG/SmaSxH+667I2PiTl
	eMPCxhb8ZNsxMHxIIKiqaG3Q8utG2X+IGIkBeynOi0EHNgSJF7PFWDc+sgCSUUWsObtXedkp7y3
	HeuUeWz5wKJ/0IGKaSEZFCTT8TbPNWAZSI+NZqSAawkzzXQ9s43sNkgIzpOC/zXe6N5rF63EsZy
	7GVnmrhWukNao4GVcUj5RB0MH/qkA==
X-Google-Smtp-Source: AGHT+IGbo4BMMGUKCdFUCwj2jkVxEsoMKwOn9jKjvcy5sJsII24Qf0yYXqLHmJNkUW2GMCchtirwu8qwmTvAOO5yO+o=
X-Received: by 2002:a05:651c:546:b0:372:628b:5cbe with SMTP id
 38308e7fff4ca-37609ef5cc8mr53550901fa.42.1760361051873; Mon, 13 Oct 2025
 06:10:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251007-pinctrl-drop-advert-v1-1-df16410680af@linaro.org>
In-Reply-To: <20251007-pinctrl-drop-advert-v1-1-df16410680af@linaro.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 13 Oct 2025 15:10:40 +0200
X-Gm-Features: AS18NWA-BZeDDz0UxckZs0Pv5Vi49CF3-yUcAh08ZXcZ3B6SePiC51zOjHIl4lM
Message-ID: <CACRpkdYiObPoit1cTXY_1EsHKzA+bEhwsgYtVaB-T4RoaXvbVw@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: Demote subsystem banner message
To: linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 7, 2025 at 3:18=E2=80=AFPM Linus Walleij <linus.walleij@linaro.=
org> wrote:

> There is no reason to print any "hello world" from pin control
> unless (maybe) if we are debugging.
>
> Drop the banner.
>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

Patch applied!

Yours,
Linus Walleij

