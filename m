Return-Path: <linux-kernel+bounces-742097-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C4DDB0ED21
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 10:26:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 945DC3AA14B
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 08:25:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACAAB279DAF;
	Wed, 23 Jul 2025 08:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="WF2Xc2ES"
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C803E279DB2
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 08:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753259160; cv=none; b=pjMkKShqMrsQT+dkay1JUDvUXL0z2svnMSPom3RL8UnKfENtDekfmbj0Ao1QL2pzr3i1oo+PkPTH0/dn5NGQ5kSQKuxYjhOMx8JrR8+LZJa/+ooJmQ6ZorvxAkUVIj2clTNg3PYSoNdP9WLjOa8E21XsUCMG//eW8hee/YdZDvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753259160; c=relaxed/simple;
	bh=vLCNSJ4DxVZDJPQ7cVNRDySeLw0NidDKviv2DX8YsFo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bsd53EtDroOfsRQrQzCqCXB66SkQUgGuR+QgTAcNCS21rLho9M40A2NUlBzajtvVTT/qYk9XbVS7Xw4P0dWh9Oxs/ILgf266RnI+YCREb/jiEQhon/Qm67y9M/yTTrZ+gbzEFNpB9QHnfYvnfEfQzVsuAyKfeFJy1A6oY/8OCaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=WF2Xc2ES; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-b31e0ead80eso5153237a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 01:25:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1753259158; x=1753863958; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vLCNSJ4DxVZDJPQ7cVNRDySeLw0NidDKviv2DX8YsFo=;
        b=WF2Xc2ESZUXC3I4997szY/O/Q2b8sQFJDwGqigrANiJNjwrQgnWk/KgiUjPftfzFf2
         YUADAbu9eIdyFhPrkqBiefiC1jjzmUhXODL5cM5E4M+gVRXQLQJNJCAbF5LQAI0FEefj
         q8MxMVO9ld3BbUf/aaJqD6gt8F++fbHQ/OBNzs7YGg4l1EmRhzW/YAVxoXGzw4MRoUre
         7p+327nZRUY2hjKCflgCpBZrPK8JaJWKKILr/859g7GVsWIzAzbdinzhOLaP/UOkmAp4
         W3o0M+K6QAVSrxdF8uS6CNj2+NiV7wNwVJnNH7YJrUx58XVYBith9M8CmJspWHHkuxPW
         E44Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753259158; x=1753863958;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vLCNSJ4DxVZDJPQ7cVNRDySeLw0NidDKviv2DX8YsFo=;
        b=XnsWbbOuuxi0N3hr/Q3eKi9Tqr0Khdv084cUZ2hq/D9ZCdcIJQX70WmVHldEUzwB1Q
         CD+OSBUHaY6OUuOiJyoH0blAELysvuFGbDKrKjXDT0Qdjr8EogRfk8oc66Si0MnUX5R+
         S01oszBMslW9UODbMwAq7132EzDksY7lXxCt08TI9Ctdk8PyZvvulyXN1UY7gjcNQ5kn
         zxHzgf+aDXerRYpROx+YVEEYuPXnGwrUUGzbNCH0UKCbUoe6LyiNN66qpC1NogUiEKP7
         U1Rg7DEP5yvUU8AGOQI+MJhQh/EEdWVsL68KtKhSyg+kMq98suBhLSsETCtQ8LeEBN4T
         8p+Q==
X-Forwarded-Encrypted: i=1; AJvYcCVhYxBHkUKKZ84n+8LPESMIoC52/JURE5U9txdTP6DvK/WGWyvbBF8qWs+gNJ0gNbo9YjztP9gYgv8/qS4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw51BEEh4jVKkHbqpkI9LEyrNJLxniNjVxbRwR+oYhsvN8RgwX4
	dW3tQPZFpj0//PBdNAn0mdxs9VVTRyVeiSg4FHGVKLsNZPOf5PAIXjSlkvH3Kbafj0zPJ+Jx0DE
	2P5X3FNBAM4hTq+TnbMrvVppbIoanGvUGk2ktNDiu7Q==
X-Gm-Gg: ASbGncuNmuEjnMfnnsIynajiX3Ei+0TVfIGoJZ4vyAOIn2Pywk7eeX6ZsEjLSww2/8a
	bj6Or29Eb9wHn4k5f5OYCJM1OtdPRV2z0SMFuiMmbhqAP9YHIXTb9/aO7ZR1GznBPLCfyLSivkk
	x9HrW/RL0FxaeZ+owYO2SDjR+b8SCshbXQ27vVCIKYoziQ7gA0snSaX/Z6iOpHDLrAs2KVTrgfs
	rxEFnn/9d5I1wkvr0ng8YcVVeVEaALSgVxvqSQB2wvxBpNT
X-Google-Smtp-Source: AGHT+IFzwCafFosCdx131zbcEFY3D64m+7mo0loj5vAsYVkMFUgy5UAHuuRGjg5yAkxctR2cI5zO8+e+kqhHgdsFxCw=
X-Received: by 2002:a17:90b:53d0:b0:315:aa28:9501 with SMTP id
 98e67ed59e1d1-31e507dc7b4mr4498294a91.24.1753259157929; Wed, 23 Jul 2025
 01:25:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250722-axiado-ax3000-soc-and-evaluation-board-support-v6-0-543979a60ccf@axiado.com>
In-Reply-To: <20250722-axiado-ax3000-soc-and-evaluation-board-support-v6-0-543979a60ccf@axiado.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Wed, 23 Jul 2025 10:25:43 +0200
X-Gm-Features: Ac12FXyLbBDcOzrp8fBxUqR9jIu-gUOTaGAF4LxjwERQBqGacqdoGbliH_T9iv8
Message-ID: <CAMRc=MdFoAa2omJgL__4mRqX5CYyhZ3VU_Uy-Tf1oPSuZdV93g@mail.gmail.com>
Subject: Re: [PATCH v6 00/10] Axiado AX3000 SoC and Evaluation Board Support
To: Harshit Shah <hshah@axiado.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	Michal Simek <michal.simek@amd.com>, =?UTF-8?Q?Przemys=C5=82aw_Gaj?= <pgaj@cadence.com>, 
	Alexandre Belloni <alexandre.belloni@bootlin.com>, Frank Li <Frank.Li@nxp.com>, 
	Boris Brezillon <bbrezillon@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Linus Walleij <linus.walleij@linaro.org>, Arnd Bergmann <arnd@arndb.de>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, soc@lists.linux.dev, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org, 
	Jan Kotas <jank@cadence.com>, linux-serial@vger.kernel.org, 
	linux-i3c@lists.infradead.org, 
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 22, 2025 at 10:16=E2=80=AFPM Harshit Shah <hshah@axiado.com> wr=
ote:
>
> -------------------------------
> Hello SoC maintainers,
>
> This patch series adds initial support for the Axiado AX3000 SoC and its
> evaluation board.
>
> Change from v6
> - Ran "b4 trailer -u" and add reviewed by Krzysztof
>
> Add soc@lists.linux.dev in the to list and send this series again as per
> suggestion by Krzysztof and Arnd. Thank you.
>
> Checked locally and able to apply these patchset to soc git.
> (git/soc/soc.git, for-next, checked commit: 7dfbf3176d886ff9a0c7786942d3a=
89809d0641e)
>
> Sorry for late request, please consider this series for the 6.17.
>

I can't speak for the rest but do you want me to take the GPIO
dt-bindings patches through the GPIO tree for v6.17 separately?

Bartosz

