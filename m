Return-Path: <linux-kernel+bounces-846305-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C38E7BC7855
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 08:19:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A12234E6AB8
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 06:19:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48207296BC4;
	Thu,  9 Oct 2025 06:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="YjJFE0/r"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E9CE1FFC48
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 06:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759990756; cv=none; b=eB1xV9ErfxXxmgfzMT8/gudvja51QIXRMWMprW2C26xSiq2Gj/UVYXIKdwvA9ck5qdPUbG+Fv0gkDmEB+RnEvtahwjXCzYyl7RKplZHyWOoohY+vKlNTmfqBBuG3a4c87R/2LupXOUhvF5hL/ALvXrjMaWinznYpqjPEdbwY3/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759990756; c=relaxed/simple;
	bh=RElW/V0Z435eecAoQxgFffr/tjQtz6OYj7jJiPqLdnw=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=u/aOpQGyapyQtoGvxRprPwjN5UIMO4Y7hXrUa2u1L78aUDDJWKYfgSKbsUnTGf78naLgarXl2hAafhts48+uSZhjVOBjXqAcuSG5sU/MGmLGUIy1C7D3p6V3uqYdorM90iOKq3FuOR5nkvs3uve6Os3zqLIqinKl6CsR/0h3PIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=YjJFE0/r; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5996EQ5m029793
	for <linux-kernel@vger.kernel.org>; Thu, 9 Oct 2025 06:19:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=27kHMdvwH0X0328kYvOzhu
	ArDwRqIDLbTEsO0hy9HCs=; b=YjJFE0/rII1owim/UA+hyfDgNMuDeEEDElg3Iy
	B+juKA67PUZwgbom6twBx2RXIt1JjYmLShtoasVUiZMnv5be0KwZ5NWvGScDroHO
	lD9xXANlGq1mSs7xJoUflN/8+fXF/aQAoXn+QDygvzO4nrkmNvei+VWz/S+O2xJR
	qZYD+5LBVLsnQWCNffzEpxK6lJ8XikT9KOznD4P9/7Wg9WCRN+xRcW9FOw5B4xcx
	xU0opuJyAZuTC/k1d93/faxE4qYXdGUZCbSFsSdY21JTd4c+M6NcUDpZXzMIWT+C
	RReJnx8vGiqeAMwagGmXhYmTLKN6SLRzg6twbWnxd4SxO0zw==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49nv4n9pbf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 09 Oct 2025 06:19:14 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-b4c72281674so714967a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 08 Oct 2025 23:19:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759990753; x=1760595553;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=27kHMdvwH0X0328kYvOzhuArDwRqIDLbTEsO0hy9HCs=;
        b=Hl1w2oJkesDDNXvvuNbcEwPe8qNHcXhpu4oLStx7/mPfwtnmnHJdQKYBtat+RBv8I4
         peYciELFj+npcKcXebSVsqVrY+hE8Wf4SREUm1L4C7JX+6YyrzIAd5tMVj8co/m5bLxz
         mQejOAtUannYO4u4yPp9n0cR1FD9mN5aYY082MObVtIOTFmbOYYiDZl+Mg7JgtgusemB
         1Sd6GyxwbXM8aFTFQbFQdQU1Y1fjezZnbvwEV8y1nM1S6AVcx0BwlZk9Ro6lY1ZV1A+d
         Mn82lcFeFHQ0Sz9wT1BVbnHQ+6rv19O3kL8VzODE53KTEyw5vyKl82pmkj4F9e76Clef
         XHOQ==
X-Forwarded-Encrypted: i=1; AJvYcCUcN+NgxKhJHup4vDENuEgeHHb4vcUINDYvQFrMoiIgzbU4IrStn/rPvxMfXk0eRvwjEervQC71bnr1Xao=@vger.kernel.org
X-Gm-Message-State: AOJu0YwD1rMiKgB/LEsZ+IbI/Qpt/4nKF1g/9SFfJwPWIhPHrrXzM5xi
	wKsvsznW7s9MJXivxPHTA3H5ImT4g7hM5X6h87VLTxUpSDNI3N0mJFg0P7430KmB8iGSoYiKFCs
	NXZahNcbsLjDWY9OWlRfC+ixGBzBPzma+ztOa71lNkvrbihfTDs0OF9f8JDwT3xqhBXI=
X-Gm-Gg: ASbGncvY/+itiwFCiD1kAGL97t/A/D5oEML4seatm69ckbOkCH03j6BsxlqiAYNxQG/
	dYGnnzqmEmNUWRwaveKMmC34ypS39Qx5fulw5hnOLZt48/n8cLe6frkXIfcxU+ApqW4fH4MYmxt
	bwsWevSdRSQjo+Mqf4qDmgJtfVCqkaABAhYyjb6tyKjY6HZVTbACiJOi2Br4fuMzC9qiyKHWwtJ
	Zip+4z9vEwiNNjMpTmPnM4y3OF1ZqmhZq2brJa60qtBsQWMyQcqmWaR6pPBafAc6fR340u0amyp
	EebSDkS6egkzPiQn27GA9AxhspVheqn9kUuj9PG68QlXhYI0I8+9kMqbfNno0LPK2hwn9RxDQkb
	HDYpbDhU=
X-Received: by 2002:a05:6a20:6a1a:b0:323:cbb9:aa1b with SMTP id adf61e73a8af0-32da845fef7mr8847877637.51.1759990753256;
        Wed, 08 Oct 2025 23:19:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEYwiXOhov/LxmRkYry+Q9grSkuraWC5lKuqWh3Ov3GOZp6ZzGWGHWrshn76JtzwZKRRdX/NA==
X-Received: by 2002:a05:6a20:6a1a:b0:323:cbb9:aa1b with SMTP id adf61e73a8af0-32da845fef7mr8847838637.51.1759990752738;
        Wed, 08 Oct 2025 23:19:12 -0700 (PDT)
Received: from hu-arakshit-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b6099adbcbesm19239671a12.4.2025.10.08.23.19.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Oct 2025 23:19:12 -0700 (PDT)
From: Abhinaba Rakshit <abhinaba.rakshit@oss.qualcomm.com>
Subject: [PATCH 0/5] Add separate ICE UFS and eMMC device nodes for QCS615
 platform
Date: Thu, 09 Oct 2025 11:48:50 +0530
Message-Id: <20251009-add-separate-ice-ufs-and-emmc-device-nodes-for-qcs615-platform-v1-0-2a34d8d03c72@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMpT52gC/x2OwQrCMBBEf6Xk7ELS0ir+injY7m40YJKabUUo/
 XcXj28G3szuVFoSdddud00+SVMtBuHUOXpieQgkNna978fg/QTIDCoLNlytI4EtKmBhkJwJ2BS
 WlcqiEGuDN+kURlheuBpmuAwy03CemZmcjSxNYvr+D9zux/EDOpnIN5AAAAA=
X-Change-ID: 20251006-add-separate-ice-ufs-and-emmc-device-nodes-for-qcs615-platform-83ebc37bdddc
To: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>
Cc: linux-arm-msm@vger.kernel.org, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org,
        Abhinaba Rakshit <abhinaba.rakshit@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Authority-Analysis: v=2.4 cv=ZJzaWH7b c=1 sm=1 tr=0 ts=68e753e2 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=EUspDBNiAAAA:8 a=TE4wMAv-58-w6rAmtzAA:9
 a=QEXdDO2ut3YA:10 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-ORIG-GUID: O1__T21zd7_NRUoxUg3kOQS4CzQaJQQA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA4MDEyMSBTYWx0ZWRfX5G0+6FRVSNQW
 F+uigI8cdEMdFZdxoQRfM7RQdBgNP76DcosW6jaDk1G80o+eH+FzzNlOcuXPcGRHUuWb1UCx17K
 lHm1LATObXseuYCQYyQT0MwuV0TGmnnh0Co9Uys6xk0HhLdge5J9MSDIabm+LKJ7ymmgKS50zKs
 Sbq20fEtNtk/b//4S95ClorF0PW4kznC61xoXWloat4ImVAvN0IeiU/Z4IMaxx6OlF38V1vMCMF
 EkkqF/mdCNjazAETg9IGXcOByIbL1AUs8fTS8m8Ddh0zYn/maJ2qqkEhEMfSGwZDuQprMgpai2g
 nJTKvH5k0xgnHt2wkb6X7XmvzaInIq+W+pSaaBV+NHqQzyW7sC5NKZ4e+dY7eStwjvYa01+YbPf
 rVCZ9NgUbmoicDXsI9KaWiExpAitxA==
X-Proofpoint-GUID: O1__T21zd7_NRUoxUg3kOQS4CzQaJQQA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-09_01,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 clxscore=1015 malwarescore=0 lowpriorityscore=0
 phishscore=0 priorityscore=1501 impostorscore=0 suspectscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510080121

This patch series introduces support for representing the Inline Crypto Engine (ICE)
as separate device nodes for both UFS and eMMC on the QCS615 platform.
Previously, ICE functionality was implicitly tied to the UFS/eMMC controllers.
With this update, ICE is modeled as an independent hardware block, allowing its
clock and frequency configuration to be managed directly by the ICE driver.
This separation improves modularity, aligns with hardware architecture.

The change allows the MMC/UFS controller to link to the ICE node for
crypto operations without embedding ICE-specific properties directly
in the MMC nodes.

Signed-off-by: Abhinaba Rakshit <abhinaba.rakshit@oss.qualcomm.com>
---
Abhinaba Rakshit (5):
      dt-bindings: mmc: add qcom,ice phandle to mmc
      dt-bindings: crypto: ice: add freq-table-hz property to ICE schema
      dt-bindings: crypto: ice: document the qcs615 inline crypto engine
      arm64: dts: qcom: qcs615: add ufs and emmc inline crypto engine nodes
      dts: qcom: qcs615-ride: Enable ice ufs and emmc

 .../bindings/crypto/qcom,inline-crypto-engine.yaml |  7 +++
 .../devicetree/bindings/mmc/sdhci-msm.yaml         |  4 ++
 arch/arm64/boot/dts/qcom/qcs615-ride.dts           |  8 ++++
 arch/arm64/boot/dts/qcom/sm6150.dtsi               | 51 +++++++++++++---------
 4 files changed, 49 insertions(+), 21 deletions(-)
---
base-commit: 47a8d4b89844f5974f634b4189a39d5ccbacd81c
change-id: 20251006-add-separate-ice-ufs-and-emmc-device-nodes-for-qcs615-platform-83ebc37bdddc

Best regards,
-- 
Abhinaba Rakshit <abhinaba.rakshit@oss.qualcomm.com>


