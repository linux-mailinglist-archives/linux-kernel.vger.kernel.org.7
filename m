Return-Path: <linux-kernel+bounces-784756-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F7BFB340AE
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 15:29:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 389481624A7
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 13:29:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4E55273D60;
	Mon, 25 Aug 2025 13:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Pm73BT31"
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31BE8271448
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 13:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756128560; cv=none; b=hVKA0awemaTiKGfr76bzrNLeeNzUHBzSyevY+To5vjTImgEtIST1qsWAo3N03LAcxdLjnHfe1ul0UFNEBOs1AnHYkdaxNfgt0GfrEB0MqkkK4N3WSj30QEBSFJUmwkdFeOjiYYtJCX+RX4b56Cgp3vZocNx29o7tr/giLWnv+EA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756128560; c=relaxed/simple;
	bh=xzKI3HmlsmcIc7ESn/tK9xaT6a8E6j1WXVPP832MxeI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Sy2M6q4PIVNNagrZuaJgTmWw0Am7WMz+p2pbucRQFSYT1Ypjd0mYBxB3zv4SXSvHQST3QYKErwVygNvhtYIgZb0h3OtJa8R+N7qrZR5r84hDKPY1KinnqViYKse5Aw6cIr/vqXFA/8UKoKQew05OlW4QvKiXjivmRd9L6bo4+24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Pm73BT31; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3c7aa4ce823so1106066f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 06:29:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1756128555; x=1756733355; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=iCSkrA7SjRGzwS/ybz+aSy4nLiKNK2T0ithklCyZmG4=;
        b=Pm73BT319cBLgohhtkPAR1jzSagymBn9A05OGP3W/djqKtN+qE0ztwwPgn64IbCWxL
         Y3CusLNEAdth/HLUzNhlwVitk+WvYyTwICdXIluBe2uPJoV+0PCvbM1z6bMJsYc5Iyyo
         nZtS7Y5DndhjzYEoVj6TwWn9zOmUgVGz7MDhkqh+Yq4v79wUeb6pzuV+cZzwoOk4nh2k
         6RL/vsCN9K7DIOWkXnW01sTHxP3A3/8B5lSdjO4FGzi6jOmx3zTAxYwKmnw4sMDhE2bk
         qs+VqMT80nXlMJZDOShChqhmTmLS3SIwQEDlPm9lt0QnSN+DMhkruFbCvwE8KtF35ip7
         mlKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756128555; x=1756733355;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iCSkrA7SjRGzwS/ybz+aSy4nLiKNK2T0ithklCyZmG4=;
        b=ELNPXBvLUeWIZyjTy2tBHvLUMcNPvMAcWEZtxYQh1WLmMSxNVSdXxJodcX3RJkz6t2
         c5HBnYM0I4aLEvVV21iwuMsuJwl8VRIltDluDg7AwjEl5jpMtGqjyTNjNgUSy3y0uEwR
         OcDbCiBZHFvpb08iyrHNs/geq1GXnhAkyoXK9zeyHpnRQNFuSpW+9k3RzjglPT7A64LK
         aWgirhxNihw1FGgheH1i5VLbod60ehlDKoY1RhDzXcJFTM2u3MAwxwkRDwabrkLBWxfq
         h5g68xhMcn/KRKH8kD1840iTXS52Mu7LhxMAd8nUELRyuacas1XmDgElSVn+uCXJI8+/
         sJvw==
X-Gm-Message-State: AOJu0Yx5eUWBrSkEEVZSBj6b8D0+4usBYp3twfx/bqYDBOveNfFFLe4O
	J0qU5MDf6POUbSniFdIF1iCc/vzJWiIwp+A1uxwaxrWu4CEo2qOUYKXnqaBAXcsF6LLczbq0Act
	bD/vh
X-Gm-Gg: ASbGncuqVPbfsI4cKt51YPPofbwPzIFMv82YBgpEOpEsxK9naShWMcop6W7kXwkazVa
	eyafV+X1tz5zWMBddYU6/uz/AAJc3d/Lv5RlnGaqlMRdMeqQKQHJggEZZXzn+JJFxwEsiZiYKJW
	FsFvWwJUi8bYvgQ0RQLabOV+F0soQqfLuLqvCsbUR/N15bNuaZbYWiT0PJ4YOwUbUxq28UmiHDl
	BieUM4hHQUYz204j9xFJvJgo37GRwsmFRIYaVX1G9xKBWX9pnt+AP32lIHs9ZGpDhcuOmw1uFKb
	RtjZndjyMLw3NkcOfC7aNEPCWocDSESj+5kSrFRmxvaazgy5z7yiAuadR4zacgy5ebe/ThaRi51
	zTKHq92iqbcjZqdW69nwTybaf+h9etrX0Qcja
X-Google-Smtp-Source: AGHT+IEC5+NGOx+bXeiFuE5RlnRmoyUXlDxW2E8CJ3c0wxqs/w78UKkEiat4ua/ZXO4LrIM8+yKxnQ==
X-Received: by 2002:a05:6000:2288:b0:3a4:f66a:9d31 with SMTP id ffacd0b85a97d-3c5daefc2e3mr10311465f8f.16.1756128554927;
        Mon, 25 Aug 2025 06:29:14 -0700 (PDT)
Received: from linux.fritz.box ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3c70f237fefsm11696632f8f.30.2025.08.25.06.29.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Aug 2025 06:29:14 -0700 (PDT)
From: Marco Crivellari <marco.crivellari@suse.com>
To: linux-kernel@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Michal Hocko <mhocko@suse.com>
Subject: [PATCH v2 0/4] Workqueue: replace system wq and change alloc_workqueue callers
Date: Mon, 25 Aug 2025 15:29:02 +0200
Message-ID: <20250825132906.1050437-1-marco.crivellari@suse.com>
X-Mailer: git-send-email 2.50.1
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

3) [P 4] upgraded WQ_UNBOUND documentation

        Added a note about the WQ_UNBOUND flag removal in a next release cycle.


Thanks!

----
Changes in v2:
- __alloc_workqueue() removed the WQ_PERCPU logic, for now.
- removed warnings about system_wq and system_unbound_wq usage. 


Marco Crivellari (4):
  Workqueue: replace use of system_wq with system_percpu_wq
  Workqueue: replace use of system_unbound_wq with system_dfl_wq
  Workqueue: WQ_PERCPU added to all the remaining users
  [Doc] Workqueue: WQ_UNBOUND doc upgraded

 Documentation/core-api/workqueue.rst          |  4 +++
 arch/s390/kernel/diag/diag324.c               |  4 +--
 arch/s390/kernel/hiperdispatch.c              |  2 +-
 block/bio-integrity-auto.c                    |  5 ++--
 block/bio.c                                   |  3 +-
 block/blk-core.c                              |  3 +-
 block/blk-throttle.c                          |  3 +-
 block/blk-zoned.c                             |  3 +-
 crypto/cryptd.c                               |  3 +-
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
 drivers/block/aoe/aoemain.c                   |  2 +-
 drivers/block/nbd.c                           |  2 +-
 drivers/block/rbd.c                           |  2 +-
 drivers/block/rnbd/rnbd-clt.c                 |  2 +-
 drivers/block/sunvdc.c                        |  4 +--
 drivers/block/virtio_blk.c                    |  2 +-
 drivers/block/zram/zram_drv.c                 |  2 +-
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
 drivers/net/can/spi/hi311x.c                  |  3 +-
 drivers/net/can/spi/mcp251x.c                 |  3 +-
 .../net/ethernet/cavium/liquidio/lio_core.c   |  2 +-
 .../net/ethernet/cavium/liquidio/lio_main.c   |  8 +++--
 .../ethernet/cavium/liquidio/lio_vf_main.c    |  3 +-
 .../cavium/liquidio/request_manager.c         |  2 +-
 .../cavium/liquidio/response_manager.c        |  3 +-
 .../net/ethernet/freescale/dpaa2/dpaa2-eth.c  |  2 +-
 .../hisilicon/hns3/hns3pf/hclge_main.c        |  3 +-
 drivers/net/ethernet/intel/fm10k/fm10k_main.c |  2 +-
 drivers/net/ethernet/intel/i40e/i40e_main.c   |  2 +-
 .../net/ethernet/marvell/octeontx2/af/cgx.c   |  2 +-
 .../marvell/octeontx2/af/mcs_rvu_if.c         |  2 +-
 .../ethernet/marvell/octeontx2/af/rvu_cgx.c   |  2 +-
 .../ethernet/marvell/octeontx2/af/rvu_rep.c   |  2 +-
 .../marvell/octeontx2/nic/cn10k_ipsec.c       |  3 +-
 .../ethernet/marvell/prestera/prestera_main.c |  2 +-
 .../ethernet/marvell/prestera/prestera_pci.c  |  2 +-
 drivers/net/ethernet/mellanox/mlxsw/core.c    |  4 +--
 drivers/net/ethernet/netronome/nfp/nfp_main.c |  2 +-
 drivers/net/ethernet/qlogic/qed/qed_main.c    |  3 +-
 drivers/net/ethernet/sfc/efx_channels.c       |  2 +-
 drivers/net/ethernet/sfc/siena/efx_channels.c |  2 +-
 drivers/net/ethernet/wiznet/w5100.c           |  2 +-
 drivers/net/fjes/fjes_main.c                  |  5 ++--
 drivers/net/macvlan.c                         |  2 +-
 drivers/net/netdevsim/dev.c                   |  6 ++--
 drivers/net/phy/sfp.c                         | 12 ++++----
 drivers/net/wireguard/device.c                |  6 ++--
 drivers/net/wireless/ath/ath6kl/usb.c         |  2 +-
 drivers/net/wireless/intel/ipw2x00/ipw2100.c  |  6 ++--
 drivers/net/wireless/intel/ipw2x00/ipw2200.c  |  2 +-
 drivers/net/wireless/intel/iwlwifi/fw/dbg.c   |  4 +--
 .../net/wireless/intel/iwlwifi/iwl-trans.h    |  2 +-
 drivers/net/wireless/intel/iwlwifi/mvm/tdls.c |  6 ++--
 .../net/wireless/marvell/libertas/if_sdio.c   |  3 +-
 .../net/wireless/marvell/libertas/if_spi.c    |  3 +-
 .../net/wireless/marvell/libertas_tf/main.c   |  2 +-
 .../net/wireless/mediatek/mt76/mt7921/init.c  |  2 +-
 .../net/wireless/mediatek/mt76/mt7925/init.c  |  2 +-
 drivers/net/wireless/quantenna/qtnfmac/core.c |  3 +-
 drivers/net/wireless/realtek/rtlwifi/base.c   |  2 +-
 drivers/net/wireless/realtek/rtw88/usb.c      |  3 +-
 drivers/net/wireless/silabs/wfx/main.c        |  2 +-
 drivers/net/wireless/st/cw1200/bh.c           |  4 +--
 drivers/net/wwan/t7xx/t7xx_hif_dpmaif_rx.c    |  3 +-
 drivers/net/wwan/wwan_hwsim.c                 |  2 +-
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
 drivers/power/supply/ab8500_btemp.c           |  3 +-
 drivers/power/supply/bq2415x_charger.c        |  2 +-
 drivers/power/supply/bq24190_charger.c        |  2 +-
 drivers/power/supply/bq27xxx_battery.c        |  6 ++--
 drivers/power/supply/ipaq_micro_battery.c     |  3 +-
 drivers/power/supply/rk817_charger.c          |  6 ++--
 drivers/power/supply/ucs1002_power.c          |  2 +-
 drivers/power/supply/ug3105_battery.c         |  6 ++--
 drivers/rapidio/rio.c                         |  2 +-
 drivers/ras/cec.c                             |  2 +-
 drivers/regulator/irq_helpers.c               |  2 +-
 drivers/regulator/qcom-labibb-regulator.c     |  4 +--
 drivers/s390/char/tape_3590.c                 |  2 +-
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
 drivers/virt/acrn/irqfd.c                     |  3 +-
 drivers/virtio/virtio_balloon.c               |  3 +-
 drivers/xen/events/events_base.c              |  6 ++--
 drivers/xen/privcmd.c                         |  3 +-
 fs/afs/callback.c                             |  4 +--
 fs/afs/write.c                                |  2 +-
 fs/bcachefs/btree_write_buffer.c              |  2 +-
 fs/bcachefs/io_read.c                         | 12 ++++----
 fs/bcachefs/journal_io.c                      |  2 +-
 fs/btrfs/block-group.c                        |  2 +-
 fs/btrfs/extent_map.c                         |  2 +-
 fs/btrfs/space-info.c                         |  4 +--
 fs/btrfs/zoned.c                              |  2 +-
 fs/ext4/mballoc.c                             |  2 +-
 fs/netfs/objects.c                            |  2 +-
 fs/netfs/read_collect.c                       |  2 +-
 fs/netfs/write_collect.c                      |  2 +-
 fs/nfsd/filecache.c                           |  2 +-
 fs/notify/mark.c                              |  4 +--
 fs/quota/dquot.c                              |  2 +-
 include/drm/gpu_scheduler.h                   |  2 +-
 include/linux/closure.h                       |  2 +-
 include/linux/workqueue.h                     | 30 +++++++++----------
 io_uring/io_uring.c                           |  4 +--
 kernel/bpf/cgroup.c                           |  5 ++--
 kernel/bpf/cpumap.c                           |  2 +-
 kernel/bpf/helpers.c                          |  4 +--
 kernel/bpf/memalloc.c                         |  2 +-
 kernel/bpf/syscall.c                          |  2 +-
 kernel/cgroup/cgroup-v1.c                     |  2 +-
 kernel/cgroup/cgroup.c                        |  4 +--
 kernel/module/dups.c                          |  4 +--
 kernel/padata.c                               |  9 +++---
 kernel/power/main.c                           |  2 +-
 kernel/rcu/tasks.h                            |  4 +--
 kernel/rcu/tree.c                             |  4 +--
 kernel/sched/core.c                           |  4 +--
 kernel/sched/ext.c                            |  4 +--
 kernel/smp.c                                  |  2 +-
 kernel/trace/trace_events_user.c              |  2 +-
 kernel/umh.c                                  |  2 +-
 kernel/workqueue.c                            | 23 +++++++-------
 mm/backing-dev.c                              |  2 +-
 mm/kfence/core.c                              |  6 ++--
 mm/memcontrol.c                               |  4 +--
 net/core/link_watch.c                         |  4 +--
 net/unix/garbage.c                            |  2 +-
 net/wireless/core.c                           |  4 +--
 net/wireless/sysfs.c                          |  2 +-
 rust/kernel/workqueue.rs                      | 12 ++++----
 sound/soc/codecs/aw88081.c                    |  2 +-
 sound/soc/codecs/aw88166.c                    |  2 +-
 sound/soc/codecs/aw88261.c                    |  2 +-
 sound/soc/codecs/aw88395/aw88395.c            |  2 +-
 sound/soc/codecs/aw88399.c                    |  2 +-
 sound/soc/codecs/cs42l43-jack.c               |  6 ++--
 sound/soc/codecs/cs42l43.c                    |  4 +--
 sound/soc/codecs/es8326.c                     | 12 ++++----
 sound/soc/codecs/rt5663.c                     |  6 ++--
 sound/soc/codecs/wm_adsp.c                    |  2 +-
 sound/soc/intel/boards/sof_es8336.c           |  2 +-
 sound/soc/sof/intel/cnl.c                     |  2 +-
 sound/soc/sof/intel/hda-ipc.c                 |  2 +-
 virt/kvm/eventfd.c                            |  2 +-
 321 files changed, 607 insertions(+), 509 deletions(-)

-- 
2.50.1


