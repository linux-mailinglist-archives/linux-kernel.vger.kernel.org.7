Return-Path: <linux-kernel+bounces-773627-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C51EB2A2DC
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 15:03:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA9F33BE03B
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 12:58:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB0E231CA4A;
	Mon, 18 Aug 2025 12:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bDaiubGW"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E9DB318144
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 12:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755521908; cv=none; b=fSvNI0JrZ742s1W92f2vLr02sC9Vt9u5MawZZnEJL1E8caXKxBWygBK2yO66lluS2iIb39y0WRuoLz7uKZayCgrZUmkXDPX1neGgjIWr6/JlXkInoJL7vk2Be2NEq3ikC14SEIB8mJ+BwG92zv5k2O3JImwy1L/dDJtRad0r8AE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755521908; c=relaxed/simple;
	bh=Hoc6meK2yDvqKWSrM6Plqe2CWtgZzDDapQiukAxSrRs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m34ojbnJsbXYGSJM6MPWqvtmH/TSp+rB0aBctwH58Io1NKItwPy2VddM+qnBv8+lRa6mOFsUhZvWQiva8iVns7Jt5J/WXVWjB7mtCUya0HzY1SFSmk0q7C2SG4xHVYyTk2eW2Y+0Y3rfFb/UmTW1fwn1uU9ysA7bfN4h0w6C4RE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bDaiubGW; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755521905;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=a4pUj9dH8CPUj1PDJpQPJJvedbec2AeoZzvhjEC1ZGI=;
	b=bDaiubGW5qHV+S6PAx+BxQzu3VIK+Af0uiajxdRJ5ifIIHkZIJhfa6QhgzJbioEaM85R0L
	yX/PRAkkf0KfKMYG5/ol/PVrIBuKU3xyEG9eHztbyPv+VNx8fmnhgIJox15LXDD3hG4dfi
	94G4ENtkR/XjzD0v5rSNyYIAliJwPsw=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-638-WubkzZN8NDSYNIikP3tm7Q-1; Mon, 18 Aug 2025 08:58:24 -0400
X-MC-Unique: WubkzZN8NDSYNIikP3tm7Q-1
X-Mimecast-MFC-AGG-ID: WubkzZN8NDSYNIikP3tm7Q_1755521903
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-45a1b0b14daso13423505e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 05:58:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755521903; x=1756126703;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a4pUj9dH8CPUj1PDJpQPJJvedbec2AeoZzvhjEC1ZGI=;
        b=bI4hCysMlqFXeW3FBMh8vqkETnandCB5fTtzsKlYfhttKLFTEycvF+aphXUPMgag7O
         KHvUkV6TXtq6goaibB+RhWaSk2J7htRUjQk2ko7iXfPxMUegE1oA8i083ApxwVrIZtuW
         Rhmjsl/jSK80Ii/U9x1bcLN0sfPVxnqzbg/25NAHKbtCLLFzc1LDoWi4R/LOy270pc9q
         WHq+Ls7sDkXh0EX5zm0ARG6xjd0PU7XHEurvOi0wi2rMYkCcykU6zVyToI4CQNldJLEL
         S7SRlG4A4I783OfFfVOzZV9oldKQDAWv3dtaWhrez/yOhLT0a96YSYbOvPsW4myuov2U
         wmGA==
X-Forwarded-Encrypted: i=1; AJvYcCW+0+DvV8F8aRydjsNnLe9Km5QhsXY1Ul7+6lIFhurmcWvUNAQbMboheTggMoJEgagqS39dUm+zWMAlOY4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxlarNl58TaAtVYUoW02G4O/3SsFlrM+JPRRd303dzAmEhsat8N
	RTKuh3RuuXwH3opxYZ0LgQIpRZDdHh/PZPlxTFSluj8ZtUXOR1ztwIotKqEnL8f/og2/2CrUwgm
	kdx4G1LpKNXxp0JmGOJmYVzf4wMs9NWkJas6qbQOSzHxYrZ7HYHlt5GVw2oAuLX8swg==
X-Gm-Gg: ASbGncsxcF0gsr4b3xP8xGCYeZN43s5eUwlJZWTxY1744F6TiExuOz7xtOCn5o4Tozc
	Ef/ejtXIuTzNhmCWAtmYNHc7ytI22fcw9IqrZXAevSytHj50sAeVLh5dAFT9coCQZhYBUUjz6IG
	HfAF5VnJAgI8NULee6w70aNFqbbjaYiYQf1lUbQl+QyvgANsPLHqg5W0PUIEVwuEMxYazplOeT2
	/P61B2UHQRpR2un/dnWXNrMnOfJAGeedC0H0AMC9Ad+7WZYfVRqeJlOmx3p+bi3+AlsT4lvWcQ/
	CxF84LfiG075XAQ/FSkuAOtnxArsO6F/I6jtY+JQhLyoSInrfmalITgjAk6abboLvK1e/Q==
X-Received: by 2002:a05:600c:45cd:b0:456:3b21:ad1e with SMTP id 5b1f17b1804b1-45a218590d5mr103925265e9.17.1755521903037;
        Mon, 18 Aug 2025 05:58:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHUpFhdT2bPtrNqg8A/9HFGtSXXsnBcNwuNUlbpznZYmqEk6yHYsE5XTIpK9tvEzUA/s3deYw==
X-Received: by 2002:a05:600c:45cd:b0:456:3b21:ad1e with SMTP id 5b1f17b1804b1-45a218590d5mr103924955e9.17.1755521902575;
        Mon, 18 Aug 2025 05:58:22 -0700 (PDT)
Received: from jlelli-thinkpadt14gen4.remote.csb ([151.43.21.221])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45a223197fbsm137673155e9.8.2025.08.18.05.58.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Aug 2025 05:58:22 -0700 (PDT)
Date: Mon, 18 Aug 2025 14:58:19 +0200
From: Juri Lelli <juri.lelli@redhat.com>
To: Doug Berger <opendmb@gmail.com>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	linux-kernel@vger.kernel.org,
	Florian Fainelli <florian.fainelli@broadcom.com>
Subject: Re: [PATCH v2] sched/deadline: only set free_cpus for online
 runqueues
Message-ID: <aKMja4BvgQ5vFaNN@jlelli-thinkpadt14gen4.remote.csb>
References: <20250815012236.4053467-1-opendmb@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250815012236.4053467-1-opendmb@gmail.com>

Hello,

On 14/08/25 18:22, Doug Berger wrote:
> Commit 16b269436b72 ("sched/deadline: Modify cpudl::free_cpus
> to reflect rd->online") introduced the cpudl_set/clear_freecpu
> functions to allow the cpu_dl::free_cpus mask to be manipulated
> by the deadline scheduler class rq_on/offline callbacks so the
> mask would also reflect this state.
> 
> Commit 9659e1eeee28 ("sched/deadline: Remove cpu_active_mask
> from cpudl_find()") removed the check of the cpu_active_mask to
> save some processing on the premise that the cpudl::free_cpus
> mask already reflected the runqueue online state.
> 
> Unfortunately, there are cases where it is possible for the
> cpudl_clear function to set the free_cpus bit for a CPU when the
> deadline runqueue is offline. When this occurs while a CPU is
> connected to the default root domain the flag may retain the bad
> state after the CPU has been unplugged. Later, a different CPU
> that is transitioning through the default root domain may push a
> deadline task to the powered down CPU when cpudl_find sees its
> free_cpus bit is set. If this happens the task will not have the
> opportunity to run.
> 
> One example is outlined here:
> https://lore.kernel.org/lkml/20250110233010.2339521-1-opendmb@gmail.com
> 
> Another occurs when the last deadline task is migrated from a
> CPU that has an offlined runqueue. The dequeue_task member of
> the deadline scheduler class will eventually call cpudl_clear
> and set the free_cpus bit for the CPU.
> 
> This commit modifies the cpudl_clear function to be aware of the
> online state of the deadline runqueue so that the free_cpus mask
> can be updated appropriately.
> 
> It is no longer necessary to manage the mask outside of the
> cpudl_set/clear functions so the cpudl_set/clear_freecpu
> functions are removed. In addition, since the free_cpus mask is
> now only updated under the cpudl lock the code was changed to
> use the non-atomic __cpumask functions.
> 
> Signed-off-by: Doug Berger <opendmb@gmail.com>
> ---

This looks now good to me.

Acked-by: Juri Lelli <juri.lelli@redhat.com>

Thanks,
Juri


