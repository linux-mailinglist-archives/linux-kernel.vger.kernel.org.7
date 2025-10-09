Return-Path: <linux-kernel+bounces-846967-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6533BC98C2
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 16:38:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B22F3A5796
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 14:38:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C95C32EA168;
	Thu,  9 Oct 2025 14:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="h55SnEXO"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75B692BE04B
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 14:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760020719; cv=none; b=u3/ZrOf14SsLI30chhtiIUtPyUjq2UDU4WYRcH40cIi/v60+JNodDGNqPcxNIp/p7+sQTMxf4yZt2hcRbuzLqQSa2e+0cs/47I0sseYz1NnjtCXN7DUk3utSyRoJMWXrOuQtIaZP44TLKbmSNIqrJZiz1EWyr/siZHv7ItIxWeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760020719; c=relaxed/simple;
	bh=vp7VjUXj+As7oOKkaiuaBC5XXitotERlBrJ3mgdUli8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cGyIZ1bLDWp0q4LWXPEmjnT+hralek/seI5iGzYHwBZlLgiRPzd5ajIZCpmcvliuhPQMGQuxpi4w6vsiqtpwXmwLpfDF/WOBrsTz2uL5pzMMBemAu7HgcNWdbpHjqC99rBrjcrocOZID3yITJk8FMI4R6UDM0bJNM7qFuqycmWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=h55SnEXO; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 599EKNdH023267
	for <linux-kernel@vger.kernel.org>; Thu, 9 Oct 2025 14:38:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=4vBhPHQU3f3k1y9DS67UjAgU
	bNDRpJ4AofTiTYruk3A=; b=h55SnEXOobNRQlQCOCWUy9CbVe6LDj6avqwfogwk
	qIkxNU4IRyy6eFxbcmOe/xohO9vcljTJ8FDB2qB4MS+HLhrFo95dKIAIO5rbiU2R
	B3BXtXj/Tbxdd8ACGmjcyoUAjx+YjOvqc4pI/O4rFJbVMwl8jVEsKNuq8jhCEHKZ
	RJNbuImxdcZbegeiXSstzfYNBfcmhYdf31VPRtwWL1V0tA8Ks2CejTNeOgTb2+bT
	tH7WfWKsU+t64ggVEhG6anr2TIAMnvo4TUm6XZiAjPW5tc0n1VwhkvejB01nokUB
	TdndrodXgO1CPpOg/6GkLJwt55aBE0vYUmGbU5QFNKJ7KQ==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49nv4m37qd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 09 Oct 2025 14:38:36 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4d905ce4749so30722271cf.0
        for <linux-kernel@vger.kernel.org>; Thu, 09 Oct 2025 07:38:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760020715; x=1760625515;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4vBhPHQU3f3k1y9DS67UjAgUbNDRpJ4AofTiTYruk3A=;
        b=X8rqripWdwxkoK0pJf5MtNDooP0+CCKxLWLWLXPctfStJVzjheMesa8Tr2lFXtufvw
         f7AUkYPKUmzU7p6dHN+WabNNxUW5FGNXH/bGodYSJa4vGl1+8JDKrnprNdeR+rXLcxQI
         AtVSCi14lgmV0WcA4WFgeHwDvrphon0PVBhIwevjQsfNoHqaBxJ17h6OtN5lnG3I1H8b
         uLeoz9FX6kdW1mLKGBvReTa52ty7ufhHDOblS2c+nc5J8ogq8pXZ70e1YSEWzdiyHxjd
         KiH9sa5ygspXUeotYLlrHQL23XJ03L5T45F6qZ0OSRiEL0hwalW+AKfpy6vxbRfzoD2e
         rO+w==
X-Forwarded-Encrypted: i=1; AJvYcCWn7QBXNduuKSwlFEp1MnGyOH6c+EbWQjm6plRxlIPeMGN32jcEpcWDw8f4AtdcRwkmJ7DopyODqYvSQUM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZANUx8J+1MFns3D+8sCpnasZaXVvGf26nkTceI6iegoPDLPyG
	KCLwQVkO0pJjjBmyiwrJ1nOG3D2kqeDchBfod48zO69y4ot76XZ6DazP1vC9NF9ktDRgZCrRi2h
	N6lNY1pDbG7UUNPrFEM2e9Is1CwkSTiUPWhY8650jBrkEj2CgxTBPceYALz/QZESYP7I=
X-Gm-Gg: ASbGnctzLF8BMUEJ8LNJcHuyg5PwgO0cb876uRNQpbCFFC5bn0It2ioIjqdSW1L+stZ
	fGifLGYdCsEdB/6mPo+JjTfOmmmF/zC5/+seQlqdfTv86E9ZMJPu6l17EinnevPbLK/ztgLSENw
	H22fQfgyGC9372ztJ5psOoHTe/c0mAN0E2eXhPACCYGzerjq+5cVtMimoymb737BCg7RsmULMuc
	Mrvk5J+wEljXHrNCOrmMDuew5UUieOQvFLcOiJkICO7DZ3TGCq4IJiTVsyFBV8SowEn/dgXn242
	qRJsQWmMa4THI0ocfJiCxH8UGG3Nqt04ze8737kdMnbJyfqtjmIK9a680TKP/kF2SoMQ/89bapE
	obMc8GZ3D0yPPk179ILANN1zClJBXHajejlXCcI+NZjQTvHxrrhWSaeaswg==
X-Received: by 2002:a05:622a:4812:b0:4d7:bf73:7641 with SMTP id d75a77b69052e-4e6eacb362emr101465761cf.17.1760020715182;
        Thu, 09 Oct 2025 07:38:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHJWR/L5QvAdufneVpdCNLbrPazn1qmhQTRqnRIiTH9ugDxuMkMX/Hp2rQmkitaj4be/K7DKQ==
X-Received: by 2002:a05:622a:4812:b0:4d7:bf73:7641 with SMTP id d75a77b69052e-4e6eacb362emr101465171cf.17.1760020714634;
        Thu, 09 Oct 2025 07:38:34 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-375f39d509bsm29456381fa.12.2025.10.09.07.38.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Oct 2025 07:38:33 -0700 (PDT)
Date: Thu, 9 Oct 2025 17:38:32 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Rob Herring <robh@kernel.org>
Cc: Krishna Kurapati <krishna.kurapati@oss.qualcomm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Biju Das <biju.das.jz@bp.renesas.com>, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: usb: ti,hd3ss3220: Add support for
 VBUS based on ID state
Message-ID: <cbpne2d7yr2vpxmrrveqajlp3irzsglxroxyyjmviuci2ewted@6ewwp6yyybk5>
References: <20251008175750.1770454-1-krishna.kurapati@oss.qualcomm.com>
 <20251008175750.1770454-2-krishna.kurapati@oss.qualcomm.com>
 <odikli6rfdyid5oqavurtqytgnwgh5hpmka2jt5tprpdw7cd72@icpnjnkfowt7>
 <20251009131543.GA379737-robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251009131543.GA379737-robh@kernel.org>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA4MDEyMSBTYWx0ZWRfXxOfcnn7W92am
 lN01H9eSmjW3wH2iFitjRzw4rWEfYsVIpGVzh+CqGvzCbqwUE6NGU/JiKo821Mr0YRql7CyNR2m
 3U2Drxer0bxsMY14sypzy+SxsQlkiMLuZ2D0ycckcuYotwv3UbySjwjt7KHphiw5/zc5RstlRfc
 F2S7tfxp2o4rAq1g7wxET0sWFIHIH3m9WSKXjX1IGlfDIBX/p3Iu4KWUpZyYdwBnBjVNuiDZa3Y
 eB/GP3ZXHzDf0wr5okAMgInBGIvAFLWbDILwSLQgEcw0dJo4IvkkJoL1e1HDayQwdx3xTxAc1ae
 NmrCyXe3UROmti9+f+9qIJ+NNgmGik9zKPiObzqD7Zqcnw62Xq8ZmoUbSbq9p1cQ7cCAutkeAg6
 FxmhyTKZw9wX7U51MoY3njBzBPy5Pg==
X-Authority-Analysis: v=2.4 cv=B6G0EetM c=1 sm=1 tr=0 ts=68e7c8ec cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=x6icFKpwvdMA:10 a=EUspDBNiAAAA:8 a=wJJNMdjIKgIFmJVF0V4A:9 a=CjuIK1q_8ugA:10
 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-GUID: UMKmtV9xjJ1fcMp7o1UywLFItJBP9LsH
X-Proofpoint-ORIG-GUID: UMKmtV9xjJ1fcMp7o1UywLFItJBP9LsH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-09_05,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 bulkscore=0 clxscore=1015 suspectscore=0
 malwarescore=0 adultscore=0 priorityscore=1501 phishscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510080121

On Thu, Oct 09, 2025 at 08:15:43AM -0500, Rob Herring wrote:
> On Wed, Oct 08, 2025 at 09:31:59PM +0300, Dmitry Baryshkov wrote:
> > On Wed, Oct 08, 2025 at 11:27:49PM +0530, Krishna Kurapati wrote:
> > > Update the bindings to support reading ID state and VBUS, as per the
> > > HD3SS3220 data sheet. The ID pin is kept high if VBUS is not at VSafe0V and
> > > asserted low once VBUS is at VSafe0V, enforcing the Type-C requirement that
> > > VBUS must be at VSafe0V before re-enabling VBUS.
> > > 
> > > Add id-gpios property to describe the input gpio for USB ID pin and vbus-
> > > supply property to describe the regulator for USB VBUS.
> > > 
> > > Signed-off-by: Krishna Kurapati <krishna.kurapati@oss.qualcomm.com>
> > > ---
> > >  .../devicetree/bindings/usb/ti,hd3ss3220.yaml       | 13 +++++++++++++
> > >  1 file changed, 13 insertions(+)
> > > 
> > > diff --git a/Documentation/devicetree/bindings/usb/ti,hd3ss3220.yaml b/Documentation/devicetree/bindings/usb/ti,hd3ss3220.yaml
> > > index bec1c8047bc0..c869eece39a7 100644
> > > --- a/Documentation/devicetree/bindings/usb/ti,hd3ss3220.yaml
> > > +++ b/Documentation/devicetree/bindings/usb/ti,hd3ss3220.yaml
> > > @@ -25,6 +25,19 @@ properties:
> > >    interrupts:
> > >      maxItems: 1
> > >  
> > > +  id-gpios:
> > > +    description:
> > > +      An input gpio for USB ID pin. Upon detecting a UFP device, HD3SS3220
> > > +      will keep ID pin high if VBUS is not at VSafe0V. Once VBUS is at VSafe0V,
> > > +      the HD3SS3220 will assert ID pin low. This is done to enforce Type-C
> > > +      requirement that VBUS must be at VSafe0V before re-enabling VBUS.
> > > +
> > 
> > Stray empty line?
> > 
> > > +    maxItems: 1
> > > +
> > > +  vbus-supply:
> > > +    description: A phandle to the regulator for USB VBUS if needed when host
> > > +      mode or dual role mode is supported.
> > 
> > Why are we adding the property here while we can use the vbus-supply of
> > the usb-c-connector?
> 
> Normally, that's my question on both of these, too. However, it does 
> look like both are connected to the chip. There's VBUS_DET which is 
> connected to Vbus (thru a 900k resistor). So having these here does look 
> like accurate representation of the h/w. The commit message should make 
> this more clear. Honestly, that's really the only part I care about. 
> How it works is not so important. 

The VBUS_DET pin is used by the controller to detect the VBUS provided
by the USB-C partner and to identify when it's safe to turn on the
device's VBUS supply. I think this still fits into the description of
the connector's vbus-supply.

-- 
With best wishes
Dmitry

