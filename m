Return-Path: <linux-kernel+bounces-833975-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F3A7BA3762
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 13:18:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA3D81C22F83
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 11:18:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02E1E27B356;
	Fri, 26 Sep 2025 11:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="BSUQ5OO1"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E26C91A2398
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 11:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758885496; cv=none; b=WDLvT0cWX/hFbZcOR/Cu7myJ/MQQ7orZz9jJh/nsor7dVdG+dUq74BQh6se6HiA8te0wDI899PsABdEvDvR+TenD+P4oHXw8uJWeos4Jk20ZREEGjaAxeeqcC5NwzizHwvOadZVslbysM/ELQVQiVo5TSxPtJ4i8v8dCAvkpENo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758885496; c=relaxed/simple;
	bh=WWXLCQcdLw/jfXQnL555FapDZ2XFm55+s0Ewk9K6eVw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=P1QRg8YmWPTIKzNIcVlslD3/6JE+weyiH58bnkw5OMtMi44UShWMbbMIXYcHZ2702tiE9JD1q2UTFtvxxbFjq9UqJk539FmL6mIQRIn5cky5kyKgqTAYVN98fcTVr3qxrZ/XtxgCtTJg0K05KSdZtGfSD3Migm2wUxSC39dJbkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=BSUQ5OO1; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58Q8vwim030943
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 11:18:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Eq9Zwf2rKiWBOFDTkcfFofQ9fiSbCfKkCk6e8JzUd+4=; b=BSUQ5OO1IXahVIuV
	Vn8Ku/wW88M79HlafbRzhLbeqlgfbsYTcgba0hO3JM4RJGdeUy59wHOEI50o1ePw
	9bWfmr1qmXKbOyzPbh7Nhf1oybSp49g36xYPjfD1H1bQqUs4D31V1sqdumkbJREa
	7xDKdPmo5XjjMS+ctOvkrYZqJ9SbwqEXiIY5ILTqiKZxxBPD4dAg5fkRhV8ZFhWK
	iGEZnV8piOhPbPhu5gsQj8W/Kk7HhuJAnLWKzXAHEQk9YWtRtpNGIGAEc0Ok/G7y
	vSjaSUoeWIV8kARA2y/DZ1FoO/wDPRK9sDHrywxChABlyRLNAsXA1jkNFW9Km1gu
	S5kp5Q==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49db0u2m1u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 11:18:12 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-85696c12803so82927485a.2
        for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 04:18:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758885492; x=1759490292;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Eq9Zwf2rKiWBOFDTkcfFofQ9fiSbCfKkCk6e8JzUd+4=;
        b=vdXjjqj2V1r3IQFqBIgyMGZlQ6+FC8wtqLTvEmOjb7Kkc0wdRb0HXp4A5TeEJyPOTh
         7vMWy/w6sROnGPGItBvc3ahxylPl4DtVjm9AUE9r22+HDDAv7mNyhvZ6i5ZsSZm7tAA+
         KPJjAG2CzrQg2hdPlb74DeSKjEwAktPDXNUXT7Nwt9tLdwOYBUgAvVK+RZi2bH2+qPhR
         4mC6xMsunARnvN8y+a4ZbGvabYE0/oVDx9n9MRIQeq4PZeRfW77DBmpbNwmJGw7ykG5l
         PHoUe4AfD8z/iRpfnCGbsr9qot71TxPYFRaxqek5SLmoWCcJ5MlnEUusVdG34IHzinrA
         CM4w==
X-Forwarded-Encrypted: i=1; AJvYcCWQgr2/FYC6A6DBJMZEsyn02yBkMP0Hhf2UwqsLI9v/9eewdPASWFAFrzZ3tJv/11uTBXATwtpKERcAZGo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwlTP4aXeqod3mQW8gNud8wqyzENPMr2Nm3jp9qA5yErRn4Hocb
	rMiudnehR8YlesQBMyU2tlxdLHPZ37B+9wUEoGVE/+NEJ0IzI5v/OeKL2pjjPidFGwGTxUMNchn
	dU20i+sjhII4TeK5FUMFO6syMyyWRkNCSiwIW/jgTHnTYGQ33DoP69onUplAlfeM83fg=
X-Gm-Gg: ASbGncuxvJaVZQminIZVJLakvaTkQSrqC5slgAVAxCwQRg9NdQJm/4cM387XfI+DGtQ
	P69CbO6IgE3xkTNrGyTjIgm2jVs9+W/SMaxAzSmySvA4myl2kyUE7ejhV8rdtssF88lLwid9FAn
	1laDFuILqzWvi7+5IY7tLVUwvi07uqEd3q4SzHqqN2WGm5G5ZEK50kTRBF+8jv2ACO7m/SPlo4p
	oJrvbb6booDcH+wYtacCp6gpMcaHFnHdzBmF9G2X9SGszYDg23PxmWv1eE6sTfrsVE0eCUfMi58
	plmmq1Uqsuk9n3zf122QO7BgSiHanxTL4Np31yeCUILwHWGBXpQEUMeTngwc4JMRNlJImUU8pcu
	y2vyIoyCtb+65PqMw1INX8A==
X-Received: by 2002:a05:620a:3182:b0:812:81c6:266c with SMTP id af79cd13be357-85ae6d81db3mr601252785a.9.1758885491740;
        Fri, 26 Sep 2025 04:18:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGTjabHhK02b9oVhzoCCGFrlmQKMMkgWl8q77/ykLbuE2cCJPi3DSQKHtmGntFz7aUmVpFMZA==
X-Received: by 2002:a05:620a:3182:b0:812:81c6:266c with SMTP id af79cd13be357-85ae6d81db3mr601248385a.9.1758885491079;
        Fri, 26 Sep 2025 04:18:11 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b3545a983ffsm349631066b.94.2025.09.26.04.18.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Sep 2025 04:18:10 -0700 (PDT)
Message-ID: <652595ef-ef79-4c36-9979-b536ca65e1de@oss.qualcomm.com>
Date: Fri, 26 Sep 2025 13:18:07 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] drm/msm/dp: Update msm_dp_controller IDs for sa8775p
To: Mani Chandana Ballary Kuntumalla <quic_mkuntuma@quicinc.com>,
        dmitry.baryshkov@oss.qualcomm.com, marijn.suijten@somainline.org,
        swboyd@chromium.org, mripard@kernel.org, abel.vesa@linaro.org,
        andersson@kernel.org, konradybcio@kernel.org, robh@kernel.org,
        krzk+dt@kernel.org, conor+dt@kernel.org, robin.clark@oss.qualcomm.com,
        jessica.zhang@oss.qualcomm.com, abhinav.kumar@linux.dev,
        sean@poorly.run, airlied@gmail.com, simona@ffwll.ch,
        alex.vinarskis@gmail.com
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        freedreno@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        quic_rajeevny@quicinc.com, quic_vproddut@quicinc.com,
        quic_riteshk@quicnic.com, quic_amitsi@quicnic.com
References: <20250926085956.2346179-1-quic_mkuntuma@quicinc.com>
 <20250926085956.2346179-2-quic_mkuntuma@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250926085956.2346179-2-quic_mkuntuma@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: g7v8DmwqJ5kB3cRFfutzIA0ULIKjf4OQ
X-Proofpoint-GUID: g7v8DmwqJ5kB3cRFfutzIA0ULIKjf4OQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI1MDE3MSBTYWx0ZWRfX9bKfuoS/4Eqf
 5ZoQMh8T+RTHXuYEGauOocYovCQcvXR6AY1071KneMJrQtzeW32RyRixZrANdJf9j8KAjr3Zxt8
 6RPPz8XrWfQiN8FR6nw8r7AwTm1efJdM792cobU8CnhbfE75K/JU4j21VIqbpU1QIoIjdXPvGK0
 bzoCQz59B9u677uLIwVFy1fFhsPAHuO0ZIEWMxyRBDK2R5s2rok0Jj90eT2CXV/5gsiHPpogXmX
 I3mQlKvBL+9TdfoiLtpZWA6L4kUxtn9NxwVXFF+OF6cl6or+Lvozu8vyEejnKs+0vtcSo8KmKTC
 tKFnzpdDRI9zKyNwtyNCHwH9dFSy+XxHddebLn5jmy//9tIB0yun5gzW7qA2+q/GPjyhBCyRZVP
 OKV4krN2p+mf1HxnKKG8KYYTlnijqQ==
X-Authority-Analysis: v=2.4 cv=ZsHg6t7G c=1 sm=1 tr=0 ts=68d67674 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=COk6AnOGAAAA:8 a=tFSzMcqD3SoeBU5fSnoA:9
 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-26_03,2025-09-26_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 spamscore=0 malwarescore=0 lowpriorityscore=0 adultscore=0
 priorityscore=1501 impostorscore=0 bulkscore=0 suspectscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2509250171

On 9/26/25 10:59 AM, Mani Chandana Ballary Kuntumalla wrote:
> The Qualcomm SA8775P platform comes with 2 DisplayPort controllers
> for each mdss. Update controller id for DPTX0 and DPTX1 of mdss1.
> 
> Signed-off-by: Mani Chandana Ballary Kuntumalla <quic_mkuntuma@quicinc.com>
> ---
>  drivers/gpu/drm/msm/dp/dp_display.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
> index d87d47cc7ec3..f247aad55397 100644
> --- a/drivers/gpu/drm/msm/dp/dp_display.c
> +++ b/drivers/gpu/drm/msm/dp/dp_display.c
> @@ -133,8 +133,8 @@ struct msm_dp_desc {
>  static const struct msm_dp_desc msm_dp_desc_sa8775p[] = {
>  	{ .io_start = 0x0af54000, .id = MSM_DP_CONTROLLER_0, .wide_bus_supported = true },
>  	{ .io_start = 0x0af5c000, .id = MSM_DP_CONTROLLER_1, .wide_bus_supported = true },
> -	{ .io_start = 0x22154000, .id = MSM_DP_CONTROLLER_2, .wide_bus_supported = true },
> -	{ .io_start = 0x2215c000, .id = MSM_DP_CONTROLLER_3, .wide_bus_supported = true },
> +	{ .io_start = 0x22154000, .id = MSM_DP_CONTROLLER_0, .wide_bus_supported = true },
> +	{ .io_start = 0x2215c000, .id = MSM_DP_CONTROLLER_1, .wide_bus_supported = true },

Well, did you see what happens when you try to plug in a display
to a controller on MDSS0 and MDSS1 at once now?

(memory corruption)

Konrad

