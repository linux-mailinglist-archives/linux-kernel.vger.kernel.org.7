Return-Path: <linux-kernel+bounces-759120-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5F1BB1D8BE
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 15:15:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A96D13AD1E7
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 13:15:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BAA9136E;
	Thu,  7 Aug 2025 13:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Qk9PlVhN"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB8E425BF1B
	for <linux-kernel@vger.kernel.org>; Thu,  7 Aug 2025 13:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754572514; cv=none; b=DphuxX84TcdsUJrh5k/77q1c4Da8I+dP+tOW6OXBviEhCjZvHY96YPjNdzK9L1QVViB0zodc1yIqBFuygym6dV0E0Ks24eHsMkIUEgnp9dc43fa0zuPSWoB9Jnnu1LGjNFanznQUa/JNf6PSqeieKpKyYxLifq5NFdhO0frbQZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754572514; c=relaxed/simple;
	bh=vkgsdxbnV+jO/2KYWJGzI77qW+k8hy9tEjiVY7fTWfE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AS1L/x3AzMdPuVvvOkpg6SdRRixLvahSZw2CAwqw0pIoWyU9Fdycm4YkP5c67zEtOzUdQ8tGTRilm2sRo68F+CAHFJEHK5pK4mtjEgb0HMhL2wLgTjHAqa3ZltZkPRTSQ/0G9XvEy0jenLqsev0W3WMjWTpXiXRwQWM3YRKh5Nw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Qk9PlVhN; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754572511;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bsCl+fG5s7XEuq47rWMb299hn6Md+wm0F7CH1smdlp4=;
	b=Qk9PlVhNkD8m8U/Eo2xCGtC9IEVqIcI26vi7OCNbIXrZjqAFdH4dt9gvwMLKpFr39IgwDm
	tQ5FMMuwldJbMW/nglFaIKB2uiOZ9dTEMSHcq2qzX2+r1fnHjVqSn9PlxDi3mDUQbwhyn6
	ILX24sAN7WJlJJyfqN5LCnmb80awJMw=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-312-UvXr1tDcOiyRD7r4qqs5IQ-1; Thu, 07 Aug 2025 09:15:10 -0400
X-MC-Unique: UvXr1tDcOiyRD7r4qqs5IQ-1
X-Mimecast-MFC-AGG-ID: UvXr1tDcOiyRD7r4qqs5IQ_1754572509
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-458c0c8d169so4853015e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 07 Aug 2025 06:15:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754572509; x=1755177309;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bsCl+fG5s7XEuq47rWMb299hn6Md+wm0F7CH1smdlp4=;
        b=UkaG/8MvwgQ99xW3xWK4Y5ryPjFnuOGitNhes8p7E+NSM1fY4I/H+R6P0L2PPRSOhg
         luY3N3hgBLETeI69NMjz6HmDvMtvORozQfej6Cb/bon2UFW7cKKzvzrSEyLtKdMKIY7r
         C66HsMOAXT7u5nhbi9KaGFYMsiZ/lMmiTVt3AMACTuoXaPGhxHWEdSsitcLqbMOpXLAr
         PHfI2Tq4v1EEILuDn3yVeAO7MPW+tP2DEgjWL2xHgS0JiwB9dp7nL4qlhreUhFWFpui5
         0lKKijjZkhfu3OSwq9mCGYqxJ6NePTys/HsMAz5wXe+xWyF5DKcAH3iisUgkX0WkLrYW
         5cAg==
X-Forwarded-Encrypted: i=1; AJvYcCUpg/4PUrRjay4cXWoJX1LC0fDTdx/bkkuKnf1pJd2Btie8Pr62EbjnPk3lKkh4p2YdKkcodOii1g3owdk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwI0UFurSF5G90ye+ZzYrJxVYFHxbcruGYlcysC/5DO2KFtc59L
	sQRSuhimdNh6ZlguuRaO5FKnZgdnES1uvJDjzJlrwHYe76pxdbIq3osKSRgUCa1Nf8to4WwZGNB
	BXhvu8Q5G4MVCk3gsY2muylLirLrAc4idBRuLIupV4eFP0gLTNuc9RNEbrDYqir1iaw==
X-Gm-Gg: ASbGncsmarI9PijZ71yZXLK1MLvXLrp4ahgbn4Rjla1ahE/SfjchFJb28QmlehMLsHc
	JaJsLkycDpQLsefNVky0i856DfGoc3RzEcnSfkoThH15een3d9C/q8bomI9y1CnbwXyUx79POgO
	YQnFrWOEhKfoJ++BAiehgj3gq76DyG6ph41CjF2BMr/rgiHpZQBfFZQ09bWXnoc9LgqOV8llZo6
	b1G/DdJO74x6rDwcB9uAGPoKlj+T3QWTI7RpdtlJcERumHM5VJNs9O8Qk9YPVdEcmXZcrfxoc+t
	Acdn8AvdB1msX/v/hkqUSFZtv4BvV8I8ijWviPAGjS4laMUW1EqeFVtQkIwA1HqCr8PGVTbffBw
	yAqCjYjip98kZuQGYqRW0ldc=
X-Received: by 2002:a05:600c:35d4:b0:43d:abd:ad1c with SMTP id 5b1f17b1804b1-459e7440902mr54691985e9.6.1754572508991;
        Thu, 07 Aug 2025 06:15:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IES0zbDgiFtIMLurP4jaGdX+lg+7QeTWhWmoc1YE1i42QiR0yB42DLVlO7szOf+gfWylt/oDQ==
X-Received: by 2002:a05:600c:35d4:b0:43d:abd:ad1c with SMTP id 5b1f17b1804b1-459e7440902mr54691615e9.6.1754572508454;
        Thu, 07 Aug 2025 06:15:08 -0700 (PDT)
Received: from jlelli-thinkpadt14gen4.remote.csb (host-2-102-14-151.as13285.net. [2.102.14.151])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-459de91ea4csm147149985e9.10.2025.08.07.06.15.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Aug 2025 06:15:07 -0700 (PDT)
Date: Thu, 7 Aug 2025 14:15:06 +0100
From: Juri Lelli <juri.lelli@redhat.com>
To: Waiman Long <longman@redhat.com>
Cc: Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>,
	Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
	Ingo Molnar <mingo@kernel.org>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>
Subject: Re: [PATCH 1/3] cgroup/cpuset: Use static_branch_enable_cpuslocked()
 on cpusets_insane_config_key
Message-ID: <aJSm2sG1G_mk_1P-@jlelli-thinkpadt14gen4.remote.csb>
References: <20250806172430.1155133-1-longman@redhat.com>
 <20250806172430.1155133-2-longman@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250806172430.1155133-2-longman@redhat.com>

Hi,

On 06/08/25 13:24, Waiman Long wrote:
> The following lockdep splat was observed.
> 
> [  812.359086] ============================================
> [  812.359089] WARNING: possible recursive locking detected
> [  812.359097] --------------------------------------------
> [  812.359100] runtest.sh/30042 is trying to acquire lock:
> [  812.359105] ffffffffa7f27420 (cpu_hotplug_lock){++++}-{0:0}, at: static_key_enable+0xe/0x20
> [  812.359131]
> [  812.359131] but task is already holding lock:
> [  812.359134] ffffffffa7f27420 (cpu_hotplug_lock){++++}-{0:0}, at: cpuset_write_resmask+0x98/0xa70
>      :
> [  812.359267] Call Trace:
> [  812.359272]  <TASK>
> [  812.359367]  cpus_read_lock+0x3c/0xe0
> [  812.359382]  static_key_enable+0xe/0x20
> [  812.359389]  check_insane_mems_config.part.0+0x11/0x30
> [  812.359398]  cpuset_write_resmask+0x9f2/0xa70
> [  812.359411]  cgroup_file_write+0x1c7/0x660
> [  812.359467]  kernfs_fop_write_iter+0x358/0x530
> [  812.359479]  vfs_write+0xabe/0x1250
> [  812.359529]  ksys_write+0xf9/0x1d0
> [  812.359558]  do_syscall_64+0x5f/0xe0
> 
> Since commit d74b27d63a8b ("cgroup/cpuset: Change cpuset_rwsem
> and hotplug lock order"), the ordering of cpu hotplug lock
> and cpuset_mutex had been reversed. That patch correctly
> used the cpuslocked version of the static branch API to enable
> cpusets_pre_enable_key and cpusets_enabled_key, but it didn't do the
> same for cpusets_insane_config_key.
> 
> The cpusets_insane_config_key can be enabled in the
> check_insane_mems_config() which is called from update_nodemask()
> or cpuset_hotplug_update_tasks() with both cpu hotplug lock and
> cpuset_mutex held. Deadlock can happen with a pending hotplug event that
> tries to acquire the cpu hotplug write lock which will block further
> cpus_read_lock() attempt from check_insane_mems_config(). Fix that by
> switching to use static_branch_enable_cpuslocked().
> 
> Fixes: d74b27d63a8b ("cgroup/cpuset: Change cpuset_rwsem and hotplug lock order")
> Signed-off-by: Waiman Long <longman@redhat.com>
> ---

Looks good to me. Thanks for spotting and fixing this.

Reviewed-by: Juri Lelli <juri.lelli@redhat.com>

Best,
Juri


