Return-Path: <linux-kernel+bounces-831660-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 72452B9D435
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 04:59:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 296553B91DE
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 02:59:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB8512E6CBB;
	Thu, 25 Sep 2025 02:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ecY1Uw/t"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B90FD2E6112
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 02:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758769146; cv=none; b=e8OJ4TSxvdvBPZP9Pps1P533OmLALrTbkfC2D1ro5M0KdO3/CUePCKdlJ611XIiFTr4z4ERJLpL0vPzIoYN+u8t8aIa0YPWJLEbDUz0AsPgL2IOw7g4ODAPyfO6cyGPnhAEOqx85V76QnAclB6TqKIRw2KCWHrEkdA32vWeCYyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758769146; c=relaxed/simple;
	bh=rMdx9u4+CPZdlaDXxIrAkulEp2MNorpZN4qQed5m6F8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mep+5SF1rVNeHOAXTw0CIw0PyA9GEZcjA1BrhlPDNWGpPCNy0HGFIAziYsboWONjLevktc/SdNAGIeLaIf1FNYrd2B8xcAQGDJ+/zqNZFmum8YFoHQnwXfRp0/UVTeTWBSup4KGtLhaa2FPkuleAXRYaSXX67h5UcY5aZgPfkSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ecY1Uw/t; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58P1B9jO003835
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 02:59:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=YVhIbwN6AspjG/ncbcs2oWej
	SClutNyLdf6oqsabWes=; b=ecY1Uw/tmpiKZ43veGA4miv+hG7rVv5z2SRAJt/F
	EQqTuFKj/yjj2QfelvNwiNA6Xks+kSz4+BaNM+VoqZ3EkPbiUXhkFIo0gdlIR1J6
	hu1rOiFbl1DjPTxo7FLgTdVOlR1WUuk0e1Osl9XL7qwjXSavTlTCYSWn6Dm+UpKY
	vAoAxheZQ7swzYArZYtpvs/bv2ZahmV25s+sMY5SAgbRQU/JvG8RRXmdOn1MD/aW
	nSj70Vg0RRX5k1zQefbDqTigNuTmbqAXJcKetlf6yHxal43YCDyZJIEITb6nJ1PG
	HW13iuaKoCsstPGToliG9G4BikT+U22WU/tLP9BuYK/Xyw==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49bajf126r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 02:59:04 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4ca4eeb9b06so11478681cf.2
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 19:59:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758769143; x=1759373943;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YVhIbwN6AspjG/ncbcs2oWejSClutNyLdf6oqsabWes=;
        b=RlWqVH+NZEq/Kf0Ra85ES2PseiZjtwAJVaeymxMhI07uxaTEIdbczY2xwKfliDHTvc
         NrTR7s8RscVgHSqYTOAmtqZR0ndGU1mDXfOYwfUjgSsrI/tPLMrr3fV/t138H3DpfEOK
         2geDSqdsn2sqjnHD+u0ynRE4cGdXCt+Q6Kw1Uwkoz0SHqfp9qYJV8FhtgtMOE6mFsyT+
         PXeLlY5ECUf0N24ef0vZ0KmFnvZWaJY1pli9nwtsqad9wTVKKIMqc+V641i79AgXmRgQ
         e8IsS2XFtsF67ftyA4+7tZcbjmH1UI+eX9hutmFKzdp5wOJWDwniIduhO8i9/3dFY8T/
         LPkg==
X-Forwarded-Encrypted: i=1; AJvYcCVowo62iKkmxM+xHPa6d36kIDK3g5agA3hp0d393faWYoQSw8gCAQOnFmpCYshTgiODjXKVpH9V9ABjS2g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxt8y4gvk9pPS7HeGaDJ2PXUBn3TQ3SZdVFWiy4kQpqWM3m7m34
	mAJbhsG/qdzPWYJcNqY7pRQcoHycpPNsebA5MeMKyv2hbTosjo36QSx/0i6dSmiJEsS1+e5XJ8g
	hJlOfY94X1QIox1PRwrWoMvVhG3jPCEyocpQWo2rw/t32RM3IsOHVSv6+Q2m8OmeHGfo=
X-Gm-Gg: ASbGnctUt4YZQAnTEDoi0r+YmJatr8XyXnHq440+RSTR3Xf9oPHE2nJugymFcRBYxnq
	AoF+SJeHpqqUgn9QnU7weln3o/wVYATHqMu43DANcoAjdeXVgW7ChCyhN6mlBea8hJ0mlCQsX55
	LLqdqTCCu+LA0D5RP8AN0olW8QfsQvbgx5RB9hzOPX2PCUsKTWxTSpFwVnHF0r690GpcdR7+z2O
	FXkBDUMewqDioSlm4DFQTpfHztm6kHxxssqI53n2jKoJWeJnBFDmA4B5Ez85tiUGA5Ni0BxgHmb
	s+UgulHT2oVPf4K9RHkWrQY3qUNKyeuap/LVMCXJ9fdu7h0xWl8iVKywPol5FZsxjyXATHx9wIN
	df+ko3OPDvQI4l5U9fkVIZzOtC4LE/DjGZrGuPFYkqVBMjl+VaOLY
X-Received: by 2002:ac8:590b:0:b0:4b7:b2c5:c61a with SMTP id d75a77b69052e-4da4d21edc4mr25364061cf.83.1758769142411;
        Wed, 24 Sep 2025 19:59:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF1XnTbfMNHcgRcbCrb+1DBR8eHmzim3EHHlWAZftE/lw4akJE2YkN9j6quohmLlN7TXR0gww==
X-Received: by 2002:ac8:590b:0:b0:4b7:b2c5:c61a with SMTP id d75a77b69052e-4da4d21edc4mr25363851cf.83.1758769141924;
        Wed, 24 Sep 2025 19:59:01 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-58316656989sm267325e87.90.2025.09.24.19.58.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 19:59:01 -0700 (PDT)
Date: Thu, 25 Sep 2025 05:58:58 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Wesley Cheng <wesley.cheng@oss.qualcomm.com>
Cc: krzk+dt@kernel.org, conor+dt@kernel.org, kishon@kernel.org,
        vkoul@kernel.org, gregkh@linuxfoundation.org, robh@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 02/10] dt-bindings: phy: qcom,qmp-usb: Add Glymur USB
 UNI PHY compatible
Message-ID: <p2deqsamovmrcijqhmcss2766owsxfyz7v2uk3mxd5du6e6tse@uo5q2iqwjxj2>
References: <20250925005228.4035927-1-wesley.cheng@oss.qualcomm.com>
 <20250925005228.4035927-3-wesley.cheng@oss.qualcomm.com>
 <5mwqf4djs2jee4x6edplwmd5ugucoi4wazrzjoiw2p5ndiv6h2@6xqnnavp2a4i>
 <efa5ed28-674c-6a30-eff3-eadc650ed6ea@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <efa5ed28-674c-6a30-eff3-eadc650ed6ea@oss.qualcomm.com>
X-Proofpoint-GUID: 9xCTvktz67LH8quTewaMhFH_eRx4dplE
X-Authority-Analysis: v=2.4 cv=fY2ty1QF c=1 sm=1 tr=0 ts=68d4aff8 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=6Hf86mc1Aoj0dGmY1zEA:9 a=CjuIK1q_8ugA:10
 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIyMDE2OCBTYWx0ZWRfX10I9vtWygZSV
 88UxDOS0NHtjKBbY/+XA4tCU9K9IKqjOBMkfy+nTj2UZE8YebUK9clKqyMKWca8BRUjsd8AJA5/
 4TnnOIB1CFgyTzozEOjgYAQEyXtrMB1ywx+GYBdYrCf072GgvKpLL1qsQDJaJA9R8Ry6Il/+7b3
 spbdvt49IjfRyk8EN5P1W+ycAkcd1QS7dL0A12vhCKDUwGa1M5KGWmGYmfVdrUbCrMwEguxpReI
 4DxThrYWznHMYV+VebJIZ1Ib4UIp+hDKPEmIcAhDSdSALGRX/SvTIMDca4ktjQMXK5w8DOI57gR
 ZEiS2BMDEiz6r6G+dBgE/wR91kf4F2S/qpR6Gdc0igJd0VquP1OcOstGXmvXBNFInyXYAanfKk5
 fzlNnhQs
X-Proofpoint-ORIG-GUID: 9xCTvktz67LH8quTewaMhFH_eRx4dplE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-24_07,2025-09-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 spamscore=0 adultscore=0 impostorscore=0
 phishscore=0 bulkscore=0 priorityscore=1501 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509220168

On Wed, Sep 24, 2025 at 07:12:36PM -0700, Wesley Cheng wrote:
> 
> 
> On 9/24/2025 6:12 PM, Dmitry Baryshkov wrote:
> > On Wed, Sep 24, 2025 at 05:52:20PM -0700, Wesley Cheng wrote:
> > > The Glymur USB subsystem contains a multiport controller, which utilizes
> > > two QMP UNI PHYs.  Add the proper compatible string for the Glymur SoC.
> > > 
> > > Signed-off-by: Wesley Cheng <wesley.cheng@oss.qualcomm.com>
> > > ---
> > >   .../phy/qcom,sc8280xp-qmp-usb3-uni-phy.yaml   | 35 +++++++++++++++++++
> > >   1 file changed, 35 insertions(+)
> > > 
> > > diff --git a/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-usb3-uni-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-usb3-uni-phy.yaml
> > > index a1b55168e050..b0ce803d2b49 100644
> > > --- a/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-usb3-uni-phy.yaml
> > > +++ b/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-usb3-uni-phy.yaml
> > > @@ -16,6 +16,7 @@ description:
> > >   properties:
> > >     compatible:
> > >       enum:
> > > +      - qcom,glymur-qmp-usb3-uni-phy
> > >         - qcom,ipq5424-qmp-usb3-phy
> > >         - qcom,ipq6018-qmp-usb3-phy
> > >         - qcom,ipq8074-qmp-usb3-phy
> > > @@ -62,6 +63,8 @@ properties:
> > >     vdda-pll-supply: true
> > > +  refgen-supply: true
> > 
> > Which device is going to provide this supply?
> > 
> 
> This is just a pmic regulator.

Ack, thanks.

> 
> Thanks
> Wesley Cheng
> 
> > > +
> > >     "#clock-cells":
> > >       const: 0
> > 

-- 
With best wishes
Dmitry

