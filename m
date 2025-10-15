Return-Path: <linux-kernel+bounces-854765-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AEABBDF537
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 17:22:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 49F3A3C147E
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 15:22:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CEAD2FB0B7;
	Wed, 15 Oct 2025 15:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ANeh3y9v"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62EF221ABC9;
	Wed, 15 Oct 2025 15:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760541739; cv=none; b=dEyj+QWaRhGGOJGPpcr0tSH60viGAKZM62kKSlfaPYekCuDjcU1XGZ8cKvS7wiSk9M/MM5ea+LMBTkG5HMeJZpEGJPRdt3Lsh6sM4nyzX9tlorUr4D1/wx/FZfwVNNeWdhc5Sq1CuAhfB6CKvtiUxqXtMrej7sK17PYpKntrcxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760541739; c=relaxed/simple;
	bh=WgWGXsmDkQY2RWyxMpc6dWAkpVwA7f8xiHPLh/Bejds=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=uPMH7SksFpjVk4RtMqow5ne7iOL9Mmc7JHcO3TjxkkLLQD8bQCxm7Sp0fQtRhc9XsMLH0XI58jzvBe4693esg5EIf8fbk/qi/eM5tLoSOb2AhBDQVLnNlTXc8td8yBPmOGlCCgzxBdJG8UTBj0KbZMeHxqFV/lDzObrWd1gr0X8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ANeh3y9v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCFACC4CEF8;
	Wed, 15 Oct 2025 15:22:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760541738;
	bh=WgWGXsmDkQY2RWyxMpc6dWAkpVwA7f8xiHPLh/Bejds=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=ANeh3y9vOpdxsgMxjm9J0x7hrm/WlWNAzKMkGt+OWegmtfglWX7fx7z6IbQwIkBmX
	 EtrSCdq4jZVRRUCKhYP6aOQ3QZm7RsIYrUsGiZjxqVjmaijbBM4ITJTRTXCiDadz7j
	 BtiMTgdl20h34+EidWiYqtD1vqcz5x0hDK61SkCET7lPqDHgnoOe+d4b55UewiXsJA
	 ryFXxQqu56wpPdlOABpDmgTPPPpL+aIlOo8Oe9fS4bHuf+DC/XLL1FACmbCXMg0EQq
	 BnNmitKMrwp3nlHCypj9cA3WymGn69pVKvzvNhaaE6354wSPJGVn9QsJFmXre0ci8j
	 XVXVDSpGztjeQ==
From: Mark Brown <broonie@kernel.org>
To: linux-kernel@vger.kernel.org, linux-sound@vger.kernel.org, 
 Marco Crivellari <marco.crivellari@suse.com>
Cc: Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>, 
 Frederic Weisbecker <frederic@kernel.org>, 
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
 Michal Hocko <mhocko@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, 
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
In-Reply-To: <20250929155053.400342-1-marco.crivellari@suse.com>
References: <20250929155053.400342-1-marco.crivellari@suse.com>
Subject: Re: [PATCH v2 0/1] ASoC: change system_wq with system_dfl_wq
Message-Id: <176054173655.179445.8487996832699914920.b4-ty@kernel.org>
Date: Wed, 15 Oct 2025 16:22:16 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-2a268

On Mon, 29 Sep 2025 17:50:52 +0200, Marco Crivellari wrote:
> Below is a summary of a discussion about the Workqueue API and cpu isolation
> considerations. Details and more information are available here:
> 
>         "workqueue: Always use wq_select_unbound_cpu() for WORK_CPU_UNBOUND."
>         https://lore.kernel.org/all/20250221112003.1dSuoGyc@linutronix.de/
> 
> === Current situation: problems ===
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: replace use of system_wq with system_dfl_wq
      commit: 0b0eb7702a9fa410755e86124b4b7cd36e7d1cb4

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


