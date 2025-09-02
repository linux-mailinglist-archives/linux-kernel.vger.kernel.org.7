Return-Path: <linux-kernel+bounces-796312-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D4D4B3FED8
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 13:59:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D590E3A5D09
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 11:57:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BCD5301477;
	Tue,  2 Sep 2025 11:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cNFlRtAi"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89161301463;
	Tue,  2 Sep 2025 11:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756813875; cv=none; b=lEaglgxjx7NBFyert/wz57qXB7SanOHTCVHYAqNcuKBhN7pnCGRVwx1IcZ59i2+oRbu4HJDTBP1ff6SSLk/wrO6VM34j86IRzTfBYfzSnmcB7pf5S80JDsMp5fKj+ZFtNtD9vGDyb5h3YLVEwNTJ3FS5iX7/5ZuL63oeyZk+xEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756813875; c=relaxed/simple;
	bh=k1JdNYvMbZDo7Tq2I4oNv+QatxGdW5GvntVkT7wUPiM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=pb44sb7s4HIQvSs8U0iU0/JklKIQ3MouCowrWAQoxLZL0C6sNwDLYyLW7KbBmmznK4TNEQ42YzPdDCeqzWEu85O2zcSAxMxm/xgyiIjnW1bdc54vuBSszxp7Wp1E12dB5sjXbWZ8LqAHpdWVWonNxmrDKaSqfUbjWfgLtRXOqts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cNFlRtAi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9E90C4CEF5;
	Tue,  2 Sep 2025 11:51:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756813875;
	bh=k1JdNYvMbZDo7Tq2I4oNv+QatxGdW5GvntVkT7wUPiM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=cNFlRtAi3zrRCToEt8gdqxNAYhJ69/csJc/llWf55tUnVXKGihtGq859lcJnt6fWX
	 uJfvQm/1xR2gvXJ3TmI4dRaBTmjhEtJU38zB1vqaDaw/J0/mCtvNdUaKFnKEnPIBoL
	 NnPdeZLxwWu5UooEhTtVIzfASY1M3KWHEccPFw2Z2+j9I9JkBYHJf3e//sdf5bxlex
	 Qve7aCDn0RdekJEI+xVGfpabwG1CBsSWR9WxWjtmxfiMezzj8I7sFa5UsMHRBW8sEW
	 lxmJ1cNINq/UIxB9VwH8GDiHKcDPkRWwBm9sgBOyUUPPoUwwqqneRflgxEm7x7kNUd
	 EMbLofPM1qarg==
From: Mark Brown <broonie@kernel.org>
To: Charles Keepax <ckeepax@opensource.cirrus.com>, 
 Maciej Strozek <mstrozek@opensource.cirrus.com>
Cc: Bard Liao <yung-chuan.liao@linux.intel.com>, 
 Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>, 
 Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org, 
 linux-sound@vger.kernel.org, patches@opensource.cirrus.com
In-Reply-To: <20250901075755.2070983-1-mstrozek@opensource.cirrus.com>
References: <20250901075755.2070983-1-mstrozek@opensource.cirrus.com>
Subject: Re: [PATCH] ASoC: SDCA: Add quirk for incorrect function types for
 3 systems
Message-Id: <175681387264.70970.13087282482193667107.b4-ty@kernel.org>
Date: Tue, 02 Sep 2025 12:51:12 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-cff91

On Mon, 01 Sep 2025 08:57:46 +0100, Maciej Strozek wrote:
> Certain systems have CS42L43 DisCo that claims to conform to version 0.6.28
> but uses the function types from the 1.0 spec. Add a quirk as a workaround.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: SDCA: Add quirk for incorrect function types for 3 systems
      commit: 28edfaa10ca1b370b1a27fde632000d35c43402c

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


