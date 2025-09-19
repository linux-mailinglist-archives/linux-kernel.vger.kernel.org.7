Return-Path: <linux-kernel+bounces-823906-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DA26B87B35
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 04:18:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 561C42A6BA9
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 02:18:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC2F0239E6F;
	Fri, 19 Sep 2025 02:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="uQ1+JcVA"
Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DB53273F9
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 02:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758248282; cv=none; b=n8vYBkdbpomXEHKwbjLeXy1xTCvEbzesKirQBXtLpfTwEaecFFM5isO5yeXN0Dp1BjI4n7pQZbhn5B+gspz7ZC7RqV/uSSrRJRrewpuOpZj/3mQRi5lk1UFZpXtTYgOCvfRE52JHoek8pA4VwUQosFNJmoy7oRGbD2sUF1fmnPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758248282; c=relaxed/simple;
	bh=8/9X/yl89henGnUcBx4/BE+c1JkAukEdDa3OSuQkd2U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cXZkmZ+jHscIdWWc186mlNnjlT8I/grJYrLh3iMnnom5pTDxALPLOUar2LF9Ec7LjnPjjPgVXgiAEaH9DabzguWL0yEqDs7/tMO3Nbg0EPGraRiQfssN8PvFfj4pf8YV/g0ZWVPP3l/hqRYxtuNzWPa3HGwXqXPj7xLjXg3wgXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=uQ1+JcVA; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <ef942138-7318-4ac9-bf53-ec646c426c82@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1758248268;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QND3Wr17IEapmHXCoB1iRboFSwrJThe5CdhfJG8oOGY=;
	b=uQ1+JcVATbyCSETKErS/bSDdzEsha2vI15YCaBeT0csK7FNUNjxgmWj4uE6UHKeH9h/yNm
	s2nUCzqf1Q6IraYoeUCfsvcXpBZBj8YmZutdZI6r8HMMCdv0iozIkf3tvPsWYZE1y695FM
	HuCsFRYxCPNLQYoej/R6gG1wpYiWZq0=
Date: Fri, 19 Sep 2025 10:17:41 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v3 2/2] bpftool: Fix UAF in get_delegate_value
To: Quentin Monnet <qmo@kernel.org>, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250918120908.1255263-1-chen.dylane@linux.dev>
 <20250918120908.1255263-2-chen.dylane@linux.dev>
 <226947cd-a28d-4c09-81cb-0fa0a21c7075@kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Tao Chen <chen.dylane@linux.dev>
In-Reply-To: <226947cd-a28d-4c09-81cb-0fa0a21c7075@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

在 2025/9/19 04:07, Quentin Monnet 写道:
> 2025-09-18 20:09 UTC+0800 ~ Tao Chen <chen.dylane@linux.dev>
>> The return value ret pointer is pointing opts_copy, but opts_copy
>> gets freed in get_delegate_value before return, fix this by free
>> the mntent->mnt_opts strdup memory after show delegate value.
>>
>> Fixes: 2d812311c2b2 ("bpftool: Add bpf_token show")
>> Signed-off-by: Tao Chen <chen.dylane@linux.dev>
>> ---
>>   tools/bpf/bpftool/token.c | 90 +++++++++++++++------------------------
>>   1 file changed, 35 insertions(+), 55 deletions(-)
>>
>> diff --git a/tools/bpf/bpftool/token.c b/tools/bpf/bpftool/token.c
>> index 82b829e44c8..20c4c78a8a8 100644
>> --- a/tools/bpf/bpftool/token.c
>> +++ b/tools/bpf/bpftool/token.c
> 
> 
>> @@ -69,38 +73,29 @@ static void print_items_per_line(const char *input, int items_per_line)
>>   		printf("%-20s", str);
>>   		cnt++;
>>   	}
>> -
>> -	free(strs);
>>   }
>>   
>>   #define ITEMS_PER_LINE 4
>>   static void show_token_info_plain(struct mntent *mntent)
>>   {
>> -	char *value;
>> +	char *opts, *value;
> 
> 
> Thank you! I just have style nits: can you move the declaration of
> "opts" and "value" inside of the for loop, please? They're not used
> outside of it.
>

No problem, will change it in v4, thanks.

> 
>>   
>>   	printf("token_info  %s", mntent->mnt_dir);
>>   
>> -	printf("\n\tallowed_cmds:");
>> -	value = get_delegate_value(mntent->mnt_opts, "delegate_cmds");
>> -	print_items_per_line(value, ITEMS_PER_LINE);
>> -
>> -	printf("\n\tallowed_maps:");
>> -	value = get_delegate_value(mntent->mnt_opts, "delegate_maps");
>> -	print_items_per_line(value, ITEMS_PER_LINE);
>> -
>> -	printf("\n\tallowed_progs:");
>> -	value = get_delegate_value(mntent->mnt_opts, "delegate_progs");
>> -	print_items_per_line(value, ITEMS_PER_LINE);
>> +	for (size_t i = 0; i < ARRAY_SIZE(sets); i++) {
> 
> 
> And could you please move the declaration of variable "i" to the top of
> the function, for consistency with the rest of the code?>

also will change it in v4, thanks.

> Same comments for the JSON function.
> 
> Thanks,
> Quentin
-- 
Best Regards
Tao Chen

