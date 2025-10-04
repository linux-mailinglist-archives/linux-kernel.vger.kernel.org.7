Return-Path: <linux-kernel+bounces-842129-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B262BB90E4
	for <lists+linux-kernel@lfdr.de>; Sat, 04 Oct 2025 20:20:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2B7744E9DC6
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Oct 2025 18:20:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2925217F33;
	Sat,  4 Oct 2025 18:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dgrsrcXl"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E65D3D3B3
	for <linux-kernel@vger.kernel.org>; Sat,  4 Oct 2025 18:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759602004; cv=none; b=WwcNqA9d+hQq5HZXdj+n0QE4hKnZYL0TL0UfgVRz9oMBHe0fa0RIXn+Ib7C0iF/Q5ap49CbDZA6FDJiViFUNuQky7+qj9mWajVfIx1iXLd8/wq+AZElR6eePEL48dW4Lq4Einn9WRSigL5+XLR89lQlksA96uCMBry15HOKPkao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759602004; c=relaxed/simple;
	bh=ro5nWrlu5+oisypfnn7859GJRQnWrQ64hwn5nsWXJbA=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=HDSUD2QYKVNgP4xUnvlg7tq01IGE+YUKljMNJ66TTpS6XlqLTq2AkEVrzksgBcl+nBV3iGsI8tshsJgO2wZpxFMl55MSgDeQpIRlFdseEFziC5iJxf/8n2MkMO97VUfgy6JGM8JzpAUVN4ib+DIi5rKQ77eFcBgb2GQNS/Sxa7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dgrsrcXl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01EE4C4CEF1;
	Sat,  4 Oct 2025 18:20:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759602004;
	bh=ro5nWrlu5+oisypfnn7859GJRQnWrQ64hwn5nsWXJbA=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=dgrsrcXlw4bXMWAsCqSlTs2zw4HP3S0VMy/ZGFgRvMFH+N6RRsbFaA0pz/QYf+gFX
	 kXVKliBaJC9c8h6tRqFCEx0obSRQ1zhSHSstQGvMIOz5uCfdBskjVSab03lUHr1CV3
	 epTHZ74s3Qp9uPh+8awxPz2U5KRDFCUgF2URcYQsUBTtiJLglmkD7mWTo2WdbZTNSI
	 y2wvxdgek9vuYnr3TmeOg/qQH5U1ZTHj0dddL3z6BEiB0E9Hxq1/naXTi0/BdTiZfY
	 zVc9xRLW8B6X1o1o4MpVjBZBo9HUMLR04RHpRdAarM8yZaPFCI02uy4nAt5z2/TZcc
	 pEuvbaFccx04A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAFDE39D0C1A;
	Sat,  4 Oct 2025 18:19:55 +0000 (UTC)
Subject: Re: [GIT PULL] x86/entry for 6.18-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <20251001173908.905725-1-dave.hansen@linux.intel.com>
References: <20251001173908.905725-1-dave.hansen@linux.intel.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20251001173908.905725-1-dave.hansen@linux.intel.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_entry_for_6.18-rc1
X-PR-Tracked-Commit-Id: 3da01ffe1aeaa0d427ab5235ba735226670a80d9
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7c738cb4ca678e70c4583ab35587f30bfae823e5
Message-Id: <175960199457.404121.6895798733273618013.pr-tracker-bot@kernel.org>
Date: Sat, 04 Oct 2025 18:19:54 +0000
To: Dave Hansen <dave.hansen@linux.intel.com>
Cc: torvalds@linux-foundation.org, x86@kernel.org, linux-kernel@vger.kernel.org, Dave Hansen <dave.hansen@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Wed,  1 Oct 2025 10:39:08 -0700:

> https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_entry_for_6.18-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7c738cb4ca678e70c4583ab35587f30bfae823e5

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

