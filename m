Return-Path: <linux-kernel+bounces-831401-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DF91FB9C900
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 01:29:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A10CD16EEF7
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 23:29:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BECD25484D;
	Wed, 24 Sep 2025 23:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="pXOkAyPS"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CAA1258CE7
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 23:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758756547; cv=none; b=c0pSLLYdCqfg6mNfRaq1D9kPqoTLjQRQADnAHGzkGh+g73XgT0POxscpGIemUOWo3A5ztZie3SITHDhYSMymog30lKYK0DU/BRB+kwLxjIh/rbHg81xiQEBeVlzlX5AfCkUTzq8HtIvy6K1cF9A1TZ3L5lesAkdyQDaqpK4jUx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758756547; c=relaxed/simple;
	bh=iNvBhLDG9ygoIMGrSAjur0ixwelDiqAhu5UHp/R+O/o=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=FQES0u463MyydhSNMp7Dtf4Dpw3DhXPgDHlCdo/duMsXetWNK3DuD+Oiu+djLe6uipVK5GWef+6BpxJDc9Xhpu9BtJZ/3PhbgH/QkMk8BZATnBo1dCr3hjInT7ceozJFk5vmuMnqxppoac0hHkzA+Du+cAVKZ5tvKgtfGAmaHoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=pXOkAyPS; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58OCq7le020897
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 23:29:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=9+l0csdA98QdCq8IK8vG8I
	Wfe5KMbV7vWJnvNBVhQ9w=; b=pXOkAyPSBZXFtG2rliNUD5sQmFFf9FZim01R5Z
	r99r2wPHw2nyj0Q2mPfoVqUBdPD1RFJarrW46tgkpRmnj8GvPqsb4OfGI+eYiRQA
	z5ob4Zv3J1zmNRj0CAFQpY4AUnXigx1GTaqBKsaVMlXYki6dzGNE/pdCpOf9zo1O
	Oi3nCArt74qgdLBZVTWOXPQ9NJujBjhOgxg97sVWBkHbVi+sxm5dyfhar7/69TPD
	3tb40dsM+BpX33k03BquvfgtMfe/LsopH6+vX+JFefBDQviV1nQ/1nJ8Q/1ODgh5
	jIoIsX6QStNrDGP/HH6ZYJpTqxFA5C1Zoth+yQp+yY32pVxg==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49bjpdy8gv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 23:29:05 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2698b5fbe5bso6238665ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 16:29:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758756545; x=1759361345;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9+l0csdA98QdCq8IK8vG8IWfe5KMbV7vWJnvNBVhQ9w=;
        b=FxcHVq7zOvZBnkAvQvzbuYePmQIrfZDf6g+fgcAyIh40r24zai5W1e/UU5WTjJtq7/
         a/NkCy9adB+59HTAVahFZEjaEVLSlWyIqFGDLU6RXcfIbYujjl9Ttl4Fv/F4ti4/4W0x
         sopixmCCDgK+TFuFGtb4LAP3zozwin4v7AQkt8392nHPtf2P/wpq4B5kzKzXz/yrbrbV
         jL1P/1ixZDxzgchIvPCboORozxkD/2yNtIszkXVmIM4/abKrKcPQbIklgV5IgoB6E4VS
         1TVflxA/rfvcfzkIyLEfWuQIQv+xg6z3EZhQRKmL0wS28XkmK92LwzQ1orK+0MIMHwRj
         Rf5Q==
X-Forwarded-Encrypted: i=1; AJvYcCUecDM+MaTF2D0rihkDeqaN7/RIUjrlRZaOCkjwbzJLR32cYsS/jWcKaf0xTK5ovwdVSiTPVyVZx2HjwaI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+yID+3rufzacPADlITM4JSXSxttw/8d6FqFG59rU0U54rUEO/
	JOS6oFEX15ydrSuUg0+ovIYwJu16L2gJ0seg47FGxNxuABd0XNuAc1zzQGtnA4SSOm6UTQ2W96N
	hAPQnQ6Aa5/WAvsDGYEZ9l5UHxz+yhQ9x3AujoI9k2qAYX26IQIfaVFiqsAPIrt/6JDM=
X-Gm-Gg: ASbGncus0Hr9DXDKmQXzcXXvmXPNHPIWK6MSmWBkC24JCXRcEMDhWBcV7RcsFiA8J3O
	cN3kdJyisdhmxrfQ0nnh7pNSld44Y/EhyDOtCpU93/4/aNmjf8SMRkRCw2Pd+EstMF9TMa3lGvv
	ykZMLGfsuaSh4oO5Sa+mh2EWP/Ct95nL8cL6oKQw/ICR1NhCayg7DF6xSB7D5aSIo0LFsM1Ubcv
	lNEsdOEK0MZ4UXjBwNyahkJow2GTImZl+o+TsxL+u8lrzmizV7wMeRvPzqMRhRaFKPEwtfFqgH2
	0E3onE0HNyIzdO0P1lx4riDIQ25zBNYKWhH7XTZrPhbjI06Ktwqygzg2c1mpkKMTxui4KEJazUi
	InDvhZJGduUiiLpA=
X-Received: by 2002:a17:902:db01:b0:272:dee1:c133 with SMTP id d9443c01a7336-27ed49ded13mr14244295ad.22.1758756544873;
        Wed, 24 Sep 2025 16:29:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEUEPADcwlddCviiL0reaYKNZCOT/tRIgVAPefqNdpaaX6oQdCmVpOJj5ORnG7Clz7s+SorlA==
X-Received: by 2002:a17:902:db01:b0:272:dee1:c133 with SMTP id d9443c01a7336-27ed49ded13mr14243955ad.22.1758756544429;
        Wed, 24 Sep 2025 16:29:04 -0700 (PDT)
Received: from hu-jingyw-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-27ed66cdfafsm4292825ad.30.2025.09.24.16.29.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 16:29:04 -0700 (PDT)
From: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
Subject: [PATCH 0/2] Add UFS support for Kaanapali
Date: Wed, 24 Sep 2025 16:28:59 -0700
Message-Id: <20250924-knp-ufs-v1-0-42e0955a1f7c@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALt+1GgC/x3MUQqDMBCE4avIPndBpVXTq5Q+xDjRpTSVXVsE8
 e6mPn7wz2xkUIHRvdhI8ROTT8qoLgWFyacRLEM21WV9K13V8ivN/I3G17YJLqJzDSLlelZEWc+
 nxzO79wbu1acw/fdvbwuU9v0AMNSaCHIAAAA=
To: Alim Akhtar <alim.akhtar@samsung.com>, Avri Altman <avri.altman@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-scsi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org,
        Jingyi Wang <jingyi.wang@oss.qualcomm.com>, aiqun.yu@oss.qualcomm.com,
        tingwei.zhang@oss.qualcomm.com, trilok.soni@oss.qualcomm.com,
        yijie.yang@oss.qualcomm.com,
        Nitin Rawat <nitin.rawat@oss.qualcomm.com>
X-Mailer: b4 0.15-dev-99b12
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758756543; l=658;
 i=jingyi.wang@oss.qualcomm.com; s=20250911; h=from:subject:message-id;
 bh=iNvBhLDG9ygoIMGrSAjur0ixwelDiqAhu5UHp/R+O/o=;
 b=259J+ycLevBFX4HiFzgSeQV3oznulyjnT7EPeTQadK+TvFBBkL0cJtcubNHatuDgWE2EAWeFO
 wSvsT6yl5qzDNQJe7HxhU/TDFOjakz3gnGHdI2MRwPveN68RqnE3bS/
X-Developer-Key: i=jingyi.wang@oss.qualcomm.com; a=ed25519;
 pk=PSoHZ6KbUss3IW8FPRVMHMK0Jkkr/jV347mBYJO3iLo=
X-Proofpoint-ORIG-GUID: vXSTsdhWPdt7z_x-mCnUiPusjEjS7Yxe
X-Authority-Analysis: v=2.4 cv=Pc//hjhd c=1 sm=1 tr=0 ts=68d47ec1 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=YZPfJuuz2T7GfvdrPZMA:9
 a=QEXdDO2ut3YA:10 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-GUID: vXSTsdhWPdt7z_x-mCnUiPusjEjS7Yxe
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIzMDAyMCBTYWx0ZWRfX/oc7TASz10ZG
 JjjZLonvXkNQx8Odotcq+5TJ4LKyOSslehtPCMZ1uVa4gURc9Bd/V3gw007Qx8Zj47lCESbRr1o
 F0vEMt/W47UaYKD74gWDb0LvBZhCswIa9qpxIAkgDNugoMvrUyyhI1qWFT7xVDnAd/KbGPO2tNX
 fUdQ5ctaFT6CzszWJ82mOBDzprNeYpj/6L1xSHnNCb3p5qQrEyWJEjOIQnRzrCgNy6cuoBKHPPo
 FAeqwegKYyCFZhWk0md8tWGbS4TbOAH6+FcyiD9E8oiZEQ43jgyNoXeOTpDNGT9hgArAPHHdNPx
 D+pOp7tSKWNCxBi+thC+u1FbwvH6zddrdid/Leu2AG8oYVZNp2zKTGPQU/str94KestPnF3xooA
 ONCSQmk2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-24_07,2025-09-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 bulkscore=0 malwarescore=0 impostorscore=0
 spamscore=0 suspectscore=0 clxscore=1015 adultscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509230020

Document the Kaanapali UFS controller and QMP UFS PHY.

Signed-off-by: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
---
Jingyi Wang (1):
      dt-bindings: phy: Add QMP UFS PHY compatible for Kaanapali

Nitin Rawat (1):
      dt-bindings: ufs: qcom: Document the Kaanapali UFS controller

 Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-ufs-phy.yaml | 4 ++++
 Documentation/devicetree/bindings/ufs/qcom,sm8650-ufshc.yaml         | 2 ++
 2 files changed, 6 insertions(+)
---
base-commit: ae2d20002576d2893ecaff25db3d7ef9190ac0b6
change-id: 20250917-knp-ufs-476c9fe896ef

Best regards,
-- 
Jingyi Wang <jingyi.wang@oss.qualcomm.com>


