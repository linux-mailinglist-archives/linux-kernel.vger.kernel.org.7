Return-Path: <linux-kernel+bounces-722583-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 441FDAFDC98
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 03:00:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EBBAD1C23122
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 01:00:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43709130A54;
	Wed,  9 Jul 2025 01:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ft9J2kjK"
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C3B7944F;
	Wed,  9 Jul 2025 01:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752022817; cv=none; b=B9ZwYsbpjghOHFqHKNI7npklJQc9OCJ1k00yTFH8osSpugfTbxsbVJ0Aww1cvcj3I/4smyKvQ8XgRS5SzKctUfEcF1Z0CjNz4FDjJG3RG97XqN/iACKscj/sMF47CKvoUaF4zwMatGm6ZSBD2Xxt/hTg4MaaTOLPKumLN7oRceQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752022817; c=relaxed/simple;
	bh=j76xYmAWTT1qGnQvlKN0JQqy1LBdl8D0GwbJttuJ/FQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=X3DHSI81sPSfw4a0VFOjqVD/Znmf0gnIiXaiXFYZlENECcHLpVV9mnhiO+dakZE+yUqXTKsvd9yaYn0LU+G4ZtP6C3Hhzz3ywq37ywxs+HmtVsmmqAkMh4emt4cqKL5uphbsf8RTZzNmSWptuKY2zwE6rEKvKS6lhUke1Yg0tFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ft9J2kjK; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-e8b67d2acfbso1050945276.2;
        Tue, 08 Jul 2025 18:00:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752022814; x=1752627614; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rKyG/qY8Es7sRvXzl2PdKZi4+ObM/qHY4kExb6QA8vU=;
        b=Ft9J2kjKTvz2V4R9KM8llDPsJuRg9j+bATYJPSYoIaCWzUBWF0Yuae3Kw9pX0VxsjX
         p0QU6J5BZ6spZSMYuECrcJqE0YZ2+ubMWV4yhR2xjCeqZphYKTvXFl3MfHUMtK6NHwhB
         kKfgrJdccrbrGSUD0EmC5893GwpONRpgtm4wqeA0ZQPBStzkznpyKpOq1ZCqUGI52qR2
         uhEh6+T7F7Il6FtCpFo6aWJQrFW/J3v9j8Ynch+kRMdsezThF9OZ2UAv6MIc1+malHls
         HppqtJRmuUe+n305uo2m1SjJCzRWtU1OZTr09TFWL6aJURL38RMBzbnhWBwbPuX23WzT
         maKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752022814; x=1752627614;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rKyG/qY8Es7sRvXzl2PdKZi4+ObM/qHY4kExb6QA8vU=;
        b=eqjWJ1JTZYF56xn1PrWpxf4uM8iLNZbqrAZf+EjWuEybGLNT0doWOJL6DHxwefZHKh
         LvjZ11CcAcmjJMy9V91+Hr6OfvJejuQkg44uPNri0OVokQ4N283xMp2BaPTqJdYXgRDx
         rtClqjljT/KU8d3ABdPQv9rKA7k1ml2G4by5VwPGbFRgu+ErZ9LT8LzifYque7k0lPtZ
         30im3H7plj7fsbfFqB4E1v9ashLv7BgvwMhxTaXJBtcw/e+zHnVEd95K1VWILVG2+pYW
         0UnlHvB5WL3feJZKM6MEbR7rT/l5y2Iz8KHjo7nWEpkHZ0xLesL2JWP8Y411lXcXM644
         0dxg==
X-Forwarded-Encrypted: i=1; AJvYcCVH/VFlXo6MWrNtvwqGC6qM8cef5LoMML+9GDpWuMMhdccqhZBEOY5AMaffB9Mse6FT8bHUQnsbt24=@vger.kernel.org, AJvYcCX0cZzX0kuUXFm900GKZTO3xhM6dN3u6ZPzH7rNP6Q2h6Hw3X/qqZnS1HtIXrPYRdpTgjSsrj+6DlKpFSYW@vger.kernel.org
X-Gm-Message-State: AOJu0YzBfvqDC61n2rqDUAXRM5JDtav1NnxiK5S+4wTWLLdC0+b0wD6M
	Y25MyEZKwcQf6cEqo3Toyy7U2eQCTEChbyve7YlR/blR7MjCkYnYgGX3
X-Gm-Gg: ASbGncvrDQqGVRDJNsX0IqztPwhipfvabM6rAvrRoqeijfZJcFg5YeyZCfUWU22m4Hu
	E3mEzTDOMlwoaZ5CNz4ncZm2eFZ1Jjtkd140lEIPM9IJ/oWy8HYvGuZuG+w3BBfOSY2z56xplE+
	bHVd9zs77rmZr7I1CbZJJolJpp/3AZWDeheZNi3DAW0JU/Ubt97ehcT3IggfDe3VmceaPmBZ/CD
	xlJUnmvthv+Dq4JRq73JeUkIQHqJKxily4OsfqTkeLAj5dNU/3TauwaDg6e95V/0sjDeddJAzxb
	8Q40unjCKn3RIRCCDSVvOjZ/Fq1OoWFuR/e2BbIgNIIU4YHRQWRujPwYGJ3kCCIRXAZmo6Tuacp
	VWgEH34c=
X-Google-Smtp-Source: AGHT+IFOQeAa6UP5Ujqqk7FjPH4slYwLSjoHPvLBT+bmeNoKQEZGTEibzIBJmqMoA7vwkzCjzqzLyw==
X-Received: by 2002:a05:6902:230f:b0:e7f:67b9:1161 with SMTP id 3f1490d57ef6-e8b6e0def6cmr969998276.1.1752022813623;
        Tue, 08 Jul 2025 18:00:13 -0700 (PDT)
Received: from bijan-laptop.attlocal.net ([2600:1700:680e:c000:235f:99bb:f36e:a060])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e899c43ed8asm3656043276.26.2025.07.08.18.00.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jul 2025 18:00:13 -0700 (PDT)
From: Bijan Tabatabai <bijan311@gmail.com>
To: damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org
Cc: sj@kernel.org,
	akpm@linux-foundation.org,
	corbet@lwn.net,
	bijantabatab@micron.com,
	venkataravis@micron.com,
	emirakhur@micron.com,
	vtavarespetr@micron.com,
	ajayjoshi@micron.com,
	bijan <bijan@node0.bijan-262664.superpages-pg0.wisc.cloudlab.us>
Subject: [PATCH v4 00/13] mm/damon/vaddr: Allow interleaving in migrate_{hot,cold} actions
Date: Tue,  8 Jul 2025 19:59:30 -0500
Message-ID: <20250709005952.17776-1-bijan311@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: bijan <bijan@node0.bijan-262664.superpages-pg0.wisc.cloudlab.us>

A recent patch set automatically sets the interleave weight for each node
according to the node's maximum bandwidth [1]. In another thread, the patch
set's author, Joshua Hahn, wondered if/how thes weights should be changed
if the bandwidth utilization of the system changes [2].

This patch set adds the mechanism for dynamically changing how application
data is interleaved across nodes while leaving the policy of what the
interleave weights should be to userspace. It does this by having the
migrate_{hot,cold} operating schemes interleave application data according
to the list of migration nodes and weights passed in via the DAMON sysfs
interface. This functionality can be used to dynamically adjust how folios
are interleaved by having a userspace process adjust those weights. If no
specific destination nodes or weights are provided, the migrate_{hot,cold}
actions will only migrate folios to damos->target_nid as before.

The algorithm used to interleave the folios is similar to the one used for
the weighted interleave mempolicy [3]. It uses the offset from which a
folio is mapped into a VMA to determine the node the folio should be placed
in. This method is convenient because for a given set of interleave
weights, a folio has only one valid node it can be placed in, limitng the
amount of unnecessary data movement. However, finding out how a folio is
mapped inside of a VMA requires a costly rmap walk when using a paddr
scheme. As such, we have decided that this functionality makes more sense
as a vaddr scheme [4]. To this end, this patch set also adds vaddr versions
of the migrate_{hot,cold}.

Motivation
==========
There have been prior discussions about how changing the interleave weights
in response to the system's bandwidth utilization can be beneficial [2].
However, currently the interleave weights only are applied when data is
allocated. Migrating already allocated pages according to the dynamically
changing weights will better help balance the bandwidth utilization across
nodes.

As a toy example, imagine some application that uses 75% of the local
bandwidth. Assuming sufficient capacity, when running alone, we want to
keep that application's data in local memory. However, if a second
instance of that application begins, using the same amount of bandwidth,
it would be best to interleave the data of both processes to alleviate the
bandwidth pressure from the local node. Likewise, when one of the processes
ends, the data should be moves back to local memory.

We imagine there would be a userspace application that would monitor system
performance characteristics, such as bandwidth utilization or memory access
latency, and uses that information to tune the interleave weights. Others
seem to have come to a similar conclusion in previous discussions [5].
We are currently working on a userspace program that does this, but it is
not quite ready to be published yet.

After the userspace application tunes the interleave weights, there must be
some mechanism that actually migrates pages to be consistent with those
weights. This patchset is what provides this mechanism.

We believe DAMON is the correct venue for the interleaving mechanism for a
few reasons. First, we noticed that we don't have to migrate all of the
application's pages to improve performance. we just need to migrate the
frequently accessed pages. DAMON's existing hotness traching is very useful
for this. Second, DAMON's quota system can be used to ensure we are not
using too much bandwidth for migrations. Finally, as Ying pointed out [6],
a complete solution must also handle when a memory node is at capacity. The
existing migrate_cold action can be used in conjunction with the
functionality added in this patch set to provide that complete solution.

Functionality Test
==================
Below is an example of this new functionality in use to confirm that these
patches behave as intended.
In this example, the user starts an application, alloc_data, which
allocates 1GB using the default memory policy (i.e. allocate to local
memory) then sleeps. Afterwards, we start DAMON to interleave the data at a
1:1 ratio. Using numastat, we show that DAMON has migrated the
application's data to match the new interleave ratio.
For this example, I modified the userspace damo tool [8] to write to the
migration_dest sysfs files. I plan to upstream these changes when these
patches are merged.
  $ # Allocate the data initially
  $ ./alloc_data 1G &
  [1] 6587
  $ numastat -c -p alloc_data

  Per-node process memory usage (in MBs) for PID 6587 (alloc_data)
           Node 0 Node 1 Total
           ------ ------ -----
  Huge          0      0     0
  Heap          0      0     0
  Stack         0      0     0
  Private    1027      0  1027
  -------  ------ ------ -----
  Total      1027      0  1027
  $ # Start DAMON to interleave data at a 1:1 ratio
  $ cat ./interleave_vaddr.yaml
  kdamonds:
  - contexts:
    - ops: vaddr
      addr_unit: null
      targets:
      - pid: 6587
        regions: []
      intervals:
        sample_us: 500 ms
        aggr_us: 5 s
        ops_update_us: 20 s
        intervals_goal:
          access_bp: 0 %
          aggrs: '0'
          min_sample_us: 0 ns
          max_sample_us: 0 ns
      nr_regions:
        min: '20'
        max: '50'
      schemes:
      - action: migrate_hot
        dests:
        - nid: 0
          weight: 1
        - nid: 1
          weight: 1
        access_pattern:
          sz_bytes:
            min: 0 B
            max: max
          nr_accesses:
            min: 0 %
            max: 100 %
          age:
            min: 0 ns
            max: max
  $ sudo ./damo/damo interleave_vaddr.yaml
  $ # Verify that DAMON has migrated data to match the 1:1 ratio
  $ numastat -c -p alloc_data

  Per-node process memory usage (in MBs) for PID 6587 (alloc_data)
           Node 0 Node 1 Total
           ------ ------ -----
  Huge          0      0     0
  Heap          0      0     0
  Stack         0      0     0
  Private     514    514  1027
  -------  ------ ------ -----
  Total       514    514  1027

Performance Test
================
Below is a simple example showing that interleaving application data using
these patches can improve application performance.
To do this, we run a bandwidth intensive embedding reduction application
[7]. This workload is useful for this test because it reports the time it
takes each iteration to run and each iteration reuses the same allocation,
allowing us to see the benefits of the migration.

We evaluate this on a 128 core/256 thread AMD CPU with 72GB/s of local DDR
bandwidth and 26 GB/s of CXL bandwidth.

Before we start the workload, the system bandwidth utilization is low, so
we start with the interleave weights of 1:0, i.e. allocating all data to
local memory. When the workload beings, it saturates the local bandwidth,
making the page placement suboptimal. To alleviate this, we modify the
interleave weights, triggering DAMON to migrate the workload's data.

We use the same interleave_vaddr.yaml file to setup DAMON, except we
configure it to begin with a 1:0 interleave ratio, and attach it to the
shell and its children processes.

  $ sudo ./damo/damo start interleave_vaddr.yaml --include_child_tasks &
  $ <path>/eval_baseline -d amazon_All -c 255 -r 100
  <clip startup output>
  Eval Phase 3: Running Baseline...
  
  REPEAT # 0 Baseline Total time : 7323.54 ms
  REPEAT # 1 Baseline Total time : 7624.56 ms
  REPEAT # 2 Baseline Total time : 7619.61 ms
  REPEAT # 3 Baseline Total time : 7617.12 ms
  REPEAT # 4 Baseline Total time : 7638.64 ms
  REPEAT # 5 Baseline Total time : 7611.27 ms
  REPEAT # 6 Baseline Total time : 7629.32 ms
  REPEAT # 7 Baseline Total time : 7695.63 ms
  # Interleave weights set to 3:1
  REPEAT # 8 Baseline Total time : 7077.5 ms
  REPEAT # 9 Baseline Total time : 5633.23 ms
  REPEAT # 10 Baseline Total time : 5644.6 ms
  REPEAT # 11 Baseline Total time : 5627.66 ms
  REPEAT # 12 Baseline Total time : 5629.76 ms
  REPEAT # 13 Baseline Total time : 5633.05 ms
  REPEAT # 14 Baseline Total time : 5641.24 ms
  REPEAT # 15 Baseline Total time : 5631.18 ms
  REPEAT # 16 Baseline Total time : 5631.33 ms

Updating the interleave weights and having DAMON migrate the workload data
according to the weights resulted in an approximarely 25% speedup.

Patches Sequence
================
Patches 1-7 extend the DAMON API to specify multiple destination nodes and
weights for the migrate_{hot,cold} actions. These patches are from SJ'S
RFC [8].
Patches 8-10 add a vaddr implementation of the migrate_{hot,cold} schemes.
Patch 11 modifies the vaddr migrate_{hot,cold} schemes to interleave data
according to the weights provided by damos->migrate_dest.
Patches 12-13 allow the vaddr migrate_{hot,cold} implementation to filter
out folios like the paddr version.

Changes are applied on top of the mm-new tree and [9].

Revision History
================
Changes from v3 [10]:
- Fix bug where huge pages would be split
- Fix code nits/issues SJ pointed out
- Added SJ's Reviewed-by tag where appropriate

Changes from v2 [11]:
- Implement interleaving using vaddr instead of paddr
- Add vaddr implementation of migrate_{hot,cold}
- Use DAMON specific interleave weights instead of mempolicy weights

Changes from v1 [12]:
- Reuse migrate_{hot,cold} actions instead of creating a new action
- Remove vaddr implementation
- Remove most of the use of mempolicy, instead duplicate the interleave
  logic and access interleave weights directly
- Write more about the use case in the cover letter
- Write about why DAMON was used for this in the cover letter
- Add correctness test to the cover letter
- Add performance test

[1] https://lore.kernel.org/linux-mm/20250520141236.2987309-1-joshua.hahnjy@gmail.com/
[2] https://lore.kernel.org/linux-mm/20250313155705.1943522-1-joshua.hahnjy@gmail.com/
[3] https://elixir.bootlin.com/linux/v6.15.4/source/mm/mempolicy.c#L2015
[4] https://lore.kernel.org/damon/20250624223310.55786-1-sj@kernel.org/
[5] https://lore.kernel.org/linux-mm/20250314151137.892379-1-joshua.hahnjy@gmail.com/
[6] https://lore.kernel.org/linux-mm/87frjfx6u4.fsf@DESKTOP-5N7EMDA/
[7] https://github.com/SNU-ARC/MERCI
[8] https://lore.kernel.org/damon/20250702051558.54138-1-sj@kernel.org/
[9] https://lore.kernel.org/damon/20250709004729.17252-1-bijan311@gmail.com/
[10] https://lore.kernel.org/damon/20250702201337.5780-1-bijan311@gmail.com/
[11] https://lore.kernel.org/damon/20250620180458.5041-1-bijan311@gmail.com/
[12] https://lore.kernel.org/linux-mm/20250612181330.31236-1-bijan311@gmail.com/

Bijan Tabatabai (7):
  mm/damon/core: Commit damos->migrate_dests
  mm/damon: Move migration helpers from paddr to ops-common
  mm/damon/vaddr: Add vaddr versions of migrate_{hot,cold}
  Docs/mm/damon/design: Document vaddr support for migrate_{hot,cold}
  mm/damon/vaddr: Use damos->migrate_dests in migrate_{hot,cold}
  mm/damon: Move folio filtering from paddr to ops-common
  mm/damon/vaddr: Apply filters in migrate_{hot/cold}

SeongJae Park (6):
  mm/damon: add struct damos_migrate_dests
  mm/damon/core: add damos->migrate_dests field
  mm/damon/sysfs-schemes: implement DAMOS action destinations directory
  mm/damon/sysfs-schemes: set damos->migrate_dests
  Docs/ABI/damon: document schemes dests directory
  Docs/admin-guide/mm/damon/usage: document dests directory

 .../ABI/testing/sysfs-kernel-mm-damon         |  22 ++
 Documentation/admin-guide/mm/damon/usage.rst  |  33 ++-
 Documentation/mm/damon/design.rst             |   4 +-
 include/linux/damon.h                         |  29 +-
 mm/damon/core.c                               |  43 +++
 mm/damon/ops-common.c                         | 270 +++++++++++++++++
 mm/damon/ops-common.h                         |   5 +
 mm/damon/paddr.c                              | 275 +-----------------
 mm/damon/sysfs-schemes.c                      | 253 +++++++++++++++-
 mm/damon/vaddr.c                              | 235 +++++++++++++++
 10 files changed, 886 insertions(+), 283 deletions(-)

-- 
2.43.0


