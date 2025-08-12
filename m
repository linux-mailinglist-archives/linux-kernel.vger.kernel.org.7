Return-Path: <linux-kernel+bounces-765129-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BBACB22BE1
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 17:41:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5715650382B
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 15:41:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB5952F547D;
	Tue, 12 Aug 2025 15:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IzOmkirm"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C73E2F5334
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 15:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755013266; cv=none; b=n0XWOJQS0L8c9ncyx6eM2/Y94OPDw34TB2u9daf4HTESwERjj3rarKh1cpbqxt2x8dWKo+qqWFJJmKqVNAcb2fZKmmxUvmlIqRYbQEeLoHaaFknCbvo4/Kr7PSrtSPh5YbEHyauh9sPUoJpfRjSRx7XfUgTiTMdZNLeVEtN90hk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755013266; c=relaxed/simple;
	bh=XfT4KrpD7sbJH9JxkIQBTeVUz290LYCG73NkE1AA5oo=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:References:
	 In-Reply-To:Content-Type; b=GJdYnzFD0pnjDW98L5lq/0Fzfg1v9bBrvUiWrYfHHlgV50+IhmKwokLEouqL6/inPbvCObGaxzQRDL+5ITTwLF5POELA2q128oDtysiqPfg/ryRYChT7Ng9rTljduODHZzuo9iK9BLiteWlUaYdj5nje1O0p+jHpwCv+WN+pUPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IzOmkirm; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755013263;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pVv9SXDOciKXSvbtZJeNEeI2H4iQqx5hAVQRRYtVNzA=;
	b=IzOmkirmBl6FnVRutlQjH3XOOjmOqbDiRa2xC7RNyGGuoI+57Vu5rcft0o7oVLVjkwy49g
	mLPXeclqgSPoYk1N1iL0jiGhAZ9JxN1cvt+iZ5KJ6sLuTMyZFaQ8nXAND8SQD8+OSLt/HW
	7y5lKGAz5FSAtPcK9FNNCC2RW9BeBQU=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-240-19O_9aHvNpSQZB9IZwPi6g-1; Tue, 12 Aug 2025 11:41:02 -0400
X-MC-Unique: 19O_9aHvNpSQZB9IZwPi6g-1
X-Mimecast-MFC-AGG-ID: 19O_9aHvNpSQZB9IZwPi6g_1755013261
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-7e82b4ed799so981707285a.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 08:41:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755013261; x=1755618061;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pVv9SXDOciKXSvbtZJeNEeI2H4iQqx5hAVQRRYtVNzA=;
        b=j+2rtLpaZavjtgFABwYo180wYgUgSw5HEaWoGdLAegJoVMC6A8DNNHpPmSp08mT1xX
         Z1doL4c+noCBbMFcCpDEYD8CsISroGwjl7Ow89nwJ2sfW3SROoIBh2A+8oGYt8CA/1rs
         K/0zEzrz0kBeyuVQHaAsnQjXdMWCYAS0yZsOxjKiHzlGgFt0wLaK1DfQGlH/HXVkHgWr
         Y0BezCeAe9qXzUsVNJXepUpn5unLaYZsGHK3BA41Zk1wbc/ozdi2YbHh0SvAn0s+/Ej3
         bRaCL9MQ6hv8snG57OqaDmHdJ8jvyjSqs7pWM0CTosCGgdtRxX+aXWFI4oXXvaKVuwMz
         oJPg==
X-Forwarded-Encrypted: i=1; AJvYcCXZJ7wyQj7f9QYUH1kqyldTvN0z9U2VrJZKU9pHNaiqSqKRax8m+TY9BRPe8+yMjhbz1gIJBVA2yQxvcPM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPuxdmlduPgZEySB7vx7UTIeqCLQIhZGE2eTIvXUQwPE9a58H7
	wPbrgN6IVvkO5seVuXZnrlw3xI4MaDN68RgjeZAa8eQwA4t/92xUhNpcTjDZS8NA18JCmJoLyVg
	2DwoD6O7XD00CEehykTuyACo1wutorM3UCKP65Lh53uBfV4Z2F6p9HxKGmqZOb1kRUg==
X-Gm-Gg: ASbGnctztmurJvr/Hdwr2NJPkUC758p5OVcNdV8vd2ZDlyFg2oXX9W5Xp3chINtPJ+S
	dmrDxEgzbCt+qPX2C/zuaWkpPTkQlzquL5o524bYJknkVZBzNOWBxS84lWuxXHfrP5bXGhvJl3s
	C90HFARSw2WIU3VKyve87LecoFSmUNvKojRAObym49Nr1WFsdMzVvk4jQ0AxplpH8XJca6pJq9q
	Kw7udNidMyvrAD6IvKvYPTz2OBkqiu7uKS/3dblwfEBQj5v4E22I/hOqSBJDwsJdaWr35lN/U+P
	jPzq+8N+BjJpv5c3+Ch9mjCc25lImSAwAH2VMccY+VpgxsKZ2oy820KLBWPmDA9pzVJ006LFOCx
	wBneKclLzOQ==
X-Received: by 2002:a05:620a:a006:b0:7e6:50f2:d62d with SMTP id af79cd13be357-7e86448745amr17728185a.5.1755013260938;
        Tue, 12 Aug 2025 08:41:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE7z4j+vdPRh2bkTEyRIllC90u9eN3g2Dj5ZoMGd8E+0uXe+TuUpyziTo9yC2mUKLGOpuz+3g==
X-Received: by 2002:a05:620a:a006:b0:7e6:50f2:d62d with SMTP id af79cd13be357-7e86448745amr17724085a.5.1755013260060;
        Tue, 12 Aug 2025 08:41:00 -0700 (PDT)
Received: from ?IPV6:2601:188:c180:4250:ecbe:130d:668d:951d? ([2601:188:c180:4250:ecbe:130d:668d:951d])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7e80b9ed261sm1208145385a.53.2025.08.12.08.40.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Aug 2025 08:40:59 -0700 (PDT)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <16908a7d-2329-475f-b932-91ea5c9cc02e@redhat.com>
Date: Tue, 12 Aug 2025 11:40:58 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 7/8] cgroup/cpuset: Fail if isolated and nohz_full
 don't leave any housekeeping
To: Gabriele Monaco <gmonaco@redhat.com>, linux-kernel@vger.kernel.org,
 Anna-Maria Behnsen <anna-maria@linutronix.de>,
 Frederic Weisbecker <frederic@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>
References: <20250808160142.103852-1-gmonaco@redhat.com>
 <20250808160142.103852-8-gmonaco@redhat.com>
Content-Language: en-US
In-Reply-To: <20250808160142.103852-8-gmonaco@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/8/25 12:01 PM, Gabriele Monaco wrote:
> Currently the user can set up isolated cpus via cpuset and nohz_full in
> such a way that leaves no housekeeping CPU (i.e. no CPU that is neither
> domain isolated nor nohz full). This can be a problem for other
> subsystems (e.g. the timer wheel imgration).
>
> Prevent this configuration by blocking any assignation that would cause
> the union of domain isolated cpus and nohz_full to covers all CPUs.
>
> Acked-by: Frederic Weisbecker <frederic@kernel.org>
> Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
> ---
>   kernel/cgroup/cpuset.c | 57 ++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 57 insertions(+)
>
> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
> index 6e3f44ffaa21..7b66ccedbc53 100644
> --- a/kernel/cgroup/cpuset.c
> +++ b/kernel/cgroup/cpuset.c
> @@ -1275,6 +1275,19 @@ static void isolated_cpus_update(int old_prs, int new_prs, struct cpumask *xcpus
>   		cpumask_andnot(isolated_cpus, isolated_cpus, xcpus);
>   }
>   
> +/*
> + * isolated_cpus_should_update - Returns if the isolated_cpus mask needs update
> + * @prs: new or old partition_root_state
> + * @parent: parent cpuset
> + * Return: true if isolated_cpus needs modification, false otherwise
> + */
> +static bool isolated_cpus_should_update(int prs, struct cpuset *parent)
> +{
> +	if (!parent)
> +		parent = &top_cpuset;
> +	return prs != parent->partition_root_state;
> +}
> +
>   /*
>    * partition_xcpus_add - Add new exclusive CPUs to partition
>    * @new_prs: new partition_root_state
> @@ -1339,6 +1352,36 @@ static bool partition_xcpus_del(int old_prs, struct cpuset *parent,
>   	return isolcpus_updated;
>   }
>   
> +/*
> + * isolcpus_nohz_conflict - check for isolated & nohz_full conflicts
> + * @new_cpus: cpu mask for cpus that are going to be isolated
> + * Return: true if there is conflict, false otherwise
> + *
> + * If nohz_full is enabled and we have isolated CPUs, their combination must
> + * still leave housekeeping CPUs.
> + */
> +static bool isolcpus_nohz_conflict(struct cpumask *new_cpus)
> +{
> +	cpumask_var_t full_hk_cpus;
> +	int res = false;
> +
> +	if (!housekeeping_enabled(HK_TYPE_KERNEL_NOISE))
> +		return false;
> +
> +	if (!alloc_cpumask_var(&full_hk_cpus, GFP_KERNEL))
> +		return true;
> +
> +	cpumask_and(full_hk_cpus, housekeeping_cpumask(HK_TYPE_KERNEL_NOISE),
> +		    housekeeping_cpumask(HK_TYPE_DOMAIN));
> +	cpumask_andnot(full_hk_cpus, full_hk_cpus, isolated_cpus);
> +	cpumask_and(full_hk_cpus, full_hk_cpus, cpu_online_mask);
> +	if (!cpumask_weight_andnot(full_hk_cpus, new_cpus))
> +		res = true;
> +
> +	free_cpumask_var(full_hk_cpus);
> +	return res;
> +}
> +
The check could probably be further optimized. This check will need to 
be updated when the relationship between isolated CPUs and nohz_full 
CPUs changes in the future. It does get the job done for now.
>   static void update_exclusion_cpumasks(bool isolcpus_updated)
>   {
>   	int ret;
> @@ -1464,6 +1507,9 @@ static int remote_partition_enable(struct cpuset *cs, int new_prs,
>   	if (!cpumask_intersects(tmp->new_cpus, cpu_active_mask) ||
>   	    cpumask_subset(top_cpuset.effective_cpus, tmp->new_cpus))
>   		return PERR_INVCPUS;
> +	if (isolated_cpus_should_update(new_prs, NULL) &&
> +	    isolcpus_nohz_conflict(tmp->new_cpus))
> +		return PERR_HKEEPING;
>   
>   	spin_lock_irq(&callback_lock);
>   	isolcpus_updated = partition_xcpus_add(new_prs, NULL, tmp->new_cpus);
> @@ -1563,6 +1609,9 @@ static void remote_cpus_update(struct cpuset *cs, struct cpumask *xcpus,
>   		else if (cpumask_intersects(tmp->addmask, subpartitions_cpus) ||
>   			 cpumask_subset(top_cpuset.effective_cpus, tmp->addmask))
>   			cs->prs_err = PERR_NOCPUS;
> +		else if (isolated_cpus_should_update(prs, NULL) &&
> +			 isolcpus_nohz_conflict(tmp->addmask))
> +			cs->prs_err = PERR_HKEEPING;
>   		if (cs->prs_err)
>   			goto invalidate;
>   	}
> @@ -1914,6 +1963,12 @@ static int update_parent_effective_cpumask(struct cpuset *cs, int cmd,
>   			return err;
>   	}
>   
> +	if (deleting && isolated_cpus_should_update(new_prs, parent) &&
> +	    isolcpus_nohz_conflict(tmp->delmask)) {
> +		cs->prs_err = PERR_HKEEPING;
> +		return PERR_HKEEPING;
> +	}
> +
>   	/*
>   	 * Change the parent's effective_cpus & effective_xcpus (top cpuset
>   	 * only).
> @@ -2934,6 +2989,8 @@ static int update_prstate(struct cpuset *cs, int new_prs)
>   		 * Need to update isolated_cpus.
>   		 */
>   		isolcpus_updated = true;
> +		if (isolcpus_nohz_conflict(cs->effective_xcpus))
> +			err = PERR_HKEEPING;
>   	} else {
>   		/*
>   		 * Switching back to member is always allowed even if it
Acked-by: Waiman Long <longman@redhat.com>


