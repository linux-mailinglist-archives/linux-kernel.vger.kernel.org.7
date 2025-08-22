Return-Path: <linux-kernel+bounces-782119-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 021A5B31B57
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 16:27:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF8B964043C
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 14:20:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85CA731282B;
	Fri, 22 Aug 2025 14:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K7qvcotL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE1AB30DED8;
	Fri, 22 Aug 2025 14:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755872309; cv=none; b=hLMWs+ilnlIms8u7L41eJgoncIL7Aw2L2OEEHDDyb8mH9vGakdJtsDSwq6rNHRd0TS/2xMoRmGERWn9XFqAplpNsWL2s3XL3YIU6VLTWsI62gOeJgeHxloECtF4BwuiDgIzIFInqiCy0KsxMnbm0P0V52vuYs4r4alR9I1GVJBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755872309; c=relaxed/simple;
	bh=5nLHn80LsLHhr2NVaamNt2oAbAL7yhI1s2q3XPEdaoo=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=P2vN6kb9MBApJDbVJjxT5UM+bOsswx9Bcu/kg/6uviPJdpeCFwSfKFZQGZEChVcIOXctE1X5Qtg+sgQM2Ko57GjzTlTA+ceCW+ploKC9HnUMhvLzAFqi+wJiHrwrOFgPGDl6RdDpNrnINl3mSzwdb9hdcmckXDgQhCjmNxPMiOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K7qvcotL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B692BC4CEED;
	Fri, 22 Aug 2025 14:18:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755872308;
	bh=5nLHn80LsLHhr2NVaamNt2oAbAL7yhI1s2q3XPEdaoo=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=K7qvcotLxvDzYs7lrpdYSLSljecsgri7euW3mPrEuvOsw8JtTG4m99V1pb0EFX1xY
	 5a0zf7phXzF/1yA2xtVKLjy6iH4vSD64kejdD2j6xEifZvzFi4QqIi5tdIf9puPJBK
	 zi3q4fCHgvis4P7y0lYRyN9R6Fr7l30FXMuhq9J4w8olLBau0txmqD22Pq/DMdFFIu
	 Jb3vaaz/kjExIHOtiQPraIxbCZWg5mX/LfEX9JTG6qdGcKDFn1BflMkY2c+X1Jf09T
	 q2ysmq6as8IcW6V5WUrKyasQmFdA8hK8aYEeSn5JDqZNyqtnKB0qeLnT2dYHamlyDF
	 gicLGYPSnNfnw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB0B4383BF6A;
	Fri, 22 Aug 2025 14:18:38 +0000 (UTC)
Subject: Re: [GIT PULL] platform-drivers-x86 for v6.17-2
From: pr-tracker-bot@kernel.org
In-Reply-To: <pdx86-pr-20250822161152-256141077@linux.intel.com>
References: <pdx86-pr-20250822161152-256141077@linux.intel.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <pdx86-pr-20250822161152-256141077@linux.intel.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git tags/platform-drivers-x86-v6.17-2
X-PR-Tracked-Commit-Id: 748f897511446c7578ca5f6d2ff099916bad6e28
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 272aa18fea29f3299960b62e2c24efb049b540ea
Message-Id: <175587231758.1847242.17150080771995738883.pr-tracker-bot@kernel.org>
Date: Fri, 22 Aug 2025 14:18:37 +0000
To: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, PDx86 <platform-driver-x86@vger.kernel.org>, Hans de Goede <hdegoede@redhat.com>, Andy Shevchenko <andy@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 22 Aug 2025 16:11:52 +0300:

> https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git tags/platform-drivers-x86-v6.17-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/272aa18fea29f3299960b62e2c24efb049b540ea

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

