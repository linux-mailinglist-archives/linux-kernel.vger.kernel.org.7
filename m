Return-Path: <linux-kernel+bounces-737430-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EBEA6B0AC77
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Jul 2025 01:08:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4659D568146
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 23:08:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70A64226541;
	Fri, 18 Jul 2025 23:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dspGXYWX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC4A22253AB
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 23:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752880121; cv=none; b=GOqj1MfQbRBFvnf7oenkN7lh3MYaqrBXLFhWA5GjYQAjrggDXPh7qoZYjSMiMCItHzNhnKqA/WASzll68hKXPBbjSzPLRa1i8hCCZM9yxCq/s39GnrLeG41r2rhYFaaBN+4DbUYBHDsnm+92qMZ3wUcovYCjqtMKvNt7ENx0jMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752880121; c=relaxed/simple;
	bh=Vurc3vJIOZclQbjZGOTZ7VSzBlFwX0C4CBqFNYImuaA=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=bf9KMRurOl/6gXqvJ+5qC86Ddv/vAOqFBYYYSjwa1+USr4ZvCbdr7nmi3ACKz9w0okiuUmrK8ckaLjww+AlBqiTfFq9W/48DEqPZQg4SUEo0AZDrk2ZkfK1ATymHIXn6bdQdtMMe5EYcXq1kEWrMOWqyz1uEnSw0urAkeM2NEfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dspGXYWX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B6B3C4CEEB;
	Fri, 18 Jul 2025 23:08:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752880121;
	bh=Vurc3vJIOZclQbjZGOTZ7VSzBlFwX0C4CBqFNYImuaA=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=dspGXYWX59a7XEkn40IhDkw5hGsg1WXWo1IIoPw4FnjprueS5XgL+x3h6J1UQFeic
	 iCfrz9LPu3c7/ijhwFZZqCPZUMGsqncOn7yumgPF8NMRVAzuzNwY1MufwKucuxRweb
	 2nn7/BxakcYGYANCI0F2SGJSQzEdOuO51FxcKjxTgcx5oz+2Cs9iEcEvzNYppdeB5I
	 Mi9b1aL88h0jJ8c0TCkRH5UZyOXAOTJzJYAukWe+ddt0gKqTxk9KLHzHZ5OyFG4zuG
	 Ar+n5kneJ5p/pKR+U2szgyfcwAgo+j8V3ZwMXskqDUklK3p2tPdtyOV+boQvCpBlEg
	 ZvcYDzQULcwow==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70F3C383BA3C;
	Fri, 18 Jul 2025 23:09:02 +0000 (UTC)
Subject: Re: [GIT PULL] RISC-V Fixes for 6.16-rc7
From: pr-tracker-bot@kernel.org
In-Reply-To: <mhng-AC007570-958E-4BDE-A86F-44681C9AC10E@palmerdabbelt-mac>
References: <mhng-AC007570-958E-4BDE-A86F-44681C9AC10E@palmerdabbelt-mac>
X-PR-Tracked-List-Id: <linux-riscv.lists.infradead.org>
X-PR-Tracked-Message-Id: <mhng-AC007570-958E-4BDE-A86F-44681C9AC10E@palmerdabbelt-mac>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv-for-linus-6.16-rc7
X-PR-Tracked-Commit-Id: b65ca21835ed615907ba231a60db80a2605b94dc
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 414aaef1537ac7f90dcb54e618864680aca2e197
Message-Id: <175288014106.2820345.947998064876714169.pr-tracker-bot@kernel.org>
Date: Fri, 18 Jul 2025 23:09:01 +0000
To: Palmer Dabbelt <palmer@dabbelt.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 18 Jul 2025 14:54:02 -0700 (PDT):

> git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv-for-linus-6.16-rc7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/414aaef1537ac7f90dcb54e618864680aca2e197

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

