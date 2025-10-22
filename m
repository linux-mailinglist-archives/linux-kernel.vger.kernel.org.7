Return-Path: <linux-kernel+bounces-864203-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E105BFA296
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 08:07:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5CAE51899D10
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 06:07:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6AB32ED866;
	Wed, 22 Oct 2025 06:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="goBYNmik"
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB7782EC0B0
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 06:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761113230; cv=none; b=aRHAyL5hcP9cjoWfeyDJKAUvYj5y02MX2zGCvUN44WVWWCMAijTeNaIsSr12X6sqdydkjPB/zBXR8xat6vsdwrKx7onhoZqTFrLKcxs4GUsGHCAqy0kc4zM8Y6CLeXztXdxAqMGFzmWRSYS88R9ooy1FSkXYPWrAzi8CXx9Mq3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761113230; c=relaxed/simple;
	bh=mzm8zjzGXa3bcj2hI1nuVqjf+8xVLhv71Tv/OMlTJC0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ozr3+x2Zky4P8af5D8DMeudaJk92/AG0SdFTWOqWNcBfdkID05bMXolyYlbxlfctxv8USV26+mUN69JRXsDnkjTObB9a9bsCWBlhGd4uApibJb+WWdAVDUiX2RCTERQQUHB+kwd1H4QmS2l9iXGXmIl8bCq+0zm1GVYodv2lsSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=goBYNmik; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-42420c7de22so3034371f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 23:07:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761113226; x=1761718026; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aGUtKwd70bSCJqEqH6YRK5k2F3XmhHRzuE4jsE9R33M=;
        b=goBYNmikQGygkSpVuRz8dAbPiRYC9TRrEh6KpIqKiosrggp/7509WAj+m/jvF33bNL
         gDPuuo89pq3QiZrWIvUFi5tN9SW7JDiZ7IP2Bv2T7XZzdfuqk1+vdpnHYfxbBRMIvnnw
         itdjjURPMwYBzSk2yAQR+/pJ7mInVMlUg6xWpaKO/Vo3LXcc4vP9TPtA91xt2OpF+2tM
         2pyDEq2eUJZp83oEF47C2lLf2lLaRzNjONDwsj6hrdLxetd6WYCwaJcMAefe/taQP+y5
         KCbfgx6rCmeJwAxQjpjRdiRwGXsidrJLstjFxibrR1lUssZefDU1cMRkK+xAwOHeIyjI
         fy8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761113226; x=1761718026;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aGUtKwd70bSCJqEqH6YRK5k2F3XmhHRzuE4jsE9R33M=;
        b=WEZWh2z2JQibnMLvE1+NUnMq1LnVdAv8Pu8NssKhbnTSd3YkTCKb23bUdXJ+I/kVho
         LRBc+UgJHDgFkUvwZWfWyUgN7MgD5vYb6p99XdYSGWfAKoPyEjVm7ihAGm/HpBkQFXb+
         5CGZFOyB7TXCxCmfDB1PRH+2eFU5u37Rz41UhTiBZr2erSeJTiS71lG+9rd7v4MWPZJ7
         jls+vygSs17Y1xZbIrD/5G6pMCWrKif5D8/seFTceUcdzyrHqxlvWkL9bscpj8MI0iBf
         gCNaXrbQD0XYSxsfL2ej6v8ahJVMt71MIIVODHS3myy2Y6pJCy7/D38tkC4KIgH0BYR8
         uS6Q==
X-Forwarded-Encrypted: i=1; AJvYcCXw66UOIFB0qV1KkzSZU/erH2es0y5loBBWughgKmQU1ZcHySIizyb7De7kCbD2qPN7VbYPLloJCm7xuTM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7Jhu+VEuT9L1SJIya9QfUkEO0sF+TrsJd50RLQzNe0Ww+Whdm
	OA/3v8buXp79iQK/KfpsxlG0jP7gW2W6qf4D4QG9a11GoPNDUrYM3Pyx5e0vWaQE62g=
X-Gm-Gg: ASbGncvWizAQWgw38p+wCIOLg4oZI7PuXRQA/Vxp3RvliKQ9HrX4BLwSPPMKIpzOelM
	h7RBwS6E290HaIOhuFKEfbpJOBWR2CjpGUGe7yVZhZOGs7GqS8d+ENMqoZGXDgX+rIFHmTVWQio
	5TQl9zLLTiGbGw9uUy1dKw5nNznql68gChw8NxWUSbYNL+S3s42Xsw2YzQKxotSEgMKtDn58fnJ
	6yZTO3yvejwzd54Fe06EDFI8VDuZ3uhQJa9pTUjPfPg345DoJcwn+KCrkrJKjg63ffkXoQ+hpPs
	JVGakCTR1HWCjEzcrgHuXtmq8Ove/NGZPeeoHgIvcyEfj7RJlVaxlC3EA08BgC1bZ+4dJlVyccW
	nHNI880v0H5NeeYTma87YhEHu1E46iVrHlLJXNp3vHgrheUJu1ubId72/6IwQgJ2s63JUZGdgkj
	N2+FxVDoiHxGPQOCJp
X-Google-Smtp-Source: AGHT+IFMMvPFqbCgXFrKUM10p7J2tPmq2z1/eAW/zj9g6TRaqGihpOwAHdCmyorfaFbNXlUU5ZMJLg==
X-Received: by 2002:a05:6000:400a:b0:3ee:3dce:f672 with SMTP id ffacd0b85a97d-42704d146c1mr11064085f8f.4.1761113225910;
        Tue, 21 Oct 2025 23:07:05 -0700 (PDT)
Received: from orion.home ([2a02:c7c:7259:a00:11f4:2b3f:7c5a:5c10])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-427f009a75bsm23794067f8f.23.2025.10.21.23.07.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 23:07:05 -0700 (PDT)
From: Alexey Klimov <alexey.klimov@linaro.org>
Date: Wed, 22 Oct 2025 07:06:41 +0100
Subject: [PATCH v3 1/3] arm64: dts: qcom: qcm2290: add APR and its services
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251022-rb1_hdmi_audio-v3-1-0d38f777a547@linaro.org>
References: <20251022-rb1_hdmi_audio-v3-0-0d38f777a547@linaro.org>
In-Reply-To: <20251022-rb1_hdmi_audio-v3-0-0d38f777a547@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
 Srinivas Kandagatla <srini@kernel.org>
Cc: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-sound@vger.kernel.org, 
 Alexey Klimov <alexey.klimov@linaro.org>, 
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>, 
 Dmitry Baryshkov <lumag@kernel.org>
X-Mailer: b4 0.14.2

Add APR (asynchronous packet router) node and its associated services
required to enable audio on QRB2210 RB1 board.

Cc: Srinivas Kandagatla <srini@kernel.org>
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Alexey Klimov <alexey.klimov@linaro.org>
---
 arch/arm64/boot/dts/qcom/qcm2290.dtsi | 72 +++++++++++++++++++++++++++++++++++
 1 file changed, 72 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/qcm2290.dtsi b/arch/arm64/boot/dts/qcom/qcm2290.dtsi
index 08141b41de2462ce91896fd84644413fa46ac047..7303aff33814f256a2ea09a71a640db466370eff 100644
--- a/arch/arm64/boot/dts/qcom/qcm2290.dtsi
+++ b/arch/arm64/boot/dts/qcom/qcm2290.dtsi
@@ -17,6 +17,8 @@
 #include <dt-bindings/interconnect/qcom,qcm2290.h>
 #include <dt-bindings/interconnect/qcom,rpm-icc.h>
 #include <dt-bindings/power/qcom-rpmpd.h>
+#include <dt-bindings/soc/qcom,apr.h>
+#include <dt-bindings/sound/qcom,q6asm.h>
 
 / {
 	interrupt-parent = <&intc>;
@@ -2077,6 +2079,76 @@ glink-edge {
 				label = "lpass";
 				qcom,remote-pid = <2>;
 				mboxes = <&apcs_glb 8>;
+
+				apr {
+					compatible = "qcom,apr-v2";
+					qcom,glink-channels = "apr_audio_svc";
+					qcom,domain = <APR_DOMAIN_ADSP>;
+					#address-cells = <1>;
+					#size-cells = <0>;
+
+					service@3 {
+						reg = <APR_SVC_ADSP_CORE>;
+						compatible = "qcom,q6core";
+						qcom,protection-domain = "avs/audio",
+									 "msm/adsp/audio_pd";
+					};
+
+					q6afe: service@4 {
+						compatible = "qcom,q6afe";
+						reg = <APR_SVC_AFE>;
+						qcom,protection-domain = "avs/audio",
+									 "msm/adsp/audio_pd";
+						q6afedai: dais {
+							compatible = "qcom,q6afe-dais";
+							#address-cells = <1>;
+							#size-cells = <0>;
+							#sound-dai-cells = <1>;
+						};
+
+						q6afecc: clock-controller {
+							compatible = "qcom,q6afe-clocks";
+							#clock-cells = <2>;
+						};
+					};
+
+					q6asm: service@7 {
+						compatible = "qcom,q6asm";
+						reg = <APR_SVC_ASM>;
+						qcom,protection-domain = "avs/audio",
+									 "msm/adsp/audio_pd";
+						q6asmdai: dais {
+							compatible = "qcom,q6asm-dais";
+							#address-cells = <1>;
+							#size-cells = <0>;
+							#sound-dai-cells = <1>;
+							iommus = <&apps_smmu 0x1c1 0x0>;
+
+							dai@0 {
+								reg = <MSM_FRONTEND_DAI_MULTIMEDIA1>;
+							};
+
+							dai@1 {
+								reg = <MSM_FRONTEND_DAI_MULTIMEDIA2>;
+							};
+
+							dai@2 {
+								reg = <MSM_FRONTEND_DAI_MULTIMEDIA3>;
+							};
+						};
+					};
+
+					q6adm: service@8 {
+						compatible = "qcom,q6adm";
+						reg = <APR_SVC_ADM>;
+						qcom,protection-domain = "avs/audio",
+									 "msm/adsp/audio_pd";
+						q6routing: routing {
+							compatible = "qcom,q6adm-routing";
+							#sound-dai-cells = <0>;
+						};
+					};
+				};
 			};
 		};
 

-- 
2.47.3


