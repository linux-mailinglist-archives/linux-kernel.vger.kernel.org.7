Return-Path: <linux-kernel+bounces-774169-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83B8BB2AF65
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 19:27:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 508DF5809FE
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 17:27:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA4153469F2;
	Mon, 18 Aug 2025 17:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AjeEJIbl"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5DC334574E;
	Mon, 18 Aug 2025 17:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755538029; cv=none; b=fU2BblwjekFODkuYlwoaMnNrNun1GH30i8tF3QROG/p83PSl8HGWXFU6sU7XFYIdgFXnFMSJxlezNqTfiw3tM4bj3J2hv7n1Ij1uEB+6tnxdcFBEXPQBQd5tJ2R8vuXr5pY++ZqSvkf9BZF/YI7CJyzHKXC85lAlH96xwkwTn9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755538029; c=relaxed/simple;
	bh=HwKz2ZvTlrx9A/GRESM903NFMrPusguohKyWSeDg0QM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VJWB0nsy90ML9+NJ10aujwQclSg12PQD/2SE10sEa29DW3fXBIf7aJhjFRCh8HQvJ3nmHTS5gkVfYZmN2lH70tqB3jzj06BoV+5AilAUVX4YTJeFAdhht7Q8jusoyJZF8FXl4Ccs2me/+pGgWbYJ0+wMORvZ480XQrF/DO0ctXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AjeEJIbl; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755538028; x=1787074028;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=HwKz2ZvTlrx9A/GRESM903NFMrPusguohKyWSeDg0QM=;
  b=AjeEJIbll40l1KLUjF3+zGbWah03vQ9fCM/mP+VwkoUaA+aaampIRLio
   782yzJPrNfTla23GnRCmcV0pKf1W1RP+6pl6lysVyOi2wZUgYz1PGOllt
   n+jRDfsISDMmuCf55LcjY+MwCbt/gn4gAY97+aaQ3G3jmD40XQFMG9WTB
   MrcA5/7ru7/UYSQ8rUNzxo9ojU0l1yQbQZ5pPadVu+czS/QHa8Bgbr6Sx
   FC/JzORU0bBl9urLZ69clkaZSW+3wW4WS+0tMFZWzKES6OriuEub5p0HY
   s7B4TXaKzNvmeiI2aZqbLcH1JVfUPv66anDC7ux6SVdUMJlneEJgS6ypl
   Q==;
X-CSE-ConnectionGUID: AZ15PtlCQjWfjI+tRK96/w==
X-CSE-MsgGUID: Y5ltu4XgRv276OuSpmedDg==
X-IronPort-AV: E=McAfee;i="6800,10657,11526"; a="57481497"
X-IronPort-AV: E=Sophos;i="6.17,300,1747724400"; 
   d="scan'208";a="57481497"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2025 10:27:07 -0700
X-CSE-ConnectionGUID: 4D4u2epWRwGxu77OuzSNcg==
X-CSE-MsgGUID: pmBbF8sQSMWFW7IwRx1oQw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,300,1747724400"; 
   d="scan'208";a="166867851"
Received: from rfrazer-mobl3.amr.corp.intel.com (HELO desk) ([10.124.220.33])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2025 10:27:07 -0700
Date: Mon, 18 Aug 2025 10:26:55 -0700
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To: Jonathan Corbet <corbet@lwn.net>
Cc: "Nikola Z. Ivanov" <zlatistiv@gmail.com>, tglx@linutronix.de,
	bp@alien8.de, peterz@infradead.org, jpoimboe@kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [PATCH] docs: Replace dead links to spectre side channel white
 papers
Message-ID: <20250818172655.g7qr6yue5oeewk5w@desk>
References: <20250816190028.55573-1-zlatistiv@gmail.com>
 <875xekaa4a.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <875xekaa4a.fsf@trenco.lwn.net>

On Mon, Aug 18, 2025 at 10:05:25AM -0600, Jonathan Corbet wrote:
> "Nikola Z. Ivanov" <zlatistiv@gmail.com> writes:
> 
> > The papers are published by Intel, AMD and MIPS.
> >
> > Signed-off-by: Nikola Z. Ivanov <zlatistiv@gmail.com>
> > ---
> > The MIPS blog post is nowhere to be found on mips.com,
> > instead a link is placed to the last time the web archive
> > has crawled it.
> >
> >  Documentation/admin-guide/hw-vuln/spectre.rst | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> I sure wish I understood why companies feel such a need to break links
> so often ... I've applied this, thanks.

Sorry about that, I have let the Intel team know about the broken links.
And requested them to make sure that this does not happen again in the
future.

