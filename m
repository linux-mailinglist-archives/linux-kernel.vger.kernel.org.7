Return-Path: <linux-kernel+bounces-823324-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D52BB86207
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 18:53:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4284754789C
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 16:53:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E3672571AD;
	Thu, 18 Sep 2025 16:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YWyxlZiD"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72CA6256C7E
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 16:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758214289; cv=none; b=mIkFcPUslT1E8GL6wYKzBRI/L904+LVyzSXRWOykXBCf6qaVNs+dunMg8iRZ49Gaq9w0yk1VrYmUeWMBxrvI2jEIqOcq7lEWNLODX7DhQCspAx7Fd+LhExNcjKCoZ4hLD7sIOwtcmStqkOy2B38eaLr7D0FcVoZedTOV6jBenoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758214289; c=relaxed/simple;
	bh=yp8L8OFoCDjm8nPw/36nCqPVec7FhsvIlFISIRupVi0=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=a+c0CbSGkbrXXBXri3LrbCDIf8AqApe21vmTKbzWk8m/d6+RvEW0KMWs67+xRtq8lpBsR4zBNvNdFGSvmoAg0lGlvyXiV+irLn4ai6M2IhZyzwId8ZeDSRILYrhLNFKt2vgZLCGf2LW3JHYDBSV5oGgQQQijG9hd8XaI9fsgdc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YWyxlZiD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3747C4CEE7;
	Thu, 18 Sep 2025 16:51:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758214288;
	bh=yp8L8OFoCDjm8nPw/36nCqPVec7FhsvIlFISIRupVi0=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=YWyxlZiDde0/WKvsoDHkks4vgiC64/y67EDOEob0lVOZUwfVgwvc22FfsCu4tNuWW
	 wiHuqk/TsC118dTi8jYUh5NBNDiNyMWbmvZutKLMkazz7QttADafyhMYTxvFZ4I0Hj
	 c59hV8e+x+J7cGGxfszp1jm0ikRG3fhv9iVhcrJCm6jbGVqyCSQRpxBi4E+0I6sz8C
	 /MDfMeE7YaxYj8d5ULIv9Pz4HWRlmlqW9s8YSTpVxa47Hh38C/VwmMCYokauxKeO6X
	 8TvrWXC4I0gPji5G9MNCKY+n8jiVYprVyJEoy3Uq+O8BHaaVNINYocdP1oXrVx0IcA
	 E6nvYxxON3Ugg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33CCE39D0C20;
	Thu, 18 Sep 2025 16:51:30 +0000 (UTC)
Subject: Re: [GIT PULL] uml-for-6.17-rc7
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250918082219.6652-3-johannes@sipsolutions.net>
References: <20250918082219.6652-3-johannes@sipsolutions.net>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20250918082219.6652-3-johannes@sipsolutions.net>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/uml/linux.git tags/uml-for-6.17-rc7
X-PR-Tracked-Commit-Id: df447a3b4a4b961c9979b4b3ffb74317394b9b40
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f03e578c8afe514c82ec9bd9af548b8fe08694e5
Message-Id: <175821428869.2499383.4059485629785074863.pr-tracker-bot@kernel.org>
Date: Thu, 18 Sep 2025 16:51:28 +0000
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-um@lists.infradead.org, Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 18 Sep 2025 10:20:47 +0200:

> https://git.kernel.org/pub/scm/linux/kernel/git/uml/linux.git tags/uml-for-6.17-rc7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f03e578c8afe514c82ec9bd9af548b8fe08694e5

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

