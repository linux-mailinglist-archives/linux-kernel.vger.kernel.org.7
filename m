Return-Path: <linux-kernel+bounces-865520-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 35548BFD5E7
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 18:51:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C4A0E5840DC
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 16:42:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E2D23563EA;
	Wed, 22 Oct 2025 16:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ExFBEa56"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DABF32B9A2
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 16:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761150537; cv=none; b=RG2DxG0WLY8d2kbZxo3Ln8B6g+kuAUDc+ovfYNUqVjFfHju6CuAHa3YLNsf3S79GThmpdTk8WQ9kgwyCXGOioVoOo7CXO+dgQOcr8DtZ0Sg/czFlDtZftglp0b8RX6Z6qDzHbdICybbLXB8czw3rbrURzBzEFNqGfZhxaaFacgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761150537; c=relaxed/simple;
	bh=gnYSeDQF9A0l9V1yfEhZWeQeVljEZJwDS8hyZnA8a8c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XkAkL/Dkps9gKlLoXeLG2hNndsWQvBnJZDx8LUGh75/1tyv/515m14wcs0rsFTSy0wx6A0NSdjJZOprtqL6sE8iXlqTfYWVgmc1TW8kW7IDElfawU0Zkq1KfZFnK3YmZ9nXRQwRiDhf3x23N4FFs2rXFOk/GOS0xbkQbOkFO2TA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ExFBEa56; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59MA9N2d002534
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 16:28:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Q1jLNGTOlSGGQO46A4daF1PWlbiRuH+dyUe66KEnmxI=; b=ExFBEa56mge8uk+V
	+CJLI+jZIHwDXJrL+phLYqFdD79kE0LukmSVvDbNE4Di0BuB2LLTfoyheCDkEbNp
	7QqkPThxhvxm3HVc5hP6FG5w7CZWjj8r4muWYgoXLJS1o9cVVctogpmDqf5Vr5I3
	zsMzmG3MZGUmOflouet+PO5yAmtdLw+adUF11CeLOKEVocMD2X5SazR3NIlR+lBn
	9k4vnpFEfqmAVpVCFNezpHvzmMYNiNgjDRhFivu+dRBVIeVDrCi9Nki7R/I/68C+
	p2w8QyYeoRfGtYh52NRFzHtr6LSYsIXFo0GLa+Jvr58ctAGhnMnozDc4ZWHbuUg9
	GdvNgQ==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49w08wayrh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 16:28:55 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-87c19c8393dso23888516d6.0
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 09:28:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761150534; x=1761755334;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Q1jLNGTOlSGGQO46A4daF1PWlbiRuH+dyUe66KEnmxI=;
        b=I9/ai5Q7aQ8nCMbUNnIjhlSUILH6Kwpwd+QG4SRPUsGph5F4Q199wL6/5MGK7RccvH
         mpnI0ayqkvOJvR9Mobu1KqmBiQuqAYEFSmA60Ap0XPjszftE9VjK+JoHK0Gu/EGvuqAP
         DD7XRJ784Jqjur33lX1OxxSWfJdcdDPHGncU6l97ewxpGMF5yFNOOs3Ej2Al/Gxdvr+n
         WH5dxzuFW6FdIcGgOW1N561LV9ecnhlp8OgY/Mg2aUtpHo+QphKe71ueg0cXv9qPHUlY
         uE4jYhwya9Yg/BeCKDNqXcV9fO8zubeO+jL9F0NX2ZvbDwx4NowaLbJo7l4/U3kLSjve
         622A==
X-Forwarded-Encrypted: i=1; AJvYcCVFyxGUfoiEG0MsJ0OdUHJ3n1/Fgy9ZbnN4u3KWE2YNWuyqnrZQZTvmnnKfBXJg0Z1GMmXTIER+5FJi434=@vger.kernel.org
X-Gm-Message-State: AOJu0YwggOgsgycP0WpAD5drS5KFuDUa/znCttv4XjJovizKA1CgigVo
	rUvPZ29EcopHsG6PlPRkoXwOfoNpYyaVg3DnDIJHrXAtvRTXssKlw3hTyVD5LOtfhjxw8lRDS+e
	6eITcz9ieTPgc7xbhaNvG8DvPoWkpEfFPvQ+EQPhgyj3SweHxP7wi4k/AUCe+0jVw4cg=
X-Gm-Gg: ASbGncv23W7n0UAVPFgBy18VLMdK0hzhVcTha07tjHmYF/5D7AAuOfnxRcS4DsRzYeo
	tJxGk1lZQgLVwucxnEPjwRV9MlgokxNPliXeOYfxIv41CfBROD4ryejbBmn3X6aZ0O//390Cant
	b+4f4nkBd/K40bqCL5g9C/3bgfHM1JZzt+pOpGvYRDQfs4S2GtLkcnStMQjcZSdkQV9EaSe2QFi
	2wL4wbqTSMsO4hJnOPJV2K/yWOieYfRf2bocyTROoUL/0WD8MvADVbVwD1pyAzoX82zYY7qfa5l
	Qc9l4jTk78IBtVdRX6zR1NP6fFQa7vr+hqlgLwLiiCrWkWYypb4+tu2lpAMemy9Pvt6Wc7ir2GY
	s7RTmFwSF2TvP8Ry5yI72G1jZk5TnWUwgU/neN1SlGgNSFAM2FdUXEqqF
X-Received: by 2002:ac8:5f92:0:b0:4e0:b24a:6577 with SMTP id d75a77b69052e-4ea116854c9mr63132161cf.2.1761150534439;
        Wed, 22 Oct 2025 09:28:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH4oJ9oXYk26oTyLnsc4HCl+yoXOudlAJ18eVcGWTDYAU+63VcV76YKqc3oyp7E8vwvDJPtcQ==
X-Received: by 2002:ac8:5f92:0:b0:4e0:b24a:6577 with SMTP id d75a77b69052e-4ea116854c9mr63131831cf.2.1761150533950;
        Wed, 22 Oct 2025 09:28:53 -0700 (PDT)
Received: from [192.168.119.202] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-63c4945f1ffsm12526984a12.31.2025.10.22.09.28.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Oct 2025 09:28:53 -0700 (PDT)
Message-ID: <4d69e9ba-caa4-49bc-a66a-d085edfead4a@oss.qualcomm.com>
Date: Wed, 22 Oct 2025 18:28:49 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 3/3] arm64: dts: qcom: x1e80100-dell-xps13-9345: Add
 Left/Right Speakers and Tweeter
To: Abel Vesa <abel.vesa@linaro.org>, Srinivas Kandagatla <srini@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-sound@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sibi Sankar <sibi.sankar@oss.qualcomm.com>
References: <20251021-dell-xps13-9345-enable-audio-v1-0-6f3f6bbd977b@linaro.org>
 <20251021-dell-xps13-9345-enable-audio-v1-3-6f3f6bbd977b@linaro.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20251021-dell-xps13-9345-enable-audio-v1-3-6f3f6bbd977b@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: ISowBcuFLm_MaHpd_vaJBryAntfPQBuW
X-Proofpoint-GUID: ISowBcuFLm_MaHpd_vaJBryAntfPQBuW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE5MDA5MCBTYWx0ZWRfX6eDPR4lOOxP4
 co17PbItFcpBNjA8jg+nF/84Hc9b7xoSIHwwEgACNn5+QwMCbC2n7dG2pk/ZoTKk4kdUFpV8N4m
 j3UULuW3LLzwcJ8I8MADH7PVoKQJczzH0ShJr30nkoF+tY4oiNg7TGxepfLPdBCHkxj3mr3ztYz
 RkwtmyT+ALQqfQH8U7HA8A2kNc57LSM3v1xQ/XqvYo9b5YrcySwqVDbYgjVerJXENZfOSMs7xXz
 LdTIu/uGDl7ty3jeT01hwTeHzpH6x7oQB9Ov/TBcdnacZrTcw1JwbjrW9Uly6hqMJZ80IF5U3+X
 mQx0zBQo4qFFfGhulAFxc2NGmCdjjroH3DxxXXqSlwmD+NVpQPFe9ZkbX/Y03lDriiRPd3TK6Vd
 OOzg70TZgJ8HFb7T6aJRmNTMlGjz9w==
X-Authority-Analysis: v=2.4 cv=V5NwEOni c=1 sm=1 tr=0 ts=68f90647 cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=COk6AnOGAAAA:8 a=KKAkSRfTAAAA:8 a=bOTh6ypEQCZma0slNj4A:9
 a=QEXdDO2ut3YA:10 a=iYH6xdkBrDN1Jqds4HTS:22 a=TjNXssC_j7lpFel5tvFf:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-22_07,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 adultscore=0 priorityscore=1501 lowpriorityscore=0
 spamscore=0 suspectscore=0 clxscore=1015 phishscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510190090

On 10/21/25 3:50 PM, Abel Vesa wrote:
> From: Sibi Sankar <sibi.sankar@oss.qualcomm.com>
> 
> Enable left and right speakers/tweeters on the X1E80100 Dell XPS13 9345.
> 
> Signed-off-by: Sibi Sankar <quic_sibis@quicinc.com>
> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> ---

[...]

> +&lpass_tlmm {
> +	spkr_01_sd_n_active: spkr-01-sd-n-active-state {
> +		pins = "gpio12";
> +		function = "gpio";
> +		drive-strength = <16>;
> +		bias-disable;
> +		output-low;
> +	};
> +
> +	spkr_23_sd_n_active: spkr-23-sd-n-active-state {
> +		pins = "gpio13";
> +		function = "gpio";
> +		drive-strength = <16>;
> +		bias-disable;
> +		output-low;

Drop output-low in both definitions

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

