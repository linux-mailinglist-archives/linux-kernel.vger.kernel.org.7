Return-Path: <linux-kernel+bounces-815169-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95ECCB56080
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Sep 2025 13:31:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0C4BE7A7B1F
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Sep 2025 11:29:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9B9D2EC085;
	Sat, 13 Sep 2025 11:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AfN419yu"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD1022550CA
	for <linux-kernel@vger.kernel.org>; Sat, 13 Sep 2025 11:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757763075; cv=none; b=eafBEHmbXujqKTToeJlvXjUYzNMUXFBrBlzszXFyDBsnQB2b88OB/fsPg5NYR/EBYLOaZzJ0BKJHurGneWHVR0FCEX2l+bdR14NKVd6VdnNm0VE5ZmGi8h+OpxhP1KJIG4Je0bo+YwNHnBD7tbcvO3eynNTySJSvMGN2GoVQk0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757763075; c=relaxed/simple;
	bh=Bgi/LtOZegcBC2paPEdpNuoA8uNY2waphFWpS0NN/k0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qhWNlanfoLIZt+wg2oc9f6QYblgw48kaBqg2FSFscsEylS7VahwYZV8j55y60WiMPpDcmTGHsL7XEDgS20OGo57H1YvqxZ1ErCNwsVMdZFCaKFLaZjv3vIoIKtGs4T0XdcsJTSnQKF5SaGc955lEJu3Yhpk6a4vo8Q4ODx9pEPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AfN419yu; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-b0787fc3008so395287366b.3
        for <linux-kernel@vger.kernel.org>; Sat, 13 Sep 2025 04:31:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757763072; x=1758367872; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BbaWkghAVJNKzBV/Fp3pj0pkQCQlDE9HrxdJcUrmDgM=;
        b=AfN419yuohMKYMdIU+2No/QLVzEgG82Gic+xV7MzrB6aoCbo/w7+YBbtz0YAOFwmsg
         Y8Lc9uQiwK7zL2iBUdH1hQP6Nej/c9CXsBbWV6P046hYnLthb0Sv/9bxvTvT37W2ab7t
         HwiM7ZOXZ43IFSzDeUm93wRST6COFetO2L4FLKUTqahctcqjyu0YZK+tXTds1HiyL36E
         YoZ2KbH4Z+88du3scCDCwXIPVUhUhJdDzfGfihzInlrPfP2+vgG5gqbYJeBcbvQ6cNEr
         J27sLZ4lIfg5vRaBCZQ8ZbxBaAMMHY8Iu3MIGRufGYCuHb2CiuEKylF9bV/rMYxYHv9z
         ESAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757763072; x=1758367872;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BbaWkghAVJNKzBV/Fp3pj0pkQCQlDE9HrxdJcUrmDgM=;
        b=vMhTMXK+GB4kGi+o8bk67H67+V+EP3Zi7Q1Ap+LLylCl0kYVtQN71fo5NoJ+GQ5uqu
         +GXInUVNOmS80tzSyjcsddFfvD480g8GIVY5JKqgnYj1b5s+i3/ptgIIg05WuxHdCQTw
         yPCzv/nyF7Zl+UAM3Li9xoGgnJrCCuuAERR7KfgLl84fLPFqGEsm2gn+zjAG1aClmOfU
         jOzrjlmNu0YgNt+a9quEiPRlE+WmWqmgEl29BQ2OyBp665kNnL8llxBZhFCFlM3rMJEy
         ClVxeXjWq9vrtvDA53FsOJ7VAnepkB3SWU7XgENaL046VR5BL02jjPLdNGokrm3a1D/d
         2lPg==
X-Forwarded-Encrypted: i=1; AJvYcCXUqNSBA6p4lzwzwIz7N+kbUt/SgxZr3ZNUDZHv7u6qac9x/LUpMwSWigE557gkJIKTp6eLmbGWJi/10OE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFYFkUhYdFIDwEb0cTRWgyPoWU9IOh61RsZQXHu4A2BcnRQxB0
	lsXloVb03lzBv0af6pUSYzBKaIsyL6p+yl3bFf/kNSoNXEaJ0DK3JB9r
X-Gm-Gg: ASbGncs5izFZg/a2GUg/mzJZCXlJ1s5rtzLXnmUyLXrWv9R1gS9BqFKEf5vhCtm/kS8
	cLjVi1fosWTlCNyVOX98ogUyIr8pv/watp/JlFTle4iygUNEllT4hw+Bb4u3dte8GXmk4GDyXnw
	A+FR8ftkG0ZliskNdazJQ/tY7uOXkv8mJjMmhdTVdOhI7IIg98v30wvrD9ZUMjXTbG+JN1Bd9NZ
	WRiiHaM3YPhbXbBJLj5FApdG2OJTwa6kRQWZ/8+ANcU2hUoTMz4JPZvosmBpNgCxao8Z6slKtyF
	JgHyuwimbGVu/El6zvtE7NPwr9WUy5DCwziq7nf9RsT1CawrIzuB3HobAGxgMb4oPH0r+lpsDDm
	T4s8SyRv3UJbaYVhTzq1o+LfV83z2xIsqxC5fndMbEEAyv5pdWXejBd4=
X-Google-Smtp-Source: AGHT+IGo8CziTZlFFDXaGrQNSM6imSKcLrT5E0r4aNs8WHUFIZfpN9rTwSz+1wD/ImFHnj2/i6E30Q==
X-Received: by 2002:a17:906:ca56:b0:b07:cd08:ff34 with SMTP id a640c23a62f3a-b07cd08ffe4mr358053766b.51.1757763072002;
        Sat, 13 Sep 2025 04:31:12 -0700 (PDT)
Received: from jernej-laptop.localnet ([188.159.248.16])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b07b30da327sm560756966b.11.2025.09.13.04.31.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Sep 2025 04:31:11 -0700 (PDT)
From: Jernej =?UTF-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To: Chen-Yu Tsai <wens@csie.org>, Jernej Skrabec <jernej@kernel.org>,
 Samuel Holland <samuel@sholland.org>,
 Andre Przywara <andre.przywara@arm.com>, Chen-Yu Tsai <wens@kernel.org>
Cc: linux-sunxi@lists.linux.dev, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject:
 Re: [PATCH 2/3] arm64: dts: allwinner: t527: avaota-a1: hook up external 32k
 crystal
Date: Sat, 13 Sep 2025 13:31:09 +0200
Message-ID: <4676490.LvFx2qVVIh@jernej-laptop>
In-Reply-To: <20250913102450.3935943-2-wens@kernel.org>
References:
 <20250913102450.3935943-1-wens@kernel.org>
 <20250913102450.3935943-2-wens@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

Dne sobota, 13. september 2025 ob 12:24:49 Srednjeevropski poletni =C4=8Das=
 je Chen-Yu Tsai napisal(a):
> From: Chen-Yu Tsai <wens@csie.org>
>=20
> When the board was added, its external 32.768 KHz crystal was described
> but not hooked up correctly. This meant the device had to fall back to
> the SoC's internal oscillator or divide a 32 KHz clock from the main
> oscillator, neither of which are accurate for the RTC. As a result the
> RTC clock will drift badly.
>=20
> Hook the crystal up to the RTC block and request the correct clock rate.
>=20
> Fixes: dbe54efa32af ("arm64: dts: allwinner: a523: add Avaota-A1 router s=
upport")
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>

Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej

> ---
>  arch/arm64/boot/dts/allwinner/sun55i-t527-avaota-a1.dts | 8 ++++++++
>  1 file changed, 8 insertions(+)
>=20
> diff --git a/arch/arm64/boot/dts/allwinner/sun55i-t527-avaota-a1.dts b/ar=
ch/arm64/boot/dts/allwinner/sun55i-t527-avaota-a1.dts
> index 535387912d9b..054d0357c139 100644
> --- a/arch/arm64/boot/dts/allwinner/sun55i-t527-avaota-a1.dts
> +++ b/arch/arm64/boot/dts/allwinner/sun55i-t527-avaota-a1.dts
> @@ -354,6 +354,14 @@ &r_pio {
>  	vcc-pm-supply =3D <&reg_aldo3>;
>  };
> =20
> +&rtc {
> +	clocks =3D <&r_ccu CLK_BUS_R_RTC>, <&osc24M>,
> +		 <&r_ccu CLK_R_AHB>, <&ext_osc32k>;
> +	clock-names =3D "bus", "hosc", "ahb", "ext-osc32k";
> +	assigned-clocks =3D <&rtc CLK_OSC32K>;
> +	assigned-clock-rates =3D <32768>;
> +};
> +
>  &uart0 {
>  	pinctrl-names =3D "default";
>  	pinctrl-0 =3D <&uart0_pb_pins>;
>=20





