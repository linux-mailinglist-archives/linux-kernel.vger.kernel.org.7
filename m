Return-Path: <linux-kernel+bounces-792170-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 51FECB3C103
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 18:41:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2974F1CC3AE2
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 16:41:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB85633CEA9;
	Fri, 29 Aug 2025 16:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sBgw6YHL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15A5B33A027
	for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 16:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756485581; cv=none; b=dVp41Hv4qC/FaVImjgiQ6SFvBhIKYwD6CpbcXM56sUJsAg/d5Wn5qcPphXbSoJwZSb6qHmnMqTBjvS37K0um1LpJ/fMYAmHvy41ocEnd9QtKYWOSnHkiqZXOPJgy85/vYh/357pwSXaBtK6+ztQHfIG6DX/69ntgrIv3hi2U6cE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756485581; c=relaxed/simple;
	bh=qs33uoiNPgG99WgkGvElgEWOyNjpxUIr31aVL6aAVXw=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=khuODdS28SR+uhL6EWbf1F8BYdsnZcG5C20TeEQC4Ni/FZLJSr3v08DIy0MKC3C8pSXVnAAH1cZu41mxbjZpBV1jDsziD+ZT5iUkG4o9lky+xXMteK+EMb+4Ecu0KYOQx7zOZNgKNYePo/hBJ4myELfb6VsKnsMP50nVkoAxq0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sBgw6YHL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECEC3C4CEF0;
	Fri, 29 Aug 2025 16:39:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756485581;
	bh=qs33uoiNPgG99WgkGvElgEWOyNjpxUIr31aVL6aAVXw=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=sBgw6YHL/Ai/6KtXdibEEp2J3eWW47ZIsq5TKVTwusJBIrjAmFbEMsUBgHVI/2WdB
	 Kbxp5MuQ5h58Is0Afty+K0sR1VCxyFc2nP7bdwz+JkW+ZzLzUnhrgl/fvhtn60gQSM
	 YeNMSWskO/mgJbB/q5ZrCAnbNF5SthO0DpGUsNx50dPLWg8V9wPyqVa8CWeCBZ3+2m
	 lx2qqOJkv7eNLK4PuP71mLy41cc4bHww+oXQ5OdiQP6q1J+wY0OwBKItzN82iw6mJ5
	 J1c0lT281CG1hWXvSaxgioAbyvd8aw75HA5Ixkd6YgtlHvg7scZ80VFcSZZjHxcLqX
	 fZ0XmmrGhco/w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EADFB383BF75;
	Fri, 29 Aug 2025 16:39:48 +0000 (UTC)
Subject: Re: [GIT PULL] HID fixes for 6.17
From: pr-tracker-bot@kernel.org
In-Reply-To: <2qs0qn4n-2n38-44r2-r9s2-53o18o975s05@xreary.bet>
References: <2qs0qn4n-2n38-44r2-r9s2-53o18o975s05@xreary.bet>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <2qs0qn4n-2n38-44r2-r9s2-53o18o975s05@xreary.bet>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git tags/hid-for-linus-2025082901
X-PR-Tracked-Commit-Id: 1f3214aae9f49faf495f3836216afbc6c5400b2e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 02d6eeedbc36d4b309d5518778071a749ef79c4e
Message-Id: <175648558745.2275621.8008824078067452606.pr-tracker-bot@kernel.org>
Date: Fri, 29 Aug 2025 16:39:47 +0000
To: Jiri Kosina <jikos@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, Benjamin Tissoires <bentiss@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 29 Aug 2025 16:25:11 +0200 (CEST):

> git://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git tags/hid-for-linus-2025082901

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/02d6eeedbc36d4b309d5518778071a749ef79c4e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

