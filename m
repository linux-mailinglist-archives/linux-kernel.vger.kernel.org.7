Return-Path: <linux-kernel+bounces-824161-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B5B2AB883F1
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 09:45:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 71ABD1C875D3
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 07:45:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA07E2D46A9;
	Fri, 19 Sep 2025 07:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="doE8GM0X"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E093B2D249A;
	Fri, 19 Sep 2025 07:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758267873; cv=none; b=NT1IHGAVIo7rTUFC/RzbSuDNZ8C33rEo9+dkc09TK9RQ7DrOP9tQYzOG92s/dNVSZeDBcSv052el+zxqafw+0fWAuRITjuSjnwde5rr5jRLV9tS89oTiSKXZ88TijXYYWczBvj7IYeYowpWieGe//I2c1uyj9PCe9FDcUSet4G8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758267873; c=relaxed/simple;
	bh=LwfR+4hkxYUidvMyg7oiE925+JBFlv5gmKUeEq/5qOU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cH0PoKW16Wo1llyfjjVItBfGiq+zBcM0vCnduArPtwpW9vfN84pGVdWsvoR2SgnFPtkUspkUUxuxIUPqXM7zSxIjk239cciw0021lUJ7Y4cRV20HnD3tt8NWKmSIlpWFDaFG1hWFwuJTXN8BvhnfWrq9OpYAMBsIPnrrX8ot0WU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=doE8GM0X; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758267871; x=1789803871;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=LwfR+4hkxYUidvMyg7oiE925+JBFlv5gmKUeEq/5qOU=;
  b=doE8GM0XNv8v8m70+FCWvo2UwW0Mqrjl6LUoQclGJ4ub5rhLKxwAoNJa
   /8D2lBHO1c3s2bC7p6AwqxN5valQTjOIkq5j+bTRkbnaqDB89Z6tLHS2O
   wzPuULDUPX2E5PrUpa58N906gpOyeuDLF45q8cFh2Xz/IJa0oXiQI6Os4
   A76jYkBXde+bwIECL1Tuvr3t2uuK8WlFnJ4+BeGw34W7dEiNt50O2+lrq
   yAFvTLPrC7VRDNcBYyrN+x75NTM9QeYm1nS6D+m9eWDlEUJZ8/CFRS4e2
   8BFTEFlgwXZQ+zFowwAIHDY6rDIxiN/x/6Of66tbxLIitd6EnwGCZ9Z2W
   A==;
X-CSE-ConnectionGUID: lrBYpqzoTHCaBVOK21iwlQ==
X-CSE-MsgGUID: VNY9YIHIRYSVQE5C0NNxmA==
X-IronPort-AV: E=McAfee;i="6800,10657,11557"; a="64250988"
X-IronPort-AV: E=Sophos;i="6.18,277,1751266800"; 
   d="scan'208";a="64250988"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2025 00:44:30 -0700
X-CSE-ConnectionGUID: x9WaXblsSveeOn3hXK415w==
X-CSE-MsgGUID: rNtytAYMTsagbX8fW0/LNQ==
X-ExtLoop1: 1
Received: from kuha.fi.intel.com ([10.237.72.152])
  by fmviesa003.fm.intel.com with SMTP; 19 Sep 2025 00:44:27 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Fri, 19 Sep 2025 10:44:26 +0300
Date: Fri, 19 Sep 2025 10:44:26 +0300
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Mark Pearson <mpearson-lenovo@squebb.ca>, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: typec: ucsi: Handle incorrect num_connectors
 capability
Message-ID: <aM0J2hDgqkxioAXU@kuha.fi.intel.com>
References: <mpearson-lenovo@squebb.ca>
 <20250821185319.2585023-1-mpearson-lenovo@squebb.ca>
 <2025082213-antacid-correct-53b1@gregkh>
 <0ac78125-a028-4d99-b106-d792d8660d0f@app.fastmail.com>
 <1c185541-2b6b-4c43-938a-9f4f4d1499b4@app.fastmail.com>
 <2025091819-bullion-hut-8242@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2025091819-bullion-hut-8242@gregkh>

On Thu, Sep 18, 2025 at 09:50:30AM +0200, Greg KH wrote:
> On Wed, Sep 17, 2025 at 02:14:28PM -0400, Mark Pearson wrote:
> > Hi all,
> > 
> > On Fri, Aug 22, 2025, at 8:54 AM, Mark Pearson wrote:
> > > Hi Greg,
> > >
> > > On Fri, Aug 22, 2025, at 12:51 AM, Greg KH wrote:
> > >> On Thu, Aug 21, 2025 at 02:53:07PM -0400, Mark Pearson wrote:
> > >>> The UCSI spec states that the num_connectors field is 7 bits, and the
> > >>> 8th bit is reserved and should be set to zero.
> > >>> Some buggy FW has been known to set this bit, and it can lead to a
> > >>> system not booting.
> > >>> Flag that the FW is not behaving correctly, and auto-fix the value
> > >>> so that the system boots correctly.
> > >>> 
> > >>> Found on Lenovo P1 G8 during Linux enablement program. The FW will
> > >>> be fixed, but seemed worth addressing in case it hit platforms that
> > >>> aren't officially Linux supported.
> > >>> 
> > >>> Signed-off-by: Mark Pearson <mpearson-lenovo@squebb.ca>
> > >>
> > >> Any hints as to what commit id this fixes?
> > >>
> > >> thanks,
> > >>
> > >> greg k-h
> > >
> > > Maybe 3cf657f ('Remove all bit-fields')?
> > >
> > > The commit there states that 'We can't use bit fields with data that is 
> > > received or send
> > > to/from the device.'
> > > Not sure why that is, but I assumed this means we shouldn't change the 
> > > structure to use 7 bits for num_connectors, which was my original plan.
> > >
> > > After that, we go all the way back to the file creation (c1b0bc2) where 
> > > it was defined as 8 bit.
> > >
> > 
> > Just a gentle nudge to see if there are any concerns or questions with the patch.
> 
> I was waiting for the maintainer of this code to review it :)

So not Fixes tag?

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

-- 
heikki

