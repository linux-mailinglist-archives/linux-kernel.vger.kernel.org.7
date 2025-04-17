Return-Path: <linux-kernel+bounces-609318-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CA707A920C3
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Apr 2025 17:04:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 90E8F1885FC1
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Apr 2025 15:04:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99589252908;
	Thu, 17 Apr 2025 15:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r9p3v7ya"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E97E0229B15;
	Thu, 17 Apr 2025 15:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744902266; cv=none; b=UFtLyqGvddzjf/nKMoMGNSiaGxZXMlbmuHfdYCi1M071TIjJygZPzvDKX8kEG4suGEyFm+Acvr/2JyyRxNBmPh+pkjXLTXm5uOs35cGbgsIq2lNoSMOf6sQe5Od7ZEXdrFN4CVKJOycAk/q5DGRvD13gS/XKMKhMnZB+LUEVGCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744902266; c=relaxed/simple;
	bh=jhVXuc6kGTl7bQ9u+r90HyPUtrpxat6y+lZDEzh7kqg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lelhoMZ8om5M93Ta9sQ39Jt8+iYjxkpscgZI0S3Z2R4hwmcgyvXcOD178aU71gy+ngBanf4zXo4WGHuO4P+xqykJTqMDUuVPk63+esdJgScrw4EFUGR7067z0KojA0xsmwIanV68p4zNKsTKOwqCWLO58sGTamtUJbOQZZFaWBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r9p3v7ya; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4495C4CEE4;
	Thu, 17 Apr 2025 15:04:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744902264;
	bh=jhVXuc6kGTl7bQ9u+r90HyPUtrpxat6y+lZDEzh7kqg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=r9p3v7yakwtBoXrdQVoWAjiJv+XoyD2QZsrhctuL3ovZBQ8PxOB0FXXpHFKLhjFB/
	 mnhp+IeQFQB2Vws6LQsNypbHsZhB5lSjD9JWIcppthXTehZlmCLvN57T8utdYQcqNP
	 34h5f4i3OnQaEDX6m7GMMuJkzK2KsKttga7HgtrFKdk2B5o0cgRoUUDAwCNK8Gn3NF
	 TrFdXacO4wF15A9dVmIE9FoL0Dn0lWimMlhXMopixevgHA3QFPlq4ZGVtiRpoPKFOq
	 rJdK3V/XYNbhcdHq+kJ5u9iic7uUGIKUnQljjvpgg/n+HPeOSTMjURwCPhq1ntWPnq
	 ahXHILaUwO8zg==
Date: Thu, 17 Apr 2025 08:04:22 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Mark Bloch <mbloch@nvidia.com>
Cc: Henry Martin <bsdhenrymartin@gmail.com>, saeedm@nvidia.com,
 leon@kernel.org, tariqt@nvidia.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 michal.swiatkowski@linux.intel.com, amirtz@nvidia.com,
 netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 2/2] net/mlx5: Move ttc allocation after switch case
 to prevent leaks
Message-ID: <20250417080422.6a22ff04@kernel.org>
In-Reply-To: <817d5a9f-63c0-40b2-8e97-4a29185c0455@nvidia.com>
References: <20250416092243.65573-1-bsdhenrymartin@gmail.com>
	<20250416092243.65573-3-bsdhenrymartin@gmail.com>
	<817d5a9f-63c0-40b2-8e97-4a29185c0455@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 16 Apr 2025 15:02:13 +0300 Mark Bloch wrote:
> On 16/04/2025 12:22, Henry Martin wrote:
> > Relocate the memory allocation for ttc table after the switch statement
> > that validates params->ns_type in both mlx5_create_inner_ttc_table() and
> > mlx5_create_ttc_table(). This ensures memory is only allocated after
> > confirming valid input, eliminating potential memory leaks when invalid
> > ns_type cases occur.
> 
> Reviewed-by: Mark Bloch <mbloch@nvidia.com>

A bit hard to see from the context but I'm guessing this fixes 
a memory leak? We need a Fixes tag..

reminder: please trim your replies
-- 
pw-bot: cr

