Return-Path: <linux-kernel+bounces-880427-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 56D05C25BEC
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 16:06:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 85A591C20941
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 14:58:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C719257431;
	Fri, 31 Oct 2025 14:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZddnmniX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1113192B84
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 14:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761922090; cv=none; b=fe+qYkxOUaJ8q/Py9XdNxTrdRuNHIoolui+n8hAKEhM2QwQk+z0GfSki68RmT23k7XBhrMwpoUB2fjOv38iG5rTUwcwg51zWQxqDQr8zVkTzTlgFvOzK68WgbBmVHZ12i1qImpSGYkGyeMSHOlMestVIltA7CbdX/3M0La84S0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761922090; c=relaxed/simple;
	bh=R6EBRAZZT2KV+i0R5WPb/d/NN6uSb73j2m8EIhfmUxc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=GnWpYwFnsKLXb41l92jys8swvKQIFIzenSxrFW2NuDicpqDiu7gYc2cOyDOdmyziQOvpPWNyPBqjHW2u10GX5u8RnJQQomkaA0TzjYR3HYjjqrJ3D0LnmPmJBeyC7reJADT2M4SJfjQtbofxdRMS26Yk2zOe1TwKAhEeqF9wu+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZddnmniX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26C35C4CEE7;
	Fri, 31 Oct 2025 14:48:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761922088;
	bh=R6EBRAZZT2KV+i0R5WPb/d/NN6uSb73j2m8EIhfmUxc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=ZddnmniXRhgDrPSbkDAva+eiCU83cpnGLgYUqGpD1BAGi8ehyX8kHt9XpwspdYJOJ
	 IaWu/zvCUFJ8GE9+aewAnfwTGgThlIt75H0TAHJmG0E4+ZTg1y5d1c8aJ11t23B+JT
	 nRIZOj9/YxlNkIPhOpDMcz26EPJ0j3R4JHIvmGF35IASIu+FNzDavD3e8hDFELL1OS
	 5kVYlDKPbbLr3smIGgc/HabJ6a9+5HUWbNh45n+Q3dLisbXxic3IAr59ONl+ycnJw0
	 pQBX0QJLz28iSvaB2eW+OGg/gBGMMKIGXzaynCj+gMf4xV5B8hmTIAi7BCVOObkwTr
	 D304AC4k2zEJQ==
From: Mark Brown <broonie@kernel.org>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>, 
 Sander Vanheule <sander@svanheule.net>, linux-kernel@vger.kernel.org, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>
In-Reply-To: <20251030173915.3886882-1-andriy.shevchenko@linux.intel.com>
References: <20251030173915.3886882-1-andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v2 0/5] regcache: Split out ->populate() and use it
Message-Id: <176192208580.71518.3306983569007220175.b4-ty@kernel.org>
Date: Fri, 31 Oct 2025 14:48:05 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-88d78

On Thu, 30 Oct 2025 18:37:00 +0100, Andy Shevchenko wrote:
> This is a refactoring series to decouple cache initialisation and population.
> On its own it has no functional impact but will be used in the further
> development. Besides that I found this split useful on its own (from the design
> perspective). That's why I decided to send it out as is separately from a bigger
> (and ongoing) work.
> 
> Changelog v2:
> - rebased on top of the recent regcache changes (Mark)
> - a new clean up patch induced by the previous
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


