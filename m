Return-Path: <linux-kernel+bounces-745968-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DE78FB12109
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 17:39:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 844A51CC4585
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 15:39:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E37AD2EF282;
	Fri, 25 Jul 2025 15:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S6R00sNl"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 445572EE980;
	Fri, 25 Jul 2025 15:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753457926; cv=none; b=lng5HksJGNAPLwLlLmeUZPt93jLoGcV9DjiSyOL++JfZGbKIZ1vCOv/Jgg/v7ymsSLKEjrLV0spZ3uWeffIxULYhHRsasuBPYFGPcqMXuRhtIlaVYAgPa2lYygOgkqITh/8pSempqvlkZ/5cXpQjpgtFnMeyxnsysLBWStmyChQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753457926; c=relaxed/simple;
	bh=Pv5esia7f1Oo/MnqsAVYfcCvEiC0IVTnC1Ej48D+jGQ=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=kw56eRws7WWDcBy34c2UvyMyY/GOrPDO0061orcr79V4SGh+XC+IPew+NJZAAm7asmNT+BOYf4sopDc2MgcY0yslvdogVh9kAJE5KbLTpc8y6OkGHrKqnui+jKLj3QSNmHI7+CGy6amQq/BI3YnneFKTWBLLVQ8E9lP/HOLeeIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S6R00sNl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22B76C4CEE7;
	Fri, 25 Jul 2025 15:38:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753457926;
	bh=Pv5esia7f1Oo/MnqsAVYfcCvEiC0IVTnC1Ej48D+jGQ=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=S6R00sNlVNecSSQzzOsL5uIHh/Zfj52Mwg078hYzscJIzofc3Hau34TcabrZxYJiT
	 ot/1j9jN0fo7gwp0GkbN2xwfDX0CLqU1rxkBariBhDfRxgjab5+Mi3ZWYu7Bk8J1D4
	 WRWD63i1UI/7FDQkcbxdAprKQtijmfVPet+7Rob+VazrpnhtPBjmiYWieQm9THWhAl
	 CjCyYzqAf5HQNQN40JLULqeFCOcS30CN6lfI9k1Cpo3UTwVXaqrVQma+MKDNZGut8B
	 0nJd/uY+EbQVaMbaxgTIaKneoMB2ENcqYTelV8aGkfptX68ZdVb2/1MbBW+SnRviMn
	 JdQR68uTekmkQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EADE7383BF5B;
	Fri, 25 Jul 2025 15:39:04 +0000 (UTC)
Subject: Re: [GIT PULL] bcachefs fixes for 6.16
From: pr-tracker-bot@kernel.org
In-Reply-To: <q57tgxvd47i7xbqwaeznpwqoa2zmccg73s3glzqj5egpv4n7tl@4frslbhlovgr>
References: <q57tgxvd47i7xbqwaeznpwqoa2zmccg73s3glzqj5egpv4n7tl@4frslbhlovgr>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <q57tgxvd47i7xbqwaeznpwqoa2zmccg73s3glzqj5egpv4n7tl@4frslbhlovgr>
X-PR-Tracked-Remote: git://evilpiepirate.org/bcachefs.git tags/bcachefs-2025-07-24
X-PR-Tracked-Commit-Id: c37495fe3531647db4ae5787a80699ae1438d7cf
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: bef3012b2f6814af2b5c5abd6b5f85921dbb8a01
Message-Id: <175345794354.3175853.699617834531156644.pr-tracker-bot@kernel.org>
Date: Fri, 25 Jul 2025 15:39:03 +0000
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 24 Jul 2025 22:58:22 -0400:

> git://evilpiepirate.org/bcachefs.git tags/bcachefs-2025-07-24

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/bef3012b2f6814af2b5c5abd6b5f85921dbb8a01

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

