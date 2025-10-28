Return-Path: <linux-kernel+bounces-874231-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CDB4C15D1F
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 17:31:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D2A93B010B
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 16:24:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7FA1284889;
	Tue, 28 Oct 2025 16:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ip7FL2Ax";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Cn9n6Epi"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AE9122A1D5
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 16:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761668667; cv=none; b=MY7lPy3kTZz6GFPIA9iWT1GIcJp9bB+V1YlfaqiTv1UdpOkl+ykjLfYJPrnzQYw9uWwebG/0LcYgaBvhHROsde4QUsp5EMquLNxXxHtfrR7HWlD03nMYgcEvaDB7hMA9/ONLSt2lbeX5zKI3gJtG9fz0MbROOzJMJTvkAXS4WaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761668667; c=relaxed/simple;
	bh=VOOUd0yB2hDhZwiksvorsIKV3pFxYwvb/WQjdsJBQiI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=E+UEjqvGfklM53ISb3uij7q8Yos08A5lkW1z+7M5bBmONaStyi31Rm1V6Gw+g5mCqgg8lYDoAdyni3GsD4bYXVVt8Dm1XZtpXBENdj3h8pEIpRfyrjl8OYnzhQmxcsWa6PbfBIpsIyYBbu3EpTLadYtfUQHdpnwjVmh27d7FgyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ip7FL2Ax; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Cn9n6Epi; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59SEnrVY1886866
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 16:24:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	jtUdNX9bE+KPstFHDmJc5ogo2QH/VceXzJSQsB/Peq8=; b=ip7FL2AxE1KMSvjB
	OqeNoqRvNNBf/Nq+fQVY7/YBZXKCdAc4i4J53sIK9wSLU6MFnpia7l2lk6lTi4DW
	GYOgkABHBwoaC0stRcfrC1oj/Kk9GHkSt+Qw/xBUVyLAWL2d2pDP+lhxqVqx8Ojf
	g/sgjHTBY9c4/4erO/KD088sxLlO0rVixAKzVIvCYZB9Unwn4YTBkAkpR9YshbDe
	4G4SILdiMbfZFs5XMbRzk/WxyD2H0fgpnJVb5BSckBtkKV7rggBa6YjRHiGu1Jnv
	3ABPr06xWySFD0Y8+GMpqPBQeTMCpdSuhdc7vKm36pmdAK36rej3Nx//7Ek1T/pW
	/A1RXg==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a2njrtawq-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 16:24:24 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4eba930d6ecso118364031cf.3
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 09:24:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1761668663; x=1762273463; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jtUdNX9bE+KPstFHDmJc5ogo2QH/VceXzJSQsB/Peq8=;
        b=Cn9n6EpiZnds+1weKmfj5Blnte3ssFN794F1halXvxiOti02sFnvpyu1R8oB/heiJ8
         9/Z4GZvjpvuFF1vaz0QaSRfZRtXzXjhQf3OpBz9jpAJwEeaHXG8R4ZG+oEU3zeSM+5yN
         cdZriGBWdl7LjkXbxcTK64ecZPOMD/9bT2BSQKtSC/w5Z8uAEhOPfi6eeYabafcsxrwo
         zUI4toFvAslo9JX1ULV4oiEuQTj/AjUg3InvtQ7ZppA083pNPGsz5R0tm6J7ZoCXWHhE
         86ORUhsBp6Cjydgz1C/h02kFtPMsteF48FXheTIJT9KtySnNKuX0miSCetcn37IwFYuW
         LINg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761668663; x=1762273463;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jtUdNX9bE+KPstFHDmJc5ogo2QH/VceXzJSQsB/Peq8=;
        b=SFdZp+9WP1EWHAd4A/rAF9YTdHUxeuExz5L+EKc/FXCUqvs1asaqWylHtrfErRDDtx
         b9MAPGQOW6QtZaIrU/uuKS1BLvVRrn1XcFrKMFDoclASGjOvGRV7IQv+oUGJIsGceYDH
         2tN7EJUbWKpmagJ8w/73Xa+GUMj+jQg6tQY+EDIPK0gg1E0XM/LsmOqcsCiV77LTiHom
         l4fRlBME2TfGBjCzkb+6erFnksVOFF2JICr3S+7AKnsh/CP/pL0ZeU2aCeKPKpBCUW+V
         LFYjsM312YgKpSOkR1bCvmoZgvZv04rHika2YONFCzjMDZpviZMXbgnmBXm01PRxElAQ
         fvNg==
X-Forwarded-Encrypted: i=1; AJvYcCXMzRw87Ql28zhR7Iq/MdMU36oURt/zbeS7LU/omPNf6cz/7LzMpDpLH4NVwGZeSwZuMyfYbV6YfRzZE04=@vger.kernel.org
X-Gm-Message-State: AOJu0YysX2kyWPMbifAR96+QM7uVWT3KExP47U80CUktIaqPU7MyGSNK
	vx1Pec58JASoW1ngd/AXpgLDDdjd4dcyxh4485LX4vNL1AMO/n8i6ioezapS0QCYpuVLWQYuGkA
	VLuNyab1nZBUu78Q407NM2jRe1NomRIExtz/AEdjg2c9jjacNKoStsGOs7l8jyLfkygM=
X-Gm-Gg: ASbGncsDNtJSTX4ignm1jeDCjsgyGwA7g6hgRrQb/AVCua0V+HIN/2A0e0JLji1ucR6
	Mb4tkvkEN+OYbmnLUUztXRlg12cJhAcNpQ/GeWDlZeC8YoYrwrpGVmb+ZUVf/RulEd4g7KyKY/n
	cw4YwsrLC20qHok0QTpM97QSpRrKdFzgd/VqQ39EMAlpv4gmeXzZpdIttGD/ZyyFVbc53W6fT7b
	LW+7u5Lwd/zbyfNOG8Bl0AJ191pHqUoB5piSPTaXg880cqo/BiXOoBkNnpiK/H3fjKHczO1CVBD
	M5V9hvPSKmcdWr/8v21fHwbjRQg2gpK+lU1vu/PcZgb8/HVTNZ8G2TryStJy44fA/9f+Zf09IFQ
	yL82TyPbc0Lph5p40q6993eVbXDuInTyQcK6ms819opynaFatR7w87u9Zc9R70DkDx5QafGTr+x
	wshg==
X-Received: by 2002:ac8:5715:0:b0:4da:155a:76fc with SMTP id d75a77b69052e-4ed0743d17dmr55587781cf.16.1761668663431;
        Tue, 28 Oct 2025 09:24:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGCKOFPOmfgrI7A8CxeXrD8u3C3qKFzqHwtQzNQov7iv1sjzmfKzAIHqNkJuAiIPIF5+4qzRQ==
X-Received: by 2002:ac8:5715:0:b0:4da:155a:76fc with SMTP id d75a77b69052e-4ed0743d17dmr55587131cf.16.1761668662840;
        Tue, 28 Oct 2025 09:24:22 -0700 (PDT)
Received: from ?IPV6:2001:14ba:a0c3:3a00::4c9? (2001-14ba-a0c3-3a00--4c9.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::4c9])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59301f41ce8sm3240866e87.6.2025.10.28.09.24.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Oct 2025 09:24:22 -0700 (PDT)
Message-ID: <23b6e21b-40e1-419f-9314-97eb685b9aef@oss.qualcomm.com>
Date: Tue, 28 Oct 2025 18:24:21 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] usb: typec: ucsi: Set orientation_aware if UCSI version
 is 2.x and above
To: Abel Vesa <abel.vesa@linaro.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Dmitry Baryshkov <lumag@kernel.org>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20251028-b4-ucsi-set-orientation-aware-on-version-2-and-above-v1-1-d3425f5679af@linaro.org>
Content-Language: en-US
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
In-Reply-To: <20251028-b4-ucsi-set-orientation-aware-on-version-2-and-above-v1-1-d3425f5679af@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=dqvWylg4 c=1 sm=1 tr=0 ts=6900ee38 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=x6icFKpwvdMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=KKAkSRfTAAAA:8 a=R3k_ItCzhSAMZnOdhvsA:9 a=QEXdDO2ut3YA:10
 a=dawVfQjAaf238kedN5IG:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: tH9bzAGAOBYbJDKT8JmKrJlQPcIdOCv_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI4MDEzOCBTYWx0ZWRfX2Gtcyto/MKxo
 kgmnr89WkfS3jUDdhKpRN7MY8ReEiupgaEwFK4obsLM9yAioSz6qyW9rEtMpaX9zHZfOtNddR8u
 Zb8v4ub86nrZSBMjiYEyrXjmsjvSHhqWSnqCfvDZfHxKkFmBOo5VLMZxpcQetIloXqdtfBgtI2L
 7WkEdgbXmi5FNPeZ0BS5genUjma2UprvVslgJyHIrXFNhqbNGWtZl1vnlxl5/m/6A+kgtuaGs0h
 K4WjDu8aht92wGoIOR97Val4/vuPPAh6g5XHvFYoTrH7jBw0P8FcGV1BSocQMua7iHUH+PDHwKN
 H6C2bncArKxmJoj77ShBp38DZOXmgPwFjE7ALzVybU42BLR5qaE0SVkBbIWO2DvlhBvnp8TYFIO
 aD20NPu04K7x5Z0HYei7VfAPNb9WLA==
X-Proofpoint-ORIG-GUID: tH9bzAGAOBYbJDKT8JmKrJlQPcIdOCv_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-28_06,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 impostorscore=0 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 spamscore=0 suspectscore=0 malwarescore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510020000
 definitions=main-2510280138

On 28/10/2025 17:43, Abel Vesa wrote:
> For UCSI 2.0 and above, since the orientation is part of the paylad,
> set the orientation_aware by default and let the implementation specific
> update_connector op override if necessary.
> 
> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> ---
>   drivers/usb/typec/ucsi/ucsi.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/usb/typec/ucsi/ucsi.c b/drivers/usb/typec/ucsi/ucsi.c
> index ed23edab776354f08452c539d75d27132b8c44dd..84afa9bfc65b6e6ad0a8c1856252299c16562baf 100644
> --- a/drivers/usb/typec/ucsi/ucsi.c
> +++ b/drivers/usb/typec/ucsi/ucsi.c
> @@ -1637,6 +1637,9 @@ static int ucsi_register_port(struct ucsi *ucsi, struct ucsi_connector *con)
>   	cap->driver_data = con;
>   	cap->ops = &ucsi_ops;
>   
> +	if (ucsi->version >= UCSI_VERSION_2_0)
> +		con->typec_cap.orientation_aware = true;

This is not enough. You should also parse the data and call 
typec_set_orientation().

> +
>   	if (ucsi->ops->update_connector)
>   		ucsi->ops->update_connector(con);
>   
> 
> ---
> base-commit: f7d2388eeec24966fc4d5cf32d706f0514f29ac5
> change-id: 20251028-b4-ucsi-set-orientation-aware-on-version-2-and-above-b79245d4b066
> 
> Best regards,


-- 
With best wishes
Dmitry

