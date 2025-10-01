Return-Path: <linux-kernel+bounces-839570-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FF16BB1ECA
	for <lists+linux-kernel@lfdr.de>; Thu, 02 Oct 2025 00:07:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 40B867B1D4F
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 22:05:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA3CC31329F;
	Wed,  1 Oct 2025 22:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="m8PBNmo3"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 363E43128B6
	for <linux-kernel@vger.kernel.org>; Wed,  1 Oct 2025 22:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759356348; cv=none; b=acYfFO9go+PxfKpjzJt0r7XgwAaIbeV7y04WodpjpHOOoHzfaSoe28lxzHwKyIZXXsbovlWHu6swDhBZAYP35od5jjPZ80F03CkzYbxQ+CfgAcS6tCAlDTL83vFgM4wdQprfVunvRwr5q/rLxEFtzSXpSADbYqhvjOWvMcTAI68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759356348; c=relaxed/simple;
	bh=hda2Xd4Mz5OnSn10548Jx0ge0zF0dKZ+ZJ+uSDZXASE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=daCiS5J43QUXOD/b/f4bd3qRhyZxwRioiTiigZFzGmBQAz0dxDsu7zlZXpNOynIJn+becQYPooL80fBBhDp5s0MTbB0+may5RMYkH0jllZzJ14YJ6eSNkn3uh2RFLaqY3Hr1TLqFrN3VDsUzn01BBMD27e1KstEg9T6UDXeVGsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=m8PBNmo3; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 591IcGCM005988
	for <linux-kernel@vger.kernel.org>; Wed, 1 Oct 2025 22:05:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=DQ/0YD5xMRw
	3lWfka6oyOcJAqHz+tEBt1EbVwdyanDU=; b=m8PBNmo3eyDlXQAQxCYjNuc89IY
	dD4Y7iU5etjHZ6eSWWUsyRRMfSqwJ58XwUkvnPFiGNVJGUGDzrXs184yad/JR7Rh
	CCBPHSqnjTiTooIOt0Usk85xKZH+tvR7Hb2UUSfSOJ6TZdAaxUuYUY9nZDJlCgxi
	a9AfzDqMcvO0NC4ItA5eXfqFefjN0OJIM3vzMwxETCpp2A+Bfk9beXEH4tCZNTyU
	Yuxbp/pXm5OMGWsbOnRkOGesog96sX24Ae7fTExvLMcqYtOgbAW+OHKLLrtfy0vd
	KdURq7l2Mcu2pm5whproNNbPEXelBSLXr9UJ8vjPJRvIwRyCOdueAvLaGuw==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49e851p0pr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 01 Oct 2025 22:05:45 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-32ee4998c50so305632a91.3
        for <linux-kernel@vger.kernel.org>; Wed, 01 Oct 2025 15:05:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759356344; x=1759961144;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DQ/0YD5xMRw3lWfka6oyOcJAqHz+tEBt1EbVwdyanDU=;
        b=nDpevGu1vySrQpV7+4JExyHpEFYORTNeeYy+N/+R5uA84EYoesGER64HDK9p/nwq7c
         0C8pTRvhi2KBXe5Vk+jb5Q6vKZbkzG7xAqvNS8wlpzIeFGQh5cEqT1fhMVVBnibBF5Kt
         vMMOitwAK9e8EzExQaAA5lBP9oZxk1LUoxKwTx6JRDjYNUFU/TEOtNrtd6ZXNRlGFGEq
         zHFvTtrZFnn9Zndag0YYME8zN6Sz4vi+Ekx0tZz/A0d6FshT+r8Y2sePzE3Kvj1OnBj2
         vsRf9pS3d4uKwCAj6zkWBQrE2+Fm7p3FjMZFNvp71+vP1/4eIMe2N5Vse8akNsIx5+H0
         7eLg==
X-Forwarded-Encrypted: i=1; AJvYcCVHD6eYHPkJczcsHY8NFdFadXPtnPJ9U6D6fTCuEMgpigR3Ov6PhO7BkthAxqX6z9B8YH7Vf5Dh7VZDMWU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzgxUzRmeMmGQt3loPv46j+DqkSTBxxcQd7m6k80O/Wnx/7m3WY
	xRKLjo9rAu2dJEgD6HEevQcrCXZyz/Hf5OBWIHPwqAuL6LB8nvKUXbpMdtcYujMSYhDc4B5gQNo
	5pe4o3FdrMrYuI5frp6aoeoxLeUwHV/YIAXWrC/3B7B3d36eTaviJGcIqUzr8td83vTo=
X-Gm-Gg: ASbGnctp95M/MkIwAqw4EiE8G1v8nr4YJ9oPuFJB38neyIUB4fxaFHdycrSMVaeoxJW
	5/oRcxg9VV+uekEEccEv+jdfmZezvLIeUqW2acgM1XPnsgfZxw0BHwRuvhYELKEUzMb8ECMgwe5
	MlG40e4QlzFT3HjCbgSNsAVMV09wnVW8RgVCZn8vdjAbFGPFUiVlbW/pPBBgR2O8E5ViNF06nPg
	ltQBlC4/eniwN9yJaqVNpQGRJlkbtquWOugxHOLpKZhEf3WXJKQtKsnmjEQEn5Sav1wszfiVIjG
	qxvEGL2ZE/aD3U7A694kmVCNdOQsWD+fSKHxJ1q6K05oQ7lRvJpmE6XBIlMGr+V6cnIsH2yNqB5
	RlrTtZYNxJexVlqZhg6TptQ==
X-Received: by 2002:a17:90b:4a87:b0:32e:d600:4fdb with SMTP id 98e67ed59e1d1-339a6f37ce0mr5612387a91.18.1759356344596;
        Wed, 01 Oct 2025 15:05:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEwA03IVPTcB3jPZNykUMsai4acp6hXfEk2fjuAdlgpyO2JlX4KBGXUh1TStolV8ltoQm2vOA==
X-Received: by 2002:a17:90b:4a87:b0:32e:d600:4fdb with SMTP id 98e67ed59e1d1-339a6f37ce0mr5612350a91.18.1759356344166;
        Wed, 01 Oct 2025 15:05:44 -0700 (PDT)
Received: from hu-wcheng-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-339b4ea3c3dsm702085a91.5.2025.10.01.15.05.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Oct 2025 15:05:43 -0700 (PDT)
From: Wesley Cheng <wesley.cheng@oss.qualcomm.com>
To: krzk+dt@kernel.org, conor+dt@kernel.org, konrad.dybcio@oss.qualcomm.com,
        dmitry.baryshkov@oss.qualcomm.com, kishon@kernel.org, vkoul@kernel.org,
        gregkh@linuxfoundation.org, robh@kernel.org
Cc: linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Wesley Cheng <wesley.cheng@oss.qualcomm.com>
Subject: [PATCH v4 05/10] dt-bindings: phy: qcom,snps-eusb2-repeater: Add SMB2370 compatible
Date: Wed,  1 Oct 2025 15:05:29 -0700
Message-Id: <20251001220534.3166401-6-wesley.cheng@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251001220534.3166401-1-wesley.cheng@oss.qualcomm.com>
References: <20251001220534.3166401-1-wesley.cheng@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=OJoqHCaB c=1 sm=1 tr=0 ts=68dda5b9 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=x6icFKpwvdMA:10 a=EUspDBNiAAAA:8 a=9ZGL9VZrYHwIVTkvpzsA:9
 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI3MDAzMiBTYWx0ZWRfX9hcc8GP5Hp6U
 VzFmTVge3y6Vhvt7JxBs0mw98yDvy+G/8oe/DwtgAIA+PqJZbtggiOf8CVpUF8L4vPLU0S+j1hE
 40PVgLU50FPFsdzkt4h5PLJKhf7xoPzT//yZ5IcVvd75rqXMuZnGrvYILKMDUTp3uDrlOOhBtrV
 TK8FUiwvpZobu5XozLm3i7+sKqP8QMchm9Z6ri3mBMuFX32ZLXGhNK3kfuFsK1X/XS9a6IGCRnq
 +6kuTIVFR3uxFWuIgIRnc3xKTP64StRTE/HIl3bkbTwEzfZNmjLSUYoz5gxiR+dQIzasQjKWMW7
 iODZJXW/te+pw8Bc3KRaKPIPN8inRGx53KG0sDqkrkv1jGw0d13u81mGvHPw8baU+szr+SWKGwV
 bSZHLsUpY5aIvOw6/S7dpfHhVYHURA==
X-Proofpoint-ORIG-GUID: ql8JFGyVNHGVGVqf72g8JrgdkvmHi3MJ
X-Proofpoint-GUID: ql8JFGyVNHGVGVqf72g8JrgdkvmHi3MJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-01_06,2025-09-29_04,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 priorityscore=1501 bulkscore=0 impostorscore=0
 suspectscore=0 lowpriorityscore=0 phishscore=0 malwarescore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2509270032

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

