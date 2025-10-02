Return-Path: <linux-kernel+bounces-839719-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E22ABB23B6
	for <lists+linux-kernel@lfdr.de>; Thu, 02 Oct 2025 03:12:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD11F1883836
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Oct 2025 01:12:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F1391C6FEC;
	Thu,  2 Oct 2025 01:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hd7+oDVg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A522A1B043A;
	Thu,  2 Oct 2025 01:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759367456; cv=none; b=S0qHATtlGFBXhSLNTC7sfmv3Y8eG1Okf8ZHlI3iOrxQIRZ2zHoq/dTi8XtLnshhd4Xw/OJugEUEIQaXlXkBBYTv3C7XDRN3TfNzz0WRyeXSA+0sB68ErsZeLI9Px4mbS3UTftqICza+g8OjFzenZK15CYMgB42vavJ3ue2g9lBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759367456; c=relaxed/simple;
	bh=Y/7dbKf2OvpkEFPMcVMfrEZFYDZv5zW/ZOeH+9CWmTo=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=Gh6Ho7ZuKGIAhvngx9GT8IJYpJOfNPnl1RltytwSu5+MnWqM91yQaRUjqWbhEPM2JBiMDv3IVrRvVE+ywcPk6xHC5yQVnsI7Gek0remisIVKrBaefXFRggm3OHPoNMPYrNzYfNNRWRM8E9sVfGMBZA70Tr7bs7vDgyyEeu6JXCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hd7+oDVg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8595EC4CEF1;
	Thu,  2 Oct 2025 01:10:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759367456;
	bh=Y/7dbKf2OvpkEFPMcVMfrEZFYDZv5zW/ZOeH+9CWmTo=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=Hd7+oDVgN6MG+76+mX5A3WUHE+2/L2Fv2uWzi38jo3jCDL1V1geriPobvrurW2y8N
	 boTVpSSgz8wez5icbZOJ1HIQRDXb/uVVaO2nw+RMpVRwebSXEyedKut+ehgOq560fp
	 3f4Q1G/wC6Gubis8GFd3Lm+1E0P30TccmRvP2ZT/CZ+HOv1KKti6EveVtoOxvlk4oU
	 1tZmzTwvkf6Q8sllIydPFSCjOWKGsEgQYxBGxRlnO/e1WsKB9p9Ctba7WxMoNvUG5/
	 8Y1t5SqIrFQ/2HEIc4nph9vDRlO/RVc/k23C+H+Do3LfBuvnswx36W28e6CHt/njo/
	 PpN03jt2+3DAw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 270B939EF947;
	Thu,  2 Oct 2025 01:10:50 +0000 (UTC)
Subject: Re: [GIT PULL] Devicetree updates for v6.18
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250929181601.GA345627-robh@kernel.org>
References: <20250929181601.GA345627-robh@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20250929181601.GA345627-robh@kernel.org>
X-PR-Tracked-Remote: ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/robh/linux.git tags/devicetree-for-6.18
X-PR-Tracked-Commit-Id: 129b91fc329604e05f794dc1a18a6da3eb518b4e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9792d660a4e91d31a6b1af105ae3f1c29107e94b
Message-Id: <175936744875.2689671.14593389321955184162.pr-tracker-bot@kernel.org>
Date: Thu, 02 Oct 2025 01:10:48 +0000
To: Rob Herring <robh@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Saravana Kannan <saravanak@google.com>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 29 Sep 2025 13:16:01 -0500:

> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/robh/linux.git tags/devicetree-for-6.18

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9792d660a4e91d31a6b1af105ae3f1c29107e94b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

