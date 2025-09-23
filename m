Return-Path: <linux-kernel+bounces-828786-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C43BB9573E
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 12:39:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C4D31904C29
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 10:39:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B316321284;
	Tue, 23 Sep 2025 10:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nT2+MJ23"
Received: from mail-ej1-f67.google.com (mail-ej1-f67.google.com [209.85.218.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AFE7249E5
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 10:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758623946; cv=none; b=YGFIEYggQ9xblLqLEcIx9wxgM7gR+NEdprtilKRkGKKAezqoM2B5jH4b+qiLJM2z5vywe7SgUaJtQl7JVMCSnfRLJH0pRruy+yxrkGbM9IdIz5z7ylPSltgSM9d66EvbUtHZHnrTrNTazvAS6I8lsBd7K4NMKCi6tfNPf+Nwc4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758623946; c=relaxed/simple;
	bh=9I+UfsvIx+bsD4niyYaXYH6gHpsHBUv5FFHGyAAC3ts=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AaN5Bh3EzJqZPU2DKSDjKVnwjQm6fwVpcnTwygWByx/u5xxYt3GDFyw0ytYDaxflx82B2XUiLaf18jndFyxpCma1B5uStbDHc1QD7c3Dr/KS0tHH+8fA52wrrvFlqdx+YzEWTYEWfzcM2PF3rWwwoJg8U0w4czKf1wn6Q8HQnW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nT2+MJ23; arc=none smtp.client-ip=209.85.218.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f67.google.com with SMTP id a640c23a62f3a-b2ee3c13aa4so204290966b.3
        for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 03:39:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758623943; x=1759228743; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=NnfkqnOJdsB0bfPkZ1igYkNhvejCpYg0U/vTuy5A1tc=;
        b=nT2+MJ239mkEhxzL9DGGySSasGJpZLCQSNir6/+yLIlKcd3SK0x2llDZG1nLO3ePfI
         82p6JldTotKKz7V95gBUDkfXHkWBI0fs3Cp5VHe5L444xVM6oOPEjv/Qflcc3+fg8G75
         02UJECVuxS2IaXqT9p6Xh02a8qZMvzy/KEMs/whgbcE+cp5RztYoKoIpoE9h0F/ohw3p
         bo+SnXDb4j2MA0X1dST3JUZtBsb1fKCL8Lw4BOq9RMroJgJ/LFdyN0hap8Jh48Z+kL6d
         1O85KQ7v+7bsbveMm/NZxc8R1In5jFcR1/3qPJt5Y5jvDqmWJBpGDNbwvivZ5shazTwe
         DaSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758623943; x=1759228743;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NnfkqnOJdsB0bfPkZ1igYkNhvejCpYg0U/vTuy5A1tc=;
        b=bNsMpe/xYGavNX7YcbRa2/VQfK3H/6Mf5XrIkN6qx0rlklGhZcT0o3K0/hQH+OHwcr
         JekPMv5vMns2zE3ULleD77VkEwdp/aJ84u2NZezElPSttlOzRu12qdUR3BpcAjaz+Drk
         ry0USZyr24dWRCLNnGYg5+YLmwQA2udKwmaek9eOFNvJwXWs/v9bzDL9BQj2ueWmXGIz
         h56kHMUip3L2tBwsGN5LCQ0gfJR+FROqjPRniHCCK26wTyVtKGA80iE+7ERz+0RKPOKt
         Nscn7VTd2J1gxld59fVP1xccJ+gsXgEDDlvDpAwagzdcX4vEbsS7CtOLbGpQqClsL7k4
         /Tsg==
X-Forwarded-Encrypted: i=1; AJvYcCV+SRD6jmznH9oBYaKG8y4fRcGyVBcFpjdVPmo7aMDlfXBM1kQHI0z7b0qpxpnAmdM7NjaE2zD42ZaXY/c=@vger.kernel.org
X-Gm-Message-State: AOJu0YzckP3JvYpFfsO8XEG0Ix0q6GOLqZEMMu3FyQBiCDg6FNkpGt1O
	GwdG3zsEPTX9VWPSjV6UH6DkfVyYwqPMLeWajt8xHCkcHdEB3YkHzyzxTJX+jwJ9FD2YNIU1cmt
	qH9T1yBGagdfQi0YEoLDTnIrIqBC0SLo=
X-Gm-Gg: ASbGncsoeH5vJIzenyyLMbWDSX2yzx8wzIKCS2AancIiK3QSqsu8cK8Nc5bnvw8p2wM
	Zr6j3JMyVuf/2G+OTTJKm/CqRzYw0FBM92GfOE99vrjqMdppcF5DIa/42I1M3IePeo5TejApdRq
	lQIaSA2rRcWDnEbjCOjaA6qEFRLIDF9BRLgU7JzUhmUTxtxbaaccepJuV9PEPl6oqOdwpd6Y00g
	z8XPbYCmQ==
X-Google-Smtp-Source: AGHT+IGe8BueWIvyXCDLHwL8VpMfxPGaA/c+GGWafGvE2t67inmTkzI9pV52mWfvHL17NVaKT6Khw4wvn8Yi5AG6Q3o=
X-Received: by 2002:a17:907:9484:b0:b2e:4ab2:485f with SMTP id
 a640c23a62f3a-b302c10a345mr210661066b.53.1758623943305; Tue, 23 Sep 2025
 03:39:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250923091634.118240-1-arighi@nvidia.com>
In-Reply-To: <20250923091634.118240-1-arighi@nvidia.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Tue, 23 Sep 2025 12:38:26 +0200
X-Gm-Features: AS18NWBYse4BMQwVtmlQ_EXCFADp-5s0Or4bp9_W7wncLZyqeCwKDe4OHa96rDU
Message-ID: <CAP01T75_tsZoGX0SghGtO5V6LJOkDEMDcocWHZwoOpXmS7cK9w@mail.gmail.com>
Subject: Re: [PATCH] sched_ext: Verify RCU protection in scx_bpf_cpu_curr()
To: Andrea Righi <arighi@nvidia.com>
Cc: Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>, 
	Changwoo Min <changwoo@igalia.com>, Christian Loehle <christian.loehle@arm.com>, 
	sched-ext@lists.linux.dev, bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 23 Sept 2025 at 11:16, Andrea Righi <arighi@nvidia.com> wrote:
>
> scx_bpf_cpu_curr() has been introduced to retrieve the current task of a
> given runqueue, allowing schedulers to interact with that task.
>
> The kfunc assumes that it is always called in an RCU context, but this
> is not always guaranteed and some BPF schedulers can trigger the
> following warning:
>
>   WARNING: suspicious RCU usage
>   sched_ext: BPF scheduler "cosmos_1.0.2_gd0e71ca_x86_64_unknown_linux_gnu_debug" enabled
>   6.17.0-rc1 #1-NixOS Not tainted
>   -----------------------------
>   kernel/sched/ext.c:6415 suspicious rcu_dereference_check() usage!
>   ...
>  Call Trace:
>   <IRQ>
>   dump_stack_lvl+0x6f/0xb0
>   lockdep_rcu_suspicious.cold+0x4e/0x96
>   scx_bpf_cpu_curr+0x7e/0x80
>   bpf_prog_c68b2b6b6b1b0ff8_sched_timerfn+0xce/0x1dc
>   bpf_timer_cb+0x7b/0x130
>   __hrtimer_run_queues+0x1ea/0x380
>   hrtimer_run_softirq+0x8c/0xd0
>   handle_softirqs+0xc9/0x3b0
>   __irq_exit_rcu+0x96/0xc0
>   irq_exit_rcu+0xe/0x20
>   sysvec_apic_timer_interrupt+0x73/0x80
>   </IRQ>
>   <TASK>
>
> To address this, mark the kfunc with KF_RCU_PROTECTED, so the verifier
> can enforce its usage only inside RCU-protected sections.
>
> Note: this also requires commit 1512231b6cc86 ("bpf: Enforce RCU protection
> for KF_RCU_PROTECTED"), currently in bpf-next, to enforce the proper
> KF_RCU_PROTECTED.
>
> Fixes: 20b158094a1ad ("sched_ext: Introduce scx_bpf_cpu_curr()")
> Cc: Christian Loehle <christian.loehle@arm.com>
> Cc: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> Signed-off-by: Andrea Righi <arighi@nvidia.com>
> ---

Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>

