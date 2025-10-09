Return-Path: <linux-kernel+bounces-846865-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1FE1BC9432
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 15:22:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E947D3E3FCB
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 13:21:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BD192E8DF7;
	Thu,  9 Oct 2025 13:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="jS2WKOgm"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5C642E11C5
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 13:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760016071; cv=none; b=Pf7aDopnCPg5vDSkkPZOlBm0wKxXoSKYKQn/DLsKqsTo9tSXFW88GPnZ9wNbXxJIfb/AF5l8GYKgH2YzaIKgxnAYlZwBtpgvW5dg+5b3fmleGUaTncbeoGCBRpz0Cll/3HPt6Rs31exp/k10gndhTnqhzdzQfuNI7ee1Yip4hDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760016071; c=relaxed/simple;
	bh=CflrvSQqC55Xi0uH5xmW2ZjycV8l2e80wpk9aEoXhME=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=irIHqXbb8gqtm7bfD0mptXHwzwD5Xpek+CORG645ZFynLL/wy/txuS/ZSVYrcJOKPmFUO46S+sAfSmdmG0zQXM9M9hsiux/0aZ+UGTp21kjzgo6og6B6h36ut8sDJt21LiFzgyAoR+SFF6WS2DZef/hC/7/9oQlsl/TUIWf4zfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=jS2WKOgm; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5996EOaJ019236
	for <linux-kernel@vger.kernel.org>; Thu, 9 Oct 2025 13:21:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=waw7/BuUtSlk9S6varyqbKPD
	0DkWdx5X+6wL+I7Srvg=; b=jS2WKOgm5Aq/aoIoCdC6qCG0oajAKzEYIJjyewgc
	n+sxPwju2jNt56GsjBbjN40guRNMlYdjRNTHh3frfUl2Fb0Kd8Bhaf4mfvqg5kjH
	2pXMXLMFITJb+O1RyUkKSzbm16b+hGYRSYuf5O5Xx4g6abmKJt1YghCcLyRUWnJB
	WMbNr3JWnsvXaz9fsxFLi9xtpkiojNwKLANMLT/Zzh/McV2poSnxeVpwBR/sBCPm
	tDhvoDcZekonznD4kz2RZ2+zFip0//LVck2mFdSQGQkPqwmHYwO9niqlF9vXray0
	coa3E31UmDV73Mhk/ky0AFhD4eOBtJtJFUeMAQxrM2wyDQ==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49nv4ntvyb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 09 Oct 2025 13:21:08 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4de5fe839aeso35012681cf.3
        for <linux-kernel@vger.kernel.org>; Thu, 09 Oct 2025 06:21:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760016068; x=1760620868;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=waw7/BuUtSlk9S6varyqbKPD0DkWdx5X+6wL+I7Srvg=;
        b=ab8GDxKDafTOUdWE/RyXlla5K/dsXZE1iERPPYvJkkRUA+WesxQHJDZuFCj4CcEtqj
         r70Z9Fw9Umzw5p36zBohf7InTuO78mHa4Kp0rfx6FMTIPi5ZA8QKd9Eg2CDOnssNi/jP
         u7s4nKXyXwwGiPcC5HO8BsPGnRa9MC+GOh6Llc4/kFARHGKDpakPirJA+E8gvxSHbehV
         o6BdAnkDVrMHrvTgNdLSG8QIenZnOaxodNBR3tDIYJmTS//EjHeN8sD5cbBvkvx+2N+u
         HeOayjujegrijbb/D8fuWAAPujUVpB8/PxiZndVi5/Ik3jB7IB1pMewWjYhJWHh4Udq3
         +9Sg==
X-Forwarded-Encrypted: i=1; AJvYcCUcb9LgJ1bpYbZXUM0bt6ZnOagLv6V3M14rOkQIFXR/+K25cIXuJVcAbF1wbi6Tx1iH8QvVGrBpv/pqRGs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTOfiozz7MHXZVlhcvh/OAoW1Ip+F6w96vgc/ndhjHt5ANusQj
	rNdR1EneLpSbLVW/2M9CsKY42aEiCSD21qPlek+2C0vozZ9dTKVQgzUXJ+R3p7PlxhzeIW3fmnh
	sazoaECVbdgnStBoIO21KbXspmRvDjout/3wC+jqp4ui/xMi3XmmMLFdWE5mcylJOn0VZ+qnEyT
	Y=
X-Gm-Gg: ASbGnctrXUDFfzv4DFemqet7nc69sf9VHzyt46o+I8VvZlzA+xy2WtTcH3zaB35gvF3
	pLLsH6bWwOmjbQsacBQJDcmgVgS7l33VSY2tgKwZdQ8m9Au4jHw5+1/ODUK5emownMjtai7ld4x
	1r85a8q2Ere1+/oyI4eEcnDn0y8fR2NDkJuaeoUAmdFFcvmnKHl2RBt8rErpg46PSVz2K6QTIzI
	48F+R/PalURypsXTz2CIJrDlgeO0rA+oMq2BEv0ggk0OJnhPEDnXTPHQbXhWjTPj0qdk5XbAoEO
	3Mz0gdrDQEeXDPSFGJs2XYwDgf0ZdQPzjIYxqed0sBf9DS/seRkhOrEagoWUFcQ6lyWx/WZQmVn
	ZagiO7godTyMVLYjY6R6cxb/xqRb+IIUwkZMYi9FeZiia+kwZK5/4gH3PIQ==
X-Received: by 2002:a05:622a:11d5:b0:4e6:d2d5:c7e8 with SMTP id d75a77b69052e-4e6ead767famr97688091cf.83.1760016067704;
        Thu, 09 Oct 2025 06:21:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHu0n6rRRsmUXdCk2v7oNX+QOVKtkYVegxJUOUjhbLvLoTCMRKVA3rX85gHWp+4lwdo4BWRLw==
X-Received: by 2002:a05:622a:11d5:b0:4e6:d2d5:c7e8 with SMTP id d75a77b69052e-4e6ead767famr97687491cf.83.1760016067125;
        Thu, 09 Oct 2025 06:21:07 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5907ac22780sm1052707e87.54.2025.10.09.06.21.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Oct 2025 06:21:06 -0700 (PDT)
Date: Thu, 9 Oct 2025 16:21:04 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: david@ixit.cz, Neil Armstrong <neil.armstrong@linaro.org>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Casey Connolly <casey.connolly@linaro.org>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        phone-devel@vger.kernel.org
Subject: Re: [PATCH v2 1/7] dt-bindings: panel: Add Samsung S6E3FC2X01 DDIC
 with panel
Message-ID: <bmsxmwfdwx7wlmngaqpvz7c2nudcoukspkxgq6zqh2mdlolfxg@fsdbafotp5q2>
References: <20251008-s6e3fc2x01-v2-0-21eca1d5c289@ixit.cz>
 <20251008-s6e3fc2x01-v2-1-21eca1d5c289@ixit.cz>
 <7askbazrkbny5jlw6cpxcpjyw5nyiozmksoyj5b5momcc7w5hn@r3x6kddatf3u>
 <74893f76-1b7d-4cfb-ba7a-9fd64427762b@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <74893f76-1b7d-4cfb-ba7a-9fd64427762b@oss.qualcomm.com>
X-Proofpoint-ORIG-GUID: ZhdRBHTxz4wGaP2PE5YZ5OALSFducmeX
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA4MDEyMSBTYWx0ZWRfX0tAkFMe4UEGR
 aRR1mMOwqgtNCTHJL7FfRgdmiKUe1gIOvtOfnkF60MW+0p9HKlTX7cFcfkTP3YVPwrW9JbthUNL
 scDIjwmm9bY1rQ/B33xmUbWT46OjSOA6s2Uve4iZyRpbgsyZmwDAc3SOSrB9cymomYkWedPdDcW
 z1/ebHI5kU7eUr/sP5PwAq7CMtgoMSCA7n5kE9rBcB7G3LceSWP9lcM5yoAKAmkJcGv5m1QbWGJ
 znRBim7nwx2TKLnk9M2hB4dh8IOuU+cy9V/NW5WeYqmPzxpwmRnoLxDQu7Td1yEvDUGTQ7GTnLT
 zCoC4TpnGstZHLEFTqIzfP7YtyX3HhVwp8s17X8HtPcSmZB81eLBekfGibkqUOsKiQiCZT8ZmyX
 vgOC6o1/LGN/1J2cm09lmdYQPULhVA==
X-Proofpoint-GUID: ZhdRBHTxz4wGaP2PE5YZ5OALSFducmeX
X-Authority-Analysis: v=2.4 cv=b6a/I9Gx c=1 sm=1 tr=0 ts=68e7b6c4 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=x6icFKpwvdMA:10 a=qNVazfFkpqTu88eF0ZoA:9 a=CjuIK1q_8ugA:10
 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-09_04,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 suspectscore=0 lowpriorityscore=0 adultscore=0 phishscore=0
 clxscore=1015 spamscore=0 impostorscore=0 malwarescore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510080121

On Thu, Oct 09, 2025 at 10:51:31AM +0200, Konrad Dybcio wrote:
> On 10/8/25 8:57 PM, Dmitry Baryshkov wrote:
> > On Wed, Oct 08, 2025 at 04:05:28PM +0200, David Heidelberg via B4 Relay wrote:
> >> From: David Heidelberg <david@ixit.cz>
> >>
> >> Basic description for S6E3FC2X01 DDIC with attached panel AMS641RW.
> >>
> >> Samsung AMS641RW is 6.41 inch, 1080x2340 pixels, 19.5:9 ratio panel
> >>
> >> Signed-off-by: David Heidelberg <david@ixit.cz>
> >> ---
> >>  .../bindings/display/panel/samsung,s6e3fc2x01.yaml | 78 ++++++++++++++++++++++
> >>  MAINTAINERS                                        |  5 ++
> >>  2 files changed, 83 insertions(+)
> >>
> > 
> > Please also describe, why it's not enough to use defined compatible,
> > samsung,s6e3fc2x01. Why do we need a separate schema and can't use the
> > panel-simple-dsi.yaml
> 
> panel-simple works for 'dumb' (perhaps a harsh word for 'made with
> just the in-spec DCS commands in mind') panels, but Samsungs are
> widely known to require a ton of vendor magic

The question is about the _schema_. I think it's fine to have a driver
for a panel covered by panel-simple-dsi.yaml.

> 
> Perhaps the original change was made with an "oh it just works
> surely there's no drawbacks possible" attitude, as the panel
> was left initialized by the bootloader

-- 
With best wishes
Dmitry

