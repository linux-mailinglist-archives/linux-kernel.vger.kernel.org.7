Return-Path: <linux-kernel+bounces-831436-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B355B9CA87
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 01:39:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D760542061E
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 23:39:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69E022D2382;
	Wed, 24 Sep 2025 23:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="EKlGrUgs"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC4022C159F
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 23:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758757118; cv=none; b=Ts+gyBhjT5tK2fti5NDNJTg7CW7II5ilqIo9wmh2CYF1ljXgQtlOq5cDTZ9TKhfteOgU0qCH41gTy4UXKaxL/3WP7nXOxb8HHWZMFlGRW0h3tCO03eAaYgIHglAVLpexa3biyQV49T9KKSFy25FbpUF/8JLk8VBI5xlHjZidMoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758757118; c=relaxed/simple;
	bh=F4znCHDFQQeryr3RxZUYIcYiRyQiALWXHxg8m2aMkAg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=h9o423XIKB6hOe2ET3OL6n872HTgMWE48VxuHZ2VvedxNVtvmhkk0DsHMFpPR7h6mKGvEI4TnEbJhY20K2SSPyoMGyQ7EAYgVPGkEdBsAo6z2VZ5zW6f69lrjBfz4zp0ww/lNwF69pTIJmiSQtVvvGZzuU0xc6FvIF1JmC9e79o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=EKlGrUgs; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58OD5hpt029706
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 23:38:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	s1aAF5rSae6ugXFLKlzHjE8diZkKaXKz4SQv2iuHKzA=; b=EKlGrUgsuL2NYpqh
	SvYmz6GzHcrZ1hZUFZyooBpPwX+qabuwHGLHk7BD201WmuCHgGszrxYAs/aRkTij
	vXxVYgd97fG9dBPpwrBdJxyufWeCd0Ql2C391gOHUm5QjX/SyCExiz+zmgLey5EL
	wqJegkq6TZqLDVCEl2uz3beCuDOlz6xi2CLP0dmiFN4UQUjhH/i3kxG7hp2M/9wU
	4doL5vu7Uik8DpeN++LhSVMJOkj2zmx+R0ZCQp/xyfN0xeR9ias71GQvNVpd+N/A
	PADkNnqvOvD5mfBBpmQScsFZsyNSbAB69RiPzOAMLHJ9VE0OE88SRerbkDZxQK51
	Zy5WFA==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 499n1fnxd9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 23:38:36 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-77df7f0d7a3so324336b3a.2
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 16:38:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758757115; x=1759361915;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s1aAF5rSae6ugXFLKlzHjE8diZkKaXKz4SQv2iuHKzA=;
        b=q+EPcf2UGeWvq9aY3u0pLwS68z4xCwCIMvleCduZZ9HztNrSFoQUSBdxtraMeHZCq/
         a/tqZdJl4OaYbv2vB5y7Adx7RV9qNKObJ86iHoTE5gtBSPcksQeJSt7hRHRI5jBOTSey
         MURct9izh3KWSjMOv9ULdR9aNobtB2/cuqTCygmeogEdWLOj1bPiL3G7+mS+ZT789JU3
         Py9HRgrEIg7bt+taDqJ2jzVzFCb46H+X6Zk3ZWnyAIgTlM3Ywn70Md8C8TpNemlA7nIe
         7duGQDjQ8xhufz+48yeKS2+PJUiTNqdjv7fOVnw4DHme/a8CmF9Yk65DJXS9Au1KKgud
         YrRg==
X-Forwarded-Encrypted: i=1; AJvYcCWM71Lf+PBmsFwfwVPpCHgosvpUUiogJCDowbfJuxv/dQ2Q4oE8Qu8SXP9oldJxnF62z1xke8JpqeuvEtc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4C3M/CURGP6/TF11OfvRF1CKRQ/+J3S13nEpA60LurybM6FBV
	1HHBezwSNyhl+L8F9kHdSehzMswbsHmaPgK2oEBmWBSctDnpChZfwDpNtvnKDujuUnRqgjS4pF3
	C6I3Uw+RwkW3Nc9Q/0sNBijWoyhCGufoqOzb1jU+wRtT0XCI19OucZWUSSH+DADRr2JM=
X-Gm-Gg: ASbGncvEUyvgqRt3ulommRM8VAkEgy2T0dIVDakW1LNxfn1UY5sEIBfEKaJvEOK7oyM
	bi1bS09GcX91Nxje9Yjqs4369g8oKwbJyxLl+tomrwtTP31/g7idMyZlB5fVZIj6x0orNvssNqX
	kUnZ2ciUKWctVyG6iX/Me0PVpMG2fgivVBAdAaR+091cYnwrmGUxAOdH8lnPakldw7p4TdXWVK5
	zVpq76Qog3zebuL9Y3XbRYLbRECfvfeJ3hAtuc9cuiqn1/Gv5MvraxFSKuylhH5/h7apEL5Sz0t
	kfLjy0L0hU0nM3qDQ/P5Um9ghUbjc+LbczJpCTuQif+rFy5cAoaCGenF+pPCnLq4NoqE4v/otWp
	8M7fbb83M+ywY544=
X-Received: by 2002:a05:6a00:189a:b0:774:1be4:dced with SMTP id d2e1a72fcca58-780fce3b007mr1898899b3a.9.1758757115278;
        Wed, 24 Sep 2025 16:38:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEnsto4a+iHjLgM5EoL764lndboVFQuG4IWUK0ulnCQHO170g5R+E0rOP+YBHKKmKYAzn5PBQ==
X-Received: by 2002:a05:6a00:189a:b0:774:1be4:dced with SMTP id d2e1a72fcca58-780fce3b007mr1898871b3a.9.1758757114853;
        Wed, 24 Sep 2025 16:38:34 -0700 (PDT)
Received: from hu-jingyw-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-78102c0709csm177056b3a.81.2025.09.24.16.38.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 16:38:34 -0700 (PDT)
From: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
Date: Wed, 24 Sep 2025 16:38:28 -0700
Subject: [PATCH 2/3] dt-bindings: crypto: qcom-qce: Document the kaanapli
 crypto engine
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250924-knp-crypto-v1-2-49af17a231b7@oss.qualcomm.com>
References: <20250924-knp-crypto-v1-0-49af17a231b7@oss.qualcomm.com>
In-Reply-To: <20250924-knp-crypto-v1-0-49af17a231b7@oss.qualcomm.com>
To: Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-crypto@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jingyi Wang <jingyi.wang@oss.qualcomm.com>, aiqun.yu@oss.qualcomm.com,
        tingwei.zhang@oss.qualcomm.com, trilok.soni@oss.qualcomm.com,
        yijie.yang@oss.qualcomm.com,
        Gaurav Kashyap <gaurav.kashyap@oss.qualcomm.com>
X-Mailer: b4 0.15-dev-99b12
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758757110; l=802;
 i=jingyi.wang@oss.qualcomm.com; s=20250911; h=from:subject:message-id;
 bh=Hs3MTutgTJMawPo10U1qCQaD7MHAVehm01p62n0kfL8=;
 b=1gRerEIHxFVQS8l19SgcIoNEiqA21x8U0jVM6V4Io83OoBFbdquBSV9NqGkCzEXQSZeAoF6Rc
 zJY2EBu2MVeBvIT9IUqQDrFZuvdNtqq22VoIwgQi+q7PZP5lueXI401
X-Developer-Key: i=jingyi.wang@oss.qualcomm.com; a=ed25519;
 pk=PSoHZ6KbUss3IW8FPRVMHMK0Jkkr/jV347mBYJO3iLo=
X-Proofpoint-ORIG-GUID: RofvlRcWBWnpDJi31zm541r6RufKdTQ0
X-Proofpoint-GUID: RofvlRcWBWnpDJi31zm541r6RufKdTQ0
X-Authority-Analysis: v=2.4 cv=No/Rc9dJ c=1 sm=1 tr=0 ts=68d480fc cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=UTvf6Pk5Os8-KCCN1KUA:9
 a=QEXdDO2ut3YA:10 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIwMDAzNyBTYWx0ZWRfXx7uQ3egDJLT8
 zvMkW4nmbOzwgLFUL5e7WMfWKlIugQ3UQ/yTUkyBfiF7w/C7Ss+K9te48yT6qYoUVHE6rRi1jmm
 8dSRzqKRWCPkosFBDHGVeBJSM9TJTdPofnK+vohNZ6IhXolpj9I9YH2OqI+HeBsVfPFPh6lunun
 vWbrZUtKyoqUfMwqf1AIwpRGaSr3k9PmePmiLeHzT417UT6sUz8UKKpobSwLtDDYRyoj2MmV1v6
 sVUaKY4E6C8Ho/hlBfeXwXLUWuYkf6NBoGt+HOdmmO6LMgDGyxSAv8Akc0YVCa7kGpB2X2kfntV
 fIqEY1oKcb3ORnEIg6D64FKjFVmtNBnjO9GblV9Zpwu3QyLoshxkcRWjOkIL4I/VpY+ye7zUmOW
 4ULerLxE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-24_07,2025-09-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 suspectscore=0 adultscore=0 malwarescore=0
 phishscore=0 bulkscore=0 priorityscore=1501 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509200037

From: Gaurav Kashyap <gaurav.kashyap@oss.qualcomm.com>

Document the crypto engine on the kaanapali platform.

Signed-off-by: Gaurav Kashyap <gaurav.kashyap@oss.qualcomm.com>
Signed-off-by: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/crypto/qcom-qce.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/crypto/qcom-qce.yaml b/Documentation/devicetree/bindings/crypto/qcom-qce.yaml
index e009cb712fb8..79d5be2548bc 100644
--- a/Documentation/devicetree/bindings/crypto/qcom-qce.yaml
+++ b/Documentation/devicetree/bindings/crypto/qcom-qce.yaml
@@ -45,6 +45,7 @@ properties:
 
       - items:
           - enum:
+              - qcom,kaanapali-qce
               - qcom,qcs615-qce
               - qcom,qcs8300-qce
               - qcom,sa8775p-qce

-- 
2.25.1


