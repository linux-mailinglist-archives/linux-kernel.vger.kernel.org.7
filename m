Return-Path: <linux-kernel+bounces-750785-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1BC3B1610A
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 15:08:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D61B35A6CC9
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 13:08:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3890929A332;
	Wed, 30 Jul 2025 13:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="FCRsIt/u"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9C60DDC1
	for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 13:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753880894; cv=none; b=MX45XIKGu/i2USMlMIXxAjmpD3Qm6WK0GHK867hFKhAIRvV5gWbzt05yXw6ywiZF/LSNmkdwM16TkHx/JFAshg7US1Xx1HK4Cs8yX/nt5FJgax2tOCI/o3bJVQDPQhrqkI2u3fV/f7Y8s6mwDZbxki+5l4RONa66GmPP1YFtQj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753880894; c=relaxed/simple;
	bh=utYzFVLTObmPxGSlUuHvJFOCt7DjeX6wik+KDLimSyA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sL6C412ac3Y5GLLdVJw2RLQMdOhuHX9xm5s3KiFyNJ8vBKG1e0VIQLfSo5gB6ToCdwebq5HcL4XkKmp8qaZfq6vRRI5ikmnsaq9mlTk+RVEr851mcsZHu4gZY4GCWGeJhIxfab7MJpEOtJTUpLihhaor+Xrm+s42WjlvnUId6mM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=FCRsIt/u; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56UCb8j3017592
	for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 13:08:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=rCoCba3PaUuakN2dddfrr36z
	ZpUe2mMvVXboTEOCYoE=; b=FCRsIt/uDiAJa5REs5cKwMn7O0aF9XVlsTRTnpWG
	BpY6aAHc1kYOI9RLjM5cUn1Jk0cUj0rBH+tkINWMZfcSbRcCjuWRG/O1cUTK+86a
	1gMqfJo9mJWrfwS2UoBjsvAX6XvLGTW9wHXClWeb5d6Pmu3mMuWuIuB3436cAEeh
	QpGb2A2kH0Mu24U3jVuNJm7YwlN4ijxfWHJrnLTfOR2iFMoCYAtvyWHFnEQamMcb
	7WjXnK3fzagFO7XMgCK1397GX31vpWJYDv4TRpBf/8SyQAQX3oRYbyzVIN0R/R33
	fUgfCC3pxGczAfZ0r/YDyiaUwgUPNvHVdd7M/b/rXBkWvQ==
Received: from mail-oo1-f69.google.com (mail-oo1-f69.google.com [209.85.161.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 484qda3rhu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 13:08:11 +0000 (GMT)
Received: by mail-oo1-f69.google.com with SMTP id 006d021491bc7-615a73729bfso855358eaf.0
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 06:08:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753880891; x=1754485691;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rCoCba3PaUuakN2dddfrr36zZpUe2mMvVXboTEOCYoE=;
        b=R5D8b/3j9EfRLJnaUvQDU7fH/VxZrNjNqawtYJmtbUDccko4GcJFYPIReZHscTwvG9
         XJqlWBcu6sLiJAOvwdcAO4k/67WNOFZiRIl0wU6f2lFkM/lj6RTLrTeBVhijzoKPFXdd
         N8ZX5s7fLEqBRamvjRiRitr7TpltBnF9uzpyGdZTLp311dbVhvggSndpE6SJRxL3bWwD
         fzVCYQPNNQ3nN4eVIsQKUFPLwHUXvG9AdgN3HHj8LoC5tkTVbkLwA90n+QEeVon8XRyx
         4pMrp81IQlvSX72TntGuERRoaOjlEXkCQthEW1kThs1fQlkiGkOXoWONO9AqCmsKvciK
         DyAg==
X-Forwarded-Encrypted: i=1; AJvYcCVrfbXsucnQkYaxi13wpApMdOKIey1oZ2Hx+A05tQcOPwOVNuwbqHGOf9BVKXPbWV0kgYc6kaGqI7n2TJ8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyAS30cjPsg77/gnpYqpw8CDMUZkkuuYW/TJYBlnPYjdC0IQ6eQ
	HGFHCkZuIuyao8Ah0OS4FAT5FzwiS/ITTwbMnBaPVM1flsEAYH2CawdOmUYD+Ic7TaefMb3DJjm
	vkuPIWlJNpP/ueENKBkzLEwiqJ7ygO4FO2aLEU9oJwgsysfiT3D/8QfNKj4g6fqO4r/k=
X-Gm-Gg: ASbGncvYEF4U9cxfoJxx1oX8ayaIKxvmOYiEHRgZ7tnxm/+0iOalTp+X9KnlVJetIwE
	KVFc0NVQ4NyMO6op6MRoTO/ZiBNUaN3s2B3CYcjFGWi+SvZ/iKlUuww53SQ39DUavjKz05Mqyb9
	Y3Fv54zciRUd2mwgzBQgxEu9K7YQKZ9xkQlc5HAjzArC5rI07nFaGX29LaVc5yoIjwxe9rHFVU7
	lA4nuXH4snIWYX0Qms0rqc0S0QhyMsI90u+QLJuautFCkRTIpWxZ72Z0KkvBg2GOUl2ymlpIINZ
	u7piSCr+mTj0vCu2ibKPBngv5e+TDEa9ydUQcZ6r6CPCW8wURzvRQKY0FYk5N10ZKZZq1DbhbK1
	N1fSUAXQNir/nTJV0RRVL0AqcKhCKFsFDB42OkXYFwgSiI+21Ki1d
X-Received: by 2002:a05:6808:509e:b0:40d:75bd:69d1 with SMTP id 5614622812f47-431994bf2b8mr2318493b6e.7.1753880890760;
        Wed, 30 Jul 2025 06:08:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEreN+EZPMsIb55Cu4XOPM4kHBtS5bQnw9CIRJxKiJf+cZor2FwqzapYkfyd+2FT5moObUVmA==
X-Received: by 2002:a05:6808:509e:b0:40d:75bd:69d1 with SMTP id 5614622812f47-431994bf2b8mr2318193b6e.7.1753880887445;
        Wed, 30 Jul 2025 06:08:07 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55b79c32a10sm497780e87.106.2025.07.30.06.08.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Jul 2025 06:08:05 -0700 (PDT)
Date: Wed, 30 Jul 2025 16:08:03 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: Ayushi Makhija <quic_amakhija@quicinc.com>, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, robdclark@gmail.com, lumag@kernel.org,
        sean@poorly.run, marijn.suijten@somainline.org, airlied@gmail.com,
        simona@ffwll.ch, quic_rajeevny@quicinc.com, quic_vproddut@quicinc.com,
        quic_jesszhan@quicinc.com
Subject: Re: [PATCH] drm/msm: update the high bitfield of certain DSI
 registers
Message-ID: <nxayk52mhisyipdsbf5rykuynpg45mk5y5ykqxh76vzyxb6exy@h3qwqdgviumb>
References: <20250730123938.1038640-1-quic_amakhija@quicinc.com>
 <74e3836e-af29-4b5f-b644-23bdff084c78@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <74e3836e-af29-4b5f-b644-23bdff084c78@oss.qualcomm.com>
X-Proofpoint-ORIG-GUID: ZiZFXMhQ1yTUNCD5yL-GofVxc8zoWt-4
X-Authority-Analysis: v=2.4 cv=Pfv/hjhd c=1 sm=1 tr=0 ts=688a193b cx=c_pps
 a=lVi5GcDxkcJcfCmEjVJoaw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Wb1JkmetP80A:10 a=e5mUnYsNAAAA:8 a=COk6AnOGAAAA:8 a=-gjihLczPamKDhiB-eEA:9
 a=CjuIK1q_8ugA:10 a=rBiNkAWo9uy_4UTK5NWh:22 a=Vxmtnl_E_bksehYqCbjh:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: ZiZFXMhQ1yTUNCD5yL-GofVxc8zoWt-4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzMwMDA5NCBTYWx0ZWRfX0BIMifxOGa3E
 7hbXvWk8MThRuqLMabf4/Oqd/NCG7TdOjHhxKpoBoohgVnd8I1p9ahEbByHkqdsmvGD12HZswXj
 yCaJqOjxiwQ/lWvcZttf+9ucoskDLjr5b7E7mHw841pfvXM0gj3CKKBjpwIcbpn+MxdGWWECAqN
 UE3/LsF37/5HN7Vgj992tdAL/nskTNKvluwiBBYyGGGt5j91oB0YTi9qUy1T9w+T/vaNcZ3E3gV
 oajwHBGGDt5q97nGikP3b1h5dpWgkdTWC/QX8exbJbnPyqa7lGprbQp5Pd3FgoExqx7l3EFMJcq
 qo9RzxCFM5S1fI6QjDpshmCSVT6t9mJ2m8rSkCdapmMMkWMCGA0yPBKxURjCBXE1RPGGGtKozcV
 FuxKX+aC7bhWraiuSIJDGDKx6cBsgimeCA9mKU7aok3IEFPoC01F0NvlM3dNxoBStNRE9mSE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-30_04,2025-07-30_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=913 clxscore=1015 adultscore=0 priorityscore=1501 mlxscore=0
 spamscore=0 suspectscore=0 phishscore=0 lowpriorityscore=0 malwarescore=0
 impostorscore=0 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507300094

On Wed, Jul 30, 2025 at 02:45:13PM +0200, Konrad Dybcio wrote:
> On 7/30/25 2:39 PM, Ayushi Makhija wrote:
> > Currently, the high bitfield of certain DSI registers
> > do not align with the configuration of the SWI registers
> > description. This can lead to wrong programming these DSI
> > registers, for example for 4k resloution where H_TOTAL is
> > taking 13 bits but software is programming only 12 bits
> > because of the incorrect bitmask for H_TOTAL bitfeild,
> > this is causing DSI FIFO errors. To resolve this issue,
> > increase the high bitfield of the DSI registers from 12 bits
> > to 16 bits in dsi.xml to match the SWI register configuration.
> > 
> > Signed-off-by: Ayushi Makhija <quic_amakhija@quicinc.com>
> > ---
> >  drivers/gpu/drm/msm/registers/display/dsi.xml | 28 +++++++++----------
> >  1 file changed, 14 insertions(+), 14 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/msm/registers/display/dsi.xml b/drivers/gpu/drm/msm/registers/display/dsi.xml
> > index 501ffc585a9f..c7a7b633d747 100644
> > --- a/drivers/gpu/drm/msm/registers/display/dsi.xml
> > +++ b/drivers/gpu/drm/msm/registers/display/dsi.xml
> > @@ -159,28 +159,28 @@ xsi:schemaLocation="https://gitlab.freedesktop.org/freedreno/ rules-fd.xsd">
> >  		<bitfield name="RGB_SWAP" low="12" high="14" type="dsi_rgb_swap"/>
> >  	</reg32>
> >  	<reg32 offset="0x00020" name="ACTIVE_H">
> > -		<bitfield name="START" low="0" high="11" type="uint"/>
> > -		<bitfield name="END" low="16" high="27" type="uint"/>
> > +		<bitfield name="START" low="0" high="15" type="uint"/>
> > +		<bitfield name="END" low="16" high="31" type="uint"/>
> >  	</reg32>
> >  	<reg32 offset="0x00024" name="ACTIVE_V">
> > -		<bitfield name="START" low="0" high="11" type="uint"/>
> > -		<bitfield name="END" low="16" high="27" type="uint"/>
> > +		<bitfield name="START" low="0" high="15" type="uint"/>
> > +		<bitfield name="END" low="16" high="31" type="uint"/>
> >  	</reg32>
> >  	<reg32 offset="0x00028" name="TOTAL">
> > -		<bitfield name="H_TOTAL" low="0" high="11" type="uint"/>
> > -		<bitfield name="V_TOTAL" low="16" high="27" type="uint"/>
> > +		<bitfield name="H_TOTAL" low="0" high="15" type="uint"/>
> > +		<bitfield name="V_TOTAL" low="16" high="31" type="uint"/>
> >  	</reg32>
> >  	<reg32 offset="0x0002c" name="ACTIVE_HSYNC">
> > -		<bitfield name="START" low="0" high="11" type="uint"/>
> > -		<bitfield name="END" low="16" high="27" type="uint"/>
> > +		<bitfield name="START" low="0" high="15" type="uint"/>
> > +		<bitfield name="END" low="16" high="31" type="uint"/>
> >  	</reg32>
> >  	<reg32 offset="0x00030" name="ACTIVE_VSYNC_HPOS">
> > -		<bitfield name="START" low="0" high="11" type="uint"/>
> > -		<bitfield name="END" low="16" high="27" type="uint"/>
> > +		<bitfield name="START" low="0" high="15" type="uint"/>
> > +		<bitfield name="END" low="16" high="31" type="uint"/>
> >  	</reg32>
> >  	<reg32 offset="0x00034" name="ACTIVE_VSYNC_VPOS">
> 
> FWIW looks like at least on 8280, ACTIVE_VSYNC_HPOS offset = 0x38
> and HPOS doesn't exist

All registers here are shifted by 0x4 for historical and practical
reasons.

-- 
With best wishes
Dmitry

