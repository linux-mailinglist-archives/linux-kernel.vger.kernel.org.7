Return-Path: <linux-kernel+bounces-818730-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F1ABB595C5
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 14:08:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F3443A762F
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 12:08:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01E0A30597B;
	Tue, 16 Sep 2025 12:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Uqcs0zHp"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55EF12D7DD1;
	Tue, 16 Sep 2025 12:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758024525; cv=none; b=q3kYsPW+eWs9mT1ZmWkOekAeMJJZAAmTr075ad80tdWh5/QJ3KhWh1axvJ1opful789xzJLHSieGR7Rj01zyDT8ETe+woivDlm87j+jJWcj7oR8mBYxCFumI7Qfl92j1LDcXzWu/pmdOOJ1ns3B4Oi1ZMrmhNbfySaotk53dgFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758024525; c=relaxed/simple;
	bh=U7SC1k5KPIcZxsGktmNWNgubheJii36rNFKNHf1Xwn0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=H6hT4deD1wIb4g+mqTT5xmoZMLMqZRmmSAZ9Ra8PhpjgWWBwhP9EsQeBaHE4LxapG4JMwi8cOJvhPOGt33hgnwb5IZggd8YYSLnXgHxTZ0mRfdzG4NQ6YrRS4/agv/SrSToIGoYP0r/LoM+lk5Cx9oLKIDQ9xuPZX4ZtYnyn+ek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Uqcs0zHp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5B79C4CEEB;
	Tue, 16 Sep 2025 12:08:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758024524;
	bh=U7SC1k5KPIcZxsGktmNWNgubheJii36rNFKNHf1Xwn0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=Uqcs0zHph/O0ZoK7jMzCEchMF5ni535xnLSrqIe1cQIv+XzGBwvOBAQ4Vu7e8NgX9
	 FxUBCLq6vCvIeCgkHYWjc/gkxd+JZHMoYRVQ17Vw7z+/i5uLjXKw/arxLR7TWBSE7s
	 FJPkf8TMspGvNq+c0NhJmYcvpfqJoSV2Z2WEB6uRAUnp5rVF7oECFYKuyPM5J4zJV3
	 wIHC7YkRO+C4KNrRboZGyz5abEs1mZFSU+qml0PHxCWJeD0u1jTUDuvU6ezr+xaLyl
	 mY+jdODeLC9QHaqOUx7b0VmM7weHf8euGobU6i3STUvckPR/ckXK+Vd9xPNe/DJNOP
	 obmdM8NAH/Dog==
From: Mark Brown <broonie@kernel.org>
To: alsa-devel@alsa-project.org, 
 Venkata Prasad Potturu <venkataprasad.potturu@amd.com>
Cc: Vijendar.Mukunda@amd.com, Basavaraj.Hiregoudar@amd.com, 
 Sunil-kumar.Dommati@amd.com, syed.sabakareem@amd.com, 
 Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, 
 Takashi Iwai <tiwai@suse.com>, Greg KH <gregkh@linuxfoundation.org>, 
 Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>, 
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>, 
 Peter Zijlstra <peterz@infradead.org>, 
 Daniel Baluta <daniel.baluta@nxp.com>, 
 "open list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." <linux-sound@vger.kernel.org>, 
 open list <linux-kernel@vger.kernel.org>
In-Reply-To: <20250909061959.2881158-1-venkataprasad.potturu@amd.com>
References: <20250909061959.2881158-1-venkataprasad.potturu@amd.com>
Subject: Re: [PATCH] ASoC: amd: acp: Fix incorrect retrival of
 acp_chip_info
Message-Id: <175802452167.111062.11810975142265512120.b4-ty@kernel.org>
Date: Tue, 16 Sep 2025 13:08:41 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-56183

On Tue, 09 Sep 2025 11:49:50 +0530, Venkata Prasad Potturu wrote:
> Use dev_get_drvdata(dev->parent) instead of dev_get_platdata(dev)
> to correctly get acp_chip_info members in acp I2S driver.
> This resolves issues where some members were zero due to incorrect
> data access.
> 
> Fixes: e3933683b25e ("ASoC: amd: acp: Remove redundant acp_dev_data structure")
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: amd: acp: Fix incorrect retrival of acp_chip_info
      commit: d7871f400cad1da376f1d7724209a1c49226c456

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


