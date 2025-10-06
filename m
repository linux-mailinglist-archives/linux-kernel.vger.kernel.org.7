Return-Path: <linux-kernel+bounces-843532-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 89661BBFAC5
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 00:21:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5CB233B0D9A
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Oct 2025 22:20:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 343201E491B;
	Mon,  6 Oct 2025 22:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="XNzmyh2X"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C08C214A94
	for <linux-kernel@vger.kernel.org>; Mon,  6 Oct 2025 22:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759789218; cv=none; b=NG74/k2OMdafoYOokvy6hoDWuGURRkX09Lz+mmEFcq75BawiklJacYO159+kSZECuK0Vrxq9i30EXXs1IdrpLDt4lOhb3vC93PzzDS1AMeRZIutJYSFER2d1yBqNyqb8Ykfj6dv3bIiVjhtyWRwj3nfRBSjLPkrC2HtShr8SMsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759789218; c=relaxed/simple;
	bh=hda2Xd4Mz5OnSn10548Jx0ge0zF0dKZ+ZJ+uSDZXASE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DR0g18a1nm4J3DGfFgXMvKH/ZbLGI+N4Vl71kQf2A83AwPFgOKJc2M/P1xYMZpn+j7k0QCxBxMS8qHBZfdxqYP2wsY881JMM9eEsHcHO49L/5lA+ECGDC+RhVrgKJm2n9rYyjRvWdEsrv5bZI5H2HAgYNbvNtOHO0cYPVXKgNcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=XNzmyh2X; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 596F1ok2027706
	for <linux-kernel@vger.kernel.org>; Mon, 6 Oct 2025 22:20:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=DQ/0YD5xMRw
	3lWfka6oyOcJAqHz+tEBt1EbVwdyanDU=; b=XNzmyh2XOAAmRvkmnEGA9YOas+D
	TYNRCEo37uwuxgKSoVQ2PNZOqqXuza1cPH6fDea7aQ950p9NlUSH3uxOZn7Jv6/6
	BBvbmdA9fg2GDlh2/ocumOWL+3rQeiIrF2/tze39ZEBVDcl3R4qpNyzEQ9CFlISz
	fYHw6K7ed8c+izO13JIZ2Sof6+DhzrjDK2kYrl/jbEWQ+Qor14qvLS59Msy5wDF+
	LzuKqmTepXBELIVbR6o622fHxqTZpn/weNV3B9HewUTcKRRB9EbMOfrDGtfXY5K5
	wSgPiZFGOJoO6scn51m6sk2AE2F0lF2b1ovtIMZhlPI8bZF/sfoV3PMTxvg==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49junu5bvq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 06 Oct 2025 22:20:15 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-77b73bddbdcso5143852b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 06 Oct 2025 15:20:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759789214; x=1760394014;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DQ/0YD5xMRw3lWfka6oyOcJAqHz+tEBt1EbVwdyanDU=;
        b=fiQTiYPvh5SLoZUFByvzqwjOQ5oR8BzYo3rnajlzvs/uNZbdu9ovEgXA2Vk13eh+l/
         FyCagklhEZN5uHLq46UpqhunJO04I0KcwQs/d7yUPIBX8NdQSzA9BiyXOw+cPvq8ySym
         Ss/PxBf73yO5QeFnM7ZWar4ig7qAoeQnDHCk9Eh7lqKuqfmPYp3TH/cI2/T8OYRPaHLk
         0HeQESqZY2ZUqYfOy5Nc8Ctgw0He6aWIBOglRVEw9NfHDpgjOV5zVeqdko0p82uLy+eB
         QQ+lKHG382KGRvE4RVR2vc+FEZZtGlmfCAPADLAowaMR0TvUDiosO55D2bvr4T3m2wmd
         MM/A==
X-Forwarded-Encrypted: i=1; AJvYcCUqkjN6CdiNszlb/RDl1RLOgJ3rN8Eg14owixod9fI/5dUXEj+9kYw4kZxm09+6E1pJnVGoYxs86SNlB5A=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSj3I6ps9IzrSYYJJCH0NAwDD+aFzwbDra3SZTfr5UMn5PPgLl
	vJJNDmsgZU397oJPBysQ+diXvFuDtRwjN2A956zIyz7qtJXJ7kcAbmw20DWJbc8OGPotMupkdtb
	8/hbmWRhB21MDlV+lRPkuPzzyO34fy3eFzoC0ZKinHbmphnqD5/LCnYkVdsiBBjJMVGQc7dFtlZ
	4=
X-Gm-Gg: ASbGncte6eKt0aLhVgkgtZk1XU1kgupqLZfrDdtw3uyn09gNLRYGk7KYJ2vCLBPFinv
	gLRtajLvp0Ywk25qBHMsp01SrSn5nH8z1r4Ab4EmP7KXlh5lrUVdTmjrlcyQTENT8UgKTegtDB2
	mysC24bfRFpmbV4gtsbKqXDRoIMw6c/MAb8FNczRhDEPpz0z/HxlqPp9BR1zAi9+4e7Fc8szZXU
	9uzEJR1kbjPqzcnq5/hb4nekyz4P0Pm32d1ga+S20MVEpGYIeW2tkPscL7p9vrgGH8edYNBzr2r
	mlb/3Sz+juno4oPG++ce43v3IYzeDd0Pzchj3Uyc+qcBEh5hZsnq3iLUUkin2pLq1JjfnpVve8u
	/4fXb6EVWubxYL3fFDr3NfA==
X-Received: by 2002:a05:6a00:399b:b0:78a:f6be:74f2 with SMTP id d2e1a72fcca58-79230757802mr1247800b3a.5.1759789213995;
        Mon, 06 Oct 2025 15:20:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFnkZXwidFHz7CWQzFnYlI1XTWEVkHlGYGjn1W8QN2IS0V8sHRnZ70wzY70yU9/PuxBu2FvJw==
X-Received: by 2002:a05:6a00:399b:b0:78a:f6be:74f2 with SMTP id d2e1a72fcca58-79230757802mr1247773b3a.5.1759789213473;
        Mon, 06 Oct 2025 15:20:13 -0700 (PDT)
Received: from hu-wcheng-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-78b01fb281bsm13734968b3a.37.2025.10.06.15.20.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Oct 2025 15:20:12 -0700 (PDT)
From: Wesley Cheng <wesley.cheng@oss.qualcomm.com>
To: krzk+dt@kernel.org, conor+dt@kernel.org, konrad.dybcio@oss.qualcomm.com,
        dmitry.baryshkov@oss.qualcomm.com, kishon@kernel.org, vkoul@kernel.org,
        gregkh@linuxfoundation.org, robh@kernel.org
Cc: linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Wesley Cheng <wesley.cheng@oss.qualcomm.com>
Subject: [PATCH v5 05/10] dt-bindings: phy: qcom,snps-eusb2-repeater: Add SMB2370 compatible
Date: Mon,  6 Oct 2025 15:19:57 -0700
Message-Id: <20251006222002.2182777-6-wesley.cheng@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251006222002.2182777-1-wesley.cheng@oss.qualcomm.com>
References: <20251006222002.2182777-1-wesley.cheng@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: Qo4QzP8fIvjeRLWh0jJ0krUE-_a2X6tL
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA0MDAyMyBTYWx0ZWRfX0UU/McNqb1/z
 SC7F8Hci3F0HNqyMY4kkGUJNQP0IK2IwQLdW8g/20VzFSxfUMjaQbOPUozTr1+dRvHF3c17bkUU
 OzuFa9P/3fQ51uzsk/TMX++91iB+PrA78fRSYjAcaURTbgo0aDY+QBvRnGfOTyX1TZ5SR5dHOPV
 s7Yr4Zz4mbCfDLfUelSVfGi1+UJu1/LYzCqDVA99S/8YrsjAAcvMA6fbgQSlRab6NYSH+eI9erm
 V5j/bf+zQTDs0MVK4BZky2ArE1vppDgutpPPxMl6WNQP1qw4GFLbACvgeLq3L8E7jT0BdMVr7z6
 LA2QubOB4RnouQ0cUUGciC/MvTQHJA0WjHk7jbhJZJtm0XDaQRCAXUzJpKx6STFidOkStPH1KJm
 PDbRswXfT6FwSzlceNo7a3p2Hf5R3Q==
X-Authority-Analysis: v=2.4 cv=CbIFJbrl c=1 sm=1 tr=0 ts=68e4409f cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=x6icFKpwvdMA:10 a=EUspDBNiAAAA:8 a=9ZGL9VZrYHwIVTkvpzsA:9
 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-GUID: Qo4QzP8fIvjeRLWh0jJ0krUE-_a2X6tL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-06_06,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 clxscore=1015 adultscore=0 suspectscore=0
 spamscore=0 priorityscore=1501 phishscore=0 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2510040023

Add the compatible string for identifying a SMB2370 USB repeater device.

Signed-off-by: Wesley Cheng <wesley.cheng@oss.qualcomm.com>
---
 .../devicetree/bindings/phy/qcom,snps-eusb2-repeater.yaml        | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/phy/qcom,snps-eusb2-repeater.yaml b/Documentation/devicetree/bindings/phy/qcom,snps-eusb2-repeater.yaml
index 5bf0d6c9c025..0f015a4c2342 100644
--- a/Documentation/devicetree/bindings/phy/qcom,snps-eusb2-repeater.yaml
+++ b/Documentation/devicetree/bindings/phy/qcom,snps-eusb2-repeater.yaml
@@ -24,6 +24,7 @@ properties:
           - qcom,pm8550b-eusb2-repeater
           - qcom,pmiv0104-eusb2-repeater
           - qcom,smb2360-eusb2-repeater
+          - qcom,smb2370-eusb2-repeater
 
   reg:
     maxItems: 1

