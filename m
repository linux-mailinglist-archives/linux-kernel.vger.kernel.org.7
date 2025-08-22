Return-Path: <linux-kernel+bounces-781961-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 649D1B31932
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 15:20:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B161A1C87399
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 13:20:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE2252FF14D;
	Fri, 22 Aug 2025 13:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Q6FPDBLo"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4E5C2FF14B
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 13:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755868771; cv=none; b=hBafWXFHnak3u/h/E9UFcv0WRZgxtomclvxgCcWzeNmVZUbGhQGIsNR8d0CiJOIKKH6C4IsRDNPYb2RKevz3x6VnwKGAx5k2nm60lB6UNyAQTLpNd3tlsbabQYduTWMR4YOfgthJxFLwFNwlXkXdlf2R22u+A66/cAZneebuNQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755868771; c=relaxed/simple;
	bh=eiD1hB+Z0uOsoTw3flYptA1TO1Mamh7hsireh/vdeas=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=b0EvSSdd0WytcSfooE40AcnaNqg3//VM1beaj74WNG8vppEWMRUwHvqg/KcLY6q1a1yt+P8h9qBaOier1im4tkyqbxIy4jt5nyrytA/lqAhylXzTsTPvF+J5LhhImv/Spp8mEX4Y7R685M5nfnkUJZpgKIbcEzoze1O5C/3sSgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Q6FPDBLo; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57M8UMEv028648
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 13:19:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=YkT9zTnMs/T
	gchpz93nWzqSoV9Tb3aGhpZ9nYmMDUsw=; b=Q6FPDBLo4vyNHfBAMylYWREonrX
	vIylXDSvw3lu9p8UHBDqJi3sv/QNbGSHzlpxO28HFGfoe48pnUVX7SB/DExHzBbv
	+leYC351TPEXmFxlVLH0Eh4xFSGq4m8TToIiJsWgdYROKGYwwuBqL0Nk9p6KQHy0
	S8S0PjnTfT0QuGeI8SNZsHZ272HYq7zw5GLQexgEqvNWh8sM2gnBoV2epy2yE6jW
	TCDgqeWP8p1Duhq/wIU3+2xyDpK6Lt+Ch14aiE4FewNg/6jUt+y7Zkhttd3H7rzh
	hYL/2bmQoqAfqfBA8U+l221DvSyeV2xkmKkWPwkdu/T/2zkCxdFAdFt4m3g==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48n52csa8f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 13:19:28 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-76e2eb787f2so2449069b3a.3
        for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 06:19:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755868768; x=1756473568;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YkT9zTnMs/Tgchpz93nWzqSoV9Tb3aGhpZ9nYmMDUsw=;
        b=MvpZ7CbPon8gy5ryHKze0ThBnCsVTLqXgChxgHdxs+8YafYzgt9G/SvhJGG8TGjfT8
         vYi0fC61kN4mZe5dDY9u1zHmyxdGwYHq3KRgFoO5LkvkXpHQWO+F4k7z5sywdVeeJb30
         Csgoll6SpH/MQ7G1CKxFYgSQeWlS8X6H9ommgSEi0o/GbAY8l5D06xCpo0xYRAFSnAX7
         I1ernePQSb54zdhXBO0+JI6rlYowpn0ZGld9HJ7iHePNFosNWMqQhOZqh+sI9jJtkIiN
         BuBsw4TIJIiYxuQ2sSHpvXOGZf7vnIWH8iJXSR//buZH30gnZ912ypjnQ+eVdNYh3Wl0
         oonA==
X-Forwarded-Encrypted: i=1; AJvYcCV4tYvCbl8F/XqtZkCt8/OeadBa/WTiNWXIviprb8OvzzJySK5J8NKKDq6vl85ilzv/OLh3OIcGhFq+j3k=@vger.kernel.org
X-Gm-Message-State: AOJu0YzG/I7KlurqLFulw4FfPxR9I3lup2ZU23fSrZGDovUOt7lVhoKn
	xMXTxGDuyTLru2OG7y4lV1XIVzPJnEqX5oy9gRMVe8G4pYW01OyMRLEaIFwew8NLTi+o8Gatbx2
	TdWrxdL4vDIXFWP4/JUGRtF3pfGgnLVrRh/zyoDIL3TcWbHUojEFvFqdo0wjIQmIPLiI=
X-Gm-Gg: ASbGncvXUye7avtf2LwHvpXwGN07l6XPZWWOl5KZiSjBdUnGwH18PEPPisYvCQtneFB
	YIUt0orvrQJEzM5gbASqDOMrnm989+ClZ38AaAqJZaUHFYKx4h8XThCekp8sI606AUJmu8g5evq
	nlRkQZHcKI4dpNILs/R2CkGX+lJ7OLrtiA/CYYfo6+BIIvSSpm8QM4VOGSiCVk3wMKhQ2zPTcp/
	1L1nKdpxmX2ck/t/k6XYRb6KVwmot0kDzDLGmUnEJcQTBN6hJvsrsdO/h3gygqUU5IDMpkQarPY
	ZGsYf8rxK4GXTb3JVJbRMSS51OTUov3Miz+DtsWHcjk1vHSGuCToB7TKJ5frE4JR4oQEEN7/ihB
	Q
X-Received: by 2002:a05:6a00:4fd5:b0:770:304e:3f79 with SMTP id d2e1a72fcca58-770304e4ce9mr3977328b3a.14.1755868767788;
        Fri, 22 Aug 2025 06:19:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEkUbwnCaMCD6FD8jRHFi94nUzhVXub+bQPoS4iGq4KAqIZXczHs7G8IrCqxVInuv1iHBKQZQ==
X-Received: by 2002:a05:6a00:4fd5:b0:770:304e:3f79 with SMTP id d2e1a72fcca58-770304e4ce9mr3977296b3a.14.1755868767289;
        Fri, 22 Aug 2025 06:19:27 -0700 (PDT)
Received: from hu-mohs-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7703d2b7301sm405621b3a.93.2025.08.22.06.19.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Aug 2025 06:19:27 -0700 (PDT)
From: Mohammad Rafi Shaik <mohammad.rafi.shaik@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@oss.qualcomm.com,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Subject: [PATCH v4 1/2] arm64: dts: qcom: lemans: Add gpr node
Date: Fri, 22 Aug 2025 18:49:01 +0530
Message-Id: <20250822131902.1848802-2-mohammad.rafi.shaik@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250822131902.1848802-1-mohammad.rafi.shaik@oss.qualcomm.com>
References: <20250822131902.1848802-1-mohammad.rafi.shaik@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: Isk8aozHMVjQ3lYTaCUY88mk_6Z7xtVO
X-Proofpoint-ORIG-GUID: Isk8aozHMVjQ3lYTaCUY88mk_6Z7xtVO
X-Authority-Analysis: v=2.4 cv=Xpij+VF9 c=1 sm=1 tr=0 ts=68a86e60 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=UhVUwdw8r1UmGneQsTgA:9
 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIwMDAxMyBTYWx0ZWRfX4Me4wfTdU9ni
 nM7TvZpe+NI1I+oG/6qrb/VDHKUufxFM2xx9R3FSEIHzbs5H81DXFI7wWRoK5qLySAjlF3Ar8F0
 cpf/Y/PUxCs2LG2AGZVFyiTIURDJiFNPtLuXylbBlJNSI7+dGaaJ4Woy7bouJhZaO0Sk9WdUJJz
 pPsB4nR7WPxUux58S2NieyK4lnfTjkHvKajhVV2V9wlXazhFkOvwix2XWZLyYWzlcxwsh8qzEYy
 +I7PmNQDe0A7W10qkd0L0X+0mC6opb4zBuTkPLjmoRV4fUnETfPLPBuSxJg4CMMe6QwnsXx2jYc
 q+lAcl75S+hVSKvJiE6txI4zSv3C1BSUQuX91CO+Ux8pTXKaQLhg8ZKSqnnvgyg7imj8RH34Kez
 LnVOTQNfSDEBb1wFSFyS2uXjzxKx5g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-22_04,2025-08-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 lowpriorityscore=0 bulkscore=0 impostorscore=0
 adultscore=0 spamscore=0 phishscore=0 malwarescore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2508110000 definitions=main-2508200013

Add GPR(Generic Pack router) node along with
APM(Audio Process Manager) and PRM(Proxy resource
Manager) audio services.

Signed-off-by: Mohammad Rafi Shaik <mohammad.rafi.shaik@oss.qualcomm.com>
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/lemans.dtsi | 40 ++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/lemans.dtsi b/arch/arm64/boot/dts/qcom/lemans.dtsi
index 64f5378c6a47..7026f25877c8 100644
--- a/arch/arm64/boot/dts/qcom/lemans.dtsi
+++ b/arch/arm64/boot/dts/qcom/lemans.dtsi
@@ -18,6 +18,7 @@
 #include <dt-bindings/mailbox/qcom-ipcc.h>
 #include <dt-bindings/firmware/qcom,scm.h>
 #include <dt-bindings/power/qcom-rpmpd.h>
+#include <dt-bindings/soc/qcom,gpr.h>
 #include <dt-bindings/soc/qcom,rpmh-rsc.h>
 
 / {
@@ -6596,6 +6597,45 @@ compute-cb@5 {
 						dma-coherent;
 					};
 				};
+
+				gpr {
+					compatible = "qcom,gpr";
+					qcom,glink-channels = "adsp_apps";
+					qcom,domain = <GPR_DOMAIN_ID_ADSP>;
+					qcom,intents = <512 20>;
+					#address-cells = <1>;
+					#size-cells = <0>;
+
+					q6apm: service@1 {
+						compatible = "qcom,q6apm";
+						reg = <GPR_APM_MODULE_IID>;
+						#sound-dai-cells = <0>;
+						qcom,protection-domain = "avs/audio",
+									 "msm/adsp/audio_pd";
+
+						q6apmbedai: bedais {
+							compatible = "qcom,q6apm-lpass-dais";
+							#sound-dai-cells = <1>;
+						};
+
+						q6apmdai: dais {
+							compatible = "qcom,q6apm-dais";
+							iommus = <&apps_smmu 0x3001 0x0>;
+						};
+					};
+
+					q6prm: service@2 {
+						compatible = "qcom,q6prm";
+						reg = <GPR_PRM_MODULE_IID>;
+						qcom,protection-domain = "avs/audio",
+									 "msm/adsp/audio_pd";
+
+						q6prmcc: clock-controller {
+							compatible = "qcom,q6prm-lpass-clocks";
+							#clock-cells = <2>;
+						};
+					};
+				};
 			};
 		};
 	};
-- 
2.34.1


