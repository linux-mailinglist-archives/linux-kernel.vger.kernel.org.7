Return-Path: <linux-kernel+bounces-768831-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C607FB26605
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 14:57:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 656A01CC474D
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 12:57:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D0A22FCBF1;
	Thu, 14 Aug 2025 12:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gk9SjFu2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C0CC381AF;
	Thu, 14 Aug 2025 12:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755176231; cv=none; b=uO/W3w+70FiZqZlWZh0efPizzTcRCIk4SFCVVWIRAEljMJ9x1h0W+/dQ0hduMVbZBvSlFw0PnhlIi4HwD+2eN+mHwH+J1bG+gypBkPRzu1WIma6HlaYIU+nVJNNul70ummCsCaZ+MzZhUOWR3Cgdfnrl3TyJ8v3ECLgLDBgjReU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755176231; c=relaxed/simple;
	bh=DXzjNuniit1erhE+1Xxu+Dwu5JyurG5ke6o1WkZEekU=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=o3It+qsUF536j3kPj81bzL/96V1HU1HqJvahh8a8eIEhvdJ52DTXWoM1rricsfSYdKDQgp7sKe2rz/DwLr7SrHpT3wZOCRycafBEWUwXBtl54qdE/sV8Pqut/RYagxDzkT77bnn2cW7k0qIOd/lQs7VAJPrtQEpEF8ZkWzowWyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gk9SjFu2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75A9AC4CEED;
	Thu, 14 Aug 2025 12:57:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755176231;
	bh=DXzjNuniit1erhE+1Xxu+Dwu5JyurG5ke6o1WkZEekU=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=gk9SjFu2BhsRAgxIqY5J0WeLMNGQhDZ10y5drdoqRTVgrACFfL6QMjEK1vsO4xYlP
	 dDqc0nVQQmN9riopqxlgJYO0N2va3Og6rKL7UcbzQohTMRiAoWL+7f7EjzskMAeLsJ
	 tzkeXVLNV5jS7bF47dfBOEFGIbeMnJvDv0jnzgYLeqDOhl6wN3m8/XywDZYGFBB72v
	 S7HH+h2HlQXuRq00FVaHmVdwS9OUw56uHulQuvbVcR828N05WYhWQkesMjjWUy47Du
	 GULLf0YYpb13uzvc85SU+9SkrHxkIuWCD+LF42SC6KJR6GXtUfITnlHbzuu8eXCI6R
	 /xLBpM7yrHtBQ==
From: Mark Brown <broonie@kernel.org>
To: Cezary Rojewski <cezary.rojewski@intel.com>, 
 Liam Girdwood <liam.r.girdwood@linux.intel.com>, 
 Peter Ujfalusi <peter.ujfalusi@linux.intel.com>, 
 Bard Liao <yung-chuan.liao@linux.intel.com>, 
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>, 
 Kai Vehmanen <kai.vehmanen@linux.intel.com>, 
 Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>, 
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
 linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Liao Yuanhong <liaoyuanhong@vivo.com>
In-Reply-To: <20250813093903.551388-1-liaoyuanhong@vivo.com>
References: <20250813093903.551388-1-liaoyuanhong@vivo.com>
Subject: Re: [PATCH] ASoC: Intel: sst: Remove redundant semicolons
Message-Id: <175517622799.36386.8181726432188367180.b4-ty@kernel.org>
Date: Thu, 14 Aug 2025 13:57:07 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-cff91

On Wed, 13 Aug 2025 17:39:01 +0800, Liao Yuanhong wrote:
> Remove unnecessary semicolons.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: Intel: sst: Remove redundant semicolons
      commit: 0e62438e476494a1891a8822b9785bc6e73e9c3f

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


