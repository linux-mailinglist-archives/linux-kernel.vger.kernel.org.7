Return-Path: <linux-kernel+bounces-862067-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB811BF45AE
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 04:08:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D116405326
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 02:08:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C9D4274B5A;
	Tue, 21 Oct 2025 02:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gtX9FdGO"
Received: from mail-il1-f175.google.com (mail-il1-f175.google.com [209.85.166.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AC732737EE
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 02:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761012509; cv=none; b=RJIXy4i6iPsIm8cCqNlleDMBlEbN98LzJBfbKFUkZO5TzcKqsQMEGY+ZdiNtn2JUY0i3zxmYGwBCPI3GqX0N6L7JlvW+56+rewjKyhZRoprmRQkj8BfxSy3YQi7D3MssSitO42VdzZIoSzaIbdZVPZVuQgFwqHzr0OMbgaqpEXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761012509; c=relaxed/simple;
	bh=lMDSCfXDFAAsG+lJ4/PlhyxArZIcaelWaaU9/c3MB38=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=VTG1Oi3WNWFux/ZGpjtkofHlKYABZ/MXRERWbVYVlJONFgHzOzlg1ky5dhShsOsnIfXptpFkvJbXJcC6mmrkN0v+vWfsLJpB4excbKJrhNvGOqtzKm3R6l5psioinmyvqyqaeTT5ifVOCvvq3fECCcxMfLsDh31C3ekAHnMcgX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gtX9FdGO; arc=none smtp.client-ip=209.85.166.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f175.google.com with SMTP id e9e14a558f8ab-430d7638d27so20987765ab.3
        for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 19:08:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761012505; x=1761617305; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SOPZINqJ1ZYn4I38TToVeVJycFqUKIHAHcONMbNzpkE=;
        b=gtX9FdGOS19dGYoNZoNHibe9hbAxWl9rAFyhotY/7l1eKeWZyyIc42LUzOmtNwef2J
         jGeQVmiHKjaboCdJGfmv12VM8sodRZvKLwWpMSTQiUpwHp7ICWK7+2Up06ummDt2+ppB
         rsjhhUYIgrLpeFxnV3bBGzYXnS+ZDUghFRsPhuhu9YewrwMuiwtN7v4DNuuAu0SJqkgw
         JYsigoxmJl5BumP+QiSwu4DPIPrZFk2T5OgL/2MvPPZCBp4O0elnQgXvSmMhAhPx1HSk
         kRsXEcyfq9rc44xdKjmgdBPFEMkyVlD3E9oNU/mBMg1adOmScNaGWzXlbnm8BHXhT2Cj
         4QkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761012505; x=1761617305;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SOPZINqJ1ZYn4I38TToVeVJycFqUKIHAHcONMbNzpkE=;
        b=d60jSD2CIWbhxVmhpjcHtCteQorstatye32KuiFVOyoqaQAhgqpFR7rbyXNc14XBRi
         8ffUFEt+4lNd+IhvUw6vyA5N+lwqphrtFHj5ekmTTyOm9MFld5MpNN8xC6TJRhFv+2Nk
         EhmG0UbGB4v4zERVrVZX25C03fN2m6ePtoaMiRuBl0F165Q77PUo5PRLXrjmCWr+EVzW
         /dyT+9uHkqVn2uvlDHxAqy/rwww8ywksfe90+qksMC88bOg3+/IA6O36i/CMfzqisvGm
         JJ/WZWNflqvWtFIMw44G4/ogp2gxo2eKl1zQzXLsJtVvYMO1SGQkAHzP5KTwOSLLiIlz
         pcCg==
X-Forwarded-Encrypted: i=1; AJvYcCXQbXhlphM3lgufiQK9tQiDV57tnXoe7ALat2cL5IG4YfP2i8DU/89BJh1kh5HFAI2Q0YiU4ikQtCWMCY0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4f3U2kmA6JL/p4eCRonh/XILe+xICG8uqzBjaimJEOteGvWmz
	gEoupdE4/cFpHEOnH8Yx78c9aa+mpyptgTSwrJ6fP20ic+430wH8pJ0E
X-Gm-Gg: ASbGncughsuC/fRMpwhzFsM2DdbPeuS2FsbCmdzRUG6Wr4ycnGJPPM3U2PubSDoztcl
	ETwWnPd3dc3nWocpKVX66CbfbrHS0pFbOF/OSa9iExMXBFfp0xyzeSR19RIX2XIH847U0ISsdbd
	x55AflDCQwkoCeyFJH67r+aZbgwpCcG1m+0TLGe8/sy9hAd3Q3AgKmUvTyYzUeFFEbOxYITfFGv
	KxbHL+G159DXa+onguUQFckHlk/+U+u1Xm/47xXhTCq60Efi/JaML4X8qMytXCq23BSS8lT8Rmx
	7i6JTlZm6fiSSPYg61NbS+LjiBntSBzQtXodvGfkW+ZxN680eXnnyD6HzhkZ0QPcucOOQc7u1x/
	Wc9KEU2INMCPQ3EAh+IiJ3h+S51OAsg//VY/MRHQM7fweRBmo3kBj58gAGEaSr2qfYszMh/lkQm
	dmf409kqbcodUsodkmsPOrAbhyKLSwHW3rqgaF//Fp8SAL7w7gSHCjYum4vwYfbCPykL8R80MhF
	1LC
X-Google-Smtp-Source: AGHT+IHxMaRrHMYn6K2NMgEXSDVxYWRsu+Ax0RcX2EKq6KdEsQ4xITeLkd7KXFChEkdLb65yRzCBzw==
X-Received: by 2002:a05:6e02:148a:b0:430:a013:b523 with SMTP id e9e14a558f8ab-430c52aa249mr247916055ab.25.1761012505291;
        Mon, 20 Oct 2025 19:08:25 -0700 (PDT)
Received: from abc-virtual-machine.localdomain (c-76-150-86-52.hsd1.il.comcast.net. [76.150.86.52])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-5a8a97699f4sm3556852173.51.2025.10.20.19.08.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Oct 2025 19:08:24 -0700 (PDT)
From: Yuhao Jiang <danisjiang@gmail.com>
To: James.Bottomley@HansenPartnership.com,
	martin.petersen@oracle.com
Cc: linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yuhao Jiang <danisjiang@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] scsi: wd33c93: fix buffer overflow in SCSI message-in handling
Date: Mon, 20 Oct 2025 21:08:04 -0500
Message-Id: <20251021020804.3248930-1-danisjiang@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A buffer overflow vulnerability exists in the wd33c93 SCSI driver's
message handling where missing bounds checking allows a malicious
SCSI device to overflow the incoming_msg[] buffer and corrupt kernel
memory.

The issue occurs because:
- incoming_msg[] is a fixed 8-byte buffer (line 235 in wd33c93.h)
- wd33c93_intr() writes to incoming_msg[incoming_ptr] without
  validating incoming_ptr is within bounds (line 935)
- For EXTENDED_MESSAGE, incoming_ptr increments based on the device-
  supplied length field (line 1085) with no maximum check
- The validation at line 1001 only checks if the message is complete,
  not if it exceeds buffer size

This allows an attacker controlling a SCSI device to craft an extended
message with length field 0xFF, causing the driver to write 256 bytes
into an 8-byte buffer. This can corrupt adjacent fields in the
WD33C93_hostdata structure including function pointers, potentially
leading to arbitrary code execution.

Add bounds checking in the MESSAGE_IN handler to ensure incoming_ptr
does not exceed buffer capacity before writing. Reject oversized
messages per SCSI protocol by sending MESSAGE_REJECT.

Reported-by: Yuhao Jiang <danisjiang@gmail.com>
Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Signed-off-by: Yuhao Jiang <danisjiang@gmail.com>
---
 drivers/scsi/wd33c93.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/scsi/wd33c93.c b/drivers/scsi/wd33c93.c
index dd1fef9226f2..2d50a0a01726 100644
--- a/drivers/scsi/wd33c93.c
+++ b/drivers/scsi/wd33c93.c
@@ -932,6 +932,19 @@ wd33c93_intr(struct Scsi_Host *instance)
 		sr = read_wd33c93(regs, WD_SCSI_STATUS);	/* clear interrupt */
 		udelay(7);
 
+		/* Prevent buffer overflow from malicious extended messages */
+		if (hostdata->incoming_ptr >= sizeof(hostdata->incoming_msg)) {
+			printk("wd33c93: Incoming message too long, rejecting\n");
+			hostdata->incoming_ptr = 0;
+			write_wd33c93_cmd(regs, WD_CMD_ASSERT_ATN);
+			hostdata->outgoing_msg[0] = MESSAGE_REJECT;
+			hostdata->outgoing_len = 1;
+			write_wd33c93_cmd(regs, WD_CMD_NEGATE_ACK);
+			hostdata->state = S_CONNECTED;
+			spin_unlock_irqrestore(&hostdata->lock, flags);
+			break;
+		}
+
 		hostdata->incoming_msg[hostdata->incoming_ptr] = msg;
 		if (hostdata->incoming_msg[0] == EXTENDED_MESSAGE)
 			msg = EXTENDED_MESSAGE;
-- 
2.34.1


