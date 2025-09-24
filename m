Return-Path: <linux-kernel+bounces-831410-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A32EB9C963
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 01:32:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3529B189EA30
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 23:32:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCC892C08A1;
	Wed, 24 Sep 2025 23:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="E9OInPVp"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 299FD2BD5B9
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 23:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758756708; cv=none; b=nSJLLXVl7al7i4aFuGUTAPsFJD1PhNoqm+aw9wgTvO1zQ471RPc6l4SOwicIFU/OLESgujOfjklkExQqIqDWt3ejePDTCwfB/ESlzpX/yTe4lYRrj2GKSg0rQQp+aX8dE3jkgymp0n/rLCQWrxS+rYODwF0+FQQX68winMldGeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758756708; c=relaxed/simple;
	bh=gv4bignPwPIvaLzxZMl8aYlpvlEaasjWbVN87G69RMg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZwMdkr1R2+lsfAhsEE139IWB/suaJSphIZ0CoGEf8CCYF2KF7S4tZgiiDFZb64NfX6yAq7Y5vk09rYcnVpImsL2wyU74N9GyPL9Zy8EgxSxg31Yy8fILtXoweswVQ6rb1gMxh4jW/ytpvUdFmv8u+BOLoqqlKYYBZ3H9CVXHmi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=E9OInPVp; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58OD1B8C002114
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 23:31:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	HEbGfgEgVvyLWvUpMV+kJZby48hk/Aw+XecnjFL0cVI=; b=E9OInPVp1+b8GUmk
	LPOodt5UvSANcift7Qe13bTdwszJBUhfSnRjYr/rwFMahuUJHZ8Nb1gQNZgB+WAk
	HALobXGa91zYNVguiA2MEqIOR3E9m5DQJ5Y2d8M8MZeJGCLkCz7Gm6FfivBCTnee
	/k03shzzefbHuwMWmGz+Q5bjvNp5T7s1RfodNX9CQ2ONATR31U5/Dqp0Qlam6q0M
	9sB/B1GNADPOK+JpyargEDRgyCN6dqrij0Uj0jS3PVkPLEYrXHS2XnqveutHDEf4
	cDoCF883M/DI8QzOWbN0YPyXJQCuAFTTTfzz4DY3NuV5vSBje60uHBBBfXYKgCbL
	0bXeXQ==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 499k98p1yx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 23:31:44 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2445806b18aso3019465ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 16:31:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758756703; x=1759361503;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HEbGfgEgVvyLWvUpMV+kJZby48hk/Aw+XecnjFL0cVI=;
        b=E9Du3VJSNLO2+fldhLPMF+7JwbU6eAXWGJRmz3A57bpf2EWCmhNvNwVGki+mD7hrUa
         i4moF7OHTvJX1rPeczbE7WfxRsyJ6y/0GDWe3p0JC/flOvbRZYYNfEi6hVPVU2tQ1Gq1
         +bcI+Zbayn1ElzGsPDzLriQNv6+pmsvGGbFQoNkF9UeRKWFLM4c8UrHVUvtxveJNUx34
         +Q0M5TkFbHptZ5EeBW2k4o+Sq2Ic5Mal1bOMz4kuXQkqTHkeBodZfSoIJPOfA6Dur2Ow
         J36lIPY+kySDHUOSU1Wsyn3slPyK6V1sS05y82rlZHKcYsODfYja63TXYTbL1YcT6oO5
         2n4Q==
X-Forwarded-Encrypted: i=1; AJvYcCVyyrECcEBCY096VykfKBeGphTQV7xS+CIXgeEDQfDioMn8ddkKYpHcw0KmVI4PpNAaZ5bH/2r1VF56q1c=@vger.kernel.org
X-Gm-Message-State: AOJu0YzkDCq+wpaoIHCt0OcvqQnkTfQjhfXs4LCNXqw77JKoQF7ZdCD1
	p16kJjiypqmCMZF7gy+Y217nJlphOLLpjIkwwGm+2ZeB+ks/PcD5KsKcsugeu6G9IBMiFU9SLcM
	fwbU9JIvKCRNoBn8ESMe/gqGFu22/i07uBghI51ftyu8ePu7USkSR/eFimNzrA/U1qiqSHf4O0X
	ECLw==
X-Gm-Gg: ASbGncsq5bLyLXLRTIG/U2D1+wHPQRXXPo0WSrbHeCEQZKxmTm7w5Dxn6EY37ulTTZo
	ka2gjvKxYy0pKgoPDBkGTAaU8UfsebILbney7lnu6LkUR8IUskHGa1Hrf3B4b5ByFIGhobsReuP
	aqSMBtAQ3EiD/P3VKYpM6L9sMuiqgvY5wlQS0OABjSvRz5YZg4SW+CN2f2v8MufwLhHnPnAJP81
	oK21YKf0sY3CEYQT2s/+Ud/dRg2JNjwK6clwjy+243hpkmZmXlLnYbXFQuSHPGqfGi3Q6RtzrLW
	mYmdxc/TWEmwTxXPEzaYNUrEnvpcgAUVPC/U38tiehZ1CkLSbABEVktXC8ZnxHwK8pzSlADTSvJ
	JriN47kLQrWDW5cE=
X-Received: by 2002:a17:903:19ee:b0:24f:8286:9e5d with SMTP id d9443c01a7336-27ed49e1bcamr17500295ad.26.1758756703349;
        Wed, 24 Sep 2025 16:31:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFaUXn+8eqPQxI6je39tc7Vwbt4iRDRLI9jYa08ujNKrkWdzuejeRqpiM7dEQS8rL3qk5wBeg==
X-Received: by 2002:a17:903:19ee:b0:24f:8286:9e5d with SMTP id d9443c01a7336-27ed49e1bcamr17500135ad.26.1758756702873;
        Wed, 24 Sep 2025 16:31:42 -0700 (PDT)
Received: from hu-jingyw-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33474f14e4bsm194322a91.28.2025.09.24.16.31.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 16:31:42 -0700 (PDT)
From: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
Date: Wed, 24 Sep 2025 16:31:37 -0700
Subject: [PATCH 2/3] dt-bindings: soc: qcom,aoss-qmp: Document the
 Kaanapali AOSS channel
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250924-knp-soc-binding-v1-2-93a072e174f9@oss.qualcomm.com>
References: <20250924-knp-soc-binding-v1-0-93a072e174f9@oss.qualcomm.com>
In-Reply-To: <20250924-knp-soc-binding-v1-0-93a072e174f9@oss.qualcomm.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Robert Marko <robimarko@gmail.com>,
        Das Srinagesh <quic_gurus@quicinc.com>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Jingyi Wang <jingyi.wang@oss.qualcomm.com>, aiqun.yu@oss.qualcomm.com,
        tingwei.zhang@oss.qualcomm.com, trilok.soni@oss.qualcomm.com,
        yijie.yang@oss.qualcomm.com
X-Mailer: b4 0.15-dev-99b12
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758756699; l=876;
 i=jingyi.wang@oss.qualcomm.com; s=20250911; h=from:subject:message-id;
 bh=gv4bignPwPIvaLzxZMl8aYlpvlEaasjWbVN87G69RMg=;
 b=z+xjsv2LTRuhcyCyzpFHffbo5dJqfD4D1fV5G/YKRcoDNhu2yffmXqKweYfyRtfJ+OOdE/B6p
 gF8Sj0VDZtfD2mbsBvW6obaK4UarsGywnJpNSk/6pD66uqLHceMy31r
X-Developer-Key: i=jingyi.wang@oss.qualcomm.com; a=ed25519;
 pk=PSoHZ6KbUss3IW8FPRVMHMK0Jkkr/jV347mBYJO3iLo=
X-Proofpoint-GUID: KS1nafMzEewPSmXjxSMKe_NdiLkhnlqO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIwMDAxOCBTYWx0ZWRfX7SaJ50N7fdjw
 v51LpDXYDTHYFK1s43aezw+SGsxWxxRqyvnJ5IoX2l3GZuic1CjvIEETYGIKoyxKNzQfqxXT21I
 s6YVrLVui6AHtMgQf0q/nAz5UptQGOVgv14iv9s7L5de6pbaaXPLgcf7QNaIVwCbWaqj5c49WQa
 al/RjDcB/l0GVi2/NPRj8NT1dYiQWCklvNWW3lR25BvQ/R7EqWJeI80g4J/AKzWJ0yWYWtUo8Ck
 lUW0V9afXdKnTN834RrWZ3tz3s+c4U+NJVpCnNu0CZg6kI4oQq9bqmWgX2sCbcT67lGO0UEugkq
 Kf9zGyogLEhs25wjgJYPgZsYeA3t+ZIIRIs7LvUmLWouSsO7p67HdIgn7Vb0J7gAs5ue3U6PaEI
 P3NF4q1g
X-Proofpoint-ORIG-GUID: KS1nafMzEewPSmXjxSMKe_NdiLkhnlqO
X-Authority-Analysis: v=2.4 cv=Dp1W+H/+ c=1 sm=1 tr=0 ts=68d47f60 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=yNaZ28o-uhmfSKpOO1sA:9
 a=QEXdDO2ut3YA:10 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-24_07,2025-09-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 adultscore=0 bulkscore=0 impostorscore=0
 phishscore=0 spamscore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509200018

Document the Always-On Subsystem side channel on the Qualcomm Kaanapali
platform for communication with client found on the SoC such as
remoteprocs.

Signed-off-by: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/soc/qcom/qcom,aoss-qmp.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/soc/qcom/qcom,aoss-qmp.yaml b/Documentation/devicetree/bindings/soc/qcom/qcom,aoss-qmp.yaml
index 851a1260f8dc..57aa819939f0 100644
--- a/Documentation/devicetree/bindings/soc/qcom/qcom,aoss-qmp.yaml
+++ b/Documentation/devicetree/bindings/soc/qcom/qcom,aoss-qmp.yaml
@@ -25,6 +25,7 @@ properties:
   compatible:
     items:
       - enum:
+          - qcom,kaanapali-aoss-qmp
           - qcom,milos-aoss-qmp
           - qcom,qcs615-aoss-qmp
           - qcom,qcs8300-aoss-qmp

-- 
2.25.1


