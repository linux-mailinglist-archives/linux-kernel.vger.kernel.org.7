Return-Path: <linux-kernel+bounces-844703-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C1451BC28C2
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 21:46:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B03014F178C
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 19:46:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38A3F2264CE;
	Tue,  7 Oct 2025 19:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N5bwagZM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CACF212FAA;
	Tue,  7 Oct 2025 19:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759866382; cv=none; b=ITkM165cJFom8dDJbsCrmA7qv+wdLNx7bGuSoykvW8a1jf0RCR/w0faeVjOAFEbWH5Jp7r2r1CTZekHWipscM+oh1OoIZ2h1d7kIVy/kjY+uz/jC+k/P0Gj7oL90BevsEs/4by8q2dyQm7rKHUwNdJDRt/dgTvVpKAirxV0juwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759866382; c=relaxed/simple;
	bh=LREUjd3X+PNvYDuIPzv39vR68u2jVbwTpy2rEHw8src=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=Mr9DH7lHpem8h/JzSPblTZZ8ngGE+57Mf+RxCpyE0VasbnNWww/9+sedlKCLPgMA6xKqjvuk9Tvp0tjfzrKQEv8iFOhAwg29deWjjPV1vlpCDc3Y8vzqFxuAw8k9cUFDmIRep7EV9NmONf0ye30LTjngxgGtAV50DXTr7T4838k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N5bwagZM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BF5BC4CEF1;
	Tue,  7 Oct 2025 19:46:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759866382;
	bh=LREUjd3X+PNvYDuIPzv39vR68u2jVbwTpy2rEHw8src=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=N5bwagZM28mkMm5f+ug/zuSzOQmX3Dp/DtawpgVal8MWyXY7pLXLR+1AtagzCP7GJ
	 eZ9XojQCEwkSn9JkNDn5IXc7pCoNqFK2zf3fJ9SFyL4dgmkuC0tcj8kJqVho1X9HW5
	 JZvfiy9srr5ngh7NvoYsj+prck/1WVT1iNEVFE/A/Ns6kK+cnkqzNv8z8gKeQCoybE
	 PcrgQ1t6a+yE3yG9aGApgO+TxWRJDIzdO5zis9dyHjboyh9d5bc7xKwEaziMMsQFu1
	 ma9+b8icgkcrnEAdG7qIpCI3evK9WdjLPs0MmC/PKYN5chLPW/+W19Ta3Md8eUfdpo
	 GiQanuyq3jDSQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE28539FEB73;
	Tue,  7 Oct 2025 19:46:12 +0000 (UTC)
Subject: Re: [GIT PULL] TTY / Serial driver fix for 6.18-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <aOUQ1CdKRQ2mSN1f@kroah.com>
References: <aOUQ1CdKRQ2mSN1f@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <aOUQ1CdKRQ2mSN1f@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tags/tty-6.18-rc1
X-PR-Tracked-Commit-Id: a699213d4e6ef4286348c6439837990f121e0c03
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 3d15d6c1b3dd9eda173d474db82daf093afa4562
Message-Id: <175986637123.2756271.13633569280355747402.pr-tracker-bot@kernel.org>
Date: Tue, 07 Oct 2025 19:46:11 +0000
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Jiri Slaby <jslaby@suse.cz>, Stephen Rothwell <sfr@canb.auug.org.au>, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Tue, 7 Oct 2025 15:08:36 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tags/tty-6.18-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/3d15d6c1b3dd9eda173d474db82daf093afa4562

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

