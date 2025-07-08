Return-Path: <linux-kernel+bounces-722024-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D85AEAFD232
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 18:44:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 51E05540356
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 16:40:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 399C8289E2C;
	Tue,  8 Jul 2025 16:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Wo5L3PDA"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F4492E49B0
	for <linux-kernel@vger.kernel.org>; Tue,  8 Jul 2025 16:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751992866; cv=none; b=Dpm+JMGuysLznXxPBPfKYJ9e5A9G8c4clVNqLWwE4iIqigBEhg5B8m+qJ/YQQ0IokxOZm3C9N5+9Bu5rAqn/zZyKrZpnPfNqyoCVe+5igcjkfwsNjyeMrbGDW6+Rh/KtkJefcsRW6dq0XjnP1WI+Rycy6QQfedxJiu0y1tyDFOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751992866; c=relaxed/simple;
	bh=oUwfhuQJI3rCG3DAr+iSLjbJAl+uDXbsV+D/ZN31zks=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dOoCoC5E3YHLmTX8tXr+wM/KXMASgIXul7NtF7+5oxdsPaybFSJ768qJMY+kxvo2PUJXcDTkqhslmPoRrXmeeLy/YjFW7Kui8V3KdlXmGDo+p+pE/0lXkbwVRwlMz7CQePmcfwijXxlTYRdknLd9ePAH48LcLZn35/AFogHj86M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Wo5L3PDA; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 568AAPS3030392
	for <linux-kernel@vger.kernel.org>; Tue, 8 Jul 2025 16:41:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	UKf7w5qtpfoZKrAvtc6t6RnK95VeeAC8USeqACfTOu4=; b=Wo5L3PDAPgTieNfr
	qjMi8imoAi591T9GRi3Tv2MnsSdFFDe8v2DII0Ca6WfNPfCZ/o56cKKyG1HEr/75
	Yk9TPiE+ZmVmMu3WVRyIiDxZjBk5HHYUEajN4YaFfTX58qGJ2iutnBCIEbKj7ykh
	qEAF5YJUadFBGvaveMYhQ2NkHNLaQQo0jFzkkcxJ4B4iBExzAm8t0gFCWsDpznEz
	h7ckJrIhP/W4EySvyNwuxOimlBlLgTTRdskzPGXJSXt/uOYdpYKkD4Ro8ki0tRWz
	0yX/JdwkSFJOlGx1B7Jx4btfJJwURtMiVLVdxw76Liz/R0kxCH+JTKIAU3WS+qvZ
	+Aaz5Q==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47r9b0wbrm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 08 Jul 2025 16:41:04 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-7d41d65f21eso35223085a.3
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jul 2025 09:41:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751992863; x=1752597663;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UKf7w5qtpfoZKrAvtc6t6RnK95VeeAC8USeqACfTOu4=;
        b=ZxrrTY2ECHVQed7QtjpMi/ufbBWRf82am8TbKTHv3NbPPZqrfsDIX7vTawCoVAYecS
         JNCq3UbfVWt/FSWfU7cRTB7o05AKYdT13KE7z1rRXqQhPqmU17H5A7Alz2mzOssM9iyh
         e0emEtd5ZdwSaWkOyYYg0GaNQH60uOoCFL6oKnn//2G30W75LVxodlX4weGLttvrMutU
         /S5St6WomhIzTI7b3pwK3Eeksq60M8B18Iv4QcXZQZVBk/xqHfA+m5pLts7xMUpN+ceQ
         NxwVMepti0dl5gnjivyVoFGwG+JqyMWjfDjK6FKiNMaRz2+woqLf1vJRkoKjEIP12qZ2
         6WTg==
X-Forwarded-Encrypted: i=1; AJvYcCUv8Vk5ABxJedndG7cI5wOYO9hZ4RDjx4mn06Bcrp2U3DyD8mo+adcPTbg4aSIzYV1rz8pfznmhCZeXNbU=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywm7uQDWLqvTYThDFM/Z2VM91XMDrUAyDKNrx6QStYmD5eDKqGW
	g+69RyXc70NoI/HAREKAGZ/wl2PUZN/4esqhFZTT7XJa6MlmBjrBJ4asAPJUhoZ7aFpQ1OoJxnW
	cxs8vsVetYR7IT5ZK9rYo95xyOgNMPhpJCRxc0SBz4B//YGBMNQGNZvAjKhQNfHU235k=
X-Gm-Gg: ASbGncsVLUD4eBidK9mW1manoUZc2sdW7oTWBaL67dTYaIOpaxYv4pZ71KmqlPRMM2J
	svmp9zeiLnIox8OabV+qKwutmPYWuateBqi8MPE/3UA0GT2+0T77kDDVSn/LqJwfgEyHUslSglj
	F2NxlA2D/fz1Gfp0dbmRHrdPh4kgG2FTvT9dT0e78STgRE4zTyMzM/HFkHjFqPGYs2e3UlfRF12
	iHEA2iovmDYOAec6XnIsPQ5WU5e2SnWihzTeQJ2/J/WbdNo+tr/HOFvzsUXlaqnLW40rkabJYUM
	6i1U1aTQLz2MmRlm+Z1PeLXo88jNqZL0Ss1HbZgcPOeBdIamCik0r+qiCd57FImivS/FYe4tHYa
	4EGY=
X-Received: by 2002:a05:620a:40ca:b0:7d3:cec3:3ff with SMTP id af79cd13be357-7d5dda100eamr831389385a.0.1751992862870;
        Tue, 08 Jul 2025 09:41:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGQxRkEb/Wae9gi4E7WPavVxS7JCL4cmOBv4z6rnMmST8IxGjfLZDNtY9CT/To3psedF6/+Nw==
X-Received: by 2002:a05:620a:40ca:b0:7d3:cec3:3ff with SMTP id af79cd13be357-7d5dda100eamr831387785a.0.1751992862462;
        Tue, 08 Jul 2025 09:41:02 -0700 (PDT)
Received: from [192.168.143.225] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-60fca6640absm7510130a12.12.2025.07.08.09.41.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Jul 2025 09:41:01 -0700 (PDT)
Message-ID: <c8626ba1-33aa-4fe9-926c-704f0d7910d3@oss.qualcomm.com>
Date: Tue, 8 Jul 2025 18:41:00 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 03/28] interconnect: qcom: rpmh: make nodes a
 NULL_terminated array
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Georgi Djakov <djakov@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20250704-rework-icc-v2-0-875fac996ef5@oss.qualcomm.com>
 <20250704-rework-icc-v2-3-875fac996ef5@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250704-rework-icc-v2-3-875fac996ef5@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=dYuA3WXe c=1 sm=1 tr=0 ts=686d4a20 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=NIC3D40qKzNtBD7CQNsA:9
 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzA4MDE0MSBTYWx0ZWRfX8EZu0W494p12
 RIHDpylTkwVnYyITIp4Qxi11vuhRiweucG97h6+N5TydnM2WVRRAx7ehpHs8CrzKXbhomu2uz8n
 2b3+fenI14wXxweWbHN5hZgysdgraubEGQ+qqwnPV/aDvIHfDfUIhJtsPA+2zrPfymJ1Nss6ony
 WIEHztPJpOxXh0HbKejk9ESbydHatu+bC1YkTXVMhYvkf0hJOE6UOuvlxqqUANqZSKXlTTcmaZU
 swK3ETvp1A9TuoJPZrWpeP1cegqAKPU23HAAQV0ddOea13VbnEb8wu7nDUVRuI5yCs9om4FS05e
 0hpRb970PUxtsYzLyVillLciWjSocVnFO4psSpiXl89wnW1lYaxL68lRTlssdJkHMrkXj9v2rJz
 PP55JOV0vjZsMGb6kFWxI59VJaiMjnGj1N8TI38Bd41/0bcSkvOL39cxY9BBo08YMYnnR4gP
X-Proofpoint-GUID: r2xDUp3xdjJoAQY1CRJnHFvumQ4Ynw6u
X-Proofpoint-ORIG-GUID: r2xDUp3xdjJoAQY1CRJnHFvumQ4Ynw6u
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-08_04,2025-07-07_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 suspectscore=0 clxscore=1015 impostorscore=0 lowpriorityscore=0
 priorityscore=1501 spamscore=0 adultscore=0 mlxlogscore=928 malwarescore=0
 mlxscore=0 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507080141

On 7/4/25 6:35 PM, Dmitry Baryshkov wrote:
> Having the .num_nodes as a separate struct field can provoke errors as
> it is easy to omit it or to put an incorrect value into that field. Turn
> .nodes into a NULL-terminated array, removing a need for a separate
> .num_nodes field.
> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> ---

I'm not totally sure.. failing to NULL-terminate is as easy to overlook
as failing to add .num_nodes

At the end of the day, potayto/potato, even the memory footprint doesn't
change.. But if you insist, please make sure that the mass-update didn't
miss anything, so someone in 2 years doesn't decide that actually counting
the items is a better idea instead.

Konrad

