Return-Path: <linux-kernel+bounces-821015-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E2360B800DA
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 16:36:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EAC96587041
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 14:33:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAD7C2EFD8A;
	Wed, 17 Sep 2025 14:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="C3UUbFRm"
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C62B2191F91
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 14:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758119592; cv=none; b=MJEwjJWqokQaAsXS2V8n2BDSZEOBCDevT0+mAT93ViRhxPxE8tPrGIfKbV2h6k3jIJch93PGQTi49BpGeh+TsLB1eWo8LMx8yWmP/eYZkDvIGrBG1/tWvXTmTMKHQEjao6XPLLDRQdDnVeOLamSIt5t89Pn7BFOQRy6dWimJTT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758119592; c=relaxed/simple;
	bh=RKaFL/f/x+BpU4Xk7oekVWLIrBOIODf0tIBd2+YRAto=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ImYTo/29ZAVKvIyeAS5SRfhddUbsEW8VN3TE6/xDLqZXp/H4sr2D46NWcvtivc4wsdiPMP5TXKOc6Z6VC5Vjo0HldJRN/6D69G7sn/UNCql4v+jS2/rRZnfgtSm0dxkMwtOlqLegcWtpGm6oAAJ/W/OGTQVl1XFKOGDfRZHf7eg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=C3UUbFRm; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-e96eb999262so4140559276.2
        for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 07:33:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1758119588; x=1758724388; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cjiYB/uowYFXiRivyJJw9KQxslDZjaml/1h2OkBzYY8=;
        b=C3UUbFRm3acP+0gd7vxBXz6Z3ef402pRo2XadWFzpB/mpXuKLW7vRWbB4zfivlFst8
         GoFZp1CMYZq2QABwCDUoiOSiBoZr10VhVEneXxJPE6qF7z8tJSamZikSv2lyZRwq34i8
         WnSbeTp9SjJ+zGRONoG3aiK0lATCddxAxq6ypvl9zWUwTUCTxj+IoJDZwAex5ACmyGdB
         l4aEfSz0+2npRMBWyEz7AHjfwhcvD/ioeyfpfBktFQE+sDh6dM/iNu3MIoCCXpmWOp5u
         BxOWT6HUdbUBzBO7QgWUWG6Pr3QtzNoSjAfRk+X7xQiUEo5bNCB3O9uYHiLHsg+AcmUJ
         FJwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758119588; x=1758724388;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cjiYB/uowYFXiRivyJJw9KQxslDZjaml/1h2OkBzYY8=;
        b=oXvqoA6xpsL8u5g9N90+6yQXP3BnzP4TobYNZtngWzbOx95p2yL7MY7SopTFAp73Tm
         xmf6sACGPYIAyvTlHhHgH77TQVeFuYiED1RgBIAuLvfkrd7KIRlGgPiSR2rN66kiNIwf
         Ms9gKHCgWKbUKYLjX5oxZLoB9GB7ILniRsA0+4Qxt7Cgm/PUXSrtTfwcDyd2whj6g3kb
         2ch4eaeTATdQ86iq+Lepw3TYPysCnE2xahNBUWdsENyZEoTVBZ5zA3FwbQZ0N7MRB0i3
         obXgOl3vv9mTn6kkFvcqW9eaBLpxUpqQjSTCzhYT08ctPY4+haqtzev7ZUz92wAzBJ33
         mdeA==
X-Forwarded-Encrypted: i=1; AJvYcCXBsC7ObXyn6IqTnTOiJzvB8Ag4o9x2p89Q2JvWh4v8hExFH6DiQtwyYRzkMTY5FdshDjAxtYwNGONvWw8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx325daWtBvZSxSIJ3Yp+r7nushPh6DWh6ul19cWsuYZ47qBPht
	AOHjDptmtLTdWVVzOHFPERqu0dMAm4LcBTbPkiJl69sKBqqLkedARpAp0kPKsJLDmJeap5W9G2y
	7gdZaeCFPuxmjUCYs1cwavW7iSmm9mrSlLuv5GxE64w==
X-Gm-Gg: ASbGncsTueQPtY0evZW9QWM4rtx6tfgT23l3I1h0JZn7MUB79a/AGtNBittqOhhlWGd
	NUHzyiA93lZ8XqLTtaediEfbplQ6KPDSepKLm5jv01FGxOFccYFwqCtYTU8DY/RiOUAAB2nTe1W
	rnmLhww68x3Ly6Nyqz7WNgcbVcCrZK6nt1Ejb4r1rEOGifhPqSFeWowL8n2Yg1bQLhqhhj0M3/g
	sEXyAlx
X-Google-Smtp-Source: AGHT+IFQl4sxW4LUcoi3bIXsptHrliwBwP5f8RO+yo+IAgyckDyrm2VPVmx1uys1O5NAXNsLjZqsLa4xcMjhuXJl5zs=
X-Received: by 2002:a05:6902:3101:b0:ea4:6:9024 with SMTP id
 3f1490d57ef6-ea5c03aecffmr2119553276.8.1758119587602; Wed, 17 Sep 2025
 07:33:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250913-pxa1908-genpd-v4-0-55e4cf32f619@dujemihanovic.xyz>
In-Reply-To: <20250913-pxa1908-genpd-v4-0-55e4cf32f619@dujemihanovic.xyz>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Wed, 17 Sep 2025 16:32:30 +0200
X-Gm-Features: AS18NWB4VWSVduLAS3dHprEYP38MnWvLvmP0MGgnFO0V0b-XHaevM6W4A6ssrDo
Message-ID: <CAPDyKFri+vsC9U7hhPukgWR2sRec5M0i8XtmyA7dVgJ-8Ewe_A@mail.gmail.com>
Subject: Re: [PATCH v4 0/4] Marvell PXA1908 power domains
To: =?UTF-8?Q?Duje_Mihanovi=C4=87?= <dujemihanovic32@gmail.com>
Cc: Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	David Wronek <david@mainlining.org>, Karel Balej <balejk@matfyz.cz>, phone-devel@vger.kernel.org, 
	~postmarketos/upstreaming@lists.sr.ht, linux-arm-kernel@lists.infradead.org, 
	linux-clk@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
	=?UTF-8?Q?Duje_Mihanovi=C4=87?= <duje@dujemihanovic.xyz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, 13 Sept 2025 at 23:16, Duje Mihanovi=C4=87 <dujemihanovic32@gmail.c=
om> wrote:
>
> Hello,
>
> This series implements support for the power domains found in Marvell's
> PXA1908 SoC. The domains control power for the graphics, video and image
> processors along with the DSI PHY.
>
> Signed-off-by: Duje Mihanovi=C4=87 <duje@dujemihanovic.xyz>
> ---
> Changes in v4:
> - Address maintainer comments
> - Rebase on v6.17-rc5
> - Link to v3: https://lore.kernel.org/r/20250829-pxa1908-genpd-v3-0-2aaca=
aaca271@dujemihanovic.xyz
>
> Changes in v3:
> - Move driver back to pmdomain subsystem
> - Instantiate using auxiliary bus
> - Small fixes and refactors
> - Rebase on v6.17-rc3
> - Link to v2: https://lore.kernel.org/r/20250821-pxa1908-genpd-v2-0-eba41=
3edd526@dujemihanovic.xyz
>
> Changes in v2:
> - Move driver to clk subsystem (domains are instantiated by clock
>   driver)
> - Drop power controller schema
> - Drop RFC prefix
> - Rebase on v6.17-rc2
> - Link to v1: https://lore.kernel.org/r/20250806-pxa1908-genpd-v1-0-16409=
309fc72@dujemihanovic.xyz
>
> ---
> Duje Mihanovi=C4=87 (4):
>       dt-bindings: clock: marvell,pxa1908: Add syscon compatible to apmu
>       pmdomain: marvell: Add PXA1908 power domains
>       clk: mmp: pxa1908: Instantiate power driver through auxiliary bus
>       arm64: dts: marvell: pxa1908: Add power domains
>
>  .../devicetree/bindings/clock/marvell,pxa1908.yaml |  30 ++-
>  MAINTAINERS                                        |   4 +
>  .../marvell/mmp/pxa1908-samsung-coreprimevelte.dts |   1 +
>  arch/arm64/boot/dts/marvell/mmp/pxa1908.dtsi       |   5 +-
>  drivers/clk/Kconfig                                |   1 +
>  drivers/clk/mmp/Kconfig                            |  10 +
>  drivers/clk/mmp/Makefile                           |   5 +-
>  drivers/clk/mmp/clk-pxa1908-apmu.c                 |   7 +
>  drivers/pmdomain/Kconfig                           |   1 +
>  drivers/pmdomain/Makefile                          |   1 +
>  drivers/pmdomain/marvell/Kconfig                   |  18 ++
>  drivers/pmdomain/marvell/Makefile                  |   3 +
>  .../pmdomain/marvell/pxa1908-power-controller.c    | 274 +++++++++++++++=
++++++
>  include/dt-bindings/power/marvell,pxa1908-power.h  |  17 ++
>  14 files changed, 369 insertions(+), 8 deletions(-)
> ---
> base-commit: 76eeb9b8de9880ca38696b2fb56ac45ac0a25c6c
> change-id: 20250803-pxa1908-genpd-15918db5260c
>
> Best regards,
> --
> Duje Mihanovi=C4=87 <duje@dujemihanovic.xyz>

Patch 1 -> 2 applied for next, thanks!

Note, the DT patch (patch 1) is available on the immutable dt branch
too for clock/soc maintainers to pull, if needed.

Kind regards
Uffe

