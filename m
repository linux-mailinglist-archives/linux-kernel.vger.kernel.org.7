Return-Path: <linux-kernel+bounces-737291-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD2AFB0AA58
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 20:50:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B334F5A28AD
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 18:50:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4267D2E973A;
	Fri, 18 Jul 2025 18:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JtY5A8cV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A18F72E7F1F
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 18:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752864595; cv=none; b=D71mgWj3HtWj9zi1ORsLjbyPbS/qe6ZF5nGG6tBjH8tdlyPyXlnrm8r0ePnxnvq5xAgmKDpHuGXNnlYkAn7ZmBpSvncftAxD2JIeBulCRdlWPnzX1lOUwstkHCPAFScGvKbUY5Ve44ZEUBkTl/dAkYLjDCia2wu+aRE3QSrr+6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752864595; c=relaxed/simple;
	bh=lE60G7ULQK5cjdRiBLrlBnz1JC8J2bjhUxgFh/dQeYk=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=DldecmLmJvN8KXQB4mNivlh6ITBoEhTLpe4kIJqaFSUBJu950npHUuWqec9REVUDE7qaZROpxtXWTOy+jI27QRGymTbdxGx7ge37toG9JN4Q+O/kOIHbwnNAhP5sK33VbbT/ZW4/ZNdv/NVqk63ZvaRi7VxMptrDvt/fBG/sy2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JtY5A8cV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7535DC4CEEB;
	Fri, 18 Jul 2025 18:49:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752864595;
	bh=lE60G7ULQK5cjdRiBLrlBnz1JC8J2bjhUxgFh/dQeYk=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=JtY5A8cVSXaEmi6PkM+gNL8Jb5E7nW73SX3FHSqHNh6+x0J6WsPzGaAm+FGJirNlR
	 5xQqc6KArpUEELYJhk9eNqpJ7b0wLfCVLlwyR5uenESQFy7URZG0LPWGghQmzVwwGU
	 KSmJgEXaE92WPO4d0creTV4V92aRIcTd9Zti3k9TR2eGjBljiQEMC8hlwuus/GYac3
	 +GWi1s11Yb2nCuXMQmI2LihsbgyAOgYDlBCr3wYDXQ4U2HPtWdIjHmmLiIOdODKEHQ
	 QLCYJI9rAfptNmwlLlrHPRjjz4PFVpPCwDNJw3syNvN2w7nxnhHnBIX91pFexSkLuy
	 PxoBV+wNiM4nQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 5F6E3383BA3C;
	Fri, 18 Jul 2025 18:50:16 +0000 (UTC)
Subject: Re: [GIT PULL]: dmaengine fixes for v6.16
From: pr-tracker-bot@kernel.org
In-Reply-To: <aHnzTit-z6NErlsL@vaman>
References: <aHnzTit-z6NErlsL@vaman>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <aHnzTit-z6NErlsL@vaman>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/dmaengine.git tags/dmaengine-fix-6.16
X-PR-Tracked-Commit-Id: 3df63fa8f2afd051848e37ef1b8299dee28d4f87
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: fcc481f76b291798ff1e3054c8a8602937087cb3
Message-Id: <175286461506.2758519.10586947768193121270.pr-tracker-bot@kernel.org>
Date: Fri, 18 Jul 2025 18:50:15 +0000
To: Vinod Koul <vkoul@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 18 Jul 2025 12:40:06 +0530:

> git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/dmaengine.git tags/dmaengine-fix-6.16

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/fcc481f76b291798ff1e3054c8a8602937087cb3

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

