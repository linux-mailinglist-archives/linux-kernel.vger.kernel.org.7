Return-Path: <linux-kernel+bounces-592462-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 83F74A7ED5F
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Apr 2025 21:34:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 22C3017FA51
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Apr 2025 19:29:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7745A221D90;
	Mon,  7 Apr 2025 19:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="hjIzSVH7"
Received: from omta038.useast.a.cloudfilter.net (omta038.useast.a.cloudfilter.net [44.202.169.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02C09221DAD
	for <linux-kernel@vger.kernel.org>; Mon,  7 Apr 2025 19:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.202.169.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744053583; cv=none; b=d+RA3KD8dK+gENt/fYKMXAvY6Yq05QDvc0rA72fnhtf7W93JXyyXC5euT6D54Ot860WKmNX2gKerTsIAg3MWfHeYqGD2Rtq0Zgw9WWDcZ3SCJG3qeFfZfzGOpbYfBH7D4itAWyLly93NRFx3bC4o4qKokm7JtjwaUFTtsVwyAo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744053583; c=relaxed/simple;
	bh=1eb97aqE0jFhG3ua2t4QyKh8D7yORp6TFEcJBL375y4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LqLXyKbdov/IP4r6G8/aanluQh8vRaSTF89Z8EFo2s1J2MDnhrQFDaHMLwBzUXmaL97qmwM/hoRxRYseSSGeZ3rUiWsaltZ+IDosygjxlN5Xs6mglVFVJlI8gdEEWuQY+ubJiNr5DYeB//ENTxOX9dQFjzsBhIccGQ6dmeE1UTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com; spf=pass smtp.mailfrom=embeddedor.com; dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b=hjIzSVH7; arc=none smtp.client-ip=44.202.169.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=embeddedor.com
Received: from eig-obgw-6003a.ext.cloudfilter.net ([10.0.30.151])
	by cmsmtp with ESMTPS
	id 1qIOuJ8GdiuzS1s0NuO6r7; Mon, 07 Apr 2025 19:19:35 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id 1s0Mu80qqh9Zx1s0Mu1AIK; Mon, 07 Apr 2025 19:19:34 +0000
X-Authority-Analysis: v=2.4 cv=GODDEfNK c=1 sm=1 tr=0 ts=67f42546
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=B3fuDwYyW55wTQKIj88FGw==:17
 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=7T7KSl7uo7wA:10 a=VwQbUJbxAAAA:8
 a=Ug0nj4SzLgKrA5L44zAA:9 a=QEXdDO2ut3YA:10 a=w-fa-FbTHyMX2ZhZN8In:22
 a=Xt_RvD8W3m28Mn_h3AK8:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=JhK2lbu6iQXN42On7u6Rpw+HVGph+tSr1zyAzVNzGnQ=; b=hjIzSVH7/Jyyl6og6tVF2TAT+V
	bNrcsGJcUzWTbgTx+c9gJXbpDLvETFNq+zR+GW0rFZyQDESPztw89kPD0SNChrItNOS5gstfecCOp
	MgSOpd8/1mlFDjYYeNM3EjmslvXT5OOk8qR/NWIRHqRnv+nJ9q2YfM+X4DpuqsJQgFaeolQN924Yb
	ploHdVmec2e6+5wE4hDZApcn759oG+Ja+/hKaDCyiejYLZ1L7PAeHS17uZ/ma1JoAQO87A3KS1Og+
	aYO3vCVMDnJZsis7kNJ4o0Gic8XFLCxGdeIr/SyjG4b3spCNFBljYVfJLjb+h7tfQaLUSVhnd9pBQ
	DvfwZU7w==;
Received: from [201.172.174.147] (port=38782 helo=[192.168.15.6])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.98.1)
	(envelope-from <gustavo@embeddedor.com>)
	id 1u1s0L-0000000324w-3O9x;
	Mon, 07 Apr 2025 14:19:33 -0500
Message-ID: <1d87b6b5-04cc-48a3-ac5d-3b176814a0e6@embeddedor.com>
Date: Mon, 7 Apr 2025 13:19:32 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH][next] w1: Avoid -Wflex-array-member-not-at-end warnings
To: Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org
References: <Z-WD2NP_1A0ratnI@kspp> <202504071203.1024EFE5@keescook>
Content-Language: en-US
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <202504071203.1024EFE5@keescook>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 201.172.174.147
X-Source-L: No
X-Exim-ID: 1u1s0L-0000000324w-3O9x
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.15.6]) [201.172.174.147]:38782
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 15
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfCNl5qiJkXWhb/w2ORTErJwZ6yILVWLwojDrMMHsnocSOb13PTg5qjPS1qJWTpE/WjMrDubXiwq0iR/KDKwZe9VyzsSWk9vswm7gSTDS2oOFsO/jQ012
 J0ootE461dBw5OI6SIi/3EpJ08AJsta9Je9/ilS/IxQlC3zAaOBppavbdLTMUgLNlIO5Di3FHj7SG5Q02Rts73C9rg9q3WnGAhre5FvlJ0JWieJdDS/QV6MR



On 07/04/25 13:09, Kees Cook wrote:
> On Thu, Mar 27, 2025 at 10:59:04AM -0600, Gustavo A. R. Silva wrote:
>> -Wflex-array-member-not-at-end was introduced in GCC-14, and we are
>> getting ready to enable it, globally.
>>
>> Use the `DEFINE_RAW_FLEX()` helper for on-stack definitions of
>> a flexible structure where the size of the flexible-array member
>> is known at compile-time, and refactor the rest of the code,
>> accordingly.
>>
>> So, with these changes, fix the following warnings:
>>
>> drivers/w1/w1_netlink.c:198:31: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
>> drivers/w1/w1_netlink.c:219:31: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
>>
>> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
>> ---
>>   drivers/w1/w1_netlink.c | 41 +++++++++++++++++++----------------------
>>   1 file changed, 19 insertions(+), 22 deletions(-)
>>
>> diff --git a/drivers/w1/w1_netlink.c b/drivers/w1/w1_netlink.c
>> index 691978cddab7..845d66ab7e89 100644
>> --- a/drivers/w1/w1_netlink.c
>> +++ b/drivers/w1/w1_netlink.c
>> @@ -194,16 +194,16 @@ static void w1_netlink_queue_status(struct w1_cb_block *block,
>>   static void w1_netlink_send_error(struct cn_msg *cn, struct w1_netlink_msg *msg,
>>   	int portid, int error)
>>   {
>> -	struct {
>> -		struct cn_msg cn;
>> -		struct w1_netlink_msg msg;
>> -	} packet;
>> -	memcpy(&packet.cn, cn, sizeof(packet.cn));
>> -	memcpy(&packet.msg, msg, sizeof(packet.msg));
>> -	packet.cn.len = sizeof(packet.msg);
>> -	packet.msg.len = 0;
>> -	packet.msg.status = (u8)-error;
>> -	cn_netlink_send(&packet.cn, portid, 0, GFP_KERNEL);
>> +	DEFINE_RAW_FLEX(struct cn_msg, packet, data,
>> +			sizeof(struct w1_netlink_msg));
>> +	struct w1_netlink_msg *pkt_msg = (struct w1_netlink_msg *)packet->data;
> 
> I'm starting to think we need a helper for "DEFINE_RAW_FLEX with a
> trailing structure" for these. :)
> 
> Anyway, conversion looks good... structs are packed, so alignment issues
> are unchanged.
> 
>> +
>> +	memcpy(packet, cn, sizeof(*packet));
>> +	memcpy(pkt_msg, msg, sizeof(*pkt_msg));
> 
> These could just be:
> 
> 	*packet = *cn;
> 	*pkg_msg = *msg;
> 
> But that was always true. The memcpy() style is retained. But it would
> catch type mismatches (like is accidentally introduced below).
> 
>> +	packet->len = sizeof(*pkt_msg);
>> +	pkt_msg->len = 0;
>> +	pkt_msg->status = (u8)-error;
>> +	cn_netlink_send(packet, portid, 0, GFP_KERNEL);
>>   }
>>   
>>   /**
>> @@ -215,22 +215,19 @@ static void w1_netlink_send_error(struct cn_msg *cn, struct w1_netlink_msg *msg,
>>    */
>>   void w1_netlink_send(struct w1_master *dev, struct w1_netlink_msg *msg)
>>   {
>> -	struct {
>> -		struct cn_msg cn;
>> -		struct w1_netlink_msg msg;
>> -	} packet;
>> -	memset(&packet, 0, sizeof(packet));
>> +	DEFINE_RAW_FLEX(struct cn_msg, packet, data,
>> +			sizeof(struct w1_netlink_msg));
>>   
>> -	packet.cn.id.idx = CN_W1_IDX;
>> -	packet.cn.id.val = CN_W1_VAL;
>> +	packet->id.idx = CN_W1_IDX;
>> +	packet->id.val = CN_W1_VAL;
>>   
>> -	packet.cn.seq = dev->seq++;
>> -	packet.cn.len = sizeof(*msg);
>> +	packet->seq = dev->seq++;
>> +	packet->len = sizeof(*msg);
>>   
>> -	memcpy(&packet.msg, msg, sizeof(*msg));
>> -	packet.msg.len = 0;
>> +	memcpy(packet, msg, sizeof(*msg));
> 
> This memcpy() is wrong. It should be targeting packet->data.

Ah yes! Other similar instances of this (in other subsystems) use `msg`
as an alias for the flexible structure, so it seems I instinctively
thought `packet == msg` for a moment. Thanks for catching this! :)

> 
>> +	((struct w1_netlink_msg *)packet->data)->len = 0;
> 
> And since you need it again here, I'd recommend defining a struct
> w1_netlink_msg pointer similar to the first hunk.

Right!

Thanks
--
Gustavo

> 
> -Kees
> 
>>   
>> -	cn_netlink_send(&packet.cn, 0, 0, GFP_KERNEL);
>> +	cn_netlink_send(packet, 0, 0, GFP_KERNEL);
>>   }
>>   
>>   static void w1_send_slave(struct w1_master *dev, u64 rn)
>> -- 
>> 2.43.0
>>
> 


