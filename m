Return-Path: <linux-kernel+bounces-757484-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 28D36B1C2AE
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 11:02:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1751418C10A1
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 09:02:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A7932E370A;
	Wed,  6 Aug 2025 09:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="LmWZchVg"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19B572192FA
	for <linux-kernel@vger.kernel.org>; Wed,  6 Aug 2025 09:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754470888; cv=none; b=XPIlrnybcTiOvaXYs90V5AQp6NGiqdK6+12ZCHJGs6zV+BoITidVtevjFnLKhLY5H0L4QtSzAQDHjUUK8ofX8CWdESB8cR7CksCX/+CxsGNwocJxK6Qo0F9btAQzpQhKTlRmU69YO5hvUQnh93+HRC2vREjShEanIWkDnDYnbu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754470888; c=relaxed/simple;
	bh=eXeFflPzyYElNM7RCdEcYbzkvkU93X8aeiBdOj0Htg8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dZkU+0ttVmAHdfrLJVTXoupffbKAOcNKIuRFNs2F4vJkHQounkNHuVaeOrfc9kRSZWgeAcg6JSwWa8D7mEl4dti27gVrugB0sBvrLB8JmI3HnqpCEWfl76CnnvNsdOckMN5VIgHBFdg20q7jzzKsf3b9Cj/j8QdpL3+JegDBWtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=LmWZchVg; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5761f99C013564
	for <linux-kernel@vger.kernel.org>; Wed, 6 Aug 2025 09:01:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	6D+xwxfaNPC764NxYBxFtb97mFQ1jkjyZhyg4hVCh4U=; b=LmWZchVg8NuIE4jQ
	rM42U7p52Jc28Jo3fLE3S84DQLS8UD3F/D06WIwMjPM69EXfsNbaNlGjI+uB0ugk
	MOWJPyZpWL7YEVLSoeF+6e0/CchKFvX7n8IpWij3pYFuignp0xwgJc4iMGzOcWa4
	hVazFSaNR9dT06CaZAaN9lz3odHtq/Aa27D+M49rn83mS0PA77pSqn7qI0MaIFgT
	hbauKmydFUSt70hbO98EsPp6S1Iwo04geC8KitENwE4xLkefnSA2M6nIGK4rBSP0
	mKzOJe1qgw2vfl/c6YgOf4RWNZfagMd6XqPVpdIywTH7LI2Ec5SmMsLqTNpiZvZn
	1FGS0A==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48bpw2t5y7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 06 Aug 2025 09:01:14 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-70941c8a17aso9675126d6.3
        for <linux-kernel@vger.kernel.org>; Wed, 06 Aug 2025 02:01:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754470873; x=1755075673;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6D+xwxfaNPC764NxYBxFtb97mFQ1jkjyZhyg4hVCh4U=;
        b=M/0mtusriG/+TijL/FoNt+lLaY1wPeLubXOkvnF06bm7R1031SBPA6CMvplLw22/NX
         03VUhUS7Qh03Lv9Wk79WT1pr4rBinm0tMD61wMZKS21WrhayiR7lttTvlwrCVQQsCxAB
         NocuDVTXwyJF3V7L9jL6S9e91I7wxKKPv4oHabTdUal1UT3IpZ8eT9cfrlrwWd107abJ
         vQ0OM/gdOOP5GO1wz/i4XgxAux5f9V5fsTXo5bqCQQ8LpN7iPxypsTRiopKTFghIcmk1
         5hUgOMD2hWc5u0jsvzguS9eLN6lANL9YHOVIR+59dX4ueg8/5bUR/HoSluXp7tJBD/09
         3JFg==
X-Forwarded-Encrypted: i=1; AJvYcCXOt/LzxkIc3j5QlKZQFtPimIZC5xzxnRBEcWFblHUkEOqhInjia3BjYuFiK/K0qF2+6zVNUqPmB73qg10=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTUNPQCguFjiS5NuOD4ZK0JeeECETrlu3v20SQMRSdpVW/jgCW
	et8rHTGDoatMTT+jE9F2R+DQBytv4Xxlb6ETt+Ml/FP4oWhEhdgHGVmgnvmPGG1t9C4Q78u8j0x
	ZTr/DaDmdiIEDf04Pw3eBx7jRAXo1PmrnnTv/a75krmVSaufPjzVk9mljPORhLWVI/Nw=
X-Gm-Gg: ASbGncu2+HAZY/PXFhv+7FL5NIbEHG86rjzEIBsyNaqJLGtlNQtntmQ7reE3aI0Nlks
	uFF5OuSStGuGDy5i+HkJz+PQhW4G0QrBrbiPm61HntGnY1vqnyaGJ0DcScgYld5Yz6eFzCWGXlQ
	twAugolo1moEyi32N3QOyUUBGQn8kF1HUKm9CWzVSxD1/eHAYkA78xUC+2XeJYbuZ6bdQF4NmsB
	U4x+3AR+rWmPf9pgDsCyWcIQKqusmSdSlERdNhW5C6/jyv7UEYp+LvtYWZJImUS5IGYkTuFg+je
	EQUgf/3+qzoFPmkkMA73iSFQ9XlJbMlzuGga0ftEDFZKY+OEqqJVvYt188cbSuvN/8mhU+3jPVL
	OyLmXZ0OkK/FH4MFIVg==
X-Received: by 2002:ac8:5d08:0:b0:4ab:701c:aa54 with SMTP id d75a77b69052e-4b0913f27a6mr15927931cf.4.1754470872835;
        Wed, 06 Aug 2025 02:01:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFQfhvBz/y7VBf77xH41t0vN0JNTEXgDYwxJcvoC4l/blB8yRe/xKAvpfQqePz0oZyARObcPw==
X-Received: by 2002:ac8:5d08:0:b0:4ab:701c:aa54 with SMTP id d75a77b69052e-4b0913f27a6mr15927561cf.4.1754470872234;
        Wed, 06 Aug 2025 02:01:12 -0700 (PDT)
Received: from [192.168.43.16] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af91a078cbasm1067576766b.5.2025.08.06.02.01.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Aug 2025 02:01:11 -0700 (PDT)
Message-ID: <0248afed-b82d-4555-8277-e84aacf153fd@oss.qualcomm.com>
Date: Wed, 6 Aug 2025 11:01:09 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 5/7] media: venus: core: Add qcm2290 DT compatible and
 resource data
To: Jorge Ramirez <jorge.ramirez@oss.qualcomm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: bryan.odonoghue@linaro.org, quic_dikshita@quicinc.com,
        quic_vgarodia@quicinc.com, konradybcio@kernel.org, krzk+dt@kernel.org,
        mchehab@kernel.org, conor+dt@kernel.org, andersson@kernel.org,
        linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250805064430.782201-1-jorge.ramirez@oss.qualcomm.com>
 <20250805064430.782201-6-jorge.ramirez@oss.qualcomm.com>
 <4chbcvub4scnv4jxjaagbswl74tz4ygovn3vhktfodakysbgy3@kukktkwd2zsr>
 <aJHgh8mon9auOHzi@trex> <aJHqpiqvulGY2BYH@trex>
 <to2hrxml3um6iep4fcxhkq7pbibuimfnv4kfwqzlwdkh4osk5f@orjzbuawwgko>
 <aJMMhIqNupwPjCN+@trex>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <aJMMhIqNupwPjCN+@trex>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=Vbz3PEp9 c=1 sm=1 tr=0 ts=689319da cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8
 a=COk6AnOGAAAA:8 a=JpaEw4Cn0_AnavUb80UA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=pJ04lnu7RYOZP9TFuWaZ:22 a=cvBusfyB2V15izCimMoJ:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: _B5v6Q5GGqZqNrrYjX-cVYdQRzwmkMZp
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA2MDAwOCBTYWx0ZWRfX2FHJKktip3cZ
 FF5BUb1vMATnjKrO3pivxD0jRuEqLmoQE6OHLTMYa82uAVwzFptzk4CAzgE2fCwIb+5pZt2lOHe
 8xZfj7rVKgtOtnmEo2ibJQmNzBjxxAMIAfhgu7DP6J8HBIJrKuwgXFOC61wVljW38NjujP2f+FG
 6QT1gEyC54Mjsn8K56m72rXQ4dc36dN0XsezQTSecQvbY06IHfKpfMMFB1f0Cr4YXRvDjuNoskm
 ApWsLSfv9+T/HBQC5VHWKWdTpRn7ffqqydjBo+F9CioIn05mk86fmqm7WdyFXeuTVb38qfLM5Pl
 MDWvhaw05iyrjeSyXKH9+o+1gPCNhYTfQbqvEVeMyn9oZ5pVdYklgnCuJjR3XobHzHK+NgAD5Gx
 e6nhjJJ5
X-Proofpoint-GUID: _B5v6Q5GGqZqNrrYjX-cVYdQRzwmkMZp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-06_02,2025-08-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 adultscore=0 suspectscore=0 bulkscore=0
 phishscore=0 priorityscore=1501 spamscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508060008

On 8/6/25 10:04 AM, Jorge Ramirez wrote:
> On 06/08/25 04:37:05, Dmitry Baryshkov wrote:
>> On Tue, Aug 05, 2025 at 01:27:34PM +0200, Jorge Ramirez wrote:
>>> On 05/08/25 12:44:23, Jorge Ramirez wrote:
>>>> On 05/08/25 13:04:50, Dmitry Baryshkov wrote:
>>>>> On Tue, Aug 05, 2025 at 08:44:28AM +0200, Jorge Ramirez-Ortiz wrote:
>>>>>> Add a qcm2290 compatible binding to the Cenus core.
>>>>>>
>>>>>> The maximum concurrency is video decode at 1920x1080 (FullHD) with video
>>>>>> encode at 1280x720 (HD).
>>>>>>
>>>>>> The driver is not available to firmware versions below 6.0.55 due to an
>>>>>> internal requirement for secure buffers.
>>>>>>
>>>>>> The bandwidth tables incorporate a conservative safety margin to ensure
>>>>>> stability under peak DDR and interconnect load conditions.
>>>>>>
>>>>>> Co-developed-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
>>>>>> Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
>>>>>> Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>
>>>>>> Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
>>>>>> Reviewed-by: Dikshita Agarwal <quic_dikshita@quicinc.com>
>>>>>> ---
>>>>>>  drivers/media/platform/qcom/venus/core.c | 50 ++++++++++++++++++++++++
>>>>>>  1 file changed, 50 insertions(+)
>>>>>>
>>>>>> diff --git a/drivers/media/platform/qcom/venus/core.c b/drivers/media/platform/qcom/venus/core.c
>>>>>> index adc38fbc9d79..753a16f53622 100644
>>>>>> --- a/drivers/media/platform/qcom/venus/core.c
>>>>>> +++ b/drivers/media/platform/qcom/venus/core.c
>>>>>> @@ -1070,6 +1070,55 @@ static const struct venus_resources sc7280_res = {
>>>>>>  	.enc_nodename = "video-encoder",
>>>>>>  };
>>>>>>  
>>>>>> +static const struct bw_tbl qcm2290_bw_table_dec[] = {
>>>>>> +	{ 352800, 597000, 0, 746000, 0 }, /* 1080p@30 + 720p@30 */
>>>>>> +	{ 244800, 413000, 0, 516000, 0 }, /* 1080p@30 */
>>>>>> +	{ 216000, 364000, 0, 454000, 0 }, /* 720p@60  */
>>>>>> +	{ 108000, 182000, 0, 227000, 0 }, /* 720p@30  */
>>>>>> +};
>>>>>> +
>>>>>> +static const struct bw_tbl qcm2290_bw_table_enc[] = {
>>>>>> +	{ 352800, 396000, 0, 0, 0 }, /* 1080p@30 + 720p@30 */
>>>>>> +	{ 244800, 275000, 0, 0, 0 }, /* 1080p@30 */
>>>>>> +	{ 216000, 242000, 0, 0, 0 }, /* 720p@60  */
>>>>>> +	{ 108000, 121000, 0, 0, 0 }, /* 720p@30  */
>>>>>> +};
>>>>>> +
>>>>>> +static const struct firmware_version min_fw = {
>>>>>> +	.major = 6, .minor = 0, .rev = 55,
>>>>>> +};
>>>>>
>>>>> This will make venus driver error out with the firmware which is
>>>>> available in Debian trixie (and possibly other distributions). If I
>>>>> remember correctly, the driver can work with that firmware with the
>>>>> limited functionality. Can we please support that instead of erroring
>>>>> out completely?
>>>>
>>>> yes, in V7 I did implement this functionality plus a fix for EOS
>>>> handling (broken in pre 6.0.55 firmwares).
>>>
>>> just re-reading your note, in case this was not clear, the _current_
>>> driver upstream will never work with the current firmware if that is
>>> what you were thinking (it would need v7 of this series to enable video
>>> decoding).
>>
>> I'd really prefer if we could support firmware that is present in Debian
>> trixie and that has been upstreamed more than a year ago.
> 
> 
> I share your view — which is why I put the effort into v7 — but I also
> understand that maintaining the extra code and EOS workaround for
> decoding needs to be justifiable. So I chose to align with the
> maintainers' perspective on this and removed it on v8 (partially also
> because I wanted to unblock the current EOS discussion).

+$0.05

I thought we were going to eventually relax/drop the fw requirement
when the driver learns some new cool tricks, but are we now straying
away from that? (particularly thinking about the EOS part)

Konrad

