Return-Path: <linux-kernel+bounces-749790-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CDA5B152F8
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 20:42:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E98CA18C0B7D
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 18:41:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBE6B2550C7;
	Tue, 29 Jul 2025 18:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IW5a5HLF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43C7C253B40;
	Tue, 29 Jul 2025 18:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753814414; cv=none; b=JIUHFk0XidqyMMIWobNOKnT4U/L3jdVZ8JCewozNasFFXzWq+tkDtjI8+Bw6+kWYYJtR+QvIDm7QyN/tcBoDqU9LD8X4v1pvUW6WO/4Uo0hFUGTEHVBoL2NXuPQTXaBKm29IYe27lnnVRABXyq3mN/EmSwNltOx3hWH1RklQdUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753814414; c=relaxed/simple;
	bh=UX/MJHveA5Ap7yrrdOCX+32Dvup+AZC66ZpXumjdzJI=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=Q8thtlyfly6hNm6/7HFKr1LXVC5ScRUmQ2tRulOITRCRKbpjMiTjZDFrVhuKRr8KPvOyqBzDuf2oTNIzmbM8NFv1ex7DmeEChR0mXQepPT6Dy5TERWvYOhEOfFv0nKbYqX4LStihkfeCmhM8PAhPsVE6imUE7l0/qBQS16ef7kk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IW5a5HLF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23DE4C4CEEF;
	Tue, 29 Jul 2025 18:40:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753814414;
	bh=UX/MJHveA5Ap7yrrdOCX+32Dvup+AZC66ZpXumjdzJI=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=IW5a5HLFNUbpJV9YSo0ppPquUGqclUWY4FfMwpZ8vkSy/5MHDewUm2sGdc8UFyFb1
	 +0rRyVDeU9IXh8QO6Qlnzi/w6ze+ebQDImVhhITsoTm4nwxqMlGA0az0Rs75lEQ9oa
	 YByWarWwZORUdpV9ZRLC0uM++V7VEXVh/JwJ0roOkABRHep2VjWyiPc0V1s4pALQcq
	 o37Pa+5YfbU8vuX4spb/oPOlObqhGIGeFD1+EROo8/kRwID/inxjNnhDYbEbRIFJUZ
	 mdbsvTnVKmfZddKCK9ctZPVfUhbN7FQmNVWjYmxwPh/gzKVlhDGisabdllsA6T1wRj
	 NRw2GAhplJmUg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADD10383BF5F;
	Tue, 29 Jul 2025 18:40:31 +0000 (UTC)
Subject: Re: [GIT PULL 2/5] soc: driver updates for 6.17
From: pr-tracker-bot@kernel.org
In-Reply-To: <60aec956-e650-43ab-ace2-52e21d7892f8@app.fastmail.com>
References: <564b7ace-bb5f-430e-a7f1-9f6a41305e10@app.fastmail.com> <60aec956-e650-43ab-ace2-52e21d7892f8@app.fastmail.com>
X-PR-Tracked-List-Id: <linux-arm-kernel.lists.infradead.org>
X-PR-Tracked-Message-Id: <60aec956-e650-43ab-ace2-52e21d7892f8@app.fastmail.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git tags/soc-drivers-6.17
X-PR-Tracked-Commit-Id: 4507d205f10216d3a6b873f0a2e9c634e23f35ac
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0f46f50845ce75bfaba62df0421084d23bb6a72f
Message-Id: <175381443063.1585410.3215815371242007157.pr-tracker-bot@kernel.org>
Date: Tue, 29 Jul 2025 18:40:30 +0000
To: Arnd Bergmann <arnd@arndb.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, soc@lists.linux.dev, linux-arm-kernel@lists.infradead.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sat, 26 Jul 2025 12:29:44 +0200:

> https://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git tags/soc-drivers-6.17

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0f46f50845ce75bfaba62df0421084d23bb6a72f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

