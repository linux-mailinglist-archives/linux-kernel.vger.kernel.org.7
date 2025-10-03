Return-Path: <linux-kernel+bounces-841683-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C1A7BBB7FD9
	for <lists+linux-kernel@lfdr.de>; Fri, 03 Oct 2025 21:37:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AFC294A8510
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Oct 2025 19:37:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F007227B94;
	Fri,  3 Oct 2025 19:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="bq6WpBaF"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B2A821FF47
	for <linux-kernel@vger.kernel.org>; Fri,  3 Oct 2025 19:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759520265; cv=none; b=lmF4oWlJLI+HFHMUJUvwEDqub+/iVATHV3x7dSFktcWxUtlgxmwiM+R2asd4iD7LyrMBBKC+/oRGfllowI6dSGJMBZP9iy6+XNxmXFosh4XKRNlPwMFrVH/AVaSrzA4MEFFtWy9lrkakBMPRD6eClEqCSJXe3UGOgb4vYklOyDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759520265; c=relaxed/simple;
	bh=L6p/x9voTECqLfOdeh8AIPH6YGnYNQuYZvz+8csEnOI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YtlB1BQYTU0ssMH18aLBEIxEy7jMON0H7gUaEScoB2diPTL3o1IbuALiSajSrPgGBRx2KmR5gISQNPc5xvcr8OLRX0OTUv4H6CGS3UFARFU0No97ntZVAUMFqNjS8QzNMkjQYwqC+03RUllVNHukIcelVbHjd/p1bo4Or6AonPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=bq6WpBaF; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 593AxFs4006633
	for <linux-kernel@vger.kernel.org>; Fri, 3 Oct 2025 19:37:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=OFUrlQLsepMyX0Jz/227i1kP
	IOkJPXkGhpbqceCOZDM=; b=bq6WpBaFk+06wBJwEH0qnWtIXDM7XynAj2EhI00p
	0F0yQKrOjKuG2uD9IJDjX3fBHiA/AaKQV+r8JNIpbKckfk8TYGxHkbyXxHFD1TQQ
	w+hr0slZQ0fTTFBO+3SkLT43KmmQKQFz2paiI0SRuA6ap1+BGolkskmA4+IjF/3M
	R6pzz/sdzb4rcHEmX3yjh6TK2T3RH4kNuVQLCp4qzO9qa6HbKYatKVTiieMWl2HA
	X0vwvwlKecuiNMH7e2u1y+3lScRfaLlQ/4Bm0+/OihQTqQ/J3L9Elig2wr1mH7Fw
	6q310s/SQgoSlUVmROT43PxGwKt/UW2Cejt1kDRi00ksbQ==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49e851utxt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 03 Oct 2025 19:37:43 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4e1f265b8b5so58916441cf.0
        for <linux-kernel@vger.kernel.org>; Fri, 03 Oct 2025 12:37:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759520262; x=1760125062;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OFUrlQLsepMyX0Jz/227i1kPIOkJPXkGhpbqceCOZDM=;
        b=Wz4DCLK/lv4J04K+TTlrWcQ9wC4GczJGvvACf3WwhAh7kS0aqfFcT3XWu4JdhsyGGK
         MbsFzAOrQqzJ4cT7u4XswVJ8lkgNm4EuUIIWE2ekmObNtycgiw79Lrbct9ttJE28kmuY
         jZSu8qcB3MVqicyxj077Eed60ML/CYyD/erjrhaafFVj5qUMKxO/1igiTeH7ixIcNONK
         SNoxiw0YcLVoZnnMKAWvdzv/87Pia1Uty90SlWE7NYpoOWBRUhYHu0eWLvwv4wNmsRiD
         /f07JYnAXoF7jqqvBkD4A+xB8jG2AykJ177wEVxReK1F4fy5yvAoZfSOrkdqsbkPUfYM
         x4iw==
X-Forwarded-Encrypted: i=1; AJvYcCVy4Srmbu4v7+H4HzQo72gT6KBPKhMdQDVeRD1cn1abuLe9LbbWQLum+EqgcGflmUZJGZ5Y6iKUrOH8zV8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwthGM8YkjwE5ITc6lhPEYAyuSJt2z26NRa4a5fQYCn7eWhTRA+
	F+k4mPnXBe6l073l08rTHxZZ2ghWNNYYkPP3LCJyjnm7Chsxrgtqv2CUPH+7/lkbKYjQL04Caiw
	xngCKQM8LHxfr63R8A7LfiSiTTsjP9k5IzQLJX2xrOKGj2AOUifD434asu7JxvEnTFxo=
X-Gm-Gg: ASbGnct9l9FgoBE9oqhcbY8PssVp+tRSpJxvIUe1DjA97MVcOT+pZsBx6ATp43yC+HC
	/HtoAmWPSeCWQ06zu34XFtQRCnSnmIgn2FxTnpuQ3runiNDRNA8P2TXpXgBHtTezyV82j85fdfI
	7Vw51bbrXJrnDcd2JLMpiCIxGRRxUmrFjnLuLHh3+rcsbeN/89edGo1Ts/JVnEeNSdlUCRRG8W6
	00aSdgoQ0Dkwb5t6GX6WOAuYNgOfe5yNM6O8Pfd8GuZ/u3L2Gm7s0EsLHQCvEbbYZj/GNbV9V4h
	7IuBzzK44qVoK2w+jMQapbCvPeFdpSswdLnaCuaBzTvPVzNNozT3Wi0fY9tmfZBE4Up752GBuRJ
	dtuTPG2xhAfQJ1kv0D19nSUX93vmzGfhmUX0XDc2z+AHADq97/NXh4s6MTw==
X-Received: by 2002:ac8:5fc4:0:b0:4da:207:f0f8 with SMTP id d75a77b69052e-4e576a418f6mr52319181cf.11.1759520262083;
        Fri, 03 Oct 2025 12:37:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHJeAynDi2ixAidT7oxs33QpSn6Idl2n/OrcQ46tde8eNgyX5FczSTYJrNB/bEEPlCldm/kew==
X-Received: by 2002:ac8:5fc4:0:b0:4da:207:f0f8 with SMTP id d75a77b69052e-4e576a418f6mr52318751cf.11.1759520261512;
        Fri, 03 Oct 2025 12:37:41 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-58b01135a82sm2103189e87.39.2025.10.03.12.37.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Oct 2025 12:37:38 -0700 (PDT)
Date: Fri, 3 Oct 2025 22:37:36 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Konrad Dybcio <konradybcio@kernel.org>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Rajendra Nayak <quic_rjendra@quicinc.com>,
        Wesley Cheng <wesley.cheng@oss.qualcomm.com>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Sibi Sankar <quic_sibis@quicinc.com>, Abel Vesa <abel.vesa@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Bryan O'Donoghue <bod@kernel.org>
Subject: Re: [PATCH v2 2/3] clk: qcom: gcc-x1e80100: Add missing USB4
 clocks/resets
Message-ID: <rdmpmfvspa6kjmwedpouy2nndl6okdrb7q2eenvcvpnnk67wp5@56fxgwfc5t5w>
References: <20251003-topic-hamoa_gcc_usb4-v2-0-61d27a14ee65@oss.qualcomm.com>
 <20251003-topic-hamoa_gcc_usb4-v2-2-61d27a14ee65@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251003-topic-hamoa_gcc_usb4-v2-2-61d27a14ee65@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=OJoqHCaB c=1 sm=1 tr=0 ts=68e02607 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=x6icFKpwvdMA:10 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=vYJjhQUXXu9twL9fmf8A:9
 a=CjuIK1q_8ugA:10 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI3MDAzMiBTYWx0ZWRfX+cc4kOlQWdPV
 q9ieU4AMLZNx+GAp72wY3UwVizfyi1e+nPUCBrKAEtSaFaEuxTQ5Q5hAoIylqh5PuajQtlisQV5
 PM4okwXGMsKU33q2B9OvzeHTzYgj9Q+dnoAgCgQHGwblw2D53E5Z+luJMt3NS1pWu3rWrc16ku9
 BOqYCBZYaQEWpN+zcRuL6RVxs0WmFyyz5S3NHSNU2MecAPNmswKgRCSoSs7nqqhdbTkyEcoRAeC
 RrWX00nWjfa42wBuCzbv3aPO+CIIMPi+ErnB0A87JQNMW+WnfsISlc2Phk14dtwkStg9RLS/Z7w
 a7NWk6yCxtj5HhzNPB8W/QaalTDMwHNHhchJ+xp7/Y8QCDGoX47YksB493si+sjH70LY7xRYGhi
 HTBzmuOpkMQUndjMl85GBNmRR2KFDg==
X-Proofpoint-ORIG-GUID: -iRuTrhECRUNotXOLAeR9K5fkojBCEgv
X-Proofpoint-GUID: -iRuTrhECRUNotXOLAeR9K5fkojBCEgv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-03_06,2025-10-02_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 priorityscore=1501 bulkscore=0 impostorscore=0
 suspectscore=0 lowpriorityscore=0 phishscore=0 malwarescore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2509270032

On Fri, Oct 03, 2025 at 08:14:39PM +0200, Konrad Dybcio wrote:
> From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> 
> Currently, some of the USB4 clocks/resets are described, but not all
> of the back-end muxes are present. Configuring them properly is
> necessary for proper operation of the hardware.
> 
> Add all the resets & muxes and wire up any unaccounted USB4 clock paths.
> 
> Fixes: 161b7c401f4b ("clk: qcom: Add Global Clock controller (GCC) driver for X1E80100")
> Reviewed-by: Bryan O'Donoghue <bod@kernel.org>
> Signed-off-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> ---
>  drivers/clk/qcom/gcc-x1e80100.c | 698 +++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 681 insertions(+), 17 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry

