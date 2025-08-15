Return-Path: <linux-kernel+bounces-771197-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 28D4DB2840D
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 18:44:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A34C1CC3A51
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 16:41:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 585E13101B9;
	Fri, 15 Aug 2025 16:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Usb42rLs"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6CB53101AA
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 16:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755276008; cv=none; b=mOkQvzRnh5WnLAR1C/JRpxxfhEi6TlXPHmHar1LPCAi95lznhn/od2l7MkjPeGxwh1nQd91DBIXrOkqUz//4l61pAoouIyDDqCm1BP4UfjXmzHFi+rKtyCRmw2oEhRhcxIa3hTIKj2cQ+Af/KldQs5nnxkub/f6FDs0UKL1TV7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755276008; c=relaxed/simple;
	bh=RhBMzittFhmG7ktz9MBDQLEthMJkvOD/tT2dKiafvtM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=GgMISCOrj5f25vhK0aA2CFofPSWupVzLPesWoEBkPRVL013RaU7j5/HzsH/C760pFOWHZCpLR0TUr2sLreiLEuwBy/EgMcSUQQcom39+8Js8EFxTDQ+12OIm0zUzoaoksXeGX/MgjjpJUV69Gmuq+cDW0vsE6UMWy+gews+aWu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Usb42rLs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C532C4CEEB;
	Fri, 15 Aug 2025 16:40:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755276008;
	bh=RhBMzittFhmG7ktz9MBDQLEthMJkvOD/tT2dKiafvtM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Usb42rLsJ9pyDlv1rhmuuQXoNkNRRimTnGuy1Qc0xN7qFH/aXuUIdwYrN+24r5hKB
	 Acdqv0BF8o7X1vRWhcJx49vWFL3sDaRK/2tojpx+Zry1ZhibDwgTQy6pTGRUt8cn2C
	 YIYKyPNsmZfAm/BK8O///4btqVDze9uY6czWuVEekMaPbVxTnn+Bbo0VVLYZP2JeX7
	 EHvliz/osyIo/mc8NMj92XWhmNapZoEdoee9USx0mAAZyQ7PnH0dOjuqF1gjQJX/AL
	 fFNaFi1uAgkhZY04Kd2HpDPbYwN4bqOTtu2qE9jdlCkx7cRcGY76ASl9HtxGlV7jPc
	 PfYobG2faibrA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADC8839D0C3D;
	Fri, 15 Aug 2025 16:40:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH v6] f2fs: add reserved nodes for privileged
 users
From: patchwork-bot+f2fs@kernel.org
Message-Id: 
 <175527601949.1161945.7999749862771332410.git-patchwork-notify@kernel.org>
Date: Fri, 15 Aug 2025 16:40:19 +0000
References: <20250807133501.551848-1-guochunhai@vivo.com>
In-Reply-To: <20250807133501.551848-1-guochunhai@vivo.com>
To: Chunhai Guo <guochunhai@vivo.com>
Cc: chao@kernel.org, jaegeuk@kernel.org, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net

Hello:

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Thu,  7 Aug 2025 21:35:01 +0800 you wrote:
> This patch allows privileged users to reserve nodes via the
> 'reserve_node' mount option, which is similar to the existing
> 'reserve_root' option.
> 
> "-o reserve_node=<N>" means <N> nodes are reserved for privileged
> users only.
> 
> [...]

Here is the summary with links:
  - [f2fs-dev,v6] f2fs: add reserved nodes for privileged users
    https://git.kernel.org/jaegeuk/f2fs/c/a3b0697610ba

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



