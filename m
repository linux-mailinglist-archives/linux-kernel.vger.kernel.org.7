Return-Path: <linux-kernel+bounces-746459-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B1327B126E5
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jul 2025 00:33:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C12471CC7A82
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 22:33:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0063A231849;
	Fri, 25 Jul 2025 22:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HH2ujMH6"
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D165A1A76DA
	for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 22:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753482811; cv=none; b=Af1MLKFIf6fcbLeZWWhi4HldSnlW1xznwW0ziclmaWIwvLRMQgj4mYypilEQjlV8eJkbvzhZ02zfwFeLjWE2NTxW57Cf0JyOfp6bxudtHQPLsZyPmnBiHW3hjpl8EtragG9khoEfcddRwJGIcqOjxhoskbSjUVgLjF1iEgTwIqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753482811; c=relaxed/simple;
	bh=txE8BMZpsZ2kkTIDh3zdqRzVj6ArWtR36OkbFFuXxvw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VWDNF923SE21XXODqPVfxpBqZ0Fv+dEs45MPk5GgLq9h+VILNr62jrwFeGUV5YEv68RXcYQcKvX2EqLKMNAUjftkrGKB0Z/Ouz9dPckDflEI58muQ3el7Zsi1NGXUnNhtVXHICXH6T11mXXHvSiJ5oys1UUAL7J6whFy5d08xtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HH2ujMH6; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-70478ba562aso36681536d6.1
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 15:33:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753482809; x=1754087609; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DZx9C4w4Iks3YnDwOlCIT9lKf9VPFQAC9ENFEkPTScg=;
        b=HH2ujMH6Mlf+e2qMl3OHgYs5kiHCWMFn2DNG+y399bIbDy3hpoTugaZclms0G5ewkr
         1rNAIqnT97wYGkYSZrQXQYw3Py3ggq6QGzxfZb5RKlGZUiqnaUvMZsLIV5WMDdjt14Th
         sMclIXtPfpOuM+8XH6+NleKcMB/C+936kY0/Kzy8Gwccjz8iYBXa+MChFjnq6RbUtHbb
         BRN33GYXgZ8OldPR5flpe2M7DXrSdFoq+BlM1kLYVKrf6SJHx+KSj+EncOT5s9Sk57rF
         ZpSrFgCKaJp82Yfq3kFAfcrfwR6X/7g3uyfV0llP7Mg48/pJUBP62TQo81GXiIu1QUUq
         MXXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753482809; x=1754087609;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DZx9C4w4Iks3YnDwOlCIT9lKf9VPFQAC9ENFEkPTScg=;
        b=I2UvVSVEv4sOKoMxQlgqLHVVcUvHdbjsbVVwmB6YERQS+zBI4P3VrgNuH0E+xpbspV
         sQtyCzhekl8xlEpU2YOhdoTFJfHc7TS4OWKmGMXoDJhyrbErsMOzl3JcW5skjrpqq2Pr
         8ze/LGKsrZD1OYisQXkaOJNon+GIQ4CwMtuWlt30WNeyQibSXfYh1eqf4R4/twCftcPE
         xT6jjfOCU9bqFgnqCtwEe9Sax+PbMZMVC3Bn7E1ya2mmaRo/fu759KGvUFq21z4JCehs
         BGoGuCplxEIVbqgP+XIspTEXWBiBrOZ9Mrcn/z9r2TxpKHTRCC0lH2a8mmENv9sk9pC6
         iAow==
X-Forwarded-Encrypted: i=1; AJvYcCVH8oLwM9uEdqIZ9sZlcrs4fcmR8JLDpWyqJQm5C95A4oG0ILC306eSVbjk4/5dVGaWGJNKOmU7+2iAC5k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxj2AwvHzPH8kjr+jm3ChEFWr/Oq2ujD+CoZI0aKZ7KN6y980cE
	Jf66yPeAd1qVrgrAr1nSzoiUCwau0Yo/zZUP67rFWvB1NwKTKQFio7Wu
X-Gm-Gg: ASbGncsbwBQG5dVKxP6DQ1e1QuSeVutaGRTvgSH9d4W/rYQyp3Aigm/igbfJ+cNJ6nz
	FZ0427g4cclVollg1yfWG4Fm0SeBNXLIrq3KIMpV/RYJZvW2ROBLbZlxhtuBkVhZJhUdr8YVPFd
	sVYKO5PztmipZuF56FG6hMAc4S+354hl60Z4Fxsh37S2sOqHDiDr3bhZM8qipg6sUC3VCmZp4ne
	gS4jjeTx/QAubBXnX0vHO/zcxBd2Lkecgb/mTx0QESRredY0H/UUYFwGh/C/u+U3eBaR74R2ymg
	6RutFKfD56giCdOQN1ysvVwROCnS/602/qvNCc12asCMQb4Ps1oXS0H/5T4iKEMl2Hl48CLXr22
	a0AfcnwNvIMQdRncCv7vJucihInlGdegjw5hfVO4P1dQT
X-Google-Smtp-Source: AGHT+IE8q+VAxVumQBkfL5m1N5HZKLBfbQY08yA51T0F8c6w/KmQDKfIYUx8eXD3BjyfwcUIEGcAUw==
X-Received: by 2002:a05:6214:413:b0:707:757:aef1 with SMTP id 6a1803df08f44-70713a92ca5mr101122406d6.2.1753482808572;
        Fri, 25 Jul 2025 15:33:28 -0700 (PDT)
Received: from [192.168.12.218] ([172.58.119.119])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4ae995456c8sm5287341cf.22.2025.07.25.15.33.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Jul 2025 15:33:28 -0700 (PDT)
Message-ID: <cabaaa35-5207-439d-b09d-bea741194535@gmail.com>
Date: Fri, 25 Jul 2025 15:33:28 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] sched/topology: clear freecpu bit on detach
To: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
 Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>,
 Florian Fainelli <florian.fainelli@broadcom.com>,
 linux-kernel@vger.kernel.org
References: <20250422194853.1636334-1-opendmb@gmail.com>
Content-Language: en-US
From: Doug Berger <opendmb@gmail.com>
In-Reply-To: <20250422194853.1636334-1-opendmb@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

I have observed a separate hazard that can occur when offlining a CPU
that is not addressed by this work around.

I intend to submit a more targeted solution to this issue in the near 
future, so please continue to disregard this submission :).

Thanks,
     Doug

On 4/22/2025 12:48 PM, Doug Berger wrote:
> There is a hazard in the deadline scheduler where an offlined CPU
> can have its free_cpus bit left set in the def_root_domain when
> the schedutil cpufreq governor is used. This can allow a deadline
> thread to be pushed to the runqueue of a powered down CPU which
> breaks scheduling. The details can be found here:
> https://lore.kernel.org/lkml/20250110233010.2339521-1-opendmb@gmail.com
> 
> The free_cpus mask is expected to be cleared by set_rq_offline();
> however, the hazard occurs before the root domain is made online
> during CPU hotplug so that function is not invoked for the CPU
> that is being made active.
> 
> This commit works around the issue by ensuring the free_cpus bit
> for a CPU is always cleared when the CPU is removed from a
> root_domain. This likely makes the call of cpudl_clear_freecpu()
> in rq_offline_dl() fully redundant, but I have not removed it
> here because I am not certain of all flows.
> 
> It seems likely that a better solution is possible from someone
> more familiar with the scheduler implementation, but this
> approach is minimally invasive from someone who is not.
> 
> Signed-off-by: Doug Berger <opendmb@gmail.com>
> ---
>   kernel/sched/topology.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
> index a2a38e1b6f18..c10c5385031f 100644
> --- a/kernel/sched/topology.c
> +++ b/kernel/sched/topology.c
> @@ -496,6 +496,7 @@ void rq_attach_root(struct rq *rq, struct root_domain *rd)
>   			set_rq_offline(rq);
>   
>   		cpumask_clear_cpu(rq->cpu, old_rd->span);
> +		cpudl_clear_freecpu(&old_rd->cpudl, rq->cpu);
>   
>   		/*
>   		 * If we don't want to free the old_rd yet then


