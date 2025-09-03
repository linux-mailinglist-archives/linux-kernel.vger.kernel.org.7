Return-Path: <linux-kernel+bounces-799436-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 45F28B42BC2
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 23:23:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 11B0D540016
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 21:23:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 522FD2EB5B0;
	Wed,  3 Sep 2025 21:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ShGCTxeB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A76BE2D3748;
	Wed,  3 Sep 2025 21:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756934577; cv=none; b=E7GI4ERHIvqXczhSUSAGWZKx7kZIV8ZjihssClL762RQOE4FxpAPwi1E5AA7FEKdEnxdXbCoj8Mw9SBSBxZ9GMXtJg45TITueQ/BwOpvJxqcLqXTQb8j751RLAP6abP0TIkgKVav9kC/5Q0rKLleMHwU+voYaJjPjMcGxqwmAZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756934577; c=relaxed/simple;
	bh=oYD045PFx4IfNHTb8kF36GnmgwvDxgzMVkLuEyhReU0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=HpT72vcT8pLzxM8oY34Yw7dP3SlrP74geTc+9iIW49kM4JBMYsWstPxfcWcs74ynMrQLHQnowF7CcQ7kJVJ/d+3dLgzd2I7mdfyIVxoE+t578vuVCckwN13UahJRhspf54jAKH1ft0uwf/kdXJPTU/wRFUMccyJch7dh1F+lhoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ShGCTxeB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E705C4CEE7;
	Wed,  3 Sep 2025 21:22:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756934577;
	bh=oYD045PFx4IfNHTb8kF36GnmgwvDxgzMVkLuEyhReU0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=ShGCTxeBX/lrduwrXSmirkUcRIIJNOmhZB3TUI7soO7c+0TjrVEzVz/rw+2CBhw/Z
	 IQsBXLo6GDRyJhX2HzKaWtUX8v7h148A0qnCwBsYOW9ViCIlbFxGk/eMzjU9gC/Orf
	 V/f53B4JkxYn6Z66HEUYRjIUc1MCG1Lt2xrC2XliV1rLSUbwTD56QjKrYxTZX/KzqY
	 iGdBYeHKALKaHpv14sMbgwIABax3STRcDPR+G2kbOHaOSBBq5SpgDHVkpUzqsp9Pzs
	 b5HeXZ8481m3g++GKFAIUm2xkVOuBk6nGFhfZvi6Yk7rV1VvoLQ6qenDq84gUhYtyW
	 rZ/9ZBgr5fwYA==
From: Mark Brown <broonie@kernel.org>
To: alsa-devel@alsa-project.org, Syed Saba Kareem <syed.sabakareem@amd.com>
Cc: Vijendar.Mukunda@amd.com, Sunil-kumar.Dommati@amd.com, 
 Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, 
 Takashi Iwai <tiwai@suse.com>, Bard Liao <yung-chuan.liao@linux.intel.com>, 
 Charles Keepax <ckeepax@opensource.cirrus.com>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>, 
 Venkata Prasad Potturu <venkataprasad.potturu@amd.com>, 
 Peter Zijlstra <peterz@infradead.org>, 
 "open list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." <linux-sound@vger.kernel.org>, 
 open list <linux-kernel@vger.kernel.org>
In-Reply-To: <20250903171817.2549507-1-syed.sabakareem@amd.com>
References: <20250903171817.2549507-1-syed.sabakareem@amd.com>
Subject: Re: [PATCH] ASoC: amd: amd_sdw: Add quirks for some new Dell
 laptops
Message-Id: <175693457437.292968.9677235604719840326.b4-ty@kernel.org>
Date: Wed, 03 Sep 2025 22:22:54 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-dfb17

On Wed, 03 Sep 2025 22:47:47 +0530, Syed Saba Kareem wrote:
> Add a quirk to include the codec amplifier function
> for Dell SKU's listed in quirk table.
> Note: In these SKU's, the RT722 codec amplifier is excluded,
> and an external amplifier is used instead.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: amd: amd_sdw: Add quirks for some new Dell laptops
      commit: 3254959b4dd065eae396cf78ccc1361460b2f53e

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


