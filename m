Return-Path: <linux-kernel+bounces-846922-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 99AB5BC96FD
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 16:09:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 775E319E7BCA
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 14:09:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EAA72EA173;
	Thu,  9 Oct 2025 14:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nSML8mP5"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AF4D23F422;
	Thu,  9 Oct 2025 14:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760018940; cv=none; b=LwAIMRLiDcwHfJlLL9XrYUTtbAta2hVP65zDSVnULhG8GjztxBADNrxHPZ4ZBugkZw9O1SkJH54Z6VluTEPK4cx+TTbNmYHD9LRSWhGGLyP4bx65YBjhnZpxXiLIwacgfsc5U85FGS+0eLnqu2LcE+Zz7jZ19AiEZtG/2gWiWVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760018940; c=relaxed/simple;
	bh=CGfn1E5Ey1zdUTDGPj9sA6UZ/1URpccJTu0xcaDFBjo=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k3kPgOEYgHnZ9N5CQdAgaJv5ZWPTPgsS65hhh+EldnYDaKaQ4craH6ruuijU2/Qe496YszbMg+nNsSOauyMFx+OQEPO7yaO9/r72ZpnYIIVmwluQstbYrykjkZW7J9fFabwmZZVaJqbUir5Ed18ilUpjAnZS2V3hZD2Y2GV/FSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nSML8mP5; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760018938; x=1791554938;
  h=date:from:to:subject:message-id:references:mime-version:
   in-reply-to;
  bh=CGfn1E5Ey1zdUTDGPj9sA6UZ/1URpccJTu0xcaDFBjo=;
  b=nSML8mP5Kfd9AumYGg/IWyrB1b23CtAHSTm3b+ROlHJ5IEIpoHzJTI6x
   g+5dNo7ZxsRjRl3sJbSPWgZNHsZZcxJRytYxCTBkqTzSHcYIAhOzRjydQ
   a7EkRHCy5NDppkZsIoB05viwlNdZCfsk5TnerXX/sdf9DHqeSznUaIakn
   u9dbIdA2z1has3Y2wyJZnyadOQAE/W1ekrQmeSmE9oAqXWUyDUmCJKLdR
   9E+0RyU0fj+e3+GMyL9Gf4m+VQiG4MpiADJ4KyOGRQWRrNn4KOZfGzOPD
   JzJJyHXXJXfAQPeACYZLxFpXnECE9ACDqvr/aio84lsouf+/fFffp8WEJ
   g==;
X-CSE-ConnectionGUID: G/xWbL8SQB6yF0hZQEpBpw==
X-CSE-MsgGUID: 9BfApQ9iTiif12o6Ce4f4w==
X-IronPort-AV: E=McAfee;i="6800,10657,11577"; a="62271655"
X-IronPort-AV: E=Sophos;i="6.19,216,1754982000"; 
   d="scan'208";a="62271655"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2025 07:08:57 -0700
X-CSE-ConnectionGUID: dSUAPNMQTUe598wjzeCUZw==
X-CSE-MsgGUID: 3B5vpNqvTvmpIkQsD+yQrg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,216,1754982000"; 
   d="scan'208";a="180667723"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO kuha.fi.intel.com) ([10.124.221.27])
  by fmviesa006.fm.intel.com with SMTP; 09 Oct 2025 07:08:54 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Thu, 09 Oct 2025 17:08:53 +0300
Date: Thu, 9 Oct 2025 17:08:53 +0300
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: "Chia-Lin Kao (AceLan)" <acelan.kao@canonical.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
	Andrei Kuchynski <akuchynski@chromium.org>,
	=?utf-8?Q?=C5=81ukasz?= Bartosik <ukaszb@chromium.org>,
	Venkat Jayaraman <venkat.jayaraman@intel.com>,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: typec: ucsi: Fix workqueue destruction race during
 connector cleanup
Message-ID: <aOfB9bdEzlxPFzhg@kuha.fi.intel.com>
References: <20251002013026.4095030-1-acelan.kao@canonical.com>
 <aOY-OyN90DScHr85@kuha.fi.intel.com>
 <dr5dderec7diwlsiu7n5vziotw4lnnkletyy7hb55miosrdiy7@oy3nqplgcv6s>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dr5dderec7diwlsiu7n5vziotw4lnnkletyy7hb55miosrdiy7@oy3nqplgcv6s>

On Thu, Oct 09, 2025 at 09:58:22AM +0800, Chia-Lin Kao (AceLan) wrote:
> On Wed, Oct 08, 2025 at 01:34:35PM +0300, Heikki Krogerus wrote:
> > On Thu, Oct 02, 2025 at 09:30:26AM +0800, Chia-Lin Kao (AceLan) wrote:
> > > During UCSI initialization and operation, there is a race condition where
> > > delayed work items can be scheduled but attempt to queue work after the
> > > workqueue has been destroyed. This occurs in multiple code paths.
> > > 
> > > The race occurs when:
> > > 1. ucsi_partner_task() or ucsi_poll_worker() schedule delayed work
> > > 2. Connector cleanup paths call destroy_workqueue()
> > > 3. Previously scheduled delayed work timers fire after destruction
> > > 4. This triggers warnings and crashes in __queue_work()
> > 
> > What warnings?
> Here is what I got.
> 
> Sep 24 13:24:22 ubuntu kernel: sysfs: cannot create duplicate filename '/devices/platform/USBC000:00/typec/port0/port0.0/partner'
> Sep 24 13:24:22 ubuntu kernel: CPU: 1 UID: 0 PID: 132 Comm: kworker/u64:1 Tainted: G           O       6.14.0-1012-oem #12-Ubuntu
> Sep 24 13:24:22 ubuntu kernel: Tainted: [O]=OOT_MODULE
> Sep 24 13:24:22 ubuntu kernel: Hardware name: Dell Inc. Dell /, BIOS XXXX XX/XX/2025
> Sep 24 13:24:22 ubuntu kernel: Workqueue: USBC000:00-con1 ucsi_poll_worker [typec_ucsi]
> Sep 24 13:24:22 ubuntu kernel: Call Trace:
> Sep 24 13:24:22 ubuntu kernel:  <TASK>
> Sep 24 13:24:22 ubuntu kernel:  dump_stack_lvl+0x76/0xa0
> Sep 24 13:24:22 ubuntu kernel:  dump_stack+0x10/0x20
> Sep 24 13:24:22 ubuntu kernel:  sysfs_warn_dup+0x8a/0xb0
> Sep 24 13:24:22 ubuntu kernel:  sysfs_do_create_link_sd+0xf1/0x100
> Sep 24 13:24:22 ubuntu kernel:  sysfs_create_link+0x21/0x50
> Sep 24 13:24:22 ubuntu kernel:  typec_probe+0x7e/0x100 [typec]
> Sep 24 13:24:22 ubuntu kernel:  ? driver_sysfs_add+0x66/0xd0
> Sep 24 13:24:22 ubuntu kernel:  really_probe+0xee/0x3c0
> Sep 24 13:24:22 ubuntu kernel:  __driver_probe_device+0x8c/0x180
> Sep 24 13:24:22 ubuntu kernel:  driver_probe_device+0x24/0xd0
> Sep 24 13:24:22 ubuntu kernel:  __device_attach_driver+0xcd/0x170
> Sep 24 13:24:22 ubuntu kernel:  ? _pfx__device_attach_driver+0x10/0x10
> Sep 24 13:24:22 ubuntu kernel:  bus_for_each_drv+0x94/0xf0
> Sep 24 13:24:22 ubuntu kernel:  __device_attach+0xb6/0x1d0
> Sep 24 13:24:22 ubuntu kernel:  device_initial_probe+0x13/0x20
> Sep 24 13:24:22 ubuntu kernel:  bus_probe_device+0x9f/0xb0
> Sep 24 13:24:22 ubuntu kernel:  device_add+0x513/0x710
> Sep 24 13:24:22 ubuntu kernel:  device_register+0x1a/0x30
> Sep 24 13:24:22 ubuntu kernel:  typec_register_altmode+0x253/0x3a0 [typec]
> Sep 24 13:24:22 ubuntu kernel:  typec_partner_register_altmode+0xe/0x20 [typec]
> Sep 24 13:24:22 ubuntu kernel:  ucsi_register_altmode.constprop.0+0x30e/0x390 [typec_ucsi]
> Sep 24 13:24:22 ubuntu kernel:  ucsi_register_altmodes+0x162/0x250 [typec_ucsi]
> Sep 24 13:24:22 ubuntu kernel:  ucsi_check_altmodes+0x19/0xb0 [typec_ucsi]
> Sep 24 13:24:22 ubuntu kernel:  ucsi_poll_worker+0x3d/0xf0 [typec_ucsi]
> Sep 24 13:24:22 ubuntu kernel:  process_one_work+0x178/0x3d0
> Sep 24 13:24:22 ubuntu kernel:  worker_thread+0x2de/0x410
> Sep 24 13:24:22 ubuntu kernel:  ? __pfx_worker_thread+0x10/0x10
> Sep 24 13:24:22 ubuntu kernel:  kthread+0xfb/0x230
> Sep 24 13:24:22 ubuntu kernel:  ? __pfx_kthread+0x10/0x10
> Sep 24 13:24:22 ubuntu kernel:  ret_from_fork+0x44/0x70
> Sep 24 13:24:22 ubuntu kernel:  ? __pfx_kthread+0x10/0x10
> Sep 24 13:24:22 ubuntu kernel:  ret_from_fork_asm+0x1a/0x30
> Sep 24 13:24:22 ubuntu kernel:  </TASK>
> Sep 24 13:24:22 ubuntu kernel: typec-thunderbolt port0-partner.1: failed to create symlinks
> Sep 24 13:24:22 ubuntu kernel: typec-thunderbolt port0-partner.1: probe with driver typec-thunderbolt failed with error -17

That does not look like anything you described in the commit message?

You have there an attempt to register the same alternate mode twice,
but the workqueue seems to be very much alive when that happens.

Based on the above this looks like either a race where the driver
really ends up registering the alternate modes multiple times or, and
more likely, the firmware is reporting the same alternate mode
multiple times.

Or am I missing something?

thanks,

-- 
heikki

