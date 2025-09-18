Return-Path: <linux-kernel+bounces-798436-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F7A2B41DFC
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 13:58:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DFE17189BE55
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 11:59:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3744B2FD7D7;
	Wed,  3 Sep 2025 11:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="chd3mvzi"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9FD02FCC04
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 11:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756900708; cv=none; b=WucQe/zAA6+f1nh7CC+mqusC4hDXeNvI6f7tM+btf1n7thebL0Ex37p410I3aJgjnB68NzCx5mDn8nUChwhkF3QSFlHBvJRA2naLWy2sWg7+/oHdnKpB/0rir6hgn9UALD51G5nh05EWbJNB+92mviTiLfXnNQa0n11GfqixlRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756900708; c=relaxed/simple;
	bh=RDcsC0Xk/SeTiAYs2PrzT5y7v3tCHnCk8IS1ckk2ayU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Q5Wjm7qT5fsncZtxGAKE2Pszlrk+NxmYvc9j1KQySdYWo3keBfKAwwJKRnvztbzluknlCF9Ve98muZFIRAxGHrZBgmc8BjUpBhVQjHxxm8PP+XTxit8dD2SC6M4T3t8PiO2LI3UT8EQjlCm0pUYyFQVscvZYv5aLmqhGN9mYt9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=chd3mvzi; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 583BEogd020226
	for <linux-kernel@vger.kernel.org>; Wed, 3 Sep 2025 11:58:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	+B6J/aB/tids3HBfaJNu1z9KCUM3gjNbHkRd/sTehYk=; b=chd3mvziinkIxnri
	4Epm3Xc98e2TrW/406+Usjs+Zmx6c4bOUZtzeqPFGZp2xrZs1u/ceKVeuWM2JGk1
	4ZKMAwLc4wBgzptRYoNMZ3/6o2TBwhWp9cYAxlDi/zYR7wCnS1Tmo5SEKa9QGwpz
	T9ZOBgr1iyY/agT8fS3JzDggHcNaaqv0boRjaCAUhDMfrMdHhnOenlWIbEF1Io/l
	o5pT51LDltjawdRmjBwmm2q38rFqimZvkGvA6w4uO3OoZ3A0K+Qrik5Eb6dXKrsj
	zlwDiC1CuiCAZKrIvYRw4PpOEwFo5Tlb+sTmFnTrkVPtdLrzQTS4TvN5jF81tG0t
	6Hjk6A==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48utk93aw5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 11:58:26 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4b30cb3c705so58117611cf.3
        for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 04:58:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756900705; x=1757505505;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+B6J/aB/tids3HBfaJNu1z9KCUM3gjNbHkRd/sTehYk=;
        b=b6/T4fB5UHNBaNsd+PnjtG3VwDfUIpH6GS9XZWR/WGVYwg4SwrJ56ebO0sT+PKnAav
         pr/hEvEizm/OnQRrKYdlxe88Mj8mXP8tzFRspwdR/4R+QgK0yxIgseGXXGFqsqz9Zqtr
         /tk2dzcq1MAyknszzio2ItT9JYeELcdy9iHvAF2u4u3/H1nb8bDL6K5mK2GZmczUCE0n
         el3GABseZlvxPkfQfpElcrdnzT3ONkJWwgodeIwnkXLB8keEtTMn4c9kVDjZKqEr+cFC
         BEWG+9P9NX9oio0traiPeajv66K5QgOpoJThK79Y2VjX9EYPgBEfHdapSBuAy0u4Swop
         fngg==
X-Forwarded-Encrypted: i=1; AJvYcCUwlI7+6/wOYKx7VLJtNYZzpyg5BxKjQPF2CwI+zrEMJvW5l22QnSC/5KDUoPmUk5uwQV5607wzbMFLKa4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzv4YBr+thYEVwTZZCrV06ygRdkYWFPBrzO9mrEeTGcjVfwnLGx
	Zb8Dnhho9PWQgfHdunZ8/PgdQ7VhbegA1mST967TNlXnfq3P2qPBOoowZ2IRpjebsIXwbAXyao2
	bXX5jTn0MIMC2f0H/3jj/qCypjCQ59ilCA5PIkIjVgVgyZVDwiWeK0hR+nqZE43zfzms=
X-Gm-Gg: ASbGnctxNiZqOa+O7N8siD4k7fJlE2ZBXXfVnaWpWxwXKjX8+ps8bzyd4JiA3U7a8IB
	q5YlnQtT8OeyLLye52PtI4SXju2G4eE5ZkTy5nyuF/zfycZejMp+KgeGOq6jZjR1lSXv0XP/O1C
	UUftlroKfLEyrCtY7R7T/BVbSHwxa4xFrdZxknw1WtLEH1T4kHQ6K2jtwk0kiojpK61UZED9XmG
	+hRftNpNKfgCcWUxL27xFK+ERLlazQ1LxMLkG9Iaw/8d0CwbGIMNX+BFwfDiNd8XdKf+fhoKWcd
	6HerpHYHr+RVNtJ+vPgzn+pptaoX+bGWIgZ+eLUAuKqHTc86L1eCGd+KqWAmxSwVRJyJqidQsnH
	AvDXVck34NFegiIUxM57+wFl8OkqEO9LsXSz4/auRmgwS6CxyS6W8
X-Received: by 2002:a05:622a:1f09:b0:4b4:94e7:7305 with SMTP id d75a77b69052e-4b494e779admr14573941cf.66.1756900704594;
        Wed, 03 Sep 2025 04:58:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEec6pipCsiN4bgRNHEInH7xKrhFe7yfQxq516iB19wHmpDvTtGnLGWlQH0T9+x/MPrYZLrfw==
X-Received: by 2002:a05:622a:1f09:b0:4b4:94e7:7305 with SMTP id d75a77b69052e-4b494e779admr14573491cf.66.1756900704030;
        Wed, 03 Sep 2025 04:58:24 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-337f50d30b0sm9891421fa.67.2025.09.03.04.58.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Sep 2025 04:58:22 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Wed, 03 Sep 2025 14:58:13 +0300
Subject: [PATCH v8 2/9] dt-bindings: display/msm: dp-controller: fix
 fallback for SM6350
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250903-dp_mst_bindings-v8-2-7526f0311eaa@oss.qualcomm.com>
References: <20250903-dp_mst_bindings-v8-0-7526f0311eaa@oss.qualcomm.com>
In-Reply-To: <20250903-dp_mst_bindings-v8-0-7526f0311eaa@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Kuogee Hsieh <quic_khsieh@quicinc.com>,
        Abel Vesa <abel.vesa@linaro.org>, Mahadevan <quic_mahap@quicinc.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1997;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=RDcsC0Xk/SeTiAYs2PrzT5y7v3tCHnCk8IS1ckk2ayU=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBouC1XhQYwJ1lOW5eV5P1HT18WaT4m7LdhmkXLt
 BA9hlGisnWJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCaLgtVwAKCRCLPIo+Aiko
 1VtwB/9dctctbqAzqdpymh47D1RY5EIKq+TYeq9nhWHT7IdEdFJVWIW9yFkpZcx/9Hvp2H2c1Uy
 /ms2Xrcw9raK5q3K70hPRtXSh+dmaHZBhxzYzyV/XfsA3kgNthtuyUBJxz71CF3EYvmttDalY2/
 LXl6G2ErP7DwIbQnWOcYGkofktJLZKbviC4IGwyjQiGdlosNItNsbjuzxncmKgJ7smR4MxUsJy1
 eu1OPmvBqp5CNd1PjEY0yTacTJGkDpormvV/p83MkvKRCwo6muNWM3w0ef7IT2qeTI7Cp4AMQRU
 kHCX9fF87Yw7hguGeHRMXQSxczp6mNgRqCHuahhTkOev3bln
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-GUID: jVb5jpkLJImyfA6Aqn5oIKIErkm9D0eK
X-Proofpoint-ORIG-GUID: jVb5jpkLJImyfA6Aqn5oIKIErkm9D0eK
X-Authority-Analysis: v=2.4 cv=ccnSrmDM c=1 sm=1 tr=0 ts=68b82d62 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=M9OWzbDgh-7tm28R-yYA:9 a=QEXdDO2ut3YA:10
 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDA0MiBTYWx0ZWRfXz8rdLnKfmJgq
 +sB6gMIBjgkBrgU8OFT2JcCATOAdS8Q0S6CVKV8x2M/5cJrqSbfJ3cVBFUxlCJHJqE/cLj+GSRJ
 SdNshwymc670YYzyUdhU1zgdaga3LOCoqpRAJWw94V4+L2rw1ShYnT9UF2bky1Dky+XXrt+liew
 OdXOkT3NRj7H2E97gAuOfw+gAV4qYjjAQur860/0a+soZPfk1OY1PmiMYZdpLUtdbCXipVnAGka
 NHaTWtgQpl1WUpL8pDpnWsB1+9+EBsvThcwKAyp075Jsj+hJMhXcschIYrbiMNfjSW2x8nZE8mZ
 V3ZxVmvLDiIa0fbZX7Ujr7GC3Ni5srrfc+ZHbvoWD1cVK4hrfX2ixQm8/aNmcFAMwYU+3RNzhHP
 YS0/VBJa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-03_06,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 phishscore=0 priorityscore=1501 impostorscore=0 malwarescore=0
 clxscore=1015 suspectscore=0 spamscore=0 bulkscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508300042

Currently SM6350 uses qcom,sm8350-dp as a fallback compatible entry.
This works, but adding DP MST support will reveal that this SoC is
not fully compatible with SM8350 platform: the former one doesn't
provide MST support, while the latter one will get it. DT schema for
SM8350 is going to demand MST-related clocks which SM6350 doesn't
provide.

Add new entry for SM6350 with fallback to SC7180 (which belongs to the
same generation and also doesn't have MST support). SC7180 has been
supported by the Linux kernel long ago (and long before SM8350 support
was added).

Fixes: 39086151593a ("dt-bindings: display: msm: dp-controller: document SM6350 compatible")
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 .../devicetree/bindings/display/msm/dp-controller.yaml     | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/display/msm/dp-controller.yaml b/Documentation/devicetree/bindings/display/msm/dp-controller.yaml
index aed3bafa67e3c24d2a876acd29660378b367603a..0f814aa6f51406fdbdd7386027f88dfbacb24392 100644
--- a/Documentation/devicetree/bindings/display/msm/dp-controller.yaml
+++ b/Documentation/devicetree/bindings/display/msm/dp-controller.yaml
@@ -31,13 +31,25 @@ properties:
           - qcom,sm8650-dp
       - items:
           - enum:
-              - qcom,sar2130p-dp
               - qcom,sm6350-dp
+          - const: qcom,sc7180-dp
+
+      # deprecated entry for compatibility with old DT
+      - items:
+          - enum:
+              - qcom,sm6350-dp
+          - const: qcom,sm8350-dp
+        deprecated: true
+
+      - items:
+          - enum:
+              - qcom,sar2130p-dp
               - qcom,sm8150-dp
               - qcom,sm8250-dp
               - qcom,sm8450-dp
               - qcom,sm8550-dp
           - const: qcom,sm8350-dp
+
       - items:
           - enum:
               - qcom,sm8750-dp

-- 
2.47.2


