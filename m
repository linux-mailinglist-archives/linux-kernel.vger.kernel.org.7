Return-Path: <linux-kernel+bounces-836863-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BD90BAABFF
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 01:25:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 606337A6540
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 23:23:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C672A274FFE;
	Mon, 29 Sep 2025 23:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nKFQtUEl"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D26C26AAAB;
	Mon, 29 Sep 2025 23:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759188177; cv=none; b=sdOlTxmi5d1cVt4Unb5YzqSgFuC4iIn7lxeRqEB3tWg/gJ0rJS//aDMFBEJ8BOzc23crxw5LUl2XVcFyypv1NT1YhWq49kepUICW3xn+B0TXdpHHOHNBdvam9D5av3pVnxGckMT1cUmLKQTCId8atOjH6oTXovZHmaymH40zjlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759188177; c=relaxed/simple;
	bh=5aAC8Qe70kLnOUUX5PFBuCaX7/uSzwYtWRYq4kzusEc=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=caQTX7rposSRknNz6MuE2y0vpNr0cTdFV8xc0/Xt4h+USfz9t/lzQN3RDFK3YiTY/WGH/h2vWvyUwUnKdMHu7BBg9vYkAl1UDhPrSuef1/mzt5BQanVIgb5bRA0I1aAmNiUDNXk//OCUX9gSVzY47iTotUvpg94Obbya7wG3ldg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nKFQtUEl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06B55C4CEF4;
	Mon, 29 Sep 2025 23:22:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759188177;
	bh=5aAC8Qe70kLnOUUX5PFBuCaX7/uSzwYtWRYq4kzusEc=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=nKFQtUElE+dsN/rk0j7uoCy6YwSlwD0jr+fi5yIWw1AdhHxp+xf6Y6b4SFf4bSyjG
	 eOB2r0NdXoWR7OEPxJZ1iG3g67iPEYAb/QlgkOhQuc5peEbsAaNlBN6XTZJsGCG6Xq
	 kiQaGiaRK9+/LNtedAhWhHC27+BMqQGnWYkhb335Y35J2y+MtkYrFrDHyIXWmSH8yn
	 La4IVy4jKYt40AmJLDYrhb35bA7iTlY2hJFdZ6FV3+s3muw/091CSQ6cr0p66aH2JP
	 wSkHl2wg5nuYWwk5IlbdXk+EjIcOUOODggtd8kG5tLoLUZaW1MEXS97ic7FjjGI392
	 E3jYDpiQGR0Wg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADE5839D0C1A;
	Mon, 29 Sep 2025 23:22:51 +0000 (UTC)
Subject: Re: [GIT PULL] smb3 client and server restructuring of smbdirect handling
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAH2r5muAWS2AtzLOL_zWeWP+Xp03puRKMjs58vrT88FJXU_j+Q@mail.gmail.com>
References: <CAH2r5muAWS2AtzLOL_zWeWP+Xp03puRKMjs58vrT88FJXU_j+Q@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAH2r5muAWS2AtzLOL_zWeWP+Xp03puRKMjs58vrT88FJXU_j+Q@mail.gmail.com>
X-PR-Tracked-Remote: git://git.samba.org/ksmbd.git tags/v6.18-rc-part1-smb3-common
X-PR-Tracked-Commit-Id: 1b53426334c3c942db47e0959a2527a4f815af50
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a9401710a5f5681abd2a6f21f9e76bc9f2e81891
Message-Id: <175918817039.1748288.242631121619274613.pr-tracker-bot@kernel.org>
Date: Mon, 29 Sep 2025 23:22:50 +0000
To: Steve French <smfrench@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, "Stefan (metze) Metzmacher" <metze@samba.org>, Namjae Jeon <linkinjeon@kernel.org>, Tom Talpey <tom@talpey.com>, CIFS <linux-cifs@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Meetakshi Setiya <meetakshisetiyaoss@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 29 Sep 2025 09:03:05 -0500:

> git://git.samba.org/ksmbd.git tags/v6.18-rc-part1-smb3-common

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a9401710a5f5681abd2a6f21f9e76bc9f2e81891

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

