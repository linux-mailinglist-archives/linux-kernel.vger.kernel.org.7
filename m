Return-Path: <linux-kernel+bounces-828848-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F693B95A0F
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 13:25:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 10BE0173CA4
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 11:25:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AFC1321F22;
	Tue, 23 Sep 2025 11:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o1kLbdEN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB9AA2F6184;
	Tue, 23 Sep 2025 11:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758626716; cv=none; b=Z/9OaFbplC2SPS/+PGDJdY9pvKxbYRXiGiOQFR/NPzLTt+nNndmaHocR/K8bPBDJiN/3XqkwKlEo/gHZOUrbseMIcRwcAcPYrxXS+IptwYV88J8UW7FIgWozNZW4XStp5u7Du9XuWb0e0cfOiSs/4ePynI1ZwAMTubg2/LIG6LA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758626716; c=relaxed/simple;
	bh=NmwI2i0bURbIKcnCM3VKAQjFFdrwiZKZPxEcH894L3s=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Y5eR8mj9MAKHtz0SOzEfWO20hs8iOkVQE5PU3OP6WvMNvgkU2uVKvuvpsDF3l4MCTuLJPfhXf6CgkAMj2s9EfZF6MVHk0gAkFsNK3iYvUt3B9NFA3mP41CeJUdb2rccrzmuxwZHsPmWaRu6nek0rV19CB34BzA5moFd4tfvq6TI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o1kLbdEN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 887BCC4CEF5;
	Tue, 23 Sep 2025 11:25:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758626715;
	bh=NmwI2i0bURbIKcnCM3VKAQjFFdrwiZKZPxEcH894L3s=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=o1kLbdENWhP0e6VT2wR73tft/YfR4rcw/IUzjUuodFvWFCjwj2IY8HYZcq+fB0b05
	 XY1SRhU5rTE0Gkl/9yub3aCmUqAHPBnpaG82L+gGDO7aCUIaF093Xf9pNLbhSB0hYQ
	 +jsTuX2R7Yv6kV+j6Aa+zsHhAdpZLA/MH5dCKbmXLEsHYcLwRxULBRg34dV85znMMx
	 hL5oQTVsv8vkteRcW6dcQuFKNKLVCIPNlLoGSA2ghY8wROasOhvH/MKlJVIXI1OXud
	 A2WB4yp8ygIx7CY82a2PdyTxBd/Kom0PigmxxGaSNK0/ToFqaMp0p4pef5mwtV2u6/
	 Zyvx3aY3koIIA==
From: Mark Brown <broonie@kernel.org>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Stefan Binding <sbinding@opensource.cirrus.com>
Cc: linux-sound@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, patches@opensource.cirrus.com
In-Reply-To: <20250917153722.94978-1-sbinding@opensource.cirrus.com>
References: <20250917153722.94978-1-sbinding@opensource.cirrus.com>
Subject: Re: [PATCH v3 0/2] Support reading Subsystem ID from Device Tree
Message-Id: <175862671323.1039471.10731453002758041713.b4-ty@kernel.org>
Date: Tue, 23 Sep 2025 13:25:13 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-a9b2a

On Wed, 17 Sep 2025 16:37:10 +0100, Stefan Binding wrote:
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


