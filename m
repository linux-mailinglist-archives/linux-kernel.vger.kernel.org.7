Return-Path: <linux-kernel+bounces-732684-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8902BB06AA7
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 02:40:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 75B803BE000
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 00:40:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 844DB192D97;
	Wed, 16 Jul 2025 00:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="gAEzoZ8w"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6832718FC80
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 00:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752626422; cv=none; b=dTXT0djlHpmqRayrm0wgYYj+TRKDpPs24lkbBzxgeH5bmiybgzbqE6GerjMIeo4aqLXxoIEVH97oB2m27EdsJ54NlaC/qo4ZWPpK2vHkggzSy+iwvEJoqsC9d3DBxLFK1/ETmC2qD1carLR9dTW+JKZzLpYn2BxlZuzcC16x8ZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752626422; c=relaxed/simple;
	bh=1Z6UkGBZr7oN805L7yjX7D1r1YPj7Qg+OqqyeMr4cyE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ZrKDVChtq/GVy9HQJ+aMtfB/qcXVP4CZ4zMHVpXwb+G6GGr97/YKZJZsP1DcUlaWqVp3Md05BXCXzkDXlTLi6XJyqw24QlNaa3TkPpEM+3WcNhQSkGBM/lFilDKDN26aiyt7pbj9mSAxtRque7+1LO82zD10iXWBpXkc3d0vSyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=gAEzoZ8w; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56FGDGH4017998
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 00:40:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=VzUYJgFGxoAVYBUN5oc7Pqp3z3f3GFuBQrm
	QxX8NW28=; b=gAEzoZ8wub87aT+QmrD5lAyTodOyu9WtMtiKUyw6qDnVvaIJgQH
	PfGDkJSUUdqlkMxdTynEnJCSlpNoXWdvVW25FPef7qe51RGS2u30dJ4tVNxLhWPv
	hgVJuxzIClnJ8hMXJ6L03v5RqEN6FsQrjZVwnFaADyqu1dtKyGXmQ05d6K/rR66B
	LWuGfFR8dYSOjHeCH53Bmo+H92txnEqtIb9lkoXPDeBnXF7F9lsYDSQ1CjgXjg38
	d6eu32cZSJsX6bXtjREcTbNmtKz1ke9lnKioCjgWahMRJqt/l7VakNpWgrZRIjZh
	SSCtEj4VZfa9fO0/cGFoYS97RUqKy3e1XDA==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47ug38256h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 00:40:20 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2369261224bso65584625ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 17:40:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752626406; x=1753231206;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VzUYJgFGxoAVYBUN5oc7Pqp3z3f3GFuBQrmQxX8NW28=;
        b=uYNCkPly0+Ta9n4brgdc9dp3cA0cNSKLuikZsB7V1Ej2aFZuZb34+Hu4vkgQaTWY7+
         B74Vif+XwQUREXWqKGHJo6jVz1zlaABuI5e4sZAg01QX8ey0YrclrVYiBhO7DV8sAsLF
         9wIx+rMPVmn2pha7kB/WCzJRVeg2Gb123itQHFTLRLHg6tnO8RPxChQSx6zpTdgSLEdY
         MN02EWV06ebl8Z6NaO1WSY2TpVwkb3nL1iW6IjmZSqVDd0FGfxa5AYSXimzbeLTd3WR/
         t+sKGtuJ8bozGdbRpCU75k+6J89vQpWlw/Qt8SyWCiZ9jS2WpHtfrfBCouxTElZszDZI
         PE4Q==
X-Forwarded-Encrypted: i=1; AJvYcCWqdXaiPtXDwQYhyS58tAW9r5Xtwogv6zNY1duiPOp1aVH0wbPQnc9IXHN3L7FxmjvwPDQNgC/F4RwnH1E=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTm7c64qr52K5TQUxkpd2SSAHs+wrLLf2cO0Rov3aTEcxUQ4FX
	t2oolZ9isBvCe7StY86v91bwJ7SmzUUg+xi5zYdkHshUFvwVqx7jZ/oeRiZwV53sM82ZGefN6IT
	9+4oYFiLEC/HzSvs7sSzm9isAfSQpdcLl0sEdWxqBQYP1pnCrzytSjW6h/wLiaNXACQp/btLo3Q
	s=
X-Gm-Gg: ASbGnctSY+rZsSEBcsYfZX7xvcCJTQtUA+GSl2mHAbgQHHPRD3Q954Y5C7mMctnotWh
	rjXHt6FRLNLz1LJCyEmxm52byBvG4SQlXRPwUpgMhaVFuXkL5yjgNG8PzEe4EIPj3su0D4gz7DR
	gaVeXpLpau0VFhnuv1MCfQ/a5rHnhF7Prh4iMlE5ppgb4Nok4NCHURapcuZQj5eWI56ETjoJYSk
	kTjLqP970+zEI3Xl2GcCEdiM6h1z+sW/0U/umvtb+8LcKpAecVd8ieUzEeoVfKv+k1OX9w/Wijj
	ciOHMHQKDYn52gAWIUwW9MKkqQirpCRgg42+Pztii77TJeTZD/qHgYqSyM1gpbP9uybbbG8jqFY
	s4193B3GbypFQRg9/Krnx4zVR+Us=
X-Received: by 2002:a17:903:28d:b0:234:c7e6:8459 with SMTP id d9443c01a7336-23e256cd95dmr11394235ad.20.1752626406517;
        Tue, 15 Jul 2025 17:40:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF3ES/p6LGhzaV34ArPImL6N73MMe/4t3qyNZuIxxo4xO9vbqvGv7dNf+3w6wdfTXF07zgFqA==
X-Received: by 2002:a17:903:28d:b0:234:c7e6:8459 with SMTP id d9443c01a7336-23e256cd95dmr11393945ad.20.1752626406059;
        Tue, 15 Jul 2025 17:40:06 -0700 (PDT)
Received: from hu-amelende-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23de42aeadcsm117015525ad.78.2025.07.15.17.40.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jul 2025 17:40:05 -0700 (PDT)
From: Anjelique Melendez <anjelique.melendez@oss.qualcomm.com>
To: andersson@kernel.org, konradybcio@kernel.org, robh@kernel.org,
        krzk+dt@kernel.org, conor+dt@kernel.org
Cc: dmitry.baryshkov@oss.qualcomm.com, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] soc: qcom: pmic_glink: Add support for subsystem restart (SSR)
Date: Tue, 15 Jul 2025 17:40:02 -0700
Message-Id: <20250716004004.311001-1-anjelique.melendez@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE2MDAwNCBTYWx0ZWRfXzoJu/C0NVujQ
 LIzFW4Gn9DscLPIEvg+BNgZC14ymbIg6VlX2x+zUub7HogFVXkcWjAqjm6WcSRcHaJ59VVW5N3G
 akFKhKrYWRO0Mi9UeKFhaJb+b1GE/xJvPrslqlXFAfaGOgQ4LOmwGAY+9X9ExxRAwhO6lbfHIcS
 ttCihuAVif36FWeJkh1ekuQ3Wa/Pw01gTtRLtCeFMq0YDcq+5rRZttxVldtFZ6aJgiudVHfO2Nw
 /ciM4/ALIAkWEA47QeNHh5mdSgRmKA/aasMgxkNLLlPOQSooaXkLgaGQim/l3lQkJUBGa+38Xzr
 B6YgEGqf29ghoCZ3ZVAUXsb7Nd/yp49ASnPSfSixhp8ygXbiJ3Zs5pYZ2h3t6mBtWrIiO64HCCx
 x/DB52/uARAtBqmCRKgJU68gsGuKFOvEpE/ET/wnIdRm6dcGVDedMim0kNuO/lskzr1EIiwD
X-Proofpoint-GUID: oC9kMfIt2F5mNYO5YLaXaLPXmr8s3ip8
X-Authority-Analysis: v=2.4 cv=SZT3duRu c=1 sm=1 tr=0 ts=6876f4f4 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=Wb1JkmetP80A:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=s3rR3T0EdQVOb1-HSqQA:9
 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-ORIG-GUID: oC9kMfIt2F5mNYO5YLaXaLPXmr8s3ip8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-15_05,2025-07-15_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 mlxlogscore=999 mlxscore=0 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 adultscore=0 impostorscore=0 malwarescore=0
 phishscore=0 spamscore=0 suspectscore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507160004

Add support for PMIC Glink subsystem restart (SSR) so that PMIC Glink
clients are aware of when subsytem come up or down. 

Changes since v1:
 - Add "qcom,subsys-restart" dt property to enable SSR
 - Add ssr_name to platform data 
 - link: https://lore.kernel.org/all/20250624225535.2013141-1-anjelique.melendez@oss.qualcomm.com/

Anjelique Melendez (2):
  dt-bindings: soc: qcom: qcom,pmic-glink: Add qcom,subsys-restart
    property
  soc: qcom: pmic_glink: Add support for subsystem restart (SSR)

 .../bindings/soc/qcom/qcom,pmic-glink.yaml    |  4 +
 drivers/soc/qcom/pmic_glink.c                 | 80 ++++++++++++++-----
 2 files changed, 63 insertions(+), 21 deletions(-)

-- 
2.34.1


