Return-Path: <linux-kernel+bounces-667579-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A5CCFAC86E5
	for <lists+linux-kernel@lfdr.de>; Fri, 30 May 2025 05:10:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E43D1BA14A4
	for <lists+linux-kernel@lfdr.de>; Fri, 30 May 2025 03:11:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0533F194C96;
	Fri, 30 May 2025 03:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Pj+uQK4i"
Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 393581662E7
	for <linux-kernel@vger.kernel.org>; Fri, 30 May 2025 03:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748574652; cv=none; b=obqk6+fQ9zjG6ju4X56e/rac2EWfN5eyKwsyfIGmrmMPbh8dZGnx3ouZNQG1AB8UtOt4c7aSW8aTMfZtXJ3kg3xyBZwme87GzFGRMHwzGWSHX0mhbnWltumtlUStySszFrfRl6D15mKcpauTnld5PXFjeOsxlwrMkW6fF4EFoJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748574652; c=relaxed/simple;
	bh=Dn+CyC0JvyO5R/AcuungXdEiOqDoOFYO7/62igZNlXY=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=GilolIQxIAowCXaVIwokDDjpkNDLPCNd81n8BZck5lYAeOsS6EvVYq26SLgTTQX4pK8hfvtGK1d7vMXKJn1itv1rZLdJUGr49p98IrrVmq6CMeuIuGJVFiry+EBoeQ9rYOizS+dQnlh+khFz0JEtXMqfMYjY/ns4tvXHdZq76VU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Pj+uQK4i; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <4b7b81f0-c818-40f6-ba5f-64dbf8528893@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1748574638;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qxmWCoqgZoSvwWE8g+gRmrqeGh5Erk+0rx4TFhB+dko=;
	b=Pj+uQK4ijpyR4dVCGYn0pCQDAfQ2tFyLOjmrchMVMak4V3mLRyqpUKqy1DR/llKLS+YwB9
	m+Nw8OZtn+5Y/PoJzMnQsmZP2RAXfwyo/cXNHNbhXtQFb3gauIzS9+skGhAiIchNOHs8un
	dffm9jzfIwWTYt9bQ5mycwDTOK/xkvI=
Date: Fri, 30 May 2025 11:10:30 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2 1/1] netfilter: load nf_log_syslog on enabling
 nf_conntrack_log_invalid
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Lance Yang <lance.yang@linux.dev>
To: Florian Westphal <fw@strlen.de>
Cc: pablo@netfilter.org, coreteam@netfilter.org, davem@davemloft.net,
 Lance Yang <ioworker0@gmail.com>, edumazet@google.com, horms@kernel.org,
 kadlec@netfilter.org, kuba@kernel.org, linux-kernel@vger.kernel.org,
 netfilter-devel@vger.kernel.org, pabeni@redhat.com, zi.li@linux.dev,
 stable@vger.kernel.org
References: <20250526085902.36467-1-lance.yang@linux.dev>
 <aDbt9Iw8G6A-tV9R@strlen.de> <a2f5fb23-e57a-4a83-bb95-b5756df0e2d7@linux.dev>
Content-Language: en-US
In-Reply-To: <a2f5fb23-e57a-4a83-bb95-b5756df0e2d7@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

Cc: stable

On 2025/5/28 19:42, Lance Yang wrote:
> 
> Thanks for taking the time to review!
> 
> On 2025/5/28 19:05, Florian Westphal wrote:
>> Lance Yang <ioworker0@gmail.com> wrote:
>>> From: Lance Yang <lance.yang@linux.dev>
>>>
>>> When no logger is registered, nf_conntrack_log_invalid fails to log 
>>> invalid
>>> packets, leaving users unaware of actual invalid traffic. Improve 
>>> this by
>>> loading nf_log_syslog, similar to how 'iptables -I FORWARD 1 -m 
>>> conntrack
>>> --ctstate INVALID -j LOG' triggers it.
>>
>> Acked-by: Florian Westphal <fw@strlen.de>
> 
> Hmm... should this patch be backported to stable kernels? Without it,
> nf_conntrack_log_invalid won't log invalid packets when no logger is
> registered, causing unnecessary debugging effort ;)
> 
> Back then, I actually thought my machine wasn't seeing any invalid
> packets... turns out they just weren't logged in dmesg :(
> 
> Thanks,
> Lance


