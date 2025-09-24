Return-Path: <linux-kernel+bounces-831420-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DFB7B9C9C9
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 01:35:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C5F5382D61
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 23:35:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C76729D26B;
	Wed, 24 Sep 2025 23:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="mEFt/XKK"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D203F27E1AC
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 23:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758756857; cv=none; b=R1ELi8LMKt9MIw5zd595I6gEaKA4kt2YvVpdWCtrHsGiGObjYyO47lMObAvDqNaWqkcik2FWMdycwwol4EweRLRACEgHYM/W/9o25YJvaN5BJh9jHV0UYcj66m0Pcq16vQq+BUdWfBTafgSs6jEApkYZO40WUzBz7YC77iNeBiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758756857; c=relaxed/simple;
	bh=I4O3gfHT5BcznZ7La6vavOxDfqkx1w/HB7s3CwlpSnc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=CKaGU8fyCfrupq9iv3l17wijU0SGHMvKJKhcR0juecRcuKxmVWNibsO38LPR8y9w1nZq8+bzu6zngRrWL6jmtN/wtb3Gbe8cMkY2iEmQNKOySicghhp8K6H28jnoFDYdvPaEwMgyHpWv0AK9loR61ksXTYPDP+WdqECUM/8LiUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=mEFt/XKK; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58ODDJfE002135
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 23:34:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=9PLTUQ5zeHXprnp5PmquzR
	9IVyqdudfdb0ioefL8Pe8=; b=mEFt/XKK0p265IVjpi5b0STaV+D0FQb6+9wEfN
	OWvBq4YGz6hsambjLOXvag+0cRN/e+Ax0qtQYrRoLied1pGRyV8WmXscr2Inn5bY
	laL2rqbGUg/E4uDCiTenW0f9ra2l/KYf4rLou8XsHXYi5YFr40YjY+ordVztkOb2
	4e7inXzZcOvo2Yxl8EXMEMaAY+YSSZkThYmuuKcYy4ixCyqFC+ePLZwrKULOUnuU
	CW+de3EKXZb/ZSZzITd3g19U+GoMkBWGu20KnaJRf4LGKpUp7/bgBjF/zEPRB1il
	0BZbViH+PFQvBNQLvR0/7H54flFtokc17Am1unVjGmX1x9wQ==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 499k98p277-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 23:34:14 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-252afdfafe1so3492795ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 16:34:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758756854; x=1759361654;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9PLTUQ5zeHXprnp5PmquzR9IVyqdudfdb0ioefL8Pe8=;
        b=JZucWhX+jlq7vtCP3WXHJR5IGDV/lH3MxJLxo+q2jHpMw5YMrGzzqsawB+jrDAHn29
         NmVZNhMo3ELpM4aFtVFaWe6gxz8+GJ9sOSmAGlczT+Jafi9TB5uMmGsAzn5aOio/rSQ0
         aPgW0L2KdKOGZ8DSp1S9n3xg4bE8mB+bmeQlFRYjf2xn7312t7zhnPy23TXg+C8hl6oh
         AJQkjKyuo5H56C9Y9NQvYTN9V18ViYK1XWYWJMbu7tmGum18AQMMQVumB6bwlIk9Gah4
         k/nkYMq1QjLG5e4RaHS0xuMQ+3wxleamp25XcGcNtRBfMvr+3EWyTVSnVCl5qi1qF9Nh
         tl1g==
X-Forwarded-Encrypted: i=1; AJvYcCULbYJRp2MhRqWN60d6GcFAHi7Gzu2GmEKx1kZA3PDZLN4amGcOOm6GVEqvQN/lR9GLJ0i4f04FN/m0fm0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwpXXWn7eGE6EWedwGfWvNxgCB1Z07mnQUl4ceaPK3JeMkFAzCr
	UR8Xjltr5D3oSFVwYC2TnF6k5oGaSEy1LSUnls3oV9Fx0Yqze1wljGV70rVqz8OD6Bzq8OBahDe
	dYlY1LGkGoIHKKjIAFnyUoCOQpCpIScR8TsqdghIWYo2FKojYYBhgdZfm6mq4AD4ra1k=
X-Gm-Gg: ASbGnct71xbG8GF40WH6a7lk9Lf3DYIwGQCahm4gGa161EV4w73VOHx1Idlm/mhqBpJ
	z/n13ZUCCugA/gpZC+JAs0PmTicSAgQkIKa33Vl78ZruwZQnQWDCZo0iRT4wlmz81ChkEWeq7OK
	DPcQzep0B8UBov3VMum5eTYrJ080JJcWxQ5R64RbKftgnhjXtujl2+jh62JaUpiP69ilv7IxuEn
	vHehcZ30rKy8KIGkPuoXPaXcHetdCkufboE9yhwcFZnaUo2bC6VNhFnBgu7q3nnzNDqCUejPrX4
	wRZGQPdxdja+DDaMV1gmLyeyozqPN6d4HC8PrNAYKSH556dJuL71g2DL1Vxeuc/4AVIiUlRMkH9
	RckSV8IaEHm22hYg=
X-Received: by 2002:a17:902:c946:b0:264:c886:8188 with SMTP id d9443c01a7336-27ed49d159cmr16244435ad.24.1758756853607;
        Wed, 24 Sep 2025 16:34:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHUrRMjSmB32RI2c0SHWNZW6mKRVY1S7Lvuou4K8ot/C0eRhg1imSELLecAfWv3RvXD+1haFg==
X-Received: by 2002:a17:902:c946:b0:264:c886:8188 with SMTP id d9443c01a7336-27ed49d159cmr16244265ad.24.1758756853148;
        Wed, 24 Sep 2025 16:34:13 -0700 (PDT)
Received: from hu-jingyw-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-27ed66d3013sm4433405ad.3.2025.09.24.16.34.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 16:34:12 -0700 (PDT)
From: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
Date: Wed, 24 Sep 2025 16:34:08 -0700
Subject: [PATCH] dt-bindings: mmc: sdhci-msm: Add Kaanapali compatible
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250924-knp-sdcard-v1-1-fc54940066f1@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAO9/1GgC/x3MQQrCQAxG4auUrA20AxLqVcRFOvPXBnEsiYhQe
 nfHLr/FexsF3BB06TZyfCzsVRuGU0d50XoHW2mm1KdzPw7Cj7pylKxeWCRBJCvGkqgFq2O27zG
 73ponDfDkWvPyXzw13nDa9x/GdHfodQAAAA==
To: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, aiqun.yu@oss.qualcomm.com,
        tingwei.zhang@oss.qualcomm.com, trilok.soni@oss.qualcomm.com,
        yijie.yang@oss.qualcomm.com,
        Manish Pandey <manish.pandey@oss.qualcomm.com>,
        Jingyi Wang <jingyi.wang@oss.qualcomm.com>
X-Mailer: b4 0.15-dev-99b12
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758756851; l=1055;
 i=jingyi.wang@oss.qualcomm.com; s=20250911; h=from:subject:message-id;
 bh=YZcMD7R1E/x5JsyNQnW7xKDXrTrxA0bWqZscFtGLLU4=;
 b=8bZx79PgRjy0zyZWg/MuI7JNaqTNImRZDABXed+lMGWCSCiJm/enMPJh/rqOmh5D6HbjHIJt4
 Ues9PkIpWLEB2mXi3GhxBdsldTRJUxk8CYgqlHE9H6WjVaSRFWZPJXJ
X-Developer-Key: i=jingyi.wang@oss.qualcomm.com; a=ed25519;
 pk=PSoHZ6KbUss3IW8FPRVMHMK0Jkkr/jV347mBYJO3iLo=
X-Proofpoint-GUID: 4LfGgo6o-KARb-VjMsW2fl_Aeq3b21ZK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIwMDAxOCBTYWx0ZWRfX3+UN9+f3KCOG
 UwHuan7tbGtqUQYoBPRb0MdxmFMPvCFGzmc0Ky/w409QdfLRitSWUmT0/aBM42hVNeI38SrjgXJ
 QT6hAS5PxVv+2B8CpwdYZijaLMWqB1LHEt+rza9K4FoiqnE8Ze4SqmZOpQ1FyPurEJ9EiShBBAl
 LnEFjY3rpdIW4Lm1AMsYeMs2IApvKbMCEK3RTXZFSLzy3S4CD8On7OdZEm9WcWseye1THnLHKg8
 oYGywYKXakNWsUZc93ysgN0ghBIbavyZCDLs534R/WDk61Z99sOrFit1EidHzeMEcxRS0CaJTS8
 5IThSYJjYZEkSJNjWHlxvm4zPjiQtqyf41ATPY5EsQxzvCgnfitukNEQ/mpgSl5nzFxuUWRJ84x
 zplq+yNR
X-Proofpoint-ORIG-GUID: 4LfGgo6o-KARb-VjMsW2fl_Aeq3b21ZK
X-Authority-Analysis: v=2.4 cv=Dp1W+H/+ c=1 sm=1 tr=0 ts=68d47ff6 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=0ikcEHTr7t7WTpsdClUA:9
 a=QEXdDO2ut3YA:10 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-24_07,2025-09-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 adultscore=0 bulkscore=0 impostorscore=0
 phishscore=0 spamscore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509200018

From: Manish Pandey <manish.pandey@oss.qualcomm.com>

Document the compatible string for the SDHCI controller on the
Kaanapali platform.

Signed-off-by: Manish Pandey <manish.pandey@oss.qualcomm.com>
Signed-off-by: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/mmc/sdhci-msm.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml b/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml
index 594bd174ff21..474afc98c8f6 100644
--- a/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml
+++ b/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml
@@ -42,6 +42,7 @@ properties:
               - qcom,ipq5424-sdhci
               - qcom,ipq6018-sdhci
               - qcom,ipq9574-sdhci
+              - qcom,kaanapali-sdhci
               - qcom,milos-sdhci
               - qcom,qcm2290-sdhci
               - qcom,qcs404-sdhci

---
base-commit: ae2d20002576d2893ecaff25db3d7ef9190ac0b6
change-id: 20250917-knp-sdcard-772e77cae9d2

Best regards,
-- 
Jingyi Wang <jingyi.wang@oss.qualcomm.com>


