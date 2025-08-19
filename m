Return-Path: <linux-kernel+bounces-776433-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CAFD5B2CD41
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 21:48:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 151951C27E37
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 19:47:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DB932848B5;
	Tue, 19 Aug 2025 19:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kLwueoPd"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6376525A34F;
	Tue, 19 Aug 2025 19:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755632816; cv=none; b=cUWvG/wyzc9X2MLmOKzMkdTCrEA/01aTDknbyPeMhNW6D+GFSozxuHDkirDlWPto2U05T2EHQxflKacc0XO/R8MP8Pxz4DSlCWxrRCumToTjsXYSPw+icXNVpkRykeN+6aJBrscQ9OWjsCSF++C/S7/yTuqP18ZkVJOR/+XM6Sg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755632816; c=relaxed/simple;
	bh=buCW/ZOs+zjtU8+u7JC48cij7cEtXIqatCc1jur/KTA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=TI+0AeIoWY0VDPGqDaklwCCmkCkCnO+LGEbcqDllZFZI9ZDUdoccr1edrA47GR8SRuoJnNG4dzp3qaHJVS8GetIPcUPnuACcNuvs7dgm+IPGpMC+R1YkkvDFwq5u6DSVEgri9JeaAK60hPB69YdZXQWi3wMq5KD9SnXH3Zac+T0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kLwueoPd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85C9EC4CEF1;
	Tue, 19 Aug 2025 19:46:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755632815;
	bh=buCW/ZOs+zjtU8+u7JC48cij7cEtXIqatCc1jur/KTA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=kLwueoPdpn/IT5tnlDGf/QqhxLe47X03Kl8uZwmPtYyybGRL+aGdGPMhdOkWiWrcc
	 lWE5mxd8oVQ7j1UCTyFmYAbnUZAZU/MY2pQuu7jDt0GxTBK+8uvON6iPNU1IG31AVF
	 cSpjEIcrzoMp6PhMDuvfcqgu5zQpWwFq0eM88u4BGhV3tDDSLs7hSPa/0h6qzjgKzJ
	 lcjtvTQjs4xCwhfev/9FavNMlW104WNKnwnRunhgevTA1l5eu+oUYboQtoXOu6Cg4d
	 uf5/zmEYmSIVgQo2/JabDET910rfq6mTAwYLyxmC7GpjtUBsiFz5nifnTbGhYLx/C4
	 M+j114rj8jUFQ==
From: Mark Brown <broonie@kernel.org>
To: lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com, 
 Shimrra Shai <shimrrashai@gmail.com>
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org
In-Reply-To: <20250815042023.115485-1-shimrrashai@gmail.com>
References: <20250815042023.115485-1-shimrrashai@gmail.com>
Subject: Re: [PATCH 0/3] ASoC: es8323: power and mixer controls cleanup and
 revision
Message-Id: <175563281428.270039.6714574776717315231.b4-ty@kernel.org>
Date: Tue, 19 Aug 2025 20:46:54 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-cff91

On Thu, 14 Aug 2025 23:20:20 -0500, Shimrra Shai wrote:
> This is a revision of a previous patch submission of mine wherein one
> part was accepted and one part was not. It was originally phrased for
> a particular device using the ES8323 CODEC, and I was advised to make
> the mixer controls user-selectable so it was not tied to the needs of
> any specific device. This submission brings the DAC and mixer controls
> for basic audio playback on this CODEC into line with the DAPM
> infrastructure and enables their operation through the standard mixer
> interface.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/3] ASoC: es8323: remove DAC enablement write from es8323_probe
      commit: 33bc29123d26f7caa7d11f139e153e39104afc6c
[2/3] ASoC: es8323: add proper left/right mixer controls via DAPM
      commit: 7e39ca4056d11fef6b90aedd9eeeb3e070d3ce9f
[3/3] ASoC: es8323: enable DAPM power widgets for playback DAC
      (no commit info)

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


