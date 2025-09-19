Return-Path: <linux-kernel+bounces-825165-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 053CBB8B26E
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 21:57:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C359B16C015
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 19:56:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DBC2322A03;
	Fri, 19 Sep 2025 19:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CNIwux1S"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B00C12BD5A1
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 19:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758311774; cv=none; b=qBW2gP8y6yIjnaA/MKzj2hgpie2csyvHAjFm+T2gbqU7qa3VLrL7+dFQIPN6gIiebHGCrvQW5w1rT+0TeSr6C9zBbPn0e7UWpx+AxU1BIbvWvS7TZ9sm8l2sVn4gS2qRF0xmJd4Xy5f59BwKmolxuLn6sfXTrwohVh4ykwhcFrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758311774; c=relaxed/simple;
	bh=sZ87DphZldS+3n0LQT7BxNMEf1yIgvPiSz7rdnDAa0M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZtqlsTaw6CFbfdGDrupoL7TcTfP5BvATNIyAToemMYXzSu4vrND191kSmv9P0gBEk0gZgOr3Eqrp72pJKLz7FwQwJFigjNppOezo5o5LgBJjed5TdPuv7MFZ1umey/Xu6f6mYtumTzvvryTJgQ8R8uMvVN5VNc7i707gOPfzleo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CNIwux1S; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-45f29e5e89bso28237885e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 12:56:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758311771; x=1758916571; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AQweL7ildnxUZkvX5C1ntDuxX4C6kDLFi7r7zPykbLE=;
        b=CNIwux1SEipsC2IGdzp/b/kVUt42WYGDjqGZL0kgN7237Dus1fPoCwiUb+6IcSpaAp
         F3B7X67nOLtQFUl+D7YSkGEQRXCEyx8/La1NlW3PrjML6UUcfiRn8e0o+/fIDpxmoJQR
         YgyFEPFhe5N+r+OE/KChu/r9zvcaiRuZasc4Rz0Au/t57/g2ptSgWtdhuRULsQFOv+Vs
         2ZvF+Ico0C7BJBG/nzMZltAIhIsmgrUiOerheAhYEA6DOB7DDOfI4eo5zpGpzmHtqipF
         Lii/jzXRoM7st+2hqzVig7OdHomfplq15TZzAeYwuhnQYbCeBwS2DoOr44uHe59wgFu3
         XpoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758311771; x=1758916571;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AQweL7ildnxUZkvX5C1ntDuxX4C6kDLFi7r7zPykbLE=;
        b=DRiY7/eQhdmVyzKtFMRJk9ycr+TuJL0qgPVr8d4b3ompINeu4jBLMPcw+bXtO8fJU6
         DiA3f4lBED/wm8MRF2zLLn1ypn2044mlozZmsjZ9zeyMoaGFfUBpRY7fJXudsJ0OiujU
         pOv/7JhiDW+5bLAk+f9e9BxEnGQzwtvY0mV2XIGcZZadRxlBpSHhbChUwoS/36Fw1Evn
         EQQJjLgtiOoDwcglFrWe6U4Ud5ajIuUd37EmhwS+Unkg2il0BkG8U0jyvG0xGQniQd1N
         gu41RSaB29j8l++Ff5uaYNiEsXn/dvIUHk92Ijk/nTc52XNeOIbG1I6cF5Wf5KLrKkRW
         3z1g==
X-Forwarded-Encrypted: i=1; AJvYcCVcGmaDKcC3UkLeEQL4X5PY6KNlBd3Hf0gXdVghru3IiQmzmdxiU3lOt3fwFmdfhvSy3TvFG2KkbukOQtg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz42Q+UuXAzSSNNWc4vNIt9TXQrCNzuzCSLc1w83wJnoArTD1lQ
	rwqSRWdaCnKtvyDZQtX8rgBsEJZCKTIyge/AOOEA/G0PhRzJG9kZQOYQ
X-Gm-Gg: ASbGncupVgvLYF5I9kwf1GLstdrRL1LnlYA+QpUWeUJXG8DYxBO1s4C8Clo2+n4YeAl
	3JvguEHBT3+OyfHb3nJb4PkR4wX/8eHf6LxuMMdf1Kc3fdR43KXhpexTO5zKuPHjI1bHI/5+Xk0
	Vp/kLl5/nZckNQ1n4lIxcwWvW0FHRE44KsNRcyVInRnjMNbX+8dha1090F6sp80y3c6sLLb13q4
	1dqgBEG0Y13VIdkSUb5qVfNddPDm4JoNN+nTW7xJ/d9YrqTEvdaXLMR2UnnBRNsWJTr23WUD7zY
	Kt4tzAAI8GwywanFYn0ZoMp/5IWbn5XsbMHk4tJA8N/3Rvf2Io1H8yzOMdqR7eFHjyfa24RGy0H
	nI2+aMa19Ta3Kymf/RL6uX8EzVgVVUFGVKVCQCiOP1Qzf
X-Google-Smtp-Source: AGHT+IGTo85Vi1p8AU08ZWHlqAuVlC+41VDkpAZXn+ZCIc5qtVePYQMGMPM1EWc+q66fPqPc+PJyYg==
X-Received: by 2002:a05:600c:c162:b0:45d:e326:96d7 with SMTP id 5b1f17b1804b1-467e77d53f3mr38636125e9.13.1758311770762;
        Fri, 19 Sep 2025 12:56:10 -0700 (PDT)
Received: from ws-linux01 ([2a02:2f0e:c207:b600:978:f6fa:583e:b091])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-464f162726bsm97025485e9.7.2025.09.19.12.56.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Sep 2025 12:56:10 -0700 (PDT)
From: Ovidiu Panait <ovidiu.panait.oss@gmail.com>
To: gregkh@linuxfoundation.org,
	linux-kernel@vger.kernel.org,
	linux-staging@lists.linux.dev
Cc: Ovidiu Panait <ovidiu.panait.oss@gmail.com>
Subject: [PATCH 3/6] staging: axis-fifo: remove unneeded irq field from struct axis_fifo
Date: Fri, 19 Sep 2025 22:53:57 +0300
Message-ID: <20250919195400.3180039-3-ovidiu.panait.oss@gmail.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250919195400.3180039-1-ovidiu.panait.oss@gmail.com>
References: <20250919195400.3180039-1-ovidiu.panait.oss@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The irq number returned by platform_get_irq() is stored in struct axis_fifo
during probe but it is never used afterwards. Drop the redundant irq field
and use a local variable instead.

Signed-off-by: Ovidiu Panait <ovidiu.panait.oss@gmail.com>
---
 drivers/staging/axis-fifo/axis-fifo.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/staging/axis-fifo/axis-fifo.c b/drivers/staging/axis-fifo/axis-fifo.c
index 33a8440858d9..c500cb0555b7 100644
--- a/drivers/staging/axis-fifo/axis-fifo.c
+++ b/drivers/staging/axis-fifo/axis-fifo.c
@@ -118,7 +118,6 @@ MODULE_PARM_DESC(write_timeout, "ms to wait before blocking write() timing out;
 
 struct axis_fifo {
 	int id;
-	int irq; /* interrupt */
 	void __iomem *base_addr; /* kernel space memory */
 
 	unsigned int rx_fifo_depth; /* max words in the receive fifo */
@@ -587,6 +586,7 @@ static int axis_fifo_probe(struct platform_device *pdev)
 	struct axis_fifo *fifo = NULL;
 	char *device_name;
 	int rc = 0; /* error return value */
+	int irq;
 
 	/* ----------------------------
 	 *     init wrapper device
@@ -640,17 +640,16 @@ static int axis_fifo_probe(struct platform_device *pdev)
 	 */
 
 	/* get IRQ resource */
-	rc = platform_get_irq(pdev, 0);
-	if (rc < 0)
-		return rc;
+	irq = platform_get_irq(pdev, 0);
+	if (irq < 0)
+		return irq;
 
 	/* request IRQ */
-	fifo->irq = rc;
-	rc = devm_request_irq(fifo->dt_device, fifo->irq, &axis_fifo_irq, 0,
+	rc = devm_request_irq(fifo->dt_device, irq, &axis_fifo_irq, 0,
 			      DRIVER_NAME, fifo);
 	if (rc) {
 		dev_err(fifo->dt_device, "couldn't allocate interrupt %i\n",
-			fifo->irq);
+			irq);
 		return rc;
 	}
 
-- 
2.50.0


