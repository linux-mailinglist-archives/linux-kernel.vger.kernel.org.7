Return-Path: <linux-kernel+bounces-896267-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id CCE25C4FFF6
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 23:50:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9BA214E586E
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 22:50:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 818832BD5BB;
	Tue, 11 Nov 2025 22:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nTqCUJEB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF84635CBD3
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 22:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762901440; cv=none; b=Vwz8GYkEY/OzDR4LkvEeeBXh6ROlJwpFaHu8C50of+QWbWhaPrUdbnPMOvWufUPApy2BNmpi9YFZHWO8c3xdP+v5o9xwE86ogrNIwvyo4Hi5k5D2OxVYXR70n7UX0fQbNySrJKcibxoW1vUALlxFLumycJXGXTbVvtlD2EiqykU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762901440; c=relaxed/simple;
	bh=1ov07mNSftJLyOcTGRzd2+/xjBpaoTdrC/6uDOIJ6C4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=PuSMVVWJV79qNPDiBkoSVY9p82wws7TMU+gt5IQwsDyLVo4AX4w21ZifFqSU4My/lMH4NwMHbSzOfX1gn5eOO8ZkGIiSmn3Gu9a9TtGKeC5XV0KCuleeGRRnyOYx5otFlJlgmeU7w2LLqZMmQ0QQuTXvAXY+QF85Lyno8nHM6cQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nTqCUJEB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F5FCC4CEF5;
	Tue, 11 Nov 2025 22:50:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762901439;
	bh=1ov07mNSftJLyOcTGRzd2+/xjBpaoTdrC/6uDOIJ6C4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=nTqCUJEBnB/kJM6DIxpCXcnLEzfIBFKBjE35fey9snTIp0XAxARzxjN6kmZXkz0wD
	 FhGiMpPd/McVoERSpNXymTEoLBMYZ+dQpIdZGldTSGMtP5Ix1AF2zYX7ySZ1SM8ZMd
	 y30iWH1SuQ8aK8uASueWJ8qPsT4PYyONdHXdiwJzPlM0QvHY7dDbwfIQlq5XvdCoUe
	 5obg/qkvgsqf4V8NGnyBQVWM1A9h2DYGgRcFr5T/8ZQs3mfz15ske7T7DqvjfHS50d
	 ykSQgjzed7lHoNVsxBLiAO6QWXGdgK5wVMyzIqbRgtpfW879RgvbiaWySpnleuIc3B
	 MmFYWhtuh3oWA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADDF3380DBCD;
	Tue, 11 Nov 2025 22:50:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH] f2fs: fix to access i_size w/ i_size_read()
From: patchwork-bot+f2fs@kernel.org
Message-Id: 
 <176290140950.3596344.12262707920968053977.git-patchwork-notify@kernel.org>
Date: Tue, 11 Nov 2025 22:50:09 +0000
References: <20251029063105.989253-1-chao@kernel.org>
In-Reply-To: <20251029063105.989253-1-chao@kernel.org>
To: Chao Yu <chao@kernel.org>
Cc: jaegeuk@kernel.org, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net

Hello:

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Wed, 29 Oct 2025 14:31:04 +0800 you wrote:
> It recommends to use i_size_{read,write}() to access and update i_size,
> otherwise, we may get wrong tearing value due to high 32-bits value
> and low 32-bits value of i_size field are not updated atomically in
> 32-bits archicture machine.
> 
> Signed-off-by: Chao Yu <chao@kernel.org>
> 
> [...]

Here is the summary with links:
  - [f2fs-dev] f2fs: fix to access i_size w/ i_size_read()
    https://git.kernel.org/jaegeuk/f2fs/c/1797093bfc96

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



