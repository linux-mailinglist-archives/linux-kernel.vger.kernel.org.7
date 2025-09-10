Return-Path: <linux-kernel+bounces-811095-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9371EB52464
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 01:06:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E72E7A8234A
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 23:06:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50C2630C61B;
	Wed, 10 Sep 2025 23:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="VAhhB64w"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F598307AD6
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 23:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757545559; cv=none; b=NNQdecjG3Vihs9OSuEMpOAYsuEE7YOXx4vTN3etlLOq87zxtLx1iaL6PMN3RKKaWl8gN2aeEhQK855WILAujqRNJWZfAyedeL4EuvbUW0gjGOLsm39gkCLmkp4zTilAB83k9pzAKzTGjMkM3OBk8D+QMklNx/v6yft95QBu646U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757545559; c=relaxed/simple;
	bh=WRNh/zltEg5V4mPf9GD3rM9HqZDe8KQbEsnD76LvjW4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tKqutbIheNkShrr5UzvUAsVym06OpbLdWVdAGBVg4VfEl2wtdB+R7UazHQKaZr8tQQy55upfLLMkvT+8ZlteUVfP1334RnfLqOCiyBTaVUqRocUdZk9nfPgMhea+KmGaBWlQQhoNxFrE1Sb39EUl4YHKr6q6HbRJAMjuaFawsvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=VAhhB64w; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58ACgQWi003895
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 23:05:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ERzL4zTaKScfm7J3BN7ajQ+Gb4oQI6oE8fQAwSa1L2U=; b=VAhhB64w/yE0LjlB
	c8lx2AXOd/51zMQVQn4ERF7h3TAU2HdOtwEbQzYiHK9FSNceTdBsjAitceLboIbC
	mB8/LRwLn/TXN73aaOd2j9FveDXTN6iWN+3mokB2OeCeCOPZVYgSKCkmBYzWyHGF
	3zvDC6FL+Y1ObPGwagLyDlf2ybaQrCP1PkJW8C6I1+wLX1M4/UNya0VzbVze7LUG
	Pr2oSwPV0EX+jpPdj22DeMRGlS8dK1e1onxFjeuo71AZedcmzaYgHxk/4bKqw9KD
	IhSG5dHprShcbxyICFvWhZBszEA62E3AUlENeZ2VscEpkiJI7C/SJql+T6MAE7x7
	wiHY0g==
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com [209.85.167.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 490dqg5bja-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 23:05:57 +0000 (GMT)
Received: by mail-oi1-f197.google.com with SMTP id 5614622812f47-435de6eabc7so88895b6e.1
        for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 16:05:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757545556; x=1758150356;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ERzL4zTaKScfm7J3BN7ajQ+Gb4oQI6oE8fQAwSa1L2U=;
        b=Bt5mpTXyzwkwge10JQTYNAGk59AIG9fBZT00rxNGr8sHb/IbGaQRlo0qGHjWL+GU0+
         OPRGG79xnQsukaTfsgxQjcsan+4NGENjvz+Yj7eR5wvvDSV1DWhxSk7fMgdMqZY0S25h
         1bP4gDtU+0kCzuWufKUE/DOz4dNlGrNBn9NW2hRG+v1i9IcKnClnYooj3glmUCYRvCje
         r9fuWzHGMh5ewZSMy/3E4CwWbdAbGuV0KJ0VnxqiuTXGVECJpfi7BospkDk7J/LZ+fv+
         2o1Onjxz+iYtzs8rc2PYZ4CYWQ2fS+BnABggFiN0vH6c93z4h1NWG0CSDwi/cVCJAfVP
         wSmw==
X-Forwarded-Encrypted: i=1; AJvYcCVlJRq67VSYHSVMRceegFjPMLBoAAbIajuXp5mp2lm3OJAKnavHGz9UQFZyn18Afka6H0i8lVb22tPFfnI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbIAHFP2Q9m6O5p2fuPR8o4D6HQRRpqYgAqBA5uT6jMvxXXaSs
	OKkbobm2oyu7OlZ/tKL5wKPFecGo5I092UP6O/MaRzWzhuglzavgD5ty4TdDu/hu4uAeEunuwmU
	X4/hJrgdqatxYAmYdmE+7+jiu479TDrPjWFA479lB92jDqGfPhUR+IJI7bV4UNf57fXE=
X-Gm-Gg: ASbGncvWqHmvEzNedkKRzEubrfc1Nn+XrZbXmaZ1LYEt99xVaTRW+kh4Jd1CfMbpOVA
	3Ao52S6aHJjxlUtBXu3tjrpf8JS86XumBycZFbtug28vEar43yJyvKUsJGLC7yp3EPj7oVNWjLd
	n5ATm/tNouQc99FpixPc61gbDZwDmkSb0I/oaPV9Yu9IWc+ESXLsGJFglepDNZvEcVRub+3yqr9
	h1dWGmE1b3KuuKRsP8XYMR/mKVlLLAx8Bw/Ym8v8eaOSb6jRt67zDISDGGjlH05d3ry56JTSq5c
	frwcfzywN8wBe7vgwfImavgS3crIg1uU9TdpO+06St9wucndHZxoc0rktald08kzVtkaADmdtRT
	p4jptc7uBEmCvD5tz6FcFkoXAhIxJAurZ2s4v6DA=
X-Received: by 2002:a05:6808:528f:b0:438:37eb:62c7 with SMTP id 5614622812f47-43b29a5a369mr8192338b6e.21.1757545556483;
        Wed, 10 Sep 2025 16:05:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEEFrRDMnoPnBq3tCf1VgqB+Opf3jTMRrFInDKVqPyjvxQxp9MCgQH85CsiR3yQpJ/JdTq4zw==
X-Received: by 2002:a05:6808:528f:b0:438:37eb:62c7 with SMTP id 5614622812f47-43b29a5a369mr8192328b6e.21.1757545556124;
        Wed, 10 Sep 2025 16:05:56 -0700 (PDT)
Received: from [192.168.86.59] (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-43b7f1f7d63sm23944b6e.29.2025.09.10.16.05.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Sep 2025 16:05:55 -0700 (PDT)
From: Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>
Date: Wed, 10 Sep 2025 18:05:38 -0500
Subject: [PATCH 2/3] dt-bindings: arm: qcom: Add Particle Tachyon
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250910-tachyon-v1-2-5090bfd133e0@oss.qualcomm.com>
References: <20250910-tachyon-v1-0-5090bfd133e0@oss.qualcomm.com>
In-Reply-To: <20250910-tachyon-v1-0-5090bfd133e0@oss.qualcomm.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=925;
 i=bjorn.andersson@oss.qualcomm.com; h=from:subject:message-id;
 bh=WRNh/zltEg5V4mPf9GD3rM9HqZDe8KQbEsnD76LvjW4=;
 b=owEBgwJ8/ZANAwAKAQsfOT8Nma3FAcsmYgBowgRQRpuwnqgO5E6Sg8JpRzXk6vIb9uXCNsuLO
 yxI81T5sAuJAkkEAAEKADMWIQQF3gPMXzXqTwlm1SULHzk/DZmtxQUCaMIEUBUcYW5kZXJzc29u
 QGtlcm5lbC5vcmcACgkQCx85Pw2ZrcW8bw//dlxT0hmietoNNCEsBoKLfpveV2VoMc/uSwSVxUZ
 qGKv+5XSGNeqQU95Ofs5EqPsmdeb20MG6OoVte2VOqmYsUiDBnsE9B+iiE9kpm1LtQqguEeSD72
 E6Tq6Yz4CNBP/BGZX7S4mcbdgo2Krb+2pxi5QOplbH96WvfbIhBVK1cmWf/wJSEOAnHrrD5dK4M
 CjboQhXTKItr9XoiudXPqmaLqUtNHqAsBEz4onY7qKY3rGFYhQx/3Hpr+7q3CRD2Z7/F7wVIaZl
 s6YkN9qW0n2IOptlpybufqqgjGWDK7EcRrjIbQ0o5WGKpY+KM5+vx/8ndbPCsarFcwBsVdE3rR5
 MHI+RbGIsZpjsIBGuVUJXw90Devk2s4XoYut8C7igAw6FLyq1FN2CoiLgkb9tUqrdBaH7WiuhDJ
 YRyPEkyM3rz14orqsxZX20QHhThKfzgxyeCnZUr7cBsPGb2lSHoUu1tCxVUbxOyljsOQi2rwtYk
 RNJNS2LSpf9FMkSI6Hyeoq77G4I1atFXb4pDCs1lpEJ/VOTwG0WQd9waeSKAlHvrjyy0hdD6EyS
 aEx5YuDt8phQncV/ZnyEvnYPj5hOgaS87Ir6b5Wo3cCcDMD+vD1nHLUjhf8NUVUs6vbH5O/seVV
 13b6lgFt2A4w73u4dpxzYghKZu9ZuEj/FShb3j/a4JqM=
X-Developer-Key: i=bjorn.andersson@oss.qualcomm.com; a=openpgp;
 fpr=05DE03CC5F35EA4F0966D5250B1F393F0D99ADC5
X-Proofpoint-ORIG-GUID: -tTTS2m5pIgeTv6k0tvK-YqnSWmecyvz
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDAzNSBTYWx0ZWRfX+pFIKq1vWtjw
 P+u4pFNqTHvHORJdkGBDq5WgPRlVxbfjnlmDO6LQZB+PzkEi6ZCcAXf4wIHWMYDJZDbdzhp8y2g
 CboMOJxPSqUyAkKliLt0x1s1ErZk624oVTdA8fLClQiNNekmhKcq/LJW+mrHnUAOfmSoQ/7jhgw
 6Hh9Iet0GMiy603wHzC6Voafj/lhzfF7ysWfHjw8baVSagqtCceSQOvXcnfRSnxxW5kEo6XuIpp
 Dtn3kvqCEdvDHJucYyTloktwv1LaffFn6DgsArY20qUuB0UJLq1NSdQbagnMRDPQHvMDs2w2HdY
 8BEyFPH8kNrKiBtqwdjbZTdC4PtYaOnx/QC2weOwGpQso6hcN/avnjJrNaUhwGwHJu7N28+0wP4
 SF7NKTHL
X-Proofpoint-GUID: -tTTS2m5pIgeTv6k0tvK-YqnSWmecyvz
X-Authority-Analysis: v=2.4 cv=N8UpF39B c=1 sm=1 tr=0 ts=68c20455 cx=c_pps
 a=WJcna6AvsNCxL/DJwPP1KA==:117 a=DaeiM5VmU20ml6RIjrOvYw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=Dkwbal4DzCgJGMwAlbYA:9
 a=QEXdDO2ut3YA:10 a=_Y9Zt4tPzoBS9L09Snn2:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-10_04,2025-09-10_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 spamscore=0 malwarescore=0 clxscore=1015 bulkscore=0
 suspectscore=0 priorityscore=1501 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509060035

The Particle Tachyon is a single board computer with 5G connectivity
with AI accelerator, based on the Qualcomm QCM6490 platform.

Document the top-level compatible for this board.

Signed-off-by: Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/arm/qcom.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
index 0a3222d6f3686f1647b9e2ea192c175b0b96d48a..8e0b42ad65607abe687a0bcc5310df264e14157b 100644
--- a/Documentation/devicetree/bindings/arm/qcom.yaml
+++ b/Documentation/devicetree/bindings/arm/qcom.yaml
@@ -337,6 +337,7 @@ properties:
       - items:
           - enum:
               - fairphone,fp5
+              - particle,tachyon
               - qcom,qcm6490-idp
               - qcom,qcs6490-rb3gen2
               - shift,otter

-- 
2.51.0


