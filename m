Return-Path: <linux-kernel+bounces-888364-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 83E4CC3AA31
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 12:41:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F02FD466270
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 11:34:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C24DF2F547C;
	Thu,  6 Nov 2025 11:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O0xRGWQk"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D9E326F29C
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 11:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762428852; cv=none; b=F+XJnJ2jlm9bCmaNHBFTRoJLNode17CiHpYe2jlVoy/W95acnn9IJXmgM2/NS00Qgctj5ncIvJtNGkaoVD99JflWk9OtjKXxpPc81O/RCsV/lJMGY8A4Kiwh6slvOn71aBFRc39yaElU9Ehq+6yNF696EpOdGek9rvYI6SK6O34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762428852; c=relaxed/simple;
	bh=8XTd5hVSjOtoTsstJNMoN5UAHfhcC3cFKbQEiBz5H50=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=u1jlPZdg18PqQU+uEbl+HAPe7+uyzOQ2khq3PXDO3yb+C90wfVycEvl6jCq64m47ZVWL5LjapwCiEDVa35MbgZq8RwDUc3hBvpQARIlYlXCMopcmtshqMBuW5WOw+0h9VeuQ4HL/sjS62BOyG7igCn9er9guO6hz5FXvScA8w24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O0xRGWQk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1258C116C6;
	Thu,  6 Nov 2025 11:34:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762428851;
	bh=8XTd5hVSjOtoTsstJNMoN5UAHfhcC3cFKbQEiBz5H50=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=O0xRGWQkZYjsu0GOdcuUli/JK3YcXQWKPzTu9NAK9lnS4ZnA420NQB/7/g3DVOnMP
	 w5hJ7y7yHsaWPOB19eXE70YYf469eIOZ5tQm1uBnzswPfLO4Q3NqsqXy+8fEyv8msy
	 cL3fYE7FPWQh9MERxtyjX462+4EhYEn0OmuXMoTyFvuE/OVNAz/oPFs6PiIT8oL3Ev
	 a8feGae2oYmeEWFPTJK3UNglF+RtH+Kdnz+MvHMHX/MsDix138EG51hWG5B+WqewC2
	 MGzY+8UQWMcng0lhY0uiTM5pp80DVgshM1aZIIsrVeBV/XaWRJQmn9rvaRvJKe886h
	 tMiPXpzVinT+A==
From: Mark Brown <broonie@kernel.org>
To: Liam Girdwood <lgirdwood@gmail.com>, Haotian Zhang <vulab@iscas.ac.cn>
Cc: linux-kernel@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>
In-Reply-To: <20251028172828.625-1-vulab@iscas.ac.cn>
References: <20251028172828.625-1-vulab@iscas.ac.cn>
Subject: Re: [PATCH] regulator: fixed: fix GPIO descriptor leak on register
 failure
Message-Id: <176242884990.2357418.738983327098295220.b4-ty@kernel.org>
Date: Thu, 06 Nov 2025 11:34:09 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-a6db3

On Wed, 29 Oct 2025 01:28:28 +0800, Haotian Zhang wrote:
> In the commit referenced by the Fixes tag,
> devm_gpiod_get_optional() was replaced by manual
> GPIO management, relying on the regulator core to release the
> GPIO descriptor. However, this approach does not account for the
> error path: when regulator registration fails, the core never
> takes over the GPIO, resulting in a resource leak.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/1] regulator: fixed: fix GPIO descriptor leak on register failure
      commit: 636f4618b1cd96f6b5a2b8c7c4f665c8533ecf13

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


