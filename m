Return-Path: <linux-kernel+bounces-802423-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EF7C1B45246
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 10:58:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8DBF67B6796
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 08:56:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EE7F304971;
	Fri,  5 Sep 2025 08:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="ZMDciYUV"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC96D27EFF1
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 08:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757062700; cv=none; b=lBKTPzodlBWcVjYe/YDlpQp5eK3wHiQcBPDpftova6vcBEI53bcIxWaNkrvh1dqFL12oImLukYgWGPLil+q5qP1PX21J25gntjfzdgA7ue5moGahDCVGrjiZynvMnJqL2b6QBSLrcsC4TcBe0I2x37gk5tGtY+NTkVuCXx50OBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757062700; c=relaxed/simple;
	bh=R0l4XrPwXgzBxVkQOZKkFG7NHoT9MIdOrDwhEx40wD8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=HpqPDPXhtx6t/6ZR193Lnojdq2JFOzA/jvgsMZ6eWbjrlYR9tYBQ7dQj2qM72XER6cdNJJG9np9hmmlJgNtBNCp42JCnoQoeNOSBo9CUDhOvez894jbS7JNxw89JydEef1NCDw5kE8ZQGv+2WYTdsw6yXx5YWnvKpkaC8NUvCnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=ZMDciYUV; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-45dda7d87faso1829285e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 05 Sep 2025 01:58:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1757062695; x=1757667495; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7V3pgdSHRJyKNYS9vikNrp4o7srnjxgZBD+Za6Nu15Y=;
        b=ZMDciYUVrKm0mi2C0/6OftiXnWCM5NneqyfJJYvlPkxjqu4y3KTJNlaoamY4+4YSHi
         DMoMK+/lqyUlj98SxfgQc8mQFZ2P2mp2v8id/THLWDBWNS5pTdNKUOdfDgXn/AfioKNN
         fFfJbmdQMpfhhXMeF7xpph14y1+7auVuS6+cVI2Q5OOH5uAHHQCnPQobMuNjTVnsGeCy
         7mIPbA110t3CmD4Vly/aAlVi6P+7qFuiGgTT8tDqLOmB/TcocEHJ8gDTm6l5Co4rs5tv
         c9AR1Lm2Um5LxFKqZZ+5Cmj8SvfIqvQvEC+8EEwFUjgX//cj4WeV5LZE9m4nl+vhcJ4V
         FV7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757062695; x=1757667495;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7V3pgdSHRJyKNYS9vikNrp4o7srnjxgZBD+Za6Nu15Y=;
        b=YWbu/4G0yVBMlDuWFimbvH3qJLEjR5EbvE4oZiEucs3409MERZSh6FHaaKNQsvwShW
         HvG52rRZa3gk5CmC9YOaiey8LUEbJT+/iQW9/eb4Umco83FiCZdFMUSoLffq5LIjx1AH
         ZuMPPewTZmjksPX/NRCCP4X8egcoS3xXQTtHIA2j6ZykyruZXpRZaLz+OZRXJ38pJG3d
         5fTo1ST4MjhlxLRnUYQ3NzBYBUSUfKpyNb/gl8odZ48tGwSg7A9974CazCBbYl0Bi9CZ
         22q5r5KVypaBD8Hv87LLLbgdZzI/SkvNCMiFBqR30VMf+sBeGuxiQdSxD4c/L8BlFItH
         0HBw==
X-Gm-Message-State: AOJu0Yz8oxzqbDxh5ZcTZTOFCdTCQl4wUlOOVOxawZn6FPcrDjXNPFRO
	phPKs8Oal7LZvvyBYVyR/ncJZFAJyTBud+KPASrsTw8ezDS++Hg4wOoZEoVMgKybqIEOTRZFAT2
	ZFygP
X-Gm-Gg: ASbGncswATBjtl7Ik8QUx4OSJN3ou0/rhM84Dyo0FFxCQnYn9mYCaC9IKFhETDU5BLe
	zusawlIVwZ2R1pNyUjyuxob+O9HEW96VjE1LR3rAxFYAWAZrRhNofN9H+2zb4G59rao3umNImGR
	hMZArWQpkURaN25UAo2Q83fWgh/MKvHYGsTyY7Rw5bP3hlTKZRro1uAjVInITG+0dz2AgAqHlXq
	wIHeGOzPlAFbNcZfwKNhHnu0RcS+//9y560MLV6KqxHsU0agputu8il9LYjhRDO5d07LHS5DGXg
	1myB5ye+s9hOr/4WHj9aBb2H1HR3c6DOsQz3E3+crRbflDVCxWncQEoMxVwbrZ/apNOX1vzhQ3e
	0xp3fpAVM+m/2A2hJlfvC+NYPmfH/tu9A7Pe+c/z47CZBgk4=
X-Google-Smtp-Source: AGHT+IEQMR1u/jnMHBYtbFlF7cZx1C2BRvYwWr0K4/ww9MjlI6VkyOS8D8Q9WiuaPg3IBgJzA/oyRQ==
X-Received: by 2002:a05:600c:4686:b0:45d:db2a:ce3e with SMTP id 5b1f17b1804b1-45ddb2acfc0mr5014375e9.9.1757062694723;
        Fri, 05 Sep 2025 01:58:14 -0700 (PDT)
Received: from localhost.localdomain ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b81a9e971sm334698915e9.18.2025.09.05.01.58.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Sep 2025 01:58:14 -0700 (PDT)
From: Marco Crivellari <marco.crivellari@suse.com>
To: linux-kernel@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Michal Hocko <mhocko@suse.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 0/3] drivers: replace wq users and add WQ_PERCPU to alloc_workqueue() users
Date: Fri,  5 Sep 2025 10:57:58 +0200
Message-ID: <20250905085801.98754-1-marco.crivellari@suse.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi!

Below is a summary of a discussion about the Workqueue API and cpu isolation
considerations. Details and more information are available here:

        "workqueue: Always use wq_select_unbound_cpu() for WORK_CPU_UNBOUND."
        https://lore.kernel.org/all/20250221112003.1dSuoGyc@linutronix.de/

=== Current situation: problems ===

Let's consider a nohz_full system with isolated CPUs: wq_unbound_cpumask is
set to the housekeeping CPUs, for !WQ_UNBOUND the local CPU is selected.

This leads to different scenarios if a work item is scheduled on an isolated
CPU where "delay" value is 0 or greater then 0:
        schedule_delayed_work(, 0);

This will be handled by __queue_work() that will queue the work item on the
current local (isolated) CPU, while:

        schedule_delayed_work(, 1);

Will move the timer on an housekeeping CPU, and schedule the work there.

Currently if a user enqueue a work item using schedule_delayed_work() the
used wq is "system_wq" (per-cpu wq) while queue_delayed_work() use
WORK_CPU_UNBOUND (used when a cpu is not specified). The same applies to
schedule_work() that is using system_wq and queue_work(), that makes use
again of WORK_CPU_UNBOUND.

This lack of consistentcy cannot be addressed without refactoring the API.

=== Plan and future plans ===

This patchset is the first stone on a refactoring needed in order to
address the points aforementioned; it will have a positive impact also
on the cpu isolation, in the long term, moving away percpu workqueue in
favor to an unbound model.

These are the main steps:
1)  API refactoring (that this patch is introducing)
    -   Make more clear and uniform the system wq names, both per-cpu and
        unbound. This to avoid any possible confusion on what should be
        used.

    -   Introduction of WQ_PERCPU: this flag is the complement of WQ_UNBOUND,
        introduced in this patchset and used on all the callers that are not
        currently using WQ_UNBOUND.

        WQ_UNBOUND will be removed in a future release cycle.

        Most users don't need to be per-cpu, because they don't have
        locality requirements, because of that, a next future step will be
        make "unbound" the default behavior.

2)  Check who really needs to be per-cpu
    -   Remove the WQ_PERCPU flag when is not strictly required.

3)  Add a new API (prefer local cpu)
    -   There are users that don't require a local execution, like mentioned
        above; despite that, local execution yeld to performance gain.

        This new API will prefer the local execution, without requiring it.

=== Introduced Changes by this series ===

1) [P 1-2] Replace use of system_wq and system_unbound_wq

        system_wq is a per-CPU workqueue, but his name is not clear.
        system_unbound_wq is to be used when locality is not required.

        Because of that, system_wq has been renamed in system_percpu_wq, and
        system_unbound_wq has been renamed in system_dfl_wq.

2) [P 3] add WQ_PERCPU to remaining alloc_workqueue() users

        Every alloc_workqueue() caller should use one among WQ_PERCPU or
        WQ_UNBOUND. This is actually enforced warning if both or none of them
        are present at the same time.

        WQ_UNBOUND will be removed in a next release cycle.

=== For Maintainers ===

There are prerequisites for this series, already merged in the master branch.
The commits are:

128ea9f6ccfb6960293ae4212f4f97165e42222d ("workqueue: Add system_percpu_wq and
system_dfl_wq")

930c2ea566aff59e962c50b2421d5fcc3b98b8be ("workqueue: Add new WQ_PERCPU flag")


Thanks!

Marco Crivellari (3):
  drivers: replace use of system_unbound_wq with system_dfl_wq
  drivers: replace use of system_wq with system_percpu_wq
  drivers: WQ_PERCPU added to alloc_workqueue users

 drivers/accel/ivpu/ivpu_hw_btrs.c             |  2 +-
 drivers/accel/ivpu/ivpu_ipc.c                 |  2 +-
 drivers/accel/ivpu/ivpu_job.c                 |  2 +-
 drivers/accel/ivpu/ivpu_mmu.c                 |  2 +-
 drivers/accel/ivpu/ivpu_pm.c                  |  4 +--
 drivers/acpi/ec.c                             |  3 +-
 drivers/acpi/osl.c                            |  6 ++--
 drivers/acpi/scan.c                           |  2 +-
 drivers/acpi/thermal.c                        |  3 +-
 drivers/ata/libata-sff.c                      |  3 +-
 drivers/base/core.c                           |  2 +-
 drivers/base/dd.c                             |  2 +-
 drivers/base/devcoredump.c                    |  2 +-
 drivers/bus/mhi/ep/main.c                     |  2 +-
 drivers/char/random.c                         |  8 ++---
 drivers/char/tpm/tpm-dev-common.c             |  3 +-
 drivers/char/xillybus/xillybus_core.c         |  2 +-
 drivers/char/xillybus/xillyusb.c              |  4 +--
 drivers/cpufreq/tegra194-cpufreq.c            |  3 +-
 drivers/crypto/atmel-i2c.c                    |  2 +-
 drivers/crypto/cavium/nitrox/nitrox_mbx.c     |  2 +-
 drivers/crypto/intel/qat/qat_common/adf_aer.c |  4 +--
 drivers/crypto/intel/qat/qat_common/adf_isr.c |  3 +-
 .../crypto/intel/qat/qat_common/adf_sriov.c   |  3 +-
 .../crypto/intel/qat/qat_common/adf_vf_isr.c  |  3 +-
 drivers/cxl/pci.c                             |  2 +-
 drivers/extcon/extcon-intel-int3496.c         |  4 +--
 drivers/firewire/core-transaction.c           |  3 +-
 drivers/firewire/ohci.c                       |  3 +-
 drivers/gpio/gpiolib-cdev.c                   |  4 +--
 drivers/gpu/drm/amd/amdgpu/aldebaran.c        |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    |  6 ++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c     |  2 +-
 drivers/gpu/drm/amd/amdkfd/kfd_process.c      |  3 +-
 drivers/gpu/drm/bridge/analogix/anx7625.c     |  3 +-
 drivers/gpu/drm/bridge/ite-it6505.c           |  2 +-
 drivers/gpu/drm/bridge/ti-tfp410.c            |  2 +-
 drivers/gpu/drm/drm_atomic_helper.c           |  6 ++--
 drivers/gpu/drm/drm_probe_helper.c            |  2 +-
 drivers/gpu/drm/drm_self_refresh_helper.c     |  2 +-
 drivers/gpu/drm/exynos/exynos_hdmi.c          |  2 +-
 .../drm/i915/display/intel_display_driver.c   |  3 +-
 .../drm/i915/display/intel_display_power.c    |  2 +-
 drivers/gpu/drm/i915/display/intel_tc.c       |  4 +--
 drivers/gpu/drm/i915/gem/i915_gem_ttm_move.c  |  2 +-
 drivers/gpu/drm/i915/gt/uc/intel_guc.c        |  4 +--
 drivers/gpu/drm/i915/gt/uc/intel_guc_ct.c     |  4 +--
 .../gpu/drm/i915/gt/uc/intel_guc_submission.c |  6 ++--
 drivers/gpu/drm/i915/i915_active.c            |  2 +-
 drivers/gpu/drm/i915/i915_driver.c            |  5 ++--
 drivers/gpu/drm/i915/i915_drv.h               |  2 +-
 drivers/gpu/drm/i915/i915_sw_fence_work.c     |  2 +-
 drivers/gpu/drm/i915/i915_vma_resource.c      |  2 +-
 drivers/gpu/drm/i915/pxp/intel_pxp.c          |  2 +-
 drivers/gpu/drm/i915/pxp/intel_pxp_irq.c      |  2 +-
 .../gpu/drm/i915/selftests/i915_sw_fence.c    |  2 +-
 .../gpu/drm/i915/selftests/mock_gem_device.c  |  2 +-
 drivers/gpu/drm/nouveau/dispnv50/disp.c       |  2 +-
 drivers/gpu/drm/nouveau/nouveau_drm.c         |  2 +-
 drivers/gpu/drm/nouveau/nouveau_sched.c       |  3 +-
 drivers/gpu/drm/radeon/radeon_display.c       |  3 +-
 .../gpu/drm/rockchip/dw_hdmi_qp-rockchip.c    |  4 +--
 drivers/gpu/drm/rockchip/rockchip_drm_vop.c   |  2 +-
 drivers/gpu/drm/scheduler/sched_main.c        |  2 +-
 drivers/gpu/drm/tilcdc/tilcdc_crtc.c          |  2 +-
 drivers/gpu/drm/vc4/vc4_hdmi.c                |  4 +--
 drivers/gpu/drm/xe/xe_devcoredump.c           |  2 +-
 drivers/gpu/drm/xe/xe_device.c                |  4 +--
 drivers/gpu/drm/xe/xe_execlist.c              |  2 +-
 drivers/gpu/drm/xe/xe_ggtt.c                  |  2 +-
 drivers/gpu/drm/xe/xe_gt_tlb_invalidation.c   |  6 ++--
 drivers/gpu/drm/xe/xe_guc_ct.c                |  4 +--
 drivers/gpu/drm/xe/xe_hw_engine_group.c       |  3 +-
 drivers/gpu/drm/xe/xe_oa.c                    |  2 +-
 drivers/gpu/drm/xe/xe_pt.c                    |  2 +-
 drivers/gpu/drm/xe/xe_sriov.c                 |  2 +-
 drivers/gpu/drm/xe/xe_vm.c                    |  4 +--
 drivers/greybus/operation.c                   |  2 +-
 drivers/hid/hid-nintendo.c                    |  3 +-
 drivers/hte/hte.c                             |  2 +-
 drivers/hv/mshv_eventfd.c                     |  2 +-
 drivers/i3c/master.c                          |  2 +-
 drivers/iio/adc/pac1934.c                     |  2 +-
 drivers/infiniband/core/cm.c                  |  2 +-
 drivers/infiniband/core/device.c              |  4 +--
 drivers/infiniband/core/ucma.c                |  2 +-
 drivers/infiniband/hw/hfi1/init.c             |  3 +-
 drivers/infiniband/hw/hfi1/opfn.c             |  3 +-
 drivers/infiniband/hw/mlx4/cm.c               |  2 +-
 drivers/infiniband/hw/mlx5/odp.c              |  4 +--
 drivers/infiniband/sw/rdmavt/cq.c             |  3 +-
 drivers/infiniband/ulp/iser/iscsi_iser.c      |  2 +-
 drivers/infiniband/ulp/isert/ib_isert.c       |  2 +-
 drivers/infiniband/ulp/rtrs/rtrs-clt.c        |  2 +-
 drivers/infiniband/ulp/rtrs/rtrs-srv.c        |  2 +-
 drivers/input/keyboard/gpio_keys.c            |  2 +-
 drivers/input/misc/palmas-pwrbutton.c         |  2 +-
 drivers/input/mouse/psmouse-smbus.c           |  2 +-
 drivers/input/mouse/synaptics_i2c.c           |  8 ++---
 drivers/isdn/capi/kcapi.c                     |  2 +-
 drivers/leds/trigger/ledtrig-input-events.c   |  2 +-
 drivers/md/bcache/btree.c                     |  3 +-
 drivers/md/bcache/super.c                     | 30 ++++++++++---------
 drivers/md/bcache/writeback.c                 |  2 +-
 drivers/md/dm-bufio.c                         |  3 +-
 drivers/md/dm-cache-target.c                  |  3 +-
 drivers/md/dm-clone-target.c                  |  3 +-
 drivers/md/dm-crypt.c                         |  6 ++--
 drivers/md/dm-delay.c                         |  4 ++-
 drivers/md/dm-integrity.c                     | 15 ++++++----
 drivers/md/dm-kcopyd.c                        |  3 +-
 drivers/md/dm-log-userspace-base.c            |  3 +-
 drivers/md/dm-mpath.c                         |  5 ++--
 drivers/md/dm-raid1.c                         |  5 ++--
 drivers/md/dm-snap-persistent.c               |  3 +-
 drivers/md/dm-stripe.c                        |  2 +-
 drivers/md/dm-verity-target.c                 |  4 ++-
 drivers/md/dm-writecache.c                    |  3 +-
 drivers/md/dm.c                               |  3 +-
 drivers/md/md.c                               |  4 +--
 drivers/media/pci/ddbridge/ddbridge-core.c    |  2 +-
 .../platform/mediatek/mdp3/mtk-mdp3-core.c    |  6 ++--
 .../platform/synopsys/hdmirx/snps_hdmirx.c    |  8 ++---
 drivers/message/fusion/mptbase.c              |  7 +++--
 drivers/mmc/core/block.c                      |  3 +-
 drivers/mmc/host/mtk-sd.c                     |  4 +--
 drivers/mmc/host/omap.c                       |  2 +-
 drivers/nvdimm/security.c                     |  4 +--
 drivers/nvme/host/tcp.c                       |  2 ++
 drivers/nvme/target/admin-cmd.c               |  2 +-
 drivers/nvme/target/core.c                    |  5 ++--
 drivers/nvme/target/fabrics-cmd-auth.c        |  2 +-
 drivers/nvme/target/fc.c                      |  6 ++--
 drivers/nvme/target/tcp.c                     |  2 +-
 drivers/pci/endpoint/functions/pci-epf-mhi.c  |  2 +-
 drivers/pci/endpoint/functions/pci-epf-ntb.c  |  5 ++--
 drivers/pci/endpoint/functions/pci-epf-test.c |  3 +-
 drivers/pci/endpoint/functions/pci-epf-vntb.c |  5 ++--
 drivers/pci/endpoint/pci-ep-cfs.c             |  2 +-
 drivers/pci/hotplug/pnv_php.c                 |  3 +-
 drivers/pci/hotplug/shpchp_core.c             |  3 +-
 drivers/phy/allwinner/phy-sun4i-usb.c         | 14 ++++-----
 .../platform/cznic/turris-omnia-mcu-gpio.c    |  2 +-
 .../surface/aggregator/ssh_packet_layer.c     |  2 +-
 .../surface/aggregator/ssh_request_layer.c    |  2 +-
 .../platform/surface/surface_acpi_notify.c    |  2 +-
 drivers/platform/x86/gpd-pocket-fan.c         |  4 +--
 .../x86/x86-android-tablets/vexia_atla10_ec.c |  2 +-
 drivers/rapidio/rio.c                         |  2 +-
 drivers/ras/cec.c                             |  2 +-
 drivers/regulator/irq_helpers.c               |  2 +-
 drivers/regulator/qcom-labibb-regulator.c     |  4 +--
 drivers/scsi/be2iscsi/be_main.c               |  3 +-
 drivers/scsi/bnx2fc/bnx2fc_fcoe.c             |  2 +-
 drivers/scsi/device_handler/scsi_dh_alua.c    |  2 +-
 drivers/scsi/fcoe/fcoe.c                      |  2 +-
 drivers/scsi/ibmvscsi_tgt/ibmvscsi_tgt.c      |  3 +-
 drivers/scsi/lpfc/lpfc_init.c                 |  2 +-
 drivers/scsi/pm8001/pm8001_init.c             |  2 +-
 drivers/scsi/qedf/qedf_main.c                 | 15 ++++++----
 drivers/scsi/qedi/qedi_main.c                 |  2 +-
 drivers/scsi/qla2xxx/qla_os.c                 |  4 +--
 drivers/scsi/qla2xxx/qla_target.c             |  2 +-
 drivers/scsi/qla2xxx/tcm_qla2xxx.c            |  2 +-
 drivers/scsi/qla4xxx/ql4_os.c                 |  3 +-
 drivers/scsi/scsi_transport_fc.c              |  7 +++--
 drivers/scsi/scsi_transport_iscsi.c           |  2 +-
 drivers/soc/fsl/qbman/qman.c                  |  2 +-
 drivers/soc/xilinx/zynqmp_power.c             |  6 ++--
 drivers/staging/greybus/sdio.c                |  2 +-
 drivers/target/sbp/sbp_target.c               |  8 ++---
 drivers/target/target_core_transport.c        |  4 +--
 drivers/target/target_core_xcopy.c            |  2 +-
 drivers/target/tcm_fc/tfc_conf.c              |  2 +-
 drivers/thunderbolt/tb.c                      |  2 +-
 drivers/tty/serial/8250/8250_dw.c             |  4 +--
 drivers/tty/tty_buffer.c                      |  8 ++---
 drivers/usb/core/hub.c                        |  2 +-
 drivers/usb/dwc3/gadget.c                     |  2 +-
 drivers/usb/gadget/function/f_hid.c           |  3 +-
 drivers/usb/host/xhci-dbgcap.c                |  8 ++---
 drivers/usb/host/xhci-ring.c                  |  2 +-
 drivers/usb/storage/uas.c                     |  2 +-
 drivers/usb/typec/anx7411.c                   |  3 +-
 drivers/vdpa/vdpa_user/vduse_dev.c            |  3 +-
 drivers/virtio/virtio_balloon.c               |  3 +-
 drivers/xen/events/events_base.c              |  6 ++--
 drivers/xen/privcmd.c                         |  3 +-
 188 files changed, 351 insertions(+), 286 deletions(-)

-- 
2.51.0


