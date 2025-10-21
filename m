Return-Path: <linux-kernel+bounces-862757-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B3159BF615D
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 13:37:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 605EB18C2D71
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 11:37:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAF2432E73A;
	Tue, 21 Oct 2025 11:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JodrGLj1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2134032E6B6;
	Tue, 21 Oct 2025 11:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761046634; cv=none; b=mjijr2vzMZVkFwiMeDK6H4BTjPb1kMwm317PGf2mNqwON+/jWmQb3FfhlTECwlbP0y1tEJ+SvsvtmvhGsQBMFg1LibF+et9lR1VpLoGUgUMoQImCyc0DF0cxZcOD9Ruy4s0ZSaC7vlgTX7ofYM2CIwB01ebmq6yCUhRvE+TTsBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761046634; c=relaxed/simple;
	bh=RlkCTDql65n6/dfuVmL3SXT+xYEU6ySwbqkXPFREyUQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=iOEgHtUItM9m7xf8CQiXf8Y3oO2TWCmdObYcRVaA2XOanN7Ez53QBK1PDaClKrEL7Y3DqWmP0rUAxLccd61stIAs5NmU3eCWpmhJgMXl8jtzakkHEPCnHA8b5dNEpUgKbolxXJR2bCNjhGALwUZJMcFkv7H+6NNCRvNvkF82Jw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JodrGLj1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F30D5C4CEF1;
	Tue, 21 Oct 2025 11:37:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761046634;
	bh=RlkCTDql65n6/dfuVmL3SXT+xYEU6ySwbqkXPFREyUQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=JodrGLj1QM2OH0M7SWnkFVjOly9/4KMGlo/09ymwSlKDQCb9t3DY6CtSax2mgGvLi
	 qmu4Z+T2eRuBhJem1Lb4u8XI3vrEgSIcflsxZ1jLqGHFUivCXIUyP60sx4cPWs2eX5
	 G5IZ2j7ykVMYtOFg2svM8lVf5zNJx7Lxl40um4TfjQEZO99lQANXqEkRYUO8Y5yPW+
	 7flWmTGcViMxUKQgNLpE3bW+zPEIMkmuGgqFaCBnvRIcKTnxgsZuS4Z5c8+l42jHJ3
	 kLIlejesCsE5LyInBkbuKLRrdMpfTIWddjaFeQzWKqruOtjnVRC88zHJX4tleY8/ir
	 w4F5RbgLDaFew==
From: Mark Brown <broonie@kernel.org>
To: Simon Trimmer <simont@opensource.cirrus.com>
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, 
 patches@opensource.cirrus.com, yung-chuan.liao@linux.intel.com
In-Reply-To: <20251016112601.187020-1-simont@opensource.cirrus.com>
References: <20251016112601.187020-1-simont@opensource.cirrus.com>
Subject: Re: [PATCH] ASoC: Intel: soc-acpi-intel-ptl-match: Remove cs42l43
 match from sdw link3
Message-Id: <176104663272.21978.4717954267043604617.b4-ty@kernel.org>
Date: Tue, 21 Oct 2025 12:37:12 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-2a268

On Thu, 16 Oct 2025 11:26:01 +0000, Simon Trimmer wrote:
> Removing this match entry ensures that a PTL system comprising of a
> cs42l43 codec on link3 will use function topologies.
> 
> Previously the behaviour would be use the monolithic topology associated
> with this codec match table entry in preference to function topologies
> and if the system had a number of smart amplifiers then they would not
> be instantiated.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: Intel: soc-acpi-intel-ptl-match: Remove cs42l43 match from sdw link3
      commit: 3bcdbc221d676f871e23da30fd485a76728f55c7

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


