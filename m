Return-Path: <linux-kernel+bounces-780420-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 84E57B301AF
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 20:04:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 84F6060639F
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 18:03:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18C8E1EB5C2;
	Thu, 21 Aug 2025 18:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t98mUctK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A7A32E54BA;
	Thu, 21 Aug 2025 18:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755799386; cv=none; b=k4l8Zz1UcdHAKeEqvHGToHvpHESIMCZ3vLMdTB8tOid62UX78s/Ov08UymtVty7b6EBdm8s+djtgOl/AuO/Xdmeq2zSv8Jv4SGmGDPtr22R5Ea09ZbD0yNlI9rXU02f5ZdyBO3LwjWZiFryj3JFT50IxbURRZFqZDmm/6jLRhYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755799386; c=relaxed/simple;
	bh=+hDXx6EahSKYVsdXiGT3+Ns+DUu9UsAG4PZJGUJkP0g=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=eZ7iuj7mdkhG3rgozYZSF5XnWqsyRoC4i+NDkZ15gF4AIVpLpVMDYVWredqeVnO6wOAmxWjoJAFkD0bP9ls/sVv+soU5Bk6wyu+k53RKZ4zRPvNLu0XypYn3sPoM7R+SLJsVzD/DlCZi/uYiFabgRRTDipN+4ICHnE5f0QzDltc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t98mUctK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29C69C4CEEB;
	Thu, 21 Aug 2025 18:03:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755799385;
	bh=+hDXx6EahSKYVsdXiGT3+Ns+DUu9UsAG4PZJGUJkP0g=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=t98mUctKHD1oOF0o5AWMTF9AQJoF4WI4IREfvuF3AQiB0ayUU6J4Pn9hDdCWX8boD
	 GEouHkX4VCwM4OyHFomAj33UceHHnhgDt6WN0Tkl/BNyT0XDr98HrcHAHoWTGijh6W
	 Qk1uyow4jPKJzIQWCNn66b6mqjwEqi8vfW0gtnIXIHSJkDZugdZLIm/Y+gk/UjBeWR
	 mWLyQDngm600t4DXZtxIR9/WZTpg1TLbiMNBuCFif/VlfwSa/mvchEmljX0GQti8xC
	 UUFoYi3carqbNFgZHOCN99yn+QlYlo4pJZkqGZeEqBKXTrcaM918c0Lsc9HqdacnE9
	 rbeTHN4vnbwFA==
From: Mark Brown <broonie@kernel.org>
To: Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Shengjiu Wang <shengjiu.wang@nxp.com>, 
 linux-sound@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20250821083100.46340-2-krzysztof.kozlowski@linaro.org>
References: <20250821083100.46340-2-krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH] ASoC: dt-bindings: Minor whitespace cleanup in example
Message-Id: <175579938289.113971.15653749852299099860.b4-ty@kernel.org>
Date: Thu, 21 Aug 2025 19:03:02 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-cff91

On Thu, 21 Aug 2025 10:31:01 +0200, Krzysztof Kozlowski wrote:
> The DTS code coding style expects exactly one space around '='
> character.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: dt-bindings: Minor whitespace cleanup in example
      commit: d78e48ebe04e9566f8ecbf51471e80da3adbceeb

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


