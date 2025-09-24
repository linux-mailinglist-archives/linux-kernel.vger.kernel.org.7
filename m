Return-Path: <linux-kernel+bounces-829924-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BAFD6B983E3
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 06:53:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 70E504C2BA3
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 04:53:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04E551DE4C2;
	Wed, 24 Sep 2025 04:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Ck/DVsim"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA0A41DA23
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 04:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758689622; cv=none; b=Iy8zbZUrYCtxmFjiZJ7NKPBCnMmzc9KZeixZ/a3aktNxnnbkR17RnUCcaKHCITQtWI1FODaVvwRBzog61eXCGKuGFRoKL8wJ09mGRLxTC5PcqSUj+fwVESdY4PZsvY/dxkmexsUTaeWGGpYATDujP5FVO1l47I5dD0lJsbDQA+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758689622; c=relaxed/simple;
	bh=eUxBTMvzdb2zkKh9nJDwMMhUwPeFhTFBjEfTT9wSGbE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OYKwN2/QP+RcCgIn8s0E46ShTblcKIik56TXBhZr1xRLnFbpK1e0/WFyTIBxdzZLzeNhBDC4PyU50fhMiK6hm5IjM6Juk5OO7kgA1IVO865gsVkJWvSl1VWcJc3ji8oj5WDJ6OD63dPjt6E7bZ7cLFEho1ZYb1qgaJ3WuyIVQgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Ck/DVsim; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58O4iGQX027782
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 04:53:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Ey1FV8fGRJ5ouO4792MVn66otxtTJ2WPhmB3J6JcvYk=; b=Ck/DVsimvGywDSo2
	qOWu11zFo10W2OKu35r+sOcvJjHoacGGcbYw37L6tbSA8GKvJ5gO81EQgQc0iNOq
	y+TEZOgV1ad4shlMY40UlNoJT3htvBSnT0AQzjDjOQT+Si1fgJXpYJLJ+OEGiv7+
	Ji6lgPXEFRedqcgA0LuoYZasSo1Gx+e8a8VhSLAwWMyERru+Z5fyTySwlYOQdknf
	U+hB7TXqLR/LZEA+7DQ9F2KuvvSLHtbFr7yZRqaUe9RjrGcd8mlgKlRdQGHcvuiC
	Y6wa3Pbxm85KxualEPPMIxq1Sp376oQRM3ydVJvCkwDec7CsMy6Y3Ir7ndaPIzel
	6BLBsA==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 499hmnubp2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 04:53:39 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-332560b7171so462096a91.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 21:53:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758689618; x=1759294418;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ey1FV8fGRJ5ouO4792MVn66otxtTJ2WPhmB3J6JcvYk=;
        b=E9zZUrvA7x7Rfz3HH1Xx9y4iUigjAuUpqrUYSnT3kDNDqsD0PyLqA5BvLGiZS/Kjwc
         ht5KOGY12bGRTAviPxDXcV5t1ojbrEzAnQUplGEERnLEbykLmvZZxczrzxjza9OEut8V
         VI1RZcdP/I/kJqLYpCaF9Zf1nALUJgRsuzCVG12/b+Wli/kEicJ7tbkFFPlXMrllUeFp
         OHCX6HW9FqaQyYdoRLCIDOOyosWjNf/jatHuCU45r0wzyRL/qBVDgoIVyUXkWwLWd4sf
         a655RpKyv4zurTYYzSi3bl5EtxS9k+VRn4QYMoGyaKVw/7ei1mFFmXQQc08ROBawiEkR
         72fg==
X-Forwarded-Encrypted: i=1; AJvYcCWnBJvi/jqTtOWzztAzNw9n/3Ky6A0PFhNrQiL8zMZIjf0bc/4kovZ4olLYH3aED+kmgsXbFHrlaZrk5U4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJMyNL6cTc1I5J3helhJyjVXtripFLQNi+h+WcYoMAA0at3eGa
	6hqrLP5E5xEh8rTQ34F68al2BOwobbG4p7V42pM1hsJ58RDQ0qaO14R01Oi8vYlIgaooOG1edQ1
	w2BXXA2jxemnn1h2qpbsd50ETxPzIkdMKR8s5zRAzOVmfK1aQYlCqbxk47ocHMsBPWvQ=
X-Gm-Gg: ASbGncs2Bb2K8GtV34oB/kkUNWjNIo/N0h5qEN8G9tOiM/LJHXQkapc0JbMNv4T6lz2
	zBzjtr9i6BA2zvGek1Uqrohld+XzYxUaG0p0SAKtUbUqwCJkXm1ozNyiNis7Nbko1JPmf0C6jeT
	7XmTozjlt8sMbwbnMxL/5PlUF7lIBH7+OSsqevroSiWjuOG8M78FDP6Fxb70+iR+QdHkLVr5NwH
	VL5TU8hXq8x0DTTA+aH4+vs/+3BqQMG3nIOSziy5AYbT7v874uLY06Dwd4uhijR+lmgSD7HA6Rv
	U/WQVfkxOLOFO5jo+0c+DjOabwz1SLltHGCeL1CSsG8XTlA/11B2VqbMK+VSj40OUNzoLm1cauY
	nKSE=
X-Received: by 2002:a17:90a:ea0e:b0:31c:39c2:b027 with SMTP id 98e67ed59e1d1-3341bf8b511mr1299846a91.7.1758689618170;
        Tue, 23 Sep 2025 21:53:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHwXizxz4PvN8bqF8/MZ0uIjY2bjNGutKbI+ypFUQlXZY6lfqzhFtn3JjO2PW+Psr+gOzAsuA==
X-Received: by 2002:a17:90a:ea0e:b0:31c:39c2:b027 with SMTP id 98e67ed59e1d1-3341bf8b511mr1299825a91.7.1758689617753;
        Tue, 23 Sep 2025 21:53:37 -0700 (PDT)
Received: from [10.92.183.157] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3341be14666sm894634a91.15.2025.09.23.21.53.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Sep 2025 21:53:37 -0700 (PDT)
Message-ID: <49ee48ca-1b55-471d-a400-6054ac1fbed7@oss.qualcomm.com>
Date: Wed, 24 Sep 2025 10:23:32 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] sound: soc: qcom: use sa8775p/ subdir for QCS9100 /
 QCS9075
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Srinivas Kandagatla <srini@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>,
        linux-sound@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20250918-lemans-evk-topo-v1-1-9680600e62d4@oss.qualcomm.com>
Content-Language: en-US
From: Mohammad Rafi Shaik <mohammad.rafi.shaik@oss.qualcomm.com>
In-Reply-To: <20250918-lemans-evk-topo-v1-1-9680600e62d4@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=YPqfyQGx c=1 sm=1 tr=0 ts=68d37953 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=IA5jmXtsaGuytGhItUkA:9
 a=QEXdDO2ut3YA:10 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-ORIG-GUID: iiGE7XSUrextp6qlRXu0TBcdRbuHNIae
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIwMDAwMCBTYWx0ZWRfX8fqeLlCFmoTN
 GXyFPwBfHFl9wZkDBoO7ib/ekd7AVxwPNWSk3jULbQUWxYTkUQJ1A7+sZ88lMRGQ9yWpYc3qvTy
 Lv2wUpLOweu0+WO8KOwLs2A1OaUk7J1GvxiwOqcNGruSlJnG4wiLj2jsMxXM+PO2mHwHIXbOL0x
 ScFjyaU2zqxnpZF1eFIpT6K8My/Uv7lgo9Hu9Nj9WM8MI+Vz+tEbOCos36ERUzF+4M7UEyt995i
 LE6DbRv9sWoXY9OjMcV/REncxAWO4/4yv7umFxH5c6OHf2McV77uYLHaiidqhrUiTGldFRicSGW
 EXClfaXlRXtrCwwsXjUIStAVMKebigisMRf8KVIdtW66iDTtJevBWTGZqCYcnTsQbENT4bqNSvY
 AqQVQ9Ap
X-Proofpoint-GUID: iiGE7XSUrextp6qlRXu0TBcdRbuHNIae
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-23_08,2025-09-22_05,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 priorityscore=1501 phishscore=0 adultscore=0
 clxscore=1015 impostorscore=0 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509200000



On 9/18/2025 8:11 AM, Dmitry Baryshkov wrote:
> All firmware for the Lemans platform aka QCS9100 aka QCS9075 is for
> historical reasons located in the qcom/sa8775p/ subdir inside
> linux-firmware. The only exceptions to this rule are audio topology
> files. While it's not too late, change the subdir to point to the
> sa8775p/ subdir, so that all firmware for that platform is present at
> the same location.
> 
> Fixes: 5b5bf5922f4c ("ASoC: qcom: sc8280xp: Add sound card support for QCS9100 and QCS9075")
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> ---
>   sound/soc/qcom/sc8280xp.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 

LGTM,

Acked-by: Mohammad Rafi Shaik <mohammad.rafi.shaik@oss.qualcomm.com>

> diff --git a/sound/soc/qcom/sc8280xp.c b/sound/soc/qcom/sc8280xp.c
> index 73f9f82c4e2581c132e6f6468740a33a6f2ec0c8..0d482d8eb1dd41a3a93d8a6d5cc4b419b8c45dbd 100644
> --- a/sound/soc/qcom/sc8280xp.c
> +++ b/sound/soc/qcom/sc8280xp.c
> @@ -187,8 +187,8 @@ static const struct of_device_id snd_sc8280xp_dt_match[] = {
>   	{.compatible = "qcom,qcm6490-idp-sndcard", "qcm6490"},
>   	{.compatible = "qcom,qcs6490-rb3gen2-sndcard", "qcs6490"},
>   	{.compatible = "qcom,qcs8275-sndcard", "qcs8275"},
> -	{.compatible = "qcom,qcs9075-sndcard", "qcs9075"},
> -	{.compatible = "qcom,qcs9100-sndcard", "qcs9100"},
> +	{.compatible = "qcom,qcs9075-sndcard", "sa8775p"},
> +	{.compatible = "qcom,qcs9100-sndcard", "sa8775p"},
>   	{.compatible = "qcom,sc8280xp-sndcard", "sc8280xp"},
>   	{.compatible = "qcom,sm8450-sndcard", "sm8450"},
>   	{.compatible = "qcom,sm8550-sndcard", "sm8550"},
> 
> ---
> base-commit: 05af764719214d6568adb55c8749dec295228da8
> change-id: 20250918-lemans-evk-topo-dddd73c29024
> 
> Best regards,


