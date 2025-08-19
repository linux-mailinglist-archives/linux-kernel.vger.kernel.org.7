Return-Path: <linux-kernel+bounces-775816-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B17BB2C55A
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 15:23:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 53E4A1BC7D4E
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 13:19:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 452C4345747;
	Tue, 19 Aug 2025 13:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RhFQQ0rD"
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20840342C80
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 13:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755609437; cv=none; b=u9SrkLcLRTLB+bgxjzGIQuI8aM3rHU7FnvP4xIDN8zocZWAhGxkasPGI3YdzhyysWMa0xtImVvBiBULtp9qgKnQ421REDOxyd776Xu2mAmJ7W1I1Aw7H/INRh4PHtYJg8pdgC0F6GBw6BCiP3qiMMFhH2o9R0owPpzXNylBUm1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755609437; c=relaxed/simple;
	bh=CbjadNNNEe8Yn9p48OvNEAWuQJuq9CsOCkHrF+TBmzM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MykAR6BmW+CGP2bfkW5mBSDuRaNLqHqkZaTGVD1Ij0wsbqxDrf0dEDvCBP/UuUuYf2YjRkYirIP2aNQzwbmXZ2hr3mJY/b+ZU+0TmCAIpMHyhLsQYfBBb7ELdcE60Afrn0/EMXcyG+lPPsJoigFBoKUowyyMzZd/bkfbJK0Jn+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=RhFQQ0rD; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-6188b668b52so624878a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 06:17:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755609434; x=1756214234; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eYMdhxIUQ31/cy7vzWDrnpVEGbQxqOB4QZi3i8Wf6a0=;
        b=RhFQQ0rDQRoiF29feuz8E0B7RFWrjeH67VglcLKa7yJEtBO/ABc8wPTQ+1TlHVa19Z
         geA1ncp1NDgjILqqWrrM3cwFanZRWMIeUqRjmdXoVtNUN/Epb88bzMhMp8PewSnblY+2
         9etN2Agp+2WLPS3vcM8u5SKq+txVm6bBbDBnreErC0bR5a+RQm4VYsFY0z2K63CIk5z/
         0Ctdbp04OVDOcoMedcPdnB7Iw8MsDc4A54rQGYVORFfBY0eY/YNL7kRIKIe5FzAQFvkX
         6YsxbOg6zUyguSwt3b9wb0XTVNrOjQ6j3CUHcWxbcSdjv7GA927nYzpolMCQahG2x+Lw
         zuiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755609434; x=1756214234;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eYMdhxIUQ31/cy7vzWDrnpVEGbQxqOB4QZi3i8Wf6a0=;
        b=dkKEls4xIP2dP2THpoQIdLl8GwFSr26sjWIXcf1x8tdbXXQRhzcsW8ysDegovPg51T
         A94W7FdpdpX/GLlxqPamU8Ck85t+6ldGcF8fyb7hzQZ3cKuU6zZB+Fqpw4r+FToRJIC3
         bga60aniIgKhsn3ptpA3CNQq0RcJcRiAc4duoMPz7Q82ilOLqKbTBjyq8KDSyeEEEaSj
         9gvUKz5M4rIjfBJmoOugAKP3RuiScm5GAdzQ+ORvR0mLjnmpUm6XCTCmx0cf13sfFZdK
         eznt5szLlakguAkyS2JBUqscbVV7qRdBw/hh/2cYOxCmWRDDH/rIdZfgZrYHu92WdqhU
         Hrwg==
X-Forwarded-Encrypted: i=1; AJvYcCXPNbb+iugItaWNZtQ2zk7U7fVPJcbgJHaK/BiMt9hrFXhbQ8LrDKDqqth0tNa95W84dMCywNkpCJuv668=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQrwRcqSt3teRozOsMwFey2B6+Irm59GuJi1xW3G8IQczLh9YN
	fyOFd0hg+ze1ZSgCujnVl+a9xs0gdXGiHtr8HlVc25vi6pA1eu2LV8febCCGJvg2m6A=
X-Gm-Gg: ASbGncvHHWerFRP4H7naSKJRJUWle7wQgU5YWd5dRVKioydzrJPm3xIxDKQIz9Vt2Dd
	PPUm4t/Oe4uQGjGBoT+aqiIfxALcGTRLgyAtOZ5VGN0qeZGjY5tCgy+Ua52VOi6ApSTsQWZDlI3
	H7TJiR5C7Q3MvErvst7pxMW+t7CtE0tY+NC2WO0LUHl8yYrPI0czW3e5/w5uXzlyW9HXcSRr6/A
	tpFx/S+C7F6JWb6jusv3ymZpoi7BDLznndkOIUXUkpQ/+sLrK4YCCoPllCiwNxxTb/jdNQ9z10c
	A5LCNp4veAGSwj7E1ius6GfxxH2gsJ3ZmT7SLblTVfLI3cFTu8bUSPAa060Fg8bGPsLQ7eJdF1p
	9DewOERWJlBj1w+uzb3XfJ7VjUZFvN7aLJQ==
X-Google-Smtp-Source: AGHT+IGKdkV+1r589d0SVRi3O+feTSsj4hmOGvm3/y18TTqAWbPqtEd00j4EtkVL8S15WigaZDcifQ==
X-Received: by 2002:a05:6402:35ce:b0:612:f2fc:2b9b with SMTP id 4fb4d7f45d1cf-61a7e6d953emr1012321a12.1.1755609434365;
        Tue, 19 Aug 2025 06:17:14 -0700 (PDT)
Received: from kuoka.. ([178.197.219.123])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-61a92678f45sm129674a12.18.2025.08.19.06.17.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Aug 2025 06:17:13 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	=?UTF-8?q?Goran=20Ra=C4=91enovi=C4=87?= <goran.radni@gmail.com>,
	=?UTF-8?q?B=C3=B6rge=20Str=C3=BCmpfel?= <boerge.struempfel@gmail.com>,
	devicetree@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 2/2] arm64: dts: stm32: Minor whitespace cleanup
Date: Tue, 19 Aug 2025 15:17:09 +0200
Message-ID: <20250819131707.86657-4-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250819131707.86657-3-krzysztof.kozlowski@linaro.org>
References: <20250819131707.86657-3-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=937; i=krzysztof.kozlowski@linaro.org;
 h=from:subject; bh=CbjadNNNEe8Yn9p48OvNEAWuQJuq9CsOCkHrF+TBmzM=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBopHlUh9ijAKsBRMt2aMyQYJ9QM9JmObsPeF4fB
 AxubSnhgyCJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaKR5VAAKCRDBN2bmhouD
 1xayD/9T2Czt91Y2lD5WnyYHRP0t4bhHs/mS2Qe5NTJa2kew7W8Ij/MB5UdXtd0mQcNRTLa1RmQ
 zXdldkv7Q4qLc0e8j8u6/U+ZeGUQ0TNC0amXAXc1XbKOrQI8RmACzjSwjV7bueIInrNE+Wm3xh4
 JjHAbMbiTxjc5DFkVK33xKIzty0UwuTjB0GrFPdA5aMfnRQTrtyux3nG5b3BrlvheRM8u/iAB05
 YdIBZDyrB7Zp/W2+4lxfUuSmRrp8Q9LZX4mSCVQXPKAgKiHcWYQTTgKcudviMw/owCZrKDmfu8j
 Qyc3qwE5+zfAMMHEZGMMBjxd0eFcXj94nTyZET3KIyG76XwIbyuU82mc11GVAk5x0C5jrIFCwm0
 W8ogs68q1bM6Hj78EeyNLzdnVpg8l8wo9c9WIsJwvT8SALOtFSRGeyTh6Jxq5GnQF1HOJKs/TrK
 kUHl7U3aLmpMrPUtwTDtCSdyhIKxNBdfX6AknvtipYJ24n4a953GkS8UVw2FefBkvaCbt/scdjR
 tTYvQMz0UXez7T6LuMsDNIR9DuKvK0PXXcbn01XzwSaI9YmmDPpiSb+y6RnNHn2aoKNQ1FABysk
 YaI8qpT+itvR0oJ1W1chMdyl7JA5C5KpZdSgnK4kLjb6jjrv190uoih1k91q9q4z2S+Pgak9lV2 zSIyIDqwPENIr1w==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp; fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
Content-Transfer-Encoding: 8bit

The DTS code coding style expects exactly one space around '='
character.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/st/stm32mp257f-ev1.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/st/stm32mp257f-ev1.dts b/arch/arm64/boot/dts/st/stm32mp257f-ev1.dts
index 836b1958ce65..4ff334563599 100644
--- a/arch/arm64/boot/dts/st/stm32mp257f-ev1.dts
+++ b/arch/arm64/boot/dts/st/stm32mp257f-ev1.dts
@@ -100,7 +100,7 @@ &combophy {
 };
 
 &csi {
-	vdd-supply =  <&scmi_vddcore>;
+	vdd-supply = <&scmi_vddcore>;
 	vdda18-supply = <&scmi_v1v8>;
 	status = "okay";
 	ports {
@@ -151,7 +151,7 @@ phy0_eth2: ethernet-phy@1 {
 			reg = <1>;
 			reset-assert-us = <10000>;
 			reset-deassert-us = <300>;
-			reset-gpios =  <&gpiog 6 GPIO_ACTIVE_LOW>;
+			reset-gpios = <&gpiog 6 GPIO_ACTIVE_LOW>;
 		};
 	};
 };
-- 
2.48.1


