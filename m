Return-Path: <linux-kernel+bounces-839454-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7C62BB1A5E
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 21:51:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AA4C07A39D6
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 19:49:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6066526FA70;
	Wed,  1 Oct 2025 19:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gi8na8j+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB9CD1DED63
	for <linux-kernel@vger.kernel.org>; Wed,  1 Oct 2025 19:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759348276; cv=none; b=ILxNeo8B+b3Z1jUJ51LchYs55RnjlIoS2pgMXLIJ/I7AXzlJ67UdshO1syZh20Mv4IlFRx83Jg03MJMQCUU0GJyQF6r/NG2cRA72wzo90E9EzQfdfRaImvpU7y6R76mzKVoiT7Syrx5RhfqrApbN6VCdqIWenQ/1xB+xkE6ndRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759348276; c=relaxed/simple;
	bh=W8VDOHnMN1UNb1v3JmDfQrLtjTMv5xtcJ8k/x/mubj4=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=DTpcJaWXbpIbDy5FddqXfYVkcDBHI3fIMT40Vh/Pki3Plu+A9AVK8l4HH0/iOOFdxdbiuLZqAJwY0JRH+ndcQCKSOGycKryTgNvHI52hEBoJ3AZpqAOPKaPdRfmHXDweUuM2dOXdlkC4iCVxmTe3M9IMoBpkkzVjzLn65dIC/rA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gi8na8j+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D6BFC4CEF1;
	Wed,  1 Oct 2025 19:51:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759348276;
	bh=W8VDOHnMN1UNb1v3JmDfQrLtjTMv5xtcJ8k/x/mubj4=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=gi8na8j+r5IvU8R6CEpTuNOfZnTikpxtmIrVsGwqvW6U+nCE4TrzPCpkTCm1qldGf
	 /yrcjYEPF5Bc1FSjzMVnTgXopCFK8an7Dgo9yRvROY7SajZRBwgYGtejqMrWeG3oA+
	 APa+IGOqNxCg8xRZ9jnuijlZZt6fq/OiY5+W+/FiEBxLC4867VbTQVKt3kCrmxqEtT
	 TpjXfek/GW4BPESO/ScaWg7wLTMmHNdwksuC+yREvCDe+4uebJMPYhJKWrVMSwumvB
	 eAYS0jxzEvO0RzaCZXO42pMO7xMfagZyqbUQY9GQLo8ljQQdBad+oHKhQbDS2TPMUS
	 PMKvnkrZzqSBg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33F0439D0C3F;
	Wed,  1 Oct 2025 19:51:10 +0000 (UTC)
Subject: Re: [GIT PULL] MFD for v6.18
From: pr-tracker-bot@kernel.org
In-Reply-To: <20251001135934.GU8757@google.com>
References: <20251001135934.GU8757@google.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20251001135934.GU8757@google.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git tags/mfd-next-6.18
X-PR-Tracked-Commit-Id: b9d6cfe2ae699bbf230a6c8e0e32212b04bff661
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b4918003cf54f99004c136c26f96b6df7ab49fac
Message-Id: <175934826881.2595637.5805817369005562106.pr-tracker-bot@kernel.org>
Date: Wed, 01 Oct 2025 19:51:08 +0000
To: Lee Jones <lee@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Wed, 1 Oct 2025 14:59:34 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git tags/mfd-next-6.18

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b4918003cf54f99004c136c26f96b6df7ab49fac

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

