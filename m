Return-Path: <linux-kernel+bounces-744399-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AEB66B10C52
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 15:57:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 49705188A5AB
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 13:58:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F6C92E54D5;
	Thu, 24 Jul 2025 13:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RHROcwon"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65BA92E175D
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 13:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753365392; cv=none; b=eS2+93aulmvcDmlmKoGAMqORN/wkGVlxD/tsjD1hcL5BDbiwWeNfVvu9kmHUNb58zDKKhBunX/+2kzFxNZBvZpC2Ukf9fdMsnSnRb/3GNi+oeZ4E2h3Gjj3co0ku3YwkVezh4yoKYZkJwB7gUvciMeSsJARTNLzbtpkfBUE9YDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753365392; c=relaxed/simple;
	bh=Vzp3U7aGndkyJ82EgcFvHbZjMAKNTPgILqBaVa9ZKKE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WZQawGqZNtmTMMey7jm9hXkkPhlev2aWPE/QjjKo0zpKxegJSQUhV19xRBrqJ4l+PGuJLXKN2qJFf0cmbv/9JR8YBX27DWX3H+yyKnIAKLP3FwQyovrdQ7cYjHB6m+ciRhceECmsot0qA2Bltl0dNXmtNcGIHuCm2Cpmnqa1ab0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=RHROcwon; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-455ecacfc32so4577075e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 06:56:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1753365387; x=1753970187; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wXG7080vUoTS71soVhA4Gbq56Ym56pqDEVpEhL2XCIg=;
        b=RHROcwon2Ud+HX/4JYfbI8AeIlRPuE37aGaORXuyjeuCK/5tKW2uS7682GhreQmJfy
         qSgjbAlw6xuO2e7ct5d6oRHucze+NlfN9iQuh/n9nVkLmQSo705NqE4p2jsK//pIXT1R
         FWR6LLd2cmYFXEebAjCGRR+N1I2TqAayaMGiXUNn0iudgrZLXParpU8hWN3n8bVbvlSq
         HofZDgHCJIKBBaZGQhprxt13iG6iTTDJrYWOtdsFQYzkJamAZrXBklaWNqmMzHOGbUpD
         2T2KJz5gkBfibeHVzVokkFEhJ8pS4WsK6UPNZRE+Y9DsNQlJI8e67jM1BpTQ8B4Tqiwr
         mYdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753365387; x=1753970187;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wXG7080vUoTS71soVhA4Gbq56Ym56pqDEVpEhL2XCIg=;
        b=u0AiLbdoag8nkNjuZSwNd5r5ecl9u1Pi2kFynew/UgIrzauhiu4g+a0EZ7zzgW5clh
         XuXm7DAXo/ee7+3WiZJErTyS/s+Emp9PMz4BiDvVOg+Rpm15CCxWum8cxqD+U/b7rQp7
         eqPSlfNl9DYOIFCoNLgoV7F62UGZ1Wdey6Hjcd2WKXqr36hxjuWMZczD+/ebQ6tRJQ5X
         YMqRs1L/Lc7SPHWfwT1kMl+wess6j5ygDmqSNy+bQ6Vw4AAFDoBczjp3euAlVxKUd2jA
         Rcw2ahyvChGTbt0bxYcgraIz68nnDnSsxRT6iBd1cvanH3NdicPJd4uqfbLMgRePJNxI
         3RSw==
X-Gm-Message-State: AOJu0YwrY0skCwDsrv+CMhrPnB7t5NvbDhBpAbHv0iEKsBi+rjHbSspE
	Ygn7K+iRWsZg59rVWQe7rAE2UCcywR/a11/yiaDkpuW56QqEPZWRxx3DAgdtfv9Ju6QBwJSwGtM
	2sgeTsBs=
X-Gm-Gg: ASbGncuo01kzpIEhdsDugD6j57y8Y0qZKuxvaAe8EuZqbZTmiqY5n2GGat6gT61uPFR
	0ups1QvoAph2320Zcc7nfUDlY5ABNKBLIPJB5ew6+ktkm9WQrbyTMCPc7WGNW8/is9OscJUgbdE
	6GpHwRR3LxUUHEGRmv/to8Q4BXA7ynNjsz8a+ZPYjK6jQNmvvo+GAIAoSpsvFCHMo6h3Qslrcuf
	+qasn7XaHRzwtR0dhCjEKaHOBxd0Dxku4i+BeThPi4OZbGW3AnldZqr1gs2JmHnK6SHucYtgehF
	yCycWzHb9h0g5gJ2zuypfWFt+GzjL+JWTIL2CJghaNz+yeCQsFCqqx55SBy2xs7MiSVLTo+GBZA
	/Czs+d3PAB/yGyqnsLqbrwJTd3LfIl4GF1944AxvNNaZONLRL6K+ETSEOKA9KdBP94SgbJp1fvB
	bMQ+eUe8EIMvD8
X-Google-Smtp-Source: AGHT+IGoSF/EqSdGIwDb9gZl52m8tCgkgoHOuTGrpWGU+P8oq0e6jpOpRi4GM0HClIhflbnZpXQODA==
X-Received: by 2002:a05:600c:630f:b0:43b:ca39:6c75 with SMTP id 5b1f17b1804b1-4586a7df4e9mr64595105e9.16.1753365387527;
        Thu, 24 Jul 2025 06:56:27 -0700 (PDT)
Received: from eugen-station.. (cpc148880-bexl9-2-0-cust354.2-3.cable.virginm.net. [82.11.253.99])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4587054e37dsm20889375e9.14.2025.07.24.06.56.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jul 2025 06:56:27 -0700 (PDT)
From: Eugen Hristev <eugen.hristev@linaro.org>
To: linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-arch@vger.kernel.org,
	linux-mm@kvack.org,
	tglx@linutronix.de,
	andersson@kernel.org,
	pmladek@suse.com
Cc: linux-arm-kernel@lists.infradead.org,
	linux-hardening@vger.kernel.org,
	eugen.hristev@linaro.org,
	corbet@lwn.net,
	mojha@qti.qualcomm.com,
	rostedt@goodmis.org,
	jonechou@google.com,
	tudor.ambarus@linaro.org
Subject: [RFC][PATCH v2 06/29] soc: qcom: smem: add minidump device
Date: Thu, 24 Jul 2025 16:54:49 +0300
Message-ID: <20250724135512.518487-7-eugen.hristev@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250724135512.518487-1-eugen.hristev@linaro.org>
References: <20250724135512.518487-1-eugen.hristev@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a minidump platform device.
Minidump can collect various memory snippets using dedicated firmware.
To know which snippets to collect, each snippet must be registered
by the kernel into a specific shared memory table which is controlled
by the qcom smem driver.
To instantiate the minidump platform driver, register its data using
platform_device_register_data.
Later on, the minidump driver will probe and register itself into
kmemdump as a backend

Signed-off-by: Eugen Hristev <eugen.hristev@linaro.org>
---
 drivers/soc/qcom/smem.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/soc/qcom/smem.c b/drivers/soc/qcom/smem.c
index cf425930539e..2aae0e696150 100644
--- a/drivers/soc/qcom/smem.c
+++ b/drivers/soc/qcom/smem.c
@@ -270,6 +270,7 @@ struct smem_region {
  * @partitions: list of partitions of current processor/host
  * @item_count: max accepted item number
  * @socinfo:	platform device pointer
+ * @mdinfo:	minidump device pointer
  * @num_regions: number of @regions
  * @regions:	list of the memory regions defining the shared memory
  */
@@ -280,6 +281,7 @@ struct qcom_smem {
 
 	u32 item_count;
 	struct platform_device *socinfo;
+	struct platform_device *mdinfo;
 	struct smem_ptable *ptable;
 	struct smem_partition global_partition;
 	struct smem_partition partitions[SMEM_HOST_COUNT];
@@ -1236,12 +1238,20 @@ static int qcom_smem_probe(struct platform_device *pdev)
 	if (IS_ERR(smem->socinfo))
 		dev_dbg(&pdev->dev, "failed to register socinfo device\n");
 
+	smem->mdinfo = platform_device_register_data(&pdev->dev, "qcom-minidump",
+						     PLATFORM_DEVID_AUTO, NULL,
+						     0);
+	if (IS_ERR(smem->mdinfo))
+		dev_err(&pdev->dev, "failed to register platform md device\n");
+
 	return 0;
 }
 
 static void qcom_smem_remove(struct platform_device *pdev)
 {
 	platform_device_unregister(__smem->socinfo);
+	if (!IS_ERR(__smem->mdinfo))
+		platform_device_unregister(__smem->mdinfo);
 
 	hwspin_lock_free(__smem->hwlock);
 	__smem = NULL;
-- 
2.43.0


