Return-Path: <linux-kernel+bounces-790629-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB3FBB3AB13
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 21:46:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 374F23B5C28
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 19:46:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D868281529;
	Thu, 28 Aug 2025 19:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uneBhP9H"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8AC027F195;
	Thu, 28 Aug 2025 19:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756410397; cv=none; b=egP4GZ2IXPuZRBkqBbNmdOwMZa6JmnptqdQypey5XzKj6nrORI4sZhXmDt6A87fHIZMacmf0FQ1/tbhTw9qqRDBeX9q145A865B4/rZAPDcwzwyFZiKTHYpAER1jBr/3gsAU6muRhGNUNTqwkVboKaF1FeopLN1FPkYJmIaQyjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756410397; c=relaxed/simple;
	bh=x6ixxhsYHHLE+m/qEma56rx6FpFeK6tgm/KddRFJrCg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=QwcZnGaDLGKFddJdb0D8gL5C19XG3k+jeKZxCyGYFIqN7MQSb97uddB4M6heSn0O55c+9phMR8uXq3B6epDeUJ4DkDvw0diMLcu3IrnPa1KuL+eji2HhCtduAEVVFuFJNB84Rszb6NYKt+IuWJauzbSlx4brs4wkR/SQW548upg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uneBhP9H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4D96C4CEF4;
	Thu, 28 Aug 2025 19:46:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756410397;
	bh=x6ixxhsYHHLE+m/qEma56rx6FpFeK6tgm/KddRFJrCg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=uneBhP9HSnclCFXA+e5QFMYUXf763HeCHa5cRD80T6WBXHDV3h5w7FVv9GtTFsdsE
	 /+PNvJUQ4JLXJTw6tfDz/dG1qF07PLY7HzB6prz7FAh8HhTt9/5WYuwXSUJWVQM5uk
	 2E5GKpPYkGkftCmEPILCdaO0u5ZX1k0Sl+l69jjvv6rmlFUJIgoB/GoO+OMKn8EZ9V
	 zWt2yGy2HbuVemj6l2/arkA83L2L2MaD68FoOuTFOqnX0ySJI1HQb7CntKJX8Yd29R
	 429fEWrMPL5pUajBoAKHkpYQSS2H6IVonQ/gohInImGabNEdPS0jqMz0Vz5KHdNI55
	 5Ce0IVwMei0gg==
From: Mark Brown <broonie@kernel.org>
To: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, 
 Takashi Iwai <tiwai@suse.com>
In-Reply-To: <20250826132734.278226-1-andriy.shevchenko@linux.intel.com>
References: <20250826132734.278226-1-andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v2 1/1] ASoC: amd: acp: Remove (explicitly) unused
 header
Message-Id: <175641039546.360532.14325528755095946571.b4-ty@kernel.org>
Date: Thu, 28 Aug 2025 21:46:35 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-a9b2a

On Tue, 26 Aug 2025 15:27:16 +0200, Andy Shevchenko wrote:
> The fwnode.h is not supposed to be used by the drivers as it
> has the definitions for the core parts for different device
> property provider implementations. Drop it.
> 
> Note, that fwnode API for drivers is provided in property.h
> which is included here.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: amd: acp: Remove (explicitly) unused header
      commit: 5b4dcaf851df8c414bfc2ac3bf9c65fc942f3be4

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


