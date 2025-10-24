Return-Path: <linux-kernel+bounces-869391-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 11513C07C52
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 20:34:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 44A293A47E9
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 18:33:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D5D834AAF0;
	Fri, 24 Oct 2025 18:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="abceeegH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C169C34A78C;
	Fri, 24 Oct 2025 18:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761330806; cv=none; b=ZDE/42i+mcwtS7c1tbAq1qx26qTYobEZu8t/yUSEnRIWjW+S6Q/FVnFENfR9a+3XIWyuQNU7RxY22n66Aca7Qar+oc/yK10kXsifOZYQikHRCJztNTqbKDnhVqXjp+IkVxEYZgDWggakWhdosMjuxr73FJ0aUd17FV/u1rhJb5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761330806; c=relaxed/simple;
	bh=YgowH6Er6UDvDilpV1dhcRswFf65jJbpuxa/tMhKSkw=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=C685/PsfBpyq1ahcuIG5HburxfW8BTVYTux4FRpWZEwBaS4RKEWYwuyaXXqnFfvxRA65+y0wCzb1Pvsi9BSlTK9cBHQJHbRx2MrJURLAGvXCDa6y9fjr/Bo7MrK8e+OWv4x1bpWen8S5r57yMH55A7SleDEnEUwiRPArw0+MGWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=abceeegH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A36CAC4CEF1;
	Fri, 24 Oct 2025 18:33:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761330806;
	bh=YgowH6Er6UDvDilpV1dhcRswFf65jJbpuxa/tMhKSkw=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=abceeegHJyAYfHxFVcgIksAaNQG9andy+rQONbEOHO/gdjn3XL09SA4TdqfEOYGe0
	 u6eGGLWJ4/TmeBcLsgCaLDGfonXPEhw9k0USd3WNOwjBZptQd3EmDIRFCUbauzF3Mb
	 RDGh+U3sUKNK78rwSn0/OredOLp2qYiPwPMvNT9i0pvMEbLg1kBt1GCXeL0f5ZMw+k
	 ykGTCU00e2FjY+J14Ft5KqEHfQCyTj91ABfll1DQTmDqumBJomCPb3gyPd9ctjp5oH
	 uZ4MJzHJIzDJYp4MOnMnBcZB+hoVo+pNGF8bY63GA2flfuP3/VtQtz+QHTs+QqAWn+
	 71CBG3n3rcBRA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADE9F380AA4C;
	Fri, 24 Oct 2025 18:33:07 +0000 (UTC)
Subject: Re: [GIT PULL] hwmon fixes for v6.18-rc3
From: pr-tracker-bot@kernel.org
In-Reply-To: <20251024143704.1144808-1-linux@roeck-us.net>
References: <20251024143704.1144808-1-linux@roeck-us.net>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20251024143704.1144808-1-linux@roeck-us.net>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git hwmon-for-v6.18-rc3
X-PR-Tracked-Commit-Id: 8dcc66ad379ec0642fb281c45ccfd7d2d366e53f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7bd29bf1fda493fd122924b158869a3b43e14887
Message-Id: <176133078632.4023146.4513485263363789083.pr-tracker-bot@kernel.org>
Date: Fri, 24 Oct 2025 18:33:06 +0000
To: Guenter Roeck <linux@roeck-us.net>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 24 Oct 2025 07:37:04 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git hwmon-for-v6.18-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7bd29bf1fda493fd122924b158869a3b43e14887

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

