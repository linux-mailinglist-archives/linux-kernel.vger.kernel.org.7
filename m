Return-Path: <linux-kernel+bounces-852165-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46A33BD855A
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 11:01:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7599E3A451E
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 09:00:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31A7C2E5B11;
	Tue, 14 Oct 2025 09:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IV3aNhOp"
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF28A2E2DCD
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 09:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760432428; cv=none; b=vAOm0c7TWBgJ+UgSVmZqpwZ+wFHpPIwyk1r82wELaGeQm+JgM/4uAMNIagTzMX50SKOrSDC/O6immAon/ZjjJSTC2Pc7BvBxeh90J6Xr3EfqxqB/pIPpXoCB2GYWsH2h+ufKuSjN1nca/pviWdvvzFKrC3Ncx/b2IxnyM6+q81c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760432428; c=relaxed/simple;
	bh=vLLXYSNqwVBysVXGGW/2y78CIHhM+kEKSlCHLMSsiuY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pPziOQutGGoIuisWDehlL7BiKYbprvg1IObcOi7S2UovQdxIx4DWfhBcGSf3MinWNxVvR4EuTe4NKbNegXDJbG4LKwOuqcMJ7wSKfsZcbSygFhKf/Ym6AGSuYuOU2IIETpY7dQoRF6sSIpkadtfppbJ7T38eA+CvUNIK0Y/VKYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IV3aNhOp; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-330b4739538so4805753a91.3
        for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 02:00:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760432426; x=1761037226; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=F1TFiJXfN4H/Xgn0NClhb7Y/ZMUzFLTyPno5YMrNpTY=;
        b=IV3aNhOprq4KTf4s2K+hFbIaOXEg7HQlKwXbuO8m8DDndYLSl0UwwVOBhjNJNewLHG
         dE/JCCRYzvhydhSNFXszrKjekF2b89STe4HX6oK9UDoXV6nLZ7+JptN0lGxpLNm+9oid
         YTo47RICcIilxETfKbsN124UscNwrZTiwvsPcW1rfSieebeRUyCaMxlLYzPL3gpfmTND
         O/8B1SqzcJIrx75QjWDK5tVTFh7Vd38tTdrOlY7DRBv6byAL9flwggAopshpeEE4vSI7
         xOWWaTK3a7frKDuMjKiExm+qRhUQUdpGVCpCtVblXlEuAua7nhE6rubJwWyV1l7l7kWz
         Pr/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760432426; x=1761037226;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=F1TFiJXfN4H/Xgn0NClhb7Y/ZMUzFLTyPno5YMrNpTY=;
        b=MFZME6LAF1/FpJxCcHVAxNgtZGozpngv4ebYKXeGTImREvJQfyajrl+MTGHW3ikc8Z
         xX6YdVxw635HMDRdcoTcGM4C7LpihLzsimz9b75T8LLFAV12q4nITObzdpVP8iXjSO0/
         qCknDev63CaizS2/F8AL/8y5Vcv59dSpJfhGe5wYvnGNZXN1+oeWuD1ieWuewSiW0b5I
         HJzdnuk/ZQ64Qj/Wd1//0cLSNMH3WxXu1vXVcYql45K/H97yD14hKLMMQ16mC8MCsMen
         vNrPv7fYyZlwW9vmGBEdNyGu8m+iqJknnazb9yDUfSLenLzI8Y46+3Qlya+ILbPgnfhe
         EQRw==
X-Forwarded-Encrypted: i=1; AJvYcCUAr2KIrFj5Ci1tVVAiqf+pdncysgn2JBb4imA9SOqIvp796UWhNU7gyQItPEbs4ZuP4NRq2EsmTbNxpG8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxmbavelnHv6h+8imWU0DnYlcXwzEMusOGSdfFFMRzZ1rV2VBdi
	NoTDsgWerW82FJvwolhbyw9NPAWppR78BeugBEfAeWWhg3KJn9+0k+jg
X-Gm-Gg: ASbGncvJKr5cLhA2vK2fnBY+BmtjHnnlCEyOzVdiJICDv/cmAF5k8Y++LlpbCTIr7wt
	Y4IZTs8WboCMqown5B4OZ5SPEvyLA31nxxPtkhtqdHFfV1z/w6ZpQNrDo8+OhCkJ5i+RQgL52bR
	GcKU7AeBHrst/wygeSDA3kqt49AittBJnpeWhm044gHTNwyg7HUgCLNZSAfknsXEGMp/IlMegnW
	lPBjaJmj0TbDe1kxMK4RKVWy0V/7V300hleIdGhpqaSQSId3bboKcY2dUV8IVuDVl+QWJLPK7G0
	LTSuOQ0djv1D5iScIvjIlcDf3+Qan0bKBsL510NtIQWXt1NXAIDhqEkjZyIYWsYxwqZCVSXoIEY
	LktLgk7/JupsNFFtuoN3ZowovPTXHCUqZQYUTggSzpF8=
X-Google-Smtp-Source: AGHT+IE0mIgWQWJZSxQ3gwmU/tn8/Wu8JthlrumZUzn60cmTN+GhgkxNyMqIgZ/XievZAUQnR5iVrw==
X-Received: by 2002:a17:90b:1b43:b0:32e:18f2:7a59 with SMTP id 98e67ed59e1d1-33b5116251cmr36222338a91.11.1760432425506;
        Tue, 14 Oct 2025 02:00:25 -0700 (PDT)
Received: from [192.168.0.13] ([172.92.174.155])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33b61aab6eesm15311175a91.15.2025.10.14.02.00.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Oct 2025 02:00:24 -0700 (PDT)
Message-ID: <a6e787e3-f332-4445-9f7a-b2ec65daf019@gmail.com>
Date: Tue, 14 Oct 2025 01:59:22 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/11] rvtrace: Add functions to start/stop tracing on a
 component path
To: Mayuresh Chitale <mchitale@ventanamicro.com>, Bo Gan <ganboing@gmail.com>
Cc: Anup Patel <apatel@ventanamicro.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Paul Walmsley <paul.walmsley@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Greg KH <gregkh@linuxfoundation.org>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Ian Rogers <irogers@google.com>, Alexandre Ghiti <alex@ghiti.fr>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 Liang Kan <kan.liang@linux.intel.com>, Mayuresh Chitale
 <mchitale@gmail.com>, Anup Patel <anup@brainfault.org>,
 Atish Patra <atish.patra@linux.dev>, Andrew Jones <ajones@ventanamicro.com>,
 Sunil V L <sunilvl@ventanamicro.com>, linux-riscv@lists.infradead.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20251002060732.100213-1-apatel@ventanamicro.com>
 <20251002060732.100213-5-apatel@ventanamicro.com>
 <20edc3a9-2efe-4431-b198-f00b3940777c@gmail.com>
 <CAK9=C2U+H5xZaK6g5qcytESyC9H8gkU_jEUDJanEs1qzcGgYCQ@mail.gmail.com>
 <69205060-6a47-4140-8026-6e5a50ad1512@gmail.com>
 <CAN37VV4jFyuEYw0cxU00FucgV=so5SfTon_1hdvbVuqX1QzYCQ@mail.gmail.com>
Content-Language: en-US
From: Bo Gan <ganboing@gmail.com>
In-Reply-To: <CAN37VV4jFyuEYw0cxU00FucgV=so5SfTon_1hdvbVuqX1QzYCQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Mayuresh,

On 10/14/25 01:10, Mayuresh Chitale wrote:
> Hi Bo,
> 
> On Mon, Oct 13, 2025 at 10:23 AM Bo Gan <ganboing@gmail.com> wrote:
>>
>> On 10/12/25 20:43, Anup Patel wrote:
>>> On Wed, Oct 8, 2025 at 2:45 PM Bo Gan <ganboing@gmail.com> wrote:
>>>>
>>>> On 10/1/25 23:07, Anup Patel wrote:
>>>>> From: Mayuresh Chitale <mchitale@ventanamicro.com>
>>>>>
>>>>> The perf driver framework needs to be able to start / stop all components
>>>>> in a trace component path during its operation. Add rvtrace_path_start()
>>>>> and rvtrace_path_stop() functions for this purpose.
>>>>>
>>>>> Co-developed-by: Anup Patel <apatel@ventanamicro.com>
>>>>> Signed-off-by: Anup Patel <apatel@ventanamicro.com>
>>>>> Signed-off-by: Mayuresh Chitale <mchitale@ventanamicro.com>
>>>>> ---
>>>>>     drivers/hwtracing/rvtrace/rvtrace-core.c | 44 ++++++++++++++++++++++++
>>>>>     include/linux/rvtrace.h                  |  6 ++++
>>>>>     2 files changed, 50 insertions(+)
>>>>>
>>>>> diff --git a/drivers/hwtracing/rvtrace/rvtrace-core.c b/drivers/hwtracing/rvtrace/rvtrace-core.c
>>>>> index 7013d50ca569..109be40d4b24 100644
>>>>> --- a/drivers/hwtracing/rvtrace/rvtrace-core.c
>>>>> +++ b/drivers/hwtracing/rvtrace/rvtrace-core.c
>>>>> @@ -614,6 +614,50 @@ static void rvtrace_release_path_nodes(struct rvtrace_path *path)
>>>>>         }
>>>>>     }
>>>>>
>>>>> +int rvtrace_path_start(struct rvtrace_path *path)
>>>>> +{
>>>>> +     const struct rvtrace_driver *rtdrv;
>>>>> +     struct rvtrace_component *comp;
>>>>> +     struct rvtrace_path_node *node;
>>>>> +     int ret;
>>>>> +
>>>>> +     list_for_each_entry(node, &path->comp_list, head) {
>>>>> +             comp = node->comp;
>>>>> +             rtdrv = to_rvtrace_driver(comp->dev.driver);
>>>>> +             if (!rtdrv->start)
>>>>> +                     continue;
>>>>> +
>>>>> +             ret = rtdrv->start(comp);
>>>>> +             if (ret)
>>>>> +                     return ret;
>>>>> +     }
>>>>> +
>>>>> +     return 0;
>>>>> +}
>>>>> +EXPORT_SYMBOL_GPL(rvtrace_path_start);
>>>>> +
>>>>> +int rvtrace_path_stop(struct rvtrace_path *path)
>>>>> +{
>>>>> +     const struct rvtrace_driver *rtdrv;
>>>>> +     struct rvtrace_component *comp;
>>>>> +     struct rvtrace_path_node *node;
>>>>> +     int ret;
>>>>> +
>>>>> +     list_for_each_entry(node, &path->comp_list, head) {
>>>>> +             comp = node->comp;
>>>>> +             rtdrv = to_rvtrace_driver(comp->dev.driver);
>>>>> +             if (!rtdrv->stop)
>>>>> +                     continue;
>>>>> +
>>>>> +             ret = rtdrv->stop(comp);
>>>>> +             if (ret)
>>>>> +                     return ret;
>>>>> +     }
>>>>> +
>>>>> +     return 0;
>>>>> +}
>>>>> +EXPORT_SYMBOL_GPL(rvtrace_path_stop);
>>>>> +
>>>>>     struct rvtrace_path *rvtrace_create_path(struct rvtrace_component *source,
>>>>>                                          struct rvtrace_component *sink,
>>>>>                                          enum rvtrace_component_mode mode)
>>>>> diff --git a/include/linux/rvtrace.h b/include/linux/rvtrace.h
>>>>> index f2174f463a69..e7bd335d388f 100644
>>>>> --- a/include/linux/rvtrace.h
>>>>> +++ b/include/linux/rvtrace.h
>>>>> @@ -273,10 +273,14 @@ struct rvtrace_path *rvtrace_create_path(struct rvtrace_component *source,
>>>>>                                          struct rvtrace_component *sink,
>>>>>                                          enum rvtrace_component_mode mode);
>>>>>     void rvtrace_destroy_path(struct rvtrace_path *path);
>>>>> +int rvtrace_path_start(struct rvtrace_path *path);
>>>>> +int rvtrace_path_stop(struct rvtrace_path *path);
>>>>>
>>>>>     /**
>>>>>      * struct rvtrace_driver - Representation of a RISC-V trace driver
>>>>>      * id_table: Table to match components handled by the driver
>>>>> + * start:        Callback to start tracing
>>>>> + * stop:         Callback to stop tracing
>>>>>      * probe:        Driver probe() function
>>>>>      * remove:       Driver remove() function
>>>>>      * get_trace_id: Get/allocate a trace ID
>>>>> @@ -285,6 +289,8 @@ void rvtrace_destroy_path(struct rvtrace_path *path);
>>>>>      */
>>>>>     struct rvtrace_driver {
>>>>>         const struct rvtrace_component_id *id_table;
>>>>> +     int                     (*start)(struct rvtrace_component *comp);
>>>>> +     int                     (*stop)(struct rvtrace_component *comp);
>>>>>         int                     (*probe)(struct rvtrace_component *comp);
>>>>>         void                    (*remove)(struct rvtrace_component *comp);
>>>>>         int                     (*get_trace_id)(struct rvtrace_component *comp,
>>>>
>>>> I'd suggest add another function (*quiesce) or something like that. Trace
>>>> components have a tr??Empty bit that indicates trace has been all flushed
>>>> out. Also along the path when you do rvtrace_path_stop, you need to ensure
>>>> the source has stopped and quiescent before beginning to stop the sink.
>>>> Otherwise you'll get partial or corrupted trace. In essence, follow Control
>>>> Interface Spec 11.3 Enabling and Disabling. FYI: my userspace driver:
>>>> https://github.com/ganboing/riscv-trace-umd/blob/master/rvtrace/funnel.py#L223
>>>
>>> It's better to add functions on a need basis rather than adding
>>> it now without any potential user.
>>>
>>> Regards,
>>> Anu
>>
>> Hi Anup, my previous comment also applies to your current use case where you
>> have encoder->RAM sink directly connected together. Having a longer path,
>> e.g., funnels in between makes it worse. The driver needs to poll the empty
>> bit tr??Empty (bit 3) of the control register to check if trace has been
>> completely flushed. Otherwise, you get a partial trace, possibly with last
>> few messages missing or truncated. So, yes, there's really a need to do so.
> 
> I think this can also be implemented in the component's 'stop' callback.

Sure, that also works.

>>
>> Bo

Bo

