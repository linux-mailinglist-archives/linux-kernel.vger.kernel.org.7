Return-Path: <linux-kernel+bounces-659241-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CC7EAC0D6F
	for <lists+linux-kernel@lfdr.de>; Thu, 22 May 2025 15:59:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 06675176C66
	for <lists+linux-kernel@lfdr.de>; Thu, 22 May 2025 13:59:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 431BB28C2BD;
	Thu, 22 May 2025 13:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="aluGZemL"
Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B4BA28C2B1
	for <linux-kernel@vger.kernel.org>; Thu, 22 May 2025 13:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747922355; cv=none; b=LFOO0zlsQws5Zp3nonFHsgygnSMN6EMxyFRi1XMx5ow4Q/l+sydBiyBs43AYBptRb2VjhgsRvZqkFMxOMjID+Uz5W+l0q/92g7bei0bg9RKNrBIimTxFvbjFL03/SpeB0QfvnlHOHCd/RqELW6ZPcbd1bYz5O6U8Qz+WvyUf72k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747922355; c=relaxed/simple;
	bh=VgVZFlJbbO8gVWDD6POpyMTYahmpyFKPPKnI3MI5cv0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dXyOdUxWfn0O+PQjrQWKaxrLPwRVtJG7hq9eSm0P6D9Lvs6Ij0dcnP9WNMq2DietmwlARoFWEENJhbXwncXAMQ0oWNoAY9RZtafD0clWm3x6glzpWyeL0U5XQCKhfVgrwkOMBXPMK4Lh1FFnlCsdu1/hgzNeOuJB2b8CYXNG+9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=aluGZemL; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <85c18336-f029-457c-ad75-ab15e05050ee@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1747922340;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JfrNA2h8hoGkFc6ifKeWxZfX62Ca0zc75XtAmNAQVYc=;
	b=aluGZemLvtjhu5NzJhDxB1gLzpUuYUkED7TS83WodjXzigil4zgly0i3wZAE0Vyo3857Bb
	1HfsO0l3tyFU7EIcFjVSwP7kcKjnyZlrEu2yCzTmc9fz7BkShJlmvxzMN3hqzyv1SsnlsD
	FodZEs9hKRLdC6XPoc+Y3sZgosxGaCM=
Date: Thu, 22 May 2025 21:58:41 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [RESEND PATCH 1/1] netfilter: load nf_log_syslog on enabling
 nf_conntrack_log_invalid
Content-Language: en-US
To: Florian Westphal <fw@strlen.de>
Cc: Pablo Neira Ayuso <pablo@netfilter.org>, Lance Yang
 <ioworker0@gmail.com>, kadlec@netfilter.org, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 coreteam@netfilter.org, linux-kernel@vger.kernel.org,
 netfilter-devel@vger.kernel.org, Zi Li <zi.li@linux.dev>
References: <20250514053751.2271-1-lance.yang@linux.dev>
 <aC2lyYN72raND8S0@calendula> <aC23TW08pieLxpsf@strlen.de>
 <6f35a7af-bae7-472d-8db6-7d33fb3e5a96@linux.dev> <aC4aNCpZMoYJ7R02@strlen.de>
 <1c21a452-e1f4-42e0-93c0-0c49e4612dcd@linux.dev> <aC7Fg0KGari3NQ3Z@strlen.de>
 <ac51507e-28ca-404d-a784-7cc3721ee624@linux.dev>
 <0e89bc09-c0ee-49d0-bbde-430cca361fd6@linux.dev> <aC8keoPd6oj4-zIV@strlen.de>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Lance Yang <lance.yang@linux.dev>
In-Reply-To: <aC8keoPd6oj4-zIV@strlen.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 2025/5/22 21:19, Florian Westphal wrote:
> Lance Yang <lance.yang@linux.dev> wrote:
>> Does this helper look correct?
> 
> Yes, but ...
>> /**
>>    * nf_log_is_registered - Check if NF_LOG is registered for a protocol
>>    * family
>>    *
>>    * @pf: protocol family (e.g., NFPROTO_IPV4)
>>    *
>>    * Returns true if NF_LOG is registered, false otherwise.
>>    */
>> bool nf_log_is_registered(int pf)
>> {
>>           struct nf_logger *logger;
>>
>>           logger = nf_logger_find_get(pf, NF_LOG_TYPE_LOG);
>>           if (logger) {
>>                   nf_logger_put(pf, NF_LOG_TYPE_LOG);
>>                   return true;
>>           }
>>
>>           logger = nf_logger_find_get(pf, NF_LOG_TYPE_ULOG);
>>           if (logger) {
>>                   nf_logger_put(pf, NF_LOG_TYPE_ULOG);
>>                   return true;
>>           }
>>
>>           return false;
>> }
> 
> Why not simply do:
> 
> bool nf_log_is_registered(int pf)
> {
> 	int i;
> 
> 	for (i = 0; i < NF_LOG_TYPE_MAX; i++) {
> 		if (rcu_access_pointer(loggers[pf][i]))
> 			return true;
> 	}
> 
> 	return false;
> }

Yeah, it's simpler and better. Thanks!

