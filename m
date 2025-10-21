Return-Path: <linux-kernel+bounces-862602-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E477FBF5B90
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 12:14:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8716A4EACA4
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 10:14:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B67F32ABEF;
	Tue, 21 Oct 2025 10:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UtividXJ"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C5F77DA66
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 10:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761041647; cv=none; b=gYMM04JZju+BCyYuOOK/90HXyN82KlHQIQVXbpz23lrTX2iSNM+/RsmcgE5QOKmzNDVezQ+CpXqL6o/Tfc7RlPdZvf56a+eFdl7Pi4E4g8jtxgHc4PTMPq3H4ELF4ySlolfJ/spGnlXNnqMQvgwaZX4wunzGhDyQnwQwHpLQ9dw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761041647; c=relaxed/simple;
	bh=hZFYqccy3hrzjkUJnAWqrJtsjPd4X/Rq5BGUoMThiBQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Z9l72Uyund1G1Q/q0/7/jMQ0VwCzclbn3yr9s+0cZVS01Ribv6BaXb01t22phNjufcmD4Qw0MINtpeoCiUHqG0zlTZukR8qdT10NUK2ZqZfRzmnio1bt2j6gHZn6TcxuC/lN5iFcENeDZ+VRIyiJ/zmlBIvhuA7SFyt0EW+IBgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UtividXJ; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-b3e8f400f79so92198966b.1
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 03:14:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761041643; x=1761646443; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aY4sUqJT8CNQPf5hwojWc40WBK5K/UWeQgITdbU7s54=;
        b=UtividXJcfovqe8wKQVSC1Iwlws+W3vm9+YGgu9nqkRy3ZOFluhjxN9jHfUPQwf8LG
         pPrDc4wh5WlXIWv+a4wea/lw3U0FpnvBljkCmvMD0RozwB67Q9aP5zeN7tCA485hujDU
         5YZiZcOlLL8OZPmNgmwI16zXW3+vpD6pCaaKyNSgCa8ypWpFwDZCCLji3knfQtlTnbx4
         0chBktbiOp+kM7Kkbsrp6hfQJnimQgGLa3l7jT5ztxZGnkyKo5XlQ5JXq3H04Q324olL
         Swb5G+4gqTnvnjE1k6TLXHTgz4704Lu13NplwlW2DPk5yvHit/KLgnPMw+lXVozWxlMB
         /1ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761041643; x=1761646443;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aY4sUqJT8CNQPf5hwojWc40WBK5K/UWeQgITdbU7s54=;
        b=tlqN4nSp65euxx0jeEcAgK57nKeX7Hr3RnOiD64/O9V7Tk4FB8GyQO4Os0Dlwv3WeT
         SOQIvCHKAdRIdlJ64/3V2cUlq4Mv61LT5GXRhaUh77IhLemHQCduQmNehWqsuKPi/fgk
         q+pJW/VBKqQvPjL7UMoyykdnvHAsdwzjDnRvbfQYyp4V2HPc85RTjeYu3yOHuCPaYYHW
         9qIPNwDaz8h2UEs8hmTEGBjCfIZoecKvkvcKMgEKB7fypKzCEIOUSohJqG8ZMO9TLCoS
         efvU3+1667WRK5Yxw3dpy/5lxaQ9pzmDMy5qlIIBFWsAQC4v4ikEG2FQAnKGTZxL6q34
         SooA==
X-Forwarded-Encrypted: i=1; AJvYcCXD6ih9IXZ3iTo2ozEcMtQqRlAKSiZplFyPerOWopGeSmuNeiIKzpchqnQZXssEdm9Q3XTMq9Xw/zMH3cY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwioiqtFfGOURd7nMBvtPm0zwXbm2nOUlq0qDI+Da4yDx1Z2q88
	M9wxPZhnzutU1V41ux01hRKwdxaY4oGKjgB5/YRSEsTMbkDstAO7L11MIbhGDw==
X-Gm-Gg: ASbGnct3bWkPIT7kYsBr6/dGRn/SmReBVw2EjLFKt1Qj0CqZ74NaW673Qi5Iu5E6wDj
	Oq3xNlfmjpgtoZy8PfTX96PdRa9xe5DKxi/QSDq5nbtk3Erz+te7jr8mrxJOR64CPlmnNLa+j+l
	sMl0+uSrIeQz8NmDDHMM6jy+PDk/x4HHKNn5COrBF63eCYrYXcKwyZiaX01Ps7pc80GLD7mr/qg
	Z0Js9SiTnt1qwnLuwVtJlMii4HGFge9cqbKu4KX6Q4DM1ROXvFmbTTomzfgbcbNi6c93inmM9wZ
	GD5cIJPnngcomq8o/4/lZ2m5zKwV3jun6iMV4rsKmTYPW43xzx6rpCsGutN4+vZYVU7bdd+S8Bs
	sA6v9XjjWwUccYH+U5CApdAD9V3RFYImvOYZLZ3cyE4481R4JMt0nxPTOGHDEVKscXDiUj2xcKt
	q7Ba3eHkj871n7MwTyEpyGFz/mZBVJ
X-Google-Smtp-Source: AGHT+IGp3+5iFHi5zRWLe8YxHSX3njxzZcoBp1BcVGuZR2w2gCAwViee0Dzqam5RCqIQMql4fNoXCQ==
X-Received: by 2002:a05:6402:4307:b0:63c:1d4a:afcb with SMTP id 4fb4d7f45d1cf-63d09d3bd06mr1476817a12.0.1761041642678;
        Tue, 21 Oct 2025 03:14:02 -0700 (PDT)
Received: from [192.168.1.105] ([165.50.73.64])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-63c4869746asm9018625a12.0.2025.10.21.03.14.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Oct 2025 03:14:02 -0700 (PDT)
Message-ID: <4c849c04-6647-432c-807c-5fa7afa7fb47@gmail.com>
Date: Tue, 21 Oct 2025 12:13:52 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v2] bpf/cpumap.c: Remove unnecessary TODO comment
To: Jesper Dangaard Brouer <hawk@kernel.org>, ast@kernel.org,
 daniel@iogearbox.net, davem@davemloft.net, kuba@kernel.org,
 john.fastabend@gmail.com, sdf@fomichev.me, andrii@kernel.org,
 martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, kpsingh@kernel.org, haoluo@google.com,
 jolsa@kernel.org
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org, skhan@linuxfoundation.org,
 david.hunter.linux@gmail.com, khalid@kernel.org,
 linux-kernel-mentees@lists.linuxfoundation.org
References: <20251020170254.14622-1-mehdi.benhadjkhelifa@gmail.com>
 <e0901356-ef48-4652-9ad4-ff85ae07d83a@kernel.org>
Content-Language: en-US
From: Mehdi Ben Hadj Khelifa <mehdi.benhadjkhelifa@gmail.com>
In-Reply-To: <e0901356-ef48-4652-9ad4-ff85ae07d83a@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10/21/25 10:37 AM, Jesper Dangaard Brouer wrote:
> 
> 
> On 20/10/2025 19.02, Mehdi Ben Hadj Khelifa wrote:
>> After discussion with bpf maintainers[1], queue_index could
>> be propagated to the remote XDP program by the xdp_md struct[2]
>> which makes this todo a misguide for future effort.
>>
>> [1]:https://lore.kernel.org/all/87y0q23j2w.fsf@cloudflare.com/
>> [2]:https://docs.ebpf.io/linux/helper-function/bpf_xdp_adjust_meta/
>>
>> Signed-off-by: Mehdi Ben Hadj Khelifa <mehdi.benhadjkhelifa@gmail.com>
>> ---
>> Changelog:
>>
>> Changes from v1:
>>
>> -Added a comment to clarify that RX queue_index is lost after the frame
>> redirection.
>>
>> Link:https://lore.kernel.org/bpf/d9819687-5b0d-4bfa-9aec- 
>> aef71b847383@gmail.com/T/#mcb6a0315f174d02db3c9bc4fa556cc939c87a706
>>   kernel/bpf/cpumap.c | 5 ++++-
>>   1 file changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/kernel/bpf/cpumap.c b/kernel/bpf/cpumap.c
>> index 703e5df1f4ef..6856a4a67840 100644
>> --- a/kernel/bpf/cpumap.c
>> +++ b/kernel/bpf/cpumap.c
>> @@ -195,7 +195,10 @@ static int cpu_map_bpf_prog_run_xdp(struct 
>> bpf_cpu_map_entry *rcpu,
>>           rxq.dev = xdpf->dev_rx;
>>           rxq.mem.type = xdpf->mem_type;
>> -        /* TODO: report queue_index to xdp_rxq_info */
>> +        /* The NIC RX queue_index is lost after the frame redirection
>> +         * but in case of need, it can be passed as a custom XDP
>> +         * metadata via xdp_md struct to the remote XDP program
> 
> Argh, saying XDP metadata is accessed via the xdp_md struct is just wrong.
> 
Ack, I didn't clarify that XDP metadata should be propagated via the 
bpf_xdp_adjust_meta like mentionned in the link[2]... Maybe I was 
thinking more in the technical side that xdp_md->data_meta would hold 
the value internally... I will send a v3 with appropriate changes.
Thanks for the review.

Best Regards,
Mehdi Ben Hadj Khelifa
> Nacked-by: Jesper Dangaard Brouer <hawk@kernel.org>
> 
>> +         */
>>           xdp_convert_frame_to_buff(xdpf, &xdp);
> 


