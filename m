Return-Path: <linux-kernel+bounces-733875-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C8E6DB07A12
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 17:39:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B7954A5BA8
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 15:38:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 091DA279798;
	Wed, 16 Jul 2025 15:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="JYEObN5A"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01D2F23496F
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 15:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752680294; cv=none; b=Nle9caEM1+/Z8nMADMFhGLNUPsgDHIEVwuD2+qeOQJ9gmGLOYDuLa5eS48QPkY2beyhjWE/tbVu9LUPoLsuTcY944dS1vKjOqWA0kpCx1+o7EzWFYKdFmOmwlwL7doXoYa3J0iPnXh4js9MmSbZZNktZss83oCRCR7UBDhvpHXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752680294; c=relaxed/simple;
	bh=l5P1z4ovdvHY0CSXjSyliAiwgCOTQV3QfxvxZAlEmC4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bUvfaqb4+mxhkfdqBan4fy2hFlTcwz8u8J5k/amZ75jp3ffQ9Ay16vdkTKMI2fjT04GV/CKmDzjecPTnb9BS6isuaKtU82vp8MI6qFGIYXrv3lK9L95tKOcNx6BtxOBzmVCdOJsUt0FOPxRXJsBwX9nTR4sz3LIWrrlcT9NHs1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=JYEObN5A; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56GD7GhW024588
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 15:38:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	UkYAxaVWsTIpveHNj6bY5KPJ5ksQrOMHQ1BxM11VR2k=; b=JYEObN5AbIOLZ1g6
	BdmXvAIsMiPZR6Nxjin0dy8wyZcmVK3SJ7cBJsiw1cd/auknAA22hSrVSfVSKLIn
	xnoscOSbwdjmC2/+I4ZsFiSwEaALpobnv6DS67WXt0ab2RNv+4zuhKTohohv1UYC
	PoXA6tlCfiY1q12wo2JMh3yuwBtbaqsqOE21l67fh5fTJ36He/kSN0Q6siV5VkcX
	tNcBfzNSe+uQIWnt2n025vgsfmAKVVeLhmasVBF6UTwfetgCb0IaEd48/4POYKXB
	FRD4t0YCRJ/iFFCJXNigsp1uSEQzY7DaS1kmQE1PH0HsJn5i+v8FQt6MdScwS8aw
	vTbCAg==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47w5dpfg7k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 15:38:12 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-7e348600cadso70484185a.3
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 08:38:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752680291; x=1753285091;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UkYAxaVWsTIpveHNj6bY5KPJ5ksQrOMHQ1BxM11VR2k=;
        b=nOQb/pxFiPGX+Rrr6qJFFtUp44toK/ywBtEoqumsq3lALLhxX+y6qvHgLJu8zjnU2r
         XK2AveVQL58ZL2YkG7aYeT40sOiUuu9C1AeapZFm9rSfzazNOt0D98sHs1IuWQ2gk3r7
         /3Jn8hVfw1LiSRZbbIpjWzYdnrhbkJprBlprYd4HFoTurTvJeq+6Q5ctgZXuq9VKP4el
         VM86e0xLhMejXLGNNps3ZtgYz+fuKfnDpo17k4XcHOKWwDFP6M1zxQRD94f0wREGgz/+
         5lOC/noSsifbi4F+qNGToeDqO888h2eI8f1VNiMXOf9obF5Hr33Ou43CaO83hNOU8duw
         y2MA==
X-Forwarded-Encrypted: i=1; AJvYcCXz7MTdytcYpj0rkiDAV5+7n0pC1lFAeY1i1mNLI6SaLXP5Fvhg/RwSymmtscGdgsorGhr74zJsy6TMKKQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCW2L8n369QpujBcoNmNCrtAZ/Qh9mh//dPL9t9HCuagDt7rAu
	uRkKuEoFqs2/4xm/yLo5WciIFXoMT1uOOvyiBYq6erobAS68hLccMEkv2SwdQv9KxR7LeTFhsrQ
	f42Xlfko+Pj8gKBugHrr0yMmiZTfZltbMxWF+BaSZF9/zlADrbCBy0NCHUxqcb0l6QNA=
X-Gm-Gg: ASbGnctHT0Qo5BuIyz1M+KlfEaXgtDUs3AeH39+uakIN+pc1G+8zEJCFSS+CVu1Zsb9
	puSz27D4TRdNJmAWf8rCbTnAZanL8s1UW8ic9G8Lj3O+DvUgnNosdqcQGbR9V8TfjbrxqmtA4vN
	PL/oSiXTOxVYChej5xf3TfnnK4T1mX6jOc8DT7zOF3iB4qcw9mo3USnI89uzxcHljrjIecWJ5EL
	rXvbZAh2iGQT6hlX473pBeO0ziC4Rs4QdjOlRhIOMTLkkSZ58jGcisuvxA6UMUnXYHTinzjWR8W
	u/JMfRaG9Jg9WM5i7AMOkKpnpZ+B0goh0ZTFBnqLSrUL6Rxj8GgyYlzf2g2kTA7e5dw=
X-Received: by 2002:a05:620a:2845:b0:7e0:bd35:fd21 with SMTP id af79cd13be357-7e342ab1fbbmr515910785a.19.1752680290583;
        Wed, 16 Jul 2025 08:38:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGOu3vav4ASfeHUT5qSQ3WEE71kptmN+XUWMWPqA/D78xEVSW3WpYohE6TsP7cV4WPYeMEFrw==
X-Received: by 2002:a05:620a:2845:b0:7e0:bd35:fd21 with SMTP id af79cd13be357-7e342ab1fbbmr515905185a.19.1752680290024;
        Wed, 16 Jul 2025 08:38:10 -0700 (PDT)
Received: from [192.168.68.118] ([5.133.47.210])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-3b5e8e0d867sm18422684f8f.61.2025.07.16.08.38.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Jul 2025 08:38:09 -0700 (PDT)
Message-ID: <d25ace2a-4744-4c92-9c56-e630bab306d8@oss.qualcomm.com>
Date: Wed, 16 Jul 2025 16:38:08 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] ASoC: codecs: wcd939x: move to using dev_get_regmap
To: Mark Brown <broonie@kernel.org>
Cc: lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com, srini@kernel.org,
        linux-kernel@vger.kernel.org, linux-sound@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, neil.armstrong@linaro.org,
        krzysztof.kozlowski@linaro.org
References: <20250716123323.5831-1-srinivas.kandagatla@oss.qualcomm.com>
 <20250716123323.5831-5-srinivas.kandagatla@oss.qualcomm.com>
 <9f4c750a-9e23-45a0-a761-4c3fc2c7d8c9@sirena.org.uk>
 <6de11c01-5b59-4222-9f4a-c951c74f0128@oss.qualcomm.com>
Content-Language: en-US
From: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
In-Reply-To: <6de11c01-5b59-4222-9f4a-c951c74f0128@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE2MDE0MCBTYWx0ZWRfX7U0mubfX1rcI
 20tqZ8t+OUITjvrU+suQZv/Qz933K2E2B98fMtdCfU35omhGumueM5fpiltypB+CSY2PAVhHwXA
 vCrYr09NMK5UYjMJtKkTVrmIBvoUCZ7T1rKKp0afIyGWzRrkRSvj6JVDfN5Uu5Q8NlVz1GhVPdW
 //eeEX5SKQ1zlaeedAoLC3p4ekd8+KPBnQ+OCb8skrDMoM7InisoKj3yGyi3zo6qs8DaZuWUiSM
 1dT3uL6esvxdlBOaOmPRum3LV/PQOiwFVIpkHBQ5RO8ea1yGAbrqrkdK4bbnpNeWPVvQBLbD2m/
 89D/ROlk7Wb6e64Nv04s833nYHsASUqyH2KVNLshOkG74QHst1vBUdeNXbTt4CfXPCn+lT1JjWJ
 23Z0MmwrFLxwHrngVozX2e7br9Yy30aVz5s1tFB7JqptfIdNMxamD32dqrYkLPvn/fr0abpY
X-Proofpoint-GUID: gNyMBNw8S_XjU6HszNhjJoNbNP2bBH8c
X-Proofpoint-ORIG-GUID: gNyMBNw8S_XjU6HszNhjJoNbNP2bBH8c
X-Authority-Analysis: v=2.4 cv=Y+r4sgeN c=1 sm=1 tr=0 ts=6877c764 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=ZsC4DHZuhs/kKio7QBcDoQ==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=_B8sJ2igTC3d7dtnB-UA:9
 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-16_02,2025-07-16_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 mlxlogscore=736 phishscore=0 malwarescore=0 priorityscore=1501
 adultscore=0 impostorscore=0 mlxscore=0 suspectscore=0 lowpriorityscore=0
 bulkscore=0 spamscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507160140

On 7/16/25 3:36 PM, Srinivas Kandagatla wrote:
> On 7/16/25 3:31 PM, Mark Brown wrote:
>> On Wed, Jul 16, 2025 at 01:33:22PM +0100, srinivas.kandagatla@oss.qualcomm.com wrote:
>>
>>> Ffor some reason we ended up with a boiler plate for dev_get_regmap in
>>> wcd939x codec and started exporting a symbol for this. Remove this
>>> redundant wrapper and direclty use dev_get_regmap from device pointer..
>>
>>> -struct regmap *wcd939x_swr_get_regmap(struct wcd939x_sdw_priv *wcd)
>>> -{
>>> -	if (wcd->regmap)
>>> -		return wcd->regmap;
>>> -
>>> -	return ERR_PTR(-EINVAL);
>>> -}
>>> -EXPORT_SYMBOL_GPL(wcd939x_swr_get_regmap);
>>
>>
>>>  	/* Get regmap from TX SoundWire device */
>>> -	wcd939x->regmap = wcd939x_swr_get_regmap(wcd939x->sdw_priv[AIF1_CAP]);
>>> -	if (IS_ERR(wcd939x->regmap)) {
>>> +	wcd939x->regmap = dev_get_regmap(wcd939x->txdev, NULL);
>>> +	if (!wcd939x->regmap) {
Infact this turned out to me much simpler and not even use
dev_get_regmap() by just doing a deref of sdw_priv

wcd939x->regmap = wcd939x->sdw_priv[AIF1_CAP]->regmap;

Will fix such instances in next spin.

--srini
>>
>> The existing code should be more efficient than dev_get_regmap(), the
>> latter does a devres_find() to look up the regmap while the above is
>> just a pointer dereference.  It's probably a marginal difference in the
>> context of probe() but there is a reason to do something more direct if
>> you can, dev_get_regmap() is mainly intended for generic APIs that get
> Thanks Mark, I did not realize that dev_get_regmap was devres search at
> the end, Will drop this patch and make something similar changes to
> other codecs too.
> 
> --srini
>> passed a struct device.
> 


