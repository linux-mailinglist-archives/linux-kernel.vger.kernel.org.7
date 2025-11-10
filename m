Return-Path: <linux-kernel+bounces-892906-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D6646C46145
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 11:56:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C5CFC4E9B57
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 10:56:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7689E211A14;
	Mon, 10 Nov 2025 10:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gKaBLUd8"
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55B76306B00
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 10:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762772181; cv=none; b=YCWvOFCByrc4y1rF3wrwbQIsjLmDd8wEvlBGW6wIRwNoQasFKkejQE8LzGaLxz6spWvmrqjmiZcZq/AnXZHsfXxYPG8uJCPbNq+Jo/rwhyMGlW1TrF+iklyJ+TjIPuGpe6cWdPfFaVD2+tLdiY2BSZJ9xnbL97ygUnRYwvrxR+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762772181; c=relaxed/simple;
	bh=dEl+crxWx0Ue6Eap9IyJQOsh+WWdfuIJZKBgNUUOskU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bK4nsf/JCJ92yZ/jFM1AO29DqaH4Ku5BKGkCUegl5r5e/KJU0I45lbO5szCc4KpesprAT/MhYDQJtBzJYQyaxLqnZI7UBh1enCJk5z093RegeG6VIPeqoOo2qklkYUx9X8xvi8ex9ljSjz2JaeuI8oS3B/nvdepO/YXY5n468sw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=gKaBLUd8; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-b679450ecb6so2258518a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 02:56:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1762772178; x=1763376978; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HOTgQEUB8GcmpUQcmIkml8fFvXO2yWgEKzXQF7vCTcc=;
        b=gKaBLUd8yrvPVoLyJ80CXi/2i4l/MtEV6mMzBU+Z3JHKX6VOOOfpEhRPfPP8aXEGG2
         TUcf/VMxLyuXljSA+kw8vdEhmUvbjSYf6E7jMeKqHx+HRb9kL7LhIry6g0WMkUFe7x4+
         kRUdnLOR+EjcklQaG5iJ/fCBbmUbZLJy96sQZDrHS/cmCJPfPqJNlZzyt/ytOGIoMISw
         1Lir7UTb14vlK3asD6EnW+PeZmBiZiCNKY6gjsxcrEaX9B6kFcukVIMxH4TqeKLqjyuQ
         uEZNNfA9wkKrK0oKfqqA6g5mOeLXvfHGWgIxeSkkg/qkB+A6ExHOdwDy9v/KaL3/AnNo
         eoUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762772178; x=1763376978;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HOTgQEUB8GcmpUQcmIkml8fFvXO2yWgEKzXQF7vCTcc=;
        b=nbF4XoqnkUekUx893lmqMnzdXMhO7y3mNXLz/mmsfYR7fcuXS3QQBKwp2G30cOAvei
         V2QzvD/OOsUmeEXJoA6WEsbr4JTlR20ItnAi9AuKgq+SEVuSBZkorxWR2e47oKriidMr
         CzuhYVurU4sjdmbIVXqyTolX3pkCpMwFk8UREmQjuNCmFU82w1oBqUWO3L9Li2fDx+1x
         wK/5h5G9xM4Xfm+pZv6pBd5QmK9hkxRztIy5OOfeJtDvCy/CzDPGsUjkANZe6JfILt1r
         BWDX9KZIZ1XP6XKQfBLFYI2V+ANyIb5MyKXvhiqUc6xoYln8Bf7pk/SlmQtqYjOYNh6f
         eD/g==
X-Forwarded-Encrypted: i=1; AJvYcCW3hkWZBTXFGjmbiW3FpJGwT4Gnm78CQT//wZttV6YFgj5f5CvfKobInJZnXFxeGoAJQzQ9DpqSE02B/A0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwM4RzS0yEhV/UaCB2Ul0po7aHozJDFJCUmLIKnjRg2a3smq+hd
	8ERylWwe1i96SKBg7Wz57izSZnY+pStmp7Quoy7Igp99geWcvxVKFOX5AgKQa/k4ieo=
X-Gm-Gg: ASbGnct9Q0CWhZx/wsrAPhroiTuPXCaaS+g4dczlHgaK6ua46Yr0eMv328/CpunpGnl
	aDKzu3n9jSx/uQV1KHuOd3mMHs8O1kPdWuhzGalhQcxlITUjwv8MdFN3i8U4dRqkc9kayCcfpHK
	8udUaiaau9W15ZXc6xwNRZNgUwSQyzJdGUix3t0B0NsCSacxnb2gxWyn0qQMon5q1hNdnQj3NbC
	axiwvoUAVMzDPP7nvcYVdqtc83V1nPTeMrmV5x2luLTtleGdQEsqMspIzZXS2dG+UISDA2/TTu8
	Wnl8k3kzhmi9mK/q23MisZO20nY5E/BwzUNqfAwiowjdEXNa1xV9/l8ALgngFuNhDUTIQ53LyL5
	gtDlYmKVjRZV+PyzNGTrUYjMt0fMlTt3KMKB1PGrkbvv4uhmPRtBjrTUslQCUBYZZpIXX/dY6rA
	aqN9xuJTeCJBk=
X-Google-Smtp-Source: AGHT+IELCZjjS9db2GOOi5gG1D3fReIWK6Fsulo/YaMjMnn+TlgjP5Y2DF6HQCR7hzQBYtF9UG4Urg==
X-Received: by 2002:a17:902:d551:b0:27e:ec72:f6d with SMTP id d9443c01a7336-297e53e7af3mr99902655ad.11.1762772178225;
        Mon, 10 Nov 2025 02:56:18 -0800 (PST)
Received: from localhost ([122.172.86.94])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-297fe688c96sm49938925ad.58.2025.11.10.02.56.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Nov 2025 02:56:17 -0800 (PST)
Date: Mon, 10 Nov 2025 16:26:15 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Sumit Gupta <sumitg@nvidia.com>
Cc: rafael@kernel.org, lenb@kernel.org, robert.moore@intel.com, 
	corbet@lwn.net, pierre.gondois@arm.com, zhenglifeng1@huawei.com, 
	rdunlap@infradead.org, ray.huang@amd.com, gautham.shenoy@amd.com, 
	mario.limonciello@amd.com, perry.yuan@amd.com, ionela.voinescu@arm.com, 
	zhanjie9@hisilicon.com, linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org, 
	linux-doc@vger.kernel.org, acpica-devel@lists.linux.dev, linux-kernel@vger.kernel.org, 
	linux-tegra@vger.kernel.org, treding@nvidia.com, jonathanh@nvidia.com, vsethi@nvidia.com, 
	ksitaraman@nvidia.com, sanjayc@nvidia.com, nhartman@nvidia.com, bbasu@nvidia.com
Subject: Re: [PATCH v4 1/8] cpufreq: CPPC: Add generic helpers for sysfs
 show/store
Message-ID: <s5xt53i6c5wryje5x6zlq75r3lx6nxb7pat6umnghpnldi4p2h@jaeew4iimdd3>
References: <20251105113844.4086250-1-sumitg@nvidia.com>
 <20251105113844.4086250-2-sumitg@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251105113844.4086250-2-sumitg@nvidia.com>

On 05-11-25, 17:08, Sumit Gupta wrote:
> diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
> -static ssize_t show_auto_act_window(struct cpufreq_policy *policy, char *buf)
> +static ssize_t cppc_cpufreq_sysfs_show_u64(unsigned int cpu, int (*get_func)(int, u64 *), char *buf)
>  {
>  	u64 val;
> -	int ret;
> -
> -	ret = cppc_get_auto_act_window(policy->cpu, &val);
> +	int ret = get_func(cpu, &val);

Why no casting required here, when you need it ... 

> -static ssize_t store_auto_act_window(struct cpufreq_policy *policy,
> -				     const char *buf, size_t count)
> +static ssize_t cppc_cpufreq_sysfs_store_u64(unsigned int cpu, int (*set_func)(int, u64),
> +					    const char *buf, size_t count)
>  {
> -	u64 usec;
> +	u64 val;
>  	int ret;
>  
> -	ret = kstrtou64(buf, 0, &usec);
> +	ret = kstrtou64(buf, 0, &val);
>  	if (ret)
>  		return ret;
>  
> -	ret = cppc_set_auto_act_window(policy->cpu, usec);
> -	if (ret)
> -		return ret;
> +	ret = set_func((int)cpu, val);

... here ?

-- 
viresh

