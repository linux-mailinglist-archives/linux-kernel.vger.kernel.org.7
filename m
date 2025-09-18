Return-Path: <linux-kernel+bounces-787853-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D8C5B37C37
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 09:51:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 04FAD3B0178
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 07:51:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63F95321457;
	Wed, 27 Aug 2025 07:51:07 +0000 (UTC)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C509317702;
	Wed, 27 Aug 2025 07:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756281067; cv=none; b=KD1P/EOf4XXlFgkkc5J+kN/iuITfbvhw6bBdY5ZXfV6qj5aCoj0LhWUcExXSn28FrAS5JBEcVSpJuOMtQqDLxBmhkxF1hddhKEXOvctzxVdl7SIK/LWOG7VU48ZhGLU7csqck6+zFIod523I7+c7g7iUiNMjbDYDoQDDFgWCeu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756281067; c=relaxed/simple;
	bh=DPZDbWIF2dAyl97Dh6I0cH5avMiSRZLdTQpuF5OAdj0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=EtqJKmnA4PHLePSb3hEVED9U3NmDLmfaOBkqrf9J7SFoZIVQwqaSzxeEDO+qjnAHXOO4Wz1g+J0lb2rxERwRrwqobKjGl8Bj94sAI4USTouyHOqQi31FL3mmEctOrsI2NspsWbX2cTbrlTOxPd5irwgDFh1rD+ni8ryas1488dg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 8f630bfe831a11f0b29709d653e92f7d-20250827
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:046c84e6-4418-4075-a1ea-5e4cd761d646,IP:0,U
	RL:0,TC:0,Content:0,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:25
X-CID-META: VersionHash:6493067,CLOUDID:7bd9595c1ac3a38d3e6fb39d93a7e729,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:102|850,TC:nil,Content:0|50,EDM:5,IP:nil
	,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:
	1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 8f630bfe831a11f0b29709d653e92f7d-20250827
Received: from mail.kylinos.cn [(10.44.16.175)] by mailgw.kylinos.cn
	(envelope-from <liqiang01@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 382673948; Wed, 27 Aug 2025 15:50:54 +0800
Received: from mail.kylinos.cn (localhost [127.0.0.1])
	by mail.kylinos.cn (NSMail) with SMTP id 6EDD7E008FAA;
	Wed, 27 Aug 2025 15:50:54 +0800 (CST)
X-ns-mid: postfix-68AEB8DE-248194557
Received: from localhost.localdomain (unknown [10.42.20.41])
	by mail.kylinos.cn (NSMail) with ESMTPA id 9F883E008FA3;
	Wed, 27 Aug 2025 15:50:52 +0800 (CST)
From: Li Qiang <liqiang01@kylinos.cn>
To: wim@linux-watchdog.org,
	linux@roeck-us.net
Cc: linux-watchdog@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Li Qiang <liqiang01@kylinos.cn>
Subject: [PATCH] wdt: add wdt resource name
Date: Wed, 27 Aug 2025 15:50:50 +0800
Message-Id: <20250827075050.1187397-1-liqiang01@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

When using allocate_resource() to allocate mem resource without
resource name on x86 platforms, we may find "<BAD>" mem resource
at "/proc/iomem", and the system will stuck when booting.

Signed-off-by: Li Qiang <liqiang01@kylinos.cn>
---
 drivers/watchdog/via_wdt.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/watchdog/via_wdt.c b/drivers/watchdog/via_wdt.c
index d647923d68fe..f55576392651 100644
--- a/drivers/watchdog/via_wdt.c
+++ b/drivers/watchdog/via_wdt.c
@@ -165,6 +165,7 @@ static int wdt_probe(struct pci_dev *pdev,
 		dev_err(&pdev->dev, "cannot enable PCI device\n");
 		return -ENODEV;
 	}
+	wdt_res.name =3D "via_wdt";
=20
 	/*
 	 * Allocate a MMIO region which contains watchdog control register
--=20
2.25.1


