Return-Path: <linux-kernel+bounces-840023-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BDFABB35D0
	for <lists+linux-kernel@lfdr.de>; Thu, 02 Oct 2025 10:55:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E7A8F3AC875
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Oct 2025 08:53:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A2A82EA730;
	Thu,  2 Oct 2025 08:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="CAP2GieB"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CFB12F548D
	for <linux-kernel@vger.kernel.org>; Thu,  2 Oct 2025 08:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759395186; cv=none; b=IfM92f0VNAH3o9K1+DIZLGboBA5bML11yWeWa90Y8vXwML2wu7ZivecOC+XYHfX1gI0DVwnxacz0gd+Z/0cTCLno7AvR8mL8R6sWLAJg42dtQwWDCAwCoWmiqb64EjW0I2a9rDIQfHTmjNHtyxvq51y+/ENiIMbyzeFtb+wOUDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759395186; c=relaxed/simple;
	bh=4HhiCdtPcD/lAuJiiWVZDNzGfAoGz/T6J5k93s3E1eQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=F4+RiY82yp4Fr2XvJ190e/xhFhbBLdXwk7U8EaDzKc7HXHfsfVu7EHGgOPuptsM/XkNVbhAb1h1gIMw+mJUX8eyHkFL8QPy37dr55+js9+KLqstU6EBdOJsC26Q0ttyNH3exwf8tN/NT58oqFzSnxVt8Ez/a7mZSl6Uyg8qdefU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=CAP2GieB; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 591Ic41L012315
	for <linux-kernel@vger.kernel.org>; Thu, 2 Oct 2025 08:53:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=TASzNO6cx4aY4C3+AUINvs
	P0m6HCBQVPuXIy+ecED+A=; b=CAP2GieB3AbnC5uPndtMr2krZegxzNq1Cuuyld
	ESrqYSY9TzqA+eOR97cRjXAOPiMhcToPndkwzI4ZEXJBkH/5el3QRr/4TvvywYW+
	wuroS8UZNwGzeyVFJHGcnH817CxjrZ5M1X7B0gJBJgsfrzZ4SIEcUvN6lz/ndx91
	hs39Z7DzcYTpVzrhTkoSWTsBgdDMsoRaLljXVmAxIplxnRhgsZzjC3XGeJNNJu/1
	b/vwLYfDzoOIA7sh4Rg2VwaDnRuPEsdq847MSydDnt6Hsb9MzO5KhXuABgSFaPf2
	ln+cfBbBG/57CITqw8+oot7rRYuhwmzB4/W4xd9txNpESsPQ==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49e80tye9e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 02 Oct 2025 08:53:03 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4e484dccaafso19171741cf.1
        for <linux-kernel@vger.kernel.org>; Thu, 02 Oct 2025 01:53:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759395183; x=1759999983;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TASzNO6cx4aY4C3+AUINvsP0m6HCBQVPuXIy+ecED+A=;
        b=nF23ZwGKxs8ZqeqnQrEqR/C6QKGETjao52Gp/veUiobVUlU5zN5KdWiNy848fXMk7P
         1BLnVZp/G82hXcX565gqpejk5v7mteZhcXqubL/55C/F18drAUwjg2M0n1ZYWN+LjbZm
         VwDaqR08RTB5Yc2kNm2PbNTpf2mGSMs/Ar4rm6F/n1iCgHOFdEK6XBR32g2bT06fZUYa
         zqGqFM9iyX8HmguTbYnsnsiMw4sIIOMZhoSklS+BEc7TGSi06/1S90ItjSF6q2xooV4h
         +MoIB5ce1Ulwwgc2o0D/+HmCYqOL6NlFuaIv4sjlTPmt/9gQpyUqfp1of4CroTRElYea
         bMCg==
X-Forwarded-Encrypted: i=1; AJvYcCVN0PteUpw0uQRPtWyoFUIFNicMDkNHbaSQEcYANazQJM88qGT/w5beYyuR6VSlqjlf2kEWvorAeh7rkn0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTkVug2QGMB+vbRpCsKxaZ0Pe5zFSEsvWNPmoIFjNQf6JkJdRz
	OtXJMKrZ89R2Q3p/bvK4JyhJXHyxo2jVwY/y15fCKGhN+RuedmSnmlW/loNqubjFlLzVLAcRQPS
	CHBdjX3wyD1METPRdyo09z103T0gDDiRtLWqi8MRsCce8isSNk+hqkraSqFMBsO/Wa4E=
X-Gm-Gg: ASbGncvsvEfbJ9ixOY/ko2v0aY0xgO8Cq7R9CEm/JLsDda7mO3woh1zoJxaS0F+GLBd
	6EGeu9905ab0xzssisUzSwk/x3WfHOe/VZJqZrZh2l/uync+z3R2VLBL/QlG/ma7+ZYZGTGBHzM
	rQ/AmR2WW/ldpaNoSs3gNI7zU0o5I8tNWUVAZS6dyrJIRlwrO/8mm964vaHaa1BN10SOxKNKMwv
	O37KtFcAPHaymcrMtNZt/keJUjmNnwu8Q1MEByiul8oUC5ueBRysP2WDpnneILeTcUT8q2B3CaL
	7ntOjjykzGWy1wkODECsBEX1c3UesuYehI30VbpnKxh4CRTCQn7HrKnnY99iBtm2mUzh6FBxd0B
	lyOb0pg2BfqqTjlprlBYSA1HPv395mOk0KAkk2XgRT5c6eM9MfMtGWFhC1g==
X-Received: by 2002:a05:622a:178f:b0:4b7:acab:852b with SMTP id d75a77b69052e-4e563187a7dmr35617731cf.26.1759395182870;
        Thu, 02 Oct 2025 01:53:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHNOAfQi87LSJCR34yVxacyKLw6xvoldf4BlPcvjoOelxPVg87GKyqRVsbOCBcClJYp2rXwDA==
X-Received: by 2002:a05:622a:178f:b0:4b7:acab:852b with SMTP id d75a77b69052e-4e563187a7dmr35617391cf.26.1759395182191;
        Thu, 02 Oct 2025 01:53:02 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-373ba3124bbsm5207351fa.27.2025.10.02.01.53.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Oct 2025 01:53:01 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Subject: [PATCH 0/2] arm64: dts: qcom: msm8996: fix issues with probing of
 USB hosts
Date: Thu, 02 Oct 2025 11:52:59 +0300
Message-Id: <20251002-fix-msm8996-icc-v1-0-a36a05d1f869@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGs93mgC/x2MQQqAIBAAvyJ7bkGFLPtKdBBdaw9aKEQg/T3pO
 DAzDSoVpgqLaFDo5spn7qAGAf5weSfk0Bm01KOSUmPkB1NNs7UG2Xv0pEI0yoVJaujVVagr/3H
 d3vcDh+1ZgmEAAAA=
X-Change-ID: 20251002-fix-msm8996-icc-ce1df61ad702
To: Georgi Djakov <djakov@kernel.org>,
        Yassine Oudjana <y.oudjana@protonmail.com>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=826;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=4HhiCdtPcD/lAuJiiWVZDNzGfAoGz/T6J5k93s3E1eQ=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBo3j1sHDRs9Wa78xf7Zro3JM+9I5+e4+9JwUjFg
 tK/W9+sH9uJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCaN49bAAKCRCLPIo+Aiko
 1edjB/9w0q5npQeXksi6wlcEjIQu25zJ0+LLfiiJgla4Z49TyAgXj6UVL73votEUyO58Gp0OjcW
 Yx7BQMKPhHZu8RQa8qqDJj/m/VBKkNXIxZ+NalS+lLaHbWqI3JkB5i2OZmOcQfsONl5PIG5dCqY
 tEfzjlzaQzFXPzhdCoYHMOXyHTOd59m+PdWFM8Pp9rC177WfRdh/gu720rIDpvNsE1B2Gd8VzMr
 atxAbUY/CPpN5TdEKYzc+EPyf15f64U9HKif0PDSAXbuGo9lcY366BrFL/vkWU5TU/hrlQs+xLi
 7XHR1tqMIgh1kh3FzyGieYKpxVD8MoeTifEk8Ee/0ZRkD0D2
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI3MDAyOSBTYWx0ZWRfX4H933hGXnKnB
 +6uJNM5sldHwswftaW1c8X1wRfwLte17Df8vHxnZ40j9BXLLN8tLGqAkGtrGbg/zyDI3+7Zxrps
 3+3Q9NPdWeooC9aldltJdLyFb4OA6DlxSAkrUKIWOsUHlUsi5ie0d7Ig8lUzLC2hTQlxLChhH8M
 EcL5jens6u8qLA/nwJZlX8pbsR9WXeFamsSCb5JTQ0/ShOGKLb2Mn+hmw+QPlqdRUS2lTfx4CrV
 qZlwvYK+DwTyS6Jy/B6SFS5koDiKPvp3vHmmNKOXiEY7OVwFoaNuKM84jhVi43voWgDFcPY72MA
 fFYp6scTli8TMDk6gpOFyG2bgUj4FCeiCd+i7SeyVK+a88lavxv3Yeb9Wuw5plfyTRNRCsgIJpF
 qTvcUxVWRgCNqAjY5jycen99YSuIOQ==
X-Proofpoint-GUID: cmnXcdnli2tKIWS_1XEK2sV-hoyHNqKX
X-Authority-Analysis: v=2.4 cv=OMkqHCaB c=1 sm=1 tr=0 ts=68de3d6f cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=x6icFKpwvdMA:10 a=EUspDBNiAAAA:8 a=tC0vjRaNn0V86lLPGsYA:9 a=QEXdDO2ut3YA:10
 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-ORIG-GUID: cmnXcdnli2tKIWS_1XEK2sV-hoyHNqKX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-02_03,2025-10-02_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 bulkscore=0 phishscore=0 adultscore=0
 priorityscore=1501 lowpriorityscore=0 clxscore=1015 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2509150000
 definitions=main-2509270029

The lack of the interconnects for the USB2 host might result in the
register writes for the PHY not reaching the PHY and thus the PLL not
locking up, resulting in -EBUSY errors for the USB host on the platform.
Add missing interconnect link and add interconnect paths to the USB2
device.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
Dmitry Baryshkov (2):
      interconnect: qcom: msm8996: add missing link to SLAVE_USB_HS
      arm64: dts: qcom: msm8996: add interconnect paths to USB2 controller

 arch/arm64/boot/dts/qcom/msm8996.dtsi | 3 +++
 drivers/interconnect/qcom/msm8996.c   | 1 +
 2 files changed, 4 insertions(+)
---
base-commit: bf2602a3cb2381fb1a04bf1c39a290518d2538d1
change-id: 20251002-fix-msm8996-icc-ce1df61ad702

Best regards,
-- 
With best wishes
Dmitry


