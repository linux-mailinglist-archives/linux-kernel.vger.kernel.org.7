Return-Path: <linux-kernel+bounces-694211-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 32697AE0965
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jun 2025 16:58:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E444A1892681
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jun 2025 14:56:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 475E628C014;
	Thu, 19 Jun 2025 14:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wbTjSoQ+"
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E745D22D7A5
	for <linux-kernel@vger.kernel.org>; Thu, 19 Jun 2025 14:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750344925; cv=none; b=F30Qo+42aXy+rB1FOs/zwNWQ6rWyBmjjxTZJDHf4JwrC692Q3CL73wXEIgg6j4DQ6QgS3Hqq7hvafh0z+MNX/xqfF0i4hsIeFBAHauST5rLMLYAl7erHfaN3UgBglrBfEH2+NI+mTk5IxVQGnu9BODRSoFRYmCzZ3zgQZ2NZQ+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750344925; c=relaxed/simple;
	bh=6Z4D16SkPJ8yBSytHwVl7DqQPX/xHbOuvdjyNeV7Wm4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UeNMgG8D9Gb98nLih3g0JGHiWvClxIyaRQaMiAjycj78yiI9l9u623LolUr0hbM5ceR7OPe5YY9B51r/UPFy2BqKFGZSJENSsDcgDFTtn8mJyL/g3QPidvHm+5rQLkXtNRsluSWJqux5GSRB3sqmrCwXLzcloPf5ZP3Bm62R4dE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=wbTjSoQ+; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3a365a6804eso583634f8f.3
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jun 2025 07:55:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1750344920; x=1750949720; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oEHr+JFKq0mjjtdNVZ8KWmf7N7HSZ0JZspgwtDVrdBE=;
        b=wbTjSoQ+TSYlMS/h+iShp0+5ton1au/W30Fnq4R2IhpJO2/BmODFJ5SKIyeavg/5hb
         eIWDQGZyaRwok6dYCC2Zgvqwc0bEbgl0ijj18avyvtl4w896uifKXCsSKaUWsk/x4R18
         4a1PJoXnaXDIfo2qm/FnBx80iXL2B9MlxkrBokXTXL8R8YYDwUQJZOhAz0C+n7adBTce
         LJxUxZTjAs4irM2FiZGnUEUnajy7C0H7aqR1FkwYoPqcxzXP4CYl1k0oqljCDR/QNgVM
         tn+aZT4IvranYYw0/ORE2rUTCuflcUQ5TV8u4nlnkKU3mrwrtovtOMXHmzT1i7YDQceC
         N6jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750344920; x=1750949720;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oEHr+JFKq0mjjtdNVZ8KWmf7N7HSZ0JZspgwtDVrdBE=;
        b=JR+8dRb7SXiYINk0Vx482/WSWZdBWuL/fhLKQATmZTfwBvTatUCtVZlV73Dzk6khIu
         eFg8j+okC6AReD+3wMyhl0MsWhL7nlzFbgCUCGGJUvE9KP7+MzPmqRTXR6jU45A+oM7d
         oPqERh0JOQbu15VpjWoBqARZu6cfjUx9EEQuOPHhi3BL8c4I2t8s/xvSIiEFMbZH9v0M
         m971oOxS1ic5zHxz4uu/3Q+eZnw9HLeGN1TiNd3qKxXrbJw2TusuxTbDSR+ijxeqcL1I
         QKvbkt+Bb0hX37O791QY2Y7WHQYdmBlbUKHOsWixA1MincKREVuTnuiUy7DAVjWhnL9T
         JMMA==
X-Forwarded-Encrypted: i=1; AJvYcCWhG1c5lV38vCw/lzA1sqE1E44GKw+Pq66GaV0I2camnHDOBP3UOzZXjlocPaCCsHzc5clne3iQUF4fooI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwiSmMONkkOHiY4T96iEhjvbDvxrJTQptNxTPavlF6R5jWl7TB4
	7in9gydZbO4KHlQ0+53xfcRA1HwPuT+KqYgsvlrwC52GEHZ/9J0xL5BWtDrVYhNF1jc=
X-Gm-Gg: ASbGncsNa3jwYNMgQzw58CELcn7m8mt5Bd8Qzagydr15+FMIZrXbt512U2ztbheezgC
	fzAAdddP0uaBtPQfWj+gbOSD2giLa/EuVVLxnL/0Kk4lLl+JUFM/GL5n3jJdt/wDe9LRJppZifV
	H/hFnYbwCdkIvb0HNc0nW1gvep11B6raYS7mYB3PvJxr4nI90NhpSc2mrwl4zvUCqw4lztxIB1C
	g29SU52C2S/R//mgvOoDSbkRTVqPtelzH65tJShj2INRs/oGZEo1gjB+A0OgPCM8iTWiQI2VXax
	0nrS0x9w3Suhhx/E0jR5ceSO+JlyW+RPXRCLyk/XqKVyeczetCwHhl8SgUnZA9CX1uPeCU/LlXu
	C+g59OAdXVn8=
X-Google-Smtp-Source: AGHT+IHWbjMlG2E6TzWb22wDzJtnoqglGRvEM5is+uCoWk0J9I5KSBBT9LoIyRfmFnTQymBf3ofmdw==
X-Received: by 2002:a05:6000:18aa:b0:3a4:f50b:ca2 with SMTP id ffacd0b85a97d-3a5723663c3mr16381011f8f.8.1750344919992;
        Thu, 19 Jun 2025 07:55:19 -0700 (PDT)
Received: from toyger.tail248178.ts.net ([2a0e:c5c1:0:100:b058:b8f5:b561:423c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4535ebced8asm31343715e9.40.2025.06.19.07.55.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jun 2025 07:55:19 -0700 (PDT)
From: Casey Connolly <casey.connolly@linaro.org>
Date: Thu, 19 Jun 2025 16:55:11 +0200
Subject: [PATCH 03/11] power: supply: qcom_pmi8998_charger: fix wakeirq
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250619-smb2-smb5-support-v1-3-ac5dec51b6e1@linaro.org>
References: <20250619-smb2-smb5-support-v1-0-ac5dec51b6e1@linaro.org>
In-Reply-To: <20250619-smb2-smb5-support-v1-0-ac5dec51b6e1@linaro.org>
To: Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Kees Cook <kees@kernel.org>, 
 "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Sebastian Reichel <sebastian.reichel@collabora.com>, 
 linux-hardening@vger.kernel.org, Casey Connolly <casey.connolly@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1378;
 i=casey.connolly@linaro.org; h=from:subject:message-id;
 bh=6Z4D16SkPJ8yBSytHwVl7DqQPX/xHbOuvdjyNeV7Wm4=;
 b=owEBbQKS/ZANAwAKAQWDMSsZX2S2AcsmYgBoVCTRhc+icEuxNhuT86NLqeDxQeR4vqH+O6CVX
 1VOLWhF6VCJAjMEAAEKAB0WIQS2UaFGPGq+0GkMVc0FgzErGV9ktgUCaFQk0QAKCRAFgzErGV9k
 tmGRD/0R7yKQaE0xf7lUByZ4lt/WrVrHsd4lwLP0Knrr7xy4r0l8x++FJhew8FlK7XIXTmj+Enh
 KQGn7Mz7pWIFuM0PU9KhXDvL2J2NKnXljq1yVW2mok7ZQCxzIw1a8OnG2ua5jC/hine+eCOopO5
 lGejGQMGussxPINrRMwSI0JKl9+ikufSc24PaxvoIf3tqgqL5ToUNlA0byiMPdkuDjt5SzE8NQw
 V7s++GnqrkYBoMb5yjr6+LfSVgRWGAXvDM6SzmXjy6UI3KX9FsWNxjYtxTLGzvBmqWUB1iRwQul
 SBI5SN6+KMLgyi6sitxK/8BY7cUwHFaH6MAUC1W36WAHiqP/5gUgbG7P0kvCAfMVQhCOtXGUN9o
 WU1/Ib4FkHzWIuMnLNS77ImL5kjgT1VKwkhT18hIEUmhfH5gy2ISzOD0mHV9xhyR/7A+TptTZEh
 VpX5OSoG26TolQdYbdexzlBdWT2eYpeepbSEzNqcvVKwmSRVNrheIeiwr3JMqTiGcHvLuaG8Kby
 tsxx2VjhvbjuyRhB7KZtHquxA2M6YAYHk7t/xTohzT+4Z5lRaiQ/R0IkmvrQ6Ph9qYWiHevzIr6
 ALWLa02Zs/mG6XyvdmA4jUpolpYZPhdv8C1fhsy6MvH/eOb3GKcXy4YdLJczUzsk+BNu78ISCv8
 nQ3uWO2t0nceVcQ==
X-Developer-Key: i=casey.connolly@linaro.org; a=openpgp;
 fpr=83B24DA7FE145076BC38BB250CD904EB673A7C47

Unloading and reloading the driver (e.g. when built as a module)
currently leads to errors trying to enable wake IRQ since it's already
enabled.

Use devm to manage this for us so it correctly gets disabled when
removing the driver.

Additionally, call device_init_wakeup() so that charger attach/remove
will trigger a wakeup by default.

Fixes: 8648aeb5d7b7 ("power: supply: add Qualcomm PMI8998 SMB2 Charger driver")
Signed-off-by: Casey Connolly <casey.connolly@linaro.org>
---
 drivers/power/supply/qcom_pmi8998_charger.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/power/supply/qcom_pmi8998_charger.c b/drivers/power/supply/qcom_pmi8998_charger.c
index c2f8f2e24398316ac5c491eaaabe4c455e875c47..cd3cb473c70dd1c289cc4094e74746e3c6dc16ee 100644
--- a/drivers/power/supply/qcom_pmi8998_charger.c
+++ b/drivers/power/supply/qcom_pmi8998_charger.c
@@ -1015,9 +1015,11 @@ static int smb2_probe(struct platform_device *pdev)
 	rc = smb2_init_irq(chip, &irq, "wdog-bark", smb2_handle_wdog_bark);
 	if (rc < 0)
 		return rc;
 
-	rc = dev_pm_set_wake_irq(chip->dev, chip->cable_irq);
+	devm_device_init_wakeup(chip->dev);
+
+	rc = devm_pm_set_wake_irq(chip->dev, chip->cable_irq);
 	if (rc < 0)
 		return dev_err_probe(chip->dev, rc, "Couldn't set wake irq\n");
 
 	platform_set_drvdata(pdev, chip);

-- 
2.49.0


