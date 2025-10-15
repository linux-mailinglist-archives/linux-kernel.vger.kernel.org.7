Return-Path: <linux-kernel+bounces-854237-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 31056BDDE19
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 11:56:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id F1FF54E5DA3
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 09:56:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D657A31B801;
	Wed, 15 Oct 2025 09:56:15 +0000 (UTC)
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9F0C270553
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 09:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760522175; cv=none; b=hLuBCh31yJ7shRa+LCIKu7LCQpdr0FWjK0PuMzFPVH/njXuOHuewfzd438GeqhDBtUeu180ZSa9PD3kEXngXJpLTyDcFsIJ97Nhacep0Em3i2yEauIw/DEGBpxMFnc+C3Z+BHO+33AYs5FRZ0f6xpzMkIxEBFy51FFVroJl/dQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760522175; c=relaxed/simple;
	bh=65O0PU7lAN3pxO794ll9r653Dndk426DC+8mbG1v+FQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fdhdIMY0bkeIKqXkRBDRH9XImH/3+3NXTztXDr8fx0HYWcwCl3AczBobrvPP5Wmw3Q6c7cm0FxQLNUoLp6XU5GbaY+6WkqJREhc8wAjgVyNJo+Go9VkhNYwyHEY8RrexEeH9hWh/BHyNkt4PIW72fE93+HSRLA1DCCADvWAIWrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [223.64.68.198])
	by gateway (Coremail) with SMTP id _____8BxE9C4b+9oVmEWAA--.47585S3;
	Wed, 15 Oct 2025 17:56:08 +0800 (CST)
Received: from localhost.localdomain (unknown [223.64.68.198])
	by front1 (Coremail) with SMTP id qMiowJAxecC1b+9oqIDlAA--.25024S2;
	Wed, 15 Oct 2025 17:56:07 +0800 (CST)
From: Binbin Zhou <zhoubinbin@loongson.cn>
To: Binbin Zhou <zhoubb.aaron@gmail.com>,
	Huacai Chen <chenhuacai@loongson.cn>,
	Lee Jones <lee@kernel.org>,
	Corey Minyard <minyard@acm.org>
Cc: Huacai Chen <chenhuacai@kernel.org>,
	linux-kernel@vger.kernel.org,
	openipmi-developer@lists.sourceforge.net,
	Binbin Zhou <zhoubinbin@loongson.cn>
Subject: [PATCH] MAINTAINERS: Add entry on Loongson-2K IPMI driver
Date: Wed, 15 Oct 2025 17:55:56 +0800
Message-ID: <20251015095556.3736330-1-zhoubinbin@loongson.cn>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJAxecC1b+9oqIDlAA--.25024S2
X-CM-SenderInfo: p2kr3uplqex0o6or00hjvr0hdfq/1tbiAgEQCGjvN5AGfwAAsC
X-Coremail-Antispam: 1Uk129KBj9xXoW7Xr4ftr43CF1UuF45uw45Jwc_yoWfJrbE9r
	1qv3yxWr15Cr97J3y0gFsaqrWaq3yfJF1Fk3Zxtwn3Aa4xtwn8JrWqya9ag3W5C39xWFZI
	qay7Wa4fCr1xuosvyTuYvTs0mTUanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUj1kv1TuYvT
	s0mT0YCTnIWjqI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUI
	cSsGvfJTRUUUbzAYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20x
	vaj40_Wr0E3s1l1IIY67AEw4v_JrI_Jryl8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVWUCVW8JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	WUJVW8JwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0
	oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYIkI8VC2zVCFFI0UMc02F4
	0EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUXVWUAwAv7VC2z280aVAFwI0_
	Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JMxAIw28IcxkI7VAKI4
	8JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xv
	wVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjx
	v20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20E
	Y4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267
	AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxU7XTmDUUUU

When merging the Loongson-2K BMC driver, temporarily removed the
addition of the IPMI driver entry in MAINTAINERS to avoid conflicts.
This needs to be fixed as soon as possible.

Now, adding myself as maintainer for the Loongson-2K IPMI driver.

Signed-off-by: Binbin Zhou <zhoubinbin@loongson.cn>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 46126ce2f968..053295599785 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14660,6 +14660,7 @@ LOONGSON-2K Board Management Controller (BMC) DRIVER
 M:	Binbin Zhou <zhoubinbin@loongson.cn>
 M:	Chong Qiao <qiaochong@loongson.cn>
 S:	Maintained
+F:	drivers/char/ipmi/ipmi_si_ls2k.c
 F:	drivers/mfd/ls2k-bmc-core.c
 
 LOONGSON EDAC DRIVER

base-commit: d27fea27a307656f0b55d6b9ac24caa40c7e4181
-- 
2.47.3


