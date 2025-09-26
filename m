Return-Path: <linux-kernel+bounces-834732-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FD63BA5627
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Sep 2025 01:27:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B5A8517D93D
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 23:27:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A1882BE7DD;
	Fri, 26 Sep 2025 23:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="gtqeWwSd"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC9922BDC2F
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 23:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758929217; cv=none; b=HRB8f+8FAUpenPDTMsFDzdPKkORpKIkw0+Qm8t7s79s9dJvi+FgMT/ptYl3vaJMK3YhH+WbOa4jIPhEYJFUOL3f9y1dI+2n/gEIT2QZJjA+GU/gOUSWEsMGaaMXBOUmEt5H9O9mrVJoFtVCO9Qi/8E9Ae5fwkagXnFSSOqw0Tcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758929217; c=relaxed/simple;
	bh=Eeu60yJ8Soz2arhwocz33aIV4wuf/NwdSfy46seGMmU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FyAqmieET1aCSbK3iZwAh4kI2MrYspP44M584NE6tOTAINmeDspi/GLbbszXlN48NYJk5U19h2Tl/wcXYyl/x0hLCbUqm8W1ZB07t05+gSzLogcKj74YaYqlYbzd9LsoxgJAgorxy2cdLPB6I2QIHjG42DwZ3HAU94JJ+sY+Q3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=gtqeWwSd; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58QEXQMV013877
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 23:26:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Vbe6hp57G+HSySRoh4rYc9OrCcfMPf0ZIXVK+DUyT9A=; b=gtqeWwSdlsxOu2Qy
	QRhQwVeigZSgtwbajicf/TtJlq7uM46vLQdRfoFNrblexGWhlo+qoDl2+R5Hr+Pi
	5qn2bTAYj4S0jeHCdc+qrIDs2igoAfgD1OPYjpZgx4d8Ki/T/IOvTJYh5cN0/gI7
	pmZsg52zHv41hHErD/k4grSDJopR7QgNyvLx23BKn/G91rbiaEqNnfWEgy6e7d1S
	JorGKR4QVoIKfhG3CqptWdZh4dukWp5bVtzdUQ6FruUPEAwRU0cCD6dbj/7naolg
	NEeor/QbWW8hTOm3lo2YGATQTx82diR2p6Z+3j8rmaO0B6Dc7STWaYPdHCenCYNG
	m5oonw==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49db0u4cjk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 23:26:54 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4df10fb4a4cso5282321cf.1
        for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 16:26:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758929213; x=1759534013;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Vbe6hp57G+HSySRoh4rYc9OrCcfMPf0ZIXVK+DUyT9A=;
        b=HRJwRr7NE/fOL4roo6fisFCs+z0zpOrpn8kKosDttrNJhjYxTB+uNikc1lCWSVE6mI
         H6FJMPUcmBI+aWEQMI3Z/xlRlNXRPyvKz06ajHiyTz1/ZN5lIrdc6mcO/9OmtGF7naHW
         wtNEZEbP1Xcnl59r2kmgIoOxw/Ie2Hr192BmLW4aTcEaEWkaFdWHh01jxJKgmL/+a9TV
         W67h7p6XdT8toNlThY3em4r7ZZJdzlCdNkJAccdoWPLbDhcz6PI61HbiLbrzV46Q+wcd
         +3LQte4loPMdVkWghSfk5/vK1TsvOmrWJmARHtv4TroLaa6szxYwMD7pBBxLfFIACQKI
         HKfg==
X-Forwarded-Encrypted: i=1; AJvYcCWkv4i+eogcrW9LBlZ8De85XCvZobH07p9DspbemuY0iDGf4etSoqM3FaxCQEusJZmMKx1/AdWnC3zX5q4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyP3ezuxT/jDvj7pxjltxEI51Y5ZP4FvRn6Psgu2ANvZfIrFdVV
	gVdwSIkC9cxpoJ4d171tTApy4zxFsqz+PshRddkhClSoxIU4hp/lGLwo1NirY940fHjTuTH8KG1
	Cc1CGSznSFMk/bSczUxhepgGvvYfRBpliOkHHBDa2o/et1Ork8sWDNcQy3HR0E8Q8ong=
X-Gm-Gg: ASbGncty+OHbXyNP9+ljJC6rKxxXDZ1u47RFzNQmoMwWpU8n8ZDV9eaE467+3RQcJ00
	GWFnF7yPa8blz/3555zGbvPTW8LH3hcGXIAACwarhEMFZnmoleHchQchlXwuCHsd9qf/nIlrSR6
	XC9OgPCvUohzbGXXoeFGXehRhg0gnXjRCORnOoOqcoHxD3bmTw63qWx55jPQ2SX/rwOpKVRVeQR
	SjHdhii4qcFCJMIiNwxNQYED0q03OUWZR2DQ7TctbfK925lpJDzNb2CElcuzMoZLmT9aUKn4osm
	eXrNYLJIy4WgG4QMEokecGOYFpjQRypSbYUd/WKZZEhxNNgDEG0GR2jtSVGdkuJPMgg1r2lCr+E
	4zwkyWldUVbwiAwGNPEqvLXYyuRERhF5EyAe/XJ2C6p2CLuDLFbox
X-Received: by 2002:a05:622a:6a45:b0:4db:ca19:ee9c with SMTP id d75a77b69052e-4dbca19f128mr66939051cf.33.1758929213195;
        Fri, 26 Sep 2025 16:26:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IELrJY8dwk3DsAMV5wvPN2YoyXnuflBYxBuOtpwI7/6SG4aQ0Rj1J4QizyTejJRTJ0k/z72TQ==
X-Received: by 2002:a05:622a:6a45:b0:4db:ca19:ee9c with SMTP id d75a77b69052e-4dbca19f128mr66938841cf.33.1758929212731;
        Fri, 26 Sep 2025 16:26:52 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-583139fb153sm2159779e87.46.2025.09.26.16.26.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Sep 2025 16:26:50 -0700 (PDT)
Date: Sat, 27 Sep 2025 02:26:46 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Yongxing Mou <yongxing.mou@oss.qualcomm.com>,
        Rob Clark <robin.clark@oss.qualcomm.com>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kuogee Hsieh <quic_khsieh@quicinc.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v12 3/5] dt-bindings: display/msm: Document MDSS on
 QCS8300
Message-ID: <rkuihu3pmhexeahfch6j7bvwn5rn4ecccbhamluh7fas5qgaup@av2foeiwmcz3>
References: <20250911-qcs8300_mdss-v12-0-5f7d076e2b81@oss.qualcomm.com>
 <20250911-qcs8300_mdss-v12-3-5f7d076e2b81@oss.qualcomm.com>
 <20250918-spectral-seahorse-of-witchcraft-69553c@kuoka>
 <b745c515-2264-42aa-8d92-663efc7f6276@oss.qualcomm.com>
 <6c195b42-d994-4d24-9c40-48d8069304e3@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6c195b42-d994-4d24-9c40-48d8069304e3@kernel.org>
X-Proofpoint-ORIG-GUID: mxeUIj_TEWiapNeeIiu3fKsaG3KFJ_yr
X-Proofpoint-GUID: mxeUIj_TEWiapNeeIiu3fKsaG3KFJ_yr
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI1MDE3MSBTYWx0ZWRfX2Mo8he3Koa0w
 MxdAvGwwdACymDfCHQx0/ZrYaAJmccfReNrWvQAC/1hWHbrQJKkUlpiyKjCHnf0azfjY1pVQxeT
 6Eh5yt5vb9a0JOoDcmrdAoXFxW2HdtEUiTqPpwaYp8YAK+HBc1wDEywNB3mREePeEExD30vLs1P
 /NPaK4ARHbpXXcZifWBmP8nffvcqyCmP8hcwtCZksA79unzP8/GKFMdzJNtHg/FKuBk0GTujQ/U
 BgPjkj8C35ZlqRJ37FOGbrg9ZjMZ8pr32N0YV2iDCjn6zuleVoaFhJwxrTzCC1B0/gMpzxGRvM4
 IxDxuZ9Ewu41VRZvDN0PvQrRhH13q/52J2lFMwxs96DkaME0xpYNQe7Wcxx+82o+qOuIThg4w5W
 AERneyr48am7kcQ1NzW9xnnrqcoHDA==
X-Authority-Analysis: v=2.4 cv=ZsHg6t7G c=1 sm=1 tr=0 ts=68d7213e cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=yJojWOMRYYMA:10 a=P-IC7800AAAA:8 a=EUspDBNiAAAA:8 a=VWPR2QegcKdD6PkuNicA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=kacYvNCVWA4VmyqE58fU:22
 a=d3PnA9EDa4IxuAV0gXij:22 a=HhbK4dLum7pmb74im6QT:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-26_08,2025-09-26_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 spamscore=0 malwarescore=0 lowpriorityscore=0 adultscore=0
 priorityscore=1501 impostorscore=0 bulkscore=0 suspectscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2509250171

On Fri, Sep 19, 2025 at 01:34:39PM +0900, Krzysztof Kozlowski wrote:
> On 18/09/2025 13:14, Yongxing Mou wrote:
> > 
> > 
> > On 9/18/2025 9:01 AM, Krzysztof Kozlowski wrote:
> >> On Thu, Sep 11, 2025 at 07:24:03PM +0800, Yongxing Mou wrote:
> >>> Document the MDSS hardware found on the Qualcomm QCS8300 platform.
> >>>
> >>> Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
> >>
> >> Patch v11 and still basic issues. I am very dissapointed.
> >>
> >> <form letter>
> >> This is a friendly reminder during the review process.
> >>
> >> It looks like you received a tag and forgot to add it.
> >>
> >> If you do not know the process, here is a short explanation:
> >> Please add Acked-by/Reviewed-by/Tested-by tags when posting new
> >> versions of patchset, under or above your Signed-off-by tag, unless
> >> patch changed significantly (e.g. new properties added to the DT
> >> bindings). Tag is "received", when provided in a message replied to you
> >> on the mailing list. Tools like b4 can help here. However, there's no
> >> need to repost patches *only* to add the tags. The upstream maintainer
> >> will do that for tags received on the version they apply.
> >>
> >> Please read:
> >> https://elixir.bootlin.com/linux/v6.12-rc3/source/Documentation/process/submitting-patches.rst#L577
> >>
> >> If a tag was not added on purpose, please state why and what changed.
> >> </form letter>
> >>
> >> Best regards,
> >> Krzysztof
> >>
> > Hi,
> > Sorry for the confusion. I did intend to remove the Reviewed-by tag, and 
> > I mentioned this in the cover letter, but maybe explanation in 
> > cover-letter was probe not clear at all.
> > 
> > This patch includes three changes:
> > 
> > 1.In the displayport-controller compatible property, "items" was changed 
> > to "contains".
> > 2.Use "qcom,sa8775p-dp" as fallback.
> > 
> > These changes might not be considered significant. So I’ll be more 
> > careful next time. Thanks~
> 
> 
> I really do not expect v12 to receive so significant changes in the
> first place. If you keep sending us buggy code, which then you keep
> changing after review, I will just not do the review. It's easier for me
> to wait for v20...

I'm not sure how to react to this missage. The changes reflect the
process in other patchsets and in my understanding on how to describe
the particular hardware block. The changes were reflected in the
changelog. If you plan to review this patchset once you get back from
your vacation, that's fine. If you don't plan to, I can ask Yongxing to
send v20 just for that number.

-- 
With best wishes
Dmitry

