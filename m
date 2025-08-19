Return-Path: <linux-kernel+bounces-775194-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41E6FB2BC5D
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 11:01:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8CB197B435A
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 08:59:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDB42319874;
	Tue, 19 Aug 2025 09:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="fcujlAtZ"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 971CF31814C
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 08:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755594001; cv=none; b=UJy6vNUtkXfwQIzRL+s9+jrzEHasLIy0lGDxveHG8bhcTXHVi75LpFA271d0YB1oZ/8BTZRCax0Y9bPXXGUtJ6LAfy5EUevISD6xosPTceL8ICPSWtFyzEt11h18olblMbN9P5En0o6Say+E+bG13c98hY1PKLGY8nqYJ2b9+Ks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755594001; c=relaxed/simple;
	bh=Hh4zqDBDykKthP0a9Qkz/GP1EmZNegjzXgRnEmjrO48=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=R+cRjij51WlVORmaUg7HLUeN6Oo4AaabCbcTHItCJKjl/+TXXSJY/CR6qiiYKqafjhaoslvjMSU+d1WMmq2MGJwMfWL4NPTvYrQHjycFNp1B8btyJWA9SW3pm0PvlcejWa2UD/64q//y2D4Gz2tXVBPZnNTgB51BwLTRnu30L78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=fcujlAtZ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57J8pBdO003958
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 08:59:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	8lF3KpHtHPJ+/F44JD02kWVd9YNd/W+c8w7yaqsK6GM=; b=fcujlAtZZIud4xK7
	tkWFi46svrxqPkKZyRDOwaCNQgHXp4Ax+tW/LgmByuwsrHgcQSUEDc5L2A+YgHkg
	8PHv2XlWSR/pnsuBA84WKDxfOGSNaAn8PQjMy5bnG+t3AouWhbxRu+qTkFNg+gjJ
	MrUpDb34kzoiNieIZSPuWD9niz9zSjr4KdBeS6s2iQo8aW7lD3roAeqKco8Y33XX
	d3ilFt7H1UbunKRh8in1iNKxXgz6qetg1e53Hl433mvj6oBYBrSNALIDlNhs2VdQ
	rZgIV579W/QI14NZUm3DkgixzQB65CaWb5i0xrkHiE61/hOtLwakYGbaJBRwY00G
	Yg5jsQ==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48m62vjuca-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 08:59:58 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4b109912a9cso229744071cf.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 01:59:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755593997; x=1756198797;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8lF3KpHtHPJ+/F44JD02kWVd9YNd/W+c8w7yaqsK6GM=;
        b=Kbs6KnRa1W8PwLHwkaErdfcUxsUFDUplH4SuSesfsm/46Qxh10DXlVJ9fj8mOXVfzf
         DeRWJeDxfKBvnTNn4IXuDI1ArZ1fJvuEg79ziVw1dqEZheme/Sy0X9FEQIR7tYAOeHYY
         iJ4JljvJQFvCOiD0AQBVcRhYChKOrdR2dIn2Ura3nl0vDDFmJGPXedqBWp/hdacUzujW
         EzAobUo8URtYsZwAYiq1eiG0zKs8faeEHXMRjsfNi+EtcHEigFPMY3cgVVJ0f40tho1T
         MD77J8fVjSlLcZsnAaW2s1GA59QAFeGuGB14k1KX8txC1cBo586mwCmFinsnWMHmhjwx
         bqmw==
X-Forwarded-Encrypted: i=1; AJvYcCXY7tQZgst0ELWIIjjhjz1ZPhhanhvR2biAjb67CS9G+O5Bom7IbFAYcPe/fhOf524Ec5Z4H9PGeaYAML4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxquOcyoFVe/ML1yW8OEFTNijVLjM8CnOOzACU7c0orsfQwhCJB
	k3qDS55+VLychOhs+27vqGNlHdhBgH8akSvL5aIVYE4XIwvZZQkaPnddkvHXoDutoyMqUxwO98w
	FdiPdBtXEXzPaNxLYaeL1Ue4KrEGnzeoAid2NhjLta0uYMESLgnm5XZWcdmv+c0SvhYk=
X-Gm-Gg: ASbGncuJEtJ+4alxbI5D+otVqzbcYX7gZsKJLmw9+1mkjFNgGQfoLEQBUDqaKLhbdbZ
	BlXCNwRPoCA2zLWTn6h0VaWGrq8JFfzUGdamEktwAQARIwWBI0fAtkjSDSqmwWktR1YccbvmvHL
	zGlkHyoH27Ecr6nazPo5UdJghibhqArtvyhWfRrpUn+GghxZbmzMBUlTHh19RusNWqLZnwhpMoC
	umSqOx1L+Zho/ZwJtZxEoF8odI8v0Yjp4zecE2bRsHPQhtBTM94KUCsV6ugnChdrZRqAdpNXQKc
	08sdFI614AHcl+ypLH5roICw5WubvWfsYM8G8kX7AZXbtlNy25CJblcJLeUsH40X8/4=
X-Received: by 2002:a05:622a:1aa0:b0:4b2:8ac4:f07b with SMTP id d75a77b69052e-4b28ac4fa75mr3985171cf.77.1755593997463;
        Tue, 19 Aug 2025 01:59:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG3agWwtfi7Ws7maBTenpB2FNs804ZV1OVplC/ref6pFQ7oAEtBb3ow4VsePNm+lOViOGFM3g==
X-Received: by 2002:a05:622a:1aa0:b0:4b2:8ac4:f07b with SMTP id d75a77b69052e-4b28ac4fa75mr3985031cf.77.1755593997037;
        Tue, 19 Aug 2025 01:59:57 -0700 (PDT)
Received: from [192.168.68.118] ([5.133.47.210])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-45a1c6cd044sm216696595e9.9.2025.08.19.01.59.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Aug 2025 01:59:56 -0700 (PDT)
Message-ID: <e0907e8d-19fa-4ad8-ba81-cb9ef4e78a10@oss.qualcomm.com>
Date: Tue, 19 Aug 2025 09:59:55 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/6] ASoC: qcom: audioreach: add support for static
 calibration
To: Mark Brown <broonie@kernel.org>
Cc: perex@perex.cz, tiwai@suse.com, srini@kernel.org, lgirdwood@gmail.com,
        linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, krzysztof.kozlowski@linaro.org
References: <20250818125055.1226708-1-srinivas.kandagatla@oss.qualcomm.com>
 <20250818125055.1226708-4-srinivas.kandagatla@oss.qualcomm.com>
 <6d137f07-d37a-431b-ab38-5f3087d9b3b7@sirena.org.uk>
Content-Language: en-US
From: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
In-Reply-To: <6d137f07-d37a-431b-ab38-5f3087d9b3b7@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE4MDEzOSBTYWx0ZWRfXwTz7c2wzlCUV
 qU7xfJAt+BDYNJp2U0JRHYQTSnu0hYWZ1bD/IyAnyqSjLxH3O7djLjbrsJF8o4LnWZNEB/OAk4A
 v4CbAvvSOmgi+KBVsJxRrMqsFhIL8hlFAIRnsKtgRjN5GvYf4f4aV1cATPUX7d+hncrEG92fpYz
 ozQeNnbJ0Sh3OglJKKfjqQW8GjWjMwOgfvGPvB7t9AUR/6cWX7R44I3v/8H6OzkafP2nebNPi/w
 ULoDEIwkWb3x7S19GpoW6Bi0X61SSWYPaY8C4NEVlFc4wpeFYtLtwsL8ev8AXGNMIZbf/8x/VT2
 M4kbhTENwwS/NdECxP3totx1xAsQZRiNVE4yxeOrTDL1eheq5vFEj2Iqt7patnlACtQ4CKl5Y+L
 9DoL8kAM
X-Proofpoint-GUID: 0ECODf7rTXv6T5uohsFW2jMoRs4HAD0_
X-Authority-Analysis: v=2.4 cv=A4tsP7WG c=1 sm=1 tr=0 ts=68a43d0e cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=ZsC4DHZuhs/kKio7QBcDoQ==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=BXQ6yQkEz0_uBQHTnLUA:9
 a=QEXdDO2ut3YA:10 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-ORIG-GUID: 0ECODf7rTXv6T5uohsFW2jMoRs4HAD0_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-19_01,2025-08-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 adultscore=0 malwarescore=0 bulkscore=0
 spamscore=0 impostorscore=0 priorityscore=1501 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508180139

Thanks Mark,
On 8/18/25 7:52 PM, Mark Brown wrote:
> On Mon, Aug 18, 2025 at 01:50:52PM +0100, srinivas.kandagatla@oss.qualcomm.com wrote:
>> From: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
>>
>> This change adds support for static calibration data via ASoC topology
>> file. This static calibration data could include binary blob of data
>> that is required by specific module and is not part of topology tokens.
> 
> This breaks an x86 allmodconfig build:
I think
 #include <linux/types.h>
is missing, Will fix this in next version.

--srini

> 
> In file included from <built-in>:1:
> ./usr/include/sound/snd_ar_tokens.h:243:2: error: unknown type name '__le32'
>   243 |         __le32 size;    /* size in bytes of the array, including all elements */
>       |         ^
> ./usr/include/sound/snd_ar_tokens.h:244:2: error: unknown type name '__le32'
>   244 |         __le32 type;    /* SND_SOC_AR_TPLG_MODULE_CFG_TYPE */
>       |         ^
> ./usr/include/sound/snd_ar_tokens.h:245:2: error: unknown type name '__le32'
>   245 |         __le32 priv[2]; /* Private data for future expansion */
>       |         ^
> ./usr/include/sound/snd_ar_tokens.h:246:2: error: unknown type name '__le32'
>   246 |         __le32 data[0]; /* config data */
>       |         ^
> 4 errors generated.


