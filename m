Return-Path: <linux-kernel+bounces-745065-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 220DAB1145F
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 01:11:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E75F058854A
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 23:11:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C8C023CEF9;
	Thu, 24 Jul 2025 23:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="do038/Df"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69DA05D8F0;
	Thu, 24 Jul 2025 23:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753398708; cv=none; b=M1M3BmjcUaanZfIbAJoxwVbXVg3OrRFxmYtzJ2Phcsp7osPzqMarP+UGOIjXTQwRwKVBiwVUO4rIhs9sMcqRN5uHBj1vrunVGUMr6/SNXyTh3wmyG6CyulBMNmUXnBp/Qqf8namIPGfdOaeoELLIb8reScT+nLvgSMiEHCSibz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753398708; c=relaxed/simple;
	bh=7tkf0TMKod37/Ao3M7A/563iobABQPRZOnAq5q4tK3s=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Sy2HdipTV1ZOC1m7FdgvcrB7+p1CgvBTBTGGIjnW3txQwsuzgJ/VIeeLlGskP0XYKb+pnAqKI/aIXm1Xsb1VmGYA5vfDLS0YUxHdclR7sL4mWlj57JXx1q9Mjd4UgogZA3MXFo/18XFRMMXE6b9fJ8KjzFYC8TuRYngroS7HixA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=do038/Df; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59E9EC4CEED;
	Thu, 24 Jul 2025 23:11:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753398708;
	bh=7tkf0TMKod37/Ao3M7A/563iobABQPRZOnAq5q4tK3s=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=do038/DfNRBwtN0IXDUQ/i/erDExb/ANvB1yCiFIkbweK92H4aTLOMo3yedw4sfeH
	 GrICsdqT30zAVDHXdq3MuglWL67w3mmNng9Tj5rnroZKR+zPrgqVH0RknrlaV/7QIp
	 j4YNKA599+jbdNColj4BJveRXv+7yIkm0mrsbo66dYgxzLgdJQI1/ExQTFQ45bv1v/
	 u/hOfH6QnnPqGCggj1tfnk2vsWeW3WYH8d2EkaC4Eg5NSSsWDDXy6xBvQ6io1kqJgA
	 kVUcWsUsiOSmWqCyGfhhpt8EO8Qiu4GqbN81+9spppQKZJbjPOAu0iziaN+XKq9qG4
	 9xX2pde8tI+oQ==
From: Mark Brown <broonie@kernel.org>
To: shengjiu.wang@gmail.com, Xiubo.Lee@gmail.com, festevam@gmail.com, 
 nicoleotsuka@gmail.com, lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com, 
 linux-sound@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
 linux-kernel@vger.kernel.org, Shengjiu Wang <shengjiu.wang@nxp.com>
In-Reply-To: <20250710030405.3370671-1-shengjiu.wang@nxp.com>
References: <20250710030405.3370671-1-shengjiu.wang@nxp.com>
Subject: Re: [PATCH 0/2] ASoC: fsl_xcvr: get channel status data in two
 cases
Message-Id: <175339870611.186504.5168876077229345217.b4-ty@kernel.org>
Date: Fri, 25 Jul 2025 00:11:46 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-cff91

On Thu, 10 Jul 2025 11:04:03 +0800, Shengjiu Wang wrote:
> There is two different cases for getting channel status data:
> 1. With PHY exists, there is firmware running on M core, the firmware
> should fill the channel status to RAM space, driver need to read them
> from RAM.
> 2. Without PHY, the channel status need to be obtained from registers.
> 
> Shengjiu Wang (2):
>   ASoC: fsl_xcvr: get channel status data when PHY is not exists
>   ASoC: fsl_xcvr: get channel status data with firmware exists
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/2] ASoC: fsl_xcvr: get channel status data when PHY is not exists
      commit: ca592e20659e0304ebd8f4dabb273da4f9385848
[2/2] ASoC: fsl_xcvr: get channel status data with firmware exists
      commit: 6776ecc9dd587c08a6bb334542f9f8821a091013

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


