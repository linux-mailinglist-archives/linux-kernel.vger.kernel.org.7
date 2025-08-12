Return-Path: <linux-kernel+bounces-764838-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BB7CB227CC
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 15:09:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EAF781BC478F
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 13:01:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 437AC27E1A1;
	Tue, 12 Aug 2025 12:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GxIrNfy/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E30E27C17E;
	Tue, 12 Aug 2025 12:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755003529; cv=none; b=f4a1HUlAvgZmR0t6jUARky8msfH1RNwycmkPalXH5z8GwhUeXM7BP1wGQ4Et8SFoJWgBZ/HdtaxbHyrfwu1i1PosSPJgNK7TpIIXvu2RpMSiG9Zu15kzIZ5O2HQMJRIB1bMPiLiOezhY3PWTlIYmRmikKMFUi2nJkzsXu+wgnOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755003529; c=relaxed/simple;
	bh=auJ4UCOYqu+Cyrj4Xt+shRCFXAxSa8EAUPDWJRJ1GYE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=cyVJuw/mkYzNdD1MXPU5GAqkqbjrTfrLjQLiKEt54OpulqLeYq7pG0GO/EiX0Z0q8FIdcC1v98V1xXlMZNfN6M8TOCOCKgaSWw1t2rkvK+LBF6UT3kOPXHt71b+y9crdxleTtEVZSTw1hiOdnMLJoxbDeTi/weIQp9wtZ6J3Ifc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GxIrNfy/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 488CBC4CEF5;
	Tue, 12 Aug 2025 12:58:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755003529;
	bh=auJ4UCOYqu+Cyrj4Xt+shRCFXAxSa8EAUPDWJRJ1GYE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=GxIrNfy/52USCUUs4tL4CxRNcGeuTLwNIlkLzoWZGaFmpxWADiVnghi/0/G8d3330
	 1ti4Sf0ac8tCWKO/4BDZPsq7YIlCAqU89kBbb1McuxVzAQgQ5VxhXLgRvQXlUDCpLM
	 QZ1EB1iuisBYSm30EcNxCQPhFr0s6R6eMpuzQBoynSr7ZuiDrLZq0RqiDti47wBZVU
	 e4OdMydFNGtgPNG99YHoQLo6PZsYSTlBqdjWS99bPVIqICPHaDir6fJKQdVwgmOVBO
	 +w/En6Gt5PdktwMMj9RSaXv6KeLMF5U4fQggfs7pei5XbG8+ENUekHwv4NpEqWygFx
	 sPdFyX7Zp+/0g==
From: Mark Brown <broonie@kernel.org>
To: Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Joy Zou <joy.zou@nxp.com>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 imx@lists.linux.dev, Frank Li <Frank.Li@nxp.com>, 
 kernel test robot <lkp@intel.com>
In-Reply-To: <20250731-b4-pf09-v2-v3-0-4c2659516582@nxp.com>
References: <20250731-b4-pf09-v2-v3-0-4c2659516582@nxp.com>
Subject: Re: [PATCH v3 0/2] regulator: add new PMIC PF0900 support
Message-Id: <175500352702.61648.1681084828187836719.b4-ty@kernel.org>
Date: Tue, 12 Aug 2025 13:58:47 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-cff91

On Thu, 31 Jul 2025 18:44:40 +0800, Joy Zou wrote:
> Add binding document and driver.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/2] dt-bindings: regulator: add PF0900 regulator yaml
      commit: 82f0907931f016c04bcb992f764bd65992c7008e
[2/2] regulator: pf0900: Add PMIC PF0900 support
      commit: 162e23657e5379f07c6404dbfbf4367cb438ea7d

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark


