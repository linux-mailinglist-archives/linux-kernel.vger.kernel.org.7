Return-Path: <linux-kernel+bounces-764242-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 70306B22052
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 10:09:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E65881AA1AB9
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 08:08:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 229712DECB7;
	Tue, 12 Aug 2025 08:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="bRhnPduq"
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 298702D6E63;
	Tue, 12 Aug 2025 08:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754986062; cv=none; b=eTBSnSlFDCY2LScwAfBBJ2RFa/pFEuSiT9i6GHBumMGrh8WEoWXyJJQceES5wV+FfM0yiVgQn1nKgjb1zN9euNJKG4QDnL72u9HtFOLKr563Ci8j/y+RAoMxDHJ5Xi8IYCBErKNJZ17IwwyqK39C8INWhfR1z+IR7QTpmDWLKNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754986062; c=relaxed/simple;
	bh=oCfBQg9H7CTvBrijTOOL3L74nrGxmWxExLc0UYr0HwE=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=ZHW//iZzP2Cn308TYfiK7/WF52S8q8XiaCIHcp4k/0koTzXciy5wlrfHuYjOEV3xBwOTaWnAyJava+cszytaL+ijeHsnchiItPtQzZJUI10AgpCkS724USL+sUTRACpcmxCv1bOjkQqrAncUZmIjJDeN/EwTnfzg6sdM3X+8jjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=bRhnPduq; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version:
	Content-Type; bh=kx/Vc9v/6c/HsuODqHtrzRVp+1SNqALEPtEmraNOycU=;
	b=bRhnPduqk3tFtRBIiU1PApXQCsCKdFzT50kUKYpZgox2EF9B0gI5cR58IkH11k
	fu2W2nCPS94gjrF246BM4WXff7De5+JE2FKB1RnCcobGviP6thGq7PASNZJY11XY
	6O6O+NZRTCeAE2qJZ+fysovaBhGhiLAZr2nlmcgU2kUAc=
Received: from root (unknown [])
	by gzga-smtp-mtada-g1-4 (Coremail) with SMTP id _____wBHZSQZ9ppoCK65Aw--.24679S3;
	Tue, 12 Aug 2025 16:06:52 +0800 (CST)
From: <yizhijiao2025@163.com>
To: "'Junnan Wu'" <junnan01.wu@samsung.com>,
	<sudeep.holla@arm.com>,
	<cristian.marussi@arm.com>
Cc: <florian.fainelli@broadcom.com>,
	<arm-scmi@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>,
	<lei19.wang@samsung.com>,
	<q1.huang@samsung.com>
References: <CGME20250812075350epcas5p1cc4533582704978ec3a4a8b73dc1535c@epcas5p1.samsung.com> <20250812075343.3201365-1-junnan01.wu@samsung.com>
In-Reply-To: <20250812075343.3201365-1-junnan01.wu@samsung.com>
Subject: =?utf-8?Q?=E5=9B=9E=E5=A4=8D:_=5BPATCH=5D_firmware:_arm=5Fscmi:_?=
	=?utf-8?Q?Set_device_ready_before_register?=
	=?utf-8?Q?_scmi=5Fvirtio=5Fdriver?=
Date: Tue, 12 Aug 2025 16:06:51 +0800
Message-ID: <00e501dc0b60$0f965a70$2ec30f50$@163.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQHpA3ghvbQLx5bOGmQsVb61YIAsWwIYH9intDP4LmA=
Content-Language: zh-cn
X-CM-TRANSID:_____wBHZSQZ9ppoCK65Aw--.24679S3
X-Coremail-Antispam: 1Uf129KBjvJXoWxAr48Ww1DZrW3ur4kKFW8tFb_yoW5Xry7pF
	4qga98A34UGr4fJ3WUXa1xuFyY9aykWr93WryUWasYgr1DAF95XwsrtrWqg347Jr1Uta4f
	t3Z2qryv9a4DurJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07bU5rcUUUUU=
X-CM-SenderInfo: x1l2xxpmld0jqqsvqiywtou0bp/xtbBaxmnbGia8wVZrAAAsI



-----=E9=82=AE=E4=BB=B6=E5=8E=9F=E4=BB=B6-----
=E5=8F=91=E4=BB=B6=E4=BA=BA: =
arm-scmi+bounces-2017-yizhijiao2025=3D163.com@vger.kernel.org =
<arm-scmi+bounces-2017-yizhijiao2025=3D163.com@vger.kernel.org> =
=E4=BB=A3=E8=A1=A8 Junnan Wu
=E5=8F=91=E9=80=81=E6=97=B6=E9=97=B4: 2025=E5=B9=B48=E6=9C=8812=E6=97=A5 =
15:54
=E6=94=B6=E4=BB=B6=E4=BA=BA: sudeep.holla@arm.com; =
cristian.marussi@arm.com
=E6=8A=84=E9=80=81: florian.fainelli@broadcom.com; =
arm-scmi@vger.kernel.org; linux-arm-kernel@lists.infradead.org; =
linux-kernel@vger.kernel.org; lei19.wang@samsung.com; =
q1.huang@samsung.com; Junnan Wu <junnan01.wu@samsung.com>
=E4=B8=BB=E9=A2=98: [PATCH] firmware: arm_scmi: Set device ready before =
register scmi_virtio_driver

Fix irregularities in scmi driver probe.

After 'commit 20bda12a0ea0 ("firmware: arm_scmi: Make VirtIO transport a =
standalone driver")'
making SCMI VirtIO transport a standalone driver, `scmi_virtio_probe` =
will follow `scmi_vio_probe`, and during `scmi_virtio_probe`, it will do =
`scmi_probe` which will invoke function `scmi_protocol_acquire(handle, =
SCMI_PROTOCOL_BASE)`, and this function will send message via virtqueue =
and wait device's reply

Before this patch, only after `scmi_vio_probe`, frontend will mark =
device DRIVER_OK by function `virtio_dev_probe` in =
'drivers/virtio/virtio.c' itself.

Accroding to chapter '3.1 Device Initialization' in virtio-spec, ``` The =
driver MUST NOT send any buffer available notifications to the device =
before setting DRIVER_OK.
```

In some type1-hypervisor, available buffer notifications will be =
intercepted until virtio driver is okay. In this case, `scmi_vio_probe` =
will be blocked at `scmi_wait_for_reply` and probe can never complete.

Therefore, the operation to set DRIVER_OK must follow perform =
device-specific setup immediately, then available buffer notifications =
can be sent in function `scmi_probe`.

Fixes: 20bda12a0ea0 ("firmware: arm_scmi: Make VirtIO transport a =
standalone driver")
Signed-off-by: Junnan Wu <junnan01.wu@samsung.com>
---
 drivers/firmware/arm_scmi/transports/virtio.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/firmware/arm_scmi/transports/virtio.c =
b/drivers/firmware/arm_scmi/transports/virtio.c
index cb934db9b2b4..326c4a93e44b 100644
--- a/drivers/firmware/arm_scmi/transports/virtio.c
+++ b/drivers/firmware/arm_scmi/transports/virtio.c
@@ -871,6 +871,9 @@ static int scmi_vio_probe(struct virtio_device =
*vdev)
 	/* Ensure initialized scmi_vdev is visible */
 	smp_store_mb(scmi_vdev, vdev);
=20
+	/* Set device ready */
+	virtio_device_ready(vdev);
+
 	ret =3D platform_driver_register(&scmi_virtio_driver);
 	if (ret) {
 		vdev->priv =3D NULL;
--
2.34.1



