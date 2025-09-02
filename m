Return-Path: <linux-kernel+bounces-796200-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CE5F2B3FD3E
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 13:00:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A61F520818A
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 11:00:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B83FB28505D;
	Tue,  2 Sep 2025 11:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RjYJClFu"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B539538DF9
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 11:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756810841; cv=none; b=gDzuVinHvclI0kkD3jf25fGua2gSNpz01uEIYU0xlZOFGYxXsNWsB0cC1WxVjIrBT22aEHaIguets857Bti8QYK19aQHqOA30NLJOBdiMMacC0WOZYy+vou2udDNNPLXZKVRKUIOQSpXTwOuHgLRC+Ch5Kku7zXHbwIxqov0v1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756810841; c=relaxed/simple;
	bh=iPelAYrx55aXRVDj/7ui89ZDpKqBmVh93bFFvxfYFWM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ts6KbjEDBUDcgKjiAqBbKFHR9pKOah5nZUSxOzRjAF+Xb9m+hr/wAiIjhaFKl9CeKpYKF4RCJiFApdXbwa6rwzsyRTmt662LKt/u9yk89MeZ854gK9BJ1KUdSAG31F1hlmNeYI/68Ph5/PzSNa0VcRHvIOEu4eytyjltu2m2iCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RjYJClFu; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756810840; x=1788346840;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=iPelAYrx55aXRVDj/7ui89ZDpKqBmVh93bFFvxfYFWM=;
  b=RjYJClFuIjUAZYVyOdHhK0YuqFxqZbXCfFuDBuaZ0zkbn6wOaKNctDDz
   w0/zru8N9qQA/qGjLcrYf5VmbynNvZJUHZikdz4iPO3Kr0BDAeyGV2X4Q
   MeZjWXiOJ+yB4lFmOzV+DPxZskseASlIo/p7xotSf2t99XJ7t1gYVl9Uk
   5hl+N6T/CstPgroBJvjD3QfXsf1eJ4GrSvbjQSYUxKZ2MYHnz5UpvoOWq
   7I4SeK7js7CRHCla2XvwR+nTDo6S6xrLdqPD9B3lbneooxDgLeFcTDoYf
   BcwFgvMKbM9B3huiiXqfo1LcCd5VOJYJ5bwpeg00XuzpL7K3+6I1uR7S6
   A==;
X-CSE-ConnectionGUID: 1wCRwybkR3uVkdWMnEXVkg==
X-CSE-MsgGUID: Ewzy94SIRBaJ4siQcww7sQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11540"; a="69788201"
X-IronPort-AV: E=Sophos;i="6.18,230,1751266800"; 
   d="scan'208";a="69788201"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2025 04:00:39 -0700
X-CSE-ConnectionGUID: 7RFKmv4jQ2a7AmYqkmw9ew==
X-CSE-MsgGUID: canpEoE6S6CEH4CiEpTkYw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,230,1751266800"; 
   d="scan'208";a="194887048"
Received: from smile.fi.intel.com ([10.237.72.52])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2025 04:00:38 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1utOkd-0000000Afri-2bQB;
	Tue, 02 Sep 2025 14:00:35 +0300
Date: Tue, 2 Sep 2025 14:00:35 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: =?iso-8859-1?Q?Jean-Fran=E7ois?= Lessard <jefflessard3@gmail.com>
Cc: Andy Shevchenko <andy@kernel.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/5] auxdisplay: linedisp: support attribute attachment
 to auxdisplay devices
Message-ID: <aLbOU0vIXX22uVvf@smile.fi.intel.com>
References: <20250901020033.60196-1-jefflessard3@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250901020033.60196-1-jefflessard3@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sun, Aug 31, 2025 at 10:00:24PM -0400, Jean-François Lessard wrote:
> This series modernizes the auxdisplay line display (linedisp) library to
> enable seamless integration with auxdisplay parent devices while
> maintaining backward compatibility.
> 
> The key improvement is adding attach/detach APIs that allow linedisp sysfs
> attributes to be bound directly to their parent auxdisplay devices avoiding
> child device proliferation and enabling a uniform 7-segment userspace
> interface across different driver architectures.
> 
> This series introduces attachment infrastructure for linedisp devices.
> The first consumer of this API will be the TM16XX driver series.
> See the related patch series:
>   auxdisplay: Add TM16xx 7-segment LED matrix display controllers driver
> 
> Changes include:
> 1. Encapsulate container_of() usage with to_linedisp() helper function for
>    cleaner context retrieval
> 2. Improve message display behavior with static padding when message length
>    is smaller than display width
> 3. Add 'num_chars' read-only attribute for userspace capability discovery
> 4. Add attach/detach API for sysfs attributes binding to parent devices
> 5. Document all linedisp sysfs attributes in ABI documentation
> 
> All existing linedisp_register() users remain unaffected. The new APIs
> enable drivers like TM16XX to integrate 7-segment functionality within
> their LED class device hierarchy while providing a uniform 7-segment API.
> 
> Thanks to Andy Shevchenko for early feedback and guidance.

Overall LGTM, only one question about spin lock vs. mutex. The rest is simple
nit-picks. I'll also wait for Geert's review / Acks.

-- 
With Best Regards,
Andy Shevchenko



