Return-Path: <linux-kernel+bounces-665390-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F184EAC6888
	for <lists+linux-kernel@lfdr.de>; Wed, 28 May 2025 13:43:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 479C77AA697
	for <lists+linux-kernel@lfdr.de>; Wed, 28 May 2025 11:42:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2021283FDA;
	Wed, 28 May 2025 11:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="CXZSk8QF"
Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCD2A283C90
	for <linux-kernel@vger.kernel.org>; Wed, 28 May 2025 11:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748432588; cv=none; b=RhFmazFLML9TADbjEUHg9SYJqnqEOwOMJyjHFomslAagIlyN4WDYNzUa52yJ1EV+910e4PVmHC+RUzikQAJLGq7MdVoKXW+BPpS1GVijVPEPo0VAJNr/TcGq0o1KHhF8i40tymJN6JZlviiZIQbEbGnEk/kz9VvBwy96wPYrKuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748432588; c=relaxed/simple;
	bh=F14WpKvt+umuWe3/Isc5tPu1qABYABZZp0MgaG9pYeg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HTuM80DMpZrF3MxqBZxfphXObTEt1uDVjZXf8QhDvq+PMr/WPqnv5Fi4hMsOymlIbCgwqqziyx+FRi+ny3ZnqVxKeHGXefNxPAlNyy0WWk+8qECTfze6iC5pN5FcAKM5BUqIYcNX5wBVVLnyIF17Lhwoo9p0GtBQrKuncUtoMFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=CXZSk8QF; arc=none smtp.client-ip=95.215.58.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <a2f5fb23-e57a-4a83-bb95-b5756df0e2d7@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1748432581;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YE1ELheB7GeGGiQgSxZMg6BAxL+LxZtmsKzHFj/F6a8=;
	b=CXZSk8QFLRjGA8Q5yqW8MqFoxFum+XvmH2ioKhW1iETEpG+zoRpfLbuSwSb9z7N+86kRRv
	zxadLT2tUi/LSAM/KI4V0xxJiFlZeMQixL1Q6wZbsrpjAJQDag2II306jZKcvpotlsVFPu
	WAM3B/n7U8rcZi+q1Hg4E8UhUGynKcI=
Date: Wed, 28 May 2025 19:42:50 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2 1/1] netfilter: load nf_log_syslog on enabling
 nf_conntrack_log_invalid
To: Florian Westphal <fw@strlen.de>
Cc: pablo@netfilter.org, coreteam@netfilter.org, davem@davemloft.net,
 Lance Yang <ioworker0@gmail.com>, edumazet@google.com, horms@kernel.org,
 kadlec@netfilter.org, kuba@kernel.org, linux-kernel@vger.kernel.org,
 netfilter-devel@vger.kernel.org, pabeni@redhat.com, zi.li@linux.dev
References: <20250526085902.36467-1-lance.yang@linux.dev>
 <aDbt9Iw8G6A-tV9R@strlen.de>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Lance Yang <lance.yang@linux.dev>
In-Reply-To: <aDbt9Iw8G6A-tV9R@strlen.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


Thanks for taking the time to review!

On 2025/5/28 19:05, Florian Westphal wrote:
> Lance Yang <ioworker0@gmail.com> wrote:
>> From: Lance Yang <lance.yang@linux.dev>
>>
>> When no logger is registered, nf_conntrack_log_invalid fails to log invalid
>> packets, leaving users unaware of actual invalid traffic. Improve this by
>> loading nf_log_syslog, similar to how 'iptables -I FORWARD 1 -m conntrack
>> --ctstate INVALID -j LOG' triggers it.
> 
> Acked-by: Florian Westphal <fw@strlen.de>

Hmm... should this patch be backported to stable kernels? Without it,
nf_conntrack_log_invalid won't log invalid packets when no logger is
registered, causing unnecessary debugging effort ;)

Back then, I actually thought my machine wasn't seeing any invalid
packets... turns out they just weren't logged in dmesg :(

Thanks,
Lance

