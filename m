Return-Path: <linux-kernel+bounces-745223-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC688B116CD
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 05:00:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 139657B8B83
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 02:58:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48FD623C516;
	Fri, 25 Jul 2025 02:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="VvrQO5ng"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E8B123AE79
	for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 02:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753412369; cv=none; b=UMVUvPSce6AtJ/ulAxZrU06geqpDQrWGdtRjXiytV74jWWWTfpKpHbV4/OOESAtp17oETmx05/sCV6WKCwtzIzTpcq7fZAVNYOb4yFBEiLtbPDHBnSy16xHRjCdZVULne/onA8Z87SCyjPfUkXu6hTONvZS4IyUhvP/12Yedwio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753412369; c=relaxed/simple;
	bh=ADhd5fIXjQjOrrjMnH2k2op7LwADIGQm+gzioqeb5HQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=h7VAiRjdufagBNy8EVgSGJ0sM23rkoevr4E3PWKbH3bBlv9f52RaGep8V9VeiBO9X86dPzE/FEq4vUq5iTtTlytgir3e2oFe6SUQLQi/HPgOKeauYg0yOUCFpYVHnXeyS671tc+3dTAb6MBkWkVLN2wpARw5HE/hs3jOOAKTqI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=VvrQO5ng; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56OLmucT017964
	for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 02:59:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=98ePQrduhIwjpcm653ufQE
	XytefjL9vIQFJJoh/WjiA=; b=VvrQO5ngCMd8f041eZD/GYpG6EeNt/yGEQE5vI
	Qrh1JS6z7cyG9BwHrOrl1KrdWg0ASFwyBoe3VWyBZnGK1jXP4IytV+/jwsyAcFsO
	Wpoo3XDQQ5IxBpQjQaEfdky1nSrTXxMtaFK15gm8NdjS7DbvwFVbsXyrCKigep37
	Q09SMLvUvZU/oEAfFoLo+Ojfkmb0u8In5nYCXaXmIMou3WGu4EgORE5Vs4upWs/v
	rF+OA66seshnYbTWdUMzWJ9EBV1ybetgSNGlhuA7H8BtthfgnOJJqxUOuES4Ofty
	WYyMpHO7EBUzTc7k0vi7t/NaP+Wr+n+LE7RupNq1z4g051/w==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 483w2wgkxr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 02:59:26 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-6face45b58dso25695806d6.3
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 19:59:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753412364; x=1754017164;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=98ePQrduhIwjpcm653ufQEXytefjL9vIQFJJoh/WjiA=;
        b=Z8Vyx1EcPln4lSDzCR2I0kFTAJiRtPszFXEsRRIshgvNBNqdZuGvxhEBBPo7lslk6f
         62OxSljsSCk0WLuLbvTCum6upCrh+EQky7jbD54jMdBo67K6rosoHzTTEhrclBmvnoV3
         Z1SvbKUR1sHBdsRmA5RgKgp4hZwSTJq98XpQ6NZZZR8724KC6a4N4ClXqOvw54wcHLMR
         aF/8BgMVQqRvs0d6ZpEx6zI0mG5yKlCImRCzc31eQUR0fbEv2r8WatU6SJXtuLadplUa
         o+qT/uW9NYtbhkKq8Hwka0v0rEwsYeD6GLunHewD2oSV06HG8tLzlKtl6X5sNPvtpE5Q
         21Ng==
X-Forwarded-Encrypted: i=1; AJvYcCWE9cTZvzLR3sik1TbRRXa83pYKlJm22nfGdqbXuwzKAuecipdZ8eB2iWIiFBjy2MLcnlZ5hwNGN62msfA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJTZM6cvbPVNHkGtpx/J/BD8uqGcrB85vnPrx6xMQ8Y4w/q8jA
	8LFu0Ny86vA0jspT5iQMpyHrwEBJxYEDcakUnaC6JnHepXNcvlOOiSjHU1bW3CBvI24SyOZUAuE
	X/EGue2cW6N4bO+2cLiA/qDaxdKWBzFs1gKJ3GNDzn+HTCBzoLQe+lAbMHYo2xWrMH0eXUkG2aX
	o=
X-Gm-Gg: ASbGncv7rD17h6eOht2bkeDdVSpBvDliORanIMa5RuXR9t+eVYO79A/V+C6/wfDwMfM
	LIIGJmRLGpgIYLfqnRBF4eL+ryUpVBeNFT196yK00KGypyeB1HsYgneZ4P1y6W4sI1cgYXW1HQ5
	+dqbSHxb3cHWn8pQu3ikPYKtCohHC/H5dQ/KFD4l/i6RnSEHMf/wb1eMOROrnjFxXg1RrmlNg+k
	zJ8vfMAo91IcRGGZrIoZXotxhvULfXphrvweH7J8o3NqqDzMAwZR4ZuDs9dGTxlNE3BSQou35Rh
	/xfJbaKmyfT+p/4w/moCiKpRs9XBmKzVav1p7sks09iWwzbhk0uImicO3fGH2e3YwQISArrBxiF
	EwGQsAxU9I6rrfU94M3oBAtNY5CiKtz4ySEL4FOr2TcWTqVoTwbKX
X-Received: by 2002:a05:6214:21ca:b0:702:c042:82a2 with SMTP id 6a1803df08f44-707204e94e9mr3742386d6.4.1753412363645;
        Thu, 24 Jul 2025 19:59:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFMbX6Qd0BmjHr7VamnS4j355UJ/sKYNIx8aX+Ltz/At8LWy90RYl1VwxOjGCbU8Q4v8WOM6Q==
X-Received: by 2002:a05:6214:21ca:b0:702:c042:82a2 with SMTP id 6a1803df08f44-707204e94e9mr3742116d6.4.1753412363087;
        Thu, 24 Jul 2025 19:59:23 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55b53c86c56sm666730e87.150.2025.07.24.19.59.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jul 2025 19:59:21 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Fri, 25 Jul 2025 05:59:19 +0300
Subject: [PATCH] arm64: dts: qcom: use DT label for DSI outputs
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250725-msm-dsi-outs-v1-1-18401fb9fc53@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAAbzgmgC/yXMyw6CMBCF4VdpZu1EqBeQVzEsCj3qLFq0UwwJ4
 d1tZPmd5PwrKZJAqTMrJXxFZYoF9cHQ+HLxCRZfTLayl6qxZw4a2KvwNGdl71vcrs1Q49RSubw
 THrL8c/d+d8JnLtW8jzQ4BY9TCJI7E7HkY3Cakajfth9ZB9G8jQAAAA==
X-Change-ID: 20250724-msm-dsi-outs-dd8e967b1e38
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        cros-qcom-dts-watchers@chromium.org
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=9591;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=ADhd5fIXjQjOrrjMnH2k2op7LwADIGQm+gzioqeb5HQ=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBogvMIeTWzPWjVPRVG65WeRJuBwVmwuDRaXtWn4
 4uw7pMmFkyJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCaILzCAAKCRCLPIo+Aiko
 1eJtB/9szF01ej+EKnL2fanpXV4Dscf5jcp7XRIJf5d5cTgnhAFujN3p+RSnKkfGqnUcXmY6Gfx
 rLZ6Ocwnzfsywbhg0gVP3d7cGkQB+b27U1aiObEWBJsNqxIhUoOg1ulG7fC7SGH6gpPCO/Zt7os
 hmJyFvqSRKrar7yMxfUhW3BCmybg7GCVX1O7ScIhs9zVaiHcLy14unzDOMN76Hr/S/veEYjDJAl
 OoRQTRkTW5Ct2YU5+Ow/nT+scNT4MKGICQnPaVF2Ia//xB3Hw4GwmqZYFNNTsOAonzBLNav86Bi
 9nDQu6OxR2xcaKRsNblhAiS49jYrma/E6dDPmsriuVXcmpOP
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-GUID: WmVD6v1s2ghGNt0JC7NpE_W_FeyEFv7q
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI1MDAyMyBTYWx0ZWRfX7uFyuIU14Za1
 8zRzOAyLcDm6p+ez6MaiSBUIFrJz29gxaXHCf6C+ELQA8nEZ/SRzX7QZLZq3ehTpslIR3mkERES
 y/zIPifvtBUG8oYSxdAaig8R2fXWbA3cnaIjRnJefGNonv9AU0kNbgShnxobNQ74ixSpR2mRemD
 ZE393ZSY+F5bhK2ggkn/1sUeRrink3wi3GRYizya0kTRo2wdtdQMbapH1S/zpWTw7tdxmBefXLO
 dEuivXASyuBvOdNYt6QiwlRNdnS6MAC4AGid0ChNNBcx+SorLlskLrWVDRdl+D/oLP62+bnN62W
 zLZyYXDZeikbkNx6wLMrx9b4KXZM3v8fMNKXBqAMjH1jWbXIo9qDkulUSHTXKY+KcJdAkXKqa1+
 m1oEUXCF+YAoGblXLtMW0trFKWjhONJa5s8uqJJmWWLo1FUDxiUAXYc7Mdk+076VbTNnUzkU
X-Authority-Analysis: v=2.4 cv=d8b1yQjE c=1 sm=1 tr=0 ts=6882f30e cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=jGMoaR9wFmQ_lgbDJXsA:9 a=QEXdDO2ut3YA:10
 a=iYH6xdkBrDN1Jqds4HTS:22
X-Proofpoint-ORIG-GUID: WmVD6v1s2ghGNt0JC7NpE_W_FeyEFv7q
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-25_01,2025-07-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 priorityscore=1501 phishscore=0 adultscore=0
 lowpriorityscore=0 suspectscore=0 spamscore=0 mlxlogscore=968 impostorscore=0
 mlxscore=0 clxscore=1015 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507250023

Instead of keeping a copy of the DT tree going down to the DSI output
endpoint use the label to reference it directly, making DTs less
error-prone.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/qrb5165-rb5.dts           | 12 ++++------
 arch/arm64/boot/dts/qcom/sc7180-idp.dts            | 12 ++++------
 .../dts/qcom/sc7180-trogdor-quackingstick.dtsi     | 12 ++++------
 .../boot/dts/qcom/sc7180-trogdor-wormdingler.dtsi  | 12 ++++------
 arch/arm64/boot/dts/qcom/sdm845-cheza.dtsi         | 12 ++++------
 arch/arm64/boot/dts/qcom/sdm845-db845c.dts         | 24 +++++++-------------
 arch/arm64/boot/dts/qcom/sdm845-mtp.dts            | 26 ++++++++--------------
 .../boot/dts/qcom/sdm850-lenovo-yoga-c630.dts      | 12 ++++------
 arch/arm64/boot/dts/qcom/sm8150-hdk.dts            | 24 +++++++-------------
 arch/arm64/boot/dts/qcom/sm8350-hdk.dts            | 12 ++++------
 .../boot/dts/qcom/sm8650-hdk-display-card.dtso     | 15 +++----------
 11 files changed, 56 insertions(+), 117 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/qrb5165-rb5.dts b/arch/arm64/boot/dts/qcom/qrb5165-rb5.dts
index 33ecbc81997c5ecb5606c7555adefd1a53634b80..d99448a0732d9d165be1b5a1b1e15b2424b98b55 100644
--- a/arch/arm64/boot/dts/qcom/qrb5165-rb5.dts
+++ b/arch/arm64/boot/dts/qcom/qrb5165-rb5.dts
@@ -725,15 +725,11 @@ &mdss_dsi0 {
 	qcom,dual-dsi-mode;
 	qcom,master-dsi;
 #endif
+};
 
-	ports {
-		port@1 {
-			endpoint {
-				remote-endpoint = <&lt9611_a>;
-				data-lanes = <0 1 2 3>;
-			};
-		};
-	};
+&mdss_dsi0_out {
+	remote-endpoint = <&lt9611_a>;
+	data-lanes = <0 1 2 3>;
 };
 
 &mdss_dsi0_phy {
diff --git a/arch/arm64/boot/dts/qcom/sc7180-idp.dts b/arch/arm64/boot/dts/qcom/sc7180-idp.dts
index 0146fb0036d44893237520aae5449931f17f1cc2..19cf419cf531f353f17b83b89ec57dac697d5134 100644
--- a/arch/arm64/boot/dts/qcom/sc7180-idp.dts
+++ b/arch/arm64/boot/dts/qcom/sc7180-idp.dts
@@ -323,15 +323,11 @@ panel0_in: endpoint {
 			};
 		};
 	};
+};
 
-	ports {
-		port@1 {
-			endpoint {
-				remote-endpoint = <&panel0_in>;
-				data-lanes = <0 1 2 3>;
-			};
-		};
-	};
+&mdss_dsi0_out {
+	remote-endpoint = <&panel0_in>;
+	data-lanes = <0 1 2 3>;
 };
 
 &mdss_dsi0_phy {
diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor-quackingstick.dtsi b/arch/arm64/boot/dts/qcom/sc7180-trogdor-quackingstick.dtsi
index ff8996b4de4e1e66a0f2aac0180233640602caf3..4bea97e4246e160bbd4497551a15a9abe50167e3 100644
--- a/arch/arm64/boot/dts/qcom/sc7180-trogdor-quackingstick.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor-quackingstick.dtsi
@@ -90,15 +90,11 @@ panel_in: endpoint {
 			};
 		};
 	};
+};
 
-	ports {
-		port@1 {
-			endpoint {
-				remote-endpoint = <&panel_in>;
-				data-lanes = <0 1 2 3>;
-			};
-		};
-	};
+&mdss_dsi0_out {
+	remote-endpoint = <&panel_in>;
+	data-lanes = <0 1 2 3>;
 };
 
 &sdhc_2 {
diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor-wormdingler.dtsi b/arch/arm64/boot/dts/qcom/sc7180-trogdor-wormdingler.dtsi
index 17908c93652011d69a2d04b980f45f6732f16977..6078308694ac2085b7958704335dd81dc7109e27 100644
--- a/arch/arm64/boot/dts/qcom/sc7180-trogdor-wormdingler.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor-wormdingler.dtsi
@@ -148,15 +148,11 @@ panel_in: endpoint {
 			};
 		};
 	};
+};
 
-	ports {
-		port@1 {
-			endpoint {
-				remote-endpoint = <&panel_in>;
-				data-lanes = <0 1 2 3>;
-			};
-		};
-	};
+&mdss_dsi0_out {
+	remote-endpoint = <&panel_in>;
+	data-lanes = <0 1 2 3>;
 };
 
 &pm6150_adc {
diff --git a/arch/arm64/boot/dts/qcom/sdm845-cheza.dtsi b/arch/arm64/boot/dts/qcom/sdm845-cheza.dtsi
index b7e514f81f92810b39d128483d10d29878aad431..2885176302c87b7b6b1c1b7979754d9f79599e85 100644
--- a/arch/arm64/boot/dts/qcom/sdm845-cheza.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845-cheza.dtsi
@@ -761,15 +761,11 @@ &mdss {
 &mdss_dsi0 {
 	status = "okay";
 	vdda-supply = <&vdda_mipi_dsi0_1p2>;
+};
 
-	ports {
-		port@1 {
-			endpoint {
-				remote-endpoint = <&sn65dsi86_in>;
-				data-lanes = <0 1 2 3>;
-			};
-		};
-	};
+&mdss_dsi0_out {
+	remote-endpoint = <&sn65dsi86_in>;
+	data-lanes = <0 1 2 3>;
 };
 
 &mdss_dsi0_phy {
diff --git a/arch/arm64/boot/dts/qcom/sdm845-db845c.dts b/arch/arm64/boot/dts/qcom/sdm845-db845c.dts
index b5c63fa0365d28fdc4a61dfe67ab6a184e748473..32bab2363a060791f2936a327e5008f83cdf8a88 100644
--- a/arch/arm64/boot/dts/qcom/sdm845-db845c.dts
+++ b/arch/arm64/boot/dts/qcom/sdm845-db845c.dts
@@ -533,15 +533,11 @@ &mdss_dsi0 {
 
 	qcom,dual-dsi-mode;
 	qcom,master-dsi;
+};
 
-	ports {
-		port@1 {
-			endpoint {
-				remote-endpoint = <&lt9611_a>;
-				data-lanes = <0 1 2 3>;
-			};
-		};
-	};
+&mdss_dsi0_out {
+	remote-endpoint = <&lt9611_a>;
+	data-lanes = <0 1 2 3>;
 };
 
 &mdss_dsi0_phy {
@@ -559,15 +555,11 @@ &mdss_dsi1 {
 				 <&mdss_dsi0_phy DSI_PIXEL_PLL_CLK>;
 
 	status = "okay";
+};
 
-	ports {
-		port@1 {
-			endpoint {
-				remote-endpoint = <&lt9611_b>;
-				data-lanes = <0 1 2 3>;
-			};
-		};
-	};
+&mdss_dsi1_out {
+	remote-endpoint = <&lt9611_b>;
+	data-lanes = <0 1 2 3>;
 };
 
 &mdss_dsi1_phy {
diff --git a/arch/arm64/boot/dts/qcom/sdm845-mtp.dts b/arch/arm64/boot/dts/qcom/sdm845-mtp.dts
index a98756e8b965fe7aa475271f72c0b73b20fbceaa..63d2993536ade229a84da16e811e8bc83c46bd15 100644
--- a/arch/arm64/boot/dts/qcom/sdm845-mtp.dts
+++ b/arch/arm64/boot/dts/qcom/sdm845-mtp.dts
@@ -445,15 +445,6 @@ &mdss_dsi0 {
 	qcom,dual-dsi-mode;
 	qcom,master-dsi;
 
-	ports {
-		port@1 {
-			endpoint {
-				remote-endpoint = <&truly_in_0>;
-				data-lanes = <0 1 2 3>;
-			};
-		};
-	};
-
 	panel@0 {
 		compatible = "truly,nt35597-2K-display";
 		reg = <0>;
@@ -483,6 +474,11 @@ truly_in_1: endpoint {
 	};
 };
 
+&mdss_dsi0_out {
+	remote-endpoint = <&truly_in_0>;
+	data-lanes = <0 1 2 3>;
+};
+
 &mdss_dsi0_phy {
 	status = "okay";
 	vdds-supply = <&vdda_mipi_dsi0_pll>;
@@ -497,15 +493,11 @@ &mdss_dsi1 {
 	/* DSI1 is slave, so use DSI0 clocks */
 	assigned-clock-parents = <&mdss_dsi0_phy DSI_BYTE_PLL_CLK>,
 				 <&mdss_dsi0_phy DSI_PIXEL_PLL_CLK>;
+};
 
-	ports {
-		port@1 {
-			endpoint {
-				remote-endpoint = <&truly_in_1>;
-				data-lanes = <0 1 2 3>;
-			};
-		};
-	};
+&mdss_dsi1_out {
+	remote-endpoint = <&truly_in_1>;
+	data-lanes = <0 1 2 3>;
 };
 
 &mdss_dsi1_phy {
diff --git a/arch/arm64/boot/dts/qcom/sdm850-lenovo-yoga-c630.dts b/arch/arm64/boot/dts/qcom/sdm850-lenovo-yoga-c630.dts
index 480192c86fb7c6981011923ef619b83b7460c78f..90efbb7e3799b9aa75ac4df84fe0006d470ae131 100644
--- a/arch/arm64/boot/dts/qcom/sdm850-lenovo-yoga-c630.dts
+++ b/arch/arm64/boot/dts/qcom/sdm850-lenovo-yoga-c630.dts
@@ -598,15 +598,11 @@ &mdss {
 &mdss_dsi0 {
 	status = "okay";
 	vdda-supply = <&vreg_l26a_1p2>;
+};
 
-	ports {
-		port@1 {
-			endpoint {
-				remote-endpoint = <&sn65dsi86_in_a>;
-				data-lanes = <0 1 2 3>;
-			};
-		};
-	};
+&mdss_dsi0_out {
+	remote-endpoint = <&sn65dsi86_in_a>;
+	data-lanes = <0 1 2 3>;
 };
 
 &mdss_dsi0_phy {
diff --git a/arch/arm64/boot/dts/qcom/sm8150-hdk.dts b/arch/arm64/boot/dts/qcom/sm8150-hdk.dts
index e1e294f0f462ac824bffe96615b36ddcd8996d80..0339a572f34d01633ebf09e473d6fdff9005682d 100644
--- a/arch/arm64/boot/dts/qcom/sm8150-hdk.dts
+++ b/arch/arm64/boot/dts/qcom/sm8150-hdk.dts
@@ -478,15 +478,11 @@ &mdss_dsi0 {
 
 	qcom,dual-dsi-mode;
 	qcom,master-dsi;
+};
 
-	ports {
-		port@1 {
-			endpoint {
-				remote-endpoint = <&lt9611_a>;
-				data-lanes = <0 1 2 3>;
-			};
-		};
-	};
+&mdss_dsi0_out {
+	remote-endpoint = <&lt9611_a>;
+	data-lanes = <0 1 2 3>;
 };
 
 &mdss_dsi0_phy {
@@ -504,15 +500,11 @@ &mdss_dsi1 {
 				 <&mdss_dsi0_phy DSI_PIXEL_PLL_CLK>;
 
 	status = "okay";
+};
 
-	ports {
-		port@1 {
-			endpoint {
-				remote-endpoint = <&lt9611_b>;
-				data-lanes = <0 1 2 3>;
-			};
-		};
-	};
+&mdss_dsi1_out {
+	remote-endpoint = <&lt9611_b>;
+	data-lanes = <0 1 2 3>;
 };
 
 &mdss_dsi1_phy {
diff --git a/arch/arm64/boot/dts/qcom/sm8350-hdk.dts b/arch/arm64/boot/dts/qcom/sm8350-hdk.dts
index f9de0e49fa249af52cb3cbdfdabb394815ce82d3..24a8c91e9f70f40247fde6eb63aa5ce58e258139 100644
--- a/arch/arm64/boot/dts/qcom/sm8350-hdk.dts
+++ b/arch/arm64/boot/dts/qcom/sm8350-hdk.dts
@@ -385,15 +385,11 @@ &cdsp {
 &mdss_dsi0 {
 	vdda-supply = <&vreg_l6b_1p2>;
 	status = "okay";
+};
 
-	ports {
-		port@1 {
-			endpoint {
-				remote-endpoint = <&lt9611_a>;
-				data-lanes = <0 1 2 3>;
-			};
-		};
-	};
+&mdss_dsi0_out {
+	remote-endpoint = <&lt9611_a>;
+	data-lanes = <0 1 2 3>;
 };
 
 &mdss_dsi0_phy  {
diff --git a/arch/arm64/boot/dts/qcom/sm8650-hdk-display-card.dtso b/arch/arm64/boot/dts/qcom/sm8650-hdk-display-card.dtso
index cb102535838def8c9a354675545d4f4c988ccd0d..5a594d7311a71f6c5a106683c1b7376f8978cc8b 100644
--- a/arch/arm64/boot/dts/qcom/sm8650-hdk-display-card.dtso
+++ b/arch/arm64/boot/dts/qcom/sm8650-hdk-display-card.dtso
@@ -60,19 +60,10 @@ panel0_in: endpoint {
 			};
 		};
 	};
+};
 
-	ports {
-		#address-cells = <1>;
-		#size-cells = <0>;
-
-		port@1 {
-			reg = <1>;
-
-			mdss_dsi0_out: endpoint {
-				remote-endpoint = <&panel0_in>;
-			};
-		};
-	};
+&mdss_dsi0_out {
+	remote-endpoint = <&panel0_in>;
 };
 
 &spi4 {

---
base-commit: a933d3dc1968fcfb0ab72879ec304b1971ed1b9a
change-id: 20250724-msm-dsi-outs-dd8e967b1e38

Best regards,
-- 
With best wishes
Dmitry


