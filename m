Return-Path: <linux-kernel+bounces-618344-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 20CC2A9AD47
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Apr 2025 14:25:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC64A1B67478
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Apr 2025 12:25:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84AE4230BCB;
	Thu, 24 Apr 2025 12:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="v420VHWZ"
Received: from outbound.pv.icloud.com (p-west1-cluster4-host8-snip4-2.eps.apple.com [57.103.65.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A93B623027C
	for <linux-kernel@vger.kernel.org>; Thu, 24 Apr 2025 12:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.103.65.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745497443; cv=none; b=f0VFC3n66pUY4raEYpfwwROCYKzucgexseNvPAJQXnMsYID0qBk/V9NZwpw/Dr8r2m3oeudbBhshocFv7ZiTaVZq2UdhE3eUxC5b6V3GI6g+95yYJhZfYN2x1k/ned9YIOdbyPz7vNqNfpznamv94jKB+9VfRdjIHOFC7MZUqLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745497443; c=relaxed/simple;
	bh=Svj8K2mMfw7MHqeGqhHzAiT2JUFa4P4M2Mj1oniQpxI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BeGbRsdsM3azGm4KB2UA5sV+PckSnpekdLnKR/oL8cvkH1IU2yj0Z5ONIFhmej+E66higZjzTTdq2PNOUzBtrPUsSRg2YrwXpleaaYA+BZRW4g/9QInj79KpGxZFBJ9x4B0UrLGqwRKnYq41EkICyHKIFoZ1ddjpU0/tTKxUGSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=v420VHWZ; arc=none smtp.client-ip=57.103.65.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; bh=gzrc5Jt8l/p14lYtc9/COl7AJ4Ldszvxo6hIDOzbFJw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:x-icloud-hme;
	b=v420VHWZySKjaGTu55npG0wDi7NWc9C9XKyZhky7BV/WD7vj+TjJRLKyr7y3iNmR3
	 DyGMT0YjgqwkILJIEcFHsCfGaKp2w9aoHROSxywRXZsfFKip9Js2B82qHmo/At2wCu
	 4kGXJA/VHDL2NN+fghpNwIqSIAyKLK3wrrlC/ok3wmmGQr4evOsu4QmGjeeKJCI5vs
	 WIf02SWB0o+gKFvQSpwxeld7yv48oyRJiK4qZg3hrCbC9hB2QPOkYnwNybzj03g55F
	 iWSqDG9tHdALMHwOd3IRX20nica55PiJb9beQTnpkKUTEdsxexZre11zmYFMSo3425
	 ZqJn1iUr1bGpg==
Received: from [192.168.1.26] (pv-asmtp-me-k8s.p00.prod.me.com [17.56.9.36])
	by outbound.pv.icloud.com (Postfix) with ESMTPSA id 1D5A71800631;
	Thu, 24 Apr 2025 12:23:55 +0000 (UTC)
From: Zijun Hu <zijun_hu@icloud.com>
Date: Thu, 24 Apr 2025 20:23:24 +0800
Subject: [PATCH v2 2/2] serdev: Remove repeated device name in
 dev_(err|dbg) messages
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250424-fix_serdev-v2-2-a1226ed77435@quicinc.com>
References: <20250424-fix_serdev-v2-0-a1226ed77435@quicinc.com>
In-Reply-To: <20250424-fix_serdev-v2-0-a1226ed77435@quicinc.com>
To: Rob Herring <robh@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>
Cc: Zijun Hu <zijun_hu@icloud.com>, linux-serial@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Zijun Hu <quic_zijuhu@quicinc.com>
X-Mailer: b4 0.14.2
X-Proofpoint-GUID: 0CwPusDRHzQvMoJAS0Ky4AcKP0w1k66l
X-Proofpoint-ORIG-GUID: 0CwPusDRHzQvMoJAS0Ky4AcKP0w1k66l
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.680,FMLib:17.12.80.40
 definitions=2025-04-24_05,2025-04-22_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 clxscore=1015
 mlxlogscore=999 adultscore=0 malwarescore=0 spamscore=0 mlxscore=0
 bulkscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2504240083

From: Zijun Hu <quic_zijuhu@quicinc.com>

There are serval dev_err() and dev_dbg() usages shown below:

dev_dbg(dev, "...%s...", dev_name(dev))

The device name is repeated since dev_dbg() also prints device
name as prefix.

Fix by optimizing the messages printed.

Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
---
 drivers/tty/serdev/core.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/tty/serdev/core.c b/drivers/tty/serdev/core.c
index 971651b8e18dcbb5b7983cdfa19e7d60d4cd292b..f00106de76a0f1e547310c7d21cc2fe3d5869e28 100644
--- a/drivers/tty/serdev/core.c
+++ b/drivers/tty/serdev/core.c
@@ -118,12 +118,12 @@ int serdev_device_add(struct serdev_device *serdev)
 
 	err = device_add(&serdev->dev);
 	if (err < 0) {
-		dev_err(&serdev->dev, "Can't add %s, status %pe\n",
-			dev_name(&serdev->dev), ERR_PTR(err));
+		dev_err(&serdev->dev, "Can't add serdev, status %pe\n",
+			ERR_PTR(err));
 		goto err_clear_serdev;
 	}
 
-	dev_dbg(&serdev->dev, "device %s registered\n", dev_name(&serdev->dev));
+	dev_dbg(&serdev->dev, "serdev registered successfully\n");
 
 	return 0;
 
@@ -783,8 +783,8 @@ int serdev_controller_add(struct serdev_controller *ctrl)
 		goto err_rpm_disable;
 	}
 
-	dev_dbg(&ctrl->dev, "%s registered: dev:%p\n",
-		dev_name(&ctrl->dev), &ctrl->dev);
+	dev_dbg(&ctrl->dev, "serdev controller registered: dev:%p\n",
+		&ctrl->dev);
 	return 0;
 
 err_rpm_disable:

-- 
2.34.1


