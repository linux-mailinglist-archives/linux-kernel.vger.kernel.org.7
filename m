Return-Path: <linux-kernel+bounces-750022-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A3B75B15601
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 01:30:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6AB757AAFE9
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 23:28:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2859272E56;
	Tue, 29 Jul 2025 23:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nm+MYcs1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E4DC22756A
	for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 23:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753831818; cv=none; b=T2JbaR0YNdEXy82t97OvfZvL+48IGrhNKOF4yw+VmbCL12odjU2amaOIdCOnL8Lb3jjbMX7xxFgA5sAl6Tdxe7dsTWYCCPw4UZdAsfZ6vp3jQBtbgrTWullN6PVNiVB/eqz99AhV24YTmsyJuN3Okgf+tCyktAzaNY/zAUbcKT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753831818; c=relaxed/simple;
	bh=FThaCvtaKnin40fYltzD0LUIDGQHROrd7bGbeW9LI3U=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=VzXAnCzzUthIxpVtkvtHQDBTgTnN7fNp3azbXJqyRQJdUXLiOtZIsjZ1LLlkwFb+fgw9DOEHJwHZcqm5u3aDoGnmvdLjgwG7fupHgfjkydLGwN8yOHVb/IvmBN1C9X7P3xrjFZsVYWezsvZ0hd6b2QC2ye7LHFCD2nfg7u3n9vw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nm+MYcs1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08D49C4CEF6;
	Tue, 29 Jul 2025 23:30:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753831818;
	bh=FThaCvtaKnin40fYltzD0LUIDGQHROrd7bGbeW9LI3U=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=nm+MYcs1sdqwEDM1i/+jwE8v0rfXa+oIq8PnN/NohftRvrLW5QWOqC1qkOtqIoCSS
	 dGEp67+wltgaTSdMTBo7s9UDCpoXnFIJFoN6BnCVrgoW4xoTBy8YRPRxr+7hx14W7U
	 r2XjImN7ibn4q+dpvggGP+RtI2nmsMWJnu7aw2v3GDLn/bOBI591Iqp5T2LxnuDAB6
	 HUgjfIN45ld2aSTQc07RnSMlj2AoW06uIF0U5EGh7d4b16/cfiL2zCCyB4CTe74bEw
	 o3ojSQpV3i/w6Kr2XKuAm/D67zO956F7t7ADSsPec5EaoOsFfDToTUsx16OVsiecwc
	 9Oqv2I/VFNipQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70CE4383BF5F;
	Tue, 29 Jul 2025 23:30:35 +0000 (UTC)
Subject: Re: [GIT PULL] Stop-machine change for v6.17
From: pr-tracker-bot@kernel.org
In-Reply-To: <d4ff8176-3b74-4d7a-ad9c-7ee08659905b@paulmck-laptop>
References: <d4ff8176-3b74-4d7a-ad9c-7ee08659905b@paulmck-laptop>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <d4ff8176-3b74-4d7a-ad9c-7ee08659905b@paulmck-laptop>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git tags/stop-machine.2025.07.23a
X-PR-Tracked-Commit-Id: cf4fc66746e344181f41604066659073dbb8aaf0
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 909d2bb07dc0e08ea81841f7c901f0f16f965f0e
Message-Id: <175383183406.1684216.1729395503698442209.pr-tracker-bot@kernel.org>
Date: Tue, 29 Jul 2025 23:30:34 +0000
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: torvalds@linux-foundation.org, linux-kernel@vger.kernel.org, kernel-team@meta.com, peterz@infradead.org, joelagnelf@nvidia.com, frederic@kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 25 Jul 2025 17:05:02 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git tags/stop-machine.2025.07.23a

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/909d2bb07dc0e08ea81841f7c901f0f16f965f0e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

