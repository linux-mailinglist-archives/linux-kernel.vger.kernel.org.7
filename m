Return-Path: <linux-kernel+bounces-749791-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EDB18B152FE
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 20:43:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 955575A3861
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 18:41:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E17C29AB1B;
	Tue, 29 Jul 2025 18:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I/e3w5gW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB5C828D849;
	Tue, 29 Jul 2025 18:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753814415; cv=none; b=Yu5U0/+gVzN3KxGvamEoeX9btvgNCcN60g8AtWHlRqYaIIBxS66rrqLA6tMLcGo45Hsf6blQcgwN6uMKB7BpPw90ykB0dr24RS4fugB9po+s1KJ1BF6jet4f9BtB3OeLUTf00Z0iiuFrdsAcVO27RL6+pOv+fHqc+feBquR7OJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753814415; c=relaxed/simple;
	bh=mmOwwVRBi8fDFzqmJj9zEcGDFG8iThDID9GPpqWiE3M=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=uhtcxonSKkwFlrjy2LyG3RXF87UEhwDhOa+1maaG8GyHA/2Zv7ruVJIArMKGKBYrkAmDISWSqxToAIVkXOx/29Jrr5dp6bKV/tHFell5ycxc66Q5hY+vs8QMyVOXeYQgryq10Av3XQn3L13AnpQLv1frPvcWv0aqYV18wUK3Gn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I/e3w5gW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF97FC4CEEF;
	Tue, 29 Jul 2025 18:40:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753814415;
	bh=mmOwwVRBi8fDFzqmJj9zEcGDFG8iThDID9GPpqWiE3M=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=I/e3w5gW7Pt9juPHNhu4oQ7B+W67lMtSMyUf427YDLwH01qssGgar4RchmtVEZhNa
	 XxhiSrt+I8BsNNBVinkIr96j/xyEP9Z9fg2pr1KrFU17zQPpoLZnRsp0ueMPRPfmLQ
	 U2Yt/KqescHBMVL7b1ivIeArlkuiY/RD1/AjBgFHdwNpdgUgI/0RHabrjlnfRYXale
	 EI2BjBUMMDyLVc5nmqCkk8jPvtCbvYVFzxohU+iH4wlci9mREEa50osNGjCFDCqAV3
	 diYM3CHhAqXIub6AeO8Q7JT1SCaCEwxLtL+bLUWs3xHCBWQVJTcVD3J0EBKfyLaz8S
	 Z09r6gx9Taz/Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 5830A383BF61;
	Tue, 29 Jul 2025 18:40:33 +0000 (UTC)
Subject: Re: [GIT PULL 0/5] soc: new SoC support for 6.17
From: pr-tracker-bot@kernel.org
In-Reply-To: <66ad07fe-3aa5-496c-8c5b-1b7ed18eb056@app.fastmail.com>
References: <564b7ace-bb5f-430e-a7f1-9f6a41305e10@app.fastmail.com> <66ad07fe-3aa5-496c-8c5b-1b7ed18eb056@app.fastmail.com>
X-PR-Tracked-List-Id: <linux-arm-kernel.lists.infradead.org>
X-PR-Tracked-Message-Id: <66ad07fe-3aa5-496c-8c5b-1b7ed18eb056@app.fastmail.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git tags/soc-newsoc-6.17
X-PR-Tracked-Commit-Id: 05a623030b3cc2250755e4d4d6b1440a03aed674
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4df9c0a2465a523e399e46a8d3b5866c769b381b
Message-Id: <175381443204.1585410.9078207862165751472.pr-tracker-bot@kernel.org>
Date: Tue, 29 Jul 2025 18:40:32 +0000
To: Arnd Bergmann <arnd@arndb.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, soc@lists.linux.dev, linux-arm-kernel@lists.infradead.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sat, 26 Jul 2025 12:31:12 +0200:

> https://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git tags/soc-newsoc-6.17

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4df9c0a2465a523e399e46a8d3b5866c769b381b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

