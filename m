Return-Path: <linux-kernel+bounces-777433-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DDC82B2D953
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 11:55:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 54C7B3A5E66
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 09:49:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43B101E491B;
	Wed, 20 Aug 2025 09:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vOPngVVQ"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EC8A2797B2
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 09:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755683369; cv=none; b=gkI04jHK8XONrWCVx1WAyxhsXJlSdahPt01B0J5WWEv3nbaQHIcvTqzqYZQtq8fYi0N7Bh8JRt4LSR8Njt1k3HKdkloO0z8CJVHGXS4NQbNjdTib/kT7RuflJcNVJTti+LeEWn9W50p5ePBMXH8VR4Mh9tqCk4Lpc1ZZS5684tw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755683369; c=relaxed/simple;
	bh=lLCHDFTIcoaYLQszbzCq5y5xyC1sxNo7SmnYSWMGngk=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=aOHfzKzNB1W6e/rNjS0v4nRT4xad+WzQIzoL7AnpWB9ry2ufrVBLyiwHI5zVTyxKXR73UQG8E7I/+qYC4UGSEb9BNuoSCezuiISiBPIdL7ZXppczkSlglK0ogMtnvpVhOOSSPyqAvGQn4umejR9c3A5CDcfAc8m5pMpanImRBk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vOPngVVQ; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-45a1b00f23eso35242305e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 02:49:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755683366; x=1756288166; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6Eop9oqjiFk3/Zd4zwNOQjH4EVFlqnIc78gwgAibO2U=;
        b=vOPngVVQp45pcq8CyNJ0Vosfla0PxuL6KD5Czhposaqh7HSq46Cy3o2UhP2Dm/MpHg
         +D+JeFn+18yCtwYqzCrnHb4GkEIN+tMpXJsWEEqLOVuLYja7tLdLbFpG56Hep1NMwMNt
         sDE8hWKr1OZtFDiDZXPS70KAwvJVjWQkwQpqFntABSHGzYhsBDmzppEPDYDLlVak86wR
         6mRUhsNlGQctmMNxw8gQyUSYQDGl5UIqSt4mNTu1A36b9l3sbm1glQf90aKGnQ8MAE3d
         pGEcg6R3MV9/bjhhhJGazEdMSls4Qg3T5Tlco0KlhXxuf2aNPH2RF8slp8ZFvCJjxSJb
         rxWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755683366; x=1756288166;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6Eop9oqjiFk3/Zd4zwNOQjH4EVFlqnIc78gwgAibO2U=;
        b=WSBpaLuh3xV5xjNh36SH+NwWNGBxIbxA1KEZV/StBEtuPh8HDUK+cFQczIMKoeMLPp
         G9C5vWclC6eLkWyV2bfGmOXYYzhMe8nyxbLl4T6eHcERiVVeOSHvQgrkRX+t83tlIY3E
         7u+Fv545YwgPa+x3FbyLtJ4JyDvgfnW9F01sexrXvnQ9zMnChTKLab6/4Pfg1ltmyKWM
         U0R+5P8A32l8tV3bTOcY/Tqo8XpCPo1mX82U7kO3+VMGGpPNvxCOFFt4kyqcKMvF17Cz
         sY/RFdh0+m4jfUNfLJG16cL1vbKc61TgxO3xHxuTyuGaiMz4G1i6N3bofov1mGkDvVFR
         wBTA==
X-Forwarded-Encrypted: i=1; AJvYcCWlKZYt0COHtY69Dz0OeOiHiXdABPMfFBA+IElwpab9rc+3noSleAF2NG68P/CkXwrR7Jxavdn36Lzo4Ow=@vger.kernel.org
X-Gm-Message-State: AOJu0YwmAxggAW2ax2OsOGaMKX6W+YGrg/SKARE7UQDCLFVKBIFN62AM
	uUCYDW4mA98pYFPQoSbP7SP35DdCsRt3j75B/Vc2KVAPeMJpv50UIJ0RtBnp0+apQD45Ohlezjh
	1OCv6xcc=
X-Gm-Gg: ASbGncsDALA0sVl/SwZJSzTAMQKcw60DKO09zz9w6JoTqAxqCaNSqI28jYWfdoHWaUB
	oukNHnirAZQwpZEvBZ3h6/OyY7icS3e+8c6gj/0JLQDNfyb+pAC1dotJUU0hqvhsiYCkONX2KBB
	YGAic1OgBLT3F0+PQKvOd6yDtyk90YHKVT0gcvHcE3oOoB0mNNBs+Eh9pz8cbiWwL0mGBzOHW4Y
	M69JJ8vQ8/0l+5P2NU3zHBdjB2+8vyIYqIIl9+Xto3O38R/GX5Qmn9M2BKRqaUQ32wturClK/L7
	ldiSVYqzlYFsfAPfvO2oTPuM0sHq3rFVMEVa8yGUE0wBkK5XHoH3v89MwjyEtK21oV2XhLn8VnZ
	xqsOYeApx0SgFECbu4ZVQHAft9gQZnlaHHYC8iUeR+SZu9rxreBoBgQ==
X-Google-Smtp-Source: AGHT+IEZkjorQBJnuBC1Uc5RJ6+hMq4jEFEXCqDMAtl5/HyOLaqY1FjKXg3Lwz7wmiMdHiIIXeEjoA==
X-Received: by 2002:a05:600c:4f41:b0:459:dfa8:b854 with SMTP id 5b1f17b1804b1-45b479a3e75mr19883035e9.5.1755683365736;
        Wed, 20 Aug 2025 02:49:25 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:3d9:2080:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3c0754f3b7esm6721228f8f.30.2025.08.20.02.49.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Aug 2025 02:49:25 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: [PATCH 0/2] arm64: dts: qcom: sm8550: switch to 4 interrupt cells
 to add PPI partitions for PMUs
Date: Wed, 20 Aug 2025 11:49:21 +0200
Message-Id: <20250820-topic-sm8550-upstream-pmu-ppi-4-cells-v1-0-a8915672e996@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACGapWgC/x3NQQqDMBBA0avIrB2IaSNpryJdpMmoA0aHjJaCe
 PeGLt/m/xOUCpPCszmh0IeVt7WiaxuIc1gnQk7VYI11xluD+yYcUbN3zuAhuhcKGSUfKMJ4x0j
 Loti9k3vEdPO9DVBbUmjk7/8zvK7rByQUaw93AAAA
X-Change-ID: 20250820-topic-sm8550-upstream-pmu-ppi-4-cells-1bd59cd3862a
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=844;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=lLCHDFTIcoaYLQszbzCq5y5xyC1sxNo7SmnYSWMGngk=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBopZojMvJMFxgl4rlct1SRa1hkO8m/Fgc4y65s4yK+
 PVAHP9OJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCaKWaIwAKCRB33NvayMhJ0TU8D/
 wMW9m2nbr5QBPT2n/emrtYye4cmy+l+fhZwxzxCDZaQtYU0GSKv0EO7ZsnNphW2y907+GLsXuAdJEu
 UzSyq4BKwlHnou0WLuRYARE5w0VX5NHeQE8StSpGjjBhkfI/H8icWpgLXwYCYopCVUHJ1X36Khz2PD
 A8lL1zaAyok+oyWjhz0I3gU7YDSr6ksWibM3z+jF2ogNQZwEJVgll63+Hd6D3junqhRkJkauhIDYqr
 WxoIS7ZTAw8toe1+KQXaaOprlVhnhK3SXmocYnahwpTLE9+ht227vHDTAhxLnhfSdOzbV7Q/CFOVcz
 H/BVJm65X3E895JrAhdMRwE2xRmm+DVQAeEq78IxrXr/RslPQz4FLOX+WeCBP3LHYFUvQaNhlGUoqU
 kkwmz+u94juSXhn6aECviqaORyTKK1tzJphbSpV68tiQvBBOC3WWNBf1A0UX+Uykxg5eHk9AA1dK2k
 pSDOxlScH20PhdvAABRzULozRJFFkBFeWGFWKiY35MjQ/P6RlU4dLZ+5WepKlFGBQjAFRsPFYz8xlf
 RkAJyMQP/0h6CAVn/2nIa+yE3qhGfDmpXTIaYM8jTJyUut4RDbTJ63Rt4L5xq6APYfg+L2RysX7YFj
 wu9EZQYaWD9srdF2zW2bxy0g5A+LbxZuve9QOu1zKrP361MLb6a8Lcvzpv0A==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE

Swich to 4 interrupt cells on the GIC node to allow us passing
the proper PPI interrupt partitions for the ARM PMUs.

Based on thr SM8650 work at: [1]

[1] https://lore.kernel.org/all/20250227-topic-sm8650-pmu-ppi-partition-v3-0-0f6feeefe50f@linaro.org/

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
Neil Armstrong (2):
      arm64: dts: qcom: sm8550: switch to interrupt-cells 4 to add PPI partitions
      arm64: dts: qcom: sm8550: add PPI interrupt partitions for the ARM PMUs

 arch/arm64/boot/dts/qcom/sm8550.dtsi | 598 ++++++++++++++++++-----------------
 1 file changed, 308 insertions(+), 290 deletions(-)
---
base-commit: 5303936d609e09665deda94eaedf26a0e5c3a087
change-id: 20250820-topic-sm8550-upstream-pmu-ppi-4-cells-1bd59cd3862a

Best regards,
-- 
Neil Armstrong <neil.armstrong@linaro.org>


