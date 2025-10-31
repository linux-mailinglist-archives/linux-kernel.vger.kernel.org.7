Return-Path: <linux-kernel+bounces-880225-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D110C25291
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 14:04:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7795C4FA6AE
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 12:58:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81AFA34D4FE;
	Fri, 31 Oct 2025 12:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Kkrpuh+m"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3B2834C83C
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 12:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761915377; cv=none; b=F3SDLGM5RnI/ZfugmAOBpQk+ZgZ0f/GZeohBuBAVLXQLSbjX5QqVcEYUgzjqBBJUjjxEBn289PNG0pNjQUPSMKz9Yt4GMklypgKcozJcjNw0wpnpqCLEDzxKk/wi7XQuYCr8/WFDktOYyVJqEw4CDBLsQeqNNFwO5SJfPCodeM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761915377; c=relaxed/simple;
	bh=6z7Q0cvkHq4tbrD8eYT1HprLcsjew57f94vW5406IBU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=O9qVciNYup2jw8INDISoyj3a+ejEkE2rHGj2X9EqhSh/zjRRYD+2feRkCw4OIyW7rK8v9q2qkNe0T6Rph3ePB+99reHTBBBgCD+RQ3oWItAjVHI2inOzUeZA0SKcpqfdBs3waMP2GR0umO6uUAQoMMtkneyOfdt+O5MFXXR/ryg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Kkrpuh+m; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-475dd559b0bso29205525e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 05:56:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761915372; x=1762520172; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pb2pqqKjiQQF/REmK83pr0aP945mNb4ceVK9gk57rPM=;
        b=Kkrpuh+mCAiuLEikgkQ09AEby3RFHS/bua6DrVqlOOVvJN/g2GFlh7RzKbxUO1X4QI
         6s5DtKD8pwnxh4TE+3/wLW7xjwfWU9kFXJgdkgzwSx5gx0gsEM1+cQp4rgvH275u63n+
         YOye8KkBZqw14djlWQ/jADCR2zbQU8nfO9sq5UoaUVV58+s9F3Q9R/7f+dqLEM/L1I+m
         iOTzAgMMrhKqxG0c2cYJbZVPd+qLoFbgsJ8jCFr4D815jqRaJH4lfq/72HsyJ5RrWCUB
         spy8Bv53/Ycqi/Awf8/Zq5GJgBfxYr0N5NXAHeoe9rJIoflYf0a7E5+LgZWsnL/EF9LJ
         gXKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761915372; x=1762520172;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pb2pqqKjiQQF/REmK83pr0aP945mNb4ceVK9gk57rPM=;
        b=DOICpADMz6oIIEwjnHYV8xIwSvbo6ttg1X9KctVITkulafhzNUhZdf/7OHb8GZnBly
         PWdLmffuoyC7IXOShppwl4/gzCkw8A9YTOfl0Uv7yO54F9Qd2e+EbOwssCDtcI8OfXsr
         48vnrbfqb2WF4uz+FULHZmT9X3m1I8/pTY8kj1HlIuPsr9v65QYFcs9Pthxu2zEXizJ2
         0tlF8M9uO6o8HwslcgoEZhSsbjt2D9exmzGZAgPw3+1sCCw/x9YiiU0WPyqkQBWejLXC
         mDbPTXsjcw0BWm3VDt0Xvd/5y5Q4EvoBtXlgXHSWr2pPYA4La/g0WlHHRO67e4ScbTNj
         +Dcg==
X-Forwarded-Encrypted: i=1; AJvYcCUA9nsshE8LrIyrm4g+bWnPFoClnaF1A8xXcqwuLIMt9TWXnj4keV0l5/YolSl+Fim/KXUoZy9XuEeK4W0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwhFUHtdvzEwcvnE/3I1k/rWlsxx7f3mHj1JC9VT5hpdo5Ux0hj
	6DJujf+/Rndvbag1UJr9tJvzrGvVt6R/4us6T0pMixyeIJmT2GjXzqrKpkqC55k7/KQ=
X-Gm-Gg: ASbGncsKBGU+KFSGptdqE85WMhVC00lVTfkoELAUZb6rVrXMMxBzb0Sd6msJCnnSO7b
	q5s36Qp6Yc0moSM8AlgGVW4fns8Z2K3FVn1Y/UUnpUuRURhj78cksxrGrpyNUm7ohxxaBea2Da/
	k3MZ7fCUNBuWqS1wvsOPeD8FmdvnmyM/22d7UDYfz85JiFNazxPBq1uK2Da9NbuHYkXdj4WZk9F
	YKiahU2RFXTnRllgM3ZqyFJkcTDRA/AIt45TDv9tFBBngzrathMKyFQcYvp7BAaUhQqjA3x8G2m
	WbbPlBntEfYtkApsxJTjAAKKX4o30bP2/6t/yf/03BEcdgAXrMUm0VhpmL50JTZStu4w/R7clE0
	DxKDSYcvd8qclwXEyhdxG86fDiNh0dM2pBovBVX7VQsE+FipaJI9wMFSl3RAsgCEg/69p4M9TQ+
	ib+OrnomXb78u8kTgtwVNFvBUx04CNFeZMUzseSviijVQ3h9aDRGoRFtEhkFrfeNI=
X-Google-Smtp-Source: AGHT+IFe9Oi7mS4HMXpo7MbmxHbms/ri8FM7ao6gprXy7xsckpCCyc1QnNO/QiFb7+3HO3HyI8NMYg==
X-Received: by 2002:a05:600c:530f:b0:46f:b327:ecfb with SMTP id 5b1f17b1804b1-4773082d988mr30938645e9.9.1761915371964;
        Fri, 31 Oct 2025 05:56:11 -0700 (PDT)
Received: from ta2.c.googlers.com (213.53.77.34.bc.googleusercontent.com. [34.77.53.213])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47732fe1075sm31814585e9.11.2025.10.31.05.56.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Oct 2025 05:56:11 -0700 (PDT)
From: Tudor Ambarus <tudor.ambarus@linaro.org>
Date: Fri, 31 Oct 2025 12:56:09 +0000
Subject: [PATCH 10/11] arm64: dts: exynos: gs101: add the chipid node
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251031-gs101-chipid-v1-10-d78d1076b210@linaro.org>
References: <20251031-gs101-chipid-v1-0-d78d1076b210@linaro.org>
In-Reply-To: <20251031-gs101-chipid-v1-0-d78d1076b210@linaro.org>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Alim Akhtar <alim.akhtar@samsung.com>, 
 Peter Griffin <peter.griffin@linaro.org>, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, semen.protsenko@linaro.org, 
 willmcvicker@google.com, kernel-team@android.com, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Tudor Ambarus <tudor.ambarus@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761915362; l=805;
 i=tudor.ambarus@linaro.org; s=20241212; h=from:subject:message-id;
 bh=6z7Q0cvkHq4tbrD8eYT1HprLcsjew57f94vW5406IBU=;
 b=yYQOtlOsyfkQ+MckjcC3btLUJDkAj1qpgBndKzNfjoyKIYZHO8SXE786LHd7AVTIyfk2xLLcu
 xQlA5cf1F31D9ReKrE2i5sQrvXX/xPObullG3soA9LrWoUzwPegkidt
X-Developer-Key: i=tudor.ambarus@linaro.org; a=ed25519;
 pk=uQzE0NXo3dIjeowMTOPCpIiPHEz12IA/MbyzrZVh9WI=

Add the chipid node.

Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
---
 arch/arm64/boot/dts/exynos/google/gs101.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/boot/dts/exynos/google/gs101.dtsi b/arch/arm64/boot/dts/exynos/google/gs101.dtsi
index d06d1d05f36408137a8acd98e43d48ea7d4f4292..11622da2d46ff257b447a3dfdc98abdf29a45b9a 100644
--- a/arch/arm64/boot/dts/exynos/google/gs101.dtsi
+++ b/arch/arm64/boot/dts/exynos/google/gs101.dtsi
@@ -467,6 +467,12 @@ opp-2802000000 {
 		};
 	};
 
+	chipid {
+		compatible = "google,gs101-chipid";
+		nvmem-cells = <&product_id>, <&chip_id>;
+		nvmem-cell-names = "product-id", "chip-id";
+	};
+
 	/* ect node is required to be present by bootloader */
 	ect {
 	};

-- 
2.51.1.930.gacf6e81ea2-goog


