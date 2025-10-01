Return-Path: <linux-kernel+bounces-838269-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CCD26BAED85
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 02:03:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF75D4A1926
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 00:03:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D39961607A4;
	Wed,  1 Oct 2025 00:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u7iaYYOe"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E2BD3987D
	for <linux-kernel@vger.kernel.org>; Wed,  1 Oct 2025 00:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759276957; cv=none; b=MEZAIBjl8dtgagGqVEITruWfL3eb+45OLJg39fc+yRZx0nCHdAgpPiI0lyz05dup5BNfXqM9rtPEW/4Kdnv9j2OMgIRIbhn8MbuwTuvEQIbqV/HPqGZmPx/h64N5wrvh7V8YXQTVu/udkQtiLypca4UKpPVnWGjkSIrKFltHUP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759276957; c=relaxed/simple;
	bh=WSSH2oPkLVUhmcyP20RM4o8s9aNZ+Q/d4Pz9Tkl3Ejk=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=AeDKlM3f/87Rt9X0lil9vuDGWP24WaG7MT7y11le8hlQ4gacOVQ3n69gHYQcDKJoh0PkFLzbrreQ9VlDk287u62EUStnxGcIvgfirUkGwbR2mVWBi5wDlLilJycDV6Xmk4HrU9rg4PaR2OdGwNHX1cCi2jLDAeqFAu8uxKUh7Mk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u7iaYYOe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14D4AC116C6;
	Wed,  1 Oct 2025 00:02:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759276957;
	bh=WSSH2oPkLVUhmcyP20RM4o8s9aNZ+Q/d4Pz9Tkl3Ejk=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=u7iaYYOeJqqe1S9YDjTweJaVE8tvpzCDfslv5vt6yua+Tm8NnWId8Cpz6BGF+bWnP
	 TGNlrNUnpWjGvMrtdwyhRC6QUqudBhvUyK4D0LP2k19XItxd5yvnosuvs6fr/IP1yY
	 T+yWTfkPOU0lswWjAwHz9E8dF/FypluVHoX+4gohhO9oVSQOqv6FCH5DJhTTsfxl/j
	 Sti4IWz7OxOZ0WHdddNJdYqP/a1rReXpkWNYQnH5l5yWUck+00hrPid27IhxQ4UKnb
	 K9ZkpsbGDEUJb0Vr7POiRg7jGpaHON5cbDuCw9O+TWIOLNUqB9Yw7h2ne/0lboT4wF
	 c6OG5xNx71uXA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33BF639D0C1A;
	Wed,  1 Oct 2025 00:02:31 +0000 (UTC)
Subject: Re: [GIT pull] core/core for v6.18-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <175913807599.495041.10251515322736195577.tglx@xen13>
References: <175913807599.495041.10251515322736195577.tglx@xen13>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <175913807599.495041.10251515322736195577.tglx@xen13>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git core-core-2025-09-29
X-PR-Tracked-Commit-Id: 3ec09344b01a15901ba824e877a0562ed8103e27
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7601d18be06943d5ac2b1802899ff6c303544936
Message-Id: <175927694990.2242674.8992034420403500845.pr-tracker-bot@kernel.org>
Date: Wed, 01 Oct 2025 00:02:29 +0000
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, x86@kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 29 Sep 2025 11:28:54 +0200 (CEST):

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git core-core-2025-09-29

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7601d18be06943d5ac2b1802899ff6c303544936

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

