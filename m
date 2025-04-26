Return-Path: <linux-kernel+bounces-621247-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 91ECCA9D6B2
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Apr 2025 02:31:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C38C188B02B
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Apr 2025 00:31:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73C071E32BE;
	Sat, 26 Apr 2025 00:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QI642TQa"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7979B189902
	for <linux-kernel@vger.kernel.org>; Sat, 26 Apr 2025 00:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745627486; cv=none; b=jahyUmBiKKIR8PIi2eA72zHSohlHoS28huqTGmCDzNoTvLoNGht8kEPmisvRN7ajNSU3i4wLHpzqA8QQfO4wjDmyqu0BxlEflKuNBPkcn3zc+nmc9TaodXSCycN7T0gZaVNsuk6RyaHGDgPrWWxPtPvLMR0Ipn+S5ZmBloH6MHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745627486; c=relaxed/simple;
	bh=9sS1jQlaw0aSh3DzVS54yCwHjJWlT7MMzb9Lp5mX0Iw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=pisVmLCGsYNgyudQti+Uy4parxiTftXe333bEWGIPoF3J72LW/WdCVA4olEgUGryCuB1m3GhNtDJzalyG8R8lXcTnSJj4BTelb8fyOToy1oXaInlDSCYc3O0PDbSQzSVY2VvWVkWXTVkKbG8FeysZfxjaBw/oovgP6uJNoSvIDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QI642TQa; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2ff64898e2aso2886664a91.1
        for <linux-kernel@vger.kernel.org>; Fri, 25 Apr 2025 17:31:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1745627485; x=1746232285; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=b3IOGBjTq7O8fLAPAnxSaHu8qhCTmDkeWLsMrPMzyQw=;
        b=QI642TQaiIkjK6ognItduvPNPmZ+zYZ9/4R0j7CquVNNqsAGbR4pp+CZAxk9QvBwKn
         88OXCZjYSvmRndr1W6dibBqlHegldB2A7XVNYKar/LnW3vGXXqSoeTqcIWw5dvQDXaQg
         eIWMDaiU1kXH8S7s0ZYglWtJx9K8RyuJ9qwEG/CeSvTNSUEkhgL7CRgGXCwsRRdcIfJ7
         G2b9fTNA662PlF12MrwNGXrN/7SiFsXRyIQKgThQ7Pg4xCBS+TWHlCMuxdfXmp+9zo0X
         kfIrp5nr1B5hSsKRF0RB/qO+DSdSTPD79FtuVEQpstvJknJIFR/jLfPQlJ/TZCN3Zof9
         oyFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745627485; x=1746232285;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=b3IOGBjTq7O8fLAPAnxSaHu8qhCTmDkeWLsMrPMzyQw=;
        b=q5KPWM3lmfRlcqgv3yNYVwJ+qO2Gmb5vAGwts1Ea2vy33mE890b5bCJFqqhQpi/xsw
         KpMxRRgQYbV5LIAGvGUE9BMtYfSKF36Bl2lwvXLHxqFUyS8st9GL2hELx0pLYac9Owzk
         0smcZtdyEChWk3e6KM797nhu63KRUaViOQX/fOuOZEEsUKc+PWHNzaleqLToLLW6ZjUo
         PY6D8d19xDZcmG3C2P0a9qcTeF72IxkVXygqihnVOtEe28ACH6jySXw02SKLTzCB7qvO
         zFzCPq3ZyOW7EiBvXM2ix/16N+ui9BTr9Lbc2wQZSIHffGuAXH1jnpuwGhrM8UP9hBbD
         rSDA==
X-Forwarded-Encrypted: i=1; AJvYcCXqGi5jMse9uGxjU9xwZeHdUmkxy8bHzBrVzELGlSI0lCkUAKaCgWftE/1RjHPz+nCMmNDkh6vseM0QVBU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDVHu0+VPDk4JsvoXSrbkf9grRhEyAeRO8Q9UFs87eKryrlJDe
	yRnwbBsAmXDlQovyWqqjT8tUCdq1o63RpYreJa0VNs5pmYIYcxnkkX8ULoNDPWkr2Wq1x9LC5U1
	J8A==
X-Google-Smtp-Source: AGHT+IGaqe210ByAqDm+K8vGUEeK+g5oQ8arD5NGMbUumTCn7JblOSFTW5m4cc+cQQlAJi5i/WKfSnsklF0=
X-Received: from pjoo7.prod.google.com ([2002:a17:90b:5827:b0:308:867e:1ced])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90a:fc46:b0:302:fc48:4f0a
 with SMTP id 98e67ed59e1d1-309f8786e57mr6500844a91.0.1745627484755; Fri, 25
 Apr 2025 17:31:24 -0700 (PDT)
Date: Fri, 25 Apr 2025 17:31:23 -0700
In-Reply-To: <20250414200929.3098202-6-jthoughton@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250414200929.3098202-1-jthoughton@google.com> <20250414200929.3098202-6-jthoughton@google.com>
Message-ID: <aAwpWwMIJEjtL5F9@google.com>
Subject: Re: [PATCH v3 5/5] KVM: selftests: access_tracking_perf_test: Use
 MGLRU for access tracking
From: Sean Christopherson <seanjc@google.com>
To: James Houghton <jthoughton@google.com>
Cc: kvm@vger.kernel.org, Maxim Levitsky <mlevitsk@redhat.com>, 
	Axel Rasmussen <axelrasmussen@google.com>, Tejun Heo <tj@kernel.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, mkoutny@suse.com, Yosry Ahmed <yosry.ahmed@linux.dev>, 
	Yu Zhao <yuzhao@google.com>, David Matlack <dmatlack@google.com>, cgroups@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Mon, Apr 14, 2025, James Houghton wrote:
> By using MGLRU's debugfs for invoking test_young() and clear_young(), we
> avoid page_idle's incompatibility with MGLRU, and we can mark pages as
> idle (clear_young()) much faster.
> 
> The ability to use page_idle is left in, as it is useful for kernels
> that do not have MGLRU built in. If MGLRU is enabled but is not usable
> (e.g. we can't access the debugfs mount), the test will fail, as
> page_idle is not compatible with MGLRU.
> 
> cgroup utility functions have been borrowed so that, when running with
> MGLRU, we can create a memcg in which to run our test.
> 
> Other MGLRU-debugfs-specific parsing code has been added to
> lru_gen_util.{c,h}.

This fails on my end due to not being able to find the cgroup.  I spent about 15
minutes poking at it and gave it.  FWIW, this is on our devrez hosts, so it's
presumably similar hardware to what you tested on.

Even if this turns out to be PEBKAC or some CONFIG_XXX incompatibility, there
needs to be better hints provided to the user of how they can some this.

And this would be a perfect opportunity to clean up this:

 	__TEST_REQUIRE(page_idle_fd >= 0,
		       "CONFIG_IDLE_PAGE_TRACKING is not enabled");

I can't count the number of times I've forgotten to run the test with root
privileges, and wasted a bunch of time remembering it's not that the kernel
doesn't have CONFIG_IDLE_PAGE_TRACKING, but that /sys/kernel/mm/page_idle/bitmap
isn't accessible.

I mention that, because on a kernel with MGRLU available but disabled, and
CONFIG_IDLE_PAGE_TRACKING=n, the user has no idea that they _can_ run the test
without mucking with their kernel.

==== Test Assertion Failure ====
  lib/lru_gen_util.c:229: stats->memcg_id > 0
  pid=423298 tid=423298 errno=2 - No such file or directory
     1	0x0000000000408b45: lru_gen_read_memcg_stats at lru_gen_util.c:229
     2	0x0000000000402e4c: run_test at access_tracking_perf_test.c:421
     3	0x0000000000403694: for_each_guest_mode at guest_modes.c:96
     4	0x00000000004023dd: run_test_in_cg at access_tracking_perf_test.c:467
     5	0x000000000041ba65: cg_run at cgroup_util.c:362
     6	0x0000000000402042: main at access_tracking_perf_test.c:583
     7	0x000000000041c753: __libc_start_call_main at libc-start.o:?
     8	0x000000000041e9ac: __libc_start_main_impl at ??:?
     9	0x0000000000402280: _start at ??:?
  Couldn't find memcg: access_tracking_perf_test
Did the memcg get created in the proper mount?
Destroying cgroup: /sys/fs/cgroup/access_tracking_perf_test

