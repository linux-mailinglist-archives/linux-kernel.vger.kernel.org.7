Return-Path: <linux-kernel+bounces-760974-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 623DDB1F25E
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Aug 2025 07:45:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BFB92727481
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Aug 2025 05:45:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 930DC279DCB;
	Sat,  9 Aug 2025 05:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JSHcrX6S"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2262279DAB
	for <linux-kernel@vger.kernel.org>; Sat,  9 Aug 2025 05:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754718330; cv=none; b=A7nNkiXyvlTbSN6ZaBORAMEylfVfTwynLrTFAWaROJhDsb6yXo8PKiaT0MMlShyIBXvt6yQ6ifE+mf8t6Acdpq+kEy12eEU7a35h7K1GGOV2fi6q/tVql3yVbZY/Bf/8h6A1VGrkNUzQ61HWyH0GuvnfJ4a6u0ngAMnqtCExeK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754718330; c=relaxed/simple;
	bh=eLAzdHieEoogHyzEwk0GZhjempd1T7FykoxH6BPniPs=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=olNlCbyawf/PqWOZI6Jdeit7AuOeOfviL2SMC/KpL7dpzkXv7PxuN9BB3twwdBNWcS33Hh3n49wPWCHbtxj7d7uu/FSR6WTEwvRNxPEiIa46/BDFKWNW4EqD4OOYWfjOAlt+AnvpaUeCReraRYndCuzdbiJ48xzIkY/dneSXdVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JSHcrX6S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1BF0C4CEE7;
	Sat,  9 Aug 2025 05:45:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754718329;
	bh=eLAzdHieEoogHyzEwk0GZhjempd1T7FykoxH6BPniPs=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=JSHcrX6Sz9csaXIThhY6Ckc3L4ImBTq0fkKivL4DcgpAi19xPAW7XwS2A0LjJXyX+
	 KA+DhdQY/46xdcPOuZAEf5kXUbXHFqPJniAf7PV9rU/zMgETJDD9qUyjiFURoivfiT
	 VWVxkuPuEXZVDD6QPMlWMDfJIp4wGUfHlG/oj9LoE2sohtx5//D19qhxRvJla6Di6n
	 t/kzRYpqiAmXoUNZ0d0kt3klpOQ2VTI6DENQuThFUVKVufNRVB8YOMyFVksD417imi
	 WUF3OldMv9FiFrvrtaBRIqbVgc6q3Qdj7PNMZOGs1QRG3apvJ1V/koz0T9fz60m2si
	 bnlT+DC1RnvPA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 339E6383BF5A;
	Sat,  9 Aug 2025 05:45:44 +0000 (UTC)
Subject: Re: [GIT PULL] regulator fixes for v6.17-merge-window
From: pr-tracker-bot@kernel.org
In-Reply-To: <c52bdf1f3fbc97fe64dbfbb27d34749c.broonie@kernel.org>
References: <c52bdf1f3fbc97fe64dbfbb27d34749c.broonie@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <c52bdf1f3fbc97fe64dbfbb27d34749c.broonie@kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git tags/regulator-fix-v6.17-merge-window
X-PR-Tracked-Commit-Id: 10dfd36f078423c51602a9a21ed85e8e6c947a00
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c5bf33d778e8744d081c51061753a8a313d247d0
Message-Id: <175471834281.387690.6466683202519926830.pr-tracker-bot@kernel.org>
Date: Sat, 09 Aug 2025 05:45:42 +0000
To: Mark Brown <broonie@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 08 Aug 2025 18:02:12 +0100:

> https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git tags/regulator-fix-v6.17-merge-window

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c5bf33d778e8744d081c51061753a8a313d247d0

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

