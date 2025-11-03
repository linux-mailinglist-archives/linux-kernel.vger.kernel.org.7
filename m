Return-Path: <linux-kernel+bounces-882446-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9279C2A80C
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 09:11:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4543C3AD16B
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 08:03:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 723682D8398;
	Mon,  3 Nov 2025 08:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fpQ+G/iF"
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22D7F2D7397
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 08:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762157000; cv=none; b=HPh0T48mK6W8fL8iKWdno/e16L/f4B+uoghglq5bh0n4lE/D3PSsfJkiAcFpY2EVH/BQdTudvI3wiVIag/nWv98lvHNNQt1IObyaY6/XSf7nw8GnLtG8rU9tCwKu+wI1xYU6WR2pJUMKRTzJ8Sdembh/ISLlfqjc7WNP3x04rwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762157000; c=relaxed/simple;
	bh=UGPgjULdS+we3HJqc3I3soms/UG6+af7wQFeI8hNCdo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=I6FEHpXVDGNSUFCDoXfRS01FKlunHgijE0QNzZk49kogi+ZknN7ih3kkTHxyjEz8SMyfr4n7WlJihuyyj8mbCTKU6k9PkQDH8+lwrrxwc2QXRUZt2ZHIF4+Wlhh4ypW/dwxJriK66APV2Jq6Azh02vUxxFd87gCA+8pmU4SImXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=fpQ+G/iF; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-429cf861327so736349f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 03 Nov 2025 00:03:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1762156997; x=1762761797; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=H26VIwt+agnnRoIUvWCQXs/2JOF56AwXUHjfpfr4mpA=;
        b=fpQ+G/iF5/F99ya+dF03RyzCqd0Qg0fgiQTzCPfVh2VcHkhNeBz1qYeKccutr70RSH
         ZSEMEFAIzDrWIY7D/PWP+1YrETaRq5cNc+I5ufki1mD22uLA/OHuOYp640aLb4u5DtFX
         AHjqqJ8hpnlKFNMmOO/5I82/GUJx5zXBWAbwBPxgDAKhi3o1frPr1OVYLTmBBu44f82h
         9g3DSc6VhF1/08rumJXTrrJgbdIuClh9LrJkyULv27DCoEu6+Af5DptitsUOrc1WwmHw
         h1FRHmpMuGorhSduD6t8u0wh5fA38wFz2+KZlHIYciqrwrCPbR+SMHTczs+QT/DJTs2U
         wCvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762156997; x=1762761797;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H26VIwt+agnnRoIUvWCQXs/2JOF56AwXUHjfpfr4mpA=;
        b=DkAUcIKGPhTLqD8Nk3DLRrZwE4Py1ueho4aUxs+FlBpp0mZjQ3BbAV+vJdDw+IZi/J
         XcZjMkK6W7X0YUP5fGcOjn0zbp54qbTT0nahBMctz8++MhOGLlzZyelWXF53KSxdj2p9
         U7UjmO865yrJv4ltukKV3QDP/sQlitHQqJCF6vHu2EWipBqqZyhT6Kc+seE43IO3saUX
         C1BvyzVjVb3anQlQWhaklYHg0HKc/lmSfLaHtx2ko0xTxhANrVeUSHmZ05U5QN/KIWmR
         eVZTa9L+XVPi1qghlskc3JUL4Nh9z5QxkX9Nre60yg1QwLzDwXNu0bAPdsBKynTBT57/
         sUMA==
X-Forwarded-Encrypted: i=1; AJvYcCW4yM0QPFgmRKgVabukj6IZ2QWQcWLh68NCkHTMOTC+TxCvjZF7Q0mlbhaXxlvX/bw1nRAa44YL0+ebtv4=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywcn2hF1olmpTRVZxNZ+HksDrBc6gNco4wr7JVwSfX/3FaIaBXb
	UPAhci9yNmguLdlnf4x/Kxcixd2pFooQG9cBqklyFZAlqDceAFJC93kRsmgFsOU3iM8=
X-Gm-Gg: ASbGncvqO3xGu6mQBbOR4dVmzoNblbl3gPMagzpEvl+SMyA/Z0whbqx5WD+LDcEFLIf
	j9w7e897+Ib7okUBN7vqIgO8jHbUcOFeUHilx1JHExeZe3S7LZnQmw1qXh6Py0SUQvfUUsKrdLK
	M8qoVHogEPmuIWIWfrMie2Tt1bGuvpN62pLlcrOUAaEDCVofI3K5Zt1Hwr786Vypj9mh2TTeDB5
	YeF20NgDI/A54uOie9DVl4w37eD9ziPyxNOXYgTjxRMMgpHdRB+HVUUNU3wQnbQqchN2sXoN++X
	XUk6wTN+s61To9hUJexVoKC781eKvi4Pu1Cy6cMbPwip902oMxnOteQaXO5llNflArVH6gBLYT2
	VJnrKofjcBx6eVCev3kU14RtumCVYbzanib8f8v78Y/B+50sOFb50zBBa0nKNc7gR6ERlV9mCb7
	9AfFvhQZUW2TI7iQF7vJJZ3sK2w9MA5hI=
X-Google-Smtp-Source: AGHT+IGNz9UjeIUIyTmrdpy1PxW7eeOvbLMlDXLQPjJMq+zpapydUSIPBZjaS+Vh5y+ecN3Jkbp6Fw==
X-Received: by 2002:a05:6000:2501:b0:429:ca7f:8d72 with SMTP id ffacd0b85a97d-429ca7f903emr4511698f8f.23.1762156997401;
        Mon, 03 Nov 2025 00:03:17 -0800 (PST)
Received: from gpeter-l.roam.corp.google.com ([145.224.65.248])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4773c4ac5d6sm142336215e9.8.2025.11.03.00.03.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Nov 2025 00:03:17 -0800 (PST)
From: Peter Griffin <peter.griffin@linaro.org>
Date: Mon, 03 Nov 2025 08:03:11 +0000
Subject: [PATCH 2/2] arm64: dts: exynos: gs101: remove syscon compatible
 from pmu node
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251103-remove-pmu-syscon-compat-v1-2-f2cb7f9ade6f@linaro.org>
References: <20251103-remove-pmu-syscon-compat-v1-0-f2cb7f9ade6f@linaro.org>
In-Reply-To: <20251103-remove-pmu-syscon-compat-v1-0-f2cb7f9ade6f@linaro.org>
To: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>, 
 Tudor Ambarus <tudor.ambarus@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Alim Akhtar <alim.akhtar@samsung.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 dan.carpenter@linaro.org, kernel-team@android.com, willmcvicker@google.com, 
 dan.carpenter@linaro.org, arnd@arndb.de, robh@kernel.org, 
 Peter Griffin <peter.griffin@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1645;
 i=peter.griffin@linaro.org; h=from:subject:message-id;
 bh=UGPgjULdS+we3HJqc3I3soms/UG6+af7wQFeI8hNCdo=;
 b=owEBbQKS/ZANAwAKAc7ouNYCNHK6AcsmYgBpCGHBKP/enJRrOYHc08VISfExyYfUCOIHP/hNH
 NbGGlSpBV6JAjMEAAEKAB0WIQQO/I5vVXh1DVa1SfzO6LjWAjRyugUCaQhhwQAKCRDO6LjWAjRy
 uiiWD/97FQHrIvR7Ad+ObGfq9pO2VhDQDunpWCIekHI474m6k3nUj2ags+XEydrybbUAlBAJS5S
 si656ToMn2SK+oYw+BO2niz2Pnh58THEqnm5FlS9Q1Fw0RJgiyFaPhfWKR0dR6MTPrso9RSjEEc
 wx+vGME5loVJgJHMvBwdrtyy/L6m7g7TV4OWB8DBuExigkqdQLacipDGXbONDP/j5mMrEDQ2Vdo
 Ga30F3f/pW5rr5mVrtVHEjzV4+Z1UVsfJw5L4qUeyZY7/Mh0HAMQ1sh0jixf8UUkUTrQhlOyv4u
 Z4Lq8D5GirrHGhFoNmC/X1GlxGSlhc1ltUzAyyMhQ7rolomG4gsBqPY5XwwOLcN6sokE184lhJT
 i/lw0r6FicCx76Sh2r0Kno9sFUpPl7pibEXgKfeSCT76z3wnN685iKmTZvdbUI/LRFzxITlhtXe
 2vMgFIbxfimbqKqCI1F53ty/eBHVvbqsJ9YZbDplSLYkFOXXzmztRZ5HG9rg6y6HYDCMMUWi9mo
 UPmWmJT9SbbjnVgz1L0S+rd2mExb8FEZZ4opckU9JwoX36t+3qjTkxLcrXpln64RGdoGpBnRJpk
 6UAIy+QaOQt91LDA3BGDxPC1+yu3UKgv5FjICgKUkKCPNo/bun1F5f2T7XLSD0s4Fkg57+Qz4eY
 GbB0Tw4cdgP5DSg==
X-Developer-Key: i=peter.griffin@linaro.org; a=openpgp;
 fpr=0EFC8E6F5578750D56B549FCCEE8B8D6023472BA

Since commit ba5095ebbc7a ("mfd: syscon: Allow syscon nodes without a
"syscon" compatible") it is possible to register a regmap without the
syscon compatible in the node.

As mentioned in that commit, it's not correct to claim we are compatible
with syscon, as a MMIO regmap created by syscon won't work. Removing the
syscon compatible means syscon driver won't ever create a mmio regmap.

Note this isn't usually an issue today as exynos-pmu runs at an early
initcall so the custom regmap will have been registered first. However
changes proposed in [1] will bring -EPROBE_DEFER support to syscon allowing
this mechanism to be more robust, especially in highly modularized systems.

Technically this is a ABI break but no other platforms are affected.

Link: https://lore.kernel.org/lkml/aQdHmrchkmOr34r3@stanley.mountain/ [1]
Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
---
 arch/arm64/boot/dts/exynos/google/gs101.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/exynos/google/gs101.dtsi b/arch/arm64/boot/dts/exynos/google/gs101.dtsi
index d06d1d05f36408137a8acd98e43d48ea7d4f4292..e1a7d33fd4a369f7b352b81d2070beb62a0ced16 100644
--- a/arch/arm64/boot/dts/exynos/google/gs101.dtsi
+++ b/arch/arm64/boot/dts/exynos/google/gs101.dtsi
@@ -1705,7 +1705,7 @@ sysreg_apm: syscon@17420000 {
 		};
 
 		pmu_system_controller: system-controller@17460000 {
-			compatible = "google,gs101-pmu", "syscon";
+			compatible = "google,gs101-pmu";
 			reg = <0x17460000 0x10000>;
 			google,pmu-intr-gen-syscon = <&pmu_intr_gen>;
 

-- 
2.51.1.930.gacf6e81ea2-goog


