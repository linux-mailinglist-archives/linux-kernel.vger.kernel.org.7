Return-Path: <linux-kernel+bounces-729113-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B6041B031F0
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Jul 2025 18:00:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 297B93B4B47
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Jul 2025 15:59:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4A0D7D07D;
	Sun, 13 Jul 2025 16:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="apHS9M+2"
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6897027F4D5
	for <linux-kernel@vger.kernel.org>; Sun, 13 Jul 2025 16:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752422405; cv=none; b=Q2TTMzrYWt+hjTdnIXkdvlZ+386v3R/85sQ+HMZl0Ge4fRdS6tUJytSMRUVu0OkeaFpOrfFY7c5ETGSeLWzh93C6AdJj2gFwmM6asD5YYpBh/V7x7ocTe78uoy8nrsuQmfvThBKAyowBem7PdGsVR4Cn0VmyOQZuIoMi7gsF9+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752422405; c=relaxed/simple;
	bh=RNZM7VeiSwJuf1WuWy49f5M7lHoQJIMon8g4vnZ5KpY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=kdz+fzl8X+VgR32KGO56iBt/DVe9KPxSkVZI033ouYWXTyXQSIaDG4Ggpl9qORy3H4gbAnT2LaJTqEmJaTbDdeIlxcImihzzVnZb4B9FJ8sQE+9miQHtQpOZwABD/Uq06cfjUB9gVgtG6yyxBVfbOjaN0UjsEilGlBpWjHJ8PlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=apHS9M+2; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3a4e749d7b2so511105f8f.0
        for <linux-kernel@vger.kernel.org>; Sun, 13 Jul 2025 09:00:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1752422402; x=1753027202; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vKkQ/ZqJDOz7LPkwRdAo8RGpwjZ41PyPdFDVt4/XaZs=;
        b=apHS9M+20pNvlxb9eMqiI2zbKEGuOZ1gRPJd6RB/L9nvPhdnulpyr5afVHIpEOoQiW
         n1zVYmIQ8UoEa84r5lvnpXVtAyI+KIrxEz5xYb+WznZnm32phNJOV60++VJcJZmTL3k7
         /V1iI8gm6oiZZtwYMCCgbgQuoR3JIF4YMRVT2N7pJapjtZfzoUl/7Tp4wwdLq0iLPV4Z
         z967WDoyn1ZpDEP71tLSVR0mTakSh8+UhGEQFqUQ8JqfcWAVP7LKYjr1fE97Aqc6LG7Q
         kYRxcYfxkD4zkE+BkEmW9g5DLywTus60hb1Ds0R/BV2MGmXRAbi6ZKI8oFiyBeeU/Yu1
         +mwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752422402; x=1753027202;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vKkQ/ZqJDOz7LPkwRdAo8RGpwjZ41PyPdFDVt4/XaZs=;
        b=wIQtk9pDGI6G7ruJqspwIBusKcCGowloVFu7OW00iLY+1cOFncsTOBFXT75x3rnWC+
         GaBg/ZDiGmRopha9pgHDnq51HOGM4Rfd84pZ1aMvzGBUKzzUo0PHngq8cM7+pyprAnu7
         VjiAMYXx1jo8uiIc+0+UFbjbX+tQ8qoxYhaTObtpFLfaqS8DGED3z/DZj51eady+zLOG
         L7j3BoB0WdAH+gnptDjW/cZgEbjg1PXk3Dg59DRmSvY1xZ9ECZxqE6Qt4XsUEhQ5nX29
         1HtXHaYDfAqfgz5YP/0bS+WwK5Io+wqaualelcjrgcdVzPMXT8gfzpEz2CnK0yNb8y/f
         iKcA==
X-Forwarded-Encrypted: i=1; AJvYcCV2HD5sV0mtcaK3M26HzY166/ETCOerPHHwTOCVdlixYmAsLNTKFWK6zazGBpdRtrKsANlP1IR7Z0hZ7rk=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywqm1MWXWpma8TLV+pO/+4eLWCTBjP0zbEdHA3UFkaA5+1xkYdC
	Fe4DIPvWe8FxmpaZoLWcG1VJm5wikBiCf9vqUzCP8zKe/FWAPyiRzkQyffeUIcVT7Y2RhhstYFF
	4eSzs
X-Gm-Gg: ASbGnculYA/IH0k9KYjtvxzSEwQWA2q91gjZH6M9ifIi6EKwGo6ZGCf1Go0tmGtDAg1
	PRrS9etX7lppm9MofkyBEsDXKZ/ywMIjWdtKDW+XBh+QIM09ZDkhbeWWmLP/r81zurWNzi+mXDG
	r8tXd9VfvWBaGKfUDOEJG6fFqQy7MWmmDOjizu87ZRkLrt3t2VL5gnxLXJG8uH4WxWdCEXzR4Rq
	9NvlpQA4bG2i6xYPWmeL9PVGst2dUA9RvvLshNTpIlD0jvm1u0lq5hygVmIeBYARkpgzy7FaAZz
	HYhb3yz3qSHpjypI0IqSlz+NDPPLiToL2IZun1Btj33RiB0b0Pv4ZSfKHcXJplCbcePYJ7OQHWT
	H6PybIbIRljIvL8S+t0/+Ljo+hv19uXqhoqmX
X-Google-Smtp-Source: AGHT+IH78NCUlzVjgglGHThnEAS1j66jKtmv3BfBRuSfPf9oa5qyEFqDD7AlIw7uaMlRAnUpKpJF7Q==
X-Received: by 2002:a05:6000:430a:b0:3a4:dbdf:7152 with SMTP id ffacd0b85a97d-3b5f2e45924mr2722298f8f.14.1752422401675;
        Sun, 13 Jul 2025 09:00:01 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.222.89])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b5e8dc23cfsm10244123f8f.37.2025.07.13.09.00.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Jul 2025 09:00:01 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 0/4] iio: Few cleanups to vf610 and ti-adc12138
Date: Sun, 13 Jul 2025 17:59:54 +0200
Message-Id: <20250713-iio-clk-get-enabled-v1-0-70abc1f9ce6c@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPrXc2gC/x3MQQqAIBBA0avErBtIs5KuEi3KxhoSDY0IorsnL
 d/i/wcSRaYEffFApIsTB58hygLMNvmVkJdskJVsqk7UyBzQuB1XOpH8NDtaUHWtUloabW0NuTw
 iWb7/6zC+7wffaXsNZQAAAA==
X-Change-ID: 20250713-iio-clk-get-enabled-4764482c8ff3
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=767;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=RNZM7VeiSwJuf1WuWy49f5M7lHoQJIMon8g4vnZ5KpY=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBoc9f8v8yLMk2vBXgG1Tj0AT6qGXDzTlR5fo1RF
 5gjZSjUj5CJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaHPX/AAKCRDBN2bmhouD
 18EZD/wIW/wgLIgyWy/YLErgNmhID0SdIWiATp+qMtjml/jCl6IsPp52oBM1Uwyk5wUPkDddL/Y
 6nktnZgskh/9XD6fKNmvHJujDgVewueutwoCFt2Zzm36+YlSHbt+rqVEpsD5b9xNcoJZkhUydnA
 5bFdse3dy/UKpT9vH1QxmPLE6zQFlq4S5CRvEC8rIXtUIPsqBt+WkpDSlinfc4fgeXhdPMVdJKs
 hCsvzYoOQBf9PK4CmpDUyys9Izb5CKAEhSmmmTAsXeFl96V7CvPH+IGwpqIdbNpAuAcO191n8VN
 k4yb36EJm+ToiEZp7Cbi9xokQjTsAX6U+9hkJfld6wOAzBg4+8cxZSbU7q0s2CeDaFh475Ywg10
 J9l6qRF53etJCt6/iGza6wxxfKsf3ZCeEJ41DIdFsyEgrHeCklYS9mr2KcSl+3rb9tX3GnqY6cV
 3bkIRCnmfmAxyGCchSEXfNBvvTOpAiXGjkPtSWCbZ+LsMEAnCNY/nQxpQBHm2Adztidn024b8Jt
 m03uvxvIa6njYZE+89AI7lD5umAaZyoSHkXI6QPxvXPGfexlhrtgOnTnWQikVjx+Gb1RMCF25Lv
 vJc1JsSOOl5E72YucWKxy4dMThT248xuvO+FkGaiFj8uSFNJycaRTFrBy7IbHEoTKMV8L6to74O
 +QYnF8IugQI7EuQ==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Just few cleanups.  Not tested on hardware.  Only the first patch could
have an observable effect.

Best regards,
Krzysztof

---
Krzysztof Kozlowski (4):
      iio: adc: ti-adc12138: Simplify with devm_clk_get_enabled()
      iio: adc: vf610: Drop -ENOMEM error message
      iio: adc: vf610: Simplify with dev_err_probe
      iio: dac: vf610: Simplify with devm_clk_get_enabled()

 drivers/iio/adc/ti-adc12138.c | 30 +++++++++++-------------------
 drivers/iio/dac/vf610_dac.c   | 23 +++++------------------
 2 files changed, 16 insertions(+), 37 deletions(-)
---
base-commit: a62b7a37e6fcf4a675b1548e7c168b96ec836442
change-id: 20250713-iio-clk-get-enabled-4764482c8ff3

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


