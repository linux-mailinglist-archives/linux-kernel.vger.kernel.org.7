Return-Path: <linux-kernel+bounces-813057-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F1521B5403C
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 04:15:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E47D1BC1693
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 02:15:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D38D11D63F3;
	Fri, 12 Sep 2025 02:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r5VgAFzc"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32ADB1B043F;
	Fri, 12 Sep 2025 02:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757643303; cv=none; b=Dn8VwmoSeHEqOLAu4tg0BvXVGh39Y9aZdz/F/xIp20bMjmFSIu7Kv5fgYKwstPdHbqLsP1AkK3Tq07NesiO1HtCZRKmLQ+AY33Jl4KLJ9mPht61r6eqhR7oWyclqjLsYF2iIBx/YzQ86NPFJqhItb2s4Qw2Fk8u0aK65pJfvls0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757643303; c=relaxed/simple;
	bh=9y+Y1O7cHz+1ou12wkFRsbWoP440AHhTEUJXXVByc8g=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=XIO7XFF1LCQBhuqQZbRXrPWV9wB8alyulVJumAl825a3L3HUsDGlLuYWfsyvnBsHxzPDXLwYwmyoLkzo1v1BQajnyrEraCsv0rtjq1uDuSM+zW0qSdJfWKJlYC2Y8SzH5StCxz47RXgYbH+6WtLzzALg26R5GymHqbJZtVbhyJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r5VgAFzc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 688FAC4CEF0;
	Fri, 12 Sep 2025 02:15:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757643301;
	bh=9y+Y1O7cHz+1ou12wkFRsbWoP440AHhTEUJXXVByc8g=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=r5VgAFzcL4SRgF+N8CjGCcf9b22yPlb2g1j8/1UG4t7aKsjPIwyMdXUlOhQ4GrvAm
	 NcLCSfJJnv0ETl+fHQ7+LEHBPay6Ofk2VRqMgIPRJV0axanjkBqDiaDqk2MdIqFJBg
	 ZCf3QAdX+d9zPtAh0U46ujqhiwjM7zPsRtaWxT2m8Kbse6vrF0GlUhYdakjZ+QQsGx
	 e2NswzRFbUOAxYUhsNBgXx2O8avzCOkqgU7fTGqaYbmYEP6PVk8pI3q9QVAfJejPp2
	 nA045JzCSFspv1lBddd98z1R+yV4XMh8+KXD+edI6Ti/BTNT3+wXV3INC9Nqwcd3O2
	 RfiFzubsbqsgQ==
From: Mark Brown <broonie@kernel.org>
To: Liam Girdwood <lgirdwood@gmail.com>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, "Rob Herring (Arm)" <robh@kernel.org>
Cc: linux-sound@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20250910233615.775397-2-robh@kernel.org>
References: <20250910233615.775397-2-robh@kernel.org>
Subject: Re: [PATCH] ASoC: dt-bindings: linux,spdif: Add "port" node
Message-Id: <175764330004.255307.4320327456204417338.b4-ty@kernel.org>
Date: Fri, 12 Sep 2025 03:15:00 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-56183

On Wed, 10 Sep 2025 18:36:15 -0500, Rob Herring (Arm) wrote:
> The SPDIF receiver/transmitter can be connected to a DAI device via OF
> graph port. It is already in use and supported.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: dt-bindings: linux,spdif: Add "port" node
      commit: 59ba108806516adeaed51a536d55d4f5e9645881

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


