Return-Path: <linux-kernel+bounces-757717-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 18888B1C5DE
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 14:31:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0795C7A8FDD
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 12:29:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFDBF28A3EC;
	Wed,  6 Aug 2025 12:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PEiz7hM4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B886228BAB9;
	Wed,  6 Aug 2025 12:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754483472; cv=none; b=e5UA+xjCT5IzJAC2h4DpWlIpKgfcNk1BVQ4G8YeBViolISuZ7YruFjzKYBilf8TQdkOzLVTyhHiBr9Ek1s/lWEZ8lulnY0uzLBK+vYmsi47U6us0MXjDxUSk/WmxCMTbzgrwP9UDWKvwaIm4WO0busvY297H1Dq07GIZaD8oMII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754483472; c=relaxed/simple;
	bh=FKdyRWwzqXaF6ZtDiJsHCZwmwHHIK1mymCHN0JZer18=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=H3qleCgoyPc5AtVzZSwxXXYx5UNeRWyoNcBif1zejXjwaCxJUF3jNIuk+lb/HhHT8KuA3QutWQh+oNt5N9zqg9Ma7fNEvFY8cuyFtMB0QPKa4M1RHvB1ZMZpwZagnan85CljAguZqAS5lQ3mE2RAT+5bROGAfOKHrkiLrcVpN9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PEiz7hM4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18D25C4CEEB;
	Wed,  6 Aug 2025 12:31:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754483472;
	bh=FKdyRWwzqXaF6ZtDiJsHCZwmwHHIK1mymCHN0JZer18=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=PEiz7hM4DtnwF3QkGNsaH/hAGbYekb6lIrmzxi8DCF0FOQk9RFYBaU4IXl01YeEpf
	 o9pZFOt69wV1AjAogvpSE5NOfC7wTrN53Rm7An8BdczB8YXZwo6bpAkXbsywuiLqmA
	 WcOORYXEvv0ZmzJjBjqDsHn82z7c5D9MCsMTaSY5nx0YX9cspXszvbhnjW/8mIkaGK
	 wfFehS4e0ksNPh8/1EHBkZMG2xjMIHBPZcLjuR7w2Uq3AsOOJnS+wGIJf/kMAz5Mo+
	 QcuEpDkkJ8ZaDlkVFJRrX9lc6YnIEPA0266swCf3YyNCfHYlqe7KpqYc/Cb+PmgqKi
	 80Cz/6lSVEB4A==
From: Mark Brown <broonie@kernel.org>
To: cezary.rojewski@intel.com, Peter Jakubek <peterjakubek@gmail.com>
Cc: Liam Girdwood <liam.r.girdwood@linux.intel.com>, 
 Peter Ujfalusi <peter.ujfalusi@linux.intel.com>, 
 Bard Liao <yung-chuan.liao@linux.intel.com>, 
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>, 
 Kai Vehmanen <kai.vehmanen@linux.intel.com>, 
 Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>, 
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
 linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250731172104.2009007-1-peterjakubek@gmail.com>
References: <20250731172104.2009007-1-peterjakubek@gmail.com>
Subject: Re: [PATCH v2] ASoC: Intel: sof_sdw: Add quirk for Alienware Area
 51 (2025) 0CCC SKU
Message-Id: <175448346880.51650.10478557821363425570.b4-ty@kernel.org>
Date: Wed, 06 Aug 2025 13:31:08 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-cff91

On Thu, 31 Jul 2025 18:21:04 +0100, Peter Jakubek wrote:
> Add DMI quirk entry for Alienware systems with SKU "0CCC" to enable
> proper speaker codec configuration (SOC_SDW_CODEC_SPKR).
> 
> This system requires the same audio configuration as some existing Dell systems.
> Without this patch, the laptop's speakers and microphone will not work.
> 
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: Intel: sof_sdw: Add quirk for Alienware Area 51 (2025) 0CCC SKU
      commit: 1b03391d073dad748636a1ad9668b837cce58265

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


