Return-Path: <linux-kernel+bounces-752510-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E13DB17672
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 21:07:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4CF6E6279C2
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 19:07:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEE5124EA8D;
	Thu, 31 Jul 2025 19:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vMUleE5F"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D784DDC1
	for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 19:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753988833; cv=none; b=BiaZi1phJSdT+c6sKtsPuAGniUOT4cXXAqHPzkvPQnvq5Uogz6Vm76ypl1lt0ZRhm3zXzjYX1NYAV3QaOPZPQT/0a8b3+kMmRgb8YqiaAjGpCUARBt+WxHi7ruC4bdVBFxp8G4dQQvnkjAb2gSDKE0wWxCDvWktC655WC9kmVu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753988833; c=relaxed/simple;
	bh=NMjF++xyXNBrLt0fymHN0eyjvSoYOnvzwOfiTRryfEk=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=pR9qfqa4dPbDRT/gn+Cefb2wueCNI7nmQxI3Y9Kt16L9Oc2Ig6bmfEysK2ldr6si10PgqVWMU3zhDuXlQef482IPFvPx+9dsZ+MZtfsxKnQGanHxBvNjIt1FK4LalTlENj1N83PeQQ9pyPt1lBnh2mb99RQLGUy8lUj0HuvkjtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vMUleE5F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E1BCC4CEEF;
	Thu, 31 Jul 2025 19:07:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753988833;
	bh=NMjF++xyXNBrLt0fymHN0eyjvSoYOnvzwOfiTRryfEk=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=vMUleE5FWSUfm5M7dEnxjqWGaaz57MdohBXl5/CjW2rJVWjjSF/iEHGkoSxkWTPr+
	 vwZYWo96uy5Y3dG9EJY2av0U84sTSRTpcENbCDdzioAlgTrz9ALxD1zNL/owdEhlLc
	 334F5l8Yp3djy+7+9uQdpLj0yH1mqBcYgMf6KmFvJK5oMD6hR0l+dMgfPLDQC5RhkC
	 9GcKyDY/c7RdVEEIJ41Frj6VRC1rsDV5QykImfGzQafAPG27koW7EiHHBv8LgudTao
	 zkgOvYC70leDBSCpD6obmLaxEDjzmHM0wgfFBSFkcEGbHdh+SEc68Q4jfXw1wS6uI/
	 rYbZfuP9sN57Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EADF8383BF51;
	Thu, 31 Jul 2025 19:07:29 +0000 (UTC)
Subject: Re: [GIT PULL] GNSS update for 6.17-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <aIno6ItXX8F15Vdb@hovoldconsulting.com>
References: <aIno6ItXX8F15Vdb@hovoldconsulting.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <aIno6ItXX8F15Vdb@hovoldconsulting.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/johan/gnss.git tags/gnss-6.17-rc1
X-PR-Tracked-Commit-Id: e326371f3002dbf54befd8ada9570fa489a46991
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: cfc6d74523efdd36f5757927ac1c75629a6d8491
Message-Id: <175398884853.3259326.9029342072619995471.pr-tracker-bot@kernel.org>
Date: Thu, 31 Jul 2025 19:07:28 +0000
To: Johan Hovold <johan@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Wed, 30 Jul 2025 11:42:00 +0200:

> https://git.kernel.org/pub/scm/linux/kernel/git/johan/gnss.git tags/gnss-6.17-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/cfc6d74523efdd36f5757927ac1c75629a6d8491

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

