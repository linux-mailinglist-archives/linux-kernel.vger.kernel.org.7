Return-Path: <linux-kernel+bounces-781772-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 29CE0B3169C
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 13:46:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE6DAAC0185
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 11:43:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 208C22F1FDC;
	Fri, 22 Aug 2025 11:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="fYAOCsr5"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17F4F2F90CE
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 11:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755862983; cv=none; b=AzysvRacWs5rXlJMpnMO+NiSlzdz6hvduLUTUZglw4Ixosfxgsn5s5U+sX1NpZ0EmW3Fo6aX8q1DmRSy83P9dBbNmKQsEWuk5UiTVexXYFa/o7D7azVnb2anphY2cWWJZq/e/TxuKRjRfjfzWrYWvJm7arPGQJu3020XjGUFbFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755862983; c=relaxed/simple;
	bh=7a/WnaSPj55K8edhn3E5yhFLYk360KQJsw5XrPi5QA8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=esC4w6ruFKonr3KZk/rK86MwTRvxT+lltyh/YsfrXVmJH4lutR/lqThlNbWRM+6xlyaK3gBTCTiHfkTsWRZqxw1KTj67JnUBelPeVbkaPTuEIWF1vI2RKT2hhxYI/OKLKwGvtnezRciITIykpfdNhTeMylEVyQxMmFOKDhdzbsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=fYAOCsr5; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57M8UQLe021808
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 11:43:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=tgTz7yxNUzClQiIcX4b6JBav
	BqVRBHXbupABDNM7vtU=; b=fYAOCsr5tbBL4NRTCiHeGXfBgGz55sQtMnm3YUhI
	6VNwk6Kg7J2PhtaNDLAKfDvNwfI06oq5aT0PUYIofROHRgGHr01aYp36g7QcqbjU
	rl3dor+cC1jJeVy7SlHnLWUXgb9h7LAv8lDQ+x9ZTNeJoejspD+IkcD/83VitQt6
	IY+TRTP+pyIpCi65/RgFS7YtzAuW8Erd5Z238eoNEQmpeo4dmYWNTDMqrr1JO7+x
	BpWRszdtr0wvAOpEjTrkZr7RU3u7qDRwmDtQ1mgXcMFrkI2maLc7xaLgAfHxczuI
	bXP/qrFETcSlezpbXK/orQisJmavKYIktjC+7POCI7U25Q==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48n52a939m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 11:43:01 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-70d9f5bdf67so10045176d6.0
        for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 04:43:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755862980; x=1756467780;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tgTz7yxNUzClQiIcX4b6JBavBqVRBHXbupABDNM7vtU=;
        b=QiESoIIOQv03kVLJO40uajogMWfizGSNy3IffcXmdEjDZF7PPExFAslkd4BSI6mx/i
         zO8Jh815nUl5pM0YtmFdjX7VM7Jg0Mgwz59uiKtukQTwegkgBf7PV/OxFUZuyriCTInA
         XIZG9YtQE+12oCyqokWAVMXvV+o7BGRPui1lfOJ/uMVH825x2Y1B0NvI9hCraWRLQLe8
         Op4t52OyKGrXNCW3fvn6dv4MdSClGn8l4fU/ctpVQfr5uQU2jOcpSvQToazCP05SrEcP
         /HVlv9aj4Sg6IS/svNVH5eawVhjjQaueAxQl4DtIDKraxfuX+5CVH4dv0EiGaxqSQKmP
         w1Og==
X-Forwarded-Encrypted: i=1; AJvYcCUxfFQchqNA2AdLay4fD7sk2t43/jCoCMcmcenSuD6RtX8J5RE7YjIkiYxNQUyeiY+eGbQafWAZBz8vt/Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGpBXTTUGCFBeA+8SEASBK2/iqHFnr+HetxYdETlTKqsAuXgiF
	2WRrTPejqH2loPxVUeY2SrB+2jHkVFy9gr01v9RhXfRC8T2Oh7oD96qqvYgHJ6d4XlOG/CTBsyl
	/PrkEjqepvl4hEBbm/rhLp67smiDkB8GJPR0aJBLqmp/iGEfBVO80Nn9lRtEf0Y3m+C0=
X-Gm-Gg: ASbGnctyhL8gIX6394pl15b36ksDlRofr0lJUBnADm2HQqmSyC9TMYQ2mh/j2S348tA
	2xdaRMTl2R/c/T3SGGw3x5yg5rqGDhMxWeJmzyWLy0rZdIFC/5OHoS1H5WDatzeg8MxQNfRk/o/
	e2tPmm325MN5NFXhtQhBSeM79g3F/bPML+VL7pmdwCrSxD1SNMf9EeNe7UJikG2hA+ez6pDpPHr
	GaVQwPRb/0Hky1FEenjWOQqMTnTtzOynUfgABEEDKdR/kBXIjVgcFcgp9VImF1YKL7qYL9JvWu/
	b6bYVwW6cLoDUghjeWrdlZdN2IrCht36A0fZu7PQ/UsfTBCY/YtS4e3WGMLosbY8zwkU1XIDZPm
	Q4pq6y55IJQPRZlk1cwRGzwQlOdmqTTm9l/lqYpKY7gF2UTsNQh+l
X-Received: by 2002:a05:6214:c8e:b0:70d:479a:ca6e with SMTP id 6a1803df08f44-70d970cdea2mr33545796d6.8.1755862979968;
        Fri, 22 Aug 2025 04:42:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEdRz6hdH7m4nOBMkuiSMbEeU+mfLZWmnffBKcn1rd+5I9DQW3QC15nh5Lpj4VpWDwLhDkI8A==
X-Received: by 2002:a05:6214:c8e:b0:70d:479a:ca6e with SMTP id 6a1803df08f44-70d970cdea2mr33545456d6.8.1755862979349;
        Fri, 22 Aug 2025 04:42:59 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3340a44b538sm36210471fa.26.2025.08.22.04.42.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Aug 2025 04:42:58 -0700 (PDT)
Date: Fri, 22 Aug 2025 14:42:56 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Cc: Sean Paul <sean@poorly.run>, Konrad Dybcio <konradybcio@kernel.org>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Connor Abbott <cwabbott0@gmail.com>,
        Srinivas Kandagatla <srini@kernel.org>,
        Rob Clark <robin.clark@oss.qualcomm.com>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Gaurav Kohli <quic_gkohli@quicinc.com>, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v4 6/6] arm64: dts: qcom: qcs9100-ride: Enable Adreno 663
 GPU
Message-ID: <g6fwzj7njcxomwoze5phbyt5xx24s4aeaxq7x64qe5esanabix@okocxeysh7xa>
References: <20250822-a663-gpu-support-v4-0-97d26bb2144e@oss.qualcomm.com>
 <20250822-a663-gpu-support-v4-6-97d26bb2144e@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250822-a663-gpu-support-v4-6-97d26bb2144e@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=feD0C0QF c=1 sm=1 tr=0 ts=68a857c5 cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=lIFQIvOu6nGuaiKUdkgA:9 a=CjuIK1q_8ugA:10
 a=1HOtulTD9v-eNWfpl4qZ:22
X-Proofpoint-ORIG-GUID: XdErAZ9Cl8PTcsQK3UpowtY2RTkQvBQ6
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIwMDAxMyBTYWx0ZWRfXzO9aql5CprKR
 8yXMm4u4KjRr6lX9oLAal64RGUIQZqppMCulPdXTdRrapFOlfgOAhuElZ3Sr06kUBeUtz6Rsf2K
 3h/KRU/3/pFm8Sl8M6GYl6IkOS0TSa2QGxqby7QO29ijaC9UVG2GSObTck5ILc4YdTriLd6yb/6
 DQ2L8YE36yCN1F1cBxmW1ykAYYRfAFcHuoKuw6A71210fDHVJqqwlBdRmVctsR5+rGMYv+1pH8o
 Jitfmz3Qm/sssqL5FYf9BWOvGMpS7tgwVYYVtgRpgpNtCJL8Rf29O4a2Cjac7C760RG5fji1Zxi
 Bu1d0LM2QJ4gJyPVW3IryaTrhPY2M7U8/vVgSwEJoDJ1uvVVYXyFaYbe9nMFNCe7BDkN7pogZTH
 i9G1njGL1vN/DQ+zcmDZOTdDaFuQiQ==
X-Proofpoint-GUID: XdErAZ9Cl8PTcsQK3UpowtY2RTkQvBQ6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-22_04,2025-08-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 adultscore=0 malwarescore=0 bulkscore=0
 lowpriorityscore=0 spamscore=0 impostorscore=0 suspectscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2508110000 definitions=main-2508200013

On Fri, Aug 22, 2025 at 12:25:31AM +0530, Akhil P Oommen wrote:
> Enable GPU on both qcs9100-ride platforms and provide the path
> for zap shader.
> 
> Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
> ---
>  arch/arm64/boot/dts/qcom/lemans-ride-common.dtsi | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry

