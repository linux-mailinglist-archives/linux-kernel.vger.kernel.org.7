Return-Path: <linux-kernel+bounces-736206-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DBC7CB09A11
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 05:09:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B09B3A44DE2
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 03:09:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 107481B4257;
	Fri, 18 Jul 2025 03:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KhKheTgF"
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21A8B1400C
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 03:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752808177; cv=none; b=gR5ktBmNypgypRmHPQLiCPdvGWSyN0lc0A/JfU1u6WqAJq06O+qFmsENPOG1cIaqgoz6F3Tx/aJvFgBQjv4GyiCBis8cEPcUS/ganHGsuA+xd4PUrCI0MEZw/fqDEPX4ivNXfT26yfo0wOHCaK5iLl7Z/v6Sve3UuHXTFMyGc8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752808177; c=relaxed/simple;
	bh=3qtNo7zkUqwrg/B/cF3W/fwZMUD/NPcHzyXciYxO7mA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=En4IPMRiAFam0aOdDf/58PCS9idUI6hlOu95g3K+iD7nQTOdjL3EA5svXGch3egXHnejM2DYNFR8SBGo0vTy6m/2joy7WlaGDTr7nia+r/Qfi/ARThGKMPM5TvE4RNLZuGyfq2uyTnz3ndVX8NeCQtMrjMLTKHQlReyQZj6NAco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KhKheTgF; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-3138b2f0249so1356717a91.2
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 20:09:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752808175; x=1753412975; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FvDciYpX6cDw67gVhydVWFNn+mPhlWsC+2w9TSXDjyM=;
        b=KhKheTgFVcHfa0vIz9rpPu/2RYFhN2s/+o8TERC2kS7UOCBeFtYXS4FnO0EsNxULUj
         QIUtdjZN6i34SsTpVGGmu4m75dmW6C62wLogrrYbPA0Eh3GjpLpbSg0T+Ym8eo8GqZ4c
         gaaBKMtvb9mIBZDY/NJnKSo9uQDJljE4PfoYRPgCs3fphM4aOa1ZKnd1lXA5IgkxZtZ/
         AmYraVdsgS/6xlQt0+oojCdEFWL0AXijDn4J0Uepi0z5oWio3ig/rbwaXl/tIm4akiuZ
         C5vGqjTVMsok5w/lf3wz91Gqd+GQ1eNDlztNteqLxfEsZyNAXrXyJ/j/o7d9GjRseiJ0
         3X+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752808175; x=1753412975;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=FvDciYpX6cDw67gVhydVWFNn+mPhlWsC+2w9TSXDjyM=;
        b=O+vh0KUjtPLzH21NvnPYylYKhgCqr+LzRxciEUffGRWTuWN18hliLIe2u3jwj5vtWE
         pdVOR3+N90kt/RrmZYMNt/V33GW2VmBhW1OeRlztsJKPgt9iLed7WyHJvWcejaG147Pj
         +Rr3RwnzIRkAJGtRuNMmZTlbKbAzosJq6RJizQ10ALQ9HFn0N+QEzlj4nA5D4pWFF6lc
         2CALon3YUaioU71HcYZcct/0nfsCzXufkfByjZtrzzH/EgBgjKFD39yy0QQrNrRUhYvY
         gml1eapufjitXCDg6KTDJB8qRcCk1869oI5/TeA9eRqcRRGLRibxX0mGaLMZye8d/U+F
         PDkQ==
X-Forwarded-Encrypted: i=1; AJvYcCUZuthT+OUKPnu+7lpSjHRCsp39iOsieGd45SlXx9cjn1rfPBD7uPYAzplWh+/avM/I7Md7cXVJ28ywsBg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzpGxA7F/H6nzySPjzUYci1tAgEI0KLjhwv8/c2ArzpucGfntMv
	dCoB1viVJiuIcPPDwvEKe1pCukn38B85cU3i/aEqB2LnETvM1GQH8NkC
X-Gm-Gg: ASbGncv87uaMYNZKXuyT60SJsUk389YaC5EX1X10nf1waB3EAdbI9Z8UlNKT4QN6pRn
	1Ed7smfMeEfZ1ZOPdr+JMnJCufbzj7emAJNxbNKy0D27XvZ4i02cB0010pUDNOOALaV5xqIVRSV
	5h4D4bh/vgBFDf4kY3XiO8Cec+Kv+zuUGKoI1uBS18JJAZ25qK72zwikVLszPMyxsj2THIKS8PK
	LJP3stkzL1DDfPXuNTUyJ+alEf5BtQAFoq3/oa5ykxYTqJzKG4kGZL96WQZAgPvtoYhfM4TCEtI
	L3jpa0g+01iyqujMfDBGcTk4V25ozr19pUz7yQmQXWhxN6K7GCEJkkd4vI6tSjr6RgU3rz5c4IV
	syhkd0YwNRweyypUXP0po13qusVgR2g/Bqdx5MTlNwcCKjr99S6AOLg==
X-Google-Smtp-Source: AGHT+IHhbuJienL7Fkwh/SX482W4DVo1oRYNgwQdvKeQQeliqD7sCv9BZrpPxsp7U76XyH3tl/NZXg==
X-Received: by 2002:a17:90b:5610:b0:313:bdbf:36c0 with SMTP id 98e67ed59e1d1-31c9e605f80mr16126118a91.0.1752808175268;
        Thu, 17 Jul 2025 20:09:35 -0700 (PDT)
Received: from [10.125.192.82] ([210.184.73.204])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23e3b5e2d20sm3753465ad.32.2025.07.17.20.09.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Jul 2025 20:09:34 -0700 (PDT)
Message-ID: <062c9e67-b0e2-0528-399c-e11428485008@gmail.com>
Date: Fri, 18 Jul 2025 11:09:25 +0800
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
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: akpm@linux-foundation.org, yuzhao@google.com, yuanchu@google.com,
 mhocko@kernel.org, lorenzo.stoakes@oracle.com, kinseyho@google.com,
 hannes@cmpxchg.org, gthelen@google.com, david@redhat.com,
 axelrasmussen@google.com, zhengqi.arch@bytedance.com, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, Hao Jia <jiahao1@lixiang.com>
References: <20250717082845.34673-1-jiahao.kernel@gmail.com>
 <z3n3dfpgrctgf3mlkqydmos2svh353v3qzd22n4g3iygji6rsr@4l4zgkrl5w35>
From: Hao Jia <jiahao.kernel@gmail.com>
In-Reply-To: <z3n3dfpgrctgf3mlkqydmos2svh353v3qzd22n4g3iygji6rsr@4l4zgkrl5w35>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2025/7/18 03:47, Shakeel Butt wrote:
> Hi Hao,
> 
> On Thu, Jul 17, 2025 at 04:28:45PM +0800, Hao Jia wrote:
>> From: Hao Jia <jiahao1@lixiang.com>
>>
>> Users can use /sys/kernel/debug/lru_gen to trigger proactive memory reclaim
>> of a specified memcg.
> 

Hi Shakeel,

> Are you using this interface for proactively reclaiming a specific
> memcg? 

I am comparing using /sys/kernel/debug/lru_gen or cgroup.reclaim to 
trigger memory reclaim when MG-LRU is enabled.
For user-mode agents, the two interfaces can achieve the same function.


I see run_cmd() using mem_cgroup_from_id() to get memcg from a
> given id but I don't think we expose ids from mem_cgroup_ids to the
> userspace. Usually we use cgroup_id which is just an inode number for
> the cgroup folder. I wonder if the current users of this interface are
> providing memcg id.

We can get memcg id through ` cat /sys/kernel/debug/lru_gen `.


Thanks,
Hao
> 
>> Currently, statistics such as pgrefill, pgscan and
>> pgsteal will be updated to the /proc/vmstat system memory statistics.
>>
>> This will confuse some system memory pressure monitoring tools, making
>> it difficult to determine whether pgscan and pgsteal are caused by
>> system-level pressure or by proactive memory reclaim of some specific
>> memory cgroup.
>>
>> Therefore, make this interface behave similarly to memory.reclaim.
>> Update proactive memory reclaim statistics only to its memory cgroup.
>>


