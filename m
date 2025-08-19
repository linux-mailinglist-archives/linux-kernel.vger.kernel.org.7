Return-Path: <linux-kernel+bounces-775932-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C212EB2C68B
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 16:06:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8091C1B65FCE
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 14:02:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A82AF1EF09B;
	Tue, 19 Aug 2025 14:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aNTR3hrb"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6992D1C860C
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 14:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755612131; cv=none; b=kkMWXb4ivS4ZkpGFKC7KV3asuvBzcPK9qe6vV8bTOwuTTWYsWGrX79MTB/qutVhLBzJyYBLxCL8HZhVHPDLCRdDckSkDs+Y8CS3eqOwAlDrVlL5PjpP3vTuDNLnJP4601RVwTGjLgpj2a0cinwkIejOp6EZSZEuWBMVLzOrfk0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755612131; c=relaxed/simple;
	bh=u/W0QB+0+qwLb9l8SQ7tWOO6IKOaU3JEPYtfuUqoLpA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=q4KGzcV0GaRgF7gK/HCVGkh6KrRmq/BK/eXie+M2fn78z25rXww/Q/1FKAgwOPMxy+HgT1askXv8MPHDtkuz+vrWag1TadDvu7bqJdK8wWEKR3ZxSao7OKKc293bnPVmHUf1zadU+Yv38LuAYBY3DucMw5QM2diM8WGEtGlXhr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aNTR3hrb; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755612128;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=u/W0QB+0+qwLb9l8SQ7tWOO6IKOaU3JEPYtfuUqoLpA=;
	b=aNTR3hrbSM9Uu02woIi3UkQiY6TENh8MjOXDZhNV55S51LD+FTuzMuSLfYiAoLeIuSkEjl
	ECxEU5I/Xleke/4X1AJYyO2VH/HIEJgequFR+QqzpAsDR60sSt/GXb8oc4S2eos/blTr5+
	v9iISKwHm3lzXevRxMLxz7Mj4NszpzM=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-139-6w1vN0VmOQO0chawpvCSuw-1; Tue, 19 Aug 2025 10:00:09 -0400
X-MC-Unique: 6w1vN0VmOQO0chawpvCSuw-1
X-Mimecast-MFC-AGG-ID: 6w1vN0VmOQO0chawpvCSuw_1755612009
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4b109c5457cso153169141cf.3
        for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 07:00:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755612009; x=1756216809;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=u/W0QB+0+qwLb9l8SQ7tWOO6IKOaU3JEPYtfuUqoLpA=;
        b=cbMiPhtAFPMg8YVwomy/CI31dNgoHDnEbNQ6LUFexEdbZNv9VcbEeuf+MWK2KKwxXh
         t4HmIBf2SznXIiWFpdgnUH/XJcmKVK2sLQUKv/1RBAT1Awlgn4p8/xJ0YxCWpYe9vl9c
         bAYPkuVnjAs3fS5uaCtiViS2lSKUMwGBLz0UxGmSEd/e5JEISENbG7WOlwGpnyRqgHob
         J4MoTmzKOEAkpFMwYe1nA+reE9iMFqjCONTHwlTUCZEwOCi5XPu5JejmEA9iH47I81pt
         G+3gPnsQQBuPUPY81SVbrKAswBkxCGpSbp84sJTtnKTUtU2I1Tmp+YeXSWW4NthDw+hh
         2VhA==
X-Forwarded-Encrypted: i=1; AJvYcCWGMjBeL8LLNHqR6EtY4i86hK8Q5mrANto4t9IbADikCRy7Y0liMvGr3muT2hYZSJEy4wPs4zidqgFc6O0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHg+fuMF/abk7pN0jWTAyM7iY05QxdXSt9c//mWn1iTyYWf1qr
	ve/gj37Mriz/KlIjzEYoJ9jvkua8ltaPzbtZaEucQkbEuD2U0AwKC0cGCLCzRd/7EwNNqxnw0ji
	EXbgiVkI2WfNgq9q4AN9PihNV+lbbC585tqxu6PuQAGM0E6BnQve2a9Fnr5tClNahDQ==
X-Gm-Gg: ASbGncv4B0xYOdcI2au2aqcmL3RPmGJgHJp5W9czqmHxtDo0tdkWPk8i9SjqYfA1eQy
	gaDk1shzms8wrs+iqQh8eoqtzXp1zyxkXMVHusnUXXSFV++0VP+PXu17yxzF4El8UeMO4aACLZY
	XQWMw+kzfzL/cuZsyA6wKmv6lEx4upJvFaFNKQyCj3EoAOqooB1yanGzSH5guvwIFxPW75qqsNA
	hGakqX4VNEFMbQIu7IRWcrN0HXh0Saki+3kxrU0UE9j5NfMnI0Y9eKnO+IBjGbh4GTlRPMCNgbm
	PUGSHmrLWnXfvCDnnAOaqp1yRPsqd8w0mBzxgLdufT7WyXMyMLtF5pQgXUTWPq2grgQwMtWU+To
	MbYQ3ZIS4gFk8gb3eb7qUm1Wf
X-Received: by 2002:a05:622a:909:b0:4b2:8ac5:2598 with SMTP id d75a77b69052e-4b28ac529e0mr15019161cf.65.1755612008757;
        Tue, 19 Aug 2025 07:00:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEBAvvYXL8i9P7cR8O8XdCVaPlvw9p/QnCocyZXFhRy9Zoik2weRNfpmr0EG3Z4favrMK+ULA==
X-Received: by 2002:a05:622a:909:b0:4b2:8ac5:2598 with SMTP id d75a77b69052e-4b28ac529e0mr15018551cf.65.1755612008247;
        Tue, 19 Aug 2025 07:00:08 -0700 (PDT)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (213-44-135-146.abo.bbox.fr. [213.44.135.146])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4b11ddd8031sm68860341cf.31.2025.08.19.07.00.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Aug 2025 07:00:05 -0700 (PDT)
From: Valentin Schneider <vschneid@redhat.com>
To: Adam Li <adamli@os.amperecomputing.com>, mingo@redhat.com,
 peterz@infradead.org, juri.lelli@redhat.com, vincent.guittot@linaro.org
Cc: dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
 mgorman@suse.de, cl@linux.com, frederic@kernel.org,
 linux-kernel@vger.kernel.org, patches@amperecomputing.com, Adam Li
 <adamli@os.amperecomputing.com>
Subject: Re: [PATCH] sched/nohz: Fix NOHZ imbalance by adding options for
 ILB CPU
In-Reply-To: <20250819025720.14794-1-adamli@os.amperecomputing.com>
References: <20250819025720.14794-1-adamli@os.amperecomputing.com>
Date: Tue, 19 Aug 2025 16:00:03 +0200
Message-ID: <xhsmhtt23h0nw.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 19/08/25 02:57, Adam Li wrote:
> A qualified CPU to run NOHZ idle load balancing (ILB) has to be:
> 1) housekeeping CPU in housekeeping_cpumask(HK_TYPE_KERNEL_NOISE)
> 2) and in nohz.idle_cpus_mask
> 3) and idle
> 4) and not current CPU
>
> If most CPUs are in nohz_full CPU list there is few housekeeping CPU left.
> In the worst case if all CPUs are in nohz_full only the boot CPU is used
> for housekeeping. And the housekeeping CPU is usually busier so it will
> be unlikely added to nohz.idle_cpus_mask.
>
> Therefore if there is few housekeeping CPUs, find_new_ilb() may likely
> failed to find any CPU to do NOHZ idle load balancing. Some NOHZ CPUs may
> stay idle while other CPUs are busy.
>
> This patch adds fallback options when looking for ILB CPU if there is
> no CPU meeting above requirements. Then it searches in bellow order:
> 1) Try looking for the first idle housekeeping CPU
> 2) Try looking for the first idle CPU in nohz.idle_cpus_mask if no SMT.
> 3) Select the first housekeeping CPU even if it is busy.
>
> With this patch the NOHZ idle balancing happens more frequently.
>

I'm not understanding why, in the scenarios outlined above, more NOHZ idle
balancing is a good thing.

Considering only housekeeping CPUs, they're all covered by wakeup, periodic
and idle balancing (on top of NOHZ idle balancing when relevant). So if
find_new_ilb() never finds a NOHZ-idle CPU, then that means your HK CPUs
are either always busy or never stopping the tick when going idle, IOW they
always have some work to do within a jiffy boundary.

Am I missing something?


