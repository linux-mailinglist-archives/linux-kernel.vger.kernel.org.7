Return-Path: <linux-kernel+bounces-824344-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04B54B88BB8
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 12:01:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E98D37BCB0C
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 09:59:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B0752F28EB;
	Fri, 19 Sep 2025 09:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="PhZx8bOw"
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CE342F548E
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 09:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758275965; cv=none; b=PkbIZP4atD9is2MD1tjmfwJVNEafOSxTn2IlalVJ3QtoaD7+4ztZ2/9w/D9L6xdf+zOMe3Ej1w9mXfyaiK/cxUV5XvGEL529G3Z+yk0T9rNJOwzsp159bJrwNkRVgUHUI6VGg+ozh/qQlJAtEBxCDe3rbLtwm2QGJ8UsdHIpWY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758275965; c=relaxed/simple;
	bh=OUZ9IG+km58rNt7HS8env5yNHx5mMi+2MbMDqULuRsY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JPmic4uU4qRWxt4e+s0LngIu+b1VjOLonmnEJUZkKhAyz0HkZ7CsM6D1XCT/RZxN2FyIj+Y8Lwpl+UK0OL+B13likJlZ8PL1GQdKGADgILT2D+Q2NPlhdJKuU1jdI5ch0cLL8anYxUVg8Zms8IgCKgjORF7KCi08we2G0n2e1Io=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=PhZx8bOw; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-62fc0b7bf62so1012503a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 02:59:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1758275960; x=1758880760; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=u1GNGqseHGUM5oQ3biZBBX1kDZS/D/utgJSKJ0QYFic=;
        b=PhZx8bOwCbj6uddXoMcvj3L5E9ivOMXdCociE+4ZaUcQIxjiB6ShaPqd7UhCxAMZLG
         h1Ae4wUT1NVZaH2CCTVprf+Rd1JQdhG8IHQHFGulfujv6Ibhu6NQz4l48au739btb5fe
         v4PgEFcHDz0BODr48ozEEQ1pnexH5s31yUaUlSXAEyhqnnhrRKIUUHUGS9lWxKlq0bFM
         5WhWIW1D4ge0K0h/zUvgXQ3hM29eRGiO3W+jEEGbiAfBYD8mwQWsi5hW/Q9JNoirdGIZ
         eOXJz/DqcyW+290sGKiUKalS70kK1vAw83gV9Ccn0w8ElHy/EyNbZtMjH49lQcKoIhpQ
         YPSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758275960; x=1758880760;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u1GNGqseHGUM5oQ3biZBBX1kDZS/D/utgJSKJ0QYFic=;
        b=cW7vtoQmBMsiCcHUhKnrHXzA7KdGe/nafp0JhxEhURevuNOfoyQjpY7NWHgH8a/bcW
         E85BSt8vclGYkxRgLZLLDttxe7WDUOkoUWrtWKJL6cyvNuVYSgQ+x3rbelv4oGGf1pqM
         zvCEy2lJ8Zyi7BOj1v+oTVftAzSUGNP1qB9nsRHM+Z5wLQCo/RggGvADdpIc1ic1C4fV
         ZHfhlwRXm902zHGSyAppLwQZ49dGUwloUTCUMvK4nbfpH0WsELK7iqY1AqsUUzf/7zJC
         Ijrj/BNygpl1BGzEAlzkK1QjRO9ha7t4A7on5GOI6mrjITUGi4KegR9yo5icyB5tt/dF
         ucww==
X-Forwarded-Encrypted: i=1; AJvYcCVFDHghpRgX/goFEJPo17EnIaWkIvJJ7AU8gInVh8wAZKLLRVW+ua9Bm2Fw5me1h/V6RFz5T7u85yC14C8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyaUry/T7Rb/OlJX5QXZ3OmvP3ky/fA1Z4I5XMBLx+2MeCWQ6tk
	TCtf6j6Jz+QH0/das7XedhEfBWSm4nZu58oUkKb8Bj6zy1+Bmw+OCqyYvY6CkD6swv8=
X-Gm-Gg: ASbGncuB2ZiNpcEtpcuWJFdd110hMzL6/m5hWnwMM0gCpGLtPwBgpSEq3jsBRyvoyBb
	uTHZ4ZUPr+KNzAJSp73rFw6TaMJZaNXHyrX87Tm54+IG+xQnHQCZmvLqXKSwwSdBRZtXHTeQSNH
	PmijE90BCs3P0KKcyQ/M5i8IhGyTD7SO8zMsN42G+lfMcZGekj5K0fwXdkkbqc6YcJiW+Jm7C8/
	JT2sOJ3DZkad6ODiBQUFobMzmJE7E13XQ3rbfgOC3P2fv+qwHo5OZIf8JYJb5+G3CT4nOlUsnYD
	7E2mKMRj298nxlChSrAAk0GMhS8/Aug58CU8fLR29czzKiHvFwtwLeQ/0ckyPqy9FZZd6p4MXFT
	gMNbJIIuNPHGiy+dHAQ4mHmv/sgPO8qXYVfGEiMzQvA10cxH3YhkRhT0260tXgEJg6Ofdqg==
X-Google-Smtp-Source: AGHT+IFHKKTi2KqgiASniTO0Gp9RLI9E4W0L4odjaW1XLQBKa1rfopUp5lUHyoEfK2xYfnHx3ihkQQ==
X-Received: by 2002:a17:907:7204:b0:b23:74d:b0cd with SMTP id a640c23a62f3a-b24ed887037mr267162266b.3.1758275960218;
        Fri, 19 Sep 2025 02:59:20 -0700 (PDT)
Received: from otso.local (144-178-202-139.static.ef-service.nl. [144.178.202.139])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-62fa6f03008sm2972107a12.7.2025.09.19.02.59.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Sep 2025 02:59:19 -0700 (PDT)
From: Luca Weiss <luca.weiss@fairphone.com>
Date: Fri, 19 Sep 2025 11:57:25 +0200
Subject: [PATCH 3/3] arm64: dts: qcom: sm6350: Add MDSS_CORE reset to mdss
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250919-sm6350-mdss-reset-v1-3-48dcac917c73@fairphone.com>
References: <20250919-sm6350-mdss-reset-v1-0-48dcac917c73@fairphone.com>
In-Reply-To: <20250919-sm6350-mdss-reset-v1-0-48dcac917c73@fairphone.com>
To: Bjorn Andersson <andersson@kernel.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>
Cc: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Luca Weiss <luca.weiss@fairphone.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758275958; l=960;
 i=luca.weiss@fairphone.com; s=20250611; h=from:subject:message-id;
 bh=OUZ9IG+km58rNt7HS8env5yNHx5mMi+2MbMDqULuRsY=;
 b=itCMelDsenKT4NC/qIf87Yi9X7uzziQSnVu68bi4iCRJjxZ8ytLv2YOjIJ4rlkqTKGrcilOBW
 i3XJ6jjiISxDxjw32haNv0RDzcg5kyGbOW4ys9WXSkcGiROIp7JJNDb
X-Developer-Key: i=luca.weiss@fairphone.com; a=ed25519;
 pk=O1aw+AAust5lEmgrNJ1Bs7PTY0fEsJm+mdkjExA69q8=

Like on other platforms, if the OS does not support recovering the state
left by the bootloader it needs access to MDSS_CORE, so that it can
clear the MDSS configuration. Add a reference to the relevant reset.

This also fixes display init on Linux v6.17.

Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
 arch/arm64/boot/dts/qcom/sm6350.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm6350.dtsi b/arch/arm64/boot/dts/qcom/sm6350.dtsi
index ff1eb2c53e7b865350d00ffbfa82d7d1e3cc5aa0..929c8a8b2d446505228531bfc55f3350ef2980b7 100644
--- a/arch/arm64/boot/dts/qcom/sm6350.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm6350.dtsi
@@ -2150,6 +2150,8 @@ &clk_virt SLAVE_EBI_CH0 QCOM_ICC_TAG_ALWAYS>,
 			power-domains = <&dispcc MDSS_GDSC>;
 			iommus = <&apps_smmu 0x800 0x2>;
 
+			resets = <&dispcc DISP_CC_MDSS_CORE_BCR>;
+
 			#address-cells = <2>;
 			#size-cells = <2>;
 			ranges;

-- 
2.51.0


