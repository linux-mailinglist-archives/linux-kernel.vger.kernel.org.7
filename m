Return-Path: <linux-kernel+bounces-792286-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5672B3C24E
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 20:16:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 526B4A60C19
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 18:16:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1041133CEA9;
	Fri, 29 Aug 2025 18:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="D2MkfVAj"
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5044B224D6;
	Fri, 29 Aug 2025 18:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756491366; cv=none; b=FC2nPdZo2txq7VER7ggC/dChpdIIzuVwxxdWsH48pzWOR6Vm65XAwS5Wza9BoyoQ1O9blKIAMEQOh4T30eSOu5oWh75wlZ/G2wWHpnpy1Qh3hqa3ZD1gL+pox66xLlcp1QNA0J+QoowpWNDqALyN4zxVJMIjoJWUD4c1kPN+2IQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756491366; c=relaxed/simple;
	bh=Vnyqj1sA+eIkplLrCxNKuA2MWjJFlyxhJHFMJUC8XJY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FR8FFDsnwkTK7bMqnV2j0R5DayCRdMcoktZQbbwv8HHkbYKIYhY41j3XAMJM1jl2Qpg4U7qsncpjpKN0QqkvsnVSoU/ALLnKvJpkcKIrjtJ3TMcNvH0H1OXENo0i+H503HS1C82szLsriBPZECstzxUMi0fIXqiHEMutMrBj/nE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=D2MkfVAj; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=R6
	s5WxCEkgSAAluKgFDGaXXXwuLdmTx3ZMN+nst+nbM=; b=D2MkfVAjGdb9dPxF8y
	Wmw4ISC3+3vc3O0BbhB96tZjHdwSH28Uf66QAMbm4e+tWebP+olMQtFXz7ZMmm8w
	3pK4cThCTNSqiVkMKzurMHcGKndjbko9DZhZNTS89l+BOiNoyeFOshLSTlNt/4jN
	D0f2HFhtibrLELoZlXXjIsHZM=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-1 (Coremail) with SMTP id _____wBn4qXi7bFoEYb2Eg--.41361S4;
	Sat, 30 Aug 2025 02:14:11 +0800 (CST)
From: David Wang <00107082@163.com>
To: WeitaoWang-oc@zhaoxin.com,
	mathias.nyman@linux.intel.com,
	gregkh@linuxfoundation.org
Cc: linux-usb@vger.kernel.org,
	regressions@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	surenb@google.com,
	kent.overstreet@linux.dev
Subject: [REGRESSION 6.17-rc3] usb/xhci: possible memory leak after suspend/resume cycle.
Date: Sat, 30 Aug 2025 02:13:54 +0800
Message-ID: <20250829181354.4450-1-00107082@163.com>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wBn4qXi7bFoEYb2Eg--.41361S4
X-Coremail-Antispam: 1Uf129KBjvJXoWxuFWDurW3AFyrGw17KF45Wrg_yoW7Xw15pF
	4fZ34jkrn0yrWxZF4DuryDAa4rJa18GrW8Wr9rG3y5ZrWjqw1UXF4qyFW7A3Wa9r4UJ34Y
	qFn0gr95W3y7GaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jY89tUUUUU=
X-CM-SenderInfo: qqqrilqqysqiywtou0bp/1tbiMwi4qmixlu1tEwABs0

Hi,

I have been watching kernel memory usage for drivers for a while, via /proc/allocinfo.
After upgrade to 6.17-rc3, I notice memory usage behavior changes for usb drivers:

Before rc3, after several suspend/resume cycles, usb devices's memory usage is very stable:

       40960        5 drivers/usb/host/xhci-mem.c:980 [xhci_hcd] func:xhci_alloc_virt_device 9
        1024        1 drivers/usb/host/xhci-mem.c:841 [xhci_hcd] func:xhci_alloc_tt_info 2
         320       10 drivers/usb/host/xhci-mem.c:461 [xhci_hcd] func:xhci_alloc_container_ctx 31
        1920       15 drivers/usb/host/xhci-mem.c:377 [xhci_hcd] func:xhci_ring_alloc 31
         112       12 drivers/usb/host/xhci-mem.c:49 [xhci_hcd] func:xhci_segment_alloc 32
        1792       28 drivers/usb/host/xhci-mem.c:38 [xhci_hcd] func:xhci_segment_alloc 59

But with rc3, the memory usage increase after each suspend/resume cycle: 

#1:
       49152        6 drivers/usb/host/xhci-mem.c:980 [xhci_hcd] func:xhci_alloc_virt_device 9
        1024        1 drivers/usb/host/xhci-mem.c:841 [xhci_hcd] func:xhci_alloc_tt_info 2
         384       12 drivers/usb/host/xhci-mem.c:461 [xhci_hcd] func:xhci_alloc_container_ctx 32
        2176       17 drivers/usb/host/xhci-mem.c:377 [xhci_hcd] func:xhci_ring_alloc 32
         128       14 drivers/usb/host/xhci-mem.c:49 [xhci_hcd] func:xhci_segment_alloc 34
        2048       32 drivers/usb/host/xhci-mem.c:38 [xhci_hcd] func:xhci_segment_alloc 61
#2:
       57344        7 drivers/usb/host/xhci-mem.c:980 [xhci_hcd] func:xhci_alloc_virt_device 13
        1024        1 drivers/usb/host/xhci-mem.c:841 [xhci_hcd] func:xhci_alloc_tt_info 3
         448       14 drivers/usb/host/xhci-mem.c:461 [xhci_hcd] func:xhci_alloc_container_ctx 46
        2432       19 drivers/usb/host/xhci-mem.c:377 [xhci_hcd] func:xhci_ring_alloc 43
         144       16 drivers/usb/host/xhci-mem.c:49 [xhci_hcd] func:xhci_segment_alloc 44
        2304       36 drivers/usb/host/xhci-mem.c:38 [xhci_hcd] func:xhci_segment_alloc 82
#3:
       65536        8 drivers/usb/host/xhci-mem.c:980 [xhci_hcd] func:xhci_alloc_virt_device 17
        1024        1 drivers/usb/host/xhci-mem.c:841 [xhci_hcd] func:xhci_alloc_tt_info 4
         512       16 drivers/usb/host/xhci-mem.c:461 [xhci_hcd] func:xhci_alloc_container_ctx 60
        2688       21 drivers/usb/host/xhci-mem.c:377 [xhci_hcd] func:xhci_ring_alloc 54
         160       18 drivers/usb/host/xhci-mem.c:49 [xhci_hcd] func:xhci_segment_alloc 54
        2560       40 drivers/usb/host/xhci-mem.c:38 [xhci_hcd] func:xhci_segment_alloc 103

The memory increasing pattern keeps going on for each suspend/resume afterwards, I am not
sure whether those memory would be released sometime later.

And in kernel log, two lines of error always showed up after suspend/resume:

	[  295.613598] xhci_hcd 0000:03:00.0: dma_pool_destroy xHCI ring segments busy
	[  295.613605] xhci_hcd 0000:03:00.0: dma_pool_destroy xHCI input/output contexts busy

And bisect narrow down to commit 2eb03376151bb8585caa23ed2673583107bb5193(
"usb: xhci: Fix slot_id resource race conflict"):

	git bisect start 'drivers/usb'
	# status: waiting for both good and bad commits
	# good: [c17b750b3ad9f45f2b6f7e6f7f4679844244f0b9] Linux 6.17-rc2
	git bisect good c17b750b3ad9f45f2b6f7e6f7f4679844244f0b9
	# status: waiting for bad commit, 1 good commit known
	# bad: [1b237f190eb3d36f52dffe07a40b5eb210280e00] Linux 6.17-rc3
	git bisect bad 1b237f190eb3d36f52dffe07a40b5eb210280e00
	# good: [e86ba12cf84ab9cf42fbc2382235fa7ba616e18b] Merge tag 'nfs-for-6.17-2' of git://git.linux-nfs.org/projects/trondmy/linux-nfs
	git bisect good e86ba12cf84ab9cf42fbc2382235fa7ba616e18b
	# good: [471b25a2fcbb25dccd7c9bece30313f2440a554e] Merge tag 'for-linus-iommufd' of git://git.kernel.org/pub/scm/linux/kernel/git/jgg/iommufd
	git bisect good 471b25a2fcbb25dccd7c9bece30313f2440a554e
	# good: [52025b8fc992972168128be40bffee7eafa532b5] Merge tag 'driver-core-6.17-rc3' of git://git.kernel.org/pub/scm/linux/kernel/git/driver-core/driver-core
	git bisect good 52025b8fc992972168128be40bffee7eafa532b5
	# bad: [8004d08330e1aa7ae797778509e864f7ac3da687] Merge tag 'usb-6.17-rc3' of git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb
	git bisect bad 8004d08330e1aa7ae797778509e864f7ac3da687
	# good: [a381c6d6f646226924809d0ad01a9465786da463] usb: typec: maxim_contaminant: re-enable cc toggle if cc is open and port is clean
	git bisect good a381c6d6f646226924809d0ad01a9465786da463
	# good: [4013aef2ced9b756a410f50d12df9ebe6a883e4a] ftrace: Fix potential warning in trace_printk_seq during ftrace_dump
	git bisect good 4013aef2ced9b756a410f50d12df9ebe6a883e4a
	# bad: [2eb03376151bb8585caa23ed2673583107bb5193] usb: xhci: Fix slot_id resource race conflict
	git bisect bad 2eb03376151bb8585caa23ed2673583107bb5193
	# good: [309b6341d5570fb2b41b923de2fc9bb147106b80] usb: typec: fusb302: Revert incorrect threaded irq fix
	git bisect good 309b6341d5570fb2b41b923de2fc9bb147106b80
	# first bad commit: [2eb03376151bb8585caa23ed2673583107bb5193] usb: xhci: Fix slot_id resource race conflict



Thanks
David


