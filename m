Return-Path: <linux-kernel+bounces-736218-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 945A0B09A2A
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 05:30:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 08FE21AA727D
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 03:30:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 870881C84DD;
	Fri, 18 Jul 2025 03:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KVsoqNmG"
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82F541C7013
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 03:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752809416; cv=none; b=pSY3WdDINNvzVnt5ScRtFi/VCOPsN70Z5Bfsg/nKG8fGbodm82kmJbI5cfcwOe6jN29dpHebTGZO+DyntiDn7t1x6yE2snQJURgRTWDTCoK5cO5MIh8JnFsLZC7hdXTXr4fYKTG5/fSbcTyVB6cbmwd6Z5MMx6UXYPhUHCsaPis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752809416; c=relaxed/simple;
	bh=+LtLvRbgSrdGqw1oPM9p6/LAXzAwxe3EXlgdCHzhj9I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AXVBryZBTr6MeVPm3oTjEz7W1YKqIgQOOm/HDZiZTlFdzDTHYdB/N7f5rus0laCjqjzeSz86HJPyH4DFpjqga7UKhKm1kKNrR0UESCLCY7kIlZRyXDwo1zvWjcJnDG8OeGLJZIXfYpIpREO1vsW70yhLs15ffIOqd3ezH5v398Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KVsoqNmG; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-74931666cbcso1531366b3a.0
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 20:30:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752809415; x=1753414215; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4rnxIvJYd1dwa8Ne+tskFcl9UI/brRc+LESqg4MRGSA=;
        b=KVsoqNmGb3sKlK+AY35TTWQWTvgwJf6nrzv1Yzj95Cxgcaa61xKpIS3f4iFZNvmMf4
         nl4mogb/fJWAR6cIjea5LP9OG//PAgXLbmlI5kyGUp3fuf0qzHO/ZWiP0Moi/fX41MXB
         kReUgT5r3bblUHCpVt61SjRPTZcSz2C+mI5IqXxy9b3fen0nOrpgqLWT2mrBOJ/lHK8k
         eFIKULe5QRrKrWcDkO33LA4Hra4PqMt9xvow67LK1ii4lkdGw14/F0msNJJQ6tFuqSQC
         aOD9JdOJmncLT6A3PmIdkb5tasfsV6OFQUkOlxjO84HXFq35qg7cFC+M931kAffRHZGA
         HTuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752809415; x=1753414215;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=4rnxIvJYd1dwa8Ne+tskFcl9UI/brRc+LESqg4MRGSA=;
        b=HmDpH5IjV5Lz3vtWRvVu6TYgHf1ddhSOafHlvXGWPOt8Td6Duv9zyX3M7YFRP5Dzzp
         gBg+oWIPMGNomA2oxyp92/u8iKErppRCRsgyI0lD3J7zVcC5ce5On133o/r/SeLC0wrY
         n0rlQLW4EboimZGJiQKnRsT/0ghfc38CRuX8eRHdJP5Tq3Y7dG5GI7jn1Y0mMZ16gsfx
         TLB9Zbxk6AVBQeujmM0caHD4E4nzmazWItEf6MWH2TWfKl5xRiVDd0rmZFmaduWmgj+r
         8p24yrj1Wp4/8wIhjsKvldOo2R0BO808F17AgbRmHhYmz3y9pOqsxWgCW/FpHW2XYAD8
         qKBA==
X-Forwarded-Encrypted: i=1; AJvYcCVdEIGaDtEryrfes+2GjqYyQwBkA5fTohO8EmSjNBxa4nhxnMyVe4ErWMyN5/OzHy7XZveWiLwWvE9l9Zc=@vger.kernel.org
X-Gm-Message-State: AOJu0YymmXO1iFI/6lUEG5rUgEaSCRA2/imn9QKHy1ewhk7U/6UZKYH/
	wf6aYCIxT9ct6B7g2fwbys2718RYFgRQYG1Kakf4S+moSuUSHaeGIgKM
X-Gm-Gg: ASbGnctO4PGzFPg/KEbrowrKK7TjnhCAFBTNLeFTzZYuTR1SF08IcceAFIJejgv+I0w
	m+3Ca8CDg5QWTTCMEr52PnYBAm4ydKBlEiTgVJg1p7bxnjEMwF8itvdzOiSHlK7X04db2zd0ijj
	L3yvE2055HkX9ShTv21zY8bwPXTzdqyXkwcReLffoGcoEUSjqfTivBlRDR6NctlvgtIJfDSaSUa
	AW/toIdGW6FKWCEKID66SDRXUXDHZppLYv6fT8peY+SjoP+OiJqsgf+9D6D0bZPjjXEdmfBd3V5
	sA5S82ycHKm9JF7gx0jE8SdK4MeGCY40V8uniwp7yl2Ru2VgtqexztuDcSr4XSuyc8bjWUTPIus
	uRb+mtgNzTGCi20frjKf0bRu0FlPh8V+Zjr0fW/A/c7s=
X-Google-Smtp-Source: AGHT+IGkDqX1RTd8raIX3m8tcMh8W9BgAWNUWa32boHUUPSgX/YclM2BmYcR9GuNXR5S0sVoMl9ZOw==
X-Received: by 2002:a05:6a00:bd93:b0:751:6ff5:df35 with SMTP id d2e1a72fcca58-758492e7360mr8723316b3a.8.1752809414615;
        Thu, 17 Jul 2025 20:30:14 -0700 (PDT)
Received: from [10.125.192.82] ([210.184.73.204])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-759cb678fecsm291392b3a.118.2025.07.17.20.30.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Jul 2025 20:30:14 -0700 (PDT)
Message-ID: <729aa946-7609-890a-3a13-4b0a58359aaa@gmail.com>
Date: Fri, 18 Jul 2025 11:30:03 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.0
Subject: Re: [PATCH] mm/mglru: Update MG-LRU proactive reclaim statistics only
 to memcg
To: Yuanchu Xie <yuanchu@google.com>
Cc: akpm@linux-foundation.org, yuzhao@google.com, shakeel.butt@linux.dev,
 mhocko@kernel.org, lorenzo.stoakes@oracle.com, kinseyho@google.com,
 hannes@cmpxchg.org, gthelen@google.com, david@redhat.com,
 axelrasmussen@google.com, zhengqi.arch@bytedance.com, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, Hao Jia <jiahao1@lixiang.com>
References: <20250717082845.34673-1-jiahao.kernel@gmail.com>
 <CAJj2-QFNvw2dMQtpZt1nHjKYdJWCH_=w2=2RWLL6m__MBb6KpQ@mail.gmail.com>
From: Hao Jia <jiahao.kernel@gmail.com>
In-Reply-To: <CAJj2-QFNvw2dMQtpZt1nHjKYdJWCH_=w2=2RWLL6m__MBb6KpQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2025/7/18 04:18, Yuanchu Xie wrote:

Hi Yuanchu,

> Hi Hao,
> 
> On Thu, Jul 17, 2025 at 1:29 AM Hao Jia <jiahao.kernel@gmail.com> wrote:
>>
>> From: Hao Jia <jiahao1@lixiang.com>
>>
>> Users can use /sys/kernel/debug/lru_gen to trigger proactive memory reclaim
>> of a specified memcg. Currently, statistics such as pgrefill, pgscan and
>> pgsteal will be updated to the /proc/vmstat system memory statistics.
> 
> This is a debugfs interface and it's not meant for use in production
> or provide a stable ABI. Does memory.reclaim not work for your needs?
> 

No, I am comparing the two interfaces.

Thanks for your reminder, but I want to use this interface run_aging() 
to age folios, and separate proactive memory reclamation from multiple 
walk_mm() by combining it with BIT(LRU_GEN_MM_WALK).

For example, user-space agent, enable LRU_GEN_MM_WALK, and then trigger 
run_aging(). Then turn off LRU_GEN_MM_WALK and use cgroup.reclaim to 
trigger proactive reclamation. Avoid the long latency caused by walk_mm().


Maybe it would be more reasonable to put walk_mm() in workqueues?

I don't know if my idea is reasonable, any suggestions are welcome.

Thanks,
Hao

> I'm not against the change; I just hope you don't depend on it
> continuing to exist/behave a certain way.
> 
> Shakeel's comment is accurate. The lru_gen interface uses the internal
> memcg id which is not usually used to interface with the userspace.
> Reading this file does show the cgroup path and memcg id association.
> 
>>
>> This will confuse some system memory pressure monitoring tools, making
>> it difficult to determine whether pgscan and pgsteal are caused by
>> system-level pressure or by proactive memory reclaim of some specific
>> memory cgroup.
>>
>> Therefore, make this interface behave similarly to memory.reclaim.
>> Update proactive memory reclaim statistics only to its memory cgroup.
>>
>> Signed-off-by: Hao Jia <jiahao1@lixiang.com>
> 
> The patch looks okay to me too.
> 
> Thanks,
> Yuanchu

