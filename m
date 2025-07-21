Return-Path: <linux-kernel+bounces-738779-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AACA1B0BCF0
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 08:47:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7379D189B793
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 06:47:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8A3A223302;
	Mon, 21 Jul 2025 06:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="cDzaD4nb"
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A8CF72618
	for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 06:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753080435; cv=none; b=uosjCNKBaoomSKz4c9B8DWDVsTQD0XorCzqIOcUlHktgTcYuDo+ym8i40ub/2sC8hA7o+uYrHiZt94xDeoN7jq6bXSTrWJFXdJcJdm21ME0C7o+FGWCoJoPP1XTRHSjBgu4u5k4c8xRN6gTQYT07vasCLezstcSw+YlJr2QOgX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753080435; c=relaxed/simple;
	bh=46z8cxXbXWVS1icOwx52qVzZDcPN2hnpSFsVyIGKQzA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OCw/HwEjuNjiIuN3srfxaglgcDHhUIft50i2l/2eUv4yf1oliOAW0htuKcKotAffRyTak/xA/cDue4abM4B2a+scFbmcSWNO8WeXf2NXvs3fhW9QimE/v8Laf+iL9YiNbor/GQwokmnoUojiVmOjikMZ7xrtBgpcWUUpMTi4D34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=cDzaD4nb; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=l0
	F3tulMToPzoOPySI148a121qnmIMZCAO/iD1nw/R8=; b=cDzaD4nbVxfI0FD7Dy
	vxUyHeaqi1jaKOD13G6EMM8usqYrlOx/De66iV6PRxu/wt2BOJCj1cCSZ9qmpjVM
	MXAD3HjxTkax5LKJwXdICOG65IZ0nt/nL2HZPSlgYk3jwaf1Npt1xoIU9KpiEnci
	CUaggqPd/oycJLbOcPgwvvXTY=
Received: from neo-TianYi510Pro-15ICK.. (unknown [])
	by gzsmtp4 (Coremail) with SMTP id PygvCgA3Re9L4n1oDDEzAQ--.15687S2;
	Mon, 21 Jul 2025 14:46:36 +0800 (CST)
From: liuqiangneo@163.com
To: alexander.deucher@amd.com,
	christian.koenig@amd.com,
	airlied@gmail.com,
	simona@ffwll.ch
Cc: linux-kernel@vger.kernel.org,
	Qiang Liu <liuqiang@kylinos.cn>
Subject: [PATCH] drm/amdgpu: remove duplicated argument wptr_va
Date: Mon, 21 Jul 2025 14:46:14 +0800
Message-ID: <20250721064614.9213-1-liuqiangneo@163.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PygvCgA3Re9L4n1oDDEzAQ--.15687S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrKFy8ArWkuF48AF1kKryxGrg_yoW3WrX_CF
	4UXas8JFy3CFnFqr1Iyr4Y93yYkF1a9rZ7uw4YvF93t342v3y3XryDtr15XFn8CF4xCFWk
	Xw4qgF1DAan7GjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU8yGQDUUUUU==
X-CM-SenderInfo: 5olx1xxdqj0vrr6rljoofrz/1tbiNBGRYWh93XBuUwAAsQ

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


