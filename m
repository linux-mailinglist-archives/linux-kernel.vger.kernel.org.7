Return-Path: <linux-kernel+bounces-886402-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5894AC357B0
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 12:50:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0933E624613
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 11:44:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4873E3112C0;
	Wed,  5 Nov 2025 11:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IenRHymy"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E6412C08B0;
	Wed,  5 Nov 2025 11:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762343042; cv=none; b=CRURYxoZnncMkGP+G8mZ0fXKN3RJxdYCvid6sHgSCxaPArtXbvPr5ceLdzHvYFrbbdP10pb6ZUXrg8GcAeCuhsJfEUdQTwPjY9e5oSqr4XEBUYjdRAZGg0mnhsozG/+irQQGyzRCWpAERLYCq7DgIl5cf9fxkqp+DxMZer4GC9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762343042; c=relaxed/simple;
	bh=lsKdS2/RgYDLurMVzKpoUTZ9hMpJVA/+yKedZERoEbQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=PFPNrwJaGyHxWBKwxsDbUVIwE2lhNBIDAxMJF6kF7LFSxf5u8nJEHKqejNpzRUURWXNv4bezbiOwjhvlPbftAvaXlOhSsnAD1FPRIAfeJ4is2HCskZjEu5Tpe5vRsIoJ8ABlzdyCjm10OgiGhzJvp+9XQ6CTCK4nMw740/RWXKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IenRHymy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6F1CC116D0;
	Wed,  5 Nov 2025 11:43:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762343042;
	bh=lsKdS2/RgYDLurMVzKpoUTZ9hMpJVA/+yKedZERoEbQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=IenRHymyvP37MS9PUGM89sMnSa0qyGoNDa9zPAZIIGmn1lqiSyvPgT7iIfkAr6fVc
	 JWGlgCA8v4pR1bvpXfdhpJBfoKvzOAxciBDVPdT1HzH2Jwb4xHAgsU0mXVluXSda0N
	 9m9BR2KQ2dXr00cb1umLf24Qy6izc5u4jz0vUvyrW05et1ZKdebh8UhaZUtljEYLvU
	 dAUa8b7YKwrV642IBPx0ZstVFwa+6T7w+oRzFWd2+KbFMnx5sQqexJp+6iznqe1zgr
	 TMgL0C51WadetlSnQ2XSwo/Y4S/3jzN1YppSzqRw43IKff1et0lX+ZRSI6HL+ZQTY5
	 2wJvHCpzVD0hQ==
From: Mark Brown <broonie@kernel.org>
To: tiwai@suse.de, Baojun Xu <baojun.xu@ti.com>
Cc: andriy.shevchenko@linux.intel.com, 13916275206@139.com, 
 shenghao-ding@ti.com, linux-sound@vger.kernel.org, 
 linux-kernel@vger.kernel.org, lgirdwood@gmail.com, robh@kernel.org, 
 krzk+dt@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org, 
 k-yi@ti.com, henry.lo@ti.com, robinchen@ti.com, jesse-ji@ti.com, 
 will-wang@ti.com, jim.shil@goertek.com, toastcheng@google.com, 
 chinkaiting@google.com
In-Reply-To: <20251104041314.792-1-baojun.xu@ti.com>
References: <20251104041314.792-1-baojun.xu@ti.com>
Subject: Re: [PATCH v1 1/2] ASoC: tas2781: Add tas5822 support
Message-Id: <176234303679.2251668.8971844792881190697.b4-ty@kernel.org>
Date: Wed, 05 Nov 2025 11:43:56 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-a6db3

On Tue, 04 Nov 2025 12:13:12 +0800, Baojun Xu wrote:
> TAS5822 has on-chip DSP without current/voltage feedback.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/2] ASoC: tas2781: Add tas5822 support
      commit: ecaba8b7990d8c6d8ba097cd4499b3b92d9df6ea
[2/2] ASoC: dt-bindings: ti,tas2781: Add TAS5822 support
      commit: c4e68959af66df525d71db619ffe44af9178bb22

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


