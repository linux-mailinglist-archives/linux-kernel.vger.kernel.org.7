Return-Path: <linux-kernel+bounces-879617-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E05CAC23954
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 08:42:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 927443AE215
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 07:42:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40D9832A3F2;
	Fri, 31 Oct 2025 07:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="M4Y3vsP6";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="f+SksGqu"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E973F329C6B
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 07:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761896523; cv=none; b=hKtNrg8kMhhM4oZIGnt8nMTaFESYAbRB08WuYB0ABVQuz7GPCER2NfIkr1flrmSym6gwC0HqUhBP9rRtdAK92O74zQacEaW6YaUWs7s8hJSg2KrvtLmvlFaJpN1pUbDocwLrYsF3tYL1PbeVXx1itC0cXMC9+ypOt1dCQ6+HLKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761896523; c=relaxed/simple;
	bh=rlsZNO3r9jM3pXZk7rHdjWG3W9uPoXZ+KGBQDQntePk=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=N+BW9tQqCgVY7i2nznwKavJ+NmNEm0nO7iVflwTLzwwTat1vFGi7jVG71taYpzDdVrvcYZj87q6GuI18A+0Xtk9iE4oehRu5s2pGyUDiUxmk/v7u5g7KwUBPNErBCtABXXPEV60fXpeJRcnOBX0ACf6q7Kv3uFfm6iFfM/wm5oE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=M4Y3vsP6; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=f+SksGqu; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59ULrQ7q898142
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 07:42:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=ovRnpTLoXzZqTnzO7mofmt
	3S7grzyD3/EeCjszf/sVY=; b=M4Y3vsP6Dcw2wF78sSC5Z0ULnuulTtQX8NUoIb
	5K7INk7y5FS5wzF+YFDZUKgZFfjTgBjs/ahN++XNqE0T4OQVp0bxv8wof/XC7thb
	nr59Dhwb8WRhFsY1NmP6rHszu4BxKCQCtJM8/KNI3rOSyntcdRdgO+XsIw3amvOS
	OzBZNgJTLRjWtuW+Vl4Ap07aZnPH+7NIbehc9C8qQ4pZ7gaF1QqqicKpWxt0ST5C
	u9oVZ3UdGoQTdxMuk5AxhBXK1nUhjvoeYtxX631azPODHC/57k5oHs0EvLTf3Im7
	GjHsqooao4BZAA2RqOYx8n/5xQcc/CiVI4tFbCqiy5l9SYBw==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a4gb21872-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 07:42:01 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-290d860acbcso39936265ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 00:42:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1761896520; x=1762501320; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ovRnpTLoXzZqTnzO7mofmt3S7grzyD3/EeCjszf/sVY=;
        b=f+SksGquD8NnU97nd2DrmidNGW6KUHr9BHkFzvrYRR/9cyCpbKjLBlawSsWGkmm+nF
         8z9dgSWCWU3uuJhYEYjBac2HPA5UBtIWZ6WqQ84yoqzWGsRHa48pAFdSIJE4eemDChiM
         j6DsqYW2zPp7J26uUOar5V2/0+hG8Px7tMIk6tQaK30X3iA3p6Yg1L6Oi6V8EapcwwFg
         iD/aWhpbsm4jD/YUiJMdQ98Xx8Qyvv7dU3WkGveDZMbGeu28IzNUx8bdHwMwyN0KavuT
         5gffBgs3ls6kMQQtVr3ZV4hu8UdimelibPWeMEb4Mq3livMZB29gfz0AaJhW1YLcR21U
         FR6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761896520; x=1762501320;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ovRnpTLoXzZqTnzO7mofmt3S7grzyD3/EeCjszf/sVY=;
        b=lnK4E/o+f9FCbN+T7Fh9NVLiwBhv3pPe/0gt60IEkazy+jc1BSuocNS7M+J8KQZgQ2
         HQVJh+JnZQ9hD3bYHitrY5bjcHQ+9Vu6jphjnPiPtMVcp9KOY0ejxGIngSeDspOFY8VU
         fhwMGT42KxxflcdLbOUrpbPI76YHwsdarBf3KSlclbCRGE14evvXks3FoQP6wva/J98R
         GDF9VY8GMsj3BTg7IC48yEOXqcKWKH4senyWz0YoXdqPKhkrM2aurwqiDo+1Fde1LaHf
         uZ7NsICRBo6c6WlN87BMSBnIwDYpsmFzv+QWWtHJSR28wWQPxJ0aCm3/nIoqLk6Ju0gt
         Oj3A==
X-Forwarded-Encrypted: i=1; AJvYcCXr9ExKc4qIeQPbzDyh+jvmrkq/nS/0OctKWitkA4MYbcIpet2s2K9M7QyvjbnfRVeBVu7p2wGcHMUzW5U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzss3255x6eRbK9jYFHrOXRfHWXg3x4F5lOK8UKOKvOHJx28HJB
	UoSmqpVbfTDeAsJgaWx8/HXgF7NqVCDi0PHTWUa7vTNBzeExHt8uk7YJz63hiW5GKc/2MIgRHtt
	ipKyhUEGy8Zw4LTIBKRbKLAqSCchtHmWECSJR2yOk3l4iyiOevw0MKFVOxc2/Fa3DxB0=
X-Gm-Gg: ASbGncvG2FNPb2qCq2uTd1OxhYTGSoAdXaZvhNH8+FoNO3BhA2kErasKb9fWwQojWGC
	bl6sqIKbIN1aZYpB/04bzbl8ueD8sNcocZ3r2n2hnzU9UdpvINaFMEX6FEPHx1BzBSNVQm6llhS
	9rp1AFALpOxaQbr1J5KnOadGwqr7R+KxE5zCd6r1RcaC96fj5irIPN6hKwGi0zbwOQvFg6XKtLz
	yOJ22dVIRy/gShMF7jSSxNLjhI/ImcEFIOsm0UxTPinHSl/+urKvB3oIHfgvLWNA/OhufUSBAIT
	VhZzuki4Ru3VY9ps1ti0PjcL4Fu2Huf69KyH2eIby+eaOgXGccitgzKOZW7VZBYJM0ukeM18N7i
	eMUJDV33fAxw70M4vpGuQfy1FGJbw9QuqR3aBgd+ToBAAI+wqmA==
X-Received: by 2002:a17:902:c947:b0:295:1e50:e7cb with SMTP id d9443c01a7336-2951e50eb4amr29425975ad.23.1761896520302;
        Fri, 31 Oct 2025 00:42:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGnOvple5E/jpu7Ojs3vJuSdtwKz4L73asmo+O5/kr7zaTkjX8j3txjYMGu4cHSGN+TDfMUMw==
X-Received: by 2002:a17:902:c947:b0:295:1e50:e7cb with SMTP id d9443c01a7336-2951e50eb4amr29425675ad.23.1761896519768;
        Fri, 31 Oct 2025 00:41:59 -0700 (PDT)
Received: from hu-jingyw-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2952696f0c8sm13276735ad.71.2025.10.31.00.41.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Oct 2025 00:41:59 -0700 (PDT)
From: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
Subject: [PATCH v3 0/3] mailbox: qcom-ipcc: Add dt-bindings and header
 files for Kaanapali and Glymur Platforms
Date: Fri, 31 Oct 2025 00:41:43 -0700
Message-Id: <20251031-knp-ipcc-v3-0-62ffb4168dff@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADdoBGkC/22Nyw7CIBREf6Vh7W3gtlVw5X8YF7xqifYhKNE0/
 XehC3XhZpJJ5pyZSbDe2UD2xUy8jS64cUil2hREd3I4W3AmdYIUG0aRw2WYwE1aw1bVjIt2xxg
 ykuaTt617rqrjKXUlgwXl5aC7LEgw5lnnwn30r/Uwsjxe3VRg/XVHBgwaI6zQqhHS1IcxhPL2k
 Fc99n2ZguSLiB8+6cUPj0CBK1nRSiqOxv7hl2V5AyI9euD+AAAA
To: Manivannan Sadhasivam <mani@kernel.org>,
        Jassi Brar <jassisinghbrar@gmail.com>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: aiqun.yu@oss.qualcomm.com, tingwei.zhang@oss.qualcomm.com,
        trilok.soni@oss.qualcomm.com, yijie.yang@oss.qualcomm.com,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Jingyi Wang <jingyi.wang@oss.qualcomm.com>,
        Sibi Sankar <sibi.sankar@oss.qualcomm.com>
X-Mailer: b4 0.15-dev-99b12
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761896518; l=2031;
 i=jingyi.wang@oss.qualcomm.com; s=20250911; h=from:subject:message-id;
 bh=rlsZNO3r9jM3pXZk7rHdjWG3W9uPoXZ+KGBQDQntePk=;
 b=OV2NRnkecWvBSoptNP9Hzj90ZICtv0J9DF+D+bN6dKOSlY6MQsUxFBkEXBDiv7MuBJeB16Vyr
 7B1krNcWNyWAtRdSWHt63Q6ZEUil9tflf79bYJyqEguqqISJ2dtlN00
X-Developer-Key: i=jingyi.wang@oss.qualcomm.com; a=ed25519;
 pk=PSoHZ6KbUss3IW8FPRVMHMK0Jkkr/jV347mBYJO3iLo=
X-Authority-Analysis: v=2.4 cv=efswvrEH c=1 sm=1 tr=0 ts=69046849 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=2HIG4QdnYvknWnWHaxgA:9 a=QEXdDO2ut3YA:10 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDMxMDA2OSBTYWx0ZWRfX0XBfwt9VbD4H
 EFztfqwA+MTiK0cO6Bjmk7KuY11tuAqpQi2PJt976XlP2reNLEoMtYVDl3ekP4pJPdakqDKWMk+
 50S68ySbek4l01gNsXY0p733Ka/qTxpHoPss7c6VuuKe/6wBhHxgc95tCvk03HMtrN+nxAmg5gW
 T/db/dWzg2XY/anoMhQVqJ5UvpRXXQtuXhSBTDh0FOfu129mZv1XwVoBVxRgl9PJyAxr1dKnXL1
 JjYtXg6hcLfr9pp8sZB55C/khky2mLejXyYPxlkpl04vG5ckRTGg2+L7/wiHFcywT4JfDeUeSGQ
 jZLlkhqa+D1tGmdSvi06ywznRUto9x42krNGD+Mpn74cOIiUz/MI9mZRQ+hJ2gzKFclBuSX3c3R
 hhTJHYDjJ+UgsC7xVZFQsttdAGUp8w==
X-Proofpoint-GUID: oF89G-isJYETncpnrhPx6jb_wQ0laLYP
X-Proofpoint-ORIG-GUID: oF89G-isJYETncpnrhPx6jb_wQ0laLYP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-10-31_01,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 phishscore=0 impostorscore=0 lowpriorityscore=0
 priorityscore=1501 spamscore=0 clxscore=1015 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2510310069

Add dt-bindings and header files for the Inter-Processor Communication
Controller on Kaanapali and Glymur platforms.

On earlier platforms, Inter Process Communication Controller (IPCC) used
virtual client IDs and performed virtual-to-physical mapping in hardware,
so the IDs defined in dt-bindings/mailbox/qcom-ipcc.h are common across
platforms. Physical client IDs instead of virtual client IDs are used for
qcom new platforms like Kaanapali and Glymur, which will be parsed by the
devicetree and passed to hardware to use Physical client IDs directly,
so header files are defined under dts.

Signed-off-by: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
---
Changes in v3:
- Move header files from dt-binding to dts - Krzysztof
- Reorganize patches
- more detailed information in commit msg - Bjorn
- Link to v2: https://lore.kernel.org/r/20251029-knp-ipcc-v2-0-8ba303ab82de@oss.qualcomm.com

Changes in v2:
- Add separate header files for different platforms
- Merge binding and header file in one patch
- squash glymur ipcc change from: https://lore.kernel.org/linux-arm-msm/20250924183726.509202-1-sibi.sankar@oss.qualcomm.com/T/#m186ef6ceb50936185d07b81e2d36228a5a361d34
- Link to v1: https://lore.kernel.org/r/20250924-knp-ipcc-v1-1-5d9e9cb59ad4@oss.qualcomm.com

---
Jingyi Wang (2):
      dt-bindings: mailbox: qcom: Add IPCC support for Kaanapali and Glymur Platforms
      arm64: dts: qcom: Add header file for IPCC physical client IDs on Kaanapali platform

Sibi Sankar (1):
      arm64: dts: qcom: Add header file for IPCC physical client IDs on Glymur platform

 .../devicetree/bindings/mailbox/qcom-ipcc.yaml     |  2 +
 arch/arm64/boot/dts/qcom/glymur-ipcc.h             | 68 ++++++++++++++++++++++
 arch/arm64/boot/dts/qcom/kaanapali-ipcc.h          | 58 ++++++++++++++++++
 3 files changed, 128 insertions(+)
---
base-commit: aaa9c3550b60d6259d6ea8b1175ade8d1242444e
change-id: 20251028-knp-ipcc-6b4189f71121

Best regards,
-- 
Jingyi Wang <jingyi.wang@oss.qualcomm.com>


