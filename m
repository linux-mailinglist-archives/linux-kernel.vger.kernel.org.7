Return-Path: <linux-kernel+bounces-739693-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 32E28B0C9C4
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 19:37:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A3695407F4
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 17:37:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 499422E03FD;
	Mon, 21 Jul 2025 17:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="CxP5bcZd"
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 104E82B9A8
	for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 17:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.143.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753119429; cv=none; b=cueMy+oLI5f8HdSZC8tKEXyx46uM2GplFPCvVq13VxszRFwCIcQHBs30UsGN0Npx+8Jiz2ncfy5huarc4V7eD6Vz1yB9dttyoCdOG/mqSJSbysjs47/b1+2TG2xx4CWW3orkUxHERUhvx8Nua9kGgriR5fL8Dm04TTUv6tBt1j4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753119429; c=relaxed/simple;
	bh=1MlHeSe7t1aUihxUN09tzbsm8J3JjC8wXjw9GYBK/YE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YMAz6QmwXgmPPiLBi5v7Zr0q+GhPGMtSiLXMdf0GgNycd88T+QN+hFbFj1/m4+j2MN0Li55kuSwL2cKP9LiHzV8RT/vG5+9QkxYSGPz+xxskmJy3opP2VVKDdczktXezdW3ZYzoNkQbeDAA+5yVijAHIPt+fX9IVaNSpTLG/VZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=CxP5bcZd; arc=none smtp.client-ip=68.232.143.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1753119428; x=1784655428;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=1MlHeSe7t1aUihxUN09tzbsm8J3JjC8wXjw9GYBK/YE=;
  b=CxP5bcZdzYe0r/JC2XNAl4MK/EcHeUjDWE8tUma/psvVHnL4LFMx2WJZ
   PIT/Kl40/RMbnUpr69nlTScHaSxM81MK+YauSkg3fjuOPI5pUvmgv+lMW
   v8703OdjFGQpuzOmB+tcF6Mghn7L+Wvhvou5QRwbIHEyl+BH9phx+B5t7
   J8twdvyywjC/xhZ+9f7BiWF4t639xsgjuKzKXmnQf6vSqhi+S/mN3L3TE
   IHAebLyWRBgDfOgT/GQSyXE9eqXX25elX+UYoerOWLFDFkwxfq5qh972Q
   u3iuhclPs/MRYuZjPyZ61WJCIolFZGHD3cz5JumPEE+PmpXKzsjrnbeIU
   A==;
X-CSE-ConnectionGUID: j/RNNiokQUC58yMNrpOflQ==
X-CSE-MsgGUID: DCEjn0SZSGCC3F925uSqqA==
X-IronPort-AV: E=Sophos;i="6.16,329,1744041600"; 
   d="scan'208";a="99464764"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 22 Jul 2025 01:37:01 +0800
IronPort-SDR: 687e6c12_J7aKtEwguult+FPa2eVZ74XVFae+FNDEmkt329qeHCMezFI
 Vu54qCUKJPs8cV2y/z6rWAAwsnpp0XEmIchTIcQ==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 21 Jul 2025 09:34:27 -0700
WDCIronportException: Internal
Received: from ros-3.wdc.com ([10.23.145.79])
  by uls-op-cesaip01.wdc.com with ESMTP; 21 Jul 2025 10:37:01 -0700
From: Kamaljit Singh <kamaljit.singh1@wdc.com>
To: kbusch@kernel.org,
	axboe@kernel.dk,
	hch@lst.de,
	sagi@grimberg.me,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: cassel@kernel.org,
	dlemoal@kernel.org,
	kamaljit.singh1@wdc.com
Subject: [PATCH v4 0/2] Support for Administrative Controllers
Date: Mon, 21 Jul 2025 10:36:58 -0700
Message-ID: <20250721173700.4153098-1-kamaljit.singh1@wdc.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Patch-set summary:
------------------
[1] add capability to connect to an administrative controller
    - New function identifies an administrative controller via the 
      controller's CNTRLTYPE
    - Prevent I/O queue creation for administrative controllers by
      overriding the controller's queue_count and setting it 
      to 1, so only an admin connection is allowed to be created. 

[2] prevent admin controller from smart log fetch (LID 2)
    - Conditional around nvme_hwmon_init() now disallowes administrative 
      controllers during controller initialization.

Changelog:
----------
Changes from v3:
  - Remove inline helper nvme_override_prohibited_io_queues() and 
    move code directly into nvme_init_ctrl_finish()
  - Add more detailed comments and changelog to patch-set

Changes from v2:
  - Avoid calling nvme_override_prohibited_io_queues() from 
    RDMA and TCP (nvme_rdma_setup_ctrl()/nvme_tcp_setup_ctrl()) fabrics 
    drivers by moving it into the generic code under nvme_init_ctrl_finish()
  - Remove export of nvme_override_prohibited_io_queues()
  - Change announcing of administrative controller from dev_info to dev_dbg
  - Coding style change. Remove parenthesis in nvme_admin_ctrl() as 
    suggested by Damien

Changes from v1:
  - Remove check that disallowed zero I/O queues for an I/O controller
  - Create helper nvme_override_prohibited_io_queues() for identical code 
    in nvme_rdma_setup_ctrl() and nvme_tcp_setup_ctrl() 
  - Separate into multiple patches
  - Revert naming of nvmf_discovery_ctrl() back to nvme_discovery_ctrl() 
  - Move nvme_admin_ctrl() from nvme.h to core.c


Kamaljit Singh (2):
  nvme: add capability to connect to an administrative controller
  nvme: prevent admin controller from smart log fetch (LID 2)

 drivers/nvme/host/core.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

-- 
2.43.0


