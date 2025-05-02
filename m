Return-Path: <linux-kernel+bounces-629263-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A9DBAA6A0A
	for <lists+linux-kernel@lfdr.de>; Fri,  2 May 2025 07:06:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E34994A1157
	for <lists+linux-kernel@lfdr.de>; Fri,  2 May 2025 05:06:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76BB41A5B9D;
	Fri,  2 May 2025 05:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YSnf0PGN"
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16F1519DF5B
	for <linux-kernel@vger.kernel.org>; Fri,  2 May 2025 05:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746162404; cv=none; b=jVQ1oHk2E85wVdTg5sGEYjTrVEtfsyr8S1Me/n2niOIQH54N3sUJ90T8JYCviOvIvCc5ZxW62RCJb+OIYsrkjzGOzZzhBP+1N65IQKQrv8J5p85CieZf8nyBDPX47vWa5sPL46af/KLCEKGn0PaszIULVLCBv4YqZyxKKJB9Z+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746162404; c=relaxed/simple;
	bh=9ZiB3IL38HWldjWT5LqovTTFiCQgbLC+OMOMx6NpS40=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rup5yUx+iOQ5Uea/KpuaY6hYv6e9rHA5dAduU6YKgTXkvHEvXLMFr9wY1sS2n/1i04m9iK0NDG1UDYYvbEqA4/2J3nEzGU2NY1XTSMJxSWvrrNYohTwpmDxre3jU06JAtBLhpW5MeYWGPzpZYMCErU8cCJjml7KaC3IT73TQNIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=YSnf0PGN; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-73972a54919so1660549b3a.3
        for <linux-kernel@vger.kernel.org>; Thu, 01 May 2025 22:06:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1746162402; x=1746767202; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/grUUpAeYIKlzRvakzNU+F1AJvJq3WlXjsn/sgH48DI=;
        b=YSnf0PGNskAGFezRtFrPbvSdT93W/5CaykNQb64PKloeleNxW/MAp0CnGQFlvD7khb
         v2+sKSEiYlO1iM5243Ip5BrD14k4BlbSRCR3nMjPo2uXnoUMxh427H0Z00KxfzKc8U1c
         RTNS8dTNoXTZ9UYFpyVZLYVl21JncgF1la47axq0k/ACy42BofqurmaY3aTMDnWm8K0D
         JJYbfBBF6oclNPzyWBVcL5w6ccU/Zg1n8XA+YOLAxnaSZ8lzBmf9cp4wOH+eXBlJhQtp
         bmPGuFPYq+KMlDCP5XneBGSfiR0CMDyvLqZpf3j20cKIHT+oilvszb5r0ZRrSMsMSZsS
         A5eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746162402; x=1746767202;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/grUUpAeYIKlzRvakzNU+F1AJvJq3WlXjsn/sgH48DI=;
        b=mJqSfTPPvd0UOTmoPTpUxmhcr+qcrLY4XLmH5rf8vu7os+IsA7t8gfvNXD7DKcc78U
         QAW84En6PJtOlOn9W0d2GReAQqAJGdG4djSIO7oFa4kav2AsKXvE7+1n2O1xqoCy0lGT
         237BKInzHhwFo0Ts3QoHTdUHYwzPRorZHHT7FDlE2oFoS23zTqoMLa+7z52F/BOw3KPU
         xjNbFupF+Ly1JkAKn0Jt7kOPbTDc7LrNOyRBbOb7NWmJg6XcDhcXeHXjgt4rOHChMXMS
         G+azEkGlgk2plKlv0w0I8x3W2skXWzeXUHqstBZ2EbrRBtvewBJ4sGiQnYowgxnBhV9q
         q8XA==
X-Forwarded-Encrypted: i=1; AJvYcCXhyAnxQNEbcaPWtJ01L4cxiSf8p83SqsuUK0/0liRVzb9CFY3H+ZfJzKEW7fCon1KeTGFUQvCmIHznNac=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0u4kOAQm57XoQPhsfR3MuQUBPH9D+r+VHGnVPwMb814meO/yR
	+rxeCEKzB/Bk7zbQXu7uvl4IeT2SQ20eOkVPv65CihtoQroVP8Y47SlnPPZc/0s=
X-Gm-Gg: ASbGncsi9To5RFsX2zrsq+GtWmVOGk32myfFBEeQpdbDji+LtQfrp/muUtfv1PMLraE
	D2HKItmVQhC6EwNi8TJtirzzdEUw9NekPVwG8/NnPDIRkRebFRjZdLA/lNr4ZdXlR/I5KMkUp2l
	ldW4S9jG7irjSBsXvoTA/yDYbtTMtXR/UTVfzeRNhAMp3dwaocJEwW9aRUrx7POk2WLSPlc8kpo
	pqOeGK8YsymWEUr4XMBlXDnoUYN9QF5cnZmCw/UR+jCZp7qSBi6IyvAI9xGUlWlfcVUWdaa3E6a
	6HM/ys5dCtkLtORkTNngBtHGLdYMiW4GktZ7/b8hqQ==
X-Google-Smtp-Source: AGHT+IEOJiAVSKAjJMccaJnGL2AgSp42k41Qardkh/MDnhjWK4eld/C+RTrDT33wzYWavJoELEolJw==
X-Received: by 2002:a05:6a21:3514:b0:1f5:a577:dd24 with SMTP id adf61e73a8af0-20cdee3f3dcmr2337675637.25.1746162402149;
        Thu, 01 May 2025 22:06:42 -0700 (PDT)
Received: from localhost ([122.172.83.32])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b1fa85e4e27sm537304a12.60.2025.05.01.22.06.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 May 2025 22:06:41 -0700 (PDT)
Date: Fri, 2 May 2025 10:36:39 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Seyediman Seyedarab <imandevel@gmail.com>
Cc: rafael@kernel.org, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, skhan@linuxfoundation.org,
	linux-kernel-mentees@lists.linux.dev
Subject: Re: [PATCH v3] cpufreq: fix locking order in store_local_boost to
 prevent deadlock
Message-ID: <20250502050639.2a4mbdav4mdlhbp2@vireshk-i7>
References: <20250430160943.2836-1-ImanDevel@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250430160943.2836-1-ImanDevel@gmail.com>

On 30-04-25, 12:09, Seyediman Seyedarab wrote:
> Lockdep reports a possible circular locking dependency[1] when
> writing to /sys/devices/system/cpu/cpufreq/policyN/boost,
> triggered by power-profiles-daemon at boot.
> 
> store_local_boost() used to acquire cpu_hotplug_lock *after*
> the policy lock had already been taken by the store() handler.
> However, the expected locking hierarchy is to acquire
> cpu_hotplug_lock before the policy guard. This inverted lock order
> creates a *theoretical* deadlock possibility.
> 
> Acquire cpu_hotplug_lock in the store() handler *only* for the
> local_boost attribute, before entering the policy guard block,
> and remove the cpus_read_lock/unlock() calls from store_local_boost().
> Also switch from guard() to scoped_guard() to allow explicitly wrapping
> the policy guard inside the cpu_hotplug_lock critical section.
> 
>  [1]
>  ======================================================
>  WARNING: possible circular locking dependency detected
>  6.15.0-rc4-debug #28 Not tainted
>  ------------------------------------------------------
>  power-profiles-/596 is trying to acquire lock:
>  ffffffffb147e910 (cpu_hotplug_lock){++++}-{0:0}, at: store_local_boost+0x6a/0xd0
> 
>  but task is already holding lock:
>  ffff9eaa48377b80 (&policy->rwsem){++++}-{4:4}, at: store+0x37/0x90
> 
>  which lock already depends on the new lock.
> 
>  the existing dependency chain (in reverse order) is:
> 
>  -> #2 (&policy->rwsem){++++}-{4:4}:
>         down_write+0x29/0xb0
>         cpufreq_online+0x841/0xa00
>         cpufreq_add_dev+0x71/0x80
>         subsys_interface_register+0x14b/0x170
>         cpufreq_register_driver+0x154/0x250
>         amd_pstate_register_driver+0x36/0x70
>         amd_pstate_init+0x1e7/0x270
>         do_one_initcall+0x67/0x2c0
>         kernel_init_freeable+0x230/0x270
>         kernel_init+0x15/0x130
>         ret_from_fork+0x2c/0x50
>         ret_from_fork_asm+0x11/0x20
> 
>  -> #1 (subsys mutex#3){+.+.}-{4:4}:
>         __mutex_lock+0xc2/0x930
>         subsys_interface_register+0x83/0x170
>         cpufreq_register_driver+0x154/0x250
>         amd_pstate_register_driver+0x36/0x70
>         amd_pstate_init+0x1e7/0x270
>         do_one_initcall+0x67/0x2c0
>         kernel_init_freeable+0x230/0x270
>         kernel_init+0x15/0x130
>         ret_from_fork+0x2c/0x50
>         ret_from_fork_asm+0x11/0x20
> 
>  -> #0 (cpu_hotplug_lock){++++}-{0:0}:
>         __lock_acquire+0x1087/0x17e0
>         lock_acquire.part.0+0x66/0x1b0
>         cpus_read_lock+0x2a/0xc0
>         store_local_boost+0x6a/0xd0
>         store+0x50/0x90
>         kernfs_fop_write_iter+0x135/0x200
>         vfs_write+0x2ab/0x540
>         ksys_write+0x6c/0xe0
>         do_syscall_64+0xbb/0x1d0
>         entry_SYSCALL_64_after_hwframe+0x56/0x5e
> 
> Signed-off-by: Seyediman Seyedarab <ImanDevel@gmail.com>
> ---
> Changes in v3:
>  - Rebased over PM tree's linux-next branch
>  - Added a comment to explain why this piece of code is required
>  - Switched from guard() to scoped_guard() to allow explicitly wrapping
>    the policy guard inside the cpu_hotplug_lock critical section.
> 
> Changes in v2:
>  - Restrict cpu_hotplug_lock acquisition to only
>    the local_boost attribute in store() handler.
> 
> Regards,
> Seyediman
> 
>  drivers/cpufreq/cpufreq.c | 23 ++++++++++++++++-------
>  1 file changed, 16 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index 21fa733a2..b349adbeb 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -622,10 +622,7 @@ static ssize_t store_local_boost(struct cpufreq_policy *policy,
>  	if (!policy->boost_supported)
>  		return -EINVAL;
>  
> -	cpus_read_lock();
>  	ret = policy_set_boost(policy, enable);
> -	cpus_read_unlock();
> -
>  	if (!ret)
>  		return count;
>  
> @@ -1006,16 +1003,28 @@ static ssize_t store(struct kobject *kobj, struct attribute *attr,
>  {
>  	struct cpufreq_policy *policy = to_policy(kobj);
>  	struct freq_attr *fattr = to_attr(attr);
> +	int ret = -EBUSY;
>  
>  	if (!fattr->store)
>  		return -EIO;
>  
> -	guard(cpufreq_policy_write)(policy);
> +	/*
> +	 * store_local_boost() requires cpu_hotplug_lock to be held, and must be
> +	 * called with that lock acquired *before* taking policy->rwsem to avoid
> +	 * lock ordering violations.
> +	 */
> +	if (fattr == &local_boost)
> +		cpus_read_lock();
>  
> -	if (likely(!policy_is_inactive(policy)))
> -		return fattr->store(policy, buf, count);
> +	scoped_guard(cpufreq_policy_write, policy) {
> +		if (likely(!policy_is_inactive(policy)))
> +			ret = fattr->store(policy, buf, count);
> +	}
>  
> -	return -EBUSY;
> +	if (fattr == &local_boost)
> +		cpus_read_unlock();
> +
> +	return ret;
>  }

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh

