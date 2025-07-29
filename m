Return-Path: <linux-kernel+bounces-749956-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68E24B15562
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 00:45:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 55E2C4E197E
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 22:45:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B068286D46;
	Tue, 29 Jul 2025 22:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YGRZ6hXb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 991932820DB
	for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 22:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753829125; cv=none; b=JM84W7qxwJCv7QNry7sjcpa4GfdpzZh60V3rL/FjUhvRbivRur31cwNvOFlU3QrWs/Gxp5A0VW8FomKaDWZUZ2TbOv0pcSYRAp+1HtfRxs8jKafDTOWGe+cfPqDB73YOYKEKctMjJOu5itkcuooNC5Y4nddZsA2xIuikaZQA5ks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753829125; c=relaxed/simple;
	bh=RqrPMoFldDMqJbIZndHqCgHbsIJoBE/YNY4YcZN9ATQ=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=OWnF/G6cfzyUtjb5mgQkO4OFKKS+53NW1d1eac0Ehc0ybV8AgHwG3AodH83GOsMG7vWlmJ7WdifgvBa68E2nOlubD9dgWyz6J3u/PIcmm6v5hZ6lJ3UWu3ooUzbFrgM8RqVNB+rWxsCichY1y/3sL4Lb8ymE/hOV/V7KX43s8T8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YGRZ6hXb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FA2EC4CEEF;
	Tue, 29 Jul 2025 22:45:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753829125;
	bh=RqrPMoFldDMqJbIZndHqCgHbsIJoBE/YNY4YcZN9ATQ=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=YGRZ6hXbf4Mn0DGw241cE8RTWT2mpNF7kFEegK+1U3MjSad5YQRRkTfQZ9wW5Dyi3
	 48f+q2Le5wCnoV/gwaTOGRGIcXWBMYo+xuNxTClgLkHs7xwEAk4FgJglcDYj0oMA68
	 bXXdqjonZyrMPcnexkhiq4KmVw8k+lNlmM/QuX1VRBb8Tg5n8zzjxLT3mjoAD6P+jk
	 IUoyV93FaX+7u78gev7QemkMnKoM0qWiEkjuVdxPkgo8DUwDjKhOMR9ilr/sULA7MB
	 E3CCR5xi4dxbjnX6L3IQWuK4N1/dibMogUE3muzoMmZsswx2Qo7CXku1nDp/xWBJPW
	 bffu157r/tv9w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EACD5383BF5F;
	Tue, 29 Jul 2025 22:45:42 +0000 (UTC)
Subject: Re: [GIT pull] smp/core for v6.17-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <175365568477.581055.6002001481718640290.tglx@xen13>
References: <175365567943.581055.6806236199247802443.tglx@xen13> <175365568477.581055.6002001481718640290.tglx@xen13>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <175365568477.581055.6002001481718640290.tglx@xen13>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git smp-core-2025-07-27
X-PR-Tracked-Commit-Id: 946a7281982530d333eaee62bd1726f25908b3a9
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b34111a89f3c78baf12546bd4bc77a15dccc19c7
Message-Id: <175382914155.1670422.9527698698638652838.pr-tracker-bot@kernel.org>
Date: Tue, 29 Jul 2025 22:45:41 +0000
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, x86@kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 28 Jul 2025 00:37:56 +0200 (CEST):

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git smp-core-2025-07-27

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b34111a89f3c78baf12546bd4bc77a15dccc19c7

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

