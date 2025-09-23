Return-Path: <linux-kernel+bounces-828184-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AE67B94208
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 05:40:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 434BA2E0A44
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 03:40:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BBA19478;
	Tue, 23 Sep 2025 03:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="GrcfXbjc"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D77826158C
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 03:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758598831; cv=none; b=l2cWiOJAyBNp7/ethU8asCIv0hkpgpPwPi9KHXXwToPkr31XGOqQqh87m9Zhr0pR67KJaf7qopJJmGd86SQNTuLDwp7xxiSXR3XctmVKFpwjnXJbpZxakZTsDiBq50gY+bIBYJ3Bg2Yr+5J8v2cx1vhJ+PrvEde/llLI8JroopU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758598831; c=relaxed/simple;
	bh=RIFtvGLBGwCMhWoFPhqwXhmEvVfxHYS/e72rWoa6NKc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iKfcDgKZlOCnRz6CrJtzUcuNHZRZTeUe2RQ6rPF7J97C0+aGyW07EBbOChPihXxGwHb4v3W6kYVk9dJWOsNI4trYb16VnCZ8gDb6TbJ61FWLkV5mx5zWsHtMh7JJ7tYaK+2nQC26XjqVk1MEBk/Y2nun5LBV6EsOUnxZhd8X4hI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=GrcfXbjc; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58MH6AVc027935
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 03:40:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=44R9e51x+lVSRbLCMDK2omE3
	gm86owMK321JGxNDCZ4=; b=GrcfXbjcft+KDX5rOioBeyIiyuuqRWRb22/4wGGj
	9IDth+Cuqg0IJXK2U9RuJ7WYQipxD1hU9fTwsGjfS/tti1aLTPCLMyRrZpElRf1a
	0gbTgp0bPdnKDcNALDm1Zz4WOT0/1cSx9GRnWtnf8kFxC82JuGqqOB871am5RqoE
	XMJc+zSyoyZOsRuVAhaCJ5HXNSaKJ/706XMvy9ELY88VmQ37lGBtZ+//2fJOWP61
	pnMX+3oFXvWPQnzp/M7qwHAEQOG5uygeAzqloJ54MJpbMxm2Xbyuu0enJSkfxHko
	eIaN591wcQKQrBxCD1hpsnK9WxOY/XjK5krMQVFB9RM+xw==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49bajesf9p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 03:40:29 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-78f2b1bacfcso83284836d6.3
        for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 20:40:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758598828; x=1759203628;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=44R9e51x+lVSRbLCMDK2omE3gm86owMK321JGxNDCZ4=;
        b=LkpptYNGA+2BZ4Dh3kBRW1DBUotEE9e3CduIH2Sr8YqrEhzwgQM1VZoMrPyE5C7Qb4
         9F+LB6gvJgHKrID7DjUq2Lsn2Gd2DR+/PtqJTI6mikmBTFedoHhXB1i0p0KVw6ge37OV
         bMvVuOxIJ4KEeq+gNoKuuwfhV9FvQkP0aKOH4qTyJBr8J5z4pgZEi4IhozviOzH0b/aR
         tt6H1nOWDfX7ybCpcXd5TTQ3E/cs1tK+3hgoRcExmSvrzOFYcKxhYQ0uYqul4DanOfOq
         wbIudvQtt+Kx1cPebeAqulckotPTqO4ZewMbAvwYtiUa8fN/qVESiZeI0tzhTS5OwKx5
         qMeA==
X-Forwarded-Encrypted: i=1; AJvYcCXdvmk3CLyAHUYk0529/aqdFBt/t35QA5qqJK0n8G9Im8urVwI7SkJHLgluJyDlM9g9/8JrQUnkPdqrB68=@vger.kernel.org
X-Gm-Message-State: AOJu0YxEDT5D/BzaRDoGwMPIfqjGC85RIJlI6qRFGaGmnlWPlmTheGuw
	U4cOu2/Ousaxg53+fZ0irna6AQY94eSTaX7efo1e+Ma8tHlEWSlRE7O3SKutue8D868i9d9ATRg
	DlczT7HvnDzFPaCQFsw6e38FQ1l7sq/HG9+gFCuZW8xswrv55yqb09ztpRhwct0jkZZ8=
X-Gm-Gg: ASbGncvCakBTqT5MOIIWlk/h57BpPiEDeYPJmCay20AVjUYcA13D+EPPnPwMBmDNjdY
	YvzMVsteGvx49iV02PZBveT67LyQAe+WERYKAXOYu0C/5vXU7veTGqhlPVpYs9Y9z87AotBPBep
	LQ4an/thT68Wjfps3NgklAFB+wrigZt+kS4HUVzM5vG2Vr8oINaJCoRlItXW1Clv7cyv2k3eDBj
	6VuSUqbxGOrqhaGpBUrVNlGPHrybF9gFhxteqR9DvMDZH2IYDUKVe4IdH5IcfcgfPfHTguTmJEp
	8Toq96i+1ADHKGf2mO0dvm1qRU6OPUH6XhNmickT2OBrXFkjr3VVC1+XHejH3/hU2VtZ6s2f/2p
	56g4beHA7v8opoO5HFSe6o+i4Dzl4pHgD3mDIN+XJYRRqOigKXTNL
X-Received: by 2002:ad4:4eeb:0:b0:765:619f:6412 with SMTP id 6a1803df08f44-7e71b143e45mr16527976d6.63.1758598827645;
        Mon, 22 Sep 2025 20:40:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGe/bIW5msqYyQoTxSQBIOixG0XTzAYGMxafEVRCzlhMmww2jUk1Mmf5rK6JXSKfsef5miSoQ==
X-Received: by 2002:ad4:4eeb:0:b0:765:619f:6412 with SMTP id 6a1803df08f44-7e71b143e45mr16527656d6.63.1758598826878;
        Mon, 22 Sep 2025 20:40:26 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-57b78577636sm2241946e87.80.2025.09.22.20.40.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Sep 2025 20:40:26 -0700 (PDT)
Date: Tue, 23 Sep 2025 06:40:24 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Wesley Cheng <wesley.cheng@oss.qualcomm.com>
Cc: krzk+dt@kernel.org, conor+dt@kernel.org, kishon@kernel.org,
        vkoul@kernel.org, gregkh@linuxfoundation.org, robh@kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-phy@lists.infradead.org
Subject: Re: [PATCH 2/9] dt-bindings: phy: qcom,qmp-usb: Add Glymur USB UNI
 PHY compatible
Message-ID: <pvma73qs7msh2qkoaqhfv5v57f3asduuutwf73ceyrxbpsv4sl@fd6fs6yrfjp7>
References: <20250920032108.242643-1-wesley.cheng@oss.qualcomm.com>
 <20250920032108.242643-3-wesley.cheng@oss.qualcomm.com>
 <7gvp6pshp4eiugk3qodg2ub3azu365loturidbkxqly6nhtgq7@bxnkxeqzarkv>
 <4116b593-d36d-df10-6101-4e3539b8b812@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4116b593-d36d-df10-6101-4e3539b8b812@oss.qualcomm.com>
X-Proofpoint-GUID: bsF8256OiAExTkj94O3GT6aM7HZ7OWyk
X-Authority-Analysis: v=2.4 cv=fY2ty1QF c=1 sm=1 tr=0 ts=68d216ad cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=JfrnYn6hAAAA:8 a=EUspDBNiAAAA:8 a=38CvGR1NfgmP05XK24QA:9
 a=CjuIK1q_8ugA:10 a=1HOtulTD9v-eNWfpl4qZ:22 a=1CNFftbPRP8L7MoqJWF3:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIyMDE2OCBTYWx0ZWRfX3D9PAO0VJ4vt
 kSL3jbx/JBPmPdP/SwkxBcpyosgmRcafOtlbekoQNkj3weJxW0ps2sxvcyt+na5Jx9SIffMT3eQ
 +SrGUMTRWQh5MFhNfn894jVQNPKvvB+J8qyhkeIhnUFR5lH9QYHdD9xmy/Xh7+UfvKKjlGxRH1E
 eHo9gjTXOXTNIqiia0T5eJ10rHE2wHNlO5q+U6MwTwD1nnzCppVDccfKlzfTRhr6Cda0oFLG68O
 C8S8nD2ntJi0SDQOr/5HkPGshEqk3i5hWb3AdcS35cmN4K7Rgme2duqlT9VSwdue9fBHttystJT
 Aj0rMpUvE9sBBN8fwvnjW/vImS88lmaeD8jIxt/Je75hIctn4Copkqe8CwhHFktUFDnidKwGLWs
 t1Hw7fEs
X-Proofpoint-ORIG-GUID: bsF8256OiAExTkj94O3GT6aM7HZ7OWyk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-23_01,2025-09-22_05,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 spamscore=0 adultscore=0 impostorscore=0
 phishscore=0 bulkscore=0 priorityscore=1501 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509220168

On Mon, Sep 22, 2025 at 06:00:04PM -0700, Wesley Cheng wrote:
> 
> 
> On 9/20/2025 8:22 AM, Dmitry Baryshkov wrote:
> > On Fri, Sep 19, 2025 at 08:21:01PM -0700, Wesley Cheng wrote:
> > > The Glymur USB subsystem contains a multiport controller, which utilizes
> > > two QMP UNI PHYs.  Add the proper compatible string for the Glymur SoC.
> > > 
> > > Signed-off-by: Wesley Cheng <wesley.cheng@oss.qualcomm.com>
> > > ---
> > >   .../bindings/phy/qcom,sc8280xp-qmp-usb3-uni-phy.yaml       | 7 ++++++-
> > >   1 file changed, 6 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-usb3-uni-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-usb3-uni-phy.yaml
> > > index a1b55168e050..772a727a5462 100644
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
> > You've added it, but it's not referenced as required. Why is it so?
> > 
> 
> Hi Dmitry,
> 
> The refgen clock isn't always required on each and every platform unlike the
> .9v and 1.2v rail/supply, which directly power the QMP PHY.  It only really
> depends on how the refclk/CXO network is built for that particular chipset.
> The refgen ensures that we're properly voting for the supply that is
> powering our CXO buffer.

So, it should be marked as required for those SoCs that use it and set
to false for the SoCs that don't.

> 
> > > +
> > >     "#clock-cells":
> > >       const: 0
> > > @@ -139,6 +142,7 @@ allOf:
> > >           compatible:
> > >             contains:
> > >               enum:
> > > +              - qcom,glymur-qmp-usb3-uni-phy
> > >                 - qcom,sdm845-qmp-usb3-uni-phy
> > >       then:
> > >         properties:
> > > @@ -147,7 +151,7 @@ allOf:
> > >           clock-names:
> > >             items:
> > >               - const: aux
> > > -            - const: cfg_ahb
> > > +            - enum: [cfg_ahb, clkref]
> > 
> > Why is it being placed here? Please comment in the commit message.
> > 
> 
> Main reason if to avoid having to define another IF/THEN block, but I can do
> that as well if using enum here is not preferred.

Is it some new clock that hasn't been used on the previous platforms? Is
it actually supplying the PHY rather than the controller (note the
CLKREF clocks on SM8550 / SM8650.

> 
> Thanks
> Wesley Cheng
> 
> > >               - const: ref
> > >               - const: com_aux
> > >               - const: pipe
> > > @@ -157,6 +161,7 @@ allOf:
> > >           compatible:
> > >             contains:
> > >               enum:
> > > +              - qcom,glymur-qmp-usb3-uni-phy
> > >                 - qcom,sa8775p-qmp-usb3-uni-phy
> > >                 - qcom,sc8180x-qmp-usb3-uni-phy
> > >                 - qcom,sc8280xp-qmp-usb3-uni-phy
> > > 
> > > -- 
> > > linux-phy mailing list
> > > linux-phy@lists.infradead.org
> > > https://lists.infradead.org/mailman/listinfo/linux-phy
> > 
> 
> -- 
> linux-phy mailing list
> linux-phy@lists.infradead.org
> https://lists.infradead.org/mailman/listinfo/linux-phy

-- 
With best wishes
Dmitry

