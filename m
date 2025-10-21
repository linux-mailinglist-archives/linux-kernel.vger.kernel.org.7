Return-Path: <linux-kernel+bounces-863552-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 1198DBF8255
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 20:52:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 96FBD4E5F77
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 18:52:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19ECB34F260;
	Tue, 21 Oct 2025 18:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gk4o0HYa"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71E3934E74E;
	Tue, 21 Oct 2025 18:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761072731; cv=none; b=o46AM1MyXTz2G4TdTgug+C7qexcnjefW0vYCyTnViTmpiEDqI4bPAFMSLUBdznvLtCepE3+gLEgb1yMjg4XK2noZREnf58LND0PKXQNx5Cd150Y9YmgG+x+VZqgl50p8VRMISd8Tjlyiy57iZNLk5nPU2p+mjLy1jX6TiIQb+0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761072731; c=relaxed/simple;
	bh=yNkG7ZzinMmGtAhlYEBlmZAUPPIXSbq0G6OAdHc/ueg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=omtOFyCyJZc9zCRioG77fZvl0w3VVtXfVJUaqQ/ztkm2a98kRm+lWl+hyA15tdyq7iCN4vcGFE3ia98wQJtfBKmg+N9/bimiGKAXSWwxQySy35zL9krrtkuXyZYxAB6PMdLzQFBJfBxDaWFGi5AVwy43OYOfNGNx/ToiAGJHZwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gk4o0HYa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F112C4CEF5;
	Tue, 21 Oct 2025 18:52:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761072731;
	bh=yNkG7ZzinMmGtAhlYEBlmZAUPPIXSbq0G6OAdHc/ueg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=Gk4o0HYax0+LUrmFlkmdc7tK/D/VSLQS08JY96NX0mkIfde+aHIQRhoIjny8L/VMB
	 3Z3IcftD+nluMUqah35IowMhhqncjOQX+kylNdXzZXHLC/HYMvZ9jSxTmcIYcfjCCa
	 j0ixVWFHZdlB/dGcVwmR+stUTMv4/45WHh0clS3LKkCXqEZECZr2J4BbHNEVKzve5v
	 QuhonieFiO9i9wRlVyz06x5enGKqffzfi1t7Fi/LMUu4C27Fr4NjwtZ4HZQEHgY0hC
	 eMbnpAxe9XnlXvQAsJ//uJpMVaWQwSYndrJjxCSI3qosp8fka8Mdp5URQ9JuTbp4Ia
	 HfNkVhwcFVIEg==
From: Mark Brown <broonie@kernel.org>
To: Simon Trimmer <simont@opensource.cirrus.com>
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, 
 patches@opensource.cirrus.com, Vijendar.Mukunda@amd.com
In-Reply-To: <20251016150649.320277-1-simont@opensource.cirrus.com>
References: <20251016150649.320277-1-simont@opensource.cirrus.com>
Subject: Re: [PATCH 0/2] ASoC: amd: ps: Propagate the PCI subsystem Vendor
 and Device IDs
Message-Id: <176107273005.196841.13422542346665726617.b4-ty@kernel.org>
Date: Tue, 21 Oct 2025 19:52:10 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-2a268

On Thu, 16 Oct 2025 15:06:47 +0000, Simon Trimmer wrote:
> This chain of two patches propagates the PCI subsystem Vendor and Device
> IDs so that they can be used by component drivers to differentiate
> firmware loads.
> 
> Simon Trimmer (2):
>   ASoC: amd: ps: Propagate the PCI subsystem Vendor and Device IDs
>   ASoC: amd: amd_sdw: Propagate the PCI subsystem Vendor and Device IDs
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/2] ASoC: amd: ps: Propagate the PCI subsystem Vendor and Device IDs
      commit: aab1301cfde344f966bbc442a4e655867ab56768
[2/2] ASoC: amd: amd_sdw: Propagate the PCI subsystem Vendor and Device IDs
      commit: 6658472a3e2de08197acfe099ba71ee0e2505ecf

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


