Return-Path: <linux-kernel+bounces-750485-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 81BDAB15C03
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 11:37:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C2B8818C24D6
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 09:37:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A134229551E;
	Wed, 30 Jul 2025 09:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AV0TAGBr"
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F276277CAF;
	Wed, 30 Jul 2025 09:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753868181; cv=none; b=e05oKIshzfzIjysMe2qDojdSwCsEfDO7IgHE1XrSGJ03r9hGoaCQ3pH7VM1TLLebHK6yYkE/CRpu7rYE/OxH7AuHvAT44foivoCnbV6lSK0UWn/SylruUvOtzrnBzZpanlttTsxmyLqV/33OzYsOFZxIZx3mpyDfdIgcABuX9ZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753868181; c=relaxed/simple;
	bh=c2GH0rNGWLSNkTpOjy4OMDbtOxD8avJx7PsDc1FiDT4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Y974Iz/HdQJO8sxhK1Sq2U3Lf32y3hOXJqLKuvYizEbVX+dTfn2OqAMJybCV+48gNhe7QJpuOUNtK4K8uXPZrO+wm6tdXsqplQxIUCEv2pfoza4qEIZWpMH/uyOvXQ25zwbA+N9VMUDGuh3nE5XeA1JSwOCCw44k9kB7eEKvsKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AV0TAGBr; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-75001b1bd76so4199858b3a.2;
        Wed, 30 Jul 2025 02:36:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753868177; x=1754472977; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ssDVlCsCS3jSCW7a4ghd6/R/IH3Ziy5fSjKUqHewJCs=;
        b=AV0TAGBru96dqdj/sFz9LwG4DaO508QfYRpQ5/hSe23f7dRRaM6wTmgF96jfsvc4Qj
         wxKW0EUcrXEIsjoCunlAISMTrNsKRQd7vRfLNU9Lq8XvoDXNOKm8GSazRC4cuzFqSilG
         5S2eA/Elhe3GiDVe5g339rfIqJ4Zp7+U6wLO65dp6hOK1WdCyWQY+9gVTEyulTSuGFJF
         93oLvo0422eF6J4psNrVYuzRVkbVTkfZ7fZnlL0nqSCFgXTGfDbq+bRHfNxNquKu2YYs
         HFG0oX/25/gWbQ/e+wZrIqB4/iCL5jS/GU5P0SudrZNbDUxrZ8JlMy7XCtc6X1M+CDGW
         WC0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753868177; x=1754472977;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ssDVlCsCS3jSCW7a4ghd6/R/IH3Ziy5fSjKUqHewJCs=;
        b=iqwfHSIbdEw4B2j8pl9dyUCqU5Wn+m+wb9rhsDsn2me3egFj8PVxsasOkHfbpjftFa
         NeSnmjz97DUn0f+hxs3qFmBfKtZ1XYgSF5V6rJnZSEanOnQSsCvOJ0llPphgSMGTBXwi
         qGsRVdFS2ZyGbjINkXZZIN7PuzZiu7zw2K//dSCVUvcEfXKuV2sC5kBXpUZ9xO5b49SD
         cgcEBcmmEynDg44K24IvcrzqP8W24527Qa5VbSuhyYAxlkl53RrI8mJ0IrQfNczSmQEV
         S+nvt53jyesaVsGFVla8fADQrv2DLv55qEmMX/QLhLTdpzgoyGoobNhSW+8TtfNOmrNx
         LS+g==
X-Forwarded-Encrypted: i=1; AJvYcCVhLYyviGwoMfJg9jioruHVgIdvDjnmRtiQEKQMTk/KdAFvTGZJpfbvYwIcS0V7VJU4rP5A3ZUldT3DEUY=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywi4Rx+fkJIKwW7ArCvDynT8f25+WEBlFD0rt/wTCfnIi8+Bvvs
	6n3jXUrybQ15ac+tpWp8lUwVKlmvDSJNVcM4YgWNLGqWqgVhBZZOmAst
X-Gm-Gg: ASbGncvWyjYx3rgkOaRqCA8mNhy+cKN9aQTyIIIbjllobxFX82c11Tpeih3QxX2Zext
	Wnb+o7yrOgL1NeOP/dq/ki6FYBwhH81zKAxNx/NpbtCrJ1aNJBiA2/3Vn3ZO2HPXERCs0xG9TQh
	TJ/CjiMaAv9pSK41fgM5z1UMI7EY6PngSn33zPUuArKZ5hAftfEMHMyDRPmfBRN0EFQfkSwiYYC
	KIz5jpQpkPrr5eVAvILO6CQDPXhumakyZE7dVF1RjEnA2wSoPUSeAm3LRP30WaH4d4qyHxceO6n
	GA8QNPd0FOVBJaOklc5OydM8pTVXQqOYgF8FyJX5RLItoFEuAf+kPQFQ4IUwur04rJ2uZ9UMhAX
	R5AGE5L/wNh2G1rXvOloufkh/kBejYw5Iho6hUZvPmFococCQx2Jfxc1ZLuP5OQYdTsxYFqyhYw
	==
X-Google-Smtp-Source: AGHT+IEkegB4qW3NBL1Htv2lZAEOtQ654FZ/2szFdy4KcwXFd0xODhnxhuJYgNKiowD1gC09+N2zrg==
X-Received: by 2002:a05:6a20:6a21:b0:220:90a9:a91b with SMTP id adf61e73a8af0-23dc0d321b7mr4050211637.9.1753868177439;
        Wed, 30 Jul 2025 02:36:17 -0700 (PDT)
Received: from SIQOL-WIN-0002-DARSHAN.localdomain ([49.36.70.111])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-240087fc42bsm75689305ad.153.2025.07.30.02.36.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Jul 2025 02:36:17 -0700 (PDT)
From: Darshan Rathod <darshanrathod475@gmail.com>
To: gregkh@linuxfoundation.org,
	m.grzeschik@pengutronix.de
Cc: linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Darshan Rathod <darshanrathod475@gmail.com>
Subject: [PATCH] usb: gadget: uvc: clean up code style for checkpatch compliance
Date: Wed, 30 Jul 2025 08:19:15 +0000
Message-ID: <20250730081915.12878-1-darshanrathod475@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch fixes a few coding style issues:
- Avoids assignments in if conditions
- Corrects parameter indentation and alignment
- Trims inconsistent spacing

All updates conform to kernel coding standards and improve maintainability.

Signed-off-by: Darshan Rathod <darshanrathod475@gmail.com>
---
 drivers/usb/gadget/function/uvc_video.c | 26 +++++++++++++------------
 1 file changed, 14 insertions(+), 12 deletions(-)

diff --git a/drivers/usb/gadget/function/uvc_video.c b/drivers/usb/gadget/function/uvc_video.c
index fb77b0b21790..fe176ba4ac6b 100644
--- a/drivers/usb/gadget/function/uvc_video.c
+++ b/drivers/usb/gadget/function/uvc_video.c
@@ -27,7 +27,7 @@
 
 static int
 uvc_video_encode_header(struct uvc_video *video, struct uvc_buffer *buf,
-		u8 *data, int len)
+			u8 *data, int len)
 {
 	struct uvc_device *uvc = container_of(video, struct uvc_device, video);
 	struct usb_composite_dev *cdev = uvc->func.config->cdev;
@@ -57,7 +57,7 @@ uvc_video_encode_header(struct uvc_video *video, struct uvc_buffer *buf,
 
 		data[1] |= UVC_STREAM_SCR;
 		put_unaligned_le32(stc, &data[pos]);
-		put_unaligned_le16(sof, &data[pos+4]);
+		put_unaligned_le16(sof, &data[pos + 4]);
 		pos += 6;
 	}
 
@@ -71,7 +71,7 @@ uvc_video_encode_header(struct uvc_video *video, struct uvc_buffer *buf,
 
 static int
 uvc_video_encode_data(struct uvc_video *video, struct uvc_buffer *buf,
-		u8 *data, int len)
+		      u8 *data, int len)
 {
 	struct uvc_video_queue *queue = &video->queue;
 	unsigned int nbytes;
@@ -89,7 +89,7 @@ uvc_video_encode_data(struct uvc_video *video, struct uvc_buffer *buf,
 
 static void
 uvc_video_encode_bulk(struct usb_request *req, struct uvc_video *video,
-		struct uvc_buffer *buf)
+		      struct uvc_buffer *buf)
 {
 	void *mem = req->buf;
 	struct uvc_request *ureq = req->context;
@@ -132,7 +132,7 @@ uvc_video_encode_bulk(struct usb_request *req, struct uvc_video *video,
 
 static void
 uvc_video_encode_isoc_sg(struct usb_request *req, struct uvc_video *video,
-		struct uvc_buffer *buf)
+			 struct uvc_buffer *buf)
 {
 	unsigned int pending = buf->bytesused - video->queue.buf_used;
 	struct uvc_request *ureq = req->context;
@@ -187,7 +187,7 @@ uvc_video_encode_isoc_sg(struct usb_request *req, struct uvc_video *video,
 	video->queue.buf_used += req->length - header_len;
 
 	if (buf->bytesused == video->queue.buf_used || !buf->sg ||
-			video->queue.flags & UVC_QUEUE_DROP_INCOMPLETE) {
+	    video->queue.flags & UVC_QUEUE_DROP_INCOMPLETE) {
 		video->queue.buf_used = 0;
 		buf->state = UVC_BUF_STATE_DONE;
 		buf->offset = 0;
@@ -199,7 +199,7 @@ uvc_video_encode_isoc_sg(struct usb_request *req, struct uvc_video *video,
 
 static void
 uvc_video_encode_isoc(struct usb_request *req, struct uvc_video *video,
-		struct uvc_buffer *buf)
+		      struct uvc_buffer *buf)
 {
 	void *mem = req->buf;
 	struct uvc_request *ureq = req->context;
@@ -218,7 +218,7 @@ uvc_video_encode_isoc(struct usb_request *req, struct uvc_video *video,
 	req->length = buf->req_payload_size - len;
 
 	if (buf->bytesused == video->queue.buf_used ||
-			video->queue.flags & UVC_QUEUE_DROP_INCOMPLETE) {
+	    video->queue.flags & UVC_QUEUE_DROP_INCOMPLETE) {
 		video->queue.buf_used = 0;
 		buf->state = UVC_BUF_STATE_DONE;
 		list_del(&buf->queue);
@@ -473,7 +473,6 @@ static void uvcg_video_hw_submit(struct kthread_work *work)
 			 * There is a new free request - wake up the pump.
 			 */
 			queue_work(video->async_wq, &video->pump);
-
 		}
 
 		spin_unlock_irqrestore(&video->req_lock, flags);
@@ -777,18 +776,21 @@ int uvcg_video_enable(struct uvc_video *video)
 	 */
 	video->is_enabled = true;
 
-	if ((ret = uvcg_queue_enable(&video->queue, 1)) < 0)
+	ret = uvcg_queue_enable(&video->queue, 1);
+	if (ret < 0)
 		return ret;
 
-	if ((ret = uvc_video_alloc_requests(video)) < 0)
+	ret = uvc_video_alloc_requests(video);
+	if (ret < 0)
 		return ret;
 
 	if (video->max_payload_size) {
 		video->encode = uvc_video_encode_bulk;
 		video->payload_size = 0;
-	} else
+	} else {
 		video->encode = video->queue.use_sg ?
 			uvc_video_encode_isoc_sg : uvc_video_encode_isoc;
+	}
 
 	video->req_int_count = 0;
 
-- 
2.43.0


