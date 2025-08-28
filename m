Return-Path: <linux-kernel+bounces-790081-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E14B7B39F10
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 15:35:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6AD33188756D
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 13:35:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BF551DC9B5;
	Thu, 28 Aug 2025 13:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="aMuhdMc9"
Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96C451D63D8
	for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 13:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756388107; cv=none; b=DzQUFwpQhJy6D6XzE82Ec5QYwjqFLaMvLxgf38O3vsBDxVNn2ARWL9TlFpN1OnV8mrz+vlngj2VV6iVgEog5B+GaQHRc5vy+wfKqcpMfyjLqx3XjFQu9UeR9riCGtXjsjHmnl/r8uxeUf1DuZxfg4ObAddOrKPEckxffY3s93eg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756388107; c=relaxed/simple;
	bh=OfgCgq7zlRlpYjhEMCKndHxIYx10att5Gm8gFGs1y3w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hPWQA1NiJtLUkCqKwE8zlNG/aHPIOkS+uOkYnKQRRcfiz0mD7Ze3INojNNq1RSwsb7GqWxD1sMpjZ8m6R5xNFs8DHGbn9MHOVMhM8/SOktSxA3wHerie8r3Fc3Ec91vvhEpgT3gf1eCZXrPjr97ekX4oBqybtLKCkrVPiqGPIj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=aMuhdMc9; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <1aba83c1-2c5a-4793-bbe9-186159790024@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1756388101;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6gv1KSKTX4neHksXd95okg0M683W0/ZW6i1hVl5Fht0=;
	b=aMuhdMc9/gB7AB3jWZ5Jl4stMvweouH3Nde/lbTgzxTTx4dcXUAi5Neur+wziZlj1o5Zms
	QgVm+V90OHleA5/mamLxVlIa5JxhwOQ2auCDe7iZwpAYGNmqT0kTgUlNVgmTBq26L77Sa7
	I3PMeEiVlryZziJvMpiXlbLF5mnjjZc=
Date: Thu, 28 Aug 2025 14:34:53 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net 2/3] net: stmmac: correct Tx descriptors debugfs
 prints
To: Konrad Leszczynski <konrad.leszczynski@intel.com>, davem@davemloft.net,
 andrew+netdev@lunn.ch, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 cezary.rojewski@intel.com, sebastian.basierski@intel.com,
 Piotr Warpechowski <piotr.warpechowski@intel.com>
References: <20250828100237.4076570-1-konrad.leszczynski@intel.com>
 <20250828100237.4076570-3-konrad.leszczynski@intel.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20250828100237.4076570-3-konrad.leszczynski@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 28/08/2025 11:02, Konrad Leszczynski wrote:
> From: Piotr Warpechowski <piotr.warpechowski@intel.com>
> 
> It was observed that extended descriptors are not printed out fully and
> enhanced descriptors are completely omitted in stmmac_rings_status_show().
> 
> Correct printing according to documentation and other existing prints in
> the driver.
> 
> Fixes: 79a4f4dfa69a8379 ("net: stmmac: reduce dma ring display code duplication")
> Reviewed-by: Sebastian Basierski <sebastian.basierski@intel.com>
> Reviewed-by: Cezary Rojewski <cezary.rojewski@intel.com>
> Signed-off-by: Piotr Warpechowski <piotr.warpechowski@intel.com>
> Signed-off-by: Konrad Leszczynski <konrad.leszczynski@intel.com>

Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>

