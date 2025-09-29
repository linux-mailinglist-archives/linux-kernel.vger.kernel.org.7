Return-Path: <linux-kernel+bounces-835773-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34284BA806B
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 07:52:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC23A3B5C6D
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 05:52:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB33927F163;
	Mon, 29 Sep 2025 05:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ghj5Y0Pj"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A780F34BA42
	for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 05:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759125131; cv=none; b=tb7eCYY8AO1DZdvc2MHwhuavvJ1OvoVCzHfgrDgchlLl6p3I1GT8laG1iX52ET5s23Dm9K5tPPaJpaU90hNiJoFehw2F2XO/emoJGsKqkuPYB7pBhhCEaWUbUQVrR8jEIJ9Q4l3fTogaQtjQoet8OAMy8N1+x78kBAepShZyyV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759125131; c=relaxed/simple;
	bh=XUBwfWdpgq5g7qZ2fkMwmcj0ZQ089xhmdCE536NdRcY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kTqD2sTx4uxh3h2UDwUc2VRBWkajy8ttg+k990xPyc7MGFYih9XigXugQXoJKbTA/lZGb+bUYjvmDomX3vQqZZBRgn5iFeBex9no7gT7b4OJiYXHeKPbqBOMIIrfKwdAMqYGH/LSEXWHEkez1HnkC/4wYpYu3MeeMnXdfpA+mM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ghj5Y0Pj; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58T0hTwS023819
	for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 05:52:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	bbHMiANAyI5VpOiOH9+PkDIHUQcsra2Awt7fKme/mwc=; b=ghj5Y0Pj1cimy/6o
	lQ6eq4rbR4HLdMBNyl0net2Yt2AY7sxbPz2VHq8cW8q69RCfGpjQhvxUF4gsixwz
	+1KuX2A2bvoLV64HDRQPoqosSUWTsYFmlat3pftJUuKSyQ8V/CWf7IrL1A7rnvYH
	iAyvrQfpxx06f4DV526JkMWcpSXKHRmE/HhDgc+EKNwhOzD4j+B6Ts1Tht249uTZ
	hHWQOwbJxR5GSBZ5pCDOoCOlJyr8cP1URwu56wJXdf0en2b/CVSdLRzTdZqfiluu
	jxT1Bk8YW5QItweIk69i7iTO//WgapYlh8KCyFyJ2tsQyz7LVOOS6w9qjUNxbCMb
	4JxDqg==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49e93hbt66-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 05:52:08 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-782063922ceso1257800b3a.0
        for <linux-kernel@vger.kernel.org>; Sun, 28 Sep 2025 22:52:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759125128; x=1759729928;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bbHMiANAyI5VpOiOH9+PkDIHUQcsra2Awt7fKme/mwc=;
        b=P6Xi6W+u15MMUGtT1tNltMY+AL7oPhGQ4gxbNENHqF2DNYHvxtjlmCpZhsipL3z+m6
         TIDB96gFTEgYlr8B0qFraIfDgLZwvyeqvA2CV4zYVvx9eFoDGv4vO3nFVD4veCX0RAOI
         JZxxUVLNUl8psVUb08mqmGKc8Jf+/KX3ZwjQC2/h5aSed27y2flEwU03XsGqPg7celz/
         VoiTf59eq/4L1JBiooca0C1q54PNEHB1IlWodI6DpZTlm/wfwK84OzuRQiV0DsLd3Uda
         3YeCkGwfhMkqXvr/zsw5zqPmw/xj93oqLXqpGvP+T6JMIsHxWgsmu27dKCA1sEIzCiXc
         j9Hg==
X-Forwarded-Encrypted: i=1; AJvYcCXioxLr7nzwZ7WcRrjVINF6R4ryLfc46sltb3PeZ/q9a8mcreyZMCwgYgowxS+p2DjlJvadlkjoiva9r7I=@vger.kernel.org
X-Gm-Message-State: AOJu0YzsHZhoGBSpwYBZ83joZMYOdnzTqZfGkb2jFTtky/W1nQxKTiF3
	O8YJpsgvLs/l3W3KIHmfdRmLe08FG8638gj/YRBrfZJH3OU66x8JnT5nLivXXJFAyABGwe4t35t
	bJF/v32PlYIPQBt3lc/4TJ+C7mKGU7DPD3JSzxYWJIaZPK+AIshUmSLuY3urBvfBPO8E=
X-Gm-Gg: ASbGncvQnLiIn2704ED2U6rhccX8CerFZ5wErOIDMCNiywB2LLbnS5pP2io+aaPQrEX
	wRG4IVnXBQffojlTpb3D9j+1LNSegHtYJYRGYN9uCBO/GRJiBPnTlJjqT3U9IQNi7i0knG0O2R8
	Ti+A1Ve2iE1hLYnWtdDxmxE0vu1k+Svrl6QXRdmZ8wrkceIirjJO8y7+yO+mkSuUqe6kkmv50Im
	7D9HAp3wODdnS1Mp3zyufcssMxWXW5WmAdJ6iWs7yQVi676Zhovc8XQOSdHn5S+V51pJUsbjgPD
	7NEHyb9D5FFYDLftqrqPTaUZa/VglJJeqPB0GsVV9FjdlUdPyETxPP5/Pt0bkFCf9x9twSJU5Mm
	uOMY=
X-Received: by 2002:a05:6a00:3915:b0:770:fd32:f365 with SMTP id d2e1a72fcca58-780fceba320mr15850343b3a.25.1759125127947;
        Sun, 28 Sep 2025 22:52:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF8QHbacnDb03pS+a1cSXE1NrmZSWsLadYC2GBzyt68+4gmxErOu5O3Q9uGrkNveCF4qF3Z6A==
X-Received: by 2002:a05:6a00:3915:b0:770:fd32:f365 with SMTP id d2e1a72fcca58-780fceba320mr15850309b3a.25.1759125127505;
        Sun, 28 Sep 2025 22:52:07 -0700 (PDT)
Received: from [10.92.183.157] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-781023c2b29sm10258850b3a.36.2025.09.28.22.52.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 28 Sep 2025 22:52:07 -0700 (PDT)
Message-ID: <d77e580a-8d55-49ba-82b5-a1d868dab572@oss.qualcomm.com>
Date: Mon, 29 Sep 2025 11:22:01 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] ASoC: codecs: lpass-macro: Add support for channel map
 mixer control
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Srinivas Kandagatla <srini@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: linux-sound@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@oss.qualcomm.com,
        prasad.kumpatla@oss.qualcomm.com
References: <20250902062300.212021-1-mohammad.rafi.shaik@oss.qualcomm.com>
 <708dc6e4-1566-4c72-9f3a-a34f935ac247@oss.qualcomm.com>
Content-Language: en-US
From: Mohammad Rafi Shaik <mohammad.rafi.shaik@oss.qualcomm.com>
In-Reply-To: <708dc6e4-1566-4c72-9f3a-a34f935ac247@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI3MDA0MSBTYWx0ZWRfX+yaq5M73ZV8U
 xURjQSfugrWdcvCEDBb/oMtb7/7SYoDnR0U9ZIGLR2uKJ/MPLbfTGfOHD2pRqNNAP3AwtwnbLsk
 H1dHkj3aZhztXQo43mVcKvMcbmyA5untlqjNXgc0IHFL0xkNcWruWsp1D+SzOLzw+jfziTE++gV
 uYrb57GYtf9rtOZ6tOUSizYJqHwhqXSsZ1O6u51RdsN0X6bPw2EGlLDtb8nA5Muxe3wWF2wn3UU
 7ejJFZO5Yi/eUMrmvyL8+NIAp1aK8cVE0qBWF8xUynPtw5LoR12T+qK6l3lwsYnuTfXCHbvSIOk
 svE2aY9ef5kKYUDezCEclGgEtFk2x3xQP11DCof1ytbM9wjSGruAGD7AqPZDHPjwCNPrrC6vKXb
 6qHUkzwMb5GnAGvBKrOXktcCthVhjQ==
X-Proofpoint-GUID: zZIwO4JkQdw2v87VEHri5kgU07S2MkFk
X-Proofpoint-ORIG-GUID: zZIwO4JkQdw2v87VEHri5kgU07S2MkFk
X-Authority-Analysis: v=2.4 cv=Rfydyltv c=1 sm=1 tr=0 ts=68da1e88 cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=o-7Fb8226cIMJVCjAR8A:9
 a=QEXdDO2ut3YA:10 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-29_02,2025-09-26_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 bulkscore=0 adultscore=0 lowpriorityscore=0
 impostorscore=0 clxscore=1015 malwarescore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2509270041



On 9/2/2025 6:28 PM, Konrad Dybcio wrote:
> On 9/2/25 8:23 AM, Mohammad Rafi Shaik wrote:
>> Introduce the channel map mixer control support for LPASS macro
>> codec Digital Audio Interfaces (DAIs). The channel map mixer controls
>> are required by APPS to configure usecase-specific audio routing and
>> channel mapping.
>>
>> Signed-off-by: Mohammad Rafi Shaik <mohammad.rafi.shaik@oss.qualcomm.com>
>> ---
> 
> [...]
> 
>> +int lpass_macro_add_chmap_ctls(struct snd_soc_pcm_runtime *rtd,
>> +			       struct snd_soc_dai *dai, int dir)
>> +{
>> +	struct snd_pcm_chmap *info;
>> +	int ret;
>> +
>> +	info = kzalloc(sizeof(*info), GFP_KERNEL);
>> +	if (!info)
>> +		return -ENOMEM;
>> +
>> +	ret =  snd_pcm_add_chmap_ctls(rtd->pcm, dir, NULL,
> 
> double space after '='
> 
Ack,

Sure will update in next version.

some how extra space error/warning is not seeing while checkpatch.pl test.

Thanks & Regards,
Rafi.

> Konrad


