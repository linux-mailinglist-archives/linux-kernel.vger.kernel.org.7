Return-Path: <linux-kernel+bounces-756770-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AE840B1B8FD
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 19:08:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4FD5918A724B
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 17:09:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60940292B5E;
	Tue,  5 Aug 2025 17:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l4gqNcrV"
Received: from mail-il1-f175.google.com (mail-il1-f175.google.com [209.85.166.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 343FD275B02
	for <linux-kernel@vger.kernel.org>; Tue,  5 Aug 2025 17:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754413709; cv=none; b=svtKqCXjNiR2gOvPIw2UjXHk+EDAbmjtGMTc85RObW8iod1vpYgwl6oC7xHbxse4wMIugqFpu93S2mogzKirOXHEVV9KR3x9D+DQtbklPaA6K9AUqQCD8d1dLiAvo7VPNKbmoUMfAlAbsyZjLzFJ0JBLRW60Mf2uX9vNqDcq+wM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754413709; c=relaxed/simple;
	bh=ek9seD7lfFFVLJUoAOVGYHKcOWsjS1dfTrcSdsjzm5s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nKFis1jUMERGgoQMTg9oszYB+0P2zGbeKSde4kr0lqCeEKVvna0qa8TjH6eqSeEQ08Dgm0EBiPUAeiUx4VYpxAZBrnyAOGUhHxtlxTuVD4Bxukro1ZtGW5n7j/3CWldwQUo9Le2sBokhb8sD72Cy8pBC3/nVOz+DMvSVGdPeNZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l4gqNcrV; arc=none smtp.client-ip=209.85.166.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f175.google.com with SMTP id e9e14a558f8ab-3e3eeb81f9aso44967475ab.2
        for <linux-kernel@vger.kernel.org>; Tue, 05 Aug 2025 10:08:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754413707; x=1755018507; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VuGlNi5wkdwqPW/iSbl5iQB6kg7YzYxdSeTWpFUyLag=;
        b=l4gqNcrVAwDM5kb8hOB2NKFOR/kkWsiS2dy1Jwe4AoiPoi3vPDdR0KK2kLf+GQN0TM
         ffVXdOipG6E5kcrr8r4q5QLlza3tZTJTY6ENXg2/Fw/eyI+sV5mqLatRa/bnHwHlp9hS
         PKRzNE08U5In6H40/xyoaNfvhD95zMpVdGgYA9dVUv1ejnADEKyYoEdREt/mqCP1RzEn
         CvPs1vgV5kbgQ1vClsvok2FRxKpGaOibxyc4bMlcov5ZWJn7YMDCVJMAGc6MVOCpkvmX
         zbZkv9xlG/tx+j/i1G0RETXnFsP8D0ihQ65FRzD3reusDL18kRw7OWu/szs/4lRDQL8H
         oIpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754413707; x=1755018507;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VuGlNi5wkdwqPW/iSbl5iQB6kg7YzYxdSeTWpFUyLag=;
        b=YzDDPNpB8o1NmfQaGvhIEqF4SuSsiqAefgoSlYXahXfEL1WSmlblV1x5K3erXNwUc4
         Lr0xFAz8WGz3mSiYMzzqiybsfI4hm/0w+a5CSIXQWQ7O0VzZtNMXD0R5aXoi4p0LIeGC
         JAzl4A89k6lRAgimD45ylb1kuOYXvKz2Gp+Qda/Rc/cnCOky/4NEa5gRws+r1tuqGSYf
         xX1BaeQt8swGnRwe+ESjEV/Qit3oql5eWJBJgIsRkv8B26YwO7b1GLB1VVZcq1Cg1oTp
         LAkeiM6+0DexBGGRcqTu1yCT+dYBFuJfTrMF/ZS1aMlSjEltkVWb58+TIV2IDzdiqeJ5
         oH5A==
X-Forwarded-Encrypted: i=1; AJvYcCU48+JarNxUBAm+c8mRUVzLGJLLIPUhU6dLHzIbuGDxSB82C1i2itsABYnKFygc+G5Of7R9ODpddwcSkFw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYihQSh2RjT9ypvIZMhDhj0tNg3hAIVAhj3LKaMA9ul8OUnsW7
	Sakaqq/gNM0QrXhvi/yR6iMJwnlYcHSqHKEtCAnXHo21Xyjhmv16wQtdoAjAswfW2REtONTOA5w
	XzA7SN+MDcQACJgx5XcAzX1fXZ4+LioY=
X-Gm-Gg: ASbGnctbGDdc5le9pNX8ASv7L9WbPMWz2lzWzLumvA9ye7/5iDfDVI7tMJ0AXi8A1Fg
	SDaUOybmXyc0gzmG6gF8X0Veo0qHTH9Ni4W75pZGds9SrP9WAHny4JxK5DEKxccSnbgsVhH/jsT
	h2g2Z9ZgK4ipR8iEwmvRewaHmrloTkr3FClS9xPumWejgUInwlocOoWY7kZ5KdfgdtAl72WF+Ht
	o946Iq5kzNxfVDTUQ==
X-Google-Smtp-Source: AGHT+IEqq7nNOFFJaTElA7V7lvC6va1YYQWAIEKkUtPlihKKeRB3JNwAkJziv2mDjIJ1sh1UHZzt2+ijfUM6fV3x7NI=
X-Received: by 2002:a05:6e02:3f12:b0:3e3:ef1c:ef16 with SMTP id
 e9e14a558f8ab-3e41611c103mr283471745ab.7.1754413707089; Tue, 05 Aug 2025
 10:08:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250804172439.2331-1-ryncsn@gmail.com> <20250804172439.2331-2-ryncsn@gmail.com>
In-Reply-To: <20250804172439.2331-2-ryncsn@gmail.com>
From: Nhat Pham <nphamcs@gmail.com>
Date: Tue, 5 Aug 2025 10:08:16 -0700
X-Gm-Features: Ac12FXz8Edy2EvZFBtLZV8o6w06tTNVXqM-wIPEG1Fn4sVzEW2PdTitTtF1NPyo
Message-ID: <CAKEwX=NSGbjG-bhjje4ga2n4xNFBdiFTZV8TRz+qSc_cvmxUJg@mail.gmail.com>
Subject: Re: [PATCH 1/2] mm, swap: don't scan every fragment cluster
To: Kairui Song <kasong@tencent.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>, 
	Kemeng Shi <shikemeng@huaweicloud.com>, Chris Li <chrisl@kernel.org>, 
	Baoquan He <bhe@redhat.com>, Barry Song <baohua@kernel.org>, 
	"Huang, Ying" <ying.huang@linux.alibaba.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 4, 2025 at 10:24=E2=80=AFAM Kairui Song <ryncsn@gmail.com> wrot=
e:
>
> From: Kairui Song <kasong@tencent.com>
>
> Fragment clusters were mostly failing high order allocation already.
> The reason we scan it now is that a swap slot may get freed without
> releasing the swap cache, so a swap map entry will end up in HAS_CACHE
> only status, and the cluster won't be moved back to non-full or free
> cluster list.
>
> Usually this only happens for !SWP_SYNCHRONOUS_IO devices when the swap
> device usage is low (!vm_swap_full()) since swap will try to lazy free
> the swap cache.
>
> It's unlikely to cause any real issue. Fragmentation is only an issue
> when the device is getting full, and by  that time, swap will already
> be releasing the swap cache aggressively. And swap cache reclaim happens
> when the allocator scans a cluster too. Scanning one fragment cluster
> should be good enough to reclaim these pinned slots.
>
> And besides, only high order allocation requires iterating over a
> cluster list, order 0 allocation will succeed on the first attempt.
> And high order allocation failure isn't a serious problem.
>
> So the iteration of fragment clusters is trivial, but it will slow down
> mTHP allocation by a lot when the fragment cluster list is long.
> So it's better to drop this fragment cluster iteration design. Only
> scanning one fragment cluster is good enough in case any cluster is
> stuck in the fragment list; this ensures order 0 allocation never
> falls, and large allocations still have an acceptable success rate.
>
> Test on a 48c96t system, build linux kernel using 10G ZRAM, make -j48,
> defconfig with 768M cgroup memory limit, on top of tmpfs, 4K folio
> only:
>
> Before: sys time: 4407.28s
> After:  sys time: 4425.22s
>
> Change to make -j96, 2G memory limit, 64kB mTHP enabled, and 10G ZRAM:
>
> Before: sys time: 10230.22s  64kB/swpout: 1793044  64kB/swpout_fallback: =
17653
> After:  sys time: 5527.90s   64kB/swpout: 1789358  64kB/swpout_fallback: =
17813
>
> Change to 8G ZRAM:
>
> Before: sys time: 21929.17s  64kB/swpout: 1634681  64kB/swpout_fallback: =
173056
> After:  sys time: 6121.01s   64kB/swpout: 1638155  64kB/swpout_fallback: =
189562
>
> Change to use 10G brd device with SWP_SYNCHRONOUS_IO flag removed:
>
> Before: sys time: 7368.41s  64kB/swpout:1787599  swpout_fallback: 0
> After:  sys time: 7338.27s  64kB/swpout:1783106  swpout_fallback: 0
>
> Change to use 8G brd device with SWP_SYNCHRONOUS_IO flag removed:
>
> Before: sys time: 28139.60s 64kB/swpout:1645421  swpout_fallback: 148408
> After:  sys time: 8941.90s  64kB/swpout:1592973  swpout_fallback: 265010
>
> The performance is a lot better and large order allocation failure rate
> is only very slightly higher or unchanged.
>
> Signed-off-by: Kairui Song <kasong@tencent.com>

LGTM. I've been learning a lot about cluster-based allocation design
from your code for my vswap prototype. Thanks, Kairui!

FWIW:
Acked-by: Nhat Pham <nphamcs@gmail.com>

