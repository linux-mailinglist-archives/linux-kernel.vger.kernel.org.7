Return-Path: <linux-kernel+bounces-848242-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 64F4DBCCFF6
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 14:54:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 404CC4F59E6
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 12:54:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 785162EFDA1;
	Fri, 10 Oct 2025 12:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hRRGuWLc"
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 373D04414
	for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 12:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760100885; cv=none; b=emHQTFY0M0PBXHk3qZjubToiUN9ABsrCN9ayUB/G1UHXfl72u7XGvsyr580lMTXTxKVZeZo3x52uNlqkIXO/CoyUe4QjLoA4C32WUg2FAox90UvzT2X3ppyvFki+o+yT9K75H11UDLqXoB5KKulxclTVzHGKBfZUrZTMhjwlR4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760100885; c=relaxed/simple;
	bh=cNunwt1gn2omp+C+FbkZBROAPqfXLTbgv7DeZ7+Yzg0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rXhKAfymWS9qKHdtZYf9dpe/aT2KT57O8iAh2YUYKv2lRMfHK1u4hGL8apLoMScWQxLkb5op+1EcBo4yfsWOqXgXwGkqIOSNsvqlpfcrBnGq4yWNlYjjDOTOi4NK7ln4ntsHtQmAvWdslETGJdm6P3QBsRi+IBLvxSqX60JUO/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hRRGuWLc; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-339d7c4039aso1993539a91.0
        for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 05:54:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760100883; x=1760705683; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kldC2zud6k9mqSCmtlg6o1ObXhcirCSqMnvOGGq4r3s=;
        b=hRRGuWLclPizUTGmiQYQQ8F25Pon1yV1xSxq71EZKOwbTbn4tpYLOY//cWdeJHlJxp
         vpGpODYSp88/TIRUznY1bKp27GySo5lQWcl6vumM0mB0ChTl1bdhUcX6rJ7mb3iVu1z1
         VTrgsthUI/HxQCN+n2XZNt9pkr96FyDED8NeLpwwXMjkI6YoCkjeLZsrBDaFoEu16Vct
         ZCo5Vj7Qe+duSki4CzZuPRlKnSIJbLYfkxmCwQ8dSM9WtzxfFLA4g+6MTNcLJ58nJnmz
         7ra8v/C/+An/1HFjyptB/g/TePW/3UyzOSJb7S6k3D1ln5BZyEx6JDdWa3v7NyQVkXvs
         fdzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760100883; x=1760705683;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kldC2zud6k9mqSCmtlg6o1ObXhcirCSqMnvOGGq4r3s=;
        b=RCSsUr2UrY2umETn1mjfpUE4Zj1L2r98ZgHU3OUI11n6BKRbkuVmopEpwt2UknDX/D
         ztDQHyMXU7WRCMG8xmzJYyjpHlDtdoTnJnzdNGvLZWCQA+TMDr0Tr8CY3Xjm5pZ8ZhIQ
         VlyhXb77UyPwEuvf6o3UmEY77PGf1DFVy0TvkPKi8tfr0TnqoLXtaHynSid2V3yDYCft
         IskS/QHfH5iO3rGrdwPYoftBnoHOWlZgGVddliRTxY64z3ScFvhDB1uwrxPxIKW7xA4c
         2BIEerKsD+aspouwTasM/ja4nbDVmmuxA/pxAP5l8e79R5taYqolJiOVdhzYBU8tbA9I
         Guxw==
X-Forwarded-Encrypted: i=1; AJvYcCW7zo/ZzQxiRSI+vwGd24vtHzaQLv47vqC+u2E1aFTzQZoxr82Dgc+NDhUlZsb4IVohWoCkhMT7CpckcMs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9gCVzlloME0MX/a5B0gRaaTBHBO30x+bylVSZngNeUQDzREbG
	jWy7oUYXv3mi/DtHYzDJxpGo4QyBgVrNDKuJ6A77nRepO0MHFVUA/iR3
X-Gm-Gg: ASbGnctfRDeqpEO3yFQfJezSymYOyzEFIGvYxbAREfZtywoX9NyqjRTI8kl982P2YRU
	iyFktWVZcfhFeJyC0SA/G3v/a9UFaWf6cCU6gD9FnE5wVILRb26g1aIDK1m3hTfCYaP/8RJ8ock
	XOGwoX8KmX59e0Kh2YN9Ex+BBY/DCO8FICoMLel85hkbzby00FICMvTMSRkuWytuPpEIMGkNLWJ
	LyioodNflaXIcHfHncclkbfUOegqFwnq2o+r33eNRJVrjo4dYwc4FHtWx8PjMMuAvwspVRvjnXP
	TCYszl+eC7aNIdwiMovY2LbYHhMJQ2iHJviRTN7U2KKjGXbFAIxPXgiA0aEVbl7GlJEkcfIyp0R
	B4ucOEQmPdih38fcxuz5hYJ3xMzOEJKGzeFAGihFbLAJJfm1y
X-Google-Smtp-Source: AGHT+IEIxCl6Q477ztznNVKd7XMjfZA1OsWCmkCbiDx+RmUOwYB7lB3n8z2Z0BX7PWzMCBFIeSxkEA==
X-Received: by 2002:a17:90b:4d8b:b0:329:e703:d00b with SMTP id 98e67ed59e1d1-33b51386449mr15424797a91.19.1760100883216;
        Fri, 10 Oct 2025 05:54:43 -0700 (PDT)
Received: from [127.0.0.1] ([2a12:a301:1000::20f3])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33b62631266sm2912083a91.3.2025.10.10.05.54.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Oct 2025 05:54:42 -0700 (PDT)
Message-ID: <a4c80b15-fed0-4ba5-acc1-240ceb7278e4@gmail.com>
Date: Fri, 10 Oct 2025 20:54:18 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH V1] watchdog: Add boot-time selection for hard lockup
 detector
To: Ian Rogers <irogers@google.com>
Cc: Doug Anderson <dianders@chromium.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Will Deacon <will@kernel.org>, Yunhui Cui <cuiyunhui@bytedance.com>,
 akpm@linux-foundation.org, catalin.marinas@arm.com, maddy@linux.ibm.com,
 mpe@ellerman.id.au, npiggin@gmail.com, christophe.leroy@csgroup.eu,
 tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, hpa@zytor.com, acme@kernel.org,
 mark.rutland@arm.com, alexander.shishkin@linux.intel.com, jolsa@kernel.org,
 adrian.hunter@intel.com, kan.liang@linux.intel.com, kees@kernel.org,
 masahiroy@kernel.org, aliceryhl@google.com, ojeda@kernel.org,
 thomas.weissschuh@linutronix.de, xur@google.com, ruanjinjie@huawei.com,
 gshan@redhat.com, maz@kernel.org, suzuki.poulose@arm.com,
 zhanjie9@hisilicon.com, yangyicong@hisilicon.com, gautam@linux.ibm.com,
 arnd@arndb.de, zhao.xichao@vivo.com, rppt@kernel.org, lihuafei1@huawei.com,
 coxu@redhat.com, jpoimboe@kernel.org, yaozhenguo1@gmail.com,
 luogengkun@huaweicloud.com, max.kellermann@ionos.com, tj@kernel.org,
 yury.norov@gmail.com, thorsten.blum@linux.dev, x86@kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linuxppc-dev@lists.ozlabs.org, linux-perf-users@vger.kernel.org
References: <aMpRqlDXXOR5qYFd@mdev>
 <CAP-5=fV05++2Qvcxs=+tqhTdpGK8L9e5HzVu=y+xHxy9AqLMmg@mail.gmail.com>
 <CAD=FV=VNmjTVxcxgTQqjE7CTkK2NVGbRxFJSwv=yOHU8gj-urQ@mail.gmail.com>
 <CAP-5=fW64xHEW+4dKU_voNv7E67nUOFm27FFBuhtFii52NiQUQ@mail.gmail.com>
 <CAD=FV=U3ic707dLuUc+NfxtWF6-ZyRdE0OY2VA6TgvgWKCHUzg@mail.gmail.com>
 <CAP-5=fVkw6TLjVuR3UCNs+X1cwVmYk7UFABio4oDOwfshqoP_g@mail.gmail.com>
 <CAD=FV=UWkZx8xQD=jBkOO6h2f5tw_KCoqhHciw5hkEOYU=GM8A@mail.gmail.com>
 <CAP-5=fXTFHcCE8pf5qgEf1AVODs2+r+_nDUOiWgdQeEgUBHzfA@mail.gmail.com>
 <CAD=FV=VuDYiu5nL5ZeZcY2b+YXOzZtSu2E4qBBHz9fWTW8gPhg@mail.gmail.com>
 <CAP-5=fX4=fV70N3GCdXgV6o-YoJynnSppxJp0MwdRrtsyDrs0w@mail.gmail.com>
 <aOdbRI3BaMCbyvtv@mdev>
 <CAP-5=fUAato=+jyNNESCX3SjWMEEJQ697VvWiBFCi5wKs_JQCA@mail.gmail.com>
Content-Language: en-CA
From: Jinchao Wang <wangjinchao600@gmail.com>
In-Reply-To: <CAP-5=fUAato=+jyNNESCX3SjWMEEJQ697VvWiBFCi5wKs_JQCA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10/9/25 21:22, Ian Rogers wrote:
> On Wed, Oct 8, 2025 at 11:50 PM Jinchao Wang <wangjinchao600@gmail.com> wrote:
>>
>> On Tue, Oct 07, 2025 at 05:11:52PM -0700, Ian Rogers wrote:
>>> On Tue, Oct 7, 2025 at 3:58 PM Doug Anderson <dianders@chromium.org> wrote:
>>>>
>>>> Hi,
>>>>
>>>> On Tue, Oct 7, 2025 at 3:45 PM Ian Rogers <irogers@google.com> wrote:
>>>>>
>>>>> On Tue, Oct 7, 2025 at 2:43 PM Doug Anderson <dianders@chromium.org> wrote:
>>>>> ...
>>>>>> The buddy watchdog was pretty much following the conventions that were
>>>>>> already in the code: that the hardlockup detector (whether backed by
>>>>>> perf or not) was essentially called the "nmi watchdog". There were a
>>>>>> number of people that were involved in reviews and I don't believe
>>>>>> suggesting creating a whole different mechanism for enabling /
>>>>>> disabling the buddy watchdog was never suggested.
>>>>>
>>>>> I suspect they lacked the context that 1 in the nmi_watchdog is taken
>>>>> to mean there's a perf event in use by the kernel with implications on
>>>>> how group events behave. This behavior has been user
>>>>> visible/advertised for 9 years. I don't doubt that there were good
>>>>> intentions by PowerPC's watchdog and in the buddy watchdog patches in
>>>>> using the file, that use will lead to spurious warnings and behaviors
>>>>> by perf.
>>>>>
>>>>> My points remain:
>>>>> 1) using multiple files regresses perf's performance;
>>>>> 2) the file name by its meaning is wrong;
>>>>> 3) old perf tools on new kernels won't behave as expected wrt warnings
>>>>> and metrics because the meaning of the file has changed.
>>>>> Using a separate file for each watchdog resolves this. It seems that
>>>>> there wasn't enough critical mass for getting this right to have
>>>>> mattered before, but that doesn't mean we shouldn't get it right now.
>>>>
>>>> Presumably your next steps then are to find someone to submit a patch
>>>> and try to convince others on the list that this is a good idea. The
>>>> issue with perf has been known for a while now and I haven't seen any
>>>> patches. As I've said, I won't stand in the way if everyone else
>>>> agrees, but given that I'm still not convinced I'm not going to author
>>>> any patches for this myself.
>>>
>>> Writing >1 of:
>>> ```
>>> static struct ctl_table watchdog_hardlockup_sysctl[] = {
>>> {
>>> .procname       = "nmi_watchdog",
>>> .data = &watchdog_hardlockup_user_enabled,
>>> .maxlen = sizeof(int),
>>> .mode = 0444,
>>> .proc_handler   = proc_nmi_watchdog,
>>> .extra1 = SYSCTL_ZERO,
>>> .extra2 = SYSCTL_ONE,
>>> },
>>> };
>>> ```
>>> is an exercise of copy-and-paste, if you need me to do the copy and
>>> pasting then it is okay.
>> Can we get whether a perf event is already in use directly from the
>> perf subsystem? There may be (or will be) other kernel users of
>> perf_event besides the NMI watchdog. Exposing that state from the perf
>> side would avoid coupling unrelated users through nmi_watchdog and
>> similar features.
> 
> For regular processes there is this unmerged proposal:
> https://lore.kernel.org/lkml/20250603181634.1362626-1-ctshao@google.com/
> it doesn't say whether the counter is pinned - the NMI watchdog's
> counter is pinned to be a higher priority that flexible regular
> counters that may be multiplexed. I don't believe there is anything to
> say whether the kernel has taken a performance counter. In general
> something else taking a performance counter is okay as  the kernel
> will multiplex the counter or groups of counters.
> 
> The particular issue for the NMI watchdog counter is that groups of
> events are tested to see if they fit on a PMU, the perf event open
> will fail when a group isn't possible and then the events will be
> reprogrammed by the perf tool without a group. When the group is
> tested the PMU has always assumed that all counters are available,
> which of course with the NMI watchdog they are not. This results with
> the NMI watchdog causing a group of events to be created that can
> never be scheduled.

Addressing the PMU assumption that all counters are available would
resolve the issue. If perf managed reserved or pinned counters
internally, other users would not need to be aware of that detail.

Alternatively, perf could provide an interface to query whether a
counter is pinned. Having the NMI watchdog supply that information
creates coupling between otherwise independent subsystems.

> 
> Thanks,
> Ian
> 
>>>
>>> Thanks,
>>> Ian
>>>
>>>
>>>> -Doug
>>>>
>>
>> --
>> Jinchao



-- 
Jinchao

