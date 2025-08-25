Return-Path: <linux-kernel+bounces-784839-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F569B34263
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 15:59:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D91803ABBE8
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 13:56:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A18592F39A4;
	Mon, 25 Aug 2025 13:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AlwIv7L4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEA122F2916
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 13:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756129777; cv=none; b=P9zjgdofygJTvwYyHDkODbKJATql2+XVPsx89F0HCUmik+CPsznPRICGElFR66BLSiQ42IEePMzpB9gHeVKmJ38RiMB2enuaLcUyEvMs2Dd5oiPv8fDCAoj2HsdG0xP/A/UMc/vLmb0XbrJNpZSddj6HCz4Oov6hJHgHocJjd5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756129777; c=relaxed/simple;
	bh=CWzbZet4SwxOJyl9Yc6cOURxcFvzYGgEYdlCYF5i3BA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lh7bI9hqYiBvhYDMOQ6dUhYT8g/QSdHpUwHlwyhp39rGff+ctZzpuj+MVX2ERII+RY621GZk5pNV+yzCDn0+hOtApLmAP5IDkxO/VxBBs/7yRd9X/arLKslbnKEUjU8lFIjacnQEPxAYv2S14Dbt9hLn1ia0cMrME/5TGwUIrkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AlwIv7L4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9E01C4CEED;
	Mon, 25 Aug 2025 13:49:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756129777;
	bh=CWzbZet4SwxOJyl9Yc6cOURxcFvzYGgEYdlCYF5i3BA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AlwIv7L4ODWarF/fn/kZXgUER9iJKIgshLn01P2v8KzHcWE+UbM4AIgvndSwy50rh
	 nRRhgI4XTsE2Plope6FqeaIsrKDADtzB96x4VcWYZsYD2FAkP0TGWek/DuOnp6q63G
	 ieoG+DSelnffHBXufauGWWdJtzzoJtFyIG+3+z6sC7fko7rlw73v3wvp160LsM8BtD
	 J/pMjSs9yVjkhqydiFrZODJTBPIu5K6V/62s0u1+qyAB49rqh1yNeI3J+3eTaLczwu
	 5LSbfDib/WGjzPWRyAoPcaESuVSB6eSLiE1RfOsOUSkyKacPIhz0/TlPyMZu9UoOQn
	 PirOuokj7vjEg==
Date: Mon, 25 Aug 2025 15:49:34 +0200
From: Frederic Weisbecker <frederic@kernel.org>
To: Marco Crivellari <marco.crivellari@suse.com>
Cc: linux-kernel@vger.kernel.org, Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Michal Hocko <mhocko@suse.com>
Subject: Re: [PATCH v2 2/4] Workqueue: replace use of system_unbound_wq with
 system_dfl_wq
Message-ID: <aKxp7h8GWg8cGIla@localhost.localdomain>
References: <20250825132906.1050437-1-marco.crivellari@suse.com>
 <20250825132906.1050437-3-marco.crivellari@suse.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250825132906.1050437-3-marco.crivellari@suse.com>

Le Mon, Aug 25, 2025 at 03:29:04PM +0200, Marco Crivellari a écrit :
> Currently if a user enqueue a work item using schedule_delayed_work() the
> used wq is "system_wq" (per-cpu wq) while queue_delayed_work() use
> WORK_CPU_UNBOUND (used when a cpu is not specified). The same applies to
> schedule_work() that is using system_wq and queue_work(), that makes use
> again of WORK_CPU_UNBOUND.
> 
> This lack of consistentcy cannot be addressed without refactoring the API.
> 
> system_unbound_wq should be the default workqueue so as not to enforce
> locality constraints for random work whenever it's not required.
> 
> Adding system_dfl_wq to encourage its use when unbound work should be used.
> 
> queue_work() / queue_delayed_work() / mod_delayed_work() will now use the
> new unbound wq: whether the user still use the old wq a warn will be
> printed along with a wq redirect to the new one.
> 
> The old system_unbound_wq will be kept for a few release cycles.
> 
> Suggested-by: Tejun Heo <tj@kernel.org>
> Signed-off-by: Marco Crivellari <marco.crivellari@suse.com>

This should be one patch per subsystem. Here is how you can divide that
into a patchset:

> ---
>  drivers/accel/ivpu/ivpu_pm.c                         |  2 +-
>  drivers/acpi/scan.c                                  |  2 +-
>  drivers/base/dd.c                                    |  2 +-
>  drivers/block/zram/zram_drv.c                        |  2 +-
>  drivers/char/random.c                                |  8 ++++----
>  drivers/gpu/drm/amd/amdgpu/aldebaran.c               |  2 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c           |  2 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c            |  2 +-
>  drivers/gpu/drm/drm_atomic_helper.c                  |  6 +++---
>  drivers/gpu/drm/i915/display/intel_display_power.c   |  2 +-
>  drivers/gpu/drm/i915/display/intel_tc.c              |  4 ++--
>  drivers/gpu/drm/i915/gem/i915_gem_ttm_move.c         |  2 +-
>  drivers/gpu/drm/i915/gt/uc/intel_guc.c               |  4 ++--
>  drivers/gpu/drm/i915/gt/uc/intel_guc_ct.c            |  4 ++--
>  drivers/gpu/drm/i915/gt/uc/intel_guc_submission.c    |  6 +++---
>  drivers/gpu/drm/i915/i915_active.c                   |  2 +-
>  drivers/gpu/drm/i915/i915_sw_fence_work.c            |  2 +-
>  drivers/gpu/drm/i915/i915_vma_resource.c             |  2 +-
>  drivers/gpu/drm/i915/pxp/intel_pxp.c                 |  2 +-
>  drivers/gpu/drm/i915/pxp/intel_pxp_irq.c             |  2 +-
>  drivers/gpu/drm/nouveau/dispnv50/disp.c              |  2 +-
>  drivers/gpu/drm/rockchip/rockchip_drm_vop.c          |  2 +-
>  drivers/gpu/drm/xe/xe_devcoredump.c                  |  2 +-
>  drivers/gpu/drm/xe/xe_execlist.c                     |  2 +-
>  drivers/gpu/drm/xe/xe_guc_ct.c                       |  4 ++--
>  drivers/gpu/drm/xe/xe_oa.c                           |  2 +-
>  drivers/gpu/drm/xe/xe_vm.c                           |  4 ++--
>  drivers/hte/hte.c                                    |  2 +-
>  drivers/infiniband/core/ucma.c                       |  2 +-
>  drivers/infiniband/hw/mlx5/odp.c                     |  4 ++--
>  drivers/media/platform/synopsys/hdmirx/snps_hdmirx.c |  8 ++++----
>  drivers/net/macvlan.c                                |  2 +-
>  drivers/net/netdevsim/dev.c                          |  6 +++---
>  drivers/net/wireless/intel/iwlwifi/fw/dbg.c          |  4 ++--
>  drivers/net/wireless/intel/iwlwifi/iwl-trans.h       |  2 +-
>  drivers/scsi/qla2xxx/qla_os.c                        |  2 +-
>  drivers/scsi/scsi_transport_iscsi.c                  |  2 +-
>  drivers/soc/xilinx/zynqmp_power.c                    |  6 +++---
>  drivers/target/sbp/sbp_target.c                      |  8 ++++----
>  drivers/tty/serial/8250/8250_dw.c                    |  4 ++--
>  drivers/tty/tty_buffer.c                             |  8 ++++----

One patch for drivers.

>  fs/afs/callback.c                                    |  4 ++--
>  fs/afs/write.c                                       |  2 +-
>  fs/bcachefs/btree_write_buffer.c                     |  2 +-
>  fs/bcachefs/io_read.c                                | 12 ++++++------
>  fs/bcachefs/journal_io.c                             |  2 +-
>  fs/btrfs/block-group.c                               |  2 +-
>  fs/btrfs/extent_map.c                                |  2 +-
>  fs/btrfs/space-info.c                                |  4 ++--
>  fs/btrfs/zoned.c                                     |  2 +-
>  fs/ext4/mballoc.c                                    |  2 +-
>  fs/netfs/objects.c                                   |  2 +-
>  fs/netfs/read_collect.c                              |  2 +-
>  fs/netfs/write_collect.c                             |  2 +-
>  fs/nfsd/filecache.c                                  |  2 +-
>  fs/notify/mark.c                                     |  4 ++--
>  fs/quota/dquot.c                                     |  2 +-

One for fs.

>  include/linux/workqueue.h                            |  4 ++--

One for workqueue.

>  io_uring/io_uring.c                                  |  2 +-

One for io_uring.

>  kernel/bpf/helpers.c                                 |  4 ++--
>  kernel/bpf/memalloc.c                                |  2 +-
>  kernel/bpf/syscall.c                                 |  2 +-

One for bpf.

>  kernel/padata.c                                      |  4 ++--

One for padata.

>  kernel/sched/core.c                                  |  4 ++--
>  kernel/sched/ext.c                                   |  4 ++--

One for scheduler.

>  kernel/umh.c                                         |  2 +-

One for umh.

>  kernel/workqueue.c                                   |  2 +-

Should join the workqueue change above.

>  mm/backing-dev.c                                     |  2 +-
>  mm/kfence/core.c                                     |  6 +++---
>  mm/memcontrol.c                                      |  4 ++--

One for mm.

>  net/core/link_watch.c                                |  4 ++--
>  net/unix/garbage.c                                   |  2 +-
>  net/wireless/core.c                                  |  4 ++--
>  net/wireless/sysfs.c                                 |  2 +-

One for net.

>  rust/kernel/workqueue.rs                             |  6 +++---

This can join the workqueue changes above.

>  sound/soc/codecs/wm_adsp.c                           |  2 +-

And finally one for sound.

Thanks!

-- 
Frederic Weisbecker
SUSE Labs

