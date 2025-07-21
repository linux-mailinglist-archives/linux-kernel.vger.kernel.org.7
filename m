Return-Path: <linux-kernel+bounces-739871-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4381B0CC56
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 23:17:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 15AD65420C2
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 21:17:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06A7D23C4FA;
	Mon, 21 Jul 2025 21:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=maine.edu header.i=@maine.edu header.b="FobE9HHn"
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62F70213E9F
	for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 21:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753132657; cv=none; b=ZIhFdCGDJZlRuzWixP/ib8XC1KuRCbPPFB9mhvzkQauYgMUeF9qbhoW26s6ZAee5FPkV+N+v5mkMDCday+Kqv6xv3VLvRMG9UdfKidvP14BOnJHMnSwbk4wbTeH3rFfxTmkMRXNYDyjqRMOemamp06+W2in16Nsl5/Il8I1XU9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753132657; c=relaxed/simple;
	bh=zdUKaEQPaR0Y8p/zfg05UZDAo7TL4JCVF0QTyHSO8x0=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=b4WbjlAwJ5Kx6qg8QIdzwfHbdLwSBdKXGaUsJWmAY7x7ccxd5bqrZNPdJ53w1+2zN9GUGvTpWfld8P4bwNziWTMNj5l2XQdu/e/3cnil+2RMbepO6vY/nWzNH8qI1J6QUnAUmbl7sWtxTn8x4b1j8lBsLxU0H/Hfy5+yHzMslpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=maine.edu; spf=pass smtp.mailfrom=maine.edu; dkim=pass (1024-bit key) header.d=maine.edu header.i=@maine.edu header.b=FobE9HHn; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=maine.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maine.edu
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-4ab9ba884c6so61414041cf.0
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 14:17:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=maine.edu; s=google; t=1753132654; x=1753737454; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:date
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=qWGJk1iJIsjh54/ScdRo2P8arFiYQbmD3zTFqCzvJy0=;
        b=FobE9HHnoGddf1Gua2+kXxL20cg04/Zda9sIKfOv+pjKCVRh56NSlXaxN0PSS+GkDS
         y2vuFHhIlV/5UmzZOqrrHzoJkEAr8x49oUkF/VwlKZBARqO6WOZW7kJyBeiRiwlvnA0K
         uz0Z46aQGxpLqMUGXRwPOerdrkc58VzyfuMJM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753132654; x=1753737454;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:date
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qWGJk1iJIsjh54/ScdRo2P8arFiYQbmD3zTFqCzvJy0=;
        b=tWN1UJJQM74mqDIYbmeHUURApHPm2LsuOcbwhNfOFywbX0OLQngB2azbjdGROCpVIb
         p4yjt1WeAztz+Eq0eaHiFCrLRBkQDRLPsVigtRCEzMSGdueLwbgBENBVWNA7kd2cZGtc
         eOnT8zucLaECc7K529rb1nsvdTCx6AAUYj5KebW9jCx6w41GiE4g+Bz70aMKsHTsscyq
         EFwUODbJafCCfcZpVChu0njlRHtPhVQ+zazv2jO4k5JqEzhQsdQZ10dEWjE1E001YZQ4
         bNTkd1MVYnLXZeh20YyUL7d+ywVzB4DLee0dEGhcggk3MmfZoWOR/pbNL4doCBH+klA9
         qj3w==
X-Gm-Message-State: AOJu0Yw+AjNzQqLunIzMf9aw6VjkR58R6JwUD/Imvjw1W77Z+8+bqlfQ
	CZTWz0RMYcqtseghPGhm/JWMCkoTaJ9F8+6eR9NpC39XtBIwHGRsG4ZBG8BS3dXHyQ==
X-Gm-Gg: ASbGncsINLTQ2Ni+Igr4Mb5jK4XpMF7PkTAiUcWxbfm4X1YmUKs59/KTKFlZVe7/+uY
	A7oQAaArGxQL4Csmhsbicfs2iVbBgYC+mG6bLp7f8DHm7bljKA5OL8krpdCpPpjhU0n6FIiIlYT
	NPFuLVs5Eatd2C4NDG7dZgvboB5ouHiHAF3DkQNQblYNtrH+cESZJ/ZMdQLEQfkVoJazKJn93b3
	zfkUOMprRv9RDuqtm9RslEG3wXfUun7Lt/C6W2T7zRHNivOsT3o4Oh3k78jlkKzF2uir/kBTRXo
	/kD5jexfN5g705FNak5xN5Ww5Ov9lM0w1R7dvu0bk4RuamZZooLxAqy9MZrCe9U2BsvckfXV4Nn
	4gyTcPC1ecbq/bofmZoSulJuIR1m3OEkTZYXuJdi7vg==
X-Google-Smtp-Source: AGHT+IGgbc2+HpbbkCjaHb07n+MxIhFnG5PNcc7/sdOmvMZ4DuULITdNYAqCLBKU+qLcRC76lYXY1g==
X-Received: by 2002:ac8:7f93:0:b0:4a7:7c8e:1d5 with SMTP id d75a77b69052e-4ae5b7c3eb5mr18526461cf.17.1753132654248;
        Mon, 21 Jul 2025 14:17:34 -0700 (PDT)
Received: from [192.168.8.146] (weaver.eece.maine.edu. [130.111.218.23])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4abb4b46b27sm46652641cf.64.2025.07.21.14.17.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jul 2025 14:17:33 -0700 (PDT)
From: Vince Weaver <vincent.weaver@maine.edu>
X-Google-Original-From: Vince Weaver <vince@maine.edu>
Date: Mon, 21 Jul 2025 17:17:32 -0400 (EDT)
To: Vince Weaver <vincent.weaver@maine.edu>
cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
    "Liang, Kan" <kan.liang@linux.intel.com>, 
    Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
    Arnaldo Carvalho de Melo <acme@kernel.org>, 
    Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
    Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
    Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
    Adrian Hunter <adrian.hunter@intel.com>, 
    Dapeng Mi <dapeng1.mi@linux.intel.com>
Subject: Re: [perf] fuzzer triggers "BUG: kernel NULL pointer dereference"
In-Reply-To: <5baea1f7-6edd-d6fa-27ce-04eddb7e5199@maine.edu>
Message-ID: <fdcdd5a7-76b5-6c52-63dc-95fadddf7772@maine.edu>
References: <5baea1f7-6edd-d6fa-27ce-04eddb7e5199@maine.edu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII


I'm still tracking this fuzzer issue.  The fuzzer can reliably trigger the 
crash but only 32000 syscalls deep into a run and I am having a lot of 
trouble trying to gather a trace/testcase that can generate it.

I was hoping the recent
	[PATCH] perf/x86: Check if cpuc->events[*] pointer exists before accessing it
patch might fix things as the symptoms were vaguely similar but that 
particular patch does not fix the problem.

Vince

On Tue, 8 Jul 2025, Vince Weaver wrote:

> Hello
> 
> the perf_fuzzer can reliably trigger this on a 6.16-rc2 kernel.  It 
> doesn't look obviously perf related but since the perf_fuzzer triggered it 
> I thought I'd report it as a perf issue first.  I can work on a smaller 
> test case but that might take a bit especially as the machine locks up 
> super hard and requires being unplugged after it's triggered.
> 
> let me know if there's any other info I can provide.  The dump below is 
> transcribed from a screenshot as I still haven't figured out a way to get 
> a serial console on this Raptorlake system.
> 
> BUG: kernel NULL pointer dereference, address: 0000000000000008
> #PF: supervisor read access in kernel mode
> #PF: error_code(0x0000) - not-present page
> PGD 0 P4D 0
> Oops: Oops: 0000 [#1] SMP NOPTI
> CPU: 5 UID: 0 PID: 0 Comm: swapper/5 Not tainted 6.16.0-rc2+ #8 PREEMPT (voluntary)
> Hardware name: Dell Inc. Precision 3660/0VJ7G2
> RIP: 0010:rb_insert_color+0x18/0x130
> Code: 1f 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa 48 8b 07
> RSP: 0018:ffffb5e5c01e3df8 EFLAGS: 00010046
> RAX: ffff93f1927f8168 .....
> ...
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 000000000000008 CR3: 00000000596824001 CR4: 000000000000f72ef0
> DR0: 00000000a000001 ....
> PKRU: 55555554
> Call Trace:
>  <TASK>
>  timerqueue_add+0x66/0xb0
>  hrtimer_start_range_ns+0x102/0x420
>  ? next_zone+0x42/0x70
>  tick_nohz_stop_tick+0xce/0x230
>  tick_nohz_idle_stop_tick+0x70/0xd0
>  do_idle+0x1d3/240
>  cpu_startup_entry+0x29/0x30
>  start_secondary+0x119/0x140
>  common_startup_64+0x13e/0x141
>  </TASK>
> 
> 
> 

