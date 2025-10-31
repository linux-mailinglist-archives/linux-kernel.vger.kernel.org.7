Return-Path: <linux-kernel+bounces-880755-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DF13AC2675B
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 18:46:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B9AE1892F19
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 17:45:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ABB7324B10;
	Fri, 31 Oct 2025 17:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="KQvCDgXx";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Njt+z226"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B46C2D0C99
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 17:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761932701; cv=none; b=GKwletRMsl1fC6Fi2MeMNUG72dBOm3gxZcbF4K/puskXtIZ/7kcLXHIZ0TeC7HMVTIBy46nHirxSwpSvE8vQaXRJkdVWSrhEhtr92b/uQxha3ISv3Fyf+gRzp/YGVuwQYO0kS0P0ywhiOpq5SA1g7Zmayp5Z6Zp40ijfqZHA8tE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761932701; c=relaxed/simple;
	bh=MMN6o0nRNxpKuhgb1l1PbN/WsZE5u4tVnTaWtoOH30w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tBNqkB/mliTTeVwx7VWi5f9iRnQL3WtE10udek/XCpxbYLsFIQKv60Kk8XKSFjyYgFm4f8z82BYzn+BRUPwRW+Rjm/aPnn1DMeH75c/VvKki4maalMtfW8uJ2AF+slXI9zF4kdynHfM5Iys1q40Egx/lWaZ6JHefuYwoC7bjH2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=KQvCDgXx; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Njt+z226; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59VF7Dbw3210518
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 17:44:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=vvHKLumKKaVNpfG3W6t6aYP4
	CbJ/5LJdAfa5MGOu8/4=; b=KQvCDgXxzqVclXNmB/ngqm50Mk7X6iKbKzWhNvSZ
	3UOCW9qdgrNnEhPbnfM8eiYiRoHX03qLmUAIo1ISyAVsf/690rZHRCi212QFmYoC
	MxwhMx99YqoMX4x6p0oi5H0zFOziho/1iXldgNH5SYdvwKq9ArNlY8vkFBMgCGH9
	t34Kbv/jT5VjbaWOinGglah/q5jqQYRwHShskdT4mhcytUeOu0E4/5eKkbBWStil
	+Zp2V8ITUy1QEUpi7Le4mhpRqu8dnw4c8VOuus9SW18opppNxMnwLGbfy2aWlp7S
	7zPJDOaOJ4agF8YSsEARJozB5mkk2aqGY3U/7ZV/q0K15Q==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a4yfpge79-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 17:44:56 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4eba1cea10dso86532731cf.1
        for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 10:44:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1761932696; x=1762537496; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vvHKLumKKaVNpfG3W6t6aYP4CbJ/5LJdAfa5MGOu8/4=;
        b=Njt+z226R/3CopOAlqm1PHF7g/wuD9MCmZ3GwzueLXO2fhftlu6brwKgJduU6xuhP9
         FrIID8zkdpgCxffeCdy6zKWTy/Un8pD8s5Wn/6GpSNp0e3ZDCuXfeeVOSZyKgm8mappW
         rwYYXEBrY/kdQ574nnP3/rzwn7St1TGVdWEvml20s4ovIc+ELw3uyRg34JzFqQQ2pWK2
         RIOxilRvimQ4E+qbMbe2UBbhe3GwcADOi3BWyS8s5+rc1arN961s1COpfz8tmw6ubsor
         fKTSMre7A4RZX0UUJvdovTD+jUBuwEUiSYUJm1PBH1MQACkNLywtXhVI35y6/XmL065k
         A1JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761932696; x=1762537496;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vvHKLumKKaVNpfG3W6t6aYP4CbJ/5LJdAfa5MGOu8/4=;
        b=Q24pofQym4bHU48yVyZBFwXvwL5sMfEUDK1g8o+jVQqMF/X/C+E3BQ/RIWn3YrW/KO
         rSc1tsOkmewyDtb4Olx0b8tn+G8CZbgep3o9NrinXmraPT1lEOjWROXAvJVHjHXcBRHV
         uFxo74waV5VB4Ob/KvJWJtZZbO4AhZsj6M3qpBi2MftrKxG9kcAN8GAjEnEug/yjrU86
         mf5yfL2D/XVkDBJw/6OksUWh0ZyTq7mOUjUhja0qK7oIyaGSZGkIFBlDHKpzzeN7yqrs
         gz05I+ou2PMh1FkrhsP/rzI7XHw/XSlejPrIle4ET4o3AUTP8dpMCDu++N477hu5FMI1
         AlUQ==
X-Forwarded-Encrypted: i=1; AJvYcCVl/MoXlJgitiQwPmrHQv1891snby9IPyJzma9s6lcSeqGelPFzxn2D24Bxmg3t13x7FT5Zp/Kptp427Lc=@vger.kernel.org
X-Gm-Message-State: AOJu0YylSrivBynPDqkSGqoZ7JycElJIqfTOv6JRpzkBOOdjh2UOmm0N
	dcKoWAA6tZR6zu/uBWJz4eV82MZWxu5TIjsieA8uijGnDjDzvYOnGLPS0XIn+DqjiO8/UVO7L2H
	wL3MNL63dXSj7acDI44GgWBvMPlIMk1zbvG4W+q81dcv+ZhELZwP4a9KgmBulD1p7X90=
X-Gm-Gg: ASbGncslaq5PUooH4u2oRQcQAGZ/b63GZpx8cyZdWRSw/4dQfZeOv3SH10gwJPnIKrW
	297+vOMwwH5yltHMr0fUKHjic/BeffQZ5FvlNT5ZsOCZTW9gYhb0sLpI6mYX9dO8X5W8vz6ocB7
	qTHJzyLJm4w6zaQoqJ3VppQauQwDjkslgkZtN16ZhsbzHceVzgnycLuT/TjqcX/+Hgxg4PrqVKR
	AgfcEe/QupIHKKbYehYXGCNAZQ2InLCAikrUGMuf1P1YfoIm5gKtRhCz4gGcp4NPouNqlHx46/M
	QdwID3zq5K+xwcPyZkZS7TEn1T/mjMVxmQO36maYRIoX/X/VFqNrycVN0G5seXMCBUYqJraXWWQ
	HQSwCla8a/Zx4OfFwQqhXvGMiI1vzQHX4nqhu70Kr74Lt0ZsIO4utpJjrt+AC4i5UkalkwHSGCS
	3yySxUmdm78mmj
X-Received: by 2002:a05:622a:1aa4:b0:4ec:f4be:cd9e with SMTP id d75a77b69052e-4ed3109b8f2mr50682701cf.73.1761932695707;
        Fri, 31 Oct 2025 10:44:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG9bEHzE8FUhJ91Y/44yaTELcPDElgy8o9JtMJnkidFrR8S2ct4TEYiKDSKIhS6PFHQgLRXEQ==
X-Received: by 2002:a05:622a:1aa4:b0:4ec:f4be:cd9e with SMTP id d75a77b69052e-4ed3109b8f2mr50682271cf.73.1761932695194;
        Fri, 31 Oct 2025 10:44:55 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5941f5b5cc4sm639106e87.72.2025.10.31.10.44.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Oct 2025 10:44:54 -0700 (PDT)
Date: Fri, 31 Oct 2025 19:44:52 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: yuanjiey <yuanjie.yang@oss.qualcomm.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>, robin.clark@oss.qualcomm.com,
        lumag@kernel.org, abhinav.kumar@linux.dev, sean@poorly.run,
        marijn.suijten@somainline.org, airlied@gmail.com, simona@ffwll.ch,
        maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de, robh@kernel.org, krzk+dt@kernel.org,
        conor+dt@kernel.org, quic_mkrishn@quicinc.com, jonathan@marek.ca,
        quic_khsieh@quicinc.com, neil.armstrong@linaro.org,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, tingwei.zhang@oss.qualcomm.com,
        aiqun.yu@oss.qualcomm.com, yongxing.mou@oss.qualcomm.com
Subject: Re: [PATCH 08/12] arm64: defconfig: Enable NT37801 DSI panel driver
Message-ID: <epz7tibi4kduo6agfirr4fe477dakdccwob4xq2nz6qkjqakr6@jmweqjka4xgd>
References: <20251023080609.1212-1-yuanjie.yang@oss.qualcomm.com>
 <20251023080609.1212-3-yuanjie.yang@oss.qualcomm.com>
 <wuh7agcgg6spghilnx4amqukaaydj25u7kbdiod7fl6pu2ulvm@pmosyuo43cyw>
 <aQF98RvLuOlJZlFi@yuanjiey.ap.qualcomm.com>
 <38c8e26c-08a4-42d9-8f6d-93969af90d50@kernel.org>
 <aQLOaI3ngjswi7kd@yuanjiey.ap.qualcomm.com>
 <7c1e0cb5-2483-4efa-be52-84cbe5d1a4b2@kernel.org>
 <aQMOz4P2/WyjXy1b@yuanjiey.ap.qualcomm.com>
 <4e444fd3-b079-4e0c-9449-1c119e1d710a@kernel.org>
 <aQQevC/Jd76rTNSU@yuanjiey.ap.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aQQevC/Jd76rTNSU@yuanjiey.ap.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDMxMDE1OCBTYWx0ZWRfX3sOKPc3eeDv6
 +W2zxh0mmwTRyf5710i+36Nz6pMieBGKIMQpqKg9ZK0PQkw4lW+CpH1gif1/x+zwbwjfdH56S4O
 Ii1XQtpT8nqpAxT0F2xIOazzyS5QXkx2o9nQHSnEbIgymXfCd81CCd++o5X25BvBE1ek3qgNeEl
 5W07XAg4SqOmGGIoOYY570kOl0eLoBXZVqxPEL0ZNFVAJNtwWCBvGYKywRYZUt1k/CywH6153B6
 bDiVWuRdyYuiWNrPDD1iJV9E2gvumKL6ED9sVdnCW1KTBgInhcOkVBHLLgVacKKjqMmcNtscz41
 uyMTxhu87M/YaBObujfQPMs5EclClVDbs+3y4OwsFq0S3urtfdtyx7x4x0Fv4pgwwi/XlNOf44K
 IGfOQ7r1ikIGDZqbQ/Z3zYVP3XBM5Q==
X-Authority-Analysis: v=2.4 cv=V5NwEOni c=1 sm=1 tr=0 ts=6904f598 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=x6icFKpwvdMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=P-IC7800AAAA:8 a=EUspDBNiAAAA:8 a=SA9wRs256TnAP9KdDBoA:9 a=CjuIK1q_8ugA:10
 a=kacYvNCVWA4VmyqE58fU:22 a=d3PnA9EDa4IxuAV0gXij:22
X-Proofpoint-GUID: ytkzoLK7vxsBYGNyke4KR5zTO48syIh7
X-Proofpoint-ORIG-GUID: ytkzoLK7vxsBYGNyke4KR5zTO48syIh7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-10-31_06,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 clxscore=1015 adultscore=0 bulkscore=0
 malwarescore=0 lowpriorityscore=0 impostorscore=0 suspectscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2510310158

On Fri, Oct 31, 2025 at 10:28:12AM +0800, yuanjiey wrote:
> On Thu, Oct 30, 2025 at 11:43:49AM +0100, Krzysztof Kozlowski wrote:
> > On 30/10/2025 08:07, yuanjiey wrote:
> > > On Thu, Oct 30, 2025 at 06:37:40AM +0100, Krzysztof Kozlowski wrote:
> > >> On 30/10/2025 03:33, yuanjiey wrote:
> > >>> On Wed, Oct 29, 2025 at 02:05:20PM +0100, Krzysztof Kozlowski wrote:
> > >>>> On 29/10/2025 03:37, yuanjiey wrote:
> > >>>>> On Mon, Oct 27, 2025 at 10:51:23PM -0500, Bjorn Andersson wrote:
> > >>>>>> On Thu, Oct 23, 2025 at 04:06:05PM +0800, yuanjie yang wrote:
> > >>>>>>> From: Yuanjie Yang <yuanjie.yang@oss.qualcomm.com>
> > >>>>>>>
> > >>>>>>> Build the NT37801 DSI panel driver as module.
> > >>>>>>>
> > >>>>>>> Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
> > >>>>>>> Signed-off-by: Yuanjie Yang <yuanjie.yang@oss.qualcomm.com>
> > >>>>>>
> > >>>>>> You (Yuanjie) authored the patch, but forgot to sign-off, then Yongxing
> > >>>>>> provided certificate of origin, then you provide certificate of origin
> > >>>>>> and send it to list?
> > >>>>>>
> > >>>>>> Please correct.
> > >>>>>
> > >>>>> All the display patches were jointly developed by Yongxing and me.
> > >>>>> So every patch 
> > >>>>
> > >>>>
> > >>>> So two people were working on this absolutely trivial defconfig change?
> > >>>> I have troubles believing this.
> > >>> I want to say these patches I am first author and yongxing give me support, so
> > >>> I think yongxing is second author.
> > >>>
> > >>> I want to express my gratitude for Yongxing's support in every patch, so I included
> > >>> both our names in the sign-off for each one.
> > >>>
> > >>> However, if my intention causes any trouble for maintainer, I can remove Yongxing's
> > >>> sign-off from this patch.
> > >>
> > >>
> > >> Please read submitting patches to understand what Signed-off-by means.
> > >> Otherwise I have doubts we can accept your patches - you simply do not
> > >> understand what you are certifying.
> > > Thanks for your tips, and I learn some tips from submitting patches: 
> > > https://elixir.bootlin.com/linux/v6.18-rc3/source/Documentation/process/submitting-patches.rst#L524
> > > 
> > > I thinks below sign should be true, if you also think it true, I will use it in next patches.
> > > 
> > >  Co-developed-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
> > 
> > How does co-developing match what you wrote "give me support"?
> OK, I will fix sign, will keep sign below in next patch:
> 
> Signed-off-by: Yuanjie Yang <yuanjie.yang@oss.qualcomm.com>

There was already one and it doesn't help, because co-developing means
actually developing together or one after another. "giving support" is
not co-developing-by.

> 
> Thanks,
> Yuanjie
>  
> > >  Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
> > >  Signed-off-by: Yuanjie Yang <yuanjie.yang@oss.qualcomm.com>
> > 
> > 
> > 
> > Best regards,
> > Krzysztof

-- 
With best wishes
Dmitry

