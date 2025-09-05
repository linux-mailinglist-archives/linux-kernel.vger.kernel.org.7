Return-Path: <linux-kernel+bounces-802098-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 156F8B44D9A
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 07:36:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B16F117417B
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 05:36:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 123B21E570D;
	Fri,  5 Sep 2025 05:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=konsulko.se header.i=@konsulko.se header.b="U6RueJvg";
	dkim=permerror (0-bit key) header.d=konsulko.se header.i=@konsulko.se header.b="IXh94vyA"
Received: from mailrelay-egress16.pub.mailoutpod3-cph3.one.com (mailrelay-egress16.pub.mailoutpod3-cph3.one.com [46.30.212.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0930823B609
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 05:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.30.212.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757050591; cv=none; b=GLIiDNg7ncGHWDdmOoUl+xd/iLGBgIiGFimKCtGEMxfWNBwrl6PlGVPTCz+eN+1BX2H7FnKTB8HnFUhJ4OCMUBPrv9z+2g25vRihszMMql2ibTwxgjqY+TGj8i6tkf9bbtKCLhMbN9igGjObGbIFJ+fQE2XJLHHSIxtWd/Nb7tQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757050591; c=relaxed/simple;
	bh=6jknBRFyZCyttZl2fMVMz8rouQM9SLmqAPqEkX/zc6w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ph0+/p5WgzHWZrIV07X15fo7ttFL2NnA/eoWuDfX25b8wip7G11Jg8JguUbHS6D7CmT14jsefffrhKWcihSuvk3idgp/7kLjDFBY0rdxnEiH1KUdReQZDp+SgImUl+7RmCKIXOgzcoe0s0wrThzgkTWDvX68CYwZ97lO2Cqm91A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=konsulko.se; spf=none smtp.mailfrom=konsulko.se; dkim=pass (2048-bit key) header.d=konsulko.se header.i=@konsulko.se header.b=U6RueJvg; dkim=permerror (0-bit key) header.d=konsulko.se header.i=@konsulko.se header.b=IXh94vyA; arc=none smtp.client-ip=46.30.212.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=konsulko.se
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=konsulko.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1757050581; x=1757655381;
	d=konsulko.se; s=rsa2;
	h=content-transfer-encoding:content-type:in-reply-to:from:references:cc:to:
	 subject:mime-version:date:message-id:from;
	bh=yJz2nmOPN6XlfPRfntHnHCKTk/nsiJ7oT+wmn7ndJ9g=;
	b=U6RueJvga2W0r8/6brgwvK6DLdXTlIwDtceuWCrS9SUaa4ik/QQ3Xmne0Nv9c76kpNJ1wLLK033dz
	 jUIr6IBnRFp4aN12GrixITh7VRvEPfOt+jNdeRDoHyRx6IA6FpBUse3gM1UAj9KDWGZgw6yUy+na22
	 oHjUMxjs/idk6DPy8+crvfHQJ9t8Ee2KMs+WCaPl5i97Yq3bCZ0Tp5EhLrhivNThES83WmvSaewQ9F
	 lBRYJ+0mozbtjKEpSw49o6LySGV5j0xBQ/v0Uvq37WvWSHcNgy7hU74ek+VlsZ7EjCeOR8BPgITJwZ
	 XVQcXqSUlykymAECYl9qE92NZ0JLNiw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1757050581; x=1757655381;
	d=konsulko.se; s=ed2;
	h=content-transfer-encoding:content-type:in-reply-to:from:references:cc:to:
	 subject:mime-version:date:message-id:from;
	bh=yJz2nmOPN6XlfPRfntHnHCKTk/nsiJ7oT+wmn7ndJ9g=;
	b=IXh94vyAqu9+nL4OhOa0uG7cGlT7oNYUn4pQX+fiohR4ZLrmDrJ9ym7zvejDHdIytJgNd5OCCnpfs
	 +buo4E2DQ==
X-HalOne-ID: 40416bf4-8a1a-11f0-a503-81a63d10fb2d
Received: from [192.168.10.245] (host-95-203-16-218.mobileonline.telia.com [95.203.16.218])
	by mailrelay5.pub.mailoutpod3-cph3.one.com (Halon) with ESMTPSA
	id 40416bf4-8a1a-11f0-a503-81a63d10fb2d;
	Fri, 05 Sep 2025 05:36:21 +0000 (UTC)
Message-ID: <bd3d2c7f-93a1-441c-b475-873d8d92e839@konsulko.se>
Date: Fri, 5 Sep 2025 07:36:20 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] mm: remove zpool
To: David Hildenbrand <david@redhat.com>, Vlastimil Babka <vbabka@suse.cz>,
 hannes@cmpxchg.org
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 Andrew Morton <akpm@linux-foundation.org>,
 Christoph Hellwig <hch@infradead.org>
References: <20250829162212.208258-1-hannes@cmpxchg.org>
 <20250904093325.2768507-1-vitaly.wool@konsulko.se>
 <7b1ca42d-1b89-44f4-bffb-e6b09f86fdc5@suse.cz>
 <8984f395-9043-49dd-a53d-bd344fd419bc@redhat.com>
Content-Language: en-US
From: Vitaly Wool <vitaly.wool@konsulko.se>
In-Reply-To: <8984f395-9043-49dd-a53d-bd344fd419bc@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 9/4/25 13:26, David Hildenbrand wrote:
> On 04.09.25 12:13, Vlastimil Babka wrote:
>> On 9/4/25 11:33, Vitaly Wool wrote:
>>>> With zswap using zsmalloc directly, there are no more in-tree users of
>>>> this code. Remove it.
>>>>
>>>> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
>>>
>>> Per the previous discussions, this gets a *NACK* from my side. There is
>>> hardly anything _technical_ preventing new in-tree users of zpool API.
>>> zpool API is neutral and well-defined, I don’t see *any* good reason for
>>> it to be phased out.
>>
>> AFAIK it's a policy that unused code should be removed ASAP. And 
>> that's the
>> case for zpool after Patch 1, no? It could be different if another 
>> user was
>> about to be merged (to avoid unnecessary churn), but that doesn't seem 
>> the
>> case for zblock?
> 
> Right, and
> 
>   13 files changed, 84 insertions(+), 715 deletions(-)
> 
> speaks for itself if there is no new user anticipated.

Well, there surely is.

> IIRC, we did a similar approach when we removed frontswap.
> 


