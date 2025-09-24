Return-Path: <linux-kernel+bounces-831433-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F07B3B9CA66
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 01:39:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C40853800C2
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 23:39:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA3562C08AB;
	Wed, 24 Sep 2025 23:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="pOr0Dt0y"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 801C72C027A
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 23:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758757085; cv=none; b=tLdmbIV94H0Z+UShUX1xnSWkmOxjZiJ/yTp3YYpuKOvnvtKPa3dtAbFs3JVX1lqkhuWn/y2+hevhric/+cHJVYNVgTyl6tFhZhFWKiQmOb4oMCwxVb+IOa0uN4phbq+OUbWyKnoR3YlYo3LCb8S7qlAiNqguv439G6vZkVgHUMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758757085; c=relaxed/simple;
	bh=OFB2kgtpI3PnGziBr3bCuaYSbdpCfTaorjOb8O9HbBg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Tx5Pc2RCggMuq1QWkBe6UZ0BL1KLOZFo1H83ypSaKgQG4t/uZ5p1QNR4yK70WctryPCTJtOMUK453paLssIb90cRQ4S2cWLILj/BKcEfeipNS+WA5RBjDGTsbg4NVX430sh4Ys+TKgNvw23AEA7sbOCiwzyjLYOHJxhmWvqPMmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=pOr0Dt0y; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58ODCR3P023441
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 23:38:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=jQNLKc8P7ShPR+tJQHo9Yg
	BqIMp3zxSivxKyvL7307M=; b=pOr0Dt0y3R0mbJ+D6HCRVwUkuA9S9EYbwSMj41
	aLNf55Wj8s7bc7+tEGKiDqKGdNGGHPH/2/vUeHUw3kc5RRMK3PL77GpCBZdT3x/G
	SBOG7m8Tt4IpKPUEl7FX4o21joDFM/Xoj/9bv6746strXUi5ZA/8tkX3hV3jMOLD
	B+GCI/JOSCbQJBztKjRhLUHUZiNV1Fogp/1oLQFXHEhJeuDMluGhnjKn4XKBH3jK
	nYQTyYAgWdwXZmw9jh+IihuAnc7wvzzD1AODzzpQDgK1tulqsbUyfWhEKCPGH9S2
	msEDte79yfJVEnpWKub+jgxbVOksAB24YKVuig05K50oqwgQ==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49budadky9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 23:38:02 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-77f4912fe36so267475b3a.3
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 16:38:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758757081; x=1759361881;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jQNLKc8P7ShPR+tJQHo9YgBqIMp3zxSivxKyvL7307M=;
        b=lOMSjJxQGYd9wAVOzrJ1JmfhQHBZ/c24BLCyJhaIVqErd/0FOVbKrA9WAHN9FaidhA
         Qj7zrAkneDj5KZGlqI70jbnIpo8nRSBJ4bDoRAg08lE0RASmH7LqvSSkG/M5kVujkdWl
         g+I87ZApgOBFUZelkBiJfzNn6uoZCf7QUswaQWAkT3WWvWocmntoIjyTihNx9JLpK7Zs
         vBa+OBmxXeQWTm8ywFJNNaWQkwJH5wzcLsfS9rLkiZdFG9adgGuernVtC4msHlsFqWo1
         +xJnUL/nX+pE6Lyff1NRUKE3qCCcpqm94bWJDRDHAQNLH2+hvAZzCIroR8JGkz9VQAm1
         Vsbw==
X-Forwarded-Encrypted: i=1; AJvYcCWlHjCR9aG7vWjm92vR+DyadfmWWuZwDd2q+vJtES4QuFUNh3QwBulCGwc2VH3X7oaIOmiAQaXgrbVjp1k=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYyHLEo4RCL3EQLs3F5mHTHmtpe1cfgVqIeW8UmNQ3YbAVVQRS
	cmnl8eBeGQB76rg/WHfEGwAe5CqQolhgFEk1ZgDuCiXwS9IylhrfyqDbslwkCHVnKvBCWnR4BSh
	ENufrZunqV9OvFLPalQYFtU8rpzy/GhM9JQU1WV61p21LiAJFVGwgtHutqvDV4tzpolk=
X-Gm-Gg: ASbGncv1LtT8olzJKIdmDA+hYUeXr5NZCXfi6eyh7h8mMaNtMNn39Lw2Hk8TnnO7uIo
	lRf8W/eGSAm6IFIx6aa8DnYYS2Y6qXfqKy7o2OMRmgbVB4siNIOn9L6MriL+a2NjDb+9qkbdLoI
	BMPpFV7LZdT6is/Gsr402Zo2nrigaRFJchu1gJTSrNE6nynDrZvUA6oerb5Wd7vhK2iwBIJ14o1
	3Q2R3VmfmdJUW/7vGvuBzOwjee3r4mPcitLrb9KkWyua0UWDX92fXu4PGegwh8x76Bj8EuA5eBY
	vCeE40V97uEFdLgRR+2B7PWtIGSBBQHJQnfzDMpo+/2EMRGXIF6jiLu5SKmsV02gSZBV/ZMMgYt
	QyQ9yL5tMLt2fG7I=
X-Received: by 2002:a05:6a00:1890:b0:771:e2f7:5a12 with SMTP id d2e1a72fcca58-780fcdf6e16mr1803922b3a.6.1758757081181;
        Wed, 24 Sep 2025 16:38:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHTt0k8qEwYpFMit4O4lQZpF8U6ST0hNEYG5mPDI3iYy2XxIpf11uYg4nFLgyyPdDE1rD249A==
X-Received: by 2002:a05:6a00:1890:b0:771:e2f7:5a12 with SMTP id d2e1a72fcca58-780fcdf6e16mr1803898b3a.6.1758757080734;
        Wed, 24 Sep 2025 16:38:00 -0700 (PDT)
Received: from hu-jingyw-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-78102b23206sm192934b3a.58.2025.09.24.16.37.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 16:38:00 -0700 (PDT)
From: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
Date: Wed, 24 Sep 2025 16:37:55 -0700
Subject: [PATCH] dt-bindings: thermal: qcom-tsens: document the Kaanapali
 Temperature Sensor
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250924-knp-tsens-v1-1-ad0cde4bd455@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIANKA1GgC/x3MQQqDQAxA0atI1g2MSpnaq5QuMmOmBmkqiZSCe
 HfHLh98/gbOJuxwbzYw/orLRyvaSwN5In0xylgNXeiuYWgjzrrg6qyOtxJ6jjmFSAVqvxgX+f1
 fj2d1ImdMRpqn8/AmX9lg3w+BiYtHdAAAAA==
To: Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        aiqun.yu@oss.qualcomm.com, tingwei.zhang@oss.qualcomm.com,
        trilok.soni@oss.qualcomm.com, yijie.yang@oss.qualcomm.com,
        Manaf Meethalavalappu Pallikunhi <manaf.pallikunhi@oss.qualcomm.com>,
        Jingyi Wang <jingyi.wang@oss.qualcomm.com>
X-Mailer: b4 0.15-dev-99b12
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758757079; l=1046;
 i=jingyi.wang@oss.qualcomm.com; s=20250911; h=from:subject:message-id;
 bh=yySQ1biqwevpZU/HQKBUIuPzNC40vlyOA1bnmF3mVEg=;
 b=1mJCZizbdBM9OpkSofxKaUkUAzDIGmKyL4KQIQAlvkkEO+8zdO/d+lWKmmnAayEA//JW2bca6
 SB73l2C18kUDB56jbCZvDlSIr+zEHLMlm7GwFy92i/L+M4OP+1cMT9i
X-Developer-Key: i=jingyi.wang@oss.qualcomm.com; a=ed25519;
 pk=PSoHZ6KbUss3IW8FPRVMHMK0Jkkr/jV347mBYJO3iLo=
X-Proofpoint-GUID: 09pcCbRkcxKRMSkKMKXfartMAqWqQVDS
X-Proofpoint-ORIG-GUID: 09pcCbRkcxKRMSkKMKXfartMAqWqQVDS
X-Authority-Analysis: v=2.4 cv=Yaq95xRf c=1 sm=1 tr=0 ts=68d480da cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=PGq002HhRynx4w536vgA:9
 a=QEXdDO2ut3YA:10 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIzMDExMyBTYWx0ZWRfX1Rkg2zCawrVw
 hmhDh8u5xE43rwN1KW52Nh2r/ha8iz+jNJMyFsBzb7taVVlVTPnz8Qnx1hYwmmomYlcX29ULA65
 AdDm9vOd0EO6qmbZkXDopwo+jfz4aosqpIzEgb6S542f9E41WMifL8VC9rkomdedSEDcMu/SW5T
 3JjnrRw7n3B6jlF1pbLKekhlDBrIFB7J/dk91j3Fvihpsg8Pb4oSF3CKiCS/69Yc1vG7WwBotfx
 pT3NdmhPF9SYpjF3P5E93ZiyhVAwALm7r+XCSSw4NtJJS0fPX7hjTQ1L2UI56gxM2GZNhAjs7rs
 DNNU2aMg1YGMpGpPLyWYunACcc3oacnuyD+d9jqDKP497uPa1Oi5GAiXDkwE1nw3ZGxzEDvRi0M
 7E533x7y
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-24_07,2025-09-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 suspectscore=0 priorityscore=1501 phishscore=0
 adultscore=0 malwarescore=0 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509230113

From: Manaf Meethalavalappu Pallikunhi <manaf.pallikunhi@oss.qualcomm.com>

Document the Temperature Sensor (TSENS) on the Kaanapali Platform.

Signed-off-by: Manaf Meethalavalappu Pallikunhi <manaf.pallikunhi@oss.qualcomm.com>
Signed-off-by: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/thermal/qcom-tsens.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml b/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
index f65dc829574c..20b9816754f2 100644
--- a/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
+++ b/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
@@ -49,6 +49,7 @@ properties:
       - description: v2 of TSENS
         items:
           - enum:
+              - qcom,kaanapali-tsens
               - qcom,milos-tsens
               - qcom,msm8953-tsens
               - qcom,msm8996-tsens

---
base-commit: ae2d20002576d2893ecaff25db3d7ef9190ac0b6
change-id: 20250917-knp-tsens-8f03e7cb07af

Best regards,
-- 
Jingyi Wang <jingyi.wang@oss.qualcomm.com>


