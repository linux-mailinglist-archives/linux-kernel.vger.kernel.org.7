Return-Path: <linux-kernel+bounces-742354-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58736B0F073
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 12:55:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5030A3A79B3
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 10:55:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43A4229C321;
	Wed, 23 Jul 2025 10:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="S4Ucak01"
Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93A8A29A9ED
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 10:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753268142; cv=none; b=gGhpqf3bPUE6TG5oyo+FIAy7Cm9BflLIVJoSgFHlwkm5XE+6iZeYqvGSucn/SfYUSCVJ1VLSpVKIZ8AnYJRwm9OOQz0Gjr1iFAwkG5ltBys/rYxembMCbu8ux1DP8/ZvbJhYzyKiW3fTr6rlDBD0y1b2zWlRcJZc+VMMIHDvl8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753268142; c=relaxed/simple;
	bh=m43EYY6q+XvOfeXV3GPp4XFcqABOWCC0aWg0XAAXamM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=igy5NqRYkjdo720/ZxTJQs84rpBefSv+JUFDBVEGfk6wUwMqn75EJvF5+lj6QqEBDPhzZPI2OAgfgHrGV2AdgPL9woEGxotkiYMFdEOqRr3KdF6c8qJ1dX14G49v7CjlZRTfqXHDEP8ewbzMJ8mkF4JXOqMmR/TswJdhJxFv9sA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=S4Ucak01; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <393b7e0e-2240-49c5-9ff7-8efa07a11d3b@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1753268136;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CYI4IOaiJ64Vf6dp+PDO/cqw+3AhfpJbd/gGnQR4Krs=;
	b=S4Ucak01dKys0gBZgwAJY0O/HeDXEdpglcJx9M10oPvLNUmZwQxFY9YeCJ21xWHJ9esC7k
	ZgWO0NhpOTWh7nOCsapziZDvN1pYsjnKm6a/2MHCihuxR07Y9uiMAjgSejnLMbu+fnCiP2
	WBQjgB5I5O1icPeJG4STrEioJ44ax3c=
Date: Wed, 23 Jul 2025 18:55:07 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v3 1/3] bpftool: Add bpf_token show
To: Quentin Monnet <qmo@kernel.org>, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, davem@davemloft.net,
 kuba@kernel.org, hawk@kernel.org
Cc: linux-kernel@vger.kernel.org, bpf@vger.kernel.org, netdev@vger.kernel.org
References: <20250723033107.1411154-1-chen.dylane@linux.dev>
 <1dd1a433-ecdf-437d-bc71-6d1b65b74cc8@kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Tao Chen <chen.dylane@linux.dev>
In-Reply-To: <1dd1a433-ecdf-437d-bc71-6d1b65b74cc8@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

在 2025/7/23 18:40, Quentin Monnet 写道:
> 2025-07-23 11:31 UTC+0800 ~ Tao Chen <chen.dylane@linux.dev>
>> Add `bpftool token show` command to get token info
>> from bpffs in /proc/mounts.
>>
>> Example plain output for `token show`:
>> token_info  /sys/fs/bpf/token
>> 	allowed_cmds:
>> 	  map_create          prog_load
>> 	allowed_maps:
>> 	allowed_progs:
>> 	  kprobe
>> 	allowed_attachs:
>> 	  xdp
>> token_info  /sys/fs/bpf/token2
>> 	allowed_cmds:
>> 	  map_create          prog_load
>> 	allowed_maps:
>> 	allowed_progs:
>> 	  kprobe
>> 	allowed_attachs:
>> 	  xdp
>>
>> Example json output for `token show`:
>> [{
>> 	"token_info": "/sys/fs/bpf/token",
>> 	"allowed_cmds": ["map_create", "prog_load"],
>> 	"allowed_maps": [],
>> 	"allowed_progs": ["kprobe"],
>> 	"allowed_attachs": ["xdp"]
>> }, {
>> 	"token_info": "/sys/fs/bpf/token2",
>> 	"allowed_cmds": ["map_create", "prog_load"],
>> 	"allowed_maps": [],
>> 	"allowed_progs": ["kprobe"],
>> 	"allowed_attachs": ["xdp"]
>> }]
>>
>> Signed-off-by: Tao Chen <chen.dylane@linux.dev>
>> ---
> 
> [...]
> 
>> diff --git a/tools/bpf/bpftool/token.c b/tools/bpf/bpftool/token.c
>> new file mode 100644
>> index 00000000000..06b56ea40b8
>> --- /dev/null
>> +++ b/tools/bpf/bpftool/token.c
> 
> [...]
> 
>> +static int do_help(int argc, char **argv)
>> +{
>> +	if (json_output) {
>> +		jsonw_null(json_wtr);
>> +		return 0;
>> +	}
>> +
>> +	fprintf(stderr,
>> +		"Usage: %1$s %2$s { show | list }\n"
>> +		"	%1$s %2$s help\n"
> 
> 
> One more nit: applying and testing the help message locally, I noticed
> that the alignement is not correct:
> 
>      $ ./bpftool token help
>      Usage: bpftool token { show | list }
>              bpftool token help
> 
> The two "bpftool" should be aligned. This is because you use a tab for
> indent on the "help" line. Can you please replace it with spaces to fix
> indentation, and remain consistent with what other files do?
> 

Thanks for your testing, i will fix it, thanks again.

> After that change, you can add:
> 
>      Reviewed-by: Quentin Monnet <qmo@kernel.org>


-- 
Best Regards
Tao Chen

