Return-Path: <linux-kernel+bounces-775638-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18B3BB2C2C4
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 14:10:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0685116ED50
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 12:10:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D521E338F43;
	Tue, 19 Aug 2025 12:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jRYXn19Z"
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 760FC33470D
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 12:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755605435; cv=none; b=TDAAc8SIfICkdOx5IACInc+KfgnocoGP+olbrzaV+u4SPFc0qJFmca19Ie8fbbOp3EE3t6yUi+QHCAiadSB+ExDdQeNOOpj0b6JECJ8wgMXkbFuUn0/1LwzMH8PuEkKX5oWv50DtwUJsnddmv8FqiMJXU05/YoKdspC7RjD74Ug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755605435; c=relaxed/simple;
	bh=ea6fVOF/ZPzXpkLEtEhf8jo7+yKf1XzprUPMMimndVQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jimjLCAo73jKyJzMkgIzJu9aE1+1fZFVQl9Z+7S0IsiclNlyBd9/XkEZH9Aodefwn42vYNvfemTqmuXTcIksOfsjXmaa+2vTwhJN4RIpuAAdbQZMndj5jcmG5tGz1CYsH+rq4ln+szvPLkEohg09xkHqNg4MB+rmpnAAodpQco4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=jRYXn19Z; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3b9d41bea3cso5539732f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 05:10:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755605431; x=1756210231; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=y+5g381r0R3Gly5+53b/VNyTXs/xlV7IGrG5ZNJb+xs=;
        b=jRYXn19ZzlkV2bwhxXB8QX7ZNnQpTUjZ118y5dbac+8Nt5x+3NU4zBu+ifUNeBU253
         kY9GBf6OarjC025s4PnAhDBoV68XmHcZlCwXKkQUR/L9Q51CAmcUIWFidcwfBmhw1ErZ
         orcHCWvZl57f2xvnWp4PtHY5qV2j0JOSV7k1OpQeUUFDeX/OENmUiwuYMxFfNtJQNyyG
         KUvRd7lG4dkuXYHM1ybumPOcTvqYF7MSFwrxRxi4UptPPHTy1z3I1u780NczpNd8mVoe
         ld1fWFeaZkb8EzcbKq57l138VFouGs1b9YnDwsrqk5h5YEIM93MM2iWJSUcnN2xkjukH
         wcgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755605431; x=1756210231;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y+5g381r0R3Gly5+53b/VNyTXs/xlV7IGrG5ZNJb+xs=;
        b=t0c2iFqKgtYfud3jyT9CvGyuB/ExkAyrE8KPR+LQguIwmHRtI1FhqQzRY1LzhBUzcG
         9v7i5F3rzfWgptpxWlXtKSyxPtyNNdcCdR6Z7KPmiSXvn+8P6C5CdROSFBvKza7eGjW6
         +3OqUHIRU/LMTr+OQJQXYG3PrahjBoIy1RZmd85yoISW+63QNZVm1aAF0C1ACcUUfyel
         ube7MrnWYicEdj1zWIpbNqkyBwn02+zgKklUy1CoBacT0dRfZ7ApifwqMSgPBYdoXhum
         M7w4bpYRo+2ZkR1dw8+bCHtytb7cAEWKojlxQqpFlbCWNZ5VgDFZU4PAoGJM6DOD5AF5
         m+qg==
X-Forwarded-Encrypted: i=1; AJvYcCU9fiX5L7UQd0r0GCpaBlor3EfJelNA/CRpn0gJuqgJtFssj4KLzrcA3MipN6Rr+ISoc1ofOqbzYPvTqhU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXpX/R53YZlV0vmTr5PwO43/y6cP/WbP7ggGWkAL/wHCPXLe3t
	28aaZU6lRjGcS8GFro1pSroFITcmu4CPZEAdSRhpokKcVQz960nU2JUr655Qo7KZDs4=
X-Gm-Gg: ASbGncvMOnkBrG5cWtltagEsFEal373IP2Wc96uyvbQMDRt2HyDXJ/paviS4fj5eL9N
	TcsY/D0p6siqHD67pEYSZbfk4t4vIsU0exnRc9FWyCZDc93ENK6sNCz6KaUDtVcAc9JynzLqBHY
	ovVjZtcVpzR+ZRNjEn8Pa7UIMBE4xPCYtjihqEhjIzDk12LHnbERFHqwGiO5lxX0z2JlobdfL/B
	apt08s2Rz9X4p3nQehH/k/rK7On0SLRRhVzu8dtA+MX92xG+QVnLTF1iVfig8Yo6oVdWB8hyjv9
	hbOaPxtiLB+prcQhOOKJEPMUU/gUCWzNplDg52y6/FXDJ72ghoOFRClBk+JaoYAeVm5ASCU2KIN
	s/ySK/Hgty66JqkVkGl5D1BOxvtXWOgO+KkVPWVuWaXtG4RFaPPnqLof89N5E3m29/y7dwDSLVB
	lGRkKlG8OKed7z
X-Google-Smtp-Source: AGHT+IFYmaZOIht6uOcy+7NKASZVqnp8ZAoXpwst8L2cyhAy9sor5s+Io2mLr0orWTwidMknZOnrlQ==
X-Received: by 2002:a05:6000:26cf:b0:3b9:10ed:e6eb with SMTP id ffacd0b85a97d-3c0ea3cf076mr1856861f8f.8.1755605430698;
        Tue, 19 Aug 2025 05:10:30 -0700 (PDT)
Received: from ta2.c.googlers.com (245.92.187.35.bc.googleusercontent.com. [35.187.92.245])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3c074d43b9asm3464410f8f.24.2025.08.19.05.10.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Aug 2025 05:10:30 -0700 (PDT)
From: Tudor Ambarus <tudor.ambarus@linaro.org>
Date: Tue, 19 Aug 2025 12:10:20 +0000
Subject: [PATCH 1/3] arm64: dts: exynos: gs101: add
 google,gs101-acpm-dvfs-clocks
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250819-acpm-dvfs-dt-v1-1-4e38b95408c4@linaro.org>
References: <20250819-acpm-dvfs-dt-v1-0-4e38b95408c4@linaro.org>
In-Reply-To: <20250819-acpm-dvfs-dt-v1-0-4e38b95408c4@linaro.org>
To: Peter Griffin <peter.griffin@linaro.org>, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Alim Akhtar <alim.akhtar@samsung.com>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 willmcvicker@google.com, kernel-team@android.com, 
 Tudor Ambarus <tudor.ambarus@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1755605429; l=844;
 i=tudor.ambarus@linaro.org; s=20241212; h=from:subject:message-id;
 bh=ea6fVOF/ZPzXpkLEtEhf8jo7+yKf1XzprUPMMimndVQ=;
 b=8NbHtnuer4XrqcxrU770zSH39wnsQWVoGXwzK2B/dmhKJyngAV87tT11N+xcYhCnrDVYTi6as
 xZEWhZ3g+nSDl9nwr+EDjC5c1libRfq5lZFXoXinj4P0CMBBy7et+BJ
X-Developer-Key: i=tudor.ambarus@linaro.org; a=ed25519;
 pk=uQzE0NXo3dIjeowMTOPCpIiPHEz12IA/MbyzrZVh9WI=

Define the clocks exposed by the ACPM interface.

Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
---
 arch/arm64/boot/dts/exynos/google/gs101.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/boot/dts/exynos/google/gs101.dtsi b/arch/arm64/boot/dts/exynos/google/gs101.dtsi
index c0f8c25861a9ddb5bbd256b62c66a645922ca74e..d010b8ffc4e09562519d6796691fe573c68b7ac7 100644
--- a/arch/arm64/boot/dts/exynos/google/gs101.dtsi
+++ b/arch/arm64/boot/dts/exynos/google/gs101.dtsi
@@ -204,6 +204,11 @@ acpm_ipc: power-management {
 			compatible = "google,gs101-acpm-ipc";
 			mboxes = <&ap2apm_mailbox>;
 			shmem = <&apm_sram>;
+
+			acpm_dvfs_clocks: clocks {
+				compatible = "google,gs101-acpm-dvfs-clocks";
+				#clock-cells = <1>;
+			};
 		};
 	};
 

-- 
2.51.0.rc1.167.g924127e9c0-goog


