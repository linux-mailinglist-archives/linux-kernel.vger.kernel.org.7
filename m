Return-Path: <linux-kernel+bounces-875412-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EAEEC1901C
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 09:25:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B8413560F99
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 08:14:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FB32314B93;
	Wed, 29 Oct 2025 08:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="KSLzx8y1"
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D41FE26FA4E
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 08:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761725231; cv=none; b=Bk19GFi09eMUY3OWlh9zGczcwY7XXvYvPoAmoanNgjFZPgPRmD8wcYKEuskTVDKpNLCF/B73mrlEDVJesY9xZBwTNG61nWIgrbzX2Ez9cCd8rSABDYRiV5qYySYafseQXisXQkgHq2quXbGuh2nijE6inmg0br/mCe5+pAJjVk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761725231; c=relaxed/simple;
	bh=PFYqLbtuiQ5i+nvu2JMs66Ba3rNW5DL11JKr/JHkaf4=;
	h=From:Mime-Version:In-Reply-To:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DdZKrkCjM/uZAHulSwk4nEMJk/0Z+RhBnSOEUElEoI9TMPb2NRCNNURx97ez8fZErUNwfw6EevoiiR4ovy7WYUXoK6KJI+BJ3nr3FOqYkiTf9MbQSPGzBJwD13ABwu7UmjAMyceHBtLOk1wqte6/wx4mTBSWfcKRafHRDCWcvTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=KSLzx8y1; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-6399328ff1fso11653303a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 01:07:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1761725226; x=1762330026; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:references:in-reply-to:mime-version
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=hWRuCyAyXN9JDnyZB3JkvqVtwPhn+0aLMbMUREVfzl0=;
        b=KSLzx8y17Ao/+Okl/E8FSoc4xeigI93SY7EtufYu1Rytm6pyVWnIpWzpaBk9wUzHfB
         uL4rS8wkX38vIcQa7BvY1N8aaEa5rFLiSKbFcxQ2lUMPFc2FuHVy5kPqVrfTRHfFCWV0
         q3eGYc/KWvYvMmGf32u+YoCeLC/PGk7XvKIdCGzbZoJoZkwvlnP2zzBmwv3dyUuOq8jf
         epz8bDBbtc4pvRsEpY3NorIASmM5NL/2rf9j5G/85t4YVUQzjQD4s0nITy7/94si7uD3
         2JMK8yteeyzEvAr0f+rXQ2ve0ZsLnT85OnX+BK+v5d49MzYlBKX0+ZrTXn0Ci/w9W+0e
         54AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761725226; x=1762330026;
        h=cc:to:subject:message-id:date:references:in-reply-to:mime-version
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hWRuCyAyXN9JDnyZB3JkvqVtwPhn+0aLMbMUREVfzl0=;
        b=CNVMrguEfygbBUIFXIyltl8unYSzlgbHu3BxUYB04ULGEvTUyAJm7/kHNI86H3Ckwk
         sUquVFADgDs01n5A3iglmWpgTqkNIfOms7GzOB6fIowcKaaxeEUwy1HAyZv3bYm6qn8C
         okYX0FVUQ+8btTqX+24+mQ4bE1OxVyOjDZ57F5bflmNj0QTSZPSPNnOvZ+mgXunnTioH
         pIugkjZlTo5J0Xfq1iitwLYnb4Q/KZjl6PziwrqbZ0fni4H4WR0lcFLZpsBUkhZnpEFm
         yKBzovK6WIZbMxkTjmuSoHcyFoOmEvuU3zx7jW8kwK1RQ8OW18zF1gtX50y4MszxN1yS
         pOFw==
X-Forwarded-Encrypted: i=1; AJvYcCXoR1Q5J8R65jaUmqQiFzI/LO7uU5xDs73Oq9MaXjtv4QYPB7VvUxDeFR8/tZUpFgZCv9VKlD2/0OkenHo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8sW823OCPj3ccWPCYSbdRRh/9s9S8T7L/tPESaauqtYun264k
	ItIIgcvgkTajnTRvFCTIBRRTdb5oewVppoRTlU5p4N7eFPX3O3lNH+IcOx4n9veR8/Qq6egAf3b
	P/2w9W9YdolJnyYmM0yMCPHMcQR3/F6FK46vgdjz0
X-Gm-Gg: ASbGncuc3PArYrmbHXboRMTBn5z4UXLprbiH7Dv/67o+eXRlcV5vkClQrjv/5T5rFCw
	/W/9gyxWKOKexD3SEQR161IoT0ZpY5KAZasX2699Ai4X7c10NssiFyWzYuNZ92MbUOexXHjkhCt
	HlJpwc49ANtE1xKKdfWnhDyESW/zfElmXew+NOVXlHHeUQsXIuEucIrWRoO3Mwt+QLG6o/S0cod
	ICtFuCxoq6H8H4vqSu4f6CSMoQ3rkUch+/cCGP7CQm+M+7FJXj2uXyGTR9OOQ==
X-Google-Smtp-Source: AGHT+IFtWTs0zx0IKNbFT8EyxMiYi6jLOxDizpScjBPJJ22DOskRxAHRLFYHT+M49BJncKFE92V85iMFHfK7Cr7ocwA=
X-Received: by 2002:a05:6402:2809:b0:633:8787:607b with SMTP id
 4fb4d7f45d1cf-640441a9a15mr1429259a12.12.1761725225356; Wed, 29 Oct 2025
 01:07:05 -0700 (PDT)
Received: from 44278815321 named unknown by gmailapi.google.com with HTTPREST;
 Wed, 29 Oct 2025 09:07:05 +0100
Received: from 44278815321 named unknown by gmailapi.google.com with HTTPREST;
 Wed, 29 Oct 2025 09:07:04 +0100
X-Original-From: Aaron Lu <ziqianlu@bytedance.com>
From: Aaron Lu <ziqianlu@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
In-Reply-To: <afe7603c37fe76064d769ce9d78df494347a748c.1760206683.git.tim.c.chen@linux.intel.com>
References: <cover.1760206683.git.tim.c.chen@linux.intel.com> <afe7603c37fe76064d769ce9d78df494347a748c.1760206683.git.tim.c.chen@linux.intel.com>
Date: Wed, 29 Oct 2025 09:07:04 +0100
X-Gm-Features: AWmQ_bnaqRtTjmNcDFhfdl7ITw6Q2JccozPzr16Jr8ZAvpeVteRhRFiBqCSvUKk
Message-ID: <CANCG0Gfud=g2zUQrDJUipiP0-id0_Jv4kkoWGnyYvwDJAR+gdw@mail.gmail.com>
Subject: Re: [PATCH 19/19] sched/fair: Add user control to adjust the
 tolerance of cache-aware scheduling
To: Tim Chen <tim.c.chen@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	K Prateek Nayak <kprateek.nayak@amd.com>, "Gautham R . Shenoy" <gautham.shenoy@amd.com>, 
	Chen Yu <yu.c.chen@intel.com>, Vincent Guittot <vincent.guittot@linaro.org>, 
	Juri Lelli <juri.lelli@redhat.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Valentin Schneider <vschneid@redhat.com>, Madadi Vineeth Reddy <vineethr@linux.ibm.com>, 
	Hillf Danton <hdanton@sina.com>, Shrikanth Hegde <sshegde@linux.ibm.com>, 
	Jianyong Wu <jianyong.wu@outlook.com>, Yangyu Chen <cyy@cyyself.name>, 
	Tingyin Duan <tingyin.duan@gmail.com>, Vern Hao <vernhao@tencent.com>, 
	Len Brown <len.brown@intel.com>, Aubrey Li <aubrey.li@intel.com>, 
	Zhao Liu <zhao1.liu@intel.com>, Chen Yu <yu.chen.surf@gmail.com>, 
	Libo Chen <libo.chen@oracle.com>, Adam Li <adamli@os.amperecomputing.com>, 
	Tim Chen <tim.c.chen@intel.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sat, Oct 11, 2025 at 11:24:56AM -0700, Tim Chen wrote:
... ...
> +static inline int get_sched_cache_cap_scale(void)
> +{
> +	return (llc_overload_pct / cpu_smt_num_threads);
> +}
> +
... ...
> @@ -9749,7 +9811,7 @@ static inline int task_is_ineligible_on_dst_cpu(struct task_struct *p, int dest_
>   * (default: ~50%)
>   */
>  #define fits_llc_capacity(util, max)	\
> -	((util) * 100 < (max) * llc_overload_pct)
> +	((util) * 100 < (max) * get_sched_cache_cap_scale())
>

With this change, fits_llc_capacity() would be false if util is just 1/4
of max(which is llc's total cpu capacity), is this intended?

