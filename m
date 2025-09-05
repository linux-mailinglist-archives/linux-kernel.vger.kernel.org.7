Return-Path: <linux-kernel+bounces-802657-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E751B4553E
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 12:48:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7BA915C118D
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 10:47:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C31D2E2F08;
	Fri,  5 Sep 2025 10:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="b/GXWPnn"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 149F130F946
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 10:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757069199; cv=none; b=HeYCUg/N4bwpCHHKRAi4g4QfNKL57imODj5T4ISY9VLZQESJTHSPw28RVO+Va/7MdACTUTdGN+7pxmuDeKb+oNhLTh23LbeLzkiKIKLLumDa0/xa98xbc7zBwUDZ9WlbDvBvKoK1Z6rgEOkKIhDiwAHCs4lsJvrCCC1HM1b5TrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757069199; c=relaxed/simple;
	bh=I6p/yTUh+A8pt4l7LAMv/W4PT4a6ow9nByy4vuG00yw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=O8Rgv64QpBs8y/fjcipzTVJU8ooefjpSxUT7NFkhIjWPeh6u8od51RKmcaQVnUfkML8NtFDnY7UAYXkgKqTI4FMab8xMSdDWwsUUvgl7crLon8UTqlVl2yDIBdvRP7/94nLF3dQU7VvIMYt5Lr/GvA6bX1IK4tE/KZ+ovWpeEKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=b/GXWPnn; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5856pBa5013645
	for <linux-kernel@vger.kernel.org>; Fri, 5 Sep 2025 10:46:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	eNfKE5usjc1AEQtJ4ORFpDrJWu8KVDm4Y0laoBTlgb4=; b=b/GXWPnn6rdIS+ff
	4RS0hdb3r6CKWOuE2ASRJYXEXjln9K4Y9ukHuSsDJt4Op46o63pQbuPwaaittgl8
	eIMr1Ng2lKPpVQ9WR1FRlUDTy9UFh5KNazS6mDBwizQEi7mSQT6jRVCLGYzWk1RK
	chbAZzREu3Lfd1MOe/4CQ5UCVeFsFbSotRuDN6BECbPTlNVStY6bImaVZ7rgQn0a
	onvbD7DbLe10Mla8/Dwf/vXsTFovF3wsWVYsQS91oG6NSXp/sWL2AcRB2fb/8B63
	hWQ8xKXDe0eEFbl6SF8pjmh0t5N3Kuwy2YNzFdtNoPnkRGyY3zM9fJvxHS/FD2w9
	moaWeQ==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48w8wyesdf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 05 Sep 2025 10:46:35 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4b10991e9c3so3485091cf.0
        for <linux-kernel@vger.kernel.org>; Fri, 05 Sep 2025 03:46:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757069195; x=1757673995;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eNfKE5usjc1AEQtJ4ORFpDrJWu8KVDm4Y0laoBTlgb4=;
        b=i9mus+Biy4hZLp/su/tXF50E3INl3kl4/GyFIdJC7Sp5omfYl8Kzp8+tTATaN2sjSQ
         DFpX4uj12Sc/JLO7dm9WndWiL8NIG6N7vEF+3c28R8cigI74+PBBGnUxg4khmL2wVqh9
         ZAeNPNVRnG4Ekl9A+Dw8ZSWeTfiUFt9HnfWEfZoDKcFXHEtpQuzJblXKbJ/fGvvcZU0k
         vb4jND5Pz97jDoAF2uCu+pHkBmLraKuC/cJzt0ZF4Ma+goZQoG35aPR6GaAQkvIqRpKU
         +pYdcm44n8EKHwnj+Ljd/I97XADS4NxIafoWaS9ce/mz0bhakbg8gZybkTeHtyJ+TRxf
         HyDw==
X-Forwarded-Encrypted: i=1; AJvYcCX2h8EIfea8FUYYfnf0hMP1VUNqJuwSTXS1GM84P7UMlDDIHXvP62HatFxbijf04sOwGsT5q92ti04WVW4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNAAA8UeOTGkqonx5HWOOZvKMb4J0TVuGuIOiIFN9eDrKSLXQz
	TDovsYDjNcHlRBRTpezSXyoIFtKsNl8t0xIXW0ZGKz3xqLbUFEODFhcELugWOExB8NY5ChTV+qg
	2pPS8miKoldKlXhOTLljjyrfKOG/YmExtJJzRO62PSKdd00uYKr6HA/VkKe6nNhz4Tls=
X-Gm-Gg: ASbGncsHHTUknybEQPzzYcCv5wVZo8JrBJ9OG628VaTThgdK7iRFMHzM5tBw1UOsnZz
	+GnoTOM2oMFa/flmmhrzFS4AtgXKHkvWzlQlRkOp69d8k4RlFOpBHvCdbaq40Z0wQ45r11m6LCh
	aCyoZG5jqGmakJxjy9nVsSxQZzmtvqIXYYQ9+dKX78j34poeTGhJoA3No3iL7EWdXYemoNyVFW5
	vqX+lx1SuUvtG4XNactgjE14V0SmfNHMSWmRTpIaRnsxDBI4eXwaWbWOGiWmmxsJgn/yf/rBdJp
	ElD0VlCvTxareJr/lr/9zAKS5OAVrkyBi9dOiOAQcVvH1K2HjVVcGNDIHmO491tZxYHnSeMnyGi
	BgUBorJ74CU4Z1SEq+8CPcg==
X-Received: by 2002:ac8:5ac3:0:b0:4b5:e391:e3e0 with SMTP id d75a77b69052e-4b5e391eb76mr31070131cf.0.1757069194939;
        Fri, 05 Sep 2025 03:46:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHw8Dn21yvKCjUW8kKlGcrNzT5lmLe1h8eGatVckUE6o1c8jbDA7+nCFwuH00rX+I8cOcqToA==
X-Received: by 2002:ac8:5ac3:0:b0:4b5:e391:e3e0 with SMTP id d75a77b69052e-4b5e391eb76mr31069951cf.0.1757069194370;
        Fri, 05 Sep 2025 03:46:34 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b0484e8a4a1sm340288266b.83.2025.09.05.03.46.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Sep 2025 03:46:33 -0700 (PDT)
Message-ID: <b321019f-3ff6-4c6b-8285-77ca291492a2@oss.qualcomm.com>
Date: Fri, 5 Sep 2025 12:46:31 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] ASoC: qcom: sc8280xp: Fix DAI format setting for
 MI2S interfaces
To: Mohammad Rafi Shaik <mohammad.rafi.shaik@oss.qualcomm.com>,
        Srinivas Kandagatla <srini@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>
Cc: linux-sound@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@oss.qualcomm.com,
        prasad.kumpatla@oss.qualcomm.com, ajay.nandam@oss.qualcomm.com
References: <20250905104020.2463473-1-mohammad.rafi.shaik@oss.qualcomm.com>
 <20250905104020.2463473-4-mohammad.rafi.shaik@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250905104020.2463473-4-mohammad.rafi.shaik@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=Ycq95xRf c=1 sm=1 tr=0 ts=68babf8b cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=4EjxHe3qrgCn2qlGiy0A:9
 a=QEXdDO2ut3YA:10 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-GUID: e116AbH34qMBU1kWSEy3OrKeZ1q1ywMe
X-Proofpoint-ORIG-GUID: e116AbH34qMBU1kWSEy3OrKeZ1q1ywMe
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTAxMDEwMSBTYWx0ZWRfXzZtv1j/EUjhV
 mVDAndTy3iAbXRzWC1ba857/Wp8hUv66k5VmAgBNNwoY1UJBVHjviWjZUBdkUc/93qlL2I15OXg
 EfiYOPghotHWkauSgNpvXuVIQ87N0zl/RTbAEUpGadDBwMlzO2Lt8czJIRR0t0qq30Iu12mmOxy
 mFn7DnSmukMsl2XnJA7mMXBiWAxyROmzfOaKuwQ1BuDtJsk4EqMCiJdw1KBY74sPRdMZYAEJRsz
 kbzTwAYCYqhfwnUgqYKoqAIZt6zhNbf3yyybcmRK/i65GwhDe6HBkPdxkBxdzIBBee9QOk1Xa7O
 809C+FE64RXYhM1uiQXTpdasbM2gHwX3c8zsc1MRKCPwxNYAiiI0dSYdq6Dhe5jIGCueMlHG6Nb
 Oxvh73Q6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-05_03,2025-09-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 adultscore=0 phishscore=0 malwarescore=0
 bulkscore=0 suspectscore=0 impostorscore=0 spamscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509010101

On 9/5/25 12:40 PM, Mohammad Rafi Shaik wrote:
> The current implementation does not configure the CPU DAI format for
> MI2S interfaces, resulting in -EIO errors during audio playback and
> capture. This prevents the correct clock from being enabled for the
> MI2S interface. Configure the required DAI format to enable proper
> clock settings. Tested on Lemans evk platform.
> 
> Fixes: 295aeea6646ad ("ASoC: qcom: add machine driver for sc8280xp")
> Signed-off-by: Mohammad Rafi Shaik <mohammad.rafi.shaik@oss.qualcomm.com>
> ---
>  sound/soc/qcom/sc8280xp.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/sound/soc/qcom/sc8280xp.c b/sound/soc/qcom/sc8280xp.c
> index 73f9f82c4e25..2fd06354923a 100644
> --- a/sound/soc/qcom/sc8280xp.c
> +++ b/sound/soc/qcom/sc8280xp.c
> @@ -32,6 +32,9 @@ static int sc8280xp_snd_init(struct snd_soc_pcm_runtime *rtd)
>  	int dp_pcm_id = 0;
>  
>  	switch (cpu_dai->id) {
> +	case PRIMARY_MI2S_RX...QUATERNARY_MI2S_TX:

there's a discontiguous (i.e. asking for another 'case') QUINARY MI2S

there's also a SENARY MI2S, but that we don't define upstream today

Konrad

