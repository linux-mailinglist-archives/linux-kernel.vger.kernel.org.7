Return-Path: <linux-kernel+bounces-772195-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 819A8B28FC9
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 19:27:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9CC9C582FA9
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 17:26:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 872792FF665;
	Sat, 16 Aug 2025 17:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DMrKpGE3"
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F958374D1
	for <linux-kernel@vger.kernel.org>; Sat, 16 Aug 2025 17:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755365188; cv=none; b=JLbHDuwiMilZC/qn0hgJn/eAQJQd6lPuudUrs1PVrhMkOeu+STrtS6aiTUSla1G1u6t9wmhy1ZXrdM+nu5YcaNRlvk/411jPX+BSd0EjVsvQ15AiZWX7RjCeIbs6/06tzj8nphLdxVB2/ke1xdFj0fSNxZ1NoQkHdtgyYpY4RUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755365188; c=relaxed/simple;
	bh=Pt4QFkJKeDes/1dpFWEZFRC9Fyo6Q/os1TmT4UtDfcI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Lg9zYHTWXhzPNDh4WpWX+1/MPdjn6UmQMo1PegBJNztI6Q6pF+qX/iEzK70PaD/zGJliZG5xEKZlmX9bWFXSi7rm4qCZu5+pel3AYEZ/JRLMF9Rdl6fs4fHZmuPQeckfQMRgQaR/fG3ZP7Uo/Wm9lomlQskxqHHRvbbtGptLXPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=DMrKpGE3; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-e93498d436dso31721276.1
        for <linux-kernel@vger.kernel.org>; Sat, 16 Aug 2025 10:26:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755365186; x=1755969986; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+erJ0Zp3LHICZMt425StIsw9Vrx8YjGGvrTqeALgDWk=;
        b=DMrKpGE3gLl7UE8DO5puO8Qafguwz8USANOHBAqI+QGjwLDzXbI7/SDdCpaFKGSh6m
         XWJdJCqwlwo0boUVHTkN2OXspJislxpCdJSM4k2mNHtjYe/xs9X8hClf3atGALEbImPJ
         Yq7fNfFGiTfhUl5CSFvv7knPUWjBz5exqenyf3GpSgUkucn31yGH/aiADY/5l2Qc50qv
         fYOhAaW3/bbeeQtXK/uKFQJuWLKmqZZZu2qHuiNqg0+ieC1NDZPoyPcuIKhmRnHC2w7M
         TdQ/OFMfrxhJGd22TSvqtdy/aPntZ5aNT513Tgaz3rkXmc4oMHLsW8Asz8Y6VAdIeypw
         4GCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755365186; x=1755969986;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+erJ0Zp3LHICZMt425StIsw9Vrx8YjGGvrTqeALgDWk=;
        b=kdoos1W+G+hvGHElHdIw7fwHaADoGHOtHDjfudN5osTb//4oWV3V8OzEEr/1wGZFCH
         32JvVr0ftraN8JqkIZi6CIL1S990Yher2rw/s093aMCYvoTdaKarw3NrIbFG0oZ4sAPC
         Kcf7Kro+XDkT68Co2WtSReQgKcbtsBbTw2Ux8Txj2MDCsix9pevIexCFnE7v947k6Cxu
         492OW7uKBRPSnd2sp72gUzbe0cErfYsQo1OE90p5rKHJzPg3rGhZ5tNaKpmAAS8aVWoK
         ndf1id9K7YUyj83MBG7P5NZRSiCMy8CrNrqoL+bbmHH4lcR8qSu7QV0Kjfqcoig8oLBW
         /P0A==
X-Forwarded-Encrypted: i=1; AJvYcCVj2+WZdluEBJeZxG8PN7VGXGW4gsFh2c7vsydZfVFTAz4auVYEVr8iAbF8803uhZx489s7p2EQ4TUZi1I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyt4ryft3L6Cm1ORwTvXKa4HBpcjEmAcZLnjDSS8UnM8mg11FO5
	2aMDRoGW9/foSYrjugEyr2zIObQolPAlQSP5MPg8kt+9l52oof2FyZzFIJOCC28XeW0RP+cd/Nb
	m8nYZ1d1zIQ7qA8xDAF918ptwS/ZV5n/GkkII0xs+gg==
X-Gm-Gg: ASbGncsmVxZ/hfCJmDavgbT1QlGYjM/YCUXBzb7h+BHcPDPnCnqpRjpH7+QPRKu1g0w
	BSFW7FYjY7N+KYghEaP7qvyQp02jX/bqM3ZcvOUup+3AzB6YQ50ZWMdA+9M+m6FaLWfNiPzt0BO
	oq/peQsh9y1+o2De2nNY3ImQi2eWG6h7uluyunaGzTzZ71zJNnIkCnD888OsFwPca2p5lptg5OO
	nSH+A==
X-Google-Smtp-Source: AGHT+IEiUE/ZBe/h6CTv9oXmV/520CYO08VrAKRH9DK2kLKicjLwLKXfuc77q+NFZWV5/udeIZCHd/ZkZBNSaus2ZAI=
X-Received: by 2002:a05:6902:1208:b0:e93:36f3:573c with SMTP id
 3f1490d57ef6-e9336f35958mr7576548276.5.1755365186241; Sat, 16 Aug 2025
 10:26:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250815070500.3275491-1-ivo.ivanov.ivanov1@gmail.com> <20250815070500.3275491-4-ivo.ivanov.ivanov1@gmail.com>
In-Reply-To: <20250815070500.3275491-4-ivo.ivanov.ivanov1@gmail.com>
From: Sam Protsenko <semen.protsenko@linaro.org>
Date: Sat, 16 Aug 2025 12:26:15 -0500
X-Gm-Features: Ac12FXxe2rWnXKWQd1X34M41uQmxOqzmaGTi-5t45-ucTyoZet0Hf0j8vH7V5Mg
Message-ID: <CAPLW+4mp5DASdcToSW1QD7f51w4AYQeKzTF=nq2U=f-HiXD-8w@mail.gmail.com>
Subject: Re: [PATCH v3 3/4] arm64: dts: exynos2200: increase the size of all syscons
To: Ivaylo Ivanov <ivo.ivanov.ivanov1@gmail.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Alim Akhtar <alim.akhtar@samsung.com>, 
	linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 15, 2025 at 2:06=E2=80=AFAM Ivaylo Ivanov
<ivo.ivanov.ivanov1@gmail.com> wrote:
>
> As IP cores are aligned by 0x10000, increase the size of all system
> register instances to the maximum (0x10000) to allow using accessing
> registers over the currently set limit.
>
> Suggested-by: Sam Protsenko <semen.protsenko@linaro.org>
> Signed-off-by: Ivaylo Ivanov <ivo.ivanov.ivanov1@gmail.com>
>
> ---
> Did not add the r-b from Sam, as the patch is pretty much completely
> reworked, including the description. Please send it again :).
> ---

Reviewed-by: Sam Protsenko <semen.protsenko@linaro.org>

>  arch/arm64/boot/dts/exynos/exynos2200.dtsi | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/arch/arm64/boot/dts/exynos/exynos2200.dtsi b/arch/arm64/boot=
/dts/exynos/exynos2200.dtsi
> index 943e83851..b3a8933a4 100644
> --- a/arch/arm64/boot/dts/exynos/exynos2200.dtsi
> +++ b/arch/arm64/boot/dts/exynos/exynos2200.dtsi
> @@ -306,7 +306,7 @@ cmu_peric0: clock-controller@10400000 {
>
>                 syscon_peric0: syscon@10420000 {
>                         compatible =3D "samsung,exynos2200-peric0-sysreg"=
, "syscon";
> -                       reg =3D <0x10420000 0x2000>;
> +                       reg =3D <0x10420000 0x10000>;
>                 };
>
>                 pinctrl_peric0: pinctrl@10430000 {
> @@ -328,7 +328,7 @@ cmu_peric1: clock-controller@10700000 {
>
>                 syscon_peric1: syscon@10720000 {
>                         compatible =3D "samsung,exynos2200-peric1-sysreg"=
, "syscon";
> -                       reg =3D <0x10720000 0x2000>;
> +                       reg =3D <0x10720000 0x10000>;
>                 };
>
>                 pinctrl_peric1: pinctrl@10730000 {
> @@ -418,7 +418,7 @@ cmu_ufs: clock-controller@11000000 {
>
>                 syscon_ufs: syscon@11020000 {
>                         compatible =3D "samsung,exynos2200-ufs-sysreg", "=
syscon";
> -                       reg =3D <0x11020000 0x2000>;
> +                       reg =3D <0x11020000 0x10000>;
>                 };
>
>                 pinctrl_ufs: pinctrl@11040000 {
> @@ -450,7 +450,7 @@ cmu_peric2: clock-controller@11c00000 {
>
>                 syscon_peric2: syscon@11c20000 {
>                         compatible =3D "samsung,exynos2200-peric2-sysreg"=
, "syscon";
> -                       reg =3D <0x11c20000 0x4000>;
> +                       reg =3D <0x11c20000 0x10000>;
>                 };
>
>                 pinctrl_peric2: pinctrl@11c30000 {
> @@ -471,7 +471,7 @@ cmu_cmgp: clock-controller@14e00000 {
>
>                 syscon_cmgp: syscon@14e20000 {
>                         compatible =3D "samsung,exynos2200-cmgp-sysreg", =
"syscon";
> -                       reg =3D <0x14e20000 0x2000>;
> +                       reg =3D <0x14e20000 0x10000>;
>                 };
>
>                 pinctrl_cmgp: pinctrl@14e30000 {
> --
> 2.43.0
>
>

