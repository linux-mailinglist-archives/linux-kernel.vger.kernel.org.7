Return-Path: <linux-kernel+bounces-850152-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF8F2BD2132
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 10:35:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 04C783C218B
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 08:35:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CA732F8BDF;
	Mon, 13 Oct 2025 08:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="TDe+QfG3"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD18F2F8BF1
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 08:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760344498; cv=none; b=bELZ9zI/gnUdsSvVn2qv0OOFpz5xzAj7ginoQMSxQfgwMXOO8ekd1Iwdkj/yJQ7BRj8+8v8xKtLcFkDXuZmVCUVw00rzyTdiFlBRoioxUJ4Haq6OHRJbySGHEmMyQ2gYMV2E+YAOxU6PrLprP97Ib7y5EyhgUvn0ITBYU8G6OjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760344498; c=relaxed/simple;
	bh=8N6JuyoDxEqzzX4bFNy5c5k0RGnFdELyNLGvZ2MUVOk=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=ll5Ssz3W75OjxULsRXAHYrjDUdwFtDd4gXu4w0FG7vqYQEMyDHwTGgd4YUZ1c2RV+Vmd+j++D4NI9aSFMKirF0Y0HwtRAm1SszjfF6xA8QITO2C5bzpHFk8IhjYeTxTcIoYYe30iJkvGqChOa1xZTi3maZfOMy0Cty87K6E0QHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=TDe+QfG3; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59D2nBwa000476
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 08:34:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=qePY1UHlkzuDJ9kRye75Pn
	muoq1wKjyrBK5aF/cS62Q=; b=TDe+QfG3DSfdqwCx296DQ7FZ0Xx2pQkR823ql3
	Ggmq0pbjmGuGoZKFwUHqRHraEFnt8b/1VKlLUyMHkqUZJoZFQ+z38K3xB9s6ahYj
	eJDRW1BCYe8ysSQMJUvVXzaibBxN1g7u9RTcZR28CqE0j5D9F3KD8Q7GHhjm8Z3c
	lMATX0TwacEeKtIlPQTrnGKF1xfH4EWNBKHrxrWduZPEiQ2BdZNiRxPErw44cI3z
	c/jxmn6nSEAuNSRanRRuaPeUeA4WDtD8PCJUKsAJ1Tjo0Iu+yzd0LvX/oglMR2wh
	HHIr1tRKq6hWWsmMVvJtFv04m6OW3tBHgqspV4fvrbjUV8/g==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49qferuwfc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 08:34:55 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-77b73bddbdcso6135777b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 01:34:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760344494; x=1760949294;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qePY1UHlkzuDJ9kRye75Pnmuoq1wKjyrBK5aF/cS62Q=;
        b=iTod3k70YTA68gIqVVZb2bw6rD34XaXp74F7pYiCuGnMuS67oZnNyh1wp0iNoraaRc
         jkdVnz2T7bOG+6DxcKEVwLX/w7FtOLBogHACXO5lcJQUR90yFU0G6YvDMItd7E1d2+sL
         saVT3WySqCNLEk+tjh3FRDU4qOdiIotcPIPqEmzcsD0mZC00h709rUmcjGW8VrnV7N/+
         jx/yc/0A1LYqJaXOIA2X+QBHYOAH5TJwLyFq9Imx/ke9h/DGMWQZ/LaRcxFjNxScvdrM
         g5ia18bV8uBrjzi+CT/KKIJvBD2aolK8NDXShjOYhh5scrwKSnD19hbrD7QLqNnJpYoS
         yXLw==
X-Forwarded-Encrypted: i=1; AJvYcCXTHv4DtUa8rWWCA2vTw2r1om99GNsDKA4RO1zJAuwQ1Q+tBulvGsrp+IIgHJycBAifbA/DrYlOaH+TaZE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYP67LeGADBgU9ZhomVzh82xWlZPvF6nIHjdqhQXmqOASOAjQY
	B7c5jvLdFDLdkv3wxXuMI7sc5lQ5c5DV7phPpVcnOqXH9pBr36Ondljtz1MRstvyI7lha6UB6JM
	JKiwEk4965LUTCEacuhUijHBasGbPaXpCojXJZbJqA8XHCWHZCJYImJbBjGaTO3bfThs=
X-Gm-Gg: ASbGnctTnyYlBIMPj7xWj7XQaeXsuym/mncLp0s1EHvliuy9C3tIbQ8crZoSn+78CPN
	wslkAQrBfpumkL3Acbn+Rbd2cUFBPZbQd8gtfAqvQWUQD+0fQZ+KLphUEVE3InNgXYT7xlmBeDD
	kY3EvgQkE0/rs2AiQwRz9nWPkpcWWZlbC9HoUjGeirZ//U6jftm+MEVsadwHJiahc3P9P3QQMNf
	ReL3/gJT29nJ0/uBRFEwVw7WN/4Uga6qic93/tTXeZuiHyTjITX3y7He93FwbSUAb5pPWvrWH8h
	tG45mBLkySPME3PYKeF8wp7YnB7WGJUZIYMIJJGsKB0Tu9nduN7sikyr/IMdcXDpaptjzLk5pru
	MxTRcPG639uqtPn51XCG1zB3nzKg=
X-Received: by 2002:a05:6a00:a15:b0:76b:ecf2:7ece with SMTP id d2e1a72fcca58-79231df6680mr25873004b3a.12.1760344494255;
        Mon, 13 Oct 2025 01:34:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IERV8N7NBi1nNuzIUr3/wdzTu8NLNE5G5dPZcctm7j/03i0JAZc/m2v/3H2x785lew0TsCKng==
X-Received: by 2002:a05:6a00:a15:b0:76b:ecf2:7ece with SMTP id d2e1a72fcca58-79231df6680mr25872972b3a.12.1760344493774;
        Mon, 13 Oct 2025 01:34:53 -0700 (PDT)
Received: from jiegan-gv.ap.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7992d09a87asm10773251b3a.46.2025.10.13.01.34.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Oct 2025 01:34:53 -0700 (PDT)
From: Jie Gan <jie.gan@oss.qualcomm.com>
Subject: [PATCH v3 0/2] Enable CTCU device for QCS8300
Date: Mon, 13 Oct 2025 16:34:36 +0800
Message-Id: <20251013-enable-ctcu-for-qcs8300-v3-0-611e6e0d3085@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJ257GgC/x3MQQqDMBBG4avIrDuQGAyhVxEX6firAyVq0paCe
 HeDy2/x3kEFWVHo2RyU8dOia6pwj4ZkiWkG61hNrWk7a6xjpPh6g+UjX57WzLuU4IxhSHDeW3R
 RRqr1ljHp/z73w3lekvzAfmkAAAA=
To: Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        James Clark <james.clark@linaro.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Tingwei Zhang <tingwei.zhang@oss.qualcomm.com>,
        Mao Jinlong <jinlong.mao@oss.qualcomm.com>,
        Jie Gan <quic_jiegan@quicinc.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jie Gan <jie.gan@oss.qualcomm.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1760344488; l=1382;
 i=jie.gan@oss.qualcomm.com; s=20250909; h=from:subject:message-id;
 bh=8N6JuyoDxEqzzX4bFNy5c5k0RGnFdELyNLGvZ2MUVOk=;
 b=Dxbu0m74+ExtDuCGfb/jHtefhFrQyDeNasjLJIZgNUvkIyl/vb6yB7Wvpe+DaVF39ceksDB8I
 MVnXQrcNPwVBICQgf0/xKwUdDb/ZugfIQh65tLcFpi6qqOs5HIdCZdE
X-Developer-Key: i=jie.gan@oss.qualcomm.com; a=ed25519;
 pk=3LxxUZRPCNkvPDlWOvXfJNqNO4SfGdy3eghMb8puHuk=
X-Authority-Analysis: v=2.4 cv=R64O2NRX c=1 sm=1 tr=0 ts=68ecb9af cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=YHNf7BNBHiJKSF8-TtAA:9 a=QEXdDO2ut3YA:10 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-GUID: O2LlI3Hn2pN7JWe_jmSMUyl77edeql6I
X-Proofpoint-ORIG-GUID: O2LlI3Hn2pN7JWe_jmSMUyl77edeql6I
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAxOCBTYWx0ZWRfXyJh9ngmoufWS
 8kwifAcDM6JcPfGAeEGbqmOAKsMzsBKHmgCHZPpP+am2F2xfka137mPCs3rZoejq5SymvrcRvPP
 81tipJlzlmTqeAAHWxC7B4+QpN6hlnFnQ9IKMq+z7SNU13TpH2QxehT0dUEqNOzEub6sn1KVu9N
 ++QJ0XXDANCqJ30RMqDja2FM51LujC+RHcLGvmToCoalzXCrLMKI8Pb04v3UaK77CsAeEpyOcqG
 DcmsgDl/VXTzh7Py42vIfjtRkejQbSKCz6QbeBUP0dNspsaKgE4o438pWi6kwy4T9B0FoTste6f
 OaNJSoUMfVfXOPL7d6v0FV7hbfmuJWVvtHcSi534+8T9tefedkvDzVRDRgkElZlOmBcjWD9odo5
 2uQ4rgxTk2FRu5k5iUw5pvZoRLqs0w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-13_03,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 lowpriorityscore=0
 priorityscore=1501 malwarescore=0 adultscore=0 impostorscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510110018

Hi Suzuki, Mike, James, Rob

Can you please help to review the dt patches? The dt maintainer needs
your comment before apply this patch series.

Thanks a lot

Enable CTCU device for QCS8300 platform. Add a fallback mechnasim in binding to utilize
the compitable of the SA8775p platform becuase the CTCU for QCS8300 shares same
configurations as SA8775p platform.

Changes in V3:
1. rebased on tag next-20251010
Link to V2 - https://lore.kernel.org/all/20250624095905.7609-1-jie.gan@oss.qualcomm.com/

Changes in V2:
1. Add Krzysztof's R-B tag for dt-binding patch.
2. Add Konrad's Acked-by tag for dt patch.
3. Rebased on tag next-20250623.
4. Missed email addresses for coresight's maintainers in V1, loop them.
Link to V1 - https://lore.kernel.org/all/20250327024943.3502313-1-jie.gan@oss.qualcomm.com/

Signed-off-by: Jie Gan <jie.gan@oss.qualcomm.com>
---
Jie Gan (2):
      dt-bindings: arm: add CTCU device for QCS8300
      arm64: dts: qcom: qcs8300: Add CTCU and ETR nodes

 .../bindings/arm/qcom,coresight-ctcu.yaml          |   9 +-
 arch/arm64/boot/dts/qcom/qcs8300.dtsi              | 153 +++++++++++++++++++++
 2 files changed, 160 insertions(+), 2 deletions(-)
---
base-commit: 2b763d4652393c90eaa771a5164502ec9dd965ae
change-id: 20251013-enable-ctcu-for-qcs8300-ec83661e5acd

Best regards,
-- 
Jie Gan <jie.gan@oss.qualcomm.com>


