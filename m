Return-Path: <linux-kernel+bounces-829649-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5533BB97892
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 22:56:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F4C24A7459
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 20:56:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8EEC30BB81;
	Tue, 23 Sep 2025 20:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="UWgMXUTL"
Received: from omta036.useast.a.cloudfilter.net (omta036.useast.a.cloudfilter.net [44.202.169.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B56130ACEF
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 20:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.202.169.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758660991; cv=none; b=Qep3+Pe+ScU0RicwHfvaEPn+LVL6k2UlD9KwThV2lfwyB4CO9IzXk5JwdotZScDSHzQJAIzFcvKbJ4/w94xe6yAEsXKBmmpIEiXMspMSXQsQwPbqvO1Sc52XY/6qIPMrXoUAM/QwVjm+wNAKDujvqP5O52IX+0Ia8I0oZgPCGH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758660991; c=relaxed/simple;
	bh=slnItvOVZAE6Oav3Q8+E0oSeQYKvZKoMeqNmgYxE3s8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gEKN0lXnlpRbMcz3psuxpaeErVAF1ASuLwi+YN11iiVVV7n2x6DFBmHNDArc0GTeVPtL0K04eXK+TNv24hMjrt44biWQN5RFb7a6uFPmPvYKUUaII71z/y93GEGBZdUiMkZTR1Q5LYioCna0keJCY5osbCaQHDQoW4DR7wcVZdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com; spf=pass smtp.mailfrom=embeddedor.com; dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b=UWgMXUTL; arc=none smtp.client-ip=44.202.169.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=embeddedor.com
Received: from eig-obgw-5003b.ext.cloudfilter.net ([10.0.29.155])
	by cmsmtp with ESMTPS
	id 15b8vZGyzKXDJ1A3pvICdJ; Tue, 23 Sep 2025 20:56:29 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id 1A3ovEFAgtssb1A3ov3jbt; Tue, 23 Sep 2025 20:56:28 +0000
X-Authority-Analysis: v=2.4 cv=Hb8UTjE8 c=1 sm=1 tr=0 ts=68d3097c
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=N332or4wHRcdzxpigiEmqg==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=7T7KSl7uo7wA:10 a=VwQbUJbxAAAA:8
 a=b_psskLWchTY9WQLhBIA:9 a=QEXdDO2ut3YA:10 a=xYX6OU9JNrHFPr8prv8u:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=R1xrpqBgU5VRolmF7QTk3y42QIWpKPlrjBX+KzL4FgQ=; b=UWgMXUTL32B3ppGQ/KieJsvITO
	iVwEyvAE/fLiFemHW/d712vtKD/8quLIAqr8Ra04bZa80zyszwCpxABXejd3p2yp9m0GYxjBAJhLW
	R+qZUeb4f7TU4uoAOzA3Z5bI/gwAAEg0B/Ttizir+kOEeBOJ+9yk1Lk1m0ylwUkXM+i7GIMVWJ+GH
	4PE5qXTs2yjETMpNecS5LXOqCUnO4BZ5m0iJV2cOLRyeYmVyD3fFZjM/aPe6nT4qz0gVof7WQNW7o
	kfW5HrPuleM/rjx15pKSguLzsQ/AsB1L3nnQWfR0dh7je8ojf6cGloMUttQvhRFUJobmCsYNhprcn
	ep4BtMCA==;
Received: from [83.214.155.155] (port=52914 helo=[192.168.1.104])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.98.1)
	(envelope-from <gustavo@embeddedor.com>)
	id 1v1A3k-00000003RJX-4Bcv;
	Tue, 23 Sep 2025 15:56:25 -0500
Message-ID: <e1c9e3e5-b04f-40d0-b05b-c119cf2d3cb3@embeddedor.com>
Date: Tue, 23 Sep 2025 22:56:12 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH][next] net: airoha: Avoid -Wflex-array-member-not-at-end
 warning
To: Simon Horman <horms@kernel.org>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Lorenzo Bianconi <lorenzo@kernel.org>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
References: <aNFYVYLXQDqm4yxb@kspp> <20250923185525.GL836419@horms.kernel.org>
Content-Language: en-US
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <20250923185525.GL836419@horms.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 83.214.155.155
X-Source-L: No
X-Exim-ID: 1v1A3k-00000003RJX-4Bcv
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.1.104]) [83.214.155.155]:52914
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 13
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfCWQc72v8KPBTmHrfBokqM2z43RYQ/C+wOKwONhL3rN1Q66qb24DzNGVzjZ3bdmI2uOejqNFcld4Y5KlWf4s6vzKxf6fKZAJNnx+em6aERUCwcP7kmt2
 lESq196df4ht0CBZXEUpezRI8VUXGvIT+MRz+sqqfcM0LrQWa9yvJrRlL3w2w0h5EdxEQhl2ieQc26jxev6/nqOvGcYKE/QfdG2l8Ybv2su4j550Da7pLDrL



On 9/23/25 20:55, Simon Horman wrote:
> On Mon, Sep 22, 2025 at 04:08:21PM +0200, Gustavo A. R. Silva wrote:
>> -Wflex-array-member-not-at-end was introduced in GCC-14, and we are
>> getting ready to enable it, globally.
>>
>> Move the conflicting declaration to the end of the corresponding
>> structure. Notice that `struct airoha_foe_entry` is a flexible
>> structure, this is a structure that contains a flexible-array
>> member.
>>
>> Fix the following warning:
>>
>> drivers/net/ethernet/airoha/airoha_eth.h:474:33: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
> 
> FWIIW, I was able to reproduce this locally.
> And it goes away with this patch applied.
> 
>>
>> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
>> ---
>>   drivers/net/ethernet/airoha/airoha_eth.h | 4 +++-
>>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> Reviewed-by: Simon Horman <horms@kernel.org>

Thank you!

-Gustavo



