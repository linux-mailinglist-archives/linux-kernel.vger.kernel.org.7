Return-Path: <linux-kernel+bounces-789888-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 344DBB39C31
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 14:06:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 39E733B6E75
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 12:06:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B82DB30F54E;
	Thu, 28 Aug 2025 12:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="xClLXYSf"
Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E404330F545
	for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 12:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756382778; cv=none; b=IDl2dwSho4IwUQdAUrPJ1mHuwgLNjsdshWM0jWRkvywQl35+elWXPgP25KTq9Sb1jBmi4u5QKL338S9yPf6PdQYVK4UvDl07YmuGUvIIfOk0hF7dV8VfJ6BH9I+4zMOLPdrcKJqGu5s7aQgPSroSxUoN0rgH1B24EzU9kCyHYeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756382778; c=relaxed/simple;
	bh=u8rEJf5zKJXsNuVAQ+4r/lMzldLPRV7Bc6LFRRi/Fi0=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=jHyLbaWVzv4PaoyUZHVr4uc2N/GCe9pBysccQjlz2O0AqPHXijIJ72/pwcl4TNMNhtg4dn02+Sizgwct1erHX95lp2mQ2OTteqHQZU267fbLeXR/aWx+i4Xz0Dr84ovQyithGVzj2W/V4QEMKs1lbYndm/osqpv/g6zev3cRPbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=xClLXYSf; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <11d46e56-b8d9-4776-9969-d3767d8cda41@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1756382764;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4lf9KRuU3XqjH9s/P98ePLTJLe34Mktbt6oDMXgNk/4=;
	b=xClLXYSf4+Y47SMAxpPCJbn6XmGzs3dIcquE8NJLfEPLm3/qz+X/1yTkBgXhVxika8ThH3
	lsRaGUbO+SUI5mHC1mu87EeBMwd5zKFveKVZbK3cxJCrFE1pNVIWRmTlRO9W1F9fgfjpk9
	qoOf/I6JzQnTzROTIOnNmnMuWXhMosw=
Date: Thu, 28 Aug 2025 13:05:55 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] net: ethernet: ti: Prevent divide-by-zero in
 cpts_calc_mult_shift()
To: Miaoqian Lin <linmq006@gmail.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Thomas Gleixner <tglx@linutronix.de>,
 Grygorii Strashko <grygorii.strashko@ti.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
References: <20250828092224.46761-1-linmq006@gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20250828092224.46761-1-linmq006@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 28/08/2025 10:22, Miaoqian Lin wrote:
> cpts_calc_mult_shift() has a potential divide-by-zero in this line:
> 
>          do_div(maxsec, freq);
> 
> due to the fact that clk_get_rate() can return zero in certain error
> conditions.

Have you seen this happening in the real environment, or is it just
analysis of the code? I don't see a reason for these "certain error
conditions" to happen...

