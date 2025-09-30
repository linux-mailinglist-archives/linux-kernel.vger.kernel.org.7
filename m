Return-Path: <linux-kernel+bounces-837023-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 227CFBAB1AD
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 04:55:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 20AB11C777E
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 02:55:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 108C5221FC7;
	Tue, 30 Sep 2025 02:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GjLYA1ZA"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 607C63C1F
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 02:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759200894; cv=none; b=gZ9oeujzJN6Jtpv0H+Kd1fEhorTvCW7nkQRWZfwxZkUOi5/K1wA3LZ0zP6AbTVvg8j/ZeUC152fF0wPQpFs2sMrdxT5l9swr3Sz0Y8WRXqIzWZmIaHW8WgdrNyOjvhO9WiSQ9150DX9gDN3Rng0rp6D+An4zKFg106v8ZLMmZeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759200894; c=relaxed/simple;
	bh=uo7Savh2jdRoLE/h4iBeiiM/33EYh7bs9MNssk3S0I8=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=a6EAVsFwALf7As6a0HPoTwnXlWxzCbZaX3FAWDgHz/axjyVyzTtiVOx+ZlqsumOAyaZ+5BTv5VUgXejw/+Ts310j1VgysJt+W1krliyTihME3iLhjl6ogXmlSLUmZV7NLtdek0EfUo7l93c2uJ+LokA77fEDzNkqmX+bRIXZ5h0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GjLYA1ZA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 418FDC4CEF5;
	Tue, 30 Sep 2025 02:54:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759200894;
	bh=uo7Savh2jdRoLE/h4iBeiiM/33EYh7bs9MNssk3S0I8=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=GjLYA1ZA4WPY9yhwup6RP2fyRlpFIHCL0YxxRawoaFTtIXoRsmNb8Ah1NtJO+isWl
	 ecu5ZmSvCPxuuuM4zlRBaXPXdTTyXdSLq6mS/MBPBRUid2UQHPwTns4xS8iANAxC61
	 lHI6CQIPv/Ea4EwlJ5kbdKGYwmYe2s8am9dH4QPdYHVcucCT6gBCYG5hDOjGrYAj/g
	 Lv8nbLwnjLAt9ETINCtAiqnvnOfd7RwqQrCLoWgvKNNIErS50FmS/J6csiJPc3isuY
	 xSFqBuo1qMwrdbi3tTYX2Vn/vUC5kWUryVf8b+A94Kg9LIAhx3pUIiszEkKOpyuO++
	 urKGBWVAi+PWg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADDF939D0C1A;
	Tue, 30 Sep 2025 02:54:48 +0000 (UTC)
Subject: Re: [GIT PULL] nios2: updates for v6.18
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250924114444.33618-1-dinguyen@kernel.org>
References: <20250924114444.33618-1-dinguyen@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20250924114444.33618-1-dinguyen@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/dinguyen/linux.git tags/nios2_update_for_v6.18
X-PR-Tracked-Commit-Id: a20b83cf45be2057f3d073506779e52c7fa17f94
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 46a1b6b2aaae965b27b3bb34cf88d441f6aef20e
Message-Id: <175920088733.1805104.11467922785823618013.pr-tracker-bot@kernel.org>
Date: Tue, 30 Sep 2025 02:54:47 +0000
To: Dinh Nguyen <dinguyen@kernel.org>
Cc: torvalds@linux-foundation.org, dinguyen@kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Wed, 24 Sep 2025 06:44:44 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/dinguyen/linux.git tags/nios2_update_for_v6.18

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/46a1b6b2aaae965b27b3bb34cf88d441f6aef20e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

