Return-Path: <linux-kernel+bounces-765117-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 194D9B22BAF
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 17:29:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 527501A2355C
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 15:29:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5BFD2E2F1B;
	Tue, 12 Aug 2025 15:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gt8qO4ns"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D55C2882DE;
	Tue, 12 Aug 2025 15:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755012551; cv=none; b=slaUbyTFZbWt5RWBDkvRcXdkytaAwlBZOGrwOpK62yMhAbYk6f2Mrv8kMuBlip3qjELzYnFmBVfVq+VvvsYBXhw3ycqJiRrAFfG4/tAO9D4+bis58rUzjuuRvU2zLk4M4XCACsab137Kc1BJ2c0DPCAvPrNn4yKE69pbNpu8mkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755012551; c=relaxed/simple;
	bh=0X8QFqz4pmBHOU4UnmXb3boETfM8x15rmCDELHIAXYU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=qSZMpH7KLpMiRH2AmQhsEtetfczlGOjz4VY0q4MaCiZdVJ/BBLFawQdWsCEzkpL4hd0HwMv9rA8y6FIlyOzIKJCJitFfmmsgHtkb3tLlP5uaN9ZxyamkzHXh8QBhT/5j/sVlIz0J3JOQS1LaBtl8WM0NVQkYag0+EWbDO1sg+08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gt8qO4ns; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D788DC4CEF6;
	Tue, 12 Aug 2025 15:29:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755012551;
	bh=0X8QFqz4pmBHOU4UnmXb3boETfM8x15rmCDELHIAXYU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=gt8qO4ns+AaZPvgl5jhaekJimTVoi9dw0wCoUryf2d76l6BuGituPyrEbpfp+W2Er
	 l2IxL0sQLFeRjg0QviHTjtsc+sOLhz32o96U+jxNLyO3+Luqwfg8IKqTx2ZdI4sSKi
	 zgBfE2PB2YYXn/dJUvllXgaOVL0FhW4+CRf0qovnZSeUfvn5W3GiWrnBfcdZC6bJAK
	 UAoPyFjgyGvyBAe5NnPD4mufcX1dA1/dwuNTFAu6XbRw66+od4SkPq8PhhI3XHkVtK
	 /ZlJTCCyLAPKCofI0cG/Tx2gbT44OIhl23ZpT+4/ZurNI845TlXznk47Wvgi1X6g4z
	 44AO2cCqdUnWA==
From: Mark Brown <broonie@kernel.org>
To: lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com, 
 Xichao Zhao <zhao.xichao@vivo.com>
Cc: patches@opensource.cirrus.com, linux-sound@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20250811070418.352104-1-zhao.xichao@vivo.com>
References: <20250811070418.352104-1-zhao.xichao@vivo.com>
Subject: Re: [PATCH] ASoC: fix "dependant"->"dependent"
Message-Id: <175501254962.179691.12904836095088907799.b4-ty@kernel.org>
Date: Tue, 12 Aug 2025 16:29:09 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-cff91

On Mon, 11 Aug 2025 15:04:18 +0800, Xichao Zhao wrote:
> Trivial fix to spelling mistake in comment text.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: fix "dependant"->"dependent"
      commit: bdf0f2c84332f1e1b9dc3b267061e263bfaff097

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


