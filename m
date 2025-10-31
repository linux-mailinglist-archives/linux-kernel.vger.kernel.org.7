Return-Path: <linux-kernel+bounces-880428-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 92F7AC25BB8
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 16:02:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4F3964F7A3E
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 14:58:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1255526ED36;
	Fri, 31 Oct 2025 14:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PNAO7SPd"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E772266576
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 14:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761922093; cv=none; b=aiwPYw4GY2/a/H4zpVYYUOS2h288unJOnDksJ+jXdjB8lmnyz/MoP6KJpcmkyVXnV/VoQcXlOlOVP6H13GnKag3OZ9OKnK7wd/r2jNRB2uA6jIpjSh/aMe6OZTwSCGU3o8jNp7W6Hc2qVrfpm3ZypPdEr7XkygqIqhhcGvIA2m0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761922093; c=relaxed/simple;
	bh=o1eR2ebC7qkfAOMwfGl0rF+VIleQ3m7zmJ5rrx2N5h8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=KHC8F+MBkw9DUggRXORHtJwGPtllGEoyn9uhqMzFOJX/jrfm6n1V8fASwqje/tR5vko679AP4/QAEq9xfFvUho4UpeX4vH/x9dypDa2fBSgBryPrpljcnaWJ0zODJSmsiHGfxV4/gVsMoFJNYCzSO10O+J2BcWXYsSabXHOfs+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PNAO7SPd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28E43C4CEF8;
	Fri, 31 Oct 2025 14:48:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761922092;
	bh=o1eR2ebC7qkfAOMwfGl0rF+VIleQ3m7zmJ5rrx2N5h8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=PNAO7SPd6XeU9SFsUc21DvgJjOZUiMJPlh1GYJ17LSVJClp+2nRfCiEGIMBt7H0D/
	 iuG2swItDVsvNFbxMZegxk4vcHS+y5+z+2JljnnUrVQ58HjnXBr7mOCUKxAW4ArWOn
	 BAlwZG7BuJSWAcPiGTVbltrQ4NauTHFHF0XdHFrdaaKOfR5RDtx8nCIhUEmmzEqPrM
	 nf59txnaW/qFXHSus2/3bnijpyxxsFaCzIZZOdvL8EujsLNM+WerJY4F46fpcYSC6q
	 nPVRRETiY27H4jSUH6nTSrB+hJd9ZIQ3DnfUY3CdVs70SmFEYoqVlz1quiO9HpMnnQ
	 RXxTtTUmu5hwA==
From: Mark Brown <broonie@kernel.org>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>, 
 Sander Vanheule <sander@svanheule.net>, linux-kernel@vger.kernel.org, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>
In-Reply-To: <20251031080540.3970776-1-andriy.shevchenko@linux.intel.com>
References: <20251031080540.3970776-1-andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v3 0/5] regcache: Split out ->populate() and use it
Message-Id: <176192208852.71518.16317794120608559479.b4-ty@kernel.org>
Date: Fri, 31 Oct 2025 14:48:08 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-88d78

On Fri, 31 Oct 2025 09:03:15 +0100, Andy Shevchenko wrote:
> This is a refactoring series to decouple cache initialisation and population.
> On its own it has no functional impact but will be used in the further
> development. Besides that I found this split useful on its own (from the design
> perspective). That's why I decided to send it out as is separately from a bigger
> (and ongoing) work.
> 
> Changelog v3:
> - added missing space (Mark)
> - collected tags (Sander)
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git for-next

Thanks!

[1/5] regcache: Add ->populate() callback to separate from ->init()
      commit: 94a3a95f03154d8d4c6206950a7f6ef9a30baec6
[2/5] regcache: rbtree: Split ->populate() from ->init()
      commit: bda6f8749c8e0b10f083dc7a1edf169f349fb776
[3/5] regcache: flat: Remove unneeded check and error message for -ENOMEM
      commit: 27fef3048fe95934f6f2f87341eb33ef6581a075
[4/5] regcache: flat: Split ->populate() from ->init()
      commit: 44c1a444b030647803d900e60f5a8af31a782f0e
[5/5] regcache: maple: Split ->populate() from ->init()
      commit: ed5d499b5c9cc11dd3edae1a7a55db7dfa4f1bdc

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


