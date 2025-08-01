Return-Path: <linux-kernel+bounces-753743-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 22018B1873B
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 20:14:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0FADF5671A0
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 18:14:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DBC728C860;
	Fri,  1 Aug 2025 18:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gyMTsLul"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F36541C62
	for <linux-kernel@vger.kernel.org>; Fri,  1 Aug 2025 18:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754072048; cv=none; b=bvCyOwOTkvXycWF/7lGtF6iQSo0sHKwTBrivScgc9Pa7CHIfC6bGa/6zPimTDpuo4kf/YsrJUFQvFwuqjzuVJ7/Du+q9OGqUyO59/YKj4ua65Li+2Yuwzqcy9KpW/jmVgTRbnVkgHXy12J1e6CWVLa8GFSGysGod8A01n/4Sfl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754072048; c=relaxed/simple;
	bh=3nj88DXwdIUKnWYFszs1tYhh29siaAN6sBkS3oig794=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=afKj8ixQMhTw4fnfteWe08fn+VAxc8+KtalSuJYKOBinnS+RGYMGHHwOi0IzBIMrgUkeBbPM4OAKMajbwb9v2+O9CQRZnwQAcox/PGvLDzi11FCrON6FpORvdNIKL6SBQY94f20wSwB54qQ2g0KXqoSYEW35eblNTrI+3/CwnLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gyMTsLul; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAF67C4CEE7;
	Fri,  1 Aug 2025 18:14:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754072048;
	bh=3nj88DXwdIUKnWYFszs1tYhh29siaAN6sBkS3oig794=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=gyMTsLulgROTDxvqHxiAWIzMugwUyYZeoynGUBoFfJi9ToEhT/NwNg4s1dKw+c0Bh
	 wCBdYNYRhq/41wDgp+9weP3Xqix4ycTg39Rv7gBlIGUG8rkZOA7NQRnQO/WhylxIs9
	 7HaB6Qn7dOUSqkfHsIFoascoXHjVsStpKsCVcS1yMOq967sHWh0fPuSooJN4vsuVuk
	 KO8WolJEsxUi1NuP7zHhamcpbrDDSPXu9ArZc877hkB95tfTcluqVadO3ilvUqhp4h
	 xyAhFJNd2lUmJAh9aN0adSi4UHUdbck1RJdF4r/X2ezy3JO/0k7uaMPd0mbhIOuHPr
	 6of0g/Rr8OVKQ==
From: Mark Brown <broonie@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, 
 Mark Brown <broonie@kernel.org>
Cc: "Russell King (Oracle)" <linux@armlinux.org.uk>, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20250731-regmap-irq-nesting-v1-0-98b4d1bf20f0@kernel.org>
References: <20250731-regmap-irq-nesting-v1-0-98b4d1bf20f0@kernel.org>
Subject: Re: [PATCH 0/2] regmap: Fix lockdep warnings for nested
 regmap-irqs
Message-Id: <175407204662.140152.11666162096319589102.b4-ty@kernel.org>
Date: Fri, 01 Aug 2025 19:14:06 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-cff91

On Thu, 31 Jul 2025 21:38:17 +0100, Mark Brown wrote:
> Russell King reported that lockdep warns when it sees nested regmap-irq
> interrupt controllers since it defaults to using a single lock class for
> all mutexes allocated from a single place in the code.  We end up with
> both the parent and child regmap-irq locked simultaneously.  The second
> patch here uses an explicit lockdep key to disambiguate things for
> regmap, the first adds missing mutex cleanup which I noticed while
> writing that patch.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git for-next

Thanks!

[1/2] regmap: irq: Free the regmap-irq mutex
      commit: 1da33858af6250184d2ef907494d698af03283de
[2/2] regmap: irq: Avoid lockdep warnings with nested regmap-irq chips
      commit: 76b6e14aa7b081337d118a82397d919b5e072bb4

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


