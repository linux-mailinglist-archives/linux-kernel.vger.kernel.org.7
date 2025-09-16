Return-Path: <linux-kernel+bounces-819602-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D856B5A391
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 23:05:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 50D9A4E10DA
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 21:05:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61F7F304BD0;
	Tue, 16 Sep 2025 21:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="h5aOGJfg"
Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2179F2F9DA4
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 21:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758056647; cv=none; b=GbAHYRfDlRrMA4jBIMWDowwPwvt3YUroBg+2cVjfH6PU0hNEw65XeOcFClAcWdVbb1u3UDai6gE9Ro1Tho0002aFWYMXNuXtu4SZf8d4BV/ArC81RCBVAnjfrJ8deMa0/yZc/Q8j2lcf6IY0BtYidmkrP1UuH7YX2N/IY4VQaTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758056647; c=relaxed/simple;
	bh=6mdeYyd3hF07QuqGuLzQcOwjnfUK2lpqXDhP/AFlcKY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=P/nEbffsP/o4Ag2SccRAWisPsj/YTS84IaknYrKwnP2hFIOhW6Fp5q8ANPuZssqm1t72Iyg5s00F/GwyRnlzV74vqCm1FbrDlB03JDACu/qut53MlvPFy5w+kT2nYcioxRjaURpZTnkMQI47FL80w4H54zipG6/GDffBCVGSeus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=h5aOGJfg; arc=none smtp.client-ip=209.85.161.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-621132816c8so2818164eaf.2
        for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 14:04:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1758056641; x=1758661441; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zuUiBdYdOzhT/4QysYZeoKXL89SuD8knZroyb1BNveM=;
        b=h5aOGJfg4OJRznwjIgshyjYLaAF+hMYWs2h8rTC7TaDYdoJLUvFIiPKPDT1FnSk05W
         k5oScwJEiM7Hhh9DlpaP7oQ60kOBTD/4J5M544qgooZKiuninpTusKYOmodW2jOFFITx
         2niLX9GfAwrf+lZisftqj/Lj01B+eO0OtNHssh0dICPNs+N9F+oEZp+P2kV0VeTdUcMh
         FAvlGHxCy4vqZFfDxegAnAw+6NmM+JYLJ/SIF7LJQ0nQvK1Og57hW5yBFwVdhK0Zm6Z7
         hfm2AL7nMGa2qDAOUwYxfzXVtjCdVZUPmSwplDKvIhzPfeIhq3BH/ChRmbfXhCyMMaQv
         CWFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758056641; x=1758661441;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zuUiBdYdOzhT/4QysYZeoKXL89SuD8knZroyb1BNveM=;
        b=qu9Lwayp2HqPD3xux17NLMlLh5QS62gucgbk97BCO83kl3AEKpf+9GMSlBwY6mbEl3
         NDiV3TBrtndHc18/6MGJh637oFZzw/+1SimRX9rvRrghFpQM3Ty2OmL1E6mqqHjZdDLj
         Puqg7HM08yjY+adUW0emUeJLpscha+QE7FCkmUgOazFo+DvWuybW3P/vOQS01a2dHkqO
         Pu1CQeJitW5+WMoBxNPesQEtKgje/ZIut+wghIx9Sm1IX4rwSWQVKjuUHVi8GPX8dVKw
         rDMuvvhANVOoqA1kqML92HVfsCCMXKRqDiy1rXHQenFWhe2/3PdNiDLRMD+O4qjIaKRN
         7BDw==
X-Forwarded-Encrypted: i=1; AJvYcCXasJMLP5NSxwTlvI483fuCv5+oVFU+I1zfy5dTQvkCPExTZ7xQB2Kaw1lifCnRWK71XfRY/qVas371L8g=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBP8yz4TuZa36L69HMuOSVvCqzbwesvGsMLXF6//7iZWMzqhFN
	LXuWwkJwCoJcyWDhbXNeS87GdbHxsYt68WMx8ukxy7SCVVNU659SAQ/iKgs4gajeSPo=
X-Gm-Gg: ASbGncvBWuk8XInLnPip0tJgragdeu/zOPZGiXzpyBkd/Oj/gORPgod4a2zkj6TXC9P
	1qHwdwW5j3WdRJdzgHfBI6bFQZvdh6cP2S01oInNQTaQJTU4kQOrUd1VV0l2KgEcDV04mOXemiy
	vkhvRzU14F0nCfL3tMY/Zelwrp2xvd/8BgmByW1ifAXa+VOJTYYOEHx/sPaDGsSJlV1+aJGHRXe
	wuRnL9nEVI/sD4NGTSHz62E47JDt9OIzd7xkxPVP0T+GxSMhaChs+EDuLBMbgTyxCJORrulS0M4
	pQowJEQmBZzlAfRcwP+ghKBwinbTP9NJg5ZVsgt9MU0NUQoxazu7Tmo83JUIPmuPrktDw1sZaQH
	c2R52efv7cIQWBBpZ1uP+de5xIhUq
X-Google-Smtp-Source: AGHT+IEThmTUM++mlzzS2GM17+096Q+59Aps0AMQsj3pnAzcqsCTdD0X+SDwFBXwlrpK1soPiyj0Ug==
X-Received: by 2002:a05:6808:1302:b0:438:3b69:ab91 with SMTP id 5614622812f47-43b8da9ed09mr8658219b6e.50.1758056641220;
        Tue, 16 Sep 2025 14:04:01 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:1d00:70a1:e065:6248:ef8b])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-43b8294ac06sm3540044b6e.14.2025.09.16.14.03.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 14:03:59 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Tue, 16 Sep 2025 16:02:57 -0500
Subject: [PATCH v2 7/7] iio: buffer: document that buffer callback must be
 context safe
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250916-iio-doc-push-to-buffers-context-v2-7-8b17937a6cc7@baylibre.com>
References: <20250916-iio-doc-push-to-buffers-context-v2-0-8b17937a6cc7@baylibre.com>
In-Reply-To: <20250916-iio-doc-push-to-buffers-context-v2-0-8b17937a6cc7@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Daniel Lezcano <daniel.lezcano@linaro.org>, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1632; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=6mdeYyd3hF07QuqGuLzQcOwjnfUK2lpqXDhP/AFlcKY=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBoydCttq6RvmTZHapP29zuCyinYPpvWDq5o1dGF
 29WTFK09xGJATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaMnQrQAKCRDCzCAB/wGP
 wDLUB/92zOe0kO9ppzodI74aYR9FNSaUt/TvOjLFc1GmaR3PblmKWJ4ZOo/YbGDfD9p5xaD08wF
 mtmHDt5X+NYKOGKRIZa+qUXi3MXdQk2Ji9iu6q5zpAAz3+617cJwOX+ZcF4mN+kTotzHnrLQrQb
 FPoL6gIXPKfbYR1tYJ5Cg4eslkpn87OC2Er6I/yNsmKBxcN0lapsQhoddTxjRYDL6ljSJNhWThP
 Foh2qQEJQBHTr1s8Yi9obAjbTXSTwCFXiHRoVQ9DS8lFV8MbIoiGroLYqiDv+/EU6LCEsbVIHU6
 j4xDgvtpohHD2migse5WmWL950+x7kN6VmEHOKWtmlAkdujt
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

Document that the callback registered with iio_channel_get_all_cb()
must be safe to call from any context since it is called from by
iio_push_to_buffer() which can be called in any context.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/iio/buffer/industrialio-buffer-cb.c | 1 +
 include/linux/iio/consumer.h                | 3 ++-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/buffer/industrialio-buffer-cb.c b/drivers/iio/buffer/industrialio-buffer-cb.c
index 3e27385069edb5b717a4c56e72dff2c0a238fa07..f4ebff9684936365ec179489d9041d8bdbe58738 100644
--- a/drivers/iio/buffer/industrialio-buffer-cb.c
+++ b/drivers/iio/buffer/industrialio-buffer-cb.c
@@ -13,6 +13,7 @@
 
 struct iio_cb_buffer {
 	struct iio_buffer buffer;
+	/* Must be safe to call from any context (e.g. must not sleep). */
 	int (*cb)(const void *data, void *private);
 	void *private;
 	struct iio_channel *channels;
diff --git a/include/linux/iio/consumer.h b/include/linux/iio/consumer.h
index a38b277c2c02cb85a766d645a046bdfa534db51a..5039558267e4c17b2e09246036d0df352e242d06 100644
--- a/include/linux/iio/consumer.h
+++ b/include/linux/iio/consumer.h
@@ -131,7 +131,8 @@ struct iio_cb_buffer;
 /**
  * iio_channel_get_all_cb() - register callback for triggered capture
  * @dev:		Pointer to client device.
- * @cb:			Callback function.
+ * @cb:			Callback function. Must be safe to call from any context
+ *			(e.g. must not sleep).
  * @private:		Private data passed to callback.
  *
  * NB right now we have no ability to mux data from multiple devices.

-- 
2.43.0


