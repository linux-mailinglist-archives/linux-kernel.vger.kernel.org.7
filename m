Return-Path: <linux-kernel+bounces-767855-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 595EBB259E0
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 05:31:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D6A0B3B691A
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 03:28:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AB6925A2C9;
	Thu, 14 Aug 2025 03:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aZzzZ3ea"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 640BC230BD2
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 03:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755142090; cv=none; b=K2EVqn4tFV4/8HzCu9OdSCQB46EThwVJmG1oiwJYvBFlYPraG1WZXZrKF7Nq1MXwPznn5QIGdUvy7JTLV1ZtbhMEC+qkysCquGprDOpbGhCGXT7gn/eVhKD6UaSwcvCQDTi20wH+48vqIFFczypec4UqdOskFTV5yiUF/+jq5WY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755142090; c=relaxed/simple;
	bh=KoHi4jKQShvuh6xHOic1Yhz7UijsK3Eqnxzo7mG6gPQ=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=HsxrZDKaOf9fWDVrKgivNIgPMGV40R1UyfxeS307NPmb/icaeouo4WeridjOVfNZx4zZhImoKc5JZj2jiH2/QZTspPVIlXrnOcNTW0KJzgO/JsauUDoZFNrQzxq/p4gLw46LBVJ+rjiVgoyYgWaTMs9BVZn2MEawid0SKXm3mXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aZzzZ3ea; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F395AC4CEEF;
	Thu, 14 Aug 2025 03:28:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755142090;
	bh=KoHi4jKQShvuh6xHOic1Yhz7UijsK3Eqnxzo7mG6gPQ=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=aZzzZ3eaPUFZUMx4QOw/sSP/vgIjDOKCsLj/d5D0VtWb5GQlwdAVOfXHIYqzP2FeE
	 60pxDhT5bmFjy8wClRuG3zsfXKNdYmf1IG3LLFX4E+DAIZunaQQF53a1i8IOYF0tbU
	 STMwq+vxsVrft8qg2PHfrWVth+hlcrBV1S0/DnpBiokC5kZPa+sviBF4fLsFwAxTLg
	 4+xUbURxaxU/O3dCgVscue4pe7tfKkN6TDofzwVYfeU8yqk0DyCx9Mcamyn4iTfVgC
	 MDm1tKf1WMR7scK2PxFRPOB0K4VjEOKe7S/bxaYldQMLQVy2t7C9b6FhJUVxmZF6L5
	 NghtpYxxGainw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE22039D0C31;
	Thu, 14 Aug 2025 03:28:22 +0000 (UTC)
Subject: Re: [GIT PULL] probes: Fixes for v6.17-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250814114541.681999bfa828ca159b7bb32d@kernel.org>
References: <20250814114541.681999bfa828ca159b7bb32d@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20250814114541.681999bfa828ca159b7bb32d@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git probes-fixes-v6.17-rc1
X-PR-Tracked-Commit-Id: e2f9ae91619add9884428d095c3c630b6b120a61
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0cc53520e68bea7fb80fdc6bdf8d226d1b6a98d9
Message-Id: <175514210143.93122.2873914272522184444.pr-tracker-bot@kernel.org>
Date: Thu, 14 Aug 2025 03:28:21 +0000
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Dave Hansen <dave.hansen@linux.intel.com>, Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 14 Aug 2025 11:45:41 +0900:

> git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git probes-fixes-v6.17-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0cc53520e68bea7fb80fdc6bdf8d226d1b6a98d9

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

