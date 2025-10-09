Return-Path: <linux-kernel+bounces-846308-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CF22EBC788B
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 08:20:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD55519E67EF
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 06:20:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BA1429E0E1;
	Thu,  9 Oct 2025 06:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="bWeOu28u"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0514429C323
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 06:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759990769; cv=none; b=LMGhS4BydWeGvhzusLIMND4/lTvEkTzC2BNbNrd0mnsoKZPXckTFgEQn7deHoZkd0zenOojokvm84jYB7TioKoZNBuOfez+5vmp32AEhzliPEGzf4i4TLQZZZgt3Qa8fqk9Rm2osJfQqA3dsg5jFcDiam/2SQwe6lL4S3eiglN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759990769; c=relaxed/simple;
	bh=77PWjnqFF2rxLV6vy3wMYiqtmpcFtBrBVy4hemvoz/s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eaAjTF1147vr0v1vESTt0fkeD8jl12PHnA28R/S9NAW+5G8bJGa4KIAMDX13HisJc4y5tp8JwGvklMAucBjY1W30nkGBSFI/qrm4f8CwPF4VxlG7M1z/izWv1FC2Iw9iJTXT8J5twxiCHwfsbHibXgAT1JOu3SakjxmNQZFzU2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=bWeOu28u; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5996EkW7030119
	for <linux-kernel@vger.kernel.org>; Thu, 9 Oct 2025 06:19:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	5mHh+0IDbJt3IBXVxkofwT+y+G3d2HQhb/K1OzNac/o=; b=bWeOu28unbFVp67T
	48fWFmki3S0SMJwNhZsLhPD1T0egOTL4deGeqdgBCLrLKgD6RVt1r8a6op3Igo8X
	hOnZrVn/JNr5jJug1Qzq1UKUHSfP3OcaHEUniSYQyni/p3nTG7LuTkZyRh9MCjiP
	vLX7YMWbyFpH9IdQV1eKFx0LsMZ/N/FQsEVmcH8yxsWq71Y9fBuiUhC8abR2pPmJ
	lS4UpG4JyOySLrr2KQLuhfxoA2zpEcolqxeT+iEopateXLX0zbR+TNR9ILS1raTw
	mnlWd8yDZdP/Qz2DEbn69ZlEataOsA0rRCfhpNMVFnz3DAj0ZlF2xufNZGFVqHFm
	AxmikA==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49nv4kspx4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 09 Oct 2025 06:19:27 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-336b9f3b5b0so1571482a91.3
        for <linux-kernel@vger.kernel.org>; Wed, 08 Oct 2025 23:19:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759990766; x=1760595566;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5mHh+0IDbJt3IBXVxkofwT+y+G3d2HQhb/K1OzNac/o=;
        b=eTkeOJaBokL05tmPrBxAFeD4owDN2IZmf/urkdH44MqRJroFjps9/bsX/SS+5i2Nft
         BdUfGbOKvdLgid/FMSJbnINLptIGrUqKK/d2hZe5InzgBzyFfAY6iudgN4Ri/j/9btfo
         /vok3IjtYTOMiFWN1uIyMtjkpuphu2q61be6tesFW9yA2DcE3pjrB2vhuJtJc0aWLcw8
         VZ21bSkQqfpWGUK2d+dYKYTWeOFqLXn0hKWI26Y7bpaBzgKgaf2WTqptGQ+rcs6CrzJs
         BUh6dg6tZRxLQCN9cYhah3P7WXUZ8EqxHzjm9NuaptooRxqlXHxFVtjwwYfEhOuyZucu
         EH6g==
X-Forwarded-Encrypted: i=1; AJvYcCUxVuhcLqEUbAN/YBBXj7o2WRlJGawnE8jFc6pUCrKXvnGa4FwsDqbFENR2gX280EhVeggFV2ItTdu7PrM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNuY9CI1iz5u4tNdDR9/WyyhEo1MhhQvryx0AS8erHnzX9A+yC
	s+eOEdc5eBwM4yL5+QN3puqu4qSbYzWFBVW86lWl6NYVVJ3Tv8ZZYi3ZAFjn0o0GBbQBSHwP+wN
	gS6Jf8OxtcISdDfOpNf9O4ks9tecE31h/EdLyV0S9g3dw4NHKZ2u6gYXOi98wAUs2O6c=
X-Gm-Gg: ASbGncuMScStSbFh6sPBwHqv8T34kpZsIVyJnXhloC5YonHigBUF3hvvfhp/AUL56rg
	mTDAa4m/FxJ9RtDBae7xLYdZz8OLyEqm+YSQhG/nInzYSHi5QVDSZH2lj3T+fFmJ4FkJTpFHALm
	fQX2sbyV1rFAq2TpX6JnPoWMsEs6IvYSfTsLKRuQIU1S/9VP+5b2pOSDNO17PDNpobp9VaBLm6G
	yv9nhXbmuMJdYmTm7GLUGFYmrQSIFKjHEXw8IXkejMZ2lxcyGjecmQXiA3L0ggWKLiikItrhVDw
	tEn5s4nan8peLVBM7gKdm0GhdIMqnDUJI2947B/zdQ0LaKuyKRPnbdlD01kGxosyjGFm+JoHpJ3
	5EyYrCks=
X-Received: by 2002:a17:90b:17c3:b0:335:2b86:f319 with SMTP id 98e67ed59e1d1-33b513eb68fmr8887011a91.35.1759990766336;
        Wed, 08 Oct 2025 23:19:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGGxM+/0itJtut7tU+h/gHpRdUBjLHespHKzHtM0eqWK/DO9Sdpm+LCvvpON3YUB9AzUXE2zQ==
X-Received: by 2002:a17:90b:17c3:b0:335:2b86:f319 with SMTP id 98e67ed59e1d1-33b513eb68fmr8886972a91.35.1759990765735;
        Wed, 08 Oct 2025 23:19:25 -0700 (PDT)
Received: from hu-arakshit-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b6099adbcbesm19239671a12.4.2025.10.08.23.19.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Oct 2025 23:19:25 -0700 (PDT)
From: Abhinaba Rakshit <abhinaba.rakshit@oss.qualcomm.com>
Date: Thu, 09 Oct 2025 11:48:53 +0530
Subject: [PATCH 3/5] dt-bindings: crypto: ice: document the qcs615 inline
 crypto engine
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251009-add-separate-ice-ufs-and-emmc-device-nodes-for-qcs615-platform-v1-3-2a34d8d03c72@oss.qualcomm.com>
References: <20251009-add-separate-ice-ufs-and-emmc-device-nodes-for-qcs615-platform-v1-0-2a34d8d03c72@oss.qualcomm.com>
In-Reply-To: <20251009-add-separate-ice-ufs-and-emmc-device-nodes-for-qcs615-platform-v1-0-2a34d8d03c72@oss.qualcomm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA4MDEyMSBTYWx0ZWRfXzXRr0YPhJG6o
 h3IOZ2lFd04wEfoswUC/HEOjQ26/vedkbaYKFDUwtM5ER1+7DydmLsjLXg8cgjbjIQ/I3hjtOJL
 wFOKecwx77y9VrJFA85mD0rdyp25mX/XiYlL/7BPPLzB4D1yVjvi1D28o16HrQJ+UZK6QfKof5w
 DDeIZ3wcOIIkJ7v+TSX8osDWez2GPPV4A4Pykog2l95sMt/B0H9HrSar6aCTMKacHAP1EEqLZuo
 AyZtCo519lhbWAG2Mc+XDIGW97s2fguUgbvMCl6pgTHF+J31C4C+x0Oe0hf5e0ayQrlH0Hkr3IN
 8v6LPNrjdFhFSPzTTSstcRE52seZxa0FN+Iu9LusL1Nlz7FaUELkDrBlKmoa+Gh2g4pOGkR+tm7
 v+WDxNSOohfNv2+CqUDq9StRpHLBPQ==
X-Authority-Analysis: v=2.4 cv=CbcFJbrl c=1 sm=1 tr=0 ts=68e753ef cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=EUspDBNiAAAA:8 a=0DGZwrxXYRw7ACnPEe0A:9
 a=QEXdDO2ut3YA:10 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-GUID: PtUVQFCzQFZQbmE1GQ8XkkmrySTJMky4
X-Proofpoint-ORIG-GUID: PtUVQFCzQFZQbmE1GQ8XkkmrySTJMky4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-09_01,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 malwarescore=0 spamscore=0 impostorscore=0
 lowpriorityscore=0 bulkscore=0 clxscore=1015 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510080121

Add the compatible string for QCom ICE on qcs615 SoCs.

Signed-off-by: Abhinaba Rakshit <abhinaba.rakshit@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/crypto/qcom,inline-crypto-engine.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/crypto/qcom,inline-crypto-engine.yaml b/Documentation/devicetree/bindings/crypto/qcom,inline-crypto-engine.yaml
index 88bef1d38013fc7d0e6842e370b2adb3bf3e8735..ea335d55070f0931ecf39427c59e2dfb7728cbbf 100644
--- a/Documentation/devicetree/bindings/crypto/qcom,inline-crypto-engine.yaml
+++ b/Documentation/devicetree/bindings/crypto/qcom,inline-crypto-engine.yaml
@@ -13,6 +13,7 @@ properties:
   compatible:
     items:
       - enum:
+          - qcom,qcs615-inline-crypto-engine
           - qcom,qcs8300-inline-crypto-engine
           - qcom,sa8775p-inline-crypto-engine
           - qcom,sc7180-inline-crypto-engine

-- 
2.34.1


