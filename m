Return-Path: <linux-kernel+bounces-829473-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 440B7B9727B
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 20:03:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E1D443A9314
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 18:03:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 902992F7477;
	Tue, 23 Sep 2025 18:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TJ/H37Rw"
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E222275AE2
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 18:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758650572; cv=none; b=N/S8aNpamExbRSkNFqyvHUQrttuKBysigOTx5bc3ghlXOrETAMNOnwuJQR7NDb+PX8cZlEuOHVNB8eHJ2xt58JilZCfINcXvOHxVxau/wCoXkIr3Kee1idpqFFVsF0OHhxTQkFC0QDlYbjK7U7rnByn+q2nzGpqRSbDGQqYRZps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758650572; c=relaxed/simple;
	bh=cwxWA5SjpJsmIGAEtf/ZI6lsWcCkGm6hw9JIin8TAEM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uN3bORQ+4b+faX1aLjptC0kYwMEzivgv6Q68Fhes9N0OE2quVhWZt34r4+NR2pJd/vGxnxR2GMTuA0AEIAkqcmbpOWV8w7b7GSLBOTgmVweRE+N+L1rMvDVDzgSVp+JwmNI90NXUfSbIJLtLFFEKklTNxER8WNylXgfdJjQGgXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TJ/H37Rw; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-77f169d8153so3528582b3a.3
        for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 11:02:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758650571; x=1759255371; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=i+tqvwE+E0cZ1fEaxr5t2bL8HNbMuR4y65gYrn4JYKo=;
        b=TJ/H37Rwjis6xDKTLdb06zEkg2wcvcRHJoq3/PEC1N98x+GsmG5N0K4KXFy1UTodCF
         mbVBafJ2DKGW+2aU7RCJirQeAEAuMqsOSIMPQQCt8/zV+eCSKSWh+QF4FvufuWwfvYkE
         7BD5f5WhGFylaQSDf26RHT2XkBs0MdNJNE5EOoVC3iAyHlvsMAWMhrbKCpRfo4nR2u8w
         JF210h4L8E+4ualBxHS9RadE3Lhi4XE6s8cQ7S8SsVSpxKPUEZ1aSjGJRZRYMqiR5tyF
         5kcr7cmyI8LyDCFKvLUbdkCFl4EVV/rwvcS9HQAVR/2CofrZvaEE16wBgD3Wi/v+sTVJ
         Tqhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758650571; x=1759255371;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=i+tqvwE+E0cZ1fEaxr5t2bL8HNbMuR4y65gYrn4JYKo=;
        b=m2bbTpjAXuE+fxN96/2tGXMTGnDx4F2+mnH5dqgV7nUyGsovxYhAKbSnH8b8rs73+g
         ZFxfIS8ol217KkLfbcHh/ZkoF0T57J6Ihdc24acZTXoue+6rMtS3sw0jyZuLvZeUYi28
         WXDPigp1UPuWCPj9CZfh0a3snWpdI4LHgNYkdRfbR2dRP7wTGW7hjBcBNHsfmBsHT2yR
         /NGcyvURemNI/ZB8KfOrpcfJTDXxQQY4gcBjs0/bo/C07rXM1ZpJDqUU6hko19zn5n4G
         RzMc62U0fcXxehn3qpzTTuYNe/csVLf+Gi+ByZbS9BBWgjZ4ySHBzRPNJIa90Zy3Orsi
         sI9g==
X-Forwarded-Encrypted: i=1; AJvYcCVGKfdDSAy2/7NWtYtYbzvNa6cUy722aSqiERtS1vnAej8lIw8u+NChBEGYSYvQ1akWg1TKKcIun3H5PGA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDIV/Gy1ua6C/AVzgTJZ35SFO0jh14lTZFS0lJpOy9rY013Yme
	Ik2M0JID/dozfRxjyoH5cysL0/QY00Csdnw2gRnX/bTs3jIK9krP9d+y
X-Gm-Gg: ASbGncsmW7zXg/ZUtcEUmw6tLbdCVJ2LW4Ra7hHO8OHK1u/uC6TXOv/XtEopVp4j4SP
	EYzq7xJ8BbEvPtR+vmMeEEmmGvrZA4mToxcEh5tfQ+ug4hgeItxLv8yqYMXDbNIjbkeYjg/ru2U
	5BzsQ6FYuP64Nl8HbE5XBPSHCVfzY03fhrbGYHNdjks1VIpMWXx0CIOLDXBJrSNPzvrg5S2svFy
	yP/bf7TgFdyzlSkHyH63yNLfN7Ypz7GzwzRUNxVVoNQOZCv3r3zUb4P6QAojvFRNI22a40ApOkR
	FjKrGXffwuMIIrE15AnKmCS6cvhsab1vsPS+LwbRTKZgHY+6Y25LkNM8m8p7WjjUfsbaxNnIWO8
	8eB8mYf9kU1gTKYqxZOPhzm5huhRFH6rB
X-Google-Smtp-Source: AGHT+IFUlOckCHI+KwnlDW4tzUdg15UTb2EGkiOLw73qogkO+0zulqJJ9EPdzpVIEp7UN6ZvkshONw==
X-Received: by 2002:a17:903:37d0:b0:25f:9682:74ae with SMTP id d9443c01a7336-27cc5a09d62mr39648005ad.29.1758650570586;
        Tue, 23 Sep 2025 11:02:50 -0700 (PDT)
Received: from [192.168.4.196] ([73.222.117.172])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-269800541adsm168967475ad.4.2025.09.23.11.02.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Sep 2025 11:02:49 -0700 (PDT)
Message-ID: <01fdd968-8b82-4777-88c3-e1dc0c81e9bc@gmail.com>
Date: Tue, 23 Sep 2025 11:02:48 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] memcg: introduce kfuncs for fetching memcg stats
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: mkoutny@suse.com, yosryahmed@google.com, hannes@cmpxchg.org,
 tj@kernel.org, akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
 cgroups@vger.kernel.org, kernel-team@meta.com, linux-mm@kvack.org,
 bpf@vger.kernel.org
References: <20250920015526.246554-1-inwardvessel@gmail.com>
 <ky2yjg6qrqf6hqych7v3usphpcgpcemsmfrb5ephc7bdzxo57b@6cxnzxap3bsc>
Content-Language: en-US
From: JP Kobryn <inwardvessel@gmail.com>
In-Reply-To: <ky2yjg6qrqf6hqych7v3usphpcgpcemsmfrb5ephc7bdzxo57b@6cxnzxap3bsc>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/19/25 10:17 PM, Shakeel Butt wrote:
> +linux-mm, bpf
> 
> Hi JP,
> 
> On Fri, Sep 19, 2025 at 06:55:26PM -0700, JP Kobryn wrote:
>> The kernel has to perform a significant amount of the work when a user mode
>> program reads the memory.stat file of a cgroup. Aside from flushing stats,
>> there is overhead in the string formatting that is done for each stat. Some
>> perf data is shown below from a program that reads memory.stat 1M times:
>>
>> 26.75%  a.out [kernel.kallsyms] [k] vsnprintf
>> 19.88%  a.out [kernel.kallsyms] [k] format_decode
>> 12.11%  a.out [kernel.kallsyms] [k] number
>> 11.72%  a.out [kernel.kallsyms] [k] string
>>   8.46%  a.out [kernel.kallsyms] [k] strlen
>>   4.22%  a.out [kernel.kallsyms] [k] seq_buf_printf
>>   2.79%  a.out [kernel.kallsyms] [k] memory_stat_format
>>   1.49%  a.out [kernel.kallsyms] [k] put_dec_trunc8
>>   1.45%  a.out [kernel.kallsyms] [k] widen_string
>>   1.01%  a.out [kernel.kallsyms] [k] memcpy_orig
>>
>> As an alternative to reading memory.stat, introduce new kfuncs to allow
>> fetching specific memcg stats from within bpf iter/cgroup-based programs.
>> Reading stats in this manner avoids the overhead of the string formatting
>> shown above.
>>
>> Signed-off-by: JP Kobryn <inwardvessel@gmail.com>
> 
> Thanks for this but I feel like you are drastically under-selling the
> potential of this work. This will not just reduce the cost of reading
> stats but will also provide a lot of flexibility.
> 
> Large infra owners which use cgroup, spent a lot of compute on reading
> stats (I know about Google & Meta) and even small optimizations becomes
> significant at the fleet level.
> 
> Your perf profile is focusing only on kernel but I can see similar
> operation in the userspace (i.e. from string to binary format) would be
> happening in the real world workloads. I imagine with bpf we can
> directly pass binary data to userspace or we can do custom serialization
> (like protobuf or thrift) in the bpf program directly.
> 
> Beside string formatting, I think you should have seen open()/close() as
> well in your perf profile. In your microbenchmark, did you read
> memory.stat 1M times with the same fd and use lseek(0) between the reads
> or did you open(), read() & close(). If you had done later one, then
> open/close would be visible in the perf data as well. I know Google
> implemented fd caching in their userspacecontainer library to reduce
> their open/close cost. I imagine with this approach, we can avoid this
> cost as well.

In the test program, I opened once and used lseek() at the end of each
iteration. It's a good point though about user programs typically
opening and closing. I'll adjust the test program to resemble that
action.

> 
> In terms of flexibility, I can see userspace can get the stats which it
> needs rather than getting all the stats. In addition, userspace can
> avoid flushing stats based on the fact that system is flushing the stats
> every 2 seconds.

That's true. The kfunc for flushing is made available but not required.

> 
> In your next version, please also include the sample bpf which uses
> these kfuncs and also include the performance comparison between this
> approach and the traditional reading memory.stat approach.

Thanks for the good input. Will do.


