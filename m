Return-Path: <linux-kernel+bounces-879887-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8007AC2455D
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 11:04:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 49CF41B20DA5
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 10:00:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC006332919;
	Fri, 31 Oct 2025 10:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="J4f3W9rX"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F211322A25
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 10:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761904806; cv=none; b=GNZatrL2Wqv2bZ3Zc71bOQG9xQzZJ7Drk9vl+HrTbrIi+tBWl/W2riCV7feyTbq3rlVVvF/aMHITddkdhSjmx5qt0RFErDSHtJpjihv7vW14YgdFUcJTv2CbpDeicdzCJ0cviodi3XHzfOiCTMFCyOVXXFXkyiHqRKsWFdB/itA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761904806; c=relaxed/simple;
	bh=wNnjGniV6pu3D6d0+vHC1OpzEzE1DnHmr+R7k2tu6TU=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=F7W0NbcTK/QYUWizpLq5bdYMiTzZGvFpiQaA7DMSp+MU5E4KEFkzf9P4Gd5c3smEOsXizfFgdGeauYa5l+YfHggtksYgH80ZrsHrUswLF4WqEMxzLxYMS1yNVYzeQgtMBnTY+Mq/O2KdEH1Y/kUrE8J2RQNx2vfWR29UMMy09cU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=J4f3W9rX; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4770e7062b5so14706735e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 03:00:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761904803; x=1762509603; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:cc:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9XmagYXZGhiRCZo8nGtg5dtjzropHlOVEQuuywu8QoA=;
        b=J4f3W9rXGjMCaWSR6Lxj7YXEWIJgdZSbBIrNsbATnAknXIGFGL1YFerW/2meokdt5+
         DNNXhauX+rEW5pjvlg0uAORbrQs4yxcAWuq8Z5wYU7xIUzBVxdHofS+uG2hE13xxh4sM
         7NSUUgwKy+kKGodo3uFPEEemwhmosAplqPGW809/IH5C9gjZaS826RWPyzAsJAudYPsJ
         JdKckZN33cePnrmmh6QTxN6+vLeFNqanG3DR3oP9nUFP9zBQAr9x2r8lpLFwLgGgfbBC
         pjgDts2J7nB3MFJEkwORLcTJRDUv8M2/u+xT0b+VKGnTYAA5i+LysobG0gpmakWDBIiv
         s5Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761904803; x=1762509603;
        h=content-transfer-encoding:in-reply-to:from:cc:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9XmagYXZGhiRCZo8nGtg5dtjzropHlOVEQuuywu8QoA=;
        b=wViTC+VwTzx/c1CrU6vxbpJXph9NY3Di6qvlamhb9GEyNb1V96v4eOFl+ger3lx4CJ
         xMX+LTqM+g/HPxdoF1+9VPGbyUEQgoXup73i3CaKBZCgK/6o4gS3x1SePTfnKNI3yEGG
         OTDpTzhdFpGDPW06tIv/5/3VrI6af/TWTcJwCq4vMFjlSwk3p46WMCYewzut8ml3IL+j
         pDINwO3W8vFsNXs+zPyX2rEOKVTrhofhkgmALORVa/fqlqcszcfZJKQBcz4Vr0gpWVme
         huw6a3PRYcfHYNlIM3oc6A7F7GCOaI1qCL4huJugYr6Kg8ozH1kI4tX6syZyDvnKZO3M
         dEXA==
X-Forwarded-Encrypted: i=1; AJvYcCUAuTitf4DcudezvHloQ80zQAddOLXlJ5XGssu63ONikHuhPxDUvXzGHU1dXEwDUWoFwmGSpE8RIzAcZbs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyvzyhdM+e46Dw9qidVu4i6extVmTCWL9Itf28f4/H4Bo8E0jaQ
	IetmoFhJCHDi1YyppBzUBn5H9UTTGXe7lfjFTpK4BLmnC86x4ge7A9nM69vfZnLHX90=
X-Gm-Gg: ASbGnctREbpXWv6sSRDTvqF8+CxFUkh/kCPkxrfB7uVSi1MG3semQ03Vz3rPsp/mXgC
	INsXR3tggwgjt4ZlqABWaip4z//lvd9XFD0rYDRLAyBr4ZkW8QtAtynEw5135qEeEMSr4+HOOBr
	149iVtb8DzVWGSUirVfU53chji7I+bv3c1c/Zl8WuF5Q3SHnF+sbI/CQtyehe8tc/5bkrkeg8iW
	YVBwHkcN76zkb4sNgLy+SM7+43VpYQMXZSUPj/IPLd58RJbyRRTLJG3FdfyutKG1mK0NaLIkq98
	Za1KcnGem62buzuReZAbxDYkxrAa7FQcIDshWG7fhTwVmlVDdZLJ3n4bALJBk3+vKzAdQJQe8Sb
	EVrOXa2c+KDy/VqQ30DstUSTs0iQ96AM5O3pJHWwa/qGhwSA0NrZH5NY7Mx69OBeha8NSVXVxd2
	pYkH+sP+7qSSPrT0r8
X-Google-Smtp-Source: AGHT+IEv9vBf1gcZcP/1EXFL+TdkTt1q9osVqrYbZXlOtnlKXOqyYbm17I+a0qRcWFjfmA40A3E6SA==
X-Received: by 2002:a05:600c:4e44:b0:45f:2cb5:ecff with SMTP id 5b1f17b1804b1-477308ce7b2mr28429105e9.31.1761904802781;
        Fri, 31 Oct 2025 03:00:02 -0700 (PDT)
Received: from [192.168.1.3] ([185.48.77.170])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47728a979b8sm86399575e9.10.2025.10.31.03.00.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 Oct 2025 03:00:02 -0700 (PDT)
Message-ID: <18df2108-5f09-4806-af0f-3af3fbff3f92@linaro.org>
Date: Fri, 31 Oct 2025 10:00:00 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tools: Fix typo error in json file
To: Chu Guangqing <chuguangqing@inspur.com>
References: <20251031031729.2304-1-chuguangqing@inspur.com>
Content-Language: en-US
Cc: john.g.garry@oracle.com, will@kernel.org, mike.leach@linaro.org,
 leo.yan@linux.dev, peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
 namhyung@kernel.org, mark.rutland@arm.com,
 alexander.shishkin@linux.intel.com, jolsa@kernel.org, irogers@google.com,
 adrian.hunter@intel.com, linux-arm-kernel@lists.infradead.org,
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20251031031729.2304-1-chuguangqing@inspur.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 31/10/2025 3:17 am, Chu Guangqing wrote:
> Correct instruction spelling errors.
> 
> Signed-off-by: Chu Guangqing <chuguangqing@inspur.com>
> ---
>   tools/perf/pmu-events/arch/arm64/ampere/emag/cache.json | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/perf/pmu-events/arch/arm64/ampere/emag/cache.json b/tools/perf/pmu-events/arch/arm64/ampere/emag/cache.json
> index 4cc50b7da526..4001cc5753a7 100644
> --- a/tools/perf/pmu-events/arch/arm64/ampere/emag/cache.json
> +++ b/tools/perf/pmu-events/arch/arm64/ampere/emag/cache.json
> @@ -81,7 +81,7 @@
>           "BriefDescription": "L2D TLB access"
>       },
>       {
> -        "PublicDescription": "Level 2 access to instruciton TLB that caused a page table walk. This event counts on any instruciton access which causes L2I_TLB_REFILL to count",
> +        "PublicDescription": "Level 2 access to instruction TLB that caused a page table walk. This event counts on any instruction access which causes L2I_TLB_REFILL to count",
>           "EventCode": "0x35",
>           "EventName": "L2I_TLB_ACCESS",
>           "BriefDescription": "L2I TLB access"

Reviewed-by: James Clark <james.clark@linaro.org>


