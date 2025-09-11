Return-Path: <linux-kernel+bounces-812972-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 09DFFB53F0B
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 01:23:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 502B61C8715D
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 23:23:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCCC32F6583;
	Thu, 11 Sep 2025 23:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iHu/aOUK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F9F22F6563;
	Thu, 11 Sep 2025 23:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757632998; cv=none; b=F8S6ysgnWqqJiV3yejDSlzb2aZFDQIruJWaR5XZxtwpMKEp5i0XtrOT+wV0NSFW0GRtXw564wYmQJPGZDgviMFR8xevAv5PwwsuOuAPiiObDEKHQwm9QLGpf4hSMZdl97AzwkZZtVPxkP3Vp8aK51k5Zb6TeT1GckJhjwYkm51Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757632998; c=relaxed/simple;
	bh=LVw0kihXPv2nJoGpHBBLOl7iJPth5gWYWTKn0o0RFZQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=ZmgKOYTPA/ho5nA1r53cmpgZHH7E7GBS/zfk1Wbp2SUrEvRT4DiPDbbMUUFBiEmOF2UTsT16KLSxMHn4Ca3HRpxIXMHxsF4Wbpr12FSvzvmuqtZHl+4XTLnV3aVh4M7w+ho7LR7gFsZJs5c+7xVdAoGYvNG1jt3FIIgbs40ENTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iHu/aOUK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41D4CC4CEF8;
	Thu, 11 Sep 2025 23:23:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757632997;
	bh=LVw0kihXPv2nJoGpHBBLOl7iJPth5gWYWTKn0o0RFZQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=iHu/aOUK0ZpoUvvdiD7kal4B1R4p16zhjEDWaEKmSER7bVLCqYVZq0ijytsLhzQ9i
	 cQIucew251f2h8kNCT43UAtxNyZo2dU49jHDN4QbxOPCdMMP19QUgyZhinkoydtqAJ
	 ukI1aApk4kIKwebxbXCFegY/encyrukUCELYeViJIUBjGk535sg/DtLPdrymNLwiS9
	 2EbYfvmnEq/ctarELt8qjwjkdCwtcxc5V49LPXByJ632QjCuNslj08VJzNLj1l/oKk
	 Rf5M4E0iac1d16uLnfykzO/wRGGjUnI32zshH0pU98/BKgjL+Da9wLy3erqEFFdRxh
	 JwH7o3eFCeD1Q==
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
In-Reply-To: <20250910-regulator-remove-dynamic-v3-0-07af4dfa97cc@collabora.com>
References: <20250910-regulator-remove-dynamic-v3-0-07af4dfa97cc@collabora.com>
Subject: Re: [PATCH v3 0/2] rust: regulator: improve the ergonomics of Rust
 regulators
Message-Id: <175763299499.199601.11128092939663917696.b4-ty@kernel.org>
Date: Fri, 12 Sep 2025 00:23:14 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-56183

On Wed, 10 Sep 2025 14:54:30 -0300, Daniel Almeida wrote:
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
[2/2] rust: regulator: add devm_enable and devm_enable_optional
      commit: 2e0fd4583d0efcdc260e61a22666c8368f505353

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


