Return-Path: <linux-kernel+bounces-767418-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A5D8EB253FC
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 21:35:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 059231C83964
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 19:35:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B3A62C21F6;
	Wed, 13 Aug 2025 19:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DmOBO6JJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB0AD256C88;
	Wed, 13 Aug 2025 19:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755113693; cv=none; b=MEKHxczRqiz8hgQLANTtEEs35MTTNBSQaPZmIWAYBkW2q4yTvrupxVMJsdV0ZFwHbu4GmDMECMG88vjctN/FWT0UGVOVXEpUMvroUX83/C7nXdR9svu2KTbNmSjfQi/ijWmjkZdCp9k3/JQjRWY3nLBwnDR2628M6uzdBg/crFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755113693; c=relaxed/simple;
	bh=ouxbFcVrUS9hvxkMdGRbOfAKnaBDJG/JEQxiQR2jMWo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Z2W/CQrNti4EPXTSooQd27eMqkGc1oxk7nHpVzsVCL7utvu4fZO8Ps+6HfEMUwCMCJpddUvO+WBzHC6deTV4ou/UDSqUst95SGvoYhJQ4Bd8eQdrCxxQ+f+ukQ9DxzwkNyZtNKnSC7dgvL0TZvflEpx3lQy1Hnl5kJSkiyTwmro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DmOBO6JJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F38C1C4CEEF;
	Wed, 13 Aug 2025 19:34:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755113693;
	bh=ouxbFcVrUS9hvxkMdGRbOfAKnaBDJG/JEQxiQR2jMWo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=DmOBO6JJETxAhR0VJijHavL/SKMgHxEADMQxsONS1H1Zt09SSiRETXQfY+a7uRy1C
	 lYPfKF4GxN/+fh0dO7ooDwiMrWBqYN9k5wiZlBcCgCgJd5XO4ilR0RGXTQK0tkr2y+
	 JFpycRB7EGSjnmAd4AxlFDt+n4OO7b3k+wwpf+AkRp878rcps8ggcCqs5kR33ARA13
	 +rbdKe89aJ7WGsxpm25x21zTLUGs20cOPN8kaYGCZivYi4HcbXRbAbv249J6PQLUcD
	 t+uP+cEhZWgGZ353Sq5+2Akj5nJ1nKPqDoP+WbRPQ8RiVrgQ7FfhvYnMNPRfnZXZqS
	 VFr7sh4pOj7IA==
From: Mark Brown <broonie@kernel.org>
To: Baojun Xu <baojun.xu@ti.com>
Cc: tiwai@suse.de, andriy.shevchenko@linux.intel.com, 13916275206@139.com, 
 alsa-devel@alsa-project.org, shenghao-ding@ti.com, 
 linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250813100708.12197-1-baojun.xu@ti.com>
References: <20250813100708.12197-1-baojun.xu@ti.com>
Subject: Re: [PATCH v1] ASoC: tas2781: Normalize the volume kcontrol name
Message-Id: <175511369173.254480.2972663584944434542.b4-ty@kernel.org>
Date: Wed, 13 Aug 2025 20:34:51 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-cff91

On Wed, 13 Aug 2025 18:07:08 +0800, Baojun Xu wrote:
> Change the name of the kcontrol from "Gain" to "Volume".
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: tas2781: Normalize the volume kcontrol name
      commit: 47ed64db8c17eb16541098add865178fb7e68744

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


