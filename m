Return-Path: <linux-kernel+bounces-733844-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 70797B079BD
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 17:26:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E15EDA44C44
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 15:24:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94CD52F5C20;
	Wed, 16 Jul 2025 15:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iPO42vlp"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7EE028A1C8;
	Wed, 16 Jul 2025 15:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752679420; cv=none; b=QsaBk8gbbDnIyQ5hasmC6rpGB5yRN6QaZIng64P7OR2TT35zQlYSvlEPYZShoV/Mew3PrTs+cjm0YTFdeYl9OibHP16XKVUgIFfC1TT8wEaYV9PJWuIqe5IBIkBxeIKmRcYjXTpVdfeCSEyTrG0Hs9dN9zjEgUSHsWHrTx1BlfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752679420; c=relaxed/simple;
	bh=tpTs+jX92sQ6oTJ59R/yyANwWHArExgRUeTRqrhTvYc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=VydqD5qqri3N+ptpxUTEAv5GOqOjlwwMTLshrvnxfg5PPvzgjjrXu4cdD0AkfjgH5jTV1KRdYUT1bJX/7GyWpUzGPXUhvdNt8u5DanaLuhGxW/mVZk/hfA00PsdSzYoNBKT58LArRIkAWJAwoRuxEtF0BNlW8fM7gI3MrUkaaQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iPO42vlp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB00CC4CEF0;
	Wed, 16 Jul 2025 15:23:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752679419;
	bh=tpTs+jX92sQ6oTJ59R/yyANwWHArExgRUeTRqrhTvYc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=iPO42vlpAyw1KrQJuE0mB7ZC9S0O1uik/YV91c1X/9+ES4NhNS8Uj5Ff79sMhHC61
	 eTR8u9pNkHeiQkAmiDQKnvRXWmT+lBPOSWmGImKbHd2zO9A94fZPwRtIfVlRStS71w
	 fJyDYuIYl+DoXowwaI/sOS1U22bCdpgsxx0F9plHz8lZb1sidOinJBPz37QWa5TRJG
	 gMZXTjgyjoAE9bGAHpFTHsJuxyGOKbolMMqRvpq+MRN0i1ACyZo7rwL3EJGk5z8nkL
	 eFcf2a2I1ddqEEE0dElkQH9XmyQClOHcOnc6eEYO3DAiMugVczgCwMVWTIzsBmp4c0
	 xFDCGfLTGncsg==
From: Mark Brown <broonie@kernel.org>
To: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
 Danilo Krummrich <dakr@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, 
 Daniel Almeida <daniel.almeida@collabora.com>
Cc: linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
 Alexandre Courbot <acourbot@nvidia.com>
In-Reply-To: <20250714-topics-tyr-regulator2-v8-0-c7ab3955d524@collabora.com>
References: <20250714-topics-tyr-regulator2-v8-0-c7ab3955d524@collabora.com>
Subject: Re: [PATCH v8 0/2] Add a bare-minimum Regulator abstraction
Message-Id: <175267941650.716137.1066495222892798076.b4-ty@kernel.org>
Date: Wed, 16 Jul 2025 16:23:36 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-cff91

On Mon, 14 Jul 2025 15:52:03 -0300, Daniel Almeida wrote:
> Changes in v8:
> - Added Alex's r-b
> - Added helpers/regulator.c, since the stubs are declared as inline if
>   CONFIG_REGULATOR is not set (Intel bot)
> - Removed unneeded "regulator.enable()" line from docs: it was not needed
>   and, ironically, it misused the API by choosing Regulator<Dynamic>
>   and then not keeping the enabled count count balenced (Alex)
> - Clarified that the "Enabled" state decreases the enabled refcount when it
>   drops (Alex)
> - Renamed "Microvolt" as "Voltage" and introduced
>   from_microvolts/as_microvolts (Alex)
> - Fixed the spelling for MAINTAINERS in the second commit (Alex)
> - Link to v7: https://lore.kernel.org/rust-for-linux/20250704-topics-tyr-regulator-v7-0-77bfca2e22dc@collabora.com/
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/2] rust: regulator: add a bare minimum regulator abstraction
      commit: 9b614ceada7cb846de1a1c3bb0b29b0a2726ef45
[2/2] MAINTAINERS: add regulator.rs to the regulator API entry
      commit: d9f334fca5448907cc47ba8553926f9ba148512f

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


