Return-Path: <linux-kernel+bounces-797888-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CC2DB416BE
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 09:35:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 52C301BA2C1A
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 07:35:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 185332DCF6A;
	Wed,  3 Sep 2025 07:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="dmzzi2Kp"
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F8891F948;
	Wed,  3 Sep 2025 07:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756884898; cv=none; b=huzxE+Bhez655CwrTSXxFSm4u6Tgajw6WXqNriejpBbX5FY8RHKLqfL/GYUmI4q1w3ca+fOllGcH+X2uJQomXzAxBNJT9rLuCEl9au1beTG8ir6ZGJ6ZgB4iL/apalYjLHUfEXcqr0VgnbPoMq54CiiopFf+CzbjXuOJw5nuqVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756884898; c=relaxed/simple;
	bh=hlOdXw+ISIywpkvToyJYiZzHeIdj7F5rcjWuwqDVRio=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cwdHgXGlPQdTjWmwB0gdVJLS1heQza+EWita1z+Fq9Y6JOG6ZJgB6+E7AV7NPMH/bE5oUbjmd1rcQJUDu2iR8n61vUhPJFQiZReVvG0I7b1sanI2usk+c+rtiq5a29A4IfBxI+vz+XqZIVi68sF8aONm+sHYQevZZFZP5vIaHEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=dmzzi2Kp; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1756884893;
	bh=hlOdXw+ISIywpkvToyJYiZzHeIdj7F5rcjWuwqDVRio=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=dmzzi2Kp6RTs8aKKrSBqzCoN6AN9vADV8PaTGya2qoXKuD78s3Bo+Fd/rL8amHJ/z
	 1pHoRKGTX9vBvc2HxD6qRwBa/GZB9emEuNReOzTO03d5gjuOuwDuNa4REPEi0Vd//F
	 AQqXpXrY6jguDJqwxKQ1RhDZ5ciMn/szQHeH9T3tfT0QnRYMJbkkt09KuwfFITpvYf
	 oUsZch4g5cr19pCaL+714RL43oqs7ff+yNCSa5GNyhRepG6jmVnR9/D49n3cALr5OZ
	 SYE34xFUpHKvNWtJKbt5KFlUOUQnRjbsgWN8N6nrhlS9hq0H+6/RlgN0+SgoLILFUM
	 s6JnUkppUhXMQ==
Received: from [10.209.99.88] (unknown [180.150.112.213])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id C62656445D;
	Wed,  3 Sep 2025 15:34:51 +0800 (AWST)
Message-ID: <9e7c8819159b3d2782ea63f9431ed208c31bf328.camel@codeconstruct.com.au>
Subject: Re: [PATCH RESEND v2 0/2] NPCM845 reset and clock device tree
 updates
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Tomer Maimon <tmaimon77@gmail.com>, robh+dt@kernel.org, 
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 avifishman70@gmail.com,  tali.perry1@gmail.com, joel@jms.id.au,
 venture@google.com, yuenn@google.com,  benjaminfair@google.com
Cc: openbmc@lists.ozlabs.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Date: Wed, 03 Sep 2025 17:04:50 +0930
In-Reply-To: <20250901132426.3081648-1-tmaimon77@gmail.com>
References: <20250901132426.3081648-1-tmaimon77@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Tomer,

On Mon, 2025-09-01 at 16:24 +0300, Tomer Maimon wrote:
> This series updates the NPCM845 device tree for the integrated reset and
> clock controller using the auxiliary device framework.
> Patch 1 combines the reset and clock nodes into nuvoton,npcm845-reset.
> Patch 2 adds a 25 MHz refclk and updates peripherals to use it.
>=20
> Tested on NPCM845 evaluation board.
>=20
> Changes since version 1:
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0- Tested in version 6.17.=
rc1.
>=20
> Tomer Maimon (2):
> =C2=A0 arm64: dts: nuvoton: combine NPCM845 reset and clk nodes
> =C2=A0 arm64: dts: nuvoton: add refclk and update peripheral clocks for
> =C2=A0=C2=A0=C2=A0 NPCM845
>=20
> =C2=A0.../dts/nuvoton/nuvoton-common-npcm8xx.dtsi=C2=A0=C2=A0 | 20 ++++++=
++-----------
> =C2=A0.../boot/dts/nuvoton/nuvoton-npcm845-evb.dts=C2=A0 |=C2=A0 6 ++++++
> =C2=A02 files changed, 14 insertions(+), 12 deletions(-)
>=20

The changes are already applied and on their way into mainline:

https://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git/commit/?h=3Dsoc=
/dt&id=3D1b8086f1729b8f22e60ba93676602174a3b0a4fc

Thanks,

Andrew

