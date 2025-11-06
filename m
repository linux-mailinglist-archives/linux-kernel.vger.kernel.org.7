Return-Path: <linux-kernel+bounces-887826-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 853F4C392D1
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 06:35:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3EDED3B5C8F
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 05:35:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE2802D876C;
	Thu,  6 Nov 2025 05:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E81LWkWL"
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B19E812B94
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 05:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762407320; cv=none; b=TLH6BqEHNx83IdtaVbVtxdxn/LHcbk41Pp8ad0su+5Ql7MPQt+m3sPcJEv2PWw3HVrDp2AW7EPOZZ3gFyb80RpNsjXvGy7tkOT8Bpi1REGgHE/4c2gdg6On7c3shN6KfaVVCR82134zpXuGZHUTx0+e6N7iNpfonwOZIPtVkAEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762407320; c=relaxed/simple;
	bh=jW8Ecmr5jd9+ijYWXvVMEEtpHOAriPwFDiD3dWIebtk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IQUR/WO+8rc1eWI2QK5KqFUcF2iKxNZwEcGTuX+B8OQtu8BjZl9YFbPrql/04lRfeXyOCvlusSgi1nJZ7WyY+AS9x4h5NriSG+go3RLiaEzEb1oLUC0B//4whON5ZCgpaxiH8S8vwryBeoRN0TFmgPgpVMng6CiQ+OMPqVFZ2E4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E81LWkWL; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-7af603c06easo712456b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 21:35:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762407318; x=1763012118; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xqu+odkC5y2EUQD3P72UD8nqz7ztmWCfwzT6Wx3nK2g=;
        b=E81LWkWLvL/I8cJ/R/PgetxwBlzhMuyDLiFT8Q1Ph20irxQUVXuwc+pEsUuQy+p53t
         Qtz04OzhDE7HEsTAj6edqOgDRxU9caPzs5omrkH+maLrowcY7Di+ZLyyQnSKBY7RIhS5
         u9BAxoAa8FFxzaxghsAbcTyZ5RfXvoalgMFu73Buq2m70SqakCtn7M9FhJc7Tcd96hjv
         zx/iiVYlNHkgZ52L3kFdnwX80mz3n1RPpQQYaiYy1IvWyqSoIyV8RGfISvmx9jf/DAlq
         oi7omQkx2WSiBIkpRb3IhedztVF32Gcw1eAlfVAqTiY6JbpM1Q5Za8PP4MjftM5WNNxE
         GcTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762407318; x=1763012118;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xqu+odkC5y2EUQD3P72UD8nqz7ztmWCfwzT6Wx3nK2g=;
        b=wY7kzsGx8vwvMEL3Sb04J+C4PliTKlgshXa1k+NkSB8OyqntU6E8B52yFFMBo0a7Zv
         +d2GTXk+Bjc9dQkb1ih5zun9Ab+M2egszBamaF9YtoOjngVTG7TGr2vkvutuEMEKnj8I
         JdQmiMkYwMsbge7bwWf2glXTyADW3kxr7NVjv76ZGc91qOB/gTBQajITZ4rQPM0p6Z1f
         3eVCzJBLb8NbwgQj5e1aKAyyfSu0wTRiS69U5KMyElrSK0j8ezlQtPz+LjBzDIupgmyo
         o8nD0f7PFeOa/txB99kkjaoB4KrVoIzxeNJ3Vtz8TxytEZ9MbGBFIVccST9dgaXYlEB1
         Cxtw==
X-Forwarded-Encrypted: i=1; AJvYcCV0BTuHc1Y/qPgl2QwoHPv81WHN3Ek93ynQHK979v8QYMv0OQAZg/ZkMiDBzC9J+ECVlk+2z1aiL0ujrLQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGW4yLSeMqoRM311+YLXQ+zBv5+ute41gcMX6qiNY8EkDjyTSG
	YLE4mqS5yn4G/3Lnpob2UKrB8n7+ky5Bd3RmFAGgx7P/oCaFYL8NAApo
X-Gm-Gg: ASbGncvsFwKr9AdCTKRIX0kC9curlnBds7xf5iTggvVWfUYDL60ylckkW6BvsgPYCpt
	BKYPD5LTcGwdBwZM6wFpz9LYbvStaqstW5G+7cnZtJpW14Py+DRjVRRdVUA82+4sB2vFEq1PKl9
	oMtbjzXb1ArvH0gncKy5mG5m8kqnRQMHQYhXtt7Mp5VwcpJOdet2Oc4H89L5EdtoA45P1vG+Syb
	VRHYLBgMhmxHyEWf/+2uVblwdv1R0ext834Q29+L5758TEPUuNfbIkMB86DPkYw3SFBS//FZHgX
	Qq+ZsKNr/YBcmHRjRLLheD4hJf2J8fcsjE14S0w2VHSpj0H64U8YqU9ZUBLdUiZYdZGZ/W7YU3N
	/zL3sdhrQRjeOva5himlnfO1dP0od2kA6mMTbL0DGl23ArD6QmCYV4jAksUbSikSK1kOGAMwn9L
	S6K7drxKLuuYHPNUJcLa7C
X-Google-Smtp-Source: AGHT+IHdEFv9Zor3bc4Bu4OwuhNr0f57kycevNnexdIDViJx433B1mm7bsY0xFtLkvh/PAGC6U94nQ==
X-Received: by 2002:a05:6a00:1818:b0:7a9:7887:f0fa with SMTP id d2e1a72fcca58-7af6f5e1aebmr2587605b3a.1.1762407317929;
        Wed, 05 Nov 2025 21:35:17 -0800 (PST)
Received: from [192.168.4.196] ([73.222.117.172])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7af82af1907sm1290495b3a.62.2025.11.05.21.35.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Nov 2025 21:35:17 -0800 (PST)
Message-ID: <c704e7d9-5bc9-43e6-98cf-d28c592b0f3b@gmail.com>
Date: Wed, 5 Nov 2025 21:35:14 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH mm-new v2] mm/memcontrol: Flush stats when write stat file
To: Leon Huang Fu <leon.huangfu@shopee.com>, shakeel.butt@linux.dev
Cc: akpm@linux-foundation.org, cgroups@vger.kernel.org, corbet@lwn.net,
 hannes@cmpxchg.org, jack@suse.cz, joel.granados@kernel.org,
 kyle.meyer@hpe.com, lance.yang@linux.dev, laoar.shao@gmail.com,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 mclapinski@google.com, mhocko@kernel.org, muchun.song@linux.dev,
 roman.gushchin@linux.dev, yosry.ahmed@linux.dev
References: <6kh6hle2xp75hrtikasequ7qvfyginz7pyttltx6pkli26iir5@oqjmglatjg22>
 <20251106033045.41607-1-leon.huangfu@shopee.com>
Content-Language: en-US
From: JP Kobryn <inwardvessel@gmail.com>
In-Reply-To: <20251106033045.41607-1-leon.huangfu@shopee.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/5/25 7:30 PM, Leon Huang Fu wrote:
> On Thu, Nov 6, 2025 at 9:19 AM Shakeel Butt <shakeel.butt@linux.dev> wrote:
>>
>> +Yosry, JP
>>
>> On Wed, Nov 05, 2025 at 03:49:16PM +0800, Leon Huang Fu wrote:
>>> On high-core count systems, memory cgroup statistics can become stale
>>> due to per-CPU caching and deferred aggregation. Monitoring tools and
>>> management applications sometimes need guaranteed up-to-date statistics
>>> at specific points in time to make accurate decisions.
>>
>> Can you explain a bit more on your environment where you are seeing
>> stale stats? More specifically, how often the management applications
>> are reading the memcg stats and if these applications are reading memcg
>> stats for each nodes of the cgroup tree.
>>
>> We force flush all the memcg stats at root level every 2 seconds but it
>> seems like that is not enough for your case. I am fine with an explicit
>> way for users to flush the memcg stats. In that way only users who want
>> to has to pay for the flush cost.
>>
> 
> Thanks for the feedback. I encountered this issue while running the LTP
> memcontrol02 test case [1] on a 256-core server with the 6.6.y kernel on XFS,
> where it consistently failed.
> 
> I was aware that Yosry had improved the memory statistics refresh mechanism
> in "mm: memcg: subtree stats flushing and thresholds" [2], so I attempted to
> backport that patchset to 6.6.y [3]. However, even on the 6.15.0-061500-generic
> kernel with those improvements, the test still fails intermittently on XFS.
> 

I'm not against this change, but it might be worth testing on a 6.16 or
later kernel. There were some changes that could affect your
measurements. One is that flushing was isolated to individual subsystems
[0] and the other is that updating stats became lockless [1].

[0] 
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/kernel/cgroup/rstat.c?h=v6.18-rc4&id=5da3bfa029d6809e192d112f39fca4dbe0137aaf
[1] 
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/kernel/cgroup/rstat.c?h=v6.18-rc4&id=36df6e3dbd7e7b074e55fec080012184e2fa3a46

