Return-Path: <linux-kernel+bounces-593322-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 95787A7F7EE
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Apr 2025 10:33:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1A8657A661C
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Apr 2025 08:32:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBD6D264611;
	Tue,  8 Apr 2025 08:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MS5Jnv/t"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7D60264624
	for <linux-kernel@vger.kernel.org>; Tue,  8 Apr 2025 08:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744101156; cv=none; b=AAUaKTD5Jdm5ttf7BkSzJoROc7WJyY5LX7To++ddagR9kZKSL2XfrWcHRynNVj0FDHj98UdRUPsccxk5mXuhiUDDjFFCPlz60sYmBUyzCxb3gsvfs42LdP5p0yUU/nNtLizgrHnnpH/NQ0E/8ztABJciRLhzpKGjMuOguu0sXSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744101156; c=relaxed/simple;
	bh=dUF2TBEutX2KGJiQNuMfxIqRjcPoQb9fYtWfjZ52S5A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F8QExOq+JSWII6mVKTWnRAiSS4E8Cr9p50e7PS614+dmiM35D2J+FcrrY5fF6DNYZx/Lfn0lCX/rUMr+HzRyX1revj90mo+fjYkAjiw0OafV8XUr/UbDHonrIlFdnACKeF79oka6vGOj2cJluEkVyHw2MT2bbOLwXhuaWIfM0vw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MS5Jnv/t; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744101153;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+UWgpwscQp73PyDMRD5EZKbcQGdo2l2UKgmDSHNPifY=;
	b=MS5Jnv/tvC2qH9QsF8wHAoyeYxPPj6MrI0UxHZt+hZMqX6cwVr1OB4iJZcCbAsolkUrpg8
	bQEK8Dm/McrHeGIv2hy/iseI9R+KTvk8u6PkJpPieA3uTx5IFauEGv7b3zKrDUvGh/kJ+G
	aSmBGL/TDFGjZrbqtgipBxcUOFFN9hY=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-689-juz7l6JANjq1PvnabMtnCA-1; Tue, 08 Apr 2025 04:32:32 -0400
X-MC-Unique: juz7l6JANjq1PvnabMtnCA-1
X-Mimecast-MFC-AGG-ID: juz7l6JANjq1PvnabMtnCA_1744101151
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-43ceb011ea5so35197395e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 08 Apr 2025 01:32:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744101151; x=1744705951;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+UWgpwscQp73PyDMRD5EZKbcQGdo2l2UKgmDSHNPifY=;
        b=ao569+C/qZhyzfTd5Usy77QWrpTfdvH91U1NEdkfyyLJGJLyH9XqdmKKxrArQhThg2
         EkamNbsZBb+Oq0N/yA7l852Ov+pKY+eWse2QOMlXYvSNcQWklypAaDjk9ubwpwf3rUVR
         3c9Il6HGmE55LBFLOVv5K4DXs0ZUtBiTWP22wt57HFCdBLH1thIyUJKxDEksigcSCLw7
         x3MO8DQb/2gomZ/5xM6IHj0q5RXXj18VA34nMGaPQi9D3aYggZggPPx+MafukXbDWDYD
         KeNSAPwMSFC+1jiZh1/A8/W00/2lTJ7WEki4vYMpqBlk0BZ6mckWSGehf8ma0L8+bPVM
         S0pg==
X-Forwarded-Encrypted: i=1; AJvYcCU5fK/cFw8MB/fpDg83HcwJZr49qH55zhfaVLAhFlM0aanz2Y76bhB3gWHxNrPIOAIAJiy4OeMDeLrhl2Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YwhTjXRQqfT9WqwOg2d+Z0IvYNKiRYyDCYQi8NeVOT/4ZVhw7EC
	kOvHgxuYC4BBu0a9M9Z3NsUc0BLRlSdA5Ppy2rTaSlEZqbkGabN9i2CINDO34pUc2uw+xPGi9oq
	S8zhwYj6Eh4TCDhN0E/DsSHKyXnaTszL2YdBtbTXFs6umdkT4e7C3GJKKF9Lymg==
X-Gm-Gg: ASbGnct6rYz56bUaF8EP/kGm3F0LW477JLSwzouHLtIfyecoC8+Y2GlnSYFUucBLu0I
	RTChjVTOQNjzvDI9bpUg9BTFD6IKkO3Pur5lP8Tpjx0/BrFq4kRscE3+57Y7yfw5tWX8m5VXqkG
	zGUHeqdG01kWNCu7DMQTlNRXSXi+rtv2p12MAkyB5s81+RJ3Zj1Se8UMWZlCj7N3gckKNExxIGj
	eGBX0Mizw5JwVLiTpbbn1iOX8DcoPMjSs8XLDMA/oB8fr10wXAoNEXPPlTgYfQDAQ9UY8rGwTL1
	EWzOwCH0iFG//dKecLihOdQJfcgCIxZpNelyXUA21IeTvtjPZMRHFlO9llF4xhjnUQ==
X-Received: by 2002:a05:600c:1384:b0:43c:fffc:7886 with SMTP id 5b1f17b1804b1-43ecf85f216mr158235555e9.8.1744101151420;
        Tue, 08 Apr 2025 01:32:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHz2ZKXaEi+HUCetPqQ0pAcpS8InkZmoD9d7JUgJGma+dknJFHnGD8z9oUR2s/51/65NGDLdw==
X-Received: by 2002:a05:600c:1384:b0:43c:fffc:7886 with SMTP id 5b1f17b1804b1-43ecf85f216mr158235025e9.8.1744101150843;
        Tue, 08 Apr 2025 01:32:30 -0700 (PDT)
Received: from stex1.redhat.com (host-79-53-30-213.retail.telecomitalia.it. [79.53.30.213])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43ec17b1352sm154886505e9.37.2025.04.08.01.32.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Apr 2025 01:32:30 -0700 (PDT)
From: Stefano Garzarella <sgarzare@redhat.com>
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	linux-kernel@vger.kernel.org,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	linux-arm-kernel@lists.infradead.org,
	Jens Wiklander <jens.wiklander@linaro.org>,
	linuxppc-dev@lists.ozlabs.org,
	Michael Ellerman <mpe@ellerman.id.au>,
	Sumit Garg <sumit.garg@kernel.org>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	linux-integrity@vger.kernel.org,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Naveen N Rao <naveen@kernel.org>,
	Nicholas Piggin <npiggin@gmail.com>,
	Peter Huewe <peterhuewe@gmx.de>,
	James Bottomley <James.Bottomley@HansenPartnership.com>,
	Stefano Garzarella <sgarzare@redhat.com>
Subject: [PATCH v2 4/4] tpm/tpm_svsm: support TPM_CHIP_FLAG_SYNC
Date: Tue,  8 Apr 2025 10:32:08 +0200
Message-ID: <20250408083208.43512-5-sgarzare@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250408083208.43512-1-sgarzare@redhat.com>
References: <20250408083208.43512-1-sgarzare@redhat.com>
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
don't need to implement recv() op.

Keep using the same pre-allocated buffer to avoid having to allocate
it for each command. We need the buffer to have the header required by
the SVSM protocol and the command contiguous in memory.

Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
 drivers/char/tpm/tpm_svsm.c | 27 +++++++++++----------------
 1 file changed, 11 insertions(+), 16 deletions(-)

diff --git a/drivers/char/tpm/tpm_svsm.c b/drivers/char/tpm/tpm_svsm.c
index b8aa7eb567de..547d4c4f7a53 100644
--- a/drivers/char/tpm/tpm_svsm.c
+++ b/drivers/char/tpm/tpm_svsm.c
@@ -25,38 +25,32 @@ struct tpm_svsm_priv {
 	void *buffer;
 };
 
-static int tpm_svsm_send(struct tpm_chip *chip, u8 *buf, size_t len,
+static int tpm_svsm_send(struct tpm_chip *chip, u8 *buf, size_t cmd_len,
 			 size_t buf_size)
 {
 	struct tpm_svsm_priv *priv = dev_get_drvdata(&chip->dev);
 	int ret;
 
-	ret = svsm_vtpm_cmd_request_fill(priv->buffer, 0, buf, len);
+	ret = svsm_vtpm_cmd_request_fill(priv->buffer, 0, buf, cmd_len);
 	if (ret)
 		return ret;
 
 	/*
 	 * The SVSM call uses the same buffer for the command and for the
-	 * response, so after this call, the buffer will contain the response
-	 * that can be used by .recv() op.
+	 * response, so after this call, the buffer will contain the response.
+	 *
+	 * Note: we have to use an internal buffer because the device in SVSM
+	 * expects the svsm_vtpm header + data to be physically contiguous.
 	 */
-	return snp_svsm_vtpm_send_command(priv->buffer);
-}
-
-static int tpm_svsm_recv(struct tpm_chip *chip, u8 *buf, size_t len)
-{
-	struct tpm_svsm_priv *priv = dev_get_drvdata(&chip->dev);
+	ret = snp_svsm_vtpm_send_command(priv->buffer);
+	if (ret)
+		return ret;
 
-	/*
-	 * The internal buffer contains the response after we send the command
-	 * to SVSM.
-	 */
-	return svsm_vtpm_cmd_response_parse(priv->buffer, buf, len);
+	return svsm_vtpm_cmd_response_parse(priv->buffer, buf, buf_size);
 }
 
 static struct tpm_class_ops tpm_chip_ops = {
 	.flags = TPM_OPS_AUTO_STARTUP,
-	.recv = tpm_svsm_recv,
 	.send = tpm_svsm_send,
 };
 
@@ -88,6 +82,7 @@ static int __init tpm_svsm_probe(struct platform_device *pdev)
 
 	dev_set_drvdata(&chip->dev, priv);
 
+	chip->flags |= TPM_CHIP_FLAG_SYNC;
 	err = tpm2_probe(chip);
 	if (err)
 		return err;
-- 
2.49.0


