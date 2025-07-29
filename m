Return-Path: <linux-kernel+bounces-749692-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 47E2EB151AB
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 18:52:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 996D318A4211
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 16:53:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C43D289E36;
	Tue, 29 Jul 2025 16:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C88/C+QL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DECD34CF5
	for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 16:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753807963; cv=none; b=beVPn/JUGlRY+gm2uU26koqz/fh5O/IUyGMt3GMWY2kOwxbiv9ekjO6tA0HLx03/Osfd7TH+OomnGRZ0d8iCt6t71gC5tCtlgsQCz1d6PLlAEAic69C3MNTduJTKhHsMvnqhLKV7rGO5zGm9cv8BFLDAt9EwYBIjKL7R0n9ZVD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753807963; c=relaxed/simple;
	bh=szXZaMT/+VHUp75G+lWUpQ7XbsJhMvWxVA9dA7J6hiM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=T6hRWRbid+v554et6inAZM7JM4cKihxXzsMw5m0soQSchvogY9wzTk+PIVnJqj1aaFCBFWS1qxRy5/orLUUM6bJ/csVnoo6pBUq/V8a28iZQheLMaeRAN1YhBPabK1mE59VNkq3OSwwWl5mM/F/UDPoslfiPWOTWQxhrqT7YgMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C88/C+QL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27B20C4CEEF;
	Tue, 29 Jul 2025 16:52:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753807962;
	bh=szXZaMT/+VHUp75G+lWUpQ7XbsJhMvWxVA9dA7J6hiM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=C88/C+QL85P2fjby4ko6Jgk7LT/8SPMLT/4ci4oZsEkSbhotLV2v1YYcrfOUqd9+e
	 3nZ06kXxc+Rjs4SETZmHub7+Y8ISQBWvwJZvFHr6hf3oR6RTv8KUasLqTI4VhDn1AQ
	 EGW13grqRjj+x9xm87F5dbRb9Xhy5Pyv/8J1sMYL35o3AzpD7AIjp+LlQ4ncB839cx
	 09/a0K+Vwf4wPRVixrAH6c1quSVrepTg6rSYgsvJEtRVZpKwQD/TZRy39XRNaGj+IE
	 DDIbIulMpeUZK+u1LU423A5BNg38aQh7DwPMPBB4UBnv3K1wu8FWLE3Ipd9Z1UxgkE
	 M4okp5CMkllwA==
From: Mark Brown <broonie@kernel.org>
To: Liam Girdwood <lgirdwood@gmail.com>, 
 Romain Gantois <romain.gantois@bootlin.com>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 linux-kernel@vger.kernel.org, Jon Hunter <jonathanh@nvidia.com>
In-Reply-To: <20250729-b4-regulator-stepping-fix-v1-1-3f7b8c55d7d7@bootlin.com>
References: <20250729-b4-regulator-stepping-fix-v1-1-3f7b8c55d7d7@bootlin.com>
Subject: Re: [PATCH] regulator: core: correct convergence check in
 regulator_set_voltage()
Message-Id: <175380796087.160570.1705032204665364699.b4-ty@kernel.org>
Date: Tue, 29 Jul 2025 17:52:40 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-cff91

On Tue, 29 Jul 2025 11:50:57 +0200, Romain Gantois wrote:
> The logic in regulator_set_voltage() which checks for a non-convergence
> condition on a stepped regulator is flawed.
> 
> regulator_set_voltage() checks if the error in target voltage has increased
> or decreased, and returns -EWOULDBLOCK if the error has not decreased
> enough. The correct non-convergence condition is:
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/1] regulator: core: correct convergence check in regulator_set_voltage()
      commit: 10dfd36f078423c51602a9a21ed85e8e6c947a00

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


