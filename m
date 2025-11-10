Return-Path: <linux-kernel+bounces-892606-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AFE29C45705
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 09:50:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 469A23AA564
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 08:50:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA4EB2FD698;
	Mon, 10 Nov 2025 08:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="cMQeIyyP";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ihQqJkIh"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3E7E24E4B4
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 08:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762764625; cv=none; b=FVdENcqwVLIbE8tsQbJ4daIaVgryF0wyIDJx6B4jfk106ki/MGA7OuEGBHn32rwE7kFkvDLl02OVXBPiqfFnVJxB6vdRJX6lN6STII66NgZ4BZC+HapwmERzSg2VsTlRol9+5Vs/VQLbmzOMnixf0AaVqfimiH9J4eK1vRcjcwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762764625; c=relaxed/simple;
	bh=IhbfKHlJWQhalv4pgjr+NZ6u+4DphMJWdXicn05Jm5g=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=H5/Vs1kYauPbc7t4mWTZhm9RlEuCjV4Eb9yAdo1PnsV81RhejQBjnFHPkihdlPO1KznCPcnSVu2iXwFw6Wxa0T+Hb2Z8/07gjcAsEzMxpaKOHAA/Cd+KzNnbz+Ikp3GXlo8aCNf4KIKureAD0K/ObpVGINttOGQKz0tjA68kt5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=cMQeIyyP; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ihQqJkIh; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AA8TtNj1672507
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 08:50:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=nauiFKY5347uNKFMjqIRfTHnnYyyhUF+2FE
	U6TjAE/I=; b=cMQeIyyPYY3UAGtBgMK5UQxEcV2xQyJB10TL6OdXOV0nlpImJr4
	eMnYLqGS2Qg21W+4zzx7NhFLUxNYj8HGvouWCriEhLAjOyjhMUIQGqqsrt3aG3i3
	theDxaB/6ThcHcID64mRf/qssWi0XBlPVx3xtW83LhZZ03rwGgLwzCIHmWJFDeSD
	dcBDAS2MPveNs7QcaPJV+N03GOpZZkP2jjLPX3iMyGVMrmyJW/hFH23cIlaXd5qB
	RnSJ400EbJeAKbWwsyWEv+vNx/nHU5SBk/FD2KhXZ5qW81b5lh8zJcfs9yWFOFvm
	O4i29A0DAog3lPxM8p/ibj1MZU9f6mFmjTw==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a9xs7c11h-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 08:50:22 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-340a6dcc470so1348812a91.2
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 00:50:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762764622; x=1763369422; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nauiFKY5347uNKFMjqIRfTHnnYyyhUF+2FEU6TjAE/I=;
        b=ihQqJkIh79+8KnA22c3nmC/QegWt4jw3x/HF9vqcz/QahskTr7IClzloSEHNkwvmFG
         Kc06Bz3KfjpO8nyRtghI/cHFNmGTK9C0GRTXAspZOZwljY0wGm1F/2fxpxwSfXXGjZOk
         orXJwVua3I1GV20VBCu1Xho3lzO78oRiL7wyFHj0AxwjYiuLrYwMlDDeuiWf2HMmnEEe
         sR6zuxP4JQNiiWuJyFWfhYkUi9PpgpusU1yadbBzJxFX2RNIpBLSXsiv9YJ+xuM7+shm
         rQr5So/XzpyinsEZFnUZ1z/SThtOkgBNxjXXs6ZjYRanLUB9g1UMSrxa7QKFEaBr4Q3t
         MlmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762764622; x=1763369422;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nauiFKY5347uNKFMjqIRfTHnnYyyhUF+2FEU6TjAE/I=;
        b=J0VcFauJSXByjxpxAbyAmD2JCaFeURC5SNAQotDsx4M5R/euU0uLoo89cgZ7dav7tT
         bFzAh8RBlH0OICP0OZG6Ou56EijKV5ZT3N9nKe43uhl3nKwsW6J7YTRXJnNc3rmWY8sG
         Happ6ve9/JiW8Grm5WzQD+4+fnfZJvom7krJ1u4eF2YKOEhTytXF9a1sRop9XJ/QExmp
         uMIzSFC33enM1QoZllEFA1QSM/T9xBFp/EOWtMFcXOYJqXiKImsGqwmldPTRXkRqLcmm
         0ZNDJ25y56wTwt3yVL/4VECzAHVf0NkHfKTH3OulPk8LPpCmMWZb8XEmSNQXxzc64Ab/
         7QIw==
X-Forwarded-Encrypted: i=1; AJvYcCWuQ05dYIdfD62JQpEd1+OuU24Tl8J29mp8LWLNEwfXs/fKpwzFVpF2+xhq6Zw9s3MHPSCTAkEPLaNLktY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx88+g+u+FfCk5nUCRgWnbYPqozlnyk0BHfRgUH9ImxPcrobtdF
	1s9kqJYK+741U2uWHBt1jzzxRGoMdQqd82Lot5HLOckkFqeo/xJOhKLsMknvaRyJm/kVkteni5V
	nlVUi2G6nmA02UTZOOJf+I5kd8VcGqxeb42UkjyA+XKBzE7qXuLmAWHIpBA0RX7m+NA==
X-Gm-Gg: ASbGnctUG8XOyXDuO5HkSYXtSnTDT2BYLzNBvLT5V+ywR17gEovSgkPDlqD2I42vKdr
	Aca8tIUC64Fejgj56Pprk8rtxm/FamepQ/f844V6uamNaabSaMmgBsT/4L8ksBWnEzebib4hF+u
	qWsWhuGU9ELJ+1/OFVQ7dzfXhmC0dmsgl0MetPZSbEX7PfsGFXgPC1pV+2wOW/ctc0EqTDAdXMJ
	UFGQav4c5ycS7Fgx1ya4HkINrQQrDLh038Dg9aIfqtqpeQxbbESIPYowPcvqK0Yu0hx+6USlFRo
	FcKAf7A6oCFYv2GQ15+tQaXlz8EIsqg5tkHLQeEPRnc8PpqVW3hkJ275qug/i5/2Vl0godBffv8
	p6XMoPh8cbwig0rugmymfq+sP46RQtQ==
X-Received: by 2002:a17:902:dace:b0:290:af0d:9381 with SMTP id d9443c01a7336-297e56cf5d7mr54606425ad.7.1762764622089;
        Mon, 10 Nov 2025 00:50:22 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG37pdwCjNlIgB1OO4HGZKFF6Bf3VVYGkGr8yEAut5arveKWY/cDKq0txxG/5U07H51uluGSg==
X-Received: by 2002:a17:902:dace:b0:290:af0d:9381 with SMTP id d9443c01a7336-297e56cf5d7mr54606165ad.7.1762764621654;
        Mon, 10 Nov 2025 00:50:21 -0800 (PST)
Received: from hu-sartgarg-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29650c5f94fsm138691365ad.40.2025.11.10.00.50.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Nov 2025 00:50:21 -0800 (PST)
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
Subject: [PATCH V4 0/3] Add SD Card support for sm8750 SoC and boards
Date: Mon, 10 Nov 2025 14:20:10 +0530
Message-Id: <20251110085013.802976-1-sarthak.garg@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: r4FPU3Zp1n3cKSYFl_kD-JB2YCnnDW1H
X-Proofpoint-ORIG-GUID: r4FPU3Zp1n3cKSYFl_kD-JB2YCnnDW1H
X-Authority-Analysis: v=2.4 cv=LtifC3dc c=1 sm=1 tr=0 ts=6911a74e cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=rfq7y1KLf-xer_pzc54A:9 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEwMDA3NyBTYWx0ZWRfX0VxTeNok1Jdu
 oDIcVj/iH/szimIgc/5pTdSlRbBBFzmb9ARWd/1S+WSZnNBPR8rx7DaYaUc7qkO5eJtx9BFVl0B
 amXiG/uvTCCBgJQuRA3m8rQafGCNBfl+NtgxiCXFhxlIRbSjl9Ybxsk3edrUYpninYGRwHYGwax
 ogi0t+7BXC6wDiMMvCiikOJXoTKuRqz2gx3aRnAT74FbsH7wGHYBHPuv4LwTCieFmUvJacPIfvo
 KXFT3450jvUNtlj8LCqP32vLePYbExrQPkGDApWzI/AlUAMl/VybNib9irHkV3j/dDP1ja3laha
 d+QEE7cDsffnCGgZA53CUThOXl5m8S1b7rv8PSa2yHh4kyRsuCMICu0hLVJp/L1rL/ZDcFZcgCP
 VqurBJ95jy3zLElRrRr/rH1JFHtsZw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-10_03,2025-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 suspectscore=0 phishscore=0 lowpriorityscore=0
 impostorscore=0 priorityscore=1501 malwarescore=0 spamscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511100077

Add SD Card support for sm8750 SoC, including MTP and QRD boards.

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


