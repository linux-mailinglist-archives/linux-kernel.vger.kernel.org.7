Return-Path: <linux-kernel+bounces-749795-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C2DEB152FB
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 20:42:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1CE2E7B2742
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 18:41:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B447529B8DC;
	Tue, 29 Jul 2025 18:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KU6vORVw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2273729B796;
	Tue, 29 Jul 2025 18:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753814437; cv=none; b=NP5Gq9+5Xwj8aM+PrBqPOov8EDvYoR7LU1dCIRYLBL37Sb7c2wFWe0bePP+B75eCPf7E6evfdY2XPFSGuu3/w223zTn13QTu7gEPpAnEOPS/BD0IFErk9hlrG/6QRG/jrWN9/6aW+ZAtx8K07gyhH61eNmXTppr+j7i0L7eemm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753814437; c=relaxed/simple;
	bh=pS5xH3j3fsbdol9Uykcid7GW7Z1pqZjbU7/mcQmwSR8=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=QoKb/EM6E7SXWpohuIqFGzmkecK3jjOhuBmQVJd7Lz9vr+d0WP+6t75zy/BFYgXEPbyGEByLTiyb/7Mx2TGATEbJVwf3urqZGfI+QJnKDSASp+9mfCPFf08kecESyZz3hqzsdTqicRc1FxaESNCssIBPotF/3eMEqYYHIKjkPWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KU6vORVw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07221C4CEF9;
	Tue, 29 Jul 2025 18:40:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753814437;
	bh=pS5xH3j3fsbdol9Uykcid7GW7Z1pqZjbU7/mcQmwSR8=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=KU6vORVwn+FDoF5yit05LmOVuBoKzuen2+jBsmIDzfM1bI4Xc1VJQt2Ja1WntFHxW
	 E/K0qNXqHOLo9sflZvDZX3Pod1KZ6nsvzWF7AncSUXruEYK7pwM/fpj1RhIHT1wlTd
	 lWYGNjjX1/5GCGzTK1N40Fe93sXZhfXKG6GyUTbMXy8RWZGXXDA5hKjzu8IkTi63NO
	 5tQzulP0HJtBvn94Cn/1fOOJvv6wpBu0JWIgIJpY7X1Qu2u9rxfpbCS8pocbhLeNM1
	 Pir1fRLzSxAJ9WRrwRo+3a9WEvTkRZP4jbwc0kLhS1UKAp9z3ckZvaTdwYPhebPDS9
	 n257sB9KWDwcg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 8A2A3383BF61;
	Tue, 29 Jul 2025 18:40:54 +0000 (UTC)
Subject: Re: [GIT PULL] Staging driver updates for 6.17-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <aIeamUo74ht2d9Ls@kroah.com>
References: <aIeamUo74ht2d9Ls@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <aIeamUo74ht2d9Ls@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git tags/staging-6.17-rc1
X-PR-Tracked-Commit-Id: 63533ba19d0f325f8e36cc5aae73281a93758618
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1641684528815bb7e85737d5d2bceb551c55d5a8
Message-Id: <175381445350.1585410.1856642405065798283.pr-tracker-bot@kernel.org>
Date: Tue, 29 Jul 2025 18:40:53 +0000
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Stephen Rothwell <sfr@canb.auug.org.au>, linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 28 Jul 2025 17:43:21 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git tags/staging-6.17-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1641684528815bb7e85737d5d2bceb551c55d5a8

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

