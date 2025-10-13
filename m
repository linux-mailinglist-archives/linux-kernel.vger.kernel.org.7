Return-Path: <linux-kernel+bounces-849945-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1FB4BD165F
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 06:53:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6731C3B5357
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 04:53:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6299C2C15AE;
	Mon, 13 Oct 2025 04:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GCeq3V+9"
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1748F283FDB
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 04:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760331195; cv=none; b=pLsV48AiU2f65Q/njmwrm3s5VpEEuOsrLCboIJ8ZdhKYuHPuJCGdEAt7a5uYOPJuFvxjc/nnjAlswm53zctlzATqHzlPAFLXjG1hIv804SWMqTPZCwknRWWTO+d3ySBB9FaZDVxhQ54YfE84nSKnf71OTwaxDoNK2yFAKy/7hPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760331195; c=relaxed/simple;
	bh=LlRT3jnNihgHBxiPjnIV4ZT7xM8cw99bxiLhTmZEqvM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pgMmXHblA3Wt/gWhY0zsDzIax9KeUvKwOWmCOut8CfVaA0j5G4xOwot6C91cMV/Dke0B++h/yQa8CkfkRl3mibl8UlqzfmOIvC0N7TNZqSHCeNIygA3AVliirdwFXOGsgu+/pWXMPbniE828vJbxKpDgEm8BJmWA7gI9kNlNKIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GCeq3V+9; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-791c287c10dso3249557b3a.1
        for <linux-kernel@vger.kernel.org>; Sun, 12 Oct 2025 21:53:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760331193; x=1760935993; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Iig8zULaBGKefHgRiefx6wvNXp12HvxlE0VsdKCFlN8=;
        b=GCeq3V+97CHgviVnM7B1MMV3F0QSdwZTaGuzsZBqU/mnrIoH5vjkLOiH0IbSEWJBaP
         aN44fqVqadqhkshP/b9/jupwM99pob+CBGxftOFaHixyllhMcC2bFoTl41DmF7ZVV0r8
         CHDa1f+3ljRxFODa1B2NQEhiKWqbmLs9cEem+6mdU/xFcI9uCSBI3BXoixvhfDT1NZ5v
         6i/cDFcDXYS8vG/uYfNZL8VPiYDd4fKmZShRDZ2Im/F1rLiduUQqP29bEhDy9bj4m+vb
         X6sK9my6MtCNgdaZccOYgHvoZYNqLNYzXuUf2ScVGY+CDxQOWz3leijy/SB1LkyJhcKd
         eOCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760331193; x=1760935993;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Iig8zULaBGKefHgRiefx6wvNXp12HvxlE0VsdKCFlN8=;
        b=JT7FA3DzmF7cpgfE3BaUFgmqtJqH+tdhGtgQLBrOte6TXSB5CBrQeS8Jm0xvX6K/TX
         emc6t2aLQTb5fwJLIO/X6vMJ2cPI57F/TR5EizizkrbMwpukT0NwgemzkZaP5NsUzuvV
         5KBi1oupxNVFn4JIOQYDAy3EfaNcNaUE3f/FytK1gEZukczk8+sr9igfspD/jD+rAH0/
         5C6Hz+bcJy1Xnwie+MXpbofU0q3SvZZyRg4xLZWoKQOhAOEgZwu+KmmhIdWbMAzry9rI
         eaucar768QNBmx/CWD3wl2JwxvjFg/7CCW31XstHds0GjmoJyAQa37jkpUbqtz4d7bEJ
         ERbA==
X-Forwarded-Encrypted: i=1; AJvYcCW2YyH9IG9bwnW6lz3S3MBNUcdnYp93uAT1dkJPUQM+I+mntqXsbqfeK6hesEZ7XBvKwXZ+rZOmhS0/pGo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPh0lTjxmDWU4NIp0nxThHKV/nHW0wZ9emqzo9uNSKmJsNSwK8
	7rA/dRsr8S2d81CE5kHeVUysWlitTuvlkDfkZ/XVt9pE3D04NHf3ZgR4
X-Gm-Gg: ASbGncs1ReahqfPbsJ15Q2MpdCmPV1Q4+TakGG9iGJC85csd8G0IZU59sdzh6uvE19P
	4kZG1AL/lnhOYUqW+xixbi40fRaOF51kheCB5ssA7IocOIZMhrpoSdnXgkbgg6ybfnZ+R9qIJTA
	W4VVUnQzql9CKVS9YbSmUZGnitNNakc5SqAX6vfF2QULRiwJAHQogRfdHQVCMMJg8wBH/N+oowO
	UzbIS/ms6zRzfLR0HWQ8sU5DvBDoMMPBb3a1mJPbR7WxWcoi+ZLtexHOy4v+X98RRtqohZgtP9n
	HVx5P1T7yURNKgGqRS6hcqwFFkXlMHlAtujO4bw/zNQ4F8bKevEYse3GPDW1QHSiUhDBpOy+Qy1
	A8E/c7KVxXha1DJjI4Sdkpy7wzIBPOFTUgWbJNla3wDL2yONQnC9gZw==
X-Google-Smtp-Source: AGHT+IGZGhr12bO6wfTXu09l388BDAP4wiQF6RXjurZEfsavHD+7xXZuNclsan1m8EDtpJl6OhwQpw==
X-Received: by 2002:a05:6a20:3d94:b0:2e8:6bf6:7d6c with SMTP id adf61e73a8af0-32da80bb8eamr24789027637.2.1760331193278;
        Sun, 12 Oct 2025 21:53:13 -0700 (PDT)
Received: from [192.168.0.13] ([172.92.174.155])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33b7411fcf0sm4651902a91.4.2025.10.12.21.53.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 12 Oct 2025 21:53:12 -0700 (PDT)
Message-ID: <69205060-6a47-4140-8026-6e5a50ad1512@gmail.com>
Date: Sun, 12 Oct 2025 21:52:04 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/11] rvtrace: Add functions to start/stop tracing on a
 component path
To: Anup Patel <apatel@ventanamicro.com>, Bo Gan <ganboing@gmail.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Paul Walmsley
 <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Greg KH <gregkh@linuxfoundation.org>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Ian Rogers <irogers@google.com>, Alexandre Ghiti <alex@ghiti.fr>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 Liang Kan <kan.liang@linux.intel.com>, Mayuresh Chitale
 <mchitale@gmail.com>, Anup Patel <anup@brainfault.org>,
 Atish Patra <atish.patra@linux.dev>, Andrew Jones <ajones@ventanamicro.com>,
 Sunil V L <sunilvl@ventanamicro.com>, linux-riscv@lists.infradead.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Mayuresh Chitale <mchitale@ventanamicro.com>
References: <20251002060732.100213-1-apatel@ventanamicro.com>
 <20251002060732.100213-5-apatel@ventanamicro.com>
 <20edc3a9-2efe-4431-b198-f00b3940777c@gmail.com>
 <CAK9=C2U+H5xZaK6g5qcytESyC9H8gkU_jEUDJanEs1qzcGgYCQ@mail.gmail.com>
Content-Language: en-US
From: Bo Gan <ganboing@gmail.com>
In-Reply-To: <CAK9=C2U+H5xZaK6g5qcytESyC9H8gkU_jEUDJanEs1qzcGgYCQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10/12/25 20:43, Anup Patel wrote:
> On Wed, Oct 8, 2025 at 2:45 PM Bo Gan <ganboing@gmail.com> wrote:
>>
>> On 10/1/25 23:07, Anup Patel wrote:
>>> From: Mayuresh Chitale <mchitale@ventanamicro.com>
>>>
>>> The perf driver framework needs to be able to start / stop all components
>>> in a trace component path during its operation. Add rvtrace_path_start()
>>> and rvtrace_path_stop() functions for this purpose.
>>>
>>> Co-developed-by: Anup Patel <apatel@ventanamicro.com>
>>> Signed-off-by: Anup Patel <apatel@ventanamicro.com>
>>> Signed-off-by: Mayuresh Chitale <mchitale@ventanamicro.com>
>>> ---
>>>    drivers/hwtracing/rvtrace/rvtrace-core.c | 44 ++++++++++++++++++++++++
>>>    include/linux/rvtrace.h                  |  6 ++++
>>>    2 files changed, 50 insertions(+)
>>>
>>> diff --git a/drivers/hwtracing/rvtrace/rvtrace-core.c b/drivers/hwtracing/rvtrace/rvtrace-core.c
>>> index 7013d50ca569..109be40d4b24 100644
>>> --- a/drivers/hwtracing/rvtrace/rvtrace-core.c
>>> +++ b/drivers/hwtracing/rvtrace/rvtrace-core.c
>>> @@ -614,6 +614,50 @@ static void rvtrace_release_path_nodes(struct rvtrace_path *path)
>>>        }
>>>    }
>>>
>>> +int rvtrace_path_start(struct rvtrace_path *path)
>>> +{
>>> +     const struct rvtrace_driver *rtdrv;
>>> +     struct rvtrace_component *comp;
>>> +     struct rvtrace_path_node *node;
>>> +     int ret;
>>> +
>>> +     list_for_each_entry(node, &path->comp_list, head) {
>>> +             comp = node->comp;
>>> +             rtdrv = to_rvtrace_driver(comp->dev.driver);
>>> +             if (!rtdrv->start)
>>> +                     continue;
>>> +
>>> +             ret = rtdrv->start(comp);
>>> +             if (ret)
>>> +                     return ret;
>>> +     }
>>> +
>>> +     return 0;
>>> +}
>>> +EXPORT_SYMBOL_GPL(rvtrace_path_start);
>>> +
>>> +int rvtrace_path_stop(struct rvtrace_path *path)
>>> +{
>>> +     const struct rvtrace_driver *rtdrv;
>>> +     struct rvtrace_component *comp;
>>> +     struct rvtrace_path_node *node;
>>> +     int ret;
>>> +
>>> +     list_for_each_entry(node, &path->comp_list, head) {
>>> +             comp = node->comp;
>>> +             rtdrv = to_rvtrace_driver(comp->dev.driver);
>>> +             if (!rtdrv->stop)
>>> +                     continue;
>>> +
>>> +             ret = rtdrv->stop(comp);
>>> +             if (ret)
>>> +                     return ret;
>>> +     }
>>> +
>>> +     return 0;
>>> +}
>>> +EXPORT_SYMBOL_GPL(rvtrace_path_stop);
>>> +
>>>    struct rvtrace_path *rvtrace_create_path(struct rvtrace_component *source,
>>>                                         struct rvtrace_component *sink,
>>>                                         enum rvtrace_component_mode mode)
>>> diff --git a/include/linux/rvtrace.h b/include/linux/rvtrace.h
>>> index f2174f463a69..e7bd335d388f 100644
>>> --- a/include/linux/rvtrace.h
>>> +++ b/include/linux/rvtrace.h
>>> @@ -273,10 +273,14 @@ struct rvtrace_path *rvtrace_create_path(struct rvtrace_component *source,
>>>                                         struct rvtrace_component *sink,
>>>                                         enum rvtrace_component_mode mode);
>>>    void rvtrace_destroy_path(struct rvtrace_path *path);
>>> +int rvtrace_path_start(struct rvtrace_path *path);
>>> +int rvtrace_path_stop(struct rvtrace_path *path);
>>>
>>>    /**
>>>     * struct rvtrace_driver - Representation of a RISC-V trace driver
>>>     * id_table: Table to match components handled by the driver
>>> + * start:        Callback to start tracing
>>> + * stop:         Callback to stop tracing
>>>     * probe:        Driver probe() function
>>>     * remove:       Driver remove() function
>>>     * get_trace_id: Get/allocate a trace ID
>>> @@ -285,6 +289,8 @@ void rvtrace_destroy_path(struct rvtrace_path *path);
>>>     */
>>>    struct rvtrace_driver {
>>>        const struct rvtrace_component_id *id_table;
>>> +     int                     (*start)(struct rvtrace_component *comp);
>>> +     int                     (*stop)(struct rvtrace_component *comp);
>>>        int                     (*probe)(struct rvtrace_component *comp);
>>>        void                    (*remove)(struct rvtrace_component *comp);
>>>        int                     (*get_trace_id)(struct rvtrace_component *comp,
>>
>> I'd suggest add another function (*quiesce) or something like that. Trace
>> components have a tr??Empty bit that indicates trace has been all flushed
>> out. Also along the path when you do rvtrace_path_stop, you need to ensure
>> the source has stopped and quiescent before beginning to stop the sink.
>> Otherwise you'll get partial or corrupted trace. In essence, follow Control
>> Interface Spec 11.3 Enabling and Disabling. FYI: my userspace driver:
>> https://github.com/ganboing/riscv-trace-umd/blob/master/rvtrace/funnel.py#L223
> 
> It's better to add functions on a need basis rather than adding
> it now without any potential user.
> 
> Regards,
> Anu

Hi Anup, my previous comment also applies to your current use case where you
have encoder->RAM sink directly connected together. Having a longer path,
e.g., funnels in between makes it worse. The driver needs to poll the empty
bit tr??Empty (bit 3) of the control register to check if trace has been
completely flushed. Otherwise, you get a partial trace, possibly with last
few messages missing or truncated. So, yes, there's really a need to do so.

Bo

