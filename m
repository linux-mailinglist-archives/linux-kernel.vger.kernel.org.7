Return-Path: <linux-kernel+bounces-786425-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F575B359A7
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 11:58:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 08D0220271C
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 09:58:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3446A2882DD;
	Tue, 26 Aug 2025 09:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="Pu8tE7UN"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A8532FAC02
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 09:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756202282; cv=none; b=mv6AUes0koCny2BYq10wbgnScs6LgtkBcPeXze+tDATx0mGDNXb4keXah5IhYP1+MvuwfsCGPNrKkvZrcYdo7VrwXLU64FdBUuVtQtIg/1drbA3K+pz96rSx/PA4y66DdJW/bVyYnpmYtPZA4ZQfcRFvlhhazhm/RI37nCWc440=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756202282; c=relaxed/simple;
	bh=Rt1wBuOibWYMf11azApMmPxWPuGaXVXsAWpTctmwPog=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LHhaEGsHRHihDrw+OeQEK0xflOPjAXc3ck5A2QiqxcGAV2iW1Bhc67qDV/97mYx0oPjcWCQlwDpSfYeI8HWakNZxS6lPFWA8CKZF4eWE8atQusbydIdXVlvNETdqE8IRmgWIbBeNQFbont0PePTP6uh/duWCiGp5QAXU1povKCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=Pu8tE7UN; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-55f474af957so1786797e87.1
        for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 02:58:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1756202279; x=1756807079; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uOUXkb1uF8zQdB/sKiLIuRwWdep4Dp9YFQhPpYg7e7o=;
        b=Pu8tE7UNSPb/mSu8D8XVNJ1m+w/gr9winhNLMNf5oNNhDIbwDbeoNasGh3h562/Z8G
         mCXFe1I8ZZxoJtKns/bQCKXoSXmIVoJtI5E19heex3sjrcGxaQU2kfr9wHdob98rL0Jn
         ly8fbX+5vAcNPWrQMMpcRo7UtVYluLIUCe3bwgfEp8uui5ohvG8u/Pe8Aq4aY9/+AuDM
         iVaw2BMpWe7M6WpsyOqJyY10Mo9VshFCDvsccyDqpIXKA43ZTVsStftFBfiRih1ZaMsw
         jGaf0yyIbgu+iiiE0pxmkgHTqTXZmDOFZ98vubSvsTAtcZf13nFmFU/HgXzYBVwJEear
         JFPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756202279; x=1756807079;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uOUXkb1uF8zQdB/sKiLIuRwWdep4Dp9YFQhPpYg7e7o=;
        b=qCTVfTxcgo+7jmFace9rlVKJAjd1EIUoI36Kml/EIucAdDqiY/gW2rbutWVkSKbkQN
         M7so2fjdadEFE8SCqRUvw7nVDaj7UpeMKsyv3rlg7rR1NYKktQUna2PneWoDa1h+uEPu
         EXGYvzq23dHx1YhHSUtvMCRdsELHxLjDGP8ROKnc5Yw0D0cgljUe+GXe61S6oeu6Bh88
         FLOG+4WxpwNm2eNSmMakoH/mwW72p+MQ/DjSkxrOJ239OZA/DX2yKN9X92rYOTV/87O1
         76wg/X6kXQswPUeEmlymxUzzofzd2hnveuJUVzcMKCP8PzkCxSpzIxWIihpOsIqJNdZ8
         ULcA==
X-Forwarded-Encrypted: i=1; AJvYcCVrTgI+FBQQNpAUAU4Brc73pFOd5Ocz1GAi+bI1TAUDJVIAlVlZo128CuTFfTm9qxxRbAnZxsv6SzS70qo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzmLjQwR1P78HoIh79RDxn1NN7d0emxyT0H+LGu8T6ywf8fhifT
	CS7CgS0kre0idEJg9y0r+yRlK3gMDROlxs4GvnKUlHwjwQyryg+x91EfhegnzmTT4aevUKNH9LY
	WQL+gDr4cS/G5UOfEnp1fYGgqi2HrEZTmnDUsBvMfnA==
X-Gm-Gg: ASbGnctsOdHVE5AH/CEWeLynZ1pbG4sw+mF7SdmR5wnrbTHGKC7/cuc9hNKo2a5ET+4
	95c08SEnN/vL6bKtV8hWL9YZebk/VB0iZBhvhpCkshJqls4F9GGJx+Cdu7vWJ41K/c8SgGZ3azq
	77geJPv/UVEhQdP1K3j4k3L0PzalR02wIxzE1XBTjM/aNQsMV1TKOETiibEotzOK+/YjONBovh5
	wUvXsxxjy7W6xygkXoZOdrYYyvAKNzbd1cdSoUbvGM8yXOX0A==
X-Google-Smtp-Source: AGHT+IHZlig7uTIvb1Hm0+VQCqd18Uy1yI/ilX78XfwZSj12J+ieVVBnbFx5cn43CrziQFS1Bp5XyB1Kt9NlfkCCxzM=
X-Received: by 2002:a05:6512:440e:b0:55f:42ca:cc03 with SMTP id
 2adb3069b0e04-55f42cacd56mr3019395e87.56.1756202279297; Tue, 26 Aug 2025
 02:57:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <372550a2633586d2f98b077d3f520f3262ca0e2a.1756104334.git.christophe.leroy@csgroup.eu>
 <ac7c79b3491cb48ef7c193420b9a9e4614b88436.1756197502.git.christophe.leroy@csgroup.eu>
In-Reply-To: <ac7c79b3491cb48ef7c193420b9a9e4614b88436.1756197502.git.christophe.leroy@csgroup.eu>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Tue, 26 Aug 2025 11:57:47 +0200
X-Gm-Features: Ac12FXy4Ibm7fbO9KiNfYE73-dyWntHoWbLgchN6hbkj2Va2bGEIGeT9v8x9Fxc
Message-ID: <CAMRc=MchS5d3RHjtpc-fAVzKyhMchdUhvZCgTNsJ94u5Cc5FWw@mail.gmail.com>
Subject: Re: [PATCH v4] soc: fsl: qe: Add support of IRQ in QE GPIO
To: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Qiang Zhao <qiang.zhao@nxp.com>, Linus Walleij <linus.walleij@linaro.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org, 
	devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 26, 2025 at 10:41=E2=80=AFAM Christophe Leroy
<christophe.leroy@csgroup.eu> wrote:
>
> In the QE, a few GPIOs are IRQ capable. Similarly to
> commit 726bd223105c ("powerpc/8xx: Adding support of IRQ in MPC8xx
> GPIO"), add IRQ support to QE GPIO.
>
> Add property 'fsl,qe-gpio-irq-mask' similar to
> 'fsl,cpm1-gpio-irq-mask' that define which of the GPIOs have IRQs.
>
> Here is an exemple for port B of mpc8323 which has IRQs for
> GPIOs PB7, PB9, PB25 and PB27.
>
>         qe_pio_b: gpio-controller@1418 {
>                 compatible =3D "fsl,mpc8323-qe-pario-bank";
>                 reg =3D <0x1418 0x18>;
>                 interrupts =3D <4 5 6 7>;
>                 interrupt-parent =3D <&qepic>;
>                 gpio-controller;
>                 #gpio-cells =3D <2>;
>                 fsl,qe-gpio-irq-mask =3D <0x01400050>;
>         };
>
> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> ---

Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

