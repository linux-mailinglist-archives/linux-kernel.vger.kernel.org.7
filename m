Return-Path: <linux-kernel+bounces-764839-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CFDF5B227D3
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 15:10:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A95E1581CB6
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 13:01:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCAB326CE37;
	Tue, 12 Aug 2025 12:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UVxS9pjf"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35FC827F171;
	Tue, 12 Aug 2025 12:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755003532; cv=none; b=EXG545aMCRI6VoxA2e89S3FWD/XzW3P5JzjZu6gylh2bmZMCOK31mfrPe9m9kvTVbA8TQp93Y9qMC8fM7Fv90feOgHsL7yycB454hVVzA3SC19WlddCaIAFJVfV/ZyyrxjMo+Wwgoi08UO0SZwFggP4/LasNOG8iuBzCOoM7YEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755003532; c=relaxed/simple;
	bh=+LCcEfDgd6WL/WHp1RealHr5ufZ7YIDstKbYxgCkn6c=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=otBfj+dHqnB7WyS4HHXyt0LT+wxTVdD3vTdNeMu+u7WgaPHOirKnbkBb179AdtgfBCnIeRR9uJ/D05zIAn3RTOVV51G9pnUq1oz3Rxaaot+kaM6uyo+4wvNP4zLlNux5ejbB2UmqJvvQ+PshvD3FjNFWEkxbI5+Q8VKEKQpF1Ig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UVxS9pjf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99F24C4CEF6;
	Tue, 12 Aug 2025 12:58:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755003531;
	bh=+LCcEfDgd6WL/WHp1RealHr5ufZ7YIDstKbYxgCkn6c=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=UVxS9pjfY+sm3xKFQhkmPq1fgxrkh0jhRZDXP+kY3ciTFMFxVBxfIog/O4tHwRZlT
	 VZlIO8/F8wgr50CMOWXeQRtBKc7bSFQ5B44vx+m6UGHJevJTh5HB3j1QLgwNUiV2tQ
	 I5mn+8M8gbwHaPrBJ+NSHDWQbRdcJolUO0gYvVIVMeQCSYr97FnDzT068QlpsJLC29
	 nr2WamtTWijXhcO4KKebt8Dk+xtoasrCiv2IANkKvzkTxNLvD7VeyEcmOopGMIs7kD
	 zMVXhnnuCzTdUb6Pn1u9XS7mJDbKWx6TNAYeKw9HBUWDZtu4XTDn+PGLe+c8wyLAwY
	 +bVTFdkNO9DQg==
From: Mark Brown <broonie@kernel.org>
To: Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Guenter Roeck <linux@roeck-us.net>, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Conor Dooley <conor.dooley@microchip.com>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>, 
 Ninad Palsule <ninad@linux.ibm.com>
In-Reply-To: <20250811141526.168752-2-krzysztof.kozlowski@linaro.org>
References: <20250811141526.168752-2-krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v2] regulator: dt-bindings: infineon,ir38060: Add
 Guenter as maintainer from IBM
Message-Id: <175500352936.61648.2539511903701949709.b4-ty@kernel.org>
Date: Tue, 12 Aug 2025 13:58:49 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-cff91

On Mon, 11 Aug 2025 16:15:27 +0200, Krzysztof Kozlowski wrote:
> The infineon,ir38060 binding never got maintainer and fake "Not Me"
> entry have been causing dt_binding_check warnings for 1.5 years now:
> 
>   regulator/infineon,ir38060.yaml: maintainers:0: 'Not Me.' does not match '@'
> 
> Guenter agreed to keep an eye for this hardware and binding.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/1] regulator: dt-bindings: infineon,ir38060: Add Guenter as maintainer from IBM
      commit: 4b0ad968717eb1862b74c1f549e4225bf95c286f

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


