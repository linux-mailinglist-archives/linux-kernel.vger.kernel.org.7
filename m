Return-Path: <linux-kernel+bounces-796671-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D5BFB405CE
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 15:58:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 00DD3547F8C
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 13:53:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCC3B306487;
	Tue,  2 Sep 2025 13:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qqzbf9uf"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ACDB307491;
	Tue,  2 Sep 2025 13:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756820944; cv=none; b=D1veWVq+81M/fMdNBfmVW7Rr2T00dyue4v5yYdQpF8DAP1pqvAuLrazpnqt3wCGnkY2iylDAuDdxgw1jmqd6BIczNwOrdMr15fXrxn2Ew3vmbXYIrzzoiU8bWb13cqxJ+i68LuaHS67H5r6GHZR/xzXnLMz1ouRvKrMxyOhOTF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756820944; c=relaxed/simple;
	bh=V1zLEZ4hN381aE4lKsa730pV/g0bYjO1juxY8tem70k=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Ce37Xh7k1JcDzT/Ue7+eswURWsdM2HRMAFyutw+HyPz5aVcV7Nv90pZJ85TFyYru/8AS7vMiHsqWOh3Zd7fJqZ6kTZ9r26Whm1Qnq5LL8jOqkREVWwXbhIT0vgxifIL8l1mHR2nRPBCFhr6UdfdvUr7RGvEqrqHAfCPoeE8fFuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qqzbf9uf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12345C4CEED;
	Tue,  2 Sep 2025 13:48:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756820942;
	bh=V1zLEZ4hN381aE4lKsa730pV/g0bYjO1juxY8tem70k=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=qqzbf9ufGxmR3PVYR/LPBelK7aOXmQMhg4IMCyYnBx2UUJmdZodBtug5Y4k6QB7cg
	 jde6Cg+sGSNjqGxDkhSjZD8BrgvDtoM1kYPp0tfKSsIMRrp6jYFnkw9uinWoAq8ajc
	 Ap/kvMWHOk6MidWgMyvbThZswRb0KzPFjRsWPYHuQSor7s7mgZ5i5uVj/+eJqlwku7
	 /rdTcqTultaBP0/o8IQkVVGNsA2Ri5f3tuxi2ExHjz2vtiDXtm21aDnQ17X84lXfRI
	 7URxM7NrEQH0P7eTb5iXJfVHCkFKEt6jtKE4jP5XPDztYVeRNDaLGlxqWtYDJRj1yJ
	 yOIMgdS+MdNXg==
From: Mark Brown <broonie@kernel.org>
To: Liam Girdwood <lgirdwood@gmail.com>, 
 Peter Ujfalusi <peter.ujfalusi@linux.intel.com>, 
 Bard Liao <yung-chuan.liao@linux.intel.com>, 
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>, 
 Daniel Baluta <daniel.baluta@nxp.com>, 
 Kai Vehmanen <kai.vehmanen@linux.intel.com>, 
 Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>, 
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
 sound-open-firmware@alsa-project.org, linux-sound@vger.kernel.org, 
 Colin Ian King <colin.i.king@gmail.com>
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250902083213.2620124-1-colin.i.king@gmail.com>
References: <20250902083213.2620124-1-colin.i.king@gmail.com>
Subject: Re: [PATCH][next] ASoC: SOF: ipc4-topology: Fix a less than zero
 check on a u32
Message-Id: <175682093980.530139.13776765985476213880.b4-ty@kernel.org>
Date: Tue, 02 Sep 2025 14:48:59 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-cff91

On Tue, 02 Sep 2025 09:32:13 +0100, Colin Ian King wrote:
> Currently the error check from the call to sof_ipc4_get_sample_type
> is always false because a u32 variable out_ref_type is being used
> to perform the less than zero check. Fix this by using the int
> variable ret to perform the check.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: SOF: ipc4-topology: Fix a less than zero check on a u32
      commit: 3279052eab235bfb7130b1fabc74029c2260ed8d

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


