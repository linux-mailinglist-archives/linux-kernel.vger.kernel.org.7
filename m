Return-Path: <linux-kernel+bounces-873727-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A4925C148C3
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 13:12:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 318533BF504
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 12:09:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55A01329C43;
	Tue, 28 Oct 2025 12:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="HBtUxppX"
Received: from canpmsgout09.his.huawei.com (canpmsgout09.his.huawei.com [113.46.200.224])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DB8A303A23
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 12:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.224
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761653366; cv=none; b=jbcZGpYdcgI6qSoias4AeAC6gCrtE33g9kRQtTnfrJnBQZRrDFzGhNZlc3Ki5T+Cwfu+xif/ybq6D/BD3q3F+Xosh9ic8hLovQ8KZkKmixWhl7fcTbHWXQeISspl0JF6ZDsOEGf1WaXq/j7AD1iTS0/3lx5TDx3CTHZ384uQ9tA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761653366; c=relaxed/simple;
	bh=SgLZXLJQZDKNeiBBThPxXw4GCHtMrY0LsCovyAskqkk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=YIT17i4sMrlIQaxoA1JH9KoPU0fiIE0YueRsDcPLReIhU7CZUr4v7KgpDGXhFG1v7mNRf/K0t5bma7VWFCUH5QrKJfv51H2cpVeAZ4diBdedEWVY6S6JShEUwSFHNVyf4Qhimomu5hVe5S7+Y0fm9cucqDPpgJ0i0EAZSS7j5UE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=HBtUxppX; arc=none smtp.client-ip=113.46.200.224
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=+XKj3nvswIkuD4UJ0ZfutlugXu3bCzJoixFmguATrjs=;
	b=HBtUxppXAx/6phM1x3Dn2rQ6CsriGnXbncK4xnGEDZ58XWM7KoJSFig237dFA3x5pGv7oX9k4
	thuJpnhcl3mBZW+/fGlfeei3bX7u+SxvapDkCXZo+aUWuFccIDYodB9iCJPoJfZs9ZorYO6Pscf
	6/dmEUzZ9j7Gmv9PcuPycwU=
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by canpmsgout09.his.huawei.com (SkyGuard) with ESMTPS id 4cwq0Z3HY6z1cyNs;
	Tue, 28 Oct 2025 20:08:46 +0800 (CST)
Received: from kwepemj200003.china.huawei.com (unknown [7.202.194.15])
	by mail.maildlp.com (Postfix) with ESMTPS id B48B9140143;
	Tue, 28 Oct 2025 20:09:14 +0800 (CST)
Received: from localhost.huawei.com (10.90.31.46) by
 kwepemj200003.china.huawei.com (7.202.194.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 28 Oct 2025 20:09:14 +0800
From: Qinxin Xia <xiaqinxin@huawei.com>
To: <21cnbao@gmail.com>, <m.szyprowski@samsung.com>, <robin.murphy@arm.com>
CC: <prime.zeng@huawei.com>, <fanghao11@huawei.com>,
	<linux-kernel@vger.kernel.org>, <linuxarm@huawei.com>,
	<xiaqinxin@huawei.com>, <wangzhou1@hisilicon.com>
Subject: [PATCH v5 0/2] Tiny bug fix and move dma map benchmark to /tools/dma
Date: Tue, 28 Oct 2025 20:08:58 +0800
Message-ID: <20251028120900.2265511-1-xiaqinxin@huawei.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 kwepemj200003.china.huawei.com (7.202.194.15)

1) Fix the bug of droped 'expansion' field in previous submission.
2) Move dma_map_benchmark from selftests to tools/dma.
 
---
Changes since v4: 
1) Addressed comments from Barry:
   - The hotfix is separated as a patch.
Link: https://lore.kernel.org/all/20251022035528.1981892-1-xiaqinxin@huawei.com/
 
Changes since v3: 
1) Addressed comments from Barry:
   - Make a few minor modifications from gpio Makefile to dma.
   - Remove include/linux/map_benchmark.h.
Link: https://lore.kernel.org/all/20251021011739.1468912-1-xiaqinxin@huawei.com/                                                                                                                                                                                   
 
Changes since v2:    
1) Fix some x86_64 build errors.
Link: https://lore.kernel.org/all/20251018101402.3079372-1-xiaqinxin@huawei.com/
 
Changes since v1: 
1) Addressed comments from Barry:
   - Moved map_benchmark.h from include/linux to include/uapi/linux/.
   - Modified CFLAGS in Makefile to reflect the new header location.
 
2) Added a .gitignore file to exclude unnecessary files.
 
3) Restored the 'expansion' field in 'struct map_benchmark':
   - This field was accidentally removed in commit 8ddde07a3d.
   - The change ensures that the structure remains compatible with existing codebases.
Link: https://lore.kernel.org/all/20250814133527.2679261-1-xiaqinxin@huawei.com/

Qinxin Xia (2):
  dma-mapping: benchmark: Restore padding to ensure uABI remained
    consistent
  tools/dma: move dma_map_benchmark from selftests to tools/dma

 include/{ => uapi}/linux/map_benchmark.h      | 14 +++--
 kernel/dma/map_benchmark.c                    |  2 +-
 tools/Makefile                                | 13 +++--
 tools/dma/.gitignore                          |  3 +
 tools/dma/Makefile                            | 55 +++++++++++++++++++
 tools/{testing/selftests => }/dma/config      |  0
 .../selftests => }/dma/dma_map_benchmark.c    |  1 -
 tools/testing/selftests/dma/Makefile          |  7 ---
 8 files changed, 75 insertions(+), 20 deletions(-)
 rename include/{ => uapi}/linux/map_benchmark.h (76%)
 create mode 100644 tools/dma/.gitignore
 create mode 100644 tools/dma/Makefile
 rename tools/{testing/selftests => }/dma/config (100%)
 rename tools/{testing/selftests => }/dma/dma_map_benchmark.c (99%)
 delete mode 100644 tools/testing/selftests/dma/Makefile

-- 
2.33.0


