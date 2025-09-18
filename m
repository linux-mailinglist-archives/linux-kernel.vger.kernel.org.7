Return-Path: <linux-kernel+bounces-823322-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24230B861EF
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 18:53:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A9537E1520
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 16:52:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30081253950;
	Thu, 18 Sep 2025 16:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FOE+XOPh"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88D3A24BD0C;
	Thu, 18 Sep 2025 16:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758214277; cv=none; b=tLM99JUrDs7HA9cEGWrbq50AYd00K+B2U87v4s1eEWjGCYb1j3sb/m8gdLd33IpIpyAayk1fZLSiREU/8Nwb+hyp1l0QOSvSsz0dbPnC/0ZU+H5+YQsR5zMmDxpyhVDPEm6UHWh8tuq5A+mq9m04lLInZrOI3NXc459snWTmSek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758214277; c=relaxed/simple;
	bh=GeyKtgWBpUz0eyIwgoG/+Yk62rhzGwdCcdZrmHG4it0=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=kIOIzwVQeqERepAlp6KHkXNucz2KMQ94R4aEKpycLJVrxNc/kgOrgYUN3D5khxlVlhN6y8dHammHrZtw9nyi+Dq3qrDkv/QV4KicQMBaYDRN/0BeR3OgWLlJt964ZBpTRl7lohukxh9Uk78ibG//CkD9rmzokDMn5ZA8hXx5O5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FOE+XOPh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AF09C4CEF1;
	Thu, 18 Sep 2025 16:51:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758214277;
	bh=GeyKtgWBpUz0eyIwgoG/+Yk62rhzGwdCcdZrmHG4it0=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=FOE+XOPh17CIaDqOGMzQ6XqsldkWyVvvTHT8MtDUWneI+avoBUmzXiKN70DsIrj2E
	 tlYKHuo6sy4ethnSP4XuVPVR9fLhNgzH5EJFUEplFUfrpNtyZwc//qc+VfE2/vcPGO
	 fsmjTEnAwSiry6lWnt74JY0CnBNnAiyLIA5e52I5C0NPTY6aLW9PozzlcHqPNDCEIt
	 7kr/gKQNUBznGnemPg3w3w4SAKlNUWTXnIJhamoKefO7n3P076dWXe4DvSHU+Rsmqw
	 ES8MiA2piAKom+5wuZGFSBm+4sC4vImqMpaY0wcLuhG7ZWuquPR7gU9Q8FSEX3Zgql
	 9s/H2rx3c+4Pg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE08139D0C20;
	Thu, 18 Sep 2025 16:51:18 +0000 (UTC)
Subject: Re: [GIT PULL] platform-drivers-x86 for v6.17-4
From: pr-tracker-bot@kernel.org
In-Reply-To: <pdx86-pr-20250918114918-1887020842@linux.intel.com>
References: <pdx86-pr-20250918114918-1887020842@linux.intel.com>
X-PR-Tracked-List-Id: <platform-driver-x86.vger.kernel.org>
X-PR-Tracked-Message-Id: <pdx86-pr-20250918114918-1887020842@linux.intel.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git tags/platform-drivers-x86-v6.17-4
X-PR-Tracked-Commit-Id: 225d1ee0f5ba3218d1814d36564fdb5f37b50474
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 604530cd9a5b0c603038dfbe9e82b3e4dad11350
Message-Id: <175821427735.2499383.10361908055732519667.pr-tracker-bot@kernel.org>
Date: Thu, 18 Sep 2025 16:51:17 +0000
To: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, PDx86 <platform-driver-x86@vger.kernel.org>, Hans de Goede <hdegoede@redhat.com>, Andy Shevchenko <andy@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 18 Sep 2025 11:49:18 +0300:

> https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git tags/platform-drivers-x86-v6.17-4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/604530cd9a5b0c603038dfbe9e82b3e4dad11350

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

