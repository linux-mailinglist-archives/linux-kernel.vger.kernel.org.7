Return-Path: <linux-kernel+bounces-858014-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 5803ABE8926
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 14:22:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C1A114F5386
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 12:22:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A6CC32ABC5;
	Fri, 17 Oct 2025 12:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="stBFIijk"
Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C631B2E717D
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 12:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760703725; cv=none; b=TKcODCQQRhf2OBTvhHKW6wNqkHqQi2KVNkIWUKuMMzcUBzEVUal/HFeFLSlsqHCH8s8W1f1FyX7yl6aSvnKQ97rOGfJT3xfiKwLUg2KT6ci7Y43k+CUovS2GODQ8jUbWbkUGYzYmlQQR0nRUVy+SiYV8z/a7u9SJd4AhKEYslRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760703725; c=relaxed/simple;
	bh=p4htG76CAU6X4aXzc3hFDO91x7V/rjzHSa6bas1xNfM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gWvGw2RKSmPR1ZLCku+c+Nk5vajPASmxRJHzE54P9lAgvNNZmDOcPfOda4ezJ/GwA2WgcXhT7KigWHpxnUUbKj0H/oe4tqzfcK2m8cUwRgwgTe/b991lxxU3pgI9zHsQ23hW09PVf3E+0SE+KBhpRMExTFCW90hC0FMmpEkgxns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=stBFIijk; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <83ffc316-6711-4ae4-ad10-917f678de331@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1760703720;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Pm4SvBhyBXqqMBUE8P86/UF8WP0RkuXkSVtcysJBKDc=;
	b=stBFIijknAIaQCktEObO1xPMD1ChASDC9VZojqVyFVrqnsIFbs9oq/ezFB8rp7D4w1ms5a
	Vbg5rmvsgtccQsQwbkSfu2j94pn4HRe+HSNysIhQlWvpzgObZQbA2RgkztsgdXWT/rNVjG
	GeBghovGgUutRQLjuvLSY6O44YANHWM=
Date: Fri, 17 Oct 2025 13:21:54 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net v3 2/3] net: stmmac: Consider Tx VLAN offload tag
 length for maxSDU
To: "G Thomas, Rohan" <rohan.g.thomas@altera.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Jose Abreu <Jose.Abreu@synopsys.com>,
 Rohan G Thomas <rohan.g.thomas@intel.com>,
 Boon Khai Ng <boon.khai.ng@altera.com>
Cc: netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Matthew Gerlach <matthew.gerlach@altera.com>
References: <20251017-qbv-fixes-v3-0-d3a42e32646a@altera.com>
 <20251017-qbv-fixes-v3-2-d3a42e32646a@altera.com>
 <d7bbb7dd-ddc6-43d6-b234-53213bde71bd@altera.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <d7bbb7dd-ddc6-43d6-b234-53213bde71bd@altera.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 17/10/2025 08:36, G Thomas, Rohan wrote:
> Hi All,
> 
> On 10/17/2025 11:41 AM, Rohan G Thomas via B4 Relay wrote:
>> +    sdu_len = skb->len;
>>       /* Check if VLAN can be inserted by HW */
>>       has_vlan = stmmac_vlan_insert(priv, skb, tx_q);
>> +    if (has_vlan)
>> +        sdu_len += VLAN_HLEN;
>> +
>> +    if (priv->est && priv->est->enable &&
>> +        priv->est->max_sdu[queue] &&
>> +        skb->len > priv->est->max_sdu[queue]){
> 
> I just noticed an issue with the reworked fix after sending the patch.
> The condition should be: sdu_len > priv->est->max_sdu[queue]
> 
> I’ll send a corrected version, and will wait for any additional comments
> in the meantime.

Well, even though it's a copy of original code, it would be good to
improve some formatting and add a space at the end of if statement to
make it look like 'if () {'>
>> +        priv->xstats.max_sdu_txq_drop[queue]++;
>> +        goto max_sdu_err;
>> +    }
>>       entry = tx_q->cur_tx;
>>       first_entry = entry;
>>
> 
> Best Regards,
> Rohan
> 


