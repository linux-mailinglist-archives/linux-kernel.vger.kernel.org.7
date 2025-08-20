Return-Path: <linux-kernel+bounces-777262-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 916DAB2D78D
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 11:09:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 47D771BA1441
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 09:06:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 966A22D9EE2;
	Wed, 20 Aug 2025 09:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="vCbsK1rK"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C55F18991E
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 09:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755680774; cv=none; b=MMHvIrqw8gCjUIaqOU9xGAVgn14IoIXmRzM/HnO+CKsk07UECXnNKWDmjEL7uewNo0GPNfQhfgdqEho4iY1zyx86wapc/PmzzU8jCPpQMoqMPPZ0N3JYhazrlzGY/si+B73DF903IJwJHoH7qE95PpCdCjDvCyzkpjE25/zFxSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755680774; c=relaxed/simple;
	bh=5OYOK7aQpU1X9yOebdZcroKWtUh/mD/yMUMLCZyq9vg=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=Xw/xwiSTJgImZy3rlOJ5S0D12w1ZPvqFekcN95VO4T9oww4KSAc8gywsQpYRt7zI4DO6qDfiUODAPknxR/1ViepUGF3C9PDPr1qAgKWjre68HluoHjI0IkGvjSyfN7iQOXdrfxvDy1s4dow93eRDaSw6rI3/+/Cgiz6JPV6nyCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=vCbsK1rK; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-afcb7a16441so970310366b.2
        for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 02:06:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1755680770; x=1756285570; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=SjfjAF0ihm6dUzVTEeGzkjgU2zdiQsd0XmXwmmZheMI=;
        b=vCbsK1rKGVPcLmRRef7Cv4N0WOSaJ4wjrzcDf+nm5Fa2Ms4rDEQ3KXE46tp7XdcxaA
         njj0O16g2I7sMjYHr8DEuzVYMsXKCSAKS9BgimhI5IyPbqdxeRf1YiV7v2S9qc0j5LYf
         NdxL6JT/2Jq6FryNXM3HsQuMognyvFPPv8Xvy9zXp5E0wgBwApFO5o9drIIEYCARN3gq
         JPxByj/JIv29HQ8Qoe5OYhF0WHfj8ZklZRZ3C3gBMZO/MSJtHztDqvWlWDc0euAsZZFC
         7N8A+rN7b1Gt6xKpsw1fkoIpc6ZZXehijsjhN71XBFYt9iv2fUQhfO7/GKIF0sCl30Xb
         VIdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755680770; x=1756285570;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SjfjAF0ihm6dUzVTEeGzkjgU2zdiQsd0XmXwmmZheMI=;
        b=U8b792sHM+4A2fg4l7uEfyp9W8XFXODNKPP4/2NxqUxxaIvbfD2jAzgG/M0kGRkvDW
         qisnJROS9EHX7ItuHgbCtNd/UJrq0u8+tQB6XCAy9ioeL7eXPFhMMJB8Nnwybl6/ZVcD
         f8gUfLsLvuD/RKpphoitEoQ/RnMmrZfUbGSiE/s/oO1Wd8snKiZQ9CLEq+t2ZXROqhF6
         seyb/FU3PvOgyudDz/AROt21A0bx12lzYiMbiTOtXCfmae0OZ3lQV32oyrxsBNll2U3g
         iC7LWw5CCVpJFHv5qnI68e0kzzFi9X6o2YvIP90JmMTMAB41QiVrVQW9LUjJvikNhvqW
         5OIg==
X-Forwarded-Encrypted: i=1; AJvYcCXfCpMNuxwP60D6TNw13iWtHBsYAfwgD7Qo+R4FlhItfxizlA2M//npaHrJ/5ZOcOSx6Sc6OZz0aJJt4Ls=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOF45UJPsz3VApQeXxRQaYKcO8D8zVsODIi2J6inFGgOSYyKFV
	Og+OXgXVtckfVQu+mhYbgXAmSeJqJXh3lQN5QQHWrraYHhZRvZHr32y1orLTW6k5qKU=
X-Gm-Gg: ASbGnctb3KpvqdU7HcjjWydkJutIKz0LQr28yRJVFGkrlIDVU6strvDSmc39t9xrf7x
	91X0QLD/QKSiAHMhNeL0eeTwPJddqbcdgxVZ0Cn4dNOsbJUwKdwmBpdErdQ/Nmip2TfaRgge4uf
	QeLoi5wyVM4MVtyd/8CcbGwmH3nhO1mUbcqmxnG83i8RYAqu0rchMrrFXg5OBU0PX1PxcwlFMG5
	yHmYCwib1fUdZvfMoGrzjcCSKDbt0OJHOL1fsJ3YxpMCLQ8bNYuzS1oX8nS7FkBvyvG+mtFUQRA
	2echgSjjyuLhJrlQEXhNauuO8AJT58X12mU7xeoI9SnFj8DgSkRAntqVTaXO5SsHySrq9vRobfF
	qN/8wQwzoqPIaZg==
X-Google-Smtp-Source: AGHT+IFxKjSoye5KytJcBeIh7RVVNTxX96Tia/JazwrfrrvBChFGTf0ixNRMCRYvTWwly37g85A8Cg==
X-Received: by 2002:a17:907:3f27:b0:ade:3eb6:3c6 with SMTP id a640c23a62f3a-afdf009b921mr174055766b.15.1755680769642;
        Wed, 20 Aug 2025 02:06:09 -0700 (PDT)
Received: from localhost ([195.52.61.108])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-afded537f98sm141907366b.104.2025.08.20.02.06.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Aug 2025 02:06:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed;
 boundary=0c51fa388eb9b21910f63f4f00a3738371207d9954d178cc4d914d32c9d6;
 micalg=pgp-sha512; protocol="application/pgp-signature"
Date: Wed, 20 Aug 2025 11:06:03 +0200
Message-Id: <DC74W02T8Y9U.Y7IH9HBIP2J3@baylibre.com>
Cc: <linux-can@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <kernel@pengutronix.de>
Subject: Re: [PATCH 5/7] can: m_can: fix CAN state in system PM
From: "Markus Schneider-Pargmann" <msp@baylibre.com>
To: "Marc Kleine-Budde" <mkl@pengutronix.de>, "Chandrasekar Ramakrishnan"
 <rcsekar@samsung.com>, "Vincent Mailhol" <mailhol.vincent@wanadoo.fr>,
 "Patrik Flykt" <patrik.flykt@linux.intel.com>, "Dong Aisheng"
 <b29396@freescale.com>, "Fengguang Wu" <fengguang.wu@intel.com>, "Varka
 Bhadram" <varkabhadram@gmail.com>, "Wu Bo" <wubo.oduw@gmail.com>, "Philipp
 Zabel" <p.zabel@pengutronix.de>
X-Mailer: aerc 0.20.1
References: <20250812-m_can-fix-state-handling-v1-0-b739e06c0a3b@pengutronix.de> <20250812-m_can-fix-state-handling-v1-5-b739e06c0a3b@pengutronix.de>
In-Reply-To: <20250812-m_can-fix-state-handling-v1-5-b739e06c0a3b@pengutronix.de>

--0c51fa388eb9b21910f63f4f00a3738371207d9954d178cc4d914d32c9d6
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

On Tue Aug 12, 2025 at 7:36 PM CEST, Marc Kleine-Budde wrote:
> A suspend/resume cycle on a down interface results in the interface
> coming up in Error Active state. A suspend/resume cycle on an Up
> interface will always result in Error Active state, regardless of the
> actual CAN state.
>
> During suspend, only set running interfaces to CAN_STATE_SLEEPING.
> During resume only touch the CAN state of running interfaces. For
> wakeup sources, set the CAN state depending on the Protocol Status
> Regitser (PSR), for non wakeup source interfaces m_can_start() will do
> the same.
>
> Fixes: e0d1f4816f2a ("can: m_can: add Bosch M_CAN controller support")
> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>

Reviewed-by: Markus Schneider-Pargmann <msp@baylibre.com>

> ---
>  drivers/net/can/m_can/m_can.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.=
c
> index 310a907cbb7e..149f3a8b5f7e 100644
> --- a/drivers/net/can/m_can/m_can.c
> +++ b/drivers/net/can/m_can/m_can.c
> @@ -2507,12 +2507,11 @@ int m_can_class_suspend(struct device *dev)
>  		}
> =20
>  		m_can_clk_stop(cdev);
> +		cdev->can.state =3D CAN_STATE_SLEEPING;
>  	}
> =20
>  	pinctrl_pm_select_sleep_state(dev);
> =20
> -	cdev->can.state =3D CAN_STATE_SLEEPING;
> -
>  	return ret;
>  }
>  EXPORT_SYMBOL_GPL(m_can_class_suspend);
> @@ -2525,14 +2524,14 @@ int m_can_class_resume(struct device *dev)
> =20
>  	pinctrl_pm_select_default_state(dev);
> =20
> -	cdev->can.state =3D CAN_STATE_ERROR_ACTIVE;
> -
>  	if (netif_running(ndev)) {
>  		ret =3D m_can_clk_start(cdev);
>  		if (ret)
>  			return ret;
> =20
>  		if (cdev->pm_wake_source) {
> +			u32 reg_psr;
> +
>  			/* Restore active interrupts but disable coalescing as
>  			 * we may have missed important waterlevel interrupts
>  			 * between suspend and resume. Timers are already
> @@ -2544,6 +2543,9 @@ int m_can_class_resume(struct device *dev)
>  			if (cdev->ops->init)
>  				ret =3D cdev->ops->init(cdev);
> =20
> +			reg_psr =3D m_can_read(cdev, M_CAN_PSR);
> +			cdev->can.state =3D m_can_can_state_get_by_psr(reg_psr);
> +
>  			m_can_write(cdev, M_CAN_IE, cdev->active_interrupts);
>  		} else {
>  			ret  =3D m_can_start(ndev);


--0c51fa388eb9b21910f63f4f00a3738371207d9954d178cc4d914d32c9d6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iKMEABYKAEsWIQSJYVVm/x+5xmOiprOFwVZpkBVKUwUCaKWP+xsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMSwyLDIRHG1zcEBiYXlsaWJyZS5jb20ACgkQhcFWaZAVSlPK
rAD/ZSbJc+wMxk6zan0X4q5gFEj/m0jpJ+28LkUqxHC8ek4A/RkYzI+CFxIzI82T
LXnkxkyj4ImZ4YZ01SYKgwfmuwYN
=jIe8
-----END PGP SIGNATURE-----

--0c51fa388eb9b21910f63f4f00a3738371207d9954d178cc4d914d32c9d6--

