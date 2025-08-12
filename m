Return-Path: <linux-kernel+bounces-765352-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AFC0B22F16
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 19:31:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4C1D47B571E
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 17:29:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D45D285065;
	Tue, 12 Aug 2025 17:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dj6MAFFW"
Received: from mail-ed1-f74.google.com (mail-ed1-f74.google.com [209.85.208.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41F0E1DE2D7
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 17:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755019874; cv=none; b=I5Y61NRGH34cp8mksLSFztr+QxqupL/q0phG87fwXRNaVRo8PB2ZGT2+cPw2EjOP5PSrU7H0OwAaG+csKhisGRPe8sEYwcbbGZ2yPFTNcoBjUCsZ6S9RMMstaVlb3BxxNlf20wbJznioc9/YNu7vH8RUcYEwTYLiAKfNY7Fiz+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755019874; c=relaxed/simple;
	bh=AhrGZwtwjFEfK30sxXuVWtOG+p+7Sgc73/Uqe3bb1xE=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=QdlAGNlyEQpoAKfHo0XgjhbEIrrFlOHTGJ6n0xHKCnJml4V1O+OO5YeVf7Zy8UPCYi/zBUayWXUaPmiqHLFefvNKGjw5jqGeqqyzPXbMJqVvT7oOExG+nKJp0KOtfPxYyJfxwt1enbtO9uVKHh93UITV9cLukHmVfyPO6CZQ7c8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dj6MAFFW; arc=none smtp.client-ip=209.85.208.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com
Received: by mail-ed1-f74.google.com with SMTP id 4fb4d7f45d1cf-615957f48a9so4537061a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 10:31:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755019870; x=1755624670; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=lO6uMK6KqC6CFZuyBdorrbdUmeFcwW7b40ufzsbZ7fI=;
        b=dj6MAFFWPnIU9Rytee7fMnTISEbk/qzjyLq/5sI6Shwc588xy9LOIn3eX1dyJw17Hb
         Pnz6bJqKfqjX1KCQVcC6uPXDUKCpO3a4ghprJyAjPNPIfC7Idrc5V6K6lTMbfFKUFJc3
         Hwg41yBYDaUT9GCjNW1+hZrbCmMDTU3ZmZFxaVL15fmT2y3M7kT4GCjfarjT/BLkn4j3
         ZHcilO1wM85QLdPR7qnHTClty49wjFDaedhZyNYPIasPZC7Lhf9fNDrV/AWkNvz5+BB4
         NuTu5os6Tle573+ykhDz+X2MP35/li/U5LAZe19qsbiysVrl9y1bqWymnaLkN3i/Oa8V
         GERA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755019870; x=1755624670;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lO6uMK6KqC6CFZuyBdorrbdUmeFcwW7b40ufzsbZ7fI=;
        b=WkDp7aZkl+/eSbMjmGDMuq5Jm92qLdbdh4PNlBxY8GkxEcRIc87AiDXTwsKgZsj03K
         f84eeRTzeSwUtZTRW+HNKi5uN0brdd/Bvc4ZsVl7UgE+xt1Vh5YO7ExxDUiJoz0ffAmt
         ySMtaJa0HM6IiyrIRaqIlR/7sIhjKuenw/wv01wKmZ+9n9HN/liquQLYLgKpMvppc106
         ym0YcJJ9VBLRy7tEx6stTbEwH1pUaN0G1Q9QSnJlwuCof5XvGFHotrfbPoWPGkEi9W9R
         B42ecoPWB9gwv34uBjmzoP18bhqGPIYZ/YpV2UmpsArWWJLxqiUw9S2dL5qqKMEf5L1d
         ZgMw==
X-Forwarded-Encrypted: i=1; AJvYcCXHpGNSDZZ4SjOWU+4aTLZV+PNwW9bQM6xWAcg919Q8SNUcOCLqFXRQiU8ScpNaKg9QFOOh7SQWyF4gEPU=@vger.kernel.org
X-Gm-Message-State: AOJu0YycY8Z0LptxBHXimM0JztBqLERuqDPtQW/NpaizQJylVmMwHx3i
	vg6a2/Sycq4Ex2DRjRd+XFMvbmL1gsQjGARvrYAJ0Fy7Tso6fB4tWQ3kaM3BLTMS8v/xrVq2vCe
	t/wFWdDxNW06Zdw==
X-Google-Smtp-Source: AGHT+IHuOuZawFVGmekchOLH7kWCMsK75iTZ+VH3GUhVjBoKVF3OEwrT4z3YtZPGKaHMJNDsnXxZGvmX+COMAQ==
X-Received: from edbev17.prod.google.com ([2002:a05:6402:5411:b0:615:4d05:f4be])
 (user=jackmanb job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6402:40d6:b0:617:5be3:bba9 with SMTP id 4fb4d7f45d1cf-6186784e879mr581207a12.22.1755019870260;
 Tue, 12 Aug 2025 10:31:10 -0700 (PDT)
Date: Tue, 12 Aug 2025 17:31:09 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.50.1
Message-ID: <20250812173109.295750-1-jackmanb@google.com>
Subject: [Discuss] First steps for ASI (ASI is fast again)
From: Brendan Jackman <jackmanb@google.com>
To: jackmanb@google.com, peterz@infradead.org, bp@alien8.de, 
	dave.hansen@linux.intel.com, mingo@redhat.com, tglx@linutronix.de
Cc: akpm@linux-foundation.org, david@redhat.com, derkling@google.com, 
	junaids@google.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	reijiw@google.com, rientjes@google.com, rppt@kernel.org, vbabka@suse.cz, 
	x86@kernel.org, yosry.ahmed@linux.dev
Content-Type: text/plain; charset="UTF-8"

.:: Intro

Following up to the plan I posted at [0], I've now prepared an up-to-date ASI
branch that demonstrates a technique for solving the page cache performance
devastation I described in [1]. The branch is at [5].

The goal of this prototype is to increase confidence that ASI is viable as a
broad solution for CPU vulnerabilities. (If the community still has to develop
and maintain new mitigations for every individual vuln, because ASI only works
for certain use-cases, then ASI isn't super attractive given its complexity
burden).

The biggest gap for establishing that confidence was that Google's deployment
still only uses ASI for KVM workloads, not bare-metal processes. And indeed the
page cache turned out to be a massive issue that Google just hasn't run up
against yet internally.

.:: The "ephmap"

I won't re-hash the details of the problem here (see [1]) but in short: file
pages aren't mapped into the physmap as seen from ASI's restricted address space.
This causes a major overhead when e.g. read()ing files. The solution we've
always envisaged (and which I very hastily tried to describe at LSF/MM/BPF this
year) was to simply stop read() etc from touching the physmap.

This is achieved in this prototype by a mechanism that I've called the "ephmap".
The ephmap is a special region of the kernel address space that is local to the
mm (much like the "proclocal" idea from 2019 [2]). Users of the ephmap API can
allocate a subregion of this, and provide pages that get mapped into their
subregion. These subregions are CPU-local. This means that it's cheap to tear
these mappings down, so they can be removed immediately after use (eph =
"ephemeral"), eliminating the need for complex/costly tracking data structures.

(You might notice the ephmap is extremely similar to kmap_local_page() - see the
commit that introduces it ("x86: mm: Introduce the ephmap") for discussion).

The ephmap can then be used for accessing file pages. It's also a generic
mechanism for accessing sensitive data, for example it could be used for
zeroing sensitive pages, or if necessary for copy-on-write of user pages.

.:: State of the branch

The branch contains:

- A rebased version of my "ASI integration for the page allocator" RFC [3]. (Up
  to "mm/page_alloc: Add support for ASI-unmapping pages")
- The rest of ASI's basic functionality (up to "mm: asi: Stop ignoring asi=on
  cmdline flag")
- Some test and observability conveniences (up to "mm: asi: Add a tracepoint for
  ASI page faults")
- A prototype of the new performance improvements (the remainder of the
  branch).

There's a gradient of quality where the earlier patches are closer to "complete"
and the later ones are increasingly messy and hacky. Comments and commit message
describe lots of the hacky elements but the most important things are:

1. The logic to take advantage of the ephmap is stuck directly into mm/shmem.c.
   This is just a shortcut to make its behaviour obvious. Since tmpfs is the
   most extreme case of the read/write slowdown this should give us some idea of
   the performance improvements but it obviously hides a lot of important
   complexity wrt how this would be integrated "for real".

2. The ephmap implementation is extremely stupid. It only works for the simple
   shmem usecase. I don't think this is really important though, whatever we end
   up with needs to be very simple, and it's not even clear that we actually
   want a whole new subsystem anyway. (e.g. maybe it's better to just adapt
   kmap_local_page() itself).

3. For software correctness, the ephmap only needs to be TLB-flushed on the
   local CPU. But for CPU vulnerability mitigation, flushes are needed on other
   CPUs too. I believe these flushes should only be needed very infrequently.
   "Add ephmap TLB flushes for mitigating CPU vulns" is an illustrative idea of
   how these flushes could be implemented, but it's a bit of a simplistic
   implementation. The commit message has some more details.

.:: Performance

This data was gathered using the scripts at [4]. This is running on a Sapphire
Rapids machine, but with setcpuid=retbleed. This introduces an IBPB in
asi_exit(), which dramatically amplifies the performance impact of ASI. We don't
know of any vulns that would necessitate this IBPB, so this is basically a weird
selectively-paranoid configuration of ASI. It doesn't really make sense from a
security perspective. A few years from now (once the security researchers have
had their fun) we'll know what's _really_ needed on this CPU, it's very unlikely
that it turns out to be exactly an IBPB like this, but it's reasonably likely to
be something with a vaguely similar performance overhead.

Native FIO randread IOPS on tmpfs (this is where the 70% perf degradation was):
+---------+---------+-----------+---------+-----------+---------------+
| variant | samples |      mean |     min |       max | delta mean    |
+---------+---------+-----------+---------+-----------+---------------+
| asi-off |      10 | 1,003,102 | 981,813 | 1,036,142 |               |
| asi-on  |      10 |   871,928 | 848,362 |   885,622 | -13.1%        |
+---------+---------+-----------+---------+-----------+---------------+

Native kernel compilation time:
+---------+---------+--------+--------+--------+-------------+
| variant | samples |   mean |    min |    max | delta mean  |
+---------+---------+--------+--------+--------+-------------+
| asi-off |       3 | 34.84s | 34.42s | 35.31s |             |
| asi-on  |       3 | 37.50s | 37.39s | 37.58s | 7.6%        |
+---------+---------+--------+--------+--------+-------------+

Kernel compilation in a guest VM:
+---------+---------+--------+--------+--------+-------------+
| variant | samples |   mean |    min |    max | delta mean  |
+---------+---------+--------+--------+--------+-------------+
| asi-off |       3 | 52.73s | 52.41s | 53.15s |             |
| asi-on  |       3 | 55.80s | 55.51s | 56.06s | 5.8%        |
+---------+---------+--------+--------+--------+-------------+

Despite my title these numbers are kinda disappointing to be honest, it's not
where I wanted to be by now, but it's still an order-of-magnitude better than
where we were for native FIO a few months ago. I believe almost all of this
remaining slowdown is due to unnecessary ASI exits, the key areas being:

- On every context_switch(). Google's internal implementation has fixed this (we
  only really need it when switching mms).

- Whenever zeroing sensitive pages from the allocator. This could potentially be
  solved with the ephmap but requires a bit of care to avoid opening CPU attack
  windows.

- In copy-on-write for user pages. The ephmap could also help here but the
  current implementation doesn't support it (it only allows one allocation at a
  time per context).

.:: Next steps

Here's where I'd like to go next:

1. Discuss here and get feedback from x86 folks. Dave H said we need "line of
   sight" to a version of ASI that's viable for sandboxing native workloads. I
   don't consider a 13% slowdown "viable" as-is, but I do think this shows we're
   out of the "but what about the page cache" black hole. It seems provably
   solvable now.

2. Once we have some x86 maintainers saying "yep, it looks like this can work
   and it's something we want", I can start turning my page_alloc RFC [3] into a
   proper patchset (or maybe multiple if I can find a way to break things down
   further).

Note what I'm NOT proposing is to carry on working on this branch until ASI is
as fast as I am claiming it eventually will be. I would like to avoid doing that
since I believe the biggest unknowns on that path are now solved, and it would
be more useful to start getting down to nuts and bolts, i.e. reviewing real,
PATCH-quality code and merging precursor stuff. I think this will lead to more
useful discussions about the overall design, since so far all my postings have
been so long and rarefied that it's been hard to really get a good conversation
going.

.:: Conclusion

So, x86 folks: Does this feel like "line of sight" to you? If not, what would
that look like, what experiments should I run?

---

[0] https://lore.kernel.org/lkml/DAJ0LUX8F2IW.Q95PTFBNMFOI@google.com/
[1] https://lore.kernel.org/linux-mm/20250129144320.2675822-1-jackmanb@google.com/
[2] https://lore.kernel.org/linux-mm/20190612170834.14855-1-mhillenb@amazon.de/
[3] https://lore.kernel.org/lkml/20250313-asi-page-alloc-v1-0-04972e046cea@google.com/
[4] https://github.com/bjackman/nixos-flake/commit/be42ba326f8a0854deb1d37143b5c70bf301c9db
[5] https://github.com/bjackman/linux/tree/asi/6.16

