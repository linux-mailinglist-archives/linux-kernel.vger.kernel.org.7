Return-Path: <linux-kernel+bounces-893753-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0FB3C4841D
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 18:17:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 32F2E422EA3
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 17:09:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 462AA3043A5;
	Mon, 10 Nov 2025 17:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PNeR0wvt";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="oUz+Oxo8"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AD932FFFB6
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 17:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762794552; cv=none; b=PCIBnBaOMW/MnXdx41oUDDPVdcP67Kw5zki4139y9/qZS+2BJnuUB2/lA3SMeUkZsNuK3KyxqN3qo25PPPYsP7MQ+XR3Dnkh+CRoAgfCXwmlL9Ip+VoJY+458Ys492INrig9ycTAa2/Ad3h6gMRjYi4gPdVpB19/LaqAnuDFXGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762794552; c=relaxed/simple;
	bh=y919u5LpJ/ng2ULs0nXVXtfDEME3QQNPvsxBqatTXGE=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=VaOOIeE32BLmSdulelIna/+fCd/762fk0xxNWypisByTXT9M70tRSoqwapD/dNq+NECqk9XCmduLRHZ7Cxsbvip+wgJXJQu7amyyaY0MwccnjxyVN9VxX+p1SYXfk+zcGW/1KugEa+RF5CBsTxZeXiYJF7ETz5i01kb20DBoj5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PNeR0wvt; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=oUz+Oxo8; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762794549;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=y919u5LpJ/ng2ULs0nXVXtfDEME3QQNPvsxBqatTXGE=;
	b=PNeR0wvt2WwxLdCYOivzg4uekIBE55+Uj6autn6zyj1kZr4eMvUUMpG/nHcaU3J+26aqe+
	fTvx2WnxNoNZEvmnhB9wG5+USAY9yCTlj5cJPUErdd4usyreIL+U1SKY127272HXbP0HkB
	tf++qiFCJ3AL2AOJwcFOcTcLU9drwaY=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-643-jWSxuwj1PUmvCBiLlKd1hw-1; Mon, 10 Nov 2025 12:09:06 -0500
X-MC-Unique: jWSxuwj1PUmvCBiLlKd1hw-1
X-Mimecast-MFC-AGG-ID: jWSxuwj1PUmvCBiLlKd1hw_1762794545
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-477563e531cso39627695e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 09:09:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1762794545; x=1763399345; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y919u5LpJ/ng2ULs0nXVXtfDEME3QQNPvsxBqatTXGE=;
        b=oUz+Oxo81kiNJqL5EjUlDxFsdgX5aQUeQKzVw3+JVaXz2+61AEK1AI/b78JPVY2OjX
         RaVCzyrcFAUNeyLYRvyu3pyACMphVSTgX6XhkQw81jSC5TRU+Ag2mTu3xg1vZ6+k9k83
         NtADh4ZSSjAL3OfkgI6Ki7JQPJXppstQvLbXYUlCytLeco4tRH/a7bM3bllXWcOwQChS
         3gMkU4/bYP51if773sk+fxyOXUiP8kL5FtAGPiavjFUwjXZqyoGox1zlcoH4vcZy/YkN
         gaY6ylEcwjFWRXfuATd65eAH6erE7WeBqS89b0Cub+zMLIfFiO0IWDVN5X1tCU0WCwxH
         k6aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762794545; x=1763399345;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=y919u5LpJ/ng2ULs0nXVXtfDEME3QQNPvsxBqatTXGE=;
        b=UyTlmkY+8z2SGWH/W35+B6smiqn5bIp81oqo7id2wQ8tYwvIAzTTHkA9b7G0WS96Ir
         g2wgIh6495jg0zw9AE3p0oqWOlU6K5CnJHniHjcKMkeGivuqans2KD4qjFefRMW2iE82
         WKblxnGPqmiWaZpw8YwOkYlkX/0m5AWoh8aMj5+wo8R9ARW5jdeTslVOlP1+KrD//c6Q
         SJszjZpeebcr5TSNYy56BnGqSySSF3gy82XPH4X4eil9oGpGF26VGpASyPVUKS+DvobF
         MI7BnCUnkrj7wVZBFgqDlmOX7c9zhd0NGCkvb4IaxQEfOrkTHMMLkbqv+lcbfBRrfC/R
         5eDA==
X-Gm-Message-State: AOJu0Ywy1neVFIbp/aMPJ9F+8VPCrXSkDovtUtW4SIvrdcUaUU39bKwS
	gNis61ebi14oG4RrycqL9+/ac0feeJfm4l1VZtVUH5qNMvAiG0sf3TyyZtwihbMUl2JTmWfQory
	YegKEWYyqeoTWjZBrUjfGO/5g3HeqFfSxWdMzCFOTLQFk8npwj+6EMNUsuBmWeWqPhQ==
X-Gm-Gg: ASbGncuC6SKUh/HpOthdnDyfM/pidMESB6bD0ok7OceNT7ZCBfN0scdSUTyE/f7lq6I
	ZN4sCYYKUuU8Ext9i9xKtUJJZ6bm+Pr74LhEncCXpF10+8Fqu45p+ZsxiImn6nKzZm5UNiL+2Iz
	b4MCXNFEbXfil5tGNeXGfN8J6L67P3mofJMej/ko5VJ80Mc5eJXDQLzI5WmOIvFdUyVsSDqfiZL
	jQvo5AOD4x7LDHjXDV4IRNEF0ZdC0ndPrPS6jblEdvJyblJaFQcbchsVwTWJP8HWPHGdg1RXQEu
	eOAO3nSKZWFTdYoPdPGczjHQgEzs1Crky82bGf++2X4Q5XLY4FXRMmTQwiuY9qkfuH+asHDb
X-Received: by 2002:a05:600c:4f94:b0:46e:48fd:a1a9 with SMTP id 5b1f17b1804b1-47773293992mr86093135e9.33.1762794544745;
        Mon, 10 Nov 2025 09:09:04 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGZg5/RAVSkqkpDICudKn+ff9OeOo9p+414Q06CSsgaxuUoNodwPLbkil89LoGQFNp/u5NXeQ==
X-Received: by 2002:a05:600c:4f94:b0:46e:48fd:a1a9 with SMTP id 5b1f17b1804b1-47773293992mr86092695e9.33.1762794544297;
        Mon, 10 Nov 2025 09:09:04 -0800 (PST)
Received: from [127.0.0.1] ([195.174.132.194])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4777f1b61acsm33575555e9.3.2025.11.10.09.09.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Nov 2025 09:09:03 -0800 (PST)
Date: Mon, 10 Nov 2025 17:09:01 +0000 (UTC)
From: Gabriele Monaco <gmonaco@redhat.com>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Michael Jeanson <mjeanson@efficios.com>,
	Jens Axboe <axboe@kernel.dk>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	"Gautham R. Shenoy" <gautham.shenoy@amd.com>,
	Florian Weimer <fweimer@redhat.com>, Tim Chen <tim.c.chen@intel.com>,
	Yury Norov <yury.norov@gmail.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>
Message-ID: <d6848897-f918-44ff-bf1c-393ad855b4c1@redhat.com>
In-Reply-To: <20251029123717.886619142@linutronix.de>
References: <20251029123717.886619142@linutronix.de>
Subject: Re: [patch V3 00/20] sched: Rewrite MM CID management
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Correlation-ID: <d6848897-f918-44ff-bf1c-393ad855b4c1@redhat.com>

2025-10-29T13:09:04Z Thomas Gleixner <tglx@linutronix.de>:

> This is a follow up on V2 series which can be found here:
>

I confirm this series passes the selftest in [1] consistently and the obser=
ved latency spikes caused by task_mm_cid_work are gone.

Tested-by: Gabriele Monaco <gmonaco@redhat.com>

Thanks,
Gabriele

[1] - https://lore.kernel.org/lkml/20250929114225.36172-5-gmonaco@redhat.co=
m

> =C2=A0=C2=A0=C2=A0 https://lore.kernel.org/20251022104005.907410538@linut=
ronix.de
>
> The V1 cover letter contains a detailed analyisis of the issues:
>
> =C2=A0=C2=A0=C2=A0 https://lore.kernel.org/20251015164952.694882104@linut=
ronix.de
>
> TLDR: The CID management is way to complex and adds significant overhead
> into scheduler hotpaths.
>
> The series rewrites MM CID management in a more simplistic way which
> focusses on low overhead in the scheduler while maintaining per task CIDs
> as long as the number of threads is not exceeding the number of possible
> CPUs.
>
> The series is based on the V6 series of the rseq rewrite:
>
> =C2=A0=C2=A0=C2=A0 https://lore.kernel.org/20251027084220.785525188@linut=
ronix.de
>
> which is also available from git:
>
> =C2=A0=C2=A0=C2=A0 git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.=
git core/rseq
>
> The series on top of the tip core/rseq branch is available from git as
> well:
>
> =C2=A0=C2=A0=C2=A0 git://git.kernel.org/pub/scm/linux/kernel/git/tglx/dev=
el.git rseq/cid
>
> Changes vs. V2:
>
> =C2=A0=C2=A0 - Rename to cpumask/bitmap_weighted_or() - Yury
>
> =C2=A0=C2=A0 - Zero the bitmap with length of bitmap_size(nr_possible_cpu=
s()) -
> =C2=A0=C2=A0=C2=A0=C2=A0 Shrikanth
> =C2=A0=C2=A0
> =C2=A0=C2=A0 - Move cpu_relax() out of for() as that fails to build when =
cpu_relax()
> =C2=A0=C2=A0=C2=A0=C2=A0 is a macro. - Shrikanth
>
> =C2=A0=C2=A0 - Picked up Reviewed/Acked-by tags where appropriate
>
> Thanks,
>
> =C2=A0=C2=A0=C2=A0 tglx
> ---
> Thomas Gleixner (20):
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sched/mmcid: Revert the complex CID manage=
ment
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sched/mmcid: Use proper data structures
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sched/mmcid: Cacheline align MM CID storag=
e
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sched: Fixup whitespace damage
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sched/mmcid: Move scheduler code out of gl=
obal header
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sched/mmcid: Prevent pointless work in mm_=
update_cpus_allowed()
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cpumask: Introduce cpumask_weighted_or()
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sched/mmcid: Use cpumask_weighted_or()
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cpumask: Cache num_possible_cpus()
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sched/mmcid: Convert mm CID mask to a bitm=
ap
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 signal: Move MMCID exit out of sighand loc=
k
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sched/mmcid: Move initialization out of li=
ne
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sched/mmcid: Provide precomputed maximal v=
alue
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sched/mmcid: Serialize sched_mm_cid_fork()=
/exit() with a mutex
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sched/mmcid: Introduce per task/CPU owners=
hip infrastrcuture
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sched/mmcid: Provide new scheduler CID mec=
hanism
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sched/mmcid: Provide CID ownership mode fi=
xup functions
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 irqwork: Move data struct to a types heade=
r
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sched/mmcid: Implement deferred mode chang=
e
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sched/mmcid: Switch over to the new mechan=
ism
>
> include/linux/bitmap.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=
=C2=A0=C2=A0 15
> include/linux/cpumask.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=
=C2=A0 26 +
> include/linux/irq_work.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=
=A0=C2=A0 9
> include/linux/irq_work_types.h |=C2=A0=C2=A0 14
> include/linux/mm_types.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 125 =
------
> include/linux/rseq.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 |=C2=A0=C2=A0 27 -
> include/linux/rseq_types.h=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 71 +++
> include/linux/sched.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 |=C2=A0=C2=A0 19
> init/init_task.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0 3
> kernel/cpu.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 15
> kernel/exit.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0 1
> kernel/fork.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0 7
> kernel/sched/core.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 |=C2=A0 815 +++++++++++++++++++----------------------
> kernel/sched/sched.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 |=C2=A0 395 ++++++++-----------
> kernel/signal.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0 2
> lib/bitmap.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0 6
> 16 files changed, 727 insertions(+), 823 deletions(-)


