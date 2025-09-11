Return-Path: <linux-kernel+bounces-812714-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25AAEB53BC7
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 20:45:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1BDBE7BF01A
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 18:44:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 672742DC786;
	Thu, 11 Sep 2025 18:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F1uxIby+"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 237DB2DC77E
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 18:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757616331; cv=none; b=ii+ijRarfWsDA4RuLu2WUKnhYhy44M81MqNv/oQlUu1mtlr9IrgX3XPK4gRSKZ4MJE3b7YI3oqDjl5crD590Fsn2VH8FsXMYc+XJmFgDeJx75tpymwpK5b4oLLdsSfz31/FlOwH5sSTQ3TbcR+ZpaW6JES/m+BLm5yskdCVyXwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757616331; c=relaxed/simple;
	bh=PU72Key0SVmvWQm9PWpGLknK5t1ThOCAfthGViLodCM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=D57HAnNhbxzmz1d1OK452DQRssBCd+MzI3pig9t05cNmwTJuNPJHUTO0/TfDtVqQzdZtUhCPtBOzQ6xCzZjXX6uqQMSrhstvUjdaR/moVrTpd7XpqIyNQh1tMN/xzx7zlmj3kiOLBc7mkYx8jKIOrglHx3/05WPgTnn5y6n8kOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F1uxIby+; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-45dcfecdc0fso10725935e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 11:45:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757616328; x=1758221128; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qgoU6ODnHJHjlxJ7O2reyqhOrHLfmkxgDzAUfsAuBJc=;
        b=F1uxIby+n1jD+eHkASJDtKaDlKcr0uDSdut0D2oEdcPWsLxNf4XiqJdf5V13zl2CsW
         Whs0PIfU93LX4cvBT1dxLgB3ewp87RX0wPjDqwkITf4WsnNC7UhxNHBglyGD/gRLUZIP
         6z9W9OrIuEvZvuFjPkfWqky7FVlbxX7rpQtaXRgFJitnH7BLL2L2gfbCwBgV6y2+KyrV
         O5WmqxEiWBj/1B5EGxgSc5KatPJtNrx+exYcbta7liENKRxdihoGLZfeCVcF6TKhP8qp
         fayCccMwtd0008RDBI64tJmo+Mn1cAP4FojO1Z1MpjY37jZ5IuWMoqRZ4jQa663u8sun
         Rdog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757616328; x=1758221128;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qgoU6ODnHJHjlxJ7O2reyqhOrHLfmkxgDzAUfsAuBJc=;
        b=oqEBL/3hFOd+AXLzhfHFDNtOynsxsO1leyzBP32FRabPb72gFhBuuoYXsvyoZFgNI0
         mDAXRq/Ezgc+GniUW7R2I/1tzvsl9OLdJEefAb7cyKhGW6rPOhIIQtHMnaLg3tL3ue+z
         RYgCXoDVbIbJkbBkTut3dmx7rp5Kfpn5xgX7EYeHKd+bzFQb1kZyQ1fOIwC1lMQa2BqI
         Z9VCxMcwninSRIWiDraN+7VlgS2Dd18u4hZK/y0UQlFhHYb4mg1rRtWw3pMlPC7hzYVQ
         hsv4JaNPAYf4vdCMlHD4NtEtqNo3PNmdja3OqYJOJE97dtU7eXOut3pH+MPCJPtr2+gP
         C3bA==
X-Forwarded-Encrypted: i=1; AJvYcCU1oVhax8rGZIAFM9tmLHsXFkXyDIbxkteaCJUI5F5M6W8eB412eqxye3qhXy+UWJkMp93T8Y3an+wOH1A=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywr2zXazA1l8Bt9MUHMEHPRdaaOh5fCJqmz/P/lDoW7QMWMJDN/
	4KsHkq3tSQZ74pA8kXjfmGJYc1huhcAGOqUQHKP8h2g72wEQZ2Egf8B1
X-Gm-Gg: ASbGncuaxS8DUjYNKTKuHvAjR1JmZI4rah80uMCzOMESypCKmPWtkKftfYtVivLKv8v
	kViY/34Gbd/cIHBPHPgYRbYhSPZsJSIsXgIfaT9Q0rZWcCgi8gbOUsqTGVU7Vtzty7ByZYmWIG0
	7Tbj+madfHtQ8Sa66v5b4tpupibRgG6Vr+9UU9hxk4UgXfMdPBZLqtYX+Bhmyy3a7ngUWsTj3ty
	bZKUOZ6J32W0WpoSxVjkZ+XKGMI6WBuQeOsVufhj54ZArPu3DgBaB98+O00UhckMm7InY1NK8D4
	RkTPu6F6KUaxm4k//nHDQ9Jt8+8rmFwsB4ZveNd8PnsVQ+8F8PdKU7e/TMZyG5Zsh2I/FCLHhR0
	oq+uLNJQD/N4D4/xlU9sXKebGv2qGMphSv+i+07QRBEZthkZC9gM5WGpCnrVobAE0+qs5ag9WQr
	e88VLJlWy2c85PdFSNs+w=
X-Google-Smtp-Source: AGHT+IF35WXiz7qtt5E7pbWdiKdOZLXpqRy4oaXj/fJmaGWMagVTnOpk2kyKlLObTat0jClq3/mWxg==
X-Received: by 2002:a05:600c:34d4:b0:453:2066:4a26 with SMTP id 5b1f17b1804b1-45f211d008dmr7116755e9.16.1757616328099;
        Thu, 11 Sep 2025 11:45:28 -0700 (PDT)
Received: from jernej-laptop.localnet (86-58-6-171.dynamic.telemach.net. [86.58.6.171])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45e01575fadsm36130825e9.6.2025.09.11.11.45.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Sep 2025 11:45:27 -0700 (PDT)
From: Jernej =?UTF-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To: Stephen Boyd <sboyd@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
 Jernej Skrabec <jernej@kernel.org>, Samuel Holland <samuel@sholland.org>,
 Chen-Yu Tsai <wens@kernel.org>
Cc: Andre Przywara <andre.przywara@arm.com>, linux-sunxi@lists.linux.dev,
 linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject:
 Re: [PATCH v2 5/7] clk: sunxi-ng: add support for the A523/T527 MCU CCU
Date: Thu, 11 Sep 2025 20:45:26 +0200
Message-ID: <5037780.31r3eYUQgx@jernej-laptop>
In-Reply-To: <20250911174710.3149589-6-wens@kernel.org>
References:
 <20250911174710.3149589-1-wens@kernel.org>
 <20250911174710.3149589-6-wens@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

Dne =C4=8Detrtek, 11. september 2025 ob 19:47:08 Srednjeevropski poletni =
=C4=8Das je Chen-Yu Tsai napisal(a):
> From: Chen-Yu Tsai <wens@csie.org>
>=20
> The A523/T527 SoCs have a new MCU PRCM, which has more clocks and reset
> controls for the RISC-V MCU and other peripherals. There is a second
> audio PLL, but no bus clock dividers. The BSP driver uses the 24MHz main
> oscillator as the parent for all the bus clocks. But the diagram
> suggests busses from the other PRCM are used in this block as well.
>=20
> Add a driver to support this part. Unlike the BSP driver, the SoC's main
> MBUS clock is chosen as the parent for the MCU MBUS clock, and the
> latter then serves as the parent of the MCU DMA controller's MBUS clock.
> The bus gate clocks also use their respective bus clocks as parents
> according to the system bus tree diagram. In cases where a block does
> not appear in that diagram, an educated guess is made.
>=20
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> ---
> Changes since v1:
> - Added comment for "fixed" dividers in audio PLL clock
> - Corrected variable names for audio PLL divider clocks
> - Added comment for the reversed order of some of the DSP clock's
>   parents when compared to the manual
> - Added comments for clocks and resets only found in the BSP driver
> - Corrected register offset for i2s3-asrc and bus-mcu-pwm0 clocks
> - Made "r-ahb" and new "r-apb0" external bus clocks the parents of the
>   bus gate clocks, with comments if guessed which one applies
> - Moved .num_clks to after the list of clocks, making it obvious that
>   the value needs to be added if more clocks are added to the list

Reviewed-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej



