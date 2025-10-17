Return-Path: <linux-kernel+bounces-858096-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 06A11BE8DEE
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 15:33:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B38F958530B
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 13:31:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8661369967;
	Fri, 17 Oct 2025 13:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SA02Nfsw"
Received: from mail-yx1-f49.google.com (mail-yx1-f49.google.com [74.125.224.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA1CB369960
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 13:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760707880; cv=none; b=nmWXvCLoaM2s+Q8igmCOr/hEkmQ+0PSIfzAVdJ+o1HNMk5r9XanCpjIQTmNoa1ImdZo8PYG2raAxf+A5lIT6wI/Ir3q0rYCZ6f+AgkvGUhkSW5mw2aCVsIs/2yeitnYZnssvmppZkkLJkyiz6qBpuoQAZNjseHjTRZAnBM3CTgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760707880; c=relaxed/simple;
	bh=9J3gYQc0b7N83X4ObbdhI51mWDQfnawAW2aJ6+zSLLU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n7P9bK/977963qUw+e8odH8/n4st7XeOwdtcmDj2hliBcOvGBWsu2G9wHW0a3NBdD+62JSG7JqR4UgbdJS6rRQSdi1EOku5BJdg955H9yt2FbLrnCx2B7++RpIoHruozbnsmn3MPUS45aP42sNg4cEK9tUpzwWt1J12M1Egiemk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=SA02Nfsw; arc=none smtp.client-ip=74.125.224.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yx1-f49.google.com with SMTP id 956f58d0204a3-63e0dd765a0so1689401d50.3
        for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 06:31:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1760707877; x=1761312677; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=x2BAJwgG2rchT5766h6wzsoqRB39jvTToguWS8dkekE=;
        b=SA02NfswANxqN5SHinNzq0BGAxKnuOy9Z4VXioXpuI0Nt1cb6bLuwPtpSWcEHHLFPg
         rAWDW0Wwop/UiDg9pDlXIQAmW2Wl/d6sa0E9v4ElENlguII8JS/GndgMJx9GE/4fYO5g
         BwR92f8Vb55sjZDO6SKiPQFQhugcYkM3gorhqInyGKIItj5p8AB1KOSMgRwfW7iAeMMH
         VY+MnZEBp35PnNRm+S65dD3mk1YCrmAe8Li/nfowqm2fsv73TpMFyd5xF7XCi8Pc38HX
         oq4Udr/+Mhe5cY7eKVoawCb8IjE0scPUNLrLHAYsb0W/1cMHVeyVWjiVzRLo8fAdrtqK
         4BRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760707877; x=1761312677;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=x2BAJwgG2rchT5766h6wzsoqRB39jvTToguWS8dkekE=;
        b=cPlV7IKj9fA6QcgYNmHuchvxPBS2AifaXMqwtm21DNh48oXObXP4APFz+jEtE5y+JR
         OD4rglINIq6kgiZvo28ehI7bOCxg9uWfsSZIuazzYgFirl/aZ5FlEUwbW/iu9/0CapAl
         w4yAzR2HFKP33iJjnQ7CNpi7e5qdEdJMvmkRQZw4xPR/QbLiOzYXswsGUVX5sQAvBpeE
         otjoSPiLC5oHAY2lQ+7Gni0pI3Nu41QS/87gxFRhU/XR5/KPiPBKFsa2/R/rGSb8pVlV
         tTLRWzjDdu8OKydQVODLI81yKlva7fg2rGx99QPom4mHK9ZaqFLkZbESuZ6BhXdzpHWg
         aQAQ==
X-Forwarded-Encrypted: i=1; AJvYcCXF188t3C1KhlyD+lBOdqEZ3rGgaf4KJfuyhWne9TLWguTNLfV/ikY7ayz7QwL1FYGiw6QYgZnIC6kXN9c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0vORjAof9xyykwmVELk4eV5mgOeDbTz7MoQrWV/YV2HaX8Pcp
	k/Cw43vcx9fA3r4oAcuc4FLnQH9BjTPrWE4hKx4kobhS31Yes06SwydiSRINfPaaQjNdpz7gGd+
	DhASFmzPgS2lvM2DxcLzmuFpjvUcd0QFwMDPlCn3hfg==
X-Gm-Gg: ASbGnculiEsQnnd5iYM1NjW/VQbH5VFvphSt7P1V334Qnwz2FSlyd5odTsSvfHD/jD5
	dqp43qAo7iIa6h69DWRM0pNuGPX4N4weImpk2lVzOQTBU7YvbHU5lqgCQMaTraSOVOQfm1dh22A
	Yo2g8aVMGEdCu7S6X06/VWTRvNGj+zp7Bh/tB7T5y+hR090QeSjvz5oAmDdzVMRwehIe8r3r8Cu
	CY/BYRxYBxus4dF9rkW2m6QFX2ijNGJEDIoXkxccZ0u52WMGuJ86b2qbO5sQQ==
X-Google-Smtp-Source: AGHT+IG77y33qe+YSWiCuw+bGYaaF+09RYcnrxdmlGwlAWMUhZclurVy0LNRRN3kFjrGJM6cFb4D106JxZl8pArLwK8=
X-Received: by 2002:a05:690c:31e:b0:782:9037:1491 with SMTP id
 00721157ae682-7837780ba2dmr27683357b3.42.1760707877501; Fri, 17 Oct 2025
 06:31:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251010133856.13167-1-johan@kernel.org>
In-Reply-To: <20251010133856.13167-1-johan@kernel.org>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Fri, 17 Oct 2025 15:30:41 +0200
X-Gm-Features: AS18NWAoXkFnAoP3lqA8ems1jp1Az55C_wUWwzdzNqFgVrU5xVeCIfkHfuYkqhQ
Message-ID: <CAPDyKFoSCjPA8SfNuUtMfGwsyS65-qoQ=Mf3g95TLx3pnuk8FA@mail.gmail.com>
Subject: Re: [PATCH] mmc: wmt-sdmmc: fix compile test default
To: Johan Hovold <johan@kernel.org>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Mikko Rapeli <mikko.rapeli@linaro.org>
Content-Type: text/plain; charset="UTF-8"

On Fri, 10 Oct 2025 at 15:40, Johan Hovold <johan@kernel.org> wrote:
>
> Enabling compile testing should not enable every individual driver (we
> have "allyesconfig" for that).
>
> Fixes: 7cd8db0fb0b2 ("mmc: add COMPILE_TEST to multiple drivers")
> Cc: Mikko Rapeli <mikko.rapeli@linaro.org>
> Signed-off-by: Johan Hovold <johan@kernel.org>

Applied for fixes, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
> index 2c963cb6724b..10d0ef58ef49 100644
> --- a/drivers/mmc/host/Kconfig
> +++ b/drivers/mmc/host/Kconfig
> @@ -950,7 +950,7 @@ config MMC_USHC
>  config MMC_WMT
>         tristate "Wondermedia SD/MMC Host Controller support"
>         depends on ARCH_VT8500 || COMPILE_TEST
> -       default y
> +       default ARCH_VT8500
>         help
>           This selects support for the SD/MMC Host Controller on
>           Wondermedia WM8505/WM8650 based SoCs.
> --
> 2.49.1
>

