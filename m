Return-Path: <linux-kernel+bounces-831426-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4204BB9CA12
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 01:37:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F10223A947B
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 23:37:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E2832BD035;
	Wed, 24 Sep 2025 23:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="nJ9U22+E"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D0B1283FE9
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 23:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758757051; cv=none; b=gL9P+q75qzbYdf/vOvRzq1AusKDsBNDWogDSwqrM4soMSExNF0Pq1fijKa8VAMR3aehyiGnrq4oRxFMoNRACKpmNL/yDlATW+i5nNd54J2GOJwHVUv8eYMAgSh74bfIvprlzPS7ufF/ao+0VoQ8WQG8sZdC0HfG2aEOHUfxhx7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758757051; c=relaxed/simple;
	bh=HbXyfoMuaXdOi+XNdzbbQmz+0DZCe36zPNBcfEwwZow=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=X2lXzHiFWVCAaQpN23k4VD6J/NsJC9uZywEs7AhsmdRTwDBZ4jEhxFkgzLtKFOnS60CAbThQfDfEnogrc2gadvNVpt3123/3J15MQLxQKitkZJ/edC7ZjryaGixAmifKQZihumqsLzdVznTamF+WoP4qy4HHIloRggvol2XIfhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=nJ9U22+E; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58OCcBGV016453
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 23:37:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=yHPnfqqswUUOj8uDWMMqRL
	Rxv62OlWni7Al2oR+xh1g=; b=nJ9U22+EBEjBt5FnLJSVbCjTzFuYd1hsPFwcvc
	Od7+l4xrwKwHSnV+uQNOs8C2WhgphBplDHr1pA6F4MYSkc0Q7qZ4n9C6nzoilrFG
	dBwR/3hUwIP2WY9J6ZtDC7/tIoXEZV3Sb6JJckS1sw75Nrnet9I3T4YliVt2T3NS
	eNy9UPVUh4LB9Q1maIdx+2z2lcuY274xxqi1y0EEVWI20baykPQG8lEq8PyfvFQQ
	v3HIxO+FVrUSKely6veAEtaLiEgS/caqW918G/4tPytFuam5kKPUpLc5296URTSh
	/XtaWrHVjFGDiaaD3RqATmoZGRt2QtscZbR7JDpNHwfk2Dmg==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49b3nyhvb8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 23:37:29 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-3304def7909so344291a91.3
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 16:37:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758757048; x=1759361848;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yHPnfqqswUUOj8uDWMMqRLRxv62OlWni7Al2oR+xh1g=;
        b=k5FBYaQJiIsS14aPVDISaHJyeHcGB4OVAhcF39S1YVvIcBxZj+TrVRZiLrZrvWmWEK
         FL1N0mclAUptqCJbnEmjSYF54EyoY4bQMFvN1QYNd2jNcTShFmUKdWF1zX41hlbo2au8
         XhuWO47AgeoOW1V+tatubLe0qdCuykahMJavdrT/qXObcSgRxCdP1NVb6KGwP+sQwMV6
         DyFU8jIZBS4ErT83pxJb0m6ydFPffAa0z+A5SjebzOTJPCst+JXtF0I+2JbDnzUH/hVG
         q05ghzdl4AT4YRvNhHVRBlsvD7clI6koELuznQmHh5+ccT9NLd/zhLBHI5b+KtoIT7U/
         zgHg==
X-Forwarded-Encrypted: i=1; AJvYcCVt28gWRzrUB8728vudUZf/B0qQULZu/6ThWRNKnxQN/3x9vLPgJ5zO+ImDGNl+q10X2+msjZuAtUBvqPE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yya4Np8aWEOLRhGcERkW1BkXuGxIw5Gzmb2Mxu9MJt2vV9gI0ZC
	yjNipwN/Q25gP90gb7dh8QIUJ5pxv9nNYfW/eJnCpJMB2cvZnjAjnLGEpm6eyazLREwt8HkP9Zd
	Mnp6h5uvoKt95jQ7S2WDGaMLtbQ6gTCQHej/Geb7B9bugqEr5fBVgT4jFUFs9sz9aXSY=
X-Gm-Gg: ASbGnctWmfonQZ+nd3lJ2QJ/CCXmbFAp3tnypa3eTCiSgKcF4lcfE8Gpxk1bJ7ig3DG
	6m0CW5x3wi8TR9+pGoiJpMs0wuC2LTn4KMBbMrlcB2auctOmHxOp+FTzb9bh4uaEok9dtbCSuya
	SczeRGVECfNDEUQkECi6bPDiNt59MVPTKDe/nOMYEQCCXEVM/Ri8xMcV/zN9YVGdhdFjrSmkpzW
	V96hfSFmbkj1ydopoL7txq4kdMDzXechSMS+qg/H4ktlRsBHWPB9pLVRO81a76k51RYPjTMiP4J
	ri4gD+IFxcqhIXx1Pf7qr6Syjyb0aWG+Gv1vEoUF/9V43CzLE3JzhLAj4DcV6Y1a+ldx4+U0RBC
	c/pnKXQjJmcPB5dg=
X-Received: by 2002:a17:90b:4f8e:b0:32e:7270:94a4 with SMTP id 98e67ed59e1d1-3342a22f5c5mr1258187a91.14.1758757048418;
        Wed, 24 Sep 2025 16:37:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFu1fGpjzdi1GVnmxxWp5bhgd/H2916Z+w4tQ6cpsammJ90qXtBWMYWR89G7rEEpNT2kZSv+A==
X-Received: by 2002:a17:90b:4f8e:b0:32e:7270:94a4 with SMTP id 98e67ed59e1d1-3342a22f5c5mr1258164a91.14.1758757047916;
        Wed, 24 Sep 2025 16:37:27 -0700 (PDT)
Received: from hu-jingyw-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33471d73550sm227187a91.3.2025.09.24.16.37.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 16:37:27 -0700 (PDT)
From: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
Subject: [PATCH 0/6] Add initial remoteproc support for Kaanapali SoC
Date: Wed, 24 Sep 2025 16:37:21 -0700
Message-Id: <20250924-knp-remoteproc-v1-0-611bf7be8329@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALGA1GgC/x3MwQqDMAyA4VeRnBdoS2W6Vxk7xC6bYdiWRGQgv
 vs6j9/h/3cwVmGDW7eD8iYmJTf4SwdppvxmlGczBBd6N/orfnJF5aWsXLUkjBRS9HFw4xCgRVX
 5Jd9zeH80T2SMk1JO83+zkK2scBw/UJVrNnkAAAA=
To: Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        aiqun.yu@oss.qualcomm.com, tingwei.zhang@oss.qualcomm.com,
        trilok.soni@oss.qualcomm.com, yijie.yang@oss.qualcomm.com,
        Jingyi Wang <jingyi.wang@oss.qualcomm.com>,
        Gokul krishna Krishnakumar <Gokul.krishnakumar@oss.qualcomm>
X-Mailer: b4 0.15-dev-99b12
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758757046; l=1727;
 i=jingyi.wang@oss.qualcomm.com; s=20250911; h=from:subject:message-id;
 bh=HbXyfoMuaXdOi+XNdzbbQmz+0DZCe36zPNBcfEwwZow=;
 b=yTmROiAJGXM4/BM+N3MM+1kh85JsfNcQcrpuH20R/3Mgwdhq/fituUy1FsGbKULrP1cNxY6r4
 LHfRxxXWzRFClPnl3LAbm505O2QVF/ZfGwPwHhTCC5CGMNUStmQhojk
X-Developer-Key: i=jingyi.wang@oss.qualcomm.com; a=ed25519;
 pk=PSoHZ6KbUss3IW8FPRVMHMK0Jkkr/jV347mBYJO3iLo=
X-Authority-Analysis: v=2.4 cv=EuPSrTcA c=1 sm=1 tr=0 ts=68d480b9 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=YhI_PNPeQObCTaMrVkIA:9 a=QEXdDO2ut3YA:10 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-GUID: 0jez3b4Hfh3MvsKQ40kseJO9A6Knhib0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIyMDA5MCBTYWx0ZWRfXwV8GRYowU2PR
 aEEaRZ9L4fpjiW7vFYC6JoOIavwXCKbTKKg5Y4IQX8BALbEmtPIP/+CcwHCHTkFobrPIJxmBg6f
 GC9hXsbRJeZRbVVDN/RB62/taZkIzyYH2wHJnWVcmJBgXjMMELjLq5ibwdTT1yY5Bfb5mHgZ1xD
 T+5o1y5NFk8WUZW1lK/vN5dCPlXUvRr4J4COiOAbTSbLqTPcfFBvESaiCtpawRqICnToW9UdRYR
 OMb+H90UVIOCago/8ZePxugUaZ9L+8rgQSVLfyWDp19zwhIIynE/adETRvzqA+9qx5EPmAGdEjr
 FAPCmZaVSGTwz1/m8TRm1OIaK0ZddKh7paqA2IhvklGNDt83STC26aKkDswCsy9AVTH8gEwYhAG
 gApmljhK
X-Proofpoint-ORIG-GUID: 0jez3b4Hfh3MvsKQ40kseJO9A6Knhib0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-24_07,2025-09-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 suspectscore=0 malwarescore=0 spamscore=0 adultscore=0
 clxscore=1015 priorityscore=1501 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509220090

Add initial support for remoteprocs including ADSP, CDSP and MPSS on
Qualcomm Kaanapali platform which are compatible with ealier Platforms
with minor difference. And add initial support for SoC Control Processor
(SoCCP) which is loaded by  bootloader. PAS loader will check the state
of the subsystem, and set the status "attached" if ping the subsystem
successfully.

patch 5 depend on smp2p patch series:
https://lore.kernel.org/all/20250923-smp2p-v1-0-2c045af73dac@oss.qualcomm.com/

Signed-off-by: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
---
Gokul krishna Krishnakumar (1):
      remoteproc: qcom: pas: Add late attach support for subsystems

Jingyi Wang (5):
      dt-bindings: remoteproc: qcom,sm8550-pas: Add Kaanapali ADSP
      dt-bindings: remoteproc: qcom,sm8550-pas: Add Kaanapali CDSP
      dt-bindings: remoteproc: qcom,sm8550-pas: Add Kaanapali MPSS
      dt-bindings: remoteproc: qcom,pas: Document pas for Kaanapali SoCCP
      remoteproc: qcom_q6v5_pas: Add SoCCP node on Kaanapali

 .../remoteproc/qcom,kaanapali-soccp-pas.yaml       | 174 +++++++++++++++++++++
 .../bindings/remoteproc/qcom,sm8550-pas.yaml       |  30 +++-
 drivers/remoteproc/qcom_q6v5.c                     |  89 ++++++++++-
 drivers/remoteproc/qcom_q6v5.h                     |  14 +-
 drivers/remoteproc/qcom_q6v5_adsp.c                |   2 +-
 drivers/remoteproc/qcom_q6v5_mss.c                 |   2 +-
 drivers/remoteproc/qcom_q6v5_pas.c                 |  79 +++++++++-
 7 files changed, 384 insertions(+), 6 deletions(-)
---
base-commit: ae2d20002576d2893ecaff25db3d7ef9190ac0b6
change-id: 20250917-knp-remoteproc-4a2c41480982

Best regards,
-- 
Jingyi Wang <jingyi.wang@oss.qualcomm.com>


