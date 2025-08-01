Return-Path: <linux-kernel+bounces-753623-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7003AB18560
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 18:04:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F38F162D9F
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 16:04:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AB3F28BAB3;
	Fri,  1 Aug 2025 16:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GNRjmcpq"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E35FA26B756
	for <linux-kernel@vger.kernel.org>; Fri,  1 Aug 2025 16:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754064240; cv=none; b=NPuFiRUZsSGXi/VF32EC+zmQ/K0Y+QX4C9puH4+vCALVCPixosdQogPxOzROkAoDea/gNc4QJAO++3LDFufzyCI8y6MHxe23iXINJYEEa04Oc9C1E0TDRTvLQN8ieXNtM+dooJEkSzqm1qoIvaKR7IylWvGwi/2QVss6HZ+Bmwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754064240; c=relaxed/simple;
	bh=xyZ+FQBq+KvXO3ea7BvsdacMmWGRiYuWxG7s/qnV924=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kf6NQgTYk2EfdfOADB88tFKhOqaaxNLz+TOimky2gpW4iwCjdbvyiAaL8wvEJJBsfEa5ijZTNyHrZYbp411VcMlJhI/d4UG5IbwgEN+dVVtScBcb8eZdhBTQEhq1melFoEfR/ArzEmJUMKk10lSusKMalurSzyq8WV7NJD9fKLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GNRjmcpq; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-456108bf94bso6560485e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 01 Aug 2025 09:03:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754064237; x=1754669037; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zRxnGgR7U4/KRc3TFVEUz3gjh5ISqNhcChVahRuuqe0=;
        b=GNRjmcpqwwzS+jczEuwt2GlBVwm3toP5e7ukdkzO87ReB8IAw3LfFm5jnGgsezyICd
         McWaiVwbIYT1QJn3wYIvXBqPW+QDBfRM2HaxMGaZ86koqPVMsn1VvI3pStaG92Iv3UGB
         Yrd6txNAJ8EuquEbT2PuSxmBhOCYUI+MsvZWJtzVjV0qkXGUmKZPLdPpWgdSEhVlx2zn
         gY9+lR/YsFgefsU+CzdUI26HHDODNCgTX3Cs4OGOOKaEtfP6XNF8ziEjXhZAmTayierL
         6bFlzmy3gKYpi4gLEw50/o1zZNeUku1HbkvZcLwgFKq/sWocTPkNRXkQz5hgJiyQ0a+W
         WCng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754064237; x=1754669037;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zRxnGgR7U4/KRc3TFVEUz3gjh5ISqNhcChVahRuuqe0=;
        b=cxyscEKStrN9Fr6s8Ngtk6AwqS0+Oi2oXzHitcE/pfYVpTZzfLr3k6iBu2SXBbAq3V
         HsHGcq13j7kbo/fadQXykX4SgbJOtWZdWZdghuRcE2Ahl+HZiiK2TP2jCQ3RQFdamyY7
         kQ9NzFG3Rr9dqmbPuieO5UiBjUOXLV1lPocWOs+B89O6uks1V5nJbPXvodS3qHSe38Ra
         4/vQhC62QBzZn+WKLT0zxyZSSMB4LChaCx8IydMZyKU2gas5gnfhzi6OmrVDLAvXpFED
         Y2mRedkrnZBlDRnP964YWUpNf5waP9f5tT07kAv2sj9pPjFzp3oGjmRxC5h0xOf74iJR
         Q0DQ==
X-Forwarded-Encrypted: i=1; AJvYcCVxY8Rk0Y3FXzPksPw26nw0CqGE3ar1F3alG7ppQxzJYNHYpt9vKr2e5W79Z7QOMjV1nDcVZPlokKptUig=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPpKtxWHRVohKY0FTghmiPAahUJfmTMjggl5slo0i9tk0Chm7w
	H8lMyJ4S/LR0GsahOF3xENNRL8dKzfsXZZ3FBQoQuDvjgoPDL3OBHGpY
X-Gm-Gg: ASbGncubX/eEKHoExfjfoo+xPVzAgntg/CZu/ZlHQGcgJYnVAc+6cX/kGsos6Rr3Giu
	Gvstto5zn6cw1DI5SBccZY3gUxnRx/SejSjPD3hGsCmKWIUIztEdyjlonKIuvhyTpVDDWe/De0s
	yREyzItyEfyO4fmq13eKeAwh6oWqXbKnUAxdchUDJS5qF0QHXdX1ldWkNGBnDxjjkVLQmvDs7XT
	xKXPb65n/OMCKSBNj5L69ASKNTjOESC55FZI4Bva5H3eXONeOfWVcdRh34TxnMw9d/kx1z3hGx7
	NCx0ZJyCqoeK/oADWqqkBJUOMAoHCr70DyzKA0CuJmhLZhpteRh+8gkNEyaQ3db4oajgmad/7RL
	NBS0bHYMC7lYjiuU5Izq+eQ==
X-Google-Smtp-Source: AGHT+IFtHwOsIUUdv6TCs8szY/jwlcGR0zdV+18UIPj2cmMVwrO1rHjhKFjCVQtudAofNkKPHw7y7A==
X-Received: by 2002:a05:600c:5253:b0:458:affe:a5c1 with SMTP id 5b1f17b1804b1-458b2159badmr15424955e9.5.1754064236763;
        Fri, 01 Aug 2025 09:03:56 -0700 (PDT)
Received: from yuri-laptop ([37.160.61.162])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-458af8c5a87sm15011285e9.2.2025.08.01.09.03.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Aug 2025 09:03:56 -0700 (PDT)
From: Yuri Andriaccio <yurand2000@gmail.com>
To: juri.lelli@redhat.com
Cc: bsegall@google.com,
	dietmar.eggemann@arm.com,
	linux-kernel@vger.kernel.org,
	luca.abeni@santannapisa.it,
	mgorman@suse.de,
	mingo@redhat.com,
	peterz@infradead.org,
	rostedt@goodmis.org,
	vincent.guittot@linaro.org,
	vschneid@redhat.com,
	yuri.andriaccio@santannapisa.it
Subject: Re: [PATCH v2] sched/deadline: Remove fair-servers from real-time task's bandwidth accounting
Date: Fri,  1 Aug 2025 18:03:52 +0200
Message-ID: <20250801160352.4816-1-yurand2000@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <aIxunUAqdecVuUMs@jlelli-thinkpadt14gen4.remote.csb>
References: <aIxunUAqdecVuUMs@jlelli-thinkpadt14gen4.remote.csb>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

thanks for reviewing the patch.

> > @@ -1688,17 +1690,14 @@ int dl_server_apply_params(struct sched_dl_entity *dl_se, u64 runtime, u64 perio
> >  
> >    cpus = dl_bw_cpus(cpu);
> >    cap = dl_bw_capacity(cpu);
> > +  max_bw = div64_ul(cap_scale(BW_UNIT - dl_b->bw, cap), (unsigned long)cpus);
> 
> fc975cfb3639 ("sched/deadline: Fix dl_server runtime calculation
> formula") essentially removed cap/freq scaling for dl-servers. Should we
> rather not scale max_bw here as well?

Now that I think about it, you are correct. Since the fair-servers' rate is
fixed (i.e. by default 50ms every second), the bandwidth must be scaled for both
the CPU and the server, or equally, neither needs scaling for the check in
question.

...

> > @@ -3149,10 +3138,13 @@ int sched_dl_global_validate(void)
> >        goto next;
> >  
> >      dl_b = dl_bw_of(cpu);
> > -    cpus = dl_bw_cpus(cpu);
> > +    cap = dl_bw_capacity(cpu);
> > +    fair_bw = dl_bw_fair(cpu);
> >  
> >      raw_spin_lock_irqsave(&dl_b->lock, flags);
> > -    if (new_bw * cpus < dl_b->total_bw)
> > +    if (cap_scale(new_bw, cap) < dl_b->total_bw)
> > +      ret = -EBUSY;
> 
> It's kind of a minor one, but can't we return early at this point already?

Yes, I suppose so. I'll update the patch to return as soon as the error
condition is met.

Additionally, I'll also update some of the checks in the above function to
reflect the aforementioned fixed rate behaviour for fair-servers.

Have a nice day,
Yuri

