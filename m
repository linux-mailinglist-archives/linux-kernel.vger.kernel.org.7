Return-Path: <linux-kernel+bounces-869179-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id AE526C07363
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 18:11:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 0DDA6357917
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 16:11:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 741CF334C36;
	Fri, 24 Oct 2025 16:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jIEwRjH+"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D3EB333734
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 16:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761322310; cv=none; b=oKIZMD1IY3tfgxRquQ9nLceiEI3iWvplopfFkQ69cuSQKYYF79x/QehtMsSU4bPpPQLOjODj5GFFNDWhr/7sjYIhSDJ6u1M9hYneWhtVMYjB8usC0EypzlyRCRDgnIcmRHhKPC+cyLeasMB3b9kTUPkbuBxMosMeQ/QE5SE5sKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761322310; c=relaxed/simple;
	bh=Cdf1mdpqaNF51DoBBi08RcZl6BuFJVBAXpPJ/HrYSKE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Py1dml0tWjUYDp0AsIqVGkOGxH2DlEGiWjk1UodPBS2CuG9mDPnQyCVuz9XzuTse0oVZPUGzk100o1YpbnNgV5ukzTA3UVFAfY/Ay6AvCI0PR/xHjMXVWl5Yxn0GCViaJAOWc0F0iUsV0lfq3W9nFQ4Ws9JOw0HprpHmfmT9t3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jIEwRjH+; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761322309; x=1792858309;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Cdf1mdpqaNF51DoBBi08RcZl6BuFJVBAXpPJ/HrYSKE=;
  b=jIEwRjH+jdX4i/vtCajQgCVBHcVsTz1Uc+NyG8SQKolfqa03ZPzCgHBu
   qkuTRAL2aS6/CdjYQFFYJRhy6MghxPNp/b+vRp6ORPnfBEJB5+Fo8xTZ7
   9TuIn+/bXhP6I0OVNsb53qQFW9HrM8sSbXYClLDI6kRlsiLJLcvwvLFuk
   1T4KfI9iCaU4r8kVbO9IX1SQl7HbS5EIf0gbADFhUcO8T7A4MF7L0c2Wo
   Kz/KWh7Vm7IIW3WuTDoReEN5WOuDECmSI9/FnUk75xM5ej28MvVM2nE94
   8SKSWnbEhMirVJCCVnIWEV5sbsuSNDuTms1PYLe3Ym/7+xZS6Odgg/sYg
   w==;
X-CSE-ConnectionGUID: 8pmE1V+oQ7mXT5PFqHptGA==
X-CSE-MsgGUID: kxcF7X23QDiU2A2z5JfESA==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="63406518"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="63406518"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2025 09:11:48 -0700
X-CSE-ConnectionGUID: vjq1QJOaQoG0LB/9jg/uWQ==
X-CSE-MsgGUID: J7fd/chjRgyCO/V7eqJl4w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,252,1754982000"; 
   d="scan'208";a="188526851"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa003.jf.intel.com with ESMTP; 24 Oct 2025 09:11:44 -0700
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id BFC7695; Fri, 24 Oct 2025 18:11:43 +0200 (CEST)
Date: Fri, 24 Oct 2025 18:11:43 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Justinien Bouron <jbouron@amazon.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Baoquan He <bhe@redhat.com>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	Petr Mladek <pmladek@suse.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Marcos Paulo de Souza <mpdesouza@suse.com>,
	Steven Chen <chenste@linux.microsoft.com>,
	Yan Zhao <yan.y.zhao@intel.com>, Alexander Graf <graf@amazon.com>,
	kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
	Gunnar Kudrjavets <gunnarku@amazon.com>
Subject: Re: [PATCH v3] kexec_core: Remove superfluous page offset handling
 in segment loading
Message-ID: <aPulPxKvWiCQcKz5@black.igk.intel.com>
References: <20251024155009.39502-1-jbouron@amazon.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251024155009.39502-1-jbouron@amazon.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Fri, Oct 24, 2025 at 08:50:09AM -0700, Justinien Bouron wrote:
> During kexec_segment loading, when copying the content of the segment
> (i.e. kexec_segment::kbuf or kexec_segment::buf) to its associated
> pages, kimage_load_{cma,normal,crash}_segment handle the case where the
> physical address of the segment is not page aligned, e.g. in
> kimage_load_normal_segment:
> ```
> 	page = kimage_alloc_page(image, GFP_HIGHUSER, maddr);
> 	// ...
> 	ptr = kmap_local_page(page);
> 	// ...
> 	ptr += maddr & ~PAGE_MASK;
> 	mchunk = min_t(size_t, mbytes,
> 		PAGE_SIZE - (maddr & ~PAGE_MASK));
> 	// ^^^^ Non page-aligned segments handled here ^^^
> 	// ...
> 	if (image->file_mode)
> 		memcpy(ptr, kbuf, uchunk);
> 	else
> 		result = copy_from_user(ptr, buf, uchunk);
> ```
> (similar logic is present in kimage_load_{cma,crash}_segment).
> 
> This is actually not needed because, prior to their loading, all
> kexec_segments first go through a vetting step in
> `sanity_check_segment_list`, which rejects any segment that is not
> page-aligned:
> ```
> 	for (i = 0; i < nr_segments; i++) {
> 		unsigned long mstart, mend;
> 		mstart = image->segment[i].mem;
> 		mend   = mstart + image->segment[i].memsz;
> 		// ...
> 		if ((mstart & ~PAGE_MASK) || (mend & ~PAGE_MASK))
> 			return -EADDRNOTAVAIL;
> 		// ...
> 	}
> ```
> In case `sanity_check_segment_list` finds a non-page aligned the whole
> kexec load is aborted and no segment is loaded.
> 
> This means that `kimage_load_{cma,normal,crash}_segment` never actually
> have to handle non page-aligned segments and `(maddr & ~PAGE_MASK) == 0`
> is always true no matter if the segment is coming from a file (i.e.
> `kexec_file_load` syscall), from a user-space buffer (i.e. `kexec_load`
> syscall) or created by the kernel through `kexec_add_buffer`. In the
> latter case, `kexec_add_buffer` actually enforces the page alignment:
> ```
> 	/* Ensure minimum alignment needed for segments. */
> 	kbuf->memsz = ALIGN(kbuf->memsz, PAGE_SIZE);
> 	kbuf->buf_align = max(kbuf->buf_align, PAGE_SIZE);
> ```

> Signed-off-by: Justinien Bouron <jbouron@amazon.com>
> Reviewed-by: Gunnar Kudrjavets <gunnarku@amazon.com>
> ---
> Changes since v1:
> 	- Reworked commit message as requested by Baoquan He
> 	  <bhe@redhat.com>
> 	- Removed accidental whitespace change
> 	- v1 Link: https://lore.kernel.org/lkml/20250910163116.49148-1-jbouron@amazon.com/
> 
> Changes since v2:
> 	- Removed unused variable in kimage_load_cma_segment() which was
> 	  causing a warning and failing build with `make W=1`. Thanks
> 	  Andy Shevchenko for finding this issue
> 	- v2 Link: https://lore.kernel.org/lkml/20250929160220.47616-1-jbouron@amazon.com/

At least this has the leftovers being removed, thanks!
FWIW,

Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

-- 
With Best Regards,
Andy Shevchenko



