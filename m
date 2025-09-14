Return-Path: <linux-kernel+bounces-815835-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9938DB56BAA
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Sep 2025 21:34:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 10E3B7A495F
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Sep 2025 19:32:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 802862DEA73;
	Sun, 14 Sep 2025 19:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=chimac.ro header.i=@chimac.ro header.b="RgU5nZPB"
Received: from mail-4323.protonmail.ch (mail-4323.protonmail.ch [185.70.43.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CB7C13BC0C;
	Sun, 14 Sep 2025 19:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757878463; cv=none; b=tuGhATZDtirClnKYm0GOGKn/QzZ3CaU1i6iOOtuBgbEojUMsmYHsoDB5XKWWNBTIw+3zg2AMkFhEEENNuF3b/Ng8PleccAi8tXlBO0snVcgRnI1xhDf3mb+c2uitUVaGsfcNlrw1HRcMMsrgavmLF9wDQPB/PXZFOloKgF6NJpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757878463; c=relaxed/simple;
	bh=SChiRd4Jr6UfFBCrUBWUWxMCt2bUKVsrLzTm4Xw4bZY=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=mlx7OAl5zqFQg21toOgI3v7wDZR/BG2PyZf8SZOGcTclGz6EQgdpW8CTIue/656zCVg3QSjLdEa0JV1lCWQPD6G1CNaK+zQVtF/ZpOqiXEdV9hUPVrAFiSRvbnftEtnZxdcxtACHf2OK3atvfQ3Kxxq7sR8biV56vXWA1lbp5zg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=chimac.ro; spf=pass smtp.mailfrom=chimac.ro; dkim=pass (2048-bit key) header.d=chimac.ro header.i=@chimac.ro header.b=RgU5nZPB; arc=none smtp.client-ip=185.70.43.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=chimac.ro
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chimac.ro
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chimac.ro;
	s=protonmail; t=1757878460; x=1758137660;
	bh=w7wnGFxKCc7yHOaz4m/M6wcLNTkWeL7mLpc1eKaDjVc=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=RgU5nZPBrcEdKZnY6SsKTT7w4/shHF7ADhfhQxFvfimVoAs/1eTjq2rXSrOTHdyU5
	 KLv2mnaN0FAFv070NRuVDtyiFsVBDJbS78uyrlvbULz11XOkMnwSAjkapz0PPjlvwL
	 vdRcnB+KSAGMot+rWcOzws8+nnzAo8BQ68VGcSzpnWB8XtZhchT9uR8xxm545hGDYi
	 dtqvoYstdeOoZ2YMUudvoeOXXp7OK7/L/PlbzPb/XjfMInWMUchu/BG98BhYAm8NfA
	 2untqNgifU2V+UuWWzp/MyXdeV3bbLZ8cbUkFSkRfLH9sIgACvHiAdf70R8OXSRY0R
	 GLBdI7iWGuVuw==
Date: Sun, 14 Sep 2025 19:34:14 +0000
To: Krzysztof Kozlowski <krzk@kernel.org>, Sylwester Nawrocki <s.nawrocki@samsung.com>, Alim Akhtar <alim.akhtar@samsung.com>, Linus Walleij <linus.walleij@linaro.org>, Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Tomasz Figa <tomasz.figa@gmail.com>
From: Alexandru Chimac <alex@chimac.ro>
Cc: linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-gpio@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Alexandru Chimac <alex@chimac.ro>
Subject: [PATCH 0/3] pinctrl: samsung: add Exynos9610 pinctrl support
Message-ID: <20250914-exynos9610-pinctrl-v1-0-90eda0c8fa03@chimac.ro>
Feedback-ID: 139133584:user:proton
X-Pm-Message-ID: 4c117c558f55e3a477e3b3b3b80bbeca70676781
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

This patchset adds support for the pin controller found on Exynos9610.

Signed-off-by: Alexandru Chimac <alex@chimac.ro>
---
Alexandru Chimac (3):
      dt-bindings: pinctrl: samsung: Add exynos9610-pinctrl compatible
      dt-bindings: pinctrl: samsung: Add exynos9610-wakeup-eint node
      pinctrl: samsung: Add Exynos9610 pinctrl configuration

 .../pinctrl/samsung,pinctrl-wakeup-interrupt.yaml  |   2 +
 .../bindings/pinctrl/samsung,pinctrl.yaml          |   1 +
 drivers/pinctrl/samsung/pinctrl-exynos-arm64.c     | 109 +++++++++++++++++=
++++
 drivers/pinctrl/samsung/pinctrl-samsung.c          |   2 +
 drivers/pinctrl/samsung/pinctrl-samsung.h          |   1 +
 5 files changed, 115 insertions(+)
---
base-commit: 48c4c0b684f394721b7db809e1cc282fccdb33da
change-id: 20250914-exynos9610-pinctrl-b44cdfaeeed1

Best regards,
--=20
Alexandru Chimac <alex@chimac.ro>



