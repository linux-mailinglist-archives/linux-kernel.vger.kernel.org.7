Return-Path: <linux-kernel+bounces-864478-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D858BFADF6
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 10:24:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DDCDE50443E
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 08:24:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3457C309DB5;
	Wed, 22 Oct 2025 08:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=svanheule.net header.i=@svanheule.net header.b="ZW4uF3y5"
Received: from polaris.svanheule.net (polaris.svanheule.net [84.16.241.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BB7730649A
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 08:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.16.241.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761121452; cv=none; b=BM6vEocL1uiVDOtyRStH4ev6KHevPaX3fh3ltSqDDqiOWOgH1dagmeoo/mKzYrI4pQfhikfTmt+0Hi5OmI2gDir073qu/aLvhJy1uDm+jS64pMG1Kn/Ak2D9pnFVtmZhxPgRA4pLi+iMkqmhoagJfZ5zFAI6UEnk0qm28OF9ou8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761121452; c=relaxed/simple;
	bh=cVLAI8TidoafTBGuNFYDV/STwV4in9pD95DRKnSWSMk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=eI3Afef3dov1zRxmE23UbyycZUTsDa36NAga2AuSaPs5ce/sVyy3bvwyQjj0WV8l6rKDTGZCXkntsFbivi+mCR7cAEfqIDnW8yYc2MJEu1BmlYf2ftzvoIw8TAGd6Gg0gfyLhWL1mpj/7enXuAoaxermAbhLRQ0CORJDuOMAh3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=svanheule.net; spf=pass smtp.mailfrom=svanheule.net; dkim=pass (2048-bit key) header.d=svanheule.net header.i=@svanheule.net header.b=ZW4uF3y5; arc=none smtp.client-ip=84.16.241.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=svanheule.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=svanheule.net
Received: from [172.28.172.2] (ptr-94-109-117-102.dyn.orange.be [94.109.117.102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: sander@svanheule.net)
	by polaris.svanheule.net (Postfix) with ESMTPSA id D88AA68B189;
	Wed, 22 Oct 2025 10:24:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svanheule.net;
	s=mail1707; t=1761121447;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cVLAI8TidoafTBGuNFYDV/STwV4in9pD95DRKnSWSMk=;
	b=ZW4uF3y5R7fcDgf9PaMVfeZt4x0p/ZgPa0U+r6M87BR8FT7cpWGQ/EaZz1WWU3GokV37HE
	cURMdW0WJniFNpUlbSgmAbhZPiJc6n1II7TPE3Kt1hCIAxYNLYSxYxboPmQPKi4UFPi7Kl
	42oxNcoq0BQGaq2MNWu/X8bQZYC2wpc5Yjamjfp+ptfaSDucrIQTxE6tNvSIsb1ZUu/bBo
	cK2l3HTFdODeNW1l4C6logie0WdX/J4GKYuu7cC3jhMtp+5x2j4u37D4XY/OU0lXkUL290
	YjFlv751+dTC0Sii866FsiXjs/hHWEWMUQG+ZEtSLOzYucUKC07uN5Ciq2Wi4g==
Message-ID: <e6d95d91b68a86b748008f69dcc495796b61843e.camel@svanheule.net>
Subject: Re: [PATCH v6 6/8] pinctrl: Add RTL8231 pin control and GPIO support
From: Sander Vanheule <sander@svanheule.net>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Michael Walle <mwalle@kernel.org>, Bartosz Golaszewski <brgl@bgdev.pl>, 
	linux-gpio@vger.kernel.org, Lee Jones <lee@kernel.org>, Pavel Machek
	 <pavel@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	linux-leds@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Date: Wed, 22 Oct 2025 10:24:04 +0200
In-Reply-To: <CACRpkdYde+=85f6Zfz40bMwOxSE-bszHzvBhQwC+G-E2CZr3Lg@mail.gmail.com>
References: <20251021142407.307753-1-sander@svanheule.net>
	 <20251021142407.307753-7-sander@svanheule.net>
	 <CACRpkdYde+=85f6Zfz40bMwOxSE-bszHzvBhQwC+G-E2CZr3Lg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Linus,

On Wed, 2025-10-22 at 09:42 +0200, Linus Walleij wrote:
> Hi Sander,
>=20
> thanks for your patch!
>=20
> Overall this driver looks very good and well designed, using the
> right abstractions and everything.

Thanks!

> The build bots are complaining but I think you will have fixed that
> in no time.

Indeed, I reproduced it on a UM build and resolved it by changing the under=
lying type for
enum rtl8231_pin_function to uintptr_t.

Additionally, this showed that I was missing CONFIG_GPIOLIB, so PINCTRL_RTL=
8231 now
selects that as well.

>=20
> Just one minor comment:
>=20
> On Tue, Oct 21, 2025 at 4:24=E2=80=AFPM Sander Vanheule <sander@svanheule=
.net> wrote:
>=20
> > This driver implements the GPIO and pin muxing features provided by the
> > RTL8231. The device should be instantiated as an MFD child, where the
> > parent device has already configured the regmap used for register
> > access.
>=20
> This is Realtek, right?
>=20
> > =C2=A0drivers/pinctrl/pinctrl-rtl8231.c | 538 +++++++++++++++++++++++++=
+++++
>=20
> Should we put the driver in
> drivers/pinctrl/realtek/*?

Like you noticed, this is for an external chip, so I also decided to not mo=
ve it to that
directory.

Best,
Sander

