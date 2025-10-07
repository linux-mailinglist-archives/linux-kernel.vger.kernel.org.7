Return-Path: <linux-kernel+bounces-844555-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E17A4BC2345
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 18:58:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A56994E95CE
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 16:58:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05CF91D432D;
	Tue,  7 Oct 2025 16:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RS7JcSvm"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE5BE146585
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 16:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759856332; cv=none; b=OSeNcj9r9zzaHyBcAxri5gF+2ITQGzfpw/tZ96tKmW9WsaK0/EEC7FHzNMEHhLftx6AFoIaEePP8SlQnLIg5IEAeyxNBUaH8FPj7Erw6VRI0sf3Ch3JWcCZPSo/hv5WMqBEoX8F/v+f3qbEgDPyLdh7LyDSE9pqz4zAZCyMCchI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759856332; c=relaxed/simple;
	bh=jGRdwrk0WiFSH1LDOpIbZJ7IaN2969IhOnXv8zywGVI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=cj+rN3ncXVl9A/lrbHZmI4XJ+pHwwWuzUIr+DVEWIElEAE4O0hs0Jb8H22HIK3J9jwB8V028lyLF1L+nbIIkVBfWqOs7haCJKiO8/LBCgungydl56SWKOaA/WJ1cp9vXiKiRJOHPtjOdq5A1sclM2SfHzM+YYMu2FDT+rELc9Yw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RS7JcSvm; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759856329;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VI49gLtrLPJJ2pYL6x4CUqavDWlalTmVp/UAdCT3bf8=;
	b=RS7JcSvmNy3yYamqSxZxg/RmgcbgkHZ/WQgmman69fLoHrp63MPTmF/+tI5tN6Q80g2+qe
	/5gWOHQCdla9AP/oOkQcWopNs4JAPOUFT27p0n3Jaujtq3U/ciB6QeqssDJAzojvqzGwRl
	oRehGRwIKb0fwjKSLjvuPf53oIQFY1M=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-121-7YpkURiNNHObo-Kll9EctQ-1; Tue, 07 Oct 2025 12:58:48 -0400
X-MC-Unique: 7YpkURiNNHObo-Kll9EctQ-1
X-Mimecast-MFC-AGG-ID: 7YpkURiNNHObo-Kll9EctQ_1759856327
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-46e2d845ebeso34838045e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 07 Oct 2025 09:58:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759856327; x=1760461127;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VI49gLtrLPJJ2pYL6x4CUqavDWlalTmVp/UAdCT3bf8=;
        b=HxiUed/G7QGslaMRlP5PkcYMIT/wDLhLtMOoBG76MN4BjRIaLzVQQLkcgVIDvJSrLW
         W0HEnpO0qtPeg41lHEOeNLB8Hrz7UFl6GM61YYG9tj5nXEiT5Is//lTU6CrDcFcsxPZ2
         NUI/uHhvXurkyA+daEAm4ihe+6qsfRtsRkEZpWmAxYtem2DMmkjF924UxKeI11HbK7CE
         Qbwj47BzDoHmYWBUWWk1ma5iKgEie2jFlG2hx52txfKgrQOsIu74AyxKocRAUYfXt60S
         MbTQxbJICvIDhQYhqcfV6aVDIE/umT/SKKkEU1WogfWb04J+T5otyt5QM4TD8FI+fYR3
         XDaA==
X-Gm-Message-State: AOJu0YxMsUSr+owvdXttL4v9CGoVCg3dIXjHJ22Po209sAqZcGFAOdXI
	FFJwJK+svUf+JUYzfFQIk6IRRpoT26tOCAoOKBsxfZdm0Gu10UygnXgCilvKMkRnngq+1CdDhqJ
	rk1nC92odWyU7Zju903G3x22z8YcBbqZ/46fTQw3gNpJg3Kx8Tg0/r/+kvNFKzKO/mA==
X-Gm-Gg: ASbGncuUNZaccdoLNSYETnnla3xOrEcjG8m9zvkE44Pbcqn8RT9A+5mnuZqq37bNKi0
	l28EPhPaLWO2f8HrKrzjyBByP9IORqr6nwy7pQ3K5ttZ2PT9k8JagYuO8ODrSK3kbvAdz1uM37c
	qy+vShHLZO0M+MNyursvyFdwQsdRxs1MBt7nJMtKhk8ufmE33MRgMa+vSjmVA8iWCyDIbnyjGkp
	dBjBBgf3Av9yVOdYvWb3rNwdjsqJbuqLvR4Q/IJWef9boUSyoqlwWGS87MaaU8tNmgUReovmx2d
	deRaSRAevZWmQnZiukqtG8ZTI5BVUnwyGBuOmpSmXweyHG8e8kOWzlLAKCuBLeanv9mzJQ4MZsc
	OXgSiwUxDp4sLdmazx0VicJzKOl2mDfs=
X-Received: by 2002:a05:600c:1384:b0:46e:3cd9:e56f with SMTP id 5b1f17b1804b1-46fa9a89286mr2689945e9.6.1759856327267;
        Tue, 07 Oct 2025 09:58:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEwECPkX1ww7TuvN8jwk7t/3HaNmLFBxphplQDqgkXaFZv+r5HSiHGWEg5jQHe1bx3Y1Vl/Hw==
X-Received: by 2002:a05:600c:1384:b0:46e:3cd9:e56f with SMTP id 5b1f17b1804b1-46fa9a89286mr2689785e9.6.1759856326877;
        Tue, 07 Oct 2025 09:58:46 -0700 (PDT)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (213-44-135-146.abo.bbox.fr. [213.44.135.146])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46fa2d67e97sm21615545e9.1.2025.10.07.09.58.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Oct 2025 09:58:46 -0700 (PDT)
From: Valentin Schneider <vschneid@redhat.com>
To: Peter Zijlstra <peterz@infradead.org>, tj@kernel.org
Cc: linux-kernel@vger.kernel.org, peterz@infradead.org, mingo@kernel.org,
 juri.lelli@redhat.com, vincent.guittot@linaro.org,
 dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
 mgorman@suse.de, longman@redhat.com, hannes@cmpxchg.org, mkoutny@suse.com,
 void@manifault.com, arighi@nvidia.com, changwoo@igalia.com,
 cgroups@vger.kernel.org, sched-ext@lists.linux.dev, liuwenfang@honor.com,
 tglx@linutronix.de
Subject: Re: [PATCH 01/12] sched: Employ sched_change guards
In-Reply-To: <20251006104526.613879143@infradead.org>
References: <20251006104402.946760805@infradead.org>
 <20251006104526.613879143@infradead.org>
Date: Tue, 07 Oct 2025 18:58:44 +0200
Message-ID: <xhsmhecrehcmz.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 06/10/25 12:44, Peter Zijlstra wrote:
> @@ -7391,52 +7391,42 @@ void rt_mutex_setprio(struct task_struct
>       if (prev_class != next_class && p->se.sched_delayed)
>               dequeue_task(rq, p, DEQUEUE_SLEEP | DEQUEUE_DELAYED | DEQUEUE_NOCLOCK);
>
> -	queued = task_on_rq_queued(p);
> -	running = task_current_donor(rq, p);


I'm not sure how that plays with sched_ext, but for the "standard" change
pattern such as this one & the others in core.c, that becomes a
task_current() per sched_change_begin(). I'm guessing we want to make
sched_change_begin() use task_current_donor() instead?


