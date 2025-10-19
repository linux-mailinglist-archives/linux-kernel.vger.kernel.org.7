Return-Path: <linux-kernel+bounces-859716-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 70B7FBEE664
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Oct 2025 16:11:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D2295189C5DB
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Oct 2025 14:11:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5DA02EA756;
	Sun, 19 Oct 2025 14:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MxDe+MS1"
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 672F81917D6
	for <linux-kernel@vger.kernel.org>; Sun, 19 Oct 2025 14:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760883066; cv=none; b=k7+tnUvu9wKdGXfL7RAmy2FYrdZaoNe3VjOcSCbEstn4OzATXjcy9Z9CyEzT193WlT1urE0Lswk9eA1zvmRHYYY+oV5Fb6T2WCcFxWTSYyDgmVxUiK3wlCb9fLFNsv1b7Gi35llcvCElREM1i4+ZFxbn9KCe/NDmp9EX1rSkPmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760883066; c=relaxed/simple;
	bh=it+q/FObsEAhAZZ2vNLVO3G/aVzDgKMtLAKtWKs2Zv0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XKtd8JWsJIsmG3NGD343e/OUxBp5Ufnf0T3KCMPqpCK0aM1eMADlBiTi3bQwx+f8ktMGczlpG5rGRRkt534MKVMz6XZFAiR/HbHdqAiEFOkyD3F3eh00EjzPW2kX4EHT7Epst0kZoHiU/AFQjtSpJlofmh8FAPVxUFpfkhF66Lg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MxDe+MS1; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-426fc536b5dso1918785f8f.3
        for <linux-kernel@vger.kernel.org>; Sun, 19 Oct 2025 07:11:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760883063; x=1761487863; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RAuT2pXiG6Soqv7ocY7dz20OVZgzWenocYDje/sN0xQ=;
        b=MxDe+MS1GBL7couXI5zK/JOaaY+Z23z+yjl5wxBHV2bG0p0irEdw70yuD8dmzlUpXX
         MVuYOYKsVxdMo97HRgkzVST/FrWRqUzAiJq2qJLd61vgWOWezMCUvxZ8/71HnNmYpB8u
         TwostWJ4591Q3fHWg7MjBWxX/dBsvj8D1bZHr3vDmaQFM3K400lfOXnxDm32ijk//gNe
         tIFeGNi16n6g6x0tk95Tn6v1MLFZwtvuzZnNnE0DSUUqoUEyEv68AZHufwurXqKvswFv
         pSCzoohoXbmJp2IMOJUI795c9Z/3hhPc2yt8N92mRiyVjcRAjUb9n66ohpGMpUJGh6kg
         j0Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760883063; x=1761487863;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RAuT2pXiG6Soqv7ocY7dz20OVZgzWenocYDje/sN0xQ=;
        b=mGgDHN/BBlcHWX9D1DPBJTrWfV9k8C+YWlBOklZjYZyGSIh7rGxD/KOINKxThnre/F
         49ORcMJUxCPvaUA8IUXIEMD0X89XgTifzeFb8AUS3NuqjvCpLFIyTs0C9p2dt3c98ggR
         8JAtZECCj9ag1HB6cNjspy4I7iY9xcWVLxz0cgQGGVztKR9TRYaprO25M7+gYX+Bag8C
         eSpWMYdBUrTj5jGfiV+9jZGYW89GbN25y6FU7rTDD7OHPgBzAXFcNjtHXuUcIQ+R2SGt
         0PsAdREsRNgFQemTYppi5qaZ/i9NGjdDjvPSti+WXKwESHDrqC2EcTogwZ5rK5X19b55
         Qn7Q==
X-Forwarded-Encrypted: i=1; AJvYcCVAwbiD0vlEfTe7jBP14hGsPaelgccoJgVn8AjcBgfydUId4etPmyJCMaKHRr60MPSsts2RV8dlUeAi4kA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyM54pi3lIOOgjgSTj0X0qsrkT5yqSKvr47+P/84b0VjouUS5gk
	iXY3SFcvjCoFuAJymwi3mJDKjsvM0YrI/UcAYLrRsDOK81y9TE/1XZW7
X-Gm-Gg: ASbGncsMMXdiTC7gGm5zVVKJagksyGbSALi0u2irXqkkK3Ld9VjItSIOwfiV4O0o95A
	1rz8zpOXGlUtYu5RHetndsApQBhJ/5i5NIu5sfCivdxNX6nbei1AkfAtRdXSnbVBlPUj9bWBCfS
	3Dv2pqk57z3n+YL+WuPL5FWUVGzeMb7F3/u6DOltSoDaHjiR1toFGFNko7DYfTumbnu0C4qEz1i
	KJLbqqfsrWZQyjL4hXIVdo7ZQWYmAVt0FxphJOAvw7tFZtn7u1Z/YYUyZsdjcwtV8D305GJDY9f
	Kt0ArVv7CFq+JkdcBr7Ma6p5RwHGYmDEJXXfAYRg8k4vbp0z93sqwbp19eXduL5lvoK/VpK12h2
	LMo5Ab4YsRFnORw2JQspUoExN+bAVUxiNndVlmhqkUopmrFkOUbHw8abaN6WB9F8PE2xqrxu6r4
	9aDcOe8X9fEAQghdlrq2iqlScBSiMMwJknLiuPrioW0gtK5dBD8zAc
X-Google-Smtp-Source: AGHT+IFUF5/TTFssGAjekhetDDv4LHWcFbL+ak9eq8410dO2fCieGGRn/c440tmYDt+ZI13D1UdhSg==
X-Received: by 2002:a5d:64e4:0:b0:3ec:dd26:6405 with SMTP id ffacd0b85a97d-42704d900edmr7404769f8f.26.1760883062419;
        Sun, 19 Oct 2025 07:11:02 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-427f00ba01bsm10225334f8f.41.2025.10.19.07.11.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Oct 2025 07:11:02 -0700 (PDT)
Date: Sun, 19 Oct 2025 15:10:59 +0100
From: David Laight <david.laight.linux@gmail.com>
To: =?UTF-8?B?VGjDqW8=?= Lebrun <theo.lebrun@bootlin.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Nicolas Ferre <nicolas.ferre@microchip.com>, Claudiu
 Beznea <claudiu.beznea@tuxon.dev>, Richard Cochran
 <richardcochran@gmail.com>, Russell King <linux@armlinux.org.uk>,
 netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Vladimir Kondratiev
 <vladimir.kondratiev@mobileye.com>, Tawfik Bayouk
 <tawfik.bayouk@mobileye.com>, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>, =?UTF-8?B?R3LDqWdvcnk=?= Clement
 <gregory.clement@bootlin.com>, =?UTF-8?B?QmVub8OudA==?= Monin
 <benoit.monin@bootlin.com>, Maxime Chevallier
 <maxime.chevallier@bootlin.com>
Subject: Re: [PATCH net-next 11/15] net: macb: replace min() with umin()
 calls
Message-ID: <20251019151059.10bb5e18@pumpkin>
In-Reply-To: <20251014-macb-cleanup-v1-11-31cd266e22cd@bootlin.com>
References: <20251014-macb-cleanup-v1-0-31cd266e22cd@bootlin.com>
	<20251014-macb-cleanup-v1-11-31cd266e22cd@bootlin.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 14 Oct 2025 17:25:12 +0200
Th=C3=A9o Lebrun <theo.lebrun@bootlin.com> wrote:

> Whenever min(a, b) is used with a and b unsigned variables or literals,
> `make W=3D2` complains. Change four min() calls into umin().

It will, and you'll get the same 'error' all over the place.
Basically -Wtype-limits is broken.

Don't remove valid checks because it bleats.

	David


>=20
> stderr extract (GCC 11.2.0, MIPS Codescape):
>=20
> ./include/linux/minmax.h:68:57: warning: comparison is always true due
>                           to limited range of data type [-Wtype-limits]
>    68 | #define __is_nonneg(ux) statically_true((long long)(ux) >=3D 0)
>       |                                                         ^~
> drivers/net/ethernet/cadence/macb_main.c:2299:26: note: in expansion of
>                                                             macro =E2=80=
=98min=E2=80=99
>  2299 |              hdrlen =3D min(skb_headlen(skb), bp->max_tx_length);
>       |                       ^~~
>=20
> Signed-off-by: Th=C3=A9o Lebrun <theo.lebrun@bootlin.com>
> ---
>  drivers/net/ethernet/cadence/macb_main.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ether=
net/cadence/macb_main.c
> index 98e28d51a6e12c24ef27c939363eb43c0aec1951..6c6bc6aa23c718772b95b398e=
807f193a38e141a 100644
> --- a/drivers/net/ethernet/cadence/macb_main.c
> +++ b/drivers/net/ethernet/cadence/macb_main.c
> @@ -2035,7 +2035,7 @@ static unsigned int macb_tx_map(struct macb *bp,
>  		count++;
>  		tx_head++;
> =20
> -		size =3D min(len, bp->max_tx_length);
> +		size =3D umin(len, bp->max_tx_length);
>  	}
> =20
>  	/* Then, map paged data from fragments */
> @@ -2045,7 +2045,7 @@ static unsigned int macb_tx_map(struct macb *bp,
>  		len =3D skb_frag_size(frag);
>  		offset =3D 0;
>  		while (len) {
> -			size =3D min(len, bp->max_tx_length);
> +			size =3D umin(len, bp->max_tx_length);
>  			entry =3D macb_tx_ring_wrap(bp, tx_head);
>  			tx_skb =3D &queue->tx_skb[entry];
> =20
> @@ -2301,7 +2301,7 @@ static netdev_tx_t macb_start_xmit(struct sk_buff *=
skb, struct net_device *dev)
>  			return NETDEV_TX_BUSY;
>  		}
>  	} else
> -		hdrlen =3D min(skb_headlen(skb), bp->max_tx_length);
> +		hdrlen =3D umin(skb_headlen(skb), bp->max_tx_length);
> =20
>  #if defined(DEBUG) && defined(VERBOSE_DEBUG)
>  	netdev_vdbg(bp->dev,
> @@ -4573,8 +4573,8 @@ static int macb_init(struct platform_device *pdev)
>  	 * each 4-tuple define requires 1 T2 screener reg + 3 compare regs
>  	 */
>  	reg =3D gem_readl(bp, DCFG8);
> -	bp->max_tuples =3D min((GEM_BFEXT(SCR2CMP, reg) / 3),
> -			GEM_BFEXT(T2SCR, reg));
> +	bp->max_tuples =3D umin((GEM_BFEXT(SCR2CMP, reg) / 3),
> +			      GEM_BFEXT(T2SCR, reg));
>  	INIT_LIST_HEAD(&bp->rx_fs_list.list);
>  	if (bp->max_tuples > 0) {
>  		/* also needs one ethtype match to check IPv4 */
>=20


