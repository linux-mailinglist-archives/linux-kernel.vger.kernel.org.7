Return-Path: <linux-kernel+bounces-859676-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 88155BEE41A
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Oct 2025 13:56:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C75D44E8959
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Oct 2025 11:56:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A2692E6CAF;
	Sun, 19 Oct 2025 11:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="HQX4nssT"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AA972E2EEF
	for <linux-kernel@vger.kernel.org>; Sun, 19 Oct 2025 11:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760875004; cv=none; b=TBiO2if1vYAcDNadJMaTMapGvl6GbC5Wtd8SLzexAEfAnwr+8z1GsAW72M69qXoA9L0aZNOKL89goFzWFn7nPdYAlikozeSRt7LOEir9sVdwMlsKMno7bJ3hyO5CTs8oeEr0a3VOohe4ILJ9Vwr+TFMlJXxFn91z8v8o9PQeKk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760875004; c=relaxed/simple;
	bh=YlZ0ROP5gJyeqaSTmWX1xfZV7ZJUSRqclRMBwrURXks=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=fiLZru5ak/cnBm5IdGjKnjoCR+qolTXsif9H4nFMJv5Im7q3GmjyIEnO+S+tyW9Lp6PLxOk0Qn3XWNh6xgOwrZff43b6d9yoCgbjCobDUiDIgW5772j4MbAtktoQ58gxLnYTWVwLolkO2Uu61pfWeu8oWSLfs4/2AasY47u2L+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=HQX4nssT; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59J2vbsO002927
	for <linux-kernel@vger.kernel.org>; Sun, 19 Oct 2025 11:56:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=qUL97SYJ6g5PgkNTlGLntC7OPdptYf5BU9K
	KW6069wQ=; b=HQX4nssTBFjgy4XrNtQPzhjeta3qag2pfWU4Yn1I8MIJdMwt8Tf
	4lFk+4tbNKKr9XjXBLFpccgsjDpg4jmmZ2Iz2OJDbiTD5PXYYTEdYBp4umlcjj97
	1r6hkmOreAfAasxgRosaZdl2q3iuksSpRwUj5xGWaJXejV3DYsQfXwPaUtiwzAHH
	jAY7A/hziBNxjEBxgPrebF4c7ZZaOAwQt+qSlihwB/ZK3Bw42208In2NI3Y2oNNy
	FnL8hVgp5oaChhL7g0ROu6c9IKO3kxPSPCLsTsYdiFYO2+aJosN3JC1lYsLfmNF5
	emwVa5GxmymWbL6VT93VWYYCJiGbhlgKVWg==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49v0kfak50-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Sun, 19 Oct 2025 11:56:42 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-78102ba5966so3168902b3a.2
        for <linux-kernel@vger.kernel.org>; Sun, 19 Oct 2025 04:56:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760875001; x=1761479801;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qUL97SYJ6g5PgkNTlGLntC7OPdptYf5BU9KKW6069wQ=;
        b=GSfG0eqi3Ezw8qSRa+gMc2KfWBopaDpJTfnrg/OKU37EJfXs4ZMtd7Awe0IiJK9Sts
         AbF2FSF/Cjl0ewRZDIGko1WOpzs+naKhwMamwJTMYm//EEdwZDJKzfn1kX+1dNRPv+W1
         Mcfzrv4eAGA2rIVB6gcp0xFCDQ9MiJOkQES0tRnbZsmZxNhYdvkq49agNoM2KVP0jflL
         dN1/+RolNkM5AcM2iChcLmz02ME/PALo3Rt6ESYVqFNbm7DK5e9UZSmXtr9njrF8FotR
         BzuFCY9yQzRu6liICDF98gXL/OG94k1co0HHrz8dUR56hkJ3jbyzjAIYBPoSMEWLZQUs
         clBA==
X-Forwarded-Encrypted: i=1; AJvYcCXaDxzJQNh50SUlzkUUln/v3ck52MyhaH5vt2+t9a9NnyvLbnQv2lnH50OspTh+XjZZv4ZtjPiBi1nbREI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHfdndTrUzAPBYIXCaoZAHsb+LD96KmcqtZIRwstk2Vq6lAGlN
	NfC3UPBnohZPJlN9uGJK2nMdEJViyGi0rVciInNXNLk4LMka9LNRKpOU0UUl4Fih9cjallMXxUo
	9lwDhB9SrakwxD1gUybrhBqyEC7RdSHBJFEBfbOuKDxAITnQpb1Ub/lpNK1ZGYtUBzeFem2wnhT
	I=
X-Gm-Gg: ASbGncs/xXO3fC9yRuqqg85A+j2yUg145oUtp9ch1m1SizyWi/Ssn2AFPNAzb/Pk1T1
	s4g25iW8PCXetGX76DeANBInrJfHYQYQHCKC48fQU4TbNkM+bnk5VMeBZyYY1/F2p57EYW5izBZ
	M798owsL8/MVtSKl/n6ufFszWQwaKXHmbNpd9+wyO9cK6EyPd4q5prSa6epxsOmvCt6xWGUg931
	zCMYAMijTilz0uKWrgxc1PUNRS+V6jf/RBeuFUD27COp/5hqkYfVTIqdcTtsae1ZTQiHfVNKaN0
	aJgUCazcUSZ9QnFTNOKOWAh4Kv+bXeWym6rI1gvvmz+sty80A2PbZcTOG5i1quDv4NI6k49p/Vw
	7IOlQ+mtxOtwmQMCOwiY3MBQRbAHgavy6BaXR
X-Received: by 2002:a05:6a21:3391:b0:334:a82b:97bf with SMTP id adf61e73a8af0-334a8644619mr13330672637.54.1760875001136;
        Sun, 19 Oct 2025 04:56:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHKOi1ONCU8C3sWPP+vbxnfjGdeVLuUrxOpyg5H2azthwS1hFEUAi/DGOLztXP2tszOin5isA==
X-Received: by 2002:a05:6a21:3391:b0:334:a82b:97bf with SMTP id adf61e73a8af0-334a8644619mr13330652637.54.1760875000707;
        Sun, 19 Oct 2025 04:56:40 -0700 (PDT)
Received: from hu-kriskura-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b6a76673a86sm4970822a12.10.2025.10.19.04.56.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Oct 2025 04:56:40 -0700 (PDT)
From: Krishna Kurapati <krishna.kurapati@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Abel Vesa <abel.vesa@linaro.org>,
        Rajendra Nayak <quic_rjendra@quicinc.com>,
        Sibi Sankar <sibi.sankar@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Krishna Kurapati <krishna.kurapati@oss.qualcomm.com>
Subject: [PATCH v2] arm64: dts: qcom: x1e80100: Fix compile warnings for USB HS controller
Date: Sun, 19 Oct 2025 17:26:30 +0530
Message-Id: <20251019115630.2222720-1-krishna.kurapati@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=E6LAZKdl c=1 sm=1 tr=0 ts=68f4d1fa cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=mzrBCZWHuliTEfAr3rUA:9 a=NqO74GWdXPXpGKcKHaDJD/ajO6k=:19
 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-ORIG-GUID: XsvagMqt7BM-HHEP5_5h8PG7FLygscEh
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAwMiBTYWx0ZWRfXz7lkKdJpWnd2
 6W6VvcZX+IEyO+YPB3dXmJXNiEQuPypWBwS+HlWKW/OQtSv4JmxtCjh4vz8QxRB2FA+BGAD6PTv
 yMFb12E1A8DuBHHy3DVIjYmDZ9ooQvsEkyL84Aws9c8M3AjbNpwltNmv1ZISHl66tSUvlBrzf/h
 I5Z1+BQsgPa9/Xw8w9KmPLZYvrIkOCaYMGQSZTwxmJhowO9mghjCBQc6iYKmgdHsexH0mz2jTBi
 UFK2XTz9J0gLm2g6UHYLxyI0JmaRrrQjVtVYrq8TLvBQ08cbXR3sxiVBpItgAALe6qL8TX8dKaS
 FBC1zS7zInkCJEkmTxUUlJXvI6/AqmriFPpEXcIGC3QTmVtmuAvjzqm5eb4oxPTUNj2bfdrJiPS
 taX4X2ReLL9C1vNin85lPCsG6mwnbA==
X-Proofpoint-GUID: XsvagMqt7BM-HHEP5_5h8PG7FLygscEh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-19_05,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 bulkscore=0 priorityscore=1501 spamscore=0
 phishscore=0 impostorscore=0 malwarescore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510180002

With W=1, the following error comes up:

Warning (graph_child_address): /soc@0/usb@a2f8800/usb@a200000/ports: graph node has single child node 'port@0', #address-cells/#size-cells are not necessary

This could be since the controller is only HS capable and only one port
node is added.

Fixes: 4af46b7bd66f ("arm64: dts: qcom: x1e80100: Add USB nodes")
Signed-off-by: Krishna Kurapati <krishna.kurapati@oss.qualcomm.com>
---
Note:
This patch has only been compile tested.

Link to v1:
https://lore.kernel.org/all/20251014022121.1850871-3-krishna.kurapati@oss.qualcomm.com/

Changes in v2:
In v1, the fix was done after flattening the USB controller nodes [1].
Since there is a system suspend issue reported on that patch, the
flattening patch will be sent later after its fixed. For now, sending the
fix for the compile warning.

 arch/arm64/boot/dts/qcom/x1e80100.dtsi | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/x1e80100.dtsi b/arch/arm64/boot/dts/qcom/x1e80100.dtsi
index 51576d9c935d..6beef835c33a 100644
--- a/arch/arm64/boot/dts/qcom/x1e80100.dtsi
+++ b/arch/arm64/boot/dts/qcom/x1e80100.dtsi
@@ -4939,15 +4939,8 @@ usb_2_dwc3: usb@a200000 {
 
 				dma-coherent;
 
-				ports {
-					#address-cells = <1>;
-					#size-cells = <0>;
-
-					port@0 {
-						reg = <0>;
-
-						usb_2_dwc3_hs: endpoint {
-						};
+				port {
+					usb_2_dwc3_hs: endpoint {
 					};
 				};
 			};
-- 
2.34.1


