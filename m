Return-Path: <linux-kernel+bounces-838274-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 746EFBAED94
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 02:04:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C7334A7EE1
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 00:04:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5B2D21ABA4;
	Wed,  1 Oct 2025 00:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YPD1Pvus"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30CBC212566
	for <linux-kernel@vger.kernel.org>; Wed,  1 Oct 2025 00:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759276965; cv=none; b=ZwBtBq5jLy5y8KIJ2+85wgQbx6OPwds6ai2UohPaDOtkJJP0LN+QZ/D+1KYks7n82OkKg1wmWZ2JeYyW9JEWNgRHUe4o6QLsJI2cAnbXfHtkvHcqOdfHB7VLNI0L0S6OnAE0OEWc5auHkNDfiYpapIkPiZtKCD/Dw2o80cxkMMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759276965; c=relaxed/simple;
	bh=1+9Ii0juHSpQ2Vu94ECa6CzN+lbROuX2E+W6sJDaNlI=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=ptescnHcdlpKQ0ASNKS40NSMYmwiM+jTjuiqpXWUaKs6Cf6CLFkuSZeGHXPLOOmmHEDbD8y3joHtuyHCWLHuGrtXHp9XlrD51dIcZ4nxnEBNG+zfFwN/O4JQWedxs7rgPed7grDerpyv99u6vsJehO+VFEr8KWweVX4DVtvaums=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YPD1Pvus; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13CFAC113D0;
	Wed,  1 Oct 2025 00:02:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759276965;
	bh=1+9Ii0juHSpQ2Vu94ECa6CzN+lbROuX2E+W6sJDaNlI=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=YPD1PvusT8prMN7Z0K+3xU2o2UCk46/2PUm6oXjIowu0MsMktwWTUo9rVUMCgcUeV
	 qN2a0skHruASWPrDlS33ez0akSUbSo/UNdPyFBx9b+VonhmH/nKPE5mdYmsvNA10TH
	 dY1mZBNQnbF8mv2i316Hc6FSHFqc3kxy04G/W23jozzfyO8WoG7ij25qa6EJcWe3Yf
	 FjZeIIqatmgGWnnCoTwpW5p87MKh+XgMv+mFFvqUebvMh0sRCORrIhK7RtXZZBee3G
	 IYkNfk238QAF6l+CqcmuuTftdIp5jt0790ayrdW1XzX8JwrshewYKH4PUlvb8YrkAe
	 uwc3bYinhjhUw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 340AF39D0C1A;
	Wed,  1 Oct 2025 00:02:39 +0000 (UTC)
Subject: Re: [GIT pull] locking/futex for v6.18-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <175913808316.495041.17299607238306952698.tglx@xen13>
References: <175913807599.495041.10251515322736195577.tglx@xen13> <175913808316.495041.17299607238306952698.tglx@xen13>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <175913808316.495041.17299607238306952698.tglx@xen13>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git locking-futex-2025-09-29
X-PR-Tracked-Commit-Id: 4386f71623b77215c9502e60fc399e76ec337fec
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c574fb2ed7c96f87fc0e5295e910e646a7ee4dfa
Message-Id: <175927695766.2242674.14467414968378706986.pr-tracker-bot@kernel.org>
Date: Wed, 01 Oct 2025 00:02:37 +0000
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, x86@kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 29 Sep 2025 11:29:02 +0200 (CEST):

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git locking-futex-2025-09-29

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c574fb2ed7c96f87fc0e5295e910e646a7ee4dfa

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

