Return-Path: <linux-kernel+bounces-842182-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 58381BB92B0
	for <lists+linux-kernel@lfdr.de>; Sun, 05 Oct 2025 01:41:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 11B924EACE3
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Oct 2025 23:41:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 756132AD32;
	Sat,  4 Oct 2025 23:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Koy9mtZy"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7EDC24679F;
	Sat,  4 Oct 2025 23:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759621302; cv=none; b=twxMIzQOmq7vXcQ3LiPDvWdpx6sGl1vpEnV/zt5ad3DV6da+PsD3runJzABJe+uC9ZNFs0eIgwLWFPxS+42xGHzGNZXfpew+KIJwI3jyJLnL/tnrCr1IXjd6XRqZ2csihQMh0Rz9WRJL50pB1JeVqdmshgJed3tdRthwbBQdf9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759621302; c=relaxed/simple;
	bh=KNi22HqiPALkEdBtH4NANvf1bWDZqXqUDGMLOMndKS0=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=Xj4HPB6co4FELapAD9d0NSWeUwvByd/a7oUrYEit90PR74dgm+Cfv5aGr60vo6rcOnV1/aCFmT45hxmbhf5B4zUFOMKdx4tr2yZltXtcOMJwK3C2ST2jJVTlvCNJNNHUKh86X9bpCRyoRh3ARI9766VxqoD01ynazRZPrLYzR6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Koy9mtZy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB967C4CEF1;
	Sat,  4 Oct 2025 23:41:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759621302;
	bh=KNi22HqiPALkEdBtH4NANvf1bWDZqXqUDGMLOMndKS0=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=Koy9mtZyc+c6ydglqYnRVEzsIG4tZptka1mbWvtsqt6GpJn4I2/VP0qfIjUEghU4z
	 okUn4EX3y2iXwwUQpXOOkkjP4ijB7lL52DihGlwPWNzbE548WPKaEL8bGHbk0bTp8P
	 aXL2svhHpyrsM+GWgsWqCXUJK864IRi/ekk+DNlfdZXUUimoiewRqoEUkpq4DkJlKf
	 tO8u4fKN86jV9Hkxha/Uru4MV/9goBGGpsx9hY5t3DXG+CK4EZ/2ZKd3U3oxQG1tSs
	 EeL9MZQqRgJCnG6Sdj8oc/3l+hV5LraEbPw+Ui7kcHs8pu8uZ6Y5lYTWm1qNsjwLJO
	 afVM2hz7dw6yQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 8950F39D0C1B;
	Sat,  4 Oct 2025 23:41:34 +0000 (UTC)
Subject: Re: [GIT PULL] USB/Thunderbolt changes for 6.18-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <aOEpFzhV1YiZ3qjw@kroah.com>
References: <aOEpFzhV1YiZ3qjw@kroah.com>
X-PR-Tracked-List-Id: <linux-usb.vger.kernel.org>
X-PR-Tracked-Message-Id: <aOEpFzhV1YiZ3qjw@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-6.18-rc1
X-PR-Tracked-Commit-Id: e40b984b6c4ce3f80814f39f86f87b2a48f2e662
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c6006b8ca14dcc604567be99fc4863e6e11ab6e3
Message-Id: <175962129312.472872.7030049888050096392.pr-tracker-bot@kernel.org>
Date: Sat, 04 Oct 2025 23:41:33 +0000
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sat, 4 Oct 2025 16:03:03 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-6.18-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c6006b8ca14dcc604567be99fc4863e6e11ab6e3

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

