Return-Path: <linux-kernel+bounces-723288-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 06E35AFE561
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 12:14:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 65C0B188F136
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 10:12:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A990428B7F8;
	Wed,  9 Jul 2025 10:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WLSFuKtk"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BB3328C025
	for <linux-kernel@vger.kernel.org>; Wed,  9 Jul 2025 10:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752055799; cv=none; b=G+oin0A4K6E19DTv8rANcL8plssLKBa08p5rD/Z3bEiQUTgL6kMIS4H9KlqxDjpevICNM9eG3Y5fzg66hUlJ7IaX/cCG+eX0ZPibiV7PY7JjpuZHUJ0D+Y7K6rAmHyLNw3rSwqigXvZ/RAnjfPr6Sgo41akr8YVTnWTRbIjjy5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752055799; c=relaxed/simple;
	bh=LxMkKb5hgW8cAQlNkcmWm9X1PpNrjirxZmIseahJ6W8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MSTnqwCPQwfCX4AsXfYHaFidvYb7r1ecl2hPgpLTAPbQZDY7AT1aeOWu/sqfmnBXW4noKiF7aHYhUFfiTyvlcAqUQ8/dDzjOlictgAXRH8Uu6582tGLNuTxsDqH+yzWHgl134vPjRD9NVSPYhKFwwl2SH9EYzM6dC8aE1/bJGnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=WLSFuKtk; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-451d6ade159so47451365e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jul 2025 03:09:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1752055794; x=1752660594; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZbOIQ7E1kZS/+21cXjdFZh+OYTVjRBSsv4Y2mT/dCkc=;
        b=WLSFuKtkvYKZmcz/iM1CeBnBF9vOR7Rq6MWwTZAqd2CJ9Uk9DWv2zZj6Hj90sOEeHw
         wn4rnSSPDCWMVyLf66v7GQUnwIxdnG6QXHYqhTzAsl7EhEiGKnNB1KL7yCs0jEcbfmE4
         xkEsAXi37B7OAJmBaZjCMI+dQLfQVIf0Qu2yRX/Jhgu9s7+ucZ3VnQEuE3+y5uWdJyW6
         fKgFX6GiX3KBAQtWZzW6fSJmhDNLDpqQwnefYFbBPG9qjmsWPX+OWvD4ggF25TC81cPM
         au4rG597SwGFLsxS/6ARY+yc0i4xnn/0fcPaOMX+3udJqoSa+h0NJrccnMvQdd+C+M6b
         5+hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752055794; x=1752660594;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZbOIQ7E1kZS/+21cXjdFZh+OYTVjRBSsv4Y2mT/dCkc=;
        b=toiBk4eoLXykGy1H7RUL3yl51J5J7O0T2xXnKUkUxYgeae5AqlOr8wtClDRtXpEplK
         7rG0ILJhtOvjJB+DZ7w2GQ49RRstcH/x1UxCMAY9dhNhhWfXgWd1ytqX9TqcEjqRa47g
         4ENcDzkxJ5c/jx+59TbSoSrh/rpJDdKRKfIZioaorRmgD2ejBVbEntXpFIe6oS3d/PoO
         +roYbHn1euQyk+N35bf1k5tbMj/hh88Zh5RmxQ+8GeaFanAuX/0jTbrpQvc1JbmOhN7G
         cQcnIbSoYfecsNNh3HZG9K78wGal03f/vhbtidDUdBk6rVJuW67tLN6SU157HncVTFy2
         0zww==
X-Forwarded-Encrypted: i=1; AJvYcCXTAn3NhB+YSX8SltOFsq8vEOEuxAskuMrV+vpe0evzxz/NV46GdiSusKUqI0YMqy9b6W690Jq7APgC3PY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyi/tc1Gm0kXWvGYijWGtQRB0kGaWc0D+yMUeZtcDsIpxWGENvS
	p4uR7At1iVztRCdRrUusL+NrnL9Eej/an7OQFCuHX43fhV66nQseUG+qSojJPjFqb8Y=
X-Gm-Gg: ASbGncssa3TtSDatcEbAfDd0eaXF0+44127xpC8Y4SxbqSj5zD2ZxZHg7KwdqwkKiwF
	8geukOf7P+U9NC/qmQmF9nslysVkqWIDGnZFKgD09Ad0Wp3MNo8PT56Yti0spSyr2BjQx0Dr0FK
	Irhc8nXDKt+3T+HZUtQ7rvpSqENHF7t0+NZJ/4vNkf2uDpCABaFWgriHCXU8k7XivqpH40+EKVx
	S3fpot7zz+mFNCqpiYF4PC1TCN2i5MOFLINHTayT2uHHn2aZyJBwAyDZBBA2tfboQmQjnhLGv+B
	V1rsIaAzQdIzKYNFOZzCnzbGeUBYFNBLx58iz+vR6eWW2GltJuzJ+Y3VrvZovy6GATLVqFQlL/d
	/Fg==
X-Google-Smtp-Source: AGHT+IGJCRy2yXBuJPF8rLO5PJrDnfPVSKiuDW0McfOpT3Cn3c63cry4nGGcVEDSDD3axp6iyvUJiQ==
X-Received: by 2002:a05:600c:a305:b0:450:d3b9:4ba4 with SMTP id 5b1f17b1804b1-454d532eeecmr13729955e9.2.1752055793564;
        Wed, 09 Jul 2025 03:09:53 -0700 (PDT)
Received: from [127.0.0.2] ([2a02:2454:ff21:ef41:d3be:a88a:dbb9:f905])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-454d5032997sm18342105e9.7.2025.07.09.03.09.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jul 2025 03:09:53 -0700 (PDT)
From: Stephan Gerhold <stephan.gerhold@linaro.org>
Date: Wed, 09 Jul 2025 12:08:56 +0200
Subject: [PATCH v2 4/6] dt-bindings: clock: qcom,x1e80100-gcc: Add missing
 video resets
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250709-x1e-videocc-v2-4-ad1acf5674b4@linaro.org>
References: <20250709-x1e-videocc-v2-0-ad1acf5674b4@linaro.org>
In-Reply-To: <20250709-x1e-videocc-v2-0-ad1acf5674b4@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>
Cc: Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Taniya Das <quic_tdas@quicinc.com>, 
 Jagadeesh Kona <quic_jkona@quicinc.com>, 
 Konrad Dybcio <konradybcio@kernel.org>, Abel Vesa <abel.vesa@linaro.org>, 
 Johan Hovold <johan@kernel.org>, 
 Bryan O'Donoghue <bryan.odonoghue@linaro.org>, 
 Stefan Schmidt <stefan.schmidt@linaro.org>, linux-arm-msm@vger.kernel.org, 
 linux-clk@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.2

Add the missing video resets that are needed for the iris video codec.

Acked-by: Rob Herring (Arm) <robh@kernel.org>
Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Signed-off-by: Stephan Gerhold <stephan.gerhold@linaro.org>
---
 include/dt-bindings/clock/qcom,x1e80100-gcc.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/dt-bindings/clock/qcom,x1e80100-gcc.h b/include/dt-bindings/clock/qcom,x1e80100-gcc.h
index 24ba9e2a5cf6c31e6e88c682e6bfcc60490d692d..710c340f24a57d799ac04650fbe9d4ea0f294bde 100644
--- a/include/dt-bindings/clock/qcom,x1e80100-gcc.h
+++ b/include/dt-bindings/clock/qcom,x1e80100-gcc.h
@@ -482,4 +482,6 @@
 #define GCC_USB_1_PHY_BCR					85
 #define GCC_USB_2_PHY_BCR					86
 #define GCC_VIDEO_BCR						87
+#define GCC_VIDEO_AXI0_CLK_ARES					88
+#define GCC_VIDEO_AXI1_CLK_ARES					89
 #endif

-- 
2.49.0


