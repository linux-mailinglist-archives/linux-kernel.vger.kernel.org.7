Return-Path: <linux-kernel+bounces-819573-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57B59B5A33B
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 22:36:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C856F4628E2
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 20:35:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D25ED279DB4;
	Tue, 16 Sep 2025 20:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JrDXhaJj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 360C125392A;
	Tue, 16 Sep 2025 20:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758054728; cv=none; b=R5rka1uwcM2qJw5PqtvbfzfZuoNW4342eSIeoCvbrbmZemfDlrFjztL7A440BlJ/cengsPm3ch3GMWvDNSgMSBoPOHoiih/aCfkTe5r26mSNO90zjW9GRTzVbDtButKyGEgeQ48sSQCFDbVsGDa9UCemA+n8oX7z2Z9aw4pIUUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758054728; c=relaxed/simple;
	bh=HcWizezMA5klvnYnQpS0v8oBjlRPRuFgpJFp2cNBiK4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LgXQ3T0aA9NlypyhDsHwgE31/p2bOKJeb57yX8zkgNEPYUacFDqZAEXDtqhfEmC2GSuaDQQp5btL/d4heRx1Gz38MSP89JvXMeKCpAITy17X/IgOxeA/vc+R3WwORXV1cmS08i0fzppqFoDSRM49F8GTHSXOYRrnqvObZjA5D/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JrDXhaJj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 954A1C4CEF7;
	Tue, 16 Sep 2025 20:32:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758054727;
	bh=HcWizezMA5klvnYnQpS0v8oBjlRPRuFgpJFp2cNBiK4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JrDXhaJjRoA5NAx7sI1jD+177fF4EHbJKbNF02yo5CMbGMfSsfuybdJ7/FWpWz5pp
	 MESqfMVlKphwNoTeprihFc+CI4t6/kYiRklvaej5u8Fh+bBbHhODzvKwUelZZmbMRt
	 ipiFF4L9KklpSRHjAR6qjxLDuIBDiYGCEUGtp7ZV71TqDKM/YllZ/OpfdNFkrdUm/P
	 OTv5rBb8kbw0EvVdI3ZxduswnozK6EFf3e4ZK7VqzVf+XGjlM/7yMRKK+KPsFucLvb
	 qixQNib13K4Yhu6KlwHPD8uFJm+8lcIsDFyJmHbPLGkHuVpGRR8K4zlTxki/HSf3rZ
	 YN3ht4L4YQklA==
Date: Tue, 16 Sep 2025 10:32:06 -1000
From: Tejun Heo <tj@kernel.org>
To: Changwoo Min <changwoo@igalia.com>
Cc: void@manifault.com, arighi@nvidia.com, kernel-dev@igalia.com,
	sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched_ext: allow scx_bpf_task_cgroup() in ops.dispatch()
Message-ID: <aMnJRn8qdiFaqQXU@slm.duckdns.org>
References: <20250915065236.13669-1-changwoo@igalia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250915065236.13669-1-changwoo@igalia.com>

Hello,

On Mon, Sep 15, 2025 at 03:52:36PM +0900, Changwoo Min wrote:
...
> Fix this by adding the prev task to scx.kf_tasks so that task-related
> BPF helpers such as scx_bpf_task_cgroup() can be called safely. Since
> the SCX_CALL_OP_TASK family assumes the first argument is the task,
> introduce a new SCX_CALL_OP_TASK_ANY macro without that restriction.
> Also update __SCX_KF_TERMINAL to include SCX_KF_DISPATCH.

I'm not sure this is safe tho. ops.dispatch() can release the rq lock it's
holding to migrate tasks across rq's, which means that other operations can
nest inside - ie. there can be an irq which triggers ops.enqueue() while
ops.dispatch() is in progress. That can in turn overwrite
current->scx.kf_tasks[].

I wonder whether a better approach would be tracking cgroup membership from
BPF side. ops.init_task() tells you the initial cgroup it's joining and if
the task later moves to another cgroup, ops.cgroup_move() will be invoked.
Would that work?

Thanks.

-- 
tejun

