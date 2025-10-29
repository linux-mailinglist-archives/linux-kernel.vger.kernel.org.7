Return-Path: <linux-kernel+bounces-875398-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 40D5BC18DF9
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 09:11:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EE5C84EC5E7
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 08:07:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95E483191BE;
	Wed, 29 Oct 2025 08:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="AGJDmc9D";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="bBMXCBlY"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 002C5314D3E
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 08:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761725157; cv=none; b=dWS9tYfhITMRQhwlXh/blfzCS4ShPmtJ9eLDqe0Lr67j/uXJxUSb1Ac14lAVSbTIF6H9IvZZ9uh5bNFPzPtXoSfKCqbl1cOSjwpcz5tOzgMc4VLQ73vD44WHPsHhsZLWpVU0HqtfxpWcvVNxTcVyM4QsqN251gH4afI+GfoqV8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761725157; c=relaxed/simple;
	bh=wSsC/m90UcMlRas3mHaUoFTcsLJkym6KsxiJChRWUvo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rd3xLVGSaNFJ33OMKeONvCeqQM1CdxtG3UB7h6OcmWjmJq0kS887EKRDTy3u2wGHnikaYldhJHQ7VaIfx2zzrM+f1+QDoYXEzWph9pdAoOnksF1mxrK1S/PiNN0WjLXbFKsNnNf1YtawfeOmmZqM9hZhoelhM3p9171t5haqeHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=AGJDmc9D; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=bBMXCBlY; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59T4v3Hs3663756
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 08:05:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	WyCMuRsQwYryKroqDg3C2kFC0X1+TeXJPv9gZBeQfSs=; b=AGJDmc9DJHmTpVc2
	WvYAMcxQwEbia0qNhbRMuVUsQVult2FUHNENsrpIrTErBHOfZI5fyixNsFn7ZpnX
	FF2Ek6JAgi1uIxM61r8lXJnzAPRbOJMeOCBVoxEllO8WoYevoiz7dW4VxGjMKFov
	PtZfXyX1y0qAuvJvOe0XuqCDNjcfrUUBgbZFyMq/pGCmR6FHm8wWnuTnARhUGdpA
	sdyeCC7Cf9qBlHVZcoIHk/9Ig9ANwuCBrQmwCPtwgcPpYqHl5f8QZeVhPsVnwxH+
	SWNkJZtJ5dQIYRsslnVhyzw/TSGUufS8L3/YSe0AvxlaYSTNIgbML937acmmelKH
	a5nlLw==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a34a1spvk-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 08:05:54 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-26985173d8eso180985895ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 01:05:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1761725153; x=1762329953; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WyCMuRsQwYryKroqDg3C2kFC0X1+TeXJPv9gZBeQfSs=;
        b=bBMXCBlYvzIhmNJ6ZXmQ12u6vTC7WCsXbFswnmX8CQR+5EQVGCPO6N2SlN/4yPiVwk
         8BQm1FWyWvN97sHuir2TCIQDzLX071xfNkQUwMwovLcqzymkTZkrX1AAphTBm0hGzzV7
         Y5X5Z0LK0cTDQbJzG2dg21Zc3SNRYj+ye1tJKPzHo3bAVCT7hihhJE3k1cXPQDpJY1Zf
         wJIXMKxyh5j317QwQFJ9IQGZMs8JgFUP0KXxCBWAIqpMTnyVfCIUM65dZM0PVjMRv/OI
         xuUpa7PSv+PQNmFzrOblpuA4U3srxSWkmqDLx1Jw/GhntRjwyxzEZbEiR1UyaGt64Qku
         +T2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761725153; x=1762329953;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WyCMuRsQwYryKroqDg3C2kFC0X1+TeXJPv9gZBeQfSs=;
        b=QtW8Wlxnn4bhKx7PtkiB7OD9HRZgTHPqgdAj5QtO1dv/PHN3Y3bMJ+mZYJqRk66KJE
         X7p9Dy2Ifd63VSQ/Vm0EFmVCHGFWzxlspL35kanG5fLl/+Sm21/kTSPUnsDpI+cl8Tod
         tiw+LApCisyyhQCn7UamxwyNggztZ9N5IgwRjSrJPlVEgyy834xEkHOnIP284PLYpWEZ
         h/S+2XFYd/ie29+LF9A3MANixnqXg2U3qWAmRuibnyP1B/ru0oiagZ5epxlkiEgs3DBr
         Vc0q4DeqjNzlnA3VseZLDK1dOzZvQKkbtKu8KZfC4kXV8sUhgHc/Cc4+yLxN9EpKnYnQ
         kcIQ==
X-Forwarded-Encrypted: i=1; AJvYcCX2sxhaWEKmVGwcBpSwRHtBLubo5cp1W2PclXSwvUFzsTGIeAnl8HfnQbHWCSOvc1Y/FePM6WfPd6zD9V0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPWwV+lN+oy285uMRGnS4go2dJfr+gHdQdLDkYxLDFHJUwViMt
	RinrkRJRoQaD+bX3926BYtlMrypXCJkxCXm8DoJfAuWVT39rEyGrZA6ZFL/TDImjEV/DVlNSMmZ
	hAd02a8xAaisQp1n8FBMmBjejWlOhAxQiAGd3RnTwCK/KJD8rnUxRPMU4U3Wq0gpZi7Tgzsnn0C
	OjTw2V
X-Gm-Gg: ASbGncunSXrfGv7AMt709oNGBTEPCd2se2+kU1gFrh2zu1Wd8JdHjLtS8FZuA5QumiV
	r0mLC5hTF0o/kxs39Y8CJRTS0+JY6ImV3LhYcOaZdGeXPVmjuntWIrDT/mi+1GQfLN2Fj0jSHqN
	ZxSUPzXepPHPLnHjm9iqWp5uksyzM4dNRZMh29KPlu2zBo1rVlZL50yOaBt3cWDCVLswQZCfual
	YsYXGhA4nyZoMlhkR/yBCTIcXG9ZA9cziBoiY+nMrCNbq5HaNbXTXw7fxUQMjIp/OEw1TwJLwpw
	tAiWdjz17ehApZj+rYwA+k6+cwiaTVZwc8fBhfaknF/yIsb5QoxCJr7UVCcTpxbjhs89OUHoZXs
	vlGwziLs3ML+Fwy8ZhhvIAaoQ8QzSk5/e9aK6BnvUSq1kr+WD8Q==
X-Received: by 2002:a17:902:d4c6:b0:24b:270e:56c7 with SMTP id d9443c01a7336-294dedfa77emr25415095ad.7.1761725153399;
        Wed, 29 Oct 2025 01:05:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEAY5y1XPZmwwX/bye2S8cDKGJs6HaLWTblBH69Q2eN1bFSJbsrs9FLTLCUpKeXfl4vf2jwhQ==
X-Received: by 2002:a17:902:d4c6:b0:24b:270e:56c7 with SMTP id d9443c01a7336-294dedfa77emr25414645ad.7.1761725152784;
        Wed, 29 Oct 2025 01:05:52 -0700 (PDT)
Received: from hu-jingyw-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29498f0be0esm141754705ad.96.2025.10.29.01.05.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 01:05:52 -0700 (PDT)
From: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
Date: Wed, 29 Oct 2025 01:05:44 -0700
Subject: [PATCH v2 6/7] dt-bindings: remoteproc: qcom,sm8550-pas: Document
 Glymur ADSP
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251029-knp-remoteproc-v2-6-6c81993b52ea@oss.qualcomm.com>
References: <20251029-knp-remoteproc-v2-0-6c81993b52ea@oss.qualcomm.com>
In-Reply-To: <20251029-knp-remoteproc-v2-0-6c81993b52ea@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>
Cc: aiqun.yu@oss.qualcomm.com, tingwei.zhang@oss.qualcomm.com,
        trilok.soni@oss.qualcomm.com, yijie.yang@oss.qualcomm.com,
        linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jingyi Wang <jingyi.wang@oss.qualcomm.com>,
        Sibi Sankar <sibi.sankar@oss.qualcomm.com>
X-Mailer: b4 0.15-dev-99b12
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761725143; l=1709;
 i=jingyi.wang@oss.qualcomm.com; s=20250911; h=from:subject:message-id;
 bh=MbjJGjYI2p6gxBQQC0Iy4v/3D5XLYqqgbONuf+0Bivc=;
 b=mIqI2Fn3tZsYy5tef004AeqHk+HfppmB5mX2ylArmDyyZkhg29XijEm/2juY+QDwt2wdGs4tk
 6kjJUm5xiNgB+q8TfsGi8xaA3kcUnMlJvRX4wMNtB+uKlAhvCf6/d/t
X-Developer-Key: i=jingyi.wang@oss.qualcomm.com; a=ed25519;
 pk=PSoHZ6KbUss3IW8FPRVMHMK0Jkkr/jV347mBYJO3iLo=
X-Proofpoint-GUID: z4bE82Z3bRNtO1D1IYfBvZfRjAEH-O22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI5MDA1OCBTYWx0ZWRfX2niD/8rudDNA
 P6uvYBMyJpLI2o/B4AIVkQXYQhysGDXQvPajX1qP1mKdUZ0rO55c+/b5PQbIZA+PNcdTRB3+Scj
 uh5iLrQNlB7uOzUxGLALsuQqoBm1IsqBcEHwLVimoBh6omQr+CP4ZBQJckApBy4eFJkpwMqP4dD
 IZAR368KN61XhhqpmPLnIk1N2irZ7HNirHBb/ZyFGxSiHsSMx6eZctZtAuZ0NN4tALD8dGAq9pu
 4G0bTClUNbNEjxLo0BDKpKzYtp7Mvb1JFNOdIYhAC8M6/9AtM1EUIW68j+cUN1dqE+Q47H43umb
 BQv7rAyjYfCOT+agn/r1fytmS4WTYr7/813RdAzFwVoItZEzd69b4zG6HrDL0/V3BdoebrNKkHg
 hgSr9oo0F9kDBg0N/LP9g5NI/WDmSg==
X-Proofpoint-ORIG-GUID: z4bE82Z3bRNtO1D1IYfBvZfRjAEH-O22
X-Authority-Analysis: v=2.4 cv=UObQ3Sfy c=1 sm=1 tr=0 ts=6901cae2 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=JsIBf0UYXXKOit1WgS4A:9
 a=QEXdDO2ut3YA:10 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-29_03,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 phishscore=0 bulkscore=0 priorityscore=1501
 spamscore=0 impostorscore=0 adultscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2510290058

From: Sibi Sankar <sibi.sankar@oss.qualcomm.com>

Document compatible for Qualcomm Glymur SoC ADSP which is fully compatible
with SM8750 ADSP. Also with the Linux Host running on EL2, the remoteprocs
need to be hypervisor independent, the iommu property is mandatory to
ensure proper functionality.

Signed-off-by: Sibi Sankar <sibi.sankar@oss.qualcomm.com>
Signed-off-by: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
---
 .../devicetree/bindings/remoteproc/qcom,sm8550-pas.yaml     | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/Documentation/devicetree/bindings/remoteproc/qcom,sm8550-pas.yaml b/Documentation/devicetree/bindings/remoteproc/qcom,sm8550-pas.yaml
index 3b66bd106737..8cb839ba1058 100644
--- a/Documentation/devicetree/bindings/remoteproc/qcom,sm8550-pas.yaml
+++ b/Documentation/devicetree/bindings/remoteproc/qcom,sm8550-pas.yaml
@@ -29,6 +29,7 @@ properties:
           - qcom,x1e80100-cdsp-pas
       - items:
           - enum:
+              - qcom,glymur-adsp-pas
               - qcom,kaanapali-adsp-pas
               - qcom,sm8750-adsp-pas
           - const: qcom,sm8550-adsp-pas
@@ -101,6 +102,7 @@ allOf:
         compatible:
           contains:
             enum:
+              - qcom,glymur-adsp-pas
               - qcom,kaanapali-adsp-pas
               - qcom,kaanapali-cdsp-pas
               - qcom,sm8750-adsp-pas
@@ -247,6 +249,17 @@ allOf:
             - const: mxc
             - const: nsp
 
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,glymur-adsp-pas
+    then:
+      properties:
+        iommus:
+          maxItems: 1
+
 unevaluatedProperties: false
 
 examples:

-- 
2.25.1


