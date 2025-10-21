Return-Path: <linux-kernel+bounces-862756-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 91E32BF615A
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 13:37:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 506A718A63F4
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 11:37:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5876E32E698;
	Tue, 21 Oct 2025 11:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s0/Kb6pX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1E9215A86D;
	Tue, 21 Oct 2025 11:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761046632; cv=none; b=cm5Hc6ED9T2VpAQSeWcURDA79jjusaMEeBWN3vRIz9kxqhcUKvJ+sG/4P3qGpB8KrE3RUvS213E25nYaWUiyygPCBA6ZbbgTGoQeQLFx848MUW41xKhIhUsgJnXqvx0NofrivbE5eqLouY2ypjwZBlap7oxCCcFSWvc/PFsFjsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761046632; c=relaxed/simple;
	bh=JnmD5sWuarX/tOOI2JweCjUR+v+O0im/mlWtk+KBG6s=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=GNq8So+UwCo0uhE12/XD6yFrDOBNeu2nVnJYRZnBe68M3I8iXLAnMNR6hEhQ7uV4IubAg9cMLDX3x+xL7VbUOFgKYLori6oVKmGK12D09d7BsW1adDlSVkklye9bClYx5l1IPsMfS2+EjGmP3hCPrL2EkY4+c9cKKC1Dw0mzTQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s0/Kb6pX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A84C0C4CEF1;
	Tue, 21 Oct 2025 11:37:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761046632;
	bh=JnmD5sWuarX/tOOI2JweCjUR+v+O0im/mlWtk+KBG6s=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=s0/Kb6pXsOw3C5StCq+hUQJqvusEVUCxuXrrFlOhGT9HKAZoP1gd5FAFrPaN9YajY
	 ex0LzKJHSRMaxcguWsS/dq31dXwReHWE7VPZDHv5yPmHCf4bzvt6b5NBOFhSBJCjOc
	 przIT2sjfeZlqNPOEomtBkzi9kcKEMYT48keEOS8mZx+9B32KP/cj7Z3Q9P6fQ8Qek
	 FEinIpYuAZZNlG8DcUrjMFXl4x5sbkq6bcGCq1tMCbkf8OzPuiBzMo6xjxjTMxNo+f
	 Wcu9bAcIEEP/LrBQ+uYpj/Tx9fOIB+d+JlGvWB+U6UUx0qm+mawyCTr3H6/fHd2d82
	 cE1QPYN4zOrbQ==
From: Mark Brown <broonie@kernel.org>
To: Richard Fitzgerald <rf@opensource.cirrus.com>
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, 
 patches@opensource.cirrus.com
In-Reply-To: <20251016094844.92796-1-rf@opensource.cirrus.com>
References: <20251016094844.92796-1-rf@opensource.cirrus.com>
Subject: Re: [PATCH] ASoC: cs-amp-lib-test: Fix missing include of
 kunit/test-bug.h
Message-Id: <176104663141.21978.573711939726004270.b4-ty@kernel.org>
Date: Tue, 21 Oct 2025 12:37:11 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-2a268

On Thu, 16 Oct 2025 10:48:44 +0100, Richard Fitzgerald wrote:
> cs-amp-lib-test uses functions from kunit/test-bug.h but wasn't
> including it.
> 
> This error was found by smatch.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: cs-amp-lib-test: Fix missing include of kunit/test-bug.h
      commit: ec20584f25233bfe292c8e18f9a429dfaff58a49

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


