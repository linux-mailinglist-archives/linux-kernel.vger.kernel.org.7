Return-Path: <linux-kernel+bounces-874188-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8E90C15B7A
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 17:15:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B0E054008BF
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 16:10:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EAA4345745;
	Tue, 28 Oct 2025 16:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tqg9kxBv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D17823451D1;
	Tue, 28 Oct 2025 16:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761667794; cv=none; b=ldJtfhpypuMeEcRQr8z+nlwKQSYtsMpnfQ3nzkTvEVdmY8xONWg7V/blPibY0TxyIuxB0YRPXPqp/Qx1gyB8NRkV9QloZfJ+mrS5YjiSBdtSszvygsMr5V/n4R9U+hSbGYaFeO28+Gzy6k7+4wAaqd1u28VxSb2sEBWdo3FtR3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761667794; c=relaxed/simple;
	bh=NBCh9XbPVaZkWy/2QcQDmc6lAF4u8bfwRyApCiGC49A=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=cjabLecEibSmO53Ym9q3fmt/AQE33e5LuAyeSpCXCQZeHfLstN6G9sqmhQxzla3N7ynB7yjOjWKtoWa7q1UCdPHomNUtqQfCZ/WS8ubs9K7r9PPoqp2jYB5ddST075eqBrtarSkOaN2QKI7nmSTCxpcgzpeN/2uGWiLrIb6c+hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tqg9kxBv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21BA5C4CEFD;
	Tue, 28 Oct 2025 16:09:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761667794;
	bh=NBCh9XbPVaZkWy/2QcQDmc6lAF4u8bfwRyApCiGC49A=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=Tqg9kxBvRCaGxfSH2hzcbcuK5i7h89Hr0zI9rfNjYicd6UwYE8db08iFFXGCNxH2J
	 1L58tQCHLQKw0ren3Wwm4Mg58qySPUaxxN4yWPbDUrMsBFciNzKkwhgeKM3okcYnNz
	 gcyNG9apoBRJOl/Bf3hAWHUot3r7lygWpGZkjYBMR9krmjuJOc+LYMud3MPAk5kUCa
	 VM5rh0dqXGcJJflGl4U0phuXSAzjmqTwIFGaiZWXd9XVETgYrMQqUs9dSvPc+fHcM4
	 NfkdoxX10IcEGdEchnEjYr2JIl85g6/KG0ZeuEh4V2Tp9z6cXt6sjpJXdRiPSE/nR0
	 L3LSwYahVdpPQ==
From: Mark Brown <broonie@kernel.org>
To: Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Vitaly Rodionov <vitalyr@opensource.cirrus.com>
Cc: Takashi Iwai <tiwai@suse.com>, Jaroslav Kysela <perex@perex.cz>, 
 David Rhodes <david.rhodes@cirrus.com>, 
 Richard Fitzgerald <rf@opensource.cirrus.com>, 
 Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, linux-sound@vger.kernel.org, 
 linux-kernel@vger.kernel.org, patches@opensource.cirrus.com, 
 devicetree@vger.kernel.org
In-Reply-To: <20251023090327.58275-1-vitalyr@opensource.cirrus.com>
References: <20251023090327.58275-1-vitalyr@opensource.cirrus.com>
Subject: Re: [PATCH v6 00/12] Add support for Cirrus Logic CS530x DAC and
 CODEC variants.
Message-Id: <176166779189.143847.17303624768770218391.b4-ty@kernel.org>
Date: Tue, 28 Oct 2025 16:09:51 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-88d78

On Thu, 23 Oct 2025 10:03:08 +0100, Vitaly Rodionov wrote:
> This patch series introduces DAC, CODEC, and SPI control bus support
> for Cirrus Logic CS530x variants, along with general code cleanup
> and resolution of checkpatch.pl warnings.
> 
> Changes since v1,v2,v3:
> 
> - Signed off all patches
> - Splitted "tidy up" pach in 3 separate simple patches
> - Fixed commit subject to much preferred subject prefix for binding patches.
> - Moved dt-bindings related patch down the chain
> - Added all relevant maintainers to CC list
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[01/12] ASoC: cs530x: Update the copyright headers
        commit: ca4d49f8a21c37be7e5aed80100ca6b13ac3cf9d
[02/12] ASoC: cs530x: Sort #include directives and tydy up whitespaces
        commit: 1e0722a77b4e263854a812c9c106ddef8fd56720
[03/12] ASoC: cs530x: Remove unused struct members and constants
        commit: f97ebfda8da28a77a0218a448829451ba7e30d5d
[04/12] ASoC: cs530x: Correct constant naming
        commit: ddbcd2f396116581ad035fb76a99fc2ed865a85f
[05/12] ASoC: dt-bindings: sound: cirrus: cs530x: Add cs530x
        commit: 9957614d2b79578b6f9a2512bfbb2bc7bbdc43ce
[06/12] ASoC: cs530x: Add CODEC and DAC support
        commit: c63b2315b9cc6b705205c73dcf4591cfeb9a25ae
[07/12] ASoC: cs530x: Rename bitfield to reflect common use for ADC and DAC
        commit: 3941abb26ff327e53e1e8b873cab3ed3d5103eab
[08/12] ASoC: cs530x: Check the DEVID matches the devtype
        commit: c37c3e5e390dcd52cbe6178ac53f5a6131ef6f8c
[09/12] ASoC: cs530x: Correct MCLK reference frequency values
        commit: e7ab858390f24a23ba0827066382ba0e6a8e4379
[10/12] ASoC: cs530x: Rename i2c related structures
        commit: 38ff69586bbb3a823dd501972e17075374b685a1
[11/12] ASoC: dt-bindings: sound: cirrus: cs530x: Add SPI bus support
        commit: bb65cb96f64e9b4ea2bbd41e4591f3da91414fdb
[12/12] ASoC: cs530x: Add SPI bus support for cs530x parts
        commit: e7434adf0c53a84d548226304cdb41c8818da1cb

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


