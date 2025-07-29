Return-Path: <linux-kernel+bounces-749690-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EF7DB151A8
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 18:51:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6DF9418A3E5E
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 16:51:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 728A92989BF;
	Tue, 29 Jul 2025 16:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=maine.edu header.i=@maine.edu header.b="CvvQTq4b"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A60B1288C9C
	for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 16:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753807842; cv=none; b=qvXggc9D5b0cuAeHKtN4h6/I/MBQZPFtnRGRNlrzYfR2cC3QErdhPsWP+e6LaNDO2duU6v2kv/NNCc5po2mi7l0uM7093Gx8jQoHfoYOYehtMr+o4z2ccoUe9xgPrcOSAyw+A+YUokjk8Ni+pB+s8Rrhkmh0pfDngzfJLCsFU2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753807842; c=relaxed/simple;
	bh=wVS4ZGXL5Q8rCd9VTXRYor1vj7ZS1t7rfVvHPIDALDI=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=iqBz8OEzcBMYr2Z0APSsASvKCqDl+tjs4ep91I3Myigtw44/kRj/ZrNkHKbedeYPuHSMqQ6l9y/s0iGsR+vLzqrBvmOm1U7shOg1h85rhnnx23Oz+qwsQCipdgFVPpIyryQyJiOsELGU+Kq0baKqT9akgcBO1jhhm1hM+D6mfe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=maine.edu; spf=pass smtp.mailfrom=maine.edu; dkim=pass (1024-bit key) header.d=maine.edu header.i=@maine.edu header.b=CvvQTq4b; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=maine.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maine.edu
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-455b00283a5so34061625e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 09:50:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=maine.edu; s=google; t=1753807839; x=1754412639; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:date
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=suVvJU4WKFdmKsQQk2tvEAp6/zICUM8EOf9Pdbq8t4c=;
        b=CvvQTq4b4HB1CriswKIo+mckpjBDqeH6yDdIkhzSSm0Xj/1reoryBDEKEkhRsANvLA
         hA2udTr6+EFYhwU8107+qEChA05vO4y1GrO1LvujfDeYj0itv22tPiKr14V/yZPy4Yxy
         p2VTVodYpEh0WbN8Nur2skdyC3BJIYWM8Dqjc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753807839; x=1754412639;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:date
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=suVvJU4WKFdmKsQQk2tvEAp6/zICUM8EOf9Pdbq8t4c=;
        b=nJyBBalefW9Dfx1F9Op0KCVR1gbH6R5q1qTt9GYJTCw8YOJ7i6OrNNWQMeIJQ/D2pY
         nd9oz5zZBY94zM8YDuhuebGurHd4X5EPfT8f0a6BgMMKm18jDcJp+gEj3AYrAKvGI86A
         ZaBp68vPEXXN2BXOtVhEoe+b3jkg+v+NFd5AcW73/0B410GnLdZWmvFDTEC9TEp6BG80
         bYilsPAKLzKnMm4e1DHAlZiDYQ4zbMxxb23Xkyk1gXDfz8zCgEOCXG9+EP5ggf6UEZkx
         qQrwvGD/R69V6/mr7ROrFIWlF+Z8H3sz3u7UuD522hgs7JZTsfpWpMAJcFA1Zs0Ujm/a
         aQFg==
X-Forwarded-Encrypted: i=1; AJvYcCX/Oexwm1uMZCmntn3tSUQn/ABcqTTbUIjU/iDvAC1QHg2128x1m/SJznwPlzBllAi+CwHP0Eoz0+7Qw+s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5WdPyybrJIlF1X3YlxpUseX0JVgbPm6LbWPTpf0dI6D/yxIBT
	h1j3JDpO9BNJXa0D3Jjn7uxfMIfNbmh+7XVa/c9XI1NSvxMDUAQKRx5GfVkE1nXoBA==
X-Gm-Gg: ASbGncvTX+Nbi3bQjY/ZFsOcbEInbjLDGbpNdgayTWUU0jyEDsPA5mJ/vbjkAl+HVCz
	XzabYK8N8MlfCWWOizlMjjxfG4Ak+ECve908LcSlRW0OmmPJkWLzr2ILYculceCpzChFBUIEjz9
	sqYttoAc1hbzYei6udD5IjcT+dUnaKE7xWQjmUj3fRwxSy2K8pxsUWi98r7sSRUUaVb3Oi9RLsB
	kqI7OFJ2CcaDX07n8WZcq4hKogBSm132xfnW7AIAh1GLDJO2iB6n40uIpE/oGvzn9Kt5U6kf1q3
	DDA8+QJinWqY2b/9HHV0BpFd3aO39zkPoPzUlGTUyMj6a4WlZTlwpKQOxwMYtv/hUyp4kwailv2
	UA6ontzKU2RrSrg3CZVk6BNViS2jvd/XYcBIquFx0CQ==
X-Google-Smtp-Source: AGHT+IFrImQZIdQJ5afgNUQwJWxIUmYS11pLeuixhQihMfc6ma0YIHh7wftRZDig4J0+lfjlNM+gpw==
X-Received: by 2002:a05:600c:c4a3:b0:442:dc6f:7a21 with SMTP id 5b1f17b1804b1-45892b92f27mr5653835e9.3.1753807838783;
        Tue, 29 Jul 2025 09:50:38 -0700 (PDT)
Received: from [192.168.8.146] (weaver.eece.maine.edu. [130.111.218.23])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4588e5b7677sm32030045e9.7.2025.07.29.09.50.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Jul 2025 09:50:37 -0700 (PDT)
From: Vince Weaver <vincent.weaver@maine.edu>
X-Google-Original-From: Vince Weaver <vince@maine.edu>
Date: Tue, 29 Jul 2025 12:50:34 -0400 (EDT)
To: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
cc: Vince Weaver <vincent.weaver@maine.edu>, linux-kernel@vger.kernel.org, 
    linux-perf-users@vger.kernel.org, "Liang, Kan" <kan.liang@linux.intel.com>, 
    Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
    Arnaldo Carvalho de Melo <acme@kernel.org>, 
    Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
    Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
    Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
    Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [perf] fuzzer triggers "BUG: kernel NULL pointer dereference"
In-Reply-To: <db7043a4-f815-4178-8d81-2da1dda6236e@linux.intel.com>
Message-ID: <ff282f45-9f17-5790-174c-e765aae0038c@maine.edu>
References: <5baea1f7-6edd-d6fa-27ce-04eddb7e5199@maine.edu> <fdcdd5a7-76b5-6c52-63dc-95fadddf7772@maine.edu> <db7043a4-f815-4178-8d81-2da1dda6236e@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1991168305-1753807837=:1913886"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1991168305-1753807837=:1913886
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Tue, 29 Jul 2025, Mi, Dapeng wrote:

> Could you please provide more information about this issue?  Like HW
> information, how long can the issue be produced and whether the issue can
> be seen in latest kernel (6.16)? Thanks.

I just reproduced this with current git (6.16.0+)

This is on a RaptorLake system.

I can reproduce this issue with the perf_fuzzer but it is possibly timing 
sensitive and so if I enable fuzzer trace logging to try to make a 
reproducible test case it won't trigger anymore.

The system locks up extremely hard and so I can't really get the panic 
message besides taking a picture of the screen.

I can try enabling KASAN to see if that helps get better debug messages.

Vince


> 
> --
> 
> Dapeng Mi
> 
> On 7/22/2025 5:17 AM, Vince Weaver wrote:
> > I'm still tracking this fuzzer issue.  The fuzzer can reliably trigger the 
> > crash but only 32000 syscalls deep into a run and I am having a lot of 
> > trouble trying to gather a trace/testcase that can generate it.
> >
> > I was hoping the recent
> > 	[PATCH] perf/x86: Check if cpuc->events[*] pointer exists before accessing it
> > patch might fix things as the symptoms were vaguely similar but that 
> > particular patch does not fix the problem.
> >
> > Vince
> >
> > On Tue, 8 Jul 2025, Vince Weaver wrote:
> >
> >> Hello
> >>
> >> the perf_fuzzer can reliably trigger this on a 6.16-rc2 kernel.  It 
> >> doesn't look obviously perf related but since the perf_fuzzer triggered it 
> >> I thought I'd report it as a perf issue first.  I can work on a smaller 
> >> test case but that might take a bit especially as the machine locks up 
> >> super hard and requires being unplugged after it's triggered.
> >>
> >> let me know if there's any other info I can provide.  The dump below is 
> >> transcribed from a screenshot as I still haven't figured out a way to get 
> >> a serial console on this Raptorlake system.
> >>
> >> BUG: kernel NULL pointer dereference, address: 0000000000000008
> >> #PF: supervisor read access in kernel mode
> >> #PF: error_code(0x0000) - not-present page
> >> PGD 0 P4D 0
> >> Oops: Oops: 0000 [#1] SMP NOPTI
> >> CPU: 5 UID: 0 PID: 0 Comm: swapper/5 Not tainted 6.16.0-rc2+ #8 PREEMPT (voluntary)
> >> Hardware name: Dell Inc. Precision 3660/0VJ7G2
> >> RIP: 0010:rb_insert_color+0x18/0x130
> >> Code: 1f 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa 48 8b 07
> >> RSP: 0018:ffffb5e5c01e3df8 EFLAGS: 00010046
> >> RAX: ffff93f1927f8168 .....
> >> ...
> >> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> >> CR2: 000000000000008 CR3: 00000000596824001 CR4: 000000000000f72ef0
> >> DR0: 00000000a000001 ....
> >> PKRU: 55555554
> >> Call Trace:
> >>  <TASK>
> >>  timerqueue_add+0x66/0xb0
> >>  hrtimer_start_range_ns+0x102/0x420
> >>  ? next_zone+0x42/0x70
> >>  tick_nohz_stop_tick+0xce/0x230
> >>  tick_nohz_idle_stop_tick+0x70/0xd0
> >>  do_idle+0x1d3/240
> >>  cpu_startup_entry+0x29/0x30
> >>  start_secondary+0x119/0x140
> >>  common_startup_64+0x13e/0x141
> >>  </TASK>
> >>
> >>
> >>
> 

--8323329-1991168305-1753807837=:1913886--

