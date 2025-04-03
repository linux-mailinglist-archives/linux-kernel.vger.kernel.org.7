Return-Path: <linux-kernel+bounces-587960-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5765BA7B254
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Apr 2025 01:17:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 689B51892032
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Apr 2025 23:16:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 002861A5B8F;
	Thu,  3 Apr 2025 23:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dEGaoa2Y"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E5B415575C;
	Thu,  3 Apr 2025 23:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743722194; cv=none; b=GyHInauyqhs9lk1JTDvx6c/UV1fH/x5hRIon7kLuQMZG+QKQF8fLvXIzrlM5FJaDK3kkSdNywoLAT7QpinA7YHoGIlRIPffHv7Y92yJ2S26FU5UNPCU5squGuzozM48JkhUQqF+RWzjbnXGihqmcAA6SdEOkkIrzeQfK2VjKNs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743722194; c=relaxed/simple;
	bh=bccAwnQ6Kd9imIVDTZCxQDIgRAgMPc3gMiJJ2x5icxg=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=ZGA9jHacw33Lv2kKebMNIX6FHvhrSmTSsP0hL08ZvVTvCX7JAVzskku4eIITcMUV54Ob2zznf9S8M59i1vpkudRQnG7QWRa7knKOeB5g3P5M+HJaqAooOok1hRmYzU5gsIdW+QeKEnvMM4YQJFjkbjUxdBzXjDfdmyL9ba1LKzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dEGaoa2Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38826C4CEE3;
	Thu,  3 Apr 2025 23:16:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743722194;
	bh=bccAwnQ6Kd9imIVDTZCxQDIgRAgMPc3gMiJJ2x5icxg=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=dEGaoa2YMNwUChFCxouM6rY3NCQAdcEkMRL1mbQOuSZgMg1tsGvtAwtPskf4EQODB
	 kLdtyhrzqd9hcsag+14dae113e2tVcnHNr/Nuf9dJIHiyaBgzmk3jPZBYLpmgdhLei
	 jjfUFvSwKJB/tcO6lfMiFUyISx731YF/6q3tIQ6h1ix8ddbfc8yRHzzEuf2NMxArlg
	 X43LtTyqFlqYsmN1m3J9K7woSAH0Dm+185kduOFExpFy8gevGJWRv5gKMb5zbfFhun
	 hYCiqtRqprhmBG5ffVu4H0mAwL6fYAhK5jmbgqAgcXCdwxwdTC+YH+xmSlSW1/bcUR
	 OIK5RPf8G49TQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 71347380664C;
	Thu,  3 Apr 2025 23:17:12 +0000 (UTC)
Subject: Re: [GIT PULL] 9p fixes for 6.15-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <Z-4Vzhdi_3XZDFfV@codewreck.org>
References: <Z-4Vzhdi_3XZDFfV@codewreck.org>
X-PR-Tracked-List-Id: <v9fs.lists.linux.dev>
X-PR-Tracked-Message-Id: <Z-4Vzhdi_3XZDFfV@codewreck.org>
X-PR-Tracked-Remote: https://github.com/martinetd/linux tags/9p-for-6.15-rc1
X-PR-Tracked-Commit-Id: 4210030d8bc4834fcb774babc458d02a2432ee76
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: bdafff62ae028e4d399751b0b6f26d76dbad6b62
Message-Id: <174372223111.2716716.14824049235094539359.pr-tracker-bot@kernel.org>
Date: Thu, 03 Apr 2025 23:17:11 +0000
To: Dominique Martinet <asmadeus@codewreck.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Christian Schoenebeck <linux_oss@crudebyte.com>, Eric Van Hensbergen <ericvh@kernel.org>, v9fs@lists.linux.dev, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 3 Apr 2025 13:59:58 +0900:

> https://github.com/martinetd/linux tags/9p-for-6.15-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/bdafff62ae028e4d399751b0b6f26d76dbad6b62

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

