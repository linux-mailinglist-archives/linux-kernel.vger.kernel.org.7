Return-Path: <linux-kernel+bounces-812223-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86BC0B534B7
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 15:59:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 27369AA0122
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 13:59:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8B50334375;
	Thu, 11 Sep 2025 13:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HP5W2qtO"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B427A32ED3D
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 13:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757599170; cv=none; b=l9pmgMxPW12Y3RUwfmwOz1KTQvIieIAe5MPA4Eby6d71X3SrVMytC/7Fz++CVNTORs+4IbGlSZNiM4b9muXKGYDa8vDe1S8zugDbri4gQcLvVZAZRAqvqMMj9/kq6ZwrfXsUny0O0FLTN0XHTZwxt9atfp+g4ybXiXEpey6Zqmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757599170; c=relaxed/simple;
	bh=W6+oLNg0lTcwoXcBoMH7aP5iNhGZ2xPTqpbqs+BPRMM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GtvHx+pioMv6Ejba/r0qn9aCZ7tYL7jf8S1AKfTX2QVR8So8gLmvhr0SkeW88YqnwkQmr40kwKim+f4DttLg8EN8VgfcFt5rbsglCNqQvfvruXmTeE0TwYwffeRsN3t7FrDjLHn4GJ+sPoCEoonR+h9nMvasntkDz8eJXcJQnDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HP5W2qtO; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757599167;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RXQap9QNVW2B9eMLyddgS040sQcFoOCBukKtfe1SVA4=;
	b=HP5W2qtOwJA3wJ83zHcoKdcSf6/yBjrQp/qDxvkOjPvG+bDu+ot9n0eZdO8E4SPDPlEkwy
	eYCtLsDNL1HmBrDCqxN2q0+432hIh0apmOx3gHxFB3vof/QOJuIu9ip+ELuE6zs977buU9
	aAQsKKHI4XJzLcfnZzneK53V3ZY8VfI=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-37-5FmWVmnGMJ2eOXjLQvS5ng-1; Thu, 11 Sep 2025 09:59:26 -0400
X-MC-Unique: 5FmWVmnGMJ2eOXjLQvS5ng-1
X-Mimecast-MFC-AGG-ID: 5FmWVmnGMJ2eOXjLQvS5ng_1757599165
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3e68a54dac2so379618f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 06:59:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757599165; x=1758203965;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RXQap9QNVW2B9eMLyddgS040sQcFoOCBukKtfe1SVA4=;
        b=qw5nRToUiExSGvBmdSCBrcut3l3fTE2Zkxk/bZjUBZQSoEuGiLVfTmv7deKux/zJW+
         tqi3XGMPP5exzrODQoOpixYE/k1g3Cjy80OIockEUPhPOR67mIL2HyQPXscWwkiXeb49
         FkFpr0zHXpeBJJlQQr3GnCakaYuj+2NaLeu5zo4ukq+Yi3EP6a3BKB6CP2KgmU5wMwnv
         7GYufUuH+FLJCmivHrurXLPY7cB2X/FR6FbyZ5gr1h8iCHX4xi0Mz8fI1+zRL1LIaes6
         SXH08q9XDGR1/ZmC5ntcf1j9B0MWW7PVMICU3O2usAemi2LhbOGpqVKqXQtQ0fnYMqoV
         hLiw==
X-Gm-Message-State: AOJu0YxZJI1aEEcgXtTZSZUQ2IYx0Ct3eXKSq4CgY7WWjez846Gkovjt
	l/k+y0ZJmQz+hnhDgEnFguOaYmRGhMHSJcIVVn+26WE4m+up6l77hUIdCC/TfkcZAkBXHYNRlu+
	IOyE2IVl2UFHjO23lu+KDYvqi/7nQUh2JcpESjJJ9/ByBt6538uhHmI45ANgkzlcqUg==
X-Gm-Gg: ASbGncsIOKQCwpKfSvv7IFn3W9SZ94Vua17CkeUjyIU6Y3Jdbj3R2h5RaKYn+yCv+Az
	JJxC80Zv+JO0Rg9qQh4bbD7Fsz4myS3AqvSxBbI7r0KjA035nQTn/aZ6u2Qgc87wYXyTUo/ckpy
	ny3dmmFlr1wFcKSa0p3OwPOJahoBm6QE9iTc5losuwScNzMfQaqnqr70ScGG7h2AGGkQpeKhk7q
	HQv/x2szhqbAQCmTYUtv9xNX8EjXHJz8jvyAAzB/8BbJVXX+LQDt3o1HrFFA1jy5kNRZniD6HgT
	EC5kC/WOcPJGOXJeUQ4IyFB9ETJC05u+hI/neuqYpIQof/cviTberT+szJ0GTI7VKo7HUMM=
X-Received: by 2002:a05:6000:2502:b0:3e4:1e29:47f0 with SMTP id ffacd0b85a97d-3e75e166452mr3031941f8f.29.1757599165176;
        Thu, 11 Sep 2025 06:59:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEx7leHaL1+Rr6ymkfV3LwM9/xSIOUP1CO3XwNw4FGNGfvH8nKSBq2X+NK/v29mIsOIAHaBbw==
X-Received: by 2002:a05:6000:2502:b0:3e4:1e29:47f0 with SMTP id ffacd0b85a97d-3e75e166452mr3031906f8f.29.1757599164651;
        Thu, 11 Sep 2025 06:59:24 -0700 (PDT)
Received: from jlelli-thinkpadt14gen4.remote.csb ([151.29.70.210])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45e016b5c5dsm28372365e9.14.2025.09.11.06.59.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Sep 2025 06:59:24 -0700 (PDT)
Date: Thu, 11 Sep 2025 15:59:21 +0200
From: Juri Lelli <juri.lelli@redhat.com>
To: John Stultz <jstultz@google.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Qais Yousef <qyousef@layalina.io>, Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Valentin Schneider <vschneid@redhat.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Zimuzo Ezeozue <zezeozue@google.com>, Mel Gorman <mgorman@suse.de>,
	Will Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Metin Kaya <Metin.Kaya@arm.com>,
	Xuewen Yan <xuewen.yan94@gmail.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Suleiman Souhlal <suleiman@google.com>,
	kuyo chang <kuyo.chang@mediatek.com>, hupu <hupu.gm@gmail.com>,
	kernel-team@android.com, Luca Abeni <luca.abeni@santannapisa.it>,
	Tommaso Cucinotta <tommaso.cucinotta@santannapisa.it>,
	yurand2000@gmail.com
Subject: Re: [RESEND][PATCH v21 0/6] Donor Migration for Proxy Execution (v21)
Message-ID: <aMLVuZbkMEQzXPqR@jlelli-thinkpadt14gen4.remote.csb>
References: <20250904002201.971268-1-jstultz@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250904002201.971268-1-jstultz@google.com>

Hi John,

On 04/09/25 00:21, John Stultz wrote:
> Hey All,
> 
> I didn't get any feedback on the last iteration, so I wanted to
> resend this next chunk of the series: Donor Migration 

Not ignoring you, but I had to spend some time putting together some
testing infra I am not trying to use to see how DEADLINE behaves with
the series, as it's somewhat difficult for me to think in abstract about
all this. :)

> Also you can find the full proxy-exec series here:
>   https://github.com/johnstultz-work/linux-dev/commits/proxy-exec-v21-6.17-rc4/
>   https://github.com/johnstultz-work/linux-dev.git proxy-exec-v21-6.17-rc4
> 

> I’d really appreciate any feedback or review thoughts on the
> full series as well.

I current have the following on top of your complete series

https://github.com/jlelli/linux/commits/experimental/eval-mbwi/
https://github.com/jlelli/linux experimental/eval-mbwi

of which

https://github.com/jlelli/linux/commit/9d4bbb1aca624e76e5b34938d848dc9a418c6146

introduces the testing (M-BWI is Multiprocessor Bandwidth Inheritance)
infra and the rest some additional tracepoints (based on Gabriele's
patch) to get more DEADLINE info out of tests (in conjuction with
sched_tp [1]).

Nothing bit to report just yet, mainly spent time getting this working.

One thing I noticed thouh (and probably forgot from previous
discussions) is that spin_on_owner might be 'confusing' from an
RT/DEADLINE perspective as it deviates from what one expects from the
ideal theoretical world (as tasks don't immediately block and
potentially donate). Not sure what to do about it. Maybe special case it
for RT/DEADLINE, but just started playing with it.

Anyway, I will keep playing with all this. Just wanted to give
you/others a quick update. Also adding Luca, Tommaso and Yuri to the
thread so that they are aware of the testing framework. :)

Thanks!
Juri

1 - https://github.com/jlelli/sched_tp/tree/deadline-tp
    will open an MR against Qais' mainline repo as soon as TPs are
    hopefully merged upstream as well.


