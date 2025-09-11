Return-Path: <linux-kernel+bounces-812971-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AF45BB53F0A
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 01:23:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 073271C86FF0
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 23:23:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B99D62F5338;
	Thu, 11 Sep 2025 23:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DzlkS6mx"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F11EC156F45;
	Thu, 11 Sep 2025 23:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757632995; cv=none; b=eGiyBDCKXwTfl3viyIO939ltkWbuHPAZV1ry0t81lDo+uJd9N3IIUFHgmK2G1Ij1goDbR2JJxWUoR62A3D9BpQN5YwTjhnkUVyDJPY95eYPz4KOtkJKbmoUUWR1cuaIaj13C7Pd4TGba5YdAMkyOTSsRH+3+Y1IXt3bvyKS2UqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757632995; c=relaxed/simple;
	bh=zKS1qog3ePk9Z6+h5QZDcuTiKqEZUbymRLcjTcUGg1Q=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=C0W5a8a6BUd6p9L89Acaia+93mecIJy3+WqLSII1EnUZ+Ha8meQEi7JFCSCay1O+kPfeX88ZUMhIpjgOBWq9i0bh9MBblY2QKCiAi+aDytG+NaA1KjBVJRXq73ckq7UbPA6tPF+mjKJLujkOpXFRbUeFAvdTG4s2wqcqUZ3X3wY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DzlkS6mx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19469C4CEF0;
	Thu, 11 Sep 2025 23:23:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757632994;
	bh=zKS1qog3ePk9Z6+h5QZDcuTiKqEZUbymRLcjTcUGg1Q=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=DzlkS6mx1iWED/6xUenQWGO0nUTRECEGsPg3EmXNjdKy4jrkkWKq5LaMD5QI1mIYe
	 cP40qG6qP+07+CeIcf82FjIHJpxm/BMWwtqNFnqF9c16LgN/8HCYY8Ze2RFhNJC173
	 EodlPSw4GGWVbptOVfBLwj+jiuujr2nxdqAx+sLBoDuPBIu38uj0oOHEa0LTKJPoj/
	 emm6/AxOcre9nM5vfpFTpayp6xygZ15MSnODX6gTQBV4TKm2ZWuULA5sP8VzRmrQSM
	 PH8abPpl0BALOyxwAuiNHccGO8t7vyN4UV7sjJdLYCd2iMAcOENCOD2Ef3k1nNtYAD
	 U6Ryay5HWMVVQ==
From: Mark Brown <broonie@kernel.org>
To: Liam Girdwood <lgirdwood@gmail.com>, Miguel Ojeda <ojeda@kernel.org>, 
 Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
 Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
 Danilo Krummrich <dakr@kernel.org>, 
 Daniel Almeida <daniel.almeida@collabora.com>
Cc: linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
 Alexandre Courbot <acourbot@nvidia.com>
In-Reply-To: <20250908-regulator-remove-dynamic-v2-0-e575ae2cde6a@collabora.com>
References: <20250908-regulator-remove-dynamic-v2-0-e575ae2cde6a@collabora.com>
Subject: Re: (subset) [PATCH v2 0/2] rust: regulator: improve the
 ergonomics of Rust regulators
Message-Id: <175763299182.199601.5497043017824444951.b4-ty@kernel.org>
Date: Fri, 12 Sep 2025 00:23:11 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-56183

On Mon, 08 Sep 2025 20:10:26 -0300, Daniel Almeida wrote:
> This small series comes after some extensive discussion on a few minor
> changes that can improve the current Rust regulator API.
> 
> Patch 1 removes Regulator<Dynamic>, as we have now established that
> there is no usecase that can't use the safer Regulator<Enabled> and
> Regulator<Disabled> APIs instead.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/2] rust: regulator: remove Regulator<Dynamic>
      commit: b87ecbc54f22382ace1cf41645e8652a4ce44d52

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


