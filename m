Return-Path: <linux-kernel+bounces-893716-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 447E7C4827C
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 17:58:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 42B2A4FE830
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 16:51:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E0E93112DA;
	Mon, 10 Nov 2025 16:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="psB/B+7V"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB353322A24;
	Mon, 10 Nov 2025 16:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762792988; cv=none; b=BjrGznmVwNAKlsvVnUYSIYwix0CMKVNSDpNqJdteefcyTDL8FAPbDn3byKkWzOG31EZa0j2H2skDaNiSSlCHdtRGFWIaLUs6c2llKgkd8xRpdz+hL4qKaLz3zuo2dhTBp+bcpSt/Fkm2WeozzTeS1gQNdVJqSJZ1Qw0i6/XcaTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762792988; c=relaxed/simple;
	bh=mRJ1mwT2rs6TEwsfFEQDI3G6unwiVQkbpWUH/udXIyQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=IBvesCEyrg//8ZyfQlFvxVNqaUGbPasy4fCTZWScullG08zUq1rDQ1b0CoaMwwdYaWj8gxPZV0lmS7WxJ2nQ8M7U/CqtbRiRIZVRDZzOUfvEs96pWSHF4Eq4tmohdCsrnQY1er+s0iHc9lBAsm4AK0EeDSXq8Gr+8IBN6m1hcaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=psB/B+7V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58E46C4FF5E;
	Mon, 10 Nov 2025 16:43:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762792988;
	bh=mRJ1mwT2rs6TEwsfFEQDI3G6unwiVQkbpWUH/udXIyQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=psB/B+7VS008G1tGHbQPKjd1uPuTCticEYhZZ68tO7LaJgLOtUP2cdYjEZwPzjyRh
	 FzcHfaVL491s+CUdOFLiFSfZF4gGwiDw4jmxjJ5wT3KLjc3s6UfUGBvH4unf4kPn1a
	 OEffHzuUbroHG2u9A906IdHhDFFKPacKSg3YawD5EL3WAHoeIqCUa6WaUI3FtL5Lrf
	 LWSF8pCTsTYwz9nz8wWWE4nTnjoe7Ai8A2FkhA4OOSm3lf/B7hRyE9bkB+l4s4yXca
	 EtOJKIP+bXp/1BuH2pk+9TT2cWEaHqqym+qKYUN7JzNypJ8hi4TaCoPeiBfyUDjoy4
	 FtlQLDWvYBu2g==
From: Mark Brown <broonie@kernel.org>
To: Richard Fitzgerald <rf@opensource.cirrus.com>
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, 
 patches@opensource.cirrus.com
In-Reply-To: <20251110114327.84370-1-rf@opensource.cirrus.com>
References: <20251110114327.84370-1-rf@opensource.cirrus.com>
Subject: Re: [PATCH] ASoC: cs35l56: Alter error codes for calibration
 routine
Message-Id: <176279298704.56837.6472394807142684200.b4-ty@kernel.org>
Date: Mon, 10 Nov 2025 16:43:07 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-a6db3

On Mon, 10 Nov 2025 11:43:27 +0000, Richard Fitzgerald wrote:
> Adjust the error codes returned by the calibration debugfs files
> to provide a wider range of errors and make them more consistent.
> 
> There is a limited number of standard errors and it's not always
> easy to find an error code that accurately describes what happened.
> Additionally, user code often uses strerror() or something similar
> to report a generic error description. The original calibration
> code used a limited set of errors to attempt to avoid user error
> strings that would be confusing or unclear on a file read/write.
> However, this restricts the ability to provide informative errors.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: cs35l56: Alter error codes for calibration routine
      commit: 772ada50282b0c80343c8989147db816961f571d

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


