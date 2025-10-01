Return-Path: <linux-kernel+bounces-838535-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60480BAF6A8
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 09:34:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 156F13AA055
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 07:34:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD3AA22F74E;
	Wed,  1 Oct 2025 07:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="o1vEMLjy"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B46A22309AA
	for <linux-kernel@vger.kernel.org>; Wed,  1 Oct 2025 07:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759304050; cv=none; b=WtoDgEmgjenjE1ygW8R5Bl2raCDcNZB60b7rV5S/hUm0y9G+GPKgGIBeADoTL2bieUGIs/MSD8FZJQzORJthCX/2QH3hY3kE5NICdePQlLsNJ00KmxjCNuICRmxsvFeIJimqGT8znlfaACqjPBlwOMZVwuFXdhnv1WnbpQyej8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759304050; c=relaxed/simple;
	bh=LzYC1jG3vaEWlmKbl0QenPi4ZGyQJHOiHpelOB+tbiM=;
	h=From:To:Cc:Subject:Date:Message-Id; b=EiYfmuXWlJZNukSOY4I3RAduWoWqKUu9BoPxpmsPprj7qfI4R4ncVSDodqRGgCbRtz9InN9RdqUAEwlsoYVx38TiKPQ0rrc3K83a90y1VZN+VndJLxywRIYoaEevJDcaINSBQeRBiFSGf2k/0A+GBDX3TBz8UhdPv0tdrz9Ewug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=o1vEMLjy; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58ULFUlH027554
	for <linux-kernel@vger.kernel.org>; Wed, 1 Oct 2025 07:34:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:date:from:message-id:subject:to; s=qcppdkim1; bh=pp07pEUrCGLz
	DIs+Sa04jo+3a7TQCSPNLP1KjYGlBDg=; b=o1vEMLjy3GoDGECoKyxvayd5gxPL
	UHGXr4GmoC5uLEJw/DWlHeNMn2IJnVPvr2O4hGxs4cqt55BkmvQonxMgC+s7zn0G
	QDHE0KznlHYTEDPqXgybCTjDK2a/IIbZ8E7w11FtB4Oa2w9TQcH1hnGLEaKBa63m
	8WxTGeI4nNH3v5bHq2aE0g+bwc5KXSqHw7fAlbcjabZ97RHBtYB6zQMltEVhUAB+
	gxWsgqpD2PQqzPuO4OToWD8jevSIr859zslI0E+gIV8PmPm9IJkddIcS43fJX/4G
	Toj2kuoVHMU220EopoXxseIh/uYJ80pz2U4cj3F6FfasJ8sqd7O3wAFcfA==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49e851kqcr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 01 Oct 2025 07:34:07 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-32eb864fe90so9701429a91.3
        for <linux-kernel@vger.kernel.org>; Wed, 01 Oct 2025 00:34:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759304047; x=1759908847;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pp07pEUrCGLzDIs+Sa04jo+3a7TQCSPNLP1KjYGlBDg=;
        b=vXGx16PT/jp9tfUtgQHLeOBXAZsThWCmucpKHuRRmf3G01dWOwGJx/t6Aez34981Nd
         X3gIn6XbU/7crJRkryzNOeWAt0jrZ5ZEdiGCWoSxYebaf0tKya3JnWJIhtSWCPWQUtOh
         F8AFL4JVL3zKeCoCb/SRwoVcw6bTybvaO9jNTWa6y52hh+2i8By2ILP/+YMNkXP4TC8g
         Go4JNJ1knw4K9iSgUOpTyUkpb8T91t8Dkdy2S/bzHbJfXfFyHXn11yX7SfDe9tp4iAsn
         cfnsAQpFWfByB/pv9Mz6a2vu8sQCrb564VifhUsMlO62lqTnuRNgvNOK44PthDeKbdEy
         NUpQ==
X-Forwarded-Encrypted: i=1; AJvYcCVFO9frriUlh4SJIqvhBmcHuJYJkNHGg+euku8KJNYVTPYKKzUmSVKZA+i0eiDJHxFue96DA5iOVAGlQxg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8Qs1xXrBVPeRVbwCJ9wwLQ8pTTBTHBt5gtSJ350+54WF7ihFw
	DpnXmSiiLJWt0isDda80VCDwaOz338++bUTMaxkjJ8Zu7fE8Zaob6kplOEjz+U2MVHFHN60Tniu
	hhOiHdhkCnJ7b8uQnqGvReA3mGuBMWENKQwrlTBy4eQfKqi/vqCQu9xupZ4QY8FKJv0A=
X-Gm-Gg: ASbGncvez+01PiIv2pTKoGCBnxM/lIJlEwtjF7NoY4xvYb9F4nH7wW2b9KqeuNPlkhK
	L+rUCpnV4Ar2MFXCIF7Q2pCLL88bDWNGe1AlM7qV+cn10HzG7fqRWOZacG/CWjEyIpr43vUCp5k
	/gDPEdVvZoO3/rfEo5d6cYmS1YbEZymWtl+UJM9L1znAi4jk2FSykSYECExZQrAlGBJYLhTR2qC
	TIq3L9g/5sLU68LVUNr5zHUIuSNRngjX35aS7/vf/G8DmHQH2JYNq2UJWMcNreQYm4iSykVfDuP
	5eXkmxvTIca2Wt46vaotJ/gjV52xtxiY9K//KHJDp29flXZRs9ykaOmx2/RmhJIqYUhmxe4xGPQ
	7mqw=
X-Received: by 2002:a17:90b:3850:b0:32e:e150:8937 with SMTP id 98e67ed59e1d1-339a6e2821dmr2984142a91.6.1759304046897;
        Wed, 01 Oct 2025 00:34:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH4wCdRDYc1kF9kYi2y0x882T/fk3TpUqLUiTJTCRQG5Z3IT69LYgUd1RC3VsNXoEp1qGQSAA==
X-Received: by 2002:a17:90b:3850:b0:32e:e150:8937 with SMTP id 98e67ed59e1d1-339a6e2821dmr2984111a91.6.1759304046398;
        Wed, 01 Oct 2025 00:34:06 -0700 (PDT)
Received: from hu-okukatla-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-339a6effe77sm1642127a91.17.2025.10.01.00.34.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Oct 2025 00:34:05 -0700 (PDT)
From: Odelu Kukatla <odelu.kukatla@oss.qualcomm.com>
To: Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>,
        Odelu Kukatla <odelu.kukatla@oss.qualcomm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mike Tipton <mike.tipton@oss.qualcomm.com>
Subject: [PATCH v2 0/3] Enable QoS configuration on SA8775P
Date: Wed,  1 Oct 2025 13:03:41 +0530
Message-Id: <20251001073344.6599-1-odelu.kukatla@oss.qualcomm.com>
X-Mailer: git-send-email 2.17.1
X-Authority-Analysis: v=2.4 cv=OJoqHCaB c=1 sm=1 tr=0 ts=68dcd96f cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=x6icFKpwvdMA:10 a=myv7mu_oF8MPm2fSyvIA:9 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI3MDAzMiBTYWx0ZWRfX/W0plAnqcKbC
 u3g7+kXhAtBAT5vMDObNE//MgsmvR8VsFUXDHoCU1vr+ql2oNe+qlTnfiGydWYGOQ/Wlspu85xT
 Aej0WpGwO7eE9feRcHwOu9pEMrAFS1d8CEoHF5Q+HcvylTrY2n/Mtz1WXalT2uVzNIvYSXjXPeG
 iOiMOju+6/RI2ELCPHa7jK4g8lKAbCjb/sVtz7LYRo4jVES/3C/hfU2j9NBTIHKWKpP8GBnV91J
 QmCOaadN9jlcjClGnU+PCAM0/kvaKrt0Kf3rfbKa4DOXK1mBhB40S+Ls70aOCYSWqofHVrfY1O7
 swIhDf5CklWRJW9KJzXYECtXc1mXATSG0S5eYawOVnBJ0NUt+2TC8p/ZzkLFHSA9SlG1yAUCRC3
 gYvPCDSXP8AfsbePm3esWQamEagnBg==
X-Proofpoint-ORIG-GUID: H4dGm4t-TS_ldQVGO8Su6xdu1KbQ6E-F
X-Proofpoint-GUID: H4dGm4t-TS_ldQVGO8Su6xdu1KbQ6E-F
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-01_01,2025-09-29_04,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 priorityscore=1501 bulkscore=0 impostorscore=0
 suspectscore=0 lowpriorityscore=0 phishscore=0 malwarescore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2509270032
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

This series enables QoS configuration for QNOC type device which
can be found on SA8775P platform. It enables QoS configuration
for master ports with predefined priority and urgency forwarding.
This helps in prioritizing the traffic originating from different
interconnect masters at NOC (Network On Chip). 
The system may function normally without this feature. However,
enabling QoS helps optimize latency and bandwidth across subsystems
like CPU, GPU, and multimedia engines, which becomes important in
high-throughput scenarios. This is a feature aimed at performance
enhancement to improve system performance under concurrent workloads.

Changes since v1:
  - Updated 'reg' and 'clocks' properties as optional.
  - Removed leading zeros in devicetree change.
  - Updated commit message for binding change with justification.

Odelu Kukatla (3):
  dt-bindings: interconnect: add reg and clocks properties to enable QoS
    on sa8775p
  interconnect: qcom: sa8775p: enable QoS configuration
  arm64: dts: qcom: sa8775p: Add reg and clocks for QoS configuration

 .../interconnect/qcom,sa8775p-rpmh.yaml       |  50 +-
 arch/arm64/boot/dts/qcom/lemans.dtsi          | 163 ++++---
 drivers/interconnect/qcom/sa8775p.c           | 439 ++++++++++++++++++
 3 files changed, 579 insertions(+), 73 deletions(-)

-- 
2.17.1


