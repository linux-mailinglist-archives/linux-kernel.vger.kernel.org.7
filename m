Return-Path: <linux-kernel+bounces-737861-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C9F9FB0B15A
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Jul 2025 20:29:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A1DD41895023
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Jul 2025 18:29:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B04E23D2A9;
	Sat, 19 Jul 2025 18:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R+QhHYkx"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 846F7288C2D;
	Sat, 19 Jul 2025 18:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752949738; cv=none; b=ryyVdDK7q589zcix3BJAw4SDmiI6dfwe6Ic3xsLSBENYtCRtQOcpD8ljZ0remQ2Zk9QREdGg4T3re6iyFvzcD1oQxD5Tc/qakPrZeqvOlOpTFgtqQS4frDkYY3WTeTN0HJBkzDFpnFFWmjH5huJaawaVjKldixIrADki4Qbs5mU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752949738; c=relaxed/simple;
	bh=8z8SuAG3pzdbepAJaKKYhzvSjRLzWrxmlFDerjSnqGw=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=gK7ACUcL/mhvzO4VyrUYYQdGVhjqxsOm5N7vmYdVMHpyyfYDVznVw3F1rfgjP5tDWzoAtDx/Fh+SoWo6oK4w1QaJqAj19LEfMYEP/cQwtGtTsWFxaPokHH7xozV4rR42oGMyWZXUhCgIX2oVx3YBjcqoa5xIOS7czq5NrV6N3Js=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R+QhHYkx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23EE0C4CEF9;
	Sat, 19 Jul 2025 18:28:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752949738;
	bh=8z8SuAG3pzdbepAJaKKYhzvSjRLzWrxmlFDerjSnqGw=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=R+QhHYkxdAOiMrcx0UvjuKBFvPFWue8rkk4lN2mzh+UVaUwE0PZ3EveBUsrbU/kmU
	 EyhR0tEDFuorkM+A9kNF0oOnTJoVtEtrC7mOUMwvqpEmLIzdF8AoYoqS+de1pUhDmE
	 TP8hhSEFw4wlLnO8fJF13/RL5E03nwlBmT3TGhV9dt53lTgUDJjUI6Ixl3fsses96t
	 ExaBOpwz7kbZTB/I1EwAOkSdBYuESKtn71xO8F7heHOk0cldI6EcwxzzR2+Sjb9yTm
	 jXVJgHgX2fT9dVVqTJQLnMIcFrEozvtsu/3fkNos5C8ZrOFmcwrnQoEMiE8qWhzxUY
	 hlHP7jS+aw5Sg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADD47383BAC1;
	Sat, 19 Jul 2025 18:29:18 +0000 (UTC)
Subject: Re: [GIT PULL] hwmon fixes for v6.16-rc7
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250719142908.4071985-1-linux@roeck-us.net>
References: <20250719142908.4071985-1-linux@roeck-us.net>
X-PR-Tracked-List-Id: <linux-hwmon.vger.kernel.org>
X-PR-Tracked-Message-Id: <20250719142908.4071985-1-linux@roeck-us.net>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git hwmon-for-v6.16-rc7
X-PR-Tracked-Commit-Id: ce3cf7c8a17478456f502cb2facd6660e519ead3
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: bd4a1567b6e3454eda1113ed3a537119208e9c7a
Message-Id: <175294975722.3026904.16808276858882183830.pr-tracker-bot@kernel.org>
Date: Sat, 19 Jul 2025 18:29:17 +0000
To: Guenter Roeck <linux@roeck-us.net>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sat, 19 Jul 2025 07:29:08 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git hwmon-for-v6.16-rc7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/bd4a1567b6e3454eda1113ed3a537119208e9c7a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

