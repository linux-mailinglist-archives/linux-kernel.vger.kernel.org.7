Return-Path: <linux-kernel+bounces-603351-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 12D2CA88607
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Apr 2025 16:58:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 036327A2889
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Apr 2025 14:57:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3036B2749FB;
	Mon, 14 Apr 2025 14:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q0fogwiy"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F8BF2749D7
	for <linux-kernel@vger.kernel.org>; Mon, 14 Apr 2025 14:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744642653; cv=none; b=P404m/p6nApKzhBhGcQCzIZ3gobksamrScp3mFLgWaJ2/2qkbR0sbyvWQaQwqqQ0nF/iFYkRepTyo7wkfg6Y3CWvKp49TVgb6s6BhvjYwbOwVuc+/SYqq0qTBUHO4TRKHNe3uDx2TEWY5qUTXS672VUBDeBeaNu+Y/H53zwiyAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744642653; c=relaxed/simple;
	bh=yLXeVtssmPoVnRDUsg/jEOLxV2If2elooLpqCpX8IfQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CO7Itx34mdkSq0Q1/6Ktp3fOt0jBV/T8ZXgGc3QceVHOch/SjYT2TJpfR6b5JZrM9+AbNDhkzbPLWDgIi5hFa8z1CMQrNtycqaubKVoYTE8L7nhEMQkNvnjiPTUy0kfI9coIfy+/K0Fkt+bjQKKlAVqNetcSSoblwR7T8efL0rM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Q0fogwiy; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744642650;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TEdsN0QQfHEZyuRksboskfejhwkQQL9RrSRK2ZgyfhY=;
	b=Q0fogwiylEOVQya4t6+GueMZswIe3WiwMeVZwKWaDyR2QbRBA01pz/3VPKZEE2a+9oGfPp
	Thd4NzK8+KUuLtLlXetUs3AU259VlFbG1z9yZyBGhDpJG4MoCwyN5iG6CuMBK23y15S6fu
	tY1nYucO+lRTwSdoSD0Af4tOTXh0UyI=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-562-pquG7t_NNtiDgFPCv2fSAA-1; Mon, 14 Apr 2025 10:57:28 -0400
X-MC-Unique: pquG7t_NNtiDgFPCv2fSAA-1
X-Mimecast-MFC-AGG-ID: pquG7t_NNtiDgFPCv2fSAA_1744642647
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3912d9848a7so2692814f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 14 Apr 2025 07:57:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744642647; x=1745247447;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TEdsN0QQfHEZyuRksboskfejhwkQQL9RrSRK2ZgyfhY=;
        b=XSeN0p+ESX9knY3FXAWDaimGWk+JkIotS9HBny7zJov0IHj3/Og3mw8nMuDX+b5SU1
         6YGgs1WCdVE9meGmetQVvZrz9TgmhUWBP2PSvXTyZqqPZVEYa5TA3//JX2+ECa0sjikA
         zXXiJ4gjONBST5FjrqGtfnhfLREJgnGJXBzjp1joPfZk1ugbI0CsXi87Q/9mfatTM31Z
         YAO8ap+nAZ1CwPFcTYsrS82G0cSh+H0lP+ZkV7VGlHdPLNvLGTi7U3brSAVlc6jdMd+B
         fepaA5QYlIpk6rz+RTT1vusGERBrtrE1f/NCWGnVtHewkfIrlH5YcCh4Tpe67FM0WrNR
         8O0w==
X-Forwarded-Encrypted: i=1; AJvYcCXMPH9d8frTeFPS4UpTsvvkIgrw6hq/mmcqpJ19AnBsHMvoIqg7d6YmcQ3P5a3MdLoxiLVyr3fzyut70iY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyX2AGC3r7Jh+eAGAyHsbcev34fST+Z2R766AglaV9netTYS7+R
	Xpg/vJNYlvXJkyjkuJhgzVfkF7IWpid6dw5cJWH/EaQ9gyie0haiCp1p3/rK+cmcnGNNVa0zP8l
	9QoHt2/R/NJo2oLW4iz8eiOePu7vJVmnVwO41URcgUdcVgGouvSzzuE6qAyTjhw==
X-Gm-Gg: ASbGncvuxIsqGndWItbOKR56wvU1paQ7s0e8waYMfqweXVL/tqIxqCFOR6Qmqc9f3JP
	ISIYOEX6G8vTiQ7W5tiglA+gcaS/5Zlk2FlabDlnmXpmhXu3hTXBNASJQ+5nMLz+otxaB4weS0Y
	+3LBxXnyhTBrYvWiVd5kHgIDfrhfWiVMaHaxtX28m6hamlbHhY3UgIIjJUADoV23Y+JVFrW8mER
	/uh+2jvvGNQ9612CMfbfKzCB3lBTLnUV3JIPPtbvsQqmlnV1w6WVV4UpM/w3zi7lN0RxGVOftkQ
	Ha8N3Qe5FT4bUlwZ3n1fNtEs
X-Received: by 2002:a05:600c:3c84:b0:439:91c7:895a with SMTP id 5b1f17b1804b1-43f2ea651bcmr156784575e9.7.1744642647218;
        Mon, 14 Apr 2025 07:57:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEApvHF30zJot3Tdd63G9ANE7NhVcm3CdypTeNAQ4xjY84TRnswJTqy6gQmM2qCnJiia7ICYg==
X-Received: by 2002:a05:600c:3c84:b0:439:91c7:895a with SMTP id 5b1f17b1804b1-43f2ea651bcmr156784335e9.7.1744642646611;
        Mon, 14 Apr 2025 07:57:26 -0700 (PDT)
Received: from localhost.localdomain ([193.207.151.40])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39eae9797aasm11333393f8f.56.2025.04.14.07.57.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Apr 2025 07:57:24 -0700 (PDT)
From: Stefano Garzarella <sgarzare@redhat.com>
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>,
	Peter Huewe <peterhuewe@gmx.de>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Jens Wiklander <jens.wiklander@linaro.org>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Naveen N Rao <naveen@kernel.org>,
	Nicholas Piggin <npiggin@gmail.com>,
	linuxppc-dev@lists.ozlabs.org,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	James Bottomley <James.Bottomley@HansenPartnership.com>,
	linux-integrity@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Sumit Garg <sumit.garg@kernel.org>,
	linux-kernel@vger.kernel.org,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Stefano Garzarella <sgarzare@redhat.com>
Subject: [PATCH v3 3/4] tpm/tpm_ftpm_tee: support TPM_CHIP_FLAG_SYNC
Date: Mon, 14 Apr 2025 16:56:52 +0200
Message-ID: <20250414145653.239081-4-sgarzare@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250414145653.239081-1-sgarzare@redhat.com>
References: <20250414145653.239081-1-sgarzare@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Stefano Garzarella <sgarzare@redhat.com>

This driver does not support interrupts, and receiving the response is
synchronous with sending the command.

So we can set TPM_CHIP_FLAG_SYNC to support synchronous send() and
return responses in the same buffer used for commands. This way we
don't need the 4KB internal buffer used to cache the response before
.send() and .recv(). Also we don't need to implement recv() op.

Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
v2:
- set TPM_CHIP_FLAG_SYNC and support it in the new send()
- removed Jens' T-b
v1:
- added Jens' T-b
---
 drivers/char/tpm/tpm_ftpm_tee.h |  4 ---
 drivers/char/tpm/tpm_ftpm_tee.c | 64 ++++++++++-----------------------
 2 files changed, 19 insertions(+), 49 deletions(-)

diff --git a/drivers/char/tpm/tpm_ftpm_tee.h b/drivers/char/tpm/tpm_ftpm_tee.h
index e39903b7ea07..8d5c3f0d2879 100644
--- a/drivers/char/tpm/tpm_ftpm_tee.h
+++ b/drivers/char/tpm/tpm_ftpm_tee.h
@@ -22,16 +22,12 @@
  * struct ftpm_tee_private - fTPM's private data
  * @chip:     struct tpm_chip instance registered with tpm framework.
  * @session:  fTPM TA session identifier.
- * @resp_len: cached response buffer length.
- * @resp_buf: cached response buffer.
  * @ctx:      TEE context handler.
  * @shm:      Memory pool shared with fTPM TA in TEE.
  */
 struct ftpm_tee_private {
 	struct tpm_chip *chip;
 	u32 session;
-	size_t resp_len;
-	u8 resp_buf[MAX_RESPONSE_SIZE];
 	struct tee_context *ctx;
 	struct tee_shm *shm;
 };
diff --git a/drivers/char/tpm/tpm_ftpm_tee.c b/drivers/char/tpm/tpm_ftpm_tee.c
index 637cc8b6599e..b9adc040ca6d 100644
--- a/drivers/char/tpm/tpm_ftpm_tee.c
+++ b/drivers/char/tpm/tpm_ftpm_tee.c
@@ -31,46 +31,18 @@ static const uuid_t ftpm_ta_uuid =
 		  0x82, 0xCB, 0x34, 0x3F, 0xB7, 0xF3, 0x78, 0x96);
 
 /**
- * ftpm_tee_tpm_op_recv() - retrieve fTPM response.
- * @chip:	the tpm_chip description as specified in driver/char/tpm/tpm.h.
- * @buf:	the buffer to store data.
- * @count:	the number of bytes to read.
- *
- * Return:
- *	In case of success the number of bytes received.
- *	On failure, -errno.
- */
-static int ftpm_tee_tpm_op_recv(struct tpm_chip *chip, u8 *buf, size_t count)
-{
-	struct ftpm_tee_private *pvt_data = dev_get_drvdata(chip->dev.parent);
-	size_t len;
-
-	len = pvt_data->resp_len;
-	if (count < len) {
-		dev_err(&chip->dev,
-			"%s: Invalid size in recv: count=%zd, resp_len=%zd\n",
-			__func__, count, len);
-		return -EIO;
-	}
-
-	memcpy(buf, pvt_data->resp_buf, len);
-	pvt_data->resp_len = 0;
-
-	return len;
-}
-
-/**
- * ftpm_tee_tpm_op_send() - send TPM commands through the TEE shared memory.
+ * ftpm_tee_tpm_op_send() - send TPM commands through the TEE shared memory
+ * and retrieve the response.
  * @chip:	the tpm_chip description as specified in driver/char/tpm/tpm.h
- * @buf:	the buffer to send.
- * @len:	the number of bytes to send.
+ * @buf:	the buffer to send and to store the response.
+ * @cmd_len:	the number of bytes to send.
  * @buf_size:	the size of the buffer.
  *
  * Return:
- *	In case of success, returns 0.
+ *	In case of success, returns the number of bytes received.
  *	On failure, -errno
  */
-static int ftpm_tee_tpm_op_send(struct tpm_chip *chip, u8 *buf, size_t len,
+static int ftpm_tee_tpm_op_send(struct tpm_chip *chip, u8 *buf, size_t cmd_len,
 				size_t buf_size)
 {
 	struct ftpm_tee_private *pvt_data = dev_get_drvdata(chip->dev.parent);
@@ -82,16 +54,15 @@ static int ftpm_tee_tpm_op_send(struct tpm_chip *chip, u8 *buf, size_t len,
 	struct tee_param command_params[4];
 	struct tee_shm *shm = pvt_data->shm;
 
-	if (len > MAX_COMMAND_SIZE) {
+	if (cmd_len > MAX_COMMAND_SIZE) {
 		dev_err(&chip->dev,
 			"%s: len=%zd exceeds MAX_COMMAND_SIZE supported by fTPM TA\n",
-			__func__, len);
+			__func__, cmd_len);
 		return -EIO;
 	}
 
 	memset(&transceive_args, 0, sizeof(transceive_args));
 	memset(command_params, 0, sizeof(command_params));
-	pvt_data->resp_len = 0;
 
 	/* Invoke FTPM_OPTEE_TA_SUBMIT_COMMAND function of fTPM TA */
 	transceive_args = (struct tee_ioctl_invoke_arg) {
@@ -105,7 +76,7 @@ static int ftpm_tee_tpm_op_send(struct tpm_chip *chip, u8 *buf, size_t len,
 		.attr = TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_INPUT,
 		.u.memref = {
 			.shm = shm,
-			.size = len,
+			.size = cmd_len,
 			.shm_offs = 0,
 		},
 	};
@@ -117,7 +88,7 @@ static int ftpm_tee_tpm_op_send(struct tpm_chip *chip, u8 *buf, size_t len,
 		return PTR_ERR(temp_buf);
 	}
 	memset(temp_buf, 0, (MAX_COMMAND_SIZE + MAX_RESPONSE_SIZE));
-	memcpy(temp_buf, buf, len);
+	memcpy(temp_buf, buf, cmd_len);
 
 	command_params[1] = (struct tee_param) {
 		.attr = TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_INOUT,
@@ -158,17 +129,20 @@ static int ftpm_tee_tpm_op_send(struct tpm_chip *chip, u8 *buf, size_t len,
 			__func__, resp_len);
 		return -EIO;
 	}
+	if (resp_len > buf_size) {
+		dev_err(&chip->dev,
+			"%s: resp_len=%zd exceeds buf_size=%zd\n",
+			__func__, resp_len, buf_size);
+		return -EIO;
+	}
 
-	/* sanity checks look good, cache the response */
-	memcpy(pvt_data->resp_buf, temp_buf, resp_len);
-	pvt_data->resp_len = resp_len;
+	memcpy(buf, temp_buf, resp_len);
 
-	return 0;
+	return resp_len;
 }
 
 static const struct tpm_class_ops ftpm_tee_tpm_ops = {
 	.flags = TPM_OPS_AUTO_STARTUP,
-	.recv = ftpm_tee_tpm_op_recv,
 	.send = ftpm_tee_tpm_op_send,
 };
 
@@ -253,7 +227,7 @@ static int ftpm_tee_probe(struct device *dev)
 	}
 
 	pvt_data->chip = chip;
-	pvt_data->chip->flags |= TPM_CHIP_FLAG_TPM2;
+	pvt_data->chip->flags |= TPM_CHIP_FLAG_TPM2 | TPM_CHIP_FLAG_SYNC;
 
 	/* Create a character device for the fTPM */
 	rc = tpm_chip_register(pvt_data->chip);
-- 
2.49.0


