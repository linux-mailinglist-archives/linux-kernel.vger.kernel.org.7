Return-Path: <linux-kernel+bounces-758336-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 01650B1CDBE
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 22:42:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B18DD62275D
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 20:42:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 699A62BE056;
	Wed,  6 Aug 2025 20:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="T7TZ66fF"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2453A2D1319
	for <linux-kernel@vger.kernel.org>; Wed,  6 Aug 2025 20:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754512739; cv=none; b=cuV/ttlhs15eOK0x7YHahQK2W1lkG24xmUvJLrbt0VJ/EFd92M9M41y2K1V8ik2dP+iSyQmEf4qbrdJDYCbOpMg0lkrICgwINZZ8P0tuh4syo5mIUOrWLeQGrzPUlmbjQ2f1mAA45fACxoj/0awYejaWKULuhhps7KlaT/sNEnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754512739; c=relaxed/simple;
	bh=Y0Gi0m9/vhXAMp5OJv67URcl26nwfvlkN6Y4JpZwokI=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:References:
	 In-Reply-To:Content-Type; b=qfXItcj1rzRL8hlog9pq+IhMJffEn2JsCORFzFdYpmLuSO7/jCHEEwHGXP6VR6kfNSAeIL+nqcXXsKAHyuuGM0L632J9UQTTHNY13Xn8ZQ+cJZG8bsz9DAKdINUEs8n2/wVm6xz4lFEtikqzKweCe6Zd3Hcht7TJQNqcKjv0xK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=T7TZ66fF; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754512737;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Qt/nz2BJaNl9ttHroypOud4E7niGxuP+q6ts/HlWbUE=;
	b=T7TZ66fFfRIG9JBWzQTk6MBgalBTVG8HYVrnlKcHsvGqtAIZY5lwMCPdvqfjoAqzsMUwoG
	5G41UVk9FYSUbq43N2fP4jx5x2NW/TsqXoKQLsTCcpYrb/dDOoFk45esa88tkgt40+73Mm
	qQw5vv/CGGdLWxJluYoFFrxOhdLEUN0=
Received: from mail-yb1-f197.google.com (mail-yb1-f197.google.com
 [209.85.219.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-677-VeT_UmmFOj64Mtk5gKAFKA-1; Wed, 06 Aug 2025 16:38:56 -0400
X-MC-Unique: VeT_UmmFOj64Mtk5gKAFKA-1
X-Mimecast-MFC-AGG-ID: VeT_UmmFOj64Mtk5gKAFKA_1754512736
Received: by mail-yb1-f197.google.com with SMTP id 3f1490d57ef6-e8fd1b500d3so410737276.2
        for <linux-kernel@vger.kernel.org>; Wed, 06 Aug 2025 13:38:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754512734; x=1755117534;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Qt/nz2BJaNl9ttHroypOud4E7niGxuP+q6ts/HlWbUE=;
        b=SdPNsWnlH24VzB4hEU1NRBcGIQye9DFVSY0hjc6UD4mFApqK99Z9Pij2pc2fhCE8Hj
         mcTTh+DDiBbnqm71vPopfbJVWxFgE/ybxIMdo0TP/ZxmS7JpYCwCGNkc92mB97RrIrib
         splWdKmWNBXCoMJJA+3ATQyX2S4nhdpklPBUmSjfTfICmClhDwGduSwDy35mUm9ya9pG
         Z9qk4HVdg8pHIYrfCZCYemh3SraKqNUnACfiYYWECAGpWR0MJIkevzMpS+I5dIdB4sL3
         GExxFdsWrb++h1LSXx075FC1UOblM/T6wF0OS0wXWOW+NC5JwmR2NSwdCc62nG2zOs3B
         Yhpw==
X-Forwarded-Encrypted: i=1; AJvYcCX4MbxTtm9/6mRsRR1GMbxMRs7CXgS/hVIIIzWc45OPYDUjK11q1BT17KWRvRErpzJ0PjcPC0tNsRQg16c=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZBb16Krg/HFb5cGfHCRBAj4HAKsPiApOgpZr1rRK81SrXrduq
	cilG20ENPq/ufsHHZ/+IcTK2f38ffQOK516/6YTbnM2jxnPIHoGJa75KYin+kLMIoeBMf+HqUqR
	wn5AsFE9zE6S4yWPACqBygTWYNYGk9x1AfeCphjs0KvG0m1dWZ+4JeZaZtc1CgLstaqYWJJbfpi
	wD
X-Gm-Gg: ASbGncuM82sNNeCVaLl0xqUA84U8TmQZ2tShhjN0EVMI03ZYu7HEFQx9RxlO4zndTma
	RPvodRMlX/VZBqnz66YHLuexHWECo4HHX1fo55p41f6lNjB92naLdHxf0ngCapnOoTdIGXVl6hX
	hr+4hhXu+D34EqBgJnYZx7XJLCCxomZKaBldZFUdNhUlJM9ipRpxGNtutjepCvo/p26uDCt3v5O
	ylH/PmYV5EbMsc8CWh3rJw4hhHD/j+vmfqaCtRw671WEixmq+U9DylVC/d5jlT/tMfTbed/x7/D
	vsKcaaUBR86NA3Vt4PfoP98mfuLvGyaAhBq7EMVpvCO9X9n5ftILI8nU9i/xW/PWoE4dVwptonZ
	47f8Nsb80Zw==
X-Received: by 2002:a05:6902:310b:b0:e8d:f87f:2b18 with SMTP id 3f1490d57ef6-e90288c0bc7mr4722904276.40.1754512734556;
        Wed, 06 Aug 2025 13:38:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG31zShLuUfYy50Xq0tF91uiYfRvnWbnMpSyKe641NaVK12XSRYKWXuape/iiX6eXJ90kmmVw==
X-Received: by 2002:a05:6902:310b:b0:e8d:f87f:2b18 with SMTP id 3f1490d57ef6-e90288c0bc7mr4722874276.40.1754512734161;
        Wed, 06 Aug 2025 13:38:54 -0700 (PDT)
Received: from ?IPV6:2601:188:c180:4250:ecbe:130d:668d:951d? ([2601:188:c180:4250:ecbe:130d:668d:951d])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e8fd3860a91sm5801622276.23.2025.08.06.13.38.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Aug 2025 13:38:53 -0700 (PDT)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <9184eaa2-40cf-43ce-b060-2a3b18aeca85@redhat.com>
Date: Wed, 6 Aug 2025 16:38:52 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 6/8] sched/isolation: Force housekeeping if isolcpus
 and nohz_full don't leave any
To: Gabriele Monaco <gmonaco@redhat.com>, linux-kernel@vger.kernel.org,
 Anna-Maria Behnsen <anna-maria@linutronix.de>,
 Frederic Weisbecker <frederic@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>
References: <20250806093855.86469-1-gmonaco@redhat.com>
 <20250806093855.86469-7-gmonaco@redhat.com>
Content-Language: en-US
In-Reply-To: <20250806093855.86469-7-gmonaco@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/6/25 5:38 AM, Gabriele Monaco wrote:
> Currently the user can set up isolcpus and nohz_full in such a way that
> leaves no housekeeping CPU (i.e. no CPU that is neither domain isolated
> nor nohz full). This can be a problem for other subsystems (e.g. the
> timer wheel imgration).
>
> Prevent this configuration by invalidating the last setting in case the
> union of isolcpus (domain) and nohz_full covers all CPUs.
>
> Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
> ---
>   kernel/sched/isolation.c | 23 +++++++++++++++++++++++
>   1 file changed, 23 insertions(+)
>
> diff --git a/kernel/sched/isolation.c b/kernel/sched/isolation.c
> index a4cf17b1fab0..0bf7b91684c0 100644
> --- a/kernel/sched/isolation.c
> +++ b/kernel/sched/isolation.c
> @@ -167,6 +167,29 @@ static int __init housekeeping_setup(char *str, unsigned long flags)
>   			}
>   		}
>   
> +		/*
> +		 * Check the combination of nohz_full and isolcpus=domain,
> +		 * necessary to avoid problems with the timer migration
> +		 * hierarchy. managed_irq is ignored by this check since it
> +		 * isn't considered in the timer migration logic.
> +		 */
> +		iter_flags = housekeeping.flags & (HK_FLAG_KERNEL_NOISE | HK_FLAG_DOMAIN);
> +		type = find_first_bit(&iter_flags, HK_TYPE_MAX);
> +		/*
> +		 * Pass the check if none of these flags were previously set or
> +		 * are not in the current selection.
> +		 */
> +		iter_flags = flags & (HK_FLAG_KERNEL_NOISE | HK_FLAG_DOMAIN);
> +		first_cpu = type == HK_TYPE_MAX || !iter_flags ? 0 :
> +			    cpumask_first_and_and(cpu_present_mask,
> +				    housekeeping_staging, housekeeping.cpumasks[type]);
This statement is a bit hard to read as I have to look up the C operator 
precedence table to make sure that I get the precedence right. It will 
be easier if parentheses are used to make it easier to read.
> +		if (first_cpu >= nr_cpu_ids || first_cpu >= setup_max_cpus) {

Perhaps you can simplify it to "if (first_cpu >= min(nr_cpu_ids, 
setup_max_cpus))".

Other than that, the logic looks right to me.

Cheers,
Longman


> +			pr_warn("Housekeeping: must include one present CPU "
> +				"neither in nohz_full= nor in isolcpus=domain, "
> +				"ignoring setting %s\n", str);
> +			goto free_housekeeping_staging;
> +		}
> +
>   		iter_flags = flags & ~housekeeping.flags;
>   
>   		for_each_set_bit(type, &iter_flags, HK_TYPE_MAX)


