Return-Path: <linux-kernel+bounces-764756-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E719B226E3
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 14:31:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A8C613B0677
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 12:31:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C50511448E3;
	Tue, 12 Aug 2025 12:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="dVVGSIcn"
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AD605464E
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 12:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755001863; cv=none; b=UVUX/XPyFbncOjqKGMDj6Vw+qaDYUX58A0UzqGNCEvm1rLK/tohs9G7tx3nPrlCiPBtBn6uLxMGm0MKUAR/yQJup7PIwLafaswu2/+8p8D38udH8NbcnL8Cd9PLp7OCmoe7xjSwqd2rsWw5ANKUlRT6mNnWlTi59u4/43eiLpdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755001863; c=relaxed/simple;
	bh=46z8cxXbXWVS1icOwx52qVzZDcPN2hnpSFsVyIGKQzA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bN6m6JV7iT1S4r7/Y0LM+08sLiLH8bD1vXwCx50Hs0nYy3f8eeihOuATtCpxf9/vmK601WxF07nLYv9TBC8JZusnh2QOJrL0VtFNGvM9CVcJcdE2yL0COFNZBfLEkwhe39A2yRerXSKlBbQRP1N9XcsPwRwTV2+mUGmwcXGDzVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=dVVGSIcn; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=l0
	F3tulMToPzoOPySI148a121qnmIMZCAO/iD1nw/R8=; b=dVVGSIcnxykLXzbese
	6xOtls2K8s5AIr6Zvo1+/QXmy3UvG5JfVa1bncmZvoLPgARBueP+zH2OvwSEyJWS
	gBsYY0W5AtxGvxNTSuJ11Th419h9yjW7gE3t5zP3atH4/tODxpT8FLi1DX4Qs7eY
	6t696G7saVaMxpKA9WfoFEMOk=
Received: from neo-TianYi510Pro-15ICK.. (unknown [])
	by gzga-smtp-mtada-g1-3 (Coremail) with SMTP id _____wB3uS7eM5toFN3cBQ--.21824S2;
	Tue, 12 Aug 2025 20:30:24 +0800 (CST)
From: liuqiangneo@163.com
To: alexander.deucher@amd.com,
	christian.koenig@amd.com,
	airlied@gmail.com,
	simona@ffwll.ch,
	shashank.sharma@amd.com,
	sunil.khatri@amd.com
Cc: linux-kernel@vger.kernel.org,
	liuqiang@kylinos.cn
Subject: [RESEND][PATCH] drm/amdgpu: remove duplicated argument wptr_va
Date: Tue, 12 Aug 2025 20:30:21 +0800
Message-ID: <20250812123021.49124-1-liuqiangneo@163.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250721064614.9213-1-liuqiangneo@163.com>
References: <20250721064614.9213-1-liuqiangneo@163.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wB3uS7eM5toFN3cBQ--.21824S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrKFy8ArWkuF48AF1kKryxGrg_yoW3WrX_CF
	4UXas8JFy3CFnFqr1Iyr4Y93yYkF1a9rZ7uw4YvF93t342v3y3XryDtr15XFn8CF4xCFWk
	Xw4qgF1DAan7GjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU8LvtJUUUUU==
X-CM-SenderInfo: 5olx1xxdqj0vrr6rljoofrz/xtbBNQinYWibK-rDFgAAsM

From: Qiang Liu <liuqiang@kylinos.cn>

The duplicate judgment of wptr_va could be removed to simplify the logic

Signed-off-by: Qiang Liu <liuqiang@kylinos.cn>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index c3ace8030530..86cabb20bff1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -567,7 +567,6 @@ int amdgpu_userq_ioctl(struct drm_device *dev, void *data,
 		    args->in.queue_size ||
 		    args->in.rptr_va ||
 		    args->in.wptr_va ||
-		    args->in.wptr_va ||
 		    args->in.mqd ||
 		    args->in.mqd_size)
 			return -EINVAL;
-- 
2.43.0


