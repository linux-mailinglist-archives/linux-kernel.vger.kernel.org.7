Return-Path: <linux-kernel+bounces-842189-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id EDE86BB92D1
	for <lists+linux-kernel@lfdr.de>; Sun, 05 Oct 2025 01:43:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 9A6783477FA
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Oct 2025 23:43:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8766C265292;
	Sat,  4 Oct 2025 23:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qLjnyRIK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E25B0263C8A
	for <linux-kernel@vger.kernel.org>; Sat,  4 Oct 2025 23:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759621348; cv=none; b=lWv+QQ/nuxO8+gXK6ZWl8LDUB27T/uITeJd66TKU2nLshzVQ9JPA/regEx+eif8Rz+dfRhRWt90PX0m3idc6gAw+StBWY1cuRKlHv69VO+cP92wPWzbcEIe1ES9pLCjZRS0m7mESzq+Uj2A8wWL/AW2RSr4jx/WYOEj5dRVlqTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759621348; c=relaxed/simple;
	bh=fhGivjgDdPWCKMroSuKYuKLI5udwppkxTyjVwCwRn0o=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=nDELVKxE6eMbUDISZahQpVjAeCjwBC9Mex/xI8Cm5KHfplQlebKrcRf/HuX9eD9qdu++4khxU3JlcJ6HfZKOCofcVUyAhyvDYacJV4PsyFWOT8ap3EP72V1Qt0HmblsNTYeyGKaC/II0lH7osyXYbPW+aZzMoXt/vv9odppci+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qLjnyRIK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6218C4CEF9;
	Sat,  4 Oct 2025 23:42:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759621347;
	bh=fhGivjgDdPWCKMroSuKYuKLI5udwppkxTyjVwCwRn0o=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=qLjnyRIK7xzm4jmkUvYYK6+7gNppqGHEwKy0+0rHEC82Ic3QMZTYzn/O9wYn9bYNR
	 a7RCZgj3Rn/xprYueD0bmcfwXrkkFo9guMspwb6akA8a2lhwRX5atTNA82+JYHVj1p
	 RXySRggmOral/Qy1uE89xyUwyEzdeO8SXu2caS+vdxl1Rnl95K1SSgnoThnXacZJ1U
	 1Ak6WwBY9Bw8GAQBc2imL6zN532+pVaN5ApWq7+EaCw7P4o2VhcUPr6KBrU25cxONP
	 tVeV0SA/1QXtnEMbhq1GBgMNcuVkIM3PuNWEqJo9CVel7uOQmx6lxuIgGUvWd0tVXP
	 nHwzCNMuezipA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B839E39D0C1B;
	Sat,  4 Oct 2025 23:42:19 +0000 (UTC)
Subject: Re: [GIT PULL] Char/Misc/IIO driver changes for 6.18-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <aOEpdLwn9jxWmz5l@kroah.com>
References: <aOEpdLwn9jxWmz5l@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <aOEpdLwn9jxWmz5l@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git tags/char-misc-6.18-rc1
X-PR-Tracked-Commit-Id: 22d693e45d4a4513bd99489a4e50b81cc0175b21
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6093a688a07da07808f0122f9aa2a3eed250d853
Message-Id: <175962133838.472872.7329535819402583670.pr-tracker-bot@kernel.org>
Date: Sat, 04 Oct 2025 23:42:18 +0000
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sat, 4 Oct 2025 16:04:36 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git tags/char-misc-6.18-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6093a688a07da07808f0122f9aa2a3eed250d853

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

