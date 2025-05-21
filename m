Return-Path: <linux-kernel+bounces-657808-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A34CEABF916
	for <lists+linux-kernel@lfdr.de>; Wed, 21 May 2025 17:22:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 705147B2458
	for <lists+linux-kernel@lfdr.de>; Wed, 21 May 2025 15:21:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B47131E22E6;
	Wed, 21 May 2025 15:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="LgCKjKRT"
Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F2E02AF1E
	for <linux-kernel@vger.kernel.org>; Wed, 21 May 2025 15:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747840930; cv=none; b=J8CCYflT53PIjEmkGCO19OqY1at1nq15NJwpwzXZEYVXcLovHEaCvXqOgOrn0DxOgK7F4IDRcDQxWp9DBfGLUNVI3NAChZEUO+LY1BmaWgg0y08ooUI673ebt1FXFa3+f8lMQNPHy0R5uda4pJHvFZ5Xq/gFT2h0jN3/Zxexbeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747840930; c=relaxed/simple;
	bh=GFKhmbuUQucyfYyIeEkAVA9XLa8smldr0M/nQft6Drc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=d8y9yd32mGL87Xle2ds8vpsiNRvD58CoOQpUV+8ykK6SOfiUJMMABBQqrhP2HEr0l1kMZJ5KKz0Nc64PuGQpfMTZUJPmt6rh4Lp94VbSoJ1lAbCxKy1CEqm9tmPO58T2h7jHqa6t/kIqQonqSgmN8xyWcwJp/62MM7vdgdCgP6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=LgCKjKRT; arc=none smtp.client-ip=95.215.58.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <6f35a7af-bae7-472d-8db6-7d33fb3e5a96@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1747840926;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XjTP0D8RvhabPX+yOSJlJgd7qda/73QUkgNtD9M1PFY=;
	b=LgCKjKRTSCH5jjtERxa/Hgu7EZ9kXGXSRC81VN3ZHTm90s2WkLa1t/nhQCVQK5lkgv3XIf
	f7EOdUBPBKp6GGa9n8E1rpL7+gXOY78EX6GG5UUycXH1JwZn5sxZa5JudTzKtgWn2qrJiK
	yt4jUrz+8s0pOGJybbTEPdh/suv9164=
Date: Wed, 21 May 2025 23:21:45 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [RESEND PATCH 1/1] netfilter: load nf_log_syslog on enabling
 nf_conntrack_log_invalid
Content-Language: en-US
To: Florian Westphal <fw@strlen.de>, Pablo Neira Ayuso <pablo@netfilter.org>
Cc: Lance Yang <ioworker0@gmail.com>, kadlec@netfilter.org,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, coreteam@netfilter.org,
 linux-kernel@vger.kernel.org, netfilter-devel@vger.kernel.org,
 Zi Li <zi.li@linux.dev>
References: <20250514053751.2271-1-lance.yang@linux.dev>
 <aC2lyYN72raND8S0@calendula> <aC23TW08pieLxpsf@strlen.de>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Lance Yang <lance.yang@linux.dev>
In-Reply-To: <aC23TW08pieLxpsf@strlen.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

Hi Pablo and Florian,

Thanks for taking the time to review!

On 2025/5/21 19:21, Florian Westphal wrote:
> Pablo Neira Ayuso <pablo@netfilter.org> wrote:
>> I have been beaten by this usability issue in the past, it happens
>> since conntrack is loaded on demand.
>>
>> Maybe add an inconditionally soft dependency? This is a oneliner patch.
>>
>>          MODULE_SOFTDEP("pre: nf_log_syslog");
>>
>> Florian, do you prefer this patch (on-demand) or a oneliner to load
>> this module when conntrack gets loaded too?
>>
>> It is a bit more memory to make it inconditional, but better to expose
>> to users this soft dependency via lsmod.
>>
>> Thanks.
> 
> I don't like this patch or the above because we do have two log
> backends, syslog + nflog.

Ah, good to know! I wasn't aware of that :(

> 
> There is no need for 'syslog' to be active for 'log_invalid' to be
> useful as long as the system in question has e.g. ulogd running
> and listening to nflog messages.
> 
> If anything, the modprobe should be done only when no logger
> is registered.

Yes, could we load the module only when no logger exists? Something
like:

+ if (nf_logger_find_get(NFPROTO_IPV4, NF_LOG_TYPE_LOG) != 0)
+ 	request_module("%s", "nf_log_syslog");

Hmm... is nf_logger_find_get() the correct way to check if no
logger is registered, or are there preferred alternatives?

Thanks,
Lance



