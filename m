Return-Path: <linux-kernel+bounces-847479-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 45945BCAF10
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 23:32:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 591481A6442A
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 21:32:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BCA2280339;
	Thu,  9 Oct 2025 21:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="QxosG7fR"
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D292E2690EC
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 21:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760045525; cv=none; b=YXJwN8333IJvevjLIBlqpwAF0Y4taLpjY4n9gW8/r4IkJHn6bNJky6LE9rzKmIIpXLJUFnfpyMiuEjPRQGctFzezwlQ/8k+WlxlR8KeVbZSUZr1P3/E+azF72K1YpeXaRToT4h3IIqRxCKbcbGpdCwHIUKY9OGbeCTBoXq83Ovc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760045525; c=relaxed/simple;
	bh=h4DU4ZI4l26jR/VYDpsmmv1Z5UP5Bh124MolAFeGVUo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aDXDN8v4Now1RvUynb3BCBGIGrUQ12bsWmxKJW7NJRRDKa50muf6IXYpQvQKm5sF0XzmghFLxDdQF6b9wFFoLP6tlzPRMJheKTuBiczyMKNtL+WW5gcO0p3TxGJR9rN6LRfXkPggRqfkK74vQOUsAOm5ypAjriwnFBMg+umsfoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=QxosG7fR; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-86420079b01so158610785a.1
        for <linux-kernel@vger.kernel.org>; Thu, 09 Oct 2025 14:32:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1760045523; x=1760650323; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hgkwS57YCpvcud1v9OH0HoTyTGxD5e4o9Ce5M90SYb0=;
        b=QxosG7fRM3vHo7j2Pi5YmcsUTvrW518Fh69m0eFdgbkxTDX+fsX5/ILOmkNJK1Ns1P
         AejkbFoqND4owDjzQI1Qi9uTbu8sZhQfU5ImigYqMxAIRvoS/DyliW9c+WDx3XKKCeL5
         ZIPAU6JzIuGCJcT13enXWOogD6+uLnY8TFlneD5SjxAqr2lz/jZwfGW09Vj2UlRcKSml
         ino20KTx3Ew7wG0eMm932/G2WdK+GJY8ojUxGWQLGTFvZmUiIdQb8Xqw+ZQqU+Dw4FTR
         s8wziyczAiuH3nLfXkFX0ZfO4fuCkANxGdDS3Wppu/KI/X6318LuBclkTdGny41jX0wF
         5veg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760045523; x=1760650323;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hgkwS57YCpvcud1v9OH0HoTyTGxD5e4o9Ce5M90SYb0=;
        b=mA8vOizP6OgX9QwGvbHLZrkWhFedPTretNKY9//Zg1MifH58i7YNaTBho04YYFI2OT
         +jErXEejhKsRtPoVbzE7+ASiTBoJo2SBGLJgZQQPW1E0FCE2fLYO2idJTRBwSLcaQizW
         MgOe51D4m+iPcB7ufxBl5AH+5W6E/5k912txYqP1o4g8fxtDjJwBame4jEM2lcgmiKPc
         rv1Aa7GKY9U0YyDOO5F/nQHOECUd6FBAtOMlTiRW3CPvHoyMO78iyLxH13N0HjiMbr03
         eCzbOq6rImvuG/DKdTJTs71R8jnHrDsvFLCNPaeHBzDGHpQZZjd5QhbRJTaYrT73Q7t3
         2vag==
X-Forwarded-Encrypted: i=1; AJvYcCUdNh5LOEnX84/km8CA53tLgVuHwxZeAoJn0bu5tYf0FusCptDecoUbtveY4+BoBdXmcbNEX5l8H66S+xU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZP733BUx+UqDbUNotO3z7O3UEwEL1F5TsBHUiwwP1b6d523Zo
	sNOoR9QIYjfJ894swz7RwKKKpAdBWgczZWLF1QMls+84qKaVLs652z9Xa9V4bCo4z0Q=
X-Gm-Gg: ASbGncvbYJ1yzMZJ5k7almOuHaInoWa/yXmsTVE2GSnK1p5hOnbpOoXSkONW+IJWsm9
	yb6PN9s1CH09Q83pwA6OzK6DsYNomBHK49benMSJh5FE7FJRpbNfO8NNFFenHcGA0rPRlskO8fl
	JblXTpz+RqDRY1zRP8R9JCqa1yloFgn75Kjt7fUfzEXniPpIWmdGhtQxgD3a8A2F22WGl55V8V7
	3w2Ktz+KOu4NoCUDStT/KR9vBQ6P9GTdqHzEtJZuy7AyYVvZU85rhT8noosaePuYcFNhDu3zFUB
	mM4HHNXtnJxnIbzoc1LOZpr37tIOMjPFtb9nFy6RwKf0a/sGkDEEugeNzdcfC1qD1pFwLkiSDZS
	7nmWR5+1RngcHOJhomLxFhjZ5eo05qOboqmYQXWv/4uA691HrtIb9YMo04CWDL6WtAyl9aGFhpP
	FMeysIACtG8puNNOEuEH8mbZtCG1F6jw==
X-Google-Smtp-Source: AGHT+IFhvYEnNHI2SYbRy0poOwxs6Ed+Sb5tInc1uLHry17j2mYdze22Kto1qFKghdfr0ShMzuu8yA==
X-Received: by 2002:a05:620a:1922:b0:80a:beb4:7761 with SMTP id af79cd13be357-88352d96abfmr1323195185a.76.1760045522483;
        Thu, 09 Oct 2025 14:32:02 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-884a23693c0sm281566585a.50.2025.10.09.14.32.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Oct 2025 14:32:01 -0700 (PDT)
Date: Thu, 9 Oct 2025 17:31:59 -0400
From: Gregory Price <gourry@gourry.net>
To: David Hildenbrand <david@redhat.com>
Cc: Michal Hocko <mhocko@suse.com>, linux-mm@kvack.org, corbet@lwn.net,
	muchun.song@linux.dev, osalvador@suse.de, akpm@linux-foundation.org,
	hannes@cmpxchg.org, laoar.shao@gmail.com, brauner@kernel.org,
	mclapinski@google.com, joel.granados@kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	Mel Gorman <mgorman@suse.de>,
	Alexandru Moise <00moses.alexander00@gmail.com>,
	Mike Kravetz <mike.kravetz@oracle.com>,
	David Rientjes <rientjes@google.com>
Subject: Re: [PATCH] Revert "mm, hugetlb: remove hugepages_treat_as_movable
 sysctl"
Message-ID: <aOgpz6no2Jx2-Y8Z@gourry-fedora-PF4VCD3F>
References: <20251007214412.3832340-1-gourry@gourry.net>
 <402170e6-c49f-4d28-a010-eb253fc2f923@redhat.com>
 <aOZ8PPWMchRN_t5-@tiehlicka>
 <271f9af4-695c-4aa5-9249-2d21ad3db76e@redhat.com>
 <aOaCAG6e5a7BDUxK@tiehlicka>
 <83e33641-8c42-4341-8e6e-5c75d00f93b9@redhat.com>
 <aOaR2gXBX_bOpG61@gourry-fedora-PF4VCD3F>
 <aOdSvriKRoCR5IUs@tiehlicka>
 <aOfU9YTKMPWzYOta@gourry-fedora-PF4VCD3F>
 <ac0393c7-9c0c-4b4d-8b35-5e6369e5431b@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ac0393c7-9c0c-4b4d-8b35-5e6369e5431b@redhat.com>

On Thu, Oct 09, 2025 at 08:51:54PM +0200, David Hildenbrand wrote:
> On 09.10.25 17:29, Gregory Price wrote:
> Or would it be sufficient to selectively enable (explicit opt-in) some user
> pages to end up on ZONE_MOVABLE? IOW, change the semantics of the zone by an
> admin.
> 
> Like, allowing longterm pinning on ZONE_MOVABLE.
> 
> Sure, it would degrade memory hotunplug (until the relevant applications are
> shut down) and probably some other things.
> 
> Further, I am not so sure about the value of having ZONE_MOVABLE sprinkled
> with small unmovable allocations (same concern regarding any such zone that
> allows for unmovable things). Kind of against the whole concept.
> 
> But I mean, if the admin decides to do that (opt in), so he is to blame.
> 

For what it's worth, this patch (or the new one i posted as an RFC), I
was able to allocate gigantic pages and migrate them back and forth
between nodes even after they were allocated for KVM instances.

I was surprised this did not cause pinning.

This was all while running the QEMU machine actively eating ~2GB of
memory.  So this seems... acceptable?  My primary use case was VM
hugepages, but it doesn't even seem like these have been pinned.

I think the confidential-compute / guest_memfd path would have an
issue, because those are pinned and/or entirely unmapped from the
host, but that just seems like a known quantity and a reason to leave
this off by default (make them read the docs :]).

Seems like this is pretty stable tbh.  Obviously if you hack off the
node0 hugepages migration fails - but I feel like you're signing up for
that when you turn the bit on.

Test I ran is below.

~Gregory

---
Host allocates hugepages, runs a qemu image with numa structure, and
migrates the huge pages back and forth

cat /proc/sys/vm/movable_gigantic_pages 
1
cat .../node0/hugepages/hugepages-1048576kB/nr_hugepages
24
cat .../node1/hugepages/hugepages-1048576kB/nr_hugepages
12

qemu-system-x86_64 \
  -machine q35,accel=kvm \
  -cpu host \
  -smp 8,sockets=1,cores=8,threads=1 \
  -m 2G \
  -mem-prealloc \
  -object memory-backend-file,id=mem0,mem-path=/dev/hugepages,prealloc=on,size=1G,host-nodes=0,policy=bind \
  -object memory-backend-file,id=mem1,mem-path=/dev/hugepages,prealloc=on,size=1G,host-nodes=1,policy=bind \
  -numa node,nodeid=0,cpus=0-7,memdev=mem0 \
  -numa node,nodeid=1,memdev=mem1 \
  -nographic \
  -drive file=fedora/hdd.qcow2 \
  -cdrom fedora/seedci.iso

grep bind /proc/1041805/numa_maps
7efc80000000 bind:1 file=/dev/hugepages/qemu_back_mem.mem1.xKNv1N\040(deleted) huge anon=1 dirty=1 N1=1 kernelpagesize_kB=1048576
7efd00000000 bind:0 file=/dev/hugepages/qemu_back_mem.mem0.E19dYs\040(deleted) huge anon=1 dirty=1 N0=1 kernelpagesize_kB=1048576

# Move both to node 0  (uses move_pages(pid, ...)
./move.sh 0
Pages migrated successfully
status[0]: 0
Pages migrated successfully
status[0]: 0

grep bind /proc/1041805/numa_maps
7efc80000000 bind:1 file=/dev/hugepages/qemu_back_mem.mem1.xKNv1N\040(deleted) huge anon=1 dirty=1 N0=1 kernelpagesize_kB=1048576
7efd00000000 bind:0 file=/dev/hugepages/qemu_back_mem.mem0.E19dYs\040(deleted) huge anon=1 dirty=1 N0=1 kernelpagesize_kB=1048576

# Move both to node 1
./move.sh 1
Pages migrated successfully
status[0]: 1
Pages migrated successfully
status[0]: 1

grep bind /proc/1041805/numa_maps 
7efc80000000 bind:1 file=/dev/hugepages/qemu_back_mem.mem1.xKNv1N\040(deleted) huge anon=1 dirty=1 N1=1 kernelpagesize_kB=1048576
7efd00000000 bind:0 file=/dev/hugepages/qemu_back_mem.mem0.E19dYs\040(deleted) huge anon=1 dirty=1 N1=1 kernelpagesize_kB=1048576

---
Guest
Running python script that eats 1.7GB of memory

import time

# 1.2 GB in bytes
size_in_bytes = int(1.7 * 1024 * 1024 * 1024)

# Allocate memory
data = bytearray(size_in_bytes)

print(f"Allocated {len(data) / (1024 * 1024 * 1024):.2f} GB of memory.")

# Keep the process alive so you can inspect it (e.g., with top or htop)
try:
    while True:
        print("nom")
        time.sleep(10)
except KeyboardInterrupt:
    print("Exiting.")

