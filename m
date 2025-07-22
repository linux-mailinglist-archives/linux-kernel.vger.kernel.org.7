Return-Path: <linux-kernel+bounces-741251-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C12BB0E1FD
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 18:36:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB3DE1C816DF
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 16:36:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5770227AC50;
	Tue, 22 Jul 2025 16:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="PTOhhcNa"
Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 103862797AE
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 16:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753202169; cv=none; b=B3AaXbL/mEpOsoZi2tcEstZKdUk6mOgWyaY1rkuyEKGJ0EQqGSlg3S5HZhVEHeDRjQ+S11OfkDZYyQzuqrONS/j5axEuNjhBvnjB5Ck+383qlSd/irZU4VG9oAQT26cWmxWyjafv3Mem4pIHVxOxeu73nL9eALmz7IwHKXzqGXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753202169; c=relaxed/simple;
	bh=jD3QayzdcggqoSc8UngUlmjoqdFLiHcnz8zfpitTb8s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pNZt+UwNdP4ZjwY5FpXgOrx1mGRORWJAgzkZxLHV6y0HeFw4gN7IGYtZW3XAkxMpoCJp954UF+bJcT/POPOR3aZgWS+g9Z/ZS589tStsq674iQtPIUsfw2QNd44atyvkMqAdcRR1ZHk0QMk74GEY6qLfslaug0beRXH+Zpb8xz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=PTOhhcNa; arc=none smtp.client-ip=95.215.58.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <5681662e-6038-433f-9da7-438b383621b7@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1753202163;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=58pvaCs+xgE9yS/q0WEYLSExFzaY39BOzBBTwJRQn7k=;
	b=PTOhhcNa8/7hDCVVDLT3bn8pDi7Oz/w60ErTXpAs4vHeqmPxYtO/OFDd0CBFcrBzQbn/Ur
	z8mrjyE5BGWPIRW89NEfX8m4q+vogMx3qFUraCJ27MRxvALFoY3fS05EzJuKyGCWbIoMoD
	KIMHG19Lz6kVJymemjjDXtEE+QHetHs=
Date: Wed, 23 Jul 2025 00:35:48 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v2 3/3] bpftool: Add bash completion for token
 argument
To: Quentin Monnet <qmo@kernel.org>, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, davem@davemloft.net,
 kuba@kernel.org, hawk@kernel.org
Cc: linux-kernel@vger.kernel.org, bpf@vger.kernel.org, netdev@vger.kernel.org
References: <20250722120912.1391604-1-chen.dylane@linux.dev>
 <20250722120912.1391604-3-chen.dylane@linux.dev>
 <ba84629f-5675-4793-9320-25d9029d2a35@kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Tao Chen <chen.dylane@linux.dev>
In-Reply-To: <ba84629f-5675-4793-9320-25d9029d2a35@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

在 2025/7/22 23:02, Quentin Monnet 写道:
> 2025-07-22 20:09 UTC+0800 ~ Tao Chen <chen.dylane@linux.dev>
>> This commit updates the bash completion script with the new token
>> argument.
>> $ bpftool
>> batch       cgroup      gen         iter        map         perf        struct_ops
>> btf         feature     help        link        net         prog        token
> 
> 
> This is a terrible example, offering "token" as completion for just
> "bpftool [tab]" works without this patch :) The main commands are parsed
> from the output of "bpftool help" so it should work after your first
> patch. In this one, we add "list", "show" and "help" for completing
> "bpftool token [tab]".
> 

As you said, how about this one? I will change it in v3, thanks.
     $ bpftool token
     help  list  show

> 
>>
>> Signed-off-by: Tao Chen <chen.dylane@linux.dev>
>> ---
>>   tools/bpf/bpftool/bash-completion/bpftool | 11 +++++++++++
>>   1 file changed, 11 insertions(+)
>>
>> diff --git a/tools/bpf/bpftool/bash-completion/bpftool b/tools/bpf/bpftool/bash-completion/bpftool
>> index a759ba24471..527bb47ac46 100644
>> --- a/tools/bpf/bpftool/bash-completion/bpftool
>> +++ b/tools/bpf/bpftool/bash-completion/bpftool
>> @@ -1215,6 +1215,17 @@ _bpftool()
>>                       ;;
>>               esac
>>               ;;
>> +        token)
>> +            case $command in
>> +               show|list)
>> +                   return 0
>> +                   ;;
>> +               *)
>> +                   [[ $prev == $object ]] && \
>> +                       COMPREPLY=( $( compgen -W 'help show list' -- "$cur" ) )
>> +                   ;;
>> +            esac
>> +            ;;
>>       esac
>>   } &&
>>   complete -F _bpftool bpftool
> 
> 
> Other than the example in the description, this looks good.
> 
> Reviewed-by: Quentin Monnet <qmo@kernel.org>
> 
> Thanks


-- 
Best Regards
Tao Chen

