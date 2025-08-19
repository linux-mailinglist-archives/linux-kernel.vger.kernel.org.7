Return-Path: <linux-kernel+bounces-775143-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F3EF4B2BBDE
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 10:29:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 886C21BA25E4
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 08:29:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B961311964;
	Tue, 19 Aug 2025 08:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="DA/HfZBB"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEC70311944
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 08:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755592160; cv=none; b=F9BYf+VBOLZBs2KyQJ2BIMj1IHvF+Ms+Unra56boCaz4+WPS/k7IpxN2tjrzV6HT1ED4Uy9pD37a75DUzqMXU/UvydBi6+Yc1Qlf5kukmt46TaXD39aPvivthULIWXx08kGGZSqFJiTOPo/dFyC0k8mczWegF6eG3rnl1WfKrb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755592160; c=relaxed/simple;
	bh=wM9xXC+D294Q3NUdde5c9ksE9RETsJFMNAGdmuAyQLA=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=tmFhxLDHGaaqXdyMuur2NKoo3VATlDUQY2gNUL3W5TUfQK7HccgEnA48rOxUZeCYwDlAKmXD8uzStDcaCqQV4y+vGwVCNg35eHL9MXO5U7MQxIaQ2O2C+Wuhb+3xUmYCfOTObjogOdbL/l4QZs8vuotCm1jfmJDOhcZ5CJe6sHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=DA/HfZBB; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-afcb6856dfbso842409266b.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 01:29:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1755592156; x=1756196956; darn=vger.kernel.org;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=TCI9o6Ocmammodx0PX+9MIbgr0tFJH9KqExrAza1lZA=;
        b=DA/HfZBB5gN8xVgBBJCfet2WqbDHktgESdTtS3HN8YTz+5l0o/541QYyEPUDcTvRnj
         +kRUu/UQIRxBVgI/AyctXq+bjkE9GV6xbUd/vNY92B8JNOUc9DNYu5S0j5rgI2DU/ddT
         uWWQlRgEsil/fRUS8r+a7qhkLcpQpdEziAkjs9nFn6l55rFw4UEiY6OnHIVnb7UlT//Y
         Jt93eFyffEReKCCd2i9ypqlNxjZ2ZMa0rJxiMbehxVZJKqYpmburhMacf7G5n9hd7k8Z
         /dIdkvRonaZHOCfZ3ERfvoVLeb4wKWQSTSALD4Cs6+I0uxEx20wMTwTVQkXtWQtohzh2
         gwfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755592156; x=1756196956;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TCI9o6Ocmammodx0PX+9MIbgr0tFJH9KqExrAza1lZA=;
        b=pXJGNphFa1OeuYXlgP46w/8UFovi8UWCucVaKshcMQb4CEyyKZkdKQ90osulkva4CS
         oP8aMG7zFwvOmwJ4Jjdk+nThe8UjTIj9V0v158f8F+nMhv3XA2Rn5y/v9/7PMnWCSvCD
         D4F2hOc8d+U8Cb9+2PJhhkKHpy+FkMHuTuQxGNwu3KLxMOfXf6lzca1UWOInzWCnmwYZ
         cMuXu3ukObN0+PPvkV0orQMBNR/1sFnYgaNm9JeYwV93rAtSPKy4Z/QTZbdt7LaeP24f
         8XQbRs3Hdz6/hPMSsbcTrHWJgq7M3uoJ2zSrXxStPVRziXNhmbnfcmVk2CAUPuY3tQU0
         zHug==
X-Forwarded-Encrypted: i=1; AJvYcCWF/2Xejw/slkVFJndT8r8OjaPrcQDxR9jxus1rM+S90WQRoZmrt1qmolMdI0BQ+d8HyaqVguF/+wlHrDA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxhdw8bINAfjww6UCcukvRz8zG2dOulvM1uShsr7FYbg+wHswqX
	pvrjXz8N1DxZbkhhQQYIVXXDF6mJJyPbE0jeWyI3Hrn1y5MKQY6fOMjysutdDAKKR0Y=
X-Gm-Gg: ASbGnctBG+FaRINvki2n0V29XJOjeIoPkR8OHIFqXNlLUcsbOh+nRb5rCFGrLZYZjYm
	KcOAFIo1Nj+mBKF8g8nj3UlMlgXH65lMnLxc8BRgE39rF4y7ym/pHxs9cdtEw1CDqJ3HCpLaR2g
	aHGtQgB8E4RUhQwimkxkf6zI9kNa5SvEI4qavg86af+M4ybz0osYSoTS4SRTWlVoEmhG/mlV9B/
	Pq1Lthk+FzzEw0opVQa5sGaSYAGKyq1Nqbp2NX7n9LL0kcrTbUvbFsVymDXt5KuAqLDOZ2pxfOL
	P9uCphMUVFdTuswhgysQo+RL6IpCwwMWulEdNrHd4K8u+43ZDFl8wLSkVxjk/CxAwDEzphNVAIu
	jwy28hTLMmDQUzA==
X-Google-Smtp-Source: AGHT+IEpf0xkM4Fy64K7iYsZpzlLtHAWLLw9UAj4WJRT9U5fr7fAn7CUDHHuzyYNHqv1utE6AIxlJw==
X-Received: by 2002:a17:907:9807:b0:af9:41a4:25b3 with SMTP id a640c23a62f3a-afdded8e7f6mr142953466b.29.1755592156089;
        Tue, 19 Aug 2025 01:29:16 -0700 (PDT)
Received: from localhost ([195.52.61.108])
        by smtp.gmail.com with UTF8SMTPSA id 4fb4d7f45d1cf-61a75794ba2sm1329676a12.45.2025.08.19.01.29.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Aug 2025 01:29:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed;
 boundary=6d44b553a7c7e2e2a2c9164fc3dbefb8444bd5baec51a0f82cba40b40ec1;
 micalg=pgp-sha512; protocol="application/pgp-signature"
Date: Tue, 19 Aug 2025 10:29:09 +0200
Message-Id: <DC69H7OUANQR.ZVMFRCS8UF4D@baylibre.com>
To: "Marc Kleine-Budde" <mkl@pengutronix.de>, "Chandrasekar Ramakrishnan"
 <rcsekar@samsung.com>, "Vincent Mailhol" <mailhol.vincent@wanadoo.fr>,
 "Patrik Flykt" <patrik.flykt@linux.intel.com>, "Dong Aisheng"
 <b29396@freescale.com>, "Fengguang Wu" <fengguang.wu@intel.com>, "Varka
 Bhadram" <varkabhadram@gmail.com>, "Wu Bo" <wubo.oduw@gmail.com>, "Philipp
 Zabel" <p.zabel@pengutronix.de>
Cc: <linux-can@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <kernel@pengutronix.de>
Subject: Re: [PATCH 2/7] can: m_can: m_can_rx_handler(): only handle active
 interrupts
From: "Markus Schneider-Pargmann" <msp@baylibre.com>
X-Mailer: aerc 0.20.1
References: <20250812-m_can-fix-state-handling-v1-0-b739e06c0a3b@pengutronix.de> <20250812-m_can-fix-state-handling-v1-2-b739e06c0a3b@pengutronix.de>
In-Reply-To: <20250812-m_can-fix-state-handling-v1-2-b739e06c0a3b@pengutronix.de>

--6d44b553a7c7e2e2a2c9164fc3dbefb8444bd5baec51a0f82cba40b40ec1
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

On Tue Aug 12, 2025 at 7:36 PM CEST, Marc Kleine-Budde wrote:
> Among other things, the M_CAN IP core has an Interrupt Register (IR)
> and an Interrupt Enable (IE) register. An interrupt is triggered if at
> least 1 bit is set in the bitwise and of IR and IE.
>
> Depending on the configuration not all interrupts are enabled in the
> IE register. However the m_can_rx_handler() IRQ handler looks at all
> interrupts not just the enabled ones. This may lead to handling of not
> activated interrupts.

But isn't that happening for m_can_interrupt_handler() in general then?

Best
Markus

>
> Fix the problem and mask the irqstatus (IR register) with the
> active_interrupts (cache value of IE register).
>
> Fixes: e0d1f4816f2a ("can: m_can: add Bosch M_CAN controller support")
> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
> ---
>  drivers/net/can/m_can/m_can.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.=
c
> index fe74dbd2c966..a51dc0bb8124 100644
> --- a/drivers/net/can/m_can/m_can.c
> +++ b/drivers/net/can/m_can/m_can.c
> @@ -1006,6 +1006,7 @@ static int m_can_rx_handler(struct net_device *dev,=
 int quota, u32 irqstatus)
>  	int rx_work_or_err;
>  	int work_done =3D 0;
> =20
> +	irqstatus &=3D cdev->active_interrupts;
>  	if (!irqstatus)
>  		goto end;
> =20


--6d44b553a7c7e2e2a2c9164fc3dbefb8444bd5baec51a0f82cba40b40ec1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iKMEABYKAEsWIQSJYVVm/x+5xmOiprOFwVZpkBVKUwUCaKQ11RsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMSwyLDIRHG1zcEBiYXlsaWJyZS5jb20ACgkQhcFWaZAVSlNB
7wD/cIXNFNL3XdWS815Jyw2Qf29KhK0qlWvUInVXRI9txwQA/0Jwxk5x8pj4Cwaj
bAJFDc2KKCrNe8rgxRBKzRgVU9oI
=unW3
-----END PGP SIGNATURE-----

--6d44b553a7c7e2e2a2c9164fc3dbefb8444bd5baec51a0f82cba40b40ec1--

