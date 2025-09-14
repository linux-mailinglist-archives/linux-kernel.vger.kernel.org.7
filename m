Return-Path: <linux-kernel+bounces-815767-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 76DF3B56AF7
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Sep 2025 20:01:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D9BE07A7D9F
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Sep 2025 17:59:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 912D9277C8D;
	Sun, 14 Sep 2025 18:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fOmV0LwM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAD662AD11;
	Sun, 14 Sep 2025 18:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757872878; cv=none; b=j4H1UbN+cD+xFrWNpSf85MkzypkNRGEBM4BTayIMLFARK20MBoc8XkFFtK1FzJ7hF5D2L7rByKg5ofpsWcLac2IEqy9GPTwhGwb0MZU079DpNBC6GHVE8CEthXDTuymxdhEiA7MKkzOn91oSFnEoDt0y/0mT1GylhTv4WXCGwm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757872878; c=relaxed/simple;
	bh=kJH+F84Ru1SGVet3qFX0qlo2JR5sD1xkYAKuMjovgCk=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=d+46rtVusQWXjEaE/OyNyfQyP7ja0kW3SQWG69M9atdlj4E41TbRn8eLbxD6X3GYfsedltcSb42OtwbN0vRdM4GlpNpqLMZjcNreW9Aiz0nJK8zIOak2gNZOeYASAMltd7uhzfVOjeSn0QQFy2EQ9DTshVF4tyvwLKxYSMB7nic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fOmV0LwM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77F3FC4CEF0;
	Sun, 14 Sep 2025 18:01:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757872877;
	bh=kJH+F84Ru1SGVet3qFX0qlo2JR5sD1xkYAKuMjovgCk=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=fOmV0LwM5zGQWOOICHQ/DpYdBthfPSNtOji7BqygnwsaA7WwiHjupTBM7yz93YF3h
	 f1A9MwCHeqf7HuBV27JrXMmNiFja0s4MVrWa8mkqTVR3DVAxue/rmrHCeODKP398F/
	 +4dGo5IE4NqKoQiRJccaVyZ02L13wTS/JsY8ihqjQS1sKZMt8phSrFUGqpJ6CEVmHV
	 sSeuyY5Sj5UwprKEM042U1QSLBDgXQCcjJudqWrXNCVOnzd0QJ2WsOQhsMT7/Btr1k
	 cM6CkELQx4cfTSgtzO4el9VeBEZrXJdtVuWOJ9R9DmjnQB8vBtfcC+r+kqHwm+3cg0
	 QLarY4+mq7CfA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70E6D39B167D;
	Sun, 14 Sep 2025 18:01:20 +0000 (UTC)
Subject: Re: [GIT PULL] USB driver fixes for 6.17-rc6
From: pr-tracker-bot@kernel.org
In-Reply-To: <aMatBsRj8kbv4VoO@kroah.com>
References: <aMatBsRj8kbv4VoO@kroah.com>
X-PR-Tracked-List-Id: <linux-usb.vger.kernel.org>
X-PR-Tracked-Message-Id: <aMatBsRj8kbv4VoO@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-6.17-rc6
X-PR-Tracked-Commit-Id: 9dfec4a51df9cf0dcc23cb4ac6fc314bf9e999d0
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d6b42787f30d86ef3aa5313c8a43c0b228d1f11b
Message-Id: <175787287895.3518752.6982863115921848006.pr-tracker-bot@kernel.org>
Date: Sun, 14 Sep 2025 18:01:18 +0000
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sun, 14 Sep 2025 13:54:46 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-6.17-rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d6b42787f30d86ef3aa5313c8a43c0b228d1f11b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

