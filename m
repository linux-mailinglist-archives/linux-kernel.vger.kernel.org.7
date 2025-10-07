Return-Path: <linux-kernel+bounces-844494-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 988BBBC2122
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 18:14:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 566073E0DCC
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 16:13:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D8312E7199;
	Tue,  7 Oct 2025 16:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TRuVcDvj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A3CE2E0B74
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 16:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759853620; cv=none; b=fvMOk/Oov93Skkg2MAyZCKTkTsA09c+tKE2KAN+eHbUm5dREbmbsklufS5hPPLvLact4m7eTerZC285UDxIwxokewqdnwlUYvofeFcHarQQF9RGS6Z1sdzHG4dpITAkPqmisxs3U5roO57bB+T3i1/52atONbEsVuMmVjS4yxLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759853620; c=relaxed/simple;
	bh=qjkaPjwH7M3f9DsHVddOSMKYUMQqQrIIvpUpOYA/IRs=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=Rgrb0RsBX+9oFygwRulv8LEGKGEvpK4PLRjOeqJ3f4UwHmi3syOfyo5Qlgs2Q8e8wcNeMlh0W+q3pXcubh1p/iMh7NN6BNjb1fJp+bqneLqE0F7s5mW1v01mFNlbOVwKUsM6cOlKKdiO7FfurJujI1dzk3YrjQgCCelhC5IGKXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TRuVcDvj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53F2CC4CEF1;
	Tue,  7 Oct 2025 16:13:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759853620;
	bh=qjkaPjwH7M3f9DsHVddOSMKYUMQqQrIIvpUpOYA/IRs=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=TRuVcDvjWDPjlfgJhCCdSekNI5lqg62k6VxoiwvP73+Fpz/6kawS7Ee8x1o9N/dfk
	 oHvFNMYbulqewM1iqTylI2jXH+NtF9yzWShrga2Yi+6ZI/hCcUcrfXoDmv02toLSo2
	 2vU0jMzk9WwBMUMKSX8Jdbg0CdOA9WpGn5/8I5s+739Rru3CUnrqFvnAs23YK88SUF
	 Inah+LXDwxlyC7f/w3sj5+umJQvhEecKtIKFqsabEmQT8UpMvWX7lHNRX3EJJnte/e
	 7AwCDimvHIJySq3bQ65xNmcOEoaRwNsEJU2ixOvzoxOdrv+/9YQOpGqDCwc9XSgzQV
	 KDRNSHEgkSLxw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE0E639EFA6D;
	Tue,  7 Oct 2025 16:13:30 +0000 (UTC)
Subject: Re: [GIT PULL] arm64 fixes for -rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <aOTPIiF3aO-YroaE@willie-the-truck>
References: <aOTPIiF3aO-YroaE@willie-the-truck>
X-PR-Tracked-List-Id: <linux-arm-kernel.lists.infradead.org>
X-PR-Tracked-Message-Id: <aOTPIiF3aO-YroaE@willie-the-truck>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git tags/arm64-fixes
X-PR-Tracked-Commit-Id: f620d66af3165838bfa845dcf9f5f9b4089bf508
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 971199ad2a0f1b2fbe14af13369704aff2999988
Message-Id: <175985360915.2684232.18171883448738269661.pr-tracker-bot@kernel.org>
Date: Tue, 07 Oct 2025 16:13:29 +0000
To: Will Deacon <will@kernel.org>
Cc: torvalds@linux-foundation.org, catalin.marinas@arm.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, kernel-team@android.com
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Tue, 7 Oct 2025 09:28:18 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git tags/arm64-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/971199ad2a0f1b2fbe14af13369704aff2999988

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

