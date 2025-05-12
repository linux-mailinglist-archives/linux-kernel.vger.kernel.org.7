Return-Path: <linux-kernel+bounces-644275-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 05822AB39C2
	for <lists+linux-kernel@lfdr.de>; Mon, 12 May 2025 15:55:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 92399189AC80
	for <lists+linux-kernel@lfdr.de>; Mon, 12 May 2025 13:56:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 625BD1DDA15;
	Mon, 12 May 2025 13:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ph0n4Z4j"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C04B51B3956;
	Mon, 12 May 2025 13:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747058142; cv=none; b=TGCN/q1mSM6MXh1Z1Ze7id0eL2olXxRDEQ8is7ioShx3nUlxcE6isPPVcryetxp+d+Y1mFTINXe4JgF7oFgzEZwdlP6kzAa1VcVMIWigwgqAgwGJ86LCdVZhnU95Oq8boCCGMruL0/s2EwyAcUehuMKZqgW9hX/2n9V15UM/iE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747058142; c=relaxed/simple;
	bh=24J21/1awOaCRkauifQ2tj+KnyZc93pUCOyEwIsEvDM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HrY0G4xDVF2WvHwaTvkdeNRTTy/SKRk6SH99i5WJPQ6haxtqzknepsBTuZTgKBuYRCws+JqDCALUUMv0n3F4ztDng3C9yErjcct9JeMlBcKxWJ1JpjjK1PyRTlEz2dzF7MKscWhTRSdg3uN1dQ9g9/GIzyC8iu1n0Sw0K3cVczQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ph0n4Z4j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CE10C4CEE7;
	Mon, 12 May 2025 13:55:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747058142;
	bh=24J21/1awOaCRkauifQ2tj+KnyZc93pUCOyEwIsEvDM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ph0n4Z4jiAGLtVBlNlMYFXv8KmM8vrITAPGHea2l11uNRrg8+6vov/QrTCvkuniQ5
	 4BdkDfPDxPHwCmYWvH7RDenMO094i/lMsDuQEaMN9WrNJiTfL9GEVRrtze1bAqmk6U
	 ncBuDr2x8iGiSyotVTd1yG8cTSg/VKT6WbXOfpyZRvaxY+mbloqKi2DINwZWJ0NrUb
	 mnNj95mYYDkPZBy41WQ45QQv4MV61VDFgKpL34HL9R7cZi1Mrx+KcAC4QnwIpKWXrn
	 1a0ms+vK/vQaXNNJFzvNqoIprqniCsHmo8BxekFD6AsPt2tAnLzoLqQm7BHLi4VXyD
	 j5f+l3VM24vQw==
Date: Mon, 12 May 2025 14:55:38 +0100
From: Simon Horman <horms@kernel.org>
To: Raju Rangoju <Raju.Rangoju@amd.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, Shyam-sundar.S-k@amd.com
Subject: Re: [PATCH net-next v3 1/5] amd-xgbe: reorganize the code of XPCS
 access
Message-ID: <20250512135538.GC3339421@horms.kernel.org>
References: <20250509155325.720499-1-Raju.Rangoju@amd.com>
 <20250509155325.720499-2-Raju.Rangoju@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250509155325.720499-2-Raju.Rangoju@amd.com>

On Fri, May 09, 2025 at 09:23:21PM +0530, Raju Rangoju wrote:
> The xgbe_{read/write}_mmd_regs_v* functions have common code which can
> be moved to helper functions. Add new helper functions to calculate the
> mmd_address for v1/v2 of xpcs access.
> 
> Signed-off-by: Raju Rangoju <Raju.Rangoju@amd.com>
> ---
> Changes since v2:
> - follow reverse Xmass tree ordering
> - line wrap to 80 columns wide

Reviewed-by: Simon Horman <horms@kernel.org>


