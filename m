Return-Path: <linux-kernel+bounces-831563-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D6A62B9D060
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 03:32:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 888363819F7
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 01:32:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B3822DE717;
	Thu, 25 Sep 2025 01:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="eslxo5rj"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F2AA1DB95E
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 01:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758763922; cv=none; b=iQfmp8D6h4k/iOibR2gfSIGPBjnM22IJ7av8JFENBCisKqpqrbT/Eh3dE70sq4ckBQU2GjFR4zeAEHdUmQ1ildpfA7VGjY+8/6U+EuIq3EdZYgT+HPNQojjttmEGzlwPopVjgNbwGhxoPs9hDVQzQ5oG3H3zHUCZSGPVWw+XuzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758763922; c=relaxed/simple;
	bh=B2W8QlDRPUbYId4RKLCk+SpL4pdjrDWi1n1TRnKMnVQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WWXkRQCjyVTgaKB2wUfxWdhfvdf3z17JrU47FodRdA/bI0QHgr0u2D8BpsXuonZx7hhgcwusbO03X3OVfasERgH/xRX8x8vxOKWBXWWo+23ENFSP3guPAfh205pQcFYIDrzcJloiTmPVbNApCChMxLMr+WH4jTFbhOcNAL2rqFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=eslxo5rj; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58P0Z4Zi019915
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 01:32:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=HMxLUM5IWdCMDI4XHlO17eGF
	SLCDgAm/nD6cVTEGZY0=; b=eslxo5rjDla+eOEEdGfqGRTwnttf8tUIBzdpR+nn
	A4DgL5fH2+zyho6V8Zhxi/B6F39cN617tkrQ3766A6SBI0epMBeSQ1+vRbVfr2BJ
	qzIzQmIU9LyLkBwptGhUBKBxkqXIBhtc3GJAJegPIcV4/CpXI8GgRh5M115n+Ivj
	VX8YG6ukLb4r2VuY2q4If0/7/60HHLfnlYKhWfT9pBxU+C7SISEKsAsriI7Bxfje
	y1gkt67cdyVRD2TQ/0AJNVRCZWlGMY6wLkJjnU6McRw9mGTyj+U5Gt5SNS+K//bs
	l+05RwE0xGPbDZSVZBEc3LZwPHS3ZvDHs0nYuBKc6QWUXQ==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49bjpdygsx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 01:32:00 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4ca8c6ec82eso10025911cf.3
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 18:32:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758763919; x=1759368719;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HMxLUM5IWdCMDI4XHlO17eGFSLCDgAm/nD6cVTEGZY0=;
        b=IaahXzPe600pmuUmwy9Jdwe/qvPUuzXhy0TtKXlAFQA3LgG+fRqXKsyeEex+k/HD8C
         azX7xeVSVIBeqoYjOgfonIDI9p6knd50GIghBIlFRTiJqdIHF0uh2nRDN5DJe5nQ7zbJ
         pxL5kK6fdG4OJXoopMdie1lUiFxZ6GKz0lf7IXruHNUT7YKhikmToq5yCE2yCEOeDe1n
         zi+h+96pAncEZZBjx8xPyXZn0kzyy/yUPcheO5ddoU2WNNbIHOnzmDdIM/1hTTRQt1B5
         OKT2k1XPxz9evW/07B5BZ47z5Tj2aTzIXqrslQoZXNYLPQKByO7LXLt9qyfHPeSFMdkd
         41WQ==
X-Forwarded-Encrypted: i=1; AJvYcCUx/TtoqmbQX34qpK/JlAjeToVLkQAtfAXqnLEJbQ7fgbh2OhDxbwRUIOy191ERzejXMhTltieJT0jbB5E=@vger.kernel.org
X-Gm-Message-State: AOJu0YxP8nvIq6R/mazpWSjdIr+yG2Yrukz/PEkK1RJtYMyZGsynX4gi
	9UfT6PghGfi6T+g1PObRekf+pqAHz+z375rtMxjpMWnO5QJWs17bVcnpnd6k6iraQYpNlIQbgKe
	yLhTHdbuVUU8Yg3TlB0GBKpB2fxbRpS5jmxIOwNtHp2bWoz4MnJG+lY87raMIGC72Mpw=
X-Gm-Gg: ASbGncvW0MUeeUow4MAK2TfNW5bY13YuaGJCGkmYVCW9MCdZ1i17oINdX2/0Osbtn1i
	w7s9qaU4Zz2cYjKeJEqnUxEu9+cIipscpId1WDP66FWF4hiSGJJTWkAalohxvwpy7k8VL2Re4kz
	cGKHGAAgmXLJ4XmFoYrmUrn+dHgfqX4JDlVvkMu1vPN+pmIibICA7n06qXANwoqGRceZhPyL5o6
	enzHzSkQYp/DSR/JnkgUtFqFpkdl8xHZpFD0kvFjp6OTB0Gmw5KYkkePi+bg36uewBRDkY4h2kn
	V0gHcKkuDnKJ3qMT6PhIVgmjMq6sDTm4QPCvNGozChKxg75vB59zdsrxyet4iPzIG8Cf++9qp9K
	7l+oDurtfcOVg8Ql9QtP+TXOp+uLD3FGYbXOZWkMs0Trud8qbeFkL
X-Received: by 2002:a05:622a:347:b0:4d7:9039:2e8b with SMTP id d75a77b69052e-4da4c77c44amr22446151cf.72.1758763918669;
        Wed, 24 Sep 2025 18:31:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGLXkB79ZdwIIrxHpR8mHmz6lONhQNuhy+mvf3W6YwEGNNidGZE2ggTMtevzJ98w35Q6vuNCg==
X-Received: by 2002:a05:622a:347:b0:4d7:9039:2e8b with SMTP id d75a77b69052e-4da4c77c44amr22445871cf.72.1758763918237;
        Wed, 24 Sep 2025 18:31:58 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-583171e50d3sm196333e87.139.2025.09.24.18.31.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 18:31:56 -0700 (PDT)
Date: Thu, 25 Sep 2025 04:31:54 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Wesley Cheng <wesley.cheng@oss.qualcomm.com>
Cc: krzk+dt@kernel.org, conor+dt@kernel.org, kishon@kernel.org,
        vkoul@kernel.org, gregkh@linuxfoundation.org, robh@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 08/10] phy: qualcomm: qmp-usb: Add support for Glymur
 USB UNI PHY
Message-ID: <fo4jg2eewahc7iahfk3kdzztpcami2wic2kocgp6m2c5nzb3ma@idfpo4frh3eb>
References: <20250925005228.4035927-1-wesley.cheng@oss.qualcomm.com>
 <20250925005228.4035927-9-wesley.cheng@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250925005228.4035927-9-wesley.cheng@oss.qualcomm.com>
X-Proofpoint-ORIG-GUID: M7G0AYdvP6SKGtSS6Hd6XFEizpiCHUGB
X-Authority-Analysis: v=2.4 cv=Pc//hjhd c=1 sm=1 tr=0 ts=68d49b90 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=NGXOFnXZFdVYdcUjdRcA:9 a=CjuIK1q_8ugA:10
 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-GUID: M7G0AYdvP6SKGtSS6Hd6XFEizpiCHUGB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIzMDAyMCBTYWx0ZWRfX8N8E4kJD4RY4
 8UKOrUdAikIdG9XTH/rOzH4GPgqWacpQbBpvtbjsF6BuOcXfqaC8WGJk2LzJM3UX0ZDhDbNhiWR
 szESHb09OxtO49EVo6tZyZbCEGYbrjpZ+ZY3XkifJUb1cfL+AYvM1K0IDD/OphTBwHi2/9wEYth
 4sz5ZRIO2z7qUx2e9oWe2JapQBed071mAkjerMfsGwyrcOOI8Ec+iMj6mdzLYo8NHxeOgDXdMah
 CwfoSukQWgCJ32ZqOzMaiK6kG+sKu+YkHLVkjiGDRjOosPz0dC/U0YGLjRzqg3XJ3dyLu19QNuB
 JnkBaTmAiDp5Anzv0dFXHqeZEm96MqDXoUlYJQVl3/WSoJ8mQxUlr9bvU0P/BElB+ATqVKg4r5b
 0+6gObMx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-24_07,2025-09-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 bulkscore=0 malwarescore=0 impostorscore=0
 spamscore=0 suspectscore=0 clxscore=1015 adultscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509230020

On Wed, Sep 24, 2025 at 05:52:26PM -0700, Wesley Cheng wrote:
> Glymur contains a USB multiport controller which supports a QMP UNI PHY.
> These ports do not have typeC capability, so it needs to be differentiated
> in this manner.  Update the QMP PHY sequence required to bring up the UNI
> PHY for Glymur.  The UNI PHY follows mostly the same register field
> definitions as previous SoCs.
> 
> Signed-off-by: Wesley Cheng <wesley.cheng@oss.qualcomm.com>
> ---
>  drivers/phy/qualcomm/phy-qcom-qmp-usb.c | 163 ++++++++++++++++++++++++
>  1 file changed, 163 insertions(+)
> 
> diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-usb.c b/drivers/phy/qualcomm/phy-qcom-qmp-usb.c
> index ed646a7e705b..50e31610ce20 100644
> --- a/drivers/phy/qualcomm/phy-qcom-qmp-usb.c
> +++ b/drivers/phy/qualcomm/phy-qcom-qmp-usb.c
> @@ -28,6 +28,7 @@
>  #include "phy-qcom-qmp-pcs-usb-v5.h"
>  #include "phy-qcom-qmp-pcs-usb-v6.h"
>  #include "phy-qcom-qmp-pcs-usb-v7.h"
> +#include "phy-qcom-qmp-pcs-usb-v8.h"
>  
>  #define PHY_INIT_COMPLETE_TIMEOUT		10000
>  
> @@ -1240,6 +1241,139 @@ static const struct qmp_phy_init_tbl x1e80100_usb3_uniphy_pcs_usb_tbl[] = {
>  	QMP_PHY_INIT_CFG(QPHY_V7_PCS_USB3_RCVR_DTCT_DLY_U3_H, 0x00),
>  };
>  
> +static const struct qmp_phy_init_tbl glymur_usb3_uniphy_serdes_tbl[] = {

Please, keep the file sorted.

> +	QMP_PHY_INIT_CFG(QSERDES_V8_COM_SSC_STEP_SIZE1_MODE1, 0xc0),

-- 
With best wishes
Dmitry

