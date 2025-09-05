Return-Path: <linux-kernel+bounces-803738-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B7752B4647C
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 22:17:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 916271BC397B
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 20:17:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC6042765C1;
	Fri,  5 Sep 2025 20:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k3C/TT/T"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21210270555;
	Fri,  5 Sep 2025 20:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757103429; cv=none; b=sa6oa3KW57HqGviAKfjhDwnx6OkM7HUnpxqH0Zu6CO1PFdN4SSenphRfn9x8vXVyp+21yE1UUPxQ1IfbzJUuwUNOQmENUwXHOllB5o1DFuf5kNHharToqjaDd1nvqzqvH059e3feIOTfkIbuiRMUVl5IyX7pJ6+q6ETUWEQuB88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757103429; c=relaxed/simple;
	bh=00s3t4Ucs22+Ui58IK8LuLgzGqSOLX/UTkwakge7uEk=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=gY6PxON2E0svFKyoQaOTiyTDhj/PGewiwx7EiK4SaAjI+Q57eHb12I/x1PN+4XQENEVVT0go2Dv1S+P2137BGoD/60pe+LWb1urQMuMjS6hw0dgGcd3RwNnctbPSHPlz6t0rgKRbo3NaH7LmivLGOIkiGXhdmEBXYq0dro9YFOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k3C/TT/T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00E96C4CEF9;
	Fri,  5 Sep 2025 20:17:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757103429;
	bh=00s3t4Ucs22+Ui58IK8LuLgzGqSOLX/UTkwakge7uEk=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=k3C/TT/TO2mtiUu8QfDbkmJzmA4XfuTMcpnHPmNKK0NuCdeVBmkiHf0vwva9z5rQ2
	 WSOaUNIUGaObmzC2SL/rAeGb0ciEMybCIhKYDVLZ77n/gDrP/VqyqRc/PBM4RaO/32
	 S5GucGXcHUuZCEUx7vgUJG0GGUAC/zB51O3ezYwS1ANMyfudnG04fYGhIPBBVQhEbt
	 KLzU4XfvQ/p7zS7KBZpRClUC4rUZCZitkMSP4r8SpEiOsxk7OHLLir98Ex3LtJSR7H
	 YIRnyukVOAknRlU89kC6ml2r7qiAg6Spl4NcYuVtSCned2vFDXVOWbjlfh5ifP7Ivg
	 tgmxblcxWOGNA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE88C383BF69;
	Fri,  5 Sep 2025 20:17:14 +0000 (UTC)
Subject: Re: [GIT PULL] platform-drivers-x86 for v6.17-3
From: pr-tracker-bot@kernel.org
In-Reply-To: <pdx86-pr-20250905155905-179965085@linux.intel.com>
References: <pdx86-pr-20250905155905-179965085@linux.intel.com>
X-PR-Tracked-List-Id: <platform-driver-x86.vger.kernel.org>
X-PR-Tracked-Message-Id: <pdx86-pr-20250905155905-179965085@linux.intel.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git tags/platform-drivers-x86-v6.17-3
X-PR-Tracked-Commit-Id: aa28991fd5dc4c01a40caab2bd9af8c5e06f9899
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: dd6cbcc589dd0f22f2b7676c92d0058348c192de
Message-Id: <175710343341.2676293.357356404985636282.pr-tracker-bot@kernel.org>
Date: Fri, 05 Sep 2025 20:17:13 +0000
To: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, PDx86 <platform-driver-x86@vger.kernel.org>, Hans de Goede <hdegoede@redhat.com>, Andy Shevchenko <andy@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 05 Sep 2025 15:59:05 +0300:

> https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git tags/platform-drivers-x86-v6.17-3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/dd6cbcc589dd0f22f2b7676c92d0058348c192de

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

