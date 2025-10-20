Return-Path: <linux-kernel+bounces-861206-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id AC1C7BF20F3
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 17:19:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D845D4E56EC
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 15:19:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F36B264619;
	Mon, 20 Oct 2025 15:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="L5639v1w"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B9D82627EC
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 15:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760973566; cv=none; b=I48J3rozvxBySdGR/+YLQV0DKx8Rw1PXWLAm8nfCXh2VCO8EPMlYaZaWvnzvhxq2Z7Fmd8wVPP/hTJhVWK8GoNYsqPNWI1IGBmv7LhNqunZa2Ljl2mOv6eP6wEOYlEc3GKIaqwVSu5I9UF1L/NqaKvIWE7jrXm2NwqiNyvG9RSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760973566; c=relaxed/simple;
	bh=txIz2mOWj+d71E+Te7JQa6TGasPd3qP3hYYTto4gqzs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Uya5H8+6VqsX1KifFeZ/HWNfmUBvcL3X0xGJqdudTX2wMrl7foHgDVoYZxGQFF/J5oVy3PgEJXGgDyFkESWCtIq5Wt2PXh8Pm5ozPPNR3u4e/ohrDiips90SoAnPLBKrgDRk9iTINyq/lnTcA53l1tf1LdSX4jnFCSLak0KOI6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=L5639v1w; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59KBYwTX025088
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 15:19:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	I+yIVlYM5/2IuWRwZgg83a0i74gXu/4A3ovbjVxqAvo=; b=L5639v1wdsU88KTZ
	aP31YCPaZZA17fAr371LPz20Mbe9pPB7jmcP/Y8iw0T8UvihA7TV4RPBzBAVRWSo
	qeOH0FXFykqJ6BytYCI2boZwYh4q/Mec+JwiaByylksSYZZ3kFU7OJD2YSv8b9/w
	H+FjqRpgvHKOVTKlyjcAIJPP6oxu0n8WnWP5zit66fkzf4Ynh0TMoRh0hREVhTgF
	n5bdgtu0sxfq6dPzXCXY8E/fl1VmiPWADwT4AEEjBXr8TXqiKm3vFbn/MsnJia5t
	2opTO9GPTBU7I+MlXaSnqesfc/GDdglQ9AiOMmIJrwFehUH1diFuZLXpoqyacvPO
	pp11KQ==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49v343w6an-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 15:19:24 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-87c1115d604so188453616d6.1
        for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 08:19:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760973563; x=1761578363;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=I+yIVlYM5/2IuWRwZgg83a0i74gXu/4A3ovbjVxqAvo=;
        b=KlKVfAWxgfG52rpX7hDHW/SJ8wl1kYqkopCuDZp/5vAVA90FTANCdICBhx/yBzVCrw
         ugmAx8v/isnua4M5ql81PkSJHyX0Kc984Z6ItspOipyo39Qxe6hrsqmM4QwC4zYSDR7/
         Y/4/c6PzWjQXqFluSG/J4XSmmrnq/U8B2tJB87MzSwe+p3vXscxFivBilMttScVCcZMy
         1+ABQp8sYsAFZAAK19/XCpZDaBTW41bg/4143lCRf2wVcCSWWEvxCJkNMuM+MmbBROnp
         x1/qJYjM+TQw/HojEaErbVHOi/orjf1WGdqjXASQkOJYyxNcgIsNw8A7GLkka/dl+mX7
         WzYQ==
X-Forwarded-Encrypted: i=1; AJvYcCUsMC3iBqqGOLIF7rQ1VjLOEdElJkPDlUvLl87Xt7NjY7eNjvEb1h921AvgVqhPfHf4PenruavkmKWJ8y4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzAM1iCToSDJ0wIQ4C9w3DyboXEZTuhtm3heReUjsHuu+hX/bZo
	ACEZCudi93dj6ckosTkQjHne4htdAblWR2BODyqdgrVZ3Yx/rpPpMAEKG/v/Hjw2cZX4Hb+KL5R
	H51oEQb5w1V+xZASOMPVxdTd3pTV7wMadbmz1zxMNXGNrupOGm73Ll9mSa92LQEQ/59I=
X-Gm-Gg: ASbGncvPguMLNN5FMnzQhTcdtK0ij2jHqzlFQs3pwl2M5IB0z3ym4Eoq/f8YNzpgcW1
	APaXiKUUPhmjr8X2LulBCD23+9aE4OKp2CguxxG/dBeluUL1GYr0q65tPjj3S0rHg38JV7ZGDFy
	WLpyl7Xo2etc+LQWoqaE88G9Nfa/ehMxBTtGBFXHG5Lra87t3zgRWPINXht54uB+cOGrGMdwGVl
	qqQOPkUe/WE2dZ3OqiaimKggBSGKpgo5bH0iWiIhUZQmhnR2VCjUOCcL6jqjAgZtrjOQT5ieYlV
	RXQUybCNqbAYmN+ps17/NyBsamzk1Fdw8IRMOnLVUEbk/i1Xkz/RN7KhSDdgKmM49L1l+52RrPc
	L+oNaUHwkbp4WYnd2Qooi6TiI6w==
X-Received: by 2002:a05:622a:1a18:b0:4e8:b940:eba6 with SMTP id d75a77b69052e-4e8b940ee60mr75346871cf.54.1760973562665;
        Mon, 20 Oct 2025 08:19:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEH7CJ1xZAKYdlNReNmCh8bS2iyCK1x9Vecn8/NOzPyBPl+tYWrz9fVLu/gfRksjbH30i8Ykw==
X-Received: by 2002:a05:622a:1a18:b0:4e8:b940:eba6 with SMTP id d75a77b69052e-4e8b940ee60mr75346481cf.54.1760973562191;
        Mon, 20 Oct 2025 08:19:22 -0700 (PDT)
Received: from [192.168.68.121] ([5.133.47.210])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-4715520d753sm150398215e9.13.2025.10.20.08.19.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Oct 2025 08:19:21 -0700 (PDT)
Message-ID: <56328447-4cab-4446-b8be-63fad2a6217f@oss.qualcomm.com>
Date: Mon, 20 Oct 2025 16:19:19 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] regmap: slimbus: fix bus_context pointer in
 __devm_regmap_init_slimbus
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Alexey Klimov <alexey.klimov@linaro.org>
Cc: broonie@kernel.org, gregkh@linuxfoundation.org, srini@kernel.org,
        rafael@kernel.org, dakr@kernel.org, make24@iscas.ac.cn, steev@kali.org,
        linux-kernel@vger.kernel.org, linux-sound@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, stable@vger.kernel.org
References: <20251020015557.1127542-1-alexey.klimov@linaro.org>
 <asrczgrmisaqzhin37jzgylm6ez2mlxtsbe6qp5mqgfecprup4@yb32qzna367s>
Content-Language: en-US
From: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
In-Reply-To: <asrczgrmisaqzhin37jzgylm6ez2mlxtsbe6qp5mqgfecprup4@yb32qzna367s>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: LwYBIVZA70YXvfu0OY-qyJLQip-S_y3o
X-Proofpoint-ORIG-GUID: LwYBIVZA70YXvfu0OY-qyJLQip-S_y3o
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAyMyBTYWx0ZWRfX64f54fS3lo+p
 qz65zjLoGKc5CLkGQeuqjenjoenO+f9Q89ri3j3Bv/TCKRXmfCQ3eNJE7gI2+pfadANdZzAWC27
 ZU9jZKA7GDudSh0IgYcf36c/wM+kpR0lcdOqFGnF8yIH2pkbhSAUNDfAo5OCb52qzrFHgsYVHMe
 UpphSMQxz4q5fZ4iutbICNbuli0H0/C47DCpFdjmRchBqkooVRN1m9tUSOJfpmhqw/J/xMCAkN/
 IFVqZw9JwkF+/5pVydhA+BCHkH7AzqV61ehbsqpQzq69q/YTCJ/mQGUy2rgRxIiqmXiOYpNJkfH
 n7XRZz57pZudyn4CJnK1BjFFk+AaOA292bmSadpfsxg5r67JfesZFk2L6R8S3B2M2zS+LSn0l6L
 A4G9CPVEOBdoeDLdaq31Xc2+Z+4C8w==
X-Authority-Analysis: v=2.4 cv=E/vAZKdl c=1 sm=1 tr=0 ts=68f652fc cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=ZsC4DHZuhs/kKio7QBcDoQ==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=FQcGyLhEAAAA:8 a=KKAkSRfTAAAA:8
 a=ZVbmtxpYz0up1Ekx5joA:9 a=QEXdDO2ut3YA:10 a=pJ04lnu7RYOZP9TFuWaZ:22
 a=09nrmc514_O-33C_6P4G:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-20_04,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 priorityscore=1501 bulkscore=0 suspectscore=0
 lowpriorityscore=0 clxscore=1015 adultscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510180023



On 10/20/25 12:15 PM, Dmitry Baryshkov wrote:
> On Mon, Oct 20, 2025 at 02:55:57AM +0100, Alexey Klimov wrote:
>> Commit 4e65bda8273c ("ASoC: wcd934x: fix error handling in
>> wcd934x_codec_parse_data()") revealed the problem in slimbus regmap.
>> That commit breaks audio playback, for instance, on sdm845 Thundercomm
>> Dragonboard 845c board:
>>
>>
>> The __devm_regmap_init_slimbus() started to be used instead of
>> __regmap_init_slimbus() after the commit mentioned above and turns out
>> the incorrect bus_context pointer (3rd argument) was used in
>> __devm_regmap_init_slimbus(). It should be &slimbus->dev. Correct it.
>> The wcd934x codec seems to be the only (or the first) user of
>> devm_regmap_init_slimbus() but we should fix till the point where
>> __devm_regmap_init_slimbus() was introduced therefore two "Fixes" tags.
>>
>> Fixes: 4e65bda8273c ("ASoC: wcd934x: fix error handling in wcd934x_codec_parse_data()")
>> Fixes: 7d6f7fb053ad ("regmap: add SLIMbus support")
>> Cc: stable@vger.kernel.org
>> Cc: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
>> Cc: Ma Ke <make24@iscas.ac.cn>
>> Cc: Steev Klimaszewski <steev@kali.org>
>> Cc: Srinivas Kandagatla <srini@kernel.org>
>> Signed-off-by: Alexey Klimov <alexey.klimov@linaro.org>
>> ---
>>
>> The patch/fix is for the current 6.18 development cycle
>> since it is fixes the regression introduced in 6.18.0-rc1.
>>
>>  drivers/base/regmap/regmap-slimbus.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/base/regmap/regmap-slimbus.c b/drivers/base/regmap/regmap-slimbus.c
>> index 54eb7d227cf4..edfee18fbea1 100644
>> --- a/drivers/base/regmap/regmap-slimbus.c
>> +++ b/drivers/base/regmap/regmap-slimbus.c
>> @@ -63,7 +63,7 @@ struct regmap *__devm_regmap_init_slimbus(struct slim_device *slimbus,
>>  	if (IS_ERR(bus))
>>  		return ERR_CAST(bus);
>>  
>> -	return __devm_regmap_init(&slimbus->dev, bus, &slimbus, config,
>> +	return __devm_regmap_init(&slimbus->dev, bus, &slimbus->dev, config,
> 
> Looking at regmap_slimbus_write(), the correct bus context should be
> just 'slimbus' (which is equal to '&slimbus->dev', because dev is the
> first field in struct slimbus_device. So, while the patch is correct,
> I'd suggest just passing slimbus (and fixing __regmap_init_slimbus()
> too).
+1
I agree, it adds more clarity to just pass slimbus instead of dev.

--srini> >>  				  lock_key, lock_name);
>>  }
>>  EXPORT_SYMBOL_GPL(__devm_regmap_init_slimbus);
>> -- 
>> 2.47.3
>>
> 


