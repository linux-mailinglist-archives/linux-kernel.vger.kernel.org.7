Return-Path: <linux-kernel+bounces-838163-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45A79BAE954
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 23:03:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 81D8C7A89BE
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 21:01:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1615728B7DE;
	Tue, 30 Sep 2025 21:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KF7FUNUE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71CD5280A5F
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 21:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759266191; cv=none; b=GR9sErglYntvRSQgUMx12moDxpbKT+vEjTJT0OI3rHE19dM+xp+qNTLhEblvRA3Mgucosi+mW4/Zj73+BXEhaYQQCr+XnFy45GkkF9hDA/3s61oLmWk9GD0jP+htQCC2cPGpacdGBrojAsx1Oj7XfpeEMOuC/+hh2MYWuoMGgrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759266191; c=relaxed/simple;
	bh=TSpS98rtLN1vo9upBvGpbHWu8uhbMMy00JZ/ujsi9EM=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=gOEl5txqi/dzyLhJI5rlPpdjsLU7uxhtgKOVqrw/+7KpD26tYPh0mFxubnoGE9RnSU34gRJt3bOiQVVcRS5zj31P1dJAIhaKxqQyA6aBCTKWUFqR+kSfTBS+r8ltoz9xxINbIaXctxTGPYPIIwGQrWUtIlXvyGcITZtOFhPMGQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KF7FUNUE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1078C4CEF0;
	Tue, 30 Sep 2025 21:03:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759266190;
	bh=TSpS98rtLN1vo9upBvGpbHWu8uhbMMy00JZ/ujsi9EM=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=KF7FUNUE6ap7Vqr+o14qqx1PGtndHJpxud3gpC7DHX16kQkhbM8n40DUKEj8hO2V0
	 oJWozqI9PxIC53C1kjhjkD8Rc9U0K7YOeT2NiSvNEYEpnVSMrj+P50CoFrD6SC24NN
	 FDYOuTigpKw2ubFumPcDX8NrXDZvgx2vTFeBTNinc3XLxqe6zLK8gCMVzplhD6Fb2y
	 pwuFepzNPqvaAYfwlV94eG3tL91EkKzMZkbE6schPy8Ne+jjssYOqfNKIhwICu6ViB
	 Ag7gvzfSDK7eOaQgKVrTBSlqo5n+NiH8E3/KtXctwaN+h1qKGZW1KXM73pMjjMsRBl
	 oSd96BX7vumxA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 151CB39D0C1A;
	Tue, 30 Sep 2025 21:03:05 +0000 (UTC)
Subject: Re: [GIT PULL] x86/build for v6.18-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250926095952.GAaNZkGKIuQKymGBtv@fat_crate.local>
References: <20250926095952.GAaNZkGKIuQKymGBtv@fat_crate.local>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20250926095952.GAaNZkGKIuQKymGBtv@fat_crate.local>
X-PR-Tracked-Remote: ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/tip/tip tags/x86_build_for_v6.18_rc1
X-PR-Tracked-Commit-Id: 2c6a28f3ef729ed2d5b174b4e0f33172fb286bab
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 163d9c6b339c4bbe1a7a877ed8c99702da96d994
Message-Id: <175926618381.2146267.6801276682958984934.pr-tracker-bot@kernel.org>
Date: Tue, 30 Sep 2025 21:03:03 +0000
To: Borislav Petkov <bp@alien8.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 26 Sep 2025 11:59:52 +0200:

> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/tip/tip tags/x86_build_for_v6.18_rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/163d9c6b339c4bbe1a7a877ed8c99702da96d994

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

