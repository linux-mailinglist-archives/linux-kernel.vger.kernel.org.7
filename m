Return-Path: <linux-kernel+bounces-759684-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5287B1E115
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 05:59:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB4E05673BA
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 03:59:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2757D1D5AC0;
	Fri,  8 Aug 2025 03:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ATOZTkJn"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 817361C84BD;
	Fri,  8 Aug 2025 03:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754625575; cv=none; b=EZEHzaLyI94Sc7JWPzGKjuLDqpaYUhO2+gjeOCdBaQEm+NR3V5yrvT4d85n/U2sfWxN7DWxowBD4otqReUr8p5cv/METwiyea91hpQwJbXJtwWFXbIibRBKBFvnElWqRTBeCqMIr9luX4psD0R6m7gRjjiZdBd5OAyaU7jWSJqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754625575; c=relaxed/simple;
	bh=I//qqkkeAqFH5kQS6Zl4OQTgherWupMRZ5zHtI3l5Wk=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=cCkADzb67QhxhLSO9JTksAecQunhMeIaRd9jGpX/NdXlD9zwQZrw8NCHXtAlzuP3SFJ/DmZ1YSHmGWAnUJQLCovm7QoEUjIuu9x6fzfImfe26Q2oHBMayDpkCzRIYG+SNQ/c7TACcfJyYSM5xiDCLa3255oXznGOWMpejw5YjwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ATOZTkJn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 547D1C4CEF0;
	Fri,  8 Aug 2025 03:59:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754625575;
	bh=I//qqkkeAqFH5kQS6Zl4OQTgherWupMRZ5zHtI3l5Wk=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=ATOZTkJnXdQf5v6JlXQL77b4dgpAoiJQGAvCkw2Fe9vfbUGi2AcajSg6bTChHNhHQ
	 stqCd8SLPUyXUod04oMekc3QcrjZkWALJcVGD4Hr/Xvm1Tgz7e1AUVoX2A9jX0Fk28
	 JbN+/snmOsSKnWMf6GY5MZkvz06sZLXytUIMJZtp2fWopOyHdb7sUHE+5Xl6ZQZ+dI
	 CLhHMfPlzo7TOW66tULs+IFBYbmF9D2jTkMqbmsJuP24WQyyaneS59wyclF6z2U9nv
	 ZWU+6vDq+TUZl14NHv/6jr1DeHPrBp9hfMKBBc2WOOMDCIYlcWAkUyxVF3Q0pC+k5n
	 cylDY0pJoC1wQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EADC1383BF4E;
	Fri,  8 Aug 2025 03:59:49 +0000 (UTC)
Subject: Re: [GIT PULL] LoongArch changes for v6.17
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250807083051.178877-1-chenhuacai@loongson.cn>
References: <20250807083051.178877-1-chenhuacai@loongson.cn>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20250807083051.178877-1-chenhuacai@loongson.cn>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/chenhuacai/linux-loongson.git tags/loongarch-6.17
X-PR-Tracked-Commit-Id: d35ec48fa6c8fe0cfa4a03155109fec7677911d4
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 83affacd18cc225f538e532c6e667d26b3ec69fd
Message-Id: <175462558844.3795225.7100911394873215243.pr-tracker-bot@kernel.org>
Date: Fri, 08 Aug 2025 03:59:48 +0000
To: Huacai Chen <chenhuacai@loongson.cn>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Huacai Chen <chenhuacai@kernel.org>, loongarch@lists.linux.dev, linux-kernel@vger.kernel.org, Guo Ren <guoren@kernel.org>, Xuerui Wang <kernel@xen0n.name>, Jiaxun Yang <jiaxun.yang@flygoat.com>, Huacai Chen <chenhuacai@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Thu,  7 Aug 2025 16:30:50 +0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/chenhuacai/linux-loongson.git tags/loongarch-6.17

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/83affacd18cc225f538e532c6e667d26b3ec69fd

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

