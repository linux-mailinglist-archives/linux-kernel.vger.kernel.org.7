Return-Path: <linux-kernel+bounces-781560-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8155BB31425
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 11:51:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 27F0F3BE47F
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 09:45:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C26052EB5A6;
	Fri, 22 Aug 2025 09:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kbYnqG4A"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 989EF2EF65F
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 09:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755855575; cv=none; b=fQYZ6hJ3TWPZwXo0r1wwHcvcK9oe74ZWp++KMp97R2L3L63pVJPU3T4yTejFS5LIHEoXkFUGj26/N2MeM1xATn99R0zG5et4CFGuq/iG+9jNOBiSK+Av0iNGkvWoNpSJ/8IPVGLdQCBJaKtbkW+cb5CEoYYfL3J0qL5Fu1ohGzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755855575; c=relaxed/simple;
	bh=IVLr7G5CNd1mqLrgQvVKCpA6gBxqxPNhBzSeQuBgqi4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=du77fSfdlddG9uH2moMK9jd16boQ2BFWf7AW3gnz5ptEjBOxe9OSzN2gHfqQIzdxasE6EU8vnBh5U/lnsJU3eTjs+wH99Qb9QKPSa0b2QkjExqYuRt9QoLDyC2lT1nDOHm6o2rUhZEd1yJp7w/dXCc/f0bd3EPm3mdWs3ymHoow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=kbYnqG4A; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-45a1b098f43so14109625e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 02:39:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755855568; x=1756460368; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sHIXsS+Alr8U93l1XOYaFtoBwmCHuYPMxDTFbbYlAd8=;
        b=kbYnqG4AvTHrAjGpl7xEoG5USmhfp0K8WuD1uQ69kgYQTX0c+HfJakxcRcm7Txd/Pr
         8yJXsKgGQJM2TlkfqC6M7zd1yPk3TIHhTXNEhab1esSe1DeN0UGn+YwIfXw1rlCx22XT
         V3M4BTr6ehNlzEpOLqShmgAa7++sqoYdrhXbmaAL2Jlitt/nRNnAu0ttzSy6nM/kHpgS
         2uXcVcCO9RMhSu20lyuM9ak79yJy5Fwfu2hJcOXcDL3ShOLV/nSdrXBD6f7WXzFJvHEJ
         QOtpt1werHVNeZsHLCieUrb11C7oz8hWIrG/w9bzN3D7ijKpGxlEoyLs9vwQRiEWTaUi
         QaKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755855568; x=1756460368;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sHIXsS+Alr8U93l1XOYaFtoBwmCHuYPMxDTFbbYlAd8=;
        b=DMocDoY4UEvN0oTAyPP+AvM02wxIlgF2u+NuFSLKZdRRK25brUxrS81gwveasQRE5u
         xjvOk1Dh5VP2RZpvojYKkYV2LWdvr+uDi/Hnr+V+7B5EqnRQXp4AXsYVcR2ccNmF+usl
         tR7hYme6lUHXUVN02nnb7oNXxxOaGN1Lki2UeGYHwMTMqTKfKv4eJnzoevwZLVdVgjSS
         IU19o1KF7rFDs4eJZvlz02MNHRz1Xx/NelR6jUz3ca9CcOeEkjnBvxKKIzUpZOCwUIbT
         y56IHw+rd4SkzUi6Cu1Zug9mJo0k+X5HpBGEzCKH3opfnV7WutMTfkSsPUbNeCiIItGm
         c32w==
X-Forwarded-Encrypted: i=1; AJvYcCWbfqejKzR1ynDD22hLFbDX3v4dlAQhYydNTCeRavdJrtug7tGsTZTuhCZEXi2uQYg8Qr2G8l7BmnB//oQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRxJJbPJi5Esvfpr1CoXmTv1cPJpka2KxUIA3abIvOnBoRoufa
	PSo24eW61YoaY9FOWMytQGV+4sWdryKMI/Ii/uLJFq/rFeaup766G4qRU/y+jrP7VdA=
X-Gm-Gg: ASbGnct247OokrBCB6psGg2biDT7kB0pxm26vz6XBOcweU/uXb+ldCbyOWg+7DIvhY7
	K9I94wAkCmy7js7wxMw2Ewia6KTBzvTAzR0HY0n8eMU4nuZ2DswpMzR0/DO7yP2PagxT6GTVYdp
	7NRyz5h22HKmuB3CyxQqhXlAzAT2C+5NV+r6tNk4stuXrpxBKOQbhD51KJ10z/0ql4R6SexYa1h
	+kQ76HuSjNyIQNRp5XwxHGcXvP/o33MLKQVByLoptcF8VgQCZp2v9/EWL+plATODJkqwza6HHoQ
	PiBReOnYSJov0LHmnMP2b/MiBBof9duwGMAEHLEJ5mnSweG8DQudo+M1sF0HtPBNNFaX+KHEZId
	rVRttbl/6xq63xu0wvJuJrAwV6HjoqumEFrJkuq4mboo=
X-Google-Smtp-Source: AGHT+IEfZNR0YczZ6ueKNvaEDwWLUmdVBx2nsk21YsqEFRkij5/C3GhysJVqrTLvlLx+EdblKwR4Xw==
X-Received: by 2002:a05:600c:3552:b0:459:dde3:1a33 with SMTP id 5b1f17b1804b1-45b517d26d4mr19119525e9.26.1755855567580;
        Fri, 22 Aug 2025 02:39:27 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:3d9:2080:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3c684524163sm609890f8f.61.2025.08.22.02.39.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Aug 2025 02:39:27 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Fri, 22 Aug 2025 11:39:21 +0200
Subject: [PATCH v2 09/16] arm64: dts: qcom: x1e78100-lenovo-thinkpad-t14s:
 Set up 4-lane DP
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250822-topic-x1e80100-4lanes-v2-9-4b21372b1901@linaro.org>
References: <20250822-topic-x1e80100-4lanes-v2-0-4b21372b1901@linaro.org>
In-Reply-To: <20250822-topic-x1e80100-4lanes-v2-0-4b21372b1901@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1102;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=IVLr7G5CNd1mqLrgQvVKCpA6gBxqxPNhBzSeQuBgqi4=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBoqDrFBWwNFJRuZ+wGXn76jklVMu2OmpJGTRTmL+Th
 LrDbCJGJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCaKg6xQAKCRB33NvayMhJ0T33EA
 CawvbNbNt8lOZkEpTY9GqGM/7FaChv1XZFpeL2pBkXyWCahuSZxpUUS9kRJ3CX69vFww7k1rzGQxy+
 ufKxxK/iRtQLsN+a1OWBek4Rul0gg/nzaMkG/b8afaHVeyMI5OCvwxXg08/WfSEnOve2wtzS7sfG4S
 S8AY/3+PAXVcp1uQhPMjy1OElm5AgzoYewx2oWtbqKx4PiC5Nwc+5Hto8ehDKTnLa9G+J3zJbzepsC
 yrnYs2ob5pn9OtSkuuwuXN9jC2CCun++KeLFYG9E1W0/gl12ioKfiy+Z2n3tcNVh33MP2J5ki1poHu
 lJuWhtW/nQV7476HcI9M+cnR8aQ/rMtBpKUy4l5IEtJzezJJIFbR27NroFMJU7kSKG6MvKlSyegitR
 V7b4hJfFMcMRUzPwlrNKSlmtCVDVOOFKqM003hCsN7Kq6hRg4xERlIILiz2hwWJbFaweU5TZq2MviE
 A2v8kanQ+sG9Ql79Vt290w+dzmBSDnVCAcYHPO3DP3f1UyR6ojBSFqnun9XGFIdOgRP7uWt6MzGu+N
 VWZ851Lg1j/yRyMhOR+rAKKZ7Ff2AoQpqj1V7DMiQCSsGvKMjf+P5SqLBEr+5Gyzc1tjFGHjlZedAO
 PYTDpnnVEZPVRpdPhiPu+igBu2fTaWgftagMHUO74ObrleCjxAlJ768uyLnQ==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE

Allow up to 4 lanes for the DisplayPort link from the PHYs to the
controllers now the mode-switch events can reach the QMP Combo PHYs.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 arch/arm64/boot/dts/qcom/x1e78100-lenovo-thinkpad-t14s.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/x1e78100-lenovo-thinkpad-t14s.dtsi b/arch/arm64/boot/dts/qcom/x1e78100-lenovo-thinkpad-t14s.dtsi
index 4cf61c2a34e31233b1adc93332bcabef22de3f86..9f965a5faaa9b687ad0aa609fe42e4841c7f7d63 100644
--- a/arch/arm64/boot/dts/qcom/x1e78100-lenovo-thinkpad-t14s.dtsi
+++ b/arch/arm64/boot/dts/qcom/x1e78100-lenovo-thinkpad-t14s.dtsi
@@ -994,7 +994,7 @@ &mdss_dp0 {
 };
 
 &mdss_dp0_out {
-	data-lanes = <0 1>;
+	data-lanes = <0 1 2 3>;
 	link-frequencies = /bits/ 64 <1620000000 2700000000 5400000000 8100000000>;
 };
 
@@ -1003,7 +1003,7 @@ &mdss_dp1 {
 };
 
 &mdss_dp1_out {
-	data-lanes = <0 1>;
+	data-lanes = <0 1 2 3>;
 	link-frequencies = /bits/ 64 <1620000000 2700000000 5400000000 8100000000>;
 };
 

-- 
2.34.1


