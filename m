Return-Path: <linux-kernel+bounces-896771-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 239DEC512F6
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 09:50:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DB1A04F497D
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 08:49:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21DB22FE052;
	Wed, 12 Nov 2025 08:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EU1aoFlN"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5D732FD665
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 08:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762937325; cv=none; b=sHuwVAvDmEfNh/Swf5ihH+0wKaLjysCftRCysZAtlfWuuiKvoIErEOLNVqg0gvj076CSIzCcBGCKgJDFt065gUSav4pLs+pxG7mgm26WJnxeHuHceQOIFl1AufZ4W2WEuFhtTZZ2KHK/Acq8weJ/IFyziOieo2SKcyJeKNCNQr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762937325; c=relaxed/simple;
	bh=RCAfXidI80M/Q7eFcJ2WvQagTMEdD/ohdv6ENAxLfKc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tI22rybe+F4UMpnG+7jrfzBpgGrPnta5JaO2XSBiKzsekVcuHKJhcJlZEHIrAzYTusGq1RMpM7GXeK42pyKng3naHUYJldp7MIVLHvTBjHEKNwwJ+pMkO0TPK/8zWVJnzM2iMmkkG64GgCr9lkkcsCeyuIMbItrlbaGkoJ0rXKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=EU1aoFlN; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-477619f8ae5so3900165e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 00:48:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1762937322; x=1763542122; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BVPUnWtWGToKWpcPTHZ/hxaM2+CTnOqNCH/2mEyOSiU=;
        b=EU1aoFlNtlFAQvTUUvSSggU+/eDvRKLjo5HgN+c2j0jTzZbQuoWF/p8+FbUwfoRSPX
         GeQdK3/js/k+6AjukreNx9qk3o0p8kxZ0KQgNxQG89vGgAumONsbhgiuuW/ju0qNcnUB
         Jq4MzKkWV1y6J8l7bl0mU9WuAQY45Atcx9Z04s6jt478wC3bo44GKNTdCYPZjd71RQv5
         ilU4hsCCHBLoi6EIXiTajFVSs3D6v4hbQtvkqUkRe89NMmOQmCrtOVwsf0Ho4MPg30se
         PxsWgkJXfH6l/qv8sWKhmNh1u6Xr6gD3yrZEJsOm+PqeX5vZ2N18F/Mvn+1hW0H9YjOO
         TW/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762937322; x=1763542122;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=BVPUnWtWGToKWpcPTHZ/hxaM2+CTnOqNCH/2mEyOSiU=;
        b=QtjktvRR3RuWwUW+UDW3lXfFb2VYZZCnMNESn8snPcG3SNzE/tRm1tbH77dw7LU+eq
         HdWlQ6/pRAInLgw5hz91jwYAmXT5NkTGS1A5yYB21qU2ptE7Uakb/TZaQzupGVADroU5
         eAA3I+QpvbWVHJ9fOmT2zoCPpNDJHX6ADNjxRo8q1wvmKa82Sbk5s8xX5j6lOpd8K/HZ
         6E1f4zhm5rCWc8kLMFrp7391VvLOhC6BACIYUmOeuYuJ6deeh8eO11ENNQ7jDal93Wkl
         dRQJ5p16udj5uvOtRsfv22LeFsILgjeYI9ZwvH3U0BD1k/oEM3PA2J2ejVYd27i4Nj4y
         lZeQ==
X-Forwarded-Encrypted: i=1; AJvYcCXmgd+/OGFVf0Ob1tJCy8Vu4HW1lNHMYZbnrt7Hnd/DUuIPDuhafP1+oQLDlqF2MoYBOKDo3wxBOj7azJg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJ2c3oW8wSwxaEMyiNtNQXoyZvtD3TgirU2YznRto3xqia+3ju
	gF8TZ+wQ4rl8tRXo9PtHbqcZcuslivizMdtVjz0guyYlOpXTVZv5C8ul+NJ2S7VK8rc=
X-Gm-Gg: ASbGncv+Uxf9au98JduKxfaSC5SzW4y51Ou8dwBW1lOynms/6Qpu1z9TnKiukZSoKOT
	N85H+xDe8iArZiIitCh/4OJ5WnYKngXo3Z5V7Wc3bUZbIlrm4I5IK5VIzW+b2hFOCfrRhLmvdsH
	K98ToYvGSOM5lA77cmDJz+smX/EcjeTcqkra/YAKQUPj+mDmqGjTfk3GBBsLEeeDsok+144D2ZD
	9AczHcJOr910TmfO8nKQryeIAEmHikB9ZlYjCcfClVpbHoXW0wIRf/nzorFLTIiUp3KQS8RspcR
	QpfyWpU2M+9yiBhDL1LRecqSgKJlDoDix+D6FZk+N5LCcWg09ILzrHneE8hA4on+EnCcFxYk6dL
	j3mdbNx7HVFCkg1DGfSRDr68Gk/vCqcVg0uy8kp5UX/O4Aqmd1eq+JXi3EbRE4K5cF1UA/fuZ6M
	+Uh0g3h0DHtQvw2s/Xw3aQDYaduhGwCr8B4JOwO13vWRMsxn34Z/w1sqK1
X-Google-Smtp-Source: AGHT+IEt7OwDsDcJANR+ViPUh1ScTLjLVqjF1eOouEZusB6zlVJflofXVhyDNqKf92Nzra23MWQEJQ==
X-Received: by 2002:a05:600c:4f8f:b0:46f:b32e:5094 with SMTP id 5b1f17b1804b1-477870a6e5fmr21321335e9.32.1762937321949;
        Wed, 12 Nov 2025 00:48:41 -0800 (PST)
Received: from ta2.c.googlers.com (17.83.155.104.bc.googleusercontent.com. [104.155.83.17])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47789ffea1esm3732645e9.13.2025.11.12.00.48.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Nov 2025 00:48:41 -0800 (PST)
From: Tudor Ambarus <tudor.ambarus@linaro.org>
Date: Wed, 12 Nov 2025 08:48:22 +0000
Subject: [PATCH 3/4] soc: samsung: exynos-chipid: simplify with
 dev_err_probe
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251112-chipid-trivial-v1-3-ec2dea03bd83@linaro.org>
References: <20251112-chipid-trivial-v1-0-ec2dea03bd83@linaro.org>
In-Reply-To: <20251112-chipid-trivial-v1-0-ec2dea03bd83@linaro.org>
To: Krzysztof Kozlowski <krzk@kernel.org>, 
 Alim Akhtar <alim.akhtar@samsung.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, peter.griffin@linaro.org, 
 andre.draszik@linaro.org, willmcvicker@google.com, kernel-team@android.com, 
 Tudor Ambarus <tudor.ambarus@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1762937318; l=1084;
 i=tudor.ambarus@linaro.org; s=20241212; h=from:subject:message-id;
 bh=RCAfXidI80M/Q7eFcJ2WvQagTMEdD/ohdv6ENAxLfKc=;
 b=Iuyx1Rcmem+gTbp+iq/ldL4czfZa+yzrFYBAtmElJwUtpSKiugcRP40UAvhwbCRq/MQa7IpyM
 B0bxpDc4AAaBbtxve8UQ6SDwWZlyqRx/xCuMxuy+I4U++uW/w30900h
X-Developer-Key: i=tudor.ambarus@linaro.org; a=ed25519;
 pk=uQzE0NXo3dIjeowMTOPCpIiPHEz12IA/MbyzrZVh9WI=

Use dev_err_probe() to make error code handling simpler and to get
the standardized format of the error code ("ENODEV" instead of -19).

Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
---
 drivers/soc/samsung/exynos-chipid.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/soc/samsung/exynos-chipid.c b/drivers/soc/samsung/exynos-chipid.c
index 3671ed718b933a2dbb9e154202bd3235e3efd758..b5866a324d8ae911a5c99d0290328efdcc072dfd 100644
--- a/drivers/soc/samsung/exynos-chipid.c
+++ b/drivers/soc/samsung/exynos-chipid.c
@@ -143,10 +143,8 @@ static int exynos_chipid_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	soc_dev_attr->soc_id = exynos_product_id_to_soc_id(soc_info.product_id);
-	if (!soc_dev_attr->soc_id) {
-		pr_err("Unknown SoC\n");
-		return -ENODEV;
-	}
+	if (!soc_dev_attr->soc_id)
+		return dev_err_probe(dev, -ENODEV, "Unknown SoC\n");
 
 	/* please note that the actual registration will be deferred */
 	soc_dev = soc_device_register(soc_dev_attr);

-- 
2.51.2.1041.gc1ab5b90ca-goog


