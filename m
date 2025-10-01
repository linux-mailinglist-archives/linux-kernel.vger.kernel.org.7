Return-Path: <linux-kernel+bounces-838268-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 683C6BAED82
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 02:03:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 954317A7DC3
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 00:01:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86A091519AC;
	Wed,  1 Oct 2025 00:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IVtcAziW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E70F21465B4
	for <linux-kernel@vger.kernel.org>; Wed,  1 Oct 2025 00:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759276956; cv=none; b=ZfyMtFeN45qdcX5CKBsmXZNooPIdEuduwRhpyAw6Gh7gI6aKJd8KCh3fAYmhNFIdwctdYdmwhVZn+hnZ/035/T9/qI9hVNS6369mjnrfRf9rUOXz4HHvzmWSXZb+WkODJdWRoKkZGCOoS1HcIDyWU5Uefcc+/wB0HfH/zPR08Ow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759276956; c=relaxed/simple;
	bh=vvPKG1LRE6cliM+hSrfOf0ayIEO49oP5GTGOKxF2FiE=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=eGb1MQteDJE039U6IIg0GriYHdWepdOEOPoOzR0FxgysHNpAWpRzvoo09qadCmYKuNa/VLe7U3pu9mtQi3KPwn1D4O4vD0R1zfWTruKnB8Ww7dLAFaNki+EGhr+sus7btMqLHVND9lxcaLOiT3q1l/UHgXZ3m+YQ20zBQk5ReZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IVtcAziW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 875D5C4CEF0;
	Wed,  1 Oct 2025 00:02:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759276955;
	bh=vvPKG1LRE6cliM+hSrfOf0ayIEO49oP5GTGOKxF2FiE=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=IVtcAziWUUszampWd0IvlMWHhanWxU8y9cY+ZDKKzkzb/wDGR8LARgKQHRtPk2lSG
	 aT8kGN4QmhyiGG1ZjxHryrqASJfMzTdgMMn23Rs0fJrJpdi2cjX3wXkKZZiaTaL/3D
	 El3pEBR0Q7Qe81LJ2Ipmim8hKLO8cEKqkO57sXKTdgQuDu1/VKQy0DvuOldVC41ZhY
	 B9bWw0eH+eKhj2NOoZ6r0Sr+h12VIwxMPFJa6sBGhIgBezmksOg1el8Pqm6/snIBeT
	 Q1OYYlrGXZlv/T9d7OPBmDCOEX9LXSip4P5OxqbDFBOHeOON6LkAhjy/x79WO7oZjK
	 6YsDi80OjsCjg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADBC739D0C1A;
	Wed,  1 Oct 2025 00:02:29 +0000 (UTC)
Subject: Re: [GIT pull] smp/core for v6.18-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <175913808486.495041.3091230048959079390.tglx@xen13>
References: <175913807599.495041.10251515322736195577.tglx@xen13> <175913808486.495041.3091230048959079390.tglx@xen13>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <175913808486.495041.3091230048959079390.tglx@xen13>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git smp-core-2025-09-29
X-PR-Tracked-Commit-Id: ccf09357ffef2ab472369ab9cdf470c9bc9b821a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d8de3685f1a28722a4ba4f1f06a0987822750fb9
Message-Id: <175927694840.2242674.6684212038884191496.pr-tracker-bot@kernel.org>
Date: Wed, 01 Oct 2025 00:02:28 +0000
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, x86@kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 29 Sep 2025 11:29:04 +0200 (CEST):

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git smp-core-2025-09-29

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d8de3685f1a28722a4ba4f1f06a0987822750fb9

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

