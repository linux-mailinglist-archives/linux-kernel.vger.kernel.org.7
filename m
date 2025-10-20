Return-Path: <linux-kernel+bounces-861472-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 953D9BF2CEC
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 19:52:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4F9354ECA13
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 17:52:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E1463321C6;
	Mon, 20 Oct 2025 17:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j87a7Qnr"
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A6FF2673B7
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 17:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760982745; cv=none; b=qLNxQ6f77JNMjFAJHQq76HTVgkCnkIZ/NZvtyk4g3S4/3G57ILsITmCl7719e8qjX/LLd6HU6B1kQ6olZyxew37Px7ZkYr2Bd/xeJFlSB4WA8RQHpyEpqEWTgnJaOb+jWVKqtSZhGZWG6g2+JI4k1kaQL04XDWxDlKw2o8zjOpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760982745; c=relaxed/simple;
	bh=pdYHJcuACjLxyUbGtQJb6l+Qo8ulOoDOXrsmHol9Lt0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KQhjsWtDIN0qapR3xeLSbrPZ543Hm8d3aJbMR+u4KHKmTPN06vudVay7Fgrxkv+aBIZZRA9Y47Xz7aQvzq9+GG4DxXcGaIYxNoaBPULfBee7hiclETF5hG26jHZtSyixrzO1Yev5bbMZGFZiXKsjJWCt8KDzfobpf02XoDHOkt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j87a7Qnr; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3f99ac9acc4so227010f8f.3
        for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 10:52:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760982743; x=1761587543; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0hPztYo4gHaE9LtG99gGwWjUyFltd44jOHvoR42cvBk=;
        b=j87a7QnrHSHjFhEFTU4teGZPeNQZlfIdzR1xQC8IjN9UPQSSXbpPCoTiiORv/5M26V
         XNeT9wtRjLDR26FEUpBkuYN8XedK6vEidP1psmaUBKW/DyQeDl/b1RiGH5zam0iNotsB
         OfHnoVm3xQx1F0ZKp84uPJyBTt/8rtkJDDiAZeVowPp+iQes2QMZBZizY5s2KYWqKKGy
         prGE+BCJv10yntaNtHknE5Z2ZudkCnDGH8Pu6aVvi3Zz+iacwJG8Opi1/3BVO4DF4cpi
         vvQAzIDEcUZm1DFY8pIuw4yLsSr4Eo7Pcpszdpe7ABCnq1T5zMIFqjpRtLgDsWaItaNt
         VX4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760982743; x=1761587543;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0hPztYo4gHaE9LtG99gGwWjUyFltd44jOHvoR42cvBk=;
        b=b8D8rkU423ZYvkc/eCgCSmGxqJvWhhk6D8YjWROjpjJsQLySWoOf1/A1SyAyqhHNp4
         +4QjqAHg1ltIqSJSKWZ3JfU3z8edc6jIKkZx+VWLgXI5nJiI/DgbICCa/QTeT7K640DS
         jY5CkuwQ0j7I5jJXgLnbQPxP+r1bQSbQDxa202z1kxI/EJneZDHUvgyPvv7EA5UISUOF
         FShLlajFrk8qlQkah7themFcmJyVWekRWlqa3l4nkfn29zukNNlQl+KrFbOlzDUrO2WY
         uI3uC28xMiKaM4on521VQVXiWYKb1OG5lcX4NqNLB7a+wtZPt+sty5eKD63RZWad6DlZ
         MrTg==
X-Forwarded-Encrypted: i=1; AJvYcCVoUe+yc9Kn+f49hR1pf+9dBE7q/LuR2AKoNsGGDzX8W/gzd4DkVHOWomcQme1gnHt0K/A2qZ8i/Ic0TNg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQl6U/utVGUaGBVGb800W3RegcRb7khctyTCBQuEhFNOkmshBx
	AVUphXfsKvsguheMe40H9v/1bkcJOBKmynO2pzrzKaEtBqrKxxM/YRcx
X-Gm-Gg: ASbGncsLYYDifqSZ1N/r1nsPy5i2lkh0LvUijsdE4rckmxd7fpe7iXJ7L3g1RwosYEt
	LnI4tTjwWG9cZhRgJPyoqn38uxWHM4LGwPaKNx4m9xrKwQ9UpCYp3CSDm/lEEZn34mKa7E29rub
	AX9bAJREzOMvSJ6J2ZpPfOOIdfqK4L5iuSKElYijucF6I9IV4bAAmvmIBVVLYD+yLdj1T/HzS1e
	uNMjrOD+IaetWAslJo8tLaBvihNLfDzOTXYyL6mb4j/RD9rahPqSgXJM/xFkoCpsqm1ySHqfSS+
	IMbeQiGkZFIWcC7FYLeJEdmpfX8p85D6ukv+6pLHMpXTMWKLqnMdSPU3rTsi4Z8eEA/j7yzMJCB
	Cd+vs0nYVfpn7ZMAUlPqJwrtGgD9UP6LQMEvhcEhP3XqKeZhvHMSFuD1rxS/23yOoC/estrYpLj
	yIVRnQoMkYDRlIkOPWYhRDIQcV4ievurDZKwef0doIQpnteRCZ0tnBU2QNC91kRsh+jnD7n0jbJ
	CIQWQ==
X-Google-Smtp-Source: AGHT+IGEpXcGziVc/IPeVNYdyzKmZC+YRn2Z3nf2tImqr8LtU1jXE0yH1+EHM8IBNjLdRoUankugUA==
X-Received: by 2002:a05:6000:26d2:b0:3e6:f91e:fa72 with SMTP id ffacd0b85a97d-42704d83dfdmr8290390f8f.7.1760982742464;
        Mon, 20 Oct 2025 10:52:22 -0700 (PDT)
Received: from jernej-laptop.localnet (178-79-73-218.dynamic.telemach.net. [178.79.73.218])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-427ea5b3c34sm16222568f8f.17.2025.10.20.10.52.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Oct 2025 10:52:22 -0700 (PDT)
From: Jernej =?UTF-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To: Chen-Yu Tsai <wens@kernel.org>, Jernej Skrabec <jernej@kernel.org>,
 Samuel Holland <samuel@sholland.org>, Mark Brown <broonie@kernel.org>,
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Vinod Koul <vkoul@kernel.org>, Chen-Yu Tsai <wens@kernel.org>
Cc: linux-sunxi@lists.linux.dev, linux-sound@vger.kernel.org,
 linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 devicetree@vger.kernel.org, dmaengine@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject:
 Re: [PATCH 06/11] clk: sunxi-ng: sun55i-a523-ccu: Lower audio0 pll minimum
 rate
Date: Mon, 20 Oct 2025 19:52:20 +0200
Message-ID: <8591609.T7Z3S40VBb@jernej-laptop>
In-Reply-To: <20251020171059.2786070-7-wens@kernel.org>
References:
 <20251020171059.2786070-1-wens@kernel.org>
 <20251020171059.2786070-7-wens@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

Dne ponedeljek, 20. oktober 2025 ob 19:10:52 Srednjeevropski poletni =C4=8D=
as je Chen-Yu Tsai napisal(a):
> While the user manual states that the PLL's rate should be between 180
> MHz and 3 GHz in the register defninition section, it also says the
> actual operating frequency is 22.5792*4 MHz in the PLL features table.
>=20
> 22.5792*4 MHz is one of the actual clock rates that we want and is
> is available in the SDM table. Lower the minimum clock rate to 90 MHz
> so that both rates in the SDM table can be used.

So factor of 2 could be missed somewhere?

>=20
> Fixes: 7cae1e2b5544 ("clk: sunxi-ng: Add support for the A523/T527 CCU PL=
Ls")
> Signed-off-by: Chen-Yu Tsai <wens@kernel.org>

Reviewed-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej

> ---
>  drivers/clk/sunxi-ng/ccu-sun55i-a523.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/clk/sunxi-ng/ccu-sun55i-a523.c b/drivers/clk/sunxi-n=
g/ccu-sun55i-a523.c
> index acb532f8361b..20dad06b37ca 100644
> --- a/drivers/clk/sunxi-ng/ccu-sun55i-a523.c
> +++ b/drivers/clk/sunxi-ng/ccu-sun55i-a523.c
> @@ -300,7 +300,7 @@ static struct ccu_nm pll_audio0_4x_clk =3D {
>  	.m		=3D _SUNXI_CCU_DIV(16, 6),
>  	.sdm		=3D _SUNXI_CCU_SDM(pll_audio0_sdm_table, BIT(24),
>  					 0x178, BIT(31)),
> -	.min_rate	=3D 180000000U,
> +	.min_rate	=3D 90000000U,
>  	.max_rate	=3D 3000000000U,
>  	.common		=3D {
>  		.reg		=3D 0x078,
>=20





