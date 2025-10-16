Return-Path: <linux-kernel+bounces-856201-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E47BBE375E
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 14:42:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D49361A62B38
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 12:43:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02331330D37;
	Thu, 16 Oct 2025 12:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NCzwt2aY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D6BA32D459;
	Thu, 16 Oct 2025 12:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760618528; cv=none; b=Hhe56JSzpeXiNJ5zKm/9P4ltRVpHXwfsqKfd74CJ9G8qir2mn1nY6tYxopaykISgOA4Rm+BG8x47Dllr0tdlqXRmEs/niEXI34dHC0dY1qNy5TochLheC1D93NwN99KQumeUIJFYCTprE0ydXB5JlrKokpVSN60yj5eUTAfolQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760618528; c=relaxed/simple;
	bh=yLkoC9bexsp0rz+m13EnQnE+1CpKO1ZweS+72nbnds0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Uc+L/8i8+2ia8uITiQdhOaJqrdRvqaJj/MQRJrpqy1sQgyXaPXE2LZCSQ7l/oGUKdqNNTk4wZN2Lp9PTIosgDbwjCxu2jFzLLt/o5jKTfhtMP65ttkHIoz/yTm4odFbwOpF9sSbr1vPPcVOH+b7LvrLvNju3Fa7ZuzQCS7Dnzx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NCzwt2aY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02382C4CEF1;
	Thu, 16 Oct 2025 12:42:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760618528;
	bh=yLkoC9bexsp0rz+m13EnQnE+1CpKO1ZweS+72nbnds0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=NCzwt2aYG7b3dTzMFyrnw+HSX/gpgauEusk0IORwgD3G4yNtoRp8M19Bb+aAixwcd
	 azVngRR2B9/r/rfQeRg1T+FSBxaVXUvAd6RzVR0AkCmDdOTbMGq2RoesBw60VrBv+i
	 aqrg+M12w9leUDy62HRptmkxswQaLskUVIsXLuf0it2OGPXt6jRfmSLfahCm5cgmA6
	 53N5d+eqYs2h/qw9oGO9wTWDVeygrtbYaoWs5dZgHy9/Uad7vfqqDhs2jRatME4JJH
	 HV/9Q4f5wjpKf5wjL6A3PF2jJ1VLhp/bMF6UX/rsMKBqOJqzqoWxfYL241jKZih4u/
	 pub6dLxhx3ebw==
From: Mark Brown <broonie@kernel.org>
To: Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shengjiu Wang <shengjiu.wang@nxp.com>, 
 linux-sound@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Frank Li <Frank.Li@nxp.com>
Cc: imx@lists.linux.dev
In-Reply-To: <20251010160321.2130093-1-Frank.Li@nxp.com>
References: <20251010160321.2130093-1-Frank.Li@nxp.com>
Subject: Re: [PATCH 1/1] ASoC: dt-bindings: Add compatible string
 fsl,imx-audio-tlv320
Message-Id: <176061852458.55339.3889292369003753911.b4-ty@kernel.org>
Date: Thu, 16 Oct 2025 13:42:04 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-2a268

On Fri, 10 Oct 2025 12:03:20 -0400, Frank Li wrote:
> Add compatible string fsl,imx-audio-tlv320 to fix below CHECK_DTBS warning:
>   arch/arm/boot/dts/nxp/imx/imx6dl-gw5903.dtb: /sound: failed to match any schema with compatible: ['fsl,imx-audio-tlv320']
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: dt-bindings: Add compatible string fsl,imx-audio-tlv320
      commit: fcd298fdc2a32f1d90cdf9a452c5c5fdc6e8d137

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


