Return-Path: <linux-kernel+bounces-800234-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 52ABBB434F6
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 10:09:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9EA3F3B6254
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 08:08:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5459C2BFC9D;
	Thu,  4 Sep 2025 08:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SAUscH97"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BB4B2BF3CC
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 08:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756973328; cv=none; b=rxhD73XlK7yQDbhsXCG//MjN2u96Gbza2uEgjmL42akizbvgfOOkSWmxMJ5niolQ/KXgjvU/bjvEj5PQqyLHajJT1rrA+tMT2aZv5+3z1i6dA2R9heLYUI4EdDoW0ucp/mlojEG0YtDzqrs2v4ZRHPIW5Qa4biYcJu6LG1SUsfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756973328; c=relaxed/simple;
	bh=D5/uCG0kH3sTiEMP/8vh8oyfqVnBuKNNC2AFU/Q2BvY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lftSRWw885L1+vUBMRv+LOS8wMdI6Z++jww8KZc7RNgO0NEQ39Jf/hHPuS7B52SBpoQwtIzXxjy7H5YOMgtYd3Au2TmNliKUwb/UP8ScDGNkYWYzN0nVvi8HoxXkjHEdMZJobcL542s9/11OnrmrKjywZuJp+9F7EM4tAzLuTL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SAUscH97; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756973327; x=1788509327;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=D5/uCG0kH3sTiEMP/8vh8oyfqVnBuKNNC2AFU/Q2BvY=;
  b=SAUscH97lo6KBJazjUblo3PsWV0OG6iKOc0sfsjRiglvItHidkkGwCwS
   J+IP+khhHJotCIefFmKFSyt2gy1NRPVrV6bvRpdeggKZ9mjvGhGSriqnf
   c7E01wlEiUgxGpCihgYRiYa9c2qYSYAjXvjhyZ0AYcH8LhMx8rlh8RkOi
   No6xjOM1qthhCWGvW8Pn14rwGlBjN7AvcYXAK0RtTJp07jXkxh7JDJEu7
   Cq2gmw3GHyEMbbhx8IcP2wnB6WHL0fAQDNxYZPWt9omHr7kefcJ5P6895
   Q6dxE2CkvtNkpDdDP5HqQvmV4rNIALiS1aH1FSE1RPNR8lpNTxcJUCsXJ
   A==;
X-CSE-ConnectionGUID: gVjA2z06Q3u1exgu5Az/Yw==
X-CSE-MsgGUID: qWEfbvDNRGCYjVr9a0B4QQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11542"; a="58338542"
X-IronPort-AV: E=Sophos;i="6.18,237,1751266800"; 
   d="scan'208";a="58338542"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2025 01:08:46 -0700
X-CSE-ConnectionGUID: rSv7HPYTTee6cW4vAcXV8A==
X-CSE-MsgGUID: iWUfZIESRIOfnhTfvp/EPg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,237,1751266800"; 
   d="scan'208";a="177090569"
Received: from smile.fi.intel.com ([10.237.72.52])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2025 01:08:46 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1uu51O-0000000BCnn-3mKJ;
	Thu, 04 Sep 2025 11:08:42 +0300
Date: Thu, 4 Sep 2025 11:08:42 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	linux-kernel@vger.kernel.org
Cc: Peter Tyser <ptyser@xes-inc.com>, Lee Jones <lee@kernel.org>
Subject: Re: [PATCH v1 0/2] mfd: lpc_ich: Simplify GPIO resource handling
Message-ID: <aLlJCquzCONTPUuG@smile.fi.intel.com>
References: <20250903081414.1972179-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250903081414.1972179-1-andriy.shevchenko@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Sep 03, 2025 at 10:12:27AM +0200, Andy Shevchenko wrote:
> Introduce a helper to iopoll.h which allows to simplify GPIO resource handling
> in lpc_ich driver for the starter. The helper can be used in many other cases.

After thinking a bit, this series is no go as it will regress on module unbind-bind
and I have no clear view right now how to avoid that. So self-NAK.

-- 
With Best Regards,
Andy Shevchenko



