Return-Path: <linux-kernel+bounces-886481-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D466C35B75
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 13:55:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B685634E77A
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 12:55:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8255316187;
	Wed,  5 Nov 2025 12:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dDlZw9Fs"
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA33B313E04
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 12:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762347315; cv=none; b=sb/61R7HB6vm67bgnkH0/zrDrNUOegU+8m5ywC7zqEkEautlTgoATcs/6/L7ickQ2RHQ0Gh9llDB2GqqhR2nUPSW9dt30JZtnvDmGG3rdSOReyRfvs/TO9QBKxSNfQ0WRr6COLjkH62qrAlrXeZ8MBFB/6iTeAiUI0G17YPBT2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762347315; c=relaxed/simple;
	bh=Wn8M4nU+g/UwE05Qu/WSvpGvx9G0oLrJnBTtlyx7Ujc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZTHtVA2+8dJREbGiHjaiuwVZa+t9DOf9MFXIJEyNOevWWKlbQ2yZYOitpx2wYRO9sJbtD6S5c38nr2BmEwUJpdG1flAgSuP7mOasmfZ7H7wkwZeQqPXiPaehspF+Jv6r8LoDCVehKBPeZSN9oR3RdAopz8NaBsGfNJqYuoRleM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dDlZw9Fs; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-33be037cf73so6852708a91.2
        for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 04:55:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762347313; x=1762952113; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1RfaksWJE0d3VMCElIbQg6mYL84G2wqZDW7eYD0q+rs=;
        b=dDlZw9FsGJl6aEa7f26v32cn88PcEe8JianrfkPzMyic6mM4h6kdiG1iG6MIqrTjji
         jefbJV5+RLkNjEwbySBrJvFt9S3d98fMAWprZJoahZGufGlZE512EL7NQkOsOPVprNoj
         m6y0+R7+0qXneUuH5ZoQbJvdmkCfrWqS4jEqthN0ZI/ozFaaEdXWZrR07sys517mzlzR
         a3rUUpRsdGxJ7j0PEOHE/f7Yl+FkRNQz1y6AT8+F0r5oYF9U1qyilO/u5X8aQuGny8Wc
         3M52t3WbKsKifSS0juv+e04c0BdL50FlFKiF6nQFhWadFJW5i8pXrKhBZjPUigeAHzcR
         w/5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762347313; x=1762952113;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1RfaksWJE0d3VMCElIbQg6mYL84G2wqZDW7eYD0q+rs=;
        b=VWDW5w1mmWqvxY+zrB5TKhYwmH3zcF9iZXFSGKAZpJ3i0D5oNYGRYNqv6+NWhlODKS
         klIvB5Ba7EP0XCbMKgwSFXcQ6V4aeyigUQ0hZj+hY6g5NPzHL2nPA3y1+MGx0YNu9D7H
         l32Iq4OnomOaIXBakwpdXVYPxCN2sEiF76nLc8QO5FRiT701AhEfB5n3+SQ9ABf3H97s
         tLqWsojjKEWc8msL4i6hYtssmuzstLQcmfgH2lRWdNTKJmrWGaHbyU7L0444q55N0SbV
         GO602iiwCz9P6hDmC8VBvHADJyhdNv31kRhGR/fvL4VGqKa0urEdfGqa2nkcnx/g53nw
         T1Zw==
X-Gm-Message-State: AOJu0Yxc+6BYLCOPslH9mfkYPlYhoMw0NJV25MbaMGpnkIuLXsAysq5w
	cqlzKDkNM5Bz6u1H7rO54BGkzqhf/XBpmk0HEbJTQOVvwhjw8gLt2/q4
X-Gm-Gg: ASbGncuD+YGzYZt5fu8R6GrQ0ub8768/85IfTYcRcI9eSy95wgulnYztij3/ezuAQjI
	g47hj9MfeKtPMYV0RyNPa/jPbkWDeNotfvEezMhSGyoHg8Q3Z0+KQG4Nyt/67z+fpKRJ2uoUP4a
	Lb0nW5HOTvtm2cFzFb3C1fZY81WN6bTU+v+P9scQ1opnOEcOjfG6aT2gEYhOOi49UF2+lxW/66E
	fsT8JU10A6L/6Nytntpwb22evhQV/xjZ2NJyrNDm7fmU738MDMLG8mFWyenBv/A9uKBgcuBh2eF
	4+E16zZQGai3VAcn3d2ZGuMtEe92C0QJ5NHfws610d7qE4mYl8B1kOJxtrVu5tC3D0JVDxkT/Qq
	ztF4Y/MziZocfn+UjWEjotxr9GRRsGatSOnRB1s6d2K0UIi/njQaMRJ9h+ttk65clpiSt7hEs5V
	Xp
X-Google-Smtp-Source: AGHT+IHL1apm7PIdUs/PaS9mChKE7wtKefYCCLYmCyunjycPDwXiaaAlhs8Q3Fs/tPla3kMZKGUiQA==
X-Received: by 2002:a17:90b:3843:b0:339:cece:a99 with SMTP id 98e67ed59e1d1-341a6c2d9ccmr3797669a91.13.1762347312700;
        Wed, 05 Nov 2025 04:55:12 -0800 (PST)
Received: from archie.me ([210.87.74.117])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-ba1f1a19e70sm5469191a12.7.2025.11.05.04.55.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 04:55:12 -0800 (PST)
Received: by archie.me (Postfix, from userid 1000)
	id 7E2DB420A6A0; Wed, 05 Nov 2025 19:55:09 +0700 (WIB)
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Documentation <linux-doc@vger.kernel.org>,
	openipmi-developer@lists.sourceforge.net
Cc: Corey Minyard <corey@minyard.net>,
	Jonathan Corbet <corbet@lwn.net>,
	Bagas Sanjaya <bagasdotme@gmail.com>
Subject: [PATCH] Documentation: ipmb: Indent boot time loading steps
Date: Wed,  5 Nov 2025 19:54:49 +0700
Message-ID: <20251105125449.45643-1-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.51.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2528; i=bagasdotme@gmail.com; h=from:subject; bh=Wn8M4nU+g/UwE05Qu/WSvpGvx9G0oLrJnBTtlyx7Ujc=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDJncbjP+ur//qaPnmpoSrpLBoSc1r6bin820u8kn5QzSP zFkczt3lLIwiHExyIopskxK5Gs6vctI5EL7WkeYOaxMIEMYuDgFYCIGTIwMd678OKPJvzv3W/65 GQUTJl7c+innblfT+pU2GboKLqGKaYwMH5+tjD2d1Gn19XGwqvLPvavUpbk/L/JexDBhJV8G078 2VgA=
X-Developer-Key: i=bagasdotme@gmail.com; a=openpgp; fpr=701B806FDCA5D3A58FFB8F7D7C276C64A5E44A1D
Content-Transfer-Encoding: 8bit

Steps for loading IPMB driver at boot time, written as enumerated
sublist, is indented instead on the same level as its parent list.
Indent them as appropriate.

Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 Documentation/driver-api/ipmb.rst | 48 +++++++++++++++----------------
 1 file changed, 24 insertions(+), 24 deletions(-)

diff --git a/Documentation/driver-api/ipmb.rst b/Documentation/driver-api/ipmb.rst
index 209c49e051163f..dd99d034272b7e 100644
--- a/Documentation/driver-api/ipmb.rst
+++ b/Documentation/driver-api/ipmb.rst
@@ -48,35 +48,35 @@ CONFIG_IPMB_DEVICE_INTERFACE=y
 
 1) If you want the driver to be loaded at boot time:
 
-a) Add this entry to your ACPI table, under the appropriate SMBus::
+   a) Add this entry to your ACPI table, under the appropriate SMBus::
 
-     Device (SMB0) // Example SMBus host controller
-     {
-     Name (_HID, "<Vendor-Specific HID>") // Vendor-Specific HID
-     Name (_UID, 0) // Unique ID of particular host controller
-     :
-     :
-       Device (IPMB)
-       {
-         Name (_HID, "IPMB0001") // IPMB device interface
-         Name (_UID, 0) // Unique device identifier
-       }
-     }
+        Device (SMB0) // Example SMBus host controller
+        {
+        Name (_HID, "<Vendor-Specific HID>") // Vendor-Specific HID
+        Name (_UID, 0) // Unique ID of particular host controller
+        :
+        :
+          Device (IPMB)
+          {
+            Name (_HID, "IPMB0001") // IPMB device interface
+            Name (_UID, 0) // Unique device identifier
+          }
+        }
 
-b) Example for device tree::
+   b) Example for device tree::
 
-     &i2c2 {
-            status = "okay";
+        &i2c2 {
+               status = "okay";
 
-            ipmb@10 {
-                    compatible = "ipmb-dev";
-                    reg = <0x10>;
-                    i2c-protocol;
-            };
-     };
+               ipmb@10 {
+                       compatible = "ipmb-dev";
+                       reg = <0x10>;
+                       i2c-protocol;
+               };
+        };
 
-If xmit of data to be done using raw i2c block vs smbus
-then "i2c-protocol" needs to be defined as above.
+   If xmit of data to be done using raw i2c block vs smbus
+   then "i2c-protocol" needs to be defined as above.
 
 2) Manually from Linux::
 

base-commit: 27600b51fbc8b9a4eba18c8d88d7edb146605f3f
-- 
An old man doll... just what I always wanted! - Clara


