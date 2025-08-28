Return-Path: <linux-kernel+bounces-790047-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BBE5AB39EB0
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 15:24:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF04456454B
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 13:22:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 283C83112D4;
	Thu, 28 Aug 2025 13:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="SYzm2zhB"
Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D11C5482EB
	for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 13:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756387299; cv=none; b=Lh9UZG6bbHGhFgssSyu3Tno1ZtcGDU9aGb/JATnHbtubrr+RhhAUxxJjC5Lt6IBxslC41M1fPVg+Shom0OwGeNZmRvbxi9ZEqCjo9rcQTIcRAsE6BVBs8FwlTf7Prjo+uzu9E7OD6volxrjMx5p5I8ht/cM4C19QJKb/pqGiZIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756387299; c=relaxed/simple;
	bh=rdhnR1AylOCdlJzHvIiLfQ61T4qqNre/RTYxnlGHtww=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=K0cksJA1IBEms5zr8Fs8nyooi/W5nejcP0aRoykIxoT3s/ta5nU0sqfkeM1G3e7FWcLm1Q3gamPrk9L+x84gqQMGENt5oRVDZWXnlfihY9PupWwI6RgJ11vftJxCBnsPqrEL50trzdSLthF0SJqDmTj8WtBGBl5LyZBEWnCND04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=SYzm2zhB; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <49a2237a-840f-4233-a6c3-008311f223ba@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1756387285;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=azya1rV9NGJDwVNW9I6s+MsKBIJbdp8VhP/Y3E0L6fc=;
	b=SYzm2zhBbIWj1FuD6DlYm8U6PHZyx9pUKcKRl8hCAhDx0aeCctLpPVZWJizIvygWOsjH8v
	tzQUxb4iKIl0KwsbTIVatM9v0+/P9YUmS6g0/6C+7pJJ2tleL/pV+h9m2DDHp9hSKOAdBI
	pAgVReQTRhqtaXA2q9VzXvUNLXAffVA=
Date: Thu, 28 Aug 2025 14:21:22 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next 0/7] net: stmmac: fixes and new features
To: Konrad Leszczynski <konrad.leszczynski@intel.com>,
 Andrew Lunn <andrew@lunn.ch>
Cc: davem@davemloft.net, andrew+netdev@lunn.ch, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, cezary.rojewski@intel.com,
 sebastian.basierski@intel.com
References: <20250826113247.3481273-1-konrad.leszczynski@intel.com>
 <e4cb25cb-2016-4bab-9cc2-333ea9ae9d3a@linux.dev>
 <9e86a642-629d-42e9-9b70-33ea5e04343a@intel.com>
 <f77cb80c-d4b2-4742-96cb-db01fbd96e0e@lunn.ch>
 <240b5f17-30cd-42f4-9dcd-4d5b60aa7bec@intel.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <240b5f17-30cd-42f4-9dcd-4d5b60aa7bec@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 28/08/2025 13:51, Konrad Leszczynski wrote:
> 
> On 28-Aug-25 14:25, Andrew Lunn wrote:
>> On Thu, Aug 28, 2025 at 08:47:02AM +0200, Konrad Leszczynski wrote:
>>> On 26-Aug-25 19:29, Vadim Fedorenko wrote:
>>>> On 26/08/2025 12:32, Konrad Leszczynski wrote:
>>>>> This series starts with three fixes addressing KASAN panic on ethtool
>>>>> usage, Enhanced Descriptor printing and flow stop on TC block setup 
>>>>> when
>>>>> interface down.
>>>>> Everything that follows adds new features such as ARP Offload support,
>>>>> VLAN protocol detection and TC flower filter support.
>>>> Well, mixing fixes and features in one patchset is not a great idea.
>>>> Fixes patches should have Fixes: tags and go to -net tree while 
>>>> features
>>>> should go to net-next. It's better to split series into 2 and provide
>>>> proper tags for the "fixes" part
>>> Hi Vadim,
>>>
>>> Thanks for the review. I've specifically placed the fixes first and the
>>> features afterwards to not intertwine the patches. I can split them 
>>> into two
>>> patchsets if you think that's the best way to go.
>> https://www.kernel.org/doc/html/latest/process/maintainer-netdev.html
>>
>> You probably need to wait a week between the fixes and new features in
>> order that net and net-next are synced.
>>
>>      Andrew
>>
>> ---
>> pw-bot: cr
>>
> 
> Hi Andrew. Thanks for the heads-up. Fixes are new features are 
> independent from each other. Should I still wait a week to send out the 
> patchset containing the new features?

If they are totally independent then there is no reason to wait for a week.
But be sure to base fixes on top of net.git while features on top of
net-next.git and put appropriate prefix in the patch subject.


