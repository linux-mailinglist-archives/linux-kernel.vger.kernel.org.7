Return-Path: <linux-kernel+bounces-790144-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AECB5B3A0EB
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 16:16:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C9FE3B36FA
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 14:13:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4A21350837;
	Thu, 28 Aug 2025 14:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eqjpdjZ9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D19634A31D;
	Thu, 28 Aug 2025 14:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756389765; cv=none; b=XYaWgbgXyhOpF7qqSkvMHrId/vNIQL3EfvOWQOu9CbVhDXfmyoFINenK00np0Qk2TXnbi/1i4YBOFvGOzn1ts3269dlgztbLSsHaFeL1F67OQmlA7pMjrpdWFZS232qIl6FZ6zjkZH5vIt8MsYDSMMNB8ud283TAVEvlPgtIlmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756389765; c=relaxed/simple;
	bh=wvZUR1kXkXm/C/ySMaGvGbZUESL+TLpkEANKBKV+oQw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=F1+6flgHR9ozkKCaOfj8PYiNF1mfE46n/1TTfcFWJvNfsORUcxAyPkZsMoyaUjFW2bQROPWxtQWqwuyre/p65+mzAus5CEJumXLbaH66fqR1Ku2wTYs4XZrL/rlQIH51jQJmCsFZIxyGQWmLZa50r2hpKHLjMv0V4e1cvU6W36c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eqjpdjZ9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA216C4CEF5;
	Thu, 28 Aug 2025 14:02:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756389764;
	bh=wvZUR1kXkXm/C/ySMaGvGbZUESL+TLpkEANKBKV+oQw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=eqjpdjZ9mJxt6BAIT8sdnHDawZxdxwbM7I7b/0zbR4pnZaEf05UAZDSxBCAKJb5+G
	 Xz6+sc0NBbU3TRs4puFNXxCiV9QPz9wv3IgWl6DE8JUuq2EjXC77+hUBgTMLKFhZz1
	 +snYxc8bXBE1d4wigv5LjIBDXtB7zhZHB7tZsdShdxOLUIcfs5XRaUhwQ0Id/oUTXx
	 /7DohtQo1b/13QmYl0731Sob+ETEi06T1JaJEu68nw4L1g7GPqmSp8rokJsVLsrO5C
	 uH5PRrnifk8oYBxM5E+W3zoRDBMTx08gI6DGQkTgICG+u97w9qYeTplbM2mj/Jp7mw
	 QXkpahHhYFO3Q==
From: Mark Brown <broonie@kernel.org>
To: rust-for-linux@vger.kernel.org, 
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>
Cc: lgirdwood@gmail.com, ojeda@kernel.org, alex.gaynor@gmail.com, 
 boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com, 
 lossin@kernel.org, a.hindborg@kernel.org, aliceryhl@google.com, 
 tmgross@umich.edu, dakr@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250821090720.23939-1-work@onurozkan.dev>
References: <20250821090720.23939-1-work@onurozkan.dev>
Subject: Re: [PATCH] rust: regulator: use `to_result` for error handling
Message-Id: <175638976137.317252.6588079114930725416.b4-ty@kernel.org>
Date: Thu, 28 Aug 2025 16:02:41 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.15-dev-a9b2a

On Thu, 21 Aug 2025 12:07:20 +0300, Onur Özkan wrote:
> Simplifies error handling by replacing the manual check
> of the return value with the `to_result` helper.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/1] rust: regulator: use `to_result` for error handling
      commit: e2ab5f600bb01d3625d667d97b3eb7538e388336

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


