Return-Path: <linux-kernel+bounces-749955-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52865B15561
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 00:45:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B6964E0B3E
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 22:45:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB1C4285CAF;
	Tue, 29 Jul 2025 22:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aFNa9jb2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 047CB2857CA
	for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 22:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753829124; cv=none; b=oBe2VPatDeIHVPfoAsdc5Rbm4ZLrXj3tl0e+6gQWpn4ihHW4PJxEKHHCsSrxFpp4Pz1/JYmwmO/S3mtcBHJRaiVzGgH3dd/72aeLqDj+vWTR2kLHLkgEp2wEM8+HxbgEk4Ck1ighim7Y0k2UNtaUGI/U9urNlsKhTxu9clcxHe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753829124; c=relaxed/simple;
	bh=o+1EVOcvT0QUWMzAtjnSdFu6ukqRDZhkRaSatB0DfQA=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=ETRJX9U1mZkkWWBLqRTrrdansEp/RPn0CIhSLX6LKiuBo86sutxf70/NKHWhdg3DU9CDXwIsxxXaAetLYOpJiGM8g8J1eZhVSzyr7m44SxZ6jBg2DBwGjvqRVBODMYHxdJQTMbI+GahbUPpcD3Yoyhpa54zp8fatk/nVEVklRIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aFNa9jb2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2921C4CEF7;
	Tue, 29 Jul 2025 22:45:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753829123;
	bh=o+1EVOcvT0QUWMzAtjnSdFu6ukqRDZhkRaSatB0DfQA=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=aFNa9jb2ZiAVa9+RExFVTsEHHqSVCIxViotKVPlRkdoUhmFQRgntJwtb9bRzf/SoT
	 6LSMzW0IljCt4hBoojy4sqGAOqMDwqn8Jx9YpJMwEHKFcimBAruR1IVhay5oDD6Hw4
	 KKc3JcYjwiHOglA2vthOw4S8GqQaKP0CMaxTUF2ejtjsFr1gZGtKjid6Kig1OTaZiC
	 ONpfmItzIZUgQWCI3Bspq0nG+534+3L3lFM12Ur899yUFBKMsBmoS6TsCRHS62A0ZW
	 KAiOzIZoLqNimAXNuwdFFLo7pIVVxy2RGhKfp9FN+m7FEaQSQZSo0P21tOUtrUU0sb
	 HwyZFkjmotqAQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33AC1383BF5F;
	Tue, 29 Jul 2025 22:45:41 +0000 (UTC)
Subject: Re: [GIT pull] irq/core for v6.17-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <175365567943.581055.6806236199247802443.tglx@xen13>
References: <175365567943.581055.6806236199247802443.tglx@xen13>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <175365567943.581055.6806236199247802443.tglx@xen13>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq-core-2025-07-27
X-PR-Tracked-Commit-Id: 8d39d6ec4db5da9899993092227584a97c203fd3
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: dba3ec9f2ad085f05528ccd36d6835b06b5370cd
Message-Id: <175382913980.1670422.13176334621535906439.pr-tracker-bot@kernel.org>
Date: Tue, 29 Jul 2025 22:45:39 +0000
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, x86@kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 28 Jul 2025 00:37:50 +0200 (CEST):

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq-core-2025-07-27

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/dba3ec9f2ad085f05528ccd36d6835b06b5370cd

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

