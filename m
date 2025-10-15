Return-Path: <linux-kernel+bounces-854229-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id EF40BBDDDDA
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 11:51:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CBA9E4FCBEB
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 09:50:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28A9131B81E;
	Wed, 15 Oct 2025 09:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fpsm98x7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 608A431AF21;
	Wed, 15 Oct 2025 09:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760521814; cv=none; b=p5nPgZ1QrWllkZ0cF7M8XMkpFZrEiHJyIoOf3HHQuWRMV2+ua3jAbD4qQCbSzc6NH+3YE55d9zSm88+gZjxtt1zRj9ZVVmeUiHe65CQeJY8FvKsFo3pBPnwcNAf2D6o63Zf3Kx3be4qeWywgmiWnQXjO9k+J1vYmjIFQjJqjf3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760521814; c=relaxed/simple;
	bh=A8PnYNnjOxYGLcpodzQbDf2XY+QgzNNYgoiEfHUlOa4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=gc9GYgfEX6kgXAPOZJhYbZG/TB1a4n7lY2xkmL2yk6/axoGQfdf0TG3n+riEawH0wHwCsUb/AxbqkW927Fy1vOiNk752J5abOg9u0KxDH+FvXrBkFKM7eJSfgWeMW+tmmNTTxq/ShvqmAzQMcovcJhgeKxOb0FB1A8DkzIvAT5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fpsm98x7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08B84C4CEF8;
	Wed, 15 Oct 2025 09:50:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760521813;
	bh=A8PnYNnjOxYGLcpodzQbDf2XY+QgzNNYgoiEfHUlOa4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=Fpsm98x7e2NbvjVVNVBF/xkK+t9RhdQn4+bpOXyY8Voz8+yEhTAzQtqJS7jOtNPBD
	 DVDjCQSwrALxpb5oBqApFC0MWI0nkGNMXS/z+DbjJvLjjEoYwnVDd4nstxTVNykgDS
	 en6m8t4Ws096QL9ai1wkMOef8+wF/NqmY8kFCtB/3a/Clmg+ILDW1vEaaJU43DyBs/
	 P3pKhJjGzCEuF1hV9OMv9+M7NLi9YTzaqH1WRdvdHZBt5GNdLrRNvc8BmZmFypfzBQ
	 nCA7XVnTAS6USTCc8LTvsWnk8jzmnhzRo4lmkwkTD2odUs0SdoQdurKqvM1PJ/6FLb
	 4+DPMTHrR0ueA==
From: Mark Brown <broonie@kernel.org>
To: angelogioacchino.delregno@collabora.com, conor+dt@kernel.org, 
 krzk+dt@kernel.org, lgirdwood@gmail.com, robh@kernel.org, 
 support.opensource@diasemi.com, 
 Ariel D'Alessandro <ariel.dalessandro@collabora.com>
Cc: devicetree@vger.kernel.org, kernel@collabora.com, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20251001183648.83379-1-ariel.dalessandro@collabora.com>
References: <20251001183648.83379-1-ariel.dalessandro@collabora.com>
Subject: Re: [PATCH v3] dt-bindings: regulator: Convert Dialog DA9211
 Regulators to DT schema
Message-Id: <176052181177.20825.9765115621999860948.b4-ty@kernel.org>
Date: Wed, 15 Oct 2025 10:50:11 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-96507

On Wed, 01 Oct 2025 15:36:48 -0300, Ariel D'Alessandro wrote:
> Convert the existing text-based DT bindings for Dialog Semiconductor DA9211
> Voltage Regulators family to a DT schema. Examples are simplified, as these
> are all equal.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/1] dt-bindings: regulator: Convert Dialog DA9211 Regulators to DT schema
      commit: 6277a486a7faaa6c87f4bf1d59a2de233a093248

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


