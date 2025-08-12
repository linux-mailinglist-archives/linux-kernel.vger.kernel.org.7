Return-Path: <linux-kernel+bounces-765285-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E16ABB22E16
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 18:47:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 150A8173843
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 16:41:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 647122D0278;
	Tue, 12 Aug 2025 16:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PkkYNJVw"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44FCC156CA
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 16:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755016870; cv=none; b=YBn5lQ/xyWfphQxNpwD4fsNEFZ1tI/8d5V26MAV6TmvmhEYHWtSaiC7cCcKkGX3BZ1rto1DyZ2d+SZUyzprl+1SsyrPElc5/pSuX3RuekmOZu5urw5vSWLpdL5Hs7VJ2PwkzguoXgFOyWGZMzp/+rvcFGLTTgGRvVe1V7VxCcRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755016870; c=relaxed/simple;
	bh=OCjBSEJRjdLTG5llc8qYAPa6VIKiujBxqdu7MEDAd88=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:References:
	 In-Reply-To:Content-Type; b=afvzOR2bNuQ3l7DkP3e0/VZX7rRwoBYMYfhWsBCCQRT78pcDaYQ+jT1LUT46+zGF0CegRzBl6ffeLaQjAfxlISGk997hcLHnjmNLZ25ThTkM8mM5cmfTGdxPfNklPZpVOpBvAjOlt28mbAhb/TqJ/LdH98pB/541QBlaZmfZkg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PkkYNJVw; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755016866;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sXnyTUMmlWJiFCbarkaRSCxqNGCBByHg4YSxSJqyADw=;
	b=PkkYNJVwgaPCnlswGLwsh9ib2v7wHQ0F9RCt9rc6bHGa+HEFzTFTzAnhqDqLuZcCLawhdb
	6jUmnPVCm/hdHhqQNxQ/IFkBXg09mw4VYDWRDsWUsPKOmI5FWHXbD6X7Dha7BhQwlQbual
	ZU64DRfNxBiWdaIcg3ZcsQoZOcnJ8qo=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-594-kWw4jG9MOOire7SDlZscvw-1; Tue, 12 Aug 2025 12:41:04 -0400
X-MC-Unique: kWw4jG9MOOire7SDlZscvw-1
X-Mimecast-MFC-AGG-ID: kWw4jG9MOOire7SDlZscvw_1755016864
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-7e665a0cddcso1284803385a.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 09:41:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755016864; x=1755621664;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sXnyTUMmlWJiFCbarkaRSCxqNGCBByHg4YSxSJqyADw=;
        b=Lo5WmKj5VmZT78R13ZAqxAuaVYkiDtrpFXrPhsMuiP6hOuPrT5jQG7f1MQVSBYQvfD
         0RBNQ7RweEzp4TmSWICFGE0fUszcoYrkF2Ncs/6OahPV1GISirUOOK0CEaluyggYmjm7
         ddbujTYghdMNwDhyCoMnshPzUfGFzHw5HbzIF3WRzO9paTklwjyElSOuymtg3NKkQvXd
         r6XsuaGRe0ycPm1SYMBZlNZkETGNAU9If5Ad7Lm0JFGtxRrJjvk50fI9uIgmPtENMS44
         iu7fQoCNrPIR6aGSErOy7uAPTpBJ3YsXK2FkUW3xhYYDZoEBjFMTUjmE/eBgb+X5kJAm
         POxQ==
X-Forwarded-Encrypted: i=1; AJvYcCXuTkUbnBkJWT7rKBT20L+QnWRPFN9ZGl+ZNqVerQ4Xul1C+stL7DYZEB90nRSoSyJtpEkwYdkPBRtV3Qw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyq+muvRwjiH9GwJzIv15n1zxzmZ/H2psbkGob/WnFHeObP9YKZ
	N4HVdLvVHyZdKKZ7z/Vro/Nq9qGpy1ROsENUf6Qhsbzbk/ABmQUmLhQtRA65lmMuETNH0/2fC0B
	KChLQu2wpJR/r51AgIDlDE+B+lv/wYNGl/5PTVcsStshhPa3yNpHCuvCLNbuhSWZlmw==
X-Gm-Gg: ASbGncu1j4jPOB32Eotl24J8gejmCjjmqVOZg9yKVFGtT3xq7Ual769KBkQcJaxIDJk
	00JmMW8IU0yfszoaHn0wH6/4promOxyif/Hi8UzvdtgGpsx3b0XCbYF/FR/IW7HklrefYAfxtr+
	IXyDi1iLSW68kZiKmg8e0RYvX+aW1aWqC1BzmnrOM+PE3hZptcDrtoWl9REybleJmD68CjHVdWa
	RVPiiB8yahKofDM3DVxk+DGXlYpyQZGIK/cgpdZv28ahQyRG/YQbJq1NTirNO6JZYLYYT4O5efX
	2JMnddUlUzFryWrAiRqVbeButeb9PLoIXO22NqwQ4BDv4pz6FcbhkKgtFqPDXd0Rxr9JozB6AhY
	QV+PvC+ATpA==
X-Received: by 2002:a05:6214:226e:b0:707:4023:6b8f with SMTP id 6a1803df08f44-709e6bb6efdmr6730746d6.28.1755016864009;
        Tue, 12 Aug 2025 09:41:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEGT2yJ778Eo08DdVw8CoPtd3IhZhG2mnb3dKlPCzw9m5F7SJeEjeBD8LuPS9bBdiPt4qhXSw==
X-Received: by 2002:a05:6214:226e:b0:707:4023:6b8f with SMTP id 6a1803df08f44-709e6bb6efdmr6730256d6.28.1755016863494;
        Tue, 12 Aug 2025 09:41:03 -0700 (PDT)
Received: from ?IPV6:2601:188:c180:4250:ecbe:130d:668d:951d? ([2601:188:c180:4250:ecbe:130d:668d:951d])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-7077c9d98ecsm178826506d6.2.2025.08.12.09.41.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Aug 2025 09:41:02 -0700 (PDT)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <3aec92a2-5f08-4120-b53e-d38a0482a862@redhat.com>
Date: Tue, 12 Aug 2025 12:41:01 -0400
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

BTW, could you replace cpu_online_mask to cpu_active_mask in case you 
need to update this patch series again?

Thanks,
Longman



