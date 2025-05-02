Return-Path: <linux-kernel+bounces-629048-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ECFCAA66C3
	for <lists+linux-kernel@lfdr.de>; Fri,  2 May 2025 01:00:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 47CCE4C6A7B
	for <lists+linux-kernel@lfdr.de>; Thu,  1 May 2025 23:00:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36E50265CCB;
	Thu,  1 May 2025 22:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="XptMGTX6"
Received: from omta040.useast.a.cloudfilter.net (omta040.useast.a.cloudfilter.net [44.202.169.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D951C253347
	for <linux-kernel@vger.kernel.org>; Thu,  1 May 2025 22:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.202.169.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746140261; cv=none; b=SQF1269hhwKfGrQMyjpxS/qRDxg82ed2iNs6aY5SAdYek3MdpJTHlqwvRly86NyKJV+82jIOdcmFPso8ASYwW47tBBNawMiKVBCFW0WgJFmcT+FCPm2F8g0GXsAjTD+OwzHo7Ds4CrtyirsNsEYD0tgtZyj/4TAC6w6WKW8MQ8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746140261; c=relaxed/simple;
	bh=3zxHWlX0tDp2KZ/yT11dmKAtfvinwG+gf88s7SisIbw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mdvH33hhsL1VtFR7SzbzdJGvhUN165ei+x3xz1dJG+fJZHkDecM7dLjsdk4+Eg7KdE4awzqll1pZzSI2ivMiPZZklfIJdu56m8F9wJpcpxuxF4FB9SPtqyZH9Br26usS2hfxhX3P0oLwKBUeyeIDBZRPGbnafmRM2ciEh/aBcLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com; spf=pass smtp.mailfrom=embeddedor.com; dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b=XptMGTX6; arc=none smtp.client-ip=44.202.169.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=embeddedor.com
Received: from eig-obgw-6004a.ext.cloudfilter.net ([10.0.30.197])
	by cmsmtp with ESMTPS
	id AYfjuMMENVkcRAcqRu5UeC; Thu, 01 May 2025 22:57:31 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id AcqQuSd1YRlrsAcqRuNCxS; Thu, 01 May 2025 22:57:31 +0000
X-Authority-Analysis: v=2.4 cv=Qamtvdbv c=1 sm=1 tr=0 ts=6813fc5b
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=efVMuJ2jJG67FGuSm7J3ww==:17
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=7T7KSl7uo7wA:10 a=VwQbUJbxAAAA:8
 a=C667ouF_f8g6uxj60aYA:9 a=QEXdDO2ut3YA:10 a=Xt_RvD8W3m28Mn_h3AK8:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=W43Qa61YR17du0yXnoQXN2+FWM5SOwP9auDcLsuj2ck=; b=XptMGTX6C0VdVC6rtZreaDYrbn
	LLUV4n+MSuODYrnrsaNDO3vhr2VMZUZhMKZ+KOl4Ld5Xi37iL26upGA2hPojK/jmlF0SG8XWwKIWF
	bs611xEM/+Ql3w+SxU6/Oenn50KXqKSU6ip2ej0cGuFsEit+mZ+GYfvk2D1S7gc0Gr9eyzUIxezAy
	yOSaCmwIbI7pGbz5QtKyyExiCL6MXz09zcNV0x6eNkpSzaxHligAP4N6ghKo5S+m7HjLa0RXpbHOS
	t/TjXvzdG2C6hQ6S0oImOFCKCr6vspxnFvE0Djdun+wan2eiVbyCF3wXkQ4rakHAUmhhr0RXyoep8
	Fnwqzj5w==;
Received: from [177.238.17.151] (port=17926 helo=[192.168.0.101])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.98.1)
	(envelope-from <gustavo@embeddedor.com>)
	id 1uAcqQ-00000003mgg-24Q5;
	Thu, 01 May 2025 17:57:30 -0500
Message-ID: <a9c0ab40-6907-46d8-9107-7afe2f1782ca@embeddedor.com>
Date: Thu, 1 May 2025 16:57:24 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH][next] overflow: Fix direct struct member initialization
 in _DEFINE_FLEX()
To: Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org
References: <aBK2TUEeQfCFop9Y@kspp> <202505011315.AC9590F@keescook>
Content-Language: en-US
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <202505011315.AC9590F@keescook>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 177.238.17.151
X-Source-L: No
X-Exim-ID: 1uAcqQ-00000003mgg-24Q5
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.0.101]) [177.238.17.151]:17926
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 1
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfENhV3IjuhFWPIKYQjl6h3y1niZsXa1egALJ35DdcSL9wh85ADshOS1e1atdqeN/3+jQLRNZowobjkKyyTEd7/1AuMU+6wroVMAx7iQsCvbWvilA66uQ
 n734oMvRkug/FmmfNHdfYkf80N7ZB5e8yOZCChyiiuhp7B5gQmiiVV4Xyv/DpRk28xRGoXBJFucTXMjDS6nThLCsZvmrqkgBBGMEzNwm3vCXci/OXu+4Ihz1


> Earlier up in the file:
> 
> ...
>   * @initializer: initializer expression (could be empty for no init).
>     ^^^^^^^^^
>   */
> #define _DEFINE_FLEX(type, name, member, count, initializer...)
> 
> This argument now becomes required, which is fine, but we should keep

Nice catch!

> the docs updated and double check any existing "_DEFINE_FLEX" users that
> may have an empty final argument (I don't see any, so that's nice).

Yep, I build-tested it and saw no errors.

> 
>>   	union {									\
>>   		u8 bytes[struct_size_t(type, member, count)];			\
>>   		type obj;							\
>> -	} name##_u initializer;							\
>> +	} name##_u = { .obj initializer };					\
>>   	type *name = (type *)&name##_u
>>   
>>   /**
>> @@ -444,7 +444,7 @@ static inline size_t __must_check size_sub(size_t minuend, size_t subtrahend)
>>    * elements in array @member.
>>    */
>>   #define DEFINE_FLEX(TYPE, NAME, MEMBER, COUNTER, COUNT)	\
>> -	_DEFINE_FLEX(TYPE, NAME, MEMBER, COUNT, = { .obj.COUNTER = COUNT, })
>> +	_DEFINE_FLEX(TYPE, NAME, MEMBER, COUNT, = { .COUNTER = COUNT, })
>>   
>>   /**
>>    * STACK_FLEX_ARRAY_SIZE() - helper macro for DEFINE_FLEX() family.
> 
> But otherwise, yes, let's do this!
> 

Here you go :)

https://lore.kernel.org/linux-hardening/aBP0b3gfurLFDlwY@kspp/

Thanks!
-Gustavo

