Return-Path: <linux-kernel+bounces-729736-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 959A3B03AE9
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 11:36:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0AA6E7A369C
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 09:34:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E896242D6B;
	Mon, 14 Jul 2025 09:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ZyXJPU1S"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69BAF241136
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 09:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752485754; cv=none; b=lws9oYCgJBPTeHs8v27VvEBaBzIU2m5m0dYNgn7X7YLOelEzzp1LgRM5dT190gFil/pkOBBi0G1wV831V6YTdN79NExPWzm1WkE0GspyyzTwAnz40P5LYTlL1j+f+5vNoD/FpNyQ2kyoa6f90ZqyOppNgk51a/izcBMQepwF5vY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752485754; c=relaxed/simple;
	bh=ru+jpxSTrNborX2bFBxdcyMpqdQrMupwkrZFcVDWZfQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=q6q/x0JOgCDbsvXNBkVpLfQmzhZzwJIyzAIqIOQE9EKQU0PqIUbPEf7VgNnTTAjiCUD1q2ClhfgksmA0hYIa7RnGYsnQdDNKrwpCXIbqexqAXkbYIS6WaOAmMgP7LeKPSq8a0LxscuHuP5ett/7lC1mtnn9Qh0T4OUl2zpPC294=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ZyXJPU1S; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56DNMOdY026519
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 09:35:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	e7zrisRWASLUd76UBSE8vFhiT+0G+v9sbTXyn1lJGAw=; b=ZyXJPU1SfZ/vrK2D
	SQlPwcnf+ETIFiVlrlCYhEPEph1lDrp55tR/MWPYKFySMiZglBnknHigufYreI5P
	86j8+DQKlXM+sLnBmjC/tGbvbjOaOw3irtcSodCZVaJLtF97IfBZMaEAcJoSgWzQ
	stVU8Mkxq7jJkoS8KO/ymb1cxJmCw1Z8yTRFgvLuxgbuz9dMpAODie684ugnbcyg
	uSc2f5kqEa33wUcdUBSRurmSjqUTS0uNL67XOFLYpSmA17e0qLtz/zzpWQdEURxs
	0f4tiXhe6EmuZDZV+ZFbaLJ1TQLQETZcEpnjD1WoRdrDPGahdHbFxsGB7Wx7Vrpl
	A7GRxw==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47ugvmv243-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 09:35:52 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-6fb030f541bso15565176d6.1
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 02:35:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752485751; x=1753090551;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=e7zrisRWASLUd76UBSE8vFhiT+0G+v9sbTXyn1lJGAw=;
        b=M8wk0xQsBp1dpcqKHIA6Ndh1Gc6pKecWG/ohGzD/bXUm+pAIu7MrIEroZFAthxvPBa
         +Ll0leHRMRJUz0TAQP9xRziC+hrpFPCwG+OabF0XLgZV9zFYh+2KNezyhxaDtjVLVI/z
         q900OgPM7wQSXgkott4NUH7fGeM4H93wVp1txKkN7ioKnV2Uj/mvch3YK1OdyYmVSTyZ
         v5NjAVJCknQDSNDJyXU6XLDgtbVYgYWeDHF02gAkHal13+DU2yCAx/4/nfgN8uv/egME
         i+lEIgQ1Zi4IV7OWU54kWiGdQX+nLcVVP+VxEzUtECYl3yPZRWNrrTKBQko7kJ+sDoQX
         fYzA==
X-Forwarded-Encrypted: i=1; AJvYcCVv7opXUKAl0GfwJoPEqf8xI03++7ufBVFaPfRkr6CgxYkKPyVnxclekExmSkXPN2JmEBt/frJ3iBdPOSw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVbyOzqHkaBBkXkeynd833ASFLCaBPaDsAJxZ/TzxQz7c7m8uf
	CE+CDE+4hV9G6m9rO8X+vimAsNjly+t1DD0t3jTDqgCw3waTHvGDJEkj3H43Cq1EVVGLiJniDj1
	YtoxhwM4hhUcyOm7kU/Gv6hLjdPiXIXeyAQQqMVIBc0v3aGvhpiI1QM/bMyOsCZihXPM=
X-Gm-Gg: ASbGncuk0t5f7GjkgmdO6qRZ+8nW/ylCMrwfTsEEFTgWd02q9opwiP26Ax3Uj95o0qI
	Ii+h6njtyXF7vA1/ysV0R1XwUDDYJMXHuEcjs543BweKd6aQ/mbazXlzB7gQcnxOsl6+moMRnNo
	sn20e7RasT2oNf7WJyABdkPMFpp+ch8tKrLxZZA3E2NaiA0vYNZ2SGSlPs863H0NbAf3412xU3j
	xuLpKA8rl7m9ZSkPUxm41523PFZy15UVWMvqrsAgKepRj6RBuPJcC86//z9SAof6j3AuM4OEvhk
	xJukDJfjUkCSnvmrvzrns4t0vyD0EW/Gi1qnpJep1JgmJyuD7YZ0k1DzIviMSlhyWYZTeesSq1+
	DJanFOexipsMg0BRsESaV
X-Received: by 2002:a05:620a:29c7:b0:7d3:c688:a590 with SMTP id af79cd13be357-7dde9f3ffdbmr577278785a.4.1752485751113;
        Mon, 14 Jul 2025 02:35:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEPBgHK2WKHaRZG5vMxzXtbPdkk1Lmydmr3moeXavVZ20BhmDNvzkpBN20H9euW8Kvu2AQovg==
X-Received: by 2002:a05:620a:29c7:b0:7d3:c688:a590 with SMTP id af79cd13be357-7dde9f3ffdbmr577277485a.4.1752485750600;
        Mon, 14 Jul 2025 02:35:50 -0700 (PDT)
Received: from [192.168.143.225] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae6e7e90afesm796156466b.32.2025.07.14.02.35.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Jul 2025 02:35:50 -0700 (PDT)
Message-ID: <7e65f9be-275b-4760-82d7-679ba3d7ee83@oss.qualcomm.com>
Date: Mon, 14 Jul 2025 11:35:48 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/7] media: qcom: camss: enable csid 690 for qcs8300
To: Vikram Sharma <quic_vikramsa@quicinc.com>, rfoss@kernel.org,
        todor.too@gmail.com, bryan.odonoghue@linaro.org, mchehab@kernel.org,
        robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
        andersson@kernel.org, konradybcio@kernel.org, hverkuil-cisco@xs4all.nl,
        cros-qcom-dts-watchers@chromium.org, catalin.marinas@arm.com,
        will@kernel.org
Cc: linux-arm-kernel@lists.infradead.org, quic_svankada@quicinc.com,
        linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250711131134.215382-1-quic_vikramsa@quicinc.com>
 <20250711131134.215382-5-quic_vikramsa@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250711131134.215382-5-quic_vikramsa@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: 2awfxXBKpRepxrvyZHwIFf97kR7qXgaO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE0MDA1NiBTYWx0ZWRfX6voCbCu6AvFg
 AIB2uGLocIRTc1XD2J5sNwdMVqnrn05/CeLzkgQ9xpgxrD/y+kOp3bC6zFXow79IGaWX4R/bKJw
 Z0Woe7u2+4AAkqjzSvO3JqgEAJBQXF7gFhgr+0SMB+PfqVVEM8VhoK16IiiQ/kHRf59K19LXWxW
 SoZmWNKNVkjtRCyCEEG4QQWM3i2yNZgsFqRB1GTpK7Mp2wqb2h1SHn19vDuDevSuIDE0pH0z9/R
 PCCP6xavSG7rL4e7I+B2o/Xg6N7yDCVxa75khsj+UMwcyv8nmsK31bESgoSeBGjHXXut0qQSpkH
 8pbgr0aNcsZTJYp9hEi1A3CSaKdHpKuqeDSUejcqVlLNt/DUjzoP1uqBF8ANeTXgrWwTOUelDPq
 oB2wZBtJ3bMBHfN0nYZY8uDRfJu1+ykqKaPcjNRvqjDTaXs3oIG3Lvg8/II0m1HS3vrV6qUe
X-Proofpoint-ORIG-GUID: 2awfxXBKpRepxrvyZHwIFf97kR7qXgaO
X-Authority-Analysis: v=2.4 cv=C4fpyRP+ c=1 sm=1 tr=0 ts=6874cf78 cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=COk6AnOGAAAA:8 a=_OLkaYxBag4VyamGeQYA:9
 a=QEXdDO2ut3YA:10 a=pJ04lnu7RYOZP9TFuWaZ:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-14_01,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 mlxscore=0 suspectscore=0 phishscore=0
 clxscore=1015 lowpriorityscore=0 spamscore=0 malwarescore=0 bulkscore=0
 impostorscore=0 mlxlogscore=999 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507140056

On 7/11/25 3:11 PM, Vikram Sharma wrote:
> The CSID in qcs8300 is version 690, it is same as csid used in
> sa8775p. csid gen3 have support for csid 690.
> 
> Signed-off-by: Vikram Sharma <quic_vikramsa@quicinc.com>
> ---
>  .../platform/qcom/camss/camss-csid-gen3.c     |   5 +-
>  drivers/media/platform/qcom/camss/camss.c     | 136 ++++++++++++++++++
>  2 files changed, 139 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/media/platform/qcom/camss/camss-csid-gen3.c b/drivers/media/platform/qcom/camss/camss-csid-gen3.c
> index f62084fb8287..581399b6a767 100644
> --- a/drivers/media/platform/qcom/camss/camss-csid-gen3.c
> +++ b/drivers/media/platform/qcom/camss/camss-csid-gen3.c
> @@ -47,8 +47,9 @@
>  #define CSID_CSI2_RX_IRQ_CLEAR		0xA4
>  #define CSID_CSI2_RX_IRQ_SET		0xA8
>  
> -#define IS_CSID_690(csid)	(csid->camss->res->version ==\
> -					CAMSS_8775P ? true : false)
> +#define IS_CSID_690(csid)	((csid->camss->res->version == CAMSS_8775P) ||\
> +				(csid->camss->res->version == CAMSS_8300) ?\
> +				true : false)

== tends to return either true or false without the use of the
ternary operator too

>  #define CSID_BUF_DONE_IRQ_STATUS	0x8C
>  #define BUF_DONE_IRQ_STATUS_RDI_OFFSET  (csid_is_lite(csid) ?\
>  						1 : (IS_CSID_690(csid) ?\
> diff --git a/drivers/media/platform/qcom/camss/camss.c b/drivers/media/platform/qcom/camss/camss.c
> index 5211367b535d..b0fd5fd307a1 100644
> --- a/drivers/media/platform/qcom/camss/camss.c
> +++ b/drivers/media/platform/qcom/camss/camss.c
> @@ -2269,6 +2269,10 @@ static const struct camss_subdev_resources csiphy_res_8550[] = {
>  	}
>  };
>  
> +static const struct resources_wrapper csid_wrapper_res_qcs8300 = {
> +	.reg = "csid_wrapper",
> +};
> +
>  static const struct resources_wrapper csid_wrapper_res_sa8775p = {
>  	.reg = "csid_wrapper",
>  };

There is no reason to duplicate this, simply point to the existing
variable

> @@ -2487,6 +2491,138 @@ static const struct resources_icc icc_res_sm8550[] = {
>  	},
>  };
>  
> +static const struct camss_subdev_resources csid_res_8300[] = {
> +	/* CSID0 */
> +	{
> +		.regulators = {},
> +		.clock = { "csid", "csiphy_rx"},
> +		.clock_rate = {
> +			{ 400000000, 400000000},
> +			{ 400000000, 400000000}

Please add a space before } across the board

Konrad

