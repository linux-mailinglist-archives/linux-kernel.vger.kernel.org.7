Return-Path: <linux-kernel+bounces-886215-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78829C35030
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 11:02:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 57F5446713A
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 10:00:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24A4E2949E0;
	Wed,  5 Nov 2025 10:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hfibgWMc"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D5C71BE871;
	Wed,  5 Nov 2025 10:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762336833; cv=none; b=N7RtGDxQC7aeNDD+c8FpsHHVgSPrdW/0a9CKDH0yrbX6+gX6unrZyObvigp5VR+Lcs1o+ztL3KnsdzaPUJuL65K793rTRZ/A/pE7i4CnA2fLKwMDHAkkV9gsm0r9AMpDUi6ChXaZjl1VSJpGXl0i/WqPcELlPkuuDKdXpBLMidg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762336833; c=relaxed/simple;
	bh=YD4NDU7urXuQUbJJ8WksowUYLqzf7yB60hRjeHCkZZw=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=sHYSAU3A5HNqdgMgN2tGMfa4v7kR95OWkRMs0IBtDzZPs7wO39Zl7goGDeSyUtM56iYxin8iCtUtaziuxlXjX8BRayP+B5BsYL3S06NZV2vJZW6pMz1raQO+7cU33LQNMM5NWJ7nXHPOCotvqViHyFVoZhiLOGHmkp8VeVE52yw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hfibgWMc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0ECDFC4CEF8;
	Wed,  5 Nov 2025 10:00:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762336833;
	bh=YD4NDU7urXuQUbJJ8WksowUYLqzf7yB60hRjeHCkZZw=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=hfibgWMc92uKDpoPasTW+A55Lp2ZGi8rU3CCEq9CinvfqQ17dC4L6onzgiPbgwYHd
	 6wVSKWRJFSojzdr6wLc5D7ahDXlcejx6bMFuL6rJx8A5cDfNHtH9MSzzoIgSEpMbvz
	 DdW5ufOUW4nca7bvSVFP8/s7fTHnGSo2kx6lypTm/PxovW3E5GGiHyksq+9u2c88Ec
	 X8TYeuLmv16NekZdYTO5FNeKHk+fVyyL35L2I7a5OGubfTD3dCQ+FrsRP0uVlzzEt0
	 y+HR4CEqU9B+2pP0kpiuDwseYmuGKihQktW3TDSC0oI5ZDw8B+XeW5mwuqlkELAJWq
	 jizRhGqWlBOeA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B1C9C380AA73;
	Wed,  5 Nov 2025 10:00:07 +0000 (UTC)
Subject: Re: [GIT PULL for v6.18-rc5] media fixes
From: pr-tracker-bot@kernel.org
In-Reply-To: <20251105101713.6527cb26@foz.lan>
References: <20251105101713.6527cb26@foz.lan>
X-PR-Tracked-List-Id: <linux-media.vger.kernel.org>
X-PR-Tracked-Message-Id: <20251105101713.6527cb26@foz.lan>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/mchehab/linux-media.git media/v6.18-2
X-PR-Tracked-Commit-Id: 27afd6e066cfd80ddbe22a4a11b99174ac89cced
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1c353dc8d962de652bc7ad2ba2e63f553331391c
Message-Id: <176233680721.3550924.15642761016318603416.pr-tracker-bot@kernel.org>
Date: Wed, 05 Nov 2025 10:00:07 +0000
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andrew Morton <akpm@linux-foundation.org>, Linux Media Mailing List <linux-media@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Wed, 5 Nov 2025 10:17:13 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/mchehab/linux-media.git media/v6.18-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1c353dc8d962de652bc7ad2ba2e63f553331391c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

