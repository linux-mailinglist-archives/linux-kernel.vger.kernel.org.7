Return-Path: <linux-kernel+bounces-744112-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 276E0B10822
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 12:51:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 656E55A28E8
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 10:51:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07E5826A08A;
	Thu, 24 Jul 2025 10:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="NUVkUtvD"
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D076426056C
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 10:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753354289; cv=none; b=JVdokxOTK9N8yF7XMu547HkE8PQK2q3dK0DVAluJM8kV0u7rYqsTch3G7tmoL9SbjJYPWGhlSOhnsA05ziuHTUCy6iUM9KNjYrjDmbPwqCql6/kTaOfWkM4O5XRU6KWZRS0VinCU9dla09wPoDV2LIb/fo8ZL+dnNGmcHUERhnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753354289; c=relaxed/simple;
	bh=j7uFVI6V9l7xw8fRLfHfkPak5LLAXMZaE/olyfNnFSw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Fc7Mphdoa+q782ssjRWW1KN3N3agqwtYHKSUnOWm60GRUxJLT9DvaUzlvkaQUY7D9LITsoEJoT6KKav69QTDQTiMLlWb2pUHEO9Xk44dLrnANjhmegt1xC00HU/eHhJnhwp5/ghhqAz/1Lnq1lthXLLlesS0nqf+ipIwRt91hpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=NUVkUtvD; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=sG
	Ogskg8s5xBFSO7BcKKXe8Vx92lIyfPLMggAd8wFCU=; b=NUVkUtvD/r42anpWZe
	1/lwKQxb0J9aAVjZM2tyv5ACz7+JAxfpJ+r9bkClL5fNE5MJnzx41iGGRUR8MGXY
	1rCn+tM7AFUdk43A/CBk1DjMg26YSFrMa+cfB/nLzHFjx9aAk/nE0j3DEhozoEJZ
	58wtZ1+hULZKtAo/ltccbL6no=
Received: from vbox.. (unknown [])
	by gzga-smtp-mtada-g0-0 (Coremail) with SMTP id _____wAXcwIFEIJokrTYGw--.35831S2;
	Thu, 24 Jul 2025 18:50:46 +0800 (CST)
From: likunyu10 <likunyu10@163.com>
To: kbusch@kernel.org,
	axboe@kernel.dk,
	hch@lst.de,
	sagi@grimberg.me
Cc: linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	likunyu15 <likunyu15@jd.com>
Subject: [PATCH] drivers/nvme/host/pci: Fix the asynchronous detection issue of nvme devices
Date: Mon, 21 Jul 2025 02:51:54 +0800
Message-ID: <20250720185154.138391-1-likunyu10@163.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wAXcwIFEIJokrTYGw--.35831S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7Xw17tw48ArW5WF1ruryUKFg_yoWfJFc_Ar
	yfur43Xay0kF4vqw12ga1fZryUKwsxXw1xua1SgF9agFnrWa9xJwn5ZFnxZ34fWwnYkF9r
	WFWUGryfZrW7ujkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU5nZ2DUUUUU==
X-CM-SenderInfo: poln30d1xriqqrwthudrp/1tbiNh6UpGiCA2PurwAAsT

From: likunyu15 <likunyu15@jd.com>

PROBE_PREFER_ASYNCHRONOUS asynchronous detection has a significant impact
on important devices. For example, if a server has two or more nvme disk
devices, it can cause disk loading disorder, which can also have a
certain impact on actual production environments.

Signed-off-by: likunyu15 <likunyu15@jd.com>
---
 drivers/nvme/host/pci.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 320aaa41ec39..c7f90621e633 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -3832,7 +3832,6 @@ static struct pci_driver nvme_driver = {
 	.remove		= nvme_remove,
 	.shutdown	= nvme_shutdown,
 	.driver		= {
-		.probe_type	= PROBE_PREFER_ASYNCHRONOUS,
 #ifdef CONFIG_PM_SLEEP
 		.pm		= &nvme_dev_pm_ops,
 #endif
-- 
2.41.0


