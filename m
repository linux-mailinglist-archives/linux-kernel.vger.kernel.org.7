Return-Path: <linux-kernel+bounces-744943-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 21E70B112D4
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 23:09:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 113087B9398
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 21:08:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4C8E1494C3;
	Thu, 24 Jul 2025 21:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DUkk4GhT"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AB992EE275;
	Thu, 24 Jul 2025 21:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753391353; cv=none; b=utwpkxrq6vAHWP1mL7lnAqGlbyAD1ib8H63anJHoQdZfpOW0BSU8cizUTIXiBO4Nzyd1A0pqLDKOF3U+JhKLq2aJALQnuJ9VHRCyMfkPHdH2pondgPoCT0Mw6+qQdoIvZLkigONA65i5bLKf01+4xQQE0RmGhODqc92DHwhfAtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753391353; c=relaxed/simple;
	bh=nFlm8N0bOxTn7QBOexrfKe5KaYKZqvAsJ+gie68l0VQ=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=NbSCeuVSknBzDrcKqngxPF2Ha4dpahUhLfOWme84DCgHKigIJz2sfYQQF1fGFnN3dMbvOJy7lk1DKReIn3VwpkEcA4p8u1MaxYDNtotsQXW6xoiBG+nKjGyHNSoT/cSBjZGSWoy6aGO+859PcXffyRRjYfSPjDneHJ+QYqhfAA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DUkk4GhT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04E71C4CEF5;
	Thu, 24 Jul 2025 21:09:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753391353;
	bh=nFlm8N0bOxTn7QBOexrfKe5KaYKZqvAsJ+gie68l0VQ=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=DUkk4GhTTHugFUqVtTWmlwUrEFfwmGfHtrK9yl8rWQyM5WPueNYoV2PwHnR0ztEmk
	 aLkrOonnw96yHpvs6WZw8a8E1Um6yOqNnT/NB/HCb24WS+yCO7VTPY1HHYQbBerg6N
	 lfNUtFXwAFzilduSb2eUndNmg5WU1e51CfMXd19u2FbjpZHi77/Nqj53439L6wrN+o
	 phjjmJYWtHrVv17sbAAD+tlKp7gc22tYuKOLw7LUmelwCD0hayFlqmNkiRQnerT2/4
	 TwwRvwNqasJt4XsiqPMgP7qNNtKwRrBoVKhIXkcRBkDT7Tbrc97QnRFZe8RdYtiOtJ
	 U/b6+Ma3IlNTw==
From: Mark Brown <broonie@kernel.org>
To: claudiu.beznea@tuxon.dev, andrei.simion@microchip.com, 
 lgirdwood@gmail.com, robh@kernel.org, krzk+dt@kernel.org, 
 conor+dt@kernel.org, nicolas.ferre@microchip.com, 
 alexandre.belloni@bootlin.com, linux-arm-kernel@lists.infradead.org, 
 linux-sound@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Varshini Rajendran <varshini.rajendran@microchip.com>
In-Reply-To: <20250610065005.64070-1-varshini.rajendran@microchip.com>
References: <20250610065005.64070-1-varshini.rajendran@microchip.com>
Subject: Re: [PATCH] ASoC: dt-bindings: atmel,at91-ssc: add
 microchip,sam9x7-ssc
Message-Id: <175339134961.153218.9352688179256813035.b4-ty@kernel.org>
Date: Thu, 24 Jul 2025 22:09:09 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-cff91

On Tue, 10 Jun 2025 12:20:05 +0530, Varshini Rajendran wrote:
> Add microchip,sam9x7-ssc to DT bindings documentation.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: dt-bindings: atmel,at91-ssc: add microchip,sam9x7-ssc
      commit: da98e8b97058c73b5c58e9976af2e7286f1c799b

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


