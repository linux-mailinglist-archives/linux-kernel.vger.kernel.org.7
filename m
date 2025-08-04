Return-Path: <linux-kernel+bounces-754950-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id CC5B2B19F0B
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 11:54:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A1E2A4E1036
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 09:54:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E29A1246335;
	Mon,  4 Aug 2025 09:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="P1wOMYoB"
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3E1CEEA6
	for <linux-kernel@vger.kernel.org>; Mon,  4 Aug 2025 09:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754301247; cv=none; b=YnzEVw4dT//fqII3XsQuDHtZNJPGL1quhmHCMW4jGn1dU70Vft9Fq3zS/LI92QXol8r2RUnxL8wSo38dCVw6HwY3PjKM9H8Z4FSn/7cd62+Obk/iQVzVZId5wpACHI6DyNrPG9UXB8EHTrioM/fD5gakIF2WKhPwO6vw5w1+JhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754301247; c=relaxed/simple;
	bh=Jj6d6UYb9vMnUKSBUQjOCQ3wI8ezfMiQpfBUHySc7ak=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=EDDxGqq12SI2qU3bD0CzbxwhV+G63bk1rYCNQdfAiPTn63ph+DAv0vQ0VwU+aZeK9Ah02fv3Lej4Q9XR0W0pZYD8deScxf++5n/9aTBZa93YAvsjWn03iXUhE9yFaLTojhxS8yd+yVGQbsc5aLt/uYqf4+OvVVoX7FOAsFjbqOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=P1wOMYoB; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-4af027d966eso28730871cf.3
        for <linux-kernel@vger.kernel.org>; Mon, 04 Aug 2025 02:54:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1754301244; x=1754906044; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bSo3E/6bQlnKLRKGBJ3CbHQxibx0gycUwYvf86x+SNY=;
        b=P1wOMYoBHGKMhh0M3nHTd9Ggw1s8UrrtovN9Z7Ecvq+F0XqyOxxHbjVl2J8OdkmImB
         jyN0Ac+v9bUkLLl5v8f2cuFBJEJor3j9R7sGc4CR2pzGazLcLm8ZiuqeWnlQE7j2UmyK
         MWipF7lyxXI7AsOtw6rtE/OUUHCSr9hl9gGnXZZD0HdNVf0khDlGYeWltga0NUO3rQt0
         d+LXbIqsu3x+yt0YPXNtIEuxKns3VXjuX4OSBVD7FTzbRCPCwF4i3X5+ZMSEY46Fnrxo
         RPXxnsm9dXbGvSSmRhwOFw5wCBGJ7U5CCBR7mlZcSpCsaUOpeW9NF+NmoxlxtbFPPqAw
         pxoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754301244; x=1754906044;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=bSo3E/6bQlnKLRKGBJ3CbHQxibx0gycUwYvf86x+SNY=;
        b=lfJqaU3X3Cr/O7s4hMC/ZXgnbJXA1oYMYBtGeyHJVPwNDca/11RwKZP9SMaUqdp1bX
         BsVXfG56h3P8XIhNtEM0Y7pZQXwEnAN6a4sgbMItxWuWE7m3u+LLz1o+hpkEmXZfioHV
         QARZCtInu8Fr/TAPeHIkQTpVAB8I4jDhUE1xoCZZVigYprSsg9ZDZKhb2bd9WisY9bZQ
         vTKLT4o0tQ23yA9FPz/UQROzkfg0ml17lBfZUXrUA6YnaFDJ96EA7qnTh0ayKh/L6PyY
         419yBjuQSONrp3iz6ssdwygQkv85e/lvDYW5px4WzbDIAhVLpKWh3N/EdJRAnJdl+1fW
         87yw==
X-Forwarded-Encrypted: i=1; AJvYcCVPEqW6bB3f9EjSiPSoY4SrkxRTnGO7unLEB/npFOxlNyyOhEo7ensj5UJubEk4rPMyh8LyhpF/o8AUiVo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwF1AsXBmNkmfIbpc0Qh9wHOfCpaoTPnxLljVzxnmFssktagDZ5
	Pskz+kgKnf7wgX87gmq3HjGGxEnMgAHmO6L2Egymtf42JVkrq4rz2j5vl4DqACV4UkQ=
X-Gm-Gg: ASbGncu1+5dFQcHyK4wSvHscIf3egTebqOSbpJ/2e0iW4qhheJ1/l13TcMOKWiKB3AY
	jZ5jt+h3iarv0fEHX71VWJRzgCFbRkuD+0VsMl3Gwo3BdjEFmD6OEe6wcXwnzG70/s/iUVdVuC8
	7vTx7VtgUFKubNTsFJFU6lfwWiluk1l/zIUVJYSqWIqNvQbMIBnkW3WVWhoAojcO63bB/i7VYUt
	SHal8oiJhVCCv+O61W2XQmFOdMd4CZPPDYJArrvYdsWg5prZFJzDZkoBUtBr/rgCynkvinTRLGd
	cB5mM8qZecO9+TPERaxhHkc1hCWnNPEKe2mio293mEHoxyLmv+FaLtXKKyD0Z5+7yyNZjrLOLkT
	rNP4hojUQH9AvtHwHd2H4KiASTikdwcO3FK+XHn9r0dkb3g==
X-Google-Smtp-Source: AGHT+IHZ1UdeUoGikf0DmtLNqfIwKAfak4BWKnOryeLRT18SeWreS93dBj4uPC7kn3VpVZP6pAlboA==
X-Received: by 2002:ac8:5a54:0:b0:4af:fee:bb01 with SMTP id d75a77b69052e-4af10a4a5aamr107018941cf.32.1754301243600;
        Mon, 04 Aug 2025 02:54:03 -0700 (PDT)
Received: from [10.68.122.90] ([63.216.146.178])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4af0c7b1d08sm30846901cf.3.2025.08.04.02.53.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Aug 2025 02:54:03 -0700 (PDT)
Message-ID: <ca86203d-89b5-4282-b318-2ac82fd2121f@bytedance.com>
Date: Mon, 4 Aug 2025 17:52:39 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] mm: use per_vma lock for MADV_DONTNEED
From: Qi Zheng <zhengqi.arch@bytedance.com>
To: Barry Song <21cnbao@gmail.com>
Cc: David Hildenbrand <david@redhat.com>, akpm@linux-foundation.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 Barry Song <v-songbaohua@oppo.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka
 <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
 Suren Baghdasaryan <surenb@google.com>, Lokesh Gidra
 <lokeshgidra@google.com>, Tangquan Zheng <zhengtangquan@oppo.com>,
 yi1.lai@intel.com, "Lai, Yi" <yi1.lai@linux.intel.com>
References: <20250607220150.2980-1-21cnbao@gmail.com>
 <aJAFrYfyzGpbm+0m@ly-workstation>
 <1d1d97f9-2a67-4920-850e-accf4c82440e@redhat.com>
 <4fa8f492-c7ef-451c-8dc7-38b031c8a092@bytedance.com>
 <d9d0890e-2837-49dc-9ca8-1d6c28e95a21@redhat.com>
 <aJB0Kdc6cx1lGkdb@ly-workstation>
 <CAGsJ_4yw4Qn7OWmUJeJZYuOHLjJ7L8kov3Th3vFPa3h4y0ur_A@mail.gmail.com>
 <7d92ec18-ff8e-4929-8b9a-f0bf5c6d249f@bytedance.com>
In-Reply-To: <7d92ec18-ff8e-4929-8b9a-f0bf5c6d249f@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 8/4/25 5:35 PM, Qi Zheng wrote:
> 
> 
> On 8/4/25 5:15 PM, Barry Song wrote:
>> On Mon, Aug 4, 2025 at 8:49 PM Lai, Yi <yi1.lai@linux.intel.com> wrote:
>>>
>>> On Mon, Aug 04, 2025 at 10:30:45AM +0200, David Hildenbrand wrote:
>>>> On 04.08.25 10:26, Qi Zheng wrote:
>>>>>
>>>>>
>>>>> On 8/4/25 3:57 PM, David Hildenbrand wrote:
>>>>>> On 04.08.25 02:58, Lai, Yi wrote:
>>>>>>> Hi Barry Song,
>>>>>>>
>>>>>>> Greetings!
>>>>>>>
>>>>>>> I used Syzkaller and found that there is general protection fault in
>>>>>>> __pte_offset_map_lock in linux-next next-20250801.
>>>>>>>
>>>>>>> After bisection and the first bad commit is:
>>>>>>> "
>>>>>>> a6fde7add78d mm: use per_vma lock for MADV_DONTNEED
>>>>>>> "
>>>>>>>
>>>>>>> All detailed into can be found at:
>>>>>>> https://github.com/laifryiee/syzkaller_logs/tree/
>>>>>>> main/250803_193026___pte_offset_map_lock
>>>>>>> Syzkaller repro code:
>>>>>>> https://github.com/laifryiee/syzkaller_logs/tree/
>>>>>>> main/250803_193026___pte_offset_map_lock/repro.c
>>>>>>> Syzkaller repro syscall steps:
>>>>>>> https://github.com/laifryiee/syzkaller_logs/tree/
>>>>>>> main/250803_193026___pte_offset_map_lock/repro.prog
>>>>>>> Syzkaller report:
>>>>>>> https://github.com/laifryiee/syzkaller_logs/tree/
>>>>>>> main/250803_193026___pte_offset_map_lock/repro.report
>>>>>>> Kconfig(make olddefconfig):
>>>>>>> https://github.com/laifryiee/syzkaller_logs/tree/
>>>>>>> main/250803_193026___pte_offset_map_lock/kconfig_origin
>>>>>>> Bisect info:
>>>>>>> https://github.com/laifryiee/syzkaller_logs/tree/
>>>>>>> main/250803_193026___pte_offset_map_lock/bisect_info.log
>>>>>>> bzImage:
>>>>>>> https://github.com/laifryiee/syzkaller_logs/raw/refs/heads/
>>>>>>> main/250803_193026___pte_offset_map_lock/bzImage_next-20250801
>>>>>>> Issue dmesg:
>>>>>>> https://github.com/laifryiee/syzkaller_logs/blob/
>>>>>>> main/250803_193026___pte_offset_map_lock/next-20250801_dmesg.log
>>>>>>
>>>>>> Skimming over the reproducer, we seem to have racing MADV_DONTNEED 
>>>>>> and
>>>>>> MADV_COLLAPSE on the same anon area, but the problem only shows up 
>>>>>> once
>>>>>> we tear down that MM.
>>>>>>
>>>>>> If I would have to guess, I'd assume it's related to PT_RECLAIM
>>>>>> reclaiming empty page tables during MADV_DONTNEED -- but the kconfig
>>>>>> does not indicate that CONFIG_PT_RECLAIM was set.
>>>>>
>>>>> On the x86_64, if PT_RECLAIM is not manually disabled, PT_RECLAIM 
>>>>> should
>>>>> be enabled
>>>>
>>>> That's what I thought: but I was not able to spot it in the provided 
>>>> config
>>>> [1].
>>>>
>>>> Or is that config *before* "make olfconfig"? confusing. I would want 
>>>> to see
>>>> the actually used config.
>>>>
>>>>
>>>>
>>> My kernel compiling steps:
>>> 1. copy kconfig_origin to kernel_source_folder/.config
>>> 2. make olddefconfig
>>> 3. make bzImage -jx
>>>
>>> I have also uploaded the actual .config during compiling.
>>> [2] https://github.com/laifryiee/syzkaller_logs/blob/ 
>>> main/250803_193026___pte_offset_map_lock/.config
>>> CONFIG_ARCH_SUPPORTS_PT_RECLAIM=y
>>> CONFIG_PT_RECLAIM=y
>>
>> Thanks! I can reproduce the issue within one second.
> 
> I also reproduced it locally.

Hi Barry, can you reproduce this problem stably? I can't reproduce it
again after reproducing it once. :(

> 


