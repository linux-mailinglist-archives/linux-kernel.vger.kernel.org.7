Return-Path: <linux-kernel+bounces-747891-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BB700B139C9
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 13:22:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F422B1890014
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 11:23:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D67925A352;
	Mon, 28 Jul 2025 11:22:51 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1DB11DB125
	for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 11:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753701771; cv=none; b=Md0z4hLc+bq3rmkwJGJ/4tSV30OEtGOYdjlra4PHl6VwYIma0tSa1B9RBRYXBJeqhMUwIYzUlW7H4lXoJABOYSQ3lccaiuWMwky5ozGKgnLaDspUJpgRUjeevkBDxP5GRacnwG2YYatS5/pfIa7MBJPQ2dm5hlFXOHTN9WAPrT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753701771; c=relaxed/simple;
	bh=s5N5ekXAXUs4jQo0mz+cmjahcfHDjG9/cUkeLM5Mm6Y=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Z2OCYlf4G26vkyLJzjA5Nnd+/O+imaTwWgksr96ooRaGXpjV0u5QETfqLpMwqW/AO5/WlGD+czONans1JpaNosQx813LQUdkIPkt7Nm0b2pa49Zr/2h/RfcEZrzFRBi8eQmGpjjnm+IUpRCRzRxBC2eOfsF3crBgSN/mN9jezu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4brGJk1QsKztSxB;
	Mon, 28 Jul 2025 19:21:42 +0800 (CST)
Received: from kwepemp100011.china.huawei.com (unknown [7.202.195.41])
	by mail.maildlp.com (Postfix) with ESMTPS id 43BEE140257;
	Mon, 28 Jul 2025 19:22:45 +0800 (CST)
Received: from kwepemp200018.china.huawei.com (7.202.194.226) by
 kwepemp100011.china.huawei.com (7.202.195.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 28 Jul 2025 19:22:44 +0800
Received: from localhost.localdomain (10.175.101.6) by
 kwepemp200018.china.huawei.com (7.202.194.226) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 28 Jul 2025 19:22:44 +0800
From: Fanhua Li <lifanhua5@huawei.com>
To: <dri-devel@lists.freedesktop.org>, <nouveau@lists.freedesktop.org>
CC: <liuyongqiang13@huawei.com>, <lyude@redhat.com>, <dakr@kernel.org>,
	<airlied@gmail.com>, <simona@ffwll.ch>, <airlied@redhat.com>,
	<linux-kernel@vger.kernel.org>, <suhui@nfschina.com>
Subject: [PATCH] drm/nouveau/nvif: Fix potential memory leak in nvif_vmm_ctor().
Date: Mon, 28 Jul 2025 19:50:27 +0800
Message-ID: <20250728115027.50878-1-lifanhua5@huawei.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 kwepemp200018.china.huawei.com (7.202.194.226)

When the nvif_vmm_type is invalid, we will return error directly
without freeing the args in nvif_vmm_ctor(), which leading a memory
leak. Fix it by setting the ret -EINVAL and goto done.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/all/202312040659.4pJpMafN-lkp@intel.com/
Fixes: 6b252cf42281 ("drm/nouveau: nvkm/vmm: implement raw ops to manage uvmm")
Signed-off-by: Fanhua Li <lifanhua5@huawei.com>
---
 drivers/gpu/drm/nouveau/nvif/vmm.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/nouveau/nvif/vmm.c b/drivers/gpu/drm/nouveau/nvif/vmm.c
index 99296f03371a..07c1ebc2a941 100644
--- a/drivers/gpu/drm/nouveau/nvif/vmm.c
+++ b/drivers/gpu/drm/nouveau/nvif/vmm.c
@@ -219,7 +219,8 @@ nvif_vmm_ctor(struct nvif_mmu *mmu, const char *name, s32 oclass,
 	case RAW: args->type = NVIF_VMM_V0_TYPE_RAW; break;
 	default:
 		WARN_ON(1);
-		return -EINVAL;
+		ret = -EINVAL;
+		goto done;
 	}
 
 	memcpy(args->data, argv, argc);
-- 
2.43.0


