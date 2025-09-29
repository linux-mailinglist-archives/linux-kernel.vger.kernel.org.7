Return-Path: <linux-kernel+bounces-836131-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26D29BA8D27
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 12:10:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF96E3BF9DB
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 10:09:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31FA02FAC0C;
	Mon, 29 Sep 2025 10:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="oDLZz7Yr"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA0E62FABE3
	for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 10:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759140591; cv=none; b=LFlIm+ZMZsSkagH+XlyJEftzESewJ91g8sMuDZuPdt81T1Ddc7R+hd2P8Jx/f+LHbCSok0ENrHP+DvTidQDG/CKDG7aa3MnksWrje6UmVuCPuJlfpsC+Fm7ph5V40/+JLbF1g/mLyGRESMABTb6T0vbSJXlVCAWLPOXmUoUL6rQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759140591; c=relaxed/simple;
	bh=06Ux4I3QO/gu1GAwm5gqNsrEmJdX2MdFND6fwSh05LY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mk1zV4+vkwyJ9PVSPDmn77cGGWJWWLniZniFQ4JruaWmMDTYn5QXe5qzN/yVZRMmYzF4rWO48baNAaUU5mGWXXOJiNsKnBTP3qqCr/TzkTwjr4tbGXJwNno0hNaNS/vuw5Oa9mHkUWdWAv0m8LwRpCYCBkupArMy5Ky1lMtiIho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=oDLZz7Yr; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58SNU2VA022463
	for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 10:09:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ukuFX1CzqOMg1c7sNCM9NZcKqMaOkjZqvA7bpG2anlQ=; b=oDLZz7YruYMhFIVW
	u0zSPMWgmzitP/ZUBUKnzAqqqsF0Q2jifaFbAhuXRu/MDRX569pqun4SRSdv/FtK
	3qMOlOf3Ta7qBCHSF7UwArgxkZhfOtWtLc1cYpEHHzsbNf/McPHURh5/bYHszbOo
	LvWGN9E/5M3q20M6BGdvEvChy4z2Yzg/lwyWynyHCaxlBiFIV48S+D2Lrgig8gW9
	8/q8Qkp04VLiIXsUHPJgGw2h7WDT0EGZxNRiTW25HSy8ML8gYmhJKfx+g8IwDama
	LvYBv/QTA7JffWiw8oi8cLun1RiuY0CaEP5ZMXiO0uhbXqdjCNFnwylLXZoytDQH
	Cqi/cw==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49e59mw483-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 10:09:48 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-780fdbbdd20so4716645b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 03:09:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759140587; x=1759745387;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ukuFX1CzqOMg1c7sNCM9NZcKqMaOkjZqvA7bpG2anlQ=;
        b=Xem/oZXaupK4JXRdIsmO5Fxa48gx8psSZoPyrBI3GaptwXBFRb7yB5Xnt3u8GmvQZQ
         mZpwAhtk/I0PJZ0PCkhN6xUN13BFQZpC6osvI/AlRjCR2mkY+cdPjVSsFhjMlYpF2nSj
         aiMWKAbv/NbolkZS9+HsOP004z2u4GXoj5+FTKo4dzaBg5hM/uhNMbIjeVHr/i6qctu/
         oX8J8dTCEyR+MqqXRo7SyZ2li9gTLIwpc7rcSOzAdBTqEASVKJhHfbJEKnu8AcO5Mct8
         ayTe4KitfRVMmBPiRqI9PQ7mKmn1khD+kU0JafNSOZIAxoYkGGVOHuvFVQK6BNDmET4X
         I02A==
X-Forwarded-Encrypted: i=1; AJvYcCWvnC63PC83IpufKzV1XPqQgDvPt9xXKIMndJaWeBlwzgVl30NeWx5fFExCGfTXRM0zm4GZ45PP21xaLko=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFEgTx977QXZJljrQsULYZH9nTgaU2Csu8dOk4spoldgJ+CCD8
	/ggtELbGH9FOasuJdaL7x4rndiXkBPYz+RZfdAWmwr/zBt2fA36c4LqgIcaGuQGMfI3Lkf07DrO
	sFtLQbJfXFh7lOLgn7nZyx9kcAAtGwpSiYEzxckihrubFypE8SPx0l/49SzEm+YaQhE4=
X-Gm-Gg: ASbGncssy52We3TcXiU2kBBYXiEonV3BTS/DOKzssVFIYwqZ4u2LnzDad6EhQlKckXY
	lneX2OTOBhAOU02WoDcrd+bD6tIgpFgNUXAtOqZoO6dctFSaWOZDwybSfYymj1IVkwDLaeWULQp
	UQsmOf1smVKXUD5/RJJ9tpC/pm2Vex16nHltPAPyjaY008HSxWNwn1aimxhcTKJ7giYXEXdJGo3
	IFyEZkEPu/zq3qcJ5rJ8pZ2Ebb6ix2yGI5N8eK4xYrZ5TA+GHpRy+Y5QASe/4jvbr2RnnzWMTTT
	0jsymJsU94HUxYeSE6rW2dv4sudBY6ElB54JKfwFsAzdVHDcOMvBf12RnSVda9jgOkjNGzNWQA=
	=
X-Received: by 2002:a05:6a00:1892:b0:781:9ae1:1be6 with SMTP id d2e1a72fcca58-7819ae11c98mr7578411b3a.6.1759140587361;
        Mon, 29 Sep 2025 03:09:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFEONG/QNzmtooig6eHCxhIPb/wc02QLjUsMZtIaO+cmgm4v5/5vvNhS/Dl4PpsqvI5jOEbpQ==
X-Received: by 2002:a05:6a00:1892:b0:781:9ae1:1be6 with SMTP id d2e1a72fcca58-7819ae11c98mr7578378b3a.6.1759140586881;
        Mon, 29 Sep 2025 03:09:46 -0700 (PDT)
Received: from [10.219.49.214] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7810cfdb99fsm9344624b3a.31.2025.09.29.03.09.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Sep 2025 03:09:46 -0700 (PDT)
Message-ID: <809add83-ddfe-4fa1-8947-76e0f49fc6a1@oss.qualcomm.com>
Date: Mon, 29 Sep 2025 15:39:37 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/5] ASoC: qcom: sc8280xp: Add support for Kaanapali
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Jingyi Wang <jingyi.wang@oss.qualcomm.com>
Cc: Srinivas Kandagatla <srini@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Rao Mandadapu
 <quic_srivasam@quicinc.com>, aiqun.yu@oss.qualcomm.com,
        tingwei.zhang@oss.qualcomm.com, trilok.soni@oss.qualcomm.com,
        yijie.yang@oss.qualcomm.com, linux-sound@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20250924-knp-audio-v1-0-5afa926b567c@oss.qualcomm.com>
 <20250924-knp-audio-v1-3-5afa926b567c@oss.qualcomm.com>
 <ru7km6vtbxwnoqtt2zf24si5envayqh7qy45mc5molevrgt5pv@g32atkcwqyan>
Content-Language: en-US
From: Prasad Kumpatla <prasad.kumpatla@oss.qualcomm.com>
In-Reply-To: <ru7km6vtbxwnoqtt2zf24si5envayqh7qy45mc5molevrgt5pv@g32atkcwqyan>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: JIx9ANBrx45-JCO4ZNNzOkDWOt7mXCOB
X-Authority-Analysis: v=2.4 cv=O4g0fR9W c=1 sm=1 tr=0 ts=68da5aec cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=P4kkzRDHVV3rFGJAm7gA:9
 a=QEXdDO2ut3YA:10 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-ORIG-GUID: JIx9ANBrx45-JCO4ZNNzOkDWOt7mXCOB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI3MDAwMSBTYWx0ZWRfX1hfXAAelXvAe
 zLBUy9WijLzxH2p+fdT40x9MoqRnpyVsQ1d8ixDlEXYJ0Z7e+VYeic26s+y1KOkU485YixIBW7p
 xYIcRRhgIpzGwG1W5LH4d9FAcvFTt4IIBCPwWM8AwghkEBJtnNVMuvud7F68NH5gab8a5eT1JKJ
 ovcGzCMvbVfWsJffxNWDCpIb4CyNU6tx523Nz4d+1Mp0ozlAPO5/KNMpKpwSCVZWt4X+FOL7RSS
 dwcN6AnYQtR6GwHbgEVPtNP6add4qCvbc/DiUZ7GvvZsnyEhSruqWvwsZ+bsmpEyQIIe4db4A0A
 BQJe3E9fsmBoVnTYGE6L2iwckSseOc52pkix0FTyvycpXRqQrp1f42j2rKMEze2Qtse7D+kp+GE
 3HS/d1sDq4gpCLtSBSgIyaplPZ2vLQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-29_04,2025-09-29_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 phishscore=0 clxscore=1011 priorityscore=1501 lowpriorityscore=0
 spamscore=0 impostorscore=0 bulkscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2509270001


On 9/25/2025 8:29 AM, Dmitry Baryshkov wrote:
> On Wed, Sep 24, 2025 at 05:01:17PM -0700, Jingyi Wang wrote:
>> From: Prasad Kumpatla <prasad.kumpatla@oss.qualcomm.com>
>>
>> Add compatible for sound card on Qualcomm Kaanapali boards.
>>
>> Signed-off-by: Prasad Kumpatla <prasad.kumpatla@oss.qualcomm.com>
>> Signed-off-by: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
>> ---
>>   sound/soc/qcom/sc8280xp.c | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/sound/soc/qcom/sc8280xp.c b/sound/soc/qcom/sc8280xp.c
>> index 288ccd7f8866..e231112175d9 100644
>> --- a/sound/soc/qcom/sc8280xp.c
>> +++ b/sound/soc/qcom/sc8280xp.c
>> @@ -198,6 +198,7 @@ static const struct of_device_id snd_sc8280xp_dt_match[] = {
>>   	{.compatible = "qcom,sm8550-sndcard", "sm8550"},
>>   	{.compatible = "qcom,sm8650-sndcard", "sm8650"},
>>   	{.compatible = "qcom,sm8750-sndcard", "sm8750"},
>> +	{.compatible = "qcom,kaanapali-sndcard", "kaanapali"},
> sorting

Sure , will update in next patch.

Thanks,
Prasad

>
>>   	{}
>>   };
>>   
>>
>> -- 
>> 2.25.1
>>

