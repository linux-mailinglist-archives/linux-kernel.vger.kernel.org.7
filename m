Return-Path: <linux-kernel+bounces-830662-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 33473B9A3B6
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 16:25:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9CDA2188D28F
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 14:25:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FD24306B25;
	Wed, 24 Sep 2025 14:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BUvgVJSs"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC8091C6FF6;
	Wed, 24 Sep 2025 14:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758723895; cv=none; b=Y8giNHy6rBIuOk8NQkBPj2MqomY6PApGzDs7rZHbTOQpDgLc61jHNPJzKvP57J0r90ZUVURXf+JEoE3SJ+YZPe/qURuqy3vyU+8iD/j+E5dSg/gmhf1tBMESeXvJhtfL7Mpx0qvy3xRKXNGxf0TJ+L+9nwWbPea+USCG9axdAUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758723895; c=relaxed/simple;
	bh=uAsROz+fJIhrI1CSE6QcyzehMYb5q4yBZaxxxQ5DZ5Y=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=sSu9P3TPdpGmOrQzGCUdh0o7RmIs1tuFUJPog+2AFos9BEDYG41qdVfCa7M6uEBfiyqPmeInBXNlmLizepH3xyM+UKllIVwygkO+ises5b3fsZq8NN76IOP1JhSrkaR/6t5h7rrTFAdb2L1iXjiHZR9d0lbD4DQLKdy90AXhwtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BUvgVJSs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82B74C4CEE7;
	Wed, 24 Sep 2025 14:24:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758723894;
	bh=uAsROz+fJIhrI1CSE6QcyzehMYb5q4yBZaxxxQ5DZ5Y=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=BUvgVJSsigLi1AjxExmfp84QYWhdWe/v+vkT+CpNeEek6EDth1R46wmnJzvYGxnLI
	 jjB3lhjCgFebr0tcqe6aXc3wlF3vPN5XV5lnbQtDt+tAcxiwwxgqudqqISy2FlRN3f
	 2Rkb0oBp7bC8by/1qeBXKSmKdKz4G1ryPJBKVAK8PmzJ8qX8qL+qwm4tJMm+nDj2yc
	 USVHy52+yVwBVP4T+wPe+Aek1/02WLxRwg5bXfkwQKXd1d17R7cmSPRMyjhOFpJFeF
	 LjcResVQvdWcAO/JcfDy9o34TgGjGtI0NjpswveTMVI4ka+XwEFVz8DRzYfHxUwc7n
	 +TfGiBBs8LP+w==
From: Mark Brown <broonie@kernel.org>
To: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>, 
 Dan Carpenter <dan.carpenter@linaro.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, 
 Takashi Iwai <tiwai@suse.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
 linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, 
 kernel-janitors@vger.kernel.org
In-Reply-To: <aNKEZ3VqJ8js208v@stanley.mountain>
References: <aNKEZ3VqJ8js208v@stanley.mountain>
Subject: Re: [PATCH next] ASoC: codecs: wcd-common: fix signedness bug in
 wcd_dt_parse_micbias_info()
Message-Id: <175872389228.1256972.12002834725304687219.b4-ty@kernel.org>
Date: Wed, 24 Sep 2025 16:24:52 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-a9b2a

On Tue, 23 Sep 2025 14:28:39 +0300, Dan Carpenter wrote:
> The error handling does not work because common->micb_vout[] is an array
> of u32.  We need a signed variable to store negative error codes.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: codecs: wcd-common: fix signedness bug in wcd_dt_parse_micbias_info()
      commit: dc64b3d42cb361d4b39eb7cc73037fec52ef9676

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


