Return-Path: <linux-kernel+bounces-764837-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE4BCB227D0
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 15:09:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 11F23580D1F
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 13:01:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8D4B27A455;
	Tue, 12 Aug 2025 12:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iUPtbqOz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 420F81EDA1A;
	Tue, 12 Aug 2025 12:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755003527; cv=none; b=a2mEWaP1E1qdb4U4fI60a4I6h/HhkoPkvvIJKz7fV59jaEeyE2I/pDVkuSnOrqWRIS3Lzyr/RpVTtkBGb8wKkxOT+BALc4e4qzzsVE93qwPSWndcspFClIbvZkcIDuwYeNmPGk4cZxT1v/6a5mu9ae5I7SD4JBpg3E1CB+t6Fh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755003527; c=relaxed/simple;
	bh=G79kXyZH3s5HZ/rmGSr0eoctrROzC2ER2aMn03NKGmg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=DPOHylmZ9/f71H/ic4EyBnEnz2MQmF+cW6x2sgJEWnFQO+KUoOq2fhIvrQyF28K2Hdq36OyJSMgGIaBjJxb2yGUghpyUQJv4VOty08sunQnWppjf1A4p02uAZMOGUpkqNKrYTF9LA693ePi50wB8gIx8cRW4VDpB/cHwihSLlXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iUPtbqOz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F489C4CEF0;
	Tue, 12 Aug 2025 12:58:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755003526;
	bh=G79kXyZH3s5HZ/rmGSr0eoctrROzC2ER2aMn03NKGmg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=iUPtbqOzSx3kCqb5d4NtiuwW5jXc5HwbtRm69oq+gB9iDbjh78faaJlgh2Jb+FrEh
	 C85FyEtNlu/XcbWcIQmS5crBJxo2godSTDN31ea/HwIvl6floX5eMsH6xrGHbRALXB
	 WkOsYvP/c5lxsIiQJfmrGgNJNh45y2v8Q7U1AGdAoq54yrTsgjJtmSw55JBBQFUh/H
	 DmsvR6K35HNq7LknPZX/hUKE2cVuzAZbBwtKOCCCAy+WHAuJfA97WVZRhH4S5GWhqD
	 j3exVuvwe4N3G0/6uGuawCdLlbCa/IAH900R2ky/6kcD3LR0tHz3qT6p4kzIVYJLlv
	 n4zeFdOhdOIfw==
From: Mark Brown <broonie@kernel.org>
To: Liam Girdwood <lgirdwood@gmail.com>, Miguel Ojeda <ojeda@kernel.org>, 
 Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
 Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
 Danilo Krummrich <dakr@kernel.org>, 
 Daniel Almeida <daniel.almeida@collabora.com>
Cc: linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org
In-Reply-To: <20250729-regulator-send-sync-v1-0-8bcbd546b940@collabora.com>
References: <20250729-regulator-send-sync-v1-0-8bcbd546b940@collabora.com>
Subject: Re: [PATCH 0/2] rust: regulator: relax a few constraints on
 Regulator<T>
Message-Id: <175500352391.61648.4220468114741869188.b4-ty@kernel.org>
Date: Tue, 12 Aug 2025 13:58:43 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-cff91

On Tue, 29 Jul 2025 14:31:39 -0300, Daniel Almeida wrote:
> This series implement two related changes to address a bit of an oversight
> on my end on the initial patch for the Regulator abstraction. Note that
> this is not a fix, as it just relaxes the constraints on the previous code
> as it is safe to do so.
> 
> Patch 1 removes some needless &mut self for functions that already provide
> their own locking on the C side.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/2] rust: regulator: remove needless &mut from member functions
      commit: f7fbf3091f4cc4133574852f655593e1613d1af0
[2/2] rust: regulator: implement Send and Sync for Regulator<T>
      commit: 9a200cbdb54349909a42b45379e792e4b39dd223

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


