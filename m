Return-Path: <linux-kernel+bounces-870476-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 15187C0AE59
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Oct 2025 18:01:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A2D7F349B6D
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Oct 2025 17:01:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4801B2F0C49;
	Sun, 26 Oct 2025 17:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RCbfuzIz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5CA7248886
	for <linux-kernel@vger.kernel.org>; Sun, 26 Oct 2025 17:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761498053; cv=none; b=bM8h6B8q0z72K55vZlzvjtFPgoiQLQ/XKNU1KyqQ0O6ronMdNB5x8iQRcahsTUQd8a6NsM6eojBuAI7axyXR7sy6YvLm9eYSpsvkmZYXs2IHgpgx2VgI5bXEYPDRU5RsuSFK2yH2La+lIusTTx+2bhDFukBo8bOUoZhH+BNeJ+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761498053; c=relaxed/simple;
	bh=4XCBpPL3oGTRmtI8t5+2yJFiAewi3gyDTKtkn5tnjsw=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=d1ruMv1VOMX+IlSQb+u2G5Qt4oxbJOjiqHVsvxWoTaXlLuFlKqj5FxNhS5LGhaZwZilu7DINLG0o1EF2xVl/docBZHbAURoXVWVI2f3f2M7lvL/jc4igyccT9Z34EsNpC5HKlARs5BU46WkQVjTfIxSI60V1kDjJWV231b8I5W8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RCbfuzIz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CA87C4CEE7;
	Sun, 26 Oct 2025 17:00:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761498053;
	bh=4XCBpPL3oGTRmtI8t5+2yJFiAewi3gyDTKtkn5tnjsw=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=RCbfuzIzHCHcxC9mNIS9R9OZPWKxcjD2+2cKOflfhKG/05I3OHn4INWCHdsRERxEZ
	 N/iMPAeMUS8ITPbo47M2UW6bPnulCB2QMXOTFW0S0iHZgNKujgDnPFIvIiF1FpvgQ7
	 TuF47tfP1BZ+3cagtNMw5vSuS71mGmSKO7Ma2uLB+YhxEqnWjhrRogDBv6hTasjO7i
	 29IbqUFXd0hHrOcEf0vyCDOOqnPuVcoNVoY1Ryyy47Wf+LekMNRpIRXNm4EC4D8lcQ
	 F7ZY1Dr4q1xZuR6lVT/BtXnS9mrkilc4faw03OhK8RAvySrpsth0k9yCKIl12ylLUm
	 fKyNnCX/Uxp8A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33B30380AA7E;
	Sun, 26 Oct 2025 17:00:33 +0000 (UTC)
Subject: Re: [GIT PULL] x86/urgent for v6.18-rc3
From: pr-tracker-bot@kernel.org
In-Reply-To: <20251026123417.GAaP4VSVbDKBgjZ9GJ@fat_crate.local>
References: <20251026123417.GAaP4VSVbDKBgjZ9GJ@fat_crate.local>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20251026123417.GAaP4VSVbDKBgjZ9GJ@fat_crate.local>
X-PR-Tracked-Remote: ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/tip/tip tags/x86_urgent_for_v6.18_rc3
X-PR-Tracked-Commit-Id: 84dfce65a7ae7b11c7b13285a1b23e9a94ad37b7
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: dbfc6422a34d6cb28e5c0432af309b24f66ef27e
Message-Id: <176149803176.292745.7955545903038266725.pr-tracker-bot@kernel.org>
Date: Sun, 26 Oct 2025 17:00:31 +0000
To: Borislav Petkov <bp@alien8.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sun, 26 Oct 2025 13:34:17 +0100:

> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/tip/tip tags/x86_urgent_for_v6.18_rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/dbfc6422a34d6cb28e5c0432af309b24f66ef27e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

