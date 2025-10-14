Return-Path: <linux-kernel+bounces-853317-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E2C9BDB3F6
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 22:28:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D8E9E4F9A52
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 20:28:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A3A8306B11;
	Tue, 14 Oct 2025 20:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UEzC3AZW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CF2A306B01;
	Tue, 14 Oct 2025 20:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760473729; cv=none; b=GercUMzvgo0JsxoXO4o1VjIwS8TgPQrPeCvpmoAPv8E0K1ytr50RBeN/56clLLTRRSeZL2a8SNRLu1hDyURWmfdsyOgGli7tVPmcKGDE87eIYKbY1PTErwr9Cln1FJjeMZoJcKq4D/EaA9p9Sp5xXdwlex+/P+ihoVKjWrM52qg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760473729; c=relaxed/simple;
	bh=fJ/ys0qq6ObV5ATLM65qotXjGPQbo8vqMpF6gGpatvA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VzcTe1x8dMVvx/GEshn8pLqzocPrmN6MOlCoxMolQsZU2tJOjxNUj9iX5VxI4TzvqsUHmZ3vnElIb89W2nvhphoTvxjrZshmtI8qZBJyPwCIqs4qOpy2TM/7yhx0/ox1owAEXLLI9/2sa12zcgeI8r036eK1aOByr0/7UfEtarE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UEzC3AZW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECFEEC4CEE7;
	Tue, 14 Oct 2025 20:28:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760473728;
	bh=fJ/ys0qq6ObV5ATLM65qotXjGPQbo8vqMpF6gGpatvA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UEzC3AZW2liLbRp18pZpw/YQ0XpWx85Wc6OOeSmLXVer4V80eRRkejrhk9fLVDRO/
	 cZoafQvhpOUvcdRV2c49BUJF/+qBwZ3M0oA0Si9s5bWgg7RYaQCzJKDwzyc7ABGgEK
	 1okCi4vK8MMMK/Omcxaj7y5n9An/eP3QkRbJ22guFnb1Mlq7cBKCGEDK+yR+ZfWbt4
	 LlRHNJzTJvwllaYG9QvLosVh3yhRqTgbW7zEiX0EkNZjD6aNk+/8LSw/4wr0MbRA5e
	 520vqhJENQlng9LG0AG4MH0cNdyZXWneFB9gxBcW6R+ul8K7+WKVpN9Ze9PL7CQ8p8
	 rpRqDlcHuc5MQ==
Date: Tue, 14 Oct 2025 10:28:46 -1000
From: Tejun Heo <tj@kernel.org>
To: Andrea Righi <arighi@nvidia.com>
Cc: David Vernet <void@manifault.com>, Changwoo Min <changwoo@igalia.com>,
	sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH sched_ext/for-6.19] sched_ext: Fix build error in
 cgroup_set_idle()
Message-ID: <aO6yfrXzTBIhrUU-@slm.duckdns.org>
References: <20251013193003.36215-1-arighi@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251013193003.36215-1-arighi@nvidia.com>

On Mon, Oct 13, 2025 at 09:30:03PM +0200, Andrea Righi wrote:
> Commit a5bd6ba30b336 ("sched_ext: Use cgroup_lock/unlock() to
> synchronize against cgroup operations") renamed scx_cgroup_rwsem to
> scx_cgroup_ops_rwsem.
> 
> Update cgroup_set_idle() accordingly to fix the resulting build error.
> 
> Fixes: d579dc6eb4fd0 ("sched/ext: Implement cgroup_set_idle() callback")
> Signed-off-by: Andrea Righi <arighi@nvidia.com>

Oh, I fixed this by updating the top of the tree. Sorry about the breakage.

Thanks.

-- 
tejun

