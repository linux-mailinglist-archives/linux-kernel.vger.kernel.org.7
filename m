Return-Path: <linux-kernel+bounces-834048-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A1DA9BA3AE2
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 14:50:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 339AD1BC04EE
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 12:50:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0873D2F5462;
	Fri, 26 Sep 2025 12:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I9Ivljue"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D11A1397;
	Fri, 26 Sep 2025 12:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758890998; cv=none; b=p44R1xiEi4Uw5hBalPisDDuDeq+ig/w8emV9xi1LwivHFxmJk6CoHBM9CJ5Vh99b41hVDSursQk6kKcBf6rlXhjk+/SnogLzrQxTBmQh8cF/GWjG7AQMMq7+LvVLfhg++rJy8aNsbScMHaSYKWM1Qbi3Obg13p/6dAa+pjeXAUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758890998; c=relaxed/simple;
	bh=LRp+NHgfq1T5GTdEXyErwid4rR/OhAtZmsWAHaC92ls=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=YhNhBI2uLomuJv+GBQFWcfm76PPZaF3AaMK2AvjmC1KolwiiFxw9fKM/Wqvyaq2JTLL51ea2dqAEPSPTMK1nQ/ASRjO6qn5gBui2ofQyJuxIqDLWuG9PcZLESkWy3XUBllh7DOUVALdTm2hHgnwY2mXh95MGKG25dKYWIXR/0MQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I9Ivljue; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A88DC4CEF4;
	Fri, 26 Sep 2025 12:49:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758890997;
	bh=LRp+NHgfq1T5GTdEXyErwid4rR/OhAtZmsWAHaC92ls=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=I9IvljueSF/vf5zELujgtFSQUjJksSRzP404oHQNvM2A9ySUb+BsVABPzjPsitQFR
	 X+Jv1Bz5XAh2lVd3QpSJjlKW7Bq4FljUttnE++JPwgUsVJ/Fmly1RNqT+CeflbfynU
	 YgLY8+2FrUWitKnaBcxxb8b6Z17P3an8frq+eJfBZVITco/r6e1z7lzT4zlZDHFuzL
	 kyKFPViVB89ILuPTcW4tX7Au0LIf9s0oad5t59tEPcgmRTzD5DbPPNPNgJWWsSWJrC
	 +1uUSPw5wRIVp6xqmYUByajUxufLXBoYzUQv7/gZje8RuPpVtjbEoPrNYUCbazpsrh
	 YhQ76qG/xuTZQ==
From: Mark Brown <broonie@kernel.org>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Stefan Binding <sbinding@opensource.cirrus.com>
Cc: linux-sound@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, patches@opensource.cirrus.com
In-Reply-To: <20250912104612.361125-1-sbinding@opensource.cirrus.com>
References: <20250912104612.361125-1-sbinding@opensource.cirrus.com>
Subject: Re: [PATCH v1 0/2] Support reading Subsystem ID from Device Tree
Message-Id: <175889099612.84679.9251858819850677029.b4-ty@kernel.org>
Date: Fri, 26 Sep 2025 13:49:56 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-56183

On Fri, 12 Sep 2025 11:45:36 +0100, Stefan Binding wrote:
> In PC systems using ACPI, the driver is able to read back an SSID from
> the _SUB property. This SSID uniquely identifies the system, which
> enables the driver to read the correct firmware and tuning for that
> system from linux-firmware. Currently there is no way of reading this
> property from device tree. Add an equivalent property in device tree
> to perform the same role.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/2] ASoC: dt-bindings: cirrus,cs35l41: Document the cirrus,subsystem-id property
      commit: f8673e4069b2032bf9f854bae818a7bdbdca7520
[2/2] ASoC: cs35l41: Fallback to reading Subsystem ID property if not ACPI
      commit: 46c8b4d2a693eca69a2191436cffa44f489e98c7

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


