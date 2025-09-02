Return-Path: <linux-kernel+bounces-797477-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83474B410E9
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 01:48:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3EE903BD45D
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 23:48:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1B422E92B4;
	Tue,  2 Sep 2025 23:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FQ15QeSX"
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66E712E8DEF
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 23:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756856881; cv=none; b=W+Syt1ImumoTGFB1M89LYMQ+u9Y06pHeAryrJp0vPLuSnLYu0a5/E4/DpkSo2xvmTseqenO10UAmCcRxWDvINjUqCjiWTXBlmPptBmb9d+NXuRtRgMv6sb1NSroqXLntcmK4aMCGhdPTXuUf/HAzwB+gMULhOcC4jRV3sE7owls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756856881; c=relaxed/simple;
	bh=vt1Y2MwF+QeM3YtKpKSzBRXW1V3QsYt0k1NWrKJnl34=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lEQULoEad4FgPXO7WuuebUdN9LD3LCyZxHUgMXg/05xR5WLIyx9A140Puk6NKMtVz1diY2dsiU3gXi18KCrOJiUarmu0TZuqrdfmEU0c9qBY/lt9wTq/Et0kZWqb8IbhoyXi+eI5MQI1xpMN2yO7A8M7cqOVDXL05k1vV2zF2WE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FQ15QeSX; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-70fa0e37bc5so23080386d6.0
        for <linux-kernel@vger.kernel.org>; Tue, 02 Sep 2025 16:48:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756856879; x=1757461679; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=szsB+4hgBlzRtrPiLozcnRxVKaaAr56CpFo21AapQ/Y=;
        b=FQ15QeSXlKqxPuZMn8WoxngkcL/4u7mi4/k6CjXrOW873YxtWL7CDv0aSm3x89N5+6
         17pJVkoCl5nJxTjO9jE4LcJ3H02HqF/g+dqkp3EHHB1Lc7Vd+H1xqKgL8hKAmx5glyZG
         pSMSlfombwmPBIQU9XQ510hQdsHj1oKXRGRbtZZR4JIckSm4otljKJ2UzQzmcL8bfE5o
         5wl3G2VEzMDmtdb1VB1rU487hkvYVNlbVRFm4UjRP9DHWVp7rVLrOTJ6bu7nrvsf3UhI
         LXrxA33yD6PBXOTgR50EV0ac6l8yfoGsFYLcIQ+6jCPtrZKEet1D++YnCyn9/192iUlF
         tXeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756856879; x=1757461679;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=szsB+4hgBlzRtrPiLozcnRxVKaaAr56CpFo21AapQ/Y=;
        b=L5aqP9PUygOrOUcasm3Ws7Yt0tXNo0dGXQ7baagaBaJAiD8qaL2r4p3SoYiqC/QgOn
         NF+ku1+zcxvkxNyGNf0BaoPY0VWnlCiuObQrWGGItHZd1O9GXL8rjKzgdfWx8jxUONmI
         zHy3h5Gig/5J5r4ValtPhPpj9FpJGPzcUj5OXqVcv+B/j7xI4/6zvDTFEbw8voob70g+
         IyOqtOs/bcadu5/YTpQh4y/NmPODiWbBnYRODkiYC9GxZUuB6gXxmJ+JcbItqoX+s5dA
         smZWcOqnlnYC8fH153o+8hc1duqauKhSRNbPNR0FU+b8cr12CW6X1yVu+pUNzVF+POWb
         wwBQ==
X-Forwarded-Encrypted: i=1; AJvYcCUi2Umd1Co987pDmiNM0nM3xeAaSHNDklOxGbnzfgph9TZvuDkYJD/S6JRQuqzMSdPwNgL3M/UE3NtjY+8=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywnvu6PqLHXbTaI/WlmZl4IYg3IuLsirbSND10CkT2NpUymrgf8
	6O3cZlHkQOp6Jm5lhvc8PIyZrbeiuVPq3u0wkBYABfeuD/3Ed7d2dpz0
X-Gm-Gg: ASbGncvZkTk6giko5ZlcpkYSZiNqtEGDY2UaKV46yl/BqXit7HVTLixzITbdPpleLe7
	Cuiu99A2Ec1g7bGRz2DCVrM0OzySbUz9uFaPiKltuIiGgxRx6h8rb5zz15NTkO1y4mQkN9nJbbL
	BreeMjZLV4bpMTTFQwyJqo+uKNtaws6J6N0gk2IaeyT1KHCuaOBQXz9X9OX5e4td8H9xT2dbXmi
	3OniA89Me1o3xtONLRFxim6EoLYQHL8i06sdbl0XhqrWaicbnWaM8PGNrBN76+86vN333f4g/Km
	mWt3p57FRcJ4jgdNh/otbEX+kt3XRWypmMKvqaYxaKik1lMTXNjROtjiD+rGuckDv2seQ88mBB1
	Y+2h2MdfWJCcAaMBVzL4QeSsgD8pF3OcY2ilyz+lJxBR/l2axuw==
X-Google-Smtp-Source: AGHT+IE755rzDB4jnnSivyguFtLycu8yDivEdX3+zUsRfdttnPsQf5p1Etq1jGJ2c1W3sqXEWC7cgQ==
X-Received: by 2002:a05:6214:2464:b0:71d:bc7d:4dbd with SMTP id 6a1803df08f44-71dbc7d5625mr77294846d6.55.1756856879106;
        Tue, 02 Sep 2025 16:47:59 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-720b5b9ceb1sm19907686d6.57.2025.09.02.16.47.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Sep 2025 16:47:58 -0700 (PDT)
Message-ID: <8c46a270-0e97-4c50-b5f3-ed58ee0c2d11@gmail.com>
Date: Tue, 2 Sep 2025 16:47:53 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] sched/deadline: only set free_cpus for online
 runqueues
To: Juri Lelli <juri.lelli@redhat.com>, Doug Berger <opendmb@gmail.com>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
 Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>,
 linux-kernel@vger.kernel.org,
 Florian Fainelli <florian.fainelli@broadcom.com>
References: <20250815012236.4053467-1-opendmb@gmail.com>
 <aKMja4BvgQ5vFaNN@jlelli-thinkpadt14gen4.remote.csb>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
Autocrypt: addr=f.fainelli@gmail.com; keydata=
 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
 WlfRzlpjIPmdjgoicA==
In-Reply-To: <aKMja4BvgQ5vFaNN@jlelli-thinkpadt14gen4.remote.csb>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/18/25 05:58, Juri Lelli wrote:
> Hello,
> 
> On 14/08/25 18:22, Doug Berger wrote:
>> Commit 16b269436b72 ("sched/deadline: Modify cpudl::free_cpus
>> to reflect rd->online") introduced the cpudl_set/clear_freecpu
>> functions to allow the cpu_dl::free_cpus mask to be manipulated
>> by the deadline scheduler class rq_on/offline callbacks so the
>> mask would also reflect this state.
>>
>> Commit 9659e1eeee28 ("sched/deadline: Remove cpu_active_mask
>> from cpudl_find()") removed the check of the cpu_active_mask to
>> save some processing on the premise that the cpudl::free_cpus
>> mask already reflected the runqueue online state.
>>
>> Unfortunately, there are cases where it is possible for the
>> cpudl_clear function to set the free_cpus bit for a CPU when the
>> deadline runqueue is offline. When this occurs while a CPU is
>> connected to the default root domain the flag may retain the bad
>> state after the CPU has been unplugged. Later, a different CPU
>> that is transitioning through the default root domain may push a
>> deadline task to the powered down CPU when cpudl_find sees its
>> free_cpus bit is set. If this happens the task will not have the
>> opportunity to run.
>>
>> One example is outlined here:
>> https://lore.kernel.org/lkml/20250110233010.2339521-1-opendmb@gmail.com
>>
>> Another occurs when the last deadline task is migrated from a
>> CPU that has an offlined runqueue. The dequeue_task member of
>> the deadline scheduler class will eventually call cpudl_clear
>> and set the free_cpus bit for the CPU.
>>
>> This commit modifies the cpudl_clear function to be aware of the
>> online state of the deadline runqueue so that the free_cpus mask
>> can be updated appropriately.
>>
>> It is no longer necessary to manage the mask outside of the
>> cpudl_set/clear functions so the cpudl_set/clear_freecpu
>> functions are removed. In addition, since the free_cpus mask is
>> now only updated under the cpudl lock the code was changed to
>> use the non-atomic __cpumask functions.
>>
>> Signed-off-by: Doug Berger <opendmb@gmail.com>
>> ---
> 
> This looks now good to me.
> 
> Acked-by: Juri Lelli <juri.lelli@redhat.com>

Thanks Juri, can we apply it?
-- 
Florian

