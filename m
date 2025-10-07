Return-Path: <linux-kernel+bounces-843771-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CC24BC035A
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 07:45:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B058E3BE5ED
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 05:45:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7793221714;
	Tue,  7 Oct 2025 05:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="GOmEItS6"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74A1B221723
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 05:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759815909; cv=none; b=ozSzF+9V9i42RvC/hS5j6Uzx2E6/PRPnLp4GfEkgWYhpkUh7ajcMYJ6FG1xxNEKKIWCTQfaP2kUL+JobQQ05LIAL1AndgDwspme+ggMlV6oVH4l06/2sG34fCfRvwnZmuCQvpab4QJp5OmkRhBzk/HDxbFSGic2OxV8+Iqq2lOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759815909; c=relaxed/simple;
	bh=OUUu6/gerX1YHi0u5e5w1G3QfwIy6Dp/7L+64GjSvBQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jLDcpnIvJTNlN9K++pSLlB3SHABJkofy4LdlGayytmUFxnfMOYKXoA6Td+JLifKArckjlUFWMd761ULUVM9/yG3SodYhcChM9iG00EDMOPVIr3azER7SXOUFMuJgMAGhcvsOul9QD3Ev2MXPm9vl0+reS/o4yweh0qnd7pxuXSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=GOmEItS6; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5972v6g0000970
	for <linux-kernel@vger.kernel.org>; Tue, 7 Oct 2025 05:45:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=haboOX8nrE8
	6yirNHVVxZwV9MxNGuoLfRh/h1+xbQzc=; b=GOmEItS60q0mnXZxKKLGR1rw12Z
	ufyTbKzqgW0qCm/ZS7D+M29MdXZ1MXSJfAoM+PfDOKcZFa+YWY2iYheRaioqKgCX
	s+FgRVWhlWZHHQaTl7pI6K2fqvgQHwPuosTkW2brU141gmYdrRlUZI7nugjTs2Xa
	NQ+I9E0KGQgohMwLVB2qaMwrY9GUaOnMTcrgkzG24cbyIfwPJwFrCc7Ry+DWJho2
	xyBlN9JWSS5Fo/nDwDNcWvnvXzLyKSsLXbvUe3H9EZWeCDDMLo9nz6E+4Kp05plp
	fHiO4+Hye3uxhiODT3r+NsMRuas+jWUcUJvEPsKrvcpB6rlJvcddvsGAfZg==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49js9dxb5a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 07 Oct 2025 05:45:07 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-3327e438680so1114339a91.3
        for <linux-kernel@vger.kernel.org>; Mon, 06 Oct 2025 22:45:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759815907; x=1760420707;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=haboOX8nrE86yirNHVVxZwV9MxNGuoLfRh/h1+xbQzc=;
        b=T0gtbij1e0lrBbVpTeri1lGYC2FGe3sQTdEawc+hoj78PjvtEOj+pquUHDhi16PAw6
         g2lPs1RUsEBhrwTzkZYT0XZkjoFqozxl3y+cY+C8IC2MDgGlGwrkY+EYlMR/Lu7tpxuf
         /b5+1xJf45iEklDZlyBn7N/+UikXxDc6rwKcYlUry+wqT/3XukI8eUdBMXz9WDj94ZOZ
         XEjeFPhSilFIGArhtfyv8D0Gs6cJEULMDZMzmMTC9piUvl6Me8/nUdMccXx4CFe1ODrB
         GzAKB905Dijldl5eu3QP9V7rMqm/xOr9ROYsyBjaASXcVD5XSSV3EBT8YdHfC5L6WfmS
         wbnw==
X-Forwarded-Encrypted: i=1; AJvYcCXOZxijuNT9JVcvZId/w0A5dB4LcXNK84OAvXLZDNyNmqBa80TLQA+UPHmO3mnis0ozTSbq6KTNhTA6pPo=@vger.kernel.org
X-Gm-Message-State: AOJu0YymzoBCre96zgZ9rG6AfDMgRqJJYpyZkSK3jgZIqlqvipqKtjh4
	V8pmCOHOWqzyGX6Ofd0GTwkA8bTlWTMcNlYrcnjBp8BePcgh2bu469wobozpNhrEkKaX0P9TXSQ
	6igapYdnQQKpIrFvf+KNfT3Ey9D80fooXLlCWx804d7LFYQ6BS4UbFS0jhAALI5RWig==
X-Gm-Gg: ASbGncvZooTwF/o8wMW6G1x6pAfPanXwYMrAmGMHZYQaEiZTQTwyttgfAm+eFLcYzdd
	cUa1pFzt5+0mYZ2nbkTILpO3RoovIESY9xU5xEiUJvUMq309KMORDOgaSmeb0xenzfQ6Lhh3KKB
	tHCKxdy3Rz495yo8pJfhICKU0IfY7d9C1rg+oYZ+BegpgP0N+mJAje5ZuSfCvx9I/ZgFVil2ahu
	FXPt0WgmrhhEFjpqeO1x+IzLtT5m18MuQgBFg/d1D4PwofQmlpIq9LZ3jEcY9bcnDyY1PPz+NAq
	a4peTRMlRrUo1dEmos9SX17vk87jsh0n2YrTeP8onnT1OfuYMC+FxrL8ikgJcWbv9mn8ycWZDLO
	P
X-Received: by 2002:a17:90b:1b0d:b0:32b:aed4:aa1a with SMTP id 98e67ed59e1d1-339c27a2515mr9170488a91.4.1759815906703;
        Mon, 06 Oct 2025 22:45:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFKsGj2BOgSxlhze96cMSKXMXiS5pzEqDmUCSy2lI8W3FBFiISmCnIBYUBPxWKNp8p8yTm7aw==
X-Received: by 2002:a17:90b:1b0d:b0:32b:aed4:aa1a with SMTP id 98e67ed59e1d1-339c27a2515mr9170455a91.4.1759815906116;
        Mon, 06 Oct 2025 22:45:06 -0700 (PDT)
Received: from hu-sartgarg-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-339ee976b81sm502624a91.6.2025.10.06.22.45.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Oct 2025 22:45:05 -0700 (PDT)
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
Subject: [PATCH V1 1/3] dt-bindings: mmc: sdhci-msm: Add sm8750 compatible
Date: Tue,  7 Oct 2025 11:14:43 +0530
Message-Id: <20251007054445.4096630-2-sarthak.garg@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251007054445.4096630-1-sarthak.garg@oss.qualcomm.com>
References: <20251007054445.4096630-1-sarthak.garg@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=Hrl72kTS c=1 sm=1 tr=0 ts=68e4a8e3 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=x6icFKpwvdMA:10 a=EUspDBNiAAAA:8 a=CJ-gMd5DwmXuTr6oK5AA:9
 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-GUID: K126oiFZTz9EAVLmDHCC0Wyl_QWscIRQ
X-Proofpoint-ORIG-GUID: K126oiFZTz9EAVLmDHCC0Wyl_QWscIRQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA0MDAwNCBTYWx0ZWRfX5wmM8DQHcB7z
 f9kkj/8nlVMCdXnmJlWjFMcKG0SrDw7C/8cUUS4F0rx0HlFiEX3CvkR5G20YbPsAZa8yq/9xBL7
 yaFn05qI+EBabxIiXInrnNZAA131q3yosQhCNMrlB5wKJ7Thl+OkidYWE/cShD+EMk6MPqr6ZIk
 caLM5QBTn4NMXIe87CDj9OAUF9eQ0t0g4W1578+PcE2aHBeVszrTygbHKKY282pUJfOreRuhx7c
 2QZRHlKhbHdbNqr3nUEp7WsIlttDjqzfgpGaJ+Wi4SsgdiIBaIHNuGCT71a5ZnsKtvZkI83cUfD
 zv6oEA0vSKYVAU9tMsll/ilF9XhSTO1G17ktPbe/hJ13bZLn0w46O7cT49bwoCtMyZN+Uth19pc
 D7ZvmkDUEwGvwWLER4ybBptaj0dSLg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-06_07,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 phishscore=0 spamscore=0 adultscore=0 lowpriorityscore=0
 bulkscore=0 priorityscore=1501 malwarescore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2510040004

Document the compatible string for the SDHCI controller on the
sm8750 platform.

Signed-off-by: Sarthak Garg <sarthak.garg@oss.qualcomm.com>
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


