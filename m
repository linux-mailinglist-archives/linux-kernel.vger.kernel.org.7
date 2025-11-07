Return-Path: <linux-kernel+bounces-891105-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 691B6C41D9D
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 23:45:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 154E6351A38
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 22:45:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E91FF262FD1;
	Fri,  7 Nov 2025 22:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z3pvny9V"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51B161E51EE
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 22:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762555544; cv=none; b=icjlo0LjE8QiAZFMq1Jpgdcj4mSdwHwsrkkPRYkN39G+aGm5jLfmYCHXW1A2+aqQgF5hlB5CjoEl+P/FOaMV/3n7zKx/zAn3SNy0OKfmRacX7/p5kFJyQdFrJr1EisT4Lha9IziJsdHTidjjnSEVchmY2dKAtVNfcRzjVRZeQsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762555544; c=relaxed/simple;
	bh=9QhhIlDZu/g49an2sK+fQ727AFyd6RN3xnybq/gbwUA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=c7L1EHNNjKwPxCjtC7IbLw6K205OYQtAzx5Z9r+uQiLeoDApKpEQFB8xEJZpWwjKYArFGtfukNYWuYsTb9WAw6TfgH2gDs+UFsAVxg8jAkN+IbNmf8nIgkZIrwaN//4rHglT5X4N/YccFK/Bf1HL2u4DkB9hwT8HYnD5TkNPlvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z3pvny9V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C812AC16AAE;
	Fri,  7 Nov 2025 22:45:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762555543;
	bh=9QhhIlDZu/g49an2sK+fQ727AFyd6RN3xnybq/gbwUA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=Z3pvny9VpovEaN57eoIGkaiZ09jT/HJ1rVErngbyPra8IKtmEDp7p1Db4Wdu0YLDT
	 v8wYHFMPtyP9UWCjnrER5CYhiPtGn19i532j+SX6zWQqjJA7oVnvHIS6TLPYv1CeK7
	 2I+3hgxOn+w/0/90vlBioOi6+IzmKi4dWfpvcqvAuD4ylsCRlwEGuFwGdYFZBpPcPN
	 CpBT/Vm2973XG5krizIidwg8GxdntkdgnTZaYSpgAr7dFT55qPp9/67iMDEc7Swk55
	 HgfOwSHFwOH4DLbmJz2UQLGfy3OWS4hfF/KXiVnxPCXaHn08jQlQJxgmMgYykM830U
	 dgOntL25lyJLQ==
From: Mark Brown <broonie@kernel.org>
To: Liam Girdwood <lgirdwood@gmail.com>, 
 Douglas Anderson <dianders@chromium.org>, Gabor Juhos <j4g8y7@gmail.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20251107-regulator-disable-supply-v1-1-c95f0536f1b5@gmail.com>
References: <20251107-regulator-disable-supply-v1-1-c95f0536f1b5@gmail.com>
Subject: Re: [PATCH] regulator: core: disable supply if enabling main
 regulator fails
Message-Id: <176255554171.22584.17620313954221457974.b4-ty@kernel.org>
Date: Fri, 07 Nov 2025 22:45:41 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-a6db3

On Fri, 07 Nov 2025 18:10:08 +0100, Gabor Juhos wrote:
> For 'always-on' and 'boot-on' regulators, the set_machine_constraints()
> may enable supply before enabling the main regulator, however if the
> latter fails, the function returns with an error but the supply remains
> enabled.
> 
> When this happens, the regulator_register() function continues on the
> error path where it puts the supply regulator. Since enabling the supply
> is not balanced with a disable call, a warning similar to the following
> gets issued from _regulator_put():
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/1] regulator: core: disable supply if enabling main regulator fails
      commit: fb1ebb10468da414d57153ddebaab29c38ef1a78

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


