Return-Path: <linux-kernel+bounces-756721-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F0F99B1B854
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 18:20:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3CA7F181D69
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 16:20:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 833ED291C24;
	Tue,  5 Aug 2025 16:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nhnhzxwJ"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D7A8291C39
	for <linux-kernel@vger.kernel.org>; Tue,  5 Aug 2025 16:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754410847; cv=none; b=DJeEB7tMS09R69/X32eQTHJT8HoqS+BRMQAD1LYoRESHw8HWYEr6Sp+J4f3YkCn/hldwLkTH9WHQPK5Usd9/cdPEjr77hO0VldCOXUl0zvhd8FDDHKZxIgTZuez+EXjZQtbXt67dgu4jJj3ufnXuNoNRQUGFXFjdRL9od1JDPJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754410847; c=relaxed/simple;
	bh=cBJjmBz2nru2N22Iu/zn8pPdmY8QA0TjfVIDw6+iow0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=alFQCvJSuEEaFrTxNFZoS0JOTDo/TXgTmPkjyn2ltkeH7uWN94mvaAtt4eMIhQ23eCGDnKvEE8qGykxYMAbJUhHrYwzUZ5HgmsZWszjMB3WnkZjNNhJZ1oAPVdzYN89kFQe8ok4/+r+vx6dIRMjnjpHuPZWqJm5Pw+v8DMDnh40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=nhnhzxwJ; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-458bc3ce3beso20909515e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 05 Aug 2025 09:20:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1754410843; x=1755015643; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IGkrmIeLV1rU3rT2THq/+9gyQc/8zpyvBaKc45egPzU=;
        b=nhnhzxwJHFgMBkBXZIkucJrvmCyySqfb5MXw2PDMk1KDW11xeuLtoedB0WH/VrumJx
         EdNqXAs2UTUc8eHvJoWeGpqVCnEDK0TeMUUb6po85mKZJxq/TyAdFtptf579wWmfuuAj
         Is1pcNBHa3dwdSRVbVqpe1fIBps6NT8wrtjqmnHv67z92Ll8pFLzuPjUyjv8QajS3CLw
         nRjIgyWv2l0mResUsaTU/HPKKSCGnkmiZB2OWOYLywdlb6KNzE8YX6P/DIN6ys4Gzlp5
         KAJoivDCCdkcXtamxE3GxFsYngTLm3/8Qk58Zn9/ebSMhc9bldWdL9pDjpc44PZgLshe
         HcCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754410843; x=1755015643;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IGkrmIeLV1rU3rT2THq/+9gyQc/8zpyvBaKc45egPzU=;
        b=SjXrkHB/fnHMIl7cYWdlwaWkz7H1XKnLupK9ERHKecV73nbD6vCx1G6kETwc052XvI
         SMTNDRotj63E959qNQZ0wmLGaKN1tIJp94QfOSU4hD4pdR4DS47IGRQf/EWS3iaUtCRW
         7FGSwWotIKoJ6KahVbs3G1Sffao/dhsukFFdDQmubUA5pc7wChE95b2dCldPcmCohyoN
         XuTN04ln9dEoPV3XSsPI0bsa+2l5WeRVPRNPuHxypCH1G0E0E9CMwo+881NLPTNqJgbm
         Jx4ivMX/PkdFCbUlL4RG4BbwUZFxvFLvPesq2Q8U262eckHPerodY36XccGVnaGTjWao
         pENw==
X-Forwarded-Encrypted: i=1; AJvYcCXUH+0ahSZRzPn/rQv/CHKx+G2hKpSAvxS17ABesx9lFpfKWLvDB+RhuINyo9DxIN3wtkLtCyMWc3Keu/Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YwrJLYIPSKW4Ag+bv7PLW3oDy2Eecn1/T+gGKOzKOLTSA5Ug8UA
	PsxHMSpoeWih0EIocNqaG7CeEFGZ4uqdxKGiwV5jP7elVPaqv1LUsRmx0AVv+5XtzD0=
X-Gm-Gg: ASbGncvnfP9iJrZXuVovKwc5yCpSiNeY9I2w0dch4F3184PYc3Oez7GANzaoHjH+FiG
	JpGG+Wey7aZA8LguoSvLPzGJ/DxwR7sKbiJ2bIiSOldVx4zCmkz71m6RJJygsPjvhr5ohabv5PW
	4kfsfRK/u2hle4IhywhaLZBCqRfjwjF0DkToKXSHb2Te+uApPsFBhXoxEZj5UXw5AQnHVg3M7KK
	7EScYHZKb34Iuvm7wK863vT4cdBZWLZz1FJmSP7A72Fdgyi4hkaBFe0A62YhGkuAcuOSKomzMLt
	T7DmizTJ2X6ZO4OhNLgPcGXzdtuMhrQnGZRdVEh/OIAZS/0uNm/c3EGYIc2FeuKanZ69o+esLC4
	f/rjNnD9o3TPxcC06E0/KNcMMGudJjGi/lS9fL3Q=
X-Google-Smtp-Source: AGHT+IFJTDQFGPN/BiqSqSYEoyKB3J5CeXH8Mn6Txe7Lz7r1rfPY2c8tUvGJMup7h8OCrkxOi1r/Iw==
X-Received: by 2002:a05:600c:4752:b0:456:25aa:e9c0 with SMTP id 5b1f17b1804b1-458b69e3710mr130392835e9.14.1754410842876;
        Tue, 05 Aug 2025 09:20:42 -0700 (PDT)
Received: from orion.home ([2a02:c7c:7259:a00:3fc8:64de:ce84:87a0])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-459e5873c43sm12023575e9.22.2025.08.05.09.20.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Aug 2025 09:20:42 -0700 (PDT)
From: Alexey Klimov <alexey.klimov@linaro.org>
To: andersson@kernel.org,
	konradybcio@kernel.org,
	linux-arm-msm@vger.kernel.org
Cc: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	srini@kernel.org,
	quic_ekangupt@quicinc.com,
	krzysztof.kozlowski@linaro.org,
	dmitry.baryshkov@oss.qualcomm.com
Subject: [PATCH v2] arm64: dts: qcom: sm8750: Add adsp fastrpc nodes/support
Date: Tue,  5 Aug 2025 17:20:41 +0100
Message-ID: <20250805162041.47412-1-alexey.klimov@linaro.org>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

While at this, also add required memory region for adsp fastrpc.

Tested on sm8750-mtp device with adsprpdcd.

Cc: Ekansh Gupta <quic_ekangupt@quicinc.com>
Cc: Srinivas Kandagatla <srini@kernel.org>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Alexey Klimov <alexey.klimov@linaro.org>
---

v2:
- removed qcom,non-secure-domain flag as requested by Srini.

Prev version: https://lore.kernel.org/linux-arm-msm/20250502011539.739937-1-alexey.klimov@linaro.org/

 arch/arm64/boot/dts/qcom/sm8750.dtsi | 69 ++++++++++++++++++++++++++++
 1 file changed, 69 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8750.dtsi b/arch/arm64/boot/dts/qcom/sm8750.dtsi
index 4643705021c6..cc74fb2e27de 100644
--- a/arch/arm64/boot/dts/qcom/sm8750.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8750.dtsi
@@ -7,6 +7,7 @@
 #include <dt-bindings/clock/qcom,sm8750-gcc.h>
 #include <dt-bindings/clock/qcom,sm8750-tcsr.h>
 #include <dt-bindings/dma/qcom-gpi.h>
+#include <dt-bindings/firmware/qcom,scm.h>
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/interconnect/qcom,icc.h>
 #include <dt-bindings/interconnect/qcom,sm8750-rpmh.h>
@@ -523,6 +524,14 @@ llcc_lpi_mem: llcc-lpi@ff800000 {
 			reg = <0x0 0xff800000 0x0 0x800000>;
 			no-map;
 		};
+
+		adsp_rpc_remote_heap_mem: adsp-rpc-remote-heap {
+			compatible = "shared-dma-pool";
+			alloc-ranges = <0x0 0x00000000 0x0 0xffffffff>;
+			alignment = <0x0 0x400000>;
+			size = <0x0 0xc00000>;
+			reusable;
+		};
 	};
 
 	smp2p-adsp {
@@ -2234,6 +2243,66 @@ q6prmcc: clock-controller {
 						};
 					};
 				};
+
+				fastrpc {
+					compatible = "qcom,fastrpc";
+					qcom,glink-channels = "fastrpcglink-apps-dsp";
+					label = "adsp";
+					memory-region = <&adsp_rpc_remote_heap_mem>;
+					qcom,vmids = <QCOM_SCM_VMID_LPASS
+						      QCOM_SCM_VMID_ADSP_HEAP>;
+					#address-cells = <1>;
+					#size-cells = <0>;
+
+					compute-cb@3 {
+						compatible = "qcom,fastrpc-compute-cb";
+						reg = <3>;
+						iommus = <&apps_smmu 0x1003 0x80>,
+							 <&apps_smmu 0x1043 0x20>;
+						dma-coherent;
+					};
+
+					compute-cb@4 {
+						compatible = "qcom,fastrpc-compute-cb";
+						reg = <4>;
+						iommus = <&apps_smmu 0x1004 0x80>,
+							 <&apps_smmu 0x1044 0x20>;
+						dma-coherent;
+					};
+
+					compute-cb@5 {
+						compatible = "qcom,fastrpc-compute-cb";
+						reg = <5>;
+						iommus = <&apps_smmu 0x1005 0x80>,
+							 <&apps_smmu 0x1045 0x20>;
+						dma-coherent;
+					};
+
+					compute-cb@6 {
+						compatible = "qcom,fastrpc-compute-cb";
+						reg = <6>;
+						iommus = <&apps_smmu 0x1006 0x80>,
+							 <&apps_smmu 0x1046 0x20>;
+						dma-coherent;
+					};
+
+					compute-cb@7 {
+						compatible = "qcom,fastrpc-compute-cb";
+						reg = <7>;
+						iommus = <&apps_smmu 0x1007 0x40>,
+							 <&apps_smmu 0x1067 0x0>,
+							 <&apps_smmu 0x1087 0x0>;
+						dma-coherent;
+					};
+
+					compute-cb@8 {
+						compatible = "qcom,fastrpc-compute-cb";
+						reg = <8>;
+						iommus = <&apps_smmu 0x1008 0x80>,
+							 <&apps_smmu 0x1048 0x20>;
+						dma-coherent;
+					};
+				};
 			};
 		};
 
-- 
2.47.2


