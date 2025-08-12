Return-Path: <linux-kernel+bounces-764629-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B5F0B22548
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 13:07:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 631FA3A7981
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 11:06:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FF7C2ECEAB;
	Tue, 12 Aug 2025 11:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P1i+n0YY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2A242EAD15
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 11:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754996735; cv=none; b=ZFzgvaC20yDBdUBAEs/RDHGNugJJYJRh+2ArEfdSacbSR9UGCEMxMAe5oSRXcs3S0spdPqT8MUjdZQDztKUiBg3u6fzaZUDlpQtQfrN5NiO3DkcPJcVni/ADlZ5U+hUNLfqZWniflD5I78fiO16/EvSYQGaDDlze+ADPOBa0xfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754996735; c=relaxed/simple;
	bh=4VaPQoHsWXcEiOpRJA2JQF87eLMjQnHxmWEApyDB4cc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=oSXXjkq9AhBVEaQ+Mg9Nt13NV2pymrlD98/S82Z+wJ1R8W7rDLCa+ZU/YAbtgeAVSwG36B5Uxw3MKKvV4Qdj9It5Ekzomf3up82TfNRfiTC9bXfqwqSAIsCRYpiXw5uFNDOAV6E5rLEvmh7vT1YYtgMlQR1YLR0JMCmVJw8AQvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P1i+n0YY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED1A2C4CEF0;
	Tue, 12 Aug 2025 11:05:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754996734;
	bh=4VaPQoHsWXcEiOpRJA2JQF87eLMjQnHxmWEApyDB4cc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=P1i+n0YYdLsyDKAppkkIPsk6B9SrzsUSPluIiTT/YEzeSY0+wFz/2fDanvCjA+Bas
	 3ORPHPRPuqWqe4UiJu66vbtjtGTPVb86GVdCUQTeoJNCG25DpOV5jm4AGJTJrqXUZ2
	 RmCVE4io7Ku1TqI+Ti12mXVTQdM58TQPpgIRQHcME1l2DOie9IhQv+O4ROGQpUpRCF
	 NUnWf5NK5oE+v+Pc6NCMTntraBKYUf1AHbCY0viXSIpwteL6B5yfVdLN53QYLFQycn
	 Vl29B95bJEOx9KkV6wJsup2BDCawB/6Kn9wShQRdPO9IjjXO0ZUvqz4bnkO0weQ9vK
	 oCsjXplO8YkFg==
From: Mark Brown <broonie@kernel.org>
To: lgirdwood@gmail.com, Chen Ni <nichen@iscas.ac.cn>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20250729040044.1851988-1-nichen@iscas.ac.cn>
References: <20250729040044.1851988-1-nichen@iscas.ac.cn>
Subject: Re: [PATCH] regulator: tps6594-regulator: Remove unneeded
 semicolon
Message-Id: <175499673371.16220.14953721190197929965.b4-ty@kernel.org>
Date: Tue, 12 Aug 2025 12:05:33 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-cff91

On Tue, 29 Jul 2025 12:00:44 +0800, Chen Ni wrote:
> Remove unnecessary semicolons reported by Coccinelle/coccicheck and the
> semantic patch at scripts/coccinelle/misc/semicolon.cocci.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/1] regulator: tps6594-regulator: Remove unneeded semicolon
      commit: c6871d56b52ec177b8b8bd891fa0cbbd004b646d

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


