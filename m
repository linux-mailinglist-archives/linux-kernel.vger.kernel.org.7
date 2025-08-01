Return-Path: <linux-kernel+bounces-752993-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 45FE2B17D8D
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 09:31:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 217077A651D
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 07:29:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79686224B07;
	Fri,  1 Aug 2025 07:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="O1uFdYDQ"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F6C1221FCD
	for <linux-kernel@vger.kernel.org>; Fri,  1 Aug 2025 07:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754033333; cv=none; b=KIcuPn+VG0I19XODh1dmrBbphQeci1JoIzWmERQlchZscTm22RSnhKdXkFONCDPD3H4IzLqG0Ju18yVFcGX1NX+4mq8zvUrU9Oe0tmRB0dNBqWdgvR8Yl1rs/SMJUWSmE8RntCCL38CDv3eAXN5lCpc3x+TTTn417RAsoyEXHvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754033333; c=relaxed/simple;
	bh=uje34Clhxc9ed3OvxabKenVPdmt0CPXcdy8D3hIZoOs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RCRyUnrGq8xSZEG1sHt+g6YfAvsAbRMIMA6KQ8dqh7Iqh/Ti1ITVfSI3rgMfgpE1/Tr2z08k5yDbyMTWqJuF2a9xX/o3XGMaHB1/BfLXLPmMOA5pGp8r6QOLBO7eLXTsJj+z4QvuMyjO0O/YG8yL/IPKjKWQcAyppUsl0GjAvHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=O1uFdYDQ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5710ZMpI031980
	for <linux-kernel@vger.kernel.org>; Fri, 1 Aug 2025 07:28:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=SEaURvMuhrpISmuLvcJOsmjb
	sYKo7gxuFeBHJJuHpIs=; b=O1uFdYDQUFjkt3tWSJopVDpW4gHMl3YUg3/ZmnCp
	vyXVwxKHRaaXtxLH6QGyC5SsEg8RstRJXYyDchnCnX2smDhEwBg3RPBb5kjbmODF
	OiCvdSTp261A82wqCsLMdQ3VjSxPY2F405rtwCCnIjInzuTxKKzc5HLFery3SBRf
	01NNE2JjX+ItOyjW8BA3LKPbAC4t1TdLDI9oe2zc9t4Mdnaw0WGFMKWGELFQNmto
	J+xw8Vd6aenmrluBIVwcDNNssypSTSLQdsPnq+5AQLb3CNp0Xez98GyP5sK/VJYg
	7MKH8I4z58tHQEmW5FjSHVbrXWyypimjJQlop4wseOFR3Q==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 487jwey8uj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 01 Aug 2025 07:28:51 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-7073834cda0so24907586d6.2
        for <linux-kernel@vger.kernel.org>; Fri, 01 Aug 2025 00:28:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754033330; x=1754638130;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SEaURvMuhrpISmuLvcJOsmjbsYKo7gxuFeBHJJuHpIs=;
        b=MUKopmy1in/veJCFupr4sJG6dhfwvkr6lIkY+d0GS6LRvnOJBIRtqnCirJHnBcmnlO
         FyIFggfkrHCtB2SLYBvwFsLfogi1xZhcHjqKckj+Wio15ROw0HBjJ9C7jbkX6k2SkUhP
         WN45D2/uYER1t3PLdH2Vb9Yel72VXUo0s/PXC0+4h9o8eKQCeg5mY/LbQ1bTm2fkZiP8
         BLdKjFE+1SmA25sQbQG9gvfh04xyeKSsS9grs9RFbtZQ8EJeoGbhqIW7mGelv7gCYJoY
         GbGLPycn5Jg9HGoam/B8zbsD0we/OVIAYckytWAvmjgMHcClvsc0b5BDMlzkcRXbpQxH
         dP6A==
X-Forwarded-Encrypted: i=1; AJvYcCU7o89h+ZS/H/NqfiqaGrurv+qWS6ZyjkaKa104cQwa+NBzWo7b5/DA0K4ova3n3M1NjYPxOYA5tsxoSEM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXv6dx+rg6LanohKYNct+K66W0/pC4eWWUKD5bD+3GDfAGrIu4
	8OF7YJ9eqicT+EtHeGhmm/RUy50YfmPDjcvlTz0ZTRt4femIx8oN27kaaT8OYG3F2RognqKnp3e
	rD7zVrddOxmvfhtIIbreW1Ymh416Lmp8q4r+eQGZUtbN7aLJRufK2n1sShQwO3kqLDTI=
X-Gm-Gg: ASbGncsxkPxR3zMkc1rgKVAE3Ivi+/77bc+bT7C+qlq+hz8Ky8gOXp+BWbV2etL35zj
	2L+N68cG+Py1C5cVFS5wRFubnOBz+sDWFeRO7QX7ask12MD5I0wagsEKBCu1rDl2qBn80nY6ezd
	aFtDaORCBjA+Okk6fKLNxMdZ7SLEDTvCYVGPtJ99JsZyiN0sK5jDlDTpSIgORxknBch3pQQmJZI
	FJ8NUEI8wEUq+hIvoHLlpSt8SKbSaWf7uOg3t4YcHtAHIVYXGJjRl/dOo52m4fF189sc5HfoYW8
	/D0SMm+INVORUgSQlalWvH/puRtN5lMqQoJ5YnCuIy1BtQ2CY7NDr//THDJyN+5/XFNuMpySZoS
	P0Jmr7vPs40TUfuXxpeiOw6zdF7yiEX/WhkkslEgHkTCCA+SsKOeI
X-Received: by 2002:a05:6214:5014:b0:707:5ff2:ae87 with SMTP id 6a1803df08f44-70766fd9ee7mr145991176d6.18.1754033330128;
        Fri, 01 Aug 2025 00:28:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFrm4INQ8xRvxOiPxAKfgqSB4rKDWYbtrN2Ds4wiRVfGNrMLXg9m6Lrslh3Tkn/TEPfHOs1iQ==
X-Received: by 2002:a05:6214:5014:b0:707:5ff2:ae87 with SMTP id 6a1803df08f44-70766fd9ee7mr145990906d6.18.1754033329694;
        Fri, 01 Aug 2025 00:28:49 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55b8898becdsm489500e87.37.2025.08.01.00.28.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Aug 2025 00:28:48 -0700 (PDT)
Date: Fri, 1 Aug 2025 10:28:47 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Taniya Das <taniya.das@oss.qualcomm.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, kernel@oss.qualcomm.com,
        Pankaj Patil <quic_pankpati@quicinc.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Taniya Das <quic_tdas@quicinc.com>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/7] dt-bindings: clock: qcom: Document the Glymur
 TCSR Clock Controller
Message-ID: <xkjmukefiaiect3x7b56dsn4zrddl2fvlgqtfa6yelanak4tih@owimyvx5qlf3>
References: <20250729-glymur-gcc-tcsrcc-rpmhcc-v3-0-227cfe5c8ef4@oss.qualcomm.com>
 <20250729-glymur-gcc-tcsrcc-rpmhcc-v3-2-227cfe5c8ef4@oss.qualcomm.com>
 <20250730-mottled-myrtle-bull-3ae03c@kuoka>
 <9cb06263-2a61-4acd-a9cc-157abb832d62@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9cb06263-2a61-4acd-a9cc-157abb832d62@oss.qualcomm.com>
X-Proofpoint-ORIG-GUID: EtP2lKj2oiJLdrYbid5AYBvnuYqv3hXw
X-Authority-Analysis: v=2.4 cv=Wv0rMcfv c=1 sm=1 tr=0 ts=688c6cb3 cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=6kVuSvOnKxEqxX6I_6UA:9 a=CjuIK1q_8ugA:10
 a=1HOtulTD9v-eNWfpl4qZ:22
X-Proofpoint-GUID: EtP2lKj2oiJLdrYbid5AYBvnuYqv3hXw
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODAxMDA0OSBTYWx0ZWRfX7ollepgUQGCB
 csgiaGzt2xXOKvsSTADYjm1sSz+UuDuJPSPyuOJi7ZutZvNldttsnF21IXdKliNbHTPtcRBYw4h
 mtqWE72Tc4ODCJ0ASnXWbY3eqW1I7/KLtS9zV/aqtEQPk4Ks0SnJXwVu3QzMwWuufBM7+YUJfOl
 zBUjQ2CEbCBHgIIDIM4l0T0EG2XqIVzq9tK8xASYA/Qh/9Vu3j9Dy8OyrAzIDQ1AwqDFx8p+pQp
 UziWVMv4XswLvMV9Akr+SWPhVCKegYDjd5rqSXsSqI2l1jgfcYguWfV/P7jwRYs06A+dEl3/fED
 xS/BgBXe0bSq+Cd5Uw1CKFHPVpI0n/MnEi9IbJSGLDSnjg+5ijSIFG6ih5xmkSjGMzaLBPNoJxo
 BYp02AuMXWhNHIbfxq+PccgyhN9xO6Gmru3eOJ0XIta4cv0xtLG3bnVjzRbbh1ZlJFpd9U+M
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-01_02,2025-07-31_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 malwarescore=0 clxscore=1015
 lowpriorityscore=0 bulkscore=0 mlxscore=0 adultscore=0 impostorscore=0
 phishscore=0 mlxlogscore=999 suspectscore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2508010049

On Fri, Aug 01, 2025 at 09:44:47AM +0530, Taniya Das wrote:
> 
> 
> On 7/30/2025 12:47 PM, Krzysztof Kozlowski wrote:
> > On Tue, Jul 29, 2025 at 11:12:36AM +0530, Taniya Das wrote:
> >> Add bindings documentation for the Glymur TCSR Clock Controller.
> > 
> > Same question as for v1, what is Glymur?
> 
> Glymur is the Qualcomm's next gen compute SoC.

This question means that the 'Glymur' name should be explained in the
commit message / cover letter.

> 
> > 
> > Where is any DTS using this (or explanation of lack of DTS)?
> > 
> 
> Krzysztof, the DTS will be posted separately once the driver and
> bindings are reviewed.

Same here.

> 
> 
> > Best regards,
> > Krzysztof
> > 
> 
> -- 
> Thanks,
> Taniya Das
> 

-- 
With best wishes
Dmitry

