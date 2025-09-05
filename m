Return-Path: <linux-kernel+bounces-802986-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8246B45931
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 15:36:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 09B24A471B0
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 13:34:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B7F73570DC;
	Fri,  5 Sep 2025 13:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qgKEDN2j"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9980B3568E9;
	Fri,  5 Sep 2025 13:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757079138; cv=none; b=Thx4G4J6F5S2N6tKhEwwg3Rbr7qX2tJ7i0O59ZlMpGo5L07v1I3GLsyLz0ewnZvkXI6rbAsjQ+dt0Eihds4GX87aCJjD+2yxkHVIw+z/6x7el2A9HLgxRO2+IVwtFk5Nc6RVT49S3G7piIY6xcfaxktZ89Hj1Xi4qj09ent8ps0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757079138; c=relaxed/simple;
	bh=z+yRBjWFuWZmQ0Jkbr7er81MzdGoQ1Zxeo87sJH5omc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=ZeVx5j/dS0EHLZVy1cFOTUi0IvdqFzJ8e+h4URha0F22oaoeCH2G2Is4bUft8RuCMZq2ZEBWuMv/8iQOXnd6IRnOqa2w4UaXoBpZTtWwXMaaEZLx7TxYzYGpOjkJQ/xmVUndPk6pIpjBA3qVv6VGprBTZwDP6df8buvvCScUr0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qgKEDN2j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEF2AC4CEF5;
	Fri,  5 Sep 2025 13:32:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757079138;
	bh=z+yRBjWFuWZmQ0Jkbr7er81MzdGoQ1Zxeo87sJH5omc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=qgKEDN2jutXLXU6US67T8gHl77pT1/ZZnypRhsvK1bja7xaCRDE/Z/9v54ITKfwCB
	 nsnd06OgYlhkdbQp0K9HpnXYvuWnKdwl768/m6VU02S7YSkkbVFkuFC6/Y1+kmcFEF
	 l2yZyDTDT6vxAx2Y+QZrc4q6p+8qGk9VXxIsFCEgMOjZHaYCV72/npJletlrGhUIaf
	 irvH+bHUbhidYdmegI7h1p5qLS79lNhn3Gl6/+Kcn/ZbPddic/MeP82tOaob3oxjHw
	 E/7hQLaDBG1XBmjhuv+HlQNlbBivE4SirDtwm81z9R93E1uwfHHBDsPxZL2POqwChj
	 pW0wVeEPDpuiQ==
From: Mark Brown <broonie@kernel.org>
To: linux-kernel@vger.kernel.org, linux-sound@vger.kernel.org, 
 Marco Crivellari <marco.crivellari@suse.com>
Cc: Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>, 
 Frederic Weisbecker <frederic@kernel.org>, 
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
 Michal Hocko <mhocko@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, 
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
In-Reply-To: <20250905091016.109428-1-marco.crivellari@suse.com>
References: <20250905091016.109428-1-marco.crivellari@suse.com>
Subject: Re: (subset) [PATCH 0/2] sound: soc: replace wq users and add
 WQ_PERCPU to alloc_workqueue() users
Message-Id: <175707913567.96517.1017989941798137828.b4-ty@kernel.org>
Date: Fri, 05 Sep 2025 14:32:15 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-dfb17

On Fri, 05 Sep 2025 11:10:14 +0200, Marco Crivellari wrote:
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

[1/2] ASoC: replace use of system_unbound_wq with system_dfl_wq
      commit: 9e5eb8b49ffe3c173bf7b8c338a57dfa09fb4634

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


