Return-Path: <linux-kernel+bounces-839574-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1594CBB1F0F
	for <lists+linux-kernel@lfdr.de>; Thu, 02 Oct 2025 00:08:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 88F1C18905AE
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 22:08:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE1C93148C3;
	Wed,  1 Oct 2025 22:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="NcV4KpZY"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2B43313E11
	for <linux-kernel@vger.kernel.org>; Wed,  1 Oct 2025 22:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759356356; cv=none; b=AxyqqO9JqKR5H3bN5Cv8E0gkkOabT0X0fOjZsrzpajAwzPDEl6erlGqTbcoccRfWghQ9lyu9ufJnXspLGUi49Sa3sfA0qiPqiFR7v+XTftPPyozQ9urdkTWU21VEZ2SIzJvEfBXFRGbrwvWr0U3OyRvcw1k/reaphu0wRXIvnMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759356356; c=relaxed/simple;
	bh=KRfbO68RqNXGYUxEscJ9pAB4g2zVH9KTs2sCuSCOkhg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=drvbtZEAQGS8/sXnJZLyRi0q3YPthZhUGKi9R+JquooM2P0mgfxof/hhUtlXBCbXt2PW+KlBfuUoFSGxXTh8JRf/dCYCiJ6KPxFERiusa3pxqSU6A/g9VxM6c+xrCkPVkmhgNOFZ9z632xk1qyNOgqOxFMWk8alGR8wG0zxLQXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=NcV4KpZY; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 591IcppT032535
	for <linux-kernel@vger.kernel.org>; Wed, 1 Oct 2025 22:05:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=NVYsIQDhA8R
	ySLuD9P7ecPi4IEalfEg3vxqe/TJrcfQ=; b=NcV4KpZYz8Xya/lAqkwjI8Lx14D
	feryq2JW3z6hAaS8oD8wcT5f/SPxN0osxdtXPEIPBBnPB8NsFTfQR8bGh4MC66K6
	pzWZ14yvwe5T5aTtlwZKBG0E0J966qKCrqfDvGTgG1XASKrZe1KoxS7mdjHcofb3
	QoV19uLa0TZgpuVBo8j29s7ghiVIFIjxf7I0QWhP2r/Q9n/xEFeRZP850dG7gvd0
	rx+ZD2wV6Nuw9Jn02vfTDEPF6U6mtrvIgECbq1J9G4cnyh7pr8v0ZWW73PBTqg6D
	+41JHmW7wKFSUaWhK9HfSNXhdW/zTWuojaJQm1Ibm5378miKohr2XGeiOvw==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49e6vr6134-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 01 Oct 2025 22:05:53 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-28e8d1d9b13so2560145ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 01 Oct 2025 15:05:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759356352; x=1759961152;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NVYsIQDhA8RySLuD9P7ecPi4IEalfEg3vxqe/TJrcfQ=;
        b=k2OpYaU8bf7L289crnj9lpo/wTxhWqrY6shiLdO7gqOYuaLzs3CweIzyynwi8Byk6l
         BfAwHLQnYVILBHI/mkaSlTq3GiSM+Ttx2vckINQDzsRRQpCa7jsGG3LAg/LU48KbwDHq
         biqo2GQNpmrq8+gdXolK3hLL7LOlYfyL1njnHWYoKhWJaqXNcmDrLdh9oCGQNm293tGU
         Xtb+0ElwGbRweZMlyFxOQfjEreEyGrZLg37SqaUHbtmvFYUhx4Sn+xC1WpAUfH+Fl+E8
         EZDk9JSettVk9gptX35WbksuSHoQMyXGEtNrDZAiVxLFMQQWkPDE3zuXBvDXy26WoMl7
         bW+Q==
X-Forwarded-Encrypted: i=1; AJvYcCUL8pu2g8mRwAeUBbAwNpK7BNmmA9797XTRrAJfRB0zKnVuZXgfc4K6EzF7mwhzFcplu/f1jOP/pEy4XLM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzldN5mguBwEWgFsNxlcASAjgM4Iuzl0RonBB35LsyLfMhd3nYi
	MQ0fuYopLoryxexdo3iorbal9M5dZdd3FcQXxFEIbPbFdghg8TDQblTuv0o77BJQog4rG12ssEZ
	ixVg8L2dz4eb/9v7OULL0o8jgo27PqdBLkYLSBLtOw70taJFv5Gzw/YhllGcpBfKUITE=
X-Gm-Gg: ASbGncslX1KLCvAFj2cNF1sNvGll5VGCyUz3kE+sk9DucsfPjlpvY1djY9FsC8PGK/e
	JVHrDBqVljkanokPJ/eW3ib2f8r2GUBH1dNGO8uFjW24PiFv88roVqwgk/ze7nA+bfoFpKK7QxQ
	HRkWVtjOSq4zTI1EHsFqGUq4rl+6kw2jPlmckMg81qDBWwe3QosfdtoDCZkVuepnrriUHtOZPqY
	T1k2PhzAwu1+zuAJbO6Au/n74WlRj/d8O4Ej6iYVrvF4Lpc7yyTDszQsrOz3Gjd1IubFq21HVB2
	P4aS9zLf7IDDoP8di27yf529PF/zASqdSMA0nUuNdvo8/KvBjIsWE1odHjoik4uwVlzaG+IRRjZ
	uWK6kxt21wD+5c3TpCEnveg==
X-Received: by 2002:a17:903:22c2:b0:25c:46cd:1dc1 with SMTP id d9443c01a7336-28e7f31092cmr55936025ad.33.1759356352134;
        Wed, 01 Oct 2025 15:05:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHqQqqXsWfsPcB2aMVgjy1eDaAlKWRk/y5Tw9L6ueOyV8a1NgF119HAYRfaqcXDXa4fmR6VmA==
X-Received: by 2002:a17:903:22c2:b0:25c:46cd:1dc1 with SMTP id d9443c01a7336-28e7f31092cmr55935695ad.33.1759356351699;
        Wed, 01 Oct 2025 15:05:51 -0700 (PDT)
Received: from hu-wcheng-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-339b4ea3c3dsm702085a91.5.2025.10.01.15.05.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Oct 2025 15:05:51 -0700 (PDT)
From: Wesley Cheng <wesley.cheng@oss.qualcomm.com>
To: krzk+dt@kernel.org, conor+dt@kernel.org, konrad.dybcio@oss.qualcomm.com,
        dmitry.baryshkov@oss.qualcomm.com, kishon@kernel.org, vkoul@kernel.org,
        gregkh@linuxfoundation.org, robh@kernel.org
Cc: linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Wesley Cheng <wesley.cheng@oss.qualcomm.com>
Subject: [PATCH v4 10/10] phy: qualcomm: eusb2-repeater: Add SMB2370 eUSB2 repeater support
Date: Wed,  1 Oct 2025 15:05:34 -0700
Message-Id: <20251001220534.3166401-11-wesley.cheng@oss.qualcomm.com>
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
X-Proofpoint-GUID: uyjkF1ARu0NtQoQc3RSquCoGP4jZHH4D
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI3MDAxNyBTYWx0ZWRfX9gbbk81LdXqt
 oooDA2qjJA6Hj3u1lYyBL4a7dNeQVuZwmDr7cFn03szqdHifxF6BwOk+g9DOpptHN4/0cHwi+fw
 Wuf5wW3hxvcKxrku/E1umVzV/wo1spbh2G7bLKVOBXvtde1XHOSC/PoRDDWWYVYW7ozk/jzaWIb
 uVPsov43I/sqEN1wUN/gOixu1oJSFQbkKZPtZ6de/50p7dgz829R7ap5EOJ6DhGMSPUm6bQJMI0
 /BuUHGjDcD4fbF6a/ZfgzRV0XBt4EwK01wKpeNHTTW2Umjeu0DZrgjOuqutlPwwgjbfrW0IwmNV
 t6AqrXxnQOiOG9u+5gvDTABrMx5cXpwtFNbiFEU8xhRfC6Z51+dmdXwAjNcUIeiM+qUrWUTiJUd
 KEC2eTnLXcpPqjogHwuh7xbk9yftuw==
X-Authority-Analysis: v=2.4 cv=IeiKmGqa c=1 sm=1 tr=0 ts=68dda5c1 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=x6icFKpwvdMA:10 a=EUspDBNiAAAA:8 a=Zq12RZiOzp0PcbRnEbUA:9
 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-ORIG-GUID: uyjkF1ARu0NtQoQc3RSquCoGP4jZHH4D
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-01_06,2025-09-29_04,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1015 priorityscore=1501 bulkscore=0
 suspectscore=0 spamscore=0 adultscore=0 impostorscore=0 phishscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2509150000
 definitions=main-2509270017

Introduce support for the SMB2370 based eUSB2 repeater.  Configure the
proper repeater tuning settings, as if this is not done correctly, it
can lead to instability on the USB2 link, which leads to USB2
enumeration failures, or random disconnects.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Signed-off-by: Wesley Cheng <wesley.cheng@oss.qualcomm.com>
---
 drivers/phy/qualcomm/phy-qcom-eusb2-repeater.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/phy/qualcomm/phy-qcom-eusb2-repeater.c b/drivers/phy/qualcomm/phy-qcom-eusb2-repeater.c
index 651a12b59bc8..441996480a67 100644
--- a/drivers/phy/qualcomm/phy-qcom-eusb2-repeater.c
+++ b/drivers/phy/qualcomm/phy-qcom-eusb2-repeater.c
@@ -75,6 +75,13 @@ static const struct eusb2_repeater_init_tbl_reg smb2360_init_tbl[] = {
 	{ EUSB2_TUNE_USB2_PREEM, 0x2 },
 };
 
+static const struct eusb2_repeater_init_tbl_reg smb2370_init_tbl[] = {
+	{ EUSB2_TUNE_IUSB2, 0x4 },
+	{ EUSB2_TUNE_SQUELCH_U, 0x3 },
+	{ EUSB2_TUNE_USB2_SLEW, 0x7 },
+	{ EUSB2_TUNE_USB2_PREEM, 0x0 },
+};
+
 static const struct eusb2_repeater_cfg pm8550b_eusb2_cfg = {
 	.init_tbl	= pm8550b_init_tbl,
 	.init_tbl_num	= ARRAY_SIZE(pm8550b_init_tbl),
@@ -97,6 +104,13 @@ static const struct eusb2_repeater_cfg smb2360_eusb2_cfg = {
 	.num_vregs	= ARRAY_SIZE(pm8550b_vreg_l),
 };
 
+static const struct eusb2_repeater_cfg smb2370_eusb2_cfg = {
+	.init_tbl	= smb2370_init_tbl,
+	.init_tbl_num	= ARRAY_SIZE(smb2370_init_tbl),
+	.vreg_list	= pm8550b_vreg_l,
+	.num_vregs	= ARRAY_SIZE(pm8550b_vreg_l),
+};
+
 static int eusb2_repeater_init_vregs(struct eusb2_repeater *rptr)
 {
 	int num = rptr->cfg->num_vregs;
@@ -278,6 +292,10 @@ static const struct of_device_id eusb2_repeater_of_match_table[] = {
 		.compatible = "qcom,smb2360-eusb2-repeater",
 		.data = &smb2360_eusb2_cfg,
 	},
+	{
+		.compatible = "qcom,smb2370-eusb2-repeater",
+		.data = &smb2370_eusb2_cfg,
+	},
 	{ },
 };
 MODULE_DEVICE_TABLE(of, eusb2_repeater_of_match_table);

