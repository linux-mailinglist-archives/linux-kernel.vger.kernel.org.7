Return-Path: <linux-kernel+bounces-797290-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B4A6B40E7A
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 22:20:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 888EF3ADF1C
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 20:20:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CC5C352FCA;
	Tue,  2 Sep 2025 20:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bll0bQun"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C289A34AB10;
	Tue,  2 Sep 2025 20:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756844404; cv=none; b=Spywc3vuy6OLPhlnINJFfyYOzSUHAidOdvHsp404lCFdBMpDVMeXwDbyUBIUE8+mMK3drjMDSp+aqAK3KzuW/gl1udhwWT3UW7Y6MUySLGLhiYmTO/dlF3k6fJdsnZaGuU/W0/Yr/zgzLqip8KceZbt7fXl6dS9ImOgLpqNYg1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756844404; c=relaxed/simple;
	bh=/2xcc73R0U3F3FIIaEW1j/nAoP7L3W6KZtpLsQtN7tE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=fHbUxVp1rycLMlqxSJougfdVL6HnwM+BbokpcYMBlSmM2yTEy3dMQuA1XgQW/y6p9Ot2w7Zta7ocy/t9D8tH6SiSudKaq99RI6T/QqE3jQPBwLIG4fLlMntnlbQy+2K1gafLwRuD2egTbOWXgSS7QGGiFOLTfV+4995eeXLdX0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bll0bQun; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F533C4CEED;
	Tue,  2 Sep 2025 20:20:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756844404;
	bh=/2xcc73R0U3F3FIIaEW1j/nAoP7L3W6KZtpLsQtN7tE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=bll0bQunktnTELmr+IHgr+TumYgTNAD3AgcaMY8TfTlX87L5Tcq5vQ3rByUv4asc9
	 KTiL8tglu58p5LWHJdV72m29ti6rd6sgqTlGHTqdKE2/e4guQb93KtGtCZodPZ+Gtp
	 Ab+cqt24GGMCSU5sjkvkTH/0DadTltSSiE0JvQXR+UJ/AgqZDC6fvkduBk4I0OSpND
	 iToKZPNI1TkBasZotg/KmiaXR8JjLyFZC6i2MhjujLUOGAOHm4pxcg5Fm+vzlI0FD0
	 k1Wwwm/+pqN1KuzDEFdDTeuSV/8ByrlAKqsjuHrwjXt0ZZEu9ga3yr4GnWXpakflr1
	 H27ZcrDSmfYVg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EBAB7383BF64;
	Tue,  2 Sep 2025 20:20:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH 0/6] f2fs: documentation formatting cleanup and
 improvements
From: patchwork-bot+f2fs@kernel.org
Message-Id: 
 <175684440975.425353.8499498509115681029.git-patchwork-notify@kernel.org>
Date: Tue, 02 Sep 2025 20:20:09 +0000
References: <20250820043432.22509-1-bagasdotme@gmail.com>
In-Reply-To: <20250820043432.22509-1-bagasdotme@gmail.com>
To: Bagas Sanjaya <bagasdotme@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, daehojeong@google.com,
 corbet@lwn.net, frank.li@vivo.com, jaegeuk@kernel.org, yuanye.ma20@gmail.com

Hello:

This series was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Wed, 20 Aug 2025 11:34:26 +0700 you wrote:
> Hi,
> 
> Here are documentation formatting cleanup for f2fs. This also includes
> docs retitle at the end of series ([6/6]) as a bonus.
> 
> This series is based on docs-next tree.
> 
> [...]

Here is the summary with links:
  - [f2fs-dev,1/6] Documentation: f2fs: Separate errors mode subtable
    https://git.kernel.org/jaegeuk/f2fs/c/4bc6bf7b8830
  - [f2fs-dev,2/6] Documentation: f2fs: Format compression level subtable
    https://git.kernel.org/jaegeuk/f2fs/c/f23044152af2
  - [f2fs-dev,3/6] Documentation: f2fs: Span write hint table section rows
    https://git.kernel.org/jaegeuk/f2fs/c/f9c97e496293
  - [f2fs-dev,4/6] Documentation: f2fs: Wrap snippets in literal code blocks
    https://git.kernel.org/jaegeuk/f2fs/c/f4f36fffd872
  - [f2fs-dev,5/6] Documentation: f2fs: Indent compression_mode option list
    https://git.kernel.org/jaegeuk/f2fs/c/e78223268878
  - [f2fs-dev,6/6] Documentation: f2fs: Reword title
    https://git.kernel.org/jaegeuk/f2fs/c/62242ac51061

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



