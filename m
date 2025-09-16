Return-Path: <linux-kernel+bounces-818269-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26432B58F30
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 09:32:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1E83C7A70F8
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 07:30:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C7AA2E5B04;
	Tue, 16 Sep 2025 07:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="BvlePUOA"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C82382E090C
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 07:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758007919; cv=none; b=EOnw8eebeX7KMrUuTuKCDUE6TQkVx3lE9LJDoZqs3Sm77rr1aFJY13qtwwYB6USE+L/+zLUZa6QG4K74T9A8+7xT1NCYTV6XU2U7HYx7aiIr9AZUAh9C0EesgpUtl6/oS4SW9w2JVElUhooLNVB3fQ7WCi0XWoBAxEK4fNH5kH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758007919; c=relaxed/simple;
	bh=s8BWyyAJ63Dlk1aTjEk5L9PFu4I14q5H4nUlYBpxpL8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=QV8a3Ywxp6FoEZlqI3fPSRHzJN/t7sccpR2sDeOge+mnYnxhMdPHrigfu8b5SnM6fY4WjgJIBa0c4hFUCEg/r0GUSxRGl8PYIRIYIz7nia7elzZWEtsUFNOqw83/YpK0/m28sj6FW6AJYO3dIGlWWjqqPgeAUFQKSuDJIKxX6uA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=BvlePUOA; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58G3piX3019573
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 07:31:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=8CH1PNlJYICaq+xN+m08UU
	ZdW+oKMYDW8S3+NyltR0k=; b=BvlePUOASAWQFxxxwArPgrHIsLPQOk/9m4RglB
	syZOuWTGymdsSVo2xicjNmHKIfvKPst2uMROL4Zx+tOCGv6D7eDOXAchX0zWCe+H
	Qc+RW//UzkHYZuPOyVn/kfJad8Zc2e6HgDuW9Zc0YlMS+CQZ6fXhwYA1XG2XFpPb
	tcXyfMwZzYHksRPYBvPk4kXNf86P5nWIWHX4GYFu+JMk+UB6wtBCtbr+SBZms/se
	oONl5YSMEC7lW/UXn1yL14x6F3Fz3zI5962xBuUqRVxr9WLFOFeBkMdTqAyc20Vq
	N3AS/x6muc86+e9uhfZ4ZwzePQMY1bVQs2ggEPaFk7btS8lg==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 494yma7w5j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 07:31:56 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-b54b301d623so916005a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 00:31:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758007915; x=1758612715;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8CH1PNlJYICaq+xN+m08UUZdW+oKMYDW8S3+NyltR0k=;
        b=JrGsKroT1GZS2r5/xcpOb40B6dgMh7UuouT5fca/jAHJbS6XW89aJ+4j6EU/yyk+Uu
         l37YmJShIiO+Tf5pQM8dITvL8KP5YuPCiBkk9/w261jvce90CQq+1RavTbpO3HXTz7Y1
         b7jLstRgDQtPF0Hg4rx2lw0tKL9ldgjPycv1eqvzVkhCPxmTx7GzJBg8DUOxyyyzjN8R
         DcfHlyOhR0avxA12EB4Tg1ti/tySO82fHy8kRurb1yidyXya7T10WDrSrVZoyXXsneYL
         iKxct8jk6634A6iAXJAHQZdpopXsCh6Mlr6OEdcmtrVPHySP42jBtfx/TctHA+6pG/6s
         T3hg==
X-Forwarded-Encrypted: i=1; AJvYcCWsbMYM681HwO8Z181kjmuyGZ/x8UBqiMiKKYqOZK2Jn4U4LqlxyQ0YpIhH1l0LFqwpyuO8hs8t0/v5MRo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXWg65reA1lI9XSpmDjTMb0uv3s9wDYl+t03chzR/+VqKLlbtl
	TBBgjutjsKhYRI5/lI3DoeWs5iVvcvX+Hq4GBWTd8uZ6ET3rSYQBWvysRaDQIrBnUTbzDOQ6evk
	wKrOIpy8krw16rEH/vwVq3xUfezrekqSZZ18RE4BgvNe/gicXD7Lkx1GSCy7lS+RkLD0=
X-Gm-Gg: ASbGnctgkPJV2yS9BAnBM7dv6gMsjicAMb0w/8VHvojI2leRxRFfgDgxudlU0KTgwTo
	w9W6GNgViOnbNM7lxX5tdNkF2JpditSNG8QZJwL1FqUd5KyA+XDzl8HTZakWjzQvGBDJniMPD7l
	/XP2jdWWEP8m8jUPRSUtgplYpC/YQDiNZExpAItTZnMoCz+O4H50ylOTfbOOm+JU0g5ozztUCOo
	rpRJGh+j9lw8WbCMl0GWxxwCoW+WsQijqHPprlYFYRCI9A9DF1WNERBicUoJ+xs3KysOaSkHwVW
	UtQomecL26ngG8M22pa/WiB7/iiAbKJp8Jq+1/8RgyCHtA8s0llPhhznkMbhf5Z/OdThI9lUTSF
	DXcF29QlvDy8v9A==
X-Received: by 2002:a05:6a20:6a10:b0:249:ba7b:e350 with SMTP id adf61e73a8af0-2602a49db95mr10679934637.1.1758007915313;
        Tue, 16 Sep 2025 00:31:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGOuY/+fNjx7hpbqu6n+05NZZcieklyq8hxAQX1LsQN7umar5jYiFVl460R7yZnKdRwQ7hEuA==
X-Received: by 2002:a05:6a20:6a10:b0:249:ba7b:e350 with SMTP id adf61e73a8af0-2602a49db95mr10679911637.1.1758007914773;
        Tue, 16 Sep 2025 00:31:54 -0700 (PDT)
Received: from sziotdisp01-gv.qualcomm.com.ap.qualcomm.com ([114.94.8.21])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32ded1ac2fdsm12995589a91.27.2025.09.16.00.31.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 00:31:54 -0700 (PDT)
From: Xiangxu Yin <xiangxu.yin@oss.qualcomm.com>
Date: Tue, 16 Sep 2025 15:31:35 +0800
Subject: [PATCH v2] dt-bindings: display/msm: dp-controller: Add SM6150
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250916-add-dp-controller-support-for-sm6150-v2-1-e466da9bb77d@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAFcSyWgC/42Nyw6CMBREf4V07SVttTxc+R+GRWmLNAFuvQWiI
 fy7lcS9m8mcWczZWHTkXWTXbGPkVh89TgnkKWOm19PDgbeJmeRS8VoUoK0FG8DgNBMOgyOISwh
 IM3SY+lgIxUFJpY10tjJVwdJVINf516G5N4l7H2ek92FdxXf9CeR/glUABy7b86Ut21LU9oYx5
 s9FDwbHMU/Bmn3fP/mBkwjfAAAA
X-Change-ID: 20250916-add-dp-controller-support-for-sm6150-525ac2ed8c86
To: Rob Clark <robin.clark@oss.qualcomm.com>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Kuogee Hsieh <quic_khsieh@quicinc.com>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, fange.zhang@oss.qualcomm.com,
        yongxing.mou@oss.qualcomm.com, li.liu@oss.qualcomm.com,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Xiangxu Yin <xiangxu.yin@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758007908; l=1877;
 i=xiangxu.yin@oss.qualcomm.com; s=20241125; h=from:subject:message-id;
 bh=s8BWyyAJ63Dlk1aTjEk5L9PFu4I14q5H4nUlYBpxpL8=;
 b=vTalDIO4NPgb/9aizwP/CTx/sKmRglc5T80Q8X0k/OzwPWggEd9F5UCFxlYbD/A8iGXuwbfLg
 NpPKQPOfeyVDbyvvuTAYxdaa+lqtOqUegXaF5tE9Gf/4aDaHTANLiey
X-Developer-Key: i=xiangxu.yin@oss.qualcomm.com; a=ed25519;
 pk=F1TwipJzpywfbt3n/RPi4l/A4AVF+QC89XzCHgZYaOc=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTEzMDAxOSBTYWx0ZWRfXzzZ3zmAdHAZ7
 NipoaUVpj/kym3UVP51UZzkZhg7ybfuwybh1csSSZjboiGTxWLc5I/feVyDwwW2ae6u+JNSp7zm
 q2qMCOLMrs+AGFdglj2XN9mUgb2/ZH9FPh/HA312+Mkm54mDVSovHqLkLVHa982UmwwiC0tYeLc
 fqSacsNTZMkPiTPOwPFqSK6hFlXcZR+WwkN+i7OVbCSkdYPhrMawDqk2F2XjSjyO5USlU+21gOp
 pRRIYwkZyVqdZh9kObzshd0DyyBdP53rYR2SKDZF4yAsOw9AtN1BCoax63ml7UymcuX3EEa2g06
 ya7cO9bO3b95uu5+qEzdS/Hw0pJgpfueDyOjPlXZ6VxyJvKUiD7YKogwNjebsGFB7kc1qs+Do8O
 U5d855Q5
X-Authority-Analysis: v=2.4 cv=cdTSrmDM c=1 sm=1 tr=0 ts=68c9126c cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=Uz3yg00KUFJ2y2WijEJ4bw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=tYuJd5ZQnYzUV30UbPoA:9 a=QEXdDO2ut3YA:10 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-ORIG-GUID: CKduiD_oI288-885NolDVcE3rjl1JmWH
X-Proofpoint-GUID: CKduiD_oI288-885NolDVcE3rjl1JmWH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-16_02,2025-09-12_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 priorityscore=1501 adultscore=0 suspectscore=0
 bulkscore=0 impostorscore=0 spamscore=0 malwarescore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509130019

Add DisplayPort controller binding for Qualcomm SM6150 SoC.
'qcom,sm6150-dp' uses the same controller IP as 'qcom,sm8150-dp'.
Declare 'qcom,sm6150-dp' as a fallback compatible to 'qcom-sm8350-dp'
for consistency with existing bindings and to ensure correct matching and
future clarity.

Signed-off-by: Xiangxu Yin <xiangxu.yin@oss.qualcomm.com>
---
This series splits the SM6150 dp-controller definition from the
'[v3] Add DisplayPort support for QCS615 platform' series and rebases
'dt-bindings: msm/dp: Add support for 4 pixel streams'.

The devicetree modification for DisplayPort on SM6150 will be provided
in a future patch.
---
Changes in v2:
- Update commit message and binding with fallback configuration. [Dmitry]
- Drop driver patch since SM6150 is declared as a fallback to 'qcom-sm8350-dp'.
- Link to v1: https://lore.kernel.org/r/20250912-add-dp-controller-support-for-sm6150-v1-0-02b34b7b719d@oss.qualcomm.com
---
 Documentation/devicetree/bindings/display/msm/dp-controller.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/display/msm/dp-controller.yaml b/Documentation/devicetree/bindings/display/msm/dp-controller.yaml
index aeb4e4f36044a0ff1e78ad47b867e232b21df509..82481519005a1b038a351aa358b9266239d0e8a9 100644
--- a/Documentation/devicetree/bindings/display/msm/dp-controller.yaml
+++ b/Documentation/devicetree/bindings/display/msm/dp-controller.yaml
@@ -46,6 +46,7 @@ properties:
       - items:
           - enum:
               - qcom,sar2130p-dp
+              - qcom,sm6150-dp
               - qcom,sm7150-dp
               - qcom,sm8150-dp
               - qcom,sm8250-dp

---
base-commit: c3067c2c38316c3ef013636c93daa285ee6aaa2e
change-id: 20250916-add-dp-controller-support-for-sm6150-525ac2ed8c86

Best regards,
-- 
Xiangxu Yin <xiangxu.yin@oss.qualcomm.com>


