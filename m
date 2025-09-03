Return-Path: <linux-kernel+bounces-798504-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3609B41EF1
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 14:29:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 687F57A7878
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 12:27:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A54A2FD1D5;
	Wed,  3 Sep 2025 12:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CBTchwAx"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 296652820A5
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 12:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756902551; cv=none; b=H/OOubDrcmm/bcGBr8IrmGOlINfXOS6zormDWqca8EbbQbSFLmJKOeoe4JGIe1uH19NN7go1b/CCsbEZ0nRd8KjWGuuybJJb+gWvB/y3YvbEFkyyX4Ff+05NSINf7knQOzt6qk7SDzrRUkqxBq/Lt76i99Jg/oVfVI/BaDBFs0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756902551; c=relaxed/simple;
	bh=3MslW1TQTdkb15i2DyG6dw6gdg010FfcwYihUpsLW78=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=LlbFf/IDqu6W968chnRWZzrBTvYBU2XUbNIhs+KLBmIUH8Ch20PSS26HPKU0DQAxfK/Ww/c4+oT2duAiJ0ubNlIGu6YU59nNbiFddXL8bUyokZBWvrlwtaCCGTrUPAGm5jkCaCl8q45DYI77Daez3l6g3VyWs2I+lfgz4Ot9I74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CBTchwAx; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756902550; x=1788438550;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=3MslW1TQTdkb15i2DyG6dw6gdg010FfcwYihUpsLW78=;
  b=CBTchwAxcPr18KTvA0wseqmouJ9mvA3MxLGRbW0jGUsp6qSVU2KF3XW5
   Msz3wEvbLiJc3Fop2d2OHOVy+uzcyjKsxpNGXZCddUJBRk5izvIeqXD0q
   FL3HM/hXFNAWu5yEECMekhZv52LWXMagN6Vd0UBIVGg07mmgQgo7V3k8g
   T1l0HgatYg1xOhoXcig8IKnRe+nUekOpEOvrrQMSQBbn9cPZQ/LwlZ+lq
   IJQpuDkrFePte5I0ZQF6yzzhHMLYOlD+tHO+hzYt1vz3IqChB7XLT9n05
   oZKEQwWBmuvxdAZAbLdszSTvs7pqkHryRg7hjVZei4Xty8LX+pZM+gLyx
   w==;
X-CSE-ConnectionGUID: WXswawABSzCbctvQ72b7yA==
X-CSE-MsgGUID: I+yXyDtoRQuWXxHOmWH8Rw==
X-IronPort-AV: E=McAfee;i="6800,10657,11541"; a="58245228"
X-IronPort-AV: E=Sophos;i="6.18,235,1751266800"; 
   d="scan'208";a="58245228"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2025 05:29:09 -0700
X-CSE-ConnectionGUID: EQ/QTFMDQVmPp89E+lc64w==
X-CSE-MsgGUID: PCGphcd1REe+hdBO1Ab9ow==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,235,1751266800"; 
   d="scan'208";a="171457823"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.1])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2025 05:29:05 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Wed, 3 Sep 2025 15:29:00 +0300 (EEST)
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
cc: LKML <linux-kernel@vger.kernel.org>, Peter Tyser <ptyser@xes-inc.com>, 
    Lee Jones <lee@kernel.org>
Subject: Re: [PATCH v1 1/2] resource: Introduce resource_rebase() helper
In-Reply-To: <20250903081414.1972179-2-andriy.shevchenko@linux.intel.com>
Message-ID: <e1d7bc7c-6862-919c-a637-bfabce591b62@linux.intel.com>
References: <20250903081414.1972179-1-andriy.shevchenko@linux.intel.com> <20250903081414.1972179-2-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Wed, 3 Sep 2025, Andy Shevchenko wrote:

> Introduce a helper to add an offset to the resource. This is helpful
> in the cases when, for example) the resource has statically defined
> the start and end fields, but the base of it is yet to be defined,
> usually dynamically at run-time.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  include/linux/ioport.h | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/include/linux/ioport.h b/include/linux/ioport.h
> index e8b2d6aa4013..159e74284d0b 100644
> --- a/include/linux/ioport.h
> +++ b/include/linux/ioport.h
> @@ -290,6 +290,12 @@ static inline resource_size_t resource_size(const struct resource *res)
>  {
>  	return res->end - res->start + 1;
>  }
> +
> +static inline void resource_rebase(struct resource *res, resource_size_t start)
> +{
> +	resource_set_range(res, start + res->start, resource_size(res));
> +}

Hi Andy,

This seems fine, it's nice to get rid of complex ->end calculations. But I 
wanted to mention another common case which is resetting the base to zero.
Are we expected to use resource_rebase() for those cases too? I've been 
thinking of adding something like resource_reset().

resource_rebase(res, 0) would work for those cases but it doesn't then  
carry the intent of "removing" the base in its name. Opinions?

-- 
 i.


