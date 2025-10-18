Return-Path: <linux-kernel+bounces-859338-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 420C8BED535
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Oct 2025 19:27:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3835F4ECCFD
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Oct 2025 17:27:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AF9224DCFD;
	Sat, 18 Oct 2025 17:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fEhlJ9b/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7646E246335
	for <linux-kernel@vger.kernel.org>; Sat, 18 Oct 2025 17:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760808439; cv=none; b=Ejb7kb/ZkHMsnMuW6mqs/3akb5g8E+MQg76F15y5QBIxzt06GIS7M3LZ1zrZwMAbdpe6zh41n3vUVyEpoHlId89Iacc8pBbl9f4OiElBIWBbbY7W6I48P39zu6YAorLT4DJW1k+MS4xCJPeg+bL99Gk9WD6lPodkEgcC9yglcpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760808439; c=relaxed/simple;
	bh=QmGTKM+RnLzBjvWS1gV5DAi0YFvYn3gGyGoJRYQfhR0=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=cl8i7Y24Qh+X4CsJCZm0S0VFCAX6jDRwn857pv8jJZlE7eH+VlxBM6lrjp5orjWgCNVqUtDLgLP2OqcdMCXvJHYWgoc0NtAQPmd0zR0TqvSpQSakHXxG0vFOetQObhHyknry+hDRglNbzbERM4y7ujR+JMW0iAV5a48faHxyRAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fEhlJ9b/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 566B4C4CEF8;
	Sat, 18 Oct 2025 17:27:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760808439;
	bh=QmGTKM+RnLzBjvWS1gV5DAi0YFvYn3gGyGoJRYQfhR0=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=fEhlJ9b/l8YmQsIkKzTKwFeAj0QJiCvwYNo5+b9ByJBD6zboqUfXDh3NX72nUZ75u
	 c5IQ+JPU11I5sUg10q7kXWmEQph+idqR6sWZo2LX25sZjMvbHq6TfG8sATh9UEur0R
	 CllMK9iS1Bmgqu351rmkUuPVIVNF1CWWX0Q2c3h4Jh+nme81SkUGWrNFAxoDaq/tRw
	 iQGtoLDmKBeTr1cP7+sk9vhDpjfP8P15RYX1hLwzsmAxc8SoLf9H/UhQIPa+EV9OI+
	 k+S9PmapntNEqbCISCbCjw9RFEW/Stl2Vnj1jag6CGv0UXDMWRJIpgMmU4vzfol9Tu
	 zdhTZ5OkSyQNQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADF0039EFBB7;
	Sat, 18 Oct 2025 17:27:03 +0000 (UTC)
Subject: Re: [GIT PULL] slab fixes for 6.18-rc2
From: pr-tracker-bot@kernel.org
In-Reply-To: <a22d61d0-9291-455e-8aa1-c19a4574d772@suse.cz>
References: <a22d61d0-9291-455e-8aa1-c19a4574d772@suse.cz>
X-PR-Tracked-List-Id: <linux-mm.kvack.org>
X-PR-Tracked-Message-Id: <a22d61d0-9291-455e-8aa1-c19a4574d772@suse.cz>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/vbabka/slab.git tags/slab-for-6.18-rc2
X-PR-Tracked-Commit-Id: 86f54f9b6c17d6567c69e3a6fed52fdf5d7dbe93
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 959f018f97e63fc188c6a7519baa6dc2d1248828
Message-Id: <176080842226.3050468.9795521680348275739.pr-tracker-bot@kernel.org>
Date: Sat, 18 Oct 2025 17:27:02 +0000
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Harry Yoo <harry.yoo@oracle.com>, David Rientjes <rientjes@google.com>, Christoph Lameter <cl@gentwo.org>, Roman Gushchin <roman.gushchin@linux.dev>, "linux-mm@kvack.org" <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 17 Oct 2025 10:49:47 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/vbabka/slab.git tags/slab-for-6.18-rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/959f018f97e63fc188c6a7519baa6dc2d1248828

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

