Return-Path: <linux-kernel+bounces-807101-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6947B4A034
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 05:44:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A13D64441CF
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 03:44:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB8F327602F;
	Tue,  9 Sep 2025 03:44:22 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6386D272E7B
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 03:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757389462; cv=none; b=f/bO9qTpBaSWU4v52ykpv+2zGkAjob4dfwHfTojZkzT2wqolfvWiUsB53pdmgb8FOWsz1cJHLbKYxgaf1fg3jM6maih4H8QO5hQKevLsciUus1oxHDS8eK/nk9vySNDTL353L9C8PDWK9qhDKJ1uDHwk5aUNgszShcrcmp5WTzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757389462; c=relaxed/simple;
	bh=gDCpq+D8chBeC/sjkf+IgkkpMT8NIfZNa1/+6ArkfhE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=i6RxPZKeBlI4W4D6vYuiMeScpJpgVvbui7BkFBfyKVY02wJI1/sZSGBqhPWckhs1Tjoqys+PPc1SxofOPmNOvdpxFgGS/VQCZ5WqorLb4EVWOwcmP/kkqEYWpDmjCeH/12p5wyJ6uMpVnCI2J0jTMLze0KdZ8uKnIdFfcKBpb5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4cLV1m65CqzRkDx;
	Tue,  9 Sep 2025 11:39:40 +0800 (CST)
Received: from dggpemf500013.china.huawei.com (unknown [7.185.36.188])
	by mail.maildlp.com (Postfix) with ESMTPS id C2D111800B1;
	Tue,  9 Sep 2025 11:44:17 +0800 (CST)
Received: from huawei.com (10.50.165.33) by dggpemf500013.china.huawei.com
 (7.185.36.188) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 9 Sep
 2025 11:44:17 +0800
From: Jinqian Yang <yangjinqian1@huawei.com>
To: <oliver.upton@linux.dev>, <yuzenghui@huawei.com>, <maz@kernel.org>
CC: <linux-arm-kernel@lists.infradead.org>, <kvmarm@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <liuyonglong@huawei.com>,
	<wangzhou1@hisilicon.com>, <yangjinqian1@huawei.com>
Subject: [PATCH v2 0/3] KVM: arm64: make EL2 feature fields writable in ID_AA64MMFR1_EL1
Date: Tue, 9 Sep 2025 11:44:12 +0800
Message-ID: <20250909034415.3822478-1-yangjinqian1@huawei.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 dggpemf500013.china.huawei.com (7.185.36.188)

Allow userspace to downgrade EL2 features (VH, TWED, HCX) to ensure VM live
migration compatibility between hosts with varying feature support.

v1: https://lore.kernel.org/linux-arm-kernel/20250325121126.1380681-1-yangjinqian1@huawei.com/

Change Log:
v1->v2:
  -Added support for downgrading TWED and VH fields.
  -Added corresponding test cases to the set_id_regs selftest.

Jinqian Yang (3):
  KVM: arm64: Make ID_AA64MMFR1_EL1.HCX writable from userspace
  KVM: arm64: Make ID_AA64MMFR1_EL1.TWED writable from userspace
  KVM: arm64: Make ID_AA64MMFR1_EL1.VH writable from userspace

 arch/arm64/kvm/sys_regs.c                       | 3 ---
 tools/testing/selftests/kvm/arm64/set_id_regs.c | 3 +++
 2 files changed, 3 insertions(+), 3 deletions(-)

-- 
2.33.0


