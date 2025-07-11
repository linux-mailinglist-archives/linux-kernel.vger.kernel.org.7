Return-Path: <linux-kernel+bounces-727768-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DAC66B01F6C
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 16:47:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0266F7A8B48
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 14:45:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC77A2E9725;
	Fri, 11 Jul 2025 14:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AteWjbDy"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 563A5270578
	for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 14:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752245213; cv=none; b=aTEHZK0zSDz6m5ECaLi1rYpv5Net4kH2UkGPuC8QJcKSf876wtv542GX1UZnU5FxGMmNdlBDlkgFY0KfNETp6nNr9uXOb5q39jiuJMKiHmkn6lBpUs1BH1xy4muErqPIq3nVRKcZ/yc1ug2pTQgN25Y9kW6Ii0raFb5Em/Q7rpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752245213; c=relaxed/simple;
	bh=01TMUFB7/dJsmtn+0Bm9lyEpC82i8ZT+V/MPg+pfOlY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dwhAQIbyRQXo8Dd0+DpP7rCE3XND81H+E3chrgG5tlN7mgJ0OCV7+1Pbtwh62wkBZ9BdZZlfJjzmiOG05wvc5frXg1jxZs0q6knNiVZAJuIvMIPgSDrPedYysxYQuPRvB5+dalCfl5krtU0P5m0uHkd7Ip40soo3YFVrmvpGwsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AteWjbDy; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752245211; x=1783781211;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=01TMUFB7/dJsmtn+0Bm9lyEpC82i8ZT+V/MPg+pfOlY=;
  b=AteWjbDyj54FpTu9Fl5hUaV7KwVmrE9fVJqfejCML6vaAGjlNx4OiHO/
   d2PYatcN8MdOV1qZrt8kJCzU7kCauPgrzfRP/EiQQ38u3cSqKoz1cP/Sn
   jEkM+OuYb9AqX2xRizlYrDQFsO4IcGSHpW3aJj7rLblEJKRg6YUetm7ya
   +0thLe7pvN98Pet4IVic9hDlSv4r56lMtoe9jiMi/oB7oJc1sbg3qkZZZ
   0qklVRk25WwRAfXZ/XTAALN88bkFs2Opn5/Et2Z6xTG+QwdkEhdqrNhuS
   mkVM/m4vmRzOI6L5+JAZ7CGBfhAbTpOECVTBqHUYcD/puI5QbDGZPmTCb
   w==;
X-CSE-ConnectionGUID: +CYBGNRETzuqVgtj64iD+Q==
X-CSE-MsgGUID: BhAhHAbVSseJcpacd5qkOw==
X-IronPort-AV: E=McAfee;i="6800,10657,11491"; a="65245373"
X-IronPort-AV: E=Sophos;i="6.16,303,1744095600"; 
   d="scan'208";a="65245373"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2025 07:46:51 -0700
X-CSE-ConnectionGUID: aBYgIc5/Tbuma5wyYjlG2g==
X-CSE-MsgGUID: q8NYpnLySbmOP9/XLRPd4w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,303,1744095600"; 
   d="scan'208";a="162068999"
Received: from johunt-mobl9.ger.corp.intel.com (HELO stinkbox) ([10.245.245.78])
  by orviesa005.jf.intel.com with SMTP; 11 Jul 2025 07:46:45 -0700
Received: by stinkbox (sSMTP sendmail emulation); Fri, 11 Jul 2025 17:46:44 +0300
Date: Fri, 11 Jul 2025 17:46:44 +0300
From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To: Simona Vetter <simona.vetter@ffwll.ch>
Cc: Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
	"Nikula, Jani" <jani.nikula@linux.intel.com>,
	"Vivi, Rodrigo" <rodrigo.vivi@intel.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Alex Deucher <alexander.deucher@amd.com>,
	Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
	dri-devel@lists.freedesktop.org,
	linux-kernel <linux-kernel@vger.kernel.org>,
	Linux AMDGPU <amd-gfx@lists.freedesktop.org>
Subject: Re: WARNING: possible circular locking dependency detected:
 drm_client_dev_suspend() & radeon_suspend_kms()
Message-ID: <aHEj1GQjjIiCbhjB@intel.com>
References: <0a087cfd-bd4c-48f1-aa2f-4a3b12593935@oss.qualcomm.com>
 <CAKMK7uH7Hcviwyw2wZK=WVxcb4zBC+EKpsREhb4FHe_AxEi8gg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKMK7uH7Hcviwyw2wZK=WVxcb4zBC+EKpsREhb4FHe_AxEi8gg@mail.gmail.com>
X-Patchwork-Hint: comment

On Fri, Jul 11, 2025 at 11:08:03AM +0200, Simona Vetter wrote:
> On Thu, Jul 10, 2025 at 04:43:02PM -0700, Jeff Johnson wrote:
> > I'm trying to debug a hibernation issue with the ath12k driver, but to
> > establish a baseline I started with Linus' current tree. I have the following
> > enabled in my .config:
> >
> > CONFIG_PROVE_LOCKING=y
> > CONFIG_PROVE_RAW_LOCK_NESTING=y
> > CONFIG_PROVE_RCU=y
> >
> > As part of the baseline I observed the following:
> 
> On a very quick guess I'd bet on the drm_client conversion for i915 to
> have broken something here. Adding more people.

Looks to me like it's simply due to this code in radeon:

radeon_suspend_kms(...)
{
	...
        if (notify_clients) {
                console_lock();
                drm_client_dev_suspend(dev, true);
                console_unlock();
	}
	...
}

> -Sima
> 
> 
> >
> > Jul 10 16:12:52 qca-HP-ZBook-14-G2 kernel: ======================================================
> > Jul 10 16:12:52 qca-HP-ZBook-14-G2 kernel: WARNING: possible circular locking dependency detected
> > Jul 10 16:12:52 qca-HP-ZBook-14-G2 kernel: 6.16.0-rc5+ #6 Not tainted
> > Jul 10 16:12:52 qca-HP-ZBook-14-G2 kernel: ------------------------------------------------------
> > Jul 10 16:12:52 qca-HP-ZBook-14-G2 kernel: kworker/u16:13/3787 is trying to acquire lock:
> > Jul 10 16:12:52 qca-HP-ZBook-14-G2 kernel: ffff8881113e0308 (&dev->clientlist_mutex){+.+.}-{4:4}, at: drm_client_dev_suspend+0x37/0x250 [drm]
> > Jul 10 16:12:52 qca-HP-ZBook-14-G2 kernel:
> >                                            but task is already holding lock:
> > Jul 10 16:12:52 qca-HP-ZBook-14-G2 kernel: ffffffff8a2e4b80 (console_lock){+.+.}-{0:0}, at: radeon_suspend_kms+0x63b/0x7d0 [radeon]
> > Jul 10 16:12:52 qca-HP-ZBook-14-G2 kernel:
> >                                            which lock already depends on the new lock.
> > Jul 10 16:12:52 qca-HP-ZBook-14-G2 kernel:
> >                                            the existing dependency chain (in reverse order) is:
> > Jul 10 16:12:52 qca-HP-ZBook-14-G2 kernel:
> >                                            -> #1 (console_lock){+.+.}-{0:0}:
> > Jul 10 16:12:52 qca-HP-ZBook-14-G2 kernel:        console_lock+0x8d/0x130
> > Jul 10 16:12:52 qca-HP-ZBook-14-G2 kernel:        drm_fb_helper_set_suspend_unlocked+0x10e/0x200 [drm_kms_helper]
> > Jul 10 16:12:52 qca-HP-ZBook-14-G2 kernel:        drm_fbdev_client_suspend+0x24/0x30 [drm_client_lib]
> > Jul 10 16:12:52 qca-HP-ZBook-14-G2 kernel:        drm_client_dev_suspend+0x138/0x250 [drm]
> > Jul 10 16:12:52 qca-HP-ZBook-14-G2 kernel:        i915_drm_suspend.isra.0+0x74/0x260 [i915]
> > Jul 10 16:12:52 qca-HP-ZBook-14-G2 kernel:        i915_pm_suspend+0x6b/0x90 [i915]
> > Jul 10 16:12:52 qca-HP-ZBook-14-G2 kernel:        pci_pm_suspend+0x1e3/0x4f0
> > Jul 10 16:12:52 qca-HP-ZBook-14-G2 kernel:        dpm_run_callback+0xa0/0x100
> > Jul 10 16:12:52 qca-HP-ZBook-14-G2 kernel:        device_suspend+0x41e/0xdc0
> > Jul 10 16:12:52 qca-HP-ZBook-14-G2 kernel:        async_suspend+0x1d/0x30
> > Jul 10 16:12:52 qca-HP-ZBook-14-G2 kernel:        async_run_entry_fn+0x96/0x3e0
> > Jul 10 16:12:52 qca-HP-ZBook-14-G2 kernel:        process_one_work+0x86e/0x14b0
> > Jul 10 16:12:52 qca-HP-ZBook-14-G2 kernel:        worker_thread+0x5d0/0xfc0
> > Jul 10 16:12:52 qca-HP-ZBook-14-G2 kernel:        kthread+0x375/0x750
> > Jul 10 16:12:52 qca-HP-ZBook-14-G2 kernel:        ret_from_fork+0x215/0x2f0
> > Jul 10 16:12:52 qca-HP-ZBook-14-G2 kernel:        ret_from_fork_asm+0x1a/0x30
> > Jul 10 16:12:52 qca-HP-ZBook-14-G2 kernel:
> >                                            -> #0 (&dev->clientlist_mutex){+.+.}-{4:4}:
> > Jul 10 16:12:52 qca-HP-ZBook-14-G2 kernel:        __lock_acquire+0x15b5/0x2ac0
> > Jul 10 16:12:52 qca-HP-ZBook-14-G2 kernel:        lock_acquire+0x154/0x2d0
> > Jul 10 16:12:52 qca-HP-ZBook-14-G2 kernel:        __mutex_lock+0x15f/0x12c0
> > Jul 10 16:12:52 qca-HP-ZBook-14-G2 kernel:        drm_client_dev_suspend+0x37/0x250 [drm]
> > Jul 10 16:12:52 qca-HP-ZBook-14-G2 kernel:        radeon_suspend_kms+0x648/0x7d0 [radeon]
> > Jul 10 16:12:52 qca-HP-ZBook-14-G2 kernel:        pci_pm_suspend+0x1e3/0x4f0
> > Jul 10 16:12:52 qca-HP-ZBook-14-G2 kernel:        dpm_run_callback+0xa0/0x100
> > Jul 10 16:12:52 qca-HP-ZBook-14-G2 kernel:        device_suspend+0x41e/0xdc0
> > Jul 10 16:12:52 qca-HP-ZBook-14-G2 kernel:        async_suspend+0x1d/0x30
> > Jul 10 16:12:52 qca-HP-ZBook-14-G2 kernel:        async_run_entry_fn+0x96/0x3e0
> > Jul 10 16:12:52 qca-HP-ZBook-14-G2 kernel:        process_one_work+0x86e/0x14b0
> > Jul 10 16:12:52 qca-HP-ZBook-14-G2 kernel:        worker_thread+0x5d0/0xfc0
> > Jul 10 16:12:52 qca-HP-ZBook-14-G2 kernel:        kthread+0x375/0x750
> > Jul 10 16:12:52 qca-HP-ZBook-14-G2 kernel:        ret_from_fork+0x215/0x2f0
> > Jul 10 16:12:52 qca-HP-ZBook-14-G2 kernel:        ret_from_fork_asm+0x1a/0x30
> > Jul 10 16:12:52 qca-HP-ZBook-14-G2 kernel:
> >                                            other info that might help us debug this:
> > Jul 10 16:12:52 qca-HP-ZBook-14-G2 kernel:  Possible unsafe locking scenario:
> > Jul 10 16:12:52 qca-HP-ZBook-14-G2 kernel:        CPU0                    CPU1
> > Jul 10 16:12:52 qca-HP-ZBook-14-G2 kernel:        ----                    ----
> > Jul 10 16:12:52 qca-HP-ZBook-14-G2 kernel:   lock(console_lock);
> > Jul 10 16:12:52 qca-HP-ZBook-14-G2 kernel:                                lock(&dev->clientlist_mutex);
> > Jul 10 16:12:52 qca-HP-ZBook-14-G2 kernel:                                lock(console_lock);
> > Jul 10 16:12:52 qca-HP-ZBook-14-G2 kernel:   lock(&dev->clientlist_mutex);
> > Jul 10 16:12:52 qca-HP-ZBook-14-G2 kernel:
> >                                             *** DEADLOCK ***
> > Jul 10 16:12:52 qca-HP-ZBook-14-G2 kernel: 4 locks held by kworker/u16:13/3787:
> > Jul 10 16:12:52 qca-HP-ZBook-14-G2 kernel:  #0: ffff888100dee148 ((wq_completion)async){+.+.}-{0:0}, at: process_one_work+0xe97/0x14b0
> > Jul 10 16:12:52 qca-HP-ZBook-14-G2 kernel:  #1: ffff88813f22fd30 ((work_completion)(&entry->work)){+.+.}-{0:0}, at: process_one_work+0x7f6/0x14b0
> > Jul 10 16:12:52 qca-HP-ZBook-14-G2 kernel:  #2: ffff8881049241b0 (&dev->mutex){....}-{4:4}, at: device_suspend+0x3bd/0xdc0
> > Jul 10 16:12:52 qca-HP-ZBook-14-G2 kernel:  #3: ffffffff8a2e4b80 (console_lock){+.+.}-{0:0}, at: radeon_suspend_kms+0x63b/0x7d0 [radeon]
> > Jul 10 16:12:52 qca-HP-ZBook-14-G2 kernel:
> >                                            stack backtrace:
> > Jul 10 16:12:52 qca-HP-ZBook-14-G2 kernel: CPU: 0 UID: 0 PID: 3787 Comm: kworker/u16:13 Not tainted 6.16.0-rc5+ #6 PREEMPT(voluntary)
> > Jul 10 16:12:52 qca-HP-ZBook-14-G2 kernel: Hardware name: Hewlett-Packard HP ZBook 14 G2/2216, BIOS M71 Ver. 01.31 02/24/2020
> > Jul 10 16:12:52 qca-HP-ZBook-14-G2 kernel: Workqueue: async async_run_entry_fn
> > Jul 10 16:12:52 qca-HP-ZBook-14-G2 kernel: Call Trace:
> > Jul 10 16:12:52 qca-HP-ZBook-14-G2 kernel:  <TASK>
> > Jul 10 16:12:52 qca-HP-ZBook-14-G2 kernel:  dump_stack_lvl+0x5b/0x80
> > Jul 10 16:12:52 qca-HP-ZBook-14-G2 kernel:  print_circular_bug.cold+0x178/0x1be
> > Jul 10 16:12:52 qca-HP-ZBook-14-G2 kernel:  check_noncircular+0x130/0x150
> > Jul 10 16:12:52 qca-HP-ZBook-14-G2 kernel:  ? 0xffffffffc1600000
> > Jul 10 16:12:52 qca-HP-ZBook-14-G2 kernel:  ? radeon_suspend_kms+0x63b/0x7d0 [radeon]
> > Jul 10 16:12:52 qca-HP-ZBook-14-G2 kernel:  __lock_acquire+0x15b5/0x2ac0
> > Jul 10 16:12:52 qca-HP-ZBook-14-G2 kernel:  lock_acquire+0x154/0x2d0
> > Jul 10 16:12:52 qca-HP-ZBook-14-G2 kernel:  ? drm_client_dev_suspend+0x37/0x250 [drm]
> > Jul 10 16:12:52 qca-HP-ZBook-14-G2 kernel:  ? __pfx_stack_trace_save+0x10/0x10
> > Jul 10 16:12:52 qca-HP-ZBook-14-G2 kernel:  ? acpi_ut_release_mutex+0xba/0x150
> > Jul 10 16:12:52 qca-HP-ZBook-14-G2 kernel:  __mutex_lock+0x15f/0x12c0
> > Jul 10 16:12:52 qca-HP-ZBook-14-G2 kernel:  ? drm_client_dev_suspend+0x37/0x250 [drm]
> > Jul 10 16:12:52 qca-HP-ZBook-14-G2 kernel:  ? drm_client_dev_suspend+0x37/0x250 [drm]
> > Jul 10 16:12:52 qca-HP-ZBook-14-G2 kernel:  ? add_lock_to_list+0x2c/0x1b0
> > Jul 10 16:12:52 qca-HP-ZBook-14-G2 kernel:  ? __pfx___mutex_lock+0x10/0x10
> > Jul 10 16:12:52 qca-HP-ZBook-14-G2 kernel:  ? lock_acquire+0x154/0x2d0
> > Jul 10 16:12:52 qca-HP-ZBook-14-G2 kernel:  ? radeon_suspend_kms+0x63b/0x7d0 [radeon]
> > Jul 10 16:12:52 qca-HP-ZBook-14-G2 kernel:  ? drm_client_dev_suspend+0x37/0x250 [drm]
> > Jul 10 16:12:52 qca-HP-ZBook-14-G2 kernel:  drm_client_dev_suspend+0x37/0x250 [drm]
> > Jul 10 16:12:52 qca-HP-ZBook-14-G2 kernel:  radeon_suspend_kms+0x648/0x7d0 [radeon]
> > Jul 10 16:12:52 qca-HP-ZBook-14-G2 kernel:  ? __pfx_radeon_pmops_suspend+0x10/0x10 [radeon]
> > Jul 10 16:12:52 qca-HP-ZBook-14-G2 kernel:  pci_pm_suspend+0x1e3/0x4f0
> > Jul 10 16:12:52 qca-HP-ZBook-14-G2 kernel:  ? __pfx_pci_pm_suspend+0x10/0x10
> > Jul 10 16:12:52 qca-HP-ZBook-14-G2 kernel:  dpm_run_callback+0xa0/0x100
> > Jul 10 16:12:52 qca-HP-ZBook-14-G2 kernel:  ? __pfx_dpm_run_callback+0x10/0x10
> > Jul 10 16:12:52 qca-HP-ZBook-14-G2 kernel:  device_suspend+0x41e/0xdc0
> > Jul 10 16:12:52 qca-HP-ZBook-14-G2 kernel:  ? __pfx_device_suspend+0x10/0x10
> > Jul 10 16:12:52 qca-HP-ZBook-14-G2 kernel:  ? __pfx_async_suspend+0x10/0x10
> > Jul 10 16:12:52 qca-HP-ZBook-14-G2 kernel:  async_suspend+0x1d/0x30
> > Jul 10 16:12:52 qca-HP-ZBook-14-G2 kernel:  async_run_entry_fn+0x96/0x3e0
> > Jul 10 16:12:52 qca-HP-ZBook-14-G2 kernel:  process_one_work+0x86e/0x14b0
> > Jul 10 16:12:52 qca-HP-ZBook-14-G2 kernel:  ? __pfx_process_one_work+0x10/0x10
> > Jul 10 16:12:52 qca-HP-ZBook-14-G2 kernel:  ? assign_work+0x16c/0x240
> > Jul 10 16:12:52 qca-HP-ZBook-14-G2 kernel:  worker_thread+0x5d0/0xfc0
> > Jul 10 16:12:52 qca-HP-ZBook-14-G2 kernel:  ? __pfx_worker_thread+0x10/0x10
> > Jul 10 16:12:52 qca-HP-ZBook-14-G2 kernel:  kthread+0x375/0x750
> > Jul 10 16:12:52 qca-HP-ZBook-14-G2 kernel:  ? __pfx_kthread+0x10/0x10
> > Jul 10 16:12:52 qca-HP-ZBook-14-G2 kernel:  ? ret_from_fork+0x1f/0x2f0
> > Jul 10 16:12:52 qca-HP-ZBook-14-G2 kernel:  ? lock_release+0xc6/0x2a0
> > Jul 10 16:12:52 qca-HP-ZBook-14-G2 kernel:  ? __pfx_kthread+0x10/0x10
> > Jul 10 16:12:52 qca-HP-ZBook-14-G2 kernel:  ret_from_fork+0x215/0x2f0
> > Jul 10 16:12:52 qca-HP-ZBook-14-G2 kernel:  ? __pfx_kthread+0x10/0x10
> > Jul 10 16:12:52 qca-HP-ZBook-14-G2 kernel:  ret_from_fork_asm+0x1a/0x30
> > Jul 10 16:12:52 qca-HP-ZBook-14-G2 kernel:  </TASK>
> >
> > This doesn't seem to be the cause of the ath12k issue I'm debugging,
> > but thought it worth mentioning since I only see one similar report
> > on lore, and that didn't have any apparent follow-up:
> > https://lore.kernel.org/all/20250202161048.373f89c0@yea/
> >
> > /jeff
> 
> --
> Simona Vetter
> Software Engineer, Intel Corporation
> http://blog.ffwll.ch

-- 
Ville Syrjälä
Intel

