Return-Path: <linux-kernel+bounces-602592-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CEF1A87CC2
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Apr 2025 12:04:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5FF5416845F
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Apr 2025 10:03:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D0C525E830;
	Mon, 14 Apr 2025 10:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="autzkZMc"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05DB3191493;
	Mon, 14 Apr 2025 10:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744625023; cv=none; b=auX7IiTgEIOOjGATH+ZrG9TZz2AVlhpvXeC8MDmEkcZXhPchB9C5fQ2WIqAIWEegO/xIiTrGig7jI9rUrrwgWozTX949ozzV2uGDEjebowjwnQd7Eoav/4qEK0WVKqm05z0/m3xiTZQS/6q0p09NApgkp6Fn7ntsMs85RM/Ndow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744625023; c=relaxed/simple;
	bh=ODYW5ybWUOgIk3FjZgLf+TuI99lrnB3LjKGzb/UKJkY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=aeuNFDy76JPCllou7MlCmiNYv/QBDtho1MYC0XikFNDb1Lt6ochT+fFDSz8c2U/8a/dZngs0bFgk2DQJress23R1+8aww2BvWwdy20jteKFepCq0hSQKKMSpULEJlR0ehFl2oxkJ0gnk72j9JcPz7UPshe3xXvELwAnr3gUH8a8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=autzkZMc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DF40C4CEE2;
	Mon, 14 Apr 2025 10:03:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744625021;
	bh=ODYW5ybWUOgIk3FjZgLf+TuI99lrnB3LjKGzb/UKJkY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=autzkZMcZWjfTrCRfBjAj+nH3k8Ih40sLGuCu615POSr4LnB8kD3wsAchacW2yFVO
	 SNl3AvhMPHc1FGUyhuaLb9y7ETTaAKCxmmfeCeqbHn5uxMta1WuraGYaKxfpCKvTJ4
	 SqwVQZZZZs6qeo3jNwyEruckrIXVnT+BUGU9SG0tA9FwyHt7zudwO9DTpRIpLJ6tCq
	 5YsL+E/WQPZglY858lhQtNObJKiOGwBs+c20LHvIx5P51MtYGmArF/gtPs36ctEYhb
	 s4t5JKMDw8j4Wpq0MFbJCgzU0Bv5VVnyw8Hq/9NRqLq+AyUyO1TauFI3hqgug8TW5Q
	 Npkl2tSMTB12Q==
From: Mark Brown <broonie@kernel.org>
To: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Mukesh Kumar Savaliya <quic_msavaliy@quicinc.com>
Cc: quic_tdas@quicinc.com, andersson@kernel.org, konradybcio@kernel.org
In-Reply-To: <20250404135427.313825-1-quic_msavaliy@quicinc.com>
References: <20250404135427.313825-1-quic_msavaliy@quicinc.com>
Subject: Re: [PATCH v2] spi: Add support for Double Transfer Rate (DTR)
 mode
Message-Id: <174462501993.12165.4079866099404006000.b4-ty@kernel.org>
Date: Mon, 14 Apr 2025 11:03:39 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c25d1

On Fri, 04 Apr 2025 19:24:27 +0530, Mukesh Kumar Savaliya wrote:
> Introduce support for protocol drivers to specify whether a transfer
> should use single or dual transfer mode. Currently, the SPI controller
> cannot determine this information from the user, leading to potential
> limitations in transfer capabilities.
> 
> Add a new field `dtr_mode` in the `spi_transfer` structure. The `dtr_mode`
> field allows protocol drivers to indicate if Double Transfer Rate (DTR)
> mode is supported for a given transfer. When `dtr_mode` is set to true,
> the SPI controller will use DTR mode; otherwise, it will default to single
> transfer mode.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: Add support for Double Transfer Rate (DTR) mode
      commit: 88113e09ada52be28968aacf4af7b3d667832f00

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


