Return-Path: <linux-kernel+bounces-790736-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 26FC0B3AC65
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 23:05:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 125E35E2413
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 21:05:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D8E72BF019;
	Thu, 28 Aug 2025 21:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rdA/75WB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7644299A94;
	Thu, 28 Aug 2025 21:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756414846; cv=none; b=A58QWyJJAUFDFiiT/72MDuO+iT+N3ppzbIJSr8msZZzoJyv4p86mPFREkqvA9JWubj8KCk2XKmFguqNmdhU/p4dRbPY1h7OavE7PKUKoH8nJVtMvEza/pbPY1Z09SxuxFbSdOxjOgQfZ8z0XDZVWQJnyXLXxNihCN+HKhHfMXLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756414846; c=relaxed/simple;
	bh=DBqonvOBX3w3IDOnQXMbogNECNQyWjuUr8rsLhJyhRA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=UKomqCtuxpBcwdGuOaFgVB2U475hSUbdW0564c6KNeqpIhBckHvghZG9TaF6hPas/Fr1j7vsERZUJmN8m9XTA2biYYpIiJPwKN6bL1bziu1/EYnTHi9XV13wedPShEqznCRI/MkaPsyCZHasHs/k1WJQx7M+DYqjjRc0Zv4RIuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rdA/75WB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A897CC4CEF7;
	Thu, 28 Aug 2025 21:00:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756414846;
	bh=DBqonvOBX3w3IDOnQXMbogNECNQyWjuUr8rsLhJyhRA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=rdA/75WBM4hHEo0XpwbWVjyWp3DsPu55VC6rkwIIVbbjuGGGClDjVBUW5ou9/O4Lq
	 a5CVttdnKzhA11++fzqJsG0ScBl7Gd0lpcVyqe8W9Bys+CZ9SnMzfDoc686mWOAu4M
	 w3EV0//N8sJmXjEY4ezmaNKdzJ/NCMZc5n9iFFY9p/2m/I2XgkO+RlYcbQktVyaeob
	 69FbfNxvho1rBLaGdN1PKiHA2eL/yI0anvRATMAW66L0CxvFHJRxq8NzxtN2bAtM7l
	 i75yFqQrC37plZiu2qtdgTeRlEHQC1vj2Dng+MgK26kDfmagA4ZInZqYczOB5wZf+j
	 d42hXS7OiYUUw==
From: Mark Brown <broonie@kernel.org>
To: linux-kernel@vger.kernel.org, 
 Ajye Huang <ajye_huang@compal.corp-partner.google.com>
Cc: linux-sound@vger.kernel.org, 
 Bard Liao <yung-chuan.liao@linux.intel.com>, 
 Peter Ujfalusi <peter.ujfalusi@linux.intel.com>, 
 Jaroslav Kysela <perex@perex.cz>, 
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>, 
 Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, 
 Daniel Baluta <daniel.baluta@nxp.com>, Mac Chiang <mac.chiang@intel.com>, 
 alsa-devel@alsa-project.org, 
 Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>
In-Reply-To: <20250826154040.2723998-1-ajye_huang@compal.corp-partner.google.com>
References: <20250826154040.2723998-1-ajye_huang@compal.corp-partner.google.com>
Subject: Re: [PATCH v3] ASoC: SOF: Intel: WCL: Add the sdw_process_wakeen
 op
Message-Id: <175641484343.364214.13960933303240952309.b4-ty@kernel.org>
Date: Thu, 28 Aug 2025 23:00:43 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-a9b2a

On Tue, 26 Aug 2025 23:40:40 +0800, Ajye Huang wrote:
> Add the missing op in the device description to avoid issues with jack
> detection.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: SOF: Intel: WCL: Add the sdw_process_wakeen op
      commit: 3e7fd1febc3156d3d98fba229399a13b12d69707

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


