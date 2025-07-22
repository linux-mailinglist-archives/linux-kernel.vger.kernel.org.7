Return-Path: <linux-kernel+bounces-740456-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DE9CB0D45F
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 10:22:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C17A3A39EC
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 08:21:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD7372D3202;
	Tue, 22 Jul 2025 08:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="mQKnoDT2"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADAEF1DF25C
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 08:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753172503; cv=none; b=Ij8ZUbbr0HNbHY9HYq+PwzNToQ30bqFxyJxlTbDjzH+TmpYE2ckBrrbxVaZpbthGLxpNFIZ/5/89xMVuimVAvgbEo99AhoqQ3pyisldRCq6izkgur+5399M0GHhYRQggQCUj753JXKmXFcLJJkbzSHYDBw2j8rGeK/OAx5nl1pA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753172503; c=relaxed/simple;
	bh=gbbHYhK65i3zf/8VX6rUyX/8c4K+RvLjAbOrGFQYRoA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=JOzfCTi1OnVfCFvA5gDPC+fSScJr0S/q21qI+ffyWVHU9H5JzcJb7tbDwfESOOhGcimZvX8VMN2tWw7T2uK0f7NcQXYW+dmh6AURGMRNTzhfv4UM0fil6iClMcs70H9u7ko9O1L39YsfjM2puQ6e6aSJFaLllkIYjjUDlnZAMFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=mQKnoDT2; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56M83Yks010096
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 08:21:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=bVmcos7Xdrhf6+4zm7tb7S
	LejYPfh6VcqSOy4gUcvc0=; b=mQKnoDT2/hxp/kieg05kixeSppar4sdeJ+jp62
	ohYw+5OtFkAOHVFqheH01IxUhazMNJ7c96nvzufC+me9+BpApKx1fcabIDVKX6mS
	Rt0MwRVLYuwzc5lYBCbN7vvdO0AJofFeutyWhdc1ADN4TTD1n0Lfz7S89SkVQGI+
	GkxUp3JCxJygqWrWX+NDWEXM22XkRGW+jF4a5LjNF/TTPvO7D5rCnirWpyP76KWJ
	T7ZZStL9flU8dGJyld+w/FVmIvWJN3UBnkxw3zupRCHT7meZRvXb8T+6xZKm0gM+
	gEQ7IYm6cmV70upeRs9zHkEd4c18aEyXdM4Egj+6C35SEcPQ==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4826t181xy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 08:21:40 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2356ce55d33so88032625ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 01:21:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753172499; x=1753777299;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bVmcos7Xdrhf6+4zm7tb7SLejYPfh6VcqSOy4gUcvc0=;
        b=bIBR5pLqQAdPvd+MrW6YKzlvqzxIVSnIRLAVQ9K3Mw38cjWW7rLi38tSCm1KvSQSjM
         lhyjyEAxjhqGnbLL0OofqS6uns/xCUiJLYwHOu5DQsdgAD5C5pGwEwrkm0v8/xEbs374
         TtRRsI83hjqinWp8vRkLjVh1rs0gKa49KIr3/UqmgHko8Qj72+7KIHqOauoQ05nWEev+
         Z6yKou99grcDxoQyRh95nnA0P99Io1HA4Sy1RMCYjaKbSqSi3CO5H9QaKOijrju8WLsY
         nfKxKh2I6sYIQvJa+rv9V9Zgq2E39o6BrcDRN7qT/mjFgqrjO6Zg5SvN7QE3tze+/fxz
         0xow==
X-Forwarded-Encrypted: i=1; AJvYcCWEeeEAhFAbOJVXqmNwMj/1U4DUum/txLDA3TPlJ8TosweNVD2wU0x+AzcuOSBorJOVJr51EFvqyrRM8Zg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwAt1SEq4qY1WO8+t3oAcBjp1GI05KlpedWEFrv1wgAqKfL67ZC
	r3FoHL8gi7CM3o51M02xWhfkp91TBI7SIlI0ft2cinN1c/SMwt1yF5VPNojjnPQCh+CjhUMbGmS
	93VOYaB3XT8p+gfJIZYShuBgUAVRLFzXnW3GH1uJz84BXfo6hLnCK8NjjDnoeFHxnfXo=
X-Gm-Gg: ASbGncuQL2r39LoX3SrLDyporLPSZSYlbnjxkrOFJLIxKvR0KoOON8WFsiISGqXtDZ4
	AXfrp74WPdQBXlryD/r7TTNyvWMRnyTwVj1wLl70yxGkQstDiyK3HUUogp4jpBQlMGGMmOxHcOJ
	RyivxmYotjcn5U8TM2HCr3G0LY9IRLtNFEb1Cha5Ag+POKwvisiao67l3/FXfgcm8JzhJw5At/l
	S0v4HBh/wq0WQck/wudlydrQb2flQssFVI0DAOJHQHjW9Tbb3gSD7ukFqJh5ntOu2P2acdIqVil
	XkACPHxkGr6mA59TyZJ7yOzGMXEf1UCoth7VcqK2VK9TRLuLq1e1pcxqmyTq
X-Received: by 2002:a17:903:3d0f:b0:233:ab04:27a with SMTP id d9443c01a7336-23e303845ffmr287496865ad.53.1753172499142;
        Tue, 22 Jul 2025 01:21:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF+8ujr/Hn52UKERa3Dr8P2y02BI0scRpHRswLWcXVb46RKMFx5fVOwI5aqhHBIpxu6C5PkBA==
X-Received: by 2002:a17:903:3d0f:b0:233:ab04:27a with SMTP id d9443c01a7336-23e303845ffmr287496465ad.53.1753172498713;
        Tue, 22 Jul 2025 01:21:38 -0700 (PDT)
Received: from yuzha-gv.ap.qualcomm.com ([114.94.8.21])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23e3b60eb01sm70994255ad.57.2025.07.22.01.21.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jul 2025 01:21:38 -0700 (PDT)
From: "Yu Zhang(Yuriy)" <yu.zhang@oss.qualcomm.com>
Subject: [PATCH v5 0/2] Enable WiFi/BT node for qcs615 ride board
Date: Tue, 22 Jul 2025 16:21:26 +0800
Message-Id: <20250722-615-v5-0-4677e70e25ae@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAZKf2gC/3WQzWrDMBCEX8XoXBn9/5hS+h6lB1laNYI6TizbN
 Al+98p2Dy1NLoJZ9puZ1Q1lGBJk1FQ3NMCccuqPRcinCvmDO34ATqFoxAiTRBOBFZWYUc8kpQY
 stahsngaI6WtzeXvf9QDnqZiN+xB1kLPbzJrq+ceLEysVJ7VSlgiBKb6mywT1dY197XOuz5P79
 H3X1eV5WXNalwGvkzQ2lQnKS8M589qZ1hXP6KPTyhjTKs91aD1YxTlaGx1SHvvhsp05063Sn4t
 mWvK9tVRYISJo/q/AZjOzOygraPmMoBXx0jH6AOV3UI4JLl2NACI0iewBKn6jekdFQaljUYtAl
 Q76DrosyzfQTmNL4AEAAA==
X-Change-ID: 20250704-615-21c25118e919
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Yu Zhang (Yuriy)" <yu.zhang@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1753172496; l=1741;
 i=yu.zhang@oss.qualcomm.com; s=20250625; h=from:subject:message-id;
 bh=gbbHYhK65i3zf/8VX6rUyX/8c4K+RvLjAbOrGFQYRoA=;
 b=YrhA0EIKKURO/scIDCj8//vrF7U7X/vEbzIkbgJQj7Mujz5fNDY15Ulm9DvqIBxfYowW07ddj
 Nf39JVCFuPpA6tKl4ft/iqJvK87+iUnlDnB74/3O9r88kiksvXBFqFt
X-Developer-Key: i=yu.zhang@oss.qualcomm.com; a=ed25519;
 pk=ZS+pKT1eEx1+Yb0k2iKe8mk1Rk+MUki89iurrz9iucA=
X-Proofpoint-GUID: I4IdnW_VLI3Cp7zfn5kJj4ctecQVtwPk
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIyMDA2OCBTYWx0ZWRfX+Nbh/taRPrZJ
 4JBlri43OTCqXw2Mv67HNi8sYmCFuWOxr1KdFFJPZtNvSkcgauYUur1FQIlZXmTZVejBJVUvqr/
 exGKF3g7r5VeTNiGyP9hyLGh26RMP3TOi+855Sj31p3T6OtkLgAZ75uX3P7IdPvMbhYFyDDXlBZ
 rD/bK8Qzg8r/hl9/i925Hb7Rr4lm3qOtS58FHx2RExvURrHK0dX6HVPbXjzFTtupBKvNWKSdzL0
 yXl2x8MniNNjqIAwtgOS3cGVdRk3sVWYAxCmo07mgHcRruuVyyf+p9PaC+jDpcTkcSjKHxtPrR3
 eVkuvDJCBW0Tns6rqhJ2JCb5PqVxdDlp11zSaMm3yEhMukVaT9c+WvpzWQUKEN8JcuxDTikHzfM
 JTTBTklWlSf+ZeN6K1u/RbkNqA9GG8Pjp57urv0schbBFlqE1DdaeZ8e0eyw4ZKcj50iYGXi
X-Authority-Analysis: v=2.4 cv=E8/Npbdl c=1 sm=1 tr=0 ts=687f4a14 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=Uz3yg00KUFJ2y2WijEJ4bw==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=COk6AnOGAAAA:8 a=TmzUbGvDyKMaPb01JRcA:9 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: I4IdnW_VLI3Cp7zfn5kJj4ctecQVtwPk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-22_01,2025-07-21_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 spamscore=0 bulkscore=0 lowpriorityscore=0
 priorityscore=1501 adultscore=0 suspectscore=0 clxscore=1015 phishscore=0
 mlxlogscore=999 mlxscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507220068

This patch series depends on:
- PCIe
https://lore.kernel.org/all/20250703095630.669044-1-ziyue.zhang@oss.qualcomm.com/

Changes in v5:
- Fix DT format.
- Link to v4: https://lore.kernel.org/r/20250707-615-v4-0-1a2f74d167d7@oss.qualcomm.com

Changes in v4:
- Fix node placement issue.
- Link to v3: https://lore.kernel.org/r/20250704-615-v3-0-6c384e0470f2@oss.qualcomm.com

Changes in v3:
- Formatting: adjust layout based on reviewer feedback.
- Fix DT checking warnings.
- Link to v2:
  https://lore.kernel.org/r/20250625-qcs615-v2-0-0f1899647b36@oss.qualcomm.com

Changes in V2:
- Correct the version metadata of the previous patch.
- Separate the modifications to the DTS and DTSI files into different
  commits.
- Formatting: adjust layout based on reviewer feedback.
- Updated the email address.
- Link to v1:
  https://lore.kernel.org/all/20241203060318.1750927-1-quic_yuzha@quicinc.com/

Signed-off-by: Yu Zhang (Yuriy) <yu.zhang@oss.qualcomm.com>
---
Yu Zhang(Yuriy) (2):
      arm64: dts: qcom: qcs615: add a PCIe port for WLAN
      arm64: dts: qcom: qcs615-ride: Enable WiFi/BT nodes

 arch/arm64/boot/dts/qcom/qcs615-ride.dts | 135 +++++++++++++++++++++++++++++++
 arch/arm64/boot/dts/qcom/qcs615.dtsi     |   9 +++
 2 files changed, 144 insertions(+)
---
base-commit: 8d6c58332c7a8ba025fcfa76888b6c37dbce9633
change-id: 20250704-615-21c25118e919
prerequisite-message-id: <20250703095630.669044-1-ziyue.zhang@oss.qualcomm.com>
prerequisite-patch-id: 37d5ab98a6918dba98ef8fd7e6c91ab98aace170
prerequisite-patch-id: 1693faa1e23bbb0a37d4fb9cbe13e5dd43148ce8
prerequisite-patch-id: efa688b2ddd5744df7aef40182787ee4ceb90c98

Best regards,
-- 
Yu Zhang(Yuriy) <yu.zhang@oss.qualcomm.com>


