Return-Path: <linux-kernel+bounces-759687-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 19892B1E11D
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 06:00:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9AC6E18A27CA
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 04:00:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC8301EBFE0;
	Fri,  8 Aug 2025 03:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RJX95aIK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 482F91EB5CE
	for <linux-kernel@vger.kernel.org>; Fri,  8 Aug 2025 03:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754625582; cv=none; b=Ok+BYauPbI5WFVQb8snZod1RABFMDkvSuzxFuiJgC+POCIk2ldBektjQAVmLXDQHTHnqYuWxR3wrF4Ps+IkiGiv9ToPprE2CHNdF0f6YPjXxdUDeMT2wtP3xd0i1gUgrgTqWKSZTpSLLFGNZwBFfBoIcYts4+uevmk8etlVuhNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754625582; c=relaxed/simple;
	bh=L1kQNAcrEiTkhHM59UBygYJRSCCClLOHT+KdApx6+8g=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=Z5xXGQlztm9wL9P/JA6wXtNECslVOSY2GQcPahtHZKdwYYa6Gj94WBKGsacQ4QE2EMcFSY+st+xwXRTVDMgYGbmQ0N8sTLglpUJodz3JPltA/gHy9Zo7uQJMwMULocoWr/AlkG2mwGaSZLislySr8htywH1NgzWGx5+tsfPDe+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RJX95aIK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 265ACC4CEF0;
	Fri,  8 Aug 2025 03:59:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754625582;
	bh=L1kQNAcrEiTkhHM59UBygYJRSCCClLOHT+KdApx6+8g=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=RJX95aIKujn4G2BM+XglZAYnZBCc4oWbqnWDm7+E+9fl3gD/MUb/wqiFz5bW7/NuV
	 di2KB3FPWYL5OJt8mHlGjmd2iZI5SFRU/DX9GC1qDnM9EwqSCVgLmO5/uAAUldjosL
	 90w3ceUqq03zvI8L/rbfaGQRO6thAIggfG6GvM42c3GW7nzwdNkmZA6Cu9fOwSyL5s
	 C0zTcqsUvtX5cwAM7sDktRpEWZ5tknN5H7GZPN6JWmjlLsp/XMVi/shK0GHe7nQKPC
	 lBNS7cyaszO6J6stjIzm97hgpsp8tlBbenCP5Q4AHoMbua+tsS6cUfwgOAWYmQs7rm
	 gbUXokrX2byeQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADCED383BF4E;
	Fri,  8 Aug 2025 03:59:56 +0000 (UTC)
Subject: Re: [git pull] drm fixes for 6.17-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAPM=9tzJAoCXiwvR6tpSv5QctkKu+JAbKZBEbM+M+z+fZOkAOw@mail.gmail.com>
References: <CAPM=9tzJAoCXiwvR6tpSv5QctkKu+JAbKZBEbM+M+z+fZOkAOw@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAPM=9tzJAoCXiwvR6tpSv5QctkKu+JAbKZBEbM+M+z+fZOkAOw@mail.gmail.com>
X-PR-Tracked-Remote: https://gitlab.freedesktop.org/drm/kernel.git tags/drm-next-2025-08-08
X-PR-Tracked-Commit-Id: 64c627519474e687b876e6e50cc28ece16d10564
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ffe8ac927d935d7d4a0bd9ac94afd705df79982b
Message-Id: <175462559517.3795225.5128155180686267196.pr-tracker-bot@kernel.org>
Date: Fri, 08 Aug 2025 03:59:55 +0000
To: Dave Airlie <airlied@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Simona Vetter <simona@ffwll.ch>, dri-devel <dri-devel@lists.freedesktop.org>, LKML <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 8 Aug 2025 10:16:27 +1000:

> https://gitlab.freedesktop.org/drm/kernel.git tags/drm-next-2025-08-08

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ffe8ac927d935d7d4a0bd9ac94afd705df79982b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

