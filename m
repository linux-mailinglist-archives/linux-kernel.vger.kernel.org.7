Return-Path: <linux-kernel+bounces-877786-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 671EDC1F05A
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 09:39:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0916D4E84A9
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 08:38:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB62C337110;
	Thu, 30 Oct 2025 08:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="NEhp79xA"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFEC731A7FD
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 08:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761813515; cv=none; b=nseW1jTGFvm3dpildL+AIfcaaNI13zGtStQzQJZTPJ8itWEwHCSsiXQCSL/0Xx3PiEoh+w42x3nD/SV6aMaksjW6krb2uj6a7R18AIjxwxrHm3X/m2gBmGhWEOqyxNWNRr6iPQDadA/MYXb1EFD1JqZsVwfhXypYsjYU/JDemOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761813515; c=relaxed/simple;
	bh=bnNftVFQXjZyorc7GhSgaJgVkTxOej4kNzmLyM/0BFc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=tnCXGx2uAM6bJCbevzvhdUGJFeKyaJgsJNlpaXsYxs+y/aSyC3Ut6a7Ir8WxA28p6EEkx0VxgumxwQWc2BQh3RDJTh8VpFjum2htLeVxZ8d9LscLddxXM70XtyGrKzQhwmW5zNLFRxJoGWvQcjHuwfbr5JRnej+8jHDUQmvyL5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=NEhp79xA; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4710683a644so7936015e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 01:38:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1761813511; x=1762418311; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:user-agent
         :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XcL62a5hHqNXI6ber/2x37lX4UAGBk2bkZQAgf4AoSc=;
        b=NEhp79xAd0iAjDFjO5YTzMftMB9ckkilT0Gc8et7EXpXW2JPuCI+XA0qz2d2l9WEzj
         PCH7wAl9B0XitUGRzIMsx4iNnPRdgqLqUpJPZSMwEjMWFBpB3k2M8wiyryXEL0tiMXtp
         9Pg2aZ0cFjdJc8h7DD/Op+QWcoC5cMOQusTqtMd0kNIXZf3PgtB5gzPVbl1a0trZdB0R
         0SoQJkZaMbdgyv1M3r/zcOhRygmlplIdJb668dgjbGQHjsidHLlRoNw/xFG5946JXRn0
         YHrW1uclW4luDj1TrOhtHrO4c6sCxThoFIW0g/WfFwwZIMiZEzdB6aKZPf9jQfwLn9fA
         HBjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761813511; x=1762418311;
        h=content-transfer-encoding:mime-version:message-id:date:user-agent
         :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XcL62a5hHqNXI6ber/2x37lX4UAGBk2bkZQAgf4AoSc=;
        b=rtWIzNcLR452EyQMOP/O342Wx+/gBDsCY8kxXRTV2f08+rSng5pH5Yq2oap/ufkMCJ
         TU+pOHK4CxUO6YOpvZlkX8L/OdBQL66WNJdZ0SzH0hwZkJ9PxvZSwP/2uYCtiK3ed74K
         HMc0n5S82h0tPHe/9NWkYXFA6fvdIdFOma//Ve/0ckRHuJmQE/mt5ywPUA55PxzQDb1n
         +AzbfnAN6QPvmABJnFsASfLgPnZkYIo/8Ckqcsmo4r/t028d22QGRU4FTW7wNQqSCI8U
         L4mN36+hsXgCukmGyJyLrf3qvB8i42o4BZvf0YPwRSCN/yE5jA/ylYGkw0411ON2XtPo
         nDHg==
X-Forwarded-Encrypted: i=1; AJvYcCWYKLqcJxbS2KTkBlgsAEnXEbJjXMqYMn/+Qa8Ll131tp139Ba543c+n5tGHEqTnh2U7OoqjkA4zHwMKy0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2F6fzF2wYDnstNBR+jXjVEI3ENxaMOpXTcbddKkn0rvk+hISb
	XImoxHES82Em2T08UVhbKxYUJqZ8AmzlUac6YGLkVDJ7cF6Dx3xyTVah7jeielfciZo=
X-Gm-Gg: ASbGncvvUiQavUw0oRbglzguCyo4mslF7zq0rtlTk0pdkX/TzbXtSUoM7eNDyNLCl59
	XVfdRy8m24QmmQQCEUtJF0TYpJFyFJYCzQ5EXwk/n3xaVn3qJtoGHhjIliObCFZ94UNomNclV3L
	q9N5oVZ26RX7OdK6a4dReBrfomc7vdMvWsJAgsKPzTf/qBEZovjn7/jkKq87leUGc8yHJMxLkP6
	DPLqtSSF/a1QYEmgGM0bYjmN/qzOAn+mF3AD/6XQP9e22260N5sGUx013R/d0ybbU/g+wm+CTpx
	1jxBsd11MeRkmfMShjod3HA62OKDaetJJ/ATPlBPATAk3QiIyvAFTSeK5hs4g5nQV16Dwv4svAD
	Gxw9izHRdEAfMZClGIxpeWZ56ZWxJH6SjtomzcThzO9LfvIaQ4WpkaO7q9Tjfj4UXi/Gw4iqefb
	l0tTuI6X+M
X-Google-Smtp-Source: AGHT+IGaIha2nuoz8jrt+cE5pgI+VJzm+ijZNjpXMyU/F0fQvHyvDhStIYNXWfm/PBDpohWawi3FOQ==
X-Received: by 2002:a05:600c:44c9:b0:477:11a0:b746 with SMTP id 5b1f17b1804b1-47726239d25mr15315075e9.6.1761813510964;
        Thu, 30 Oct 2025 01:38:30 -0700 (PDT)
Received: from localhost ([2a01:e0a:3c5:5fb1:64bd:9043:d05:7012])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-477289a57fdsm26741525e9.7.2025.10.30.01.38.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Oct 2025 01:38:30 -0700 (PDT)
From: Jerome Brunet <jbrunet@baylibre.com>
To: Chuan Liu via B4 Relay <devnull+chuan.liu.amlogic.com@kernel.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,  Michael Turquette
 <mturquette@baylibre.com>,  Stephen Boyd <sboyd@kernel.org>,  Kevin Hilman
 <khilman@baylibre.com>,  Martin Blumenstingl
 <martin.blumenstingl@googlemail.com>,  chuan.liu@amlogic.com,
  linux-amlogic@lists.infradead.org,  linux-clk@vger.kernel.org,
  linux-arm-kernel@lists.infradead.org,  linux-kernel@vger.kernel.org,
  da@libre.computer
Subject: Re: [PATCH v2 4/5] clk: amlogic: Optimize PLL enable timing
In-Reply-To: <20251030-optimize_pll_driver-v2-4-37273f5b25ab@amlogic.com>
	(Chuan Liu via's message of "Thu, 30 Oct 2025 13:24:14 +0800")
References: <20251030-optimize_pll_driver-v2-0-37273f5b25ab@amlogic.com>
	<20251030-optimize_pll_driver-v2-4-37273f5b25ab@amlogic.com>
User-Agent: mu4e 1.12.9; emacs 30.1
Date: Thu, 30 Oct 2025 09:38:29 +0100
Message-ID: <1ja518zsvu.fsf@starbuckisacylon.baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Thu 30 Oct 2025 at 13:24, Chuan Liu via B4 Relay <devnull+chuan.liu.amlo=
gic.com@kernel.org> wrote:

> From: Chuan Liu <chuan.liu@amlogic.com>
>
> l_detect controls the enablement of the PLL lock detection module.
> It should remain disabled while the internal PLL circuits are
> reaching a steady state; otherwise, the lock signal may be falsely
> triggered high.
>
> Before enabling the internal power supply of the PLL, l_detect should
> be disabled. After the PLL=E2=80=99s internal circuits have stabilized,
> l_detect should be enabled to prevent false lock signal triggers.

You to reformat this description. It feel that both paragraph are saying
the same thing.

>
> Currently, only A1 supports both l_detect and current_en, so this
> patch will only affect A1.
>
> Signed-off-by: Chuan Liu <chuan.liu@amlogic.com>
> ---
>  drivers/clk/meson/clk-pll.c | 28 +++++++++++++++-------------
>  1 file changed, 15 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/clk/meson/clk-pll.c b/drivers/clk/meson/clk-pll.c
> index 6c794adb8ccd..c6eebde1f516 100644
> --- a/drivers/clk/meson/clk-pll.c
> +++ b/drivers/clk/meson/clk-pll.c
> @@ -383,36 +383,38 @@ static int meson_clk_pll_enable(struct clk_hw *hw)
>  	if (MESON_PARM_APPLICABLE(&pll->rst))
>  		meson_parm_write(clk->map, &pll->rst, 1);
>=20=20
> +	/* Disable the PLL lock-detect module */
> +	if (MESON_PARM_APPLICABLE(&pll->l_detect))
> +		meson_parm_write(clk->map, &pll->l_detect, 1);
> +
>  	/* Enable the pll */
>  	meson_parm_write(clk->map, &pll->en, 1);
>  	/* Wait for Bandgap and LDO to power up and stabilize */
>  	udelay(20);
>=20=20
> -	/* Take the pll out reset */
> -	if (MESON_PARM_APPLICABLE(&pll->rst))
> -		meson_parm_write(clk->map, &pll->rst, 0);

Why is the reset moving around ? nothing is said in the description about
that

> -
> -	/* Wait for PLL loop stabilization */
> -	udelay(20);
> -
>  	/*
>  	 * Compared with the previous SoCs, self-adaption current module
>  	 * is newly added for A1, keep the new power-on sequence to enable the
>  	 * PLL. The sequence is:
> -	 * 1. enable the pll, delay for 10us
> +	 * 1. enable the pll, delay for 20us
>  	 * 2. enable the pll self-adaption current module, delay for 40us
>  	 * 3. enable the lock detect module
>  	 */
>  	if (MESON_PARM_APPLICABLE(&pll->current_en)) {
> -		udelay(10);
>  		meson_parm_write(clk->map, &pll->current_en, 1);
> -		udelay(40);
> +		udelay(20);
>  	}
>=20=20
> -	if (MESON_PARM_APPLICABLE(&pll->l_detect)) {
> -		meson_parm_write(clk->map, &pll->l_detect, 1);
> +	/* Take the pll out reset */
> +	if (MESON_PARM_APPLICABLE(&pll->rst))
> +		meson_parm_write(clk->map, &pll->rst, 0);
> +
> +	/* Wait for PLL loop stabilization */
> +	udelay(20);
> +
> +	/* Enable the lock-detect module */
> +	if (MESON_PARM_APPLICABLE(&pll->l_detect))
>  		meson_parm_write(clk->map, &pll->l_detect, 0);
> -	}
>=20=20
>  	if (meson_clk_pll_wait_lock(hw)) {
>  		/* disable PLL when PLL lock failed. */

--=20
Jerome

