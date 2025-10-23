Return-Path: <linux-kernel+bounces-867310-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 74A5DC02380
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 17:45:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7053E1AA2473
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 15:46:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C490223AB90;
	Thu, 23 Oct 2025 15:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZedjYDZp"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74BD21D514B
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 15:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761234351; cv=none; b=k7IcaFyXgbxOiVgAUptDG3MuTuE3fwzT+CpzJf8Mg5dzK/7IRnUw9N3o8sPjp7ZR5Nd4Hx6g3eALAlk/BVIr6GMSCHSBVotd5aqjVlm4EWDrWZ5e+juWSexwS/go8nIZXMHQXUqAHRRu2+XmVizi+X+q+F5NCczB/ZcD9hMa02I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761234351; c=relaxed/simple;
	bh=WpbcaF8x2sasj+ApAXCwoMuJpqNIfGogMerrRKXqC4s=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=iILNNheYUXNLkVwTnSuOOcO7hb5XpMgtxwWVz4wEPiMh9d0/pcbVwL3TkKuv71yswdfl6UeqNen4ih/h2v6YCjDSYSG0dm66eXVa2DV1i3MhaAnXMpTUNFekZqVjROMdRZcOLy4dqvrEbJ/YUIUKZYFmilY1BtH4JO0oPrzwzlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZedjYDZp; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761234346;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=50SfSxS4nKgs8hxb+bOC3hzEIaH0AgAoPcaR+jSb2yk=;
	b=ZedjYDZp1IFEy1Azf72R8spjexepm0UyKY4hiC9MaNrUMfHkoT22XiR7QnTQHZ0yML1GQS
	TQNQqFFCOqElgqs2xMEoLO8+rUnnYBzQ7+YydbSEECAsgkiMANjdSWLprEvyyJgToyqubI
	BZ0LvoHvPRr4cSeV9LSKxhnHzfMonFY=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-625-mNIfWDWBOR-XVbBFT31C2g-1; Thu, 23 Oct 2025 11:45:45 -0400
X-MC-Unique: mNIfWDWBOR-XVbBFT31C2g-1
X-Mimecast-MFC-AGG-ID: mNIfWDWBOR-XVbBFT31C2g_1761234343
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-46eee58d405so6544655e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 08:45:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761234343; x=1761839143;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=50SfSxS4nKgs8hxb+bOC3hzEIaH0AgAoPcaR+jSb2yk=;
        b=WwmvBylgDjVI5dkl30h/HWth1m86/jiS+Q3ggNT9hUjH+sNEEjpQJIfe6eeV3aaOzR
         pB7b7W8HJ5rnI3+uR7iWSq5+9za4d/rsveRfjVVISNxt3RqEG1SKqKr2+9hVnGX6b49A
         qpuBcPinJOPd5s16I3YDh0EsLbPo1QQe8nSprTfBhPlf7YbHoOMs+xQkSp5NPmgxnjC7
         XvOvqLvZubetUOCxIUBv2m7uWqomwR6gWTV1duU2RFMMdrOSbmdcKFBYx4CrwuleJbK/
         paEll3sc5iSRhu8XUO75pmJuDo9PHLj4ukUmhmyDuMI0Kkq6Wmep7XFilRfRMfhh5a7P
         cNAA==
X-Forwarded-Encrypted: i=1; AJvYcCVL+VwBVZM4/rlOdImsI5PMhFe+8oasW4iVCbI9Esn+TYtcaDDl2A72JVI1H0MUu1O7hzVNRG5SCR9D4hE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwpKcuP17Z+sbgvG3cE5pqHUcAksUZQuSVY413Gzrv5rijAg9id
	xiAcJMbJ3/iHqHQ0VDr7eJq/yIrOTDapQYWBUoXdw8X//b3zHNc83Fr7tpDJhezksmOuVyU8Knm
	OFn4fRhH5wGO1e+dZYvyVtX1JlnZormmyQqYo48fARE57ZgK38t55dGugtruy8uNHsQ==
X-Gm-Gg: ASbGncv/Ct5e+/FTJrTrd89TZtEsVJiQrvMu5y3C/SzwtWNRwAsk4zv7cyzrgWVgIax
	8NzAJZJFd9yWqBxqSh86mpqwaJzujPRwn8lwBnRyJCb+I0zAtSuX+23iD/7M7xQpECLzM+N+3F+
	n+Cf+75MOSLtF5wlc/7KVWx2gIbsekKrsg7IRTS06xMXwV0BhYQI4j0yhEQL49WKCFa+JFsPEYk
	+NwCKrTFXBjFFDBxb7UmjxuNX6cwXh/AZhyVuVPkEGo8nF9osRXMuOmhs1vbD9r1Ddzt7gwI4q2
	IBVC+9PFn3kzPFcpVhxYUeGzjaqA5ORhm0hE/NUXrwM/2lwyXTs7CKCjDXTxD+8fgligGLq38N5
	oBuV7RWjOYhP3xnzb6OP/79uBxsXdxZazD9wrUyo/PGZqyR1ukLOTUQLU21PD
X-Received: by 2002:a05:600c:548a:b0:46e:6d5f:f68 with SMTP id 5b1f17b1804b1-4711787a2cdmr173963815e9.12.1761234342953;
        Thu, 23 Oct 2025 08:45:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IENvjJfnRqlEPVbQJG/5+2SRFe/+XvUSWY4e9vS8wIYZ+gnFtpWxD3L8rMa8r5ek+Ptfbuv2w==
X-Received: by 2002:a05:600c:548a:b0:46e:6d5f:f68 with SMTP id 5b1f17b1804b1-4711787a2cdmr173963305e9.12.1761234342435;
        Thu, 23 Oct 2025 08:45:42 -0700 (PDT)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (213-44-135-146.abo.bbox.fr. [213.44.135.146])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-475cad4c81dsm44883515e9.0.2025.10.23.08.45.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Oct 2025 08:45:41 -0700 (PDT)
From: Valentin Schneider <vschneid@redhat.com>
To: Frederic Weisbecker <frederic@kernel.org>, LKML
 <linux-kernel@vger.kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>, Michal =?utf-8?Q?Koutn?=
 =?utf-8?Q?=C3=BD?=
 <mkoutny@suse.com>, Andrew Morton <akpm@linux-foundation.org>, Bjorn
 Helgaas <bhelgaas@google.com>, Catalin Marinas <catalin.marinas@arm.com>,
 Danilo Krummrich <dakr@kernel.org>, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Gabriele Monaco
 <gmonaco@redhat.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Ingo Molnar <mingo@redhat.com>, Jakub Kicinski <kuba@kernel.org>, Jens
 Axboe <axboe@kernel.dk>, Johannes Weiner <hannes@cmpxchg.org>, Lai
 Jiangshan <jiangshanlai@gmail.com>, Marco Crivellari
 <marco.crivellari@suse.com>, Michal Hocko <mhocko@suse.com>, Muchun Song
 <muchun.song@linux.dev>, Paolo Abeni <pabeni@redhat.com>, Peter Zijlstra
 <peterz@infradead.org>, Phil Auld <pauld@redhat.com>, "Rafael J . Wysocki"
 <rafael@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, Shakeel
 Butt <shakeel.butt@linux.dev>, Simon Horman <horms@kernel.org>, Tejun Heo
 <tj@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Vlastimil Babka
 <vbabka@suse.cz>, Waiman Long <longman@redhat.com>, Will Deacon
 <will@kernel.org>, cgroups@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-block@vger.kernel.org,
 linux-mm@kvack.org, linux-pci@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH 05/33] sched/isolation: Save boot defined domain flags
In-Reply-To: <20251013203146.10162-6-frederic@kernel.org>
References: <20251013203146.10162-1-frederic@kernel.org>
 <20251013203146.10162-6-frederic@kernel.org>
Date: Thu, 23 Oct 2025 17:45:40 +0200
Message-ID: <xhsmhecqtoc4b.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 13/10/25 22:31, Frederic Weisbecker wrote:
> HK_TYPE_DOMAIN will soon integrate not only boot defined isolcpus= CPUs
> but also cpuset isolated partitions.
>
> Housekeeping still needs a way to record what was initially passed
> to isolcpus= in order to keep these CPUs isolated after a cpuset
> isolated partition is modified or destroyed while containing some of
> them.
>
> Create a new HK_TYPE_DOMAIN_BOOT to keep track of those.
>
> Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> Reviewed-by: Phil Auld <pauld@redhat.com>
> ---
>  include/linux/sched/isolation.h | 1 +
>  kernel/sched/isolation.c        | 5 +++--
>  2 files changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/include/linux/sched/isolation.h b/include/linux/sched/isolation.h
> index d8501f4709b5..da22b038942a 100644
> --- a/include/linux/sched/isolation.h
> +++ b/include/linux/sched/isolation.h
> @@ -7,6 +7,7 @@
>  #include <linux/tick.h>
>
>  enum hk_type {
> +	HK_TYPE_DOMAIN_BOOT,
>       HK_TYPE_DOMAIN,
>       HK_TYPE_MANAGED_IRQ,
>       HK_TYPE_KERNEL_NOISE,
> diff --git a/kernel/sched/isolation.c b/kernel/sched/isolation.c
> index a4cf17b1fab0..8690fb705089 100644
> --- a/kernel/sched/isolation.c
> +++ b/kernel/sched/isolation.c
> @@ -11,6 +11,7 @@
>  #include "sched.h"
>
>  enum hk_flags {
> +	HK_FLAG_DOMAIN_BOOT	= BIT(HK_TYPE_DOMAIN_BOOT),
>       HK_FLAG_DOMAIN		= BIT(HK_TYPE_DOMAIN),
>       HK_FLAG_MANAGED_IRQ	= BIT(HK_TYPE_MANAGED_IRQ),
>       HK_FLAG_KERNEL_NOISE	= BIT(HK_TYPE_KERNEL_NOISE),
> @@ -216,7 +217,7 @@ static int __init housekeeping_isolcpus_setup(char *str)
>
>               if (!strncmp(str, "domain,", 7)) {
>                       str += 7;
> -			flags |= HK_FLAG_DOMAIN;
> +			flags |= HK_FLAG_DOMAIN | HK_FLAG_DOMAIN_BOOT;
>                       continue;
>               }
>
> @@ -246,7 +247,7 @@ static int __init housekeeping_isolcpus_setup(char *str)
>
>       /* Default behaviour for isolcpus without flags */
>       if (!flags)
> -		flags |= HK_FLAG_DOMAIN;
> +		flags |= HK_FLAG_DOMAIN | HK_FLAG_DOMAIN_BOOT;

I got stupidly confused by the cpumask_andnot() used later on since these
are housekeeping cpumasks and not isolated ones; AFAICT HK_FLAG_DOMAIN_BOOT
is meant to be a superset of HK_FLAG_DOMAIN - or, put in a way my brain
comprehends, NOT(HK_FLAG_DOMAIN) (i.e. runtime isolated cpumask) is a
superset of NOT(HK_FLAG_DOMAIN_BOOT) (i.e. boottime isolated cpumask),
thus the final shape of cpu_is_isolated() makes sense:

  static inline bool cpu_is_isolated(int cpu)
  {
          return !housekeeping_test_cpu(cpu, HK_TYPE_DOMAIN);
  }

Could we document that to make it a bit more explicit? Maybe something like

  enum hk_type {
        /* Set at boot-time via the isolcpus= cmdline argument */
        HK_TYPE_DOMAIN_BOOT,
        /*
         * Updated at runtime via isolated cpusets; strict subset of
         * HK_TYPE_DOMAIN_BOOT as it accounts for boot-time isolated CPUs.
         */
        HK_TYPE_DOMAIN,
        ...
  }


