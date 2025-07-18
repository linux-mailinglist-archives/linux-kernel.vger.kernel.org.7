Return-Path: <linux-kernel+bounces-737290-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F6BBB0AA56
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 20:50:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E798F5A25BF
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 18:50:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D36FE2E92C4;
	Fri, 18 Jul 2025 18:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Uh8hgJNb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 414422E7F36
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 18:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752864594; cv=none; b=gjy8S1pWM0l5vq3ZBCx/Uyzn7sQtA8DaobMfreEY95cT1QLqldj8YkKqkas5NukDYsCiskiiwWMgu/+zJF+zPS4le7NVkR7GbEKM3umUeGKsF0ObiH92SNmy/Ob+GMidym21sw4wKWR1brYPCo9ohNX6OqG4ZDYkyWfGOryw4Rc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752864594; c=relaxed/simple;
	bh=TKPEzWfHcLOpUmkY0TCl3wmEWTZdibxEZqPBSBNKTD4=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=WT/9xePTBNboNgSagHEqVUq/xqjx3rFu5Qkf/rcdnU9qXdXd+ezRgrBAL6KVNgkrg5m2pK1XzsIiXob+tnsbiYI5uSZr/SUg7GPhliD6QQQDV0Ul28fM3M8uXT3kwwkaMsJN2E6zVpxJfNnvS5AxG7wTeAAxP8JJ6N8VZXLLMhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Uh8hgJNb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B3F4C4CEEB;
	Fri, 18 Jul 2025 18:49:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752864594;
	bh=TKPEzWfHcLOpUmkY0TCl3wmEWTZdibxEZqPBSBNKTD4=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=Uh8hgJNb4zkaAOZRV0DUCubYc3KzSpBTm38+qZxM85wqXrdX733+Lha+L4hVdzoeG
	 BdtcfDZ/x4CR9N2QuRiVJ/M2+lUWgLDuWaV+gx5LFUkrSG0JViyBS73T8jn/WOb1l+
	 RM8B3VtklG4Ql/7EYZVGAN75EKuhUsYsHhKGAdEoL1AE5GfbNiS8AGdgfmRhFqU2FB
	 fH6FmPNo0GRPQP9CyHtbtWX/Y7zh32U1sKegKDMpfwg6gcnhbn46BjUWmZHva4BxLT
	 kBLR8m6e8vb1YIty9cgFyBDQcnz/H9HVKnfxJ5yKQQ49+PjS0d4Ezcrb4FS49cC6+B
	 JeJgMbXfGtbxw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAEB7383BA3C;
	Fri, 18 Jul 2025 18:50:14 +0000 (UTC)
Subject: Re: [GIT PULL]: soundwire fixes for v6.16
From: pr-tracker-bot@kernel.org
In-Reply-To: <aHnyvOQxBkGTGpXF@vaman>
References: <aHnyvOQxBkGTGpXF@vaman>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <aHnyvOQxBkGTGpXF@vaman>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/soundwire.git tags/soundwire-6.16-fixes
X-PR-Tracked-Commit-Id: 834bce6a715ae9a9c4dce7892454a19adf22b013
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e1da8eb20a06c71022252754ce6c20de9fcdbbeb
Message-Id: <175286461353.2758519.14228101306275843918.pr-tracker-bot@kernel.org>
Date: Fri, 18 Jul 2025 18:50:13 +0000
To: Vinod Koul <vkoul@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 18 Jul 2025 12:37:40 +0530:

> git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/soundwire.git tags/soundwire-6.16-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e1da8eb20a06c71022252754ce6c20de9fcdbbeb

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

