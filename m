Return-Path: <linux-kernel+bounces-802452-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1E63B45282
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 11:07:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 46DA63A4101
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 09:07:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBE60285057;
	Fri,  5 Sep 2025 09:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="a9GlRqd4"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96F45280037
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 09:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757063116; cv=none; b=FNZVH7ekooOpAGzRFpQd5/4pObw8rRpgzDc2A4PJO5uTjaUC4erp5W+hj6M21N1hHhZl1uqQTUl1F9VxuE/3eEkpR8tze3IZsUson17DQVQ/pi0qIGhGyuIgUXBykz0PYMpF048HiVcnHhFjLzoqSpXgvWtB9VsQac/u5yT/fZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757063116; c=relaxed/simple;
	bh=W4bOW8Cx56etGcynFDRDpqQz6URT2sx6FrVBuoWHgb0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=SggbE6hwwMEhJ5wC8Tx2l7NOzpI8CowH9NCF6AoBSaum73tFTBIKSNbiLrO+ensnynldUkIWGb4VZS1Hd1j8grPxDJr0hUAu/WWlzbA3W42p2pPPlAQsIePz7CW/ssjPJj8UEqMAci6utIJqCwkb28K5pqWOKqSwm0/DwEFop3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=a9GlRqd4; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-45dd505a1dfso7497465e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 05 Sep 2025 02:05:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1757063113; x=1757667913; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rAY5RHGYtb3Vh906IvsO6P6kCIvtGXBJMzL03W3Xh/g=;
        b=a9GlRqd4z1Xrq9rc22a9o8Q7kZ4ToX3js43rwC4KKX1F9n5wJPT3oPw/I31K+57RZG
         mJSvTBRC48J3kyzeORDYZn5YjDf4wSbk5/jKORkYxhabs5iisPkOK9jqI54+SMV0a2sQ
         xoUGOOZFKrYBmPj5jIIYyYmh/MIVkznmZD0K18Il6mp/zrIKdBCCg6NzUAfYXfk4sqOm
         vq6oDU/9ynP4sqgDCtCvgF7fZQn5rbla1XjDNiNIocF5xDsRfQv8GZK7IdBFQZP3Js/b
         nUSsk0TCwuE1+AY8KtrFwPgtPjiSOulfDZ5tx/Plh41ClfkLoMoB7a+NWUFNeOc1vAUP
         Y0BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757063113; x=1757667913;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rAY5RHGYtb3Vh906IvsO6P6kCIvtGXBJMzL03W3Xh/g=;
        b=EFufKCdvTgiBjwt057t+1PR31KcJ2NzSL34V90ENwBP8Gj0900THzda1t+KS3ty2d/
         0eynkxxkfXNHo1qjofIPXsVB6YM0UyivZMHUVcc9WI6I82Zzf97UaAuu+HBXie1WPLHj
         g/vnS6o19JlnnZzhhFzaFhIBlj554VrjUfx3d172nI5qAvWe27viaECLobZnzUpIFB/j
         smTJ5bABlHuoovW8//gmIjJ0Y/VphIwIQg2S3karUt0PTw3cV3U91kyfnENFl1xMNdLR
         Kd7XROMwKaMWmd4o7YkagWTsqeKw1UmjZe+4V+8dythfaAsFCKFLRfO7J8fZm/BFMuzQ
         IlEQ==
X-Gm-Message-State: AOJu0YxPoslr+6KvYoQq8YVFM87QsGtKP7tCDcwOQh/SqoDl+QP6PAvG
	L+p+2Wv7ZTmnvGsTZY64yI/e2YPjuwDzYE6zYR2Vujf/lmzo/c3hKY1NyZ2jqHICdc78VsoS+fv
	s+cwc
X-Gm-Gg: ASbGncsyFyy2D/DUTO2ToJa+Qi1RKnJzpjHPWm7hR5fpPhlFKoF88C0KU4c5xiiLe+8
	lIHTfhDq1BFm0qYfl/trUPxg5vZoJSctXt9+K4fl13HB2vXgFfb9hP0Fw9DGE5WT6OnKhG5pzPs
	JRFROpTE6sQT/Nw7ADQcETHpZdSawiR58YpAmKfu2G5Z+gQRKDoVAoTpa8ybe9X+QCPQO6UNMIF
	BY/RECBr7d4YjQSOEcd2a4dAqk2vFwDOPBHbzIJ/jD9MRTPeqc7x7U9Z+NRgrY0tCnxFQvqjch2
	aBjLQwxoKutl9z7CCGbrA7jNRcETjxEtzlag6lBVENFU/O6lNM5UUI/1cv7/XUMLV1oEQGfrQ00
	JBI0bjhFxT+/uoAy+uk9sYoISXkaLG8d6MbNUXsN0DoawMsIXfFMEUE4ZVw==
X-Google-Smtp-Source: AGHT+IFNGLym/5PLfwcfDJ7477p5jDRngN98T8SzwWKgKLQ9ncQxJyZ4WA2jhJTReIn8rSYJBNF4ig==
X-Received: by 2002:a05:600c:46c3:b0:458:c059:7db1 with SMTP id 5b1f17b1804b1-45b8557f254mr213442005e9.30.1757063112598;
        Fri, 05 Sep 2025 02:05:12 -0700 (PDT)
Received: from localhost.localdomain ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45dd07480d5sm34118215e9.8.2025.09.05.02.05.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Sep 2025 02:05:12 -0700 (PDT)
From: Marco Crivellari <marco.crivellari@suse.com>
To: linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Michal Hocko <mhocko@suse.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net-next 0/3] net: replace wq users and add WQ_PERCPU to alloc_workqueue() users
Date: Fri,  5 Sep 2025 11:05:02 +0200
Message-ID: <20250905090505.104882-1-marco.crivellari@suse.com>
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
  net: replace use of system_unbound_wq with system_dfl_wq
  net: replace use of system_wq with system_percpu_wq
  net: WQ_PERCPU added to alloc_workqueue users

 drivers/net/can/spi/hi311x.c                         |  3 ++-
 drivers/net/can/spi/mcp251x.c                        |  3 ++-
 drivers/net/ethernet/cavium/liquidio/lio_core.c      |  2 +-
 drivers/net/ethernet/cavium/liquidio/lio_main.c      |  8 +++++---
 drivers/net/ethernet/cavium/liquidio/lio_vf_main.c   |  3 ++-
 .../net/ethernet/cavium/liquidio/request_manager.c   |  2 +-
 .../net/ethernet/cavium/liquidio/response_manager.c  |  3 ++-
 drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c     |  2 +-
 .../net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c  |  3 ++-
 drivers/net/ethernet/intel/fm10k/fm10k_main.c        |  2 +-
 drivers/net/ethernet/intel/i40e/i40e_main.c          |  2 +-
 drivers/net/ethernet/marvell/octeontx2/af/cgx.c      |  2 +-
 .../net/ethernet/marvell/octeontx2/af/mcs_rvu_if.c   |  2 +-
 drivers/net/ethernet/marvell/octeontx2/af/rvu_cgx.c  |  2 +-
 drivers/net/ethernet/marvell/octeontx2/af/rvu_rep.c  |  2 +-
 .../net/ethernet/marvell/octeontx2/nic/cn10k_ipsec.c |  3 ++-
 .../net/ethernet/marvell/prestera/prestera_main.c    |  2 +-
 drivers/net/ethernet/marvell/prestera/prestera_pci.c |  2 +-
 drivers/net/ethernet/mellanox/mlxsw/core.c           |  4 ++--
 drivers/net/ethernet/netronome/nfp/nfp_main.c        |  2 +-
 drivers/net/ethernet/qlogic/qed/qed_main.c           |  3 ++-
 drivers/net/ethernet/sfc/efx_channels.c              |  2 +-
 drivers/net/ethernet/sfc/siena/efx_channels.c        |  2 +-
 drivers/net/ethernet/wiznet/w5100.c                  |  2 +-
 drivers/net/fjes/fjes_main.c                         |  5 +++--
 drivers/net/macvlan.c                                |  2 +-
 drivers/net/netdevsim/dev.c                          |  6 +++---
 drivers/net/phy/sfp.c                                | 12 ++++++------
 drivers/net/wireguard/device.c                       |  6 ++++--
 drivers/net/wireless/ath/ath6kl/usb.c                |  2 +-
 drivers/net/wireless/intel/ipw2x00/ipw2100.c         |  6 +++---
 drivers/net/wireless/intel/ipw2x00/ipw2200.c         |  2 +-
 drivers/net/wireless/intel/iwlwifi/fw/dbg.c          |  4 ++--
 drivers/net/wireless/intel/iwlwifi/iwl-trans.h       |  2 +-
 drivers/net/wireless/intel/iwlwifi/mvm/tdls.c        |  6 +++---
 drivers/net/wireless/marvell/libertas/if_sdio.c      |  3 ++-
 drivers/net/wireless/marvell/libertas/if_spi.c       |  3 ++-
 drivers/net/wireless/marvell/libertas_tf/main.c      |  2 +-
 drivers/net/wireless/mediatek/mt76/mt7921/init.c     |  2 +-
 drivers/net/wireless/mediatek/mt76/mt7925/init.c     |  2 +-
 drivers/net/wireless/quantenna/qtnfmac/core.c        |  3 ++-
 drivers/net/wireless/realtek/rtlwifi/base.c          |  2 +-
 drivers/net/wireless/realtek/rtw88/usb.c             |  3 ++-
 drivers/net/wireless/silabs/wfx/main.c               |  2 +-
 drivers/net/wireless/st/cw1200/bh.c                  |  4 ++--
 drivers/net/wwan/t7xx/t7xx_hif_dpmaif_rx.c           |  3 ++-
 drivers/net/wwan/wwan_hwsim.c                        |  2 +-
 net/bridge/br_cfm.c                                  |  6 +++---
 net/bridge/br_mrp.c                                  |  8 ++++----
 net/ceph/messenger.c                                 |  3 ++-
 net/ceph/mon_client.c                                |  2 +-
 net/core/link_watch.c                                |  4 ++--
 net/core/skmsg.c                                     |  2 +-
 net/core/sock_diag.c                                 |  2 +-
 net/devlink/core.c                                   |  2 +-
 net/ipv4/inet_fragment.c                             |  2 +-
 net/netfilter/nf_conntrack_ecache.c                  |  2 +-
 net/openvswitch/dp_notify.c                          |  2 +-
 net/rds/ib_rdma.c                                    |  3 ++-
 net/rfkill/input.c                                   |  2 +-
 net/rxrpc/rxperf.c                                   |  2 +-
 net/smc/af_smc.c                                     |  6 +++---
 net/smc/smc_core.c                                   |  4 ++--
 net/tls/tls_device.c                                 |  2 +-
 net/unix/garbage.c                                   |  2 +-
 net/vmw_vsock/af_vsock.c                             |  2 +-
 net/vmw_vsock/virtio_transport.c                     |  2 +-
 net/vmw_vsock/vsock_loopback.c                       |  2 +-
 net/wireless/core.c                                  |  4 ++--
 net/wireless/sysfs.c                                 |  2 +-
 70 files changed, 117 insertions(+), 98 deletions(-)

-- 
2.51.0


