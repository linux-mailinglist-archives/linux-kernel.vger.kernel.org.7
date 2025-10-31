Return-Path: <linux-kernel+bounces-880488-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id CBB25C25E01
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 16:43:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 94BED4E9FD3
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 15:43:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 265982E1F06;
	Fri, 31 Oct 2025 15:42:38 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FE812E7621;
	Fri, 31 Oct 2025 15:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761925357; cv=none; b=K57pmuHpEnJwb6rEIsqDMBGejguMMdxC57XrVuVI3oPxP3cRAXuNrhB529HUZVsz3BE4I4mBOa4wOyfQoMD+qATCcPatwAkzOShRcg31hQtE0uF8WYHadBiQpcNdJl+yW+Qs0BnIBSMHbMCt9a2p2qZu6QZ6apHiVVOoum5ZmpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761925357; c=relaxed/simple;
	bh=WgycjOCZjZnHaVWCT2nuafQQmtgoRqecQ2sN/B06bvM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=tleHxjKeV5YaNPOCcWEQyLRxffwPE1p6PjZ9cpc3ggZzsMsr+5i3MVr+QE3MO+jGYx4LK9B+Eb2/b2zzxqAnkfFkQyFC8zHfKANuSvjSTc9VN5v216Kw7vodJ9wuJ3WlHTpjkTsGyMwjx78aHl1KR00S4E7rOzonaTscr1jNHfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1435A1595;
	Fri, 31 Oct 2025 08:42:25 -0700 (PDT)
Received: from e133380.cambridge.arm.com (e133380.arm.com [10.1.197.68])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7C19A3F66E;
	Fri, 31 Oct 2025 08:42:30 -0700 (PDT)
From: Dave Martin <Dave.Martin@arm.com>
To: linux-kernel@vger.kernel.org
Cc: Tony Luck <tony.luck@intel.com>,
	Reinette Chatre <reinette.chatre@intel.com>,
	James Morse <james.morse@arm.com>,
	Ben Horgan <ben.horgan@arm.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Jonathan Corbet <corbet@lwn.net>,
	x86@kernel.org,
	linux-doc@vger.kernel.org
Subject: [PATCH v2] x86,fs/resctrl: Factor MBA parse-time conversion to be per-arch
Date: Fri, 31 Oct 2025 15:41:25 +0000
Message-Id: <20251031154225.14799-1-Dave.Martin@arm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The control value parser for the MB resource currently coerces the
memory bandwidth percentage value from userspace to be an exact
multiple of the rdt_resource::resctrl_membw::bw_gran parameter.

On MPAM systems, this results in somewhat worse-than-worst-case
rounding, since the bandwidth granularity advertised to resctrl by the
MPAM driver is in general only an approximation to the actual hardware
granularity on these systems, and the hardware bandwidth allocation
control value is not natively a percentage -- necessitating a further
conversion in the resctrl_arch_update_domains() path, regardless of the
conversion done at parse time.

Allow the arch to provide its own parse-time conversion that is
appropriate for the hardware, and move the existing conversion to x86.
This will avoid accumulated error from rounding the value twice on MPAM
systems.

Clarify the documentation, but avoid overly exact promises.

Clamping to bw_min and bw_max still feels generic: leave it in the core
code, for now.

No functional change.

Signed-off-by: Dave Martin <Dave.Martin@arm.com>

---

Based on: v6.18-rc3

This is a minor update to v1 [1], with no functional differences.

Testing: see "Testing Notes", below.

Apologies for the long tearoff that follows...
For the actual patch, skip to the regex '^diff'.


Changes since v1:

 * Commit message updates: Fixed subsytem tag and casing of "MBA" in
   the subject line; named the affected parameter explicitly,
   rdt_resource::resctrl_membw::bw_gran.

 * Miscellenaeous function comment blocks and documentation text
   updated in response to review comments.

 * Updated documentation of bw_gran as per Reinette's suggestions.

 * Renamed resctrl_arch_round_bw() -> resctrl_arch_preconvert_bw(),
   since this is just a hook for the arch code to do something to a
   value that it will use later; the core code doesn't care what
   transformation is done here.  Clarified the accompanying comments.

 * Removed dangling forward declaration of struct rdt_resource in
   arch/x86/include/asm/resctrl.h.


Original tear-off notes from v1:

I put the x86 version out of line in order to avoid having to move
struct rdt_resource and its dependencies into resctrl_types.h -- which
would create a lot of diff noise.  Schemata writes from userspace have
a high overhead in any case.

For MPAM the conversion will be a no-op, because the incoming
percentage from the core resctrl code needs to be converted to hardware
representation in the driver anyway.

Perhaps _all_ the types should move to resctrl_types.h.

For now, I went for the smallest diffstat...

---
 Documentation/filesystems/resctrl.rst     | 17 +++++++++--------
 arch/x86/kernel/cpu/resctrl/ctrlmondata.c |  6 ++++++
 fs/resctrl/ctrlmondata.c                  |  6 +++---
 include/linux/resctrl.h                   | 14 ++++++++++++++
 4 files changed, 32 insertions(+), 11 deletions(-)

---

Testing Notes:

This patch should not make any functional change, but for completeness
I have included comparisons of the output of the restrcl kselftests.

See [3], [4] for detailed diffs.

(dmesg timestamp and PID changes squashed.)

The vanilla 6.18-rc1 and patches 6.18-rc1 test runs are those discussed
in [2] (see there for discussion of the out-of-tolerance results

---

References:

[1] [PATCH] fs/resctrl,x86/resctrl: Factor mba rounding to be per-arch
https://lore.kernel.org/lkml/20250902162507.18520-1-Dave.Martin@arm.com/

[2] Re: [PATCH] fs/resctrl,x86/resctrl: Factor mba rounding to be per-arch
(test discussion subthread)
https://lore.kernel.org/lkml/aO+7MeSMV29VdbQs@e133380.arm.com/

Test diffs:

[3] resctrl_tests output diff
from vanilla 6.18-rc1 (busy, recently-booted system)
to this patch on 6.18-rc3 (quiet system).

# --- base-rc1/resctrl_tests_6.18.0-rc1.out	2025-10-14 17:11:56.000000000 +0100
# +++ test-rc3/resctrl_tests.out	2025-10-28 16:07:12.000000000 +0000
# @@ -1,132 +1,132 @@
#  TAP version 13
#  # Pass: Check kernel supports resctrl filesystem
#  # Pass: Check resctrl mountpoint "/sys/fs/resctrl" exists
#  # resctrl filesystem not mounted
#  # dmesg: [    1.397893] resctrl: L3 allocation detected
#  # dmesg: [    1.397928] resctrl: MB allocation detected
#  # dmesg: [    1.397961] resctrl: L3 monitoring detected
#  1..6
#  # Starting MBM test ...
#  # Mounting resctrl to "/sys/fs/resctrl"
#  # Writing benchmark parameters to resctrl FS
#  # Benchmark PID: 998
#  # Write schema "MB:0=100" to resctrl FS
#  # Checking for pass/fail
#  # Pass: Check MBM diff within 8%
# -# avg_diff_per: 0%
# +# avg_diff_per: 1%
#  # Span (MB): 250
# -# avg_bw_imc: 6422
# -# avg_bw_resc: 6392
# +# avg_bw_imc: 6509
# +# avg_bw_resc: 6580
#  ok 1 MBM: test
#  # Starting MBA test ...
#  # Mounting resctrl to "/sys/fs/resctrl"
#  # Writing benchmark parameters to resctrl FS
#  # Benchmark PID: 999
#  # Write schema "MB:0=10" to resctrl FS
#  # Write schema "MB:0=20" to resctrl FS
#  # Write schema "MB:0=30" to resctrl FS
#  # Write schema "MB:0=40" to resctrl FS
#  # Write schema "MB:0=50" to resctrl FS
#  # Write schema "MB:0=60" to resctrl FS
#  # Write schema "MB:0=70" to resctrl FS
#  # Write schema "MB:0=80" to resctrl FS
#  # Write schema "MB:0=90" to resctrl FS
#  # Write schema "MB:0=100" to resctrl FS
#  # Results are displayed in (MB)
#  # Pass: Check MBA diff within 8% for schemata 10
# -# avg_diff_per: 1%
# -# avg_bw_imc: 2033
# -# avg_bw_resc: 2012
# +# avg_diff_per: 0%
# +# avg_bw_imc: 1987
# +# avg_bw_resc: 2004
#  # Pass: Check MBA diff within 8% for schemata 20
#  # avg_diff_per: 0%
# -# avg_bw_imc: 3028
# +# avg_bw_imc: 2980
#  # avg_bw_resc: 3005
#  # Pass: Check MBA diff within 8% for schemata 30
#  # avg_diff_per: 0%
# -# avg_bw_imc: 3982
# -# avg_bw_resc: 3958
# +# avg_bw_imc: 3981
# +# avg_bw_resc: 4012
#  # Pass: Check MBA diff within 8% for schemata 40
#  # avg_diff_per: 0%
# -# avg_bw_imc: 6265
# -# avg_bw_resc: 6236
# +# avg_bw_imc: 6302
# +# avg_bw_resc: 6351
#  # Pass: Check MBA diff within 8% for schemata 50
#  # avg_diff_per: 0%
# -# avg_bw_imc: 6384
# -# avg_bw_resc: 6355
# +# avg_bw_imc: 6417
# +# avg_bw_resc: 6468
#  # Pass: Check MBA diff within 8% for schemata 60
#  # avg_diff_per: 0%
# -# avg_bw_imc: 6405
# -# avg_bw_resc: 6376
# +# avg_bw_imc: 6475
# +# avg_bw_resc: 6527
#  # Pass: Check MBA diff within 8% for schemata 70
#  # avg_diff_per: 0%
# -# avg_bw_imc: 6417
# -# avg_bw_resc: 6387
# +# avg_bw_imc: 6504
# +# avg_bw_resc: 6557
#  # Pass: Check MBA diff within 8% for schemata 80
#  # avg_diff_per: 0%
# -# avg_bw_imc: 6418
# -# avg_bw_resc: 6394
# +# avg_bw_imc: 6502
# +# avg_bw_resc: 6556
#  # Pass: Check MBA diff within 8% for schemata 90
#  # avg_diff_per: 0%
# -# avg_bw_imc: 6412
# -# avg_bw_resc: 6384
# +# avg_bw_imc: 6506
# +# avg_bw_resc: 6555
#  # Pass: Check MBA diff within 8% for schemata 100
#  # avg_diff_per: 0%
# -# avg_bw_imc: 6425
# -# avg_bw_resc: 6399
# +# avg_bw_imc: 6518
# +# avg_bw_resc: 6572
#  # Pass: Check schemata change using MBA
#  ok 2 MBA: test
#  # Starting CMT test ...
#  # Mounting resctrl to "/sys/fs/resctrl"
#  # Cache size :23068672
#  # Writing benchmark parameters to resctrl FS
# -# Benchmark PID: 5135
# +# Benchmark PID: 1000
#  # Checking for pass/fail
# -# Fail: Check cache miss rate within 15%
# -# Percent diff=24
# +# Pass: Check cache miss rate within 15%
# +# Percent diff=9
#  # Number of bits: 5
# -# Average LLC val: 7942963
# +# Average LLC val: 9528934
#  # Cache span (bytes): 10485760
# -not ok 3 CMT: test
# +ok 3 CMT: test
#  # Starting L3_CAT test ...
#  # Mounting resctrl to "/sys/fs/resctrl"
#  # Cache size :23068672
#  # Writing benchmark parameters to resctrl FS
#  # Write schema "L3:0=1f0" to resctrl FS
#  # Write schema "L3:0=f" to resctrl FS
#  # Write schema "L3:0=1f8" to resctrl FS
#  # Write schema "L3:0=7" to resctrl FS
#  # Write schema "L3:0=1fc" to resctrl FS
#  # Write schema "L3:0=3" to resctrl FS
#  # Write schema "L3:0=1fe" to resctrl FS
#  # Write schema "L3:0=1" to resctrl FS
#  # Checking for pass/fail
#  # Number of bits: 4
# -# Average LLC val: 71434
# +# Average LLC val: 76870
#  # Cache span (lines): 131072
#  # Pass: Check cache miss rate changed more than 2.0%
# -# Percent diff=70.0
# +# Percent diff=63.7
#  # Number of bits: 3
# -# Average LLC val: 121463
# +# Average LLC val: 125814
#  # Cache span (lines): 98304
#  # Pass: Check cache miss rate changed more than 1.0%
# -# Percent diff=40.8
# +# Percent diff=41.0
#  # Number of bits: 2
# -# Average LLC val: 170978
# +# Average LLC val: 177346
#  # Cache span (lines): 65536
#  # Pass: Check cache miss rate changed more than 0.0%
# -# Percent diff=22.8
# +# Percent diff=20.8
#  # Number of bits: 1
# -# Average LLC val: 209950
# +# Average LLC val: 214175
#  # Cache span (lines): 32768
#  ok 4 L3_CAT: test
#  # Starting L3_NONCONT_CAT test ...
#  # Mounting resctrl to "/sys/fs/resctrl"
#  # Write schema "L3:0=3f" to resctrl FS
#  # Write schema "L3:0=787" to resctrl FS # write() failed : Invalid argument
#  # Non-contiguous CBMs not supported and write of non-contiguous CBM failed as expected
#  ok 5 L3_NONCONT_CAT: test
#  # Starting L2_NONCONT_CAT test ...
#  # Mounting resctrl to "/sys/fs/resctrl"
#  ok 6 # SKIP Hardware does not support L2_NONCONT_CAT or L2_NONCONT_CAT is disabled
#  # 1 skipped test(s) detected. Consider enabling relevant config options to improve coverage.
# -# Totals: pass:4 fail:1 xfail:0 xpass:0 skip:1 error:0
# +# Totals: pass:5 fail:0 xfail:0 xpass:0 skip:1 error:0


[4] resctrl_tests output diff
from this patch on 6.18-rc1 (busy, recently-booted system)
to this patch on 6.18-rc3 (quiet system).

# --- test-rc1/resctrl_tests_6.18.0-rc1-test1.out	2025-10-14 17:21:44.000000000 +0100
# +++ test-rc3/resctrl_tests.out	2025-10-28 16:07:12.000000000 +0000
# @@ -1,132 +1,132 @@
#  TAP version 13
#  # Pass: Check kernel supports resctrl filesystem
#  # Pass: Check resctrl mountpoint "/sys/fs/resctrl" exists
#  # resctrl filesystem not mounted
#  # dmesg: [    1.397893] resctrl: L3 allocation detected
#  # dmesg: [    1.397928] resctrl: MB allocation detected
#  # dmesg: [    1.397961] resctrl: L3 monitoring detected
#  1..6
#  # Starting MBM test ...
#  # Mounting resctrl to "/sys/fs/resctrl"
#  # Writing benchmark parameters to resctrl FS
#  # Benchmark PID: 998
#  # Write schema "MB:0=100" to resctrl FS
#  # Checking for pass/fail
#  # Pass: Check MBM diff within 8%
# -# avg_diff_per: 0%
# +# avg_diff_per: 1%
#  # Span (MB): 250
# -# avg_bw_imc: 6886
# -# avg_bw_resc: 6943
# +# avg_bw_imc: 6509
# +# avg_bw_resc: 6580
#  ok 1 MBM: test
#  # Starting MBA test ...
#  # Mounting resctrl to "/sys/fs/resctrl"
#  # Writing benchmark parameters to resctrl FS
#  # Benchmark PID: 999
#  # Write schema "MB:0=10" to resctrl FS
#  # Write schema "MB:0=20" to resctrl FS
#  # Write schema "MB:0=30" to resctrl FS
#  # Write schema "MB:0=40" to resctrl FS
#  # Write schema "MB:0=50" to resctrl FS
#  # Write schema "MB:0=60" to resctrl FS
#  # Write schema "MB:0=70" to resctrl FS
#  # Write schema "MB:0=80" to resctrl FS
#  # Write schema "MB:0=90" to resctrl FS
#  # Write schema "MB:0=100" to resctrl FS
#  # Results are displayed in (MB)
#  # Pass: Check MBA diff within 8% for schemata 10
#  # avg_diff_per: 0%
# -# avg_bw_imc: 2028
# -# avg_bw_resc: 2032
# +# avg_bw_imc: 1987
# +# avg_bw_resc: 2004
#  # Pass: Check MBA diff within 8% for schemata 20
#  # avg_diff_per: 0%
# -# avg_bw_imc: 3006
# -# avg_bw_resc: 3011
# +# avg_bw_imc: 2980
# +# avg_bw_resc: 3005
#  # Pass: Check MBA diff within 8% for schemata 30
#  # avg_diff_per: 0%
# -# avg_bw_imc: 4006
# -# avg_bw_resc: 4013
# +# avg_bw_imc: 3981
# +# avg_bw_resc: 4012
#  # Pass: Check MBA diff within 8% for schemata 40
#  # avg_diff_per: 0%
# -# avg_bw_imc: 6726
# -# avg_bw_resc: 6732
# +# avg_bw_imc: 6302
# +# avg_bw_resc: 6351
#  # Pass: Check MBA diff within 8% for schemata 50
#  # avg_diff_per: 0%
# -# avg_bw_imc: 6854
# -# avg_bw_resc: 6856
# +# avg_bw_imc: 6417
# +# avg_bw_resc: 6468
#  # Pass: Check MBA diff within 8% for schemata 60
#  # avg_diff_per: 0%
# -# avg_bw_imc: 6882
# -# avg_bw_resc: 6883
# +# avg_bw_imc: 6475
# +# avg_bw_resc: 6527
#  # Pass: Check MBA diff within 8% for schemata 70
#  # avg_diff_per: 0%
# -# avg_bw_imc: 6891
# -# avg_bw_resc: 6889
# +# avg_bw_imc: 6504
# +# avg_bw_resc: 6557
#  # Pass: Check MBA diff within 8% for schemata 80
#  # avg_diff_per: 0%
# -# avg_bw_imc: 6893
# -# avg_bw_resc: 6909
# +# avg_bw_imc: 6502
# +# avg_bw_resc: 6556
#  # Pass: Check MBA diff within 8% for schemata 90
#  # avg_diff_per: 0%
# -# avg_bw_imc: 6890
# -# avg_bw_resc: 6888
# +# avg_bw_imc: 6506
# +# avg_bw_resc: 6555
#  # Pass: Check MBA diff within 8% for schemata 100
#  # avg_diff_per: 0%
# -# avg_bw_imc: 6929
# -# avg_bw_resc: 6951
# +# avg_bw_imc: 6518
# +# avg_bw_resc: 6572
#  # Pass: Check schemata change using MBA
#  ok 2 MBA: test
#  # Starting CMT test ...
#  # Mounting resctrl to "/sys/fs/resctrl"
#  # Cache size :23068672
#  # Writing benchmark parameters to resctrl FS
#  # Benchmark PID: 1000
#  # Checking for pass/fail
#  # Pass: Check cache miss rate within 15%
# -# Percent diff=4
# +# Percent diff=9
#  # Number of bits: 5
# -# Average LLC val: 10918297
# +# Average LLC val: 9528934
#  # Cache span (bytes): 10485760
#  ok 3 CMT: test
#  # Starting L3_CAT test ...
#  # Mounting resctrl to "/sys/fs/resctrl"
#  # Cache size :23068672
#  # Writing benchmark parameters to resctrl FS
#  # Write schema "L3:0=1f0" to resctrl FS
#  # Write schema "L3:0=f" to resctrl FS
#  # Write schema "L3:0=1f8" to resctrl FS
#  # Write schema "L3:0=7" to resctrl FS
#  # Write schema "L3:0=1fc" to resctrl FS
#  # Write schema "L3:0=3" to resctrl FS
#  # Write schema "L3:0=1fe" to resctrl FS
#  # Write schema "L3:0=1" to resctrl FS
#  # Checking for pass/fail
#  # Number of bits: 4
# -# Average LLC val: 70161
# +# Average LLC val: 76870
#  # Cache span (lines): 131072
#  # Pass: Check cache miss rate changed more than 2.0%
# -# Percent diff=72.1
# +# Percent diff=63.7
#  # Number of bits: 3
# -# Average LLC val: 120755
# +# Average LLC val: 125814
#  # Cache span (lines): 98304
#  # Pass: Check cache miss rate changed more than 1.0%
# -# Percent diff=42.5
# +# Percent diff=41.0
#  # Number of bits: 2
# -# Average LLC val: 172077
# +# Average LLC val: 177346
#  # Cache span (lines): 65536
#  # Pass: Check cache miss rate changed more than 0.0%
# -# Percent diff=22.0
# +# Percent diff=20.8
#  # Number of bits: 1
# -# Average LLC val: 209893
# +# Average LLC val: 214175
#  # Cache span (lines): 32768
#  ok 4 L3_CAT: test
#  # Starting L3_NONCONT_CAT test ...
#  # Mounting resctrl to "/sys/fs/resctrl"
#  # Write schema "L3:0=3f" to resctrl FS
#  # Write schema "L3:0=787" to resctrl FS # write() failed : Invalid argument
#  # Non-contiguous CBMs not supported and write of non-contiguous CBM failed as expected
#  ok 5 L3_NONCONT_CAT: test
#  # Starting L2_NONCONT_CAT test ...
#  # Mounting resctrl to "/sys/fs/resctrl"
#  ok 6 # SKIP Hardware does not support L2_NONCONT_CAT or L2_NONCONT_CAT is disabled
#  # 1 skipped test(s) detected. Consider enabling relevant config options to improve coverage.
#  # Totals: pass:5 fail:0 xfail:0 xpass:0 skip:1 error:0


diff --git a/Documentation/filesystems/resctrl.rst b/Documentation/filesystems/resctrl.rst
index b7f35b07876a..fbbcf5421346 100644
--- a/Documentation/filesystems/resctrl.rst
+++ b/Documentation/filesystems/resctrl.rst
@@ -144,12 +144,11 @@ with respect to allocation:
 		user can request.
 
 "bandwidth_gran":
-		The granularity in which the memory bandwidth
-		percentage is allocated. The allocated
-		b/w percentage is rounded off to the next
-		control step available on the hardware. The
-		available bandwidth control steps are:
-		min_bandwidth + N * bandwidth_gran.
+		The approximate granularity in which the memory bandwidth
+		percentage is allocated. The allocated bandwidth percentage
+		is rounded up to the next control step available on the
+		hardware. The available hardware steps are no larger than
+		this value.
 
 "delay_linear":
 		Indicates if the delay scale is linear or
@@ -737,8 +736,10 @@ The minimum bandwidth percentage value for each cpu model is predefined
 and can be looked up through "info/MB/min_bandwidth". The bandwidth
 granularity that is allocated is also dependent on the cpu model and can
 be looked up at "info/MB/bandwidth_gran". The available bandwidth
-control steps are: min_bw + N * bw_gran. Intermediate values are rounded
-to the next control step available on the hardware.
+control steps are, approximately, min_bw + N * bw_gran.  The steps may
+appear irregular due to rounding to an exact percentage: bw_gran is the
+maximum interval between the percentage values corresponding to any two
+adjacent steps in the hardware.
 
 The bandwidth throttling is a core specific mechanism on some of Intel
 SKUs. Using a high bandwidth and a low bandwidth setting on two threads
diff --git a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
index 1189c0df4ad7..dc05a50e80fb 100644
--- a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
+++ b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
@@ -16,9 +16,15 @@
 #define pr_fmt(fmt)	KBUILD_MODNAME ": " fmt
 
 #include <linux/cpu.h>
+#include <linux/math.h>
 
 #include "internal.h"
 
+u32 resctrl_arch_preconvert_bw(u32 val, const struct rdt_resource *r)
+{
+	return roundup(val, (unsigned long)r->membw.bw_gran);
+}
+
 int resctrl_arch_update_one(struct rdt_resource *r, struct rdt_ctrl_domain *d,
 			    u32 closid, enum resctrl_conf_type t, u32 cfg_val)
 {
diff --git a/fs/resctrl/ctrlmondata.c b/fs/resctrl/ctrlmondata.c
index 0d0ef54fc4de..26e3f7c88c86 100644
--- a/fs/resctrl/ctrlmondata.c
+++ b/fs/resctrl/ctrlmondata.c
@@ -35,8 +35,8 @@ typedef int (ctrlval_parser_t)(struct rdt_parse_data *data,
 /*
  * Check whether MBA bandwidth percentage value is correct. The value is
  * checked against the minimum and max bandwidth values specified by the
- * hardware. The allocated bandwidth percentage is rounded to the next
- * control step available on the hardware.
+ * hardware. The allocated bandwidth percentage is converted as
+ * appropriate for consumption by the specific hardware driver.
  */
 static bool bw_validate(char *buf, u32 *data, struct rdt_resource *r)
 {
@@ -69,7 +69,7 @@ static bool bw_validate(char *buf, u32 *data, struct rdt_resource *r)
 		return false;
 	}
 
-	*data = roundup(bw, (unsigned long)r->membw.bw_gran);
+	*data = resctrl_arch_preconvert_bw(bw, r);
 	return true;
 }
 
diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
index a7d92718b653..1fb6e2118b61 100644
--- a/include/linux/resctrl.h
+++ b/include/linux/resctrl.h
@@ -485,6 +485,20 @@ bool resctrl_arch_mbm_cntr_assign_enabled(struct rdt_resource *r);
  */
 int resctrl_arch_mbm_cntr_assign_set(struct rdt_resource *r, bool enable);
 
+/*
+ * Convert a bandwidth control value to the appropriate form for
+ * consumption by the hardware driver for resource r.
+ *
+ * For example, it simplifies the x86 RDT implementation to round the
+ * value to a suitable step here and then treat the resulting value as
+ * opaque when programming the hardware MSRs later on.
+ *
+ * Architectures for which this pre-conversion hook is not useful
+ * should supply an implementation of this function that just returns
+ * val unmodified.
+ */
+u32 resctrl_arch_preconvert_bw(u32 val, const struct rdt_resource *r);
+
 /*
  * Update the ctrl_val and apply this config right now.
  * Must be called on one of the domain's CPUs.

base-commit: dcb6fa37fd7bc9c3d2b066329b0d27dedf8becaa
-- 
2.34.1


