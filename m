Return-Path: <linux-kernel+bounces-738304-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EBEFB0B6ED
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Jul 2025 18:32:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59CC13A7E2D
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Jul 2025 16:31:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12534221273;
	Sun, 20 Jul 2025 16:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KeIegjq8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7652722422E
	for <linux-kernel@vger.kernel.org>; Sun, 20 Jul 2025 16:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753029060; cv=none; b=T+CJCHF4R+ec/QJBP3S/LL1Eh0u4TPMrSm6PjKkJJemlj59hjWiAS+/PnzhezyZE7E0GES8qyfZltJbBWgwA1jUAAzj2YWZ/5s/JKlmDteqamrBvPa+VtMujmtu4BWYn/+Tb/x7BkaRsadBk2tlJLlV6f0xwd9i7rpoMkvaampw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753029060; c=relaxed/simple;
	bh=MkLO9gXLpmNlXcaEGgHvV/L6tbQ0dUe0Y5cHjfci5fE=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=VIdHeeFhkqCBxKP2onYvxQKIwr2+mzqGNlrB7wC+K9nlPacrLUmRX3bWfwY8rJbQYj6Ml1WnD++TXShGYwT9vF78oviY+XFC4dbaEE2mDo09iraTgIZ7olox2f3tOi5uM4jb4PayF62m9W59FE/xLfHGTk6IEtfoSgYYs5AKODw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KeIegjq8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A141C4CEF7;
	Sun, 20 Jul 2025 16:31:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753029060;
	bh=MkLO9gXLpmNlXcaEGgHvV/L6tbQ0dUe0Y5cHjfci5fE=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=KeIegjq8XliEKkEsqgwXrcvsC6LGqB6ta+70xwsaMjmxBL2Yp4f3jDM/3Dv4fMDKq
	 gOqaxt8s7xo1Bw6AvA3E8LoQETtvvCmrk7iQNziz5/dbWYY3f4LohcTQ44UiRjyilR
	 /PWv3sLS1puvLD9lfmtXThkLUSbU6sorb+qtWH+xHxbDMGbluRxyub5ASi+EZZp0Yl
	 6sDDCDbkjn7lnAv8xVxcPrUpS2+Sw9aEE3xu3+HqJxxFhFajnIQkecKJbkAneM4Acj
	 gX481UHIew+b1onLtaDHR+rfun5SjjuZ78JtPIFsW2hyFYZNqFlDu1mDQOp/d9OAFk
	 OnHrfMuEA+r2Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADC37383BF51;
	Sun, 20 Jul 2025 16:31:20 +0000 (UTC)
Subject: Re: [GIT PULL] Char/Misc/IIO driver changes for 6.16-rc7
From: pr-tracker-bot@kernel.org
In-Reply-To: <aHzJIwjrpLJmol5d@kroah.com>
References: <aHzJIwjrpLJmol5d@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <aHzJIwjrpLJmol5d@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git tags/char-misc-6.16-rc7
X-PR-Tracked-Commit-Id: 2d7521aa26ec2dc8b877bb2d1f2611a2df49a3cf
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ecf11d31bf5ccde62c91abe94d4edb867b64958f
Message-Id: <175302907929.3241589.12133546641139074686.pr-tracker-bot@kernel.org>
Date: Sun, 20 Jul 2025 16:31:19 +0000
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sun, 20 Jul 2025 12:46:59 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git tags/char-misc-6.16-rc7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ecf11d31bf5ccde62c91abe94d4edb867b64958f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

