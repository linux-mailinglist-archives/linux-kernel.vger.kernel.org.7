Return-Path: <linux-kernel+bounces-749954-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E82DB15560
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 00:45:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B1F864E1519
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 22:45:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4498F27FD62;
	Tue, 29 Jul 2025 22:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fctg7IIz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DB4327FD52
	for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 22:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753829122; cv=none; b=SswZUXjsklOuXiRNb4S4d8whP5L/55H4bUEc6QPI34a4OEtdvsSIBfjdMKH1RfuC+I20vgdg3X9j60GcOh0i10Ely6hTslJBDVKyNIe4Hjj4Sc8du2h2Ih1Um2P2EP/Nx5DlYUIOD+1PUvE+ei+4KYzW1YBOVxZpjW+XCStsYvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753829122; c=relaxed/simple;
	bh=l+AKwvgmfwUocvHarx71lgZV0ChTuV1/FTU72wIgFkg=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=kUkfsBBzqSjZv8AuYVS5ViD6A86EZMVDW+bUus8wLOR7KElR97n23JCW+EdRWVG6vT+LUL8deSNj+MvyK/u3tTDL09aj82/MkBHcSwqiWZLjNIuh5OHiSy0btK8NcOUBZyqyqXijdzAK9E/zhf3gTb+d9MiHFpnF7k1JF0JSGfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fctg7IIz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05EBBC4CEF7;
	Tue, 29 Jul 2025 22:45:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753829122;
	bh=l+AKwvgmfwUocvHarx71lgZV0ChTuV1/FTU72wIgFkg=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=Fctg7IIzrJovibxepmYWrTpvEb9LpvjPtSRyPpnukcJA5DvoQMcHCgLsj4Iy2Z1Gd
	 O53pwgERZ2hmYJaBgi9FwQ8hnek8Z51hiRwVY5nWIbZSgQchHP0EEKYj9nDmr2j6Ts
	 EXcq0CQe7a8Z3+RYggk9zsaSw/YtAetXKQNG4cSzsNye4P/P07TIbMgVWLJdF+3gHX
	 85JKIzbK0fMebmGuvahKzJpoDDV2SJdE+W0+CxXa+d4kszbEIkCZAP/7G1c4CSSOGg
	 EMtgxj6rJjDaDLGZn7QZFHNAB69NxDDFRgs8wXkn6/4VftRzQV4brbGq5uL62wEoSb
	 N1KHVt7Uva4Kg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70E2F383BF5F;
	Tue, 29 Jul 2025 22:45:39 +0000 (UTC)
Subject: Re: [GIT pull] irq/msi for v6.17-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <175365568292.581055.1455338411054266072.tglx@xen13>
References: <175365567943.581055.6806236199247802443.tglx@xen13> <175365568292.581055.1455338411054266072.tglx@xen13>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <175365568292.581055.1455338411054266072.tglx@xen13>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq-msi-2025-07-27
X-PR-Tracked-Commit-Id: 4a089c0b3f55b400689a5c35f7dfa0a74c363dae
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5623870d9b4f1b9bd4a8b75544f2f9ed2a49afff
Message-Id: <175382913805.1670422.17115992581687775353.pr-tracker-bot@kernel.org>
Date: Tue, 29 Jul 2025 22:45:38 +0000
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, x86@kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 28 Jul 2025 00:37:54 +0200 (CEST):

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq-msi-2025-07-27

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5623870d9b4f1b9bd4a8b75544f2f9ed2a49afff

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

