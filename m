Return-Path: <linux-kernel+bounces-765118-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 32726B22BB1
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 17:29:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 188851A26C02
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 15:29:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73FA02F549A;
	Tue, 12 Aug 2025 15:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J9SloMJT"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA7742F5481;
	Tue, 12 Aug 2025 15:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755012551; cv=none; b=dFdCRzAOCtxeaeHahtxH4ff4VUA68F6Br580Z8syUDDW6BqTKlM6o12/ft/LN42Ap806D8HMLMRJTaenr695DBxjgyK8GIDp3lSCQT1q6Txb3M9tpRWlGMjpWCaqej+C4qOknYMpwJx1CpPkikkwgz9JIYP1Amov2m/TfxnOJTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755012551; c=relaxed/simple;
	bh=m5eXkqwhtq2KR/p+yktgoCeF4iXuruewK5AtT05FGGs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=AcSJlkda8YskG6NH3vKBQDvuABYJh2KuInPS/hRlbFJrjsivBYmVMnVtPvr7Z8+uYWlDw0eGs7hBf6Pe58QneK9JNodRKUrINiXOn0BryWQYmsy5D+rQPL/ar4vZoS8Ua9noiNKXPI3l85F0t0NgG339gbUgxISwzNs31lejwqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J9SloMJT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1725C4CEF0;
	Tue, 12 Aug 2025 15:29:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755012549;
	bh=m5eXkqwhtq2KR/p+yktgoCeF4iXuruewK5AtT05FGGs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=J9SloMJTLL3BLKO0t/Tm8vXsuj5upbYZzV3cUUZFig5ZVZ9AZypCAT56QMnxv+zd5
	 b/FjxwE9ZoMpfMxWBXSwo/j5kwrq9vtB7PkzVvUdPJzu6l4tmRHCe+xMOsNeenwmxs
	 5xaVEqV6P+5LlJoivG0MK0FeGt4fU8cpt2c2I6ZtY/XHVRht1vA3+x0g4PaVOt4B1u
	 r4Ku73yHl5HqAg/v3OyUA6cCABJeYXXasG9Lo2a0A+S5bs7B1K2AWMgkqeBbHkPGEd
	 L6O9ICfa9QUYnYydppGyTBgPu42kWiobhb9PLSFuhTk5aqjADSpti76DQcO27P7AGH
	 hop8lUwn4kRng==
From: Mark Brown <broonie@kernel.org>
To: devicetree@vger.kernel.org, Mahdi Khosravi <mmk1776@gmail.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, linux-sound@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20250811080940.7909-1-mmk1776@gmail.com>
References: <20250811080940.7909-1-mmk1776@gmail.com>
Subject: Re: [PATCH v5] ASoC: dt-bindings: realtek,alc5623: convert to DT
 schema
Message-Id: <175501254765.179691.1589109865896563758.b4-ty@kernel.org>
Date: Tue, 12 Aug 2025 16:29:07 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-cff91

On Mon, 11 Aug 2025 11:09:40 +0300, Mahdi Khosravi wrote:
> Convert alc5623 audio codec binding to DT schema.
> 
> Also add "realtek,alc5621" to the compatible list for
> existing use in kirkwood-t5325.dts.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: dt-bindings: realtek,alc5623: convert to DT schema
      commit: 8c02c8353460f8630313aef6810f34e134a3c1ee

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


