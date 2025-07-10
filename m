Return-Path: <linux-kernel+bounces-725623-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 53BFBB0019F
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 14:25:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 20FDD3AB17A
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 12:24:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 917A825229C;
	Thu, 10 Jul 2025 12:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="BCBl8BQn"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8589B2505BA
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 12:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752150320; cv=none; b=KOK3p2OXYDviAH2Z/PK0EoikLDihVL7DXYFGhkVX5lEMx3XlLg+WIKwUNTzeQMWiVWS2ZjTe5Ic5I44zZ/FVvcCaIDiYC+svV+HiQLQejm9sOXJ5HbW4K6izQh861UWWdfC4mlia8/OqoQqg8/fTvd7axYQfhZdHQFNH8kz9+Oc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752150320; c=relaxed/simple;
	bh=FgzRt8ZR7RE+rp15IyUmQeD1Nnm06vrWcpPbcGFEZc8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Qt/p6hdX6p5TopzfS/5FQvwvzT9lvAKu9RJQLpYftaThxIGYxG/BKkwKv1DmgGtiXTjPVmX+gS45oiQAAtjvP+qYPBvZRxY4oqLjgkMT6f1FVtKAOr2S9iYSq16dgr5I0NZpHYoxCkQE81P4OmXaA+twspw8OJ7qsvY1rVAMZ34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=BCBl8BQn; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56A96Ps0014493
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 12:25:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ytbTCzKHlppw2SwuVFycJKbJ22dHTAoFO6LLPths6vk=; b=BCBl8BQnoib8Svq+
	gfbo5fvs1mFg9wD06+fQV4mO1Yujoh6bcMlpk5i47P8zlnXcU5yE4ZPwbEecRf7z
	HReJSijPmv9Gp6e0mRCjmIfajjbIqmhe3BWdIlgQb6g38Hx/ZsuGU9wx4aia/xCq
	t65mAn4ocuHMxGM3JMLfvliRQ5mq3GSqvx+vUYklz9zLmSMOwausfZgxwXWK+7pV
	ascfe6QsPtHKFrGuwBjcVjOkEd5w391snbN4+StyJ49NENL9SDRm9P/7M6Jw740Y
	ZM2RR9kJr6fV2QFImPUZcizk7Q6lu8vj3hI3OZxb1BKUqfpC/fc5ge10boKpxYZ6
	dv6zdA==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47r9b15tw6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 12:25:18 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4a804126ed6so3940511cf.1
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 05:25:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752150317; x=1752755117;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ytbTCzKHlppw2SwuVFycJKbJ22dHTAoFO6LLPths6vk=;
        b=HxYzH4Mzf1gFNozH+/o66WR+TRjQvlYaqP3xcnnP7JOamI70HUqYjorNqx+Bvk2JBZ
         KU7tSs3ch0MeZkCw13vODjZk5dViNxwBNZ+z33pjoqg4e59bogm4v8EinFLIDYuERY+N
         XQWnu9SXR0S4FAMOrW0DfHWGpeanj/JdHQ7Sq2/oj8DFTIDy4ftAIy2csIZbSKQvykkP
         NCbCzlk92hn1dqlm3BKj8rnzJHM3CDQOGW0FBhDwz7MWQgpK7adlKyTPHOhf0nQGLoSt
         ITWKLcrlyjOxaJAAbD27uGe9Q2wrHJ5WlNl7EtYXgiiPvr/jd1w09jpJPsEc23Fmna5e
         t3aQ==
X-Forwarded-Encrypted: i=1; AJvYcCXHM1RUa9zu0nh+J2g4m/+P5/6F/DtDDyk1J1YaqM845yc2UK8tMw2ITbnNi5JFe+FmOT5t/EXZJ4WIFGU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3zX+HZZFdRvO7UrVNa6zJrUUq/gBmUU5BIyRk0rQ6dQJob/Po
	GkhpbmBpiqn3qJDiJ+Xf+bWsssJRELZmQLJseCiCCc2HQ8zFv0QOCc68qC5FP81hkOan5J4vbDv
	JOfb2EQvklplzbnncsFyVXIlMzvyd57dd5Na+z4+zGQXEhAQBgb36cQ5W+6+1cPdM6F4=
X-Gm-Gg: ASbGncvtOLjdQUgUOkuPFmqSCt6Oe9iUrYovAhwwWMhhRddmzBjzX3+QxZlVVNqRAk7
	E84tzsOtZ3ScgbdhdyzDcEslUZvMhYmakn2fUcsTgas7+g2hhgMa2jNGFGQmS6rA5oYq1fcIy22
	LinubNl2YAmpUMRzllI7e6GDU+SqJz/NFqEtodjOAoJZHN1MRiamTNOXaRFqBwAwmamqE7M3Gtn
	Y1/AoboSlQm3zBy7KYp77f4J0WlOXPkzkPsCFFp4xX+nnR2OJ5R3CJDP64eOXEp+dgGiSGF9Het
	1lNu8/iUskTezrcQYvVlzv5BYevHWv7VfJfAviDJ4Dksn475EjvPtQG6fDXWqnUhnnVLLUt0or0
	vDWI=
X-Received: by 2002:a05:622a:18a9:b0:474:faeb:50aa with SMTP id d75a77b69052e-4a9e72c759dmr23061971cf.5.1752150317065;
        Thu, 10 Jul 2025 05:25:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHL2upV2JP4A2q8XY4xH5jOb8YXZErvSG6S/PQkLmFjLIJfoL6nTfAPNahLLoITNqEwR13IJQ==
X-Received: by 2002:a05:622a:18a9:b0:474:faeb:50aa with SMTP id d75a77b69052e-4a9e72c759dmr23061571cf.5.1752150316273;
        Thu, 10 Jul 2025 05:25:16 -0700 (PDT)
Received: from [192.168.143.225] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-611d1062950sm455639a12.65.2025.07.10.05.25.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Jul 2025 05:25:15 -0700 (PDT)
Message-ID: <46a506ee-0472-4c7a-8fd8-b3a1f39105b5@oss.qualcomm.com>
Date: Thu, 10 Jul 2025 14:25:12 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 08/12] pinctrl: qcom: use generic pin function helpers
To: Bartosz Golaszewski <brgl@bgdev.pl>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Alexey Klimov <alexey.klimov@linaro.org>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Sean Wang <sean.wang@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
        Paul Cercueil <paul@crapouillou.net>
Cc: linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
References: <20250709-pinctrl-gpio-pinfuncs-v2-0-b6135149c0d9@linaro.org>
 <20250709-pinctrl-gpio-pinfuncs-v2-8-b6135149c0d9@linaro.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250709-pinctrl-gpio-pinfuncs-v2-8-b6135149c0d9@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=dYuA3WXe c=1 sm=1 tr=0 ts=686fb12e cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=KKAkSRfTAAAA:8 a=SCCoO-_AHFKZ3jW1OIgA:9
 a=QEXdDO2ut3YA:10 a=kacYvNCVWA4VmyqE58fU:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzEwMDEwNiBTYWx0ZWRfX568pmitGpVtY
 BYWQRytbiLL/dNnYbypjATgc3k11kwLvvYStZ7DAmB2uRTAhV1Er2Nl7tRI3sT2BbEN1Xl8YU+C
 8XkqJu13dnVtNNVVruSBhIWzXtq+fhcWGG5xEwkFs55SR5IhW+v17BQ4CTFmyWCS6UpTprw9R77
 ITqLcnN5VOXMHVExnjHuNpnIKDBRu5RLcZhkpTHgnAKzmfoCMcKPByOn7EENd+j/M5fARK+5iKA
 JzTmpX61S+SBFhrqm1OGRxYs3LNnPPgpNu4FmuWk3zel+WQF5olpgG0x6Zna3eJaA10KknK1wgX
 HWA8DDu9x2hYQUnxVTim3L7SwPiKNlg9XEAOk+rYGqKPwrXgO9Es3QyAP0Y4rjzL0h70Wu3BMcS
 PGWXaZZuL3td7W2RaHJ11rdMAh52lHSoAhRs+sWFAiHePDIWk4px/eE80zfoKxuFz8n4jeXx
X-Proofpoint-GUID: dOoOmETz2paqcrWOaFcg-zsL4bHiLfTf
X-Proofpoint-ORIG-GUID: dOoOmETz2paqcrWOaFcg-zsL4bHiLfTf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-10_02,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 suspectscore=0 clxscore=1015 impostorscore=0 lowpriorityscore=0
 priorityscore=1501 spamscore=0 adultscore=0 mlxlogscore=764 malwarescore=0
 mlxscore=0 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507100106

On 7/9/25 4:39 PM, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> Use the existing infrastructure for storing and looking up pin functions
> in pinctrl core. Remove hand-crafted callbacks.
> 
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> ---

[...]

>  int msm_pinctrl_probe(struct platform_device *pdev,
>  		      const struct msm_pinctrl_soc_data *soc_data)
>  {
> +	const struct pinfunction *func;
>  	struct msm_pinctrl *pctrl;
>  	struct resource *res;
>  	int ret;
> @@ -1606,6 +1581,14 @@ int msm_pinctrl_probe(struct platform_device *pdev,
>  		return PTR_ERR(pctrl->pctrl);
>  	}
>  
> +	for (i = 0; i < soc_data->nfunctions; i++) {
> +		func = &soc_data->functions[i];
> +
> +		ret = pinmux_generic_add_pinfunction(pctrl->pctrl, func, NULL);
> +		if (ret < 0)
> +			return ret;
> +	}

It's good in principle, but we're now going to house two copies of
the function data in memory... Can we trust __initconst nowadays?

Konrad

