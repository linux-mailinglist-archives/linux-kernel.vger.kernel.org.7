Return-Path: <linux-kernel+bounces-789820-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A4B1BB39B21
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 13:11:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB92C985A3E
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 11:11:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9782730E0DF;
	Thu, 28 Aug 2025 11:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D0OEtpRM"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BED6330DEC4
	for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 11:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756379484; cv=none; b=OPnEjHwqXlZsJkwY4iEIroCzuU98h0lkXMRliA62ueLagNt7KJKFy+Xi3WYQiPaQv8FVrZVrdrpkIRBdcluO6y1vrhfXQFzo41eW94RGYAJkPsTd2WWFY5FBmTtoEza8hWFkBo095Npxy8gto2ko/eYo0x2KyXrMYkgjR2kv100=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756379484; c=relaxed/simple;
	bh=ClQXAX0cTc7z7eGf8kQVz+BQ0anPMAx0rOPr+Otswiw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=WrMfAQQBQJ6eo5661Sp0DYPhXDw6Q3JpiiIrGVM7Za4LfBs5eTpic0sgliVADIWoKvv1N14eciO4IQYBd3iVj2yURcEF7fywYSUath6VSGLCB+FvRGToqXi3bxyeorNg2umljPVqHDI5KQnqYoXPyKqf2zI40kmUxsR0r+1HfKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=D0OEtpRM; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756379480;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Hr7lDWU7SHqgPCMft6Vro5RommoaFCDmXbSbDTO5c6g=;
	b=D0OEtpRMOSN21bTTatyww+W8B4YVSS21RJLOEholMtwSDWlJcv4z/25x/oq4ZUJocGo9B+
	BryirFQsy2i7br8vLSMhnaKwjgYbZePs08gwhpv88zIR2et8Um4ncCyybrQDpDhZwe3HMv
	T8B/Z9Ccttf8KyzXQyFWgBnhB1Ednto=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-56-88eDh-dVMcqlHtB9uP2cDg-1; Thu, 28 Aug 2025 07:11:19 -0400
X-MC-Unique: 88eDh-dVMcqlHtB9uP2cDg-1
X-Mimecast-MFC-AGG-ID: 88eDh-dVMcqlHtB9uP2cDg_1756379478
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-7e8704ea619so221956085a.1
        for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 04:11:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756379478; x=1756984278;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Hr7lDWU7SHqgPCMft6Vro5RommoaFCDmXbSbDTO5c6g=;
        b=a6HR1A4H2BDjbzuRm137d04UdApxN+EOZNfYu8ni6TVQf676Dm8EYtPwUUUDcL/+zQ
         Z70OQAg7c9s8U9Giyf75L0Qa9H8dtxYILnQNcY6phQCsOjT23IWwViukzJdzxZd0SB47
         D2rpFRnfobawROliu67B05Wj9LHXOc6EQ/rc7e6czB7WQoFAy33xvmQx4/gyI23KWsd0
         YZKLDiuHT9XPsNu7GUuDP1k9g5EjKxP6W8m/TJxMilX1NAO6THRj/CdSo6DbODmSmyK0
         I6Fd6H4QKQxkUPczINUZr2SuZo1TZDC7zLt2Lubiot6Uy4ys066ASsbAHMErvlH1zZg3
         Br7w==
X-Forwarded-Encrypted: i=1; AJvYcCXqggdzC05JG/6uuk184VIpTmuJQ5v5+lsyZQcP9rTwm8Dq9A/3PHfSHeJA/Fmj2MWOGRWcmN9vuArLqv8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFwFGCgyllgu5g3jPJY0XiQDkiPfQ6vXhlLg7CLyB5KMpIuiYF
	O39jH9zt52tQcPyPQgqw7syyBjAnoEjv+0H9etahMb1d9FVeHglYhfX202oe73XLKz5c8Qt+p+n
	r8dqNZJrEnw78LLGOWHX/LnvGWjJaH3cT57xMw/oTiMzXAJGYXhbK1E34IlT9u5BpQg==
X-Gm-Gg: ASbGncvZWdhQTJdsW6YSC5tHL7qfRtxDew05RR8wBK54+o82B38Vp8b9iH8SX21IuFt
	In9gO0BnbRc9Q2ZxMzrQ1apAaD+9RsTYLKSDdJxsQrvg2gu7p0TWZkgGSLOnYTmJGVCkc3Zu4Uy
	PELbYg+U4++/oZ4nXQZ/yNfdbafHpiEZWXLBmLOOtnQHjHrxEpbpoRMkhA7ggBe4/TbmeMcvEFg
	rbjOUPf1lfmZR6LCBAYVz0JLYJ+8mu3kzm/VeOqTHGTShO3S26dBipJ+1cGlcMQYn7mmRwbnUEw
	N41SX21aCf97ly/cD2UqPmTArV+ahzNbVY1gKfevAbPw3GizvcIk+EaKw9YcvTFnmmeEz1sixen
	up7nz5bh3JV66jahEDhhVDwMh
X-Received: by 2002:ad4:5d4a:0:b0:70d:ea79:b37f with SMTP id 6a1803df08f44-70dea79b985mr43080706d6.62.1756379477904;
        Thu, 28 Aug 2025 04:11:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGBoKj25IgHgcU9r1XJZvGOyDMH0BUs/AbQlVVw2L/YTxR6hyDog4ZaCLGwYtt8Et7wSvuzDA==
X-Received: by 2002:ad4:5d4a:0:b0:70d:ea79:b37f with SMTP id 6a1803df08f44-70dea79b985mr43080126d6.62.1756379477319;
        Thu, 28 Aug 2025 04:11:17 -0700 (PDT)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (213-44-135-146.abo.bbox.fr. [213.44.135.146])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-70df2253308sm12063346d6.26.2025.08.28.04.11.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Aug 2025 04:11:15 -0700 (PDT)
From: Valentin Schneider <vschneid@redhat.com>
To: Qianfeng Rong <rongqianfeng@vivo.com>, Ingo Molnar <mingo@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann
 <dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>, Ben
 Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
 linux-kernel@vger.kernel.org
Cc: Qianfeng Rong <rongqianfeng@vivo.com>
Subject: Re: [PATCH] sched/topology: Use kcalloc() in sched_init_numa()
In-Reply-To: <20250821140833.24791-1-rongqianfeng@vivo.com>
References: <20250821140833.24791-1-rongqianfeng@vivo.com>
Date: Thu, 28 Aug 2025 13:11:11 +0200
Message-ID: <xhsmhcy8fln00.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 21/08/25 22:08, Qianfeng Rong wrote:
> Replace kzalloc() with kcalloc() in sched_init_numa().  As noted in
> the kernel documentation [1], open-coded multiplication in allocator
> arguments is discouraged because it can lead to integer overflow.
>

Hm, checkpatch does warn about these.

> Use kcalloc() to gain built-in overflow protection, making memory
> allocation safer when calculating allocation size compared to explicit
> multiplication. Similarly, use size_add() instead of explicit addition
> for 'i + nr_levels + 1'.
>
> Link:
> https://www.kernel.org/doc/html/next/process/deprecated.html#open-coded-arithmetic-in-allocator-arguments
> #1

This document is actually in the kernel sources, it would be better to
reference it as:

  Documentation/process/deprecated.rst

> @@ -1994,8 +1994,8 @@ void sched_init_numa(int offline_node)
>       /* Compute default topology size */
>       for (i = 0; sched_domain_topology[i].mask; i++);
>
> -	tl = kzalloc((i + nr_levels + 1) *
> -			sizeof(struct sched_domain_topology_level), GFP_KERNEL);
> +	tl = kcalloc(size_add(size_add(i, nr_levels), 1),
> +		     sizeof(struct sched_domain_topology_level), GFP_KERNEL);

@nr_levels is at most 256 (including illegal values between 0 and 9); @i is
going to be the size of sched_domain_topology[]; is the double size_add()
really warranted here?

>       if (!tl)
>               return;
>
> --
> 2.34.1


