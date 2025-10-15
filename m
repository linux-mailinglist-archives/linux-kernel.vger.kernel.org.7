Return-Path: <linux-kernel+bounces-854854-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D026BDF943
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 18:10:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 17FFC400972
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 16:10:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96006326D77;
	Wed, 15 Oct 2025 16:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RKOE/qaz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D67842FE054
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 16:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760544613; cv=none; b=knGtAym80l+vr1jWH0uO8sfKeCwoDCvPJ5Hm+LwmJKYmK3Kb3Uql5o6Py9vV0j0V2/Yb+NQSIAkbfV5FEQzog8gXbGqzHTIPmqosiah5wMbEIEsWY1PZ3ow7qvMqzGLSL3YX3AYZzBk3sIJOcK7u+ykemB+UtPeMzahuM7M5HBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760544613; c=relaxed/simple;
	bh=hpRcZAWNMxpmQJb7XKuhBra8pZDOKnhd1MgwnC9wEzU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=suJIle6ZLPxQ8cChzMuBZFk9Bk5alWRx59uBwEEL7+N5gHxttYUVoNulzDMA5fe2KjLhWihbIhQxu3yqqIG/cl1MOAkwsb5EY1+QhHYIZILebX2qxncB5Cy8BcU64tzX6LUIFZKqlGFLM8/kQvfY0UL77ebv/b+YWvUnKqi6Sbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RKOE/qaz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 661B4C4CEF8;
	Wed, 15 Oct 2025 16:10:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760544613;
	bh=hpRcZAWNMxpmQJb7XKuhBra8pZDOKnhd1MgwnC9wEzU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=RKOE/qazZr4vKUSlXD9dGr4nBADRVWwzPKk/WvCIeJnlX/46DOEY0ipW4MmOjCSJB
	 im9k49m917WEcErTpKnlVmD4MYP+DFGQaiKMhns1AQLvuEv+e2ByUYhHdE0a5cU+mF
	 3UpVqPKiRuAGGPyqW4Qwnm7klG6O3TDu7NrTDmbAQrqnt7mSmtnOe0+WANPvZYgxVZ
	 L7VhkoUK24Z7QO7YBNTONKtmY9+VeRM86LmGx/tfkFr57Ndd6g04JrFTmmGgEc2T+H
	 RJgCGYUQNROvRV4ZCwWZi0kwTnZ1TcxoE16SYy7Qzqdci641vDJxxpzs2/r5nKSJvm
	 POc7TtuVYAnkw==
From: Mark Brown <broonie@kernel.org>
To: Liam Girdwood <lgirdwood@gmail.com>, 
 Oleksij Rempel <o.rempel@pengutronix.de>
Cc: kernel@pengutronix.de, linux-kernel@vger.kernel.org
In-Reply-To: <20251001105650.2391477-1-o.rempel@pengutronix.de>
References: <20251001105650.2391477-1-o.rempel@pengutronix.de>
Subject: Re: [PATCH v2 1/1] regulator: core: forward undervoltage events
 downstream by default
Message-Id: <176054461213.193399.13443708649583416048.b4-ty@kernel.org>
Date: Wed, 15 Oct 2025 17:10:12 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-2a268

On Wed, 01 Oct 2025 12:56:49 +0200, Oleksij Rempel wrote:
> Forward critical supply events downstream so consumers can react in
> time.  An under-voltage event on an upstream rail may otherwise never
> reach end devices (e.g. eMMC).
> 
> Register a notifier on a regulator's supply when the supply is resolved,
> and forward only REGULATOR_EVENT_UNDER_VOLTAGE to the consumer's notifier
> chain. Event handling is deferred to process context via a workqueue; the
> consumer rdev is lifetime-pinned and the rdev lock is held while calling
> the notifier chain. The notifier is unregistered on regulator teardown.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/1] regulator: core: forward undervoltage events downstream by default
      commit: 433e294c3c5b5d2020085a0e36c1cb47b694690a

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


