Return-Path: <linux-kernel+bounces-762937-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DA447B20C8C
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 16:50:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD9624229BD
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 14:44:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C37B32D948C;
	Mon, 11 Aug 2025 14:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hillion.co.uk header.i=@hillion.co.uk header.b="J5KoFZEO"
Received: from mx1.mythic-beasts.com (mx1.mythic-beasts.com [46.235.224.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 836A02741D1
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 14:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.224.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754923334; cv=none; b=dN5nwBvY2n111y5YMPIBisfeLxXERgHGCDaORhD4mzniM1dGlwnZLZRqYvB9o6CpmPNVlcl6t+dGI25rhJFanIHk7Q2PQg3Fefx6hXvou1CMwCM6+dgnMMg+T34VoEG2Yf12C5ppPJ0Wm62vhQAoyyYPF3N6gHP6p7rJuhQRoJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754923334; c=relaxed/simple;
	bh=U9o2H+Q0J4k2x52U2kiwTJMstpnIkm8GJPdkKyQaViw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rtOl3gTCsMwEq5mhCywS2CnuVnYv5l/qd0JYc+ovBbFYUhLauxBgRUUAfLcJO0+Nu1M8EG208kN7ph8urWfNGGKtB3y9DAF6z9ATJWNT8uKNQw5sm/m/mBfGGTFG89J4uQbssg7HFHOdY0dr6NOii9xTcqlUKzhRb3EUqpcYT54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hillion.co.uk; spf=pass smtp.mailfrom=hillion.co.uk; dkim=pass (2048-bit key) header.d=hillion.co.uk header.i=@hillion.co.uk header.b=J5KoFZEO; arc=none smtp.client-ip=46.235.224.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hillion.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hillion.co.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=hillion.co.uk; s=mythic-beasts-k1; h=Subject:To:From:Date;
	bh=U9o2H+Q0J4k2x52U2kiwTJMstpnIkm8GJPdkKyQaViw=; b=J5KoFZEOs5dzJdwzFEJpsKMAVm
	NeOYuGLdS/4pGTnLVvdLk3Ofo9FfTJxEvNosp6luCyjUuBO51v6G7SSVAieN7PjcncYiozkZg0zRZ
	xt51/RMVUCQVmoHwKMC4/cjbOGblRyAaKVUYxm/cmTSd7w3E/el3vzvGKi5y8urfhGjM/lUbh/9eY
	4w7LOBPOQs7yM5LKQ4ETx5MA4SNInASQT3ccrfnGen50iLFlLudgaWpUeP58lNUoDb8y5quqw3pRu
	0oznmi42UwGpSWVSP34vK04SYtJEohbPY47D4Yf9nB3bZn9r3Xx8PYw1uAS8UKQywTDL0e35rDHS8
	oUhwo9Vg==;
Received: by mailhub-cam-d.mythic-beasts.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <jake@hillion.co.uk>)
	id 1ulTcn-004NC3-3B;
	Mon, 11 Aug 2025 15:35:46 +0100
Date: Mon, 11 Aug 2025 15:35:05 +0100
From: Jake Hillion <jake@hillion.co.uk>
To: Andrea Righi <arighi@nvidia.com>
Cc: Tejun Heo <tj@kernel.org>, Christian Loehle <christian.loehle@arm.com>, 
	void@manifault.com, linux-kernel@vger.kernel.org, sched-ext@lists.linux.dev, 
	changwoo@igalia.com, hodgesd@meta.com, mingo@redhat.com, peterz@infradead.org
Subject: Re: [PATCH v3 3/3] sched_ext: Guarantee rq lock on scx_bpf_cpu_rq()
Message-ID: <y23etey3foin5nrxgj6e4g373b3ap6oxqa5rrvuvwyus3umw5s@bgh3d6uuga5t>
References: <20250805111036.130121-1-christian.loehle@arm.com>
 <20250805111036.130121-4-christian.loehle@arm.com>
 <aJebkj-neVJNKEJ4@slm.duckdns.org>
 <aJh6BWX7rYCNrzGu@gpd4>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aJh6BWX7rYCNrzGu@gpd4>
X-BlackCat-Spam-Score: 4

On Sun, Aug 10, 2025 at 12:52:53PM +0200, Andrea Righi wrote:
> Yeah, this is not nice, but they would be still broken though, in PATCH 1/3
> we force schedulers to check for NULL and, if they don't, the verifier
> won't be happy, so this already breaks existing binaries.

I ran some testing on the sched_ext for-next branch, and scx_cosmos is
breaking in cosmos_init including the latest changes. I believe it kicks
off a timer in init, which indirectly calls
`scx_bpf_cpu_rq(cpu)->curr->flags & PF_IDLE`. This should be NULL
checked, but old binaries breaking is pretty inconvenient for new users.

As Andrea says, this is the already merged patch triggering this.

Thanks,
Jake.

