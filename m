Return-Path: <linux-kernel+bounces-809976-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C654FB51431
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 12:44:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 802A34E3148
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 10:44:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76E3930DEB0;
	Wed, 10 Sep 2025 10:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SLcMzggF"
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9DA42C159A
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 10:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757501056; cv=none; b=rr6uDphQUhS+6Aa5sPaGAmu/W9E+eiAC1IBU0nUhg7isOdZtvMgyPv2hPnCuQNSTBh/khgYb+ye0/xeabdP0I8qRngRAWa5T3qxlh4taFdFIDAPnNBOGEFJrwjW8B3A7TQf3w1hd28r0lmzIBL4+gv/T+D1OvHMVp+umq81ieT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757501056; c=relaxed/simple;
	bh=YZxvDIdDmY/3wxxRt0NldmRCMJltF2rY8Dt82GASgFM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=D9VKdGlSp+sGEW9kiafYFpk0rkN/L8h5DXHWLPVL8jC+iYIEcrZlhiyoTW0l7339OMTfq4GtE6OjTDDeb9Xo7RL682SYoME6EpkSHlqNtYoNtpmKBlQ8VJsNY+4DKWTfAas000t9tUIPgluHWb10X6IAgxaelmNwZUyL22kSPSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=SLcMzggF; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-61d1fe6f160so1343442a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 03:44:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757501053; x=1758105853; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=C/Qjry/G+jx8lqtwVy7XKrhJZHtvYwgGNx73zxEK2OU=;
        b=SLcMzggFsN0iR9lxTRmP/2s65nrVyl5WjbPw+GFo/Kr5B9bP/AUDbpWgxXfAELkUJj
         o2Y3yqfU9SNsjxFhS1sJydxN3U/l4lBRhh+cy07ZWj56hWP2ZUcNJnKIVkuD/3vg2Mja
         PDYg+rYfgi6zund0kQ4M7cZc7ntQmrJFXLzFGwrGMEz9N9er+R2GcGohRf9Juw3s5ugG
         kXaHY69UwHAFX9Pq4KYujJEYCP0QOhwpoLK70TuxHE9xEzcJY/UkXOtiWEwVxXbKas07
         GhRL66716hCHK3/gEFeYCwqn525n82DJGrT3Ye+UW1I5AS27S9M8GkdlMWCk+cDtNy8Y
         SEWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757501053; x=1758105853;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=C/Qjry/G+jx8lqtwVy7XKrhJZHtvYwgGNx73zxEK2OU=;
        b=oLa46SqADkp7hRxBh6tUt+cwSNBPcWpNVP9I76wQIHYUXyNyjrkS869wQW/OJOAh9j
         0RRM3T8g+kdR9juKr+a2Bzhvj2lIG//tmg0Ma0HTRbHUjdynLPRlkLirJYaVZoS0rl/E
         6OUnJ9nNpvpA/djFmEMiHJq1E7QwmkiXYRgLkeBSQZDd/+H9cFJjo4Ko1FJcFY9QvCG2
         3YBp1HViVX7+zCg5fFajhrxpmJKs3F9i0sVDzHsz9CzEW9QBpi2ZGzqZGsE+Cxxw+Jlc
         rpihyQVKLEYCHL835yPJRcPfQyXu81mID1q90w3N1R216As/zZRSSawky/1kxGZaahPl
         fUWw==
X-Gm-Message-State: AOJu0Yx8nP9IrkHAVnBCstyTigHZnMHODxJ5Hyh3mng46QI4E+2jBkfS
	40Ii2IVyJxZSv580PtS7Jlswf1mrysTutLiedVtAMOsMRMEtNB1bM6etbjhgyFGi6wM=
X-Gm-Gg: ASbGncutStQOWAUSnsjkrShDoPDk3I7IrL4+REMZr7OFZ9+qKbC/774+2pW7zIFLvHL
	agw4nK0MXq5vwBkjm1Q5giUgQ91eyzZ8VBSlMoRkrhplkgqu0NgMFxQKGT2NiGbm8toVno2tc9i
	88bqvT+o1mwx3ntOsFqvbsQ+TsCad8uH0NMxLzxUBqr5CUMGbCJ6KeLrrKBfLqFdIrkX0W53lvG
	2symL+EKOW1r6GwdkDJPZgwRujtN1ZBBef5ddWje5VQH9NSFnWx1E39Xa+l6aG12TMU2MPafpPm
	RBOZTjOMbljlPgQXOZmvHngW+MsILD6HCVn9wM6lJLe77Ug3Y8fNTlFIUTHbhcd5jnBWnHO+yWH
	GkG2ieo5XRQ6kiM/jfbQ26T6bgPe4PNOO6bAJJR0=
X-Google-Smtp-Source: AGHT+IERk52gGCs3n+Z3B8VRz2Pi8NLtvk77MiGr+3goAnlVYOxa6u6adOOxLhuUzAHo0UCVOp8sVQ==
X-Received: by 2002:a05:6402:358f:b0:628:28ee:942 with SMTP id 4fb4d7f45d1cf-62828ee0affmr5454092a12.4.1757501052935;
        Wed, 10 Sep 2025 03:44:12 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.219.123])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-62c01ae5f75sm3144890a12.46.2025.09.10.03.44.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Sep 2025 03:44:11 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 00/13] memory: tegra: Several cleanups
Date: Wed, 10 Sep 2025 12:43:56 +0200
Message-Id: <20250910-memory-tegra-cleanup-v1-0-023c33a2d997@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGxWwWgC/x3MwQpAQBCA4VfRnE3tEuFV5DAYTLE0i0je3eb4H
 f7/Ac8q7KGKHlA+xcvqAmwcQTeRGxmlD4bEJJkprcGFl1Vv3HlUwm5mcseGtiXTZ0ORt5RCSDf
 lQa5/Wzfv+wEv03+sZgAAAA==
X-Change-ID: 20250910-memory-tegra-cleanup-1ba0d5f86ba3
To: Krzysztof Kozlowski <krzk@kernel.org>, 
 Thierry Reding <thierry.reding@gmail.com>, 
 Jonathan Hunter <jonathanh@nvidia.com>
Cc: linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org, 
 Aaron Kling <webgeek1234@gmail.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1671;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=YZxvDIdDmY/3wxxRt0NldmRCMJltF2rY8Dt82GASgFM=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBowVZuUVkFXe7gVcwAH9KeTVa2HVPVE407M13tn
 a5vjctr+u+JAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaMFWbgAKCRDBN2bmhouD
 10ItD/4lrQLY0Pk6xsuHa6nY1eY8cSuEpFxxCdwano2xVA/V2xublblvXIk/HDzm6E/SGCqnSi0
 T7j943THyR5qMjgiD2Er5DzLlkx1eF5JXx15djOcaBhxv/3pKqBuDccjbuXpweNWmfjYZ0ruFfc
 aaIEz0ReAoCclxAFUsAsYrehasRtK+SB4JCH5cntboGaWPOG8W8KPg0vKVIAbQ7LEYgkSGP4jZh
 hN5XLeLDAC6yBhAG29raJOqlRIS3Wc28/tv+gA1EaahtIFRwVr4FrD08yvA0KvR+sXxucqvvxZx
 gEwHRy0QAo20UnqbcE+vL8SnNnJK5n3r2fKI2Gt2pQ8TSiWh5KcVD6/VAmpIXxkpN+ezZHd1Ian
 bDLtF0v8Gbhzhtp7n2mgDSYBzIAwMHEyma7XycSbnDccnRADXQDorSzl2e1pxSLxYFbIhuYckr8
 G/k65Qh6yyklmop+n28IYkDV1qH43iPJf/tkxmgJWilgkyVSIBN6rj6CX9jGHTj5ui/6EA5VBs1
 J+n3XP83wj9bGt9mU/p0HN5sKQoLfpaI68GnCqnPNSGNfCM2zvZpabT7wDPvUWY8VELyc2cEgLG
 ftwXYEUqWhTBKbpJdN+h9ob8yJBuFxaC1peKpw1W0dfinLJRsBIt7bBGBmxHqiTV0NeYRwNHkh3
 BoWVqwVcrOlrJ5Q==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Few cleanups for Tegra MC/EMC drivers:
Deferred probe, few simplifyings and function name unification.

Best regards,
Krzysztof

---
Krzysztof Kozlowski (13):
      memory: tegra124-emc: Simplify return of emc_init()
      memory: tegra124-emc: Do not print error on icc_node_create() failure
      memory: tegra186-emc: Do not print error on icc_node_create() failure
      memory: tegra20-emc: Do not print error on icc_node_create() failure
      memory: tegra30-emc: Do not print error on icc_node_create() failure
      memory: tegra30-emc: Simplify and handle deferred probe with dev_err_probe()
      memory: tegra20-emc: Simplify and handle deferred probe with dev_err_probe()
      memory: tegra186-emc: Simplify and handle deferred probe with dev_err_probe()
      memory: tegra124-emc: Simplify and handle deferred probe with dev_err_probe()
      memory: tegra124-emc: Add the SoC model prefix to functions
      memory: tegra186-emc: Add the SoC model prefix to functions
      memory: tegra20-emc: Add the SoC model prefix to functions
      memory: tegra30-emc: Add the SoC model prefix to functions

 drivers/memory/tegra/tegra124-emc.c | 140 +++++++++++++++------------------
 drivers/memory/tegra/tegra186-emc.c |  39 ++++------
 drivers/memory/tegra/tegra20-emc.c  | 150 +++++++++++++++++-------------------
 drivers/memory/tegra/tegra30-emc.c  | 119 +++++++++++++---------------
 4 files changed, 207 insertions(+), 241 deletions(-)
---
base-commit: 65dd046ef55861190ecde44c6d9fcde54b9fb77d
change-id: 20250910-memory-tegra-cleanup-1ba0d5f86ba3

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


