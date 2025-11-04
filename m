Return-Path: <linux-kernel+bounces-884247-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 96C7DC2FBB0
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 08:56:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 08F2C34D0B9
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 07:56:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C76DB3112BD;
	Tue,  4 Nov 2025 07:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="alQ8yu3x";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ckrPo/BE"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AFEF3101A9
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 07:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762242992; cv=none; b=nwLVtqLNYBPYD9o/fcuVcMa83n8WdIxB6GpNuLGyHK9xmf+Xr/7RlgTZipK3ENl1frHT6agTEE3dnyWNgZJdeP1lst2IyKtMcB24+U8pAdYJrnkO2Wh4j0J9q9pg/FRuLrcOZaSN+hBPGa4eoeYEZ30d9d7HVChZBnKMFPf7Fa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762242992; c=relaxed/simple;
	bh=bHp8KyfyTgywNWuOKhm3Dq5gP74cMZKfenoZcOODGik=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=s4y6y5shFTQRvKw9owalXr6oTQisNIIWk+8fpS3ARBsv1R/92TAbvzYm8ln7LLS+pnT/HJbMKlWxoiVBlb4henSl1GdiLVmxzJRAxCgTf8xbN8igdnkoDvTWHRrufwbs+zE44FJN8vT7Bz4RlrdDSluLJWuNlwjVpHYL9GxfBzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=alQ8yu3x; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ckrPo/BE; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A43KZhY3659520
	for <linux-kernel@vger.kernel.org>; Tue, 4 Nov 2025 07:56:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	RoHRt+4t/c3tdwGEDl4fclkJI4Vp+4dj/2Y0zI28L2A=; b=alQ8yu3xJ3FjoQj+
	elCtwvIDJ3iUNC3PN/L/FeSABIfRNwwvn8bkmx7rfM1jfgRLupb8v+9BtyFUV2Tx
	vFTl0GTmiqhoZlIBm6rwRZ1t6d/BcKhqCd+Qa+4OkjVP3PhlNlmsMWljIvRKBLQB
	OqRnnRgHK9R5r2G7iy9G8HX8lO3wIlBXn14V+NZY6czmzNLow/8QHfqBUPUnL58S
	RvhWyV5BXI3pXdZXuokR2Zxeara8E+qBnROd7cFMkgbFgZG6Vytm9EC6hXTlpZNO
	+gWpjKaqeflCsORSFyPJAycroooCS12ushbEJD9cwI4aYjYV0dW9ibajqweHL7Jm
	iyoODw==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a70gea4cs-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 04 Nov 2025 07:56:30 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-340be2e9c4bso2589590a91.1
        for <linux-kernel@vger.kernel.org>; Mon, 03 Nov 2025 23:56:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762242990; x=1762847790; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RoHRt+4t/c3tdwGEDl4fclkJI4Vp+4dj/2Y0zI28L2A=;
        b=ckrPo/BE/PR9gzruwYdG4drPLVUrFnVju4xhha5eAOzGD1QhodEfrhrmFk6Of6msS+
         fIUVqCqrMHPOUTiGmq6+Gl15J/vmrGADWLEix/QtiYLcgJx1Ntwo1lAKeg28EKCffwUE
         43HtaEucUJgpFBQAYE2MEhNlw5pgXH9dUOFtoMBkREKO04gN21zptete2G27WIwRd1LX
         cpYvyZgVtzaI3xGHRMegOynZa//4ocv+F5MwK0hp6yGy+rqzBJlDXuboYs4175O/oc8z
         pku03H1acNuEmAMvdLD/yLOjHPCpWlVnHhjHfoE8/6RkgUeM1+KbWkeWQyQLhHmb+cvs
         UOYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762242990; x=1762847790;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RoHRt+4t/c3tdwGEDl4fclkJI4Vp+4dj/2Y0zI28L2A=;
        b=NSzC5Y/Sv4N9IUUWts+BPqDMz0x1ZJZdVBCrN1dZ68VEdUDcVlcpg7+jdVDUCO25/T
         2oV8P6Xi85e6z3rUyu/pF67oWxceeWoGMaZzog0svhVfcwpOJyAytDcXE3pWetUZfbtw
         MyxdlSPUTH3jmRv9ySRRTt0y5zC+t2Ki8lUNPVYPlHc/lbuW+ta6wsJEcp89G8sD4TTM
         gf0v81cpA4iilI8U5XYvbK78/tZv8+MbAiL7XlT/jbUKmEt5xBYSo/2D1eapiC6pwHgk
         351YZVXeVtbJjunxbTA2r9Qp/Vs10tz1MaqF+rGXgHaivwSs7b6ilJZeltGrtIut58ne
         6Lkg==
X-Forwarded-Encrypted: i=1; AJvYcCXckgDIqhChyA1omAiSDS9WzrYvlCcBK6LDyJr1uv5LVk6+d6iXEoEZ2YQahH8tZX4OC09fzLmFe7JC4hk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6AOMpM+1SPhlfxAaJmDQ9dCGGhGIWcl/cgiTx+zktIzHrCtEi
	48C9L+vmUivpa8TQ6a8XC9CNzGZl8ILFkCXFLt6eElz+CEMrfceGXB+l624aomz+oUx1XGJg4TO
	0RB7/w37nhGNoMn0rCXRNJ9ksYIAplvoYjx9k2jVkd+oyOOqShodnyIEuZnaVbyl6rB/fJganYL
	wQlD7S
X-Gm-Gg: ASbGncvaJoiPkthXrwV4UQVz+QG0Cbnh5Nffiein1OyK9S6yWHM/yjydGIMh7cxHtOH
	NJNgV4wTxjskrlZj+i1WQZ9j5TCPnNma4E9PyCMrbO0p0o8eEWarMVtQWtNgFSGcd751D3nuJAs
	5l25NlL2iyY8co2sCWTP4Tsy3ZcKMeKIZM2vnVOhzZzTGx8vtg79HOkK+ovA8S8Crt4outOLINY
	Ry1EQqqcTtUoAWZz6j96B1Y5HAsV0UwMKwVFQ34z7aHcuN7h+QuvBISLg9j/XgA2LeHp5JylqRp
	TPQN8TovU8t6pKhD39mktYj3R5dUE6HLYFKsCz8oh7iBDq20ziRQhnxYEe3ZVI94bPlPWWa3WWu
	7ObkZYJu1e4bp0jcQXRXGyDvpPXHBkZBXAhuoJ4g04CO12w==
X-Received: by 2002:a17:90b:2d84:b0:340:b572:3b7f with SMTP id 98e67ed59e1d1-340b5723c9emr14408692a91.20.1762242989727;
        Mon, 03 Nov 2025 23:56:29 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHblCsTh9EtWdUdTdA5S+5zt8dR4ohSG7w0SjM7q5S624Oo1ILhLcn4ytG8kX9EqOp8INvBCA==
X-Received: by 2002:a17:90b:2d84:b0:340:b572:3b7f with SMTP id 98e67ed59e1d1-340b5723c9emr14408667a91.20.1762242989235;
        Mon, 03 Nov 2025 23:56:29 -0800 (PST)
Received: from hu-qianyu-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34159a16652sm3627951a91.20.2025.11.03.23.56.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Nov 2025 23:56:28 -0800 (PST)
From: Qiang Yu <qiang.yu@oss.qualcomm.com>
Date: Mon, 03 Nov 2025 23:56:24 -0800
Subject: [PATCH v6 1/3] dt-bindings: phy: qcom,sc8280xp-qmp-pcie-phy:
 Document the Glymur QMP PCIe PHY
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251103-glymur-pcie-upstream-v6-1-18a5e0a538dc@oss.qualcomm.com>
References: <20251103-glymur-pcie-upstream-v6-0-18a5e0a538dc@oss.qualcomm.com>
In-Reply-To: <20251103-glymur-pcie-upstream-v6-0-18a5e0a538dc@oss.qualcomm.com>
To: Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Qiang Yu <qiang.yu@oss.qualcomm.com>,
        Prudhvi Yarlagadda <quic_pyarlaga@quicinc.com>,
        Wenbin Yao <wenbin.yao@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1762242987; l=1696;
 i=qiang.yu@oss.qualcomm.com; s=20250513; h=from:subject:message-id;
 bh=1mXglDsn+0xPeOIvS0urkFyaDKAG2hJUN/4wa3OAjrY=;
 b=GDVAIOjrtXgFxzq3uZDg8rQD0ct/+9J5e8bGi0lgeVcn5C6a0KNvzWvmp7eukWmwXw/i6g99h
 sLGPoRscagRDmBJWoDMGWX6jOH33rlVmLIRspi4B5THCcUdBlhNy+Ef
X-Developer-Key: i=qiang.yu@oss.qualcomm.com; a=ed25519;
 pk=Rr94t+fykoieF1ngg/bXxEfr5KoQxeXPtYxM8fBQTAI=
X-Proofpoint-ORIG-GUID: 2O02x9amhNk57UInXMw-VHIv1HKMu0yu
X-Authority-Analysis: v=2.4 cv=bqBBxUai c=1 sm=1 tr=0 ts=6909b1ae cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8
 a=prgL3jgsdPShhDvlN2UA:9 a=QEXdDO2ut3YA:10 a=uKXjsCUrEbL0IQVhDsJ9:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA0MDA2NCBTYWx0ZWRfXzpr1peQdQK1M
 bxVMzyvr4RCgr/z2HGfDuJSwMTdhJ0FkDXiowevjEERakhTrdAlgYb58p+akMTlgNEcrpx8oQnQ
 xJBG0KDxnWwHkepFLOdGY4PL/W9fFN/nr0b5W1bNN5mL1pM2J09N2miFfYstaOxLTHYLCyOViTh
 csLg/43Bs2Zx19J+BEMh1KLOpLBzhpQDrWlOiy5dsaxOeEWYK2mvMA5esQLvm+9WVvC20ux+fH6
 Zfm0gAg+p07aX27ss4OenKqq0VyJ9f6a303PQTJMPcZX0zGO5K7b1cywEKWR7dV5WaD3G6Pfq9F
 mREVkzb8y7gPein+bw2vDuDDoJU8L2xo4m/0JKeq/2pEHLZbPNYHW4/YOibFIFMsnVdLtKSlR0J
 xBn4XpmoU8rxahK3X5wyEEI90Ikkwg==
X-Proofpoint-GUID: 2O02x9amhNk57UInXMw-VHIv1HKMu0yu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-03_06,2025-11-03_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 adultscore=0 bulkscore=0 malwarescore=0
 impostorscore=0 spamscore=0 priorityscore=1501 clxscore=1015
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2511040064

From: Prudhvi Yarlagadda <quic_pyarlaga@quicinc.com>

The fifth PCIe instance on Glymur has a Gen5 4-lane PHY. Document it as a
separate compatible.

Signed-off-by: Prudhvi Yarlagadda <quic_pyarlaga@quicinc.com>
Signed-off-by: Wenbin Yao <wenbin.yao@oss.qualcomm.com>
Acked-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Qiang Yu <qiang.yu@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-pcie-phy.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-pcie-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-pcie-phy.yaml
index 9f5f9af6f6cd8373358ad7ec8303a62f006c1f95..48bd11410e8c2de664d47262b982473ee24cf09d 100644
--- a/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-pcie-phy.yaml
+++ b/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-pcie-phy.yaml
@@ -16,6 +16,7 @@ description:
 properties:
   compatible:
     enum:
+      - qcom,glymur-qmp-gen5x4-pcie-phy
       - qcom,qcs615-qmp-gen3x1-pcie-phy
       - qcom,qcs8300-qmp-gen4x2-pcie-phy
       - qcom,sa8775p-qmp-gen4x2-pcie-phy
@@ -178,6 +179,7 @@ allOf:
         compatible:
           contains:
             enum:
+              - qcom,glymur-qmp-gen5x4-pcie-phy
               - qcom,sa8775p-qmp-gen4x2-pcie-phy
               - qcom,sa8775p-qmp-gen4x4-pcie-phy
               - qcom,sc8280xp-qmp-gen3x1-pcie-phy
@@ -213,6 +215,7 @@ allOf:
         compatible:
           contains:
             enum:
+              - qcom,glymur-qmp-gen5x4-pcie-phy
               - qcom,sm8550-qmp-gen4x2-pcie-phy
               - qcom,sm8650-qmp-gen4x2-pcie-phy
               - qcom,x1e80100-qmp-gen3x2-pcie-phy

-- 
2.34.1


