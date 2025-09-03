Return-Path: <linux-kernel+bounces-798273-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 708E1B41B89
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 12:18:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 43DCD169A47
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 10:18:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 005432E2EF5;
	Wed,  3 Sep 2025 10:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PlNXRqt9"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B20527056A
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 10:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756894705; cv=none; b=GPO0+kNnMVZWiaJIVCJ37OTpURHB/nDC92Q7nLM28shmzkpiCFqahtC9L/1XF3Ohxj2Ko2CrnQ9PJ6QQjOZvi5GOzJVR5e0xbudvY80jWghnik35S7vm55RsI+3lyTyb76qTpJ2gnszsHID8WYAVJVNNr5L18PvkShuHlgvhD4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756894705; c=relaxed/simple;
	bh=FJkdxpi5/exkuxIE7YtNT/k9qbxv87EQuc/qReQvjQs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nOGUri67kbwSanqo7W72TWGJ5ECqL6f1EPbfflhv1iX9Kk0lJAkBluz5BJmlgnfdc4Ewn7UIotqCtbg/Wv4G0pF6qkmvXCPZeWjsboEnoDnQOxbmmyshz2Cjsmm+lxBx0GX38zkQ/H6NwXV4K7C69Hf5nKTbj30YrhP6LD6zFJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PlNXRqt9; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756894703; x=1788430703;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=FJkdxpi5/exkuxIE7YtNT/k9qbxv87EQuc/qReQvjQs=;
  b=PlNXRqt92P3JyMRscJNO+hsX9j7NUWvAB3e1k2WVBh8jLXAhLjW+1WC0
   +ExKKTA5IOKwvnBc4oi5P+Qw4jIywRes7LD0cmdH6zldaQ5EX1hb7NtYM
   nZNjJh8ZpmCMjkkMsLHj4u+UGEgV/NqkGp2mGgK4buWzzZhRx2uqKdQD6
   ur9YVhiTLxD2ep/prVXTCBFYkABEZkWu3uo24ybRESe4oA9HXTuQICEJt
   noXQl8CRbqKWm8crnGNNkf6DTzML6Zzy1iI1Qwfh97Xjhk8mQhUBF7UPA
   2em3DhbmQ6WO+Fou3eJlO5pB7557ib+cStjjj1HRVXEj3moFhwlEw7bot
   w==;
X-CSE-ConnectionGUID: +31xs5x0QuKMkweXEI+/Tg==
X-CSE-MsgGUID: tPdmT2WmTNGSSw9aD9bKKw==
X-IronPort-AV: E=McAfee;i="6800,10657,11541"; a="59058064"
X-IronPort-AV: E=Sophos;i="6.18,233,1751266800"; 
   d="scan'208";a="59058064"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2025 03:18:23 -0700
X-CSE-ConnectionGUID: 85baaDvxTn6pbW57nAJWYg==
X-CSE-MsgGUID: 0GgCYpxGTPCsYUXPX7gqXg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,233,1751266800"; 
   d="scan'208";a="172366202"
Received: from smile.fi.intel.com ([10.237.72.52])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2025 03:18:21 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1utkZG-0000000AxCf-3sIt;
	Wed, 03 Sep 2025 13:18:18 +0300
Date: Wed, 3 Sep 2025 13:18:18 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: =?iso-8859-1?Q?Jean-Fran=E7ois?= Lessard <jefflessard3@gmail.com>
Cc: Andy Shevchenko <andy@kernel.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/5] auxdisplay: linedisp: support attribute attachment
 to auxdisplay devices
Message-ID: <aLgV6lcxvs5JLUdk@smile.fi.intel.com>
References: <20250901020033.60196-1-jefflessard3@gmail.com>
 <20250901020033.60196-5-jefflessard3@gmail.com>
 <aLbEcN44RT58ywzq@smile.fi.intel.com>
 <9223FFA5-2B0F-4A74-AFE2-CB7C9703CFAB@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9223FFA5-2B0F-4A74-AFE2-CB7C9703CFAB@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Sep 02, 2025 at 01:37:52PM -0400, Jean-François Lessard wrote:
> Le 2 septembre 2025 06 h 18 min 24 s HAE, Andy Shevchenko <andriy.shevchenko@intel.com> a écrit :
> >On Sun, Aug 31, 2025 at 10:00:28PM -0400, Jean-François Lessard wrote:

...

> >> +static DEFINE_SPINLOCK(linedisp_attachments_lock);
> >
> >Why spin lock and not mutex?
> 
> The attachment list operations are extremely lightweight (just adding/removing
> list entries), making spinlock the optimal choice because:
> - Very short critical sections: Only list traversal and pointer assignments;
>   avoids context switching overhead for brief operations
> - No sleeping operations: No memory allocation or I/O within locked sections
> - Future-proof atomic context safety: Can be safely called from interrupt
>   handlers if needed

To me it sounds like solving non-existing problem. I am sure we will see no
driver that tries to call this API in an atomic context.

-- 
With Best Regards,
Andy Shevchenko



