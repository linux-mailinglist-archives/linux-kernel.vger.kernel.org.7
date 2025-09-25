Return-Path: <linux-kernel+bounces-831628-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DF16B9D2BB
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 04:31:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 557EE4A24E6
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 02:31:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF3532E9759;
	Thu, 25 Sep 2025 02:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Pm/x9kqw"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6753C2E8E06
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 02:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758767345; cv=none; b=Bryl+zDgSCaoX+dBTjE9OdXDhFakKpJEIMiAedGq1MpHFrXWEkTehHT+0EcR2E8pSnyD6rw7Q5EHZeYnrrFGgkditKBgorJGoDdGYNrAPwR29ywS1NLjrrZmhS67woHVYmXiIV4iiEnnrFQRR5uZRd2LtwmRruw9mFq4N+ob1O0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758767345; c=relaxed/simple;
	bh=hda2Xd4Mz5OnSn10548Jx0ge0zF0dKZ+ZJ+uSDZXASE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Y9b4hYADrzqgKIKz2Xk401mwrUGprLKyY3seV7n2knyHZWeiUeyc4pntyzqaMVgmT7TfgoX9Yyi7VhvVCHJwUpJ8ns8QYIvd/WxIpnPd1FghVv7KzrQLRv3Smk8iyZtHmrE71s8zFoIkx6lZZNKM3LPCNsU3Kpd1UWpdIGxDEhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Pm/x9kqw; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58P12khG002657
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 02:29:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=DQ/0YD5xMRw
	3lWfka6oyOcJAqHz+tEBt1EbVwdyanDU=; b=Pm/x9kqwjXpeuiM+EFdZ8VP4H6E
	1Kr6LbYY4UNfgps55EkFu6Yi0SzhcW6/dABhIM1fQoEuVa4D2QQliEBoZb9Pr+3w
	D3PJl/AJxZePybRFQDRHfRhIrD+wtUGvLqIitlDV5MAhDgwekLQ4oT3Rc/njzGe2
	mMfq37HRf1LZp01RbbCnt/Fue36p+jezVTG2Bg1El09GBdTImF8OxKWvt1zMMgnf
	V6DyvFh7faCMB0GQkjGfl3lvkzG7ptYBOYHduZQkMa9T1xAUf1F5hRU6wqxqHXW+
	/kOyremgd5UuvpNdYDN2XPyhmrRXEhtzGpKG7ekk1alptfjEeJyePtIDOLg==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49bajf0yu5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 02:29:02 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-32eb2b284e4so713733a91.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 19:29:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758767342; x=1759372142;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DQ/0YD5xMRw3lWfka6oyOcJAqHz+tEBt1EbVwdyanDU=;
        b=K+5J624Mkqkv6KJNfVEZgaAAprxd09Pjt15VC0GZ0p0g2nhB5qazz3xOfzOhlRC4N+
         k37W9bUyHsCnaYe8psW1iIR61ogOm9BYv7axaZ+61/bnBkx8MMaAnYQSo0KDSbdGhBjx
         EMLVmGVYspZ6DSjZmRunF3Tt0p7Sa79IUEVH5Gwrv8FNDak24fqfs2xr12Mjy+sIfuzW
         vwTlsIWapthoqEMjmkEpDtL5ldzOc76tSd459qS41o0JtmT42GhT8aVoM789Ne2YhyLH
         OYDz1lwbT5GuKdNhjPgooFGxxpCcrjio5oNnZgtabecB06zQvvA+Z4ZipAPyOI05aXsi
         F/1A==
X-Forwarded-Encrypted: i=1; AJvYcCXHtnqrTGwXtyd68HfnSzQpY82IsobEvWmdIvZk952LGLz3gz8HoDJVUFYj6JKNYw/qpLp8DJS16R4naWc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyiGN2MrV0BEq0m6jzrQSxgg9AZL9AnpkUzDaUeF75SIUnT1IMM
	xYix5aSIkCrZr8ND2wfdhmX1Tugo2O7Q9CWKLPKs3epwY7qOjSdJ5fMY+FQ0Rl1nZIQhvtxdjRw
	LkKgh6a0cD9tmWrMMvaJqarc/RZM2O4D/plTMQDrTEcT5XP9WHpuc5stR/XpmZyRUeI0=
X-Gm-Gg: ASbGncsAOLB2IY6OByM5672UUjIDXd2zbKG52IfCW5/rXR4CfMI0ZDR1l62H0hEWSBi
	tk1TLymDR9ag2D9H43DL1QtwO0Oy9xzxhqlxXbaVTN8kBzF339sdAVFuS4dOvWqVWWCgQZvG24K
	tlZZhxXtSkcLprG07lv2eiGi2q0KATU2cWCRI7wihzWxvZp16qjPQau3IKP5P0lH95yjo5i4Z1o
	6NGg67B+7poD8n5xShyxd7oMAp4t5Y+lgcuIcSulr4GtLC3nndZ8bbVjgYL7KCpf0MILgLoAw7n
	pdD0jgnRnjsI9JG4C1r1feDwpUOkefkR4xjQiiSyMt1xaHmsV0i9PI4dbxwamcUov2L0g5vDd1Z
	asa41W0T4/JjDUY1H
X-Received: by 2002:a17:90b:384d:b0:32e:64ca:e84a with SMTP id 98e67ed59e1d1-3342a2436b8mr2376223a91.12.1758767341845;
        Wed, 24 Sep 2025 19:29:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEHa9Ej68o30zwHMqd1RYxe408/D5PXvI6i6Er/fRTSy1fm27Fjs2od49tjoO15fcRaB1IM5Q==
X-Received: by 2002:a17:90b:384d:b0:32e:64ca:e84a with SMTP id 98e67ed59e1d1-3342a2436b8mr2376195a91.12.1758767341386;
        Wed, 24 Sep 2025 19:29:01 -0700 (PDT)
Received: from hu-wcheng-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33471d711ecsm499881a91.4.2025.09.24.19.28.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 19:29:00 -0700 (PDT)
From: Wesley Cheng <wesley.cheng@oss.qualcomm.com>
To: krzk+dt@kernel.org, conor+dt@kernel.org, dmitry.baryshkov@oss.qualcomm.com,
        kishon@kernel.org, vkoul@kernel.org, gregkh@linuxfoundation.org,
        robh@kernel.org
Cc: linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Wesley Cheng <wesley.cheng@oss.qualcomm.com>
Subject: [PATCH v3 05/10] dt-bindings: phy: qcom,snps-eusb2-repeater: Add SMB2370 compatible
Date: Wed, 24 Sep 2025 19:28:45 -0700
Message-Id: <20250925022850.4133013-6-wesley.cheng@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250925022850.4133013-1-wesley.cheng@oss.qualcomm.com>
References: <20250925022850.4133013-1-wesley.cheng@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: QfgHvxSaJuAmprxrlQXhJgsRNIUA2qm4
X-Authority-Analysis: v=2.4 cv=fY2ty1QF c=1 sm=1 tr=0 ts=68d4a8ee cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=9ZGL9VZrYHwIVTkvpzsA:9
 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIyMDE2OCBTYWx0ZWRfXzhbg/0fFHaR2
 UrJWs6QcT+ZQaUfMnEFgrwDCtU6TYMVWysMXN3T7NkZO2ovsVxw84VJAr5taUV74C9rMr5WLiaY
 yAfjfNtjjEflqcE6MlfBIQqsiR3Lu4Wh6coIAvlBwhrkPxgS0dyldl3uHUeMqlkcG46vhBRcNp2
 fAbitf+n8x6MchkmWUM/QfIRwzp318pGdSqT/dOmVFU4+6PJggFe14Pvc5AZUHi44cokV/1g3BB
 YBUCJQlwe4sKSTnr2w0/U13oghMiuiwIYIsFhu1yCxEKYZMxG/EbroZnxF1uZB44ZEIJ2Jr+eKf
 N+F1g4K+MAQSl5j9clKE/PldmANhNriQqHs+V3PTc21dYq1OXDbIN2ubNB2gmEVJa1bQn2NCesk
 b93KfYa3
X-Proofpoint-ORIG-GUID: QfgHvxSaJuAmprxrlQXhJgsRNIUA2qm4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-24_07,2025-09-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 spamscore=0 adultscore=0 impostorscore=0
 phishscore=0 bulkscore=0 priorityscore=1501 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509220168

Add the compatible string for identifying a SMB2370 USB repeater device.

Signed-off-by: Wesley Cheng <wesley.cheng@oss.qualcomm.com>
---
 .../devicetree/bindings/phy/qcom,snps-eusb2-repeater.yaml        | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/phy/qcom,snps-eusb2-repeater.yaml b/Documentation/devicetree/bindings/phy/qcom,snps-eusb2-repeater.yaml
index 5bf0d6c9c025..0f015a4c2342 100644
--- a/Documentation/devicetree/bindings/phy/qcom,snps-eusb2-repeater.yaml
+++ b/Documentation/devicetree/bindings/phy/qcom,snps-eusb2-repeater.yaml
@@ -24,6 +24,7 @@ properties:
           - qcom,pm8550b-eusb2-repeater
           - qcom,pmiv0104-eusb2-repeater
           - qcom,smb2360-eusb2-repeater
+          - qcom,smb2370-eusb2-repeater
 
   reg:
     maxItems: 1

