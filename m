Return-Path: <linux-kernel+bounces-764686-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EA7A2B22605
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 13:38:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 151F5502611
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 11:38:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC8EA2EBB98;
	Tue, 12 Aug 2025 11:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ll31roH5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29FAA248F6A
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 11:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754998714; cv=none; b=EL8yeXFNRf5k1YV8PN7pV8zEVYmn9bwz21eN6AXZAskibGL2B8AO3tESBjAxux3sXalutCDd0/tSnwKGqQTG/NfRnm3D+vxlNQWJSd5RFtJ6WyWcULBgAAvKju15xzcy9Pi/5pCGvLucLZuzvC7nNrK7zxIG+h7/zzwS28gCBP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754998714; c=relaxed/simple;
	bh=9BEpkXszhtxLTv7+Vyx7bRPyP/C32Z9mVBYZkygal8E=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=RgjSzK/V+wSYDSDCU8XmkqWqxggnaaNAmiowboe92db4m1vOWhmhpWeZre/8EjiXO88W3JhzzYZ9Zf4Id7zOMMVekgfsYej+IWSo6LrG9Xd8cJ1ecB1o9v/1OzecXof5505pT3ExH63iSmhYr2e6zZ0xdlTB2a1L+HjMHM5h7Ho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ll31roH5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0112C4CEF0;
	Tue, 12 Aug 2025 11:38:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754998713;
	bh=9BEpkXszhtxLTv7+Vyx7bRPyP/C32Z9mVBYZkygal8E=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=ll31roH5p3O3TIGAsWEDIRKmI6Nd7roj0F9fFgUE2rxm23fnQrKhHSbmKSH0+OW9/
	 dmFw1HQNiraj8LQ959KHEmsPKdWHED8m6l9NHyqhFuzb5vW6t4Jy3K1H2QhMBTSQ4S
	 pFIuM8NJPoyXuLRlvvdtlRDKEC8UqCDQYLBxbIRIEdY3Es5BcoMVrel9vzZt4Xg3gG
	 +HaJY3mI8u8fgte5m3QnihBFH0AICZ079iupgyONHTXj/Bb471a1WDlo4OK5dxELUI
	 y3cvZp5fSblQoWZvltKACKrKH6MF6clbWQPWedlTShg3+YX1BrsE1uYwfm8KXH4txx
	 0LHl/aFDEtoFw==
From: Mark Brown <broonie@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J . Wysocki" <rafael@kernel.org>, 
 Danilo Krummrich <dakr@kernel.org>, Luis Henriques <luis@igalia.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20250728150829.11890-1-luis@igalia.com>
References: <20250728150829.11890-1-luis@igalia.com>
Subject: Re: [PATCH] regmap: mmio: Add missing MODULE_DESCRIPTION()
Message-Id: <175499871251.35334.8177128459051772925.b4-ty@kernel.org>
Date: Tue, 12 Aug 2025 12:38:32 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-cff91

On Mon, 28 Jul 2025 16:08:29 +0100, Luis Henriques wrote:
> There were already several commits to add module descriptions to regmap
> modules.  But this one was still missing:
> 
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/base/regmap/regmap-mmio.o
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git for-next

Thanks!

[1/1] regmap: mmio: Add missing MODULE_DESCRIPTION()
      commit: 886f42ce96e7ce80545704e7168a9c6b60cd6c03

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


