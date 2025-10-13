Return-Path: <linux-kernel+bounces-849845-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DB0DFBD1114
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 03:14:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 02D241893F4D
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 01:14:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14EC8203710;
	Mon, 13 Oct 2025 01:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="gQGuRgAr"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B589F52F88
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 01:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760318054; cv=none; b=IhdidY00dBuSOWXC1AOB00+oJxuJ295PJjQKQDKIRP8G33CdSaXBxEk29VH0vj0kybCSVG1mr7mMyl+lGC7yO1SczSUWtS5JkzSKufAGcK9LtUvkZPEBiFJ7yfPozob5SkK8GANwFqr6EfRq9cwby9Mj13uPSCy3lf3iEq+we5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760318054; c=relaxed/simple;
	bh=vYTNGVpJqfVNWqTFnghL5MAMhtBYnTD2XCWEwdgn2To=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=LXZlM5geGFRpeSZ/+B3SR0lLfD8gWPIkuRyhFAayfmcb8e1FK6KHd96JKCbXAUUtwpTk7Vd2fyMXzSB1Vdx/iopKA5I0oex0W6OuBihIif+9JBKjMB7uwtvK2kX4a2BHbW2WdiogVr3sGy2hj9QndY/LUWkdCORVw37YaFByf+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=gQGuRgAr; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59CMx2Vm030228
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 01:14:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=vK+SJgwnOTEZYAlMkPB/qihU7mC9Y5KP7ce
	r6c8Azng=; b=gQGuRgAr0p8shwpEcS1em5PgCzaRp7SDskDjDsJRc7IgOj83lGS
	xZ1YUXq73s254/R5Anbp2PwBB8lWyQGUzLZXRi1A3kilMkJEIiqcmf2Wfw7/b9TY
	qXSc3pv29gdT6dPlQix0h3b8/uwcWe3EjPHdS5sYk+aKhc+9srfqSvc+bPfCPLBh
	wO0t4Z9b2JwjVVpk6MGbCfzTC47o39aWnZu/lyb8whnYzzNIsdiuJUFUk4cakj/r
	gfzl+1wX1DxDyhEiCK/PUshUBjSqdcXGd7nMw22kRzoLm26ymfK4ZbBwCqIJXa80
	mi7q31M+i9t5zRtuoWJL/MNvj2MdI6uP6ZA==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49qfertuhh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 01:14:10 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-b4c72281674so5854965a12.3
        for <linux-kernel@vger.kernel.org>; Sun, 12 Oct 2025 18:14:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760318049; x=1760922849;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vK+SJgwnOTEZYAlMkPB/qihU7mC9Y5KP7cer6c8Azng=;
        b=G8jdiUK1XGEwU0yNBAoCwSGBkaws1zBiz5sUt0dRdHXpw1vW8kZvHtKGU4KIF7clUJ
         BhX+TFgo127QvgIBjCwpdBuFwZMzISyURm9jxClXeQarBbaKKwy4+RR3OZgU5B1j48Z2
         iX97EHbSGBf+RnBLw/M/lVXnlZmWOHFWzCTnEq+imk80V7uq/pqCwZw69NU803SBn0A/
         mBavZ6dbHeCdAslOpgVM/Fdt3nnKZX4QWw/OUQ2DELadOqoIQgODN++Sgr+eCjRnzivO
         m6DyN4PdOpMNMb7181xKHiz+AUb3kYC5u3RBhMFxuTjCI8t7FL8SGCgn7UCNTWL0dhD3
         fN+A==
X-Forwarded-Encrypted: i=1; AJvYcCViCOu95E4WIEmxT040m8mtSInbz7p6Cr9rDYW2XAN1uJZuSbH6MNcWi7qbRVImf0vCcMUE7VvzTNLziKo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzH29uRz0xtwwAg/FU0bjOOIN5v9A+aGTyGfub6+UXUyWMp+ON9
	HeNfEcF+Z1UHNoPNgq3q4fW053pGBnguzgefrBExWJU0SEYCd7RzGEbnP0oxzhR0pyXRPUgDAY6
	R68fN8+daf41pfE5xbQzZRCUQY/X8EaIaAlMV4dihAscWatqgnJdKKtgFSZpVIH4rT9o=
X-Gm-Gg: ASbGncsoOeJUCp9YNBRKioSq4RxEXkE1qDAvSE2xbESLeSJ08H9cQqN49ZkkKawnjs1
	nZeD7PyhKpRRdJYu5kO0qsPRHJb1xzJTX4aHNqE5dhZalMyrSV6uEYywMbevmMjWbCkyO0+myjk
	Cllu2aEfLQbvSrAtQkpsqr1FDYAkgX1qgHEaH1+ADGtRxB73nBa1l9iIwlAsWQlMdrxOW5JHgBK
	uNNzvCwIwEiOL0w3ctlo/xtTmeuoqbo/USWlkQjztRflFZN+VdHdI6nw5bgJ9JEyPOdFKD+nfDP
	q5qk+K5kG8LQr7XnuDilm5QXjHiqNPlA3tqoFI7qCEGPNKsj83I/kHU1E56F3V1hT8POzsn4BO+
	Gtg==
X-Received: by 2002:a05:6a21:4843:b0:32d:b925:246e with SMTP id adf61e73a8af0-32db9254d9cmr17513630637.43.1760318048826;
        Sun, 12 Oct 2025 18:14:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG2QXwY3MOrK4ad1ja2OEJVP5yyAqc35NeoeynehrZkJOMLTtorm2RzOTEzGNzwKQ3z/GLTDQ==
X-Received: by 2002:a05:6a21:4843:b0:32d:b925:246e with SMTP id adf61e73a8af0-32db9254d9cmr17513603637.43.1760318048362;
        Sun, 12 Oct 2025 18:14:08 -0700 (PDT)
Received: from hu-kriskura-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7992bb11ca0sm9672647b3a.32.2025.10.12.18.14.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Oct 2025 18:14:07 -0700 (PDT)
From: Krishna Kurapati <krishna.kurapati@oss.qualcomm.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Wesley Cheng <wesley.cheng@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Krishna Kurapati <krishna.kurapati@oss.qualcomm.com>
Subject: [PATCH] dt-bindings: usb: qcom,snps-dwc3: Fix bindings for X1E80100
Date: Mon, 13 Oct 2025 06:43:57 +0530
Message-Id: <20251013011357.732151-1-krishna.kurapati@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=R64O2NRX c=1 sm=1 tr=0 ts=68ec5262 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=x6icFKpwvdMA:10 a=EUspDBNiAAAA:8 a=QltsTdpWXtN-n1SMwaMA:9
 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-GUID: 2qGuCU5kAwKY35RM4eY2hBoDvSxKFgnH
X-Proofpoint-ORIG-GUID: 2qGuCU5kAwKY35RM4eY2hBoDvSxKFgnH
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAxOCBTYWx0ZWRfX7tu0KSpXoUKS
 xG45+GG8i7BY3EHLOdLKeldP+J7DKzulShpNoNvCSezVhLssjSf19nYw+nAzkz3M3MzRWceilc4
 xgGiKfU2lE8zBaFGT5QRQ5ntbrAMh8Hhobu3X19bUCIvZO1exrOy3XNor9iCLp1cV8ICpViqvkR
 ysoBZZZyQNgNm1y/JDKDtJoFSAzhktZIy1GJCbN/MSeO2xl/GocyRFkk/n0UteIr+f/1mfMqCGP
 Hxvd6ephg+qPZDxvTK1Z1nF9Rsbbn1zXXil8p4eeCI/A6ngTz5d/cDE2YHT8dpWKYtWb6s8Bcd4
 fz/4ovMBXQubc3OK0pDLkB89lUSDa5HdgAKPEwvycDHt+p1jI3uZlXfMmcCyRyTupB9eRw1v7ZG
 X9iLEaL2rN9t566xGVpSi9hKGy9fAA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-13_01,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 lowpriorityscore=0
 priorityscore=1501 malwarescore=0 adultscore=0 impostorscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510110018

Add the missing multiport controller binding to target list.

Fix minItems for interrupt-names to avoid the following error on High
Speed controller:

usb@a200000: interrupt-names: ['dwc_usb3', 'pwr_event',
'dp_hs_phy_irq', 'dm_hs_phy_irq'] is too short

Signed-off-by: Krishna Kurapati <krishna.kurapati@oss.qualcomm.com>
---
The above issues were found when effort was being put in to
flatten usb controller nodes on X1E80100.

 Documentation/devicetree/bindings/usb/qcom,snps-dwc3.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/usb/qcom,snps-dwc3.yaml b/Documentation/devicetree/bindings/usb/qcom,snps-dwc3.yaml
index dfd084ed9024..d49a58d5478f 100644
--- a/Documentation/devicetree/bindings/usb/qcom,snps-dwc3.yaml
+++ b/Documentation/devicetree/bindings/usb/qcom,snps-dwc3.yaml
@@ -68,6 +68,7 @@ properties:
           - qcom,sm8550-dwc3
           - qcom,sm8650-dwc3
           - qcom,x1e80100-dwc3
+          - qcom,x1e80100-dwc3-mp
       - const: qcom,snps-dwc3
 
   reg:
@@ -460,8 +461,10 @@ allOf:
     then:
       properties:
         interrupts:
+          minItems: 4
           maxItems: 5
         interrupt-names:
+          minItems: 4
           items:
             - const: dwc_usb3
             - const: pwr_event
-- 
2.34.1


