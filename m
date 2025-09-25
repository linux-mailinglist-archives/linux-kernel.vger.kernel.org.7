Return-Path: <linux-kernel+bounces-832183-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D1801B9E93E
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 12:11:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A664427B0E
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 10:11:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AF362E9EC9;
	Thu, 25 Sep 2025 10:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MtAXrr3u"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB7E026CE2A
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 10:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758795057; cv=none; b=SocUx2JbUrHRq5aDlXRoNCnP1SacCNDOxrdV1UYo5YRQEm+/hJSsOwh9WoCQg66bb9HaiOZwFGU0oIqtuqDgPMW6m620VatMU2D7fXYbxn8UffxwIrGO7Gnxh9N9FnQy57DXtOtAi0dhQu4Uj7qBc83Z1rlljDZuylOO0GQIH20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758795057; c=relaxed/simple;
	bh=Uu7qPHWAY70uCIDEzqVDmVr4PiMC2MZjl91UdvG6bIw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=J4QZNWuU83yaobxTO+tZVq2/uVu0C86Ij1ucdwBBqRgDhSYYbZetWe1Ssilwnsqa2hZgbwtczYAz3BKBcElMXlR+7sVxBGI9Jbjdzu+lUgZ1ldZH1ugiUQcI+QzlS+visdr6P8xbFAYXdzpgrUOKqqMlghMN2UJiw4DygTrCAW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=MtAXrr3u; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-46e317bc647so5131685e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 03:10:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1758795053; x=1759399853; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rOe/V2dIqH8cF6CYVYqeg4xafgczBUe8P8lTChGAnIk=;
        b=MtAXrr3ui4H3CFYh5Ex8N7ztOfPdeN34W2HxnnN4zBiLPtG/kEenegJwicfFuwdwgs
         R7ZjpEzVB4JGCS7TLJMbg7gaauM0uV9V2szvJNt0t4RDqj8jO0OmADK0H2n5WtHvebZ0
         4IImS8ToF271lG/7nIEXeESyUujeHJ17ipympmlEnAZ3mcJUc95loBNYoD3hb2xILe+O
         nj+xJV0ibOPBImRJPB0CnpdOFpsXMag6fTb6DjWViWreTgceF2dy8xbX4d9tX+kD6KM8
         vMmkKkkykzaOe/m5TRc67itNiib/fzBIG0v3zMUG152f4KdkQV5K8COZxf2JbAMzO7/9
         /lqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758795053; x=1759399853;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rOe/V2dIqH8cF6CYVYqeg4xafgczBUe8P8lTChGAnIk=;
        b=a/42CPFN9rQtfvccmJzS6HxAmOLaAMBeG2f/yYu99yBQQaBuOveJzxa/YU6bs4kSoc
         ZsQ2IuzZ/nls7sR19sveZJVtbBdmLLQGMHAEWVnSkqTqxnymf/U+LHLAzTHgStAanedl
         1okN6kNgAa9wQKvHpNHsQb4jF7MdbRHzH8jaXmiAg8YrUGNa5yQ667in4IkxIaNN6Zic
         aKvd6SIjtVn7hsM7SaLIUDzGNhRDj+NuGDpiP0ofmzurs67kxiIi0nKOf34Y/k8AlCRN
         sAk7SCk2E68pVFCpkziZXp4PkvUVs1Qmx6RkHm4RA3wN5f5Is+TDj3BtLkDiO583p15z
         93GA==
X-Forwarded-Encrypted: i=1; AJvYcCXOg9r2GzaD+Le19TRgZbum/BB3yy+sged0/v0+UthWUys9FhRt2jtWaxg5pcJ1YGuMO0dkp5dOfQ//faI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPOglmfbMIHyVWA7wWLCa1QDJDxKRzV9cIzlfZ/mmsbZmQ/Q4y
	YBt3FDfuPe2hSAJs48v/QcHN2eCDFRDULzZIJ5CAPAzJJn/O5kDDgs3bvzXc7/EFhm4=
X-Gm-Gg: ASbGncuoJP0Gcd8075AUch7q5xpdnS1GtJyaqjZ1KsGtAl0wrad5wuPBFn3nk/UTFVb
	etEavrGeky26MkdZ5hR8mKUWyDnZ0NxITPENiGYXVJvf9HLtbJ3LsSq2mrpGjSZ/iIGg9c2vpxe
	2CMBpI0QAiRcUl7O9Fjeq0cwjtd75gD9RSzhczz4FaFQzqoKp9bxGa3BIrsI9sG38cpMMVKzbSN
	M2tKRywRWPWzd2tTbyt6vUDZdk7lkRV0uwsZePplLZclXQSv1t/M77Mt3epb6tAruz84Meq5g5Q
	J5P+03GjRFU7ZKOXcYKlbjoiUTjAWJhAxXk72MOpAwzIDomL4VMtvsGG49/WL/oyyZNn/k7jh8Z
	zXMZ6fCf4syxgubrKhyitld1JIHd8
X-Google-Smtp-Source: AGHT+IFKLqOqt62stWM0T5kpVyIEL9lneNcZ++3W9gEaCXSNMWcezei1Wkk6UZpKhu4oEPAHFgNNEA==
X-Received: by 2002:a05:600c:6306:b0:46d:9d28:fb5e with SMTP id 5b1f17b1804b1-46e329ab29cmr30602985e9.5.1758795053180;
        Thu, 25 Sep 2025 03:10:53 -0700 (PDT)
Received: from [192.168.1.3] ([185.48.76.109])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e2ab7d4e3sm69919775e9.23.2025.09.25.03.10.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Sep 2025 03:10:52 -0700 (PDT)
Message-ID: <635ba698-d7a9-40d0-9285-4ec108d4a536@linaro.org>
Date: Thu, 25 Sep 2025 11:10:51 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 1/3] coresight: tmc: add the handle of the event to
 the path
To: Suzuki K Poulose <suzuki.poulose@arm.com>,
 Mike Leach <mike.leach@linaro.org>, Jie Gan <jie.gan@oss.qualcomm.com>,
 Leo Yan <leo.yan@arm.com>
Cc: Carl Worth <carl@os.amperecomputing.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Tingwei Zhang <tingwei.zhang@oss.qualcomm.com>, coresight@lists.linaro.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20250922-fix_helper_data-v1-0-905e8115a24e@oss.qualcomm.com>
 <20250922-fix_helper_data-v1-1-905e8115a24e@oss.qualcomm.com>
 <874isuo0m2.fsf@rasp.cworth.amperemail.amperecomputing.com>
 <f7be3833-9b33-4935-b821-a2e0000a2557@oss.qualcomm.com>
 <CAJ9a7VjaUE+iy=FFwPhCdfXgoGR3rP9WSx-ZkKYeCHhqJ2yzMg@mail.gmail.com>
 <3b16607f-8995-46b1-aecf-c6aa79f66f9d@arm.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <3b16607f-8995-46b1-aecf-c6aa79f66f9d@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 24/09/2025 5:42 pm, Suzuki K Poulose wrote:
> On 24/09/2025 11:21, Mike Leach wrote:
>> Hi,
>>
>> On Tue, 23 Sept 2025 at 02:49, Jie Gan <jie.gan@oss.qualcomm.com> wrote:
>>>
>>>
>>>
>>> On 9/23/2025 1:31 AM, Carl Worth wrote:
>>>> Jie Gan <jie.gan@oss.qualcomm.com> writes:
>>>>> From: Carl Worth <carl@os.amperecomputing.com>
>>>>>
>>>>> The handle is essential for retrieving the AUX_EVENT of each CPU 
>>>>> and is
>>>>> required in perf mode. It has been added to the coresight_path so that
>>>>> dependent devices can access it from the path when needed.
>>>>
>>>> I'd still like to have the original command I used to trigger the 
>>>> bug in
>>>> the commit message. I really like having reproduction steps captured in
>>>> commit messages when I look back at commits in the future. So, that 
>>>> was:
>>>>
>>>>         perf record -e cs_etm//k -C 0-9 dd if=/dev/zero of=/dev/null
>>>>
>>>
>>> Sure, I’ll include your commit message in the formal patch series, I
>>> think it's V3 since you have submitted two versions, if you're okay with
>>> me sending it out.
>>>
>>>>>    /**
>>>>>     * struct coresight_path - data needed by enable/disable path
>>>>> - * @path_list:              path from source to sink.
>>>>> - * @trace_id:          trace_id of the whole path.
>>>>> + * @path_list:                      path from source to sink.
>>>>> + * @trace_id:                       trace_id of the whole path.
>>>>> + * struct perf_output_handle:       handle of the aux_event.
>>>>>     */
>>>>
>>>> Fixing to "@handle" was mentioned in another comment already.
>>>>
>>>> Something about the above still feels a little off to me. It feels like
>>>> we're throwing new data into a structure just because it happens to be
>>>> conveniently at hand for the code paths we're needing, and not because
>>>> it really _belongs_ there.
>>>>
>>>
>> This data is perf specific - not path generic; so I agree that this
>> structure should go elsewhere.
>>
>> I would suggest in the csdev (coresight_device) structure itself. We
>> already have some sink specific data in here e.g. perf_sink_id_map.
>>
>> This could then be set/clear in the functions coresight-etm-perf.c
>> file, where there is a significant amount of code dealing with the
>> perf handle and ensuring it is valid and in scope.
>>
>> This can then be set only when appropriate - for source / sink devices
>> and only when in perf mode, and avoid the need to pass the handle
>> around as API call parameters.
> 
> I think this data is specific to the session we are enabling the
> device(s) in. e.g., we keep the trace-id in the path.
> So, I don't mind having this in the path structure.
> Instead of modifying csdev with additional locking from "etm-perf"
> it is always cleaner to handle this in the path.
> 
> 
> Suzuki
> 
> 

Yeah, and perf_sink_id_map only "needs" to be in the csdev because it 
controls sharing IDs between multiple paths which can't be accomplished 
by storing it in the path.

This one is just a pointer to the perf handle which really does belong 
to the session rather than the device. This makes it more of a path 
thing than a csdev thing. Maybe we can rename path to be more like 
"session", which also happens to contain a path. But I think path is 
fine for now.

However in this case handle is per-cpu data that is only accessed on the 
same cpu in tmc_etr_get_buffer(). Assigning it in etm_event_start() just 
copies the same per-cpu variable into a non per-cpu place that 
eventually gets accessed on the same cpu anyway.

If we exported it then it can be used directly without worrying where to 
store it:

diff --git a/drivers/hwtracing/coresight/coresight-etm-perf.c 
b/drivers/hwtracing/coresight/coresight-etm-perf.c
index 17afa0f4cdee..4c33f442c80b 100644
--- a/drivers/hwtracing/coresight/coresight-etm-perf.c
+++ b/drivers/hwtracing/coresight/coresight-etm-perf.c
@@ -42,12 +42,8 @@ static bool etm_perf_up;
   * the ETM. Thus the event_data for the session must be part of the 
ETM context
   * to make sure we can disable the trace path.
   */
-struct etm_ctxt {
-       struct perf_output_handle handle;
-       struct etm_event_data *event_data;
-};
-
-static DEFINE_PER_CPU(struct etm_ctxt, etm_ctxt);
+DEFINE_PER_CPU(struct etm_ctxt, etm_ctxt);
+EXPORT_SYMBOL_GPL(etm_ctxt);
  static DEFINE_PER_CPU(struct coresight_device *, csdev_src);

  /*
diff --git a/drivers/hwtracing/coresight/coresight-priv.h 
b/drivers/hwtracing/coresight/coresight-priv.h
index fd896ac07942..b834e8bef2a5 100644
--- a/drivers/hwtracing/coresight/coresight-priv.h
+++ b/drivers/hwtracing/coresight/coresight-priv.h
@@ -14,6 +14,7 @@

  extern struct mutex coresight_mutex;
  extern const struct device_type coresight_dev_type[];
+DECLARE_PER_CPU(struct etm_ctxt, etm_ctxt);

  /*
   * Coresight management registers (0xf00-0xfcc)
@@ -49,6 +50,11 @@ extern const struct device_type coresight_dev_type[];
  #define ETM_MODE_EXCL_HOST     BIT(32)
  #define ETM_MODE_EXCL_GUEST    BIT(33)

+struct etm_ctxt {
+       struct perf_output_handle handle;
+       struct etm_event_data *event_data;
+};
+
  struct cs_pair_attribute {
         struct device_attribute attr;
         u32 lo_off;
diff --git a/drivers/hwtracing/coresight/coresight-tmc-etr.c 
b/drivers/hwtracing/coresight/coresight-tmc-etr.c
index bf08f6117a7f..7026994b02b3 100644
--- a/drivers/hwtracing/coresight/coresight-tmc-etr.c
+++ b/drivers/hwtracing/coresight/coresight-tmc-etr.c
@@ -1328,8 +1328,9 @@ struct etr_buf *tmc_etr_get_buffer(struct 
coresight_device *csdev,
                                    enum cs_mode mode,
                                    struct coresight_path *path)
  {
-       struct perf_output_handle *handle = path->handle;
         struct etr_perf_buffer *etr_perf;
+       struct etm_ctxt *ctxt = this_cpu_ptr(&etm_ctxt);
+       struct perf_output_handle *handle = &ctxt->handle;

         switch (mode) {
         case CS_MODE_SYSFS:


>>
>> Regards
>>
>> Mike.
>>
>>
>>
>>
>>> The core idea behind coresight_path is that it can hold all the data
>>> potentially needed by any device along the path.
>>>
>>> For example with the path ETM->Link->ETR->CATU:
>>>
>>> All the mentioned devices operate by forming a path, for which the
>>> system constructs a coresight_path. This 'path' is then passed to each
>>> device along the route, allowing any device to directly access the
>>> required data from coresight_path instead of receiving it as a separate
>>> argument.
>>>
>>> Imagine a device that requires more than two or three arguments, and you
>>> want to pass them through coresight_enable_path or similar functions...
>>>
>>> For certain coresight_path instances, we may not need the handle or
>>> other parameters. Since these values are initialized, it's acceptable to
>>> leave them as NULL or 0.
>>>
>>>
>>>> Or, maybe it's the right place for it, and the cause of my concern is
>>>> that "path" is an overly-narrow name in struct coresight_path?
>>>>
>>>
>>> It defines the direction of data flow—serving as the path for trace 
>>> data.
>>>
>>> Thanks,
>>> Jie
>>>
>>>> But if a renaming of this structure would improve the code, I'd also be
>>>> fine with that happening in a subsequent commit, so I won't try to hold
>>>> up the current series based on that.
>>>>
>>>> -Carl
>>>
>>
>>
>> -- 
>> Mike Leach
>> Principal Engineer, ARM Ltd.
>> Manchester Design Centre. UK
> 


