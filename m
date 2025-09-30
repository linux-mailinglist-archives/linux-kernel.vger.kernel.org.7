Return-Path: <linux-kernel+bounces-837163-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5860BAB966
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 07:55:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 236797A7F31
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 05:53:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53727295DB8;
	Tue, 30 Sep 2025 05:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="F8t1+gf7"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0CEA280309
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 05:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759211514; cv=none; b=tb7X0ZxfTmEWa2DDuCNn9HeHCr2qgDZNut9HHepG5xmGgZm7iiXZALwsOB11rhhwqaSocgMc1o8YiYHDa//RC6KGMGowhQ0qbi4zOG2cTL9KGx1Ud7xVMp6xdQWDDYywP3Dpvrzt44xd2TgGOaTqD1sp0DswIag9f+wkfoP6MlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759211514; c=relaxed/simple;
	bh=opy6bEwniR0m7S+4M/eY23ORBb6vxUsSguJ3ntFDLtY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JCnGQcq8tnLNMdfEkzRHPf200PWmqB24r+hSQ5GwkdSmtRTJc7Xs4fEJ6hpNnU11/xy4qOa1WJMVOmC7yPDZakWvwrtZF0lEP9UDjopRi+yduZKGIhnSvhFkWxZwDsKksQdI18JRURFyqP/bAHKqoeZs6bo1KINGx/c7/s2TfFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=F8t1+gf7; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58U4HV61017574
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 05:51:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	JGAhTN0/MK7tzTuxs8B6KT3k8TvrrLVML7xGTqGXHy4=; b=F8t1+gf7Zqt6bPeW
	PUh6Z+R8qhw+F3Q6PJBiM1Qzqep492fR6RUsliAjvRSTe2p+DT8EWB4o8IoUfzbX
	ELfcAiG/BIPjRER4lCiiKrn/rvZ5PYhRIhGQZNuLn8R91AcP/cXyGNIgeWNE8dxs
	25tjE7KxvLzfYqxDxtzqOSXShqJx7BFYjQInpIVuDGGdhZoqAf162rHR6fwmzV2N
	tRj7yN6UnO2QXjePepPK4jqNlDisGllvcohoCyJlxYc2YOgHZBmJt6ZQtmItK/vi
	3/CghC8gwf4n209TuaIhRLcy5fBu6e0jYVSxDHpwXQGnoZwZoPnPNhLyTAC6FRht
	WInjUg==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49e80tqvtg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 05:51:50 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-b5516e33800so6943950a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 22:51:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759211509; x=1759816309;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JGAhTN0/MK7tzTuxs8B6KT3k8TvrrLVML7xGTqGXHy4=;
        b=PbmEwTL2jHYY+W9FxsqUgtbp5pn4ACiQgVCIiO5wX6Se8oQMpjGr1HaIPoVRXSM/qa
         uTrDZQHx9uMW1T+5uGAU/MMgtxAWaHOsU17bVx5dIWHkdncFYOk33vuyFWu4pfeZhse4
         bcSmV2Oz4N52gB5V1MRo2Ub6yRVp1ukSQz6CxBE9yMFUeb1tzyKJWHTS/iaOqxwvRM13
         keZ6mQGqf+aCOG1BVbGRp8E1aTHGF1R6lDZK7vhPjDmKFYhb6fbjx4wYtMgkmFR1SqMM
         yY19tJ0nQMkaKrtwa042/coLBEueX2OC9fRQlim1FQBMU0mNPJzna2ARjjG5ol/wC/0e
         Elmg==
X-Forwarded-Encrypted: i=1; AJvYcCV89esa2T87YbvFoucP2IkgLBRZJZpYDa8qqUaaB/ydxMfX6+wPzUdloIdZW9ThY4hiivdAAJY+M491UVM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPkge4bjdj2Oc5KkO+q1T1yiCxZwN0M+LCetW/DZJbJq/WivT9
	yTE3KXO0ADBDJrTTCSgmCuU0rqhK6IYnEkvjcnK0Prms2/Q+xdQvFkggbEKDsKrau/wZ1b4UuD0
	s/ljLQSLJyq8Tm86qi/GXpb/DHCF/ZssU8WgVxLurKFCwxOvgk3tAnrjyLYGTWW21mmc=
X-Gm-Gg: ASbGncvbhKUGhXfCrXvMt9ht05WHY6QUtAWzOhO3IaCl8TOQjyouc03vIiWxTE6W9eB
	1yetFDIAqIW1RwQFyobu7ZeUP+waLL5Qq77W7mFY8SYeE+BV3zamZ/jsWjfcGcnUB9VSq9SLGSH
	SLsr5aeljsFdEA71yKOML5ChlaWnQbFxmeoU+S/CeH4wLtjQUx+D5s1Efu1fwDFiAgUjclMT6Jq
	+DoWGh2IJOB+walYpObN8TLUSR2+TX3N15h8ZHIgXTubaNvtfx+CrvfIujUg8T2vrJ25KekdIc1
	8VqOWkmOh0jHeNaNj7FayUXWnjRS8bvwTXWoDEKxk9RUcQnFtNqjRz226CyAopK7SI8uvA==
X-Received: by 2002:a17:90b:3147:b0:32e:7bbc:bf13 with SMTP id 98e67ed59e1d1-3342a2e3881mr19323724a91.34.1759211509364;
        Mon, 29 Sep 2025 22:51:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGNHqe3cLZLc7xLZaXETZkTNHqotOqlcLKXPv0OIyQKyD1TA/j/7y3gfQe0rZdWjF2vIUaLsA==
X-Received: by 2002:a17:90b:3147:b0:32e:7bbc:bf13 with SMTP id 98e67ed59e1d1-3342a2e3881mr19323711a91.34.1759211508854;
        Mon, 29 Sep 2025 22:51:48 -0700 (PDT)
Received: from hu-akhilpo-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3341be23412sm19029779a91.20.2025.09.29.22.51.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Sep 2025 22:51:48 -0700 (PDT)
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Date: Tue, 30 Sep 2025 11:18:21 +0530
Subject: [PATCH 16/17] dt-bindings: arm-smmu: Add Kaanapali GPU SMMU
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250930-kaana-gpu-support-v1-16-73530b0700ed@oss.qualcomm.com>
References: <20250930-kaana-gpu-support-v1-0-73530b0700ed@oss.qualcomm.com>
In-Reply-To: <20250930-kaana-gpu-support-v1-0-73530b0700ed@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Sean Paul <sean@poorly.run>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Jonathan Marek <jonathan@marek.ca>,
        Jordan Crouse <jordan@cosmicpenguin.net>,
        Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        devicetree@vger.kernel.org, Akhil P Oommen <akhilpo@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1759211380; l=927;
 i=akhilpo@oss.qualcomm.com; s=20240726; h=from:subject:message-id;
 bh=opy6bEwniR0m7S+4M/eY23ORBb6vxUsSguJ3ntFDLtY=;
 b=xkyLJDhvdjtv5zH0t4R2/Ltq7yscuVczpTRjglKxHmFMzhfzxDbXmuA1k/vXF8VuGXusE56aM
 ze5RwHw81B/DIw0VoSyDnGDCDBLO1lvaar1+Yi9NLQ4Wmw4MLZC2JXb
X-Developer-Key: i=akhilpo@oss.qualcomm.com; a=ed25519;
 pk=lmVtttSHmAUYFnJsQHX80IIRmYmXA4+CzpGcWOOsfKA=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI3MDAyOSBTYWx0ZWRfX8bKbnhBz93b9
 FFHibSztIN8FFVBqWKedT7gT6HOv93DF/QFHqfy7+QVNa68B/z9HhcGiKmJTznG5gD86nuK9Pb8
 18pCbI+dUgfqUy4FflgLhVHl3jAfRl30naTEPCaIv2bTe73JT97NFuxzbMWFQGqNx8li2oUlDKT
 UZreKhLOwE7HsqSBaWIda98kzeqEXwL7Y7sRQ8T3JZq74L37G5fWThzh4BzTz3ASJlnwJj7CUCV
 AL53YL6bi3PEncTQNOFZSpT9Ap/Q/vv4Q6C9OuXvgMc/xI0Hy0d0nbn2Si3XrCFHkVc5TDMdm8f
 RU6T477FroJoRR1Z6PI3NVP2WGuGwg5/B/e5ophGPVFgC3CIrfyIC4ImsH3Z4rUD/YPrhXxLSYU
 YsgYuknV8AvIo9BZ5g+oqVgx9i30Fg==
X-Proofpoint-GUID: 9ipb8caPiSStKqcsblZ8uH_A_yqRsWA4
X-Authority-Analysis: v=2.4 cv=OMkqHCaB c=1 sm=1 tr=0 ts=68db6ff6 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=-Mh53b5kj-Vf1dIxLVYA:9
 a=QEXdDO2ut3YA:10 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-ORIG-GUID: 9ipb8caPiSStKqcsblZ8uH_A_yqRsWA4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-30_01,2025-09-29_04,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 bulkscore=0 phishscore=0 adultscore=0
 priorityscore=1501 lowpriorityscore=0 clxscore=1015 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2509150000
 definitions=main-2509270029

Update the devicetree bindings to support the gpu smmu present in
the Kaanapali chipset.

Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/iommu/arm,smmu.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
index 7b9d5507d6ccd6b845a57eeae59fe80ba75cc652..4c68e2f2c6d776d18a2a306ad67718ef7396426a 100644
--- a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
+++ b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
@@ -88,6 +88,7 @@ properties:
       - description: Qcom Adreno GPUs implementing "qcom,smmu-500" and "arm,mmu-500"
         items:
           - enum:
+              - qcom,kaanapali-smmu-500
               - qcom,qcm2290-smmu-500
               - qcom,qcs615-smmu-500
               - qcom,qcs8300-smmu-500

-- 
2.51.0


