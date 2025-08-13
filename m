Return-Path: <linux-kernel+bounces-766976-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A86E5B24D5D
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 17:29:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 38EEF3B4938
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 15:25:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C02652356BD;
	Wed, 13 Aug 2025 15:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r4ckmFCQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27A02233711;
	Wed, 13 Aug 2025 15:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755098703; cv=none; b=UZg7UTRRS3HVY9ncabX5SlFeT+YfifXIW2x+n+/xKfhps8739RXt5kDB5DvzZqlSZdMxbv9IxHLxAyH5n2NAKg9nkTR1HNPQChgfVT4Ustxuc+LIE2ZiptjpaQh5wNdR6um08LTAPZsbazk5GpclulUCp6V5OdU8/DqsVViGe9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755098703; c=relaxed/simple;
	bh=LdAz9HA7k6Mt25X/eHpKDCXmwzoxWWS687VHIRULmMg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=s5NXOhfHAwn3Pff+nfG7TwlrypVGUCLOKA5VPFAhTFaiC7e7vgpT2tjY+AmmfyFHHcCOKy3kKhiPlOASnxWBbtkgwFN9CIZW+GPXpiH4hhyD+vbQquZoawsMrBiNJqX3ZlW3lmh8qhHIOkD4sm0FWVS16Za1v7CqZjhP9ptMDr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r4ckmFCQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3409AC4CEF6;
	Wed, 13 Aug 2025 15:25:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755098702;
	bh=LdAz9HA7k6Mt25X/eHpKDCXmwzoxWWS687VHIRULmMg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=r4ckmFCQpZxJwlBCMQ1MTH3dUfeWYXjMjIgmYwqYGghN7KIwb8wEmJoirY2fAeKXQ
	 4+/hhdzd2N6jzGyIRue8f8ilS6uutUSsC32x92wB2akSX2QLX0PlzBTecZCVJSNvd+
	 y+3TqJx+YX4SCjKBWiwTRmdISCNR2XhaOEwt4b5Vl5JayH0034EnX0nDdv5ERVdFYk
	 gFKhIBEM1GdxrYMSMGUoshlYMMNuuF/vfSoHF4LHtg/qjRzmxFVEH2QoCHwmM3E/9Q
	 EHvwdCwMOSmT4g5C66HVYVapRnhU/1hMqKGvYHyBpW3SLP8Uc54EBT4xhc2z4fzc0l
	 Mc8Jnq75QhfNg==
From: Mark Brown <broonie@kernel.org>
To: lgirdwood@gmail.com, robh@kernel.org, krzk+dt@kernel.org, 
 conor+dt@kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, jeff_chang@richtek.com
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20250813020910.2977555-1-jeff_chang@richtek.com>
References: <20250813020910.2977555-1-jeff_chang@richtek.com>
Subject: Re: [PATCH v7 RESEND 1/2] regulator: dt-bindings: Add Richtek
 RT5133 Support
Message-Id: <175509870096.77898.4938265555323697090.b4-ty@kernel.org>
Date: Wed, 13 Aug 2025 16:25:00 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-cff91

On Wed, 13 Aug 2025 10:08:50 +0800, jeff_chang@richtek.com wrote:
> Add bindings for Richtek RT5133 IC Controlled PMIC
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/2] regulator: dt-bindings: Add Richtek RT5133 Support
      commit: d0de6895095356f1cc2d5f9825df220f10d34cee
[2/2] regulator: rt5133: Add RT5133 PMIC regulator Support
      commit: 714165e1c4b0d5b8c6d095fe07f65e6e7047aaeb

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


