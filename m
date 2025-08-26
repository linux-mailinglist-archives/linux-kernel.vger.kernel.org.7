Return-Path: <linux-kernel+bounces-785811-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C0DBB3515A
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 04:02:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 92DBC7AF38E
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 02:01:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE3B021ADCB;
	Tue, 26 Aug 2025 02:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A1oqFSSZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1357D1FBEBE;
	Tue, 26 Aug 2025 02:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756173759; cv=none; b=ZyKhHM77LP1nXJla0Rn2qtQEOQQrz7isSMee6VeyD8hR3QLfyHqT0FxGjwogheWmOezBJ0gUcycbzxtF2MrVY8Z6ZQh3GYMOKT1WZHBv2n2YSr/MnObfnW7fbfi11DFunAxTN5i6O4MFYmPgvnjSq1EqWf8Z09bHJbyi0ENkgUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756173759; c=relaxed/simple;
	bh=muXgQEpsb6bw/DTcaEzgoJ4ui6A05ZjVvpHHGLJV4Bk=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=DcMraWG5lMnSMGDIQAeCuxG/pRSHdLIhe7ypCwDOqRCKMXb+iEBdvhbYtjvi8QJlOl7KIaIoIqNLD6Ro+DMQjFs83tUhh2v7em3Jedib8lu0/ZCeb1ljyGWpoHJ+ph+mUcBFbTaqgS1dO2bEScmPh1T5Ca6xE1ldSF0XLKAqLCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A1oqFSSZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97D62C4CEF1;
	Tue, 26 Aug 2025 02:02:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756173758;
	bh=muXgQEpsb6bw/DTcaEzgoJ4ui6A05ZjVvpHHGLJV4Bk=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=A1oqFSSZ712nwSngpOSXgql5FscEbkkm3Ol+QvMEKpg4Sw+ByThWsFWIE0N9bkAMI
	 K+NJTk/kn9oI4F1aKZmYyGaK1tMBeswhlKyCh2gbkiNacYwqXhQPPBonX8LT5FYwMB
	 A/eCn6COCZBhtoifrLGmkXMwu2JyDHGLzcOhJwc9A5n9IYBupJiYM9n+zHw4xAnVq0
	 GXBB67VNO66Qlvk+tJne7XCoOubj257Uu6tHOl5RjkKPf6lGx7FkEfojxZ8/AfdKCu
	 lspMmkUlY1DolLVhDadUgtoKyvwNKs/fgiOxWi+ZBGN0rtrfx4p5dI5TEs4hNVXjLM
	 jc7st1ObODSwA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADF56383BF70;
	Tue, 26 Aug 2025 02:02:47 +0000 (UTC)
Subject: Re: [GIT PULL] Devicetree fixes for v6.17, part 1
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250825203521.GA399593-robh@kernel.org>
References: <20250825203521.GA399593-robh@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20250825203521.GA399593-robh@kernel.org>
X-PR-Tracked-Remote: ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/robh/linux.git tags/devicetree-fixes-for-6.17-1
X-PR-Tracked-Commit-Id: 80af3745ca465c6c47e833c1902004a7fa944f37
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: fab1beda7597fac1cecc01707d55eadb6bbe773c
Message-Id: <175617376629.3625474.2877908258292778978.pr-tracker-bot@kernel.org>
Date: Tue, 26 Aug 2025 02:02:46 +0000
To: Rob Herring <robh@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Saravana Kannan <saravanak@google.com>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 25 Aug 2025 15:35:21 -0500:

> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/robh/linux.git tags/devicetree-fixes-for-6.17-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/fab1beda7597fac1cecc01707d55eadb6bbe773c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

