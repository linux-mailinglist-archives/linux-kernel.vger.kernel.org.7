Return-Path: <linux-kernel+bounces-859337-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 490B9BED532
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Oct 2025 19:26:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D22D419C0CCD
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Oct 2025 17:27:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A16F257825;
	Sat, 18 Oct 2025 17:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CsnT/x4z"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F31423D7DC;
	Sat, 18 Oct 2025 17:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760808408; cv=none; b=VqpUBZypIziTipdz4Bh+wvN7W2u4IS+DOv3pZMiK55O9czdhiwYDvONIQlkvrUSKI5sci1F4Ma9TdQtzLsxGkDiQL07hkwfTyTzSkC5wo9OsK442OuDlJv7Rok4REdIthdSqQGTQMXKdR8IWBq/lPt/Ci8MG4jQ14fjk40i4ngQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760808408; c=relaxed/simple;
	bh=hiwp+X/wqiBhX8SAHvFrwpKp8IZJw2DkiY3HeFPEIY0=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=l1L+qFuf64+/juFZbGuzDQrnw0/5TNJgAuOJ97yZxLb+xKnVKb5lqbYO5vwyaUFmTbGqYU8Ns4AFTwDpmC7fxn1w5iMHcoP6/5P4gM4Q1wmWgtcYrTafFC/4Yp4UxUKTTDz8yw/KHouG437+ZalJn7hnbWkeKxA6MpEkJC+E26A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CsnT/x4z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51951C4CEF8;
	Sat, 18 Oct 2025 17:26:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760808408;
	bh=hiwp+X/wqiBhX8SAHvFrwpKp8IZJw2DkiY3HeFPEIY0=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=CsnT/x4z/DO6JxqZoyNn85YSi9dIp2JTUgDeu6HxLQU06Ok273TmKCid5o7yos/6B
	 It2qLutxGY2MDVla1phNKX/vd9EZmDQMg0gp5EIg1lRHd0fHoPwG3PQ6h/2n74Oyoc
	 HC43MO4SvwOwqw0tfDn4F3PI6jpkf2Usy0lvcQGwmJ+mca+vrM+RxVMOGfhuf+3duR
	 S0wTXx99b455sI+7+ogn8Xqnn4GUfOjwqRTzIhmz0ec40qVye7A7E/c/68d43aQdqX
	 VR9iEhn+RHxs3GjzqCEiBhSPsOKEeiDpLDf6fvxHesq372n1CdIOfdOKbTvknk6PYS
	 IV9/rRbdR77Gg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 712EB39EFBB7;
	Sat, 18 Oct 2025 17:26:32 +0000 (UTC)
Subject: Re: [GIT PULL] smb3 client fixes
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAH2r5ms-8MBEd9ssS8vtkneFt=wKW-5MDWr-4pMf0mSZS0JH5A@mail.gmail.com>
References: <CAH2r5ms-8MBEd9ssS8vtkneFt=wKW-5MDWr-4pMf0mSZS0JH5A@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-cifs.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAH2r5ms-8MBEd9ssS8vtkneFt=wKW-5MDWr-4pMf0mSZS0JH5A@mail.gmail.com>
X-PR-Tracked-Remote: git://git.samba.org/sfrench/cifs-2.6.git tags/6.18-rc1-smb-client-fixes
X-PR-Tracked-Commit-Id: 3c15a6df61bab034b087f00181408b1537a535bb
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4ccb3a800028759b2ba39857cb180589575d7445
Message-Id: <176080839113.3050468.2993069482826703927.pr-tracker-bot@kernel.org>
Date: Sat, 18 Oct 2025 17:26:31 +0000
To: Steve French <smfrench@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, CIFS <linux-cifs@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 17 Oct 2025 11:24:32 -0500:

> git://git.samba.org/sfrench/cifs-2.6.git tags/6.18-rc1-smb-client-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4ccb3a800028759b2ba39857cb180589575d7445

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

