Return-Path: <linux-kernel+bounces-771191-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91BDAB283FF
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 18:40:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 41D4B5A05DD
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 16:40:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D12930E850;
	Fri, 15 Aug 2025 16:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PNzn9niG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA7AE30E844
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 16:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755276001; cv=none; b=XIz3El9tPmT2Zvzp61svEqff2FE7KBj4bmb9ZAGFTDnVGgQc6wVlLMirHZW9PfYMK8UZja9CiS0rWVI3CbhsMoiKN5AUzqHMA1ug40zZwKx/NG+IlEaBjgmZt4Su5GrniKWSRd/t+6B4SKeSGQpG45TsdA89auxsBomU4jyX3vo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755276001; c=relaxed/simple;
	bh=EeeFqZS4JJOHrZXRZU/ZngCmex+Ibm/qQWj1VUkvDbM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=RSqCvdS+KoXI9B77oG3HXciGM9K6eSxjCb5HL3EHJUbenRD14NgdTjDhNE4OFB5l/xheUnIpWyKsFBbCzDTYcjfq5jf28S8f8ltfsn7X1df3OmJhsrKj1WG1gbLC6GMrqmIg2znnHRS/kG0JbBA50mD1UUcxIF6dsKxiwBqT0cE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PNzn9niG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88450C4CEEB;
	Fri, 15 Aug 2025 16:40:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755276000;
	bh=EeeFqZS4JJOHrZXRZU/ZngCmex+Ibm/qQWj1VUkvDbM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=PNzn9niGtpjSlMCPAdlOHPVYo2b1EIvGe6rpFljmPiZf2SatkqXwYRNdo5BSGbC1l
	 NVLTjA4xOSC+L306eWyoV7CmUUX/u2mfxri64XcK2S7PPXXaNWv3dBijfYo8oD9bUH
	 t+5e4NDcfLyYtX8wN8jXiBATS0JaLUpVQBUFpkMbfOD/r7Kymf+Zlk5X6Q4AEO/lTI
	 xVnUQWAIuYVd9luuBgvim8UlwMXcOpj7mL/gzM6MSfFt2hFTe+LjizqnzczgXBOQFg
	 G9kBhcwHa0XNZ8CZpfT6eGCFUGv3MpKZxiDJ6fD03L//l7kqQcOEPNl9Qmi4qxqzpU
	 4hPUSeaCeDBGQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70E5E39D0C3D;
	Fri, 15 Aug 2025 16:40:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH v3 1/2] f2fs: add lookup_mode mount option
From: patchwork-bot+f2fs@kernel.org
Message-Id: 
 <175527601124.1161945.12842294818231800884.git-patchwork-notify@kernel.org>
Date: Fri, 15 Aug 2025 16:40:11 +0000
References: <20250805065228.1473089-1-chullee@google.com>
In-Reply-To: <20250805065228.1473089-1-chullee@google.com>
To: Daniel Lee <chullee@google.com>
Cc: jaegeuk@kernel.org, chao@kernel.org, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net

Hello:

This series was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Mon,  4 Aug 2025 23:52:26 -0700 you wrote:
> For casefolded directories, f2fs may fall back to a linear search if
> a hash-based lookup fails. This can cause severe performance
> regressions.
> 
> While this behavior can be controlled by userspace tools (e.g. mkfs,
> fsck) by setting an on-disk flag, a kernel-level solution is needed
> to guarantee the lookup behavior regardless of the on-disk state.
> 
> [...]

Here is the summary with links:
  - [f2fs-dev,v3,1/2] f2fs: add lookup_mode mount option
    https://git.kernel.org/jaegeuk/f2fs/c/632f0b6c3e32
  - [f2fs-dev,v3,2/2] f2fs: add sysfs entry for effective lookup mode
    https://git.kernel.org/jaegeuk/f2fs/c/1bd119da0b93

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



