Return-Path: <linux-kernel+bounces-667653-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE69CAC87D2
	for <lists+linux-kernel@lfdr.de>; Fri, 30 May 2025 07:25:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 01B6A7A4521
	for <lists+linux-kernel@lfdr.de>; Fri, 30 May 2025 05:23:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8B5F186A;
	Fri, 30 May 2025 05:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k77MYclJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E07C1F542A;
	Fri, 30 May 2025 05:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748582668; cv=none; b=CkUhbybghT8owHIQv7LGx7htXMBLia2ogpP0v0KRMNbjmzPd4dEVQ1eGVVkRen/lg7pmoFXO8pJJcW9UCBDSMUBdV2CLGf2gVqPwFkPfLV06DrbYSOHoTkYWNegmIUjep8wt2q+pRMY+DUYp4V+jlRhAMZ3IoXfpAC4GDqcGBBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748582668; c=relaxed/simple;
	bh=p++oYQC/1LC0Rj6nakcoaQeTYctD2eQ0q5R7TmrzX2g=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=iCrDR3E7g24XtthMV+SURpxzs/3M1oZBTzgzzpV1R5OZ2MKSCUgplwMl4EdrONgowmoXvNaGkz4xKTKV5ndkfbj382H3azmYMqrBUROWOawodbGkD2+I283OJqryeB6slQH+9w9cb68IqcB02V9C1pPk1KVDeEmcYSujJRXhTv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k77MYclJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB19DC4CEED;
	Fri, 30 May 2025 05:24:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748582667;
	bh=p++oYQC/1LC0Rj6nakcoaQeTYctD2eQ0q5R7TmrzX2g=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=k77MYclJkyvLanwseC1QP3PTVlEtOUch+7vKOQs1pfAjZlL2IKkSyxI9znpCBevgE
	 pOafmD6Bn2ifehWIqlKK74EnHVsepbgEmubP4UDvd5htw1Ry0QhojJItUf3WTKTAJJ
	 c3VjuOE+yEvzxC6gf5y7/UB+EyvnaVwNh4YISW1qRuHvOUpDAqsIgAsL1d2e7Qm7Ew
	 tUatav3s4pLhHdaIuCx+G2T02z917rilhb7rt5ApgfMCuie83UbqG0Refnaa6dzWlC
	 aUHLifiVEH95N3ttk36Y2hp1pvToRU2JDVx/zumvhiG/06fvAJXNnHwcTceaizT026
	 QO/EuBvYL5xNw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE07239F1DEE;
	Fri, 30 May 2025 05:25:02 +0000 (UTC)
Subject: Re: [GIT PULL] Trusted Security Manager (TSM) updates for 6.16
From: pr-tracker-bot@kernel.org
In-Reply-To: <683902e2e98df_218f10017@dwillia2-mobl4.notmuch>
References: <683902e2e98df_218f10017@dwillia2-mobl4.notmuch>
X-PR-Tracked-List-Id: <linux-coco.lists.linux.dev>
X-PR-Tracked-Message-Id: <683902e2e98df_218f10017@dwillia2-mobl4.notmuch>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/devsec/tsm tags/tsm-for-6.16
X-PR-Tracked-Commit-Id: 9d948b8804096d940022b1a3c483a5beb8b46574
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ae5ec8adb8ec9c2aa916f853737c101faa87e5ba
Message-Id: <174858270128.3833287.7343943151110343588.pr-tracker-bot@kernel.org>
Date: Fri, 30 May 2025 05:25:01 +0000
To: dan.j.williams@intel.com
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 29 May 2025 17:59:14 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/devsec/tsm tags/tsm-for-6.16

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ae5ec8adb8ec9c2aa916f853737c101faa87e5ba

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

