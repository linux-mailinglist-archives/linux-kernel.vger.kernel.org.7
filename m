Return-Path: <linux-kernel+bounces-818938-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C94FB5984F
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 15:56:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F9573B86EE
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 13:55:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E8A4327A2C;
	Tue, 16 Sep 2025 13:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="afdB9Bm7"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20D01327A0C
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 13:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758030878; cv=none; b=Rz8NjhOIZ5KGN+PUWMJVZx+98/EOLur5oGSXwys97Uyve1cRDmsi/ZmQU8PzO5Wi2xpEc/jXUn14tUKXD2i1kpfjx1TQuAhh3RG3RsiAg3HSkxFfJ7YnyLkUuXBht4XJ2M71mEXZgNeXt1nD3H4/NX2V5ueapygciI37ijKW2QE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758030878; c=relaxed/simple;
	bh=fWCmqFEd7OPomJ7rITpLZOiL9NrthwW4j7FV0SpV4dg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=M9B4q4cJA0/EegG6yEMiYRCrCo4Hhvj2vYsXWHmJ3YArvIU7Mvlz0ERxTmbc5x6UOUk3umtwAx90Zb8eySv9oKfNmLCWcOjkORFL2xjFE0MQ+tVjl0G4yvG4xJ5Tguzf26UthhXLDvFfBw9anCL9naR0W65QNvrl4Fe+5p74Pww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=afdB9Bm7; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-251fc032d1fso61401985ad.3
        for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 06:54:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1758030874; x=1758635674; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jPYXwMaf9XORYOvpeTSKlqB+qoDKbzWhfT7TOlo6D2A=;
        b=afdB9Bm7jKy5O6+azF1RiOazm16U5ynIe3dQJzTaQfX4Lnde+hcS4WB7faECbiUeGQ
         B7lqHCtLIDzHtJMAz9T7YahmMahaMjOUroZ6b9hhIxSpvoNqq+j2pt1+SWBYJ0+AoYG5
         3AaK0Iol3dtGEF+huX5fpcM+7PNXpAaVgQk0luImXRVQY8xv+n19VSxzWQcU7G9EgKKW
         1joVljnphi+MYO8t8HHn9dxu7PA77oe6Xl4/w9A/5VFFRePYIzQqOTCsdf1Lhrt1eI0a
         Af3Qo4RY2ApBSmBneVIF8fdkwLGn9q8dGwHax3fbOYBhNkieZsOgYW6QfZ+jb+rSFdqW
         hJXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758030874; x=1758635674;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jPYXwMaf9XORYOvpeTSKlqB+qoDKbzWhfT7TOlo6D2A=;
        b=B3FWrvlBKeru3a5picitdm7k6PyE7cum0DftpwxtRZVHyVtsz8PhK8ta2A4ovOlNkw
         7uZUzk+Tmznnr7ck80pekSfwvF+GIzCfbmmVdZQpGc2Nw1NgflcLar54RVcKafneRfrD
         tJOL01zlfuBarP25quuFNUR2bPpjoIEQlHA7lthLgPXF14zq5RLY+KfNA7zWpVNdkohW
         YFJ64y0T9bLEy5V0uevw7mclFRw5aG9ELjFZ/06ypruY3iXRUwNCNjz1bA8LgTSr29N3
         l44h0QL84B6ibbWGRJCzWr/kWti3h2iStwf2hDAsX69w5876Ch5GQaIxmyy1FnFg7N5M
         7z6w==
X-Forwarded-Encrypted: i=1; AJvYcCUTvOqPleWVm+rWn1e3l610E3+NVtrToazx6Tx4uM+hC35U0BJUFIr4uwKFUDdWZXtDqHiknx1D2XC6JgY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4V8lXYlhcO2Ry35WW7ffW1UkfpIIY2aDsDrAxV0nggEQYIiPb
	jj/8Nb3EdcRr7t4OqpDMPeSNHWOPuletaaiaxmFoV9C0bb/ihExjoN+bliF6SLg8lJA=
X-Gm-Gg: ASbGncsMoiEs+cGAMGq3ZTSXNcFjMzVqur91EgDK2H10XgZBmk4FY0PkBMBFn+Qbb3W
	K3u/aR0VCCQDh6IyM2SAKLCxcc7yyY0WViCPBR1RpaoHnBhGsjnr0jnlBc/H19Wncpj+/GcdtIK
	NUEVN2iEtp5+iYYh5SFTmW2mvNQNSVeoQ5twFBQ989P/WFS+b57m3EdrDjsWWhPYoJskdQEwKgh
	pXuGL36q4j1V2LCg01VzcfZ4Cgyr8svvETU4b4reWsivM22gDwBDpq6HBd5rsOqNmJwdcwY5Voq
	DqAfbdn+hkDuPIYt8LGWRJtogdpg0fWI7tDruvzwgh+XPHyj6z/Jzge1aDNbSthixy0iVLw3+0f
	L2i824iSGGywqUOofFs6jS0vacjiN4ar8AJIaxKCmWO8bqeRzs/JMvLIdUpIbq2j0gus7JxeWwf
	7LHyiwTw==
X-Google-Smtp-Source: AGHT+IG8lasNhNhAYlDmGUXLI8t/qpiw2FP6ff9Jqqn0r2lmG1QOH7Icm2zQ9M4bySvDLCeAO1oeKQ==
X-Received: by 2002:a17:903:f85:b0:260:5bab:8cad with SMTP id d9443c01a7336-2605babb245mr163297405ad.29.1758030874302;
        Tue, 16 Sep 2025 06:54:34 -0700 (PDT)
Received: from [10.88.213.9] ([61.213.176.57])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2677a5cf655sm52556865ad.4.2025.09.16.06.54.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Sep 2025 06:54:33 -0700 (PDT)
Message-ID: <18e7bf9b-eb4c-4c4c-a00e-bfe0bc07e81c@bytedance.com>
Date: Tue, 16 Sep 2025 21:54:19 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Re: [PATCH] vduse: Use fixed 4KB bounce pages for arm64 64KB page
 size
To: Jason Wang <jasowang@redhat.com>
Cc: mst@redhat.com, xuanzhuo@linux.alibaba.com, eperezma@redhat.com,
 virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
 xieyongji@bytedance.com
References: <20250915073429.54027-1-sheng.zhao@bytedance.com>
 <CACGkMEvWNOjFU0pgiS=LF2B+yEC-y_RU3w_P5_dr10RPH+5xrg@mail.gmail.com>
 <328b3f8f-cca7-4d8f-9335-24341b40b2d5@bytedance.com>
 <CACGkMEvXH+VpA-2sJ39QL4Rb3Gg0VCOKn5BApRpft=583Qcp2g@mail.gmail.com>
Content-Language: en-US
From: Sheng Zhao <sheng.zhao@bytedance.com>
In-Reply-To: <CACGkMEvXH+VpA-2sJ39QL4Rb3Gg0VCOKn5BApRpft=583Qcp2g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/9/16 15:34, Jason Wang 写道:
> On Mon, Sep 15, 2025 at 7:07 PM Sheng Zhao <sheng.zhao@bytedance.com> wrote:
>>
>>
>>
>> 在 2025/9/15 16:21, Jason Wang 写道:
>>> On Mon, Sep 15, 2025 at 3:34 PM <sheng.zhao@bytedance.com> wrote:
>>>>
>>>> From: Sheng Zhao <sheng.zhao@bytedance.com>
>>>>
>>>> The allocation granularity of bounce pages is PAGE_SIZE. This may cause
>>>> even small IO requests to occupy an entire bounce page exclusively.
>>>
>>> This sounds more like an issue of the IOVA allocating that use the
>>> wrong granular?
>>>
>>
>> Sorry, the previous email has a slight formatting issue.
>>
>> The granularity of the IOVA allocator is customized during the
>> initialization of the vduse domain, and this value is also modified in
>> this commit.
> 
> Ok, let's add this to the changelog.
> 
> Btw, do you have perf numbers to demonstrate the benefit?
> 
> Thanks
> 

For arm64 64KB base pages, compared with fixed 4KB bounce pages, using 
native pages is more likely to fill up the bounce buffer(default 64MB), 
resulting in I/O performance bottlenecks.

I used QEMU vduse-blk as the backend for testing write performance. 
Below are the fio test results:


	  | native       | fixed-4k
----------+--------------+-------------
numjobs=2 | bw=44.4MiB/s | bw=47.0MiB/s
iodepth=4 | iops=90.9k   | iops=96.1k
----------+--------------+-------------
numjobs=4 | bw=58.8MiB/s | bw=61.1MiB/s
iodepth=4 | iops=120.3k  | iops=125.4k
----------+--------------+-------------
numjobs=8 | bw=64.0MiB/s | bw=74.7MiB/s
iodepth=8 | iops=131.1k  | iops=153.1k
----------+--------------+-------------
numjobs=16| bw=69.8MiB/s | bw=92.7MiB/s
iodepth=8 | iops=143.0k  | iops=190.0k


Thanks

>>
>> Thanks
>>
>>>> The
>>>> kind of memory waste will be more significant on arm64 with 64KB pages.
>>>>
>>>> So, optimize it by using fixed 4KB bounce pages.
>>>>
>>>> Signed-off-by: Sheng Zhao <sheng.zhao@bytedance.com>
>>>
>>> Thanks
>>>
>>
> 


