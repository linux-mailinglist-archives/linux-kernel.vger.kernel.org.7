Return-Path: <linux-kernel+bounces-815540-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BF38B567E9
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Sep 2025 13:30:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC1D618919B4
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Sep 2025 11:30:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82B9A248F78;
	Sun, 14 Sep 2025 11:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fogq+P1K"
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BC64248F68
	for <linux-kernel@vger.kernel.org>; Sun, 14 Sep 2025 11:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757849390; cv=none; b=srbIlTsWg+KyA4eU30PJiELfkP8nZ2MnUpX0EuwYup5/n+bwNN40DKSxjysF94H646URj+lstKut5SLqY0e9WM1nINXOK9hLg7nZmVVh4kmz6dSUrhn7waH92YHzUO0idvKAxn038+b3uqmduO6E6DhgiSMRaX1r79D+IQcyzf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757849390; c=relaxed/simple;
	bh=tNCkYEchRdJ7RVdGf0Ni9Ay2pzie5WwsNtik9+z3tJI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YiqT3ySgY67UGYCxfqstARJhT029uhN6L4XRf2WqV2g9muZxBMQU5bBTPPzEJvoBw2A/A4DdVBbM3iiWMi9RXfd7JegRMU9czt05Lxkgtb6a6S7kOsF0lUgSc55/pNmTSjvBzeYHcvlv2/+XOPoOCiunxm0KaWXG/1iYfFdJSlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fogq+P1K; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3e4b5aee522so1955914f8f.1
        for <linux-kernel@vger.kernel.org>; Sun, 14 Sep 2025 04:29:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757849387; x=1758454187; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6kWbQjmWNj90FslbkuEkjvxEvCWQssax8cSBKQRPyJ0=;
        b=fogq+P1KVeoOdwmJV/S7jESkSLViUhpHfp/5U01BCbsu/w0O/n7B7I6wAVGSbz0Rpz
         bO9iVsEWjidrwTr/ihdZjNz0bldArhpuofuwMSF9f9U03eQ/GHfu+1vmyyzcLuFzP/gC
         y8Oa4IHDRwh4SqkP5wsbhPEMYbi+mTl8rb+sA8s7HAoAVikkKCmM0kUahR5AwOTW8q0v
         EKRtjxYJf79x/bm8k2Zadt+pp51KPF0t7DzoI95ra+IFfZtJ1vnaVrN23xAeJGAOJbcD
         ERLuJFepjara+DfJ0HUjuOLpzA0u50rs8Jcp9YJrLVUCSoRgmn6ptinAErXAxsOj+b/S
         LanQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757849387; x=1758454187;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6kWbQjmWNj90FslbkuEkjvxEvCWQssax8cSBKQRPyJ0=;
        b=m+P0YY+5uJXxrKVhamuobnndn6iMnnt8yfQeTwS424HHLkfb5PZ1k0ssm+HNiVxdDO
         yFApNrAVz6i7iiIMnkPAnFz2cxuJkpNITmDA0LweqMt8vNhdz/gZBtrqOS9AdybCtJ0P
         pFdyHhpW3GqW6vY8wEXKXMlIcZcjsTrkoeFjkpf88dnCADpHX/ntpYDzXaEX1LadbrRd
         AzjGH8n19bQli7aylXQgRA816efsuKFU+m4xyC9B9NnWmdWHEG/3trpp8pWJ9jUSFAzr
         mJydADuk7qFO7nNtEiVbk/KNt810oO+UP6Mw5maR3N9Ojh3Ntx/6rOLO2m/8SaAzp14X
         4h8A==
X-Forwarded-Encrypted: i=1; AJvYcCXXE4I4zTIo4UsWumr2+rm6/RNNWKS9aiRbmsieMDZkZdAkoEQLglghnWhtAnMcngFhBktARy+0oSwECXk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIm6YNQI08uEp33jFOFxFfnLQwqDQqWC4Fck+CpIoW/0Vzlt58
	ZXiW9seqi7C+CWZA7RQ4oalukHQ7f1AyrLMtIK5qlysP8EgpAx7qu5W8
X-Gm-Gg: ASbGnctG4GYdJeliEYK4g2YH/Lyyosbw02KTDriWvRUmnMfrBz9/HJjXYKGcIQSip9W
	qC1IvjGZBrnnB5lQS/mkrSu69vRkr7hyQ3PKRdWus1pHuTu3/89VLU5LjPawKY1No0xm4Gzl2+Q
	S53dmhEwGQy94XgQJFQcwgUTwu8amvCKa/J3pS3tdT0O0ZRM3cZeQc5jgZSJ/GXIUCLzInyW1zW
	M8N2ZrKEYD+Bt9fN6dVzHfM39JCvr2loSECrJxRQsfKfoFtEGXes8Bz2Sy06KfghmfE0aYTs6Pi
	vZleTOVb/W/nMHY7/r2DA+rGTbN/snLGK0/ah7RjrDtHPqRbK3qSPqr7ZvBU74llR1jMnEBhtX8
	7n+V548OJQYMRGR+eNF/e4V9tvIGQqktTw7FTkEvdWPhjhF81wzr4PzOt6DnKYfmuo9aUWOxnfw
	==
X-Google-Smtp-Source: AGHT+IG39OXL5GbVP5YXCrtcp7+pGbdpdEB59AacbRvXYzjADaHt3PlBFvUeX/cNMkHe4IVaRg1YkA==
X-Received: by 2002:a05:6000:2385:b0:3e2:4a3e:d3cf with SMTP id ffacd0b85a97d-3e7655940b6mr9199096f8f.5.1757849387391;
        Sun, 14 Sep 2025 04:29:47 -0700 (PDT)
Received: from ivaylo-T580.. (91-139-201-119.stz.ddns.bulsat.com. [91.139.201.119])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e8346defd3sm6591268f8f.1.2025.09.14.04.29.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Sep 2025 04:29:46 -0700 (PDT)
From: Ivaylo Ivanov <ivo.ivanov.ivanov1@gmail.com>
To: Krzysztof Kozlowski <krzk@kernel.org>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	Rob Herring <robh@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: linux-samsung-soc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 1/3] dt-bindings: soc: samsung: exynos-pmu: add exynos8890 compatible
Date: Sun, 14 Sep 2025 14:29:40 +0300
Message-ID: <20250914112942.2604194-2-ivo.ivanov.ivanov1@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250914112942.2604194-1-ivo.ivanov.ivanov1@gmail.com>
References: <20250914112942.2604194-1-ivo.ivanov.ivanov1@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add exynos8890-pmu compatible to the bindings documentation. Since
Samsung, as usual, reuses devices from older designs, use the
samsung,exynos7-pmu compatible.

Signed-off-by: Ivaylo Ivanov <ivo.ivanov.ivanov1@gmail.com>
---
 Documentation/devicetree/bindings/soc/samsung/exynos-pmu.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/soc/samsung/exynos-pmu.yaml b/Documentation/devicetree/bindings/soc/samsung/exynos-pmu.yaml
index f0fb24156..be1441193 100644
--- a/Documentation/devicetree/bindings/soc/samsung/exynos-pmu.yaml
+++ b/Documentation/devicetree/bindings/soc/samsung/exynos-pmu.yaml
@@ -55,6 +55,7 @@ properties:
               - samsung,exynos2200-pmu
               - samsung,exynos7870-pmu
               - samsung,exynos7885-pmu
+              - samsung,exynos8890-pmu
               - samsung,exynos8895-pmu
               - samsung,exynos9810-pmu
               - samsung,exynos990-pmu
-- 
2.43.0


