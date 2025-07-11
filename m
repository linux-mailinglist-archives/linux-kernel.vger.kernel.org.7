Return-Path: <linux-kernel+bounces-727876-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63BA1B020EE
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 17:55:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 169593AC8D5
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 15:54:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E5E62ED172;
	Fri, 11 Jul 2025 15:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="YxBo7v3g"
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC4C718DF8D
	for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 15:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752249320; cv=none; b=a406oyI4VbZVP7KbBwCxx85YAH4hDQOQwiE7QPu6IpZp5JK2fjrNmRQIRbOGlRYD+KVpADJB9uWnvUZmAvXnvPGe438Cv6AzgWdQRNv5FWktD2Y/ZZVqm9l4fv44MHHlFy8XQ5KD/eipKekXKpMLORJodM7PimAR0nGC5E7lays=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752249320; c=relaxed/simple;
	bh=p1Ot7fwFyp3rNeiGKP2Pf6ZoMkbKz4ivHLt6owO8qOA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=e8McLRXIVf0FTAeiOkTVC5WKMDZmaUwqqKZoNs8Dn3KdfeVaz3lkg6xnA9YkZC8cnExovcCZAmqGqIrEOCkWayVgNAh3NwkTJE7HpG4rR+3XwikTcToBzLFdj2GGbeI5VREcG8CDEyHFpHpO8Xa1fMji95I07URAXFB6giynOQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=YxBo7v3g; arc=none smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-735ae68cc78so1306432a34.1
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 08:55:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1752249317; x=1752854117; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ALf1X7Rod+QmNvsPsp443TiwKUm1nvu6GsJBGeigeFI=;
        b=YxBo7v3giUsnlBnEkHqEGJkxpEHyrUq8uV3w7TdZP3QCFWaubJSLMiZupk/SYLko9h
         +K6P7OidnQKhmwjEkuiVv00VBge1Wif9C165lXaXO6ifZJuDgWvyLaDpowufiUyS9Sjy
         wiKEKdhH5mLfFnRjUTekELvmyJmkxX8YK+bqj4/sW8avsrtjCPTqOCSAPDtS1YhS2K5C
         8r8bE3aau3Lif4HZL6piC7E+m5VaFHJWJfmzrZuQq/Zq7Qhj4HeOW67qeyVFuihK41nh
         NrfNuQdiWf3/fQv8twKeodT5V2hNJxbz2a077zv3TNRzp8wOpdscq99syEMrwme8GylN
         I46A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752249317; x=1752854117;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ALf1X7Rod+QmNvsPsp443TiwKUm1nvu6GsJBGeigeFI=;
        b=ZyI6kAOVHsTiVi9AOtvgPd5MOl70LOnaumWB80ax7ruJxfpx3VsNVg57zeXgGZIi83
         dhO5kuTgA1G6izXdqmEEY09dhS/HNR0IPl/+gh49yvQJxidtkP1a1CoSl2upX9l6A8aU
         1T/e0E4bzvS1OGWDAMFx/X7UC6gkBImxDeZbZgtbkawBmuIcrCBI9GH1xq9HW+OFa09j
         FAC+rENNMqGRtuZT+f0F2aLi9//7g+tRnM610J3dZONP/ruqz1t2tc+2YGUiA0peUqcg
         DuDa52QSBpByiVytwc2aDRnxixe4viWtIII2D+SHzDiTXVLqFIq64nkNvsa/RiN8eiQZ
         YtDg==
X-Forwarded-Encrypted: i=1; AJvYcCUM3r+uBPN7x5ScOrTvarcRKCIIdkyo1C5O6zrhKlCYXQMAOwTMU9hA8wqsSnmYVP1wxdDkb/z8VoPZsKo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMtX/0xuvYLn/pLIzAxVy2LK96dQoxRUiUhMHXvaquU9T+uRcx
	x1qQlbAjKabGJVhEKKI3l42IqS/C0q/+v5EIgEGdPJRcrpO1rEyLiozxlQACGNRmmWPcJtljwTz
	HazNT+B4=
X-Gm-Gg: ASbGncvT0rXzeIcZOMqDP//sueYwYIsXSo8+S+WRjdj2q9fUkYmd7FSL3oQacHVRaE7
	LZXYZjiqUvRtOxdK9PZ8OgIf6ENDN0vyehkSze6nh+XWdlhtG02s2feZO7PYnFG5Ts5rbc8Svev
	Gu11bmPJNOWP/Ln386XndoKjPjXA5Fxn9UBROGQAeixQNT/4ejOZDXgnXFKyZ1Fjv2TaiZ82iZw
	1Lz5sGG7Vp3/fhbsULXlj1clyLDJ3wJJpM6Kc8Psl5qKOrbRNAG2shHKsa/OJApkOBupHDLUNiY
	NhvJdUm4t8XSdOaiwmGkN+2oJWGgh+E/oLs3TmBmr9YClA61k1DbvrkQo6pWX0ZxWF3mAe87YaK
	M+0vTQoYrv9P3RCSTST+sT/Z/m9avHxmPp5N1ICM=
X-Google-Smtp-Source: AGHT+IHX/K76Zdq7pRcux0W/uzxRZwqWhKse0oq12O+uTQoErsfsBRX+nj7saE6UtNfnD2iOJDkNrw==
X-Received: by 2002:a05:6808:15a5:b0:40b:1c78:f5f5 with SMTP id 5614622812f47-41567c4bd38mr1897734b6e.27.1752249316750;
        Fri, 11 Jul 2025 08:55:16 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:1d00:4601:15f9:b923:d487])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-613d9d820e8sm522402eaf.10.2025.07.11.08.55.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Jul 2025 08:55:16 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Fri, 11 Jul 2025 10:55:07 -0500
Subject: [PATCH] iio: proximity: sx_common: use stack allocated buffer for
 scan data
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250711-iio-use-more-iio_declare_buffer_with_ts-5-v1-1-4209f54e010f@baylibre.com>
X-B4-Tracking: v=1; b=H4sIANozcWgC/x3NQQrCMBBG4auUWTuQtJagVxEJNfljB7SRSVuF0
 rsbXX6b9zYqUEGhc7ORYpUieaqwh4bCOEx3sMRqak3bG2cti2ReCviZFT/4iPAYFP62pAT1b5l
 HPxfuOR3DyUbXmc5Fqr2XIsnn/7pc9/0Lf30rK3sAAAA=
X-Change-ID: 20250711-iio-use-more-iio_declare_buffer_with_ts-5-f4c91d73037d
To: Jonathan Cameron <jic23@kernel.org>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2345; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=p1Ot7fwFyp3rNeiGKP2Pf6ZoMkbKz4ivHLt6owO8qOA=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBocTPcQAlCrmKq9hNUJl4Kw1D57FHXb41y7wDMG
 9e6SK3gwa6JATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaHEz3AAKCRDCzCAB/wGP
 wDkHB/0R8VoVxieBp9t+2WtlakC8LYp7TwVU2vpMN4VHE7qlhaPwavjM3pG7+GXQIxFLSJhVRDH
 OlUaS7ozUAoVDyXber96l+oXQUuBmMjpya2q7UTNVrPTX9mFHuhMtAjai7t2sUzt/2WiTbfJM9X
 i06AlLqqUC9Ka7dQq0h0nxA+P+c2zy0T1/nxliN3p0C/3svkGBUBcfbCvJuPQrxmO0rm1vDhkII
 ZJea/1lbreTdsrlTC2GRE7QH1mn4JlR0O/kQ41SvlkVezSIsVhkMq2SiSmuG3pc18MzaqXeOulH
 O1/lH32lhusjgG7aJ9VOx/RVvxXMGTQfK34JoQzqvCcl5uqH
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

Use IIO_DECLARE_BUFFER_WITH_TS() to declare a stack allocated buffer
in sx_common_trigger_handler(). Since the scan buffer isn't used outside
of this function and doesn't need to be DMA-safe, it doesn't need to be
in struct sx_common_data.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/iio/proximity/sx_common.c | 7 ++++---
 drivers/iio/proximity/sx_common.h | 6 ------
 2 files changed, 4 insertions(+), 9 deletions(-)

diff --git a/drivers/iio/proximity/sx_common.c b/drivers/iio/proximity/sx_common.c
index 59b35e40739b0d931dbac076ca5c83ba421ba766..fae035e8d2f5a40ed7379dd6e306f84878a9bef0 100644
--- a/drivers/iio/proximity/sx_common.c
+++ b/drivers/iio/proximity/sx_common.c
@@ -361,6 +361,7 @@ static irqreturn_t sx_common_irq_thread_handler(int irq, void *private)
 
 static irqreturn_t sx_common_trigger_handler(int irq, void *private)
 {
+	IIO_DECLARE_BUFFER_WITH_TS(__be16, buffer, SX_COMMON_MAX_NUM_CHANNELS);
 	struct iio_poll_func *pf = private;
 	struct iio_dev *indio_dev = pf->indio_dev;
 	struct sx_common_data *data = iio_priv(indio_dev);
@@ -376,11 +377,11 @@ static irqreturn_t sx_common_trigger_handler(int irq, void *private)
 		if (ret)
 			goto out;
 
-		data->buffer.channels[i++] = val;
+		buffer[i++] = val;
 	}
 
-	iio_push_to_buffers_with_ts(indio_dev, &data->buffer,
-				    sizeof(data->buffer), pf->timestamp);
+	iio_push_to_buffers_with_ts(indio_dev, buffer, sizeof(buffer),
+				    pf->timestamp);
 
 out:
 	mutex_unlock(&data->mutex);
diff --git a/drivers/iio/proximity/sx_common.h b/drivers/iio/proximity/sx_common.h
index 259b5c695233b4e295ad8ae2b05fceeaa4a7ae61..97b264aa50b0c9811ce6b42be34eace03eae2627 100644
--- a/drivers/iio/proximity/sx_common.h
+++ b/drivers/iio/proximity/sx_common.h
@@ -122,12 +122,6 @@ struct sx_common_data {
 	unsigned long chan_prox_stat;
 	bool trigger_enabled;
 
-	/* Ensure correct alignment of timestamp when present. */
-	struct {
-		__be16 channels[SX_COMMON_MAX_NUM_CHANNELS];
-		aligned_s64 ts;
-	} buffer;
-
 	unsigned int suspend_ctrl;
 	unsigned long chan_read;
 	unsigned long chan_event;

---
base-commit: f8f559752d573a051a984adda8d2d1464f92f954
change-id: 20250711-iio-use-more-iio_declare_buffer_with_ts-5-f4c91d73037d

Best regards,
-- 
David Lechner <dlechner@baylibre.com>


