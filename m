Return-Path: <linux-kernel+bounces-866822-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 12D43C00BEB
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 13:31:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 843593B0A90
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 11:30:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0D9E30EF66;
	Thu, 23 Oct 2025 11:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="iWxNJYC7"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3ED230E0F6
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 11:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761218982; cv=none; b=HSfknQ+XaUwyDPTaX5vQPmTHTWXZEkd6jrDHHmgAl+2QNJE1Ah47K8NfuQ83xpzaEyAsGPOoUCDv26qV5fQCfiUGVpwmq2Zyn7ch+cA+d9+y078cC2GNwwd1UB2xgv2RV2D5lasEXB2KUZVggptVJmfiA+uO2GdITaan8vDFXpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761218982; c=relaxed/simple;
	bh=O7f0ov9vTfLRbLjUh2RSJGZyEQmlwikWpzB+7BwXE+c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZAfKoRGFwMd1yoF0i9boYBXv8EEsPdXJCPRcp029VpFJXQNaLopkVylFbhhg7WOQ6TxXjfG3rE9oTeKm49ObTVPJpCnGQh4hx0B4Td7BZzrQwRTHtdiZ5uT9ym7mVGYhZxorU+r6fTjxrnQWTz6hcMSTWzS5pqpTC1YdeUifuEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=iWxNJYC7; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59N7nSYo019109
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 11:29:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=P8mfvs0DoXJ
	oaXO7wXqvtVIblGXbDsNop1/adqmTvLc=; b=iWxNJYC7tTJa9YL70ViGzWRPjKS
	X7PSdZTHZ6QZBwAs3ivHwJmHr+qxTsiaqCTWfivPGf55lqubw4qbxJmC6vWshHCj
	QpCmlqLze47BCy/y4m3XJB1uq7y4seAw6sp0FXrTB0pdeBjzMPGPUgVDFaHGfAKQ
	gVy6pGupVxvV9Ob6SKoVD6ogpN/PwxGuBX3q3kzLkrcQW+PW/xADfQ0UG+T9blwd
	yurVWYwTkLv9JQqxRlKe2wfBsPSOIe5QZ8pplVf7bxJDlGzWWeh7DUkAY0F4MMKH
	vHGtCefgVE9g6MwgjI9N4m9F5q20/qc2qjG8Ej5KC7Bi4ailQAubTOqxCEg==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49y67qj5ea-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 11:29:40 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-267f099ca68so1432415ad.3
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 04:29:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761218979; x=1761823779;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P8mfvs0DoXJoaXO7wXqvtVIblGXbDsNop1/adqmTvLc=;
        b=n5s2vTMSfwC8S6GeLpKHffitYCwl2ACHY7AE8FJnE5BYwFUjATzUR68gaEZW7FiEzr
         pid9WMUSk1vnbys/mLUe9Vi6k4myEzVpHmFUwcLdS34Ob/7tR1bpWX/66MLiY8XEr4Hx
         3/dCb4KbSie4oAlLz1hNAkZCDynSynbIEW2tOkQCujghAVdrxLV49xCB6Z5AuHiHfS56
         kegmKV/xEIN2UUq0/85xQXPdyjyFtb1ZqtiTxebdwB4O33IjQ1VwBtbuAfZlFZuht1oF
         BKu92iQt93aCEukyKVobeqPufhvacJBjlD2LY+pAodpTrCs3nlrunSpys9zCI+a9N1qp
         q3Og==
X-Forwarded-Encrypted: i=1; AJvYcCUtiaYz4k51BOSJqP2QCUF2Ny4XlB0AlcsOUk4xhj/FmJY8JmCLkJbc8eMMI6VM9nDDQeANJLD8OIZyLOU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUCSKItk9ZlKw/P5tXtFC5qijcVzo4ng8O4kVICICkfN89NEKz
	SAZs6ETDnLTQxOblve1hBl7U/qdxmQd/OEN+oY+7YGIre8lAw2SFxnnj3veZkEGPrp5B4FuXfNv
	YIGUTK4nE7U4lInkrns/S8OaRA48RRVnSRUolBfYq6lDmGamGcwgrdmlkIEu+0DgHSA==
X-Gm-Gg: ASbGncuDj+qotdNckloewsy0KYKllyxWdBjDjNRjy04pyRuU/+e3I/D+9ZjMkvUbsM9
	T1m+nd3QoAOc8gr6+BWqnntO7vbUXXKlqcjudYxd7ZYbZkivJME4m64xepwuS/xhTpPQnO5FqmR
	gGF88iLWtQjjPrm45U09B5AqjGDEh2ecdlSn7Yd5RvaeY6hlzJdfbO6ypApToCXsp67Jdk3+8NS
	D6P8NRVd6DNixOTTGHsD0F8z4nckKEs8zXrYMC1Q1lMro67eeBlBKmHZ8Sw6EZb2w29kn4tSLcp
	hkVmEmP3xhSIDi6LrfTqXxBmwQddVt3M1lT0QCN0NViaYWuMfOfmB3IGjfh+sow0MGzwELR1VJY
	XWHjkI9HZjV7XZ+csi9ZQTLmmbJd6aQ==
X-Received: by 2002:a17:903:3d0f:b0:274:944f:9d84 with SMTP id d9443c01a7336-290ccaccc47mr153641955ad.11.1761218979214;
        Thu, 23 Oct 2025 04:29:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEUBXBV4AbrVjLdhmtE5JO/g8t7ggle1PnMzliYfuhA5RdGXlFMPcTHhQSuRUhryEqPpDsL1g==
X-Received: by 2002:a17:903:3d0f:b0:274:944f:9d84 with SMTP id d9443c01a7336-290ccaccc47mr153641715ad.11.1761218978805;
        Thu, 23 Oct 2025 04:29:38 -0700 (PDT)
Received: from hu-sartgarg-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2946e1231b0sm20438815ad.97.2025.10.23.04.29.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Oct 2025 04:29:38 -0700 (PDT)
From: Sarthak Garg <sarthak.garg@oss.qualcomm.com>
To: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        quic_nguyenb@quicinc.com, quic_rampraka@quicinc.com,
        quic_pragalla@quicinc.com, quic_sayalil@quicinc.com,
        quic_nitirawa@quicinc.com, quic_bhaskarv@quicinc.com,
        kernel@oss.qualcomm.com, Sarthak Garg <sarthak.garg@oss.qualcomm.com>
Subject: [PATCH V2 1/4] dt-bindings: mmc: sdhci-msm: Add sm8750 compatible
Date: Thu, 23 Oct 2025 16:59:21 +0530
Message-Id: <20251023112924.1073811-2-sarthak.garg@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251023112924.1073811-1-sarthak.garg@oss.qualcomm.com>
References: <20251023112924.1073811-1-sarthak.garg@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDIyMDE2OCBTYWx0ZWRfXzQYMhT3Z8VPq
 iy1/K9/w7+LM9/oHOGL9nmNEHOjYOeaIRR60a5u3pxfkhkJppEFUEIc92MIHbXOJhwt2/XPStvh
 wufk8bP6dLQEiPwwfJXadxCXdWOwe4YTUalnlofF5+XUjztd/AABHHvTH5EchMXT7b/n8tUvytT
 DUcfZBMRLen4rTWzvZYpnrA69RkrIAW3iIgs4+DfnnwOPwXZFGcN2DAlpWe+/oa0rJWRgAN61OZ
 7+b9/XpekZKWonfdBEJzyNXWpOQePZlm1GBoyStGc8TZCxFmL6cRKrSB6BlZC5KJFYHa0tWJRKc
 BK83rx0dWES4J9GOYa76qzIFO24Rqu3iRShu3Xba+Jjg+tqtJ5BPRY3QBoJyQgqhj17OKvf08Qa
 wBTktgKHu+70Hspwjg7QZdSiIBRxzg==
X-Authority-Analysis: v=2.4 cv=LMRrgZW9 c=1 sm=1 tr=0 ts=68fa11a4 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8
 a=yU21l3sC3bVkzOeoNhsA:9 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-GUID: ypBnIva1cM56SyU6Hh-aQalQDTh1YI0K
X-Proofpoint-ORIG-GUID: ypBnIva1cM56SyU6Hh-aQalQDTh1YI0K
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-22_08,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 priorityscore=1501 impostorscore=0 phishscore=0
 bulkscore=0 malwarescore=0 adultscore=0 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510220168

Document the compatible string for the SDHCI controller on the
sm8750 platform.

Signed-off-by: Sarthak Garg <sarthak.garg@oss.qualcomm.com>
Acked-by: Rob Herring (Arm) <robh@kernel.org>
---
 Documentation/devicetree/bindings/mmc/sdhci-msm.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml b/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml
index 594bd174ff21..027011223368 100644
--- a/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml
+++ b/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml
@@ -70,6 +70,7 @@ properties:
               - qcom,sm8450-sdhci
               - qcom,sm8550-sdhci
               - qcom,sm8650-sdhci
+              - qcom,sm8750-sdhci
               - qcom,x1e80100-sdhci
           - const: qcom,sdhci-msm-v5 # for sdcc version 5.0
 
-- 
2.34.1


