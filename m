Return-Path: <linux-kernel+bounces-788342-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BD27FB3832A
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 15:00:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5BA005E19C7
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 13:00:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48F1F350D75;
	Wed, 27 Aug 2025 12:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vGh/t5bn"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEEF22F0C66
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 12:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756299593; cv=none; b=kz1id10A2xMin3anRjHPRCKrwdUy4VTIHlV+hhbpM+AKHQI5bg3iEe2VB3RrssZxYQvM82RevypxjMyvrblrD9L2y0VQPBFoYN/GCGb4uCFBCU3sghj53VXiRgHOL1Cy/WzcTcdEnrjhL64FpN/iU/UJN6REMdzg3xt6h05FnN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756299593; c=relaxed/simple;
	bh=lXqAHsVVGobAqxHDBDj2hfAW5L/ixpf0F+OYYJ4nT/w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pbYAri6DRTxfznTwIOjpyTDS3xfG2dn4eWGi7ozCz12MrdYnnMUieiQoywwTQ5kDfn6n7D4jnv7PyiedwGKJzSal5GBNKFZmf2IDpWrOEuUmvSTMTGKRO5yS0XD4Ib4psl1WwBNC94chBRQPjiu9h2VYYj4txz2Rr4GK+NVC8Cg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vGh/t5bn; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-45a1b0bde14so36582985e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 05:59:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756299590; x=1756904390; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=St11QoIkuwt6LD0qyFy2W7TckyvP5Gq6gOAm3aWS/Ik=;
        b=vGh/t5bnupJIjbNNLkWrelgN1x+vnYeZB80lDlbAu2sR7vqO4QpBjNCeZhBvKYHGuY
         700Id3X+DHpfup/KUwUtT1mLDV9WTJbiNy+zCz6JN1wioY4fTYv4zhfpoSxbovg/DeWk
         1fVd810pBH6hmyOrQLhKC28sfvjG4EjV+LHw1bl3EIZoJpgQsccdcFE9gBqdPCdcDnjS
         vKRGpKQoCAg9tSIceDvEO1kFyuU1gSDoPyezboXq//GGkmz1SH4qbOHmLXd+MeKztWe+
         2Pgr8JdJxdzB1V4ycx8jjIXhOYvBFmd3SZ3joe5I29uXApisnkKtSEGchfgQbJtLijOI
         ytIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756299590; x=1756904390;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=St11QoIkuwt6LD0qyFy2W7TckyvP5Gq6gOAm3aWS/Ik=;
        b=r2t7oH9tUzBmzP+umxc67pvV6VBhlOuuRVPwfuEm2C4+hWXVw7k8kOMP4mnUS5K1rS
         qot3ENNfIIoLgDzGYxBku0DCYoyyAdhvjIzptg/CKEHG1C5yHefqPXY216fmMIiS8gtg
         lb37ZC2wyHM3qi9re3FNOWahYc7V/UYmaMCwReo7Mbv8ryESJm7dLXtrnolfwGZKMTN2
         ixRJntXBAZv2WzIbB+0zm9CZYRcV98OBrfFGhfhzDTtSJ4zozZQ8F+LVTitQOSAHQgLh
         q6+YmHMx6dU214aFAq2nYRo5/IlnWTldLu7+Dy0bvlEq2DmfcMdCduKqk9SbPdDzI9Rw
         zhMg==
X-Forwarded-Encrypted: i=1; AJvYcCWrKxt1fZUh8HgzDyk/P6pXQa5TFao/Js5Hw8/E5bNxqRaZZ7xxqPnUku1b16huVhNvkQvrm5nBvhBp9rg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbA0V9M0TgYa3r7wYwBuspYIHhZxHrh8xinuzUmBYv3NBTIEVR
	HDUFk5On+Dyg9lVTRnOfp2a5Ehe4uqP+6Z4+VQb3JBEBpCjl4dkWJLUjAef8TeclBZE=
X-Gm-Gg: ASbGncvrWlNeZmaDUp8TrtDLsoskczCwo2YkX9LeJafTWJ4vToeelm3WqIUPzd204NQ
	cfHCDLd5vpr7YM+hp2iHlf43bHqVgIAM9Ykz+y+5NJSPVWjCPEUpZULAxvwHVBnUmnBS4/DslHe
	nAHqW7PnTHcWKMl8kvZrW2Jq7XtqGI08wNK7A5PS7Q7cQ9WbpPk02fkg4i/EzTxyWirJnmIWw7r
	pcGXdfZEgonZw7levTi5h15f3rBHMTjVvIARNDT1J5ZxzzKq9NcYQLVXwocKDPv1QHw0D9CpjdE
	hBnyx6Nq5rtGrQ+2I4cUmoaoly6FA3BuzhqyyXC8XR3HAivi03+RS58vprUdkeuqcPGN0hHyYW1
	WcSAXYH6+6RjPqYvGmbo0wOoLtXoyIfcKfFTKAjHfEsVKGHKIVAQEt+Ej2zqnnv0QBeEmknba7E
	rNbQ==
X-Google-Smtp-Source: AGHT+IGrO5in4kxeXFs8Ggk7J9FQe0NLAJGrBqkvOKY0AV+1WCmJgGAiQ8Lyh7hq52k9MPnYiLZGlg==
X-Received: by 2002:a05:600c:4f47:b0:43c:f0ae:da7 with SMTP id 5b1f17b1804b1-45b698efbc2mr40559705e9.7.1756299590136;
        Wed, 27 Aug 2025 05:59:50 -0700 (PDT)
Received: from ta2.c.googlers.com (219.43.233.35.bc.googleusercontent.com. [35.233.43.219])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3cc890b178bsm3272069f8f.52.2025.08.27.05.59.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Aug 2025 05:59:49 -0700 (PDT)
From: Tudor Ambarus <tudor.ambarus@linaro.org>
Date: Wed, 27 Aug 2025 12:59:46 +0000
Subject: [PATCH v2 1/3] arm64: dts: exynos: gs101: add #clock-cells to the
 ACPM protocol node
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250827-acpm-dvfs-dt-v2-1-e1d2890d12b4@linaro.org>
References: <20250827-acpm-dvfs-dt-v2-0-e1d2890d12b4@linaro.org>
In-Reply-To: <20250827-acpm-dvfs-dt-v2-0-e1d2890d12b4@linaro.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1756299588; l=858;
 i=tudor.ambarus@linaro.org; s=20241212; h=from:subject:message-id;
 bh=lXqAHsVVGobAqxHDBDj2hfAW5L/ixpf0F+OYYJ4nT/w=;
 b=1hf3mcPjyceW9nVsY3YJaxdSK+F2L7MXoZnBJFli89bCPqeG8RhhWI+dgSmVFITri3grRwv4z
 cDeXEVit+3jDX/fnKLE9QVz2WyAluN7lZ9fP3bWF51Nsyhbi7g8lZJ0
X-Developer-Key: i=tudor.ambarus@linaro.org; a=ed25519;
 pk=uQzE0NXo3dIjeowMTOPCpIiPHEz12IA/MbyzrZVh9WI=

Make the ACPM node a clock provider by adding the mandatory
"#clock-cells" property, which allows devices to reference
its clock outputs.

Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
---
 arch/arm64/boot/dts/exynos/google/gs101.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/exynos/google/gs101.dtsi b/arch/arm64/boot/dts/exynos/google/gs101.dtsi
index c0f8c25861a9ddb5bbd256b62c66a645922ca74e..f00754692bbac39fd828ebd4ef7c269f746f2522 100644
--- a/arch/arm64/boot/dts/exynos/google/gs101.dtsi
+++ b/arch/arm64/boot/dts/exynos/google/gs101.dtsi
@@ -202,6 +202,7 @@ ext_200m: clock-2 {
 	firmware {
 		acpm_ipc: power-management {
 			compatible = "google,gs101-acpm-ipc";
+			#clock-cells = <1>;
 			mboxes = <&ap2apm_mailbox>;
 			shmem = <&apm_sram>;
 		};

-- 
2.51.0.261.g7ce5a0a67e-goog


