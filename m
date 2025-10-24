Return-Path: <linux-kernel+bounces-869079-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 625F2C06E72
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 17:15:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 7AB3235C8E9
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 15:15:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C498B325494;
	Fri, 24 Oct 2025 15:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Ou8d3YTq"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82A57139D
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 15:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761318934; cv=none; b=bEM8SI7ymxS5FvYRQMszKudL4tWErmuy6ZlXJ7KoQdJOwJceV1odtAHUOmrTSw9/kJWWcPWFZ/oPwMZrqOs3ibURbU+BWmbm7kZHON1vvJCg5J7hrhYGsYkhbYA629dJEKplMxBUBo4vnlni6WjZLu1WFK+1ZVcB3zAyEn1HOTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761318934; c=relaxed/simple;
	bh=9V73lTpYpUQPN2unOa8O9eu57Du0iwem3Ucszfhlq/g=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=k6fnBffzeSfFK/+f3Oon+YSO5ksidTu3+8YCms4no6UWK2Ytx7ttIH87BshWNOZj7UzrUalNChTV/EpFVV85okbabiqigpmKIyTrMb1by+6PQ2/XV51RZEhqz+/cBSEP8AIkJCqWcTRSSc7GEsaL8yFe1gR6XFVEOOx6zBAz0Gw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Ou8d3YTq; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59OBsZ8t014872
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 15:15:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=cfIr32sZYc3p6VekkBfE2nyU/dTJ9NuqA2F
	9CFThGoc=; b=Ou8d3YTqEPYt0SW9GKbB9JJX0ptxZXnY5c0X4M3u58OBkNERP4O
	MV5OssTOMOuILSFt7aXnTI1fGvJ2Bd6eYB4mPor22Bud6dHh3nUuXnO3pgHYCcg3
	vbDAQ2o6ekY90mR+Ty8MR/T6s4dYNnBbfE8rNVt7+WOCXmo9cscX/qex7v3ZVpNh
	MhUzGwpCGF8oOJGp2bnZs3mIaFY5b+a+I8FruEI23cFjwQRSLiXLhSMPSG/IOo2z
	s3SoTbUjVJZ2yG7N08sQ+4zxlm6UFFgrGQC6ZYv5qhPUTQLE0nG/D4P8g0bY5gRX
	plBXUZbb/dM1gSYrfoNCbUiF7wA7+OjYhAw==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49v08pvnfs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 15:15:31 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-290b13e3ac0so18994955ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 08:15:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761318930; x=1761923730;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cfIr32sZYc3p6VekkBfE2nyU/dTJ9NuqA2F9CFThGoc=;
        b=BVXSPapTwl5rRJXaIWgzwXn+EjdaHjvumPlk6BU/7xg/lgJmqmvYTkgiACCw7eYewu
         SgfdJzfh0eRru2/OTv+nSv1ODAl9vkvKcGPs4p6ixu8DupdmXaOvWWaXoDBsHkWsymz1
         cd4Ox6DLnp3lRHeQHt4yVXgRRUBAmsbB1ZS6Ah1e1GzDJqYa6spYxGswVQo3VC8omCfY
         RZtDQdV30GRncaQOptR3KGCVcvLgXtdttivSoKJFk7HiNcU6gwPhRAjuMHd7JduN0Pjk
         GhZbdZLqhbPBrTZXNdM128UngyKsTmJ189Zl1KxQg2tt8MvCTcUx7okKnblAxbQgSq5h
         Y6tg==
X-Forwarded-Encrypted: i=1; AJvYcCUBg12GQZHqtVy3cARsgp9hZJROUMSg8vd+I0BZIj3VZyzTRbE47SPNyntrkoWLWeqz60nEsgbJcFD+ZPs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/qkMsbhSvN+LSRc3sY0J7+utE7PvZp9XnQXZRsAHlLVzbkEe+
	uFmA+3xvqw6OcGg8yXvZTPbrLIwLWYyv/JPV2tpNxhg3E1BDQ/mAWR9hkfNSNISsWpZSey8QRUE
	pDio3Zf7/LHf99ex91nstirtxhjDngf3QAuuR93+mJAIGX549g0tI0g8C9Kcl2x7FAnk=
X-Gm-Gg: ASbGncsIbl75QIIDLuO7NxG+acYoGQxDdLGDHfDYDOIiQBsbTBgtAx0/4DnroZyENqi
	8MvdBl9Y3ujCGDSLgSdaFsIH0/ni5XJvcHwc4xqCmhvjjfDQuyZ/eR2r5htlG7bTyMWeOuKZEdv
	zvjm7e0lLKlZnOU83f2XtxVkx3zPkuDYTdY8Gw+0D09b24mqNNzDpgbYVkOFXNfn1JLATXqZPAF
	mYZhR7AvexKewInUO9OBDN1axBTj0pqcDjWrSq51fyXjbYXpPH7r5EE+dAvPoS4biohzXyNq4ip
	KGkHyfIUwbHJi44PTKixNgyFBvsqZPF4G7mumusZ963UUvrEfb6EFRH3qn1E4ygZvRceeDjMphh
	TeqXGDglcFOby82DB9WJs4zfn/u4Em+TFn83l
X-Received: by 2002:a17:902:dad1:b0:26c:87f9:9ea7 with SMTP id d9443c01a7336-2948ba78fd1mr41240485ad.59.1761318929570;
        Fri, 24 Oct 2025 08:15:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFsVckxizfm6vv65RfSCPhbMxJwxNdrq783lMxRYm8N33ihDrYegMyk6O+OvMxTju33/OqI6g==
X-Received: by 2002:a17:902:dad1:b0:26c:87f9:9ea7 with SMTP id d9443c01a7336-2948ba78fd1mr41239915ad.59.1761318929019;
        Fri, 24 Oct 2025 08:15:29 -0700 (PDT)
Received: from hu-kriskura-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2946ddddc34sm58758885ad.20.2025.10.24.08.15.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Oct 2025 08:15:28 -0700 (PDT)
From: Krishna Kurapati <krishna.kurapati@oss.qualcomm.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Krishna Kurapati <krishna.kurapati@oss.qualcomm.com>
Subject: [PATCH v9 0/3] Introduce USB DT support for SM8750
Date: Fri, 24 Oct 2025 20:45:18 +0530
Message-Id: <20251024151521.2365845-1-krishna.kurapati@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAwMCBTYWx0ZWRfX1k9dLxRJAxJa
 45XIJsXTyhRZSwdWqgT+tOseRJGrGvLeHerFkP1Ofbh6Iqwa5H6n1SPZ2uUpxyfGqWULlBx+SNu
 pfmaU8V9KszvpDmrE9ySwjDTq0FueUTXA3vy7rwikvoduLXEVTNFnFiICxzyCU2PjK7ukSBLOON
 9/rQwg6x+OImkvwEM0jFpGKqfox2qrufDo8EteSOCgRUlQWuUIIKgwUdvaq+lFIizDAVpFBI/nU
 LmfHbkxdf4CzuL+leVgMJWPg2BZ/ZrewI3OPwWeBHL4La6Ps/ehKzD74JpIE9Z9MwRVg7f/mtUI
 pOjkqo7iMXDDlIrjtgpOkkDBkpQsutdrH6U3LjjJR8R7Q+FKXRJPfQEHFitEhlpMuREU5Z5tEkP
 r8cqPPPg1tiYIuXCybDIxU0JHMLBpA==
X-Proofpoint-GUID: JwUUlMpF3T6dXdJWe1-mWgQWPALvPUbg
X-Authority-Analysis: v=2.4 cv=Up1u9uwB c=1 sm=1 tr=0 ts=68fb9813 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=COk6AnOGAAAA:8 a=UZ4tNvspqRR6S34ExfcA:9 a=GvdueXVYPmCkWapjIL-Q:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: JwUUlMpF3T6dXdJWe1-mWgQWPALvPUbg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-24_02,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 suspectscore=0 malwarescore=0 clxscore=1015
 impostorscore=0 bulkscore=0 priorityscore=1501 spamscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510180000

Add support for the PHYs and controllers used for USB on SM8750 SoCs.

Version-6 of this series has all the binding/driver/dt patches acked.
But only the phy changes have been merged.

Version 7 was a rebase to get acked patches merged. But comments came
in to use flattened bindings.

The v8 for usb bindings patch has been split and sent out separately [1]
and it is ACKed.

Cover letter heading has been modified to remove phy context.

Defconfig patch has been resent by Jingyi on [2].

[1]: https://lore.kernel.org/all/20251021050954.3462613-1-krishna.kurapati@oss.qualcomm.com/
[2]: https://lore.kernel.org/all/20251021-knp-usb-v2-4-a2809fffcfab@oss.qualcomm.com/

---
Changes in v9:
- Updated commit tags (Removed Suggested-by of Konrad andadded his SoB)
- Confirmed with Konrad offline before adding his Signed-off-by
- Updated commit text in patch 1/3 as per suggestion from Bjorn.

Changes in v8:
- Using Flattened DT representation.
- Removed obtained RB tags since the code has changed significantly.
- Modified Author mail address from quicinc to oss.qualcomm.com
- Link to v7: https://lore.kernel.org/all/20251015105231.2819727-1-krishna.kurapati@oss.qualcomm.com/

Changes in v7:
- Rebased on top of linux next
- Split usb patch and sent out separately.
- Link to v6: https://lore.kernel.org/all/20250527-sm8750_usb_master-v6-0-d58de3b41d34@oss.qualcomm.com/

Changes in v6:
- Change readl_relaxed/writel_relaxed calls to just readl/writel in the readback function
- Updated languange in the defconfig commit to specify SM8750 as a Qualcomm SoC
- Link to v5: https://lore.kernel.org/r/20250421-sm8750_usb_master-v5-0-25c79ed01d02@oss.qualcomm.com

Changes in v5:
- Removed refclk_src from the QMP PHY driver as that is no longer used.
- The decision to move the TCSR clkref property from controller --> phy
node was made in v4, and the refclk_src was a lingering change that was
meant to be removed.  CXO is the parent clock for TCSR clkref, so CXO
clk will be voted for as well.
- Relocate the SM8750 compatible within the qcom,dwc3 bindings.  This is
to take into account the change in clock list.
- Link to v4: https://lore.kernel.org/r/20250409-sm8750_usb_master-v4-0-6ec621c98be6@oss.qualcomm.com

Changes in v4:
- Made some fixups to the M31 eUSB2 driver
- Moved TCSR refclk_en to the QMP PHY DT node
- Link to v3: https://lore.kernel.org/r/20250324-sm8750_usb_master-v3-0-13e096dc88fd@quicinc.com

Changes in v3:
- Split platform DTs into separate commits.
- Fixed up M31 eUSB2 PHY driver with feedback received.
- Reordered DT properties based on feedback.
- Rewrote commit message for enabling EUSB driver.
- Link to v2: https://lore.kernel.org/r/20250304-sm8750_usb_master-v2-0-a698a2e68e06@quicinc.com

Changes in v2:
- Added new QMP PHY register definitions for v8 based QMP phys.
- Made changes to clean up some code in the M31 eUSB2 PHY driver based
on feedback received.
- Added bulk regulator operations in M31 eUSB2 PHY, to ensure that
both the vdd and vdda12 regulators are properly voted for.
- Removed external references to other dt bindings in M31 example for
the DT bindings change.
- Split DT patches between SoC and plaform changes, as well as the
PHY subsystem Kconfig changes when introducing the M31 eUSB2 PHY.
- Added orientation switch and port definitions in the DT changes.EDITME: describe what is new in this series revision.
- Link to v1: https://lore.kernel.org/r/20250113-sm8750_usb_master-v1-0-09afe1dc2524@quicinc.com

Wesley Cheng (3):
  arm64: dts: qcom: sm8750: Add USB support to SM8750 SoCs
  arm64: dts: qcom: sm8750: Add USB support for SM8750 MTP platform
  arm64: dts: qcom: sm8750: Add USB support for SM8750 QRD platform

 arch/arm64/boot/dts/qcom/sm8750-mtp.dts |  22 ++++
 arch/arm64/boot/dts/qcom/sm8750-qrd.dts |  22 ++++
 arch/arm64/boot/dts/qcom/sm8750.dtsi    | 158 ++++++++++++++++++++++++
 3 files changed, 202 insertions(+)

-- 
2.34.1


