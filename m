Return-Path: <linux-kernel+bounces-888363-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D612C3AA39
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 12:41:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D60D7465D58
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 11:34:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 830452F5A3F;
	Thu,  6 Nov 2025 11:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rZwpeJD5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D59A026F29C;
	Thu,  6 Nov 2025 11:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762428846; cv=none; b=kzBe5ICyy9L915a+R920NFtRGpVLybrkBQs961I9qFMns3BPxCoHPXy1wo30wS9Gy8dGFhHl1TpM6Fp+7qabk3/BRtOC4FOzxAE8Z5958fF3e0uoomUDeOmwzg+V0d44AdDGtndzszmeWhcZVa6GQmiiIOVdn3NpAA8pisJsB/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762428846; c=relaxed/simple;
	bh=x0vSPZuKoRb3szafYiv21K0FcdiPZdKs0Jp10xlTOqg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=r92cOLxRMo3k6u5uX2oHIB8Hf9tXEhKf8KUsLhoiDjfEhGwOkacWAACZtCJKUg/xESrVhe7yVWrDzg7oqrwbEWxtIzQTZg7SO2ulRcycZpO8A40kK71G/uSdXIjHWCawJlH2DJoHioVov03zQgfvb/tz6dBGiNvZSbgl+X+y8v8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rZwpeJD5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3F75C19421;
	Thu,  6 Nov 2025 11:34:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762428846;
	bh=x0vSPZuKoRb3szafYiv21K0FcdiPZdKs0Jp10xlTOqg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=rZwpeJD5qSn0xu/aGF3pXyhMLon1Go9aoKkG1nuVdqFSpyZVcT56FbiQqQ3zKDs8Z
	 /Wc1Hs59K+N1++qOXxcxUDLeG5g3b8YtNKJyJglTk3If109pRtrCy5WRrP5absdUlU
	 nNFoS8P7dBDqK8xRNz3LJ24vHDlYNRHGFbj536mMpIqPB4h5XkM6PttyBLDIsvN7R2
	 Za4Ky13ASREhFVbX1uGrRmwtXaqmMLVnbK0wHpJst9lF9nQ97HN9dujeP8WIySrAod
	 suOpisJDZK5M2wbqMdmaldf1Fjz97jNne32fQbz8VBZ8isfHvUNV6IT0Nll3oqiFcu
	 kwTG7EhCPWoTg==
From: Mark Brown <broonie@kernel.org>
To: Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Ranganath V N <vnranganath.20@gmail.com>
Cc: linux-sound@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, skhan@linuxfoundation.org, 
 david.hunter.linux@gmail.com, khalid@kernel.org, 
 linux-kernel-mentees@lists.linuxfoundation.org
In-Reply-To: <20251104-dtbs-v7-1-224aacb09671@gmail.com>
References: <20251104-dtbs-v7-1-224aacb09671@gmail.com>
Subject: Re: [PATCH v7] ASoC: dt-bindings: ti,pcm1862: convert to dtschema
Message-Id: <176242884289.2357326.13162539553675802549.b4-ty@kernel.org>
Date: Thu, 06 Nov 2025 11:34:02 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-a6db3

On Tue, 04 Nov 2025 16:04:58 +0530, Ranganath V N wrote:
> convert the Texas Instruments PCM186x Universal audio ADC bindings
> to DT schema.
> 
> The PCM186x codec provides a single digital audio interface. Therefore
> this binding adds a reference to dai-common.yaml and defines
> '#sound-dai-cells = 0".
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: dt-bindings: ti,pcm1862: convert to dtschema
      commit: aa897ffc396b48cc39eee133b6b43175d0df9eb5

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


