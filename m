Return-Path: <linux-kernel+bounces-605707-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 736D8A8A50D
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Apr 2025 19:10:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1596F3B7197
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Apr 2025 17:10:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E1D62192E4;
	Tue, 15 Apr 2025 17:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rosenzweig.io header.i=@rosenzweig.io header.b="c6y3umwu"
Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4559221770C
	for <linux-kernel@vger.kernel.org>; Tue, 15 Apr 2025 17:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744737050; cv=none; b=ubXODHq6AraY0fPXacxwwJzc8kaeaP3vJz/pKJ6XIFbqaGPV7K44so/5QcfFpKmRIDAYIpEsGurXcv5vwllpkgcnr/GX6wJ7GCTES5QCyQ7HSxkPr7NPMgKrNodSUYDP2M5fGX2Y5GicLNx9JNEenr0yItfgMaYBj8uDMRtR28U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744737050; c=relaxed/simple;
	bh=7afz5puaVH6rPrspnzOEfLrdKfHE6h09vxLmo8vU3m8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UPOju3I5S8rxsqD33G7pK6ReXuDUxb8A7+09Svyswv2mubbMfo06gP8iiyS5WlafEgRbykhz6+a9/IfHETHuz91hBi+JKg/nwomes4OVP/zEq+rMJ72utfMO0cxFAbsxEoWcMUUv1OdxVTPOeUHP0wjcuoTUi11xeR/aWbGftnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rosenzweig.io; spf=pass smtp.mailfrom=rosenzweig.io; dkim=pass (2048-bit key) header.d=rosenzweig.io header.i=@rosenzweig.io header.b=c6y3umwu; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rosenzweig.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rosenzweig.io
Date: Tue, 15 Apr 2025 13:10:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rosenzweig.io;
	s=key1; t=1744737045;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=l+ItDRvc2CgbELkYEQjQqulbuQxz4MyRUQS30G+nsPs=;
	b=c6y3umwuPNz+nEZojVdyszn3dB7XfYQ6DeOGO0pEcfZYHJZFEQC6gO5ZQENAnnJouRPvUL
	rUhnMlvqolEh+vEcC1cc4b7bgSH+GUDph2yh1qNZiao/yEgJp2XvIMepfstsT6bFB3+QhS
	MTA46PVnNK36GsCw0NqCSieU1jNsHRBqqc5MzIT0iNRcm+g82GQ5gFMqSCdeHlvU+gxypA
	+6oHbfKbxam8Qcqns2H0PlmeebG6aZQgmz8onhwLASMlbmXaTFSwxes+N5HMdDIjybb9od
	lPFK9bY9pBc4bVRjV+60lkAcZp0K9HG0rVT3Jd3emgWqSPifN2Dw0OL4SM8mBQ==
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Alyssa Rosenzweig <alyssa@rosenzweig.io>
To: sven@svenpeter.dev
Cc: Janne Grunau <j@jannau.net>, Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Naveen N Rao <naveen@kernel.org>,
	Andi Shyti <andi.shyti@kernel.org>, Neal Gompa <neal@gompa.dev>,
	Hector Martin <marcan@marcan.st>, linuxppc-dev@lists.ozlabs.org,
	asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org,
	Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v2 1/6] i2c: pasemi: Use correct bits.h include
Message-ID: <Z_6TENulj4zwBzfm@blossom>
References: <20250415-pasemi-fixes-v2-0-c543bf53151a@svenpeter.dev>
 <20250415-pasemi-fixes-v2-1-c543bf53151a@svenpeter.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250415-pasemi-fixes-v2-1-c543bf53151a@svenpeter.dev>
X-Migadu-Flow: FLOW_OUT

Reviewed-by: Alyssa Rosenzweig <alyssa@rosenzweig.io>

Le Tue , Apr 15, 2025 at 03:36:55PM +0000, Sven Peter via B4 Relay a �crit :
> From: Sven Peter <sven@svenpeter.dev>
> 
> When changing the #defines to use BIT and GENMASK the bitfield.h include
> was added instead of the correct bits.h include.
> 
> Reported-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> Closes: https://lore.kernel.org/asahi/Z965tVhC5jxy1kqZ@surfacebook.localdomain/
> Fixes: 8b4da3ef9206 ("i2c: pasemi: Add registers bits and switch to BIT()")
> Signed-off-by: Sven Peter <sven@svenpeter.dev>
> ---
>  drivers/i2c/busses/i2c-pasemi-core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/i2c/busses/i2c-pasemi-core.c b/drivers/i2c/busses/i2c-pasemi-core.c
> index bd128ab2e2ebb64929f2f6a3525835a880c3114d..71cc8cfc7c5cbf3924269f6217712d42008c03ff 100644
> --- a/drivers/i2c/busses/i2c-pasemi-core.c
> +++ b/drivers/i2c/busses/i2c-pasemi-core.c
> @@ -5,7 +5,7 @@
>   * SMBus host driver for PA Semi PWRficient
>   */
>  
> -#include <linux/bitfield.h>
> +#include <linux/bits.h>
>  #include <linux/module.h>
>  #include <linux/pci.h>
>  #include <linux/kernel.h>
> 
> -- 
> 2.34.1
> 
> 

