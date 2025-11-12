Return-Path: <linux-kernel+bounces-897827-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B9139C53AFE
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 18:29:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 46DAC345A7D
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 17:25:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C92D0346A02;
	Wed, 12 Nov 2025 17:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="IrducnoR";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="fMCytAZF"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DF9D346A01
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 17:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762968304; cv=none; b=KyEmk6NgV7DA4yKsvuy2tyO+iU7gJibZEcpxlmX7JFh8/lbgcswB64h3ew3XrHQM67wqPEo/xn95kXFiZCmQFwT25jW1buwmFwAn+uR/X4p6A9XKl5F4UO7t9qBCMEeGr4Dg6fq41H21+R/ME18nHUQGvItT1zB0H9fVKY8ZzuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762968304; c=relaxed/simple;
	bh=igQk7IJ58jSde1RxsW+nclhIn6i3+FsoP+UNSE9F6p0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MyuCbD/Q6f9kFY10lFwzf88s8mre1BMYOd7cbMo07FewFltJimaS/dvFw+BXSjVTTB+X8Bo+HMTR3lDRmYYWC5GtiBPULBN4vKCoH+HKPekF3Jtt4U4+Bqx3ikQcvzYWG4v3cCdgNbLd8Xz+jp7SFiaYNXK9AfxUOtIajbsWSTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=IrducnoR; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=fMCytAZF; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5ACE37vX1270581
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 17:25:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	/Km83Z8dJrIrAX1ZOXyhzLK/42gxeDh501oYlNSXd5M=; b=IrducnoRl/XHdZ1m
	nPOFuvT6IUNwXU6pESjJu8QQtWRqvRMmy0aLhekGsQX0SHH5xUQ7uK/tZ+0pmDGk
	AoRSC6L/KseWHCh7O9bbna7iVmY33VsE+SaZyzsEbWeQLE136pn0/U+V9mmsz3VE
	pBeknlq85Jipuznsr2thcQ17IQOX8FTLfp96fsgvyHkZkSqIf9d3JPxxmLTPUdmB
	DZGvaqwmWODxgJBAQh5pwWfskJ/0hd5dxkUnCDTT1IzV0LaSzAkmc4OIc0nErCxZ
	8+KGdc3KoPSTDbKXnwyGe0CLfSPf56Exkn4OiJuw+Deu35xs+miY+xSCoEY+7qWX
	DL6SNw==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4acunm0qhu-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 17:25:01 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4e88c912928so28456651cf.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 09:25:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762968300; x=1763573100; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/Km83Z8dJrIrAX1ZOXyhzLK/42gxeDh501oYlNSXd5M=;
        b=fMCytAZFygBwHEujR4VNE2Y07fzTcBUnlDPwT0ZHZz5wgPPtJ6smpo+NBAWUsV4m8t
         MmjlVt4FznyeW4AGPK+zsQ3q+y+Pcvwftsjc4X0svMyaUiyflN4dr5LFhUGV4fAx/rVn
         kbsaWimeedSAOpJm38v51+ZbtpBe3HhG378So1ig+qd/orA/kA4JiAKIW0rXm57fdHcO
         JZm34/ZPA8c6J4CuCRzQ4/NRFvZIQDMOMJm2PcuuUv5sohBVyGW7bbZEHy8R9dmc0nZ4
         yvKSG/rF1eMtXhCMngbe/YSG2SY1kW8/baJYD6Bbn6TP2mFXAPbB1qtXsgpeH5gfDD6G
         tdLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762968300; x=1763573100;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/Km83Z8dJrIrAX1ZOXyhzLK/42gxeDh501oYlNSXd5M=;
        b=w2RpVNF9E7hPFxdIgwf0YDpZftgy+aOcpyP8bvo+QPcJGsgpXQUKaaqfACmElIvfvt
         UCqXHOEPGRmtlkz1NgwfievMBKI7YWVYzskvbdvt8Iholvqn94eqPgIC61sYUkW31+w+
         aAh3DMzYa4sW0Y2IgXjZbtGco5eXG+9ATmfCmTZWQAN322vnpHD6UiGza8vE/w+hFlV0
         0718fYzLcrvcNteU4bapJxgnoIhszgP8PL5rtdYRSp6WLIdOKAfZVjeayDcFFrYlgeQP
         +IaxzCAB8bppxw60yGocWuf7tyBPbwVN0su43chb4bNPvthxkeLdv6fGAkzSs5ReJdRw
         +DWQ==
X-Forwarded-Encrypted: i=1; AJvYcCVVPInM7TK0VeoIZtgs5kf4KxVA/qtTXfRRLukPcBbseQp1gE4sxWoGWkXnBS0cYoPBcyk1NlL2FofVcj4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6gpxOaYTPHAckiVLYD6ZjzANEMpCus+CGcDPQ5/08AoNA+54d
	Tg/NgfnK11SFnyVEjbfZ1nKhJjvdJbpuCOYDpYdRcREgNEqAN5YXEsexiQSG5NJmOiBLp6Rr3b9
	ZJtlg0BOCMJ9jAJKvtFf65PRus3A7Q+rsE6aSPFR3DHZq+idU3QMj7RSt17F3bmOhVRmArDjinB
	w=
X-Gm-Gg: ASbGncsDPXwt7uucUqmRI1UNKGEQRJyWnmd4+NV00mU6BNJEdy+XkNgofQqQ7dmiFDF
	1ezyRQvIOLnJryKZp5Pxa6cTAuyBMJKePZ6+SyxJ2xwCetkGeviQAKa3C6fUPf261rCbAg/l43L
	T2xoBEE7qNAELkjwnU4agD5hwBye40lMv2gHLRdJHkcCnQ7WmxT6H8/68zHhJ9EsLp33ONhayAu
	jUtMXDMZiH8BsRZCUnU6KS2ZBmVuRrmEdVr5WXGVhVUBisJdc40kBlecMTvJo6GV3kVVsW60f3O
	ygG2pB2jwZh5E6/V4HEcliPjRmCPGdx8uVnFZ0t0BuCPTaM0T6csCaDFqcgWRyCj9QmAGV3nEfF
	+/eAwR2aECIKpOLzkqpAnvavlIg==
X-Received: by 2002:a05:622a:28a:b0:4ed:213c:1582 with SMTP id d75a77b69052e-4eddbc4df56mr45383541cf.7.1762968300169;
        Wed, 12 Nov 2025 09:25:00 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE/HxFt1aiBzX4O5TfxsQW2cuwzf8525wYzeQqUTuGj+dwhgfdPm+309s2XwH34HG9G30yWJA==
X-Received: by 2002:a05:622a:28a:b0:4ed:213c:1582 with SMTP id d75a77b69052e-4eddbc4df56mr45383201cf.7.1762968299645;
        Wed, 12 Nov 2025 09:24:59 -0800 (PST)
Received: from [192.168.68.121] ([5.133.47.210])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-4778bcfa2e9sm798635e9.12.2025.11.12.09.24.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Nov 2025 09:24:59 -0800 (PST)
Message-ID: <db5dca8a-d5ef-4182-9ccf-52b2bb56a2d1@oss.qualcomm.com>
Date: Wed, 12 Nov 2025 17:24:57 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 06/12] ASoC: codecs: add wsa881x-i2c amplifier codec
 driver
To: Alexey Klimov <alexey.klimov@linaro.org>,
        Srinivas Kandagatla <srini@kernel.org>,
        Mark Brown <broonie@kernel.org>, linux-sound@vger.kernel.org
Cc: Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org
References: <20250522-rb2_audio_v3-v3-0-9eeb08cab9dc@linaro.org>
 <20250522-rb2_audio_v3-v3-6-9eeb08cab9dc@linaro.org>
 <1c7d62f5-1816-4ecf-9376-2751ec06830b@gmail.com>
 <DE6VXJQPNX0Z.1LE0XW9T5T1LR@linaro.org>
Content-Language: en-US
From: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
In-Reply-To: <DE6VXJQPNX0Z.1LE0XW9T5T1LR@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEyMDE0MCBTYWx0ZWRfX6xxn+viOkHKx
 gW0frfwFBC05do/j/Vniu4+QuuPWnpSJIidMdP8/GNZDBx+JTkGk3Qx+fWb9l5CXIsHtKO5sFCD
 p6/tHcp9SRvoffSdm5E5aTH7w85TxaTVVV032GjtysiwYQelCiQwALpydrdV2e8z4rnqyJDdPZJ
 9vxqTLDodqFk+JEGO/6uBeY4O400Z83krMcISjUe2FQGzPT9dHezvG0H7LXbcYoO3MMRM6sZRAZ
 deIPTV1Dubb3jDy2BrOIrH+FTwfZ4gNojrl77rcU9ul/IMDx21kxTkffmZFapUZFBOP01AROG9J
 fYwNwkhLX7AllxJVJ/rZTRkzutbWzfC9S+DzbSahI/MbTR0NGmblIhchWt0gQpuvdU7WW6xObc9
 2jF4WpXk+dHAursMTQMt0YlwZa5G/w==
X-Authority-Analysis: v=2.4 cv=aLv9aL9m c=1 sm=1 tr=0 ts=6914c2ed cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=ZsC4DHZuhs/kKio7QBcDoQ==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=8-6JEL_qhUNu0U2AKIkA:9 a=QEXdDO2ut3YA:10
 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-ORIG-GUID: cKVU35lAFN3XGvKoBt0FRUlwuuunuFaK
X-Proofpoint-GUID: cKVU35lAFN3XGvKoBt0FRUlwuuunuFaK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-12_05,2025-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1015 adultscore=0 bulkscore=0 impostorscore=0
 malwarescore=0 spamscore=0 priorityscore=1501 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511120140



On 11/12/25 5:16 PM, Alexey Klimov wrote:
> Hello Srini,
> 
> On Thu May 29, 2025 at 11:05 AM BST, Srinivas Kandagatla wrote:
>>
>> On 5/22/25 6:40 PM, Alexey Klimov wrote:
>>> Add support to analog mode of WSA8810/WSA8815 Class-D Smart Speaker
>>> family of amplifiers. Such amplifiers are primarily interfaced with
>>> SoundWire but they also support analog mode which is configurable by
>>> setting one of the pins to high/low. In such case the WSA881X amplifier
>>> is configurable only using i2c.
>>>
>>> To have stereo two WSA881X amplifiers are required but mono
>>> configurations are also possible.
> 
> [...]
> 
>>> --- /dev/null
>>> +++ b/sound/soc/codecs/wsa881x-i2c.c
> 
> [..]
> 
>>> +struct reg_default wsa881x_ana_reg_defaults[] = {
>>
>> This does not make sense.
>>
>> All the regmaps should be same, it should not change with the change in
>> interface from SWD to I2C.
>>
>> Could you calrify this before we start reviewing rest of the driver.
> 
> It was sent initially in nov 2024 I guess and that one was v3. v2 was
> sent in December 2024.
> 
> I am currently reimplementing this. I obviously agree that registers
> are the same but why we should be 100% sure that regs defaults
> should be the same if the mode is different?
> 
Am not sure why the hw reset codec register defaults would be different
for each interface.
There might be some additional interface block registers which could be
missing in the original list, but the codec registers should be same.

> Or do you suggest/expect that, for instance, analog defaults should be
> kinds applied on top of common (swd) default values?

Codec + interface specific
is what i was thinking of.

--srini

> 
> 
> [....]
> (The rest of original email was sent and quoted but I did not
> see any comments there, so I removed it but if I missed smth there
> please let me know)
> 
> Thanks,
> Alexey
> 


