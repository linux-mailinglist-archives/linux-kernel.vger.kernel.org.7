Return-Path: <linux-kernel+bounces-866839-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 91C0CC00C60
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 13:35:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6C9A54FF18C
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 11:35:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 998C63064A7;
	Thu, 23 Oct 2025 11:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="nJsZoqip"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A254C211290
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 11:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761219301; cv=none; b=FwNdXdPt0KIKHwjKyR1KTMoMnfxLAvFMafuynQLJOGn3f86RXMGvvUENZCv0KXCjygleaIhIOrZh0+Uvo8VHqf7ID6VMrAs+iNgTR/6DzvxX8JqIuf2HOLVaeCQHIQSt7oxIfc94QD7OGupMxPxvjvWH7yYsk8sh/yiSQlGIAzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761219301; c=relaxed/simple;
	bh=f+/NnNjzHQpwza0Q5UTb3bp/OkbrnhnjOKHiz2Go468=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OD/cxoAyc9fbN/lf688r+dXEvVRoyORG+TTYEZsmVHF0iK7W8hRO8v9ApjUTeBSesY/7p9DKj/zWh75O+fxS6QpTzlLryH9MJ5YiEOqjBvDufZJ9v8aIvb/ZVppKlADLxAJajPPETxA9R07UWt0brPzhh1b/UmXFhaY3msaTYck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=nJsZoqip; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59N7YX19011794
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 11:34:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=0GsmbhgdWrGJ+GimrTjkaExR
	9bUmFkGScu7WoG+LKrE=; b=nJsZoqipaUVAIV7XnpOVhcGP1Rn/u0Zql4bOCl7A
	gtfa1c/6ECJEerPws1u3O3TPsWDk/8c4ynB1qABQlFlcupys0doyDROXbIKAfdaG
	Nx6UDeCTGhP46nzH3J7fPlXXLC7IyrIi4oiZ2BT64rJHK2W7eBDbz8I5RTQUGgGZ
	PU+ANNbTtYwZCUK9WrRvOrIX+UXMc3+9SA6fUCb6GeM8NJ+UX7H/4hGHj1D0i71I
	1guf3/78ZWMCUgOQsv3VNVzPCJWAX+fxZrG5QRov9LN3tYXLInmxymcCm4RLY/Du
	S8v38lDolmoSqbsLMNM9OdrcDvbUSNW4jdvmhVa2LJHukg==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49y524adcf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 11:34:58 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4e8bb155690so9232941cf.0
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 04:34:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761219298; x=1761824098;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0GsmbhgdWrGJ+GimrTjkaExR9bUmFkGScu7WoG+LKrE=;
        b=nb8b0+C4ZYz80/oLFinBgMtrZrdyNVYLFwwuI7NPgmm4RTLDPyMmm2+QiveTqe5DZa
         HJNHqcUtDU37E3BUjUw7EJssJKJ/fKXbiSTFMylBJThKi/mjyd2dslKTe/sf5l5oi5Kh
         iGriEViuR9rZt8/WhZycribSzF9Q2+ROWxQocLT080YR77p6yPkxcMcekXrb7w1Fedv+
         uUtZ7XPI1WXjfyyn6ziQuHJE6ojgpUNcnoOQ2h28CkaKq4rl5RrItgRMGSV7Cyo7722q
         fWMHp9h7HUEF2pslNhKnIH0uKUInQbnIyR1cOPUsbolzJNxcTZlRGy0CPkCsVqLRnmFh
         CC4A==
X-Forwarded-Encrypted: i=1; AJvYcCV6LlE10pURCNuwYuW2OSQwCXJPruUQVzUs31KeIU60p2d2/MTnyAXVje/l/+T/HZdmfJTYVmsmg6F5IgU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJVWrBL7A3aj9KMVVAMXxfyc2/xEhGP1O1Vbe2Hk7PlxxehVh2
	bQZo+tlY7+lRT0tYzh5ONmv3ejEKdJIWPKOmwbpz65b9aXUfmIaDzjUk8f5AzDadHdDB5BFY93y
	/4PZocTWjkwtxIE2PNGja2PvbagaorkMD/yoo/MuF66pKnFfGPXF/uWkkvEhz9+Ye/m8=
X-Gm-Gg: ASbGncuJnXyeZRrk1jUvS/fIub812Kgk5LSChn3nB0MFZcjVY4Re6jm8ceILi2fo/6v
	NZ0O3E21f6A2jxdEyaFx/Z/dEXcupn/KrFIvuJEX9BovDTzwejDFpovdO+0cj4KRRYt+la5MtwJ
	nxUAGpW62wgVdkB4iIwrqtp3biP4TcDHN9yX2Pq4fj7lJfg/ySmf9AnC7t/Hkz+ZYvv5A/3rhcF
	Ul+3Z8XmbP5Ci3IrSUL5Iz3M+BSvRHwlrzZrdOx/9anJWWy7HnGzhjlQGIU7COdgVniu5KpwVDB
	6Vc+Oge3By+IgzrIadMDOlSGkWjjxsXj8lwJHptC6RxgjoDBQVnU88Nr6yss47H0EsXO65/w31l
	SAwi5cmBnjJ4khibWsQO8r+fn05a1CVN4/4q8I8CHwuzfMpiViZ6FPG7depXXgYOMr1wy9C5RtW
	ccleXAebxr76nq
X-Received: by 2002:a05:622a:1488:b0:4e8:ac66:ee4b with SMTP id d75a77b69052e-4e8ac66f3famr247774661cf.50.1761219297548;
        Thu, 23 Oct 2025 04:34:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEI3toh2FWWacCWixWtLj+UhejuUOALAkx4auCsoA9mdYJd6RmpJFsj+n/JRxq7WMt0HM3+Yg==
X-Received: by 2002:a05:622a:1488:b0:4e8:ac66:ee4b with SMTP id d75a77b69052e-4e8ac66f3famr247774281cf.50.1761219297099;
        Thu, 23 Oct 2025 04:34:57 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-378d67dc592sm3822231fa.45.2025.10.23.04.34.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Oct 2025 04:34:56 -0700 (PDT)
Date: Thu, 23 Oct 2025 14:34:54 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Anjelique Melendez <anjelique.melendez@oss.qualcomm.com>
Cc: heikki.krogerus@linux.intel.com, gregkh@linuxfoundation.org,
        lumag@kernel.org, neil.armstrong@linaro.org, johan+linaro@kernel.org,
        quic_bjorande@quicinc.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v6 2/2] usb: typec: ucsi_glink: Increase buffer size to
 support UCSI v2
Message-ID: <f2y4aposu5ddpwgue5gskumo5mjwkrod32ecbvveodgxrysg6u@zsq6ftoy4yqg>
References: <20251022004554.1956729-1-anjelique.melendez@oss.qualcomm.com>
 <20251022004554.1956729-3-anjelique.melendez@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251022004554.1956729-3-anjelique.melendez@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDIyMDE1NSBTYWx0ZWRfX1bBYtVQl7sSv
 jjdlEuuHInOH4Pmsvoj8NpEUutiEbdb+PXpcmRh6Una49Xdo/65OqZG9oxgCeXpWtPoWwm13TyD
 3nydhMLBDwtyLcOKBHXpPoL2o4QoyuD/8klaLEgQrJADkXORfFQ22oLg3Hf5XPFAcu17yYqz6Vn
 fQldWJj6l+fnLO7Qjxtu9+vQT0IQ2JR0y7kOqfkC1YffTM1CBeBuOIpZSPL0h+q5PiN+RSb9/yS
 eCh1d/Vb2RQet+TVwEe+yKgHmA61k3sSZsduWJTsXQoN91UeBiZ+PYl/2BYmVpXfVPHAY3ICvtc
 qYjmfE2Rr7BT+skirB5IQK6jShPjWhLvvyJm2ieWO2KrjtQHfPw8NQiFw2vEI9Kf5nr0zOSWetB
 5ghmx9j65gxM6nmkkpT13Akbw/LGUg==
X-Authority-Analysis: v=2.4 cv=Uotu9uwB c=1 sm=1 tr=0 ts=68fa12e2 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8
 a=WG3W4BPXNB2T8y8KjtgA:9 a=CjuIK1q_8ugA:10 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-GUID: gv7e2aoHBMdF2fKbqAHTnFei53XCAVlb
X-Proofpoint-ORIG-GUID: gv7e2aoHBMdF2fKbqAHTnFei53XCAVlb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-22_08,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 priorityscore=1501 clxscore=1015 spamscore=0
 adultscore=0 suspectscore=0 phishscore=0 lowpriorityscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510220155

On Tue, Oct 21, 2025 at 05:45:54PM -0700, Anjelique Melendez wrote:
> UCSI v2 specification has increased the MSG_IN and MSG_OUT size from
> 16 bytes to 256 bytes each for the message exchange between OPM and PPM
> This makes the total buffer size increase from 48 bytes to 528 bytes.
> Update the buffer size to support this increase.
> 
> Signed-off-by: Anjelique Melendez <anjelique.melendez@oss.qualcomm.com>
> ---
>  drivers/usb/typec/ucsi/ucsi_glink.c | 80 +++++++++++++++++++++++++----
>  1 file changed, 70 insertions(+), 10 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry

