Return-Path: <linux-kernel+bounces-774956-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A546B2B99F
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 08:39:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4CEB1162B2C
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 06:36:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC9132673AF;
	Tue, 19 Aug 2025 06:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="EyEyXonY"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 809A823E356
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 06:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755585400; cv=none; b=J3lT29tYFASjHDDOwG0KbnlGEO45Z1TwJxarqaD3HAnjEw7YUHJw18DhBrMmBjljq0C1+IcucY9bSlc2mgMEtg59ZTg3w8TZdf8ckHkyEP2y7Fhtb+QKVOA1frkXzzQIK0oX+djuqqsLi6DykSNESyeMOsfJVYTnEQocHstLu8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755585400; c=relaxed/simple;
	bh=8rX82cXmDkiy7mxoulbCd1tP0xA4NYjLb7c/ZyHx9wE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=V07bjgUE/NW/ODPEP+alnZXEFngVYG0EGegBTNf5eX4e4p2DPTSZjQrUF+P7e69WL+3f+XYiL5OVGCurTjY11ZHWw9ETlLQgh8uIIt5R4QqOth48M6MvYOZt4GuSKZfoMNqSb41Y7XUehi/jdcWP4cRm62PQD8PRQztqCelsJso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=EyEyXonY; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57J1GLve011948
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 06:36:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=BNDtdStOIIki9xxSs9/BB+
	Gr6oUDaLjPxhFCW+eeQCc=; b=EyEyXonYYSs6oBIqd3Ln5w1LpBUuXayPhDojXS
	NG3ErmNfjJRADyOdJxZpec0t5sgSYnVXjcmQgssv+XIKCSo6Ktz4xCY4FYYpWLpu
	dfHqSkicd/mXXWD+b+RotNQ3fkTpa0caLH/YBCZg4RPJ9VFIJJJi3EzNjn1l4wWr
	e+s4Z4jn3jHVDXotpBwc9YkwHda1nXxTyBzzWdsYK6g64gt54bhYSR9kA9ALF3EO
	wkwoGgh+/aV32Zxy6rY3iP2jFQHqOQMaqULtUc1AnYiFQtK8rDg3ZTFYkwu59T6A
	ADSgjhXywDifKfwj50jTFX9sg3FlAJQye+dlNtvgJ39sA2LQ==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48jk99qdfm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 06:36:37 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-24457f44a29so60393315ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 23:36:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755585396; x=1756190196;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BNDtdStOIIki9xxSs9/BB+Gr6oUDaLjPxhFCW+eeQCc=;
        b=DPwhbUkbLJHliJdlOUO/wzLWLHHEG45YUtFV0NiCLr45DqA+jIOxrk3SUe3TMS3Y+E
         oHWsi3hovIItO9KiU6KjYmXijriI3D30Xsn7LAHdYruQro7e5Cx0ufyhoyEbpix7I+aF
         cORBnwzsmCICOr86H+rojSWdE4Gwf1ysdqT0+NwBxd6q4j4tqVmv97synqr5WXyk7ioz
         QXoZntG+PHN8qGEtqL49gYk4fLp9csVn4QfYzrQrr172mSB48HYIEJur+FAvk/EYf8dC
         gPyVFmIizPbwCuuNrpwSLrcZN53Z1wslmps7YZU71+7xpUiQjWDorhD7Oa307BlgciZU
         MI2A==
X-Forwarded-Encrypted: i=1; AJvYcCXNGLeYoLpwrw1ZulwXkWrqYoirk7z29x60ltGcQxtd9cWWIE2k9cA19KrlhEIrlg0FtCbnGHEtOu3FPAM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCQ0X8ifk1m/a2ZlpOM8Nc+6LS2oDxtNnA4JMrkwiQ4ktj8hYZ
	iYUCqyLF5KrtL6+xmUxmePsdeaIPNILal3ofm/ziEHreOJvKmXk5Ck0QrtFgHT3shl3ISTEt5fe
	TtlV/slMb7iHEHT+0uZEvlKZwmfU+5zNIGdq46Hi04qXmKVlBddfGrOwTmHLB5e3v4os=
X-Gm-Gg: ASbGncvZsv+z4yu+HPVA+vVgKV3zElty7T9cbZacqponDAqxfuAShX9xdq8+XTZSm1A
	3BRWS4yZNzKORdIEcuJ2Mr6NUrGrpnt8J9IvrTrG/04Hscnu/xE7JEay9WMUMdANz6PDkk1hcAF
	F/kMEEOm+JMQWZ+WhhpSXMs2W5M6xeFg4f4fhQb5jZXM6U0mbS7YxfMOGmixWA/3rdy4Z3lBffW
	OM0g2lFGe8Q4s2U/5ruOjlLRubHSGvEUu2kfpFiQJ9mqvPHwp0eu3/yt5GENl96U3oFLQb9qY7F
	7DWlJbzezPZ6S9Pmv6exfRNC/4Q95GT1bez1lkk55HR1iymNO+uqZViFW5VwCR+a3JpuV65V+of
	Axaczj63qG/OLML9UHuLmzQ98qjYHkPyrBg==
X-Received: by 2002:a17:903:1a0f:b0:23f:d8e4:ded2 with SMTP id d9443c01a7336-245e04fa7ecmr18015985ad.53.1755585396147;
        Mon, 18 Aug 2025 23:36:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH7x2rlLjLEjoY6XNFKv6eIKH4qPemYI90LbCuQyKWX6k4A4fAbmZ2rJWHEIcg7kMoDk+m1Xg==
X-Received: by 2002:a17:903:1a0f:b0:23f:d8e4:ded2 with SMTP id d9443c01a7336-245e04fa7ecmr18015545ad.53.1755585395617;
        Mon, 18 Aug 2025 23:36:35 -0700 (PDT)
Received: from yijiyang-gv.ap.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2446d54fe38sm98120455ad.135.2025.08.18.23.36.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Aug 2025 23:36:35 -0700 (PDT)
From: Yijie Yang <yijie.yang@oss.qualcomm.com>
Subject: [PATCH v4 0/6] Enable ethernet on qcs615
Date: Tue, 19 Aug 2025 14:35:55 +0800
Message-Id: <20250819-qcs615_eth-v4-0-5050ed3402cb@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAEwbpGgC/y2OzQ6DIBCEX8Vw7jaCP5Ge+h6NMYhr5SBWoMbG+
 O5d0eNkZr6ZjXl0Bj17JBtzuBhvJksivyVMD8q+EUxHmolUFGnFM5i1L3nRYBhAopC5KMpe8ox
 R4eOwN2uEvWrSrfIIrVNWDweCKk0X/JV0OH9pLZzxM6uncTThkVhcA1yLgh2owfgwuV+8ufDYi
 D4XHIjZnK9gySCFXuW5LGWRdpV60og2Vt8Jzep93/9hUL5Z8QAAAA==
X-Change-ID: 20250813-qcs615_eth-9e294256f913
To: Vinod Koul <vkoul@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Richard Cochran <richardcochran@gmail.com>
Cc: netdev@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, stable+noautosel@kernel.org,
        Yijie Yang <yijie.yang@oss.qualcomm.com>,
        Yijie Yang <quic_yijiyang@quicinc.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.15-dev-5bbf5
X-Developer-Signature: v=1; a=ed25519-sha256; t=1755585387; l=1876;
 i=yijie.yang@oss.qualcomm.com; s=20240408; h=from:subject:message-id;
 bh=8rX82cXmDkiy7mxoulbCd1tP0xA4NYjLb7c/ZyHx9wE=;
 b=aePfqudwbcAPoG0PPnBbU0FLS0s8F7btntlHW3vUPmGfocAQIUpjWpRbyjMfijPe2uqxhVKJY
 McDY75ufw3tBmlF2fvkzXQ/MPEjYHaStCQJMuO2NDkjLw3U+Y3RiqW5
X-Developer-Key: i=yijie.yang@oss.qualcomm.com; a=ed25519;
 pk=XvMv0rxjrXLYFdBXoFjTdOdAwDT5SPbQ5uAKGESDihk=
X-Proofpoint-ORIG-GUID: Xor5Fr-W4osM4ZeDTuVfiD6O5rI7IfCd
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE2MDA0NSBTYWx0ZWRfX17YS1qGXLkiS
 jAig1ONeOHDuRUPyDokuiWb2VE9eV2UbVtPjaj2pyA3Lauk4AsUAiIdqJ+uJmQHxXtf0bLRMvxa
 bK2P3Ujif7ynYNL254Es7FLmKqcG2oFzwJ+LV7DxQloSq8Ov0VM0kvn9XSlCteNac3u4461WlAO
 C2mrb8QGyySa1vZ6Kt9bZ4n7y/ahOqUFBh1g1gGe0UzCDPVO9m+20wmU9KIaL9/y6ddhhzkRMy4
 L9Kv2IblONLnJcgAFqZPf/zxOsaX7uFSORNajeHu+rFmj+249qAwDFN+eHaZ13VH8GUu5O1VZ/q
 ao1WYUjXRuoEZpAqNHTtY9u3ia6WNSjDCq9XolsEtPHaXpBMCF8tGQGc7GLLvZmyBP47bL+ojQb
 eADbbgvu
X-Authority-Analysis: v=2.4 cv=IIMCChvG c=1 sm=1 tr=0 ts=68a41b75 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8 a=COk6AnOGAAAA:8
 a=EUspDBNiAAAA:8 a=wApU7nzg8TAj0S4BVTIA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: Xor5Fr-W4osM4ZeDTuVfiD6O5rI7IfCd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-19_01,2025-08-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 clxscore=1015 impostorscore=0 phishscore=0
 adultscore=0 malwarescore=0 bulkscore=0 suspectscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508160045

Adds device tree nodes and EMAC driver data to enable Ethernet
functionality on the QCS615-RIDE platform, supporting all three
standard speeds.

Switches the semantic interpretation of 'rgmii' and 'rgmii-id' in the
driver code to match upstream Linux kernel definitions. Updates the
device tree files for affected boards—QCS404-EVB-400 and SA8155-ADP—
accordingly to ensure consistent behavior across platforms.

Signed-off-by: Yijie Yang <yijie.yang@oss.qualcomm.com>
---
Integrates the thread:
https://lore.kernel.org/all/20241225-support_10m100m-v1-0-4b52ef48b488@quicinc.com/

Changes in v4:
- Change the phy-mode of QCS404-EVB-4000 and SA8155-ADP to rgmii-id.
- Remove the DT binding change related to the phy-mode definition.
- Update base commit.
- Drop ABI compatibility and update the driver code accordingly.
- Link to v3: https://lore.kernel.org/all/20250121-dts_qcs615-v3-0-fa4496950d8a@quicinc.com/

---
Yijie Yang (6):
      net: stmmac: Add support for 10 Mbps and 100 Mbps Ethernet speeds
      net: stmmac: Inverse the phy-mode definition
      arm64: dts: qcom: qcs615: add ethernet node
      arm64: dts: qcom: qcs615-ride: Enable ethernet node
      arm64: dts: qcom: qcs404: Inverse phy-mode for EVB-4000
      arm64: dts: qcom: sa8155p-adp: Inverse phy-mode

 arch/arm64/boot/dts/qcom/qcs404-evb-4000.dts       |   2 +-
 arch/arm64/boot/dts/qcom/qcs615-ride.dts           | 104 +++++++++++++++++++++
 arch/arm64/boot/dts/qcom/sa8155p-adp.dts           |   2 +-
 arch/arm64/boot/dts/qcom/sm6150.dtsi               |  33 +++++++
 .../ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c    |  28 +++++-
 5 files changed, 162 insertions(+), 7 deletions(-)
---
base-commit: eb91b04da2c3ac17e4e67079e455fba4bfd1b4f0
change-id: 20250813-qcs615_eth-9e294256f913

Best regards,
--  
Yijie Yang <yijie.yang@oss.qualcomm.com>


