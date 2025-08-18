Return-Path: <linux-kernel+bounces-773528-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EB873B2A147
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 14:16:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE59D3ABCA9
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 12:13:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBA8231A065;
	Mon, 18 Aug 2025 12:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="lYuGxOrG"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD2D9261B60
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 12:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755519174; cv=none; b=X6ROqVsm4TEHgMOJrBdqR2Pi6I5Bkro6FILwcTgndd0morUQgo1HXx9Z74tYKkgB8t9Dzju3btpNOY+JI7xw0ishjKJ4MJ2NEEqnenqC7WYyFq2C4h+c3uVu5l7U7nI0Z0PqsDPFqj8EtBtXruiE0lw3TgH53djRhKSTi0DqadU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755519174; c=relaxed/simple;
	bh=l/Hq9M2tag2Uf2Hwt4nk862X0hV2q6xQBB+TOTBaiCg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kdkme+XgIhCi//x79L8P89MwJZQK4c2cAEFl+DmuL8rc0pnEqzkqEhTaN3Jds9rVXNhTJdZwO6fr1d3O1F/07s2MtjRiGNsz0aMAcs5Il1NJtI+BtPTVc5cPRJT+KTCJ03mx/9iHdNJIDkOybGdygDDuSyHW83l7f/Te+mCRmPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=lYuGxOrG; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57I8Nmiq010617
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 12:12:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Y/Zk/ptbfC/s0X71iF/TOOzhAZQdu9FozG00nBTib+Q=; b=lYuGxOrGw6KVoj9d
	6wt3DXu/EpGyz1itMgu845RUyfGxJqsDbLju5KAx/ZcrQ3zEvZEK+KCOmkuQ35ns
	XYu00HKVxX5+rMrS7nBKX3nYHmdKQubDLRk7k4CVWX+jYD+T+P+1BGs0ZRsceerm
	iC6/0k/CkR+5QaOd8kjKl2LCYanBQnUMb1Uv38FcNzva9FITphHhg/qk/X/+vNcL
	AezZfIrUK93MMw/8P5fBRc0QdvQqOmruLyxIZ4Eo9ZBKdY22FUpAaUlA06nJ+MtT
	TJREQpbWHOMzlKq9Mvw9DoZX+VKvnXV85eMb1EcWwq4TJU2wJ5azEhOcswZHz09W
	rRs6hw==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48jk99mgth-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 12:12:51 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-70a88daeb18so92947816d6.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 05:12:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755519170; x=1756123970;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Y/Zk/ptbfC/s0X71iF/TOOzhAZQdu9FozG00nBTib+Q=;
        b=nY6UvErktpn9rt7aqmc8dq5gDQkAfcdWgp/PkoJ5K1TVXAfDcViFgVAzivsGKWUwHd
         BGReKang/yq/ARqYmLwYMjJ1qJc33/jHqY6XuVSwaEvjw3eJxwN2wx9NQONPZGe8Y6qg
         sBtNEIq17DIEkJdYPwmz8PCrbd7WRAL/gZJsR0AQCxy4w6OsX+UB/PTVtETPLQw5cX5k
         hcC1c1ZzOoPFBvKDcaUnRjLCWiIf0Ogc9aaoBwXe21Ffg/6qZ6+KSd3YI46nf5berRBZ
         qk+dO9Y+16r/wRvYfoUwLI52ZKdAZu4u/UaQrP3N+JotguTWdPJHfIXk5e4pJtPOB20T
         Fyyg==
X-Forwarded-Encrypted: i=1; AJvYcCUynUNYc5Xp5QOEoccCcQy8M9F9jCKjwekondbraWIDuWrFJ6k00FoKZWlLuNC40/guLbwcrr0fQJfucvg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5E0z8NdSsnnEa4RoBjb5h3brmQFv17x+lefNAnhdEpaq49yUi
	6zu+4eBAxMO59tc0g7lTOz0E2L5euGgA+zq1SOPSd3/4AdUa2fnlcciasMTSLCaRLZVX9afOeii
	XD2ZSua/CKQts9Nfo/LSlBd9lSqa5+5wgCzXbh3lViFRbf71OaOdX8DpvX7Ap7c5w2Zc=
X-Gm-Gg: ASbGncsrp/7jT/mQT9kDMUG11BrIluobG01HJxXLnxtbQHWjrvcf5oIVP+KB9v+0ik9
	ZWVTuomXbCOgZ6mGnHe0S8/TTjXE3G0Yd1RDSQCrNgA9zevB7nfwl9LJvNcTTUMQi/2fmetu2nY
	eFvBWKA+0Mp+scWrPnBVGKtQc7+ArBcCys0QOmKX9s3tqf54hp0Qig8LwEeJTGgSoxDXKl4sY66
	hNivumcp19gfQtO3BZj3MQMx5EFp6qcq6TZyk8tmtpEHwzBmGb8H1yg1MjJmKRHc6uIXJ3SkMrA
	9jshr5iv0NBkxeOdJvIw91vYphgESfreehNFgM5DzJO12c6gtr6NSwmU3Kaf5nd4eD8=
X-Received: by 2002:ad4:5ec9:0:b0:707:4753:bfa0 with SMTP id 6a1803df08f44-70ba7ae8111mr141335916d6.13.1755519170424;
        Mon, 18 Aug 2025 05:12:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFHRFvUfwURz3ewAxMtJStPogLwq4buM+7ktoCYfMhG9uZfyOelR0HnLGAyPJJlNvhRCWmp1A==
X-Received: by 2002:ad4:5ec9:0:b0:707:4753:bfa0 with SMTP id 6a1803df08f44-70ba7ae8111mr141335526d6.13.1755519169817;
        Mon, 18 Aug 2025 05:12:49 -0700 (PDT)
Received: from [192.168.68.118] ([5.133.47.210])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-45a1c74876csm170320785e9.14.2025.08.18.05.12.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Aug 2025 05:12:49 -0700 (PDT)
Message-ID: <9533096c-926c-4251-89e8-84989a9bf0b7@oss.qualcomm.com>
Date: Mon, 18 Aug 2025 13:12:48 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] ASoC: qcom: audioreach: add support for SMECNS module
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, broonie@kernel.org
Cc: perex@perex.cz, tiwai@suse.com, srini@kernel.org, lgirdwood@gmail.com,
        linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
References: <20250818112810.1207033-1-srinivas.kandagatla@oss.qualcomm.com>
 <20250818112810.1207033-5-srinivas.kandagatla@oss.qualcomm.com>
 <8405b263-08a9-4b8f-ad20-73c8f5865b39@linaro.org>
Content-Language: en-US
From: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
In-Reply-To: <8405b263-08a9-4b8f-ad20-73c8f5865b39@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: cF3daioRwsLUN4SWffqCWYjxa2fCWlu5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE2MDA0NSBTYWx0ZWRfX9ONT8Dlq5K33
 U0lYD8WIehPoTlzwjUrZ9So3kMDxl7tfS03RDKRhDOE8t6aX8zNA3L+N0Ex6Q0VXXMPrjKZgU2S
 YTTZmPx+TNIvrXxM7X2Bc2kSaoNAeUIJCuOHC+vEIwkOaSZxnTaNfs0DdwD53hCmGdtMbSKum5I
 1z34w6wlizb+SqsDYaotBMnQff9+cWKtUe9LqL6nu+JBg0S92qVhoQNK07J0idwkkJVCPk6FX6r
 2pm0mifMCowARbjjSjlsnaUqaljIJi9Qi1B+oRhDK5P7zb2WzgqlXNqY5kdKTDztOx2hA5cmI6i
 wsB0leLYSwwydI9Q/m6M3JlOkHvzs5OMjEKzJPMypEdEpololp+Mk3/rYd3rnQQITEotyhH3u+t
 y97Kon6a
X-Authority-Analysis: v=2.4 cv=IIMCChvG c=1 sm=1 tr=0 ts=68a318c4 cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=ZsC4DHZuhs/kKio7QBcDoQ==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=gLwdHoSog2dnRv_T-kIA:9
 a=QEXdDO2ut3YA:10 a=OIgjcC2v60KrkQgK7BGD:22
X-Proofpoint-GUID: cF3daioRwsLUN4SWffqCWYjxa2fCWlu5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-18_05,2025-08-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 clxscore=1015 impostorscore=0 phishscore=0
 adultscore=0 malwarescore=0 bulkscore=0 suspectscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508160045

On 8/18/25 12:58 PM, Krzysztof Kozlowski wrote:
> On 18/08/2025 13:28, srinivas.kandagatla@oss.qualcomm.com wrote:
>>  		rc = audioreach_i2s_set_media_format(graph, module, cfg);
>> diff --git a/sound/soc/qcom/qdsp6/audioreach.h b/sound/soc/qcom/qdsp6/audioreach.h
>> index 617bda051cf8..2ae6420f4b6a 100644
>> --- a/sound/soc/qcom/qdsp6/audioreach.h
>> +++ b/sound/soc/qcom/qdsp6/audioreach.h
>> @@ -30,6 +30,7 @@ struct q6apm_graph;
>>  #define MODULE_ID_MP3_DECODE		0x0700103B
>>  #define MODULE_ID_GAPLESS		0x0700104D
>>  #define MODULE_ID_DISPLAY_PORT_SINK	0x07001069
>> +#define MODULE_ID_SMECNS_V2		0x07001031
> 
> Can we keep these sorted by hex?
> 
Let me try that in v2, looks like some of these are not sorted.. I can
sort them and patch it.



--srini
> Best regards,
> Krzysztof


