Return-Path: <linux-kernel+bounces-854757-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B8F9FBDF510
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 17:20:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3573C507E32
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 15:18:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F6E32FB982;
	Wed, 15 Oct 2025 15:18:21 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1809C2FB098;
	Wed, 15 Oct 2025 15:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760541500; cv=none; b=ct0L+6FiB2ejv7Ba5U6vsSScwdvtMPa7+zPm726lGioQCEawVypNbPl7RzOH2h6/wfHyQLcNUxB8wENyPyiDvxazf4EYaScxiKMgs/B9WbQzfYc77ddH373Q+BypszBSkRCHrci32aydGzti7KDdzybbzARLObOIW8EGC8JNplI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760541500; c=relaxed/simple;
	bh=Hrmt+Y7mWkjnLYCZVh4Gs5U5H6hIxRys96aOiCSBM6A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JHpphCiF8oRvjPSnJ9HXIPytnbv6qCIdz54/IOEjEfLDvclhPL6g4N4gEEel25of/0CIx/GVrZRiqLPNDe4XdkVwtaEAgvdgsHQKPARqbHVJp3QvWi14CPEEFUQPMHrs8JeNOOJERO4pNkOXUWXoAsBWqVh68kC6YRC1NC/zD8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8BAE41655;
	Wed, 15 Oct 2025 08:18:10 -0700 (PDT)
Received: from e133380.arm.com (e133380.arm.com [10.1.197.68])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 67D2C3F738;
	Wed, 15 Oct 2025 08:18:16 -0700 (PDT)
Date: Wed, 15 Oct 2025 16:18:09 +0100
From: Dave Martin <Dave.Martin@arm.com>
To: Reinette Chatre <reinette.chatre@intel.com>
Cc: linux-kernel@vger.kernel.org, Tony Luck <tony.luck@intel.com>,
	James Morse <james.morse@arm.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>, Jonathan Corbet <corbet@lwn.net>,
	x86@kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH] fs/resctrl,x86/resctrl: Factor mba rounding to be
 per-arch
Message-ID: <aO+7MeSMV29VdbQs@e133380.arm.com>
References: <20250902162507.18520-1-Dave.Martin@arm.com>
 <b38f0459-1373-42d3-8526-e8ef9ac4d2e7@intel.com>
 <aNFfs43UBp6tjqPM@e133380.arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aNFfs43UBp6tjqPM@e133380.arm.com>

Hi Reinette,

Just following up on the skipped L2_NONCONT_CAT test -- see below.

[...]

On Mon, Sep 22, 2025 at 03:39:47PM +0100, Dave Martin wrote:

[...]

> On Fri, Sep 12, 2025 at 03:19:04PM -0700, Reinette Chatre wrote:

[...]

> > On 9/2/25 9:24 AM, Dave Martin wrote:

[...]

> > > Testing: the resctrl MBA and MBM tests pass on a random x86 machine (+
> > > the other tests except for the NONCONT_CAT tests, which do not seem to
> > > be supported in my configuration -- and have nothing to do with the
> > > code touched by this patch).
> > 
> > Is the NONCONT_CAT test failing (i.e printing "not ok")?
> > 
> > The NONCONT_CAT tests may print error messages as debug information as part of
> > running, but these errors are expected as part of the test. The test should accurately
> > state whether it passed or failed though. For example, below attempts to write
> > a non-contiguous CBM to a system that does not support non-contiguous masks.
> > This fails as expected, error messages printed as debugging and thus the test passes
> > with an "ok".
> > 
> > # Write schema "L3:0=ff0ff" to resctrl FS # write() failed : Invalid argument                                      
> > # Non-contiguous CBMs not supported and write of non-contiguous CBM failed as expected                             
> > ok 5 L3_NONCONT_CAT: test                             
> 
> I don't think that this was anything to do with my changes, but I don't
> still seem to have the test output.  (Since this test has to do with
> bitmap schemata (?), it seemed unlikely to be affected by changes to
> bw_validate().)
> 
> I'll need to re-test with and without this patch to check whether it
> makes any difference.

I finally got around to testing this on top of -rc1.

Disregarding trivial differences, the patched version (+++) doesn't
seem to introduce any regressions over the vanilla version (---)
(below).  (The CMT test actually failed with an out-of-tolerance result
on the vanilla kernel only.  Possibly there was some adverse system
load interfering.)


Looking at the code, it seems that L2_NONCONT_CAT is not gated by any
config or mount option.  I think this is just a feature that my
hardware doesn't support (?)

arch/x86/kernel/cpu/resctrl/core.c has:

 | static void rdt_get_cache_alloc_cfg(int idx, struct rdt_resource *r)
 | {
  
   [...]
  
 | 	if (boot_cpu_data.x86_vendor == X86_VENDOR_INTEL)
 | 		r->cache.arch_has_sparse_bitmasks = ecx.split.noncont;
  
   [...]
  
 | }

Cheers
---Dave


Full diff of the test output:

--- base/resctrl_tests_6.18.0-rc1.out	2025-10-14 17:11:56.000000000 +0100
+++ test1/resctrl_tests_6.18.0-rc1-test1.out	2025-10-14 17:21:44.000000000 +0100
@@ -1,132 +1,132 @@
 TAP version 13
 # Pass: Check kernel supports resctrl filesystem
 # Pass: Check resctrl mountpoint "/sys/fs/resctrl" exists
 # resctrl filesystem not mounted
-# dmesg: [    1.409003] resctrl: L3 allocation detected
-# dmesg: [    1.409040] resctrl: MB allocation detected
-# dmesg: [    1.409072] resctrl: L3 monitoring detected
+# dmesg: [    1.411733] resctrl: L3 allocation detected
+# dmesg: [    1.411792] resctrl: MB allocation detected
+# dmesg: [    1.411831] resctrl: L3 monitoring detected
 1..6
 # Starting MBM test ...
 # Mounting resctrl to "/sys/fs/resctrl"
 # Writing benchmark parameters to resctrl FS
-# Benchmark PID: 5126
+# Benchmark PID: 4954
 # Write schema "MB:0=100" to resctrl FS
 # Checking for pass/fail
 # Pass: Check MBM diff within 8%
 # avg_diff_per: 0%
 # Span (MB): 250
-# avg_bw_imc: 6422
-# avg_bw_resc: 6392
+# avg_bw_imc: 6886
+# avg_bw_resc: 6943
 ok 1 MBM: test
 # Starting MBA test ...
 # Mounting resctrl to "/sys/fs/resctrl"
 # Writing benchmark parameters to resctrl FS
-# Benchmark PID: 5129
+# Benchmark PID: 4957
 # Write schema "MB:0=10" to resctrl FS
 # Write schema "MB:0=20" to resctrl FS
 # Write schema "MB:0=30" to resctrl FS
 # Write schema "MB:0=40" to resctrl FS
 # Write schema "MB:0=50" to resctrl FS
 # Write schema "MB:0=60" to resctrl FS
 # Write schema "MB:0=70" to resctrl FS
 # Write schema "MB:0=80" to resctrl FS
 # Write schema "MB:0=90" to resctrl FS
 # Write schema "MB:0=100" to resctrl FS
 # Results are displayed in (MB)
 # Pass: Check MBA diff within 8% for schemata 10
-# avg_diff_per: 1%
-# avg_bw_imc: 2033
-# avg_bw_resc: 2012
+# avg_diff_per: 0%
+# avg_bw_imc: 2028
+# avg_bw_resc: 2032
 # Pass: Check MBA diff within 8% for schemata 20
 # avg_diff_per: 0%
-# avg_bw_imc: 3028
-# avg_bw_resc: 3005
+# avg_bw_imc: 3006
+# avg_bw_resc: 3011
 # Pass: Check MBA diff within 8% for schemata 30
 # avg_diff_per: 0%
-# avg_bw_imc: 3982
-# avg_bw_resc: 3958
+# avg_bw_imc: 4006
+# avg_bw_resc: 4013
 # Pass: Check MBA diff within 8% for schemata 40
 # avg_diff_per: 0%
-# avg_bw_imc: 6265
-# avg_bw_resc: 6236
+# avg_bw_imc: 6726
+# avg_bw_resc: 6732
 # Pass: Check MBA diff within 8% for schemata 50
 # avg_diff_per: 0%
-# avg_bw_imc: 6384
-# avg_bw_resc: 6355
+# avg_bw_imc: 6854
+# avg_bw_resc: 6856
 # Pass: Check MBA diff within 8% for schemata 60
 # avg_diff_per: 0%
-# avg_bw_imc: 6405
-# avg_bw_resc: 6376
+# avg_bw_imc: 6882
+# avg_bw_resc: 6883
 # Pass: Check MBA diff within 8% for schemata 70
 # avg_diff_per: 0%
-# avg_bw_imc: 6417
-# avg_bw_resc: 6387
+# avg_bw_imc: 6891
+# avg_bw_resc: 6889
 # Pass: Check MBA diff within 8% for schemata 80
 # avg_diff_per: 0%
-# avg_bw_imc: 6418
-# avg_bw_resc: 6394
+# avg_bw_imc: 6893
+# avg_bw_resc: 6909
 # Pass: Check MBA diff within 8% for schemata 90
 # avg_diff_per: 0%
-# avg_bw_imc: 6412
-# avg_bw_resc: 6384
+# avg_bw_imc: 6890
+# avg_bw_resc: 6888
 # Pass: Check MBA diff within 8% for schemata 100
 # avg_diff_per: 0%
-# avg_bw_imc: 6425
-# avg_bw_resc: 6399
+# avg_bw_imc: 6929
+# avg_bw_resc: 6951
 # Pass: Check schemata change using MBA
 ok 2 MBA: test
 # Starting CMT test ...
 # Mounting resctrl to "/sys/fs/resctrl"
 # Cache size :23068672
 # Writing benchmark parameters to resctrl FS
-# Benchmark PID: 5135
+# Benchmark PID: 4970
 # Checking for pass/fail
-# Fail: Check cache miss rate within 15%
-# Percent diff=24
+# Pass: Check cache miss rate within 15%
+# Percent diff=4
 # Number of bits: 5
-# Average LLC val: 7942963
+# Average LLC val: 10918297
 # Cache span (bytes): 10485760
-not ok 3 CMT: test
+ok 3 CMT: test
 # Starting L3_CAT test ...
 # Mounting resctrl to "/sys/fs/resctrl"
 # Cache size :23068672
 # Writing benchmark parameters to resctrl FS
 # Write schema "L3:0=1f0" to resctrl FS
 # Write schema "L3:0=f" to resctrl FS
 # Write schema "L3:0=1f8" to resctrl FS
 # Write schema "L3:0=7" to resctrl FS
 # Write schema "L3:0=1fc" to resctrl FS
 # Write schema "L3:0=3" to resctrl FS
 # Write schema "L3:0=1fe" to resctrl FS
 # Write schema "L3:0=1" to resctrl FS
 # Checking for pass/fail
 # Number of bits: 4
-# Average LLC val: 71434
+# Average LLC val: 70161
 # Cache span (lines): 131072
 # Pass: Check cache miss rate changed more than 2.0%
-# Percent diff=70.0
+# Percent diff=72.1
 # Number of bits: 3
-# Average LLC val: 121463
+# Average LLC val: 120755
 # Cache span (lines): 98304
 # Pass: Check cache miss rate changed more than 1.0%
-# Percent diff=40.8
+# Percent diff=42.5
 # Number of bits: 2
-# Average LLC val: 170978
+# Average LLC val: 172077
 # Cache span (lines): 65536
 # Pass: Check cache miss rate changed more than 0.0%
-# Percent diff=22.8
+# Percent diff=22.0
 # Number of bits: 1
-# Average LLC val: 209950
+# Average LLC val: 209893
 # Cache span (lines): 32768
 ok 4 L3_CAT: test
 # Starting L3_NONCONT_CAT test ...
 # Mounting resctrl to "/sys/fs/resctrl"
 # Write schema "L3:0=3f" to resctrl FS
 # Write schema "L3:0=787" to resctrl FS # write() failed : Invalid argument
 # Non-contiguous CBMs not supported and write of non-contiguous CBM failed as expected
 ok 5 L3_NONCONT_CAT: test
 # Starting L2_NONCONT_CAT test ...
 # Mounting resctrl to "/sys/fs/resctrl"
 ok 6 # SKIP Hardware does not support L2_NONCONT_CAT or L2_NONCONT_CAT is disabled
 # 1 skipped test(s) detected. Consider enabling relevant config options to improve coverage.
-# Totals: pass:4 fail:1 xfail:0 xpass:0 skip:1 error:0
+# Totals: pass:5 fail:0 xfail:0 xpass:0 skip:1 error:0

---


