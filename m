Return-Path: <linux-kernel+bounces-799933-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 72868B43163
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 06:51:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9286816C4AA
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 04:51:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 712E4244685;
	Thu,  4 Sep 2025 04:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Vc0qXbbq"
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DEEE226CFF
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 04:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756961298; cv=none; b=YaFx2PCRVNUhe5n9G5SlnfadEdYziMAptpllHXQ1ZQK2x1jROOhEWlWNN9Ck0obuzxn1SRRrEWRmgnb8TMFfAWlreOk5moUTtwqFs3zlr9BhvHvOOhnzPhS3RxfJtK2nw+h65/GozW4fV28et2koD8Yj86Yl5HGtqVYo4J1fRfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756961298; c=relaxed/simple;
	bh=5gGSzTrvBBYF22J+UUhj6V0Z7NBjpjQbuN932TPUw/M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QysS133bDzGq0gk12HelFSu3HjutdNbxjfNT03jyAfsHGqnQXTH9Ot+aWYUYgFjuUbHGaWbbnP83qiCSenxo9k8zl4CDKNDA6RSGSTN5DEYCOXdl3yaSWLqh2LjSDc/9CFqpx0hYIvLPLexL1K1mSaeX1eKcnZfrdfTPTWUh6Qw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Vc0qXbbq; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-77287fb79d3so604233b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 21:48:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756961296; x=1757566096; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=F0p1lwqdDVIJVajGYr/mU8WzHwecynjQcLCSTh1yP2k=;
        b=Vc0qXbbqg4iG4etZL+d2nLUyI/JMQTR2wHfnmHPMYK1Yu07ywvR2LUjgyNJ2yVQhVH
         YYKpymhfzY/1WiW3iWlbOBkM3I1kQLCwuikqyubfHfb98AoLnTwwD4N1d4qz3QhuxJcT
         RuaJfp8dvymvCHI6ikMZjC7yZLcNPp6lRJUky6XnDt+M7AgUaRweoohjMqboLU8YTbDD
         u+C3bMvo7fZqSLjJH+IPrETS3Gd5++Optu7ni1zUjU5VYvvectwlHqk9iFSJ/KLxt5u3
         ixZx/KxkcyePdPYOQvOlJZ9ikQWI6pO/dDW+Jaf9Kqmt4+WLdMzcG9xnQVeFBSHLwV3n
         cDhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756961296; x=1757566096;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=F0p1lwqdDVIJVajGYr/mU8WzHwecynjQcLCSTh1yP2k=;
        b=VB0SXRV8kGWzQ72NnWUm6RgA69c5dnMGXNNolcG2mvccTR6Yq8ROEt+V78fw3Pg1Sx
         ZI2tdxKWyQ2A+Kwrfo8siBC1htMLI0Xf8UNE/Sf2+56NNIne+/BY6xiun+SQN4MR0DvR
         x/mYeql9JeO8M3TLRs21dwN5Er48OBGrI2WDdkLyRbahmHVGEE91t6aVQagrLCFHaUs0
         fiNk/hqkje6alF3wHq7Q1bpi22NGOKy8ZGuEPJEmnx1ut3pfA1y+1RzDWItCKEuV2+ml
         SOAvc8wqshGcfYPhS1r96YctMHEe02mzHKAxSOpBQzFurqUYpzXYMlXk7B5w0Q9jmjUE
         y5sw==
X-Forwarded-Encrypted: i=1; AJvYcCXf5VmyNcxhAuM87ukC7z2P1RQlizSb3MjuSogbn+fARLtpqxbDBeuYu8VAnoFt+Zks1bopN6aMo8SuUuQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzftraJk7Zkc+R7N5JDg+4V6FjP2ZhhoYasGnD7375nxwgqHpV+
	9As3yCSLmsYfTP/6RV7Y6b7bKQCwmCuAkiRllBEbVKm3lxckhsv/FvkOQnyyXXMMMyo=
X-Gm-Gg: ASbGncsm0oN9wsyfIxASUd5HdhwAiEXFbxyfK+kfx19/Bp3l2CedTIjHX8gMe2B500n
	TneRDAt1PMRL/1kUlFxO/7QuB8CdL/1ycjin0U+ny8I3otRCta//uIGXgkCqejT6iT4artk9h5Y
	dQ99mnF8wumXc5oHuwIwzNNdqLPTzDk5vlXjA9DcYK6xN6LbnEadrQQRNUIHfbLPRFlQF4uYXYK
	H0yqCWNlhNAPDn+IXhHVZxNuxRA2KwOV7zElD/B7vPTsJ4apSLAhfBZOi5yPZkVHYvIdA1IfXLO
	go7okjDkanWTTGZdeYx8gzP4J8J0NHKzAixh6ZPLKcRXMBh4HL20AvTdD4NhBihImk0ORgaDKDP
	WfYw0no/2XKeZ1H5EqUFRfbacZLI/07A/8uE=
X-Google-Smtp-Source: AGHT+IFBkCuheM4gA9HcZq48WmM/cf+Qe1YyWVvICeZp8J+0dhqzifPOHeuJCWtafRAvrmuY9BL5ow==
X-Received: by 2002:a05:6a21:33a9:b0:247:76e4:d8e0 with SMTP id adf61e73a8af0-24776e4d9dfmr6750375637.31.1756961295905;
        Wed, 03 Sep 2025 21:48:15 -0700 (PDT)
Received: from localhost ([122.172.87.183])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3276fcd48cesm24273848a91.19.2025.09.03.21.48.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Sep 2025 21:48:15 -0700 (PDT)
Date: Thu, 4 Sep 2025 10:18:12 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Zihuan Zhang <zhangzihuan@kylinos.cn>
Cc: "Rafael J . wysocki" <rafael@kernel.org>,
	Saravana Kannan <saravanak@google.com>,
	zhenglifeng <zhenglifeng1@huawei.com>, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 2/3] cpufreq: Always enforce policy limits even
 without frequency table
Message-ID: <20250904044812.cpadajrtz3mrz2ke@vireshk-i7>
References: <20250904032210.92978-1-zhangzihuan@kylinos.cn>
 <20250904032210.92978-3-zhangzihuan@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250904032210.92978-3-zhangzihuan@kylinos.cn>

On 04-09-25, 11:22, Zihuan Zhang wrote:
> Currently, cpufreq_frequency_table_verify() simply returns when the driver’s
> frequency table is missing (policy->freq_table == NULL).
> This means that cpufreq_verify_within_cpu_limits() is not invoked in such
> cases, leaving policy->min and policy->max unchecked.
> 
> Some cpufreq drivers handle this manually by calling
> cpufreq_verify_within_cpu_limits() even when no frequency table is present,
> in order to ensure the policy stays within CPU limits.
> 
> To avoid this inconsistency and potential misuse, make
> cpufreq_generic_frequency_table_verify() always call
> cpufreq_verify_within_cpu_limits(), regardless of whether policy->freq_table
> is available. This unifies the behavior across all drivers and makes the helper
> safe to use universally.
> 
> Signed-off-by: Zihuan Zhang <zhangzihuan@kylinos.cn>
> ---
>  drivers/cpufreq/freq_table.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/cpufreq/freq_table.c b/drivers/cpufreq/freq_table.c
> index d5111ee56e38..f4b05dcc479b 100644
> --- a/drivers/cpufreq/freq_table.c
> +++ b/drivers/cpufreq/freq_table.c
> @@ -105,6 +105,7 @@ EXPORT_SYMBOL_GPL(cpufreq_frequency_table_verify);
>   */
>  int cpufreq_generic_frequency_table_verify(struct cpufreq_policy_data *policy)
>  {
> +	cpufreq_verify_within_cpu_limits(policy);

So if we have a freq-table, we will call this twice now. Why make it
bad for the existing users ?

And then the name of this function, it is all about freq-table. If it
isn't there, not sure we should call it at all.

>  	if (!policy->freq_table)
>  		return -ENODEV;
>  
> -- 
> 2.25.1

-- 
viresh

