Return-Path: <linux-kernel+bounces-789864-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3595AB39BC3
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 13:40:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C960D560393
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 11:40:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07F4EB665;
	Thu, 28 Aug 2025 11:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="C83XqEow"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84539265298
	for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 11:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756381203; cv=none; b=p+xIi6Z8cs9FOz+BPAQ/OJCkfGCA6eOUxFGlX5a8xZY/0rRiFX94OgGtYLGsXfZb4o+ytXY3aC4U1ne5t6wqzKXlpO8Zm/N7kXy7Z8hK8+uBi2JDEuPtRXBGfhdXy8zsA+EI/s1b/xj1gl8dvnQjEOjK4HVZBB6sbPn/9UsNnu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756381203; c=relaxed/simple;
	bh=O7xdEYswjygSFKghVFDGoQEw6p/6DC20s/4mgaboZKw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=RTttiKIUAh2dfBYWLKK3XENxrK9X7cvEs/OnNJYLApUW1jfpL6OyJDy5cZZTZvv4NixaU2+rjkteUPy07SsuXWr5ZI1KZ+UqP50gOz1hMtboQALYaxSbk/iwqaFQl2HbSEftpQyo7gRqQOiaZVuiXfLLBU9Z0XaXWo03kfpAivo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=C83XqEow; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756381200;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+tCqT5/nyItEZam3sx+EY/DN0F99uvzrdRTcSCk3iUE=;
	b=C83XqEowjYql3x0J1zHgLTvJYWyzeSD6LILgEfMEICnT4tzklcOBGmu6xgpfpS+XE9CFmw
	RrlZ7HnsYGd7WLjIkQq1qGmciNnNA5r4g7TzEC986bi9NbVTfttqiulzOpVnp25FLgW3ND
	5y8g3JsUc2eNYNAJb0BA9XDCzWw7Fwk=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-608-mQd4hosEN5ymNAyYSmwFdA-1; Thu, 28 Aug 2025 07:39:58 -0400
X-MC-Unique: mQd4hosEN5ymNAyYSmwFdA-1
X-Mimecast-MFC-AGG-ID: mQd4hosEN5ymNAyYSmwFdA_1756381197
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-7f674810ddbso240314085a.3
        for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 04:39:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756381197; x=1756985997;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+tCqT5/nyItEZam3sx+EY/DN0F99uvzrdRTcSCk3iUE=;
        b=tf3T5Z28Ka+55UnhSlrYhwErgIysq2gARyyHUX8G+XW7Nty3CP7+mj+cIaFYLptXqK
         7J/EfqY2K8Qn4dRwWkOltrf60qTloX5jmnp2kFFb9+m5aLjV5u0olEM7gO+Az32RPSgP
         uPzk7YcuUvP5lPmIvZeHgEbp4LQFOzInd83C+SUibJ9aldw30ydwpgA5GCZ/1JXae7EG
         XlNO02j2c/7wCNgi/BMPTkliJ4EGyATaxzO/uJ0tC4lkKDcTsWhiNOE+hsdVE1/qwDR6
         fPZyabvBGMhYZWrt7JW8qeiDTC3rpuFFQ6f8BQHQuBJsCEt1ZBtzOVoFjsWlv8XZ5veU
         X5Fg==
X-Forwarded-Encrypted: i=1; AJvYcCX2HQrC9wm1WxFL0CXq4+ZI1IKwRUQjv2x/gfc2iUa89+wkXedqwpU9tx1MfRUHTOMy+EnT1tpzYEVRRAk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yza6GIS6vba6ogYTP/dyWeW6idGv0Vw9NAS6KEgOuWjNbTTSW5c
	ALGsOSv6VEt6BBl7fzmcjLpu/FJLrr8LJotVKEFhLs2y4spD2w2rZ9mr52OtcSwYXMOT15UrbuW
	I/Vq2bb8wLBUtC0ZOYewfDEx4wLCm+S+Cp+XVbBPcs1ZlI3viZobQPAdwJVjME+BxrA==
X-Gm-Gg: ASbGnctsDf/KxJmr56xiRIIR9umR7YekvfyJ4yi2jp/9o7XwQlL5Wmg53VyYoHpIAAx
	qyeiDIQ4OewO+yIcLdbZ5ImtyncxYbtYGuys3wmBT9fiWfhgwhsH2K7WMyMIXNTquLDrSAM85jH
	jMGL1XnXSTH1nLd0XV/gr0QGA4X85TqqG1BeOvCwVZEFN2u0/2+5C8qL/TCzLI0ungEc/bdZ+Ad
	k+Yc0ht2aeLfxGjou2vewLkq+wB8wqVZp1QvvBzYiyt6iYzX9BciIeVElvept7ZiMOZ86VyfZVR
	F2uTi4GKPON3GvBuVc3YOQVkibwmpwFgCXIXmlR88R3zjn9JqKMgqOM4AXH4UgjaOICiknX4/Jd
	iOi9xBUsH8xR53Au+wfJYAcDk
X-Received: by 2002:a05:620a:2951:b0:7f0:21be:5fb4 with SMTP id af79cd13be357-7f021be64c3mr1705796585a.35.1756381197377;
        Thu, 28 Aug 2025 04:39:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEe/KT7M75lXMqJagZz8fr9J7i71gy5nhg7Cmmy62zuCLwA03Rm3Yc6Uqbz4JJ+BwYMpG+vaw==
X-Received: by 2002:a05:620a:2951:b0:7f0:21be:5fb4 with SMTP id af79cd13be357-7f021be64c3mr1705792485a.35.1756381196672;
        Thu, 28 Aug 2025 04:39:56 -0700 (PDT)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (213-44-135-146.abo.bbox.fr. [213.44.135.146])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7f9a317338csm183426085a.18.2025.08.28.04.39.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Aug 2025 04:39:55 -0700 (PDT)
From: Valentin Schneider <vschneid@redhat.com>
To: K Prateek Nayak <kprateek.nayak@amd.com>, Ingo Molnar
 <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Juri Lelli
 <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>,
 Leon
 Romanovsky <leon@kernel.org>, linux-kernel@vger.kernel.org
Cc: Steve Wahl <steve.wahl@hpe.com>, Dietmar Eggemann
 <dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>, Ben
 Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, K Prateek Nayak
 <kprateek.nayak@amd.com>, Tim Chen <tim.c.chen@linux.intel.com>, Vinicius
 Costa Gomes <vinicius.gomes@intel.com>
Subject: Re: [PATCH v6] sched/fair: Get rid of sched_domains_curr_level hack
 for tl->cpumask()
In-Reply-To: <20250825120244.11093-1-kprateek.nayak@amd.com>
References: <20250825120244.11093-1-kprateek.nayak@amd.com>
Date: Thu, 28 Aug 2025 13:39:52 +0200
Message-ID: <xhsmha53jllo7.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 25/08/25 12:02, K Prateek Nayak wrote:
> From: Peter Zijlstra <peterz@infradead.org>
>
> Leon [1] and Vinicius [2] noted a topology_span_sane() warning during
> their testing starting from v6.16-rc1. Debug that followed pointed to
> the tl->mask() for the NODE domain being incorrectly resolved to that of
> the highest NUMA domain.
>
> tl->mask() for NODE is set to the sd_numa_mask() which depends on the
> global "sched_domains_curr_level" hack. "sched_domains_curr_level" is
> set to the "tl->numa_level" during tl traversal in build_sched_domains()
> calling sd_init() but was not reset before topology_span_sane().
>
> Since "tl->numa_level" still reflected the old value from
> build_sched_domains(), topology_span_sane() for the NODE domain trips
> when the span of the last NUMA domain overlaps.
>
> Instead of replicating the "sched_domains_curr_level" hack, get rid of
> it entirely and instead, pass the entire "sched_domain_topology_level"
> object to tl->cpumask() function to prevent such mishap in the future.
>
> sd_numa_mask() now directly references "tl->numa_level" instead of
> relying on the global "sched_domains_curr_level" hack to index into
> sched_domains_numa_masks[].
>

Oh am I happy to see that hack go :D

> The original warning was reproducible on the following NUMA topology
> reported by Leon:
>
>     $ sudo numactl -H
>     available: 5 nodes (0-4)
>     node 0 cpus: 0 1
>     node 0 size: 2927 MB
>     node 0 free: 1603 MB
>     node 1 cpus: 2 3
>     node 1 size: 3023 MB
>     node 1 free: 3008 MB
>     node 2 cpus: 4 5
>     node 2 size: 3023 MB
>     node 2 free: 3007 MB
>     node 3 cpus: 6 7
>     node 3 size: 3023 MB
>     node 3 free: 3002 MB
>     node 4 cpus: 8 9
>     node 4 size: 3022 MB
>     node 4 free: 2718 MB
>     node distances:
>     node   0   1   2   3   4
>       0:  10  39  38  37  36
>       1:  39  10  38  37  36
>       2:  38  38  10  37  36
>       3:  37  37  37  10  36
>       4:  36  36  36  36  10
>
> The above topology can be mimicked using the following QEMU cmd that was
> used to reproduce the warning and test the fix:
>
>      sudo qemu-system-x86_64 -enable-kvm -cpu host \
>      -m 20G -smp cpus=10,sockets=10 -machine q35 \
>      -object memory-backend-ram,size=4G,id=m0 \
>      -object memory-backend-ram,size=4G,id=m1 \
>      -object memory-backend-ram,size=4G,id=m2 \
>      -object memory-backend-ram,size=4G,id=m3 \
>      -object memory-backend-ram,size=4G,id=m4 \
>      -numa node,cpus=0-1,memdev=m0,nodeid=0 \
>      -numa node,cpus=2-3,memdev=m1,nodeid=1 \
>      -numa node,cpus=4-5,memdev=m2,nodeid=2 \
>      -numa node,cpus=6-7,memdev=m3,nodeid=3 \
>      -numa node,cpus=8-9,memdev=m4,nodeid=4 \
>      -numa dist,src=0,dst=1,val=39 \
>      -numa dist,src=0,dst=2,val=38 \
>      -numa dist,src=0,dst=3,val=37 \
>      -numa dist,src=0,dst=4,val=36 \
>      -numa dist,src=1,dst=0,val=39 \
>      -numa dist,src=1,dst=2,val=38 \
>      -numa dist,src=1,dst=3,val=37 \
>      -numa dist,src=1,dst=4,val=36 \
>      -numa dist,src=2,dst=0,val=38 \
>      -numa dist,src=2,dst=1,val=38 \
>      -numa dist,src=2,dst=3,val=37 \
>      -numa dist,src=2,dst=4,val=36 \
>      -numa dist,src=3,dst=0,val=37 \
>      -numa dist,src=3,dst=1,val=37 \
>      -numa dist,src=3,dst=2,val=37 \
>      -numa dist,src=3,dst=4,val=36 \
>      -numa dist,src=4,dst=0,val=36 \
>      -numa dist,src=4,dst=1,val=36 \
>      -numa dist,src=4,dst=2,val=36 \
>      -numa dist,src=4,dst=3,val=36 \
>      ...
>
>   [ prateek: Moved common functions to include/linux/sched/topology.h,
>     reuse the common bits for s390 and ppc, commit message ]
>
> Reported-by: Leon Romanovsky <leon@kernel.org>
> Closes: https://lore.kernel.org/lkml/20250610110701.GA256154@unreal/ [1]
> Fixes: ccf74128d66c ("sched/topology: Assert non-NUMA topology masks don't (partially) overlap") # ce29a7da84cd, f55dac1dafb3
> Link: https://lore.kernel.org/lkml/a3de98387abad28592e6ab591f3ff6107fe01dc1.1755893468.git.tim.c.chen@linux.intel.com/ [2]
> Not-yet-signed-off-by: Peter Zijlstra <peterz@infradead.org>
> Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>

Reviewed-by: Valentin Schneider <vschneid@redhat.com>
Tested-by: Valentin Schneider <vschneid@redhat.com>


