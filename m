Return-Path: <linux-kernel+bounces-890707-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A6637C40B82
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 16:59:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 52ADD188A514
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 16:00:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1C0832E130;
	Fri,  7 Nov 2025 15:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GZch3LXT"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B9014A0C
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 15:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762531175; cv=none; b=FOn1uq8htNY3i0s1HWYjaeMsGyUFb6/tKMSx6whjBxChGT3yqKG7QCZ9jSDCuY+rr2xm5dwiRklFgibrT0/Zqw+lUXaMrzJ6jFGKix1qti5Tyza1rIZ9M8aGL9t1DBajO9NZPsvgVH9YACfrIs/TB61sjbRdqIPECpb98oDQtIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762531175; c=relaxed/simple;
	bh=2M8qKuGCQadolI+HsUy8wIj3etcQsy3VNJ5QM5ogPB4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=AvuxasRE5vXAGjHty/B3jkxwR/QjKvHP+GZvjnEH7qxt36IKJkLktT9ekTG8+2WJ9IVmxFtJKrOSm+HQMl7KZjaA+dlEh2gM6Z8QN5EjvD5QmBHTYEr6DsQPKlE0qLk31vbMBEig7EVbZv13xQP9ti94/ASIFOqYU8aGZXzrcUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GZch3LXT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D00B5C4CEF5;
	Fri,  7 Nov 2025 15:59:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762531174;
	bh=2M8qKuGCQadolI+HsUy8wIj3etcQsy3VNJ5QM5ogPB4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=GZch3LXTBGVC75N75+2AZRNqh1aVOWoHiPp7abbxpQS3+FGUam2aLrBB2BIUC6rpS
	 bO9A0W4M+lWBSzqVMoD/n7QZa6IQ4MNEs3p2V/JRb+YSE68UdoKKVExgJNvvG10rfn
	 6e/UZLBpvcusUBiCBf60EUyGnxm6EJzfw5+CD31oLTiJtLaMV18kaDUnNerEKQ0+w0
	 1ultI/81kGesRpumQxcIRK194zgesoQ6Gyk2vRLYVGNClHhwJnqxmtEuA/e9yTviZO
	 n72UDRlHa1KXSHg4VY5RTz/hCOkBuT1iekckkX7cWKS5CIzUzJ8aLhWCQrPlQu4+4a
	 OLmr7d7uTffYQ==
From: Mark Brown <broonie@kernel.org>
To: linux-kernel@vger.kernel.org, 
 Marco Crivellari <marco.crivellari@suse.com>
Cc: Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>, 
 Frederic Weisbecker <frederic@kernel.org>, 
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
 Michal Hocko <mhocko@suse.com>, Matti Vaittinen <mazziesaccount@gmail.com>, 
 Liam Girdwood <lgirdwood@gmail.com>
In-Reply-To: <20251106142914.227875-1-marco.crivellari@suse.com>
References: <20251106142914.227875-1-marco.crivellari@suse.com>
Subject: Re: [PATCH v2] regulator: irq_helper: replace use of system_wq
 with system_dfl_wq
Message-Id: <176253117139.2510929.8121904506912995233.b4-ty@kernel.org>
Date: Fri, 07 Nov 2025 15:59:31 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-a6db3

On Thu, 06 Nov 2025 15:29:14 +0100, Marco Crivellari wrote:
> Currently if a user enqueues a work item using schedule_delayed_work() the
> used wq is "system_wq" (per-cpu wq) while queue_delayed_work() use
> WORK_CPU_UNBOUND (used when a cpu is not specified). The same applies to
> schedule_work() that is using system_wq and queue_work(), that makes use
> again of WORK_CPU_UNBOUND.
> 
> This lack of consistency cannot be addressed without refactoring the API.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/1] regulator: irq_helper: replace use of system_wq with system_dfl_wq
      commit: b6f4bd64f453183954184ffbc2b89d73ed8fb135

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


