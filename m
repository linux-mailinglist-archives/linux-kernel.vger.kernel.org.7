Return-Path: <linux-kernel+bounces-810007-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 022FEB5148F
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 12:54:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2FC731B2051B
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 10:54:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9AC43126DA;
	Wed, 10 Sep 2025 10:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kbu+gJtU"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF03C303A1A;
	Wed, 10 Sep 2025 10:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757501656; cv=none; b=YV0hhk4CKcYw2RF46LSxSCGcG4Bn7/U+CvvxqIARGGKV080OFlg80x0OOTv6L4SC8flEjWhWVmhlkqMjUDPwibxBj4ywo+77DjZMtn+ZKUvUWPXI8I9gmJIKijHOujO6iDUdwtggV3yLaVJHHW0xY4P1W0YNiGBU6GZ5qKQO+ZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757501656; c=relaxed/simple;
	bh=AcyUcFaxXzjSHC3sR+EMGV3sR47MnuEgabNIEIn/ym4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=fYjNJSXWxLQCpTDE9JqFmRct9RvX6IVMGHdHAN8QM8ADQbWufEX4xq1TRMqpNhydeRIEtTES/VKuZ/TANpd9WFqMdMluawf/bjD5Qf+wg1VClMnZS7TMsZ2t7mMDEatU8McSsKvS5RzSbnx/SMVHjdaQBiGUcWww8n6sPUXuqjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kbu+gJtU; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757501655; x=1789037655;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=AcyUcFaxXzjSHC3sR+EMGV3sR47MnuEgabNIEIn/ym4=;
  b=kbu+gJtUyL/3AnVD4FgdP2Dq0ciWtdHhYpOmAuhEqzqy9Ws8iMccVz+p
   KBZPvTF8I1yJcTh8xBL3tgXS7dMtrG0E+ocbpIhmDeBFZ20IeklJneRVP
   xOjzsJAiE+LeGZ9omAKajYbbbwGeSL8/i+GYzJz/hUm4236q1B/HAY2hC
   RSGxvfWcespM3j1iY8H4TlIkBCgLdZQUX5A77AxfYy43fhcuzgr7/rQUQ
   ENeEQl5rokY38+G1fl7Cdzu2BPSM675jpAZVxH+hKFx92PSV1/7+Fodt1
   vQP0t40Jc1IHQ+Mceidxj7nYXg6BEVu2DROZyuMOIJ9Pz8nUx5pfZ7Mzk
   w==;
X-CSE-ConnectionGUID: mShK+J40TACUkU9PZixkOw==
X-CSE-MsgGUID: VP8eviKcSC+wrjvX6rk++w==
X-IronPort-AV: E=McAfee;i="6800,10657,11548"; a="59914886"
X-IronPort-AV: E=Sophos;i="6.18,254,1751266800"; 
   d="scan'208";a="59914886"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2025 03:54:13 -0700
X-CSE-ConnectionGUID: jxDKXNUDRlKtnC8BmAPr8g==
X-CSE-MsgGUID: ScYaLDjDSDyhIEjrJDIy5g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,254,1751266800"; 
   d="scan'208";a="173194608"
Received: from mjarzebo-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.246.72])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2025 03:54:10 -0700
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, Jonathan Corbet
 <corbet@lwn.net>, Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, Mauro Carvalho Chehab
 <mchehab+huawei@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 12/19] docs: Makefile: document latex/PDF PAPER=
 parameter
In-Reply-To: <52411bce7bf0d068bfc8e33b35db3259c3ae0c64.1756969623.git.mchehab+huawei@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <cover.1756969623.git.mchehab+huawei@kernel.org>
 <52411bce7bf0d068bfc8e33b35db3259c3ae0c64.1756969623.git.mchehab+huawei@kernel.org>
Date: Wed, 10 Sep 2025 13:54:07 +0300
Message-ID: <d20b612ee510c65dcd60183eda5068b164294759@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, 04 Sep 2025, Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:
> While the build system supports this for a long time, this was
> never documented. Add a documentation for it.
>
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> ---
>  Documentation/Makefile | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/Documentation/Makefile b/Documentation/Makefile
> index 4736f02b6c9e..0e1d8657a5cc 100644
> --- a/Documentation/Makefile
> +++ b/Documentation/Makefile
> @@ -126,4 +126,6 @@ dochelp:
>  	@echo
>  	@echo  '  make DOCS_CSS={a .css file} adds a DOCS_CSS override file for html/epub output.'
>  	@echo
> +	@echo  '  make PAPER={a4|letter} Specifies the paper size used for LaTeX/PDF output.'
> +	@echo
>  	@echo  '  Default location for the generated documents is Documentation/output'

The Sphinx make mode 'sphinx-build -M help' provides all of this and
more...

BR,
Jani.


-- 
Jani Nikula, Intel

