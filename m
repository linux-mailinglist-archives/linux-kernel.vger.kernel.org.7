Return-Path: <linux-kernel+bounces-867791-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CA76C03812
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 23:14:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D61CA3B33CD
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 21:14:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 467FA296BC3;
	Thu, 23 Oct 2025 21:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uXc5VAGy"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EA40254AE4;
	Thu, 23 Oct 2025 21:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761254061; cv=none; b=GYYBxxxzsVA0v0UH3i5N2XbknuOiZ81UvndjBHAR9tKwhhUGpfD+grdzj+2zPEPEfuq97Sl5oGjSPhvXLmEP9gEj0g4RxtLlY5SDFt4CjzfQNWm8FX1kHTOdhFW6jgyCaEkWueU9H2wCBPds4YqEnpL34MnjrkMa9TB4sfc2EMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761254061; c=relaxed/simple;
	bh=wbkNBMIZ6jB8PHwxsS3CPuYPXG0TkXccuiVzpdAw1Rw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Woclu7JDcRtmRxe2bGdUF62OgvbyOHg0jjvwIz0vgu3S12VpCQcUo3SF5BfSnA926w+bG+gjB/g+ED596T17RjnDk2Ib0U1oEZO2TiUpOqw8Z3V2vEJktyzrIY4RwmFnKtPf5qdoNk9rcyrhHwEvPLiYCXZWfY9reoAB63qsQqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uXc5VAGy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D162C4CEFB;
	Thu, 23 Oct 2025 21:14:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761254061;
	bh=wbkNBMIZ6jB8PHwxsS3CPuYPXG0TkXccuiVzpdAw1Rw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=uXc5VAGy6Qh4nlLaNesi8kKyhhPkyrSPzmpW5+g6s1O7HowK/rPStGj8eMfmPM4ph
	 CFNNanD9GSMiKNMLOyIFiIUJnKwhGpaVH7J25ZvWLlbkzaCJD9lGSXzhldxn31pERz
	 t1CEC/Lv0l88pGda5Dfcfr5dGrn5z/ga3zHbBnpSxPjTc2zV+SwwHO8+ovcCWF/LLA
	 7Ay9Tg0Qos8DYrQid/wr020rlv45Qd6wTtaGOkVy8bgXEXE3/widDH6LG0Au2U2I2n
	 UmhF5uNi9SeboTwljJ+hYnK5/nrZEUOQOHEYJQVmcgU6LVTsYsRRevUijBWPUFaHwG
	 bFpxwFDlz18Yg==
From: Mark Brown <broonie@kernel.org>
To: Liam Girdwood <lgirdwood@gmail.com>, 
 Peter Ujfalusi <peter.ujfalusi@linux.intel.com>, 
 Bard Liao <yung-chuan.liao@linux.intel.com>, 
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>, 
 Daniel Baluta <daniel.baluta@nxp.com>, 
 Kai Vehmanen <kai.vehmanen@linux.intel.com>, 
 Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>, 
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
 Chen-Yu Tsai <wenst@chromium.org>
Cc: sound-open-firmware@alsa-project.org, linux-sound@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 linux-mediatek@lists.infradead.org
In-Reply-To: <20251023061226.1127345-1-wenst@chromium.org>
References: <20251023061226.1127345-1-wenst@chromium.org>
Subject: Re: [PATCH] ASoC: SOF: Fix function topology name check in profile
 info output
Message-Id: <176125405790.267603.9724280623055175546.b4-ty@kernel.org>
Date: Thu, 23 Oct 2025 22:14:17 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-88d78

On Thu, 23 Oct 2025 14:12:24 +0800, Chen-Yu Tsai wrote:
> The function topology feature, and the plat_data->machine field that
> specifies this feature, is ACPI specific. The check didn't take this
> into consideration, which causes a NULL pointer dereference splat on
> OF platforms:
> 
>     BUG: KASAN: null-ptr-deref in sof_create_ipc_file_profile (sound/soc/sof/fw-file-profile.c:291 sound/soc/sof/fw-file-profile.c:340) snd_sof
>     Read of size 8 at addr 00000000000000c8 by task (udev-worker)/247
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: SOF: Fix function topology name check in profile info output
      commit: edf5c8920240dcafe830908549a0edee4ba3b4b0

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


