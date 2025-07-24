Return-Path: <linux-kernel+bounces-744910-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C9CEB11262
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 22:30:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 69BE31CC43A5
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 20:30:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 607B82E7636;
	Thu, 24 Jul 2025 20:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rb6tVfht"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0AFE2EACE9
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 20:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753388995; cv=none; b=KAVBJDxiQYSamlJO9A+uOO6Jcf4H9BMGrjT9VmvdIzbrN/w/E4HYXY3uFZqG3X+QKaxFtCMo1BPI/yM2Fkt9OpxczFvlBA3Ahhtz4UdqDCp4vl6rXCfH36e2nL4ai8YUsaNOqn71qxdXRQ1QCpjgNbTqXVn7hCST070GA5duamY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753388995; c=relaxed/simple;
	bh=VZmDCd3D1PztjGRSoro8vEYxaEMq+OsxAiIzCVbhvv4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=opx3hs/YEN3suMqe+g3aQkxfLbD1tnqCqFcnyRF2A0nUwzWhlsSxInlAZdyTKGFV7n46iKl6ic7d+cv2LseTQqf0qeRStc58i7jm4i6pQQ/fyUkhkSKy0pdIOGe3V3F+3hI2rxvouZJM1FiiyAxZQJdftFMv3jbfc5ibVOug1t4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rb6tVfht; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BDF0C4CEF6;
	Thu, 24 Jul 2025 20:29:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753388995;
	bh=VZmDCd3D1PztjGRSoro8vEYxaEMq+OsxAiIzCVbhvv4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=rb6tVfhtxtUM217biiRFFvUH61OmzuKT+7AUKKwK1U/6tXK1Lxny2dThPlh1rzQaY
	 3o34yrXq4KSl76dokN244FSawvlQmyGPYm7laclOpNPj0mlr4fKhH6NBTgU0PabFL9
	 IgGNg9tMOeqQTGHzREYeo/IYNVT4Wb+S1eHk3HyLd0F/GINWKwFzK8ewNlR0TYg2QC
	 fSodeNc4j+nPyI8zzCAYSh31EJpwgMgyZ06xM2JaehDkkdQbymv/9cNhohz9k5wqT+
	 axYvd9waxytq9JrZhoiDWw3FDXl4Io/RUe3O5BLgb0k8q5Z8fwlEvInLpPxTuFYQ4t
	 EbAAhmore+wXQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70D3E383BF4E;
	Thu, 24 Jul 2025 20:30:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH] f2fs: ignore valid ratio when free section
 count
 is low
From: patchwork-bot+f2fs@kernel.org
Message-Id: 
 <175338901299.2519964.7208919270936337472.git-patchwork-notify@kernel.org>
Date: Thu, 24 Jul 2025 20:30:12 +0000
References: <20250718220431.2290301-1-daeho43@gmail.com>
In-Reply-To: <20250718220431.2290301-1-daeho43@gmail.com>
To: Daeho Jeong <daeho43@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 kernel-team@android.com, daehojeong@google.com

Hello:

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Fri, 18 Jul 2025 15:04:31 -0700 you wrote:
> From: Daeho Jeong <daehojeong@google.com>
> 
> Otherwise F2FS will not do GC in background in low free section.
> 
> Signed-off-by: Daeho Jeong <daehojeong@google.com>
> ---
>  fs/f2fs/gc.c | 18 ++++++++++++------
>  1 file changed, 12 insertions(+), 6 deletions(-)

Here is the summary with links:
  - [f2fs-dev] f2fs: ignore valid ratio when free section count is low
    https://git.kernel.org/jaegeuk/f2fs/c/e6d5e789c3b2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



