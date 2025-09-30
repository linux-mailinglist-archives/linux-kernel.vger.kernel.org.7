Return-Path: <linux-kernel+bounces-837022-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DEEDEBAB1AA
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 04:55:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A63142013C
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 02:55:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5330423817E;
	Tue, 30 Sep 2025 02:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BARO6Qdb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE4BC23506A
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 02:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759200884; cv=none; b=oh/IwLQADl5R6MN56AsiRTWLJYSU8BEsYmgicrdBZLIf0b4aa/uyavMD0yMvXzYcQ+17ILxYtje3SXjcPn1hcIj0wOWTQWaNkkzvQvSyV5lLSq1DxEQNEdeX3UTduWbXloIqUKpzZhWJBf66u81Fesn2XVuPEBZ/cMjgPaR25xM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759200884; c=relaxed/simple;
	bh=HL+THJGskFVL433eKDDlQSm0NvfTmh1ckVcBvXfN6vo=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=n68RGs1OR5iU2WN0o8Ck7OFEuKoXFrlZ0JAYZO2kDXHsFZFGKfnI5TuwD6mXgwvJbHuGZtMq+Zy6SzjOtuRvn2craOJz5aGkhBgQ5nIr/yCnfNKgnL5elfa1pL6xeYODZTJjHNDd5WEMncA7X2UGABquAeK7EGFf861IJJsg6bE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BARO6Qdb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87CE5C4CEF5;
	Tue, 30 Sep 2025 02:54:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759200884;
	bh=HL+THJGskFVL433eKDDlQSm0NvfTmh1ckVcBvXfN6vo=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=BARO6QdbrN8WCShhkUT5OCrXk0WT7AvI6EFS4B5r3YgQigzKYHbc6ffhuEHKG4q26
	 4InVRpj+vo6/Gx6snGSmm8j+VAwEdcZoIlUxUozPJaU2KH3kdRDirma3HWmTTX01mC
	 PQMj14ejEBRUmTuV+v6uEx7Whl4lnxxETl0TVSWKZBASmo5JLgX4tQXDetNHfldyeZ
	 tc1WEJa64PGj2g977zaS4GWoOHj24VFfTruWHr7U+Sa1iC6bywI2+okD4OMv5Q0Od/
	 H07uS6SgkhmMAvxInjBhdDMXLVyUHcWlws6rB0I7iI7wCwYwU0CY+zG2w2YIVLjIUT
	 Sz5j5AUiw/HSg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33FEB39D0C1A;
	Tue, 30 Sep 2025 02:54:39 +0000 (UTC)
Subject: Re: [GIT PULL] RISC-V updates for v6.18-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <2c804359-3d43-0fba-7173-a87f9aec4bd2@kernel.org>
References: <2c804359-3d43-0fba-7173-a87f9aec4bd2@kernel.org>
X-PR-Tracked-List-Id: <linux-riscv.lists.infradead.org>
X-PR-Tracked-Message-Id: <2c804359-3d43-0fba-7173-a87f9aec4bd2@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux tags/riscv-for-linus-6.18-mw1
X-PR-Tracked-Commit-Id: 0b0ca959d20689fece038954bbf1d7b14c0b11c3
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: cb7e3669c683669d93139184adff68a7d9000536
Message-Id: <175920087774.1805104.1478127226373607827.pr-tracker-bot@kernel.org>
Date: Tue, 30 Sep 2025 02:54:37 +0000
To: Paul Walmsley <pjw@kernel.org>
Cc: torvalds@linux-foundation.org, linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 29 Sep 2025 02:00:17 -0600 (MDT):

> git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux tags/riscv-for-linus-6.18-mw1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/cb7e3669c683669d93139184adff68a7d9000536

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

