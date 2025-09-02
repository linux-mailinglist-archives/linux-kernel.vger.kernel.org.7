Return-Path: <linux-kernel+bounces-795567-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 424E6B3F4A2
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 07:40:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0775317FE08
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 05:40:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50EBB2E1742;
	Tue,  2 Sep 2025 05:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WitTSfwG"
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 326122D5934
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 05:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756791614; cv=none; b=sTjV/I4jzGB/C45u5PTrLnUUAwsnM3BLIsu8FeSw/H4aQVHwkz40dl47VsbwZ2ccqTJMj0uMUUzHe6rLoo++gcL/Hggxoen/I4Mcw9YaG8FkhZsfTGwAM41geGSAHe4YeX9LyAAplICuy+64axPkPctHS1h2c3T+rCG1IZKOb9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756791614; c=relaxed/simple;
	bh=8Tn7K5i1isgjo5oamWJLs+4w/BwjVbi7Qfelosp9mko=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gsjT6nceVHWaRb9VvXAfneHBgYMOz/Mf8wrW9QqyAugcqkWmtKRLaLsx3yookKo2pdBIuIsJvDhU7VKf0K6G1YsmlLVP5nFQH36wg1ASHJFDhHpKJy/3e4WWGLGFO9GvX19eADyuHLZRfhxHnL5dp57DRdbKGz8SSG3a9pO5qnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=WitTSfwG; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-772301f8a4cso4231722b3a.3
        for <linux-kernel@vger.kernel.org>; Mon, 01 Sep 2025 22:40:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756791612; x=1757396412; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7CgLt7RIUR4eCRkWKk0fzd+AGBm8SmxIJSCNeFZDeGc=;
        b=WitTSfwGT3Yr34GNcUah1ae/5J+7wiflLbNWZvvqpxvUHei+LNCSNJCG8kihW5L7x1
         olO70+BCNZydBNHcOMvFMtSVej2CCivhkHl9VKZd5EDLJ8rQJLeRl7+qfUEeZ+G8wv1M
         xFWqZKnjj42W9HZihrPBpu9gHIz0m7QJO2ZR1SG2NUoiIz0z5WMjVNxQjHqW12TD0R8G
         t275lieZQJT7wswVxt5zQVOxe9EcXkNvST34E/onR2M/KJzbLAdOz1ObEJVT59c4Pw7h
         u3TpMA6yOh2fRP2G5F0rIcmF7euR5bqWCRggAK67bhA9hA/FtMS7t+3c4UybBRsRCHCz
         QS6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756791612; x=1757396412;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7CgLt7RIUR4eCRkWKk0fzd+AGBm8SmxIJSCNeFZDeGc=;
        b=uGnZQ3OGy/nfQ13I9TG1wV0pVLpAK70nrtjMzPccVVlA7gOT5EKV2+kVhd3Zw9H5pH
         Lm+XIqRLZPEVpLNDmGt0XTfQ5xW3nRuegKcq2H3ukYXepzSdcNBujlffOqBzXXl6jdsu
         Q7gxX/5eyYgYODsOYrqDVTZeK8NUUwm4HF/0qw1akSa0PO9HQkYh45SvSKeLpjMYKXoO
         6sg+2bP2sd+ypbaRyQGWqEbjpnTG+UpVgoAoe79CXwPlfM7so+nKnrlKrCxY02Tb6Ef6
         PN00yFx8OB4wX8dSQOWwiOqxJN1QfNhfuYSDeh1fMDy1JlRKL/3shR6K4tcU+o0DXj4g
         b0fQ==
X-Forwarded-Encrypted: i=1; AJvYcCWNeGvD4ZXnUziP75r7hRAjraj9wz3dwB0HuqZ/hMyIuPO7G8YZMmK0f0FJQeLasAz40WQLzUn58nT9jQ8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVxYTuc/zdmVV1gg3JUnwQGruOo+mPM7HQQnvzIS6mwZSZhRRc
	DfYoqk+im5N+sVJPNXEmTR35yscG2jmZPWtI+BIsFuCdchrW1WtSOYyUYs2E9U1x0iQ=
X-Gm-Gg: ASbGncvJlNWqBx7YnizQuOB5slDPFW4f++i7XGcUXqqbrKdb7zyBAUJpWNdTUitzvjt
	OZzAdfe+vhyP2jkhcPzlJl6ZLqoz577yQyVQEzj4XqTgjWe4zDTYfAaeme43DOdVRN0vtcknv77
	CRTh0MMWTmv8TfW/Cq3nmBx9cTIC1pSlrsos9uXW5E8ZSicZ9lbHEP5PesxNS4r9tMe7sn95zXE
	Bl0udax1lKTttmuQl7Ul67KfqUwmFel/V6rPUlcth6T/QjUPg3A+hN3+wvnh2dlnaGSTG72FbQi
	kA2EZz64KdfxDDH+nJ2uW/nzjDFbh2NcQ4ERFqcCSsJQ3LsyKwKvF88xtQO8IwpyOBJ8FTj3NAF
	lrkygigenzWBgpp1vZmRd5tTYzr4t2+nDq3g=
X-Google-Smtp-Source: AGHT+IGWJbCBhztTVmd7cwokjocgGM90CqXAfMEUTus4zvpVxidmHRlC8OnM+wteG2mcHiOA8FYJpA==
X-Received: by 2002:a05:6a00:3e04:b0:76e:2eff:7ae9 with SMTP id d2e1a72fcca58-7723e276de4mr11916438b3a.12.1756791612472;
        Mon, 01 Sep 2025 22:40:12 -0700 (PDT)
Received: from localhost ([122.172.87.165])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7726475290esm3157523b3a.98.2025.09.01.22.40.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Sep 2025 22:40:11 -0700 (PDT)
Date: Tue, 2 Sep 2025 11:10:09 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Zihuan Zhang <zhangzihuan@kylinos.cn>
Cc: "Rafael J . wysocki" <rafael@kernel.org>,
	zhenglifeng <zhenglifeng1@huawei.com>, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 2/3] cpufreq: sh: drop redundant freq_table argument
Message-ID: <20250902054009.rhqu4ki3bl4kr5a7@vireshk-i7>
References: <20250901112551.35534-1-zhangzihuan@kylinos.cn>
 <20250901112551.35534-3-zhangzihuan@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250901112551.35534-3-zhangzihuan@kylinos.cn>

On 01-09-25, 19:25, Zihuan Zhang wrote:
> Previously, some cpufreq core helper functions accepted a separate
> 'freq_table' argument even though the frequency table is now stored
> inside struct cpufreq_policy.
> 
> This patch updates all cpufreq core calls to remove the redundant
> argument and use policy directly.
> 
> Signed-off-by: Zihuan Zhang <zhangzihuan@kylinos.cn>
> ---
>  drivers/cpufreq/sh-cpufreq.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/cpufreq/sh-cpufreq.c b/drivers/cpufreq/sh-cpufreq.c
> index 9c0b01e00508..75d224ba56ba 100644
> --- a/drivers/cpufreq/sh-cpufreq.c
> +++ b/drivers/cpufreq/sh-cpufreq.c
> @@ -93,7 +93,7 @@ static int sh_cpufreq_verify(struct cpufreq_policy_data *policy)
>  
>  	freq_table = cpuclk->nr_freqs ? cpuclk->freq_table : NULL;
>  	if (freq_table)

Instead of above, you can now simply check if policy->freq_table is
valid or not.

> -		return cpufreq_frequency_table_verify(policy, freq_table);
> +		return cpufreq_frequency_table_verify(policy);
>  
>  	cpufreq_verify_within_cpu_limits(policy);
>  
> -- 
> 2.25.1

-- 
viresh

