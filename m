Return-Path: <linux-kernel+bounces-801451-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EEAFB44518
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 20:10:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 30A217A8E3A
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 18:08:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0CC634320B;
	Thu,  4 Sep 2025 18:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iFv0cUxB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E381342CB0;
	Thu,  4 Sep 2025 18:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757009386; cv=none; b=qrhHajB4az7yNQq9iIXdYVfHONMpzAGpCKHD9J4qMQXy2j+g5laz32VKnfOo3aCuDs9ckrh0SmzOcuW5nn939FWD85GNwUT9zoaGLXc8bmMzQ5jBYpu9xC6slulWOIwHrYWtr/MX7p4A0sZk+eN1Z6PDS+thztH9ekvKT6wmTuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757009386; c=relaxed/simple;
	bh=Jtn2SyIE5v8kRCMdny/OerWg8P+zl1zMi+jLU/fKX7g=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=RZIk05xx56n0ZBqawHYbs8LUAWU1ffYH6HQjw1oCQd1PILmi60bR7j4uot+y3UrkaxcXv+Bqy5hLwKk7Iz10/wN4qOBLxLj263mmhLFWLZFVy4Y9c2Lsc5zirD41w6Otru471csQDPFAUCtufmrEITDDQaC3HuVM4T+kL2ehAcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iFv0cUxB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59B31C4CEF0;
	Thu,  4 Sep 2025 18:09:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757009385;
	bh=Jtn2SyIE5v8kRCMdny/OerWg8P+zl1zMi+jLU/fKX7g=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=iFv0cUxBjI0coDlZV9JjJS0A4l4ZWFLZ7Wo8K0pUOpsBhKv9FYV0bZ7xKAaWtwV83
	 yev5q1WXWB+chu2a9YcBzcgj/2IzowXKyzBUHnJbLQO3p+tgGxvoSXN/jbpgZcTeHV
	 8W4nddg5UqJxX0NgT0P4xXXr68fI6554fuFfy++ZctQ0TCX0eZGZq3p4es6M/+dAPM
	 ytt0Ps5j5PBWkLodfPhWqtmxz2ISRzdJRraJ5HWREV1RnFDDL6bWmR52ukQuodPCKH
	 kARNjH5wwbxFpIl5KT1MkgRn5B52Mvv3n3B02l9Ntjwjw+RLU8NLicHU2ksbEntM/7
	 0McS7iNJxznxg==
From: Mark Brown <broonie@kernel.org>
To: lee@kernel.org, Charles Keepax <ckeepax@opensource.cirrus.com>
Cc: lgirdwood@gmail.com, linux-sound@vger.kernel.org, 
 linux-kernel@vger.kernel.org, patches@opensource.cirrus.com
In-Reply-To: <20250903094549.271068-1-ckeepax@opensource.cirrus.com>
References: <20250903094549.271068-1-ckeepax@opensource.cirrus.com>
Subject: Re: (subset) [PATCH 0/6] Improve cs42l43 suspend/IRQ interactions
Message-Id: <175700938410.120028.427826203393006933.b4-ty@kernel.org>
Date: Thu, 04 Sep 2025 19:09:44 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-dfb17

On Wed, 03 Sep 2025 10:45:43 +0100, Charles Keepax wrote:
> cs42l43 uses pm_runtime_force_suspend() during system suspend, however
> this means care must be taken that IRQ handler code isn't running when
> entering system suspend as force suspend will ignore that the handler
> is holding a pm reference. Typically the result of this is just a few
> error messages, but better to improve the handling and ensure that all
> IRQ processing is synchronised in before system suspend.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/6] ASoC: cs42l43: Rename system suspend callback and fix debug print
      commit: 638ca7601f41a3f8368811f3185b06e2547b7a0f
[2/6] ASoC: cs42l43: Store IRQ domain in codec private data
      commit: 149dda5f42a8fa6dacf2cff1d16952de28622d30
[3/6] ASoC: cs42l43: Disable IRQs in system suspend
      commit: a69b4ba19a07896e7e4246446bad002f5fc0dae1
[4/6] ASoC: cs42l43: Shutdown jack detection on suspend
      commit: dd7ae5b8b3c291c0206f127a564ae1e316705ca0

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


