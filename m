Return-Path: <linux-kernel+bounces-880222-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A969C251F7
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 13:57:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id DE49134FF23
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 12:57:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 587FD34C998;
	Fri, 31 Oct 2025 12:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pjcqSf8c"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7EC934B687
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 12:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761915374; cv=none; b=Ws4hItStnxmv9cwRBm1hlwdvUM6pnBuU7drPh2s3dtlQbpRa8QMvC+TfxRjNacrtJo7saqtn4SR5xFf8LD8zPHAV2yc2MZl0tobcydOIamEEwqclyEzEtSD0szwO09aSrmTW/xZmVcrvqYmb5+KGFrG4HMKCKNwg46vzP0udDYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761915374; c=relaxed/simple;
	bh=9SkaUUiz7kTIzusyZvFJbNhQMbW11/ifo4mNZna+tJU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=l83sRKDOrG5Uqhgh4j6sP17Qo7k1q77fxVQHJHzu6lYMbSPCADKsRVpZcYmisjYdPA64R/ynMEqvL1GIazaJCiXd3zO2VlPs2dwSB3erqC+vv7l+g/wibSqlOQwf3BFnGLh8UkvYnOOpsr+9wVXJuCpb04mMZ24F2/6N/4NFUOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=pjcqSf8c; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-475de184058so7388135e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 05:56:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761915370; x=1762520170; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zOHP7nyDdbsMDvdN2HPmSUfNbw9SBzb4pYxZJwfsKCY=;
        b=pjcqSf8csRvMKhXpsMNT5GfCy/ENV258BI/DdZllu8DN/pdAiGBnqgaygnI2Zmvs2f
         lr12n7FM7S8fhke/yul3Brzf+SejwIVvXyY7cJUam1bUzAkgAk57o7kDehd+D2nRPwq5
         8nONXCFTsEHX2zG0j1TRcw8YWt5XWZUUQIQY/k9/+jkaAvwKqDjhe4EQ5KsbHTh3gQ2j
         lsvzBEvJt71jVAWIj238hncwKT8qLuVLpqFcJbpCjUcJJbic7ujkCE9bgWVwb9k8QH4e
         1XGkUt0JFILfHs8umMHD1QuEvr9z013GauBDtS5pBHhjsd8nsXKb3odreTI23iqWTTzH
         6BEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761915370; x=1762520170;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zOHP7nyDdbsMDvdN2HPmSUfNbw9SBzb4pYxZJwfsKCY=;
        b=lbgLvX6asXlp5bwTovQasTRV3uUKe+BLn8G1XudDUkBsSx2db4rfqtvqsdxmlpHnNl
         ZXIIVdYlifd5xPB7plgQ4R9Ffk7bBc+wHZV4Oy6HrDo+0dSLV+OAJJMUZ+h+gbajyqRK
         R6CvJiHwEUu3qjU6lYwak8TPlebUJwMhkM8kX+eZT//4bc6dd2XmekB86ZaPujQnoj35
         /TO/NAnp5uqA8rMDezP1Pu6njcus6yekB6DtNEdrT4mHEkaxkIFHVhBuHDh4GcgeBpmV
         1dcmbc2R+PIvLdbhAt12rbe84G39NcQDvLU65JRVYV4lJa+9cMwEu9yQY0n4mevstsUK
         8jpQ==
X-Forwarded-Encrypted: i=1; AJvYcCWkfMtXXjozzM0UQuJ9XfqETpX6NWLbSl5eIae1doXjx9kXoLoHzYMN2we/cTXjJ09engmzmu95JgcOyXs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9ZIVfTRbzbhJIblU708VsalFnKHedgRhGwSxjWqXNe2UXguyc
	peXOwbMlm6fTzM1A/1S3z5UVuE8qeAyeix0XGxFN4QFltv8GIjeQ3hhRVdP6AE4+qVE=
X-Gm-Gg: ASbGncthxJ56Z9r/u5V/FlxuW4TZtjyb6616hGRlX3x3QXQUZdRm0LA/tUlMRs+XX9G
	Zl9s4p/hVUGFL2OWTCsG6e+SYMtd/DNr5JcxbxntKz7Q+hxJogW8adypNMz/wjaIBRcKeCTOjj0
	wE95DEUKDvdnXW5g+YLxGpxehXHqQY7XR0vO83CRfL77tDfWBUjOhz9fU+T7VNSk6D7c1LNM3Ww
	BTjjVenmzodDCv2kTuealDL4rmw1U8QoJKiFXSfcm3CxqauT7z9eibNC5Gt6iyVM2Lxn4dt3GxA
	8O09gV5rv9ciSAZmeSXGrcvNvb5nYsJQi49eFRP8XxaAGxR06ErAhF+txZZxRyz4Ims22C9/OF+
	ozFvmZbTSSD2bk8M218167IAPMd8hKFEb7VBOxws61bEd3flj52FmbHSSfkq2sTXtqKyM66nU3S
	ZD+eBwAtz0L/bLFoo4g4jeSXW7GIoR44fLx2JWPfa55J43SYEuGSZRvG7Q8B5I4Uh2z1pVJyUSN
	Q==
X-Google-Smtp-Source: AGHT+IG5tkb1EJ/8aJ1Ee+rlCTIqPTTaT+zFP2s7onbxjS1ItcgDWPxmaFF+3jJVap3Qn/JSHQQtdg==
X-Received: by 2002:a05:600c:a345:b0:471:1717:421 with SMTP id 5b1f17b1804b1-47730872584mr29116745e9.19.1761915369981;
        Fri, 31 Oct 2025 05:56:09 -0700 (PDT)
Received: from ta2.c.googlers.com (213.53.77.34.bc.googleusercontent.com. [34.77.53.213])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47732fe1075sm31814585e9.11.2025.10.31.05.56.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Oct 2025 05:56:09 -0700 (PDT)
From: Tudor Ambarus <tudor.ambarus@linaro.org>
Date: Fri, 31 Oct 2025 12:56:07 +0000
Subject: [PATCH 08/11] soc: samsung: exynos-chipid: prepend exynos_ to a
 method's name
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251031-gs101-chipid-v1-8-d78d1076b210@linaro.org>
References: <20251031-gs101-chipid-v1-0-d78d1076b210@linaro.org>
In-Reply-To: <20251031-gs101-chipid-v1-0-d78d1076b210@linaro.org>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Alim Akhtar <alim.akhtar@samsung.com>, 
 Peter Griffin <peter.griffin@linaro.org>, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, semen.protsenko@linaro.org, 
 willmcvicker@google.com, kernel-team@android.com, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Tudor Ambarus <tudor.ambarus@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761915362; l=1201;
 i=tudor.ambarus@linaro.org; s=20241212; h=from:subject:message-id;
 bh=9SkaUUiz7kTIzusyZvFJbNhQMbW11/ifo4mNZna+tJU=;
 b=nVOMdUvG1eXJr+DmGEMwRP9k/VrvAUTj6to5NckxRVaBgVO0QjELdEXrxI7Wq+M6ZeX/ijI4h
 dh24nYIEhqCBdabs7dGrkSupGP7jmC0xwBudDXgEZ9PZzzmF0vMd5kr
X-Developer-Key: i=tudor.ambarus@linaro.org; a=ed25519;
 pk=uQzE0NXo3dIjeowMTOPCpIiPHEz12IA/MbyzrZVh9WI=

Avoid name space pollution and prepend exynos_ to
product_id_to_soc_id().

Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
---
 drivers/soc/samsung/exynos-chipid.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/soc/samsung/exynos-chipid.c b/drivers/soc/samsung/exynos-chipid.c
index 9c43c615167e4bbf15d00d42c2e52cc64d7dae1a..92cd5dfc0a9b641428d0d047cfefd4256a893ac0 100644
--- a/drivers/soc/samsung/exynos-chipid.c
+++ b/drivers/soc/samsung/exynos-chipid.c
@@ -84,7 +84,7 @@ static const struct exynos_soc_id {
 	{ "GS101", 0x09845000 },
 };
 
-static const char *product_id_to_soc_id(unsigned int product_id)
+static const char *exynos_product_id_to_soc_id(unsigned int product_id)
 {
 	int i;
 
@@ -222,7 +222,7 @@ static int exynos_chipid_probe(struct platform_device *pdev)
 						exynos_chipid->revision);
 	if (!soc_dev_attr->revision)
 		return -ENOMEM;
-	soc_dev_attr->soc_id = product_id_to_soc_id(exynos_chipid->product_id);
+	soc_dev_attr->soc_id = exynos_product_id_to_soc_id(exynos_chipid->product_id);
 	if (!soc_dev_attr->soc_id) {
 		pr_err("Unknown SoC\n");
 		return -ENODEV;

-- 
2.51.1.930.gacf6e81ea2-goog


