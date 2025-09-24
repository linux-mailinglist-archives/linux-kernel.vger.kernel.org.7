Return-Path: <linux-kernel+bounces-831439-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6E0EB9CAAE
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 01:40:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 83A483281D9
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 23:40:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05FA02C08BF;
	Wed, 24 Sep 2025 23:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="khB5Nh+g"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58D461DB95E
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 23:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758757189; cv=none; b=K6hO+Y1LVOh56rqivwrUGiNyPJE6OrXfDCgSxrBnIQNnRunsc40XMCvwtxT9IHVvrFsw61vL8rHkZr27C7qLninxAPJleNeoiVKkoOsuqHOy53j7mGY8XeUedcciypKcSAOmf0OPUyVs6hFhpfZh+W+d7Ynt2bzaO1RWF+JJgNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758757189; c=relaxed/simple;
	bh=A0IksIjbcV0zYC0LFQhpwq6alcHDLrjcQTDZDZhCGQk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dZE+cl6uIo+heKZmpclu1jRnWvFBSdyR+t8PyNDmRSCoEy3R3GOze6HNoGoxTXS7p54QLNH4DQ+J++/iBWbe9jD1Rauj9TrTR17L24EDed4Qz2fCcPHCnPcwXeq6p+Z4KQA9IX0vPgKXlII6jkfZGeR1OEUW1T3TpPZurJTceIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=khB5Nh+g; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58OCW1M5018070
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 23:39:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	hPC1lm76vlDPdXNi79JkDIdLpoOcxK4RxJ7uEiMhDGI=; b=khB5Nh+gtJ+6IWFB
	trztuYY8qkUN7zsVBUrVNz4NskdevCUOmptVWraOUcLtUf6vT76AK7/E2Ce/LXX0
	hz03m8YH/SSTwROkY37UfV6WLmui+7lHd64mGMpB8E94QDfEHzvOriRmv1XIXPRL
	x3puyNboZ70HPcZeAYVDk9MWwtdACHzrbDPxM2gPVUFDqfiJPA9+U6RP09EVRsI4
	9JANdWHZhXyKqLpRJrVwAkd8/9/vYN0sDllN8UZjfTq24GNnEWv+uLkx+w+CT2hH
	Z+i/cdh2FDR9Cdh0LwooOnrmaZ/U0AllwRKpY3br7EpvwhpK2Bok17yCzO1OdtNV
	x4Hm6Q==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49b3kka12u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 23:39:47 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2697410e7f9so7390025ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 16:39:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758757186; x=1759361986;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hPC1lm76vlDPdXNi79JkDIdLpoOcxK4RxJ7uEiMhDGI=;
        b=ttDhAOaPpx7+c6vducTeApGu3+R9ncLDa2jX44Am966BIOsFA2QQ1dB/dsrfm/EWxn
         14+5aPg1tqplk4pwH35e160qTsedZtDrLUByJNv/UwPHGfbYy1CVC9ePEZgq6nOelN6p
         Gm49kiNcVJIjxF7/st5CjepFHiCt3+4U6Z65sWpauoC+ZjKEVHoLYdkaGsookNCJZLMX
         KSGCK3XRGwtyYmd+FkpISxR5bHd6M8LUgQUzPpsQZUcHln5t8hIZ7cnKlEVbTSkpefH9
         H2TF+uPSlIm2q4458UJw1/JZ7sy7rFZcwdWR97MB1MYT3kknTy3dF/tCthoIgCdzCOiC
         YvCA==
X-Forwarded-Encrypted: i=1; AJvYcCWzQShs66De+ezIENWT6wfXFQehshBNRXRUjy+oxtMNDseCMiWI1rKZIdGVWjCwRtll+RhuDDYT0GwAV0I=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNz7NWAqLZxFnzExDSyDxHZEjLONACXqUbMwBMC3eozslx6px0
	bnduw9fmCxfs+zVVVxwN2IoWifoI8tkC+T4qA319MX+PyeZrbSczvHQU8pIecU7aHsVMaZmFPhU
	7ToOvSfyv4bnl4o3SPCBuvvRzeMY6TNSuweVxUnEN8mR19kT+pbyjNk7fALVQNgqSKmw=
X-Gm-Gg: ASbGnctla2dClnQvoTUZWCNMPZdDBs6XS3yYhkx2BLFFwidOCuczI2s2JSBZi2u+D3Y
	BSYKpqnLDptWzsOy9OnuIhcAIU01yEQ8DDsOFsLtMfYmmdYrhtjts+6gnqODoyYBhDE3ljb8V2J
	CrC8KNw7FfXAkH7Zdfnl9DlOG9gOlVEZgWllyzbL9WwQnf4GKp3t3Z4l+x/kP7cewxZqdLtM1NZ
	vW9cc/8aTZfj0RCnYI+bhAptkmgMaFq454OcynkIAvokn/qeuJiPHRKAiPnZTFm4luRy+j804U2
	5kh9TAuqrN7eTV2h0pqsqCTPD1bGc2hbIZ+53MFTRJUl26YbVVeQioF4W4gr6NLYj7L4TP06GRI
	GnKPUwzPkTkj18CQ=
X-Received: by 2002:a17:902:c40e:b0:275:4d5d:23c5 with SMTP id d9443c01a7336-27ed49dda8fmr15255505ad.14.1758757186207;
        Wed, 24 Sep 2025 16:39:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGKPq3eUwx1CZEeKNquC21jVZ0PQXxU9D92BBNxZRWSMVH82129V619yOCTouhs8MsUysDjXw==
X-Received: by 2002:a17:902:c40e:b0:275:4d5d:23c5 with SMTP id d9443c01a7336-27ed49dda8fmr15255175ad.14.1758757185714;
        Wed, 24 Sep 2025 16:39:45 -0700 (PDT)
Received: from hu-jingyw-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-27ed66d3acfsm4610045ad.20.2025.09.24.16.39.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 16:39:45 -0700 (PDT)
From: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
Date: Wed, 24 Sep 2025 16:39:38 -0700
Subject: [PATCH 1/2] dt-bindings: dma: qcom-bam: Document crypto v6 BAM
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250924-knp-bam-v1-1-c991273ddf63@oss.qualcomm.com>
References: <20250924-knp-bam-v1-0-c991273ddf63@oss.qualcomm.com>
In-Reply-To: <20250924-knp-bam-v1-0-c991273ddf63@oss.qualcomm.com>
To: Vinod Koul <vkoul@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jingyi Wang <jingyi.wang@oss.qualcomm.com>, aiqun.yu@oss.qualcomm.com,
        tingwei.zhang@oss.qualcomm.com, trilok.soni@oss.qualcomm.com,
        yijie.yang@oss.qualcomm.com,
        Gaurav Kashyap <gaurav.kashyap@oss.qualcomm.com>
X-Mailer: b4 0.15-dev-99b12
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758757183; l=893;
 i=jingyi.wang@oss.qualcomm.com; s=20250911; h=from:subject:message-id;
 bh=lQGY04TW6hNZ4zPeN5WzUrPiJMNqGmAVWl+dWR5SKJo=;
 b=GpR2MIqO5vd4S3PaZFQjY4Fnf+ZIiYb36sfUK5UY5cGR/b97pk4ALaZpsryM2TPl94/mh6NKv
 cqYKn60G45sD59Y5ij5PVCQotxN0WLQj/4JKm2YhMufKEl3MwpTfIon
X-Developer-Key: i=jingyi.wang@oss.qualcomm.com; a=ed25519;
 pk=PSoHZ6KbUss3IW8FPRVMHMK0Jkkr/jV347mBYJO3iLo=
X-Proofpoint-GUID: RM7ZAuoRUjymy1Lfbvzvz0d7-SSwAXNA
X-Proofpoint-ORIG-GUID: RM7ZAuoRUjymy1Lfbvzvz0d7-SSwAXNA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIyMDA4OSBTYWx0ZWRfX7yeVG8n1w8tk
 mNlgxua98+TW7jaRp8NfcPg3K2KihBT51jX4BhyvrHeyXcgjIM2tZDkXHYu075Ux6TMRAHQcZhZ
 V71z9uEwQQi8wtWu6ILYEFzGOnbDquO8dUX6JsBB77mgcxcuUBL7QWhH80l86QZ7z8HsE/rnqIt
 T3V5t1zoHVOQymRl5KSV4F5bM9wdZsie3ebzKS5kQvjlzNLaZ6jd0+u9UFhEPnt+VstJncS/B6N
 Uk4dbT5DNLDQxQgQSbvOM1aK2X5DI1fi7prAsVquifuCxG7ibyr6DqOiDXKUZ5Utc9rWk1I5+TB
 CsoWCZzUiXpE7W75Mphl9PIdblglPKMFYcBuof8srn/0gpXxtNf6X3Ui0kuspavwH7iI3rOHUkS
 zyVcO3ws
X-Authority-Analysis: v=2.4 cv=BabY0qt2 c=1 sm=1 tr=0 ts=68d48143 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=s6VSgM3AptX_uwP4r18A:9
 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-24_07,2025-09-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 phishscore=0 bulkscore=0 priorityscore=1501
 adultscore=0 malwarescore=0 spamscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509220089

From: Gaurav Kashyap <gaurav.kashyap@oss.qualcomm.com>

Document the new BAM compatible which is used by
QCE (Qualcomm Crypto Engine) versions 6 and above.

Signed-off-by: Gaurav Kashyap <gaurav.kashyap@oss.qualcomm.com>
Signed-off-by: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/dma/qcom,bam-dma.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/dma/qcom,bam-dma.yaml b/Documentation/devicetree/bindings/dma/qcom,bam-dma.yaml
index 6493a6968bb4..4e5b6675af7c 100644
--- a/Documentation/devicetree/bindings/dma/qcom,bam-dma.yaml
+++ b/Documentation/devicetree/bindings/dma/qcom,bam-dma.yaml
@@ -17,6 +17,8 @@ properties:
   compatible:
     oneOf:
       - enum:
+          # Kaanapali
+          - qcom,bam-crypto-v6
           # APQ8064, IPQ8064 and MSM8960
           - qcom,bam-v1.3.0
           # MSM8974, APQ8074 and APQ8084

-- 
2.25.1


