Return-Path: <linux-kernel+bounces-830350-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D0CDB99733
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 12:38:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A02C81B21DA7
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 10:38:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D13A2DFF18;
	Wed, 24 Sep 2025 10:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="KCpFnMCC"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A8362DFA46
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 10:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758710283; cv=none; b=RPjDR2pKMYUOsAAFEwpxG9p9n/oSkElj8YaG2k4iqzVgg2gg1LaI5Xd1sOCTkKXahTc/4ifL4vggDoi8YFTTLPy5NZ6rrY92k+X4LcOqBLQsC+eBqS4Sm8R3VodDF8ep5svn/Jv+iCzS3QbRS1/dcMSJvr+k6Etq9kkEIKdM5bg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758710283; c=relaxed/simple;
	bh=Toar0gvp2qJ43aKc+/cW7q0AzANqcXizpPzrPHWXH30=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iZ8H7zSBxnRBqzvNUafY9MZ1Ia4yjalqM9/ZBI5/59xf+l/HGQgLFBmkLCQy8Ge0bLPyrr2J/PX5LXHVjptdzX7ON4s48nDNxrFFCTQJfTTvPZgpW627uV/WR51E3rN7C999KQs2CkNUkBqUeOCG1L/yuMoAFrBDWvB12z6DZt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=KCpFnMCC; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58O4iFIq002776
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 10:38:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	I9MQAHNRQTDWklM4yOpEwiFV6eCi+r3BJBm1CRNI/Qk=; b=KCpFnMCChEFc3DP8
	vbHTSH3gLdgpSwVZ5pTgOA7OY9nU10qZuuJJIn8InaFyesIL5rerjjLWWsQAspum
	ddlvTldnB+CCiUgVcjG2qkF+K0LOgN9qD+ujEhzzB1bdtnH09dAuqXk1gDto/mKV
	XkHYSf3w2WMM224E2gxYiwGLDFLroUoG97Q9K4GgWoQr2TnEIpko25mS8L8KrwBf
	0PHd81Rog3BavLMiplfQQqXBI0i32JwA9eAYzPm9ntIg2BJHfT1pcNCSvVwDR3JN
	7C+zO0sxiqGr/hxNIUHM79q8LUIZQ8nf17eRdiK5f5I1roMM4QzuIJWqpGfdkyCe
	R8qVTg==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49bajexhp0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 10:38:01 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4bf1e8c996eso105938141cf.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 03:38:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758710280; x=1759315080;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=I9MQAHNRQTDWklM4yOpEwiFV6eCi+r3BJBm1CRNI/Qk=;
        b=QbIBVp8/Fthu0J1J91WSlLM6jmW9mapXjRxNQyGVf7X+FgGuNeDvM6ReoX/uaIuWa3
         9I+bpxUxgue2KHdMVVo4IjycvLJPiDXZ5i9WnuLGkfhzWkJ42eug8TVxBfFZMjFyFa8l
         p8cIYVFMZ8hUtJ7WfUTWj7oo7+ldoQDXABEWmzZaCIqXPqU47zOuQtjpwrSUfoFQVDJB
         XI+5cVoEu4Jv47lsqbL93FFZ46V2qyCqDQRVd57WJyTSoQ+P2WNeURaSRlVBP4PUb8cz
         Eka5OiqWKH1J+T2jJUErRCGWu3CooxF5K8NpBw8o299tRh9+8dhpeDS2NKPKkO2ZjbiS
         GJug==
X-Forwarded-Encrypted: i=1; AJvYcCX/xAHHTpfSPxZyNBUCD1qo6nfvXufXkKoVwMP/aZRPiotoT40l1Rot87MKjO5PEfdaiQ3I+2+nuSRl9Jw=@vger.kernel.org
X-Gm-Message-State: AOJu0YylqunIY6EMCuKCdAHGKH4r6y+i73tRIUqgzrs2y5hpk00SdBOP
	mYzYDFzLLVandgcl60NU5ITt2+9kVh0X/84m16dsjiH8/vAb4+bMylGjgzNln6Bw15A7hz7d5Gp
	d5AcdpjPdgGT3dkwQkYwDWLSnzvJeOeP4MoeCWKo6KoMStPaHvfs5hrfc5EvUfP7/y6M=
X-Gm-Gg: ASbGncvgHFxT7JaOsaoVQwitwwnNeaB2o/+owNJrQb2lbIX4BkMLVx/rXB1m/uCmvFn
	qxRdZLAkUAUyccUMyz04l1B3pq+hkqFPYmmqLvMN0A/zGb5XJ0iNdwe0GiOzUY+PPWZXyEIYJki
	+qzyFfTITeRmFtz/0AAWksjvolz4kxWCnnq7eJZL9JdU0yOqOW455uu+f+8lF0yfqIXcA8+zf9H
	70kTkSp2PbsNjTmnFt/hZ/f3vhnyxE7p7wgO/ZaBOjrLtmoSY7B8+XclqVxKcucyT0yrO4+S50k
	XZdq1ug0CGdW0Mxu4Smqb+ek4hiNMEP2Q72xYt1EfmSqL3itLtiofnXSlLSW8B7hQE8=
X-Received: by 2002:ac8:5815:0:b0:4cf:fc38:7ff5 with SMTP id d75a77b69052e-4d370d5e68fmr55024851cf.68.1758710279899;
        Wed, 24 Sep 2025 03:37:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGDRyLWKTabJ5qvoph/CIwo2q5r7HvHCVkrkTq6bzN60xam0HeMzsPtDkfzIFyr4t9WVi8Jkw==
X-Received: by 2002:ac8:5815:0:b0:4cf:fc38:7ff5 with SMTP id d75a77b69052e-4d370d5e68fmr55024641cf.68.1758710279425;
        Wed, 24 Sep 2025 03:37:59 -0700 (PDT)
Received: from [192.168.68.121] ([5.133.47.210])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-3ee0fbf1d35sm29649231f8f.55.2025.09.24.03.37.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Sep 2025 03:37:59 -0700 (PDT)
Message-ID: <4ec6bf87-f6c8-4080-98c2-e81425c44e4a@oss.qualcomm.com>
Date: Wed, 24 Sep 2025 11:37:58 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH][next] ASoC: codecs: wcd: Fix a less than zero check on an
 u32 array element
To: Colin Ian King <colin.i.king@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        linux-sound@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250924103334.9832-1-colin.i.king@gmail.com>
Content-Language: en-US
From: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
In-Reply-To: <20250924103334.9832-1-colin.i.king@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: WAdzXWzOmpbWrc6Ekcxf1Gnrvn3_jZVv
X-Authority-Analysis: v=2.4 cv=fY2ty1QF c=1 sm=1 tr=0 ts=68d3ca09 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=ZsC4DHZuhs/kKio7QBcDoQ==:17
 a=gChy-ArH425jUgxL:21 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=OLL_FvSJAAAA:8
 a=pGLkceISAAAA:8 a=bwnp8BXZDZf2W2z4idsA:9 a=QEXdDO2ut3YA:10 a=j9o5Av5NI7AA:10
 a=M_KkFZv0jYEA:10 a=a_PwQJl-kcHnX1M80qC6:22 a=oIrB72frpwYPwTMnlWqB:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIyMDE2OCBTYWx0ZWRfX1bFBLDnudut2
 VHYTtTzCcq8j1SmGqe1vuN1V5ZsDQtaah/F0RKo+PidgqpW/lgYRywxTm+RNX5IynrzM1N3C12r
 TIX4jtB5GYlkiygPD64shpycOUXNZUndfR8TovfmTzR84fhidiJxjGpR6uOZ8b5U+O7z8GaTZZ2
 5InRKFmT1X2AiiNfBM/0AetEbc28vrc1tz87YQGIK06xCfunoM1AF3Rr6j1ihSS+cOysmZ7q2bv
 ZZOPq+OGF1NRvpEbsoEYWjOXf6se9wYvpMmP/P0AGAyZi6MV6p5zHoEQ7Fa/TAobeoyDbTwrj7p
 xXNN/Hj0SD68dxOyPz80LCtq7FjlP/iCNXyNvl8IYt2wO4m8qL3Xe2eBSOYbUwwMnRCdIi69psh
 Tb/GvZ6i
X-Proofpoint-ORIG-GUID: WAdzXWzOmpbWrc6Ekcxf1Gnrvn3_jZVv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-24_03,2025-09-22_05,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 spamscore=0 adultscore=0 impostorscore=0
 phishscore=0 bulkscore=0 priorityscore=1501 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509220168

On 9/24/25 11:33 AM, Colin Ian King wrote:
> Currently the error check from the call to wcd_get_micbias_val is always
> false because an u32 unsigned int in common->micb_vout[i] is being used to
> to perform the less than zero error check. Fix this by using the int
> variable ret to perform the check.
> 
> Fixes: 4f16b6351bbf ("ASoC: codecs: wcd: add common helper for wcd codecs")
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> ---

Dan Carpenter sent exactly same fix yesterday:

https://www.spinics.net/lists/kernel/msg5855359.html

--srini
>  sound/soc/codecs/wcd-common.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/sound/soc/codecs/wcd-common.c b/sound/soc/codecs/wcd-common.c
> index 9bbfda828377..9fd3965ed540 100644
> --- a/sound/soc/codecs/wcd-common.c
> +++ b/sound/soc/codecs/wcd-common.c
> @@ -65,9 +65,12 @@ int wcd_dt_parse_micbias_info(struct wcd_common *common)
>  	int i;
>  
>  	for (i = 0; i < common->max_bias; i++) {
> -		common->micb_vout[i] = wcd_get_micbias_val(common->dev, i + 1, &common->micb_mv[i]);
> -		if (common->micb_vout[i] < 0)
> +		int ret;
> +
> +		ret = wcd_get_micbias_val(common->dev, i + 1, &common->micb_mv[i]);
> +		if (ret < 0)
>  			return -EINVAL;
> +		common->micb_vout[i] = ret;
>  	}
>  
>  	return 0;


