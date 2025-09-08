Return-Path: <linux-kernel+bounces-806669-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 94F4DB49A34
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 21:40:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE8553BA4F8
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 19:40:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45B702D1932;
	Mon,  8 Sep 2025 19:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="VBiwS4b+"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3994A45945
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 19:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757360423; cv=none; b=qp3thsRcW1m9vza39iha20iIlxrhfRdlfRV/eXthgc8lAHeFxjIJ4OWnwaGoVSunGg5HIbQKIAwz7MKIsTWj2a2xsEBba3pjTFhEvgVhPOKQiR1tr42KymxcitGzFRebGvgI49qCaTi6KiGmhtelnzZO5V54nM08HPsNpt/HxWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757360423; c=relaxed/simple;
	bh=PL01mJ0RQboPDnIbyuTFQL2+JjE45/PjCXjxeBASbKU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KlTAuCEBn9Kq1Y8PWQqXqv6VpDlBrxsOuiD/zG6v8DtwCVdc0UekVMOXzvgOPW7jxxzWGp2hlr5jL4tCLe3RyKtaYsuDy8Ui/eIS2r0M/KftsS3HW2vhYZfYLoLRh7K5WpTRe2SiIDdluZ+B49hPO/UwbES/xTEDEZz8MLA5TR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=VBiwS4b+; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 588Hlfbf003713
	for <linux-kernel@vger.kernel.org>; Mon, 8 Sep 2025 19:40:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	8xCz4z0Bi/57zqJUn/Mu/aLwfF4knJr/ZgFBZ7thB9k=; b=VBiwS4b+OjjF3Nlw
	y3LEwxbipBHTmcLyVfGQ/94uFZNV6tFzJ750TXRnlYjODWL9JFYi4IeII0bXeieR
	o79zy419jWcW8QkkLG+cmJy88bZH8mxFfrfgxetSrgKO/byBFiiTGdToXcps/V6Z
	4xiouAYv4SH1ry16tDceBmyw3fjUWx29j53gT8Sr8uDWr2lC+EdT0CNIIQedD27m
	Bh+7pmrGb4MeCHWSsLKg2NKS8KFpdWjzT2BN3xlaHeNasanJ4wBVYMVYI0z0eI4N
	6ubakKTAOkPGzZ3f9MTGnMk7Gdz0eZMRS+y0iqKW4JcFPOZ2AUJor32vUAg8ZxLi
	cDSJyQ==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 490dqfwn07-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 08 Sep 2025 19:40:21 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-b4fb25c2e56so3938212a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 08 Sep 2025 12:40:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757360420; x=1757965220;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8xCz4z0Bi/57zqJUn/Mu/aLwfF4knJr/ZgFBZ7thB9k=;
        b=F8d2aOwbqICmuhhZbSG77wF2FqAgHRL9tAbEOJHQZ0I9XjurTpBApE9+Bp67DnA8BL
         66ojltS8vRPez1pEqSp1vvU12m+ARHCDPkIwFS9QmVAKtW+P0fLrgTj2LUYk4hQgTqHx
         k8ofP2daAP6kBNifFe3fiGxkATLT5oe0MTnNmdCj3qapBc82Zl62rq9wJGF06nXCem0X
         79Wrh4WhHBWiRqH2O1ZetJAx35QFnWVnKmQY34rkv9k31C363xlTseR8DvAet7D4BbhO
         WzJGK8Wj+snzyd0OC1aTN+taZcMnjsaNSnC2cjpxGtqt2LRtygruTCERtv8Lhjt2Fu00
         tMRw==
X-Forwarded-Encrypted: i=1; AJvYcCUt5p2ktwaahl6xwg3fAtzeCL4y6r/dV53Q8RjqMhXdX7AuH5EpXWWlknlyEXLSg8cYRtLsymPDlAqE/gk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVxEDC1MjdCcUbqGct3AP6vduy3nz2BM8DjikyT3mEWIHroki2
	hfIRO6hMugtTVRdeRbEdYrIlpD4dse0MUiQnSmCj1mK3p1aa5CI59hF9+Y8PSnWQJ1Y+RdcM3uA
	ChnOGX/CPL4aPc8CjabnCNJlUt28hPr52xVGb8TGPbEKWHnAQYFiBNg+XC3WPX92a2tg=
X-Gm-Gg: ASbGnctepQC5kFKhHaNsW1+0YhmA8596OiNUPN0IuNyUSL3mqkVQ1LmlUQmtxBsyIxh
	WdOob8je4smMoAvNgDpApB14n/gXp4kyxqrXvxhDVRROxIHGRKbuzpj3sGVRJwotiJmVo4rna6u
	BBC38vfCs60CURe7XU0l6sk/6gUeNFf4PStHL8UlzGdBDjCs27jEAG6mD0C9tmL1ayX2j0z2LUt
	ZIyZ49OGZlz7Yf44bF66ANuDJZf586hJw8pKRvvQ61dgABdAlfd5CDwKNUGfTFi2MLU3FCTpzvr
	9D5N6vz63yxPG4BNh17MGfGBGxztHMHUE16G/0nuP3OcUhL2gWU+jO2fn6MzH5j2
X-Received: by 2002:a17:903:19c6:b0:24c:e3d0:c802 with SMTP id d9443c01a7336-2516c896521mr130751945ad.1.1757360420223;
        Mon, 08 Sep 2025 12:40:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFxhiT37B/NGt3Wi8a3WEea6fQ9S7xmvSLYGxYBSHf3TlZTrNT5DS5LYTWCDynBV7L4xpYphw==
X-Received: by 2002:a17:903:19c6:b0:24c:e3d0:c802 with SMTP id d9443c01a7336-2516c896521mr130751545ad.1.1757360419698;
        Mon, 08 Sep 2025 12:40:19 -0700 (PDT)
Received: from hu-akhilpo-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24ced7ea5e8sm104008475ad.104.2025.09.08.12.40.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Sep 2025 12:40:19 -0700 (PDT)
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Date: Tue, 09 Sep 2025 01:09:37 +0530
Subject: [PATCH v5 2/6] dt-bindings: nvmem: qfprom: Add sa8775p compatible
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250909-a663-gpu-support-v5-2-761fa0a876bf@oss.qualcomm.com>
References: <20250909-a663-gpu-support-v5-0-761fa0a876bf@oss.qualcomm.com>
In-Reply-To: <20250909-a663-gpu-support-v5-0-761fa0a876bf@oss.qualcomm.com>
To: Sean Paul <sean@poorly.run>, Konrad Dybcio <konradybcio@kernel.org>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Connor Abbott <cwabbott0@gmail.com>,
        Srinivas Kandagatla <srini@kernel.org>,
        Rob Clark <robin.clark@oss.qualcomm.com>,
        Dmitry Baryshkov <lumag@kernel.org>
Cc: Gaurav Kohli <quic_gkohli@quicinc.com>, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Akhil P Oommen <akhilpo@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1757360399; l=928;
 i=akhilpo@oss.qualcomm.com; s=20240726; h=from:subject:message-id;
 bh=PL01mJ0RQboPDnIbyuTFQL2+JjE45/PjCXjxeBASbKU=;
 b=xzIai9+odqedIq/xKI96mip3L8PPgW/pEWse8XkWfmWni4Is3GRw6oqtePWGYVP0l1+g1CF0E
 ps5n16/F07fANl8SeSNNXsQ8HXmzVnQOiLSHTCIAfl9g3OChd1VhyDw
X-Developer-Key: i=akhilpo@oss.qualcomm.com; a=ed25519;
 pk=lmVtttSHmAUYFnJsQHX80IIRmYmXA4+CzpGcWOOsfKA=
X-Proofpoint-ORIG-GUID: BTC2j9Ld2WzH9VkYV0uweICedA8lMpf1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDAzNSBTYWx0ZWRfXzNEGqcU6tiIB
 zXXn+t85pzACUvV2X7bKJQwNMQDnjW/7YWqF7WC9zGs05hHaHOzwuskfNzzKtnLLniWc62n3MuC
 eC697HeyL2Rxdd4EqCE+gelzB43cuBOfK8LpI2Xde/qkLAqgSkQoaPD2wfi9GgVTpIMer8Jg7q2
 uae3M/8rG3qJfHppVQiv+pVhaZ16gRzLPYUbYSp5kSjFZB+6TEML+zkLUegAhLSCZELT967LAIk
 jdWAGTME7GcUoaeAgWqYoWOE0W8HZ3hg7AR6X449R+ZDGX378dJO+uROBLKUaxLlKPGzlnBucmC
 M6RQRSlesJJvUnMeOWAuZrzck/D0E7FV83apLPjV+LMHv+VcTy5oYrGhm2jRNinG/iakCOJx8JY
 B5PIjWuc
X-Proofpoint-GUID: BTC2j9Ld2WzH9VkYV0uweICedA8lMpf1
X-Authority-Analysis: v=2.4 cv=N8UpF39B c=1 sm=1 tr=0 ts=68bf3125 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8
 a=TNpnUgr77EDisZP18eEA:9 a=QEXdDO2ut3YA:10 a=bFCP_H2QrGi7Okbo017w:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-08_06,2025-09-08_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 spamscore=0 malwarescore=0 clxscore=1015 bulkscore=0
 suspectscore=0 priorityscore=1501 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509060035

Document compatible string for the QFPROM on Lemans platform.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/nvmem/qcom,qfprom.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/nvmem/qcom,qfprom.yaml b/Documentation/devicetree/bindings/nvmem/qcom,qfprom.yaml
index 3f6dc6a3a9f1adc582a28cf71414b0e9d08629ed..7d1612acca48d24c3b54c4d25fa8a210176d3bb5 100644
--- a/Documentation/devicetree/bindings/nvmem/qcom,qfprom.yaml
+++ b/Documentation/devicetree/bindings/nvmem/qcom,qfprom.yaml
@@ -39,6 +39,7 @@ properties:
           - qcom,qcs404-qfprom
           - qcom,qcs615-qfprom
           - qcom,qcs8300-qfprom
+          - qcom,sa8775p-qfprom
           - qcom,sar2130p-qfprom
           - qcom,sc7180-qfprom
           - qcom,sc7280-qfprom

-- 
2.50.1


