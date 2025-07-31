Return-Path: <linux-kernel+bounces-752512-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B116EB17675
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 21:07:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A000A587BCB
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 19:07:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 151A4256C7C;
	Thu, 31 Jul 2025 19:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FjAWukm4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 767B0255F5C
	for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 19:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753988837; cv=none; b=RW0KxgslZoDaD8pg1fBdmBGZVaPgt6f+q8W8nEfVNqYMr3xiBaxQ1Q76M74G7LyBlrRbDIvQBRNL2RgZLKqv7HzLStxQj9rGbEPpD1VVPcASK/w0XVOCIw3gO48E8Z8luZewIiQ/N0147wa0nuVwLMRYCHaUL7o1SFZDpZvV/Hw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753988837; c=relaxed/simple;
	bh=jhPthhsoR3Tl11HWhRsEy1wabZzhw3FoJMCwSMXpQQs=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=P6DQYo7pyKGCniWsqq22enbYjwovF7kL47vQKa5hxZ4mzY3qGelqnn7Ii5Xo+njdtCasbDBnVznUOWTVABbg3nyJ669TGaC7xb7+too3mNXi4PWKo/c4sAX7KSGS6xrZWqt9xTLnXk35AaCU3Dg+j3+3YXkMMsFSs6CB6NWFgCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FjAWukm4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EFDDC4CEF8;
	Thu, 31 Jul 2025 19:07:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753988837;
	bh=jhPthhsoR3Tl11HWhRsEy1wabZzhw3FoJMCwSMXpQQs=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=FjAWukm4cfzTJqWBXlQLim0vREKXjLX1KOtMSpwbVFpUKJ+CndMRFwDKOWYPq1/1t
	 o4bbU+Kw+HZg5Bxf1JDDANgZKyGMJ8Kfg8vIWVcS3pe4QF+FCJiQnKzRlN90VrcX4R
	 bYlHUc2uAgui4PsVTnA8zzvDUgioOWSKo6ADm5/IFvLTid3wqTRKlhwhBefiskeDD9
	 hz0mqRF8iZmXsQW8wJkQk1NlH/pP0hBq+pIlIOIraaGW5TgPD3v0NSMTRVqVZ3V2X7
	 Fg7fWoch6kNHitgRBJg3sKgdvw4xf1ueCdwzYIhd9ky37+MCQt6illeqHyQeXcr2HK
	 9g2mmgwQ0HJGQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33C4F383BF51;
	Thu, 31 Jul 2025 19:07:34 +0000 (UTC)
Subject: Re: [GIT PULL] MFD for v6.17
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250730150850.GB6782@google.com>
References: <20250730150850.GB6782@google.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20250730150850.GB6782@google.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git mfd-next-6.17
X-PR-Tracked-Commit-Id: 006aa8f57f55dd5bf68c4ada1e0d3f4e59027d71
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 24e5c3241ab643b133717c34d1f4c78349774cc1
Message-Id: <175398885279.3259326.14564379173530191554.pr-tracker-bot@kernel.org>
Date: Thu, 31 Jul 2025 19:07:32 +0000
To: Lee Jones <lee@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Wed, 30 Jul 2025 16:08:50 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git mfd-next-6.17

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/24e5c3241ab643b133717c34d1f4c78349774cc1

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

