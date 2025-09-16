Return-Path: <linux-kernel+bounces-819596-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B3BFB5A386
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 23:04:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9086A3A709C
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 21:04:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9266029ACD8;
	Tue, 16 Sep 2025 21:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="nfTGOknD"
Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2F7E283FEE
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 21:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758056635; cv=none; b=jzgmdD2SFU4kIpy9nb1zaiKVzMlq6hgfjpDMLusheNn2I3ALcvR9lPb+5QnX0OHABE6972g24FmCT7QCZaEgtWPNngpqMh0Lw4ZK+gnrgRfenLp4HGodKpJfUbBFRm2eronQrdsX8pMuh0JcAVcqdTi68aeGVvYY+QQyiXAywTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758056635; c=relaxed/simple;
	bh=pvW5zRcWfeyVBSqoz2YuVw11X5u2Bz4r/sM+Ny8NzaE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qNX/40rNGWUqgWLx/a4jBOp42v+WiR6MANm1LDWVup4grObkPL2ySrbRUVkZdBdk5wSVStwpZrFaCEVTGspKFACh13DsMKapBG1vrVxOazbXzoUv4BjtHkFZbdVuHcwvMMOnSkHyRWobsrtINTkdeWYJa/Fqo0sm/t3XQDBkZ/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=nfTGOknD; arc=none smtp.client-ip=209.85.161.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-62344b7b69cso991086eaf.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 14:03:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1758056633; x=1758661433; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HL2e/WuXZjgQ+ibL3M/EC4K8mQrgrMrBA77dFAoob1U=;
        b=nfTGOknD6Z2H8hWDN4zHeKrjz/FbQNgLUfkvadFoRljurYf5LY+Bb67ugx2GL1YUrg
         60zBr+vfSqI+3tLeSL1Xt33njNMrSRtPAO9tT7g5gG9GpjKDkW/aj+/JOfippCKuXehl
         MHW/xtnNAUfhTO9TMHfEbMiadaYMCc3KvDEK6Hhrjf2Qo6DCCjOzreNrYgodvWdBKt/l
         9tBWYDn8j3L2qrdfYNBZVVaNjx0vpmaTNCVUDBsxQf4+dIZaxCIRM0GmKifXdVF4q3/P
         fAZOy9yXnClALn67bC+mJo/reDjl5GPs21pKYMhnXZAGAHxlyYuZ5UBRZ2cjmF7v2bKK
         BJxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758056633; x=1758661433;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HL2e/WuXZjgQ+ibL3M/EC4K8mQrgrMrBA77dFAoob1U=;
        b=e3wzpgZ0LjU/D9gw1qsidqertxLEDR7BEYcUqc1uNW+wn04sGdJQPMdfELtXlfBTfF
         k4O2QnkPUszeCZ7e2klyrMCmdjThzHI4vM7GcIEh0HZLslqp+6DjVF3ANq8ozQXTZz3Z
         2uyUWApe3PVjvohfd+wNJfAE786KH511qbZTBQuVV/v0ap6enuBLrhpkDGNParnNMr07
         eKV+nc7tSOGc7bSjEy/qnYHZKCcvkLYKsPDx2UxsKXFYamPg7bZfGzaRdh0D6rZei7QK
         titjUG5upbZo4iKf3MvNEf00DohKKbL2JfACRbJaRTriJbadiI3JgBwysFvZ6yFWcnDn
         fbyQ==
X-Forwarded-Encrypted: i=1; AJvYcCUEVcILabMWI69egz/W0cP1Vp3dPusfzXAE2KWbahnhvJK2+qJBbb5D9yU+5/+VNi9dX3IZnpgCW7zeZ5s=@vger.kernel.org
X-Gm-Message-State: AOJu0YytHPES8xtzDtPIe0qEj2yY894y134t0HF/9Ob/n8F0KxvcusUw
	g14ridQA5x9Ds8AUsUNN8Vr5l5kNwOLpgX5lc7EicUdi/0B4rWEA50fIpzVhZsDv0rk=
X-Gm-Gg: ASbGncvTP+fjABrHhYKOEp8BASRTD56TaAN4UDIBifmhmZPkR/OBFfWqAZk6n6sw9cQ
	4G295v0enc5/cR4qjj6INVEBTXL692vWzsipTXovn9YDsbuLilW69jBO+ODUh4WkFr6gE7H0n7p
	btFoPdBnN8TGsSF48c8tHL2psYNu80q7jhG9fo5q0Vs2bXvXpogxtmaov/Ehlert1dHIXDu1Qc5
	wy1mQTSBUb6bW2CQ4gP3NgcAU3GzaqT2nWj3Of9lbuX0iF0Meod8xDIyxwBnsb/svOK4ZjcMu56
	1GeeN36BXb4GwAopzm3KB7pyQbOYMHxXUaS0bUQ+Rse5K9j52YKVHOCycdaPWA19cgpxXhhoaYw
	OpUQ6LJG3ejxGuQwyj/zDvtqOXLRc
X-Google-Smtp-Source: AGHT+IFCkDG2Wd7hYTlZ9YHQ7MptC+whdynNDap9Jf70c5msRHifOUMwG7G/fxQ283A5VlxFfDvFTw==
X-Received: by 2002:a05:6808:4f4b:b0:43d:2454:b694 with SMTP id 5614622812f47-43d2454ba43mr5452806b6e.2.1758056632935;
        Tue, 16 Sep 2025 14:03:52 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:1d00:70a1:e065:6248:ef8b])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-43b8294ac06sm3540044b6e.14.2025.09.16.14.03.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 14:03:51 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Tue, 16 Sep 2025 16:02:51 -0500
Subject: [PATCH v2 1/7] iio: buffer: document
 iio_push_to_buffers_with_ts_unaligned() may sleep
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250916-iio-doc-push-to-buffers-context-v2-1-8b17937a6cc7@baylibre.com>
References: <20250916-iio-doc-push-to-buffers-context-v2-0-8b17937a6cc7@baylibre.com>
In-Reply-To: <20250916-iio-doc-push-to-buffers-context-v2-0-8b17937a6cc7@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Daniel Lezcano <daniel.lezcano@linaro.org>, 
 Andy Shevchenko <andy.shevchenko@gmail.com>, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1165; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=pvW5zRcWfeyVBSqoz2YuVw11X5u2Bz4r/sM+Ny8NzaE=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBoydCGz0nb3t98zgUS4Vy0mVSAHDq4Di0yBzGlx
 Ad7/z0vBWOJATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaMnQhgAKCRDCzCAB/wGP
 wDvRB/9K8/CMqZk+CvwWOwTNLvv+TYQg7ZAkUbXyhvoRnbq1pRVxfx40S1ft1ETBBhsuwkOPuEo
 TQOXcJsMOIaY53M1OjIG5/Ki/ZcaT0ZG3l8v2BymVa4+mWzK+SDs0XIq9dikRACQmCTPepxzIje
 WpRaiXmhy1S/8bdEVdX9g9lWAWFViY2vvX1v0R6HaAO83Nyu7xX4YcDxCh5FKt17RAPXiHIcSD8
 MBkRm5SyEMogpzHe3NAh+StDDaqkqIrXM5VCXzu4H4lXxBVJeFQXnDBjLB3HClV/hHZPWhswUrR
 fl5wKxqlZIJjfLO0BIqrdwVzp1HZUTdSzL84wQz1Y4Wo7qyX
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

Add Context: documentation comment that
iio_push_to_buffers_with_ts_unaligned() may sleep because it calls
devm_krealloc().

Also document Return: value while here.

Suggested-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/iio/industrialio-buffer.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
index a80f7cc25a27109cfe22ce447c4117fc94bc8310..7da43a1f2f75f32dc93b9a5fe903378a79e82fe3 100644
--- a/drivers/iio/industrialio-buffer.c
+++ b/drivers/iio/industrialio-buffer.c
@@ -2401,6 +2401,9 @@ EXPORT_SYMBOL_GPL(iio_push_to_buffers);
  * not require space for the timestamp, or 8 byte alignment of data.
  * It does however require an allocation on first call and additional
  * copies on all calls, so should be avoided if possible.
+ *
+ * Context: May sleep.
+ * Return: 0 on success, negative error code on failure.
  */
 int iio_push_to_buffers_with_ts_unaligned(struct iio_dev *indio_dev,
 					  const void *data,

-- 
2.43.0


