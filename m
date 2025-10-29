Return-Path: <linux-kernel+bounces-875486-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BA10C190CA
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 09:31:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 930E3355D70
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 08:31:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9171D328B52;
	Wed, 29 Oct 2025 08:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="pqPYPJAi";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Xz98l66P"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B237F320397
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 08:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761726341; cv=none; b=ljBFtWMXvuPtJ26vzYh43QJGUk/JMU/W6djlhs2xWN7OtChZOj4nQ2tfWjMGLr+LIQVBAc7/lnsbllQU58S9RfzZbIPglAw9Gy5i9I7EsCv99v99/Gl3yZS+ueoi6qXcX4LG9YjtnEjYA8rZsRSPG6HPKP2sp/vp3BpUOx4xO9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761726341; c=relaxed/simple;
	bh=w43bHQGv/zAaKHwokTSoj0q1EvK3cCGUoMxNLVzLHPE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=m3Qhu6q7h50nEcyPcQPbZDTE876Wd+prEengALjmuNndmOa/jB3txtSY0sunf54czjaD/8uCHLUAXJ5n+Z5zKP4TKkpYV11s2miq9Q6QXA6ysm+51dzjlordhq2F2EV4hRc80f1nExUfrwT3jcmsKTZuV3xzHB/4kqtPKJ36y6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=pqPYPJAi; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Xz98l66P; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59T4uuWx3692185
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 08:25:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	50Cp3I5mBMY7GPkVlH2aGvh/9PRy+BGUwsmDasOX5G0=; b=pqPYPJAiNMOoiw9G
	1rPqYQ1PkKiDKu6cjLY+e2QQeI2dRgXksuFKkHIgGb5bH5mpoWSWwOfNcdvyi5OS
	3tJoDUH9qwLdguGsvAg9U/BEFA8/J6FBz3ZgdqPzbXHcUu6QRh1mwXkI0s3JU88a
	KbZguItQZixrFRI72sERi7T2V9Q04CeXnxhIfDbkOXcO85KGZU4/jaPUjpe/sVkK
	0CkYXjzbW3ziNW+KpC3oerNJJuZb0BiwsXbyiKzTJlAsuxUYa3fHe184eYbzbSK4
	59mtEXDFW5ec07H82x6dxl8Ol1vog6DSyI17aE88pO7uocQpsR9ab2HeQVhYlcrb
	APh+xg==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a34a2hsam-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 08:25:38 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-7a43210187cso2294305b3a.3
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 01:25:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1761726338; x=1762331138; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=50Cp3I5mBMY7GPkVlH2aGvh/9PRy+BGUwsmDasOX5G0=;
        b=Xz98l66PXmW/vTQ5kCjCR1fSShVZy0Zp5YrWXGEIdEZ4Zy1OttFeKni3KFy1y0Od4w
         EM/5AfJF/uCcKpSmkomhVD/0sC21C/geZ5Vti4OATn4KqxELM+BMsakBKeVn0ymY5nuJ
         u4OTSFjXns9tP5JT8gBGywrwJJG1+/tdwM/10iO+I9HVIFSeuEE1osXe6q9m5ZSgDZ5H
         govVDr9ASx8NkiqCSgYkjjiRWCigY/5A+Z12lU0vtZ8gs3lVHqJxMUi+jtSg3EFR9dCj
         OohfN8RpqwVOsaKK2tM6iGZh4PyALtmyVNWtSms+6gtjcWI/ee75C5T4NkRy/lqYhDOF
         1c4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761726338; x=1762331138;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=50Cp3I5mBMY7GPkVlH2aGvh/9PRy+BGUwsmDasOX5G0=;
        b=rHNHkt0XUzwOSILJ7s5mQHQSV1nzaNaEP4w/21lOnJLvTmOwH3tgJXPlqqdun5+Dph
         1piwdBd7ljyVurPCvhLCx3etj+MyBbDzHj/N7bObOl/xMKaD3T1uvOVdUpEpV0wapEbn
         RMTOK9XCnTy6nvIxxzQCbOafmtapf1M1H4NwqrDI23z7WQv+C2uU7d67R2wov+UXwtgp
         STuhOj9F7CxHUeRJKleBKbTF5h1E+wNiLsDdipY2jyD4E1oufmBa6Z39MduZKI8JNlYn
         LkHUUBc/Yt0thgTHOHOkWca+IfQwwztF26C4G6nVVXJNkO1q9fNMj1VUG2QGzrYLk6xT
         gaaQ==
X-Forwarded-Encrypted: i=1; AJvYcCU7z/wzcyYM1BOZkIZPXZ7iAz8MRlR37InKfLVJWYACdu/S85p3Iz+epxw8Iic4nH/kuEH0jFW+unZH7Kg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHyGUDyllhYWNRiRlVKOWbppgBpYZPxfNW1qZ5DZDDVWPmdlYf
	5k+bVleK90MPMK6WjJ0RU1Usn1NLSHLWCKf48NkLe6I7YgJ4YuAb8CSnzh/cZ1lcRSsiJCj+DKQ
	eSB5V3NtZvlIkSwXEMuHxz/FyQ0wOaUDgGQdMaSPSIuuMKUOEfugunc+c+BJ+Jhr6x68=
X-Gm-Gg: ASbGnctQHN0dFFSh5CDB2jLCLqXR2ODedTQM21RVFO8TWb0N4alm52ZXeGtWC1hk8tG
	oqh5oya0+sa8RJkvVkJQ4++yZr96IGWxsVQSbq19w1yyZc1O5Dre5kidM4VFMYnuZp1Rgog9NAb
	d3COkGbKy4BZZUEOougDKwW+OlcYJT06792QEoQAqFwP58RnEVaLE06bMI17kcNiSooWni29FR8
	/53r3iaB4/3A/n9w0g7TYc5g5CZ88YmIllba2Z4lWVnOdzJ+vwznt+Fa1qQYDHWEIWB1CwvTkOV
	ZrgETekgocm22XirfaK4y9TspgHO5nYqYX02pSXZLbGsccMgL9Z9l9SDOSdwXpNIj8ktLh+ndYO
	9pNLLKLApsp0Gy1ZC2vWNV27SYl50eOI8rzihpfzZ7RTAka0/cQ==
X-Received: by 2002:a05:6a00:3e04:b0:7a2:76a9:9bf0 with SMTP id d2e1a72fcca58-7a4e53f47eamr2802456b3a.31.1761726337576;
        Wed, 29 Oct 2025 01:25:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEnkr279komHitpMFYSLX57z9xYrZhE70hIU2j2mahLHGOiFc3l7/MU04d5SWTk1X9QMqcI2g==
X-Received: by 2002:a05:6a00:3e04:b0:7a2:76a9:9bf0 with SMTP id d2e1a72fcca58-7a4e53f47eamr2802417b3a.31.1761726337088;
        Wed, 29 Oct 2025 01:25:37 -0700 (PDT)
Received: from hu-jingyw-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a414049a44sm14158850b3a.35.2025.10.29.01.25.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 01:25:36 -0700 (PDT)
From: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
Date: Wed, 29 Oct 2025 01:25:29 -0700
Subject: [PATCH v2 1/3] dt-bindings: crypto: qcom,prng: Document kaanapali
 RNG
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251029-knp-crypto-v2-1-b109a22da4f7@oss.qualcomm.com>
References: <20251029-knp-crypto-v2-0-b109a22da4f7@oss.qualcomm.com>
In-Reply-To: <20251029-knp-crypto-v2-0-b109a22da4f7@oss.qualcomm.com>
To: Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: aiqun.yu@oss.qualcomm.com, tingwei.zhang@oss.qualcomm.com,
        trilok.soni@oss.qualcomm.com, yijie.yang@oss.qualcomm.com,
        linux-arm-msm@vger.kernel.org, linux-crypto@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jingyi Wang <jingyi.wang@oss.qualcomm.com>,
        Gaurav Kashyap <gaurav.kashyap@oss.qualcomm.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.15-dev-99b12
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761726334; l=960;
 i=jingyi.wang@oss.qualcomm.com; s=20250911; h=from:subject:message-id;
 bh=SWFaejhCBdbBAfLWu5s/QWExunI5LAeom61uGwA2pZI=;
 b=/AvSxPMJLFyU/Dzv85BBKtBK8RgdwXpFW/pU71hx+9yFVaibNBVFOyIdTecVihUljGcx0SRv2
 KEfTegPnQopCHsl6gZ8N6fZo9GB4b9HTRGOaWh4bmEpL8/msqsHxGhx
X-Developer-Key: i=jingyi.wang@oss.qualcomm.com; a=ed25519;
 pk=PSoHZ6KbUss3IW8FPRVMHMK0Jkkr/jV347mBYJO3iLo=
X-Proofpoint-GUID: m-KZToaVJq_CDZwcNqYkrj4qj2x6dJro
X-Proofpoint-ORIG-GUID: m-KZToaVJq_CDZwcNqYkrj4qj2x6dJro
X-Authority-Analysis: v=2.4 cv=PcvyRyhd c=1 sm=1 tr=0 ts=6901cf82 cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8
 a=ou92kEv10uOBaGRFQZkA:9 a=QEXdDO2ut3YA:10 a=2VI0MkxyNR6bbpdq8BZq:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI5MDA2MSBTYWx0ZWRfXyvM8cZs8DYSJ
 ZC5iRW9FDvAshaO93ZpFuOhYqswH0j+olFiP1G6NsveQ+41euFoHGqKtjC124vJA4l+qSp34VSb
 HDy+JitZ/Y8VqxMUnRUlp3Go8J42PLd/8nhq1zkHk8RIuPhTExQTeVN1e3q4I2BDp/f8ycgBAFf
 QZpwcjm8gnDscSf3qdhlQ6rfeSstRNFB2x0vGipFEtzs6wAU+wzdtmdlkUTOrskpRRmrqS7Ha2E
 HmB1RmqnwJp83DDrFGPp0Pgx42I2rHPwP14l/sr1/I8q+IplE2kymk3a+r3O9APkm/V5SXXkTuu
 dX3AJ00H4QG12p260JXkQ+W8XA05V0DkO4RbJKmqBDfbyL/fRF7PGbOVLzul3v1RpD8xnVjRzrK
 SmKEzxzxfnakdnx0312ZiPsoa4p1AQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-29_03,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 spamscore=0 adultscore=0 priorityscore=1501
 lowpriorityscore=0 malwarescore=0 suspectscore=0 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2510290061

From: Gaurav Kashyap <gaurav.kashyap@oss.qualcomm.com>

Document kaanapali compatible for the True Random Number Generator.

Signed-off-by: Gaurav Kashyap <gaurav.kashyap@oss.qualcomm.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/crypto/qcom,prng.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/crypto/qcom,prng.yaml b/Documentation/devicetree/bindings/crypto/qcom,prng.yaml
index ed7e16bd11d3..597441d94cf1 100644
--- a/Documentation/devicetree/bindings/crypto/qcom,prng.yaml
+++ b/Documentation/devicetree/bindings/crypto/qcom,prng.yaml
@@ -20,6 +20,7 @@ properties:
               - qcom,ipq5332-trng
               - qcom,ipq5424-trng
               - qcom,ipq9574-trng
+              - qcom,kaanapali-trng
               - qcom,qcs615-trng
               - qcom,qcs8300-trng
               - qcom,sa8255p-trng

-- 
2.25.1


