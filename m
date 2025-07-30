Return-Path: <linux-kernel+bounces-751220-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E95BB1668A
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 20:49:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9907C624981
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 18:47:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5778B2E3B01;
	Wed, 30 Jul 2025 18:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OxKRQJt/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A75242E2EF3;
	Wed, 30 Jul 2025 18:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753901273; cv=none; b=IS2BZ0mjraqvXuyHNfJtJYa8IH9kP8kjgOD0TnYmhuWoBHrz6xHC/cPE6BdtHYOn0ae+VmkePnW7r4Kl3Fh8QhnyQE7dZUhwPDJ4ZS6qgYMwyrv+rzuzEOO7M2oezKI/JL4arE9fopNzP29JpnKbGA5/ZCahfmDwcOIn35ANWdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753901273; c=relaxed/simple;
	bh=rwZoluvAJTbCX7qtBjwfi1i8hSMDPNTypgECtXqDqCg=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=cXVrE/CXIHuu0YD/gFLZempB4+jR8VnNbH388m1v9pYNPdkf5v++cvADVXGixyuxedXC1ucrP7KzdQ7W7Cu3wAAxGrzWDxOHHqL2zVplr8/m2aQ4BWUuWA+6w72ZJutY9ZJFPzBZPy7Uj/ibonYArHmS/9zohy9RTa7aaugClAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OxKRQJt/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81A97C4CEE3;
	Wed, 30 Jul 2025 18:47:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753901273;
	bh=rwZoluvAJTbCX7qtBjwfi1i8hSMDPNTypgECtXqDqCg=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=OxKRQJt/lxqPFQlGXhikB5oHDeuWGX3vEK3JCpT7bVh8xOQCmWTNldyZLUo8QM7sN
	 tfnBASNs1PEi9ePZnXDEDxN8M2KuHqwelkuDpGkWEhk9+h6VO/CNI6hw6k07OV8uAb
	 oTkqJ24wMX8i5X8tiLxAuMNjUB52OyqiRVj+oT1ROy6s1F2LmdRdwkr5WxzaeWWkwl
	 T1jO+Wk8j76RTAl5OBR31d1PTv613nh+5yRh7NXuFX6LupymoP2b9DSzv6+LJrUflg
	 2Kt3V7DarGeuJgwq8OGKvoSJQlaGVWRTjcMmASxnH4lzE22iFL/xuwDf4MVzlzBWdK
	 becbDPEpu74mw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADDF2383BF5F;
	Wed, 30 Jul 2025 18:48:10 +0000 (UTC)
Subject: Re: [GIT PULL] IOMMU Updates for Linux v6.17
From: pr-tracker-bot@kernel.org
In-Reply-To: <aIdWGaahna8cQqjK@willie-the-truck>
References: <aIdWGaahna8cQqjK@willie-the-truck>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <aIdWGaahna8cQqjK@willie-the-truck>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/iommu/linux.git tags/iommu-updates-v6.17
X-PR-Tracked-Commit-Id: b9e6e8ae0a5f9edae7cc1b5972a1d3dea9223fe2
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 53564f400572b1b8d9ee5bafb9c226eb1d38600a
Message-Id: <175390128935.2433575.10296322889274011325.pr-tracker-bot@kernel.org>
Date: Wed, 30 Jul 2025 18:48:09 +0000
To: Will Deacon <will@kernel.org>
Cc: torvalds@linux-foundation.org, joro@8bytes.org, linux-kernel@vger.kernel.org, iommu@lists.linux.dev
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 28 Jul 2025 11:51:05 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/iommu/linux.git tags/iommu-updates-v6.17

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/53564f400572b1b8d9ee5bafb9c226eb1d38600a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

