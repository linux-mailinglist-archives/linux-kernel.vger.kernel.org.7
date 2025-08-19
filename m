Return-Path: <linux-kernel+bounces-775130-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E025B2BBB0
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 10:23:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B1D1170E07
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 08:23:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE849310645;
	Tue, 19 Aug 2025 08:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="E3TQQHMD"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5327B1FC0E2
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 08:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755591777; cv=none; b=mwQjTZUE11rBMn2YyuIJaoZp4RQipvo31k9OVsaiaagZqF4F3mqGDYfZgA81/oXWFux8M3Q1JF0rdfGoCrug5QNGTzeY6EK8KhjX1ljiHjS3Xtl/peb5kT8EuSqlYVmoSI/zlx1u+db8xhKqBIrMmEnkiPBO8RHQX12wtfS+IGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755591777; c=relaxed/simple;
	bh=m7Qft2exuOUoR0wMKCXPDgPvneFrO1oxaOH/gu7phBE=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=RG1pftTfVWdroVhoD19CeRP54cFCrCLrHPvXRM6x+fnzn4V75odOA5ssUMGHRwOt+l2RB3/ASjDGTpkDlkmesCAyWVx0aYgzrrmcMy6QfpTgihWKWrGsoJERLxAlUAINbddGyAz9lHyn8+zqTd7ExOpPiaiGaNL5VWPVdvZh4ho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=E3TQQHMD; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-afcb78ead12so707868766b.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 01:22:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1755591772; x=1756196572; darn=vger.kernel.org;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=L1Njkru38l0QOoJlAufglEomIeGj1U8B+0WCyzenuAc=;
        b=E3TQQHMD1Xh9mQGwkCZhSk/Q3AF1flCcNIb7dc/5XKBhyH+wF59p+rf96GdTMEX59g
         qUxxJBO2AHhXCkMK1k3iaroRVt+fgNDAKZp3Mq5H7vBijt+tswOEPluxeAWxdO+sOkZC
         fo9XBca32zDxfjopOtE1XGK8yzxuKyyyQDDy7mV/mgkXwtqAK8MjghyZKHtxVLP56yvC
         L85Ivr9wgvSZvZ+XSrlyvGdRIRRjSh08yzejn0AOmmAECUQxzWUujVqHpxkWkV91Pdwb
         EIP3M179brlFObMlb7w7msfJDs7Rf2T/tpyVqSnWvRbs150IC2JnF9MDo3+/s3GnIJ3d
         g2Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755591772; x=1756196572;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=L1Njkru38l0QOoJlAufglEomIeGj1U8B+0WCyzenuAc=;
        b=BjzdhCz9Ixwa/v06h0u/Qo1Ttyg4SVflv/1k9fvwbAzGHrI8jjWoZQ0Vzt9HOGw3mF
         vONiuS5ef4RhLNRyUjM+5kg8yDrxjKD9QTuNIUvSZ5PS8N+ot89dNk8Nmk1me9Z/Zyio
         LshlN92KzTre9f7lu2JxpXrK0GnsM0sJa28ffrnVUscIFwh5C5IN6uh+0V0LkWMqmYIF
         AtGpi5H453DPPTMKEN6uZbRRR+2W3xyUBoIDRGDvNXn3CAhIygh62UGSJ/e48WqizeMa
         wIAWJuFdvci5NymwFgB5FaPRWPCD6R88KDYA0UJckYBjtm5WkfToGBxNy48EFSstnLUD
         npag==
X-Forwarded-Encrypted: i=1; AJvYcCWkRFy826tMaNT3XANqfud0veoD36ivGHiPG3oafy/0MBV++3mL13bCRfDel1z9BOgBV/AG6iVHppDozJE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFdYmw8UVG54g4oQTYwxm3kRQ47maZ1bzgsiHH5MG8pJsVU3YX
	13SwZP2YdXi+1Z/Fum2LoJSfC2/cv/QMYcf8Hk5+/KmyMzzGAhyvCsYEk0jGtl3IwMQ=
X-Gm-Gg: ASbGncss3D7sItWndxK9504Nciw8l2Mn5Wdh/yJQQpigVyY29FoV+YKSwe+o8Rhkl1z
	vEPr9F3sRBaHGZ4BRiu75/IU1lRPnYu6gNRg6je7cyzZOYKOxELNh5lae5aH2GWMsqEZZq+G1da
	SUwuNXCPFNEGVSCYQIXiMoRJxZeEECFlzx6Q3mjXwcmJMuMBtxuLOcAJRiVmRWrKybFnf0udHJ+
	DI4Ey0vvhUnaGPPKOTYq0e84/pxRpmx3lN8eqCWRkmoZni2SNAIOrrdlgsuUq8r7ZCh6Kdz4Uqj
	ZgOY0JlkAUysQ0onf8uT5StsxV3FkxXiamWsAQQC8QMxSUF1eWTwGG3BCW52Lmavp3PcR72OO0H
	42IRvqsEIyZ7nX2Z/gpLakC3l
X-Google-Smtp-Source: AGHT+IHQ6IdI5sz4L18Yu1QZQTvncbAaZVp3nVGEwQGE+IqJb6cAlIJuAKwGy+/BUZFGq/kMFQJjyg==
X-Received: by 2002:a17:906:2a99:b0:af9:885e:d36c with SMTP id a640c23a62f3a-afddd200cefmr130153366b.51.1755591771920;
        Tue, 19 Aug 2025 01:22:51 -0700 (PDT)
Received: from localhost ([195.52.61.108])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-afcdd018a78sm952328866b.94.2025.08.19.01.22.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Aug 2025 01:22:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed;
 boundary=b503e628a8fe4bcc91b58492e55f6736818a0e22ecd6078894dcbad57484;
 micalg=pgp-sha512; protocol="application/pgp-signature"
Date: Tue, 19 Aug 2025 10:22:45 +0200
Message-Id: <DC69CAZD1X5T.XGQPHLBKGPTP@baylibre.com>
Subject: Re: [PATCH 1/7] can: m_can: m_can_plat_remove(): add missing
 pm_runtime_disable()
From: "Markus Schneider-Pargmann" <msp@baylibre.com>
To: "Marc Kleine-Budde" <mkl@pengutronix.de>, "Chandrasekar Ramakrishnan"
 <rcsekar@samsung.com>, "Vincent Mailhol" <mailhol.vincent@wanadoo.fr>,
 "Patrik Flykt" <patrik.flykt@linux.intel.com>, "Dong Aisheng"
 <b29396@freescale.com>, "Fengguang Wu" <fengguang.wu@intel.com>, "Varka
 Bhadram" <varkabhadram@gmail.com>, "Wu Bo" <wubo.oduw@gmail.com>, "Philipp
 Zabel" <p.zabel@pengutronix.de>
Cc: <linux-can@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <kernel@pengutronix.de>
X-Mailer: aerc 0.20.1
References: <20250812-m_can-fix-state-handling-v1-0-b739e06c0a3b@pengutronix.de> <20250812-m_can-fix-state-handling-v1-1-b739e06c0a3b@pengutronix.de>
In-Reply-To: <20250812-m_can-fix-state-handling-v1-1-b739e06c0a3b@pengutronix.de>

--b503e628a8fe4bcc91b58492e55f6736818a0e22ecd6078894dcbad57484
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

On Tue Aug 12, 2025 at 7:36 PM CEST, Marc Kleine-Budde wrote:
> Commit 227619c3ff7c ("can: m_can: move runtime PM enable/disable to
> m_can_platform") moved the PM runtime enable from the m_can core
> driver into the m_can_platform.
>
> That patch forgot to move the pm_runtime_disable() to
> m_can_plat_remove(), so that unloading the m_can_platform driver
> causes an "Unbalanced pm_runtime_enable!" error message.
>
> Add the missing pm_runtime_disable() to m_can_plat_remove() to fix the
> problem.
>
> Cc: Patrik Flykt <patrik.flykt@linux.intel.com>
> Fixes: 227619c3ff7c ("can: m_can: move runtime PM enable/disable to m_can=
_platform")
> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>

Reviewed-by: Markus Schneider-Pargmann <msp@baylibre.com>

> ---
>  drivers/net/can/m_can/m_can_platform.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/net/can/m_can/m_can_platform.c b/drivers/net/can/m_c=
an/m_can_platform.c
> index b832566efda0..057eaa7b8b4b 100644
> --- a/drivers/net/can/m_can/m_can_platform.c
> +++ b/drivers/net/can/m_can/m_can_platform.c
> @@ -180,7 +180,7 @@ static void m_can_plat_remove(struct platform_device =
*pdev)
>  	struct m_can_classdev *mcan_class =3D &priv->cdev;
> =20
>  	m_can_class_unregister(mcan_class);
> -
> +	pm_runtime_disable(mcan_class->dev);
>  	m_can_class_free_dev(mcan_class->net);
>  }
> =20


--b503e628a8fe4bcc91b58492e55f6736818a0e22ecd6078894dcbad57484
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iKMEABYKAEsWIQSJYVVm/x+5xmOiprOFwVZpkBVKUwUCaKQ0VRsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMSwyLDIRHG1zcEBiYXlsaWJyZS5jb20ACgkQhcFWaZAVSlNm
MQD/ehJlyjV9qxlZOvdKCqkSom2T+5Mpi2A2cSo+AdV7WcYA/1oPIUAvbvp1Wnd9
cDdrbLzXQ+tlisjks+4a/+Lj/fEF
=BpmN
-----END PGP SIGNATURE-----

--b503e628a8fe4bcc91b58492e55f6736818a0e22ecd6078894dcbad57484--

