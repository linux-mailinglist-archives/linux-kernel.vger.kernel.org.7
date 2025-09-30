Return-Path: <linux-kernel+bounces-838169-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A386BAE96F
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 23:04:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A6461C70D4
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 21:04:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B18A2882B7;
	Tue, 30 Sep 2025 21:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MgHwbi1s"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5731F2BE64A
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 21:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759266200; cv=none; b=KiaIXUk4ZLTVyPpJPwI5NZ2mCZ0RN6/zbQ120L9y3cVQnSVhskoH8TpZc0j/7dSdJmadjGh4YWa1G5oKZzacboBKIU85EuXZdDWcMFkunRaqy00kZDkM/23w697MiXh7bRgK0sETcEDwNsDu6eVggYRPhRX+3VSRuYQrECYpJi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759266200; c=relaxed/simple;
	bh=RNVlBTu/Ck/GH3hqZOXwiqOoB75Eav/T6lfrNe3FSm8=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=HN9gbBKhglhm3/+5oHWOe5uw5i3WRwvNsBBssZYLtLoRwQJheWoxrwml1kKg47i8J0FC4dsqc3BM3D95j4nE0gCoklKCgHQ6AmRTA0/9dxDVfn/CLoQiGd3nqLQiliPWxZz4sWr8sYCx4goYAjsD9zj5nThYqvzHEkmQ2A24JhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MgHwbi1s; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BB03C4CEF0;
	Tue, 30 Sep 2025 21:03:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759266200;
	bh=RNVlBTu/Ck/GH3hqZOXwiqOoB75Eav/T6lfrNe3FSm8=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=MgHwbi1scnuWnkKrX0ay6w4rFUVUr/Dr4R9lcBue1ZoPAoxKQdVx5XlEGWU+5CEgj
	 bO0FbBkOFrtEwtE0d025Qz7iOwEnkOzhL5E9ULWaMkjlQ7pw2qRpVXYQc2BfIIk2ct
	 CKYdAvaog2L3LuqSEGhhCsmD0pHWkytEPZLA3YevauyWL/9iqqWCJp2Gt/dX1G1sTU
	 RcTfJkhPrgn4m9A1t2Em4SBOWXwYq8HWeUTHp3D25uR7LJcku1ReIWig7Fs39TFVpv
	 GNbPavFaOo1RwXTSoeC/F0SVV2NLotJek8h96JD9x2jieMGlE6zNZxOTuQq6/bGHPi
	 efXhclFQlTFPA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70D8139D0C1A;
	Tue, 30 Sep 2025 21:03:14 +0000 (UTC)
Subject: Re: [GIT PULL] x86/cpu for v6.18-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250926101319.GAaNZnP1tx-bGTHlwW@fat_crate.local>
References: <20250926101319.GAaNZnP1tx-bGTHlwW@fat_crate.local>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20250926101319.GAaNZnP1tx-bGTHlwW@fat_crate.local>
X-PR-Tracked-Remote: ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/tip/tip tags/x86_cpu_for_v6.18_rc1
X-PR-Tracked-Commit-Id: 27b1fd62012dfe9d3eb8ecde344d7aa673695ecf
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a65879b4584f98e6c1b80380f55ca8cfca82cb47
Message-Id: <175926619290.2146267.1372842024354382924.pr-tracker-bot@kernel.org>
Date: Tue, 30 Sep 2025 21:03:12 +0000
To: Borislav Petkov <bp@alien8.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 26 Sep 2025 12:13:19 +0200:

> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/tip/tip tags/x86_cpu_for_v6.18_rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a65879b4584f98e6c1b80380f55ca8cfca82cb47

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

