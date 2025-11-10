Return-Path: <linux-kernel+bounces-894339-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 39D89C49C77
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 00:38:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A20CE188C6A9
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 23:38:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CF613081AD;
	Mon, 10 Nov 2025 23:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PX8Hu+fS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02D5930748C
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 23:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762817874; cv=none; b=HinKS6SXBZzfI0kp/OeHr3EIAAtI6jlcLirl/TYvb5Jpcr8EvFP8KGIAj01w73W74QIhprE1ickQcxl1zI3RbkiZIn7MqGxrds65RC2ObIqbHpsLjAWSDzhh8coNfgevhK+Oitolnr1JNXA5HKrTNitG+dcmoFwsFwZ8a8xzQKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762817874; c=relaxed/simple;
	bh=pNcx0xabKXaB1YSBxc57Kje72bmAUQ+xz/K/8CGdd5Y=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=YdG/3PPX04354wLeTF7nyd9pXZ8r63wc1m0oz+/U1ZkpHS8tbr6OcF8zODV8WglgIIP0a9tKoh6k8NocSv6RVdAXf2h9B0T/WEQlF+G4fXxqfCk+AFP4pte457vgld9im2T2oYpdmvR0vUF//zUgoaIX9vN/9Dzr3AOPRQkt1NM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PX8Hu+fS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82EC3C4CEFB;
	Mon, 10 Nov 2025 23:37:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762817873;
	bh=pNcx0xabKXaB1YSBxc57Kje72bmAUQ+xz/K/8CGdd5Y=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=PX8Hu+fSeVct17jwh0LCCAz/Uyzaoi203TumpmANr6+2OFWZU7XeX98GGxBsriOv1
	 o5+Pzda01K9klhG49ur6MtavXQGERd9g5trGmB2rbCkk2A6c1LSuimK7iudOvt034i
	 vn/Vl8LAHxLd8fOzLhrYf0QlT/CgSG0vvxviCkki3scPXqGfWJxBMI7QcCVM+EjdX6
	 4xFAZsoZ0ldMoNoEI5EnHXQUo4PUdZRzwMUXxvn7Ay/dErOGdzpllSSoanDWtjqBhn
	 Xp16KQgLNYaMYX4VptBwRyDwnP18IKNbm3I9BO0SsKa6JqU2THVbZ5E2gG4kx2iwoS
	 4JkJ+5+F1ZIEw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 34245380CFD7;
	Mon, 10 Nov 2025 23:37:25 +0000 (UTC)
Subject: Re: [GIT PULL] RISC-V updates for v6.18-rc6
From: pr-tracker-bot@kernel.org
In-Reply-To: <a7d159e4-8e75-e4be-4405-f10fee270664@kernel.org>
References: <a7d159e4-8e75-e4be-4405-f10fee270664@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <a7d159e4-8e75-e4be-4405-f10fee270664@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux tags/riscv-for-linus-6.18-rc6
X-PR-Tracked-Commit-Id: dc20452e6caf962f04ede7f364267b0c37784ab4
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4427259cc7f7571a157fbc9b5011e1ef6fe0a4a8
Message-Id: <176281784382.2808805.9321461270963841353.pr-tracker-bot@kernel.org>
Date: Mon, 10 Nov 2025 23:37:23 +0000
To: Paul Walmsley <pjw@kernel.org>
Cc: torvalds@linux-foundation.org, linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 10 Nov 2025 13:41:32 -0700 (MST):

> git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux tags/riscv-for-linus-6.18-rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4427259cc7f7571a157fbc9b5011e1ef6fe0a4a8

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

