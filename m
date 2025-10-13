Return-Path: <linux-kernel+bounces-850412-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 1234FBD2B9D
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 13:08:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 15A414F0E9A
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 11:08:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A021A1F541E;
	Mon, 13 Oct 2025 11:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uAE7f6P2"
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F91E19D087
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 11:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760353704; cv=none; b=Q7ci2gZkS1W0QrEgA9Sjb6knRXFkiUPMPUxrLes3wCuO3x79XUvNTtPVIdNRPpQz7Wopm86xB8dHEdkSgRSk+PYVht73ciLFln7GKHzMBAuRPIvBWH1vo4OHxtkFZMQS7GbDyoLtrPjjrA5dCJmeEzQNqswbtPyco7dBqPhYXdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760353704; c=relaxed/simple;
	bh=ypTR+U6CbcsupTqnlW9WC9v+pxZ9wGorAvOqUL63jvE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RVAE7oOx1bjyBoEpIPtNip28IQxI98rS9U29EtzSHDeWL0zyCa6ab+X0bXOLVZf5g9WA2r+bG3ue2vGs6cdN9JGZVgQIh/y/h+z2VULmTlGl62qSC4MN9yzWNCIDVRdOSGNjTgmw7N3htvkz9x3Pf8wm0ZjvygK/mFEk0vtoDw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=uAE7f6P2; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-3612c38b902so36773991fa.2
        for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 04:08:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1760353700; x=1760958500; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ypTR+U6CbcsupTqnlW9WC9v+pxZ9wGorAvOqUL63jvE=;
        b=uAE7f6P2eWrSqwTH62pVZLLZvZJTXn17x/Lx2NAB6Ll5/0CYeVZM/SME/xR5PWAGwm
         Dq7H4ApUlspcLKqTnpbm6Lnu5GW3tSoy2934trOHMgg7fvk5qEJ7CooFTb6pJ1Br/8c7
         oTzYCAPoTpQRQhdXlccU+jxQ85sjp4rlz9uBClq5c3gXURM73QXfzkXKEWDHzYbbg4BE
         pIVyqOwQA3kVujILuA/vJFYo98nj5CMJywwLkdZZwrBTI8i0lA0WlP0He8on2rrRg1NN
         WlXallAQTlMmaCJNe4o8dzt40Zl6uGmQdrbzm34qeeDtRmjhTNjFzsoaA3YZUXAkG/wD
         EdtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760353700; x=1760958500;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ypTR+U6CbcsupTqnlW9WC9v+pxZ9wGorAvOqUL63jvE=;
        b=tIUqiNlpDRkNIp3mx548HmTc8+bXyM1ELqa2R2CclLD5ufSAhcQBQkeex7V0ORwTGP
         kBkUwuGV1Wox6eMKR7eLlwopg8r4Zlan2VKqaRDbgDXTX2ns0fUeI+qFTEH+CTF4oyCq
         E/X6Jd7VWvKeJg/HTRu06ir9A/L79vQ0qYzKAvfl0DMQIeJkXaVz5znDKRZVhl1I/pLd
         XFp2gO8sEo8fkRv9hSDo7NiEA4EQTPW0aLeEAcC8CedW5Bw2eewmK2LoPqqL8B5YkiAh
         i3xBM6MriQD+JkiDzgI26pUluaw4XYMMAyNFNNt/OATmar8R9lwZ8i4Fa99EA6oQ+Nvn
         S4ug==
X-Forwarded-Encrypted: i=1; AJvYcCWBkIvkfENmj9asQm7rRNk+6YWH40nkcHPEZ85Lxra3B3jpmv7XXlwGLiFmcusEgqjPjdA/nT5/t+Uz/+o=@vger.kernel.org
X-Gm-Message-State: AOJu0YwhKXTxmc7XkFtOIO9QkZp8LMuFTIShqzYRIBelG+QVjxZyefY4
	gy+6Xm05esYRSio+Mb2TKzi8WEBV690jzE3CmJtl37pPImr1rs5JWUhY9/1tJDDGy16m3dPEpEK
	diHi6DDWQ8jdk9+uPhbRHp03Ybj16WxMnIM6qfHI0fw==
X-Gm-Gg: ASbGncuIFPRtMXGG4ooNmwth44zXLP2GjcL+J4VWSExZfdx/3Fxe35WNQUaiuCva3/x
	hrTJl5G4Qa1TJolZMx/b38uJk08FAwlNCxk1lzVVidO1RKuEEtWxL4Xhb58mX37M3B2z6Edg1TK
	XxVFvi6J8yt6vnrQ2/nUnHAw6BlL5IYRFEu6JLzG5vJV2r9VEkLWZzXxtK7Fi25D5zIGIMFUYah
	l4cX/T9rCSblFStjoIIXKJeDEYwvA==
X-Google-Smtp-Source: AGHT+IHtdCLd+4uJh0pbUlnFA7Qzu/sxrXL4iOF6wbwTfZv7XTlOSlg+VqyDSfbt690MZKi6vF6Z3aq6/nvgRVaOgQc=
X-Received: by 2002:a05:651c:546:b0:372:9f0c:2158 with SMTP id
 38308e7fff4ca-37609d927d0mr46661901fa.16.1760353700507; Mon, 13 Oct 2025
 04:08:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251003-fix-mt8196-pinctrl-regnames-v1-1-4d22031140f0@collabora.com>
In-Reply-To: <20251003-fix-mt8196-pinctrl-regnames-v1-1-4d22031140f0@collabora.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 13 Oct 2025 13:08:09 +0200
X-Gm-Features: AS18NWCm49dSzl3HawLMJssUJLSTrG4CpecVW6MUgTtkI6_u-J70Cy8bMmd9g7s
Message-ID: <CACRpkdZvJ3jvoxi4H-PL307up1nrvL5hNAtWTrwZGwNW+i8Lyg@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: mediatek: mt8196: align register base names to
 dt-bindings ones
To: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
Cc: Sean Wang <sean.wang@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Cathy Xu <ot_cathy.xu@mediatek.com>, Guodong Liu <guodong.liu@mediatek.com>, 
	kernel@collabora.com, linux-mediatek@lists.infradead.org, 
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 3, 2025 at 4:01=E2=80=AFPM Louis-Alexis Eyraud
<louisalexis.eyraud@collabora.com> wrote:

> The mt8196-pinctrl driver requires to probe that a device tree uses
> in the device node the same names than mt8196_pinctrl_register_base_names
> array. But they are not matching the required ones in the
> "mediatek,mt8196-pinctrl" dt-bindings, leading to possible dtbs check
> issues.
> So, align all mt8196_pinctrl_register_base_names entries on dt-bindings
> ones.
>
> Fixes: f7a29377c253 ("pinctrl: mediatek: Add pinctrl driver on mt8196")
> Signed-off-by: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>

Patch applied for fixes.

Yours,
Linus Walleij

