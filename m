Return-Path: <linux-kernel+bounces-860334-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 404E6BEFE4D
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 10:20:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC9FF3E6E9B
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 08:20:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 027EB2EA15F;
	Mon, 20 Oct 2025 08:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XjOe2YZm"
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0D032EA736
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 08:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760948404; cv=none; b=j0qMtZb0AbAFNyy/h2UfMmtGJ78Ai95aO50PUGIFTr9GlsZiUhcHD1DTCZJ1xZzaVQam7nNMg0RJoDI7SeDmS1BpHAW8TwPNeJuJ3+F7KS1bz05ENKEEtd3BnprSZnUoWQ/zjkkHiuYyzOhMurR0+96wBPHNATArSFdbP7gQDl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760948404; c=relaxed/simple;
	bh=9CLN3XP4gT6Uua1C96RINMvaSgMZmj50DVjXUb+alrk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LL3JhWEbY7YLTySqXpVBVh3VkM2uP2x6sJIWvEsx6UH3ftFhTqLlyTXfhFILrdTX99+7EILQfRcfz495Si7RRX3vknTuPbCwngpS6QwrvrUPzPyy04Pcega2Q9zgJtfMuxM/2Eo8JwzdT9zmhtKLt9tHMmzjv+oOJZuyKp1kgrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XjOe2YZm; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-87a092251eeso95891126d6.0
        for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 01:20:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760948400; x=1761553200; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=krtDUBIIbBhf5txhvHZ8ViDPiZJA8hj1zGguCfZUNVQ=;
        b=XjOe2YZmUmzWNDgutBTWleHJZSCEW4s6qisehzrkDZjXcK3fDmxuv5jE5Wu83MMSDT
         qLJ6zm902boqrXqh5jdwhnRpOZF4YdR+js0/tDqIhtDdbpxYWgsfOQbzNf9XrKlX7Dv3
         n2ygL58W0bfwFtZjhNFv+qB/Ziu26ff43w14DXwwgExCyJpYTewKi2kl7yxqXKxc7lA7
         Y1uOwOHEWCdcGB3KbrTBgRyU8ijdUwSs8BaclEOHf+bbP25gEMedFlGuXbmpkUXASv8N
         dyQWf3lBTjbg6wjBDPlAOozdiCkGxEsH/llKpnMS+ZliVLpoT1yoTdx3mfml4LNQ8oCr
         nxCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760948400; x=1761553200;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=krtDUBIIbBhf5txhvHZ8ViDPiZJA8hj1zGguCfZUNVQ=;
        b=rzvnewFBRY5m/tmtdVlXF8sD6muhG4Qd1lUagwqzljjADLzbH1TCeq1WandIJZHV0S
         ksAoQW11RfnkGE4WQMyjo+HDvDK4tesEN2BJSrjeR/yrfPmA/cTeOuhUrHFdG1tWTTgE
         MsQGLnUgjb1uveRInlgYJ9zH5HonU2IHMoaScEGZGD+x6gzfPoEO9LQSTxXZHHVhHPNs
         ew4l8RnI54hS8/gCK7EWa8Ouj3i2YBDwZy0tOubbO4uSelDlbnjFMyFeB06XHUA0rl+J
         pcG4stDIpD3bIVkdxujCg9oKDwdhKJczCJmQmKIemkucXLbjDra4ZTNpL0rbkXUTy6hg
         D5pg==
X-Forwarded-Encrypted: i=1; AJvYcCXAlc0F7xo66kZZCGYMGcJmKo21HS9fXxBI/GQqBLst2QyXcdP00oj+nz5nID1cxuMy5DUAwJbtJkRIluM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzr8Olt6yqWHMxG9w39kSKIL3PqFfPaAI3Of4QeoZYFUm5dgBq2
	/pI+YWC1i/BjAsK7/Lh8NGyiBAI5+dyJX6pQBNUkvpoaLd2/2ETaUexptp4qvDtMLn1NzeHGje3
	WXmnXdFpJvlmpqJm9+3GwUAPNe+aHegM=
X-Gm-Gg: ASbGnctwhJfJNLYXrNvVNBFnFSUJRlzoUxE9RnH5BQ6cKG2RWuFoffyaNR+Q3DNZZs5
	kN1HYYn0m6k8r6HEIae2hxWIlQ+2YVoW0uPX8B5p5o56gdxWvBNwRWl/uByY1NA5Y6qyYRQ0inX
	U1m9cjWsUDrWs/R+6UOqA1xQYYMedOpX9CnQcMtp+DUQm8T+qkyG99n6YcmMcVYLTIwV4w7FHBM
	O3EMfrmGrrGwfyAz/vTp7MXmzOoMfZBokB+YtrqRFznymrmAh4qhGqwKTL73GWDQX4ZyuNYl3tK
	gKDgEnT2NYEEBofKUg==
X-Google-Smtp-Source: AGHT+IH00fZSiLlpv5/iK2nqClbPVqEOFs6NjYUaaUpZZ81WenopkIUOdg2ZPbRIOvaCbrU3WZ4RbOVGHG7Hebvs9Kw=
X-Received: by 2002:a05:622a:55:b0:4b3:4fa9:4cd2 with SMTP id
 d75a77b69052e-4e89cfb2443mr191567221cf.33.1760948400448; Mon, 20 Oct 2025
 01:20:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250925-rk3576-evb1-dsi-v1-1-c76fc3740abc@gmail.com>
In-Reply-To: <20250925-rk3576-evb1-dsi-v1-1-c76fc3740abc@gmail.com>
From: Alexey Charkov <alchark@gmail.com>
Date: Mon, 20 Oct 2025 12:19:51 +0400
X-Gm-Features: AS18NWCBDCEZzvVwJX4XETqmgmCCBqTdNAVD0aLBXbcVgyOY6pJqe52HL1dPqJA
Message-ID: <CABjd4YwVfrzxYKM4cAG=-fMbw9OcQGZD20CVCG8FvC8phDsw+Q@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: rockchip: Add DSI LCD display on rk3576-evb1
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 25, 2025 at 12:38=E2=80=AFAM Alexey Charkov <alchark@gmail.com>=
 wrote:
>
> Add support for the Rockchip W552793DBA-V10 LCD+touchscreen assembly whic=
h
> comes physically attached to Rockchip RK3576 EVB1 boards.
>
> The display part is driven by the on-chip MIPI DSI controller, and the
> touchscreen is connected over I2C.
>
> Signed-off-by: Alexey Charkov <alchark@gmail.com>
> ---
> Note that backlight support is left out for now, as it depends on PWM
> support [0] which has not yet been merged.
>
> A workaround is simply `gpioset -c 0 13=3D1` to set the respective GPIO
> pin high and thus to light up the display unconditionally.
>
> [0] https://lore.kernel.org/lkml/20250602-rk3576-pwm-v2-0-a6434b0ce60c@co=
llabora.com/
> ---
>  arch/arm64/boot/dts/rockchip/rk3576-evb1-v10.dts | 89 ++++++++++++++++++=
++++++
>  1 file changed, 89 insertions(+)

Hi Heiko,

Any thoughts about this one? Can we perhaps get it merged for -next?

Thanks a lot,
Alexey

