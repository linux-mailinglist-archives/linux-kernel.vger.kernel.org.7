Return-Path: <linux-kernel+bounces-840029-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 44BDABB3601
	for <lists+linux-kernel@lfdr.de>; Thu, 02 Oct 2025 11:00:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B15981921572
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Oct 2025 09:01:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1505E2FFFAB;
	Thu,  2 Oct 2025 09:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XhMaUHuY"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BA192D46CC
	for <linux-kernel@vger.kernel.org>; Thu,  2 Oct 2025 09:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759395637; cv=none; b=B5PJQ7k25ZZxRRzMltOnncrAr4JNMJLXtUqWHJ7/A4OVOS0SsEv2bDQ9p1DZEHZiheJzncEpCNoYekOikaKqhWHhRwudjTw2/h+iuJHtghHe5+0TVVvoAiVvub5eufp4k8XiDDINQBeIdR4JQ6ib/hvBqubkkSc0j8SiuV4FasA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759395637; c=relaxed/simple;
	bh=84AylPn9YmG6sx5ZDrib8oBlfrTRDhaIPTl2lTgieP0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eiiouyk2UeBK3D9bA4Cj1XqsgVFZksDylZDtYPtMA3WC8lKlKBE0A346NBaG5oHWB/OHtLZDHhNF8iCM6yg0pUa7Yg+y5b7doCNoshF5Tiej9+nuSfTMWsw24CqdKUHzwecf8ZMyOopPyL3UjSPJmfMNmkYyKLrtcBieL4qQTe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XhMaUHuY; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759395633;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=21WYNQWAkUtv9ZDQIyJYgljvqkz5iY9O2fZMXh5kL3Y=;
	b=XhMaUHuYi8ZhFw5wmegSg3NIRz/fZ/8CckaFU9L5wwyHxhErRcUlA6FX6tyHlzgQU83kg6
	YIoyniIbC7oW5+5PhVLupMAP7frNjKHDiDPEgbbY0HY71e7TtwcE/ruy6Fx5X46BfzQubf
	6oc7il1viscGCMqZVbfcgepdfhT3hZU=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-423-3Ir_E43SNCGu59-DIugn5Q-1; Thu, 02 Oct 2025 05:00:32 -0400
X-MC-Unique: 3Ir_E43SNCGu59-DIugn5Q-1
X-Mimecast-MFC-AGG-ID: 3Ir_E43SNCGu59-DIugn5Q_1759395632
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-86835654255so281112485a.3
        for <linux-kernel@vger.kernel.org>; Thu, 02 Oct 2025 02:00:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759395631; x=1760000431;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=21WYNQWAkUtv9ZDQIyJYgljvqkz5iY9O2fZMXh5kL3Y=;
        b=V0OnzAZHHa+qp9GrDRdm6dNWrFIrdBShzZvjnVgGxY+eWbIPrDdx2SO2Kf3zClRanS
         o99m6WNaiK1bBdwm/SqfiLmhBAVZt0sOQvfCdLpw2U5q6FrPVACf4OHq+zLK0koEKJS3
         JRDBt/V/bI+rgAVLXK45+iPfPJJbTNerELJKcBMa23lyzSdiJn5AuE/xZ3vl7bJsBHF2
         V+fP46XUbg8x5h0Xe894kULqu9o8QnpeUdfdXpiPtrlfLr/1cHLNX/E7VPs6q+MKN0jL
         TFL5DWmjDLWGh1Dw9HmqzjdYtAfXLw7zVhaLbcGwA+XZ19wFeIlVzJ/5H+yvsYRhBfR8
         Z/Sg==
X-Forwarded-Encrypted: i=1; AJvYcCWtmT07ZteghWkN0BafWcNW4cMyG6Fx9tqbJVOdbGDuQZo/61RUQvnMKgJkxMn2JMM7H3ItxNapHUPYJdo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzit8swYlH2nwvA0izoPypby2MOCaZ30/2i0ypUNbTy40Ms108J
	rbrpE4csYxJIpMyNFWGqbLfa2kWaRTIC9N8fmBz1WvDfb6BPkGVEPdcXZs4esitGuRtmLcpOv1L
	d1tLfYVJYSvGQGGBuGuH1X6S/ejWZt1u7bzBNmKdWb7kwKw2Bdc1O2Bd5g0k+fK65cV8VJTBO+g
	==
X-Gm-Gg: ASbGnctsU+tD8o/jKJ3VaER30JEZQF1KyWY2/BfeZMJSbQzXvIP1fapb3zs+SKLFm7L
	9kokFC0kshHrMhBJNI/qX5AW4nliE2nmLCTRV+6PSIZz9+nLW7hhhKCrnjlOBHhk3SaIHw1OJwR
	S7Ihnjguwnt7WWgyQmgpgJfzfa/HuGoKYcn16vrQxz2EtVvCDVTrprHmVhxrQUQHKQBEAjd7TBl
	VWC1cu2ivvoHOg0b3SBsKYyJn+xm6gltvmLAZDbpOSpt0jm4x0e+PXuKh+7ckAVQFJlnPWTlwob
	Gz9H485SmZaJ49SZeXQDZnsDgkKdVdomX+n/CUJW4HWz99IrRZMTNkz5gzkEXPL4LzyPTa2K8Ya
	N9/lV4yKaio6foAocYcPQYapM
X-Received: by 2002:a05:620a:4402:b0:855:f375:10aa with SMTP id af79cd13be357-873751a3db1mr1083180585a.50.1759395630544;
        Thu, 02 Oct 2025 02:00:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFqzT24HMYpswltDE7EhM3N86IdyzZOua3jmE97sJb4IHI0ZAe32f3e7KICakO9PqOrrZ4/kg==
X-Received: by 2002:a05:620a:4402:b0:855:f375:10aa with SMTP id af79cd13be357-873751a3db1mr1083174385a.50.1759395629894;
        Thu, 02 Oct 2025 02:00:29 -0700 (PDT)
Received: from jlelli-thinkpadt14gen4.remote.csb (host-80-47-6-60.as13285.net. [80.47.6.60])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-87772460a54sm168528585a.18.2025.10.02.02.00.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Oct 2025 02:00:29 -0700 (PDT)
Date: Thu, 2 Oct 2025 10:00:24 +0100
From: Juri Lelli <juri.lelli@redhat.com>
To: Yuri Andriaccio <yurand2000@gmail.com>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	linux-kernel@vger.kernel.org,
	Luca Abeni <luca.abeni@santannapisa.it>,
	Yuri Andriaccio <yuri.andriaccio@santannapisa.it>
Subject: Re: [RFC PATCH v3 00/24] Hierarchical Constant Bandwidth Server
Message-ID: <aN4_KE-5kOCbpQux@jlelli-thinkpadt14gen4.remote.csb>
References: <20250929092221.10947-1-yurand2000@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250929092221.10947-1-yurand2000@gmail.com>

Hello!

On 29/09/25 11:21, Yuri Andriaccio wrote:
> Hello,
> 
> This is the v3 for Hierarchical Constant Bandwidth Server, aiming at replacing
> the current RT_GROUP_SCHED mechanism with something more robust and
> theoretically sound. The patchset has been presented at OSPM25
> (https://retis.sssup.it/ospm-summit/), and a summary of its inner workings can
> be found at https://lwn.net/Articles/1021332/ . You can find the previous
> versions of this patchset at the bottom of the page, in particular version 1
> which talks in more detail what this patchset is all about and how it is
> implemented.
> 
> This v3 version further reworks some of the patches as suggested by Juri Lelli.
> While most of the work is refactorings, the following were also changed:
> - The first patch which removed fair-servers' bandwidth accounting has been
>   removed, as it was deemed wrong. You can find the last version of this removed
>   patch, just for history reasons, here:
>   https://lore.kernel.org/all/20250903114448.664452-1-yurand2000@gmail.com/

Peter wasn't indeed happy with that patch, but I am not sure we finished
that discussion. Both myself and Luca had further objections to what
Peter said, but not further replies after (which can very well be a sign
that he is still adamnt in saying no go away :). Peter?

https://lore.kernel.org/lkml/aLk9BNnFYZ3bhVAE@jlelli-thinkpadt14gen4.remote.csb/
https://lore.kernel.org/lkml/20250904091217.78de3dde@luca64/

...

> For this v3 version we've also polished the testing system we are using and made
> it public for testers to run on their own machines. The source code can be found
> at https://github.com/Yurand2000/HCBS-Test-Suite , along with a README that
> explains how to use it. Nonetheless I've reported a description of the tools and
> instruction later in the page.

Thanks for this. Quite cool. I tried to run the tests, but it looks like
the migration set brought my qemu 8 CPUs system to an halt (had to kill
the thing). I will try again.

I have been working a bit in trying to come up with a testing framework
for SCHED_DEADLINE, which I didn't unfortunately posted yet mostly
because I was waiting for the discussion about the patch mentioned above
to settle (which would require adaptation in the tests that check for
bandwidth limits). You can find the idea here [1]. It's thought to be
an addition to kselftests. I believe your test suite can be extended to
cover the tests I implemented and more, so I am not super attached to my
attempt, but it would be good (I think) to converge to something that we
can maintain for the future, so maybe have a plan to possibly merge the
suites. What do you think?

1 - https://github.com/jlelli/linux/commits/experimental/deadline-selftests-scripts/

...

> Testing v3:
> 
> The HCBS mechanism has been evaluated on several syntetic tests which are
> designed to stress the HCBS scheduler and verify that non-interference and
> mathematical schedulability guarantees are really enforced by the scheduling
> algorithm.

...

> The tasksets minimal requirements were computed using a closed-source software,
> explaining why the tasksets are supplied separately. A open-source analyser is
> being written to update this step in the future and also allow for more
> customization for the testers.

On this (generation of random taskset and corresponding schedulability
checks) I also started working on a different tool, rt-audit.

https://github.com/jlelli/rt-audit

It's very simple, the tool, the random generation and the checks. But I
honestly like the idea that it's based on rt-app. Please take a look if
you have a chance and tell me what you think. Again, I feel it would be
good to converge towards something open that we can maintain.

I will be trying to find time to continue testing and reviewing this RFC
of course.

Thanks,
Juri


