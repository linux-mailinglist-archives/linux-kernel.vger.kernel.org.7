Return-Path: <linux-kernel+bounces-896651-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 40BBDC50E4E
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 08:20:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 21D3F3B9539
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 07:12:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 302572882B6;
	Wed, 12 Nov 2025 07:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="gvTDzYVg";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="CUzXQJqh"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B481028642A
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 07:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762931571; cv=none; b=eJ9v2V6LpH6RdzwOfT4AhsIHGvH6NSsNjRhDxCRD2o6sUJjJaKVbfIpRFWCqkdpUgXdSE+dSNPzpRbipuvercppHTAwYwg74d66HXMOWqxucqP5Xy+//bbNczidXC/onciC/Viyse/ry/F3h49VF79tLeYEhTE8N+QcjtAsSpG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762931571; c=relaxed/simple;
	bh=nm2Ff6jo8I+QGuD3PQnqbmzX4vD+x9n9obxne1ccimM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Kiw2BHULYxsY2QthihRah6aTW9VOVBMu+me2G7A5z6YsXQ/XnhgkxQpRNnSyKchWcz083+jXtBbucMNDYgtsKHbF+FB3XOcddyyz+8UOc6g5aYvAtTzrcqfwbkGoLNenT8mOYT1LSroUPe1GUooxHFZNeuigMKlhPM9kgeOBNHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=gvTDzYVg; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=CUzXQJqh; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5ABMwXr82540307
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 07:12:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=cTUtPl+F/Wsa2a4a3fwMU2pSucYtfz3vonO
	DrbZBpqI=; b=gvTDzYVgC58SDEn3SJOa90vgLPsdtqItCt5LsSLBFFGE+xxceAK
	ZaRjUVGVY8ceh0t6ciZG6gORwB/3QTpkOd1mA20AIgAi0Wu/pdWmws+QoUbFOmNT
	V3j5z6sR46pMtRozoA1nXnQmxku/83fpghn6DnIDrA17ef0bXJNrWUQf5KiSaBdm
	W+/GMMHgECRQnUdBiYLnl60FUIIzk2N/L83oCHpiE4hCZg/u/Mqw6n/5vDhE1unk
	mHDNZ25eXZcYgSwxXcaE3kScdjlRW2aFSNv600VQp5Hm3xX6j+J03ZmC8XnkGKna
	cwYPYRNEPGn63D6Stp/TFY8hkyQdSqfP2Qw==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ac5fgjsty-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 07:12:44 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-7b0007167e5so181859b3a.3
        for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 23:12:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762931564; x=1763536364; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cTUtPl+F/Wsa2a4a3fwMU2pSucYtfz3vonODrbZBpqI=;
        b=CUzXQJqhfH53ZFHB0PLdHMZbrY1ckYdAbEKd+EEWGCiYW+KVH19lSUpRTriUUn8GCE
         nEx8rc/Vc81K/tKzKSxt1N0P/VHJosuKIfr7JMAhf4HZHKUL+RxijGyt/yp+yckoMNJm
         n8hVczhdc/bgxjBvWgSZWg4lWbx1mqFsC49K9omrw0nQV9aiYsjjn/vqaWTYxVBBBnSb
         5YoTuyL4rMKE/C9LYJbbxfeIaJ8LomcZTQhUhQSly0dOGUtlm77CSi2mcU33/729IWpT
         GT56rK5y4o6W510qzZnenxUhoDGw3CRxplVadGGaZhVnjXMgE7Wt+Z6K5apbI9uiDWk+
         3S7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762931564; x=1763536364;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cTUtPl+F/Wsa2a4a3fwMU2pSucYtfz3vonODrbZBpqI=;
        b=tkXNJowEE24gK/BaU3knLBeI7WB/yjMVe9rbF+O+/fdYUJOHt7+MyONgwTc+ISb1WD
         8F4x4aB3XVRBN2Dcxcvr08K6Ri2XW9rw1TP0uKZaIXjj8beBeHKMAjQPxes9Zkskn+yQ
         okIQxefD2uMasxMpsc+6vvIhpAWyq0ATLNuBHT/V2OhSvKGBgxzUxTJQoKqiu9fynuO7
         UUrOGhyB6LB1EYCI2xx8xiIHwUfCobKEkySyAqMaxtKBMxWOqyBRmQ9Mo6+Zf7uHt55f
         2P+n+ueQqww9a2ysuDz8zI4FBO9GSF0iq63taxUjprqGPmzArtDRnvbcp6hoK1Tti/+D
         JJ+g==
X-Forwarded-Encrypted: i=1; AJvYcCWizNrY+jpwJkpu5tiTFUqyyUDZ6n+mkXn2pyePduNECC1nBzxZVQEq0C1FTL7GiMMw2Wq75/g/+QPMb7U=@vger.kernel.org
X-Gm-Message-State: AOJu0YywOy3gKiQtYmos+QX1zt4OxWldTwzHjxeGV6nKnuPWCPXVQ/GY
	ON2CdgLBhkGxaRv9YHIOH3nwWHMGQFv6y5xEhQLA/0W9gcgGDDYclGj2sKbFjHoKgd4WiAVGK7D
	CBCD0D03gwaWvVN5xf14CjhWIl+riHHHUQJkC/kPxRJdQhYRMItNCr0mZFucHyJDRZA==
X-Gm-Gg: ASbGncv8aLZjSmVzcT1sqCumjK/uXRMROmZFsiPSU8BA94K4acMCq0+vRS4LXLJscRa
	WzCyegY4RwsUP/Snto7b1pQYGl0xavUd5985NZ+4OtvErnLcw3D3V2+s/WYPit7vJ25wQfb7rMI
	7wwVt8gAMCfN5n9kF8rdm0FYtrScZHnFyVrxNZW0dxb2Dckh5w7/uvJIdS4rWoRT3NwoBTKlY6P
	7Do7wGTduZ1OF6SrdiR1TUa6aqlh4I8y82VDca8umbKc2qWGbH9CstHMKmnOjx4LZobBE8ZtNgh
	wtl0oQXzaPaYVtnYPfaRA7UoeKaLCm4EYKS2PPHKY1KMJssf8C4S6JP8Fn1rjqTuzaUl3oZindy
	U2VGB4VDhrzd5FjNaV5dyEVs9vSk03Q==
X-Received: by 2002:a05:6a00:3e21:b0:7a2:861d:bfb with SMTP id d2e1a72fcca58-7b7a59978c8mr1337979b3a.7.1762931563653;
        Tue, 11 Nov 2025 23:12:43 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE8/WVzXtZC81bsT/lVupwJpWgLlYk4J1uvkWrhn84yol6tDqvbdYjpuCd7yrTjhx/IcgUuVQ==
X-Received: by 2002:a05:6a00:3e21:b0:7a2:861d:bfb with SMTP id d2e1a72fcca58-7b7a59978c8mr1337946b3a.7.1762931563095;
        Tue, 11 Nov 2025 23:12:43 -0800 (PST)
Received: from hu-sartgarg-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7b0c9632e22sm17949037b3a.8.2025.11.11.23.12.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Nov 2025 23:12:42 -0800 (PST)
From: Sarthak Garg <sarthak.garg@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_nguyenb@quicinc.com,
        quic_rampraka@quicinc.com, quic_pragalla@quicinc.com,
        quic_sayalil@quicinc.com, quic_nitirawa@quicinc.com,
        quic_bhaskarv@quicinc.com, kernel@oss.qualcomm.com,
        Sarthak Garg <sarthak.garg@oss.qualcomm.com>
Subject: [PATCH V5 0/3] Add SD Card support for sm8750 SoC and boards
Date: Wed, 12 Nov 2025 12:42:31 +0530
Message-Id: <20251112071234.2570251-1-sarthak.garg@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: No9KnWDyi2mgr1XTih_hU-8_ywDbE8Mt
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEyMDA1NiBTYWx0ZWRfX4ER9gBJ9mYo8
 8RgqyxQhYP4RHjwu2Tb5uMQkarry2k7QbnI0ZXZuDJeEO0+5sgizh0qEh0w+qDIOAysnYTfymd0
 /SiNVKxMJF9pB/PbdLJkrHYsHxSudUUT4WIYmJNqBSvpnH89Wl2QiW+mHR5oYWfEbxxdOP0UFH1
 vACg8/z9dPyQI51nyy1kUQxi8VPWa3LTmwLbdEZAOFth6oO1QsRO0iCaTIcqECk/bgPvft3BCaG
 t6Wl+yjr2Uwaew7bU3mQHe8RPT7mSuStRDr0jBCEbHjhWxc4VokpJgXnEb7AZBsLaxF5JvuuSP1
 V4KFpv1t33kBwvDMGC+mp+wf0L0zzhyvkDLK/FX0q+PcU60rhHKKkqy+HOo7LXMxh96nktWpPIp
 vlziilQuXXqQve6aN1zHFxKI5HHv5Q==
X-Authority-Analysis: v=2.4 cv=B5u0EetM c=1 sm=1 tr=0 ts=6914336c cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=rfq7y1KLf-xer_pzc54A:9 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-GUID: No9KnWDyi2mgr1XTih_hU-8_ywDbE8Mt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-12_02,2025-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 suspectscore=0 lowpriorityscore=0
 clxscore=1015 bulkscore=0 spamscore=0 impostorscore=0 malwarescore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2511120056

Add SD Card support for sm8750 SoC, including MTP and QRD boards.

- Changed from v4
    - As suggested by Konrad Dybcio sort nodes with a unit address
      (numbers after @) by that register address.

- Changed from v3
    - As suggested by Krzysztof Kozlowski refactor the code to follow
      DTS coding style and use hex everywhere in reg.

- Changed from v2
    - As suggested by Abel Vesa move the GPIO configuration for SD card
      detection (specifically the pin settings for gpio55) from the
      SoC-level device tree (sm8750.dtsi) to the board-specific device
      tree files.

- Changed from v1
    - As suggested by Konrad Dybcio the patch into separate commits per
      board and did formatting improvements (e.g. aligning < symbols,
      placing each item on a new line).
    - Addressed Konrad Dybcio comment to use SVS_L1 for opp-202000000.

Sarthak Garg (3):
  arm64: dts: qcom: sm8750: Add SDC2 nodes for sm8750 soc
  arm64: dts: qcom: sm8750-mtp: Add SDC2 node for sm8750 mtp board
  arm64: dts: qcom: sm8750-qrd: Add SDC2 node for sm8750 qrd board

 arch/arm64/boot/dts/qcom/sm8750-mtp.dts | 23 +++++++++++
 arch/arm64/boot/dts/qcom/sm8750-qrd.dts | 23 +++++++++++
 arch/arm64/boot/dts/qcom/sm8750.dtsi    | 54 +++++++++++++++++++++++++
 3 files changed, 100 insertions(+)

-- 
2.34.1


