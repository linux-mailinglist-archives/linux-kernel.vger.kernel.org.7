Return-Path: <linux-kernel+bounces-749015-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CC150B148E6
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 09:05:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 17E62189FEF6
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 07:05:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBBBF257AF8;
	Tue, 29 Jul 2025 07:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PmbkvjwT"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38FC32472B7
	for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 07:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753772711; cv=none; b=N4bIg5vW+R5Mhbd06oGNXivkBOb4YUgRZlPuYO9yV0CiXhtsNJ8RXhU1F04mi5qhTgye1vvZKJM4JsxScp5hdvXp3IHh5Kirsa9qV38xkllIJvyVQjG1ZVBfzIKu8QAso1zqVQVdouq4Bxm0B4P5zaLOLYwxtBUUiI9k9VoEhmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753772711; c=relaxed/simple;
	bh=VZqq5+IOyzkAtXp3tDFiYOCbbKLgWzdI96jJK3WGKhs=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Err7bUA8FPa758O7VEEL26EkElAicxHPGfDd5tD+Y6hVTgPJH4gpzj85RONUmquLJCdD4RMbW1jAOHg0wd4aEqkctgsklyDkJA46xNdXEfyw31VmHZ4BstUwTze/icM1fSdwN1FeghjbZ4f2xTpkN4SDKZKjg6Ri7btW7Tev/S8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PmbkvjwT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A4A8C4CEEF;
	Tue, 29 Jul 2025 07:05:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753772710;
	bh=VZqq5+IOyzkAtXp3tDFiYOCbbKLgWzdI96jJK3WGKhs=;
	h=Date:From:To:Cc:Subject:From;
	b=PmbkvjwTeE5n6Ys8cE6MQywj4VjKa4HUKtCZqJUuHTja1tws4/L/KZz2nsUr629vV
	 xZOKtDN28bey68q/OC02M8DvCheD79P2B5790jP9BWDqEPIPL7AhTOK6wIXgFICK9t
	 2S5hgoHCDIFjYEFWyPgxYqr8GQJ8FD2evoo704vtFpaNdNQHIFPcnhkWQPBgCkU0hw
	 +oPsvK/wyzSoWXjpWW4sl1TnjfKdl+qXlsmz9K5tL/xHCFSbk+e8T++0fp6ewsELNG
	 7BbZ5cVvowtj4Cztyp2VD+Ivgs1T7XOjfLleILn9PFdNBVNmFkBfdBnySHx/Z1+OUo
	 QDgmgGgaXLRtQ==
Date: Tue, 29 Jul 2025 09:05:05 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, the arch/x86 maintainers <x86@kernel.org>,
	David Woodhouse <dwmw2@infradead.org>,
	Ard Biesheuvel <ardb@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave@sr71.net>
Subject: [GIT PULL] x86/cpu update for v6.16
Message-ID: <aIhyoX_qXX0GLrzR@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Linus,

Please pull the latest x86/cpu Git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-cpu-2025-07-29

   # HEAD: 5bf2f5119b9e957f773a22f226974166b58cff32 Merge tag 'v6.16' into x86/cpu, to resolve conflict

Add user-space CPUID faulting support for AMD CPUs.

 Thanks,

	Ingo

------------------>
Borislav Petkov (AMD) (1):
      x86/CPU/AMD: Add CPUID faulting support


 arch/x86/include/asm/cpufeatures.h |  3 +++
 arch/x86/include/asm/msr-index.h   |  1 +
 arch/x86/kernel/cpu/amd.c          |  4 +++-
 arch/x86/kernel/process.c          | 20 ++++++++++++++------
 4 files changed, 21 insertions(+), 7 deletions(-)

