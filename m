Return-Path: <linux-kernel+bounces-839627-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81C11BB20A0
	for <lists+linux-kernel@lfdr.de>; Thu, 02 Oct 2025 01:02:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 082EA48801D
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 23:02:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11BE43128CE;
	Wed,  1 Oct 2025 23:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IUpHlbWZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DE273128B9
	for <linux-kernel@vger.kernel.org>; Wed,  1 Oct 2025 23:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759359650; cv=none; b=otE6YCDsBZO7zV+FOgsGA79DMI/8BLbBjJ4gCP0+FWbz5YuTqpjb1x+9isolM4H4tLsa44Ec+StTuivHwgAdfDPyHgmsuOgipu7P+aiSfWvn324zfL9Lkh+t9y1EzLdnB76EwRwFRQeOPjgN8RSaUwbcEEfzL7jY6LqQCch1GFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759359650; c=relaxed/simple;
	bh=GITcIdB8mC6bw50TT8d1xCWLIRpK8lV2iJSbaemLs2w=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=XfnEQBZHGJGt5Qqc4HUSWTcu6imDwxUq7R2sP2WF2epfTQAljHUN2tVB3SnekGreh308XSuleYUJGVVJAGiGvaz2pPhoneIM+vxPR4XR22mV6+zK/ub/oCWxniwDLCZu6+q+Z7E+2vl5laO0vss3ptNRH+Ip/GomUSmG5hHzsac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IUpHlbWZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5167EC4CEF7;
	Wed,  1 Oct 2025 23:00:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759359650;
	bh=GITcIdB8mC6bw50TT8d1xCWLIRpK8lV2iJSbaemLs2w=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=IUpHlbWZrugWzYb/hJFFGYpv9AqGemzYevsJtlhNUMyUj9S3/tsysDKVBlKv1KfNW
	 kcMIBhjlGJyXUf7r8f3ayQX4jhx9bYzNbzIktUN0R1KlYYFt/1173bJwRVWfTapM00
	 4tzr8wuY7vGyNPeGIdMO/LE8maB7/7SbFO5AOfSAdxR27bWFyDU8Mjq6HwTygRdOMR
	 +ou8jXMB+ykycJUdz1m0VcYffMeSjwDYaDzxvfdSfQimkcUkV45/qmqBptAuqwZ9Px
	 BXknzniLM0fxFYUBGzk2iFpow+1FBD6OUKH1rqAsRk1At0ouzVsEkYenpikOauoUC5
	 bdNH04roaE3zg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAF5639EF947;
	Wed,  1 Oct 2025 23:00:43 +0000 (UTC)
Subject: Re: [GIT PULL] IPMI bug fixes for 6.18
From: pr-tracker-bot@kernel.org
In-Reply-To: <aNrKnJ5GNGkf-yqv@mail.minyard.net>
References: <aNrKnJ5GNGkf-yqv@mail.minyard.net>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <aNrKnJ5GNGkf-yqv@mail.minyard.net>
X-PR-Tracked-Remote: https://github.com/cminyard/linux-ipmi.git tags/for-linus-6.18-1
X-PR-Tracked-Commit-Id: d46651d4e3c0caab554c4c591c0b6c3b026b1e93
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 524c4a5daf92982cf16d9e6c8cdf8721abe35a11
Message-Id: <175935964263.2651312.15793300408336185459.pr-tracker-bot@kernel.org>
Date: Wed, 01 Oct 2025 23:00:42 +0000
To: Corey Minyard <corey@minyard.net>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel <linux-kernel@vger.kernel.org>, openipmi-developer@lists.sourceforge.net
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 29 Sep 2025 13:06:20 -0500:

> https://github.com/cminyard/linux-ipmi.git tags/for-linus-6.18-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/524c4a5daf92982cf16d9e6c8cdf8721abe35a11

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

