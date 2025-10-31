Return-Path: <linux-kernel+bounces-880170-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E7ECC25098
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 13:36:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7C16F4F56EE
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 12:34:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E79A34404F;
	Fri, 31 Oct 2025 12:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="lDhdJq+9";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="NT3M2xMp"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF057320CCA
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 12:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761914046; cv=none; b=i7ndZNsAzK63kiy4E20868wznXUy7wOATSGFQ6InNbQTFRbe+1c3lOybhWtoRmF1W+6wuLkrtjcSYZvmqLizdN4wo3Ookr+LxoyzYZs599FViaJMeKTZ3CS1UAFkmOL9dcN2R3S3xjXhElcSwizNq5EIpdm1SOSP7c37TAnFd2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761914046; c=relaxed/simple;
	bh=sqJNqwGnrrb/W2OtAanS252ug+Zw15TbKV12EdEx/nk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=JAlejbT4qzU6Vt1uBVBmpN1EWkIdbgU2oWVb3DTn8LegLrPQHF7g7vKfeqtm51wzq6Fsr+NVVesjPypT58d+vhqOLOk0P1pua+Y1DTgQUN0WnvVlkpf2hISQpMSipbtqpnP+A8nldU23Y5il2wRJM17SXbDwd4hgh9v6hxvEsa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=lDhdJq+9; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=NT3M2xMp; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59VA3tnL2558929
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 12:34:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=7YQCRRoiEM+61ba/NfudLdurcxlXk1dhmyr
	M49MhVh4=; b=lDhdJq+90zXlXucjR1tOMZYWa9zX19EQUMY1O8rxBZCrdt0IShm
	ditOfJTaeyJ80vjm7tLtQ+FIAFYaLOf7AF8aIPyV8Om9yma1GTOC89dQv4fasPl4
	OP7ShwWfy/tjZtNc01EDsdzjOavX610ZZKX4HsEsM1qGKmERWLtbz6DECY2a4Q/e
	8Pw+hFAkmbC2j2tOE+QUfjQ6sPn9RYjSfcnTVL8N4xzF4EDEwWDtich0Hj28kwdo
	PsqHfz4duzWeO3kKtOEfU9kjVMB6CAo0IQoSswlhoJARlPp3Ud84D7hPzUboyZli
	+YNNvXkA6OwB+txXeoWUTjXuF14YRdnWE4Q==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a4u1grc15-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 12:34:03 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-77f610f7325so1883045b3a.1
        for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 05:34:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1761914043; x=1762518843; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7YQCRRoiEM+61ba/NfudLdurcxlXk1dhmyrM49MhVh4=;
        b=NT3M2xMpJuE3avco5oHwI4+VNZnYNIqoIwrojxq38ZEYr6XG7ezJlkma//mlPJAvHc
         bX3GAdHxh8JzxCo/q42yefC94iAnwwKrVnX7KN8cppMAELHUeoLcJfLJWCklzkuybSaO
         Ss0unFj2EvAavwIxa2iqvp8SxiJuN3IhTKxeiYzp/NccbbEEA3GTUKlX1gdQ6NmFd2k+
         N7VNP5yMuwEPs2NbYysr/2T/ZkMqIUjKkvBM5Y5WHEEBAF4BQnJcoNUGQiCDW9JgIFJa
         6BDXUSAq/bFv3Dh8y6u9rixv7h8oBw9PNbOMaYZ0fzEnmetzEjialo+Tt21UAHqUPizf
         0NYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761914043; x=1762518843;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7YQCRRoiEM+61ba/NfudLdurcxlXk1dhmyrM49MhVh4=;
        b=jOJxWIyjDDD5RzJcEPWUQ7oPugfhDW+YZzpzk7n9ZhavhuoQnMlU5R8WPUFDlrDx91
         bjcylIXn8rx/sGdy1sJITcFXRWdZMLX+5osDBAaKInkRriMPeda1kHw4N2QPzamBofzq
         e/TDcSywEqeBTjuCekgu+UKQbJftWsfYapahrCFjcAxUehm/xC7vFVF9WrBxWS4C4QIP
         G2auUb1edPxKzH1P4Uc2IJKPG9fNMBizxjuCzO7ga08HQkLlhwH++2zDDvGqrODi9ueG
         L4BWsShUxYoxBwRmI/6KiscQN7zN7BS9u1vJMZZA73FAfVzjch5wTHCGs3sl6W+n1byq
         tBGA==
X-Forwarded-Encrypted: i=1; AJvYcCUSXyG1FDgEswtqgJklvDbsM6JPxv1DU/vzJPxCZ9S2cHy3qLRHAyx1m5K6LkCqZSNIROf2luukRBDmZ4o=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXDA5TPiAfiPwPwSr6B8xl5jm+39M0ESpvn9NINrQ3cp4hiOzj
	KjN2EVPEXEf339QLH9OH/CzKD4qr5JLKQfNTl4MhSU61PW2lalYozWwhl9xZEWuso6MVKTOWCwN
	FSy1jfocRmVBtHeBOvrEHNEXvJ5SSDzgyu9N39lcmYkUtUs4FnEjxr+LUuRLlY9SQK7I=
X-Gm-Gg: ASbGncv/5LVauHRmZSjC2XgY87yV1vui0i6bbwOITJ0JeTpEJHaHHpPn1YziFhgEOj6
	/09DO1w5i5KgV68XqIHbLYegn5vMNQI2OqJ1d+jMbRiNw2x+ei4dbyxL6bllnQvaNEjG5wB3Nvr
	zif8b3376NBXhGaGa2NxXucdku2dzM+QHNcxZAuTNe2BeqCedleadcxkt5yJUezW7sAUjqAstX1
	zZbn0jFUs0g56N0R/+GIV1NiaZBQZon/xaOmIssvjjpx8tb1DZJae0R4rs/cCQi7RklEWoLmv+k
	fz8TiwhrpzfhOigpRQD+szDrw60RanTtIsRCA0yvK9biKwGFkEaQMGtWRLfIoKJE0TGCHolnSXo
	frBNwhnCPWIqtUlFzYg6J49Nm1dps75lToWGz
X-Received: by 2002:a05:6a00:39a7:b0:7a2:7cc3:c4ed with SMTP id d2e1a72fcca58-7a77737e83amr4042127b3a.4.1761914042479;
        Fri, 31 Oct 2025 05:34:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHReIeOkpBnk0vAQ+/4MbA0+mM/Fvz1bOi9vC6V7Ci8ebXCWBjQBmBWS+FcPQgCmB068L7yjw==
X-Received: by 2002:a05:6a00:39a7:b0:7a2:7cc3:c4ed with SMTP id d2e1a72fcca58-7a77737e83amr4042084b3a.4.1761914041930;
        Fri, 31 Oct 2025 05:34:01 -0700 (PDT)
Received: from hu-kriskura-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a7d8982109sm2131277b3a.1.2025.10.31.05.33.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Oct 2025 05:34:01 -0700 (PDT)
From: Krishna Kurapati <krishna.kurapati@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Krishna Kurapati <krishna.kurapati@oss.qualcomm.com>
Subject: [PATCH v10 0/3] Introduce USB DT support for SM8750
Date: Fri, 31 Oct 2025 18:03:51 +0530
Message-Id: <20251031123354.542074-1-krishna.kurapati@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=Lo+fC3dc c=1 sm=1 tr=0 ts=6904acbb cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=x6icFKpwvdMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=COk6AnOGAAAA:8 a=hjxnLiisKRasYILsxJMA:9
 a=zc0IvFSfCIW2DFIPzwfm:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: BVKQpSR1eqRdX_9_cA9ngu4fKgLjWN-f
X-Proofpoint-GUID: BVKQpSR1eqRdX_9_cA9ngu4fKgLjWN-f
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDMxMDExMyBTYWx0ZWRfXybUd38MyCwo4
 KhdtFizdSxMoPBckVifovT2NzuA6iujmOhlwdg6duWH4ges6QmhM11rPslwmp3vuFdEHxS2YCc9
 9I+JCgxK5QsNKthPGj1XgdY9yP96DzNtZpRmzGbWWT9KLeUjrT1dPzV8tts8kBO+s5Tz71EitmP
 V3spcm0LaafuyPvlaLif+qZ2T5ZeWlKsdGNuqOncoZmbWxa8d3H6moUHGdXD3mOFuOllFSMl4eu
 4ZKT4xVMq3J9spmkNN3Fr8sPmm8TQjSJGv0xyeaJxRIyV/muRyln9eSBUS4e0KuEgRE93/XB6f4
 5olo5GQS8O0OZB5Q7dzUI91AdlHXxVd/3Yj0MWyMquU5oNPD6d9OnL/LnS5X/BdzZPU2TdocEeb
 A6SkzsSDv8AaYIO57RZtzul2FrNXBw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-10-31_03,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 impostorscore=0 lowpriorityscore=0 clxscore=1015
 spamscore=0 priorityscore=1501 malwarescore=0 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2510310113

Add support for the PHYs and controllers used for USB on SM8750 SoCs.

Version-6 of this series has all the binding/driver/dt patches acked.
But only the phy changes have been merged.

Version 7 was a rebase to get acked patches merged. But comments came
in to use flattened bindings.

The v8 for usb bindings patch has been split and sent out separately [1]
and it is ACKed.

On v10, the pmic glink changes and usb role switch support are added while
addressing some comments obtained.

Defconfig patch has been resent by Jingyi on [2].

---
Changes in v10:
- Squashed pmic-glink changes from [3] in this series.
- Added remote endpoints between connector and usb nodes.
- Added Jishnu's CDB & SOB tag to credit for pmic glink changes.
- Renamed "usb_1"  to "usb" as per comments from Bjorn.
- Added QMP Phy pipe clock in GCC properties as per comments from Dmitry.
- Link to v9: https://lore.kernel.org/all/20251024151521.2365845-1-krishna.kurapati@oss.qualcomm.com/

Changes in v9:
- Updated commit tags (Removed Suggested-by of Konrad andadded his SoB)
- Confirmed with Konrad offline before adding his Signed-off-by
- Updated commit text in patch 1/3 as per suggestion from Bjorn.
- Link to v8: https://lore.kernel.org/all/20251022084052.218043-1-krishna.kurapati@oss.qualcomm.com/

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

[1]: https://lore.kernel.org/all/20251021050954.3462613-1-krishna.kurapati@oss.qualcomm.com/
[2]: https://lore.kernel.org/all/20251021-knp-usb-v2-4-a2809fffcfab@oss.qualcomm.com/
[3]: https://lore.kernel.org/all/20250113-sm8750_gpmic_master-v1-2-ef45cf206979@quicinc.com/

Wesley Cheng (3):
  arm64: dts: qcom: sm8750: Add USB support to SM8750 SoCs
  arm64: dts: qcom: sm8750: Add USB support for SM8750 MTP platform
  arm64: dts: qcom: sm8750: Add USB support for SM8750 MTP platform

 arch/arm64/boot/dts/qcom/sm8750-mtp.dts |  73 +++++++++++
 arch/arm64/boot/dts/qcom/sm8750-qrd.dts |  73 +++++++++++
 arch/arm64/boot/dts/qcom/sm8750.dtsi    | 161 +++++++++++++++++++++++-
 3 files changed, 306 insertions(+), 1 deletion(-)

-- 
2.34.1


