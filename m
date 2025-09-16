Return-Path: <linux-kernel+bounces-818731-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B61C1B595C8
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 14:09:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3EDCE7A9C99
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 12:07:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00A7030CDA2;
	Tue, 16 Sep 2025 12:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o0HtcqrN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A9AE30C62D;
	Tue, 16 Sep 2025 12:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758024528; cv=none; b=eMZOWRoVXNs+M6mXFo2z77Ft3kguuwtstBa+NcjXpBRwGF1tqVwP+hn9n0g6u8rbcy3ljtjcpLUJU6/XR1lANEJuYF4zkKGoKK5Z3/Kmr3o/aRtumdDG5G7WuchJ/4TMKspqXk/eLQKnRB3hMdpWniO5P8mjePM6R557YuF7QFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758024528; c=relaxed/simple;
	bh=vMvpD33/YLHO9mP+Yy3drQPm01ooJcuPvq35U+2+2gE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=aX/IPP/jZce5erUjaOFQDcE2DeDGc++bgYIWPAZraaeWyNb5r8eZnImSzxNfoqlkFGATfv92ZpHT35YvgiXngc+8P6mSco/i2Rgp4b6usCLwY70EXV2xtZzba8pKvVOrUFN8rUhcX5/MA+j9+/QvSNfV99ECx1XLVya+kEwuri8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o0HtcqrN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C8E2C4CEF0;
	Tue, 16 Sep 2025 12:08:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758024527;
	bh=vMvpD33/YLHO9mP+Yy3drQPm01ooJcuPvq35U+2+2gE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=o0HtcqrNBAApCEOpmaZ+//hHcVjvJzF83whiX6m1n1OCE39gbk1J+kWX3otVFgKE+
	 eB7Lr7UNP1WJn2tmRREDTM2C0JYPZWH48iyO0KzAn03KismETEkwu/pBv+KauTuhu1
	 ZJzduduftjNG66A4aUbK7s16qUP6RU2dzm1ptdwKHV1FiVMtx6MrQs3CAkbjxLphdj
	 8S/RcJAj0Lj5V29/dra1KCV9/LVFUdjQDEkpYw7XUPVM/CcVdRedJFks4P7it0W14p
	 kY1AeOeShpCjWpPCTC74LAzOpP+VZp/lsifGtGw2cKcqAOR1qCNX+E0x37IfumIc+Z
	 cI7dJdmb7yx8g==
From: Mark Brown <broonie@kernel.org>
To: alsa-devel@alsa-project.org, 
 Venkata Prasad Potturu <venkataprasad.potturu@amd.com>
Cc: Vijendar.Mukunda@amd.com, Basavaraj.Hiregoudar@amd.com, 
 Sunil-kumar.Dommati@amd.com, syed.sabakareem@amd.com, 
 Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, 
 Takashi Iwai <tiwai@suse.com>, Greg KH <gregkh@linuxfoundation.org>, 
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>, 
 Daniel Baluta <daniel.baluta@nxp.com>, 
 Peter Zijlstra <peterz@infradead.org>, 
 "open list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." <linux-sound@vger.kernel.org>, 
 open list <linux-kernel@vger.kernel.org>
In-Reply-To: <20250910171419.3682468-1-venkataprasad.potturu@amd.com>
References: <20250910171419.3682468-1-venkataprasad.potturu@amd.com>
Subject: Re: [PATCH v2] ASoC: amd: acp: Fix incorrect retrival of
 acp_chip_info
Message-Id: <175802452498.111062.8715620650477854915.b4-ty@kernel.org>
Date: Tue, 16 Sep 2025 13:08:44 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-56183

On Wed, 10 Sep 2025 22:43:59 +0530, Venkata Prasad Potturu wrote:
> Use dev_get_drvdata(dev->parent) instead of dev_get_platdata(dev)
> to correctly obtain acp_chip_info members in the acp I2S driver.
> Previously, some members were not updated properly due to incorrect
> data access, which could potentially lead to null pointer
> dereferences.
> 
> This issue was missed in the earlier commit
> ("ASoC: amd: acp: Fix NULL pointer deref in acp_i2s_set_tdm_slot"),
> which only addressed set_tdm_slot(). This change ensures that all
> relevant functions correctly retrieve acp_chip_info, preventing
> further null pointer dereference issues.
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


