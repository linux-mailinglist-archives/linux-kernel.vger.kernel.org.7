Return-Path: <linux-kernel+bounces-824561-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25686B898CB
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 14:54:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA67E6219D1
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 12:54:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B1A3238C36;
	Fri, 19 Sep 2025 12:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p8T4+LPr"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB4C82356C6;
	Fri, 19 Sep 2025 12:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758286442; cv=none; b=SxUKI8G6bfSq6/Qcdvsf5TiWX6IqI4X9OFsryhHCNsRLKQ3Lj/wJqXEqDAzWPVob88F3ppXGXsK/P4ByRMKBseJv9bpMr2m1AOko6dP+7yjwb8juF+UWVSodG/coD0WUQROz9Pi50qnRXmmXvVNziExwzH/wjFJMcpXKxw20Wwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758286442; c=relaxed/simple;
	bh=1pfZgGzNVtn0yABMX7hwUhOXHqmt1khayMvA9KMbUsA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=enOf6h2vag0RchXHHgXUK5YQjmQKbqpZ1j2N9MWrluU0/nedjYXVoH+ElAFdUrhcz6Upgbq4/nwC/qFtLmPqStqYVu95QP4ia6lqqyHkoJRswMtP+tiWSPem4L8TWxwN0vS/GClz/JxAJMePckmCdRjaCUtvJDEUKV0It2oWGio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p8T4+LPr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA8CBC4CEFB;
	Fri, 19 Sep 2025 12:54:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758286442;
	bh=1pfZgGzNVtn0yABMX7hwUhOXHqmt1khayMvA9KMbUsA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=p8T4+LPrhdJj5Duof9QvtkvUewrLT7QKstuFUZFwoUgWL3d86Fcy8aBZsLApyPrIV
	 gn+npxGwewAWxoWNFy8Wd39olzrswZUqM/5+wI8W+WaKyncLy9hO7/vOMRhsTKkKW9
	 ms2iExHNBnNKw8Ws7RaM/1senuunK7PZr7egiStzNXZKsSL3pVhaVw+9G9+uYOVUN7
	 MFH4MA7FtUZMjA/13S3ziBnxlEjKx28z6YuAvW1nuQrtZdlZpKEDp2ytInYESGtXzE
	 hTPvXJVd82HMAzniuGi8IBS2vUxLPG7MzYicBunhkLmSeAUTmBgCztrY4B//UVnaip
	 SeGHbCiblUSxg==
From: Mark Brown <broonie@kernel.org>
To: peter.ujfalusi@linux.intel.com, yung-chuan.liao@linux.intel.com, 
 ranjani.sridharan@linux.intel.com, kai.vehmanen@linux.intel.com, 
 Richard Fitzgerald <rf@opensource.cirrus.com>
Cc: sound-open-firmware@alsa-project.org, linux-sound@vger.kernel.org, 
 linux-kernel@vger.kernel.org, patches@opensource.cirrus.com
In-Reply-To: <20250819160525.423416-1-rf@opensource.cirrus.com>
References: <20250819160525.423416-1-rf@opensource.cirrus.com>
Subject: Re: [PATCH] ASoC: SOF: ipc4-pcm: Fix incorrect comparison with
 number of tdm_slots
Message-Id: <175828644050.102649.9531212152341579882.b4-ty@kernel.org>
Date: Fri, 19 Sep 2025 13:54:00 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-56183

On Tue, 19 Aug 2025 17:05:25 +0100, Richard Fitzgerald wrote:
> In ipc4_ssp_dai_config_pcm_params_match() when comparing params_channels()
> against hw_config->tdm_slots the comparison should be a <= not a ==.
> 
> The number of TDM slots must be enough for the number of required channels.
> But it can be greater. There are various reason why a I2S/TDM link has more
> TDM slots than a particular audio stream needs.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: SOF: ipc4-pcm: Fix incorrect comparison with number of tdm_slots
      commit: 62a7b3bbb6b873fdcc85a37efbd0102d66c8a73e

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


