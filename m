Return-Path: <linux-kernel+bounces-691851-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A9EBADE974
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jun 2025 12:57:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2476C3AC491
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jun 2025 10:57:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D0AE286428;
	Wed, 18 Jun 2025 10:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aB1Uqvfh"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B667628507D;
	Wed, 18 Jun 2025 10:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750244272; cv=none; b=I5nhB0T9gGvMQnAGX8rb6MKW3mP9Bzrq1dqtfGUtdmLjtNvB/OuvrSAzbqDxc+oEIH/dhgQ93SmLBGf+OWKmoscIn+ghVnxBL82gz+2n1UQ7+FDz5k+8P+wTNAFfdn57lVxd4T4wsTElL7GaOyR/1aNZatqosmT953BePypkgw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750244272; c=relaxed/simple;
	bh=7FPcNMckWnDYeJaJFuWwe4tcNPxJxBIpdKGFGbkGluY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hje1efApFdhMy74nnEPodeVVVAPg4hXWFAw2p90QI3zVNoeo2Dl85u9fMOVCkcoNOe7PSP9ptTNPklziI34c9DbjtynR148UGtFwCozgvHrkdQjl+f/15MxNkhIFC2ido1KSgoxSFh3mTNIFHvbL2dDGg83UWYO7XorB+e0Zbm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aB1Uqvfh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A177C4CEE7;
	Wed, 18 Jun 2025 10:57:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750244272;
	bh=7FPcNMckWnDYeJaJFuWwe4tcNPxJxBIpdKGFGbkGluY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aB1UqvfhS/9mDXOqCnezBt4GmyABFdNHmZyVQ7uavLw/70R0+uM2DqDlsrsaVQJGN
	 /S2qDxdGrR3oREHmBKWnQb9xxhp2PRab8d4FrLtkuBa+Bx3zxD4dQ1LFM989va2Rci
	 gjZklXy/9svsDGf8K+iefHpmtYqC8ReGMLIr90W5Nz1fQvq7gemnEWyyYEhie3UXXv
	 039lWNICrB0dSaUTerwhg+YHLj9YaYviYwQnWoN5d6SmnYJDkb4vdHuyWBupCpjBH7
	 HiLfH055nB0wmudPBfVV7gs+kXWOzJcR1mxZrCOgkSytDOP7NazABruRcwF76NJ/It
	 SLc71zDeg+5DQ==
Date: Wed, 18 Jun 2025 11:57:47 +0100
From: Simon Horman <horms@kernel.org>
To: Jijie Shao <shaojijie@huawei.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, andrew+netdev@lunn.ch, shenjian15@huawei.com,
	wangpeiyang1@huawei.com, liuyonglong@huawei.com,
	chenhao418@huawei.com, jonathan.cameron@huawei.com,
	shameerali.kolothum.thodi@huawei.com, salil.mehta@huawei.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	michal.swiatkowski@linux.intel.com
Subject: Re: [PATCH V2 net-next 4/8] net: hns3: add \n at the end when print
 msg
Message-ID: <20250618105747.GH1699@horms.kernel.org>
References: <20250617010255.1183069-1-shaojijie@huawei.com>
 <20250617010255.1183069-5-shaojijie@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250617010255.1183069-5-shaojijie@huawei.com>

On Tue, Jun 17, 2025 at 09:02:51AM +0800, Jijie Shao wrote:
> From: Peiyang Wang <wangpeiyang1@huawei.com>
> 
> To make the print message more clearly, add \n at the and of message if
> it is missing currently.
> 
> Signed-off-by: Peiyang Wang <wangpeiyang1@huawei.com>
> Signed-off-by: Jijie Shao <shaojijie@huawei.com>

Reviewed-by: Simon Horman <horms@kernel.org>


