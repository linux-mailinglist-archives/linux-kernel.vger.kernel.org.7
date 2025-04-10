Return-Path: <linux-kernel+bounces-597788-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A2E6A83E6A
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Apr 2025 11:22:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE4344463C3
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Apr 2025 09:17:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 274B6215773;
	Thu, 10 Apr 2025 09:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="dBjjiOSD"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7E28215783
	for <linux-kernel@vger.kernel.org>; Thu, 10 Apr 2025 09:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744276621; cv=none; b=DMZpCXQRjq7JtQI8cdwHC6Tu7JyTpsIekCD2/QSZ48E0dbqx5JM0hivBm97PnP9+bOOumHBJnT3apNG5PLkHBfZiu2WcTldg6qKr8zDbv4Q/dOmsK7UXW3AtLXXw5eRJpYfj6V7PcQ44i3JjxQoVJvIzlpBntp3aR6egpSuqkBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744276621; c=relaxed/simple;
	bh=VkzhrYC3yEaNvm5M6gSaSYRsNsm/ykYz+nSLqBPNH6U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b9kkZxDpMnc3cNk4DnqKNZkp70mEsfuQb/eFeHvnfl9yRjA1aNj+jdcIvh9a48UFQze24ZXCYJwu/pCh9OyHV7gvd7aiAeC+2ZPbLSRGp0KUN/RjvGgXHHoRHdxD+sKjMnVmid8zar2i8U0b8akRHXJYs63ICPYCrBfQPC1wTJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=dBjjiOSD; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53A75dsC000661
	for <linux-kernel@vger.kernel.org>; Thu, 10 Apr 2025 09:16:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=/NI4HaeWdHG20yTgWgvdAsga
	B/QNYBVNAVRuaUYyJe4=; b=dBjjiOSD0xzRRsCKkHFO3BiTt1gp1gMlwu7NcCea
	wn1eKWRBYcX4S3JyOJC0wP6aje1NUF6+kzFxd6C21x4cAvpEFAzQeIfd5QoWzSzO
	4lgWxkDfuQ45s6XRLsgClUk0I8+fRoURxQQuEqQfs4O7QLpYDTdOb/3YXDCIWSmi
	LI9PdHN/uX8aaWh4PAa+CUqw9eM4ed8BrqlG3SZjm1IONcXsUtRu6pLhSL9Esbx2
	pPDvqctjuLyKN2T3NSakRTPfGep6b5FNRQr9AX8zR9vm7ezPgoliTjLovyH0E4gq
	DtL6tqINPp3Qg12idSbsT9Z6RIAxnU9Cw63V7WUis0+xVw==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45twd2xaj5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 10 Apr 2025 09:16:58 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-7c549ea7166so95352085a.2
        for <linux-kernel@vger.kernel.org>; Thu, 10 Apr 2025 02:16:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744276617; x=1744881417;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/NI4HaeWdHG20yTgWgvdAsgaB/QNYBVNAVRuaUYyJe4=;
        b=kF9n3jdDzImPhxRCAfxyAiuqyTUogI+Fmpi7hdaOaRKqBz5LSMPzGeH+3cS3d7FtKt
         Jks3p5p1/KR1ltf3izA93BK3G5tlBX6qkfGRCc/KLT7Wx7e/oEOjmakwWnFzvyKxRp5A
         60Y2Q+xSQyBjzRsj/s1AclUtaRDV4ueTEixUdqOYK4MZOBL+Q/8FHP18vI8OyM2Ptvru
         Tubv8vzfaPcwrUIMMh1ugRW1w+VKLknU5zHEmZOPcgb0iNRIQsY9nF6zQiwnO9Ft7crC
         bFGMs4bnZQCGQp3rEiF99eT80037biOYnFfuZCjut0gvO1VkmIbVOs46RSFd5N0y+ANF
         kvnQ==
X-Forwarded-Encrypted: i=1; AJvYcCV1ybaMpZsktTD6jWXJuCojquRYiRhQYd63eoXcg0ofpbMgWoIAFaW8aktNV/owBf1bDfxCTOZejAYkfcw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMU5o+cc7pKDiEUOfsT77pg9Y292sBqbU2zt/zTsTrNURHOYIM
	eLdWtrzIAqXk6ljxGoXro15xRFjionL4IKbcV8XaR2ddafvNVS16HowMS4uMjaCsLGxUX7u0uk3
	wkFZAb09pacm/3W9w6VH6AF3AoHV9pORGYtzNZF5npubEKQ0azf3s1co0yGlsb68=
X-Gm-Gg: ASbGncvmM/ohz/ZXeU7MjKncXkUtB2WAvP56uLuGsr2BQXCrNPIlGZa8yAFdcwVD9+O
	crN1QD8XQ8978YArmFLO+l+upqjPzMHLUA2vO6SY3zpzAh0nVdeBRyI3J7RuDIUam4NjWTAKd02
	bMn//00xWoLyzIsIEdx2nouN+KKpL/JLoA9/nl7i99DSdXYkZP0seP5INjcz6pBERov6YK2QO9r
	pbYasH/iSCprjgNANirPIkBazvLsTxQXrw/rTRKScqDZ7R3dI9TC/oiG8p9IKwNbXuWskG/Q8C/
	zo/NfKcAPsZ8EZlo3yL/HGUkHorjaXLqsq9I2CoU+1SXPVTDCBLrIAiJsIiXE2eXn2TzJ9ZGCDI
	=
X-Received: by 2002:a05:620a:171e:b0:7c7:609d:d223 with SMTP id af79cd13be357-7c7a76bfdf6mr244705685a.42.1744276617601;
        Thu, 10 Apr 2025 02:16:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFvugvbzG1bQhMo5tx4WT5oAVkdX9Zwn/H4ZbJ4q7g7do1hwxxuv+2Xv7nYPcjDjrokpnPXVA==
X-Received: by 2002:a05:620a:171e:b0:7c7:609d:d223 with SMTP id af79cd13be357-7c7a76bfdf6mr244704485a.42.1744276617283;
        Thu, 10 Apr 2025 02:16:57 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30f4649d812sm4115651fa.11.2025.04.10.02.16.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Apr 2025 02:16:56 -0700 (PDT)
Date: Thu, 10 Apr 2025 12:16:54 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Ayushi Makhija <quic_amakhija@quicinc.com>, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        robdclark@gmail.com, dmitry.baryshkov@linaro.org, sean@poorly.run,
        marijn.suijten@somainline.org, andersson@kernel.org, robh@kernel.org,
        robh+dt@kernel.org, krzk+dt@kernel.org, konradybcio@kernel.org,
        conor+dt@kernel.org, andrzej.hajda@intel.com,
        neil.armstrong@linaro.org, rfoss@kernel.org,
        Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se,
        jernej.skrabec@gmail.com, quic_abhinavk@quicinc.com,
        quic_rajeevny@quicinc.com, quic_vproddut@quicinc.com,
        quic_jesszhan@quicinc.com
Subject: Re: [PATCH v2 03/10] dt-bindings: display: msm: document DSI
 controller and phy on SA8775P
Message-ID: <vw4qkj6wtets6dx4irslusnyz2oztjljymzzcmomqxlcphxnvd@gpxrdgzhu5xu>
References: <20250311122445.3597100-4-quic_amakhija@quicinc.com>
 <20250312-calm-steadfast-cricket-fe9dd8@krzk-bin>
 <654d409e-2325-46e7-a064-ed9e64277e69@quicinc.com>
 <a168a473-c363-4041-8e3e-84fa44e92b10@kernel.org>
 <zpmr6cpiixyu2sj7r7oqpqsge6dcqw6xszldf7ugznmcrxqsme@efiwnggcn5qx>
 <a654d62e-502a-4a47-96c4-a44c14860e54@kernel.org>
 <767e11cd-e338-4e00-a8e7-2e15f3da84b4@oss.qualcomm.com>
 <04d90c1b-1b73-4b6a-b7fc-351754fbb16b@kernel.org>
 <bcc44dcc-8b8a-427a-9a38-8dc6d59c13e3@oss.qualcomm.com>
 <bfab7272-5a41-4072-82a8-0f7401b2affc@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bfab7272-5a41-4072-82a8-0f7401b2affc@kernel.org>
X-Proofpoint-ORIG-GUID: jnkaMzJb2Hx6jmxaPG4AnRfRZv8R5bW6
X-Proofpoint-GUID: jnkaMzJb2Hx6jmxaPG4AnRfRZv8R5bW6
X-Authority-Analysis: v=2.4 cv=NaLm13D4 c=1 sm=1 tr=0 ts=67f78c8a cx=c_pps a=HLyN3IcIa5EE8TELMZ618Q==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=XR8D0OoHHMoA:10 a=mGSTcfrgQxl9XoTJgfIA:9 a=CjuIK1q_8ugA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-10_01,2025-04-08_04,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 impostorscore=0
 priorityscore=1501 adultscore=0 malwarescore=0 suspectscore=0
 lowpriorityscore=0 bulkscore=0 mlxlogscore=830 clxscore=1015 phishscore=0
 spamscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504100069

On Thu, Apr 10, 2025 at 08:08:17AM +0200, Krzysztof Kozlowski wrote:
> On 09/04/2025 17:24, Dmitry Baryshkov wrote:
> > On 09/04/2025 09:07, Krzysztof Kozlowski wrote:
> >> On 08/04/2025 22:26, Dmitry Baryshkov wrote:
> >>>>>>>>> +          - const: qcom,sa8775p-dsi-ctrl
> >>>>>>>>> +          - const: qcom,mdss-dsi-ctrl
> >>>>>>>>
> >>>>>>>> Drop fallback
> >>>>>>>>
> >>>>>>>    
> >>>>>>> Hi Krzysztof,
> >>>>>>>
> >>>>>>> I couldn't understand the meaning of "Drop fallback", could please elaborate it ?
> >>>>>> Look at SM8750 example on the lists. Keep only front compatible.
> >>>>>
> >>>>> Why?
> >>>>
> >>>> To make things simpler and shorter.
> >>>
> >>> I'd prefer consistency. Previous platforms use qcom,mdss-dsi-ctrl.
> >> Then you should have objected month(s) ago when Rob asked for dropping
> >> fallback and since then we consistently drop it.
> > 
> > Well... It's still not merged. is it?
> > For SM8750 it kinda makes sense, because the clock handling is different 
> > from all other current platforms. For the existing devices... I'm not 
> > that sure.
> How does it differ? The clock handling does not matter - this is just
> select of schema for the child node.

Ah.... I'm sorry, I misinterpreted the email. Yes, having only a single
compat here is perfectly fine. Please excuse me for the confusion.

-- 
With best wishes
Dmitry

