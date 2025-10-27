Return-Path: <linux-kernel+bounces-872640-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AF369C11A63
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 23:16:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 541E2463E82
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 22:15:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 364682F12BE;
	Mon, 27 Oct 2025 22:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oIIusBLH"
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4BC0327790
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 22:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761603309; cv=none; b=OrMH7CWWh8QolrxfwDagI3fHmW1iBW0IeRy1Q6TBk/OblRL42DEwWjtYkBA/l/ZFkfcbI3brIWdvTIUMjLN2BNbAwocYbyf7pRs3pGLe7MLa3Xgg/OQ78XvnvR+jbS28ivUSQ4+c8Avi4gOKO8MWvvtEFj3tftmN/n+kyYDDW/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761603309; c=relaxed/simple;
	bh=MklpS3nPFH/8Q8+o9LUwlAzS9y0GP87dIrP5WY05aXE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H4+ut9G/TaQUjC44aX3nlnw+x9bN1rmtk4A7ipoYd6X2/pJXx0bwokHzUrGxjKWXjbLzzgIDLyZMNFKPSE3mKCnkHaLdIsO2CgRcUp9S5VlWzpAKOt5WgKe+TIcp1/yd2iKoQV2zXR2VsVSdJomCOVnJH7WjDITaNGihkfD5anI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=oIIusBLH; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-592fd97c03eso4510991e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 15:15:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761603304; x=1762208104; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MklpS3nPFH/8Q8+o9LUwlAzS9y0GP87dIrP5WY05aXE=;
        b=oIIusBLHv/uPMiuYIPKVd/A4DljZqaB0bAwbK8/xAvaJ1+qq/tUE5VO7nJgv9ImHmd
         vxuEIeUbxR34eP3Jmo8FXMt0FXZyBqXmC86KMnVf12MGces8PpustttlzE5elpY91FlW
         TsdgIBoGDGL4dDNYtaijN0/fPzFy6f4xxT02eDSlKdVxmHCGvd49PCUL/urZaLkLQQ5Z
         1TlzmtdzzFIhHQd2NUD0ph5VWJWH2tz6UI2XRXS+QRK0hJPezLVcfLN4cBNAiD2AkrVL
         gIrQWD/y2s9+8A8myk/Gkh0Latrad8vCiK1CULu78e0b0ChcvjB+fUp7rNZ1+FAOs+0b
         PDLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761603304; x=1762208104;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MklpS3nPFH/8Q8+o9LUwlAzS9y0GP87dIrP5WY05aXE=;
        b=PdWRZPapGsxXZ6muhgeDf/gCiQD09/8JEQFUp8MR92GsivgEYZyDEHVa0cl+gpFLuH
         V4K9mEPgzxhdujwqVW9wnpKw9p0a1/j0mAZl2cU886P4+wOkF6ZWdDPlYXTkxuq14jS4
         uPSuqwfoDJyqnZUvJLm4/LpXIYWsGdvlORfjd5MRGjsweO06PXfEWQX702BCi6dNx/Cy
         /auB/pj00ndiPWRe9NfbewWU61D9s20tNkt3/iJKgcc2ev6PmFywwwdbtREZCKiaICNm
         h1s4dclsd98azQQVmQUncEeTplUWmVXP4mTDSDJbPPaNx/4DeUgZMs1eJ8UyyOIRd++a
         dWpA==
X-Forwarded-Encrypted: i=1; AJvYcCUXGS7ye2nL8P2sFPJbtnCh6UPuWQdnVFXU/FFZgt58jur+9tCbAgMQWyRO71m687JG6C9O4q12X1oNk1U=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywl08Xv66NrFov4KWW07xEcKLrDIORWHaA09ntYGw/1v8/ObI4h
	00a1BVCxMAEOBwzhI8F3HVVZx/5w4qQspoxjjMAhdch8rYjPdnukJJcLFuBQ0gErPQkNfIjHCh9
	Ui07rWGaaHRpiJfpA0y8Yd8PBlh2oOgP3ZQZDKFa2Ew==
X-Gm-Gg: ASbGncuqodRD5yXZvGcra2Uwh1Zyzl+B1WwHE7nmKWzkeSDo64t3XvG161+2KDAIsgj
	SbWQ3fmt+5zIKEbMytdZCUiZCdLRybdPGQrHYqUbsn9aH8VONjHAXCGI12x6+T0G7ianWhiZdJ3
	ZPS+CljKxfS3/SkXxqfJtU/SeGiEgztd8fnAO3xtNtA4R0H8YoDQN7lTk35NQg8cRrHz5VPQGmP
	lfOiKJk5OdTBzw6TWIjlWhsBAI1Yv9bG/Cfl0mSmNGEjbHs4hFRgYCwC1LwrD44iobE7ww=
X-Google-Smtp-Source: AGHT+IGLhiO6SgwWEy6J63NGSkHEkhNG2WH3ZWZ7Mjt5HjFADLOLTHG32rGKFBXTboiBLjapU4iKntf9dVI4uinRnL8=
X-Received: by 2002:a05:6512:308c:b0:591:ec0d:3014 with SMTP id
 2adb3069b0e04-5930e9c3bb1mr426683e87.48.1761603304563; Mon, 27 Oct 2025
 15:15:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251023132700.1199871-1-antonio.borneo@foss.st.com> <20251023132700.1199871-10-antonio.borneo@foss.st.com>
In-Reply-To: <20251023132700.1199871-10-antonio.borneo@foss.st.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 27 Oct 2025 23:14:53 +0100
X-Gm-Features: AWmQ_bld4K6zXNCkN---w7iwBNN2WjFxw2gv2dtNkgQHft2zTjwtq7Bsw-LLEv4
Message-ID: <CACRpkdZoecqkKfXmu4ih3qb00OMPmAtJVvyqerXf52n+s7vFxg@mail.gmail.com>
Subject: Re: [PATCH v4 09/12] pinctrl: stm32: Support I/O synchronization parameters
To: Antonio Borneo <antonio.borneo@foss.st.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, Bartosz Golaszewski <brgl@bgdev.pl>, linux-gpio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, 
	Christophe Roullier <christophe.roullier@foss.st.com>, 
	Fabien Dessenne <fabien.dessenne@foss.st.com>, Valentin Caron <valentin.caron@foss.st.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 23, 2025 at 3:27=E2=80=AFPM Antonio Borneo
<antonio.borneo@foss.st.com> wrote:

> Devices in the stm32mp2xx family include an I/O synchronization
> block on each pin that is used to fine tune and improve the I/O
> timing margins of high speed synchronous interfaces.
> It can be configured to provide independently for each pin:
> - skew rate on input direction or latch delay on output direction;
> - inversion of clock signals or re-sampling of data signals.
>
> Add support for the generic properties:
> - skew-delay-input-ps;
> - skew-delay-output-ps.
>
> Add support for the property 'st,io-sync' to configure clock
> inversion or data re-sampling mode.
>
> Show the new parameters on debugfs pinconf-pins.
>
> Enable it for the stm32mp257 pinctrl driver.
>
> Co-developed-by: Valentin Caron <valentin.caron@foss.st.com>
> Signed-off-by: Valentin Caron <valentin.caron@foss.st.com>
> Co-developed-by: Fabien Dessenne <fabien.dessenne@foss.st.com>
> Signed-off-by: Fabien Dessenne <fabien.dessenne@foss.st.com>
> Signed-off-by: Antonio Borneo <antonio.borneo@foss.st.com>

Patch applied!

I'm really happy about how this turned out, lots of generic improvement
with this as the end result!

Yours,
Linus Walleij

