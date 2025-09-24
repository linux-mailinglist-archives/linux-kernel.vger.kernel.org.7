Return-Path: <linux-kernel+bounces-831387-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F491B9C864
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 01:23:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 057013A4F30
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 23:23:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1F682D052;
	Wed, 24 Sep 2025 23:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="CvEFPhSK"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D43F0522F
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 23:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758756194; cv=none; b=rwakXmfbqvP9HvCgg5cHYZGUdG5f2eLUrYJMb7Fw3iMXpuaD9HEPOc3Ce2TZOR1KN0UkLiU/o02yufald0QIcax46iK0jfmoKlD0YAevhIIN6O+z9ABYGakBHY14hjbgbyLsoHMNiRg7RKKlNKcS3zr4Fp7VR1NmrXq/4gQHEV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758756194; c=relaxed/simple;
	bh=gFCePsoPbzM0W7ILRRpK1/MIcPC3NfbicImFa/pze/I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=QNnxHWr0sr7VDzeg6V8IqLUKu5ijaDTsmb/4kdqqdgOJf/oziShpKHNTkVR9WkfMCIg1lc0o95LZXSwh+Z/5F1/cAzQR6ekZ0JIMWKah8b4pMa45JQw88/q6E951oW2sr2ZqjsOTsEBUwK8nrzd3NhaDxxv5Rdu81EsRn5CxUB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=CvEFPhSK; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58OD3t5U018716
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 23:23:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=t+4IWnHke+FbZXG2BMohmw
	IxnzVqYF1Hh5Q4vtTVF14=; b=CvEFPhSKrrUhj+GRR6fC+xUvy/vJMkmFKKmQeH
	GKtoHahug2qzX0EwPmHrtQk8pMt6KvdIYTgPbflkrO4Usc94OakuQ7pz6FpJ8ZD4
	yS23wRPdTxevF3Iy3fYziUmNHJBRdc7fCmaFaX3kkKmMbC3hlLviYBBlDvliO50a
	Ed5j274sF9FRmyTJJslGAAK7deWhjyn1D6MthELa0gsAJJTwMiz3FK/6w3WX3W+g
	kIAC+gCJuZtiPRetLCVmPDL6fwuDY5PYWlQ0j0WD5/cCqgxyI50U/x73PRYG4t4d
	B54dG5mZqxPqbOHsDY8FEhV9ylOnBAStd7PMLM6iG7v+sS2w==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49bhvjybsk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 23:23:12 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-269939bfccbso3813325ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 16:23:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758756191; x=1759360991;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=t+4IWnHke+FbZXG2BMohmwIxnzVqYF1Hh5Q4vtTVF14=;
        b=Dtug6AHexqAYdX2882XNdqAFSl/ohRvnbpfaiCFdUU0iTLuilsp4YNNMOer1ql/u0m
         Ze09S8epR00fmLwxMduEHiIo+YByBv+9GS+RxGZVpEO2YsKlCEWeeUixcOpBiF+RZ28M
         88wyrK6lNwPejsG2LYHfQb8Haquz2U7MN0umeDtKlPlaoW4G8aozsXy/wJVGCEvhKrnu
         ga6jIKzJx0abQ6R0WBDoFFJYxC1XGejO4i1K9VLcCHLB1xveg2VW3qQyBtPEisKN5Xka
         FQL56DUJDbDt3mXFz1/M29Tee1bRz3vXe5J169qmVL0ASmgygHLoRJWoXtzfeg2CR4ln
         sK7w==
X-Forwarded-Encrypted: i=1; AJvYcCVbbaedQ3SsGO++9OcslVX/nfHSpWsQwqZyVOoVYoYN53u3jw/Dn7tsZ/JvcO1n0+oJjiY+WVOswdNnGFM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfSmQ3rb+Ba1nLUnjVi/rmjkezgdt1mm0APOLSZtzyWFd/Z4oZ
	AYZtLIale/bAv6g00vXTLRBHAv8/IefGboowJGvrFblmWXahoV13lhTMdqJC7zTh986NBZCCIKS
	4t5F0kGiQoKNWI4rRLfo5Aer1DrfIncm8F1iGoaP6yAGXBP6tWcLwma1wbxTaXpRtkGg=
X-Gm-Gg: ASbGnctyw3PAr8MLAXr0r+FOL9Zx9ma8dwtqxSMiDXmIBXDB89P01rPJTNngIDx7JSB
	wre6/cW+CjdDx/vGtDtoSPEVN7JkM8NtC8yszxcvSWN6tGB5gHLRZwjv3lXqmQYpJqtBd+90dQb
	m8IkLyq2ZBbOcRVrEmE4GuYi+n5uv9pnwU0kdEZYQDXKTvjc7FJUg937+b4l6g+TMuTDEWuz1st
	ILrv71/QIufXfiYGvilils3R3NErsiCVTjgZYUzQx2O+oCWxezRb4uns6hLsOyhr/mak1Xpxcg8
	Fz/V+57mMU3RrFc9iaV0E6JN83ZRSeyGjorILC67EdPAkb63nauYFh8THcsvayZJjUnxze//O38
	kyJrIM+MmpEb8zfU=
X-Received: by 2002:a17:903:b8f:b0:267:bd8d:1ca with SMTP id d9443c01a7336-27ed4a6e8dbmr17494335ad.43.1758756191169;
        Wed, 24 Sep 2025 16:23:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGcViyIgc/11XVapybWYXt7+h+ARrhm5NS+/jC2pUC+Hh+STkUep9GhTZoOG6ot9Z7n+IN+bA==
X-Received: by 2002:a17:903:b8f:b0:267:bd8d:1ca with SMTP id d9443c01a7336-27ed4a6e8dbmr17493985ad.43.1758756190697;
        Wed, 24 Sep 2025 16:23:10 -0700 (PDT)
Received: from hu-jingyw-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-27ed68821aesm4048915ad.90.2025.09.24.16.23.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 16:23:10 -0700 (PDT)
From: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
Date: Wed, 24 Sep 2025 16:23:06 -0700
Subject: [PATCH] dt-bindings: mailbox: qcom: Add CPUCP mailbox controller
 bindings for Kaanapali
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250924-knp-cpufreq-v1-1-1bda16702bb1@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAFl91GgC/x3MwQqDMAyA4VeRnBeodSLuVcYOsaYziF2XbCKI7
 26343f4/x2MVdjgVu2gvIrJKxXUlwrCROnJKGMxeOdb19cdziljyN+o/MZr17jomtD7lqAUWTn
 K9r/dH8UDGeOglML0eyxkH1Y4jhMG/iSYdgAAAA==
To: Sibi Sankar <quic_sibis@quicinc.com>,
        Jassi Brar <jassisinghbrar@gmail.com>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, aiqun.yu@oss.qualcomm.com,
        tingwei.zhang@oss.qualcomm.com, trilok.soni@oss.qualcomm.com,
        yijie.yang@oss.qualcomm.com,
        Jingyi Wang <jingyi.wang@oss.qualcomm.com>
X-Mailer: b4 0.15-dev-99b12
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758756189; l=1188;
 i=jingyi.wang@oss.qualcomm.com; s=20250911; h=from:subject:message-id;
 bh=gFCePsoPbzM0W7ILRRpK1/MIcPC3NfbicImFa/pze/I=;
 b=VZHuxitp5BD5mBW/K7gCz7zoYBjX1GT1qVkD7uakOrEFz5fRHBnj0g4pKPiDPAKTCfCfe0ITC
 lDAN8jWU+sjCPkQGlwK2Nyu2IEx2iA8oRnD+/8LhqNY54i8/ta/irJk
X-Developer-Key: i=jingyi.wang@oss.qualcomm.com; a=ed25519;
 pk=PSoHZ6KbUss3IW8FPRVMHMK0Jkkr/jV347mBYJO3iLo=
X-Proofpoint-ORIG-GUID: dQihhf6CgUEWbldeRrtCIbSyJSraBExH
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIzMDAxMSBTYWx0ZWRfX/xeaAHZ3dKH1
 M3yfxD4PypNJKh15vHGPPrRAkGv+NFK01vxLPNgl+Xl/kgFRz57g/2WWGng1ylrxcjMKu4S9nVi
 fNIzQHotqsPgSbb7fkS/RI7iOM0/5PsuDbSgoQQ0Kt83D+hA+W6OslVmcWm810Wo1nhVcip8/4C
 +aRWM+EQu/ESInJetl49Ngj5cQWQ8AcujDav8hqGnaYclDLTeD1TI8S9LVT2vetRaRgoIc4+5fp
 Baa0HO4jbK7eV+HAkuOaPjefV3D2nT6eJR3SBc3e44Y8NOtL+j/nK89tqZGKp/dj3+orWi8l90F
 zOYdXqXmeiJCx29XLyitPZ0G9cGfjfvOy6a5xYFIanln/h2qD0bV4H6ByaElGzQrlGEYRRBQDz3
 GVGxz1yA
X-Proofpoint-GUID: dQihhf6CgUEWbldeRrtCIbSyJSraBExH
X-Authority-Analysis: v=2.4 cv=Csq/cm4D c=1 sm=1 tr=0 ts=68d47d60 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=8jNUSCxD5SpwfXmMkmYA:9
 a=QEXdDO2ut3YA:10 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-24_07,2025-09-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 adultscore=0 impostorscore=0 phishscore=0
 clxscore=1015 spamscore=0 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509230011

Document CPUSS Control Processor (CPUCP) mailbox controller for Qualcomm
Kaanapali, which is compatible with X1E80100, use fallback to indicate
this.

Signed-off-by: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/mailbox/qcom,cpucp-mbox.yaml | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/mailbox/qcom,cpucp-mbox.yaml b/Documentation/devicetree/bindings/mailbox/qcom,cpucp-mbox.yaml
index f7342d04beec..6f72f78e4b72 100644
--- a/Documentation/devicetree/bindings/mailbox/qcom,cpucp-mbox.yaml
+++ b/Documentation/devicetree/bindings/mailbox/qcom,cpucp-mbox.yaml
@@ -15,8 +15,13 @@ description:
 
 properties:
   compatible:
-    items:
-      - const: qcom,x1e80100-cpucp-mbox
+    oneOf:
+      - items:
+          - enum:
+              - qcom,kaanapali-cpucp-mbox
+          - const: qcom,x1e80100-cpucp-mbox
+      - enum:
+          - qcom,x1e80100-cpucp-mbox
 
   reg:
     items:

---
base-commit: ae2d20002576d2893ecaff25db3d7ef9190ac0b6
change-id: 20250917-knp-cpufreq-4730f03c925a

Best regards,
-- 
Jingyi Wang <jingyi.wang@oss.qualcomm.com>


