Return-Path: <linux-kernel+bounces-880268-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 69D5DC25466
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 14:34:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D6F5189A45B
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 13:32:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 873BC199FB2;
	Fri, 31 Oct 2025 13:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aApeRan2"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F54378F26;
	Fri, 31 Oct 2025 13:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761917514; cv=none; b=TXBuLMeEyq/QtrAs0ZPlUD8Kk/AsypfcDvEdhCRs2FtQ+mPIwmJ2AHQrArU8FSJo9i7gVir9CqmVLK6A0BzBQYsNamkdyOr2hBVCLKKjoVdF4vGr6KQEX/Czg0slvP0VG6CNS9m2OVZaaV7bnS0p4nxoAmcLLfCgpjK5rxgM4+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761917514; c=relaxed/simple;
	bh=qLl7PRjCm6T/K0kSuAMoSuVsfYvPSX+ZvqQCR59QVgk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O8Xhfw6lHVFXRweVe8Mka5/V12oxGir9DGAvmSJoVqzIOiXlW0ZohkQXPNXbTKkFvi3rveMUSTUfF5KzUxwbDef/rQ9jTEaXgqB5OgtoS+xWNcCRoEszvLwnzd1qmpupYbpCL97lyChYtd5su/aey2J19k1276rIxafin9NOAYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aApeRan2; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761917513; x=1793453513;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=qLl7PRjCm6T/K0kSuAMoSuVsfYvPSX+ZvqQCR59QVgk=;
  b=aApeRan2NY3lmuptMsbCSxyDk8mk11xn+o0AKNg3t8kR09QfEdd4L56S
   W6FiZRAy6FW+MqdemM4r9xZYy0hZq2NrWwUtsgyt+/Z/1BZnbc4uzFTOf
   AOitmm7hPzGZNDG0OkEjOoMy4de4HYdBO1qdO2CeMsLX0BNET3en2lurB
   G0JqtCQWTTVG+2pA1xP5lc1l7qO3WuychHEJziwF87BF1ioCNMs6xo17b
   4JMf2ir3esVsGa4iWrUaEme7VyJqiXPpC1bfV/7bgeCCxFZed0d9vYoaH
   gHcorZoztGK/t+fuuLvDZRCYuXUdSjVxfHjmJ+5Kk/8YquRJYs3LvREsc
   Q==;
X-CSE-ConnectionGUID: 3b3uFSTCTTe0qKyt9RmMkQ==
X-CSE-MsgGUID: 98XXpSMOQXefEd321tdUcw==
X-IronPort-AV: E=McAfee;i="6800,10657,11598"; a="81488966"
X-IronPort-AV: E=Sophos;i="6.19,269,1754982000"; 
   d="scan'208";a="81488966"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2025 06:31:51 -0700
X-CSE-ConnectionGUID: NTt2vmzATTCRS+6w92EeTQ==
X-CSE-MsgGUID: mcocI4H8QLqEjGSUJ4FIqw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,269,1754982000"; 
   d="scan'208";a="190584058"
Received: from jjgreens-desk20.amr.corp.intel.com (HELO kuha.fi.intel.com) ([10.124.220.81])
  by orviesa004.jf.intel.com with SMTP; 31 Oct 2025 06:31:47 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Fri, 31 Oct 2025 15:31:46 +0200
Date: Fri, 31 Oct 2025 15:31:46 +0200
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
	"Chia-Lin Kao (AceLan)" <acelan.kao@canonical.com>
Cc: "Chen, Antony" <antony.chen@intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Fedor Pchelkin <boddah8794@gmail.com>,
	Andrei Kuchynski <akuchynski@chromium.org>,
	Venkat Jayaraman <venkat.jayaraman@intel.com>,
	Myrrh Periwinkle <myrrhperiwinkle@qtmlabs.xyz>,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: typec: ucsi: Detect and skip duplicate altmodes
 from buggy firmware
Message-ID: <aQS6QhE1L7aLKhJN@kuha.fi.intel.com>
References: <20251016055332.914106-1-acelan.kao@canonical.com>
 <aPX-ZxwaweJjtv3J@kuha.fi.intel.com>
 <66gkc32hdbzdxpnx3r56bfzt4znw6xj7m3j6363mus4nf47kf6@3f2hj5qwsb46>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <66gkc32hdbzdxpnx3r56bfzt4znw6xj7m3j6363mus4nf47kf6@3f2hj5qwsb46>

Hi Chia-Lin,

Mon, Oct 20, 2025 at 12:36:51PM +0300, Dmitry Baryshkov kirjoitti:
> On Mon, Oct 20, 2025 at 12:18:31PM +0300, Heikki Krogerus wrote:
> > +Antony
> > 
> > On Thu, Oct 16, 2025 at 01:53:32PM +0800, Chia-Lin Kao (AceLan) wrote:
> > > Some firmware implementations incorrectly return the same altmode
> > > multiple times at different offsets when queried via UCSI_GET_ALTERNATE_MODES.
> > > This causes sysfs duplicate filename errors and kernel call traces when
> > > the driver attempts to register the same altmode twice:
> > > 
> > >   sysfs: cannot create duplicate filename '/devices/.../typec/port0/port0.0/partner'
> > >   typec-thunderbolt port0-partner.1: failed to create symlinks
> > >   typec-thunderbolt port0-partner.1: probe with driver typec-thunderbolt failed with error -17
> > > 
> > > Detect duplicate altmodes by comparing SVID and VDO before registration.
> > > If a duplicate is detected, skip it and print a single clean warning
> > > message instead of generating a kernel call trace:
> > > 
> > >   ucsi_acpi USBC000:00: con0: Firmware bug: duplicate partner altmode SVID 0x8087 at offset 1, ignoring. Please update your system firmware.
> > > 
> > > This makes the error handling more user-friendly while still alerting
> > > users to the firmware bug.
> > > 
> > > The fix applies to all three recipient types: partner (SOP), port (CON),
> > > and plug (SOP_P) altmodes.
> > > 
> > > Fixes: a79f16efcd00 ("usb: typec: ucsi: Add support for the partner USB Modes")
> > > Cc: stable@vger.kernel.org
> > > Signed-off-by: Chia-Lin Kao (AceLan) <acelan.kao@canonical.com>
> > 
> > Thank you for the patch. Before going forward with this, I would like
> > to make sure that Dell is not using the GET_ALTERNATE_MODES command in
> > some customised way deliberately, and that this really is a bug in the
> > EC firmware.
> 
> 
> Just to point out, we have had a similar issue with Lenovo Yoga c630,
> see yoga_c630_ucsi_update_altmodes(), the EC was ignoring offset field.

I think we can reuse that function like Dmitry pointed out. Can you
check that?

thanks,

-- 
heikki

