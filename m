Return-Path: <linux-kernel+bounces-733723-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D010AB0783F
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 16:36:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C17D9564C7A
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 14:36:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F86F19AD5C;
	Wed, 16 Jul 2025 14:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="H+SOQg/N"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C6E91E9B04
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 14:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752676589; cv=none; b=mNoLp8gb0E4P//MTn5wH/P5rDRewcn9xn0SSodyeIFMHn/6jiZ+5F8Ytn2nJBf8hraZuiBQVzIMVr+6jgi5IS08RCqt0jU1W07N6w3Juumk6aQhlB3FoNk+Erzk8Q++XiwcptrywDfDOJ4kVxVGqysXFlgR2+zycET2pqUtbIro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752676589; c=relaxed/simple;
	bh=kWi9q2Y7BtCTuQpXIsV0qVlJCPRpa73NHUr4PkpWIKE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cSZoGd6O8aRFzWMhejxW7haXLLrbf0jahYV5nhFra84lxI4JvKokt/dHhFT498TYdh7xcYrxHMnnMHqiEe8yunWFkMy3XpLNaGgGehampbSUq6eDKsI1K6UfPsb/S1Jmu90VlKiLSiUDZcFx2BHvMvT/xTIR85jiXJJsyErSb9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=H+SOQg/N; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56GCsMqJ007235
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 14:36:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	yA4UmYowfV6ZSvtoqDZ9mQILLwvVdlfWPK/+o9PtKoc=; b=H+SOQg/NHM9CFRFb
	Kn2gVgKcJwJLi5vLKyZZpivTylywC1NYYM0Es66fRRgrn21qPug79nha9ZwpgpiR
	dJiykYMXPG3dGzxnKuIgADcyOjVnMBOB35H7mZ9uT4Tcd5CuUVL/Oy1RyK7wRAs/
	EWDoj2iaQXjc1qNMUI4atZsQ/TeNvGb82UYD41ziAPTgkV3RLajqoxN/DGQIFc7u
	3tr7W5ki2OLIhtBehs9xkEXg9/qEUgN2zEnEpkPfOSckSlHKZcAQ4HMKkEEj8euT
	+oq5VRU/mzmz0fQOPSOYYTQ2xtYPkA95a4/jmu2uAg+J6AJB7gw3gorx8FyJXEgo
	F/zYgg==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47wnh5vfan-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 14:36:27 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4ab401e333bso18369581cf.1
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 07:36:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752676586; x=1753281386;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yA4UmYowfV6ZSvtoqDZ9mQILLwvVdlfWPK/+o9PtKoc=;
        b=mAoRJNYfFNd00+XwdFsYkyXKEG9CwIefvQYbUq66MdaIQs5bNMN72t9wF3c8kVgIPr
         l0/XypeZPNe4hgGmgd2/9pcrX7Aeq2c6dD9f6At9Uz9VbKFIDVDzZhI8LIBkail0ciCT
         FszY56me0X+yQJF2cY+N40osPkAFMvV+vYxa1F3TceP+9/HN2tsMRjybfnMza3lqWPhL
         XM68QWrotJ0X4jTCXeGdx+8NcY+S3fk6HjWEcAyCnhIkxLah1j9fCIXeJT6QGiQyfmbY
         59vM/fhpYA1g8Bxm7ep+PB/z+h1knnM1rPemRvJDOW8yNGTT/QmPk9O0Q3yC2wLH/liO
         ikmA==
X-Forwarded-Encrypted: i=1; AJvYcCUPhe8xdXnLgtGym+M09jmtoR1+KKh43y/1/TFfWXaTI3G5Z1J8dYJ5vjWB2Tah7SxN06Jn1/RzYJr6hVg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKAbcqwzC+4hHm9aWmy5MlmkH5hisD9FIeqTaODGzSD6Jtvyop
	R+3ufaifkJILFhVmSrLJPnq7FXJej8kn1/dBPWkoedBU/Qmz+D1f2iFd6j8l2LuHxQbJBjiQInE
	qagCFgcMyJrTSxkFaL+EhgLcm5P1jHv/DzufCJlYleXkl4JTUx/U7om6NNYdiGhxdRq8=
X-Gm-Gg: ASbGnctl+K63ko+8SOr/gEHYmcbYji7373m4RINecEWlbj28mht1zrlNM34bNSJ4BfJ
	sM5JT9PCu6Qfwe2j0D8JtACSHGmkzLBF/v8pIpnk3ElbUcO/B3Jj/McIlEptHPD8Q49wIjI9iKm
	ii5qFFid+EENEOlk8WZs7kO0TOaKQ3WNGqWr5VyQDkOcaIUYt0K5Rf+K7l7lPNxFjxhNHsPzvuw
	+dsivhHbg9d5WpCgAjlIeHKWmxFbFIi2/SO2MER422gDNfTa6gWqZkcafeOat+nt9Lxouww9kNf
	iF5iS4dTqxD98HfCIuRdaGgi+SUq98GTJKHmXRa/ytpWWZvH5ko1kMl4xDLwGq4djd8=
X-Received: by 2002:a05:622a:4cc8:b0:4ab:5b15:fdb1 with SMTP id d75a77b69052e-4ab7f9511eemr119396371cf.15.1752676586191;
        Wed, 16 Jul 2025 07:36:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGi5okhmPc18F4MSl3Ewd57VpwWpM4vQ1vHWNcrZD3NgHSt79iUlTK7PnkvhFJVebZUhBEygw==
X-Received: by 2002:a05:622a:4cc8:b0:4ab:5b15:fdb1 with SMTP id d75a77b69052e-4ab7f9511eemr119395741cf.15.1752676585545;
        Wed, 16 Jul 2025 07:36:25 -0700 (PDT)
Received: from [192.168.68.118] ([5.133.47.210])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-3b5e8dc2464sm18418111f8f.38.2025.07.16.07.36.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Jul 2025 07:36:25 -0700 (PDT)
Message-ID: <6de11c01-5b59-4222-9f4a-c951c74f0128@oss.qualcomm.com>
Date: Wed, 16 Jul 2025 15:36:24 +0100
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
Content-Language: en-US
From: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
In-Reply-To: <9f4c750a-9e23-45a0-a761-4c3fc2c7d8c9@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=dKimmPZb c=1 sm=1 tr=0 ts=6877b8eb cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=ZsC4DHZuhs/kKio7QBcDoQ==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=iuNjYCSt-HKeNY_OgDcA:9
 a=QEXdDO2ut3YA:10 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-GUID: ZT89UVZRFtQwHjQxHikHltP9-7cQrhtn
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE2MDEzMiBTYWx0ZWRfX90685CTUCQDR
 8NUsbBMwW12ikNi+6c5ce9btrqZjjY5Ie3Uq83EpFlueDICa8G2HC+RhmYgM4Jryj/0IVVXnr9f
 NNDZO1c9T3LfqFuD8rUNcBeEDMgpJP8a3mCCRXCanPtVfyIwxjqkvC7hRxkBwoOydYN1buu0Zv3
 exVUOmAzOxUxbi07rTgP0qG0lRMrhU+YZGpqr3ubPllw81b0Mn3DMMGxI43rOguFwCNAb/aFu12
 EaDa+hNnf9wnh1udSvdRgrIZOmmnU/2uJtAGUQFlj9gzVe4w/7gMvMVHkHVJ2MDv7xNJVRxevin
 uWTOBS8CBZiHSfGbU0CmanfnrhqqtQL2fXhIBKbp6d05JAXmSBs67TXV5PaY4NgqvXvN39UNNNI
 YkTcEusG9Y+zFZBad4HvmroMLVtHGr2NCAksBSkTuUYjRy6w5jHsVS0zno8ocCC/3qKU/J55
X-Proofpoint-ORIG-GUID: ZT89UVZRFtQwHjQxHikHltP9-7cQrhtn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-16_02,2025-07-16_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 mlxlogscore=707 mlxscore=0 spamscore=0
 adultscore=0 impostorscore=0 priorityscore=1501 suspectscore=0 bulkscore=0
 phishscore=0 lowpriorityscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507160132

On 7/16/25 3:31 PM, Mark Brown wrote:
> On Wed, Jul 16, 2025 at 01:33:22PM +0100, srinivas.kandagatla@oss.qualcomm.com wrote:
> 
>> Ffor some reason we ended up with a boiler plate for dev_get_regmap in
>> wcd939x codec and started exporting a symbol for this. Remove this
>> redundant wrapper and direclty use dev_get_regmap from device pointer..
> 
>> -struct regmap *wcd939x_swr_get_regmap(struct wcd939x_sdw_priv *wcd)
>> -{
>> -	if (wcd->regmap)
>> -		return wcd->regmap;
>> -
>> -	return ERR_PTR(-EINVAL);
>> -}
>> -EXPORT_SYMBOL_GPL(wcd939x_swr_get_regmap);
> 
> 
>>  	/* Get regmap from TX SoundWire device */
>> -	wcd939x->regmap = wcd939x_swr_get_regmap(wcd939x->sdw_priv[AIF1_CAP]);
>> -	if (IS_ERR(wcd939x->regmap)) {
>> +	wcd939x->regmap = dev_get_regmap(wcd939x->txdev, NULL);
>> +	if (!wcd939x->regmap) {
> 
> The existing code should be more efficient than dev_get_regmap(), the
> latter does a devres_find() to look up the regmap while the above is
> just a pointer dereference.  It's probably a marginal difference in the
> context of probe() but there is a reason to do something more direct if
> you can, dev_get_regmap() is mainly intended for generic APIs that get
Thanks Mark, I did not realize that dev_get_regmap was devres search at
the end, Will drop this patch and make something similar changes to
other codecs too.

--srini
> passed a struct device.


