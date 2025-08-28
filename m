Return-Path: <linux-kernel+bounces-790181-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27F78B3A212
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 16:36:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2EC5D583F54
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 14:27:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5C59313548;
	Thu, 28 Aug 2025 14:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aHrNGTMa"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C1D8226D18;
	Thu, 28 Aug 2025 14:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756391205; cv=none; b=ZhPui96gCsterHg1VJSx840Y0lhrkpANeeP8wmHHpeV7Dxt1lWmS+cVQRKcfIRWN207yA+CtbEQP49aj1Mwmz62P2gc9i1R17RqO0GOCvIhnVShORHwF00E7uP2vJTAmXy3m+wlHPSLulbpBkaD4dPkYPTFRMsMeiP/j1gPbTWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756391205; c=relaxed/simple;
	bh=OgX2g1VbwOW3A/1+b5scV4T2jr/8zC7Zzky6etYrcv4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=GklKr7MAd4/0EA9AAUtEVj6+xhsbvSSDBWOYk6NfvJfdG2Y1U/CCa3+7NODp2XD8oT5I737hoo2TPFSWti7fYyr+zQC+gb0YtFkCrIgk/FqTbfqX8dDPAuzZT7lfSNjomZdg3YcqC6jCcfh3GEumlwmyZnJavHFa8GJNgqoWEFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aHrNGTMa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74F6AC4CEED;
	Thu, 28 Aug 2025 14:26:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756391205;
	bh=OgX2g1VbwOW3A/1+b5scV4T2jr/8zC7Zzky6etYrcv4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=aHrNGTMaTGob9tj9cRYan5PlGmiK7c94wZV665v4S6Iftfjt3+XWdaYcJmN6OIfoL
	 OIOw+9FouyrcEVNVPjRt2H4tZTs4B/DllMrkQ9x1XwYGN1cslg+511hgE/GwvZ0wrf
	 iqBDxrwtgreuOJB9XybZzvXjemhOl7JILve2tMco8BR5UxfppxrZHy53IHlpAc5Ukh
	 Dt4IMYIAsXWE3noY5UWAUe9CEq4Ez8MopM4DeRxc34OO77F6rf+0WEC93PzP8S0LAs
	 Cg9V/k2K4WfI0CD+z3BZwKZ7Y5xt4QhKiSsZ8GrnU1VTi2JY4Es+Q3Z05kBkjtF1Or
	 xz3G0AmYNTRug==
From: Mark Brown <broonie@kernel.org>
To: Liam Girdwood <lgirdwood@gmail.com>, Chen-Yu Tsai <wenst@chromium.org>
Cc: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
 linux-sound@vger.kernel.org, linux-mediatek@lists.infradead.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20250825151111.3696404-1-wenst@chromium.org>
References: <20250825151111.3696404-1-wenst@chromium.org>
Subject: Re: [PATCH v2] ASoC: mediatek: common: Switch to
 for_each_available_child_of_node_scoped()
Message-Id: <175639120317.325624.3705402613246984996.b4-ty@kernel.org>
Date: Thu, 28 Aug 2025 16:26:43 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-a9b2a

On Mon, 25 Aug 2025 23:11:09 +0800, Chen-Yu Tsai wrote:
> Using for_each_available_child_of_node_scoped() allows us to get rid of
> of_node_put() calls from early returns or breaks in the loop. It also
> fixes issues with missing of_node_put() calls.
> 
> Switch to for_each_available_child_of_node_scoped() in parse_dai_link_info().
> Also drop the braces around if blocks now that the inner block is just
> one statement.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: mediatek: common: Switch to for_each_available_child_of_node_scoped()
      commit: b088b6189a4066b97cef459afd312fd168a76dea

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


