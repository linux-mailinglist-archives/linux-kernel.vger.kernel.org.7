Return-Path: <linux-kernel+bounces-761834-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B499B1FEFA
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 08:08:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2C04A7ABA3E
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 06:06:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E5C727AC28;
	Mon, 11 Aug 2025 06:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="E9Gkvv1D"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 297BB26D4F9;
	Mon, 11 Aug 2025 06:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754892488; cv=none; b=X3EU0/c/REkb7KuxQ7V+r7LR+HCIDQ4ul0+0c3EP7oCn+zz/Ueb1/3YSrb5RpC8ApOMapCb7lF+fQLaOxvAZ+OdEl5MdzY8FFFLppaSjDozhObkvZYKY58xj5ncf8+dgI0e/9sZL0ufo71CTeC9FM5VXd6DFlO+Bzj8OfpoqhSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754892488; c=relaxed/simple;
	bh=pMDIeN6cHQc15CumEtak7l0KHpV6zdNtQEXaloLZQco=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d51k9rKnnnwrLFd5LO+7sVtNqvEz4Gg/gd1ogx+cXzqW7+EWt33FmLfozMCjslVx9p8sWct1QUTQzj/olEG75ZJUYIvH9go0cKvlNm/2nXuoRlcudgXi3HQb6XeKH+dJ4tQAjEXkckYZMamCPT5k5L8iPXvOsDrXYCsXDM+LaMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=E9Gkvv1D; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754892487; x=1786428487;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=pMDIeN6cHQc15CumEtak7l0KHpV6zdNtQEXaloLZQco=;
  b=E9Gkvv1D3x8neHAeU8AUBO4aWgeE1ds5OaHmcmJc8jioPh8bzNlX0RgN
   eXhYBWe4lJkmSoXfPT8FQI9wCVn1psPOiElFMn0AYftd7lhJs1ZVI7Sgw
   0m3DmjhZubLtyh6AxZgKO+yJuIRtjYnBZHkVvEduacVp81ZmRexC/GdDF
   dmnaD1xIT2wZtYJTIRUK05HuZYgK8jdcnZfmoTOnqEPYvw59uSUqoN0ic
   LGWw0zRrA356qglrFC2jK5yJg4RXE3KOPczUdgN1m+01OWeLK4h4ayv01
   6FofWe5mWDlByVIvwHhkWRJUasgapa+P5ooLjJlaBSLfLtE194/fkR/qI
   g==;
X-CSE-ConnectionGUID: WsmbLi1bRP+MCPuuHrKi6A==
X-CSE-MsgGUID: 1DPdMem8S3Cih+LsoRYJfQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11518"; a="59749471"
X-IronPort-AV: E=Sophos;i="6.17,278,1747724400"; 
   d="scan'208";a="59749471"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2025 23:08:06 -0700
X-CSE-ConnectionGUID: 1aAF1SvsTYashk9ftAQYIg==
X-CSE-MsgGUID: Tos2kzzpRDKL/yc/rTuyBQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,278,1747724400"; 
   d="scan'208";a="165478858"
Received: from sschumil-mobl2.ger.corp.intel.com (HELO kekkonen.fi.intel.com) ([10.245.244.87])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2025 23:08:05 -0700
Received: from kekkonen.localdomain (localhost [127.0.0.1])
	by kekkonen.fi.intel.com (Postfix) with ESMTP id 9A70D120A5B;
	Mon, 11 Aug 2025 09:08:01 +0300 (EEST)
Date: Mon, 11 Aug 2025 06:08:01 +0000
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6 krs, Bertel Jungin Aukio 5, 02600 Espoo
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Petr Mladek <pmladek@suse.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Documentation/printf: Use literal fwnode_handle
Message-ID: <aJmIwb84CPvswmaQ@kekkonen.localdomain>
References: <07262c55e82fc4a3e3dbe7c45713b14955271e7f.1754552156.git.geert+renesas@glider.be>
 <aJcbbb4OVK_q2VkU@smile.fi.intel.com>
 <CAMuHMdXF_Dto3EVBKxr9+M=rmcwNcZy66aUqbb5OiRb75vSfnA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMuHMdXF_Dto3EVBKxr9+M=rmcwNcZy66aUqbb5OiRb75vSfnA@mail.gmail.com>

Hi Geert,

On Sun, Aug 10, 2025 at 09:33:50AM +0200, Geert Uytterhoeven wrote:
> Hi Andy,
> 
> CC Sakari
> 
> On Sat, 9 Aug 2025 at 11:57, Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> > On Thu, Aug 07, 2025 at 09:36:01AM +0200, Geert Uytterhoeven wrote:
> > > When looking for fwnode_handle in the printk format documentation, it is
> > > only found in the Chinese translation:
> > >
> > >     $ git grep fwnode_handle -- Documentation/*printk-formats.rst
> > >     Documentation/translations/zh_CN/core-api/printk-formats.rst:用于打印fwnode_handles的消息。默认情况下是打印完整的节点名称，包括路径。
> > >
> > > This happens because the original documentation talks about "fwnode
> > > handles", without mentioning the actual type name.
> >
> > Fixes?
> 
> If you insist...
> 
> Fixes: 3bd32d6a2ee62db3 ("lib/vsprintf: Add %pfw conversion specifier
> for printing fwnode names")

Thanks for the patch.

Reviewed-by: Sakari Ailus <sakari.ailus@linux.intel.com>

-- 
Regards,

Sakari Ailus

