Return-Path: <linux-kernel+bounces-855730-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 33200BE2207
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 10:22:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6AFE84E227D
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 08:22:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 096B7304BCA;
	Thu, 16 Oct 2025 08:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TGvMq1/X"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC6D62FBE1C
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 08:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760602957; cv=none; b=gZkLGdSoq8bYZkRyuNWvNC/KFSUdcUvD/+4xZUuEn8pcliXNN5FEpywy4292WkAmJUNeR4VbNFheye6gFocd9ovjzJGnFBPzzzux/V7C+VPus7NMRpAOEaGz59BN3RbZmMMmSUUstfWAP1hehfYSGTwmwCJ7zPcEFGawuXk41LY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760602957; c=relaxed/simple;
	bh=oBBdec07DnXHPLlkhx/kTRhSSBmJ1d438R+ruAA70Rs=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rn70PXO4x2nj0po1BYstIO0EShYejFnrS+m017p5x65yFaH+3CtWIniTFoEAv5VGBN3k3WtVxAxJKm5h++x8S6Daoz7+QKgO7xoP3ObqtUycxKaGsaPe9jtA4M2or59R6riucY7fY7QJd4sfmOR6UIXs1kDJUNrMX0SLea12Izc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=TGvMq1/X; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-63befe5f379so595441a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 01:22:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1760602953; x=1761207753; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=oBBdec07DnXHPLlkhx/kTRhSSBmJ1d438R+ruAA70Rs=;
        b=TGvMq1/XCQChBhpPqzrd6PHtUIoSTpJHbT4pAZkLpBnjTBVo0q4lIQwi1QVTocZ9Tn
         N39vYvf/QM64pftaErwX3GEDyhBmVpJ+1KeMvSF5Colrbsx82W99eWHlqjZlzvUHUa9k
         VN4fqFTFKvop1DUq5Gpe80HPx44cB+KgqRAAGyIpoWdY2w9B/rYOpmLLu3wVvd1ZWzaU
         a3TlUwJOHRh9EQvwl1lbX+1bdq7HDxPIHWNRQ3kHcPw8qHcpwTknAkniNzk6qVcZR0RB
         +RX/9vw9j6D4hjoN2fUtv9M3C95Ep7H7jJuaaZhiOIyVVjAh8A+EVZ8wyjYkI1/WL1ww
         Hw1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760602953; x=1761207753;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oBBdec07DnXHPLlkhx/kTRhSSBmJ1d438R+ruAA70Rs=;
        b=XaLYSoSTiUX2SXY5NccdN+gEBk8Q1iss70xibb+UqqJBqxr068gzj/MCeBZ8XtqNmG
         P11pJmkrPjdIxb7+bGOC/nhnkaFwDUH1gCU5tNH00l0r9XXOFQhIIwE4Gp7b+YcOxwKF
         3Kg/LSYd0SOf5OXQ2/Bdoz7IYROIl7PkWVpt7Qu91wW4MSfl2nFEPmmKpqdNJFpnMpyV
         Nh0gA5XteDut7PB3RkPxcT3+9wSSGONXzYW98GN48etwLfEKtYMYffLBP3Pc4fGr0Cus
         SjXVdsSCoBfBCMsF98DnhPfTssxE71xxpXBnWs0AGtghAfIFSY2MNXXlYHMscyknZMgo
         qKmg==
X-Forwarded-Encrypted: i=1; AJvYcCWz7He7hC02sqcB7VsLUFL9IQPez1BFzpTECFs3QmcTqV0oa8UbwSJTrfa05+gHGEPEJh2GkAcGM/70Mo8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5I1jbw1dta2OFc1TWMGMN910VQoWkrEw6wAWa3hxJPhNKA4vS
	87IkXc/JPN9K2hed7hnKGDXZSlSaspbfhyXazVmX9FAeFn53UGJxKLoI9GYRCSy4ttc=
X-Gm-Gg: ASbGncthwRYSxs9an/ciowQ2D27YL7ib6iuPxXfnDAEAimO1fIMLO4NNBm+4WW10HGT
	DLoPIg5bbxb3aZF24nABpiTdEtwG41mI6+tbqJqVCartMPCySaynBCXZiURQ1l0l0njqqe0p1BG
	baKwDw7GjEss20TINx49Te0oev6l9vV7WSdDiYE73B393khj70Na7uE/xuSnWXC6p5Fmg6hQ+6w
	8IkCf0FRs1yAEfaR8+n9xa1q6N9iZnKgWP5ktsGJQEg0fOQo0Z1js6plu/BqatALRmgZUU5LsOn
	9mupcXrCnAglICjKTBQdqQHT61sAz6huJ70+gB7G9iIpCZ/MXfT5JOb1ceYIimYs3oMGK0Q6Ibz
	xRAmE6rmbcBdiwdGvYe4kxYFN205C2IrRBCLXbYp98qznP1F3sc7Ufuglm3RV71bX33EtOWJAOU
	bjL/a6KqbDME6XpZ63BA==
X-Google-Smtp-Source: AGHT+IGSt650n9l8ivg1ZcCBjVV9spK1fxIgYVcQeuSemjU+fLA1qbxGFofJQsP8Vwjza4IFOhR66g==
X-Received: by 2002:a05:6402:84a:b0:62f:50cb:764c with SMTP id 4fb4d7f45d1cf-639d5c699efmr29854311a12.35.1760602952962;
        Thu, 16 Oct 2025 01:22:32 -0700 (PDT)
Received: from draszik.lan ([80.111.64.44])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-63bea024febsm3932663a12.4.2025.10.16.01.22.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Oct 2025 01:22:32 -0700 (PDT)
Message-ID: <0ccec501bd01a4e3a2e5087a52fe7a9b32d97c75.camel@linaro.org>
Subject: Re: [PATCH 4/9] arm64: dts: exynos: gs101: fix clock module unit
 reg sizes
From: =?ISO-8859-1?Q?Andr=E9?= Draszik <andre.draszik@linaro.org>
To: Peter Griffin <peter.griffin@linaro.org>, Rob Herring <robh@kernel.org>,
  Krzysztof Kozlowski	 <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Alim Akhtar	 <alim.akhtar@samsung.com>, Tudor
 Ambarus <tudor.ambarus@linaro.org>, Michael Turquette
 <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, Sam Protsenko	
 <semen.protsenko@linaro.org>, Sylwester Nawrocki <s.nawrocki@samsung.com>, 
 Chanwoo Choi <cw00.choi@samsung.com>
Cc: Will McVicker <willmcvicker@google.com>, Krzysztof Kozlowski	
 <krzk@kernel.org>, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, Krzysztof
 Kozlowski	 <krzysztof.kozlowski@linaro.org>, kernel-team@android.com
Date: Thu, 16 Oct 2025 09:22:31 +0100
In-Reply-To: <20251013-automatic-clocks-v1-4-72851ee00300@linaro.org>
References: <20251013-automatic-clocks-v1-0-72851ee00300@linaro.org>
	 <20251013-automatic-clocks-v1-4-72851ee00300@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-2+build3 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2025-10-13 at 21:51 +0100, Peter Griffin wrote:
> The memory map lists each clock module unit as having a size of
> 0x10000. Additionally there are some undocumented registers in this regio=
n
> that need to be used for automatic clock gating mode. Some of those
> registers also need to be saved/restored on suspend & resume.
>=20
> Fixes: 86124c76683e ("arm64: dts: exynos: gs101: enable cmu-hsi2 clock co=
ntroller")
> Fixes: 4982a4a2092e ("arm64: dts: exynos: gs101: enable cmu-hsi0 clock co=
ntroller")
> Fixes: 7d66d98b5bf3 ("arm64: dts: exynos: gs101: enable cmu-peric1 clock =
controller")
> Fixes: e62c706f3aa0 ("arm64: dts: exynos: gs101: enable cmu-peric0 clock =
controller")
> Fixes: ea89fdf24fd9 ("arm64: dts: exynos: google: Add initial Google gs10=
1 SoC support")
> Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
> ---
> =C2=A0arch/arm64/boot/dts/exynos/google/gs101.dtsi | 14 +++++++-------
> =C2=A01 file changed, 7 insertions(+), 7 deletions(-)

Reviewed-by: Andr=C3=A9 Draszik <andre.draszik@linaro.org>

