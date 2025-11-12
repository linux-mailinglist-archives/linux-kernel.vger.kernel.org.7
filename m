Return-Path: <linux-kernel+bounces-896837-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 77FC6C515B6
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 10:30:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 96B284FA5E8
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 09:21:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 072022C0296;
	Wed, 12 Nov 2025 09:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vUYXxIIo"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8571728CF52
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 09:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762939295; cv=none; b=F7S/QOvMnI9BGRdIadzc3zFDTFlm05wBKZZng3oaVgLCM8kUZiKTH/jQG4i9DYu8EElJKjMl/ReGne1pUqCQS8QvXs1w9SyEVtaj/XmjCMi9kPLvi2hwxEkHDvWY7CLd+D0lDN1xRqdJECvNHm/K/QN75yS3JjP54P822Dnui6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762939295; c=relaxed/simple;
	bh=mHUEJ9dFxjdIsQc2ajIBdyiHVVcQa57HOEjifIA99SM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Dqbpt/5xun0mjChCsxPHAnPu3gb6GaLfbHxklrA05Umtdab9lHqXnSYtjVc0Z0NNl0V3x5jTKvhZkJe+J/rKALZXuxJpMdzqYjPCHFiWP4iG1FfF2ALND4EzMjSzmIV3idTB/t2jSDTlK5rblbaErHg4jl/K3C+oOaRBO0uLnFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vUYXxIIo; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-47755a7652eso4182885e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 01:21:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1762939292; x=1763544092; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=isJ1f7GA11vhD0tZY8DcYtbxrZ+tOnHfUKfDqQgIdJc=;
        b=vUYXxIIowwiO4tmCofem4QeembsmQjG80XV7yc2aMHR1CBEhKwOliP3OfewG8Q5TNl
         8FTRzYF0iI0qtXu8USmL5V1KUxUWo3RtttTdz0sowfYHKasPWpd4j3ocpvgtmG9l/hk/
         aVvIadVqWTPNwGtZL0mxtDHoMlQxOpVoy5vgU4p3/6fczeznrv1L5zaiVC5Y+2rPD30j
         0O59I1mZ2nToxTY3JSipEHV68MzE6UZ1rEJplrw+yqTZOso7oXzaNIkQUYOptLkcdouW
         hFhHvsWR4rOdrW7xrh6nIgp26B4JroY8GGAxeoeP5fkXqHy8jEtjI+lD2QT7BablVqU1
         Tdqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762939292; x=1763544092;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=isJ1f7GA11vhD0tZY8DcYtbxrZ+tOnHfUKfDqQgIdJc=;
        b=Ez7sY/j75hjBmgpZkDefKrTj7rV9JaivIu+ZWsX0XL4/cmCRJCAP12R7wZo1KbrKUj
         6LI+klQvfZzvjtwBto1D6f4CGu79amUMjQiY9mTkOHvBgwMqdClRSFBSdwAL9BAoLvC8
         CyloIP66LYXDxwEjlUcqtA6dm1XxwWcAp/845yiKqXvOugrc7xwzTUBqB1VZk1GUkKK7
         nhneuSaGUasYSPeFk27EYFCh5MJFc/GLqLIaDxGFEiWqV52Wh9+B8dwXvL9O3MF+OslA
         fAcdRCut+jZW6CYlV/kW5T8puToZguVA184J12Co2hZHA9KRiq+TdNyMc6sRYCxjvow0
         +Xpw==
X-Forwarded-Encrypted: i=1; AJvYcCUjupvr/GaLVkjoAhdvfkxzSBAktdH3fb/8gs5YuBKorQDteDRySCIyqYoQ5sZo5rQ5J687/LZG01ehWtg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzhz8jIiHiALqLCVbT3pQtzVlBkiZygvBqi3iPVRuINAGJKkwIH
	3TVQqHS6ElmFViWFJZapoiYYucE+4IL7r32Y9TH1mMuxGlpWLfeXQ66zztCJXncTaSg=
X-Gm-Gg: ASbGncsJmaPaDBEILDNYk7i6ekjvR6x3hNh1FSb99H4tnTS7rtVudQEPpmMJmJyNFK1
	qCSGw8FfIR8xR2CZTdy4QoN2ES3NdFv49Cywt5YXZs/a8ynYKzMv/LAMls3caIuHP1QCeyMz5fj
	ndq/g2FZxy5Y842ahJbrrycOyHfmj2XR+abQKsaIRbhl0Rbmb2MUHEabGUPVQJtkQgNVUC2Mzh8
	0CuFPdnQKTyV9Q2pG1KYeUcuEWbtRrJQMPNUxmFAd48LKDt6B18NzttX4EB1O6rTNzya6IZCSXk
	TDhYad8a0tpVpAeyG6WeTlSVnuSzYgrRjzWZRA/Ci1X+yPjdGrJB2g/AlFIrVQnYXH4m+bcpMHD
	414pPBNqPChtLY8mff5kuxirRN1dsA4xHZ+s8+fYAh5Ikq7KSAosJU/RdhVioaewZAx2oTeyzUc
	qPVfGrZw==
X-Google-Smtp-Source: AGHT+IH19B1p4+2J8cnMXiWHY0YRtV67T+2IEhayNx6bLOI1rTnsrziF09BOz3EDGz+wy3KJavPJ1A==
X-Received: by 2002:a05:600c:3b90:b0:477:7a1a:4b79 with SMTP id 5b1f17b1804b1-477871e9565mr17896305e9.37.1762939291619;
        Wed, 12 Nov 2025 01:21:31 -0800 (PST)
Received: from [192.168.1.3] ([185.48.77.170])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42b330f6899sm21364157f8f.21.2025.11.12.01.21.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Nov 2025 01:21:31 -0800 (PST)
Message-ID: <9008f2e6-d2de-4765-b824-cdd6a1175794@linaro.org>
Date: Wed, 12 Nov 2025 09:21:28 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 0/5] Remove NO_AUXTRACE build option
To: Ian Rogers <irogers@google.com>, Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>,
 Mike Leach <mike.leach@linaro.org>, Leo Yan <leo.yan@linux.dev>,
 Suzuki K Poulose <suzuki.poulose@arm.com>,
 Yicong Yang <yangyicong@hisilicon.com>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Thomas Gleixner <tglx@linutronix.de>, Darren Hart <dvhart@infradead.org>,
 Davidlohr Bueso <dave@stgolabs.net>, =?UTF-8?Q?Andr=C3=A9_Almeida?=
 <andrealmeid@igalia.com>, Tomas Glozar <tglozar@redhat.com>,
 Quentin Monnet <qmo@kernel.org>, Yuzhuo Jing <yuzhuo@google.com>,
 Blake Jones <blakejones@google.com>, Charlie Jenkins <charlie@rivosinc.com>,
 Yeoreum Yun <yeoreum.yun@arm.com>, Athira Rajeev <atrajeev@linux.ibm.com>,
 Ravi Bangoria <ravi.bangoria@amd.com>, Collin Funk <collin.funk1@gmail.com>,
 Dapeng Mi <dapeng1.mi@linux.intel.com>,
 Thomas Richter <tmricht@linux.ibm.com>, Dmitry Vyukov <dvyukov@google.com>,
 Andi Kleen <ak@linux.intel.com>, Howard Chu <howardchu95@gmail.com>,
 Zecheng Li <zecheng@google.com>, tanze <tanze@kylinos.cn>,
 Gabriele Monaco <gmonaco@redhat.com>, GuoHan Zhao <zhaoguohan@kylinos.cn>,
 Markus Elfring <Markus.Elfring@web.de>,
 Colin Ian King <colin.i.king@gmail.com>,
 Kan Liang <kan.liang@linux.intel.com>,
 "Dr. David Alan Gilbert" <linux@treblig.org>,
 Jean-Philippe Romain <jean-philippe.romain@foss.st.com>,
 Yang Li <yang.lee@linux.alibaba.com>, linux-kernel@vger.kernel.org,
 linux-perf-users@vger.kernel.org
References: <20251110013152.3099080-1-irogers@google.com>
 <aRLV50z1L9A3YRFF@google.com>
 <CAP-5=fW4XSL_tAD9-BzG9ceUJSr005bWi3Q1-kiJ_xyiHJZggg@mail.gmail.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <CAP-5=fW4XSL_tAD9-BzG9ceUJSr005bWi3Q1-kiJ_xyiHJZggg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 11/11/2025 6:01 pm, Ian Rogers wrote:
> On Mon, Nov 10, 2025 at 10:21 PM Namhyung Kim <namhyung@kernel.org> wrote:
>>
>> Hi Ian,
>>
>> On Sun, Nov 09, 2025 at 05:31:47PM -0800, Ian Rogers wrote:
>>> Switch the __get_cpuid feature for intel-pt to use the provided cpuid
>>> function in perf, this removes the need for NO_AUXTRACE when the
>>> feature detection fails. Remove the now unnecessary feature
>>> detection. Remove NO_AUXTRACE as it just builds a more broken version
>>
>> Can you please elaborate what the broken part is?
> 
> Sure. I'll summarize what alters in patch 4. NO_AUXTRACE is
> controlling 3 main things:
>   * set up of aux options for PMUs (code in the arch directory)
>     * ARM: coresight and SPE
>     * Intel: BTS and PT
>     * PowerPC: VPA DTL
>     * S390: cpumsf
>   * support for decoding aux events (common code that can be
> cross-compiled assuming other library dependencies are available)
>     * ARM: coresight
>     * HiSi: PTT decoder
>     * Intel: BTS and PT
>     * PowerPC: VPA DTL
>     * S390: cpumsf
>   * Tool support for aux buffers (common shared builtin code):
>    * perf record: aux options for events, snapshot, aux-sample
>    * perf inject: aux events will fail the entire perf inject command
> 
> So somebody with a NO_AUXTRACE build would generally experience a very
> sad perf command. Having the option made sense when there were feature
> tests that could fail, but possibly that should have just controlled
> not compiling intel-pt. Having the option is extra burden on
> developers/maintainers, as shown in my comment:
> 
>> This was prompted by needing to make a v2 patch set of:
>> https://lore.kernel.org/lkml/20251107170712.2302714-1-irogers@google.com/
>> due to a broken NO_AUXTRACE configuration.
> 
> Somebody may have been using NO_AUXTRACE as a proxy for not having
> some library, but I don't see that in the code. If this is the case we
> should add the appropriate feature test, ..
> Not having NO_AUXTRACE may have been a bug work around for someone, in
> which case we should work to fix the bug. Again, I don't know of this
> case and don't see it in the code.
> 
> Thanks,
> Ian
> 
>> Thanks,
>> Namhyung

Seems like a nice simplification even if nothing was badly broken.

Reviewed-by: James Clark <james.clark@linaro.org>


