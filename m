Return-Path: <linux-kernel+bounces-825750-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D8A5B8CB9A
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Sep 2025 17:32:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE5BB1BC1D66
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Sep 2025 15:32:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96B5C2F549C;
	Sat, 20 Sep 2025 15:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Qg2bH4tc"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37089219A7A
	for <linux-kernel@vger.kernel.org>; Sat, 20 Sep 2025 15:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758382303; cv=none; b=ObcHVamcramdL6i3swVKbPV3n7F4qZSFhVrdo1Jezyfxr9GVhLat/zLECD7w3+WofXgbEjciXrgSf8aJ8Ui3olz35t6HwWs0B2LuOGQ8Tqh7vdy7q7jRl0Y0YyWuf7hmlP/NuPbw9k41Y53aORhrzdcs6zlsihh2qpD63pWnVsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758382303; c=relaxed/simple;
	bh=udxfCGmnVPp3xuxZUomY6Jk5jtbCwqUC6PXYgyxxiTw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k4of9Ug/2jrg7lQ/021lWlepj7ldO+Xe1N9XMNl/bVOfqfPSPRYL4rVBDOSZF+wl7mvwIAjA5qKgdDiRHthPIHbWdNw1G4RPHdq41aVL5QrhmVU/CqAWTj7jIxPM8u5HD0mUylzoPAQ/FcjVB0+ZKlrh0VuOSrWRlEgaLi2XqVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Qg2bH4tc; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58K3QJeU019167
	for <linux-kernel@vger.kernel.org>; Sat, 20 Sep 2025 15:31:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=Agw1jf4xhD2dHvOPSs6hIpbq
	udXfs5BkybpcFGMrFAA=; b=Qg2bH4tcfoIH9x0hMOcjMnqT2Tnhanqu0xSzf9vr
	UxJTTIAX2EDnB/J/yjVXv+isq8NlO4GN3npTf3glkUOHfPXNMxhsRNBzrLOtZJXy
	JHcB2TrR6Nq6W6sqvgUVC0jd3tioWSaHM7QdkKdvJYgJeEc/P/rAJfovXlhtzxSI
	quiRW7Pw4BOZLISYzjZ+hqdU0YcPYPKXk75ZZ91BVXAoaI7vwusd291CYV9Sk6tP
	YVFANlrRhtP3vSoIyFkh2PBzCYRRLGpefFUGBd2uA5JAeaJYzIo8MjF5KMlmyQzK
	spCgGPqtmDKCZkTAZ1ZZFzJqJjppIx6y2PY9gRYmaMJupA==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 499mbv0w2r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Sat, 20 Sep 2025 15:31:40 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-78e0ddd918aso50410056d6.1
        for <linux-kernel@vger.kernel.org>; Sat, 20 Sep 2025 08:31:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758382300; x=1758987100;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Agw1jf4xhD2dHvOPSs6hIpbqudXfs5BkybpcFGMrFAA=;
        b=GF8Xu0PqFU2dR9LlpbfvLVttjeUUhdb3QgleIkTpWlqWrqsKA5NJx1l3bLT4XsOLB0
         LPC24zQB8JfbFZphEfgCUs1T90z6Go7Cjrq26T7v2b8WnlkkAqX30CKjA4r2ByAHoQXm
         WARbxgM34ay1SXG3/c7b43DKHfDWWfMRKFWxX2zUBky6Y/Oy098XO+cr7dNdSFXMpz88
         l/2hflZktfxHA78IOG4aO/CD88HhhnjTFIwTUmOO3OZc9BUF/bY0K4xeRJqaCF3YIq4Z
         VdF5YDfFvFhfTViRzAYt7alZHI4Bh9eZZTCT/3sYPtAoTHE5X2V9ddhks8xwAIb8Qo7f
         kHig==
X-Forwarded-Encrypted: i=1; AJvYcCWmCP6xps/otg2kdiKrUpEpjFQBIgl9IPfuexxHsmTFfyEp6vIrI8AUgNj5F3U2Y05fA7q1QnRibeoUnBs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPHr5IX1NQfA54fyarWp/a8IU8snpg/8K9UlHofJAFJgeOcjFc
	w7UD51msIO8Qi/bVDGKSqUZpgvp5ovmlnEcfELDByZgs5DRiaxk4Yo3bdSDfbNqw6hAEqWMJFSz
	cIT+AdJG4Fy0Q+njs/zi8GdsUMKHsia4f4BR9PqyseurKmt4PHnJFkRxNA7E9XROl1AY=
X-Gm-Gg: ASbGncuPF8NXoXhcCpg4BiEVXIC8CY2jss4xebJ+iQ3zMKhu9ADyElFWZvi16ynGGwJ
	JMhjt56fneibZYYbafAAbGTndm2H1Uba0qsP3es16sqkGioeYBeCqADYOl/ShHvom1MaHJ/ai6f
	Zxyc2I5kbnywRnrbF71BqtrPr7NXcjKRJj48Cqkp3phVn9/dSFGs8rYX/2iOl8waviOuUXPkLS6
	ErwTfSmAFCgw6trpyVeX0fUC0kKl1BlDr5RqpdiCbKQB25Si1Wdcw5x/ueJXJl4SgK8nH97S7fo
	jLqo7gHHnTdtXdj1NySmfwpQDWpa4qlw3fUvu+eAftn90QMalQYBVtntFfno43ooC3b0nJnpsgw
	EUV4hQS+5GPPLaOE7dukDugDKwBOrvYzvmG5WOtYRX5jvPEg8ZdM9
X-Received: by 2002:a05:6214:62e:b0:768:f173:a0a1 with SMTP id 6a1803df08f44-79919dad1b6mr75240906d6.42.1758382300081;
        Sat, 20 Sep 2025 08:31:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF5J8E1oBMgOvgfZk+xaTiZAs81UEBJOVjkmbbKOqjcN60ku0uMpKtLAmm2ZHJO1n+o1SNXFw==
X-Received: by 2002:a05:6214:62e:b0:768:f173:a0a1 with SMTP id 6a1803df08f44-79919dad1b6mr75240506d6.42.1758382299623;
        Sat, 20 Sep 2025 08:31:39 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-57cb7f53a76sm144778e87.102.2025.09.20.08.31.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Sep 2025 08:31:37 -0700 (PDT)
Date: Sat, 20 Sep 2025 18:31:35 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Wesley Cheng <wesley.cheng@oss.qualcomm.com>
Cc: krzk+dt@kernel.org, conor+dt@kernel.org, kishon@kernel.org,
        vkoul@kernel.org, gregkh@linuxfoundation.org, robh@kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-phy@lists.infradead.org
Subject: Re: [PATCH 6/9] phy: qualcomm: qmp-combo: Update QMP PHY with Glymur
 settings
Message-ID: <kmo2xwxia334fba4nt3eyzijlet7ogv4trxskoog6ymkxmpsi7@2pr2pryaxxgp>
References: <20250920032108.242643-1-wesley.cheng@oss.qualcomm.com>
 <20250920032108.242643-7-wesley.cheng@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250920032108.242643-7-wesley.cheng@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=ZcAdNtVA c=1 sm=1 tr=0 ts=68cec8dd cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=gzIeawRUdsEZb0YUvHYA:9 a=CjuIK1q_8ugA:10
 a=iYH6xdkBrDN1Jqds4HTS:22
X-Proofpoint-ORIG-GUID: PwIyjOi7jyyK6jG4wTj1CnZnIuwrtmJ-
X-Proofpoint-GUID: PwIyjOi7jyyK6jG4wTj1CnZnIuwrtmJ-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIwMDAzMSBTYWx0ZWRfXyKqFjXexOLie
 xJTXw8LdsHvxTY5OSoeWB/dSOIPyUmkn6kzm//dnF1S3E+Czs1A3CfT9RsD2huvNSmUtmYLOJlp
 6mD/bqjuZ+t/yOHkSxeejrAqtiCeF8yqWFmOincRRpMOaWkgzscVlBJxrmtphyTvskJLW1aUb3k
 SLWfGkdHvzrzrpqPbLQmNCT3MV8453wwkDjp5ppuFiCQ/zxvkYVCsjm0cJ04A+8saS+4emulhw5
 q766qpxg8Dilck+idNXI03DEvOvrU9RK0CNPdhjo2Yg/o97Ha84q9Jv2Exk218dCH8Y4T2zhi7q
 nApFKFcuCKoBG9WlPinUarjPCSdlpdhWyW1xCCTT0piu1rmyE8KmvcBfyY1PLARdyCRSJCJUlz7
 gInUQRc/
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-20_06,2025-09-19_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 impostorscore=0 clxscore=1015 bulkscore=0
 phishscore=0 malwarescore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509200031

On Fri, Sep 19, 2025 at 08:21:05PM -0700, Wesley Cheng wrote:
> For SuperSpeed USB to work properly, there is a set of HW settings that
> need to be programmed into the USB blocks within the QMP PHY.  Ensure that
> these settings follow the latest settings mentioned in the HW programming
> guide.  The QMP USB PHY on Glymur is a USB43 based PHY that will have some
> new ways to define certain registers, such as the replacement of TXA/RXA
> and TXB/RXB register sets.  This was replaced with the LALB register set.
> 
> There are also some PHY init updates to modify the PCS MISC register space.
> Without these, the QMP PHY PLL locking fails.
> 
> Signed-off-by: Wesley Cheng <wesley.cheng@oss.qualcomm.com>
> ---
>  drivers/phy/qualcomm/phy-qcom-qmp-combo.c     | 309 ++++++++-
>  .../phy/qualcomm/phy-qcom-qmp-pcs-aon-v8.h    |  17 +
>  .../qualcomm/phy-qcom-qmp-qserdes-lalb-v8.h   | 639 ++++++++++++++++++
>  .../phy/qualcomm/phy-qcom-qmp-usb43-pcs-v8.h  |  33 +
>  .../phy-qcom-qmp-usb43-qserdes-com-v8.h       | 224 ++++++
>  drivers/phy/qualcomm/phy-qcom-qmp.h           |   4 +
>  6 files changed, 1225 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/phy/qualcomm/phy-qcom-qmp-pcs-aon-v8.h
>  create mode 100644 drivers/phy/qualcomm/phy-qcom-qmp-qserdes-lalb-v8.h
>  create mode 100644 drivers/phy/qualcomm/phy-qcom-qmp-usb43-pcs-v8.h
>  create mode 100644 drivers/phy/qualcomm/phy-qcom-qmp-usb43-qserdes-com-v8.h
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry

