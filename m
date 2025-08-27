Return-Path: <linux-kernel+bounces-788874-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04A22B38BA1
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 23:47:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B4E0216E17D
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 21:47:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9033E2F0C76;
	Wed, 27 Aug 2025 21:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BP2txcJj"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67ACA30DEB4
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 21:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756331230; cv=none; b=eGfO0ibbBWgrsnVz+d2FymISp24leVHG2YQ8U9BnTYbY7nITZNATmz6hwVclsBq1TW4/hlBU3Gwxd0cwZSLBdzq0T9rTctckaWhoB8Aq0yD8uDHD1CmKXNHvh0ugiZNTNyPRTVh9wuMejnBojvI45CxQYAQfNx1ThK87dd1byBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756331230; c=relaxed/simple;
	bh=9RW8zXdpdVYAVUqtLZZ63zwdMXfvo4c5jZhmHZV/++Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d2S48rL/9RLwdjI+SP+MoUN3WbBdE30QuF/poVN3HwNy64hmo1gW8iiQmYXkGms92Cs/VdbwfSGSbsgtRg9EG9hDsXThoXSbSWxVz3oJChyTtMbvM1DqOMvW9O6gpnajNurIS0zkSQv+P4fO3k4jH4SUrljbMMbCiens/OzOrZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BP2txcJj; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756331229; x=1787867229;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=9RW8zXdpdVYAVUqtLZZ63zwdMXfvo4c5jZhmHZV/++Q=;
  b=BP2txcJjZMHp2cr+g6iHM0Xw3Mouy/S0/eIiYnfcB6Besp0GK/mcmasx
   7VBbzYH4h1fCiEskFesNTo54kHFZUMHTiCPvKrfygDBFUmnYiZdaMwlD7
   aekhi7as5wBD94jHFp5lWRtOOwOKcksvfJjntCFKXUTPVnr5a/ac7t9sO
   j4RByLLHggb7D0svN+IeEg9jzSkzuC7H2BRDljPLriF5OlpALHAg5ORz1
   Ru/EuYs5f1GbIs8rYCbMlNpiIto2izHhS363wD1KLlh2JvmSi0K6MmPxe
   kLCFYGW8xhoFyeCk8tT/7mfN7HcJruHqc1nT0J4TXMaIljTrpD79eLPyP
   A==;
X-CSE-ConnectionGUID: lyTrm3gJSWCa94BZCCiglQ==
X-CSE-MsgGUID: 4RPmvp1VSyu6nQ8UdFtNJQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11535"; a="76192225"
X-IronPort-AV: E=Sophos;i="6.18,217,1751266800"; 
   d="scan'208";a="76192225"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2025 14:47:08 -0700
X-CSE-ConnectionGUID: OzumYTkkRFipllJ6o2zpgg==
X-CSE-MsgGUID: ILq6xhTLS6uAnu5M0StACA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,217,1751266800"; 
   d="scan'208";a="170764828"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2025 14:47:08 -0700
Date: Wed, 27 Aug 2025 14:53:18 -0700
From: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: ricardo.neri@intel.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] genirq/debugfs: Fix a typo in IRQ effective affinity
Message-ID: <20250827215318.GA28201@ranerica-svr.sc.intel.com>
References: <20250812-rneri-irq-debugfs-typo-v1-1-f29777b4024d@linux.intel.com>
 <87ikievsh3.ffs@tglx>
 <20250825231054.GA25222@ranerica-svr.sc.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250825231054.GA25222@ranerica-svr.sc.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)

On Mon, Aug 25, 2025 at 04:10:54PM -0700, Ricardo Neri wrote:
> On Sat, Aug 23, 2025 at 07:49:12PM +0200, Thomas Gleixner wrote:
> > On Tue, Aug 12 2025 at 14:00, Ricardo Neri wrote:
> > > Fix a typo in the line that prints the effective affinity of the IRQ.
> > 
> > It's not a typo. It's intentionally shortened to make the output
> > tabular, which makes it more readable.
> 
> Ah, I didn't see it this way.
> 
> > 
> > If you want 'effective' then please adjust 'affinity:' with an extra
> > space so it stays that way.
> 
> Sure. I can do this.

I looked again at my proposed change. I would need to adjust 10 more lines
besides 'affinity:' to keep the alignment. Adjusting a couple of lines
would not pollute history much. Adjusting multiple lines would do more harm
than good, IMO.

Unless you think otherwise, I do not plan to pursue this change further.
 
BR,
Ricardo

