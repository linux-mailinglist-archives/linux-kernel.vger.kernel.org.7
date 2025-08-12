Return-Path: <linux-kernel+bounces-765119-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0079AB22BB3
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 17:29:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B1B57426757
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 15:29:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5B732F5486;
	Tue, 12 Aug 2025 15:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cYvHJDUD"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C8C12F5482
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 15:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755012589; cv=none; b=A0cL+K9k5j7FIBBqX0rsQfowT/PPIbyFVejaDHLNTg2MChIJFI5gxhG1H4E1zLzmgDUoqJkTqcY+LIUSwxjkjx8NTe3IPvOUjPqwiuOl+qOyZWfClkx/yjfX1NebuQeK7F0JTYY9jX4mOK16hO9xkf9YIc7j/Ws+rrPvq8takX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755012589; c=relaxed/simple;
	bh=lVpz2r6CUCOdWMmAbGQmvSn5iH8OBffDbbtnM6qk9rM=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:References:
	 In-Reply-To:Content-Type; b=nIrm6Elko+JMWXmFBgC2+yKfXYtLtJ1OQQaZUfAZMafFH2a7sx/pLXGA4/EK4A4opR4iXEG4Ti1nMRnsgd0MkJtPSYxofoffvT3l3/yaj7tOqo7mzEr+F42V2omP4BXYuWX/YY/2ZzxH6r1TgPZMi7SAKw+r+yTgj5ekjvq/8Y0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cYvHJDUD; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755012585;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4XAxSxKvK72o9I+RHPHnbHosdZghbyJGunP+/xi0nHs=;
	b=cYvHJDUDSScyOMZp3ijV/Wuajzwjkvz2bLwHll8SxXFEsFw06UawzBkIS8t9SgfzNNJ7jh
	AwPTfIhD3qJpYweskqPU5PrWnxZBhezgSHbbxPVsiLam81oO6ERfbxsqjskMv19rDkl9s8
	29+LVUEi3zBwa8MhatZPHo26XH5VnL0=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-520-Wk0OysYlOKCYbwMxClRvVA-1; Tue, 12 Aug 2025 11:29:44 -0400
X-MC-Unique: Wk0OysYlOKCYbwMxClRvVA-1
X-Mimecast-MFC-AGG-ID: Wk0OysYlOKCYbwMxClRvVA_1755012584
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4af18aa7af8so149206201cf.3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 08:29:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755012584; x=1755617384;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4XAxSxKvK72o9I+RHPHnbHosdZghbyJGunP+/xi0nHs=;
        b=rvvq164Ebd5sgdR3HbMydFL/ySbefntHL7dBZVkpjZq/bWY066WAsastTosvCOYblc
         JndDm09sl2jTk2nWojcSnEAolZ2iwOigaIIHbEiy8J3M7WSNAwkpJMrcwjV1yFKX+Sce
         b+BL/LHOPGi2bz8we5Wq9JKSO0TD04t/98wVNLZvDl4ks7IzkjTCbXNpahomhBlPlMoq
         wqNLyHYMwPxVeO9KRVZHNAIxPKYOgIjPcrSbOChE2DVeW90HFYXjNh+tGvj6NwQ6hGYF
         sVOkIRkBta+pEvaTPhYk8MEMc4N0B1ydvnGyBsyjxQzuE2dsjTJzy+GKEr3BHVIFcCMU
         M2Fw==
X-Forwarded-Encrypted: i=1; AJvYcCWFD1XpGWlVdQUCuvS7lGoPg/XmXvSP1cOj36xGVul0QkxoALhDUamM5uwR+jWNtZSgmAb5Yh02ildS0bM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZrlFJav3UDkU4ai/SNj+SnYc+VpahgANge+RXXj3aJUOSNFCZ
	2d48chLQr/lPmcmVmbWQcwruFVkZxCbPCVUJTsafI15N0UBcZ7AugOaS4MtA61Ax6nGQq9aJ6lt
	VNmTBNHokTXEiNJF98W04GUmNfXQnrY83Dhd/am3/fGHTKgEQtoxiDa+F6hPFCE8s3w==
X-Gm-Gg: ASbGnct7YpVw3PBYge+Nci5WqZHFLponvKLfdLQKs1BSLFht2D2p1+GbfTWJLyKpgSk
	ElHefYp/KJ15o4CBTQrBOfHXzgsXZTQiK4VrAaZWP3D8domjXoiAn/+BFEPZvVHjD4UFLgTYb9B
	bWxNfhRnliC7GbxtYNEXc7LhU/ZbeQK9MF29bfIQaI5HGu7hVSf+JXWF6sR2rWfibu26MnKetQp
	P+cehS4xRFQhXtzmIilXdpCUMVlFqVQBrBgu1UydRR22fbCy1j9266lEo7KlxytXhl3Fmu9+Smq
	ijaYTNZ7H7vVsCtXCl40xy8d0cLlkcMzETz/FRcBypIaYcOzoQ93duWiEyAicCZn0Fjahu0bhhA
	oMRXExPl4kQ==
X-Received: by 2002:ac8:5749:0:b0:4af:199d:107 with SMTP id d75a77b69052e-4b0ecccd7efmr48577111cf.48.1755012583445;
        Tue, 12 Aug 2025 08:29:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFKHe96FuWq6UoRLQxaOujmsaHpIFPq+dhmB6C7g7OxKsj4NSLjaFEnU1qumoMqXVEKaxQPHg==
X-Received: by 2002:ac8:5749:0:b0:4af:199d:107 with SMTP id d75a77b69052e-4b0ecccd7efmr48575961cf.48.1755012582255;
        Tue, 12 Aug 2025 08:29:42 -0700 (PDT)
Received: from ?IPV6:2601:188:c180:4250:ecbe:130d:668d:951d? ([2601:188:c180:4250:ecbe:130d:668d:951d])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4b06787441fsm125279601cf.28.2025.08.12.08.29.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Aug 2025 08:29:41 -0700 (PDT)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <a4395bac-9c54-4a23-b5e0-2a84db9b4ec7@redhat.com>
Date: Tue, 12 Aug 2025 11:29:41 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 6/8] sched/isolation: Force housekeeping if isolcpus
 and nohz_full don't leave any
To: Gabriele Monaco <gmonaco@redhat.com>, linux-kernel@vger.kernel.org,
 Anna-Maria Behnsen <anna-maria@linutronix.de>,
 Frederic Weisbecker <frederic@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>
References: <20250808160142.103852-1-gmonaco@redhat.com>
 <20250808160142.103852-7-gmonaco@redhat.com>
Content-Language: en-US
In-Reply-To: <20250808160142.103852-7-gmonaco@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/8/25 12:01 PM, Gabriele Monaco wrote:
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
> index a4cf17b1fab0..3ad0d6df6a0a 100644
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
> +		first_cpu = (type == HK_TYPE_MAX || !iter_flags) ? 0 :
> +			    cpumask_first_and_and(cpu_present_mask,
> +				    housekeeping_staging, housekeeping.cpumasks[type]);
> +		if (first_cpu >= min(nr_cpu_ids, setup_max_cpus)) {
> +			pr_warn("Housekeeping: must include one present CPU "
> +				"neither in nohz_full= nor in isolcpus=domain, "
> +				"ignoring setting %s\n", str);
> +			goto free_housekeeping_staging;
> +		}
> +
>   		iter_flags = flags & ~housekeeping.flags;
>   
>   		for_each_set_bit(type, &iter_flags, HK_TYPE_MAX)
Reviewed-by: Waiman Long <longman@redhat.com>


