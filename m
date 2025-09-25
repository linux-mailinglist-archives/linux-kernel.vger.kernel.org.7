Return-Path: <linux-kernel+bounces-832533-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 353CAB9F9A4
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 15:36:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3CBF1189B9E3
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 13:37:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18F5D26CE0F;
	Thu, 25 Sep 2025 13:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pNVcdayR"
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD8D826A087
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 13:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758807396; cv=none; b=R2N9KGkkbn63KKr28I/0T0cPvCedElyYVEG4Xk6+K9s7IOiFfpfY5OiqtIc3qw9KhOKJ9WGMn5ITm6BgWJNrV2R1n/0dAp/fte8kh4useu/q0WmlfZ8H7kumvsff5hQnqnm7P6PoDMCagRAbiphKmqCGPAS+1k1HTPzelaDBO9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758807396; c=relaxed/simple;
	bh=sSqjP4cvcawLrblfY9/wyy/hyoTTAKgpnyDa32+hyZs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cIoVInrDG7tXFL4ZB1755hq854teXPqR6zGuhYaJqzBjanelHR8F/ZSUvo2GaLAoU+DSskngScJ0/RKduZfJwjzHb7bDBebpZbgUCKNVrCeszG2zgKkyGW7ATXVRsqDmcdBa5Od2Hm2FCl5gJJov+QPcS5pHpO1GiEBnOBVLNfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=pNVcdayR; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3f0308469a4so620533f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 06:36:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1758807393; x=1759412193; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fx9sm2SG/XPK/zOHzWrJwHUPoT7scPpd+/H8+WI3Eu8=;
        b=pNVcdayR5oUrFeRDU0/+k/DMuwh1UJUitwxQmMWFRwZSDNsnTaJWymZtfYVKQrhkV6
         k9Dg9MQEKbDh9b69Mlxj+SgMSXAjFTzeNMiQtEjqTgiqyZFK1CIeKwi391y48eqAd1XX
         KBKW6cR4sRt2YNDrIAcyzvkWcUDp6Q5uJE5ZR9vxwgXFv9V5wLLWk04QRM3keo5OR+ZA
         AcBgkYL1uibz5EYT64nX75ZTqDx5zc9Rlqceuy6d8frJ9z4imWLf7KInh1uJ3KMaO1Ic
         L3yZMX9fPeTt9+L4aKZi1fse6voYFd6ApMJFlwX0JHdS0yTCstIQfLepl3qoTZct4rgc
         bzgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758807393; x=1759412193;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fx9sm2SG/XPK/zOHzWrJwHUPoT7scPpd+/H8+WI3Eu8=;
        b=gwbUxWnzOw10cNINKBGol5N5NztBE7ifvz4+edUVq3DE+iV7sdGp7PJN3vcO+e57lL
         XfnYhKCAgznbXBxdOIAIWurVNYJe3QN/+C6qDmxP1UfCyew7XZ4s7oRzgEaaldt2Fmxh
         QnGXkNvKW7zAukqSC9QWVFvyt5RqvLpGbqZp0D1+fjHo5j5dQwGvDPAVA2u3izS7BUCO
         cp1k+kpKxzLx2KlnYneqApJvXa5hRHnBBV9Kf5sUD7sxPWVQyS9RHlh4ykzzRVfK5NK8
         OOuz2s7nsVfZeG1J+G+OBLJ/2NtZvuKdqOdQrTTsJKe5hzd6b6LLGtD6o62yiG5mHneD
         PUNg==
X-Forwarded-Encrypted: i=1; AJvYcCX1FQqKCE5wLcYK2H4owVng+zYIZBVFNtRCD540ncfncQBMNJ7Q11gMdnfUWVtJfvg4hUdacKQvtbvN3u4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLy+dSPNWuYgCYiUb1BXuQ9eVll1gh8B980K3dYqkxDyx2qeaD
	RYKismoSfRrxMZ5MT0JXupBDCJbiMvyeJmhlAYaXbRcXSkfbFjnLp+AkO41Shlti+Z0=
X-Gm-Gg: ASbGncvx0Fr6UmqQZQ56oZUzJUGo6TVzhkFKY8MuUkiobW/uEQ2762XVTXI8+GrRNno
	vz5JAzhLOwwRLcQ2gh0ltFOB6dwq2nGO8G+WtUd5WthOJ//tKe8wax48WYs4KDXlCanFxydylzI
	H9ZQXJ4+9KWcGTj6nkNLxTksNqH3V1rPqhdhG81YUm63nQquaTU77phbPwve0xYuXJNhtclqFUo
	bG7NfhzpMuk4gD6OkQ4nlgDkniZlqx28rrkAPAfFLnaKUADH5xC4oxF6mVTLc5Dh4LiOL3gq4/x
	SkPPTFsgbmb3hVfailUZMuV/kz/1HAGTNtfw8JGzaQIZXbqHruzDwH1+mqfN243xgeUm9Qug+5O
	tz0rWlPabajZV/e7egH3lC0QqW7nQ
X-Google-Smtp-Source: AGHT+IHR1VtsrqYdEOR5yfalGbybkOIcDKOqLqd1M8rHZFAAkkevuzTqFI72lGmxMsSzzCv1aIizeQ==
X-Received: by 2002:a05:6000:290b:b0:3ee:154e:4f9 with SMTP id ffacd0b85a97d-40e45a92e7emr3845371f8f.20.1758807392860;
        Thu, 25 Sep 2025 06:36:32 -0700 (PDT)
Received: from [192.168.1.3] ([185.48.76.109])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-40fb72fb2eesm3203962f8f.12.2025.09.25.06.36.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Sep 2025 06:36:32 -0700 (PDT)
Message-ID: <4d5bf14a-0465-47b2-88c3-1bf85b008707@linaro.org>
Date: Thu, 25 Sep 2025 14:36:30 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 08/12] perf: Add perf_event_attr::config4
To: Will Deacon <will@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-perf-users@vger.kernel.org, linux-doc@vger.kernel.org,
 kvmarm@lists.linux.dev, Ingo Molnar <mingo@redhat.com>,
 Namhyung Kim <namhyung@kernel.org>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>, Leo Yan <leo.yan@arm.com>,
 Anshuman Khandual <anshuman.khandual@arm.com>,
 Mark Rutland <mark.rutland@arm.com>, Jonathan Corbet <corbet@lwn.net>,
 Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>,
 Joey Gouly <joey.gouly@arm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>,
 Zenghui Yu <yuzenghui@huawei.com>, Catalin Marinas <catalin.marinas@arm.com>
References: <20250901-james-perf-feat_spe_eft-v8-0-2e2738f24559@linaro.org>
 <20250901-james-perf-feat_spe_eft-v8-8-2e2738f24559@linaro.org>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20250901-james-perf-feat_spe_eft-v8-8-2e2738f24559@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 01/09/2025 1:40 pm, James Clark wrote:
> Arm FEAT_SPE_FDS adds the ability to filter on the data source of a
> packet using another 64-bits of event filtering control. As the existing
> perf_event_attr::configN fields are all used up for SPE PMU, an
> additional field is needed. Add a new 'config4' field.
> 
> Reviewed-by: Leo Yan <leo.yan@arm.com>
> Tested-by: Leo Yan <leo.yan@arm.com>
> Reviewed-by: Ian Rogers <irogers@google.com>
> Signed-off-by: James Clark <james.clark@linaro.org>
> ---
>   include/uapi/linux/perf_event.h | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/include/uapi/linux/perf_event.h b/include/uapi/linux/perf_event.h
> index 78a362b80027..0d0ed85ad8cb 100644
> --- a/include/uapi/linux/perf_event.h
> +++ b/include/uapi/linux/perf_event.h
> @@ -382,6 +382,7 @@ enum perf_event_read_format {
>   #define PERF_ATTR_SIZE_VER6			120	/* Add: aux_sample_size */
>   #define PERF_ATTR_SIZE_VER7			128	/* Add: sig_data */
>   #define PERF_ATTR_SIZE_VER8			136	/* Add: config3 */
> +#define PERF_ATTR_SIZE_VER9			144	/* add: config4 */
>   
>   /*
>    * 'struct perf_event_attr' contains various attributes that define
> @@ -543,6 +544,7 @@ struct perf_event_attr {
>   	__u64	sig_data;
>   
>   	__u64	config3; /* extension of config2 */
> +	__u64	config4; /* extension of config3 */
>   };
>   
>   /*
> 


Hi Peter,

Did you get a chance to look at this? Patches 1-7 have been taken, just 
waiting on an ack to take this config4 change before taking the 
remaining ones.

Thanks
James


