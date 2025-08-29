Return-Path: <linux-kernel+bounces-792137-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 284C8B3C09E
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 18:25:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 813B658535D
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 16:25:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AC0D32A3D1;
	Fri, 29 Aug 2025 16:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Vx1+Nkfe"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC2B8322DDF
	for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 16:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756484680; cv=none; b=FixXXQtKZgI4nqkGl6KZ2lWsjDds5ImDWjAMRyBVaT1Dz/Lac9vnQ9woI1p8jq1KvxVxE4VULUIdaamj84TrOuYFv0ZyJVuDfdyqt0AM1DEQbebYEVkF0sQiyyfRDvd35HdaTyVvcyRpVvLMUk/YOYgHerpBRqOQAZy3oN4tbHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756484680; c=relaxed/simple;
	bh=3B97zBH4p9jRcLgMlEAc2P4fRn926Py9yl1OWBr7GvA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t6b37/hHenQyUAzdlS2qU8iif9tfUlnuIeNfviONdOtzJeMleSwSSvGohYH/m5khuNnyrjtvdOknbOlfRQX9QP9w39JXHMVk301lWXquk4+QTUHBTiCPms0XcPzUqQ6tQ9G5xZhDy+dMlltgnIDoxb2wQi7b/Aoie1xQ7v+mFtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Vx1+Nkfe; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57TFaWDC011710
	for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 16:24:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	XCIfjiGc29TyHYiTm4KLiwCktBOr1c2fqrZ/oTTcfZo=; b=Vx1+NkfegDhBk6Bf
	fz9QkSj4uQXedF2HcUipcq/YN/IeXx+DvrakGMN4PA8SIbyDMeF/EFY8+SGlJhCM
	hWQuULnOEPwdLEE9OI3kN3J9ENLVFPsOSQGeArClQUEq5AT2HDzNZZXN7cXGDlL2
	XEMstV+DzQaqKeu5+yvsyikbFjzUAsBHRJXkxz/H0qyhjmQUeNxQ4OMXTUVTOAFb
	hw2ZCWfBXFpoFE987qMsXv8Y4aL1WzcICnFpLL76rNO4YL2wqNF+jM2zBcUZCD1y
	MoKNK2FFxccJCt1R8PkBP7U6X615kh7h6V8HaaawsANhi73UCyGASKypSnlclA95
	rWCH/Q==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48rtpf6nn1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 16:24:37 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4b0faa8d615so84620631cf.1
        for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 09:24:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756484677; x=1757089477;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XCIfjiGc29TyHYiTm4KLiwCktBOr1c2fqrZ/oTTcfZo=;
        b=jtilJ9yv4ePM70Y0OrO0si+NkIs87AMiOqWI0MkM/iWU2Mua/DMsbJCPcG5LWMXFVt
         uWu4tFQAouw9kRMxWAbcVS77tXo4+LOVd2ksZisjgLxmzhQdWlOWwnsN/JO/JleGEk7A
         iKX9bgD1wClo03HTFPlXd+KcV7acwS6vPGbdH2zoufRzW4ce1Grz9MSQO6TPmRDBfxiq
         wHw0DDS4JgnFJAWP6ggi8DjWYYDVsCeUGM/LVkoao8oSlsS5PGCHuHL4r51n+jjLVKz2
         E80QOamUa9c9tiAB9SkqrfiQcOAw2qzaNsbjFT1yMKJ5acyp3Xom/WW0drL4xFCsngyY
         i6xg==
X-Forwarded-Encrypted: i=1; AJvYcCXsEW8OrJjDFrIeaHzZUZqt5XOYbvQKFjdc8b4WRlmCia/VV/SzptbJeAFLBg5LXK/us+imGhCyMB20D9E=@vger.kernel.org
X-Gm-Message-State: AOJu0YxkuX7nbpfzuToa4mRyW7X8insU6JTbb8baYhCkvvrwd+qyU6lG
	QSm2xJzfkbvaZbXF4tttYPkqBxLsWnzfrxOJ2z/uKotK0eDAYqr5qpLH6x/uRwDTtfnZWNez5CB
	2Lj7h/MijGoJst17Fuh9Xix/sXM6KcRnqCc0ZK5HXsN3QLrzI2NlqzUlqGfxj85NKr0A=
X-Gm-Gg: ASbGncslPVaPytM3g64TeEiYMl+6wsQQq1bANXc5gRvpCCzupovXZeHaxyzfTVwNeNl
	eDIOV1ryndVSbhdIf4VQMAMTM4+AebL6yPDBeNm4URzg7f8kq4mXTCHlR/MKZTVVS40lsthdeEW
	9smB8DTfy/OZAi7sHRk17y7xTXef/h8CLnsxyKe83vw76H6eeGx+c6yojtsUZAJQTpbojOwNzgh
	qt5vnF69UrcOU8J3VguXIx7j1x24hTNzFFptYinClkIj7SXsDkwsHsHqOgZc626C0d3QwsklyZd
	Qy6M09PdLuj7hiogTIr94c4WlN4aZ+yrkXDq5GYr7iDTb+1d/hRZs2DF44CQgeFeBtTbg3KZ3jM
	MJ/5VJH+WBiXGv3d64vodfJEGTunGicsfg2169Y6XXgDgYCtQlX60
X-Received: by 2002:a05:622a:2c1:b0:4af:bfd:82bf with SMTP id d75a77b69052e-4b2e76f6c2fmr159959981cf.17.1756484676376;
        Fri, 29 Aug 2025 09:24:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG3avH1Zre9WfCU8qCI5LcLOBiCx7PfjvDuQh+HklBIJkQz+ZtJjjyCJREb1zAER0kzRP6i/A==
X-Received: by 2002:a05:622a:2c1:b0:4af:bfd:82bf with SMTP id d75a77b69052e-4b2e76f6c2fmr159959551cf.17.1756484675754;
        Fri, 29 Aug 2025 09:24:35 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55f678450dfsm713370e87.72.2025.08.29.09.24.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Aug 2025 09:24:34 -0700 (PDT)
Date: Fri, 29 Aug 2025 19:24:32 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Monish Chunara <quic_mchunara@quicinc.com>
Cc: Sushrut Shree Trivedi <quic_sushruts@quicinc.com>,
        Wasim Nazir <wasim.nazir@oss.qualcomm.com>,
        Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Richard Cochran <richardcochran@gmail.com>, kernel@oss.qualcomm.com,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        netdev@vger.kernel.org,
        Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>,
        Nirmesh Kumar Singh <quic_nkumarsi@quicinc.com>,
        Krishna Kurapati <krishna.kurapati@oss.qualcomm.com>,
        Mohd Ayaan Anwar <quic_mohdayaa@quicinc.com>,
        Dikshita Agarwal <quic_dikshita@quicinc.com>,
        Vishal Kumar Pal <quic_vispal@quicinc.com>
Subject: Re: [PATCH 3/5] arm64: dts: qcom: lemans-evk: Extend peripheral and
 subsystem support
Message-ID: <ozkebjk6gfgnootoyqklu5tqj7a7lgrm34xbag7yhdwn5xfpcj@zpwr6leefs3l>
References: <20250826-lemans-evk-bu-v1-0-08016e0d3ce5@oss.qualcomm.com>
 <20250826-lemans-evk-bu-v1-3-08016e0d3ce5@oss.qualcomm.com>
 <kycmxk3qag7uigoiitzcxcak22cewdv253fazgaidjcnzgzlkz@htrh22msxteq>
 <3f94ccc8-ac8a-4c62-8ac6-93dd603dcd36@quicinc.com>
 <zys26seraohh3gv2kl3eb3rd5pdo3y5vpfw6yxv6a7y55hpaux@myzhufokyorh>
 <aLG3SbD1JNULED20@hu-mchunara-hyd.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aLG3SbD1JNULED20@hu-mchunara-hyd.qualcomm.com>
X-Proofpoint-GUID: LUDC4F8AL8grfUW8AzRt6dtGUmncWGyC
X-Proofpoint-ORIG-GUID: LUDC4F8AL8grfUW8AzRt6dtGUmncWGyC
X-Authority-Analysis: v=2.4 cv=Hd8UTjE8 c=1 sm=1 tr=0 ts=68b1d445 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10
 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=COk6AnOGAAAA:8 a=YDAz1v9_iDTVm1Y559YA:9
 a=3ZKOabzyN94A:10 a=wPNLvfGTeEIA:10 a=kacYvNCVWA4VmyqE58fU:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODI1MDE0MiBTYWx0ZWRfX6MdAtFLTZygk
 V7O5kXZsaloohcmcfZsRmDVtxYnqy2YbjoKGWkOKiiUSr8dvH4UjeYWa+tQlymD/aQCXcl4OYrq
 fbtZN4rRhx8ikpaHq2FCMQ+kOsbGaXWZN1V4d0flFT9rphoEoeMMC/LgmbE1KcAoXt/Mce9FjHU
 IUOKX0uf5L/smXHsK2bv1TD5wx2wLuENdmT4ucgAJJcVfB+bWj24na5OOB1FYi3Q4V9TwZr5DUt
 V4WQJVohJgAF+tuoiiHIT7LFhOxCjXi6OCSjEKkufueXp5Rfut4lkxOCI9luVH6VCIzSDih+ONf
 YecXa4pJ5SNaVZJbo636fhbF4f/xppIanHqIt7eikbSybiocWy6qv5C+GdWVbpfuTmgI0WagKFr
 edy1m9lT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-29_06,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0
 adultscore=0 clxscore=1015 impostorscore=0 spamscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508250142

On Fri, Aug 29, 2025 at 07:50:57PM +0530, Monish Chunara wrote:
> On Thu, Aug 28, 2025 at 04:30:00PM +0300, Dmitry Baryshkov wrote:
> > On Thu, Aug 28, 2025 at 06:38:03PM +0530, Sushrut Shree Trivedi wrote:
> > > 
> > > On 8/27/2025 7:05 AM, Dmitry Baryshkov wrote:
> > > > On Tue, Aug 26, 2025 at 11:51:02PM +0530, Wasim Nazir wrote:
> > > > > Enhance the Qualcomm Lemans EVK board file to support essential
> > > > > peripherals and improve overall hardware capabilities, as
> > > > > outlined below:
> > > > >    - Enable GPI (Generic Peripheral Interface) DMA-0/1/2 and QUPv3-0/2
> > > > >      controllers to facilitate DMA and peripheral communication.
> > > > >    - Add support for PCIe-0/1, including required regulators and PHYs,
> > > > >      to enable high-speed external device connectivity.
> > > > >    - Integrate the TCA9534 I/O expander via I2C to provide 8 additional
> > > > >      GPIO lines for extended I/O functionality.
> > > > >    - Enable the USB0 controller in device mode to support USB peripheral
> > > > >      operations.
> > > > >    - Activate remoteproc subsystems for supported DSPs such as Audio DSP,
> > > > >      Compute DSP-0/1 and Generic DSP-0/1, along with their corresponding
> > > > >      firmware.
> > > > >    - Configure nvmem-layout on the I2C EEPROM to store data for Ethernet
> > > > >      and other consumers.
> > > > >    - Enable the QCA8081 2.5G Ethernet PHY on port-0 and expose the
> > > > >      Ethernet MAC address via nvmem for network configuration.
> > > > >      It depends on CONFIG_QCA808X_PHY to use QCA8081 PHY.
> > > > >    - Add support for the Iris video decoder, including the required
> > > > >      firmware, to enable video decoding capabilities.
> > > > >    - Enable SD-card slot on SDHC.
> > > > > 
> > > > > Co-developed-by: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
> > > > > Signed-off-by: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
> > > > > Co-developed-by: Sushrut Shree Trivedi <quic_sushruts@quicinc.com>
> > > > > Signed-off-by: Sushrut Shree Trivedi <quic_sushruts@quicinc.com>
> > > > > Co-developed-by: Nirmesh Kumar Singh <quic_nkumarsi@quicinc.com>
> > > > > Signed-off-by: Nirmesh Kumar Singh <quic_nkumarsi@quicinc.com>
> > > > > Co-developed-by: Krishna Kurapati <krishna.kurapati@oss.qualcomm.com>
> > > > > Signed-off-by: Krishna Kurapati <krishna.kurapati@oss.qualcomm.com>
> > > > > Co-developed-by: Mohd Ayaan Anwar <quic_mohdayaa@quicinc.com>
> > > > > Signed-off-by: Mohd Ayaan Anwar <quic_mohdayaa@quicinc.com>
> > > > > Co-developed-by: Dikshita Agarwal <quic_dikshita@quicinc.com>
> > > > > Signed-off-by: Dikshita Agarwal <quic_dikshita@quicinc.com>
> > > > > Co-developed-by: Monish Chunara <quic_mchunara@quicinc.com>
> > > > > Signed-off-by: Monish Chunara <quic_mchunara@quicinc.com>
> > > > > Co-developed-by: Vishal Kumar Pal <quic_vispal@quicinc.com>
> > > > > Signed-off-by: Vishal Kumar Pal <quic_vispal@quicinc.com>
> > > > > Signed-off-by: Wasim Nazir <wasim.nazir@oss.qualcomm.com>
> > > > > ---
> > > > >   arch/arm64/boot/dts/qcom/lemans-evk.dts | 387 ++++++++++++++++++++++++++++++++
> > > > >   1 file changed, 387 insertions(+)
> > > > > 
> > > > 
> > > > > @@ -356,6 +720,29 @@ &ufs_mem_phy {
> > > > >   	status = "okay";
> > > > >   };
> > > > > +&usb_0 {
> > > > > +	status = "okay";
> > > > > +};
> > > > > +
> > > > > +&usb_0_dwc3 {
> > > > > +	dr_mode = "peripheral";
> > > > Is it actually peripheral-only?
> > > 
> > > Hi Dmitry,
> > > 
> > > HW supports OTG mode also, but for enabling OTG we need below mentioned
> > > driver changes in dwc3-qcom.c :
> > 
> > Is it the USB-C port? If so, then you should likely be using some form
> > of the Type-C port manager (in software or in hardware). These platforms
> > usually use pmic-glink in order to handle USB-C.
> > 
> > Or is it micro-USB-OTG port?
> > 
> 
> Yes, it is a USB Type-C port for usb0 and we are using a 3rd party Type-C port
> controller for the same. Will be enabling relevant dts node as part of OTG
> enablement once driver changes are in place.

Which controller are you using? In the existing designs USB-C works
without extra patches for the DWC3 controller.

> 
> > > 
> > > a) dwc3 core callback registration by dwc3 glue driver; this change is under
> > >     review in upstream.
> > > b) vbus supply enablement for host mode; this change is yet to be submitted
> > >     to upstream.
> > > 
> > > Post the above mentioned driver changes, we are planning to enable OTG on
> > > usb0.

-- 
With best wishes
Dmitry

