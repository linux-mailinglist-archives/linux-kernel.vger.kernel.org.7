Return-Path: <linux-kernel+bounces-892439-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AC85C4519E
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 07:38:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5412B3B1437
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 06:38:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A7D12E92B4;
	Mon, 10 Nov 2025 06:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shopee.com header.i=@shopee.com header.b="R5HCuqlb"
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF0C123BCE4
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 06:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762756686; cv=none; b=oYcmgfttyKH7hoARNEIhtPGXOSfxSsvqdR0OAdr53rlkICSgHpF5aCka8cOOpb34P0WrwKwBxsSRaSxBJcCqrLk+W0HojUdxJVFbHV5OuHKjn8zb707YMoDtpfu9jBV5NWfslJq2khaCebx77mavUnx5cT0u0Qf4znS+2VbGkwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762756686; c=relaxed/simple;
	bh=SUHfIg5GhQcEfjnNTSceZJLkDCfTBJb7plnlPtngbCM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IxOCQrY90fVvu62Aiv5sUUNxMEXmte58/FX0TEBPmJgDiRosiucfcjKf6Z3s+7CIsB/xGqAYidH2ezielOGEALcdQqbMFk1vxF9jkpEpoIPXvxdrBGH/pJ6K4L7LpSDCrwyvZJhyV495qtgADycW6QrIoO6g/urqaKuOoC9Bx74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shopee.com; spf=pass smtp.mailfrom=shopee.com; dkim=pass (2048-bit key) header.d=shopee.com header.i=@shopee.com header.b=R5HCuqlb; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shopee.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shopee.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-7af603c06easo2366309b3a.0
        for <linux-kernel@vger.kernel.org>; Sun, 09 Nov 2025 22:38:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shopee.com; s=shopee.com; t=1762756684; x=1763361484; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wmBVMknsz67ut23E5K5rufi/vJYxx4RPQjR4CpqkZ2E=;
        b=R5HCuqlbWU2edYGODcWV1pi669v3q6rHIrHoX+G2fxwUP3JOwpuWcweyOYq+KC6pZx
         Tuptkc8bqnK1emYqAJFUfBXzY+w/+LP2E0SmggulAymi/WlLPSv27GTf/o6GolG/+Cv9
         b+AFFQZ6ClEk6Xr8tCMXv+cwTBaXaYgi4ZtGmX3dTUhlEn+N39q2np1IUoBNNoMLljaW
         7mPnV4CNZeR0gf/KQdScareM35zLA3VxKx2QGMXfZ2eZYMtJewhWm5CJvNK8YdB+JpYU
         nAZ+Du3uO9wYXsY6pTspPRbJ31iDNhY+cboi4MQkjfMCF+XmYxpu207RQdxdUs7Rd8w0
         kNlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762756684; x=1763361484;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wmBVMknsz67ut23E5K5rufi/vJYxx4RPQjR4CpqkZ2E=;
        b=Rgmc5e9Uzj844GemKtM+lUjjAezeWbUBaDsbZH/U1PNBH1cR/PPAb2k43/FijrB0ZW
         BuLsTzRRCXdJgEItOSMybpO5hUIWz7TUT7/jjD1c5CYcVx+IMh/Md8B5a6RzOjVel52p
         mhamZkuFnAuAajfeXcJJRQZmFMJ3YgfIHilEHnkIukk4OpHjX9cqgxfrltiVTrxtca8c
         +XCjk9rVjwvDbqVfFBgFnpLOgrw557vzTa+ve+rRk12PeTq8Nu5z3NCnGHKit9n+IpMu
         Rgmk47IoXC1f8P/ibLaGnCX+RNU1lV3i6wKyyGkDJCuKTgpY7AUvrjiyi0NaH/Ne7k8N
         F6og==
X-Forwarded-Encrypted: i=1; AJvYcCWez3dyVdi+vvq7swIb4f/jA3w9NsDpW4tW7dGWqoJjB3j8GDv+d4kdMLHvxIxIhFmJeH2SLJKeF77Q35U=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOEkC+e2da79jdTshBmNlaxAV/dFbjT4ZZdkzNvjVqfxK5Vklt
	Ii578l/nBGAaArWzE0l8UxxE0EUk0WMz0lWZu+9PcAPIw46v8HuDb1+dWCXfapCjryM=
X-Gm-Gg: ASbGncuQ7FrGLqdJbW1APP6UbrrqDr5A7Guelg0nBWM2UoeG/iozHMyWTaRWzqkNYvr
	twdzwlqdOjdv9tg5Jrdst7WFsodeH6NoUCL4ZUe+kVxlaMYWDDObxiXeRyhwbO51Hy6tnleL0tY
	O+YJ/Leh+m8PO1zBZyVLCA7lgZuIrVrtAMgMkUUueLenAJSp9SM/K2UzrRd4tYLez+GZaPziBcW
	fH6oDnANNkPrvP7jpes2i3w+qTBomB/Dh4QfvTwtwVV14jCR4Gw9z9jckbZ+Id/WCvqE0EIQI1d
	U1fnZsg9e2j+yvT7ytlLHf38wX7x4gkeGZr3oxXrjKJNNH5tgtL8G+PueAifc9miNbkDIwNR7xd
	wjAyVpwX0VfE3OmDP4kFBJVSMp5AsfG5pSA71A+ecuAwxWPrn+4QWOZW86NvitW5AehHrQHjPhU
	95ZNS8qNvcpTgUoA==
X-Google-Smtp-Source: AGHT+IGpM2iMSrs4WgXitoPVDoGbl0s8jdXiEXMRW0CSHSXbsOrMNjve/Ihdvic39TubC73LXbxmTQ==
X-Received: by 2002:a05:6a00:1a8e:b0:78a:f6be:74f2 with SMTP id d2e1a72fcca58-7b218103464mr9344608b3a.5.1762756683995;
        Sun, 09 Nov 2025 22:38:03 -0800 (PST)
Received: from .shopee.com ([122.11.166.8])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7b0cc17a688sm10609451b3a.40.2025.11.09.22.37.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Nov 2025 22:38:03 -0800 (PST)
From: Leon Huang Fu <leon.huangfu@shopee.com>
To: shakeel.butt@linux.dev
Cc: akpm@linux-foundation.org,
	cgroups@vger.kernel.org,
	corbet@lwn.net,
	hannes@cmpxchg.org,
	inwardvessel@gmail.com,
	jack@suse.cz,
	joel.granados@kernel.org,
	kyle.meyer@hpe.com,
	lance.yang@linux.dev,
	laoar.shao@gmail.com,
	leon.huangfu@shopee.com,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	mclapinski@google.com,
	mhocko@kernel.org,
	muchun.song@linux.dev,
	roman.gushchin@linux.dev,
	yosry.ahmed@linux.dev
Subject: Re: [PATCH mm-new v2] mm/memcontrol: Flush stats when write stat file
Date: Mon, 10 Nov 2025 14:37:57 +0800
Message-ID: <20251110063757.86725-1-leon.huangfu@shopee.com>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <blygjeudtqyxk7bhw5ycveofo4e322nycxyvupdnzq3eg7qtpo@cya4bifb2dlk>
References: <blygjeudtqyxk7bhw5ycveofo4e322nycxyvupdnzq3eg7qtpo@cya4bifb2dlk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, Nov 7, 2025 at 7:56 AM Shakeel Butt <shakeel.butt@linux.dev> wrote:
>
> On Thu, Nov 06, 2025 at 11:30:45AM +0800, Leon Huang Fu wrote:
> > On Thu, Nov 6, 2025 at 9:19 AM Shakeel Butt <shakeel.butt@linux.dev> wrote:
> > >
> > > +Yosry, JP
> > >
> > > On Wed, Nov 05, 2025 at 03:49:16PM +0800, Leon Huang Fu wrote:
> > > > On high-core count systems, memory cgroup statistics can become stale
> > > > due to per-CPU caching and deferred aggregation. Monitoring tools and
> > > > management applications sometimes need guaranteed up-to-date statistics
> > > > at specific points in time to make accurate decisions.
> > >
> > > Can you explain a bit more on your environment where you are seeing
> > > stale stats? More specifically, how often the management applications
> > > are reading the memcg stats and if these applications are reading memcg
> > > stats for each nodes of the cgroup tree.
> > >
> > > We force flush all the memcg stats at root level every 2 seconds but it
> > > seems like that is not enough for your case. I am fine with an explicit
> > > way for users to flush the memcg stats. In that way only users who want
> > > to has to pay for the flush cost.
> > >
> >
> > Thanks for the feedback. I encountered this issue while running the LTP
> > memcontrol02 test case [1] on a 256-core server with the 6.6.y kernel on XFS,
> > where it consistently failed.
> >
> > I was aware that Yosry had improved the memory statistics refresh mechanism
> > in "mm: memcg: subtree stats flushing and thresholds" [2], so I attempted to
> > backport that patchset to 6.6.y [3]. However, even on the 6.15.0-061500-generic
> > kernel with those improvements, the test still fails intermittently on XFS.
> >
> > I've created a simplified reproducer that mirrors the LTP test behavior. The
> > test allocates 50 MiB of page cache and then verifies that memory.current and
> > memory.stat's "file" field are approximately equal (within 5% tolerance).
> >
> > The failure pattern looks like:
> >
> >   After alloc: memory.current=52690944, memory.stat.file=48496640, size=52428800
> >   Checks: current>=size=OK, file>0=OK, current~=file(5%)=FAIL
> >
> > Here's the reproducer code and test script (attached below for reference).
> >
> > To reproduce on XFS:
> >   sudo ./run.sh --xfs
> >   for i in {1..100}; do sudo ./run.sh --run; echo "==="; sleep 0.1; done
> >   sudo ./run.sh --cleanup
> >
> > The test fails sporadically, typically a few times out of 100 runs, confirming
> > that the improved flush isn't sufficient for this workload pattern.
>
> I was hoping that you have a real world workload/scenario which is
> facing this issue. For the test a simple 'sleep 2' would be enough.
> Anyways that is not an argument against adding an inteface for flushing.
>

Fair point. I haven't encountered a production issue yet - this came up during
our kernel testing phase on high-core count servers (224-256 cores) before
deploying to production.

The LTP test failure was the indicator that prompted investigation. While
adding 'sleep 2' would fix the test, it highlights a broader concern: on these
high-core systems, the batching threshold (MEMCG_CHARGE_BATCH * num_online_cpus)
can accumulate 14K-16K events before auto-flush, potentially causing significant
staleness for workloads that need timely statistics.

We're planning to deploy container workloads on these servers where memory
statistics drive placement and resource management decisions. Having an explicit
flush interface would give us confidence that when precision matters (e.g.,
admission control, OOM decisions), we can get accurate stats on demand rather
than relying on timing or hoping the 2-second periodic flush happens when needed.

I understand this is more of a "preparing for future needs" rather than "fixing
current production breakage" situation. However, given the interface provides
opt-in control with no cost to users who don't need it, I believe it's a
reasonable addition. I'll prepare a v3 with the dedicated memory.stat_refresh
file as suggested.

Thanks,
Leon

