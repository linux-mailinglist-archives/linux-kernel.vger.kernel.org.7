Return-Path: <linux-kernel+bounces-738383-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B6C5B0B7B4
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Jul 2025 20:38:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B1EF1899779
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Jul 2025 18:38:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70DF8226165;
	Sun, 20 Jul 2025 18:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PZhh1Fck"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D10CB2253EF
	for <linux-kernel@vger.kernel.org>; Sun, 20 Jul 2025 18:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753036684; cv=none; b=WzMqPUHBmzBa+y5gGo6oRiIMCouy5QSl/z9cKTHiSoSLI4rjmAuhrU5uICJAF2CDrFJW0Ozc2m6223CE71YDZxFk4VdBRFv/zXX74cXkyTLsqrAiG3/Lkf8zI7j0dhNbGEt1n1ee03cTwC/vHhKd5SjVGlyzfZKv6/XkRnsMjqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753036684; c=relaxed/simple;
	bh=kThilF4Bp3f+DOAi0DwPajqdgtNvjCk+O+bLsastRcA=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=iAFoXciMSTGlChADEbtDC2A2ATvfe751byqAMOk7n/PZ4cRbWHCayD8nzzPzDx0fBUnsd4Qm79llt+ybbGg55aZr0CcP+1BQ4utwHUwY49Y4d8eWoThKa+B+2HEYzXFhEMbA1A3lWvE01U96/2jZVvB3TVPFPY3CtyP3uMxUaSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PZhh1Fck; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66E9DC4CEED;
	Sun, 20 Jul 2025 18:38:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753036684;
	bh=kThilF4Bp3f+DOAi0DwPajqdgtNvjCk+O+bLsastRcA=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=PZhh1FckLI1IDweicgQTDx5D5mxBVOyQ9YEpUshTyJy3eMPG7cwYs9TcM/cY711QP
	 eoTSo5eLiH8YB6OnPcxUe2csiVjeAHyrl3O/gu4vknK2+gKEmh5Y1bCZo5xdiMJlHn
	 l/tbVs1hYNuoFcXdP5DvEsE6qEDSb9A6cktQNYGT+Wl97a+3sx+fuu7aRg0nU1z6GS
	 rDh7IREvBQTYP4Fy2/XSJIKxqYjBO/4twwGHnKS7+jy1lPMq1H+ZZdNDsnvE4KivGh
	 CYhW+mwzLKjxWpt0d0TSP3DFIrC0576zzI70+EHGrsErf/dJTJAPaN9rm2ZZjGzPd9
	 Ew1BwkQIyV2FA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADC3D383BF51;
	Sun, 20 Jul 2025 18:38:24 +0000 (UTC)
Subject: Re: [GIT pull] x86/urgent for v6.16-rc7
From: pr-tracker-bot@kernel.org
In-Reply-To: <175301303889.263023.7762556142250207604.tglx@xen13>
References: <175301303546.263023.1426155806374119244.tglx@xen13> <175301303889.263023.7762556142250207604.tglx@xen13>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <175301303889.263023.7762556142250207604.tglx@xen13>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-urgent-2025-07-20
X-PR-Tracked-Commit-Id: 6b995d01683feae619aa3263d18a6aa19bface16
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 07fa9cad54609df3eea00cd5b167df6088ce01a6
Message-Id: <175303670330.3266248.16023189527963153926.pr-tracker-bot@kernel.org>
Date: Sun, 20 Jul 2025 18:38:23 +0000
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, x86@kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sun, 20 Jul 2025 14:05:01 +0200 (CEST):

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-urgent-2025-07-20

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/07fa9cad54609df3eea00cd5b167df6088ce01a6

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

