Return-Path: <linux-kernel+bounces-869664-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C6AA5C0877C
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Oct 2025 02:48:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 23E5D3B2DE1
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Oct 2025 00:48:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0D5C1E5205;
	Sat, 25 Oct 2025 00:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="oyY0L3AB"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4DE51E633C
	for <linux-kernel@vger.kernel.org>; Sat, 25 Oct 2025 00:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761353278; cv=none; b=lZCtlG6+AuuG10l+ETZMycG8/a9QGVUgyeYbdhsyWTbD3CWL4Lc4xJUf7XO6SRoFso7DEDNV/dKENcGs5BLlvdQj1OB7FnxyOMGwmV3VFizN6TiByOZMTbLIJyw/IExjovT05yq1br4YRzqyEOInFOAdGDd1qP4nlv192aHT9Ww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761353278; c=relaxed/simple;
	bh=1f+SaJrbfLX2xjXPT7sMapX9Y8rP0T2mxE48gQoh8kc=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=qnEfgq63tf/cB+6bnzF4nRBRuA6U6cYooE/y3XUx7uc61aWh/SURtxlm6ThDbwuVA9p/Ih2jZflFuUiyj4a2CqAudQRMyIgATKysK1ZqkW61G7no20nvub5fnIf63R8kcCzqO8tpyj6BTfOR913l0g9mcAFHe4+giZ6wG7G8IKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=oyY0L3AB; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59P0lJFZ027734
	for <linux-kernel@vger.kernel.org>; Sat, 25 Oct 2025 00:47:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=L6IpjpS1e585bisXA7MOt4
	/08rdI0wiNtT+dUHbEzGs=; b=oyY0L3AByn15neH3IQr5o/AF/dmDLMz98+hDc+
	50WZf/hKbMH5zljy3tXr+mjrZe+rZaUyJCSvnHeRxs0EvFp+/lUEZwO+xsTiaLyF
	FxY3DMuPehYISneS72ofWIStlU3KmLk+K/wlM1x7Ehx1LQHWLczEFpQ9OHpeIg3n
	SO8J++AVjkPtXQ0a1mHZkBvUJCwdK1O7UxYgIWYItBBHxI83v45UMBKkhazGvPWp
	+1RJriUFEkMWhlLhnmEMkJ4eex8on6JE5vcC3Ybd6bjoFJ8vAIX99MhykGSUyAe5
	iHJA3LWJ4i1DyUNEjD0H2JIL+sSKyYCU/xvNvk1krU5Ttyyg==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49v2gedjjd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Sat, 25 Oct 2025 00:47:54 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-b6ceba8968dso1842011a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 17:47:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761353273; x=1761958073;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=L6IpjpS1e585bisXA7MOt4/08rdI0wiNtT+dUHbEzGs=;
        b=JEVBtWHJFKAK2xRVLbsKcavtahqlv8asWy9XJqfVd1S3Y05fIMeD7dgZPKngb6KtFq
         OJPWcWj1hBwLhM4aXqqh9HjLBU9vpp7TJ7VHwnbGz/jtmYDXbiMcdxaIt7j4wJKFhUBl
         g/8Q1rs95H+q+ECqb6/y7rj36HkLd/6UvP0xiKkOXj9IYhqC547sIxXUTfgfWZNNNJq9
         HReUrmdiMIUHFST+O0goyw0LfkXKvUsflRmywglds9E+zYuvBYt/XPYv3WRl71R5W7JY
         F8DVZTKkV15whSeI73CqNTjfXp1uQrGnG5Q4L6iLsD4At7MIYRQSOLgXNidXMUuor8KK
         nUPw==
X-Forwarded-Encrypted: i=1; AJvYcCUmqJ4c17qxK5sIbvHVigZ6XtEWPCO8fXr0KrW6IkMe3I4bJvLIgzAXgWbG2Bgj3NZmSc4KdnMuLKch5Yw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzzZbSeLXuTspjUn86l0ZR+ACrNGoTcDRPjtF/VTRA6g/jy/F4t
	LY7DFokc3Nn+J6oQrGAVFX+j9g/NSP+B9Rpx6c5m3+h8jm109ytaEGdqePnMn7vwpR/qcAHRZFw
	+mgH6XTrGzJFlgxLN34MA8W3NfN9HJ7Ok7JyD7oOdMQjcE5+D8KbtSkYak3BKWqMw+dQ=
X-Gm-Gg: ASbGnctxdhf4aOnbH6Qe30ZtrKtXum+nQ6T3Tsnba7UNuEscY8Gj8MabHw58HiAjp7t
	ocqemHWw4hrRb64lZuTa8Rp+N9ZJe2z7eTGse5tTKrW38HoKEQ+I4VFKaClSYYG28kwqWWfR/y5
	PuCUTSbpqTm9S6tB5o5sL68xEsedhfwcLLsFOEdYIoolsLCqag/gy7VJ6/i4iWRCyS3DFGpTtmP
	knMqZzWDiV7hXXABr8sPjKKgUNclPsVDXfrjwzJJLuw4yTJ5m4DzhXe6qIYs8KBK2CmgoTo6+71
	KZKATJkbtG70Ga6OvLJXl4Ggb3hjg+6rzXdOifhkkktQbT7bUTJb79dR11Mtlek/bGgjQXGgVO/
	lZkw32qRfoZF+UQPcDm0BFuvX+/0xOqCx1h5nw5a2jy4tgtMAwwY=
X-Received: by 2002:a05:6a20:1585:b0:334:9649:4754 with SMTP id adf61e73a8af0-334a85462d8mr39971250637.13.1761353273323;
        Fri, 24 Oct 2025 17:47:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHaI6IX+J3gSXLi97PHwV59k1RCPN0Swx6E+HQYIPmwQxD+ZLzN0Beey+AMQrxU3ZXLo0dzww==
X-Received: by 2002:a05:6a20:1585:b0:334:9649:4754 with SMTP id adf61e73a8af0-334a85462d8mr39971228637.13.1761353272815;
        Fri, 24 Oct 2025 17:47:52 -0700 (PDT)
Received: from hu-wcheng-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33fed3eca8dsm167352a91.0.2025.10.24.17.47.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Oct 2025 17:47:52 -0700 (PDT)
From: Wesley Cheng <wesley.cheng@oss.qualcomm.com>
Subject: [PATCH v6 0/8] Introduce Glymur USB support
Date: Fri, 24 Oct 2025 17:47:38 -0700
Message-Id: <20251024-glymur_usb-v6-0-471fa39ff857@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACoe/GgC/43Qy07EMAwF0F8ZZU0i++bRlhX/gRAaStpG6gMSW
 qhG/XfSLtCw68bSteQj2zeRfAw+icfLTUS/hBSmMQf3cBF1dx1bL8N7zgIEywTItl+HOb7O6U0
 2AMhU7GyjRR74iL4JPwf2/JJzF9LXFNfDXnjvHgxVINJgKhUMnNGS5bdPvV9V3fmxfZpSUp/zt
 a+nYVC5iB1bcA9YIguUypC2FYpzgv4v5HlLyrDWxCd3MH8CE3G+3mqjNDtniM8J9l5w+wMJCly
 iKE5csW3bLzE8uHWyAQAA
X-Change-ID: 20251022-glymur_usb-f222049165f3
To: Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Wesley Cheng <quic_wcheng@quicinc.com>,
        Abel Vesa <abel.vesa@linaro.org>
Cc: linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Wesley Cheng <wesley.cheng@oss.qualcomm.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Elson Roy Serrao <quic_eserrao@quicinc.com>
X-Mailer: b4 0.14.3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAyMCBTYWx0ZWRfX/rxrO25N8N0M
 g6/1PCr3bbTk0Zbj0ja+HfzoUOdFlfYwtGCiUMwm/sDMNv6zP42k5+y6sppV1PQudiWRuZ5HiEM
 8eMamFV+WlrbSuW1DhQjRhrg1YNji7nkDlqcKzJN8gItWSch7cfk4G9Ow1GZbvBrnY6rmeRhe4v
 EL0aEIL63GHyFxNCxquTldAbMI78ibp280hhk58lOcdaBFjGm37+xxwce9Nwgfx2m+SwB2Qf4jJ
 L+WStZsSpkrh0P2eNPcuomRf6Snu53L33Qfr1OxnPMUzDcx+JrE5OcU4funliMmXyFu7oxM5jj6
 CUeqV+63+G4x1ijwgxZO0HDPaN7uQDvV4XtdZxrDmMoizTzC1J5f+iPSq52sz1Y2I6pegEFW7SN
 SO6e//zfH8hFvtOTCPpErQi0jShX/A==
X-Authority-Analysis: v=2.4 cv=KqFAGGWN c=1 sm=1 tr=0 ts=68fc1e3a cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=fXH650Jz_15WDPxxfBwA:9 a=QEXdDO2ut3YA:10
 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-GUID: lQ3fk1Fla75Bx84-RgEuD2-j29Qh5Y9Y
X-Proofpoint-ORIG-GUID: lQ3fk1Fla75Bx84-RgEuD2-j29Qh5Y9Y
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-24_05,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 phishscore=0 malwarescore=0 impostorscore=0
 lowpriorityscore=0 adultscore=0 priorityscore=1501 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510180020

This series enables the PHY level changes that are required to support
the type C based controllers and the multiport controller.  The typeC
ports utilize a usb43dp based QMP PHY for the SSUSB path, while using
the M31 eUSB2 PHY for the HSUSB path.  For the multiport controller,
it will utilize two QMP UNI PHYs for the SSUSB path, and two M31 eUSB2
PHYs for the HSUSB path.

Signed-off-by: Wesley Cheng <wesley.cheng@oss.qualcomm.com>
---
Changes in v6:
- Reworked the reference clock requirements for the QMP and M31 eUSB2
  PHYs.  In the QMP case (both UNI and combo), removed the need for
  the clkref entry, as TCSRCC clkref switches will handle votes on the
  CXO clock.  For entries w/o a TCSRCC clkref switch, populate the ref
  entry to the CXO handle, while others (with TCSRCC entries) will
  the TCSRCC clkref associated to the USB core.
- With the reference clock rework, dropped:
    phy: qualcomm: m31-eusb2: Make clkref an optional resource
- Removed the need for a clkref entry in the QMP combo clocks list.
  Removed previous reviewed-by tag due to this change.
- Split non PHY subsystem based patches into a separate submission.
- Remove DP related init tables from QMP combo
- Link to v5: https://lore.kernel.org/r/20251006222002.2182777-1-wesley.cheng@oss.qualcomm.com

Changes in v5:
- Moved phy-qcom-qmp-usb43-pcs-v8.h into USB specific QMP driver
- Fixed DT bindings for clock properties for QMP combo PHY
- Link to v4: https://lore.kernel.org/r/20251001220534.3166401-1-wesley.cheng@oss.qualcomm.com

Changes in v4:
- Updated DT bindings change for QMP combo PHY to have IF/THEN blocks
to handle the newly added clkref, and fixed the commit message as well
- Added a new header with v8 offsets for the PCS MISC register set,
and refgen current load for the QMP combo PHY driver
- RE-added the headers for the QMP combo PHY
- Link to v3: https://lore.kernel.org/r/20250925022850.4133013-1-wesley.cheng@oss.qualcomm.com

Changes in v3:
- Fixed some incorrect patch ordering.
- Alphabetized Glymur QMP settings for combo and UNI setting arrays
- Link to v2: https://lore.kernel.org/r/20250925005228.4035927-1-wesley.cheng@oss.qualcomm.com

Changes in v2:
- Updated QMP combo PHY to properly handle the refgen-supply and to
remove the primary core reference/tag
- Updated QMP UNI PHY to properly handle the refgen-supply and added
a separate IF/THEN block to handle the new clkref
- Updated M31 eUSB2 to make clocks and clocks-name required for sm8750
and optional for Glymur
- Fixed missing PCS MISC table
- Added SMB2370 repeater changes
- Link to v1: https://lore.kernel.org/r/20250920032108.242643-1-wesley.cheng@oss.qualcomm.com

---
Wesley Cheng (8):
      dt-bindings: phy: qcom,sc8280xp-qmp-usb43dp-phy: Add Glymur compatible
      dt-bindings: phy: qcom,qmp-usb: Add Glymur USB UNI PHY compatible
      dt-bindings: phy: qcom-m31-eusb2: Add Glymur compatible
      dt-bindings: phy: qcom,snps-eusb2-repeater: Add SMB2370 compatible
      phy: qualcomm: Update the QMP clamp register for V6
      phy: qualcomm: qmp-combo: Update QMP PHY with Glymur settings
      phy: qualcomm: qmp-usb: Add support for Glymur USB UNI PHY
      phy: qualcomm: eusb2-repeater: Add SMB2370 eUSB2 repeater support

 .../bindings/phy/qcom,m31-eusb2-phy.yaml           |   9 +-
 .../phy/qcom,sc8280xp-qmp-usb3-uni-phy.yaml        |  19 +
 .../phy/qcom,sc8280xp-qmp-usb43dp-phy.yaml         |  16 +
 .../bindings/phy/qcom,snps-eusb2-repeater.yaml     |   1 +
 drivers/phy/qualcomm/phy-qcom-eusb2-repeater.c     |  18 +
 drivers/phy/qualcomm/phy-qcom-qmp-combo.c          | 326 ++++++++++-
 drivers/phy/qualcomm/phy-qcom-qmp-pcs-aon-v6.h     |  12 +
 drivers/phy/qualcomm/phy-qcom-qmp-pcs-aon-v8.h     |  17 +
 drivers/phy/qualcomm/phy-qcom-qmp-pcs-misc-v5.h    |  12 +
 drivers/phy/qualcomm/phy-qcom-qmp-pcs-misc-v8.h    |  12 +
 .../phy/qualcomm/phy-qcom-qmp-qserdes-lalb-v8.h    | 639 +++++++++++++++++++++
 drivers/phy/qualcomm/phy-qcom-qmp-usb.c            | 163 ++++++
 drivers/phy/qualcomm/phy-qcom-qmp-usb43-pcs-v8.h   |  33 ++
 .../qualcomm/phy-qcom-qmp-usb43-qserdes-com-v8.h   | 224 ++++++++
 drivers/phy/qualcomm/phy-qcom-qmp.h                |   2 +
 15 files changed, 1495 insertions(+), 8 deletions(-)
---
base-commit: 15ba5ae3b0ede7e355c88ac074e946fc1aa21026
change-id: 20251022-glymur_usb-f222049165f3

Best regards,
-- 
Wesley Cheng <wesley.cheng@oss.qualcomm.com>


