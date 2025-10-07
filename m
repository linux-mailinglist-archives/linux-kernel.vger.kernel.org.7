Return-Path: <linux-kernel+bounces-844099-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F127BC1008
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 12:24:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D047534DC52
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 10:24:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95AB6264609;
	Tue,  7 Oct 2025 10:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="pXLbaRZN"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BAAB28F4
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 10:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759832637; cv=none; b=Lhew6KkKfvmp8xdZCmq1c+0ayMILGfEUPmXyx5wA/6Qj2GNebxV38gTF/VIZYG4ovw8uOltcAQRd6NNCLLvvs89Cfds1Ic8ra61MEsY5g5BQZxa3liZv1oUJzNaRmGrSnBV+HYw6EwBJqB+gtfEU8PLUcPlhVyx//V5SiksmKGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759832637; c=relaxed/simple;
	bh=/Pulhqjo24SKTr9cc1ENnx7pLe+f8uR1MQfDkhduvfU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=paNzLJPZmDpZzSBeLwD/WcViKGpX44Xyy1we/ublwx+U2L8UKZ6nMnqFT6mk2l8Sj+ceYyxOr/ozxc1jF0pqQziu74v7hHh8ovYoF/wTGoRGIB8SqiCWsxHOWz+J6DEmAXUy9Fvz8Zqhwb/pW2ye820+HPtbk01HJIYSWk/kMmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=pXLbaRZN; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59732gI3017153
	for <linux-kernel@vger.kernel.org>; Tue, 7 Oct 2025 10:23:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	WkgVZee6Gf3vg+RIy3eezVROXir73E+qp+AS6AvinH0=; b=pXLbaRZN+k05dEFy
	daMWsqyxF2PdcPfdjRTE2l9yGbpOTc6lmKMnPGelsgUT5CDpjlKCHua9qEcJ8BvW
	Iquw4VlU45IOe088d7P/2DBp8KfzoDcbYUhQngK5EPIq8tubgrT4p1VMeb91dG5a
	PDJjIF1YDO1aKsPZ1iNY8Wdw4sRZ8VcGP8jp6ha0u4NCk6TtMOtTKeH59S3UcT8C
	iF8i+x3Gc9SYUUAxaPI1Gwvdx8cE3ZV/LpiEa4jn4Zzt4cx0DPKrUy8wiSL/0tFg
	plw9Z1Smn+PHWqSByQfIAkX07yYJ68A1aJY/SGgk63SBvCRjF6RljXMVczDgscX8
	QJKIAg==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49jtk6xy1y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 07 Oct 2025 10:23:55 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-85e23ce41bdso136493885a.3
        for <linux-kernel@vger.kernel.org>; Tue, 07 Oct 2025 03:23:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759832635; x=1760437435;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WkgVZee6Gf3vg+RIy3eezVROXir73E+qp+AS6AvinH0=;
        b=iEcKo9OFfiDi0FtvPr7AGIVaEvj0gL1H0OXihatVLkdjvPDZvZBE6pbKDi5Z4OLxYp
         PmJaA6dhZdSJVYnroPjcBWjRLg7Cx7OPOqg7FcsezqV52SMPxb7+fHAlnVjeJlKHHY4O
         JwBGCaf41w9NK+YHqCTOT8s4yVBRhHD7lrjL6xkI0aO4URef1tKwuppUVduXr3cDmxUR
         MfP5z0dWf5KR+GYxv8HzdD9Zla1sV9Y1lnEBn9v4quQgZ0/X9Iv0eN2Ir8h2ZOX0/G79
         4/leIAmA/lbzstHo7Z5mn5lsYZGqETdeuJKvnTxuDS61b0IVxrDQzqv6sqZb9LlgW387
         UNeQ==
X-Forwarded-Encrypted: i=1; AJvYcCXgzBwXfEZS592/Pw8w2wliNAhnJz15sJH9qjQApPV+vBtqZYjY0kHF/GRmyFGASO+VxHwAV53NaVeYz+c=@vger.kernel.org
X-Gm-Message-State: AOJu0YwV3xQlrxEv7DyZU5waI3iNGWXLbGRvHfN5Tt96TGRzH40959Oi
	sv03VfVhszA9/FwFlWFkKjlwwh0qt5Q9A6T/CuhCxWWsVYHStGH/JHnIW00ehQmc9/KaFVU51oH
	vYM0ORJjEMzEc/XXukn8PU4x//zTGI59uCIMn5JtlgrXG6lToS3YK9c//mmw5hpKQqu0=
X-Gm-Gg: ASbGncsK72P/AtJ0/kBSPx8fJ/rkzle75SjnFaQqKuXpnhAUDPdiciphhSXd3QOfUzW
	oNLhssVuF8JT/eXMSD1HwcA7ROQA2MYb9pET9FDcqjoVIOOu+6PvPoXQdEZz+Ae+kadsgrNTsGr
	NLVMSKS2mEgNTg1AqzkHAw5fJqLriFnVuvmTagl6FdebXqV/p6MYV5j3dlzXxwpvUHaj65Qum5w
	nTlizdAlw4J7OMTbhApvMQcKCJB5/0jKKYPMCpb2WwoMEBUQEx207+GsrkvuBfaQugE25u35od1
	NhSAQpj5EuOKg7yArSbqML4ZW+Z9OeQe0EJncKrPNTfM/jGfS2kz6eKQn+6kdseeeVQ9GqNX3c0
	C8/N0jsgwz/G9uKDc4jInmufUKNE=
X-Received: by 2002:a05:620a:4628:b0:856:6bcd:4adc with SMTP id af79cd13be357-87a396be2b6mr1387376385a.9.1759832634446;
        Tue, 07 Oct 2025 03:23:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGVSNzorydREG7b211hNLhPZOy+zMPqGTivdO+Qk5L9VY53/qkidtVBHb3GAFgnk0lVswCaAg==
X-Received: by 2002:a05:620a:4628:b0:856:6bcd:4adc with SMTP id af79cd13be357-87a396be2b6mr1387372185a.9.1759832633661;
        Tue, 07 Oct 2025 03:23:53 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b4ffb161d92sm75814866b.21.2025.10.07.03.23.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Oct 2025 03:23:53 -0700 (PDT)
Message-ID: <f15ea346-43f7-49bc-bd5e-47510a48892d@oss.qualcomm.com>
Date: Tue, 7 Oct 2025 12:23:50 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 3/6] ASoC: soc: qcom: sc8280xp: add support for I2S
 clocks
To: Neil Armstrong <neil.armstrong@linaro.org>,
        Srinivas Kandagatla <srini@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-sound@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20251006-topic-sm8x50-next-hdk-i2s-v1-0-184b15a87e0a@linaro.org>
 <20251006-topic-sm8x50-next-hdk-i2s-v1-3-184b15a87e0a@linaro.org>
 <6492e444-4196-4900-a741-a74a8c506a6d@kernel.org>
 <1eab5200-1292-4d39-bdf8-0c5084cfaab9@linaro.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <1eab5200-1292-4d39-bdf8-0c5084cfaab9@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA0MDAxNyBTYWx0ZWRfX7V2jD7hvPblO
 ONhkdZ/QVL5GjsV1mT0b0rpXh63kMI2sdZwv0cSh6MVns3UkU6eTcoH3JI8fkPzLTwFnwmrSFYn
 Az5l1ZhM8SBQbdujk1ghDaNv3E338BACmuAuNpHTFmiH7eHqcEXtzmRZOjUkt7t1T8Qgc6L/C6Y
 1tqBDHGqvMm/As68vKCojkWyXVri5jboEIOcNdngnN/FTtkqPgowxHFvIE1aPmUwv1nLO9+m4x7
 C1JcIan3I2jSN9SZTAqxFuSXYhs8MglVlAD/0S7Mt38/F1S0bPUqMqHlssHHWTVCic9d6VvzVAV
 cry8zyPEPeIhYUurjJnl/jZMg5St/1ZvDbpiu2Gl2w25KVZWgm8PTXXkAlt/DxRt7e93GgPEvTZ
 GgJ1dFWT0iGfCd0WAI26AoI7oEbqAQ==
X-Authority-Analysis: v=2.4 cv=do3Wylg4 c=1 sm=1 tr=0 ts=68e4ea3b cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=KKAkSRfTAAAA:8 a=GCCr0xkA3K9mKd9kojEA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: c4jvbKr_Rp98YfuK9bf-wVFemIIyRi5T
X-Proofpoint-ORIG-GUID: c4jvbKr_Rp98YfuK9bf-wVFemIIyRi5T
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-06_07,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 lowpriorityscore=0 phishscore=0 clxscore=1015
 malwarescore=0 spamscore=0 impostorscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2510040017

On 10/7/25 9:02 AM, Neil Armstrong wrote:
> On 10/7/25 00:21, Srinivas Kandagatla wrote:
>>
>>
>> On 10/6/25 7:37 PM, Neil Armstrong wrote:
>>> Add support for getting the I2S clocks used for the MI2S
>>> interfaces, and enable/disable the clocks on the PCM
>>> startup and shutdown card callbacks.
>>>
>>> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
>>> ---

[...]

>>> +static int sc8280xp_snd_startup(struct snd_pcm_substream *substream)
>>> +{
>>> +    unsigned int codec_dai_fmt = SND_SOC_DAIFMT_BC_FC | SND_SOC_DAIFMT_NB_NF | SND_SOC_DAIFMT_I2S;
>>> +    struct snd_soc_pcm_runtime *rtd = substream->private_data;
>>> +    struct sc8280xp_snd_data *pdata = snd_soc_card_get_drvdata(rtd->card);
>>> +    struct snd_soc_dai *cpu_dai = snd_soc_rtd_to_cpu(rtd, 0);
>>> +    struct snd_soc_dai *codec_dai = snd_soc_rtd_to_codec(rtd, 0);
>>> +    int index;
>>> +
>>> +    switch (cpu_dai->id) {
>>> +    case PRIMARY_MI2S_RX...QUATERNARY_MI2S_TX:
>>> +    case QUINARY_MI2S_RX...QUINARY_MI2S_TX:
>>> +        index = sc8280xp_snd_i2s_index(cpu_dai);
>>
>> What is the mclk and bitclk rate set here, we can not rely on the
>> default rate.
> 
> The default rates are set in DT:
> +        assigned-clocks = <&q6prmcc LPASS_CLK_ID_PRI_MI2S_IBIT LPASS_CLK_ATTRIBUTE_COUPLE_NO>,
> +                  <&q6prmcc LPASS_CLK_ID_MCLK_1 LPASS_CLK_ATTRIBUTE_COUPLE_NO>;
> +        assigned-clock-rates = <1536000>,
> +                       <24576000>;

Is there a way to infer these rates based on the DT audio
connection graph?

Konrad

