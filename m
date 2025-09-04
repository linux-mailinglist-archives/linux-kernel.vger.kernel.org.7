Return-Path: <linux-kernel+bounces-799909-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A24F3B43148
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 06:46:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 874314E133F
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 04:46:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15A091BC3F;
	Thu,  4 Sep 2025 04:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QZhjqnqg"
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7C7E2C1A2
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 04:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756961162; cv=none; b=VuaBE4RthEtSZLla7SAbfNsvP6RXqG/NyJcI5h8IObInAAZrSkOyuiZGCp4aOOelKKuTy9E2HbQJWNwXgQ9Jdr1rckuAs+qqg3ae33vDTCNlnPC6git09sJUhZo7LumC6ZrCwgJ3+5FEoXeFfeZmbMwzva+MVUaDgZEyPBorbfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756961162; c=relaxed/simple;
	bh=fV2Tk+cAJFMvm725WpVa4ywZ3SnH9lOf9TlnxGHH9qQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cRAj3af6J5ArvIfvE4gzBSF4IrZbGOgMUGwDUEV0ydRkgUFC9lG0KF5V/Q0QijfyEJzlHhjhN8OedbZb1Sj+pFq0vi9ci0byQiWX4LInp5B9pQDDieUghqjNVtktUhZMVfiFjkpBJMsrbk7IvzNrU27zOR6zMDitwdu8r0n+nAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=QZhjqnqg; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-b4c72885c8bso506702a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 21:46:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756961160; x=1757565960; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yVwtOioJ6QQmoqBdgt4Ax8qFgErbBnqWc/akKz/RHWs=;
        b=QZhjqnqg8OCUeubSWDzUjhwUjZvoCAckzWIYec079n8cjwdNniWAxFYIHZo8FmBe1m
         QeYRasz+X9TOP2yRqmH25NCwVmOL44nBUVPmk6TpbMzC9Q27wdund6CSjhowjjAKXENc
         VTz/vPSaZr9qP0rkvikQS6lOVLY998wJUIDlSPwD6ctQytUU8EqqGCK8RO2EyycPsGHz
         2PMfpZutMMd/BX6UYyuz9HbF3ulqulkdX8Z+BY3WkmQVWagmOaOUOFSO76klMUoASR4n
         ug4bpMjSwlNMYc1zgtuh+sb28ubJocgUop0YqGdEZCs3n1kmdEorP2MF0o7fLdrmWce9
         S99w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756961160; x=1757565960;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yVwtOioJ6QQmoqBdgt4Ax8qFgErbBnqWc/akKz/RHWs=;
        b=Te3L0cpYAah9n8w/UMbvuWir35OsdrjMiX1iUTFEbFg94wpA5nZIzd02vNXRj08kVC
         Z0T4XoRnCWNEVsTgieZLJXOf/ukxR3IWvJ7L6OzSpeFxFUXhMvBE8cBz48/HWvSTA+lL
         qIGORmhNQIqE+CtYdLS+9F94zXSMSi0HLVXuEXxK/JfQJG7WYtDL/dnlGcXlnivjfNft
         IqPCkKAIDS5+CtU3LGd1NpgQjz3BbxOfw2pFPsQBhjjfi9oTn9yX79NBaz4h7ly05V1b
         sYDWZDL0Y7r+psCKO0DbVGRbYmu7NWxBv10t8PXQhnLNolPfo+dfqgEIByZ7aakQjAgy
         oE7g==
X-Forwarded-Encrypted: i=1; AJvYcCVs9WviQEE2eoibF7DC4DYBIli5L86Kpsd0g+GEON5J1Y5DQme1IHq927RfDvMCBBzCeLuTaz0lp4osi78=@vger.kernel.org
X-Gm-Message-State: AOJu0YyX1jm/ENs2qJXLeg7OgstDBVBVrw1SXitJr4vlg58tT7ICHvVo
	VFnG2d0B5w2zOZppnxgoIkTs0YMZyMTHcXfpspjJGbZ8+qj3n4U+j/ZR5jMbJKtSRV8=
X-Gm-Gg: ASbGncs6C92xOTH3/j4F/nnbN+nNYBfhawTn922tHOJJiBhed+vQcIFBPJFieJtuQ3y
	VyEQvYPmKOeYWWmvx6j0XfYIiBT+dNLvhj5hEYugHi4lhWgWj3cEkqUDorPq3TuGzx3VP/MKKk3
	XJ9qC/bOiF6YpJXf97JS2GBKzMRsiv+PuMcB0O/isWcBeUrHgi0ZG/mU5Sm262k3brYL4oUltMa
	BuQ1eGIXAP+/Vjd5cxXpVQKqcYY3TzzjR8gQ4otouOUiS4FsDIVnKfX27CJhEWX/AD2ZB2AX/ag
	AGyIEwV4coHBpkle7/g+jVKcg0VIkxYVsZCu8DWEwwHS6y45BrRRzN3HTdPVrVwEOdeDA3po7N0
	XGjPWSI8lsVkso4bKb6CccFyX
X-Google-Smtp-Source: AGHT+IHWGXeH6oTQDDhuBdIP3fhF+mpaRH7oxjZ7f709N/WQgz/IqaZIzWCaAXXOXynM2TWc33SOuw==
X-Received: by 2002:a17:902:f543:b0:24a:ea31:b523 with SMTP id d9443c01a7336-24aea31ba6bmr163168215ad.49.1756961160175;
        Wed, 03 Sep 2025 21:46:00 -0700 (PDT)
Received: from localhost ([122.172.87.183])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24caffd7beesm18391575ad.121.2025.09.03.21.45.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Sep 2025 21:45:59 -0700 (PDT)
Date: Thu, 4 Sep 2025 10:15:57 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Zihuan Zhang <zhangzihuan@kylinos.cn>
Cc: "Rafael J . wysocki" <rafael@kernel.org>,
	Saravana Kannan <saravanak@google.com>,
	zhenglifeng <zhenglifeng1@huawei.com>, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 3/3] cpufreq: Make cpufreq_frequency_table_verify()
 internal
Message-ID: <20250904044557.tde36hekoeuhnsci@vireshk-i7>
References: <20250904032210.92978-1-zhangzihuan@kylinos.cn>
 <20250904032210.92978-4-zhangzihuan@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250904032210.92978-4-zhangzihuan@kylinos.cn>

On 04-09-25, 11:22, Zihuan Zhang wrote:
> diff --git a/drivers/cpufreq/sh-cpufreq.c b/drivers/cpufreq/sh-cpufreq.c
> index 642ddb9ea217..ee3fd1e71b90 100644
> --- a/drivers/cpufreq/sh-cpufreq.c
> +++ b/drivers/cpufreq/sh-cpufreq.c
> @@ -90,10 +90,8 @@ static int sh_cpufreq_verify(struct cpufreq_policy_data *policy)
>  {
>  	struct clk *cpuclk = &per_cpu(sh_cpuclk, policy->cpu);
>  
> -	if (policy->freq_table)
> -		return cpufreq_frequency_table_verify(policy);
> -
> -	cpufreq_verify_within_cpu_limits(policy);
> +	if (!cpufreq_generic_frequency_table_verify(policy))
> +		return 0;
>  
>  	policy->min = (clk_round_rate(cpuclk, 1) + 500) / 1000;
>  	policy->max = (clk_round_rate(cpuclk, ~0UL) + 500) / 1000;
> diff --git a/drivers/cpufreq/virtual-cpufreq.c b/drivers/cpufreq/virtual-cpufreq.c
> index 6ffa16d239b2..2498f40cd57e 100644
> --- a/drivers/cpufreq/virtual-cpufreq.c
> +++ b/drivers/cpufreq/virtual-cpufreq.c
> @@ -249,10 +249,7 @@ static int virt_cpufreq_offline(struct cpufreq_policy *policy)
>  
>  static int virt_cpufreq_verify_policy(struct cpufreq_policy_data *policy)
>  {
> -	if (policy->freq_table)
> -		return cpufreq_frequency_table_verify(policy);
> -
> -	cpufreq_verify_within_cpu_limits(policy);
> +	cpufreq_generic_frequency_table_verify(policy);
>  	return 0;
>  }

You ended up changing the logic of both these files and it isn't the
same anymore. Earlier if freq_table was there and
cpufreq_frequency_table_verify() failed, we used to return, but not
anymore.

And we don't return the error anymore for virtual driver.

-- 
viresh

