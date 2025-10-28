Return-Path: <linux-kernel+bounces-874190-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B5D5EC15B95
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 17:17:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 33316188BC12
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 16:11:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBE10346763;
	Tue, 28 Oct 2025 16:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="my88TeD2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AE9A345753;
	Tue, 28 Oct 2025 16:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761667796; cv=none; b=LRMwViAe2ReZVKX4wfWrlDdczGTTr3wV2WzVTcKIYT1jrsGMYJH+2ui+vDJtV/p7Qzqa2dCq4IdskWV9ezlbP5Ygbw4wZEE2pfBHcVOhSj9D5uqeeXhvCOROLC8UEa5kuZiyM/SkQvfhHdA2xZZjhj3AvRKK/sOCLlvS57gsMmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761667796; c=relaxed/simple;
	bh=vCdR3/rZz20yMOq7v/d2UI1upiB2Yl6XUmdojd8yJmg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=brBdO+YmLwMBnJ0K3XjcOHUDvDMf7v97WNL0+Nh33lA9rsMid6XUzMTvYKErXnPPSFmuATHVnhiOCUryaXaVikfg06pm5pj9PrT5xEEJJnpcHENDgKvRTSQgFwQWItl/hQ/8a9hsYK2wr8r8oJEBRBuWN9ypuec08wg715ueVRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=my88TeD2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5A90C4CEE7;
	Tue, 28 Oct 2025 16:09:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761667795;
	bh=vCdR3/rZz20yMOq7v/d2UI1upiB2Yl6XUmdojd8yJmg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=my88TeD2/GWGKsOFoX4u37HOUHcRL31zjYBNFecsKUHHnPN2xvonRf+8rdyUzJdev
	 iN3MbI5+SX5JO1fwY7XIjlwmTgPCRZ6ruC05YGiSkx82SbFNmCtQdjirnqaxHe3Yb7
	 mqwhbds5QYQH+sTX9RjBC3bEg1lOkU1DE7Pu1piGb5m8Pe8J3JZmGSbvgyC5mpCwVv
	 MDj7PwovIsL/wm++m1uxnV4+AgTuvFuTNHUc9DCzPPyBBkwqeXcHY5XV7cNdeWaNpA
	 b+ilYbmXFz0jf1FxELheIipIQ3JtukuYmLSSQgCAyM6CkQV0AktG374uL7MhN8BL2H
	 0J36McFSg1VLg==
From: Mark Brown <broonie@kernel.org>
To: tiwai@suse.com, Richard Fitzgerald <rf@opensource.cirrus.com>
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, 
 patches@opensource.cirrus.com
In-Reply-To: <20251021105022.1013685-1-rf@opensource.cirrus.com>
References: <20251021105022.1013685-1-rf@opensource.cirrus.com>
Subject: Re: [PATCH v2 00/11] ALSA: cs35l56: Add support for factory
 calibration
Message-Id: <176166779456.143847.13511200470716720703.b4-ty@kernel.org>
Date: Tue, 28 Oct 2025 16:09:54 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-88d78

On Tue, 21 Oct 2025 11:50:11 +0100, Richard Fitzgerald wrote:
> Until now, all products with an amplifier supported by the cs35l56 driver
> have shipped with Microsoft Windows pre-installed. The factory calibration
> of speaker protection has therefore been done using the Windows driver.
> 
> However, products that ship with a Linux-based distro must be able to
> perform the factory calibration procedure from within the Linux-based
> environment. This patch series adds that support.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[01/11] ASoC: cs35l56: Read silicon ID during initialization and save it
        commit: 1afc05996299b4546e8be9b13c89f78e19912c7d
[02/11] ASoC: cs-amp-lib: Add helpers for factory calibration
        commit: cdd27fa3298ad2f39788804f7d09ab31af2b416c
[03/11] ASoC: cs35l56: Add common code for factory calibration
        commit: f7097161e94cd39df7a8848ad0de5f394124ed69
[04/11] ASoC: cs35l56: Create debugfs files for factory calibration
        commit: 191a27faf53edf9e9101901e402bfee49c44073c
[05/11] ALSA: hda/cs35l56: Create debugfs files for factory calibration
        commit: 46a3df50b0cab466099515f2375b01c5be4fb95c
[06/11] ASoC: cs-amp-lib-test: Add cases for factory calibration helpers
        commit: cf6290eebe3cc4eb677d11aa061d10cb1df12ab9
[07/11] ASoC: cs-amp-lib: Return attributes from cs_amp_get_efi_variable()
        commit: 959400caf51eb31f95d1ab754a285b5546ebd3e4
[08/11] ASoC: cs-amp-lib: Add function to write calibration to UEFI
        commit: 2b62e66626f05e277c8fdeb50d4c1e0cbab2fe0e
[09/11] ASoC: cs35l56: Add calibration command to store into UEFI
        commit: ef24466ee1912997c2bd526194006bbca424c24f
[10/11] ALSA: hda/cs35l56: Set cal_index to the amp index
        commit: 64670a6c062c4d183c366d46e71ee76395af6a15
[11/11] ASoC: cs-amp-lib-test: Add test cases for cs_amp_set_efi_calibration_data()
        commit: 4795375d8aa072e9aacb0b278e6203c6ca41816a

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


