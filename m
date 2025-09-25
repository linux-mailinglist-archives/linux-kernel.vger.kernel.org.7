Return-Path: <linux-kernel+bounces-831684-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D12BDB9D504
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 05:30:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF39B1B248F9
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 03:30:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 287A62264D3;
	Thu, 25 Sep 2025 03:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BG88CM4d"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80346DF71
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 03:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758771010; cv=none; b=u8oZfpxRXaxjV6i4E3mNCLjhsPDiNrJx2JpsCqOFdPnJYmWXHnJ46nvIgBOHC5h1p/1YfrbCXQXOJvGOO8iT4xYT3nEYYPUDnEFLuCZCEUjupcdHEL3ANwoAxGPLzWDeA79ILqnkJcXqp1ENasqWC0T9kIEljeJZoYpQpF7jtxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758771010; c=relaxed/simple;
	bh=Z1rEEP2xjUQWNQmCsKtyDGJqr+lSHSgBRvo63Lk1wR0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=RxYQyPAUZ25WJ1OjQ9ECfS4O5k27mI3X1EeJwOkjWchYwlqbFNOcZfnDDgqhj1FhUOg0y747wzdHorYFSJqxlb1zj14+A2e701GE8lzP8fBhZPe737fBtGDR3DCDgGwIqM9Pw/XRiZlQiSDACO0mLGVTmubZaqFma+5/GCw3Lb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BG88CM4d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09D3FC4CEF0;
	Thu, 25 Sep 2025 03:30:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758771010;
	bh=Z1rEEP2xjUQWNQmCsKtyDGJqr+lSHSgBRvo63Lk1wR0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=BG88CM4dYQkU3URFWRSlOCJVo0faiCWaWqOh/9KYrTInYMOcf5Jw6Od5Ybjvd00c4
	 xERQroOwStGGlwoSIXkG0A3YutwRWQWXxBL9Dhlaqre2WT+TM7S9cetFFNhm64B5AP
	 clWLyv1AWS0DqQg6IIxDJxHVdNIjQxVaENlcdLxuLxqKqHRG2lJYjZHeMJ1bEkg1j7
	 AOwOpJ4QvxfHnpmjUSu0lo990046Y2ESbnrP7XQoIkA86/QDG8a61nYAXak1DA6api
	 ZnsWCcgQinKpetUucm68kqxAjysKtbO/UqCkzwFy6t7MYoDJPpzQXoHN7WS6i4kb2l
	 is+G6YxMjXYMA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70B6539D0C20;
	Thu, 25 Sep 2025 03:30:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] MAINTAINERS: Update Paul Walmsley's E-mail address
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <175877100625.2803569.11537236172793560743.git-patchwork-notify@kernel.org>
Date: Thu, 25 Sep 2025 03:30:06 +0000
References: <4a3d959d-56ea-36d8-029d-141e7820279d@kernel.org>
In-Reply-To: <4a3d959d-56ea-36d8-029d-141e7820279d@kernel.org>
To: Paul Walmsley <pjw@kernel.org>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
 paul.walmsley@sifive.com

Hello:

This patch was applied to riscv/linux.git (fixes)
by Paul Walmsley <pjw@kernel.org>:

On Mon, 15 Sep 2025 00:30:37 -0600 (MDT) you wrote:
> My experiment with using corporate Gmail for Linux kernel list
> interaction has come to an end.  For my MAINTAINERS entries that
> use that E-mail address, let's switch those to use the k.org E-mail
> forwarding.
> 
> Signed-off-by: Paul Walmsley <paul.walmsley@sifive.com>
> Signed-off-by: Paul Walmsley <pjw@kernel.org>
> 
> [...]

Here is the summary with links:
  - MAINTAINERS: Update Paul Walmsley's E-mail address
    https://git.kernel.org/riscv/c/e24108012ce9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



