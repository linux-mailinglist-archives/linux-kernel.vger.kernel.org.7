Return-Path: <linux-kernel+bounces-792122-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A78CB3C072
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 18:17:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2EFC51C80470
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 16:18:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15085322DAA;
	Fri, 29 Aug 2025 16:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="SJByZQBy"
Received: from omta40.uswest2.a.cloudfilter.net (omta40.uswest2.a.cloudfilter.net [35.89.44.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B80DEACD
	for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 16:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.89.44.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756484252; cv=none; b=U5SYhRBWyauh6qmqMRqXGiCsRfNFs98OiSpUYwV0zdZqOh1VyN5R3EQj+/PN0LJbw2HZpK/0YqhSDilC72wTiBAaM2AWaXYDhmJQMW08usumdPwyw89pULt2uGkyMwULlpFhTYVWMLZelz+FMTszDY6B9yGnll5tbRnQ2jnbAns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756484252; c=relaxed/simple;
	bh=KLt4H1dAsH4m3W8wq5f1JTt1awfasu+AhMOuE6RzBOs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aXmFblvBpZLBzYu1zKJiWP+cqWo6MyuOQr58eTOqUjtYWaFJauPJweZcYLoVVzsG5r8tyvvU7593e7mCais+EhPVWMiK2p8mZloTSY2PwjYY+Oq7vXsdDU+ZvBOLUf29pOHznHnuy7UKc92CadhQbMvbbJEye6fUyAob0jmiV2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com; spf=pass smtp.mailfrom=embeddedor.com; dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b=SJByZQBy; arc=none smtp.client-ip=35.89.44.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=embeddedor.com
Received: from eig-obgw-5002b.ext.cloudfilter.net ([10.0.29.226])
	by cmsmtp with ESMTPS
	id s0gKus0SW17jAs1n2ugY6R; Fri, 29 Aug 2025 16:17:24 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id s1n0uNEhHrnsYs1n1uDXQ2; Fri, 29 Aug 2025 16:17:23 +0000
X-Authority-Analysis: v=2.4 cv=OLkn3TaB c=1 sm=1 tr=0 ts=68b1d293
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=DR2cKC/DEnBA9KqqjaPhpA==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=7T7KSl7uo7wA:10 a=VwQbUJbxAAAA:8
 a=TsAxZPKnxnV8R9QPSkIA:9 a=QEXdDO2ut3YA:10 a=xYX6OU9JNrHFPr8prv8u:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=jd58pSIsv1e0sCZpmSVms3HbnYFises5DmnzMNo/SI0=; b=SJByZQByYNRohejkbnYICwqHak
	TIIvcUIMXBt+mCHl5aDfJpFVL2rFm94Zbg4XvBhPkyDWY9G9Rhy3WX89aFk1Tb5aYDVNMrSb3+T9c
	1COE02dHTnZfIYvPFOpPH6h9ICud9ZDpbhtKwvE9dQEyrhD7V0RrR5+eMg9P97Dh9yhs7mEfDWrQs
	U/4EHXQI0qeYBMVFeVfKgcwHzh1doY3aFrkNs1trvHtUlmgtB6yA+ZeEEXfh3lclzlGq1tC5yWBkt
	KSw/AIdTghFQhFKZDbDiM5BBFbtqmTRLnRIGKI+8GvSBYOGjxgz4M4rD6guhHirdVGQ1ZghakoL7p
	v5DdgLcw==;
Received: from static-243-216-117-93.thenetworkfactory.nl ([93.117.216.243]:49788 helo=[10.28.229.44])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.98.1)
	(envelope-from <gustavo@embeddedor.com>)
	id 1us1mz-00000004L3i-0KqT;
	Fri, 29 Aug 2025 11:17:21 -0500
Message-ID: <dc494864-22c9-42a6-ba3b-f64ae753ae53@embeddedor.com>
Date: Fri, 29 Aug 2025 18:17:03 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2][next] hyperv: Avoid a hundred
 -Wflex-array-member-not-at-end warnings
To: Michael Kelley <mhklinux@outlook.com>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 "K. Y. Srinivasan" <kys@microsoft.com>,
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
 Dexuan Cui <decui@microsoft.com>
Cc: "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>
References: <aLGSlaa6Llqz7jkJ@kspp>
 <SN6PR02MB4157D4C3A66E0563A9071DF1D43AA@SN6PR02MB4157.namprd02.prod.outlook.com>
Content-Language: en-US
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <SN6PR02MB4157D4C3A66E0563A9071DF1D43AA@SN6PR02MB4157.namprd02.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 93.117.216.243
X-Source-L: No
X-Exim-ID: 1us1mz-00000004L3i-0KqT
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: static-243-216-117-93.thenetworkfactory.nl ([10.28.229.44]) [93.117.216.243]:49788
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 2
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfJhwT1kxP/UHYQNa961YY36H/D9Urx1c3NC6aRulD6ywy7KxnbN/gwE1jFl1u4rjpMikwZrSQp19I11qzuBpGOW00NoW1MAU+jXFKmacUbiYUwjvN2Ej
 Q26N64aUDhXUiACi55yPepmtvkkwroKrpjZ6z9ys9lDekMLtlRTDIgo9dGGkbiu1Tgo832Z734DWukqgdy0j9keFtsYOrO/cSdYtau6z07UxovdD4DNkomkA



On 8/29/25 18:07, Michael Kelley wrote:
> From: Gustavo A. R. Silva <gustavoars@kernel.org> Sent: Friday, August 29, 2025 4:44 AM
>>
>> -Wflex-array-member-not-at-end was introduced in GCC-14, and we are
>> getting ready to enable it, globally.
>>
>> Use the new TRAILING_OVERLAP() helper to fix 159 of the following type
>> of warnings:
>>
>>      159 ./include/linux/hyperv.h:711:38: warning: structure containing a flexible array
>> member is not at the end of another structure [-Wflex-array-member-not-at-end]
>>
>> This helper creates a union between a flexible-array member (FAM)
>> and a set of members that would otherwise follow it. This overlays
>> the trailing members onto the FAM while preserving the original
>> memory layout.
>>
>> Also, move `struct vmbus_close_msg close_msg;` at the end of
>> `struct vmbus_channel`, as `struct vmbus_channel_msginfo,` ends
>> in a flexible array member.
>>
>> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
>> --
>> Changes in v2:
>>   - Fix subject line.
>>
>> v1:
>>   - Link: https://lore.kernel.org/linux-hardening/aLGSDpi4xDjUUYVm@kspp/
>>
>>   include/linux/hyperv.h | 10 ++++++----
>>   1 file changed, 6 insertions(+), 4 deletions(-)
>>
>> diff --git a/include/linux/hyperv.h b/include/linux/hyperv.h
>> index a59c5c3e95fb..efdd570669fa 100644
>> --- a/include/linux/hyperv.h
>> +++ b/include/linux/hyperv.h
>> @@ -708,8 +708,9 @@ struct vmbus_channel_msginfo {
>>   };
>>
>>   struct vmbus_close_msg {
>> -	struct vmbus_channel_msginfo info;
> 
> It turns out that this field of struct vmbus_close_msg is never used.
> It dates back to 2011, so maybe somewhere along the way it stopped
> being used, but struct vmbus_close_msg was left unchanged.
> 
> So a better solution to the "flex-array-member-not-at-end" issue is
> to eliminate this structure entirely, and use struct
> vmbus_channel_close_channel directly in the one place where
> struct vmbus_close_msg is currently used. I've done a quick test of
> this change and I don't see any problems.
> 
> I'll submit a separate patch with my proposed change, and this
> patch can be dropped. Does that work?
Yes, please. Go for it. :)

Thanks!
-Gustavo

