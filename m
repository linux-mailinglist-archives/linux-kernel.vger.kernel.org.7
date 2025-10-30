Return-Path: <linux-kernel+bounces-878720-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id DB3F0C2154A
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 17:57:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9BA044E9497
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 16:52:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC9DF2EDD50;
	Thu, 30 Oct 2025 16:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VM0Nv8lb"
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 741162E336E
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 16:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761843174; cv=none; b=nKoYAZ7tTqMc8LqWF6RiBw82Cfh0p/IC3R2GPE6T+kfNWa7iDeFZLXtyNic1QJP3QJ18FZQRicvBuqv9jL5sbZUC2CqWBgnvSXHO2mnmzt7I1c+oVph0fwDTHf+hy5kVcoQ4NjJIs2ztcal3FXBl1JAVdjVUNcQ6iKc5QcB7+TI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761843174; c=relaxed/simple;
	bh=saTzTsk6ERiceKfN8Um2hY3saGopo1TUW/HSVvdmTX4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OMRTKW7krSVVmLNgcaRBbBkxzfeSWUZ08OiIeRw86tP7qlwbVpUUikY+Pb3/Re4EckD18c7m9XIPiqXPWmVo4pb7uOJHsINOotv/feyh4Bn22T2+CgLwEunK6twcppG/GHWzBdIFzx7m7Dz3oRmf3z+AWqT4YuqRnlf7NDOj35E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VM0Nv8lb; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-378d61ce75aso13772801fa.1
        for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 09:52:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761843170; x=1762447970; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tlWDyxYkhp/D36U5g27lvu6EGh+jZYN4Y/0k0qjqXDY=;
        b=VM0Nv8lbs8sE+1XzANOEKDKnVrGGN6/4B1+Qo26zEjwoKZtHXbcaauDnsA++/Ejagn
         PpTE1ookWtGFznLVTobUiBzIrfqCbhsuc4a/KA9K6xFuQF4TB5D3kacvliXS7KmE5Am0
         NXdlMwl0pZzmo/xJtyLJYKhA5AlzwlQbJPl2DnFWY26jFcosFMxbI70ydqSe7E8+/d2D
         cSBYjVZSWYsl3eNr9l8kubU2qDPj7cADzvANpJwdw/xf15w/KCdUkn9wJ6SYDDVERwb7
         tHn6STtVQKhabJFjxnLgspNtB5+q8tboF5F3sj68yJZ9h4p3mi+om80QyrPRT0J4C5jk
         Kijw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761843170; x=1762447970;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tlWDyxYkhp/D36U5g27lvu6EGh+jZYN4Y/0k0qjqXDY=;
        b=ix/6k3V2JGSatb/dkJ38HPZArZ6FXc1BqbaB2BFhRDoaixeCOTYHPvSClxbOye3uep
         o+zui8qgr/CNllT43oHjOHYygMop0HNeYKhcCOGv1YiRGqbVS4cjuo8uPggo+pTtog4e
         v3CzgAl0RUWuki5ouDKhzVXGBsyMsaa8CYDExg+ZIdjnyt1rdIi7FgSasSHbq1sim2V8
         z5REKtGatsT47/HMe9wMI5s+Yc9Q5YwSRqZxND9+Yrd197O1ZnhU0cbly8RN5BgghbdP
         X1YIp7xo5K1FHZPPO0ImGMbC37HnepWIE43Wb5j8MLsDTX/JjY14wr+yD5KIQLVxKZ4U
         YJHQ==
X-Gm-Message-State: AOJu0YwsQVUvVL7FZ+iXXKSQh+GOS2I2aetPm5aggOLV4mDYGu4Q/ChN
	g0x5vnl9GWALIHMipJG6q2KieqsJAr20dk6OzstPcD5NPgcPyLvqzUeV61Hl8g==
X-Gm-Gg: ASbGncuEDy2Y96LaDEEI9zSX7XglBjOL+EMUnJ8JlymmrTpKUpJ+22uC9LyoOgU5Dti
	LGyzgh7h9mQl89BJipQYEkM2yum872Sb4u5paNTwo2UAOzP+0YY6ZqvvhVMJypsW64+CUjDm7P8
	77OuSGIvhK2lBwF62d3sNfPgw97OeoFa/UL3mwBHZy9scLm4UwhS8/f78NgJowEdP7ZPTHWlSYG
	OiRVxq7PtZqd4qZWN8yC36wHu7NthA8qsHJI2E6jIdh1INbeiG+F2ck6vWL393Z5ytaf3kWlOiL
	hX+bnAqPYB/GW+3e6zSOkaRfwqpcf9l1pFIevTkeLJVJb70qUldUeNUkCFdImPifzKFV+jxa5yU
	fQgnN3RDJcj5H2AXH5OqS5Xy/zmhxjGUvMJFdLWls0ymCGgVtnm3RqmdHteu5fwbnb/dsasIy
X-Google-Smtp-Source: AGHT+IHMIiS1YfXHjJxpkwJPtXSZb88H5cKO1QAaq1vg4aVdRFl7kzYz9oYVEeHVUcNBuvCMZWKyYw==
X-Received: by 2002:a05:651c:25d6:20b0:373:a93d:5b4d with SMTP id 38308e7fff4ca-37a18dc9c52mr1602251fa.14.1761843170270;
        Thu, 30 Oct 2025 09:52:50 -0700 (PDT)
Received: from alpha ([5.128.45.91])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-378ee0c6269sm40757091fa.30.2025.10.30.09.52.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Oct 2025 09:52:49 -0700 (PDT)
From: Pavel Bystrov <pavelbystrov.work@gmail.com>
To: krzk@kernel.org
Cc: linux-kernel@vger.kernel.org,
	Pavel Bystrov <pavelbystrov.work@gmail.com>
Subject: [PATCH] w1: ds2482: Rename 'read_prt' to 'read_ptr' for consistency with the datasheet.
Date: Thu, 30 Oct 2025 23:51:40 +0700
Message-ID: <20251030165140.89996-1-pavelbystrov.work@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The DS2482 datasheet uses "read pointer" for this register selector.
Rename the variable to match, improving readability and greppability.

No functional change.

Signed-off-by: Pavel Bystrov <pavelbystrov.work@gmail.com>
---
 drivers/w1/masters/ds2482.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/w1/masters/ds2482.c b/drivers/w1/masters/ds2482.c
index e2a568c9a..aa9e8c7a9 100644
--- a/drivers/w1/masters/ds2482.c
+++ b/drivers/w1/masters/ds2482.c
@@ -116,7 +116,7 @@ struct ds2482_data {
 
 	/* per-device values */
 	u8			channel;
-	u8			read_prt;	/* see DS2482_PTR_CODE_xxx */
+	u8			read_ptr;	/* see DS2482_PTR_CODE_xxx */
 	u8			reg_config;
 };
 
@@ -145,13 +145,13 @@ static inline u8 ds2482_calculate_config(u8 conf)
  */
 static inline int ds2482_select_register(struct ds2482_data *pdev, u8 read_ptr)
 {
-	if (pdev->read_prt != read_ptr) {
+	if (pdev->read_ptr != read_ptr) {
 		if (i2c_smbus_write_byte_data(pdev->client,
 					      DS2482_CMD_SET_READ_PTR,
 					      read_ptr) < 0)
 			return -1;
 
-		pdev->read_prt = read_ptr;
+		pdev->read_ptr = read_ptr;
 	}
 	return 0;
 }
@@ -169,7 +169,7 @@ static inline int ds2482_send_cmd(struct ds2482_data *pdev, u8 cmd)
 	if (i2c_smbus_write_byte(pdev->client, cmd) < 0)
 		return -1;
 
-	pdev->read_prt = DS2482_PTR_CODE_STATUS;
+	pdev->read_ptr = DS2482_PTR_CODE_STATUS;
 	return 0;
 }
 
@@ -190,7 +190,7 @@ static inline int ds2482_send_cmd_data(struct ds2482_data *pdev,
 		return -1;
 
 	/* all cmds leave in STATUS, except CONFIG */
-	pdev->read_prt = (cmd != DS2482_CMD_WRITE_CONFIG) ?
+	pdev->read_ptr = (cmd != DS2482_CMD_WRITE_CONFIG) ?
 			 DS2482_PTR_CODE_STATUS : DS2482_PTR_CODE_CONFIG;
 	return 0;
 }
@@ -241,7 +241,7 @@ static int ds2482_set_channel(struct ds2482_data *pdev, u8 channel)
 				      ds2482_chan_wr[channel]) < 0)
 		return -1;
 
-	pdev->read_prt = DS2482_PTR_CODE_CHANNEL;
+	pdev->read_ptr = DS2482_PTR_CODE_CHANNEL;
 	pdev->channel = -1;
 	if (i2c_smbus_read_byte(pdev->client) == ds2482_chan_rd[channel]) {
 		pdev->channel = channel;
-- 
2.50.1


