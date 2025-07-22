Return-Path: <linux-kernel+bounces-740520-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A7D18B0D530
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 11:01:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5DDA2188338B
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 09:02:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38229238C21;
	Tue, 22 Jul 2025 09:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VZjMqlPL"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D494AEAC6
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 09:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753174901; cv=none; b=W0tZz5PlWFp2YvtUy9k50aV6BCSN/nw3jPFnhBIK2pwLt+VTgnA7qFKBOLNPir/jKn4M1GJrOoe+JNZ3gYLVLJwJEHYfaTyK/AjPX+gq4EliMK+FMhgxZpYh6S8sCXM4NFeWox3MmIrvw9Dqi9HLB1EdUwk8V6gjlsCJleqrLLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753174901; c=relaxed/simple;
	bh=hFt94XmJsDlLeMHUeMllYCOwQV1CUxQzfC1ZqpLOclY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=oMd2cZDT74ZlMUE4aFeWyrV9siccS0SdTRtnDwHaq/lZcKMlpZma94U+QfqtEZbi/HMrYoxlVUnHSqw2KM6UoGm1TcDXq/zd6khTWWRkpq4AJFJnOQa1HxLvw6zSgwhdBy8ZIuQPnpDe1wKI3Hw9R9DRIhPrB05A2kKfAcCA9Cs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VZjMqlPL; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753174898;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QpoQe9hSlIHouyPhZTJkRuSXMG2aW5gVU9jJOfJVYT0=;
	b=VZjMqlPLhp+z6ToXl6XpwXH3u19qWzfdDCNL/B9hHel7yefHfPvzXc8u0EAZQ8Dyxy70Jc
	7Y3lvEMoECKWf2TBTMe6sUSR6mI8TpvYKOVcr9ZMV0eZYXVfzFq0rBM52ycbXKdnZtG5SD
	U2P07zzBh8yUm3HAbaEQQeV5rgUSjY4=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-75-CuxDmn00Pp6hibYCbypphQ-1; Tue, 22 Jul 2025 05:01:36 -0400
X-MC-Unique: CuxDmn00Pp6hibYCbypphQ-1
X-Mimecast-MFC-AGG-ID: CuxDmn00Pp6hibYCbypphQ_1753174896
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3a4e713e05bso2164710f8f.3
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 02:01:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753174895; x=1753779695;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QpoQe9hSlIHouyPhZTJkRuSXMG2aW5gVU9jJOfJVYT0=;
        b=pC5FZEIBc6agecvUWDC5QoXkB7s1yzaLHOpNB59YLVV3ZjKT1lbNubw0IDY1V4yYnB
         Qsfc/NW+cXXcCU/u/VnK7Jr4iBv6ZHpZj6GS7AN/yUa9sHLhXv4v6ycWUUIF8yUBAeJW
         NGn/dkIj6Rrx18Scqmo/ZKROiqC6Ru3abBLW5dF1iePjJgifQlRyGPYajEcnPLjEN4yI
         hg6P3MZizSURKXwzRwdi6khurqG4aNdwLfSFvSZzCkncX0sgWLrgwCAIVj3Jx+ntmu03
         GpROHaif36lcvpCRn9Q/kn9ehC42QdSJL57c7uG+E6+2yHVfgPZLiKXN5g8kGOxl0QZc
         gQyQ==
X-Forwarded-Encrypted: i=1; AJvYcCUJcITHv5YZOPVVuEaivIfDlFRM+n21VfvlhaBQBanJxkDDxbWv7Zxl6tfT6u0FWm1hTonchxL1ph5Aiho=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzh5qoCb075QSc1LoveOub7DuaoJoo5vUxWuKRxCF8byMlDOfFm
	CLsYelJJjL1Ei1x8mbKu2U1P1taDNUz09iRR9vbQVUyDyVGYfzVVA3W2Ui0DqTnUuZiRLNpSRtf
	5zWymj6Wa2pyGhLHoGLVb5LGhkycBqAqVb0H7E0c8Ngi50NNWzPxWIILciq7EzLEmA2hNBpHGTL
	RcqQJT7qYvRnFks2ZTr+zuS1DFdVzg1ptS+xL1oPgT3TtcGRHPlQ==
X-Gm-Gg: ASbGncvmllG1CaDk8RZqv4qDyFxhmnNcOPjHCOznNQfx6XRdRO2DuQAYQvm8k6XKvQb
	w1UKFziN985bkE9ao3ArQXqACAlFfnqKBIkvg/zWfkgEYMg4y8ta9l5/IaMEEuWQ+S69LHQtMBL
	14l7jWtrAJYmME2uW/nzoh43yp3WLdt4iTlmAlER9gXt1KNjYSKR6Mxhp28Uu3+MkWA3k/jvCec
	8vqmgc5QolNgfWFgRKnWCuGFIXl9HMS8fmHog4WeldgWRQxD6Qms+G+KEluGpXxptGcXgW79W6a
	tvE9bbqaW8/zM1+DwHsWO8UN97GQaeoX7AIjJzHNuklvhn2x4462Uj2bD1NNxL+aOlVStO6txcA
	Qz+vsUuLfxQPVZpbFYvonolWm
X-Received: by 2002:a05:6000:4b01:b0:3a4:eec5:441c with SMTP id ffacd0b85a97d-3b60e53ececmr19951231f8f.47.1753174895272;
        Tue, 22 Jul 2025 02:01:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGTmrQ3C1i33NiqRyZbgr1tT6KbdmdD63HnGAf290ZVtUdW9BaU1E+LIv6PnMjyZzEk/+4R+A==
X-Received: by 2002:a05:6000:4b01:b0:3a4:eec5:441c with SMTP id ffacd0b85a97d-3b60e53ececmr19951188f8f.47.1753174894834;
        Tue, 22 Jul 2025 02:01:34 -0700 (PDT)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (213-44-135-146.abo.bbox.fr. [213.44.135.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b61ca4c754sm12893962f8f.59.2025.07.22.02.01.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jul 2025 02:01:34 -0700 (PDT)
From: Valentin Schneider <vschneid@redhat.com>
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Huang Shijie <shijie@os.amperecomputing.com>, mingo@redhat.com,
 peterz@infradead.org, juri.lelli@redhat.com, patches@amperecomputing.com,
 cl@linux.com, Shubhang@os.amperecomputing.com, dietmar.eggemann@arm.com,
 rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] sched/fair: do not scan twice in detach_tasks()
In-Reply-To: <CAKfTPtBxtAu1=p22Z5N7_EMeTMyRvN-gQDa_G==dTDDKtPdYzA@mail.gmail.com>
References: <20250721023939.19703-1-shijie@os.amperecomputing.com>
 <CAKfTPtC7+V6ubaGDPy0MW2MFG7w_yrnYCPQ-b2=3uYgeM+-+EA@mail.gmail.com>
 <xhsmhv7nleqfl.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
 <CAKfTPtD8uF=6kr=RpduggahJRztH4DtQFQ5Q5zM6PWY8EESfxg@mail.gmail.com>
 <CAKfTPtBxtAu1=p22Z5N7_EMeTMyRvN-gQDa_G==dTDDKtPdYzA@mail.gmail.com>
Date: Tue, 22 Jul 2025 11:01:33 +0200
Message-ID: <xhsmhseioeh02.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 22/07/25 09:53, Vincent Guittot wrote:
>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>> index 1b3879850a9e..636798d53798 100644
>> --- a/kernel/sched/fair.c
>> +++ b/kernel/sched/fair.c
>> @@ -11702,12 +11702,16 @@ static int sched_balance_rq(int this_cpu,
>> struct rq *this_rq,
>>                  * still unbalanced. ld_moved simply stays zero, so it is
>>                  * correctly treated as an imbalance.
>>                  */
>> -               env.loop_max  = min(sysctl_sched_nr_migrate,
>> busiest->nr_running);
>>
>>  more_balance:
>>                 rq_lock_irqsave(busiest, &rf);
>>                 update_rq_clock(busiest);
>>
>> +               if (!env.loop_max)
>> +                       env.loop_max = min(sysctl_sched_nr_migrate,
>> busiest->cfs.h_nr_runnable);
>
> it should be h_nr_queued as mentioned by Huang and my patch has been
> messed up by my web browser
>

Works for me.


