Return-Path: <linux-kernel+bounces-708989-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F8F7AED7E0
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jun 2025 10:54:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 48C9B1898F01
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jun 2025 08:54:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 431AD23B63C;
	Mon, 30 Jun 2025 08:54:27 +0000 (UTC)
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF9F514F70;
	Mon, 30 Jun 2025 08:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751273666; cv=none; b=tiq2aQm5CmPOldsWCVIrbFLZe0zBTgm1TaPr+/pnQglF5+rKwgjo1U8L3V9mUyM78U/8mnHBPVObK6MeHn3YzW3hOL23dMkkBZIsjqr1aQyTvsOq6WceOb7e1ijF9o/XtA6tgJYjESVTBL03AcGUrEEZd55ZaFzxM9q4bC94bxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751273666; c=relaxed/simple;
	bh=TZIvhrthRicC6Lvb+WGpxZCxTLY8ZHeL22qSl3BRQXY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=WLjUe/Yo0jqPXMCb1NDch7HM9c832ciyX4DtbZ+vk6BkDArwiNpQw0qTLQs4PMuMZKEDhsQ3GwNoRKxO9MjjGjreorluGFzcUDzaIWHIAS8lHfOAEXbEZ2UoRFlBOyWRamalumscOF79YdVkfO9Sai99SGdevPshgrL/y57lezE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4bW0KX4tzKz2BdX6;
	Mon, 30 Jun 2025 16:52:32 +0800 (CST)
Received: from dggpemf500015.china.huawei.com (unknown [7.185.36.143])
	by mail.maildlp.com (Postfix) with ESMTPS id E3D881A0188;
	Mon, 30 Jun 2025 16:54:15 +0800 (CST)
Received: from huawei.com (10.50.165.33) by dggpemf500015.china.huawei.com
 (7.185.36.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 30 Jun
 2025 16:54:15 +0800
From: Longfang Liu <liulongfang@huawei.com>
To: <alex.williamson@redhat.com>, <jgg@nvidia.com>,
	<shameerali.kolothum.thodi@huawei.com>, <jonathan.cameron@huawei.com>
CC: <kvm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linuxarm@openeuler.org>, <liulongfang@huawei.com>
Subject: [PATCH v5 0/3] update live migration configuration region
Date: Mon, 30 Jun 2025 16:53:59 +0800
Message-ID: <20250630085402.7491-1-liulongfang@huawei.com>
X-Mailer: git-send-email 2.24.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemf500015.china.huawei.com (7.185.36.143)

On the new hardware platform, the configuration register space
of the live migration function is set on the PF, while on the
old platform, this part is placed on the VF.

Change v4 -> v5
	Remove BAR length alignment

Change v3 -> v4
	Rebase on kernel 6.15

Change v2 -> v3
	Put the changes of Pre_Copy into another bugfix patchset.

Change v1 -> v2
	Delete the vf_qm_state read operation in Pre_Copy

Longfang Liu (3):
  migration: update BAR space size
  migration: qm updates BAR configuration
  migration: adapt to new migration configuration

 drivers/crypto/hisilicon/qm.c                 |  29 +++
 .../vfio/pci/hisilicon/hisi_acc_vfio_pci.c    | 202 ++++++++++++------
 .../vfio/pci/hisilicon/hisi_acc_vfio_pci.h    |   7 +
 3 files changed, 176 insertions(+), 62 deletions(-)

-- 
2.24.0


