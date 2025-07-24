Return-Path: <linux-kernel+bounces-743447-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD59BB0FECD
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 04:34:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D7A125461C7
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 02:34:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67C6619F420;
	Thu, 24 Jul 2025 02:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A7vpVD0N"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6CC213A41F
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 02:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753324450; cv=none; b=Y1KmXxDPlAqhK0RWsxdk556Jim6+tZ6Fd6hQqzTlG+tnERpYqTNWancRmKHZE1YYsW+ti2DAEndAsexqhRGWSLXoryi+EPZbUAlffLdWlHVEO+WHrANww2VfStpT9s+Ki8AS6Px0gl4sl4xFbmc9SB6f0gwYOZtrizHplfBO69M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753324450; c=relaxed/simple;
	bh=XGPGL9OVy6dFXMESf6ZLlfVJaLRxBfn/cwkkzq8+YCY=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=O6l/NUFDyYYgcRAM+6AvBrjObNefgkedYdUSRHHiiCmPX1tsQu1L34f5EbZ7T9BCV+n5cjZA/bww0GzzjuK5RKBrdwe29zHaoLXbrWHm5xmdaIVwiJNORncWAsMgx6ar+OWmwraqO2qQ5wzOdxR8FQ9VNYTaXqva9VevTK/+CVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A7vpVD0N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8722C4CEE7;
	Thu, 24 Jul 2025 02:34:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753324450;
	bh=XGPGL9OVy6dFXMESf6ZLlfVJaLRxBfn/cwkkzq8+YCY=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=A7vpVD0Ns7OU9l03FyWnFtMUvLjdgEvyve74IpPhc7/SQ6T5EREyoinSAHKmNiH2t
	 cQqfxT8YUxhbipSm4A8yVamEtK4HNbED2HY1kaGL3g35KrNGYe4dvZhkeSP2AFIO62
	 y/L4rKIdYGbvSOOArFEt2xg8Egi1rU+nyrK4JPAB5ltin6B20RpGnOecY3fsvq/SHI
	 iH6hrE09JnTibeH1zSBWMp4mKSaU8BO6uu9eqA61M6Dl6+UKGjIBWzbKNkvMvqaNKB
	 VgI11x3x92lXtVpdlvA/65QrKyBfJl0XhdiXIHTqIJA90DMQN2TgWv9+gaXMSlOlKx
	 cD/EddqWe2P/w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id E7118383BF4E;
	Thu, 24 Jul 2025 02:34:29 +0000 (UTC)
Subject: Re: [git pull] drm fixes for 6.16-rc8/final (resend in txt for sure)
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAPM=9twUCJj4X-2jf0VG5+A2YN9Gk8hjOAhJ2hxq4SdgZfvtMA@mail.gmail.com>
References: <CAPM=9twUCJj4X-2jf0VG5+A2YN9Gk8hjOAhJ2hxq4SdgZfvtMA@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAPM=9twUCJj4X-2jf0VG5+A2YN9Gk8hjOAhJ2hxq4SdgZfvtMA@mail.gmail.com>
X-PR-Tracked-Remote: https://gitlab.freedesktop.org/drm/kernel.git tags/drm-fixes-2025-07-24
X-PR-Tracked-Commit-Id: 337666c522b9eca36deabf4133f7b2279155b69f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 25fae0b93d1d7ddb25958bcb90c3c0e5e0e202bd
Message-Id: <175332446845.1852750.8580468393012759936.pr-tracker-bot@kernel.org>
Date: Thu, 24 Jul 2025 02:34:28 +0000
To: Dave Airlie <airlied@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Simona Vetter <simona@ffwll.ch>, dri-devel <dri-devel@lists.freedesktop.org>, LKML <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 24 Jul 2025 10:40:08 +1000:

> https://gitlab.freedesktop.org/drm/kernel.git tags/drm-fixes-2025-07-24

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/25fae0b93d1d7ddb25958bcb90c3c0e5e0e202bd

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

