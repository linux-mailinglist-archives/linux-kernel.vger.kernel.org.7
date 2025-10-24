Return-Path: <linux-kernel+bounces-868505-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0160AC05602
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 11:36:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7DCEC3AF4C1
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 09:33:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3709130ACF0;
	Fri, 24 Oct 2025 09:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="deqjCh8k"
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B7F3273D9A
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 09:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761298399; cv=none; b=RDuhkR5yKgbvdk3pK14iff4IqBYuZdP3Cm93GqCxezU5t7fS9SsZYlShBdTnoEUnPIT5PwM1TuOxfHdkbNvXg8K4sVlwboeZ1+JAe/wh4k5SoRRHXwih7tmHJ15cvgoccLr7nYP+h8dkWQpDkP/6n1ka/nAzFbQLz3pdiCYtqcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761298399; c=relaxed/simple;
	bh=kRQvfDsqLu6Vxr4d7/zgz/3bpNMHBsbQAcyO5Wqn7aA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z1eneGLqUbRtHQH6r5qPh9ULsJzcN9SteJTwa0t7VUfOzEzzqgZHLoCWBa96ivQMAyta4GrB6gaZcCnlQlHfkXwZvKJsIIhOE23HiHxFi8RDNgDQPQjag29fmm5YZmHREvdMAhT2bdBLn4rOCnDIXgpuaUiGAoBKkhg3Q2bCzC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=deqjCh8k; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-33ba37b3ff7so1879985a91.1
        for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 02:33:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1761298397; x=1761903197; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+MbwbNlILNFLRsimC2ZCXthc+stdxrprxO1I5dfp1aE=;
        b=deqjCh8kWlkQUxMO9oK4f80lX1NIQTjimnu/Gv4zietxNNW5a154e7xmOVqMgctTY+
         3wurp0NgKlktu4exr6wPwA563CxLIzx/09CmK1dvUhtQPkINoryyAvIHwpOIzr6Gnfws
         UiJo4LlDYcxYxuRFQ95PS2Mwa335EsXquN2zd5GctFJQpOdToxr2U0dK+VMtP1vFziIP
         tatab2JqgaZxi4HRpuO5giS6BSpFyg1tojufeLw/8gC0ojnNsTe06yigDMKOfjNMrLUg
         KeG2ZGKoZN26FeKrLy+d+rJYeCb5TCLqnZEqyQncouZsADl9zCh1cL3TjTRBxGEO6/UI
         dFbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761298397; x=1761903197;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+MbwbNlILNFLRsimC2ZCXthc+stdxrprxO1I5dfp1aE=;
        b=BKoAFX2g4hF3w0j7v6da4I25W4X7eRFbxUGpZ6SPVJ8IkYAQb7k4fqFbqr9RNGsyJq
         coZdJJEixnWDzD0wnL0ir08cTCy6PEcvBIKS1+ziiQnuQi3N4i32IL11tyAOt7jirciw
         w9gwixPOxiScKjGZCOKE9c842W4orQcUPsfCVHadsdTH86kTuUoRnaHeAkMheK8zEIQa
         GzEyc6sb3jxOt383C35Typ2IlZaP4nR0Kg+oHQlUh+cR8Et16c5duW7czkgZfKrap+ko
         E1obndkFhi2fqLsU9p58R4ZHg/l5NNQOk5QLrnGSVRV4+smyLRGlRoInzZL3hqox+qtd
         NepQ==
X-Forwarded-Encrypted: i=1; AJvYcCWGG4L6AkYHcVUadQ2b1Sgf17byFD9Do636E7f8CaJN3bzT+NJhQIC+yuh3F14XjadubpwsoITRcrF1y3I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyy1LwsY+IH4B7e2g4Djr04D7GqSYSj+o/oEt3SCcFyZBKvvD7Z
	1XoWiXKHKAXb3+xtJwzujAm9EiwR65LfrbhfBb9EaoJm+t4Av/8JJvUYhc9iefRpAA==
X-Gm-Gg: ASbGncsxweA5urV6pIMHkfJZTUc7B11LWAzGFivG8jdsGN3Ul/CsXD3GemVjZ6bIbJU
	fpiwg6Q5Pe7Bj1pI4mXbvSE/M7NtDBMjQ//N/zYIPninfb6AlKJFmYdhuvQIzGkOnabf0V3yDiZ
	sMPzAurTCAOPTVSGw2yF3n50GTsgl13/Nm7h0RsYzdDCbDMEdF4wn3QNnV2WbRzARxyqlTB3dqE
	fO5Naov0xJgMA4mikpdykkXCqz1H8PAwxydzrtboVXWp+h87LGynO4ApLvClQZ+ETIrmmgLEmhY
	TOfBx01+Uawa4rDlYA+4DRuKsxd/Qf+/wNFbnoWfOP9DFuiW9bpcYxMBQ1WF6PnCYyExv8ws1eJ
	vjRpQSMP7qkgmMvbiQkicWNf9E3kwia39vMN5ISoHBRXxBUmeey+ACyxf6gW1M+x4Tzvc1shsy1
	9NGXQFG1VjFIJ7yJqx4LJh
X-Google-Smtp-Source: AGHT+IEPQDp8R9BZm3sW5WPIJNA5P37x71plD+9JMC57EGkPUvo//tXZ5V07Mo0oYDtVrl4dmkDO0w==
X-Received: by 2002:a17:90b:1c0d:b0:31c:39c2:b027 with SMTP id 98e67ed59e1d1-33fd3a96310mr2622684a91.7.1761298396606;
        Fri, 24 Oct 2025 02:33:16 -0700 (PDT)
Received: from bytedance ([115.190.40.12])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33e222d8652sm8383143a91.0.2025.10.24.02.33.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Oct 2025 02:33:16 -0700 (PDT)
Date: Fri, 24 Oct 2025 17:32:58 +0800
From: Aaron Lu <ziqianlu@bytedance.com>
To: Tim Chen <tim.c.chen@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	"Gautham R . Shenoy" <gautham.shenoy@amd.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Madadi Vineeth Reddy <vineethr@linux.ibm.com>,
	Hillf Danton <hdanton@sina.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	Jianyong Wu <jianyong.wu@outlook.com>,
	Yangyu Chen <cyy@cyyself.name>,
	Tingyin Duan <tingyin.duan@gmail.com>,
	Vern Hao <vernhao@tencent.com>, Len Brown <len.brown@intel.com>,
	Aubrey Li <aubrey.li@intel.com>, Zhao Liu <zhao1.liu@intel.com>,
	Chen Yu <yu.chen.surf@gmail.com>, Chen Yu <yu.c.chen@intel.com>,
	Libo Chen <libo.chen@oracle.com>,
	Adam Li <adamli@os.amperecomputing.com>,
	Tim Chen <tim.c.chen@intel.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 10/19] sched/fair: Prioritize tasks preferring
 destination LLC during balancing
Message-ID: <20251024093258.GA1630077@bytedance>
References: <cover.1760206683.git.tim.c.chen@linux.intel.com>
 <ca1946de63ad9f0ae99e079a74d70c55879cc0b6.1760206683.git.tim.c.chen@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ca1946de63ad9f0ae99e079a74d70c55879cc0b6.1760206683.git.tim.c.chen@linux.intel.com>

Hi Tim,

On Sat, Oct 11, 2025 at 11:24:47AM -0700, Tim Chen wrote:
> @@ -10849,11 +10849,45 @@ static void record_sg_llc_stats(struct lb_env *env,
>  	if (unlikely(READ_ONCE(sd_share->capacity) != sgs->group_capacity))
>  		WRITE_ONCE(sd_share->capacity, sgs->group_capacity);
>  }
> +
> +/*
> + * Do LLC balance on sched group that contains LLC, and have tasks preferring
> + * to run on LLC in idle dst_cpu.
> + */
> +static inline bool llc_balance(struct lb_env *env, struct sg_lb_stats *sgs,
> +			       struct sched_group *group)
> +{
> +	struct sched_domain *child = env->sd->child;
> +	int llc;
> +
> +	if (!sched_cache_enabled())
> +		return false;
> +
> +	if (env->sd->flags & SD_SHARE_LLC)
> +		return false;
> +
> +	/* only care about task migration among LLCs */
> +	if (child && !(child->flags & SD_SHARE_LLC))
> +		return false;
> +
> +	llc = llc_idx(env->dst_cpu);
> +	if (sgs->nr_pref_llc[llc] > 0 &&
> +	    can_migrate_llc(env->src_cpu, env->dst_cpu, 0, true) == mig_llc)

llc_balance() is called from update_sg_lb_stats() and at that time,
env->src_cpu is not determined yet so should not be used here?

> +		return true;
> +
> +	return false;
> +}

