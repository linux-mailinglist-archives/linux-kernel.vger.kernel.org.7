Return-Path: <linux-kernel+bounces-837021-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F412BAB1A7
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 04:55:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8BAA119252DE
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 02:55:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 206BF22FDEC;
	Tue, 30 Sep 2025 02:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lVAPqqPw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CA0C22A1D5
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 02:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759200882; cv=none; b=kgOK/a2CNwFujlUQMwMAVqlun+NVRg2kN5+sm7lzFKXP23Pl9xW8BlTCaIRngfc+48i2LXICoLOGrdeFoRawCt4sOTQX1GdeNq1e/JSHBO6yRWattqqjsXN2YmcUgRA5tO0MQG5moxh/WdcrenuAnbzr1NAdxDODD3kRIlHOsI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759200882; c=relaxed/simple;
	bh=dgkK4EJcZHiuCBGTJ9a5wfkKCFJjD76Sr6N8F/kXGV4=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=YzBaQti/q+8MR0gnWSx8f+TQhfc5uUryzN2z7gZggbGNPmhWpTPV63CxOAlCmbGIIUDA6ez3Axhu7B98Jx3zeaIyNQqoNKJHgBtJq6DmczRboxK6C3QKHWpqQ4Lv8LFkgdH71bupmiCjDPIikWHVaep+CIAs6B+3er8wgfNgqLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lVAPqqPw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 508CAC4CEF4;
	Tue, 30 Sep 2025 02:54:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759200882;
	bh=dgkK4EJcZHiuCBGTJ9a5wfkKCFJjD76Sr6N8F/kXGV4=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=lVAPqqPw6QMXiZPs9mOtotS3f+LY3UsmXdQUXm8OqSmREDrXEFTFywSFKTqVxd32k
	 L2p/TWFob4uO7lqsJeftCAGZ8pWjZ0ytMunmyKZvKpJCHShOzWpL2ZoFTmlBiXPIgp
	 oCoABkK1TClx6ZlzWajU9fR+F32zE5Y7jHcAmRr/ky/bNObTxyLRrTtqvofAHaS7gi
	 29V2CfJBbhE+0iN7Mnv6MtNsC7eWZVB6sXiIuHbORhut4SbQ/ZOV4dkKoJ4H8Ke9QJ
	 dt5tMX2qj91TlHqPM4efegjZN6aiGjUIxNdLbEzToiB5NNuvRmq7w1OQrEBU1d7RrZ
	 yeq4wxXUpV6qw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAE4D39D0C1A;
	Tue, 30 Sep 2025 02:54:36 +0000 (UTC)
Subject: Re: [GIT PULL] Please pull powerpc/linux.git powerpc-6.18-1 tag
From: pr-tracker-bot@kernel.org
In-Reply-To: <ac4dc89b-6961-4900-a7e8-c522264076f0@linux.ibm.com>
References: <ac4dc89b-6961-4900-a7e8-c522264076f0@linux.ibm.com>
X-PR-Tracked-List-Id: <linuxppc-dev.lists.ozlabs.org>
X-PR-Tracked-Message-Id: <ac4dc89b-6961-4900-a7e8-c522264076f0@linux.ibm.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-6.18-1
X-PR-Tracked-Commit-Id: ef104054a312608deab266f95945057fa73eeaad
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 417552999d0b6681ac30e117ae890828ca7e46b3
Message-Id: <175920087537.1805104.12802141093962924925.pr-tracker-bot@kernel.org>
Date: Tue, 30 Sep 2025 02:54:35 +0000
To: Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, aboorvad@linux.ibm.com, adityab1@linux.ibm.com, atrajeev@linux.ibm.com, Christophe Leroy <christophe.leroy@csgroup.eu>, gautam@linux.ibm.com, haren@linux.ibm.com, hbathini@linux.ibm.com, joe.lawrence@redhat.com, kjain@linux.ibm.com, kstewart@efficios.com, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, masahiroy@kernel.org, mhiramat@kernel.org, Michael Ellerman <mpe@ellerman.id.au>, namcao@linutronix.de, naveen@kernel.org, npiggin@gmail.com, nysal@linux.ibm.com, rubenru09@aol.com, segher@kernel.crashing.org, skb99@linux.ibm.com, thorsten.blum@linux.dev, thuth@redhat.com
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 29 Sep 2025 22:23:42 +0530:

> https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-6.18-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/417552999d0b6681ac30e117ae890828ca7e46b3

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

