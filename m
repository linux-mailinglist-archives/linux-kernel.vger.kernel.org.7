Return-Path: <linux-kernel+bounces-833127-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19C14BA1487
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 21:59:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B9BBA388525
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 19:59:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15D2D31E885;
	Thu, 25 Sep 2025 19:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="X10rL/5m"
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2A3931DDB8
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 19:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758830390; cv=none; b=Q80SWh2em36jE1gRxgy6QOjtAvX+ZFPr6xY6ZB5+XMZDjhGmprY+8Tg2AlhrbgYn4wUJOcksz2th5A60pFeefe+S+Ri0lVLb+TTCVLwxOrxIEljdTs+/QLy3QwXMVapw/Ey5SI1KyM1rlqvhTrsycT043OEIMruG6hS1FtUJrL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758830390; c=relaxed/simple;
	bh=vMyMrttkJU70UcU5kNCp5ltRt/PfbQM9ak0dhNmn2aU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=doOKTDOlQkce9AiNi5o8h4cFpxiBciMRmHdT6J8pH5QYXzcNYPIv/VwBBHs4LECSZFkeHLWxqqKXFY2kjoAo4rMtXHlfR/nc1LY2MbkkuDEpKFpNSzMBb7CkqguOJ/RZl1XdjxHHXrS+rD0skI12C50VtOHYQGfpWbbvftWOTsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=X10rL/5m; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-77f68fae1a8so1957544b3a.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 12:59:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1758830384; x=1759435184; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xOzyRe+3fMSMSulDoCd/U8Ee2YvY46RKA0vukyO785o=;
        b=X10rL/5m7qX1Zwd8iYZmu6S6PsHN5PsUe7Go1imuTj/GrSoFySgG3n6ZrXaumCyOaa
         JZrZDwK02wooL71RDITRhGRPV/Ex4KOA2Qvc9oJ7DXtYxOHUWUZbC1vuTSdI8wg5Tr9V
         9UIV4cXdJTDoWjf3pFf/VJXUghC6B+JUCBCqc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758830384; x=1759435184;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xOzyRe+3fMSMSulDoCd/U8Ee2YvY46RKA0vukyO785o=;
        b=cpHHMFPOWao/bVIxJwyTs6n1rVw1D/OVtbXqk+IUEgGxxbMRpqZbaLTvbzHj1O8h0X
         vIDke9f6MKy2LaDo0O6y7ESJEplbpTI11uv+9iWW2XKUvCfRg/uVrZC0ZCQEE/cXPTW4
         qFQydTAG4Vs21KRylpuer4+Ry0PpMisA64VDbaMsGL/cZbEGcL4nAN4ttaqfuUQ4DAW2
         ToV1xkom8d83XoOsmYjnCjekosWSr4g9HMllrqaNa6n2gqV+4v1Hkr6rQfx/NOOTDSVJ
         owCmCj5ZIOnp2DrSBxifXbYlXCdMc6/t+l4hbr3spskMRsySoiZxmoLuMQJ/tXD8kcgL
         FePg==
X-Forwarded-Encrypted: i=1; AJvYcCVaQS7YxUmWOdznSRxG+nhrs67x36anAbSOel9hj5BC2mI0jSd7LTykJ66prJ1J9e+lifNotWwYAALheCU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLp5voBdRdJCgkCcxdw1adMYwcex2DrlYj3q9by2enQxI2/aIs
	D+aYQBeO3OO8vjIobADQ1W+Xmh4HMgKVULWzELWOzk6kLdlesgxLiZNAHpBB13bFUuZJnPYBbGF
	xCaE=
X-Gm-Gg: ASbGncukP1XopOCQSJTxjiVY2dCzSf06wtCWrV5vJuSjqrmP8rDo99MUQphStqj92rP
	RaC/+wEwLzkSxqltIlzhvSK1BYqklvyCdTMWC9cN8ANygVQ6yHBtqhGQ5D0pzbmR44Q9a8K1jUS
	6qg3k87dy7kXqbIWerAN484zAI6Vx8nHLK6WXiO+Ow12tpEVXLr0NA9rJ+WM6fbiiykpN+33wVw
	jwFAB1YkM5iq2FAF30Qnv7VMQ7X+C/2Mu7w5kOwsCsNWe9WdBvV/BcH6RatyrWE61wYkZAVzG1V
	3YLur4c+GIJ7jFja8CPs7J6fTxVtBAFwFORLaka4ZyFA6itMkowFnJeH3+islwVr9CjTjig4f2s
	EaxTi4Sumfpb9x3k+itAzEaEg0TlfYXEV6DwNvJPaQ5V7XWYS1jhvIgiGXZ7XXA==
X-Google-Smtp-Source: AGHT+IELVvANjEhqqcjkLNs9WsmUy/QSqVrWLH8zVK0l5Ev/B9XwevmzGtfFScDhkJdeamgFlE4M0w==
X-Received: by 2002:a05:6a00:189a:b0:776:20c2:d58b with SMTP id d2e1a72fcca58-780fced5d67mr5963954b3a.24.1758830384245;
        Thu, 25 Sep 2025 12:59:44 -0700 (PDT)
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com. [209.85.216.49])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-78102b22f5fsm2689368b3a.53.2025.09.25.12.59.40
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Sep 2025 12:59:41 -0700 (PDT)
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-32eb76b9039so1613682a91.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 12:59:40 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVev1h+O360rg/+dett4rJDAXvTg07NhcAubroQ+OKXs43jAlD0X6rLBNq2zfjvNY1PO0bmFZnmQVEh8kU=@vger.kernel.org
X-Received: by 2002:a17:90b:538e:b0:32e:18b2:5a45 with SMTP id
 98e67ed59e1d1-3342a20b94dmr4932192a91.5.1758830380238; Thu, 25 Sep 2025
 12:59:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250925084806.89715-1-cuiyunhui@bytedance.com> <20250925084806.89715-2-cuiyunhui@bytedance.com>
In-Reply-To: <20250925084806.89715-2-cuiyunhui@bytedance.com>
From: Doug Anderson <dianders@chromium.org>
Date: Thu, 25 Sep 2025 12:59:28 -0700
X-Gmail-Original-Message-ID: <CAD=FV=VZLYqPQCOEhbH4QtndeG5e1-0wey24fgYNTeFiqd8qJg@mail.gmail.com>
X-Gm-Features: AS18NWBiujTv-FGvPpgY3gBOBVEPrJ77epiIZ9CDp8xRQDwQ7FOMR9gCNXwR3xI
Message-ID: <CAD=FV=VZLYqPQCOEhbH4QtndeG5e1-0wey24fgYNTeFiqd8qJg@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] watchdog: move arm64 watchdog_hld into common code
To: Yunhui Cui <cuiyunhui@bytedance.com>
Cc: akpm@linux-foundation.org, alex@ghiti.fr, anup@brainfault.org, 
	aou@eecs.berkeley.edu, atish.patra@linux.dev, catalin.marinas@arm.com, 
	johannes@sipsolutions.net, lihuafei1@huawei.com, mark.rutland@arm.com, 
	masahiroy@kernel.org, maz@kernel.org, mingo@kernel.org, 
	nicolas.schier@linux.dev, palmer@dabbelt.com, paul.walmsley@sifive.com, 
	suzuki.poulose@arm.com, thorsten.blum@linux.dev, wangjinchao600@gmail.com, 
	will@kernel.org, yangyicong@hisilicon.com, zhanjie9@hisilicon.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Sep 25, 2025 at 1:48=E2=80=AFAM Yunhui Cui <cuiyunhui@bytedance.com=
> wrote:
>
> @@ -17,6 +17,7 @@
>  #include <linux/cpu_pm.h>
>  #include <linux/export.h>
>  #include <linux/kernel.h>
> +#include <linux/nmi.h>
>  #include <linux/perf/arm_pmu.h>
>  #include <linux/slab.h>
>  #include <linux/sched/clock.h>
> @@ -696,10 +697,12 @@ static int armpmu_get_cpu_irq(struct arm_pmu *pmu, =
int cpu)
>         return per_cpu(hw_events->irq, cpu);
>  }
>
> -bool arm_pmu_irq_is_nmi(void)
> +#ifdef CONFIG_HARDLOCKUP_DETECTOR_PERF
> +bool arch_perf_nmi_is_available(void)
>  {
>         return has_nmi;
>  }
> +#endif

Should the previous comment move here, AKA:

/*
 * hardlockup_detector_perf_init() will success even if Pseudo-NMI turns of=
f,
 * however, the pmu interrupts will act like a normal interrupt instead of
 * NMI and the hardlockup detector would be broken.
*/


> +static int __init init_watchdog_freq_notifier(void)
> +{
> +       return cpufreq_register_notifier(&watchdog_freq_notifier,
> +                                        CPUFREQ_POLICY_NOTIFIER);

I think you need to do something to prevent this from happening on any
platforms that override hw_nmi_get_sample_period(), right? These
cpufreq notifiers will be useless in that case...


-Doug

