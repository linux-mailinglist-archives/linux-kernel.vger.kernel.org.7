Return-Path: <linux-kernel+bounces-784860-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CD5EB342AD
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 16:07:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D5595E5A52
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 14:01:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1F722F0C48;
	Mon, 25 Aug 2025 13:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j/hyZk1r"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 070942F0C50
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 13:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756130150; cv=none; b=SXF0jtGLCWY6eHe3K0HZmLgijHI7669sQvBQJQuDZHEXTqGAcbC6i9e1EGN7vYCXxU/x8U9p7jbh/S5XGCRkKPaRJ/alhuM+10zJFVfJN9b6JqPoU39SYW9igJ23vaZfIXr304zGLH5adI19l2RE48bwpSD8XstE9/KbVSpIrAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756130150; c=relaxed/simple;
	bh=nxg+4jQHmo0Wj9W8MhRh0pe+y7ovO9YwWxScRPr7A/k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AMyDITeviBlNkvPKTVBB5yX6VgK03rfel9G995nNvyRO5NW7NwbZplwtgEEHYyrGnqr83JeVGdB0Qk4CV6jQ/L+oF+4NwzsenqqXaLoOSvW9Vruq8bMFX8vQgTOMoq4T30YGEgPP3MgvMYgSRTIbKlYlD8jJeQTzOX7XscdJamY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j/hyZk1r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C419C4CEED;
	Mon, 25 Aug 2025 13:55:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756130149;
	bh=nxg+4jQHmo0Wj9W8MhRh0pe+y7ovO9YwWxScRPr7A/k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=j/hyZk1r0B1ABFPys1S0Qh5i9kwsneVulK2sLpVoDf8Yz+yX7Kwd+7wAhI4Ym049k
	 sWV3b/x3tavBpZxPIN29w+yagmjQ6Pah9zA6mNYPpSAUaV7bvWZ72h6MQfz6OV8KBH
	 Vcj5cjGDIU3lHypHfQE/VlnbHzlEocH9OxUU6QaU7ARi2qy6vpkM1hCCoysQM/IzXc
	 GWJOzehxd9R+PlA7ZmSlaY0wylWsJk0Q6KkJp5X8b/qbawcpEj+W2384aUslvr6lOb
	 Q870Uk+ubQCp78I8xx3Ig/PK+kSc6q4VZ57szgdEwNFx6H/8O2qwM4wNvXZ8QRMjDm
	 eRlNgBjEj6Gpw==
Date: Mon, 25 Aug 2025 15:55:46 +0200
From: Frederic Weisbecker <frederic@kernel.org>
To: Marco Crivellari <marco.crivellari@suse.com>
Cc: linux-kernel@vger.kernel.org, Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Michal Hocko <mhocko@suse.com>
Subject: Re: [PATCH v2 1/4] Workqueue: replace use of system_wq with
 system_percpu_wq
Message-ID: <aKxrYlx1Rzvp8ebO@localhost.localdomain>
References: <20250825132906.1050437-1-marco.crivellari@suse.com>
 <20250825132906.1050437-2-marco.crivellari@suse.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250825132906.1050437-2-marco.crivellari@suse.com>

Le Mon, Aug 25, 2025 at 03:29:03PM +0200, Marco Crivellari a écrit :
> Currently if a user enqueue a work item using schedule_delayed_work() the
> used wq is "system_wq" (per-cpu wq) while queue_delayed_work() use
> WORK_CPU_UNBOUND (used when a cpu is not specified). The same applies to
> schedule_work() that is using system_wq and queue_work(), that makes use
> again of WORK_CPU_UNBOUND.
> 
> This lack of consistentcy cannot be addressed without refactoring the API.
> 
> system_wq is a per-CPU worqueue, yet nothing in its name tells about that
> CPU affinity constraint, which is very often not required by users. Make
> it clear by adding a system_percpu_wq.
> 
> queue_work() / queue_delayed_work() mod_delayed_work() will now use the
> new per-cpu wq: whether the user still stick on the old name a warn will
> be printed along a wq redirect to the new one.
> 
> This patch add the new system_percpu_wq except for mm, fs and net
> subsystem, whom are handled in separated patches.
> 
> The old wq will be kept for a few release cylces.
> 
> Suggested-by: Tejun Heo <tj@kernel.org>
> Signed-off-by: Marco Crivellari <marco.crivellari@suse.com>
> ---
>  arch/s390/kernel/diag/diag324.c               |  4 ++--
>  arch/s390/kernel/hiperdispatch.c              |  2 +-
>  drivers/accel/ivpu/ivpu_hw_btrs.c             |  2 +-
>  drivers/accel/ivpu/ivpu_ipc.c                 |  2 +-
>  drivers/accel/ivpu/ivpu_job.c                 |  2 +-
>  drivers/accel/ivpu/ivpu_mmu.c                 |  2 +-
>  drivers/accel/ivpu/ivpu_pm.c                  |  2 +-
>  drivers/acpi/osl.c                            |  2 +-
>  drivers/base/devcoredump.c                    |  2 +-
>  drivers/block/nbd.c                           |  2 +-
>  drivers/block/sunvdc.c                        |  2 +-
>  drivers/cxl/pci.c                             |  2 +-
>  drivers/extcon/extcon-intel-int3496.c         |  4 ++--
>  drivers/gpio/gpiolib-cdev.c                   |  4 ++--
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    |  4 ++--
>  drivers/gpu/drm/bridge/ite-it6505.c           |  2 +-
>  drivers/gpu/drm/bridge/ti-tfp410.c            |  2 +-
>  drivers/gpu/drm/drm_probe_helper.c            |  2 +-
>  drivers/gpu/drm/drm_self_refresh_helper.c     |  2 +-
>  drivers/gpu/drm/exynos/exynos_hdmi.c          |  2 +-
>  drivers/gpu/drm/i915/i915_driver.c            |  2 +-
>  drivers/gpu/drm/i915/i915_drv.h               |  2 +-
>  .../gpu/drm/rockchip/dw_hdmi_qp-rockchip.c    |  4 ++--
>  drivers/gpu/drm/scheduler/sched_main.c        |  2 +-
>  drivers/gpu/drm/tilcdc/tilcdc_crtc.c          |  2 +-
>  drivers/gpu/drm/vc4/vc4_hdmi.c                |  4 ++--
>  drivers/gpu/drm/xe/xe_gt_tlb_invalidation.c   |  6 ++---
>  drivers/gpu/drm/xe/xe_pt.c                    |  2 +-
>  drivers/iio/adc/pac1934.c                     |  2 +-
>  drivers/input/keyboard/gpio_keys.c            |  2 +-
>  drivers/input/misc/palmas-pwrbutton.c         |  2 +-
>  drivers/input/mouse/synaptics_i2c.c           |  8 +++----
>  drivers/leds/trigger/ledtrig-input-events.c   |  2 +-
>  drivers/md/bcache/super.c                     | 20 ++++++++---------
>  drivers/mmc/host/mtk-sd.c                     |  4 ++--
>  drivers/net/ethernet/sfc/efx_channels.c       |  2 +-
>  drivers/net/ethernet/sfc/siena/efx_channels.c |  2 +-
>  drivers/net/phy/sfp.c                         | 12 +++++-----
>  drivers/net/wireless/intel/ipw2x00/ipw2100.c  |  6 ++---
>  drivers/net/wireless/intel/ipw2x00/ipw2200.c  |  2 +-
>  drivers/net/wireless/intel/iwlwifi/mvm/tdls.c |  6 ++---
>  .../net/wireless/mediatek/mt76/mt7921/init.c  |  2 +-
>  .../net/wireless/mediatek/mt76/mt7925/init.c  |  2 +-
>  drivers/nvdimm/security.c                     |  4 ++--
>  drivers/nvme/target/admin-cmd.c               |  2 +-
>  drivers/nvme/target/fabrics-cmd-auth.c        |  2 +-
>  drivers/pci/endpoint/pci-ep-cfs.c             |  2 +-
>  drivers/phy/allwinner/phy-sun4i-usb.c         | 14 ++++++------
>  .../platform/cznic/turris-omnia-mcu-gpio.c    |  2 +-
>  .../surface/aggregator/ssh_packet_layer.c     |  2 +-
>  .../surface/aggregator/ssh_request_layer.c    |  2 +-
>  drivers/platform/x86/gpd-pocket-fan.c         |  4 ++--
>  .../x86/x86-android-tablets/vexia_atla10_ec.c |  2 +-
>  drivers/power/supply/bq2415x_charger.c        |  2 +-
>  drivers/power/supply/bq24190_charger.c        |  2 +-
>  drivers/power/supply/bq27xxx_battery.c        |  6 ++---
>  drivers/power/supply/rk817_charger.c          |  6 ++---
>  drivers/power/supply/ucs1002_power.c          |  2 +-
>  drivers/power/supply/ug3105_battery.c         |  6 ++---
>  drivers/ras/cec.c                             |  2 +-
>  drivers/regulator/irq_helpers.c               |  2 +-
>  drivers/regulator/qcom-labibb-regulator.c     |  4 ++--
>  drivers/thunderbolt/tb.c                      |  2 +-
>  drivers/usb/dwc3/gadget.c                     |  2 +-
>  drivers/usb/host/xhci-dbgcap.c                |  8 +++----
>  drivers/usb/host/xhci-ring.c                  |  2 +-
>  drivers/xen/events/events_base.c              |  6 ++---
>  include/drm/gpu_scheduler.h                   |  2 +-
>  include/linux/closure.h                       |  2 +-
>  include/linux/workqueue.h                     | 22 +++++++++----------
>  io_uring/io_uring.c                           |  2 +-
>  kernel/bpf/cgroup.c                           |  2 +-
>  kernel/bpf/cpumap.c                           |  2 +-
>  kernel/cgroup/cgroup.c                        |  2 +-
>  kernel/module/dups.c                          |  4 ++--
>  kernel/rcu/tasks.h                            |  4 ++--
>  kernel/smp.c                                  |  2 +-
>  kernel/trace/trace_events_user.c              |  2 +-
>  kernel/workqueue.c                            |  2 +-
>  rust/kernel/workqueue.rs                      |  6 ++---
>  sound/soc/codecs/aw88081.c                    |  2 +-
>  sound/soc/codecs/aw88166.c                    |  2 +-
>  sound/soc/codecs/aw88261.c                    |  2 +-
>  sound/soc/codecs/aw88395/aw88395.c            |  2 +-
>  sound/soc/codecs/aw88399.c                    |  2 +-
>  sound/soc/codecs/cs42l43-jack.c               |  6 ++---
>  sound/soc/codecs/cs42l43.c                    |  4 ++--
>  sound/soc/codecs/es8326.c                     | 12 +++++-----
>  sound/soc/codecs/rt5663.c                     |  6 ++---
>  sound/soc/intel/boards/sof_es8336.c           |  2 +-
>  sound/soc/sof/intel/cnl.c                     |  2 +-
>  sound/soc/sof/intel/hda-ipc.c                 |  2 +-

Similar cut needed here.

Thanks.

-- 
Frederic Weisbecker
SUSE Labs

