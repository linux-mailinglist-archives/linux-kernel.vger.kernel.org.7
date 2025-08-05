Return-Path: <linux-kernel+bounces-757005-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C5E83B1BC2B
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 23:55:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 856D73BBA4F
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 21:54:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0FC82566F2;
	Tue,  5 Aug 2025 21:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="aEqUC350"
Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 849A2242D6C
	for <linux-kernel@vger.kernel.org>; Tue,  5 Aug 2025 21:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754430733; cv=none; b=VRZDKrg5no6kOd2Vf9qkTJTZ8vxs2EvtG/5CzjKfrnmOZGmiuo6q/ZZKAsqSIEBwFjpeo2qRoiIh+Rhf1dLiPw6FbB04iV6kmVmk13FAH2Tsy4sxULHIKADGO08FkzRvbHY7b0KRzcuRN9tCAULINpAqa0UNaQuqLroQekWEBfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754430733; c=relaxed/simple;
	bh=hG5Y30wd83h9+pD3BiZT1GBMxjZg8Zy6Scpnuc/Lo1k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WpXQYLg4dOmU4XIzwXuSMUrN0MugoZWYCSgpGVw6t8tPLnaB2IS0xL/AEptdzT+fDw9uHpFCE6ZRixuTX7tHpiGJNp96dGKfl5yttS57EoI2FeJKJTPznMY5rv+xEnG0Bt6LoKsyKaY9InnvbpYBGBsgUlAPqoHF0ljs03Ma3As=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=aEqUC350; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <9557ecbe-ea07-45f0-b467-151e61054e02@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1754430728;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Cs+bWnDOx/OJlqb35VzN1pjD3ZJ8uXX7M0AUIGNqQOM=;
	b=aEqUC350CjsrAOmJYdvVHpBrh8GxezYaONvLR0O3149K+tfs3IFcLivu7Yw6GiDN1PucOa
	09DVc1S4nS5ljjCOdLJxqL9Cuy0D8Zgm2u5LlQEX3LP5QVzeHka6aoFue2D4T2oq5hAaZQ
	LUHBbCQUbpyW8sT7sZoJ6qA+xM/rs2k=
Date: Tue, 5 Aug 2025 17:52:04 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next v4 6/7] net: axienet: Rearrange lifetime
 functions
To: Andrew Lunn <andrew@lunn.ch>
Cc: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Michal Simek <michal.simek@amd.com>,
 Leon Romanovsky <leon@kernel.org>
References: <20250805153456.1313661-1-sean.anderson@linux.dev>
 <20250805153456.1313661-7-sean.anderson@linux.dev>
 <69b08e90-ae99-43fd-9779-dd5497a26e1f@lunn.ch>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Sean Anderson <sean.anderson@linux.dev>
In-Reply-To: <69b08e90-ae99-43fd-9779-dd5497a26e1f@lunn.ch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 8/5/25 17:32, Andrew Lunn wrote:
> On Tue, Aug 05, 2025 at 11:34:55AM -0400, Sean Anderson wrote:
>> Rearrange the lifetime functions (probe, remove, etc.) in preparation
>> for the next commit. No functional change intended.
> 
> There is a lot going on in this patch. Can it be broken up a bit more?
>
> The phase "No functional change intended" generally means, its the
> same code, just in a different place in the files. This is not true of
> this patch.

Sorry, at one point that was true and then I made a some edits. I will
update the commit message.

>> +struct axienet_common {
>> +	struct platform_device *pdev;
>> +
>> +	struct clk *axi_clk;
>> +
>> +	struct mutex reset_lock;
> 
>>  static inline void axienet_lock_mii(struct axienet_local *lp)
>>  {
>> -	if (lp->mii_bus)
>> -		mutex_lock(&lp->mii_bus->mdio_lock);
>> +	mutex_lock(&lp->cp->reset_lock);
> 
> This lock is different to the bus lock. This is definitely not a "no
> functional change".
> 
> Please make this lock change a patch of its own, with a good commit
> message which considers the consequences of this change of lock.

OK

>>  		if (!np) {
>> -			dev_err(dev, "pcs-handle (preferred) or phy-handle required for 1000BaseX/SGMII\n");
>> -			ret = -EINVAL;
>> -			goto cleanup_mdio;
>> +			dev_err(dev,
>> +				"pcs-handle (preferred) or phy-handle required for 1000BaseX/SGMII\n");
>> +			return -EINVAL;
> 
> That looks like a whitespace change. This is a "No functional change
> intended" sort of patch. You can collect all such whitespace changes
> into one patch.

The main purpose of that hunk is to remove the `goto cleanup_mdio`. The
dev_err change is just because I was "in the area".

>>  		}
>>  		lp->pcs_phy = of_mdio_find_device(np);
>> -		np1 = of_find_node_by_name(NULL, "lpu");
>> +		np1 = of_find_node_by_name(NULL, "cpu");
> 
> Interesting. Maybe you should review your own patches.

Will do.

--Sean

