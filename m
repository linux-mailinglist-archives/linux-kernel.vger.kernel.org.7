Return-Path: <linux-kernel+bounces-761066-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD753B1F3E5
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Aug 2025 11:57:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E79F3ABED1
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Aug 2025 09:57:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D79352522A7;
	Sat,  9 Aug 2025 09:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UqIxV+s8"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E488D17578;
	Sat,  9 Aug 2025 09:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754733429; cv=none; b=SdkRG9Tj7bPdj1Y/6Z2pYi5NY5Dtx6Bqo8cszXRdpsq+W85ZFocnJgPbBwz56WMw/H0wct+tGUT7YAgpJ1T5FAKhbgXw7ozZQcbPMDKvkpUQTV5V1Hwrbo6pfQ8gnoZ+MRxyeUXoppKfTbf845ohbfFBbRsS6l+8T5ukzlpM9qI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754733429; c=relaxed/simple;
	bh=KfTztYwi+6LcMDwbkjWdx4AqDgBS3a+xN/DjCueFpvY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SMMOU28BQAB/O1l4+OnFZWxn4SEsv1xQ1qwvul/Xirhurqoq3ZvkB9wSCOgF1A0m9yUoy22p7Fohf7HzWWFMIUMXadntWbpvjITmbKgRWag+AkuFtr6RRK5gHOT2RVLsB7UfQ6cpKdQf4asi/uwzN4SnUUmWryIjL3rdO8FJ8ak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UqIxV+s8; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754733428; x=1786269428;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=KfTztYwi+6LcMDwbkjWdx4AqDgBS3a+xN/DjCueFpvY=;
  b=UqIxV+s8RhXLt590kwJ48FRSbLAs1zZB4/tMveq2oPlOwU1QNbmtRe1A
   9zR73XIesDSOh6FegKfi5eHdHRL6V9HakVPdSs4Sqv1FEJp5K5yfM/k19
   P7a3qsz//FMZdjSqHw0FNsRvbTfTJV5CwP4cBqXWBaNCwNSSxsOp5l5/J
   vYK9FEl/GcSe3Gq5HGRgwWKVhi5eD/mjpuCbHEkBVlbtWFycpip5PokRC
   fBR1rxkjAXDysHNEswEd4zqW69rjdimA/7B/hPx9Hl4aWUTUacrcmwOFd
   C0ghDTgVT3DIta/ZUd5i9zwnqVr+9qV59B9JQzQ4HO1cYMFY9ysITi6Hq
   w==;
X-CSE-ConnectionGUID: se6hIRjwRgirL74RiSYqmg==
X-CSE-MsgGUID: FzDQx1URTdaYr0dp0qUV6w==
X-IronPort-AV: E=McAfee;i="6800,10657,11515"; a="56778701"
X-IronPort-AV: E=Sophos;i="6.17,278,1747724400"; 
   d="scan'208";a="56778701"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2025 02:57:07 -0700
X-CSE-ConnectionGUID: hr6wK5rpTma0p2tr7gdwng==
X-CSE-MsgGUID: y132Wk96TECBew8t+w0+sg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,278,1747724400"; 
   d="scan'208";a="169957051"
Received: from smile.fi.intel.com ([10.237.72.52])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2025 02:57:06 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1ukgJy-00000004cbt-0lsQ;
	Sat, 09 Aug 2025 12:57:02 +0300
Date: Sat, 9 Aug 2025 12:57:01 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Petr Mladek <pmladek@suse.com>, Steven Rostedt <rostedt@goodmis.org>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Documentation/printf: Use literal fwnode_handle
Message-ID: <aJcbbb4OVK_q2VkU@smile.fi.intel.com>
References: <07262c55e82fc4a3e3dbe7c45713b14955271e7f.1754552156.git.geert+renesas@glider.be>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <07262c55e82fc4a3e3dbe7c45713b14955271e7f.1754552156.git.geert+renesas@glider.be>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Aug 07, 2025 at 09:36:01AM +0200, Geert Uytterhoeven wrote:
> When looking for fwnode_handle in the printk format documentation, it is
> only found in the Chinese translation:
> 
>     $ git grep fwnode_handle -- Documentation/*printk-formats.rst
>     Documentation/translations/zh_CN/core-api/printk-formats.rst:用于打印fwnode_handles的消息。默认情况下是打印完整的节点名称，包括路径。
> 
> This happens because the original documentation talks about "fwnode
> handles", without mentioning the actual type name.

Fixes?

Anyway, LGTM,
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

-- 
With Best Regards,
Andy Shevchenko



