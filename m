Return-Path: <linux-kernel+bounces-742398-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F77DB0F13A
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 13:32:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E6DBF1C83C56
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 11:32:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C8312DCBE2;
	Wed, 23 Jul 2025 11:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="MqqsE0j5"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5448A299A84
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 11:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753270312; cv=none; b=he+l3Y2flVYHbmdxDUVO3MktROGQMBP11RWxMt3LUzumRazvgTH3cH31rIvfO/XVR78eqZR5uo2gd/vyZO+HQ8B7IhLGF+rCRUjyH3cRxFVNA1Oo/KurR3PurQPsxOARVoTiaAdpFkxCQ2C0CTeGLZbaYsiAy86bb19WkF0Avlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753270312; c=relaxed/simple;
	bh=pV0VD1Ve0EwcnOI6Dsn5yVqFhYxL60jCXm0cCBSm0b0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a9muAm/PFpuZwVMSqw02VDwaKWuAiHO4ohsTFkEboHBAj3OW54TO4XdZIcz6VSBkr97L8/TfOS89Yu5mFLPEcc5t3Yboq/B9SbWBX0C+Rk+w7O6K8aR+/pMahO0cRrUD9/fR+wNEI2XsLHIjshaA01F1h7zTYOv13aPeGUtTZ80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=MqqsE0j5; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56N9LhOH001765
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 11:31:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	tK5Pqy7KQu9d9+qheXVruzD1mIXvjyuacLXlsOVg6YA=; b=MqqsE0j5IWELOehA
	GF5/LC2Y3Ya9EmwnMJIku3INqfBLrqTgaHa0vnfsP3w27DRp/iPY3R/aN0+cuKh5
	wsSXJUV+bkJ6h4H0b93WSG62VBUDl2DCUA2njpfsDfxMPjKEmIQUV66pLl9faq69
	6cZpPMArjo4bGfEP/d2ImpT9RlpwJGJ8d4o862zkkMRQgjgaeyYl3d8Fzg2mqnsH
	33a2U0RKSx0kwsLBC6i77AVH5Tl7xzPgJYeqsEpubAqTTJ8twclq55DdZyLap4A7
	W3xjBH2GGp5M6/ByxlI3c6KE81TtH+zCwqO8jI3hx2L1/o4M6C50J6UXXUOk0eBR
	ubErGQ==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 481t6w6407-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 11:31:50 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-6fb5720eb48so14829276d6.0
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 04:31:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753270309; x=1753875109;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tK5Pqy7KQu9d9+qheXVruzD1mIXvjyuacLXlsOVg6YA=;
        b=wPmoBBWx70KkJpWPpMwhVFVU4zg/jOJumPaaYMY1/RBPZQucmo7UuryAQIkEuYvocd
         HxJmZxRZLF+Ma6sJOVjSxPyQbYwaD3u2ag1q4EFwwDx/Nf0+9z6qxpsMfjMItnAaKCZj
         c25WtNCt0O0eoMgF7WcnXvJP6UdlUh9p17jifWh+wG9wBUk4ITH9ryg4V6ONWykP4nIO
         c9s7vT3y18nQCmnkaAdFIX48b1cOSxhIihBVq1j8+2N0gWlUKZd+kvFOcQTqOwXJUeQR
         ALbjmYDA9cUGNVonPjGxNLUHVAtvhLbC7+fHCdFkK/sb0fIJwDPavjmOw82bOgx8L4dE
         xxGw==
X-Forwarded-Encrypted: i=1; AJvYcCWcpaMFiqI7mDMFWE+XOXUV/lKWoaIRQvsw0uFjwOfvjSZv0l/gAXq+goE46tl6t+7sGn5HQDqqZL3y8Gg=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywd2kd0DUwkZ3cRzwUAeVZzK+7ZvsVM4Esu2PFOUuomPXClulM2
	LTcKxu/n+B5Jo5hpxZlwPk7j+mXN//Fs4AryVcMCsm2XIRoGZfqTtRtYeKNbHpaTYzGnK/nX3mc
	7CLX93w9pTP7lGKZn18yQ56D7vy0rgupDtmq8+BcJMR3S9pDHLTvb650JjdfXKqvEvG8=
X-Gm-Gg: ASbGnct/QYjIHvWcXI3yj9qyS71jKEXn1DoHGfsVb3rBthS/JcRHyEfnoo9eZMKq2TH
	L1JLKgXtZ0ec2vP2tBX0C+9p97WkvBboMOPNo18bqEGNYhU739o7trRHeBzzqKFrrQtRW2De9/n
	9XUezFlVeISYIoiXvvDu+kGWV1y4wL38bdW6/Ygnz/+1lnFH8vZn+13t6hqMwHzPUMd/c0T4GiN
	3wwPUGyEBISBxIJ6VaZmq8XVYZYEU1VtQ/lJo0V51Bvqqv1w6yFMPSylkAtFNYrevAOpHQAcAwX
	73XOjzF6S+lwBgTHPciL0nn9q7ZHcYfU9i9AU55zdRFaYH4PzHvt4xhk5uf8AB5lkKIsatsucZ9
	tcyjjIYJPsE0Qyiq2Y5Ry8T6wHUfIGO1JTY7cAhSYAyvuVfnybcLw
X-Received: by 2002:a05:6214:20a6:b0:702:c3af:2f44 with SMTP id 6a1803df08f44-706eb94119dmr97079706d6.20.1753270308790;
        Wed, 23 Jul 2025 04:31:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGIZMlMLWLJLVR9CzSUMPV/Lcdv53v0D6YQdORkgTfSC5CVTA/SCOyvECPkVGx3vpwvKDNjmQ==
X-Received: by 2002:a05:6214:20a6:b0:702:c3af:2f44 with SMTP id 6a1803df08f44-706eb94119dmr97079086d6.20.1753270308258;
        Wed, 23 Jul 2025 04:31:48 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-330a91d9747sm19241091fa.78.2025.07.23.04.31.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jul 2025 04:31:47 -0700 (PDT)
Date: Wed, 23 Jul 2025 14:31:45 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: "Yu Zhang(Yuriy)" <yu.zhang@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/2] arm64: dts: qcom: qcs615-ride: add WiFi/BT nodes
Message-ID: <fym6hgenzzpct3kbat4iz42o6nyavfkrp6z5jkf6vjfnwo2u55@of7pgzoxbgej>
References: <20250707-615-v4-0-1a2f74d167d7@oss.qualcomm.com>
 <20250707-615-v4-2-1a2f74d167d7@oss.qualcomm.com>
 <smnw6whsw5todddsoveeanohcaesfip27udzkbw5wk5dwlztzz@ic3xemwrbjwg>
 <a63cab56-2d32-4d38-83f9-911561807e9d@oss.qualcomm.com>
 <7117b159-6743-4db3-9ae5-1cf4ae051601@oss.qualcomm.com>
 <469e2e9c-b950-4ecc-bfa9-82aa9178b65d@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <469e2e9c-b950-4ecc-bfa9-82aa9178b65d@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=SPpCVPvH c=1 sm=1 tr=0 ts=6880c826 cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10
 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=yc11P9gDo9Jt-TL_Xg0A:9 a=3ZKOabzyN94A:10
 a=wPNLvfGTeEIA:10 a=pJ04lnu7RYOZP9TFuWaZ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIzMDA5NyBTYWx0ZWRfX8kFsLJ5/3ene
 XTLYfqE+0kHDWFMBA2X5s50yezpn8wfH9mWQuSfx72t5UVxTb3aIQHdVd2ceM7td7pCMl84473j
 ZxZwZHNDP3A+4N6GTcEaBj1zcCQ+QRZb/RslMFfR9uHGpjio+X2sXAXAoTvI1Y56+buSCPU5ayq
 0eMB7VQnrH2OPNFJOtPwbMrEgqK3BIrtbf/KytLWbpeuHCq/5Zl5+YxvuPvbTg3GYN6jfagWRDN
 urhdL/GwhGjssPuQmlHt6rsdgmt7Bw9w4ubhSv1Kf1h8h/K7+mfnzxZ2dTsR1f+MEuFvqPH85I1
 PKr7Q4SVFGfEQUAGJDoY+2GMNOzgkL5I/5vxuyUldDi8bkkf9y6YoJIj7fGfC1BYe1v4u2O6E4b
 gCfxvTqrsVAG1x9hRCr/S+Amnv2g6WlptJ0gxxbKwuVER7as+I4HCQbv8E0oAY2ZC15yqIJM
X-Proofpoint-ORIG-GUID: rUPjMW4TCv8galPQaPcETPKOrPeGjUCF
X-Proofpoint-GUID: rUPjMW4TCv8galPQaPcETPKOrPeGjUCF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-23_02,2025-07-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 suspectscore=0 adultscore=0 phishscore=0 malwarescore=0
 mlxscore=0 bulkscore=0 clxscore=1015 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 mlxlogscore=999 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507230097

On Wed, Jul 23, 2025 at 10:02:36AM +0800, Yu Zhang(Yuriy) wrote:
> 
> 
> On 7/23/2025 1:36 AM, Dmitry Baryshkov wrote:
> > On 22/07/2025 18:58, Yu Zhang(Yuriy) wrote:
> > > 
> > > 
> > > On 7/19/2025 6:13 PM, Dmitry Baryshkov wrote:
> > > > On Mon, Jul 07, 2025 at 10:51:06AM +0800, Yu Zhang(Yuriy) wrote:
> > > > > Add a node for the PMU module of the WCN6855 present on the qcs615 ride
> > > > > board. Assign its LDO power outputs to the existing WiFi/BT module.
> > > > 
> > > > 
> > > > What is "existing WiFI/BT module"? There is no module in the DT. Not to
> > > > mention that PMU is a part of the WCN6855.
> > > > 
> > > > > 
> > > > > Signed-off-by: Yu Zhang(Yuriy) <yu.zhang@oss.qualcomm.com>
> > > > > ---
> > > > >   arch/arm64/boot/dts/qcom/qcs615-ride.dts | 135
> > > > > +++++++++++++++++++ + +++++++++++
> > > > >   1 file changed, 135 insertions(+)
> > > > > 
> > > > > diff --git a/arch/arm64/boot/dts/qcom/qcs615-ride.dts
> > > > > b/arch/arm64/ boot/dts/qcom/qcs615-ride.dts
> > > > > index 011f8ae077c256f079ce1b07720374a9bf721488..2df8e7e3c1d3b6d6353a6753b8387c7411edd927
> > > > > 100644
> > > > > --- a/arch/arm64/boot/dts/qcom/qcs615-ride.dts
> > > > > +++ b/arch/arm64/boot/dts/qcom/qcs615-ride.dts
> > > > > @@ -18,6 +18,7 @@ aliases {
> > > > >           mmc0 = &sdhc_1;
> > > > >           mmc1 = &sdhc_2;
> > > > >           serial0 = &uart0;
> > > > > +        serial1 = &uart7;
> > > > >       };
> > > > >       chosen {
> > > > > @@ -47,6 +48,85 @@ regulator-usb2-vbus {
> > > > >           enable-active-high;
> > > > >           regulator-always-on;
> > > > >       };
> > > > > +
> > > > > +    vreg_conn_1p8: vreg_conn_1p8 {
> > > > 
> > > > No improvement. Please try again.
> > > > 
> > > you mean should be "vreg_conn_1p8: vreg-conn-1p8",right? I'll update
> > > it,
> > 
> > What is the node name for the previous regulator device? Anything
> > preventing you from following the pattern?
> > 
> Do you mean the prefix 'regulator'?
> I just want to keep 'vreg_conn_1p8' and 'vreg_conn_pa' the same as in
> sa8775p-ride.dtsi, because they're using the same module.

That's a different device. Please use the style of the file that you are
patching.

> 
> > > thanks.>> +        compatible = "regulator-fixed";
> > > > > +        regulator-name = "vreg_conn_1p8";
> > > > > +        startup-delay-us = <4000>;
> > > > > +        enable-active-high;
> > > > > +        gpio = <&pm8150_gpios 1 GPIO_ACTIVE_HIGH>;
> > > > > +    };
> > > > > +
> > > > > +    vreg_conn_pa: vreg_conn_pa {
> > > > > +        compatible = "regulator-fixed";
> > > > > +        regulator-name = "vreg_conn_pa";
> > > > > +        startup-delay-us = <4000>;
> > > > > +        enable-active-high;
> > > > > +        gpio = <&pm8150_gpios 6 GPIO_ACTIVE_HIGH>;
> > > > > +    };
> > > > > +
> > > > 
> > > 
> > 
> > 
> 

-- 
With best wishes
Dmitry

