Return-Path: <linux-kernel+bounces-841794-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E40E2BB83FB
	for <lists+linux-kernel@lfdr.de>; Fri, 03 Oct 2025 23:58:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C72E24EE988
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Oct 2025 21:58:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 213DB273804;
	Fri,  3 Oct 2025 21:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="pRvTdwQG"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C62B25A338
	for <linux-kernel@vger.kernel.org>; Fri,  3 Oct 2025 21:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759528676; cv=none; b=AaMr4VnbC/jNf3/rX4ZvN/4AHCwbesnD/fnu9+cmu/XPE7SPL1TSRU+Hv5LPVrgM/fGyT3ZUCCSTi1IwFKfwLMNCuV8o5ZCPVm2kd+eSoXEfwyDkozgQjCa8LuAsysUBDEdtVk9k298Aib4amviv5SnGuCsNBzd+yhaxjYUaZO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759528676; c=relaxed/simple;
	bh=fEzp16TZ1GnYDZ47twnaQ+dNb+URfspzX8pj/3MILLE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ORxQ6xelh9q/xCMP81WOh5ghP+3+6MOvuOTCC8z6EzNtsMl6ru2h39OdlLjwAGTy3OYwPCEz9t7vO05anz+A9+Xkwk9ECISb0Ms6FNBVU5GusZVOnJ0Bbs7XXY7GJRvAChfAJ/cFdj32S6FaIbVys83MUhN0zX3nmZvEHspgAzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=pRvTdwQG; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 593BkRB1032054
	for <linux-kernel@vger.kernel.org>; Fri, 3 Oct 2025 21:57:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=YNYMggB94eeV7wT4wE4M0iJ1
	TwWVtN6gTYQAscDX/bI=; b=pRvTdwQGF5SCPIywI8X7hDFjxZS6ZJdKkPiVUjrC
	+ZQxBfLqKgPCNSkpZyQCpTU/yLK1GiT/Bzu0S09hC5HvbhbUKtkOJlYX6zfhUg4n
	3EjHpqsE5g2qSIkxReLU8fHJEetvjd+0KHBeuSX6qIc4GsRq9AEKcvBeGMW6osFe
	fwkhjIuxfTBewppb6xrRPtWYjS/wX60GutHoZ5UZAq9Kq0poftxmncWcII6gCHV5
	KkronXCkdTKtDdmgw10QPFFvTyVNjzWPRtQCUsqEbhTYvrd+N+V8aCh9SSjeC+Am
	GM6PRejg88ZLBrndTcfZi3LPdkBdS8SIq8G4T+TquldA5A==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49e6x646j5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 03 Oct 2025 21:57:53 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4e484dccaafso68272531cf.1
        for <linux-kernel@vger.kernel.org>; Fri, 03 Oct 2025 14:57:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759528673; x=1760133473;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YNYMggB94eeV7wT4wE4M0iJ1TwWVtN6gTYQAscDX/bI=;
        b=LaeOkWHRPtui6WPPx2Gbpyl0hMtiNkti0rGfY2zoUC7BhE+iya5yLxJXsO9Tr0s372
         OK0ZzM4MFCegwfKMyd8kyz85TwTLyRAiLSXBnJ52JxupEIwE99MNOt+9n9bgl/TQmZjM
         M/rFjYq8+3WHA/by/XCzlfwGBTAJuJCgxkxC9+4zw2fscUVRLriYmJaSu5WPCft4L9nx
         jVTiv/JMbvf0+8cZXkC0aQRKGhTQYHJs6C5z9HC9R8ZrD4X57thPfXmXZPo8xUfdN8CL
         etmmVMNeAANbaamH2KX/RppHUOHIerN+evA1fylzZwg9VnVkos6aB38zG62e8bWBtLns
         lIJw==
X-Forwarded-Encrypted: i=1; AJvYcCXhXnbgU7LR60yfIlDxKI6Ji7GbYhjimXbZA2gy6TMqiixcCX93qp4pVz/tFvNLGpyOS5cQznflOuofBfY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6G3WKCGKBnmPthEgsufOHEZueVp3keZZS2z1+kCgoxCAQ3DNo
	xSVu8LSC6oquj8xy/0HX/u8jw6u2Dk0ZjrQMi7r1QIMmndfkIhRPoXlLyXI3BTtbjwSQdnUd2Hb
	eSlEul1ShDe39sNPYLRDca/S3nFVQ0uXXMldUpESyn9bHvDq5DiftUH5mfIuT8VV+gwc=
X-Gm-Gg: ASbGncu2zip3c3Jj7YZ6Z7TCA07PuzRd5DASlPHZhzk/SY55ZNfk9yrLAnarEHrC1Ri
	zUDNEsrYIFgL7MRn2ApjLDre3xxi5SFHxAWpwCg/j1X/jAG5Cb41dqsnjUVosgrIknbheYfcKFp
	STAW2LcTOeaj005p2DBarLMRvviwYy3iNSJxX/z73VW6GBIqpBAamkMsYU/SocmOvWPJBA6cuJG
	GAfTg7R2MT97G2Qx2ll8KDXpS6kbBqGAfNF8aspSR+/XofDm0eUeFBn4t/Yl9i8LVA7G9Xbp4fJ
	0Gw92zWSAIvKWMBjK/WpLOuSpCV9kx24+gMStif8xOnoVOqbz2aP9xc0NLFqBF8ed2ECzv1qiCb
	0v2MrNK6OU8y9ts+ecY1qvJJVcsnHkbfvvj/W7jZzSZwh/8PYFaXY9yPnOg==
X-Received: by 2002:a05:622a:1a16:b0:4d5:eedd:6882 with SMTP id d75a77b69052e-4e561bc3998mr113526931cf.12.1759528672754;
        Fri, 03 Oct 2025 14:57:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFmkOEk5qkYNgMXsVNq22E+jGt6uwDR3N3MQN4CYMlHhgek+PYfOCZ0N2MlvGdN4IjRHbZGAg==
X-Received: by 2002:a05:622a:1a16:b0:4d5:eedd:6882 with SMTP id d75a77b69052e-4e561bc3998mr113526611cf.12.1759528672132;
        Fri, 03 Oct 2025 14:57:52 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-373ba2e3e49sm19125671fa.22.2025.10.03.14.57.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Oct 2025 14:57:50 -0700 (PDT)
Date: Sat, 4 Oct 2025 00:57:49 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Jingzhou Zhu <newwheatzjz@zohomail.com>
Cc: andersson@kernel.org, konradybcio@kernel.org, robh@kernel.org,
        krzk+dt@kernel.org, conor+dt@kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/2] arm64: dts: qcom: Introduce Huawei MateBook E 2019
Message-ID: <f3ofbmp6w2rthiapu22infn6bfoeancv5l2azapplpniwtr44r@ffrakyzsjody>
References: <20251001142107.21860-1-newwheatzjz@zohomail.com>
 <20251003131925.15933-1-newwheatzjz@zohomail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251003131925.15933-1-newwheatzjz@zohomail.com>
X-Proofpoint-GUID: HcrFNZEbryox0PNjn-HDIZaE8ogazunD
X-Proofpoint-ORIG-GUID: HcrFNZEbryox0PNjn-HDIZaE8ogazunD
X-Authority-Analysis: v=2.4 cv=ZtPg6t7G c=1 sm=1 tr=0 ts=68e046e1 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=x6icFKpwvdMA:10 a=VwQbUJbxAAAA:8 a=WV1l7McVAAAA:8 a=jRjEOkseAnzkkx59WGkA:9
 a=CjuIK1q_8ugA:10 a=kacYvNCVWA4VmyqE58fU:22 a=ly-PvpxawfTmY1UqWLBn:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI3MDAxOCBTYWx0ZWRfX7xCMO8yt2hzx
 3BuSDAmMfs1NRZ1o6TrICEQfaez2kPckpnRIgB1LZXoLpKTLzGxW6j/jz6gvgIuL3NqazhbQYBf
 EY7AieLOu1bT8Tt2iGECARVl2AcrAPBBY22guvhIKPFey++pAtsJ4a9Yux6R3FPZlO7az0MEP3l
 mh0fw3n0O7L258WKupjb1K+ATQVnDtQsb1oETA4yXjnTKFPVQ9YHnlUEHVCoc48D994JaxB8jjF
 /nu+3vU72OFKNdhOsm4JLnz7qYCGxHIvIzjOex8NdJMx2v1Jzgm/mK06Mih479Q/te3mAfj8E5f
 ectcDhHo97R1hO5ubZDnSJ8eTKE0tnwXDHlTbbiZKoZvdZI/NfMJNkYLNRoG8z+ntR1l3moagJV
 zIMrnoDuj1ZBPbfzzv4bx5LSFbMYTw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-03_07,2025-10-02_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 priorityscore=1501 malwarescore=0 bulkscore=0
 suspectscore=0 clxscore=1015 lowpriorityscore=0 adultscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2509270018

On Fri, Oct 03, 2025 at 09:19:23PM +0800, Jingzhou Zhu wrote:
> Huawei MateBook E 2019 is a 2-in-1 tablet shipped with Windows on ARM.
> It is one of the early WoA devices powered by Qualcomm Snapdragon 850,
> or the sdm850 platform. This series adds mainline Linux support for this
> device using device tree.
> 
> Changes since v1:
>  - Remove 'enable-active-high' property from &vreg_s4a_1p8 and
>    'input-enable' property from &i2c5_hid_active to avoid warnings
>    mentioned by "Rob Herring (Arm)" <robh@kernel.org>
> 
> Changes since v2:
>  - Rearranged the order of nodes and properties suggested by Bjorn to meet
>    the dts coding guidelines
> 
> base-commit: 7396732143a22b42bb97710173d598aaf50daa89
> 
> Signed-off-by: Jingzhou Zhu <newwheatzjz@zohomail.com>
> ---
> Jingzhou Zhu (2):
>   dt-bindings: arm: qcom: Document Huawei MateBook E 2019
>   arm64: dts: qcom: Add support for Huawei MateBook E 2019
> 

Please don't send new versions as a reply to the previous one. It might
be ignored by other people or by the tools.

-- 
With best wishes
Dmitry

