Return-Path: <linux-kernel+bounces-859356-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F2EDBED5B9
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Oct 2025 19:35:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 90F2419A83FC
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Oct 2025 17:36:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B04B725A326;
	Sat, 18 Oct 2025 17:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="a+mwsc3d"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C39B259CAF
	for <linux-kernel@vger.kernel.org>; Sat, 18 Oct 2025 17:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760808914; cv=none; b=C19ZPnSUE4JrZUGIP2wGbvPhBxUG78viUxxSRzzoLDncPEcagg7qjDjxy+pSJbkblkI5VfnHABQNbCLUiAGcFXc2j7wRWGNmHcQgzlU0S3n/nhPT0RSVOYVNxo6Hi4ejZu0/I8nkariJMwQ4RiPaTyAb8j4oGJIPPdVAzLb6X5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760808914; c=relaxed/simple;
	bh=7GoRKt9iTOxF7lj6HUnvrwmRa1p1Dpt72Qt0aEln06c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=REazfcsog+6lfAQHY5DMekwGjSWpIkyXaZH+oPS6JJuz0tN3okOiOeEYYTDOaIpJxgBwDUv6nootVYuDixFFlwfGNdfKfBRz5e1oZ5ECLXrZAIn+GoxweoQ892DH4oLUoc9cp+1QugeFClMEfEZKfQ7d7aFGZyf1MPHxqpiG3I8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=a+mwsc3d; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760808912; x=1792344912;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=7GoRKt9iTOxF7lj6HUnvrwmRa1p1Dpt72Qt0aEln06c=;
  b=a+mwsc3dLt7B+I6JHKsUQhBBRgr95ZxBnacdeFbB74UwE8V23dLLn/b5
   iA5KphoZBpmtvnu+uHC/T0wWjWxPouAS7MHS04l27+bJ6vFvJHQ7yk3i0
   LQ9rXhgcYKb+ycq+Ii6pf+cCVC7QDl1C4ru5xbd67Ei3+Tn51LSCiDXUW
   W6ceWyK9xGzJDTFoB+pzyzQdmR/82W0mzW1wR/++SjQL8lUrQjfQX1IB2
   B7E7tTqEgVP3noWMBlE2+PnVFxKzguiupvZC1IyQnIbR8Jxtid4ZyNmP4
   v+DOHMlfqn3ONir9qatRe7/Uy+Zna6M5TI4fJcRBkMm87s7FHYI3P005M
   g==;
X-CSE-ConnectionGUID: nYpJmPa0R82y8mDUmKEw5Q==
X-CSE-MsgGUID: MhrazVKAQXSk5eLQcIAYyg==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="63039379"
X-IronPort-AV: E=Sophos;i="6.19,239,1754982000"; 
   d="scan'208";a="63039379"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2025 10:35:12 -0700
X-CSE-ConnectionGUID: brctu+d0TyCx1JRfys0O/g==
X-CSE-MsgGUID: RViUEOLZQtyQPMQg67UeqA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,239,1754982000"; 
   d="scan'208";a="213958875"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO ashevche-desk.local) ([10.245.244.194])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2025 10:35:11 -0700
Received: from andy by ashevche-desk with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1v8wfB-00000000Cts-0NEI;
	Wed, 15 Oct 2025 11:15:13 +0300
Date: Wed, 15 Oct 2025 11:15:12 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Michael Wu <michael@allwinnertech.com>
Cc: myungjoo.ham@samsung.com, cw00.choi@samsung.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] extcon: Fixed sysfs duplicate filename issue
Message-ID: <aO9YEOFkPz2IAyB6@smile.fi.intel.com>
References: <20251015065102.70422-1-michael@allwinnertech.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251015065102.70422-1-michael@allwinnertech.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Oct 15, 2025 at 02:51:02PM +0800, Michael Wu wrote:

Thank you for a fix, my comments below.

> With current extcon_dev_unregister() timing, ida_free is before
> device_unregister(), that may cause current id re-alloc to another
> device in extcon_dev_register() context but sysfs filename path not
> removal completed yet.
> 
> The right timing shows below:
> on extcon_dev_register: ida_alloc() -> device_register()
> on extcon_dev_unregister: device_unregister() -> ida_free()
> 
> stack information when an error occurs:
> sysfs: cannot create duplicate filename '/class/extcon/extcon1'
> Call trace:

>  dump_backtrace+0xe8/0x108
>  show_stack+0x18/0x28
>  dump_stack_lvl+0x50/0x6c
>  dump_stack+0x18/0x24

At least these four lines are noisy in the commit message. The Submitting
Patches documentation recommends to leave ~3-5 important lines out of a trace
back, so the below is okay in my opinion, except the last line also can be
dropped (devm call).

>  sysfs_warn_dup+0x68/0x88
>  sysfs_do_create_link_sd+0x94/0xdc
>  sysfs_create_link+0x30/0x48
>  device_add_class_symlinks+0xb4/0x12c
>  device_add+0x1e0/0x48c
>  device_register+0x20/0x34
>  extcon_dev_register+0x3b8/0x5c4
>  devm_extcon_dev_register+0x4c/0x94

> Fixes: 7bba9e81a6fb ("extcon: Use unique number for the extcon device ID")
> Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Better to reduce a noise in the Git history by moving the Cc:s to the...

> Acked-by: MyungJoo Ham <myungjoo.ham@samsung.com>
> Signed-off-by: Michael Wu <michael@allwinnertech.com>
> ---

...comment block here. It will have the same effect on the emails (tools will
Cc people listed here).

> ChangeLog:
> V1 -> V2: Update commit msg, suggested by Markus Elfring
> V1: https://lore.kernel.org/all/20251011053719.87055-1-michael@allwinnertech.com/

Code wise LGTM, FWIW,
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

-- 
With Best Regards,
Andy Shevchenko



