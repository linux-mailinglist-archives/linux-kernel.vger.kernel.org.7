Return-Path: <linux-kernel+bounces-866296-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D57E4BFF691
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 08:52:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 147754FF3B3
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 06:48:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8664135B135;
	Thu, 23 Oct 2025 06:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="fCwXDP1y"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAEA1DDC3
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 06:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761202035; cv=none; b=mTlY2HIWtUrMjXLTW0gv46HK7Ed8yZwIGV+4kWimysgWYCDWRyHiqm9VS18GynAyM3eayvLe2v+Y5c6+naVjan1Vnqv9uByem2TOc1JC0yHDvPcGFA5pLb7Lhc6fEYrALx8spvhBP+BYhb2sObEMiI/otAwFpWHGeEqM96835jM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761202035; c=relaxed/simple;
	bh=BzR5m1+AmBuGphCU8penEcnDwTh4kg2CeNuytCu0c5Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DaoQMKNmh4hXqHupvwpya9WfDjFKCfb45whgZRS5UAstXba3Nd9/6xrFb3XHx5R+g8xQIs1XNhY/X/TwgvQelZqfxIYtQVn3rUXIUhRL5rPHIeEchpHj/BU8frXQKrkdJHp4ldurRzZUPK5pv2Dj5wlcCWv/tJLx8aIdE9JaSxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=fCwXDP1y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCC4CC4CEE7;
	Thu, 23 Oct 2025 06:47:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1761202035;
	bh=BzR5m1+AmBuGphCU8penEcnDwTh4kg2CeNuytCu0c5Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fCwXDP1ySFokjA21zlXSKIg4Yf+1aCZrzpMzIUQUxzNZOMoQx+ntQECQuXKDKmAmZ
	 pID1KlzJAGeBx8jmLZi3u0VCi1PNpmXJhbkC5Rtf6tmIDjUy6UMBT8TzdpHRKtjLJI
	 2lgzPyL4ek8hMgup65yrJBam7FofSdvSRdyAs67s=
Date: Thu, 23 Oct 2025 08:47:12 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Tariq Toukan <tariqt@nvidia.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>, linux-kernel@vger.kernel.org,
	Mark Bloch <mbloch@nvidia.com>, Gal Pressman <gal@nvidia.com>,
	Aya Levin <ayal@nvidia.com>, Saeed Mahameed <saeedm@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>, Simon Horman <horms@kernel.org>,
	Shay Drory <shayd@nvidia.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Parav Pandit <parav@nvidia.com>, Amir Tzin <amirtz@nvidia.com>
Subject: Re: [PATCH net] driver core: auxiliary bus: Fix sysfs creation on
 bind
Message-ID: <2025102355-abstract-subgroup-aa97@gregkh>
References: <1761200367-922346-1-git-send-email-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1761200367-922346-1-git-send-email-tariqt@nvidia.com>

On Thu, Oct 23, 2025 at 09:19:27AM +0300, Tariq Toukan wrote:
> From: Amir Tzin <amirtz@nvidia.com>
> 
> In case an auxiliary device with IRQs directory is unbinded, the
> directory is released, but auxdev->sysfs.irq_dir_exists remains true.
> This leads to a failure recreating the directory on bind [1].
> 
> Using the attributes group visibility interface, expose the IRQs
> attributes group if"f the xarray storing IRQs entries is not empty. Now
> irq_dir_exists field is redundant and can be removed.
> 
> [1]
> [] mlx5_core.sf mlx5_core.sf.2: mlx5_irq_affinity_request:167:(pid 1939):
>    Failed to create sysfs entry for irq 56, ret = -2
> [] mlx5_core.sf mlx5_core.sf.2: mlx5_eq_table_create:1195:(pid 1939):
>    Failed to create async EQs
> [] mlx5_core.sf mlx5_core.sf.2: mlx5_load:1362:(pid 1939):
>    Failed to create EQs
> 
> Fixes: a808878308a8 ("driver core: auxiliary bus: show auxiliary device IRQs")
> Signed-off-by: Amir Tzin <amirtz@nvidia.com>
> Reviewed-by: Mark Bloch <mbloch@nvidia.com>
> Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
> ---
>  drivers/base/auxiliary.c       |  13 +++-
>  drivers/base/auxiliary_sysfs.c | 117 +++++++++++++++++++++++++--------
>  include/linux/auxiliary_bus.h  |  26 ++++++--

Why would auxbus patches go through the net tree?

confused,

greg k-h

