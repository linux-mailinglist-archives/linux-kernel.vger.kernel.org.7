Return-Path: <linux-kernel+bounces-640189-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA010AB0185
	for <lists+linux-kernel@lfdr.de>; Thu,  8 May 2025 19:37:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4EB2C4C6DFA
	for <lists+linux-kernel@lfdr.de>; Thu,  8 May 2025 17:37:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0795F27E1D0;
	Thu,  8 May 2025 17:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n54Z7dqF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F4A217A2E2;
	Thu,  8 May 2025 17:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746725813; cv=none; b=e3SkTBu+mu64VQjScpIlHWNlCn2CclR09VXgEJYWyRQfQeDe3VC2ExQzyHA00iyBkyT42s4uB1czWHa36JldD2RA1Q8P7+PY/6w9KiRDR9QbMJZ7jzjEjmY03HR6AOuZgZka1pMMJrix6dUPhYx0cdx1YamGNHuGbDhxVcINUf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746725813; c=relaxed/simple;
	bh=wERx+mVYknRswd1fgrUi8mRRTqOnpMCj6/e8sj6/RuY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c0icOzTyjdldgItoqK2qMwIKRh50I4vUj+CeW0uYzrMRcPs0X5XcSuxExOuZWqs0+o1KICDyv9YsIoZ+daaeusRyWLvBjugXsSep1OJVIrlgLQfbcuu4s1wgjPfxesW9G7mxHcDSt6kzcqv9yMntaO116OMXNsZQlsDqpd9Z37Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n54Z7dqF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6771CC4CEE7;
	Thu,  8 May 2025 17:36:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746725811;
	bh=wERx+mVYknRswd1fgrUi8mRRTqOnpMCj6/e8sj6/RuY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=n54Z7dqFhzJFaUjSfBAVCgq4xMn59iYfF2AhgS6eHhckuTvEzevHci5cpM6bw0qyG
	 t3jzmY+kYNMyxqOiYVQGH2VfNhRzd9t2LRs+TIvNDgK+yDMxgmbLGHGwf6Fzvcrd8M
	 wbUaC4yyc98ogsTi9VBLz0j6LcjwdYHSCwsKRQo+YNWjR1aQOcNx4O3HNIuIEh7/cY
	 ssM5bhlLzRJV6Jh5LkABjFv5JDTvtgegbqNAQgNEF8BDMWSWKLVUEXO7n8j/JJAdY6
	 W9mvdHsqjDiBRAA4bR9AjxaiVBtHnM9WgWYrMqk515YfUwJvL4mb+HzTDLtSzwLPEW
	 cL854WXw+SKlg==
Date: Thu, 8 May 2025 18:36:47 +0100
From: Simon Horman <horms@kernel.org>
To: Abdun Nihaal <abdun.nihaal@gmail.com>
Cc: shshaikh@marvell.com, manishc@marvell.com, GR-Linux-NIC-Dev@marvell.com,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, rajesh.borundia@qlogic.com,
	sucheta.chakraborty@qlogic.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] qlcnic: fix memory leak in
 qlcnic_sriov_channel_cfg_cmd()
Message-ID: <20250508173647.GN3339421@horms.kernel.org>
References: <20250507152102.53783-1-abdun.nihaal@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250507152102.53783-1-abdun.nihaal@gmail.com>

On Wed, May 07, 2025 at 08:51:00PM +0530, Abdun Nihaal wrote:
> In one of the error paths in qlcnic_sriov_channel_cfg_cmd(), the memory
> allocated in qlcnic_sriov_alloc_bc_mbx_args() for mailbox arguments is
> not freed. Fix that by jumping to the error path that frees them, by
> calling qlcnic_free_mbx_args().

Thanks, I agree with your analysis.

But I think it would be nice to include some text regarding
how you found the bug, e.g. by inspection, using static analysis,
via a crash.

And if you have been able to test the patch on hardware,
or if, rather, it is compile tested only.

> 
> Fixes: f197a7aa6288 ("qlcnic: VF-PF communication channel implementation")
> Signed-off-by: Abdun Nihaal <abdun.nihaal@gmail.com>

...

