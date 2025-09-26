Return-Path: <linux-kernel+bounces-833629-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 281EDBA27CC
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 08:02:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D386C4C8372
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 06:02:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C28927A469;
	Fri, 26 Sep 2025 06:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WHbySpC4"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 481CC1D90DF
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 06:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758866565; cv=none; b=h+fTjJ5CMt3HJ2l+TB/t7/oedIodjZH3aOLXjqb0t1XkcCHkORdX13bDi5QOjESPmPgij2MfSb7DGb88/fJJE+gx+xvKx8Q4dpjrqxrlOevu/ShVzpLu6DNYiuM3oPzs8yjyjJjmWCkdNZO/hQhlotY1juZy2gXz0anfo512nYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758866565; c=relaxed/simple;
	bh=POyFtLZ7UIXGuFMD1yKppyUrmoQC7dA7w7dQvtUqCm4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ApSgshnCih7AXAZfvL6IvaPcOHyAixezjugUSKSdVHaqQ6ARTf+TDgM+S5j6Ko4YuYbb/NBbpNi6EAUPSJ2VjTd/JAiazyCsxGo9aLU9S7pabenHUgRluNVvGtywNnjSeRpxGqAc6i4JWUtd8dSaDEeQqwL8moXonAr9h4s6bpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WHbySpC4; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-57a604fecb4so2163720e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 23:02:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758866561; x=1759471361; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9fBcy3c/E/T3NGDH5JHB3RnEcKctDeRvXgPqBJQGNSA=;
        b=WHbySpC46b35XnuWdjNKRiuWu3/yPOP11IBf6syhJhsgNU9a7C88KcJZE85qt87fI9
         2UTl5P+Mw9QgksPbvS9SUhtXIx5TAs+MzsDg3Zy7uvazcgYN27MQ9gNHQtfCPzAJsmWP
         HTjBMDCNKAfGbDI3U/oke8FW0H4Igg+F9BvouFS0Y8Fm044tZWc/0o31ERbNtRRsfZwD
         IX8pPn+3oh1SkaxwI4tDG8tfCdeTYAvdP/Je+OtDMrnjoPkgiu2zAIscbm4hk2yHeF5B
         cS2UkT0rkZ1KNal2igh4tLfbaXsEgr9gtxdRAfrBhScPuK2DWYmu9TbMlUbaTrNNYZ91
         KLhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758866561; x=1759471361;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9fBcy3c/E/T3NGDH5JHB3RnEcKctDeRvXgPqBJQGNSA=;
        b=kYQnwlbuql0xtkXud+k6dkY7iXs53kVvWzak2auLF4NmCpoucT5xvPTvyjnsB9L6GV
         lWYGcmAYcn9FDUlM1COBPEnnCFX1Cl2d2INk85oxF/XugaPm5GXARIamChvDDECtjOc1
         rI0OJ3RkzMwF4nElKAu+OzxMgTrFbTuwggm6rex+WZr92TR29cd4DwAaqn6uXnvNH1jq
         7rkq8GO6QRVHboR7OzTAnKtCYzHtlID5LwzGjQt4W+4eKIdY/DuOrGXhnKXn8UkZS5N+
         ShVrvx5AmjYhGSvtp7ZrwZ/KIkXeRkbW6HhFOcBFvimFLakBWZEDjxkqOumOIr/81Dgj
         egzQ==
X-Forwarded-Encrypted: i=1; AJvYcCU3JIKQ4DhNOFJPsAG95PgvCa8p/OIqqxVyHhCCQlojnehRxWF/hzIzFwwQJA/BJcdjEyq+XllWu3IBI90=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8xODTjPvUZyHvudDZDUPY+0iNu7HEfx2loEh/6tudLcFBjbtz
	e4UIFwF2n8Z17pjnpKCcOpRXuprMiTbwPUBhl6jIvuLJEgRUfLoRwxYO
X-Gm-Gg: ASbGnctlWvO+bohgV+/Sqg2nNNc14DC0qLqmuPA1vJ53aLb/4SChNSnCKdkemf373Gu
	Xd+9FbmPC6UmsCmcp4OJgYZ+fJwdLjNSyB4zltluBj9e5JACZdi4c8tO7sMD5ATAmbB6GVDyPXu
	3uGFrc4eoau1Vk7uSqynUHRKn2UASgIo7d3QTaKGPQ+8vvyPoTjicRS2a7POcKN0kJNHefIcIli
	seeHeUxKnY+Uun1g2b2RmtDdgCqNJHHm2ZdNrRmjjjkJVtvhKsnyLl349y3+MRTQ9SEuN6eiTjQ
	kqOFZeSd8WkfNGcCScLDufmw2spQHOP+NuibnaGUVk4CgyE2ZjXXg9+MVKeKlvJXjoDq6XTfXYD
	UxJSDIJ1AU1W8yTLANAhhxkY53Dc3D6i4eog5KCNm4VLaoMxm0SjjxFzMY9rtE3wAUL/RHh+MPT
	fr5Q==
X-Google-Smtp-Source: AGHT+IGV8QDcAeAN6q0hBhlpXKx5E3Z5Sk+qkGALyzG9+OrIh/NJRGoVi2Z2NS1LSyZkITzGL0IGHw==
X-Received: by 2002:a05:6512:3d8a:b0:577:494e:ca70 with SMTP id 2adb3069b0e04-582d092d95cmr1963358e87.8.1758866561031;
        Thu, 25 Sep 2025 23:02:41 -0700 (PDT)
Received: from Cryo-Lima.localdomain (109-227-126-171.dynamic-pool.mclaut.cc. [109.227.126.171])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-583173d0f44sm1499633e87.143.2025.09.25.23.02.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Sep 2025 23:02:40 -0700 (PDT)
From: Oleksandr Suvorov <cryosay@gmail.com>
To: Johan Hovold <johan@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Oleksandr Suvorov <cryosay@gmail.com>
Subject: [PATCH] USB: serial: ftdi_sio: add device ID for U-Blox EVK-M101
Date: Fri, 26 Sep 2025 09:02:35 +0300
Message-ID: <20250926060235.3442748-1-cryosay@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

The U-Blox has a USB Type-C port that presents itself as a USB device
(1546:0506) [1] with four attached FTDI serial ports, connected to:
- EVK-M101 current sensors
- EVK-M101 I2C
- EVK-M101 UART
- EVK-M101 port D

This commit registers U-Blox's VID/PID of this device so that FTDI SIO driver
successfully registers these 4 serial ports.

[1]
usb 5-1.3: new high-speed USB device number 11 using xhci_hcd
usb 5-1.3: New USB device found, idVendor=1546, idProduct=0506, bcdDevice= 8.00
usb 5-1.3: New USB device strings: Mfr=1, Product=2, SerialNumber=0
usb 5-1.3: Product: EVK-M101
usb 5-1.3: Manufacturer: u-blox AG

Datasheet: https://content.u-blox.com/sites/default/files/documents/EVK-M10_UserGuide_UBX-21003949.pdf

Signed-off-by: Oleksandr Suvorov <cryosay@gmail.com>
---
 drivers/usb/serial/ftdi_sio.c     | 1 +
 drivers/usb/serial/ftdi_sio_ids.h | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/usb/serial/ftdi_sio.c b/drivers/usb/serial/ftdi_sio.c
index 49666c33b41f..5fc9266c1cb3 100644
--- a/drivers/usb/serial/ftdi_sio.c
+++ b/drivers/usb/serial/ftdi_sio.c
@@ -1074,6 +1074,7 @@ static const struct usb_device_id id_table_combined[] = {
 	/* U-Blox devices */
 	{ USB_DEVICE(UBLOX_VID, UBLOX_C099F9P_ZED_PID) },
 	{ USB_DEVICE(UBLOX_VID, UBLOX_C099F9P_ODIN_PID) },
+	{ USB_DEVICE(UBLOX_VID, UBLOX_EVK_M101_PID) },
 	/* FreeCalypso USB adapters */
 	{ USB_DEVICE(FTDI_VID, FTDI_FALCONIA_JTAG_BUF_PID),
 		.driver_info = (kernel_ulong_t)&ftdi_jtag_quirk },
diff --git a/drivers/usb/serial/ftdi_sio_ids.h b/drivers/usb/serial/ftdi_sio_ids.h
index 4cc1fae8acb9..2539b9e2f712 100644
--- a/drivers/usb/serial/ftdi_sio_ids.h
+++ b/drivers/usb/serial/ftdi_sio_ids.h
@@ -1614,6 +1614,7 @@
 #define UBLOX_VID			0x1546
 #define UBLOX_C099F9P_ZED_PID		0x0502
 #define UBLOX_C099F9P_ODIN_PID		0x0503
+#define UBLOX_EVK_M101_PID		0x0506
 
 /*
  * GMC devices
-- 
2.48.1


