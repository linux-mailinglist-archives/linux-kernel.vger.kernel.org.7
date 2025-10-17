Return-Path: <linux-kernel+bounces-857557-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 43007BE7213
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 10:20:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D37883A5D56
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 08:20:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACE54280A5B;
	Fri, 17 Oct 2025 08:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="p7UqfOQs"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9688227E07E
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 08:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760689250; cv=none; b=QGHR5sb1CmJ8XZcdU2YjkmDb76qn9CazDeiycqguUzwUNmUVm4zydBzSr0D2t+44/G5YwHLkO3t/c9zzw2Jlbs7Q/p85Epsmz3et9pgFXlFGnh6m1Q2GoMwKDsBe2nUDqZP0pBzBQhYWkQcJnclCbC/HNhUVmoJkLT5lFAuarWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760689250; c=relaxed/simple;
	bh=W1ab4XP/vKfyLvPZCWVMMkItYSbT3sjdMDhJbsFCZE0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Kb3Ucqq8+cLJ7EKUMJpqutGPL7dIcJ3OUhIzvof7SaSuOEX/iKIbnhK6kMx3W8Tf23NZ3h04xJsSGc4i5fwPzwGZ7vmKJp7Jh8/OIeSliJF2m4jNESv+D9H8wmfgtAYZrr0hb2scegYJi5qKFHs36lyEf/Fi+8YXt6db7Et3xoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=p7UqfOQs; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59H7qstA028686
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 08:20:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	W1ab4XP/vKfyLvPZCWVMMkItYSbT3sjdMDhJbsFCZE0=; b=p7UqfOQs7akhcvBl
	LZjWMZG8me13GguhAmhrzowv7BTnRO7C4Mg38uUJES/mgcSG6rI+UFUbXG5h92RG
	3p4TDFgwhtxmgcRS56oiaZBx+cPzwhPmX7RGDZrHWrMHBlDysQRkt57t91QWRNK9
	gRC3j4mCRUaluffuYpZJJ3LmjK7O4FWnJyasz6SKtiEzmkG2CFH1nZnT/gwelEJq
	Roo/IOipfELf0LUnIcZNYXTVEY++z+ZQ8SGK1dADFTAgPJJCgBo9mKRZH+J9JwnR
	Ch9gLX53SropsZ9IS45NT4RGD4e2XElNfxSsm9CqaR/aZn+g1Cy4snJc4PHSX3ZQ
	1eMIGA==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49u1h0u3sr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 08:20:47 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-88f3a065311so51238585a.0
        for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 01:20:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760689246; x=1761294046;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=W1ab4XP/vKfyLvPZCWVMMkItYSbT3sjdMDhJbsFCZE0=;
        b=V/QGHfTbjS7FoqV8rFet+FLBJku8hcdHj4vei0NUGgxO/Kxadc4mLCyC3f0RWXd2gy
         Tg6m6u4lcjUE2kAqErcuM26QM8qjb2hy3cZs2gg47ANI4BSsGe7BshSO30g5bVQ4XDlj
         UoKMxkO/pggvmv5pH4m4T0RC2IG+7MHJTaRMSjQGLq6sUgTEIOYkSYp8zFkM7m/kg0pv
         KD4CCF99vtTjBeU9hSFLCZzwKMe3Q6G5ikBjEN5s2abyrQU7VsNP6lDDXGhB8GzcZiiG
         h8N+khxgvCWAFRw3eaX16pdrEgr62ZOHQsuq6ztsFFmqNg4pmBVlH30NEVtThEJmPGgH
         iWAg==
X-Forwarded-Encrypted: i=1; AJvYcCVMwSbboIQK5XvXxEmfHXMGdBInApDxwCuimrw+iQwuL1lp7OFQry3MedAdEKnBmW/8knaks4YfqtCzOfo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCirpY1e6zA5Yk24Ew05MsgWCEvEtmMXCRXVQz/f3/n+wcMrfc
	RLCcGOcqHXH28leJZHnlIaSpwbYfwhg3uHmKv1DyNxrs0tu8LwM4KsC/AI3bKO95+QKd5+eniaO
	IeMmsJthjWPxO/g5/7P5XAhxzuUMwiinWoziPFN5yctM7caZI6YmgM1Z7FkPbN0CHq9M=
X-Gm-Gg: ASbGncsEo5xgz/zYaszd2IYZwzZi/jejfjkpJjxM48lIDG9bdq2DbnA65BLc2Upo7D3
	Oo2DkJkfo8FFd7jbiCAYNXYq+jVHtNJ5K8Cg2RESH84DHL1a+fCojdm7xvaeTXsVKJTT9LLkKtg
	cevGyv9YBtkz8+s1K+zgztDtfFzbFIRfLI8tmmimZGEFeR0rdoeh6paLFyWVF9q6ysBQRJ9W/my
	Wn/S9lZejnucT0IaGxDkQyVK1KH1iLM+gj1OMlmW0aQvWrRP5kaFpoRZiGSUJLL+HZc+aeGu58X
	oB95e1QcEPTIbfYPWbJmvwYmJlm4LX3Xz2IIbXgp4g5PVCE9A8tnxzyby1JeZp84OGYQTOwWTHa
	jaXmGNs0S+IzHOV8A6tG6WAaG6CNTWR9uxKQ25DnG3U/x9hXJuFEKzuwn
X-Received: by 2002:a05:620a:480c:b0:85f:a278:78bf with SMTP id af79cd13be357-8906ea9b701mr288981085a.3.1760689246422;
        Fri, 17 Oct 2025 01:20:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG11LgstWaYNgZ1s68woOATZnZcT4+E5t9urVq0Efp1rsjpDe8qtt+X2vM/fWmWeJco3S37WQ==
X-Received: by 2002:a05:620a:480c:b0:85f:a278:78bf with SMTP id af79cd13be357-8906ea9b701mr288979585a.3.1760689245872;
        Fri, 17 Oct 2025 01:20:45 -0700 (PDT)
Received: from [192.168.119.202] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b5cb9f75f47sm754628366b.28.2025.10.17.01.20.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Oct 2025 01:20:45 -0700 (PDT)
Message-ID: <73d30994-3ec3-41bc-9b07-638d4173dfe6@oss.qualcomm.com>
Date: Fri, 17 Oct 2025 10:20:43 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/6] arm64: dts: qcom: r0q: add touchscreen support
To: Ghatto <ghatto404@gmail.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20251014044135.177210-1-ghatto404@gmail.com>
 <20251014044135.177210-4-ghatto404@gmail.com>
 <e114504e-4bdd-46b9-b708-8eebc3075163@oss.qualcomm.com>
 <CAMQHOhfjsi1L+3j3TrcjEjPp3xkn94KOdsrVZvJCyUDFBBSeqg@mail.gmail.com>
 <d06a254f-bf54-4bdf-bd09-3ee5e5b31bad@oss.qualcomm.com>
 <CAMQHOhe=WYhtsjHMcRnJOi8UhnNNBfveTWRGSZ_bg24gFysAEw@mail.gmail.com>
 <8bd5486f-38a9-4104-8d09-234f642b45fe@oss.qualcomm.com>
 <CAMQHOheTkKC8NcRrPxKZdB_h0SJGNJVMd4NUD7TE4becPouWyQ@mail.gmail.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <CAMQHOheTkKC8NcRrPxKZdB_h0SJGNJVMd4NUD7TE4becPouWyQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=esXSD4pX c=1 sm=1 tr=0 ts=68f1fc5f cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=NEAV23lmAAAA:8 a=fGO4tVQLAAAA:8 a=EUspDBNiAAAA:8 a=7GU4dPUIjq6KxtgWSIwA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-GUID: 1ikccnp_mnUgcRyFxGgx470-XNu_bF2i
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE2MDA5OSBTYWx0ZWRfX2zWAcPtlndT2
 Y0dhX8EcF3Qiluu3vNtiA9sqCFa3m555Hs8VtJKj/mw9pvTWkBoq/gVPL4mTfBvNZu3NjLOALlD
 gUYOX+opzrkcEF9lNx5BoUSRuEDJYWqtjoyQ6vQbrY5duhc4cLkvGaJUJoVNj6WAx01uNoww/vL
 RqLhsDbFSqNOd8ONaok3sDIladisDHIkrtgrpiMLIdxH/lydjv3Ug+kzoF66FFyI5RJV1BxD8EC
 T3s7BFBukjuP8as2ZGFgGyZQxcEMhd29W1HrIX+gmojajoVb5CCr/NVq5pM49wvhSuLUi4guWNa
 reUYR9uavpcsjwlwaB37Gf1vdQmOEr2VuOpO898E4QdrwYVjjzUuUQIV0ZZD9Bm/eYyCihkdLZU
 DvOKViZIKnCXYsJH0zPl81VhO4fnQw==
X-Proofpoint-ORIG-GUID: 1ikccnp_mnUgcRyFxGgx470-XNu_bF2i
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-17_03,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 impostorscore=0 bulkscore=0 spamscore=0
 malwarescore=0 suspectscore=0 clxscore=1015 lowpriorityscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510020000
 definitions=main-2510160099

On 10/16/25 10:08 PM, Ghatto wrote:
> On Thu, Oct 16, 2025 at 6:06 AM Konrad Dybcio
> <konrad.dybcio@oss.qualcomm.com> wrote:
>>
>>
>>
>> On 10/14/25 9:04 PM, Ghatto wrote:
>>> On Tue, Oct 14, 2025 at 11:18 AM Konrad Dybcio
>>> <konrad.dybcio@oss.qualcomm.com> wrote:
>>>>
>>>> On 10/14/25 5:10 PM, Ghatto wrote:
>>>>> On Tue, Oct 14, 2025 at 7:01 AM Konrad Dybcio
>>>>> <konrad.dybcio@oss.qualcomm.com> wrote:
>>>>>>
>>>>>> On 10/14/25 6:41 AM, Eric Gonçalves wrote:
>>>>>>> Enable the ST-Microelectronics FTS2BA61Y touchscreen. This patch
>>>>>>> depends on "Input: add support for the STM FTS2BA61Y touchscreen".
>>>>>>
>>>>>> The second sentence doesn't really make sense to be included in
>>>>>> the git log
>>>>> I'll keep it to the cover letter then
>>>>>>
>>>>>>> The device has an issue where SPI 8 (the bus which the touchscreen is
>>>>>>> connected to) is not working properly right now, so
>>>>>>> spi-gpio is used instead.
>>>>>>
>>>>>> Some Samsung devices used to use spi/i2c-gpio intentionally, also
>>>>>> on downstream. I'm assuming this isn't the case for r0q.
>>>>> It isn't, the device uses fts2ba61y on the spi8 bus - I hosted the
>>>>> DT at https://github.com/ghatt-o/ss_experiments/blob/main/r0q.dts if you
>>>>> want to take a look.
>>>>>>
>>>>>> Did you enable gpi_dma1, qupv3_id_1 before spi8, when testing
>>>>> The driver probes, but it fails to recognize the touchscreen device
>>>>
>>>> Could you post a complete dmesg and the precise DT diff you used?
>>> https://pastebin.com/QkYa8nMp (android dmesg) mainline dmesg doesn't have
>>
>> The link has expired 🙁
> https://pastebin.com/s4abJS9M shouldn't expire now!

And yet it did!

Feel free to just attach it to your message.. the list may bounce
it, but it will still reach the To/Cc recipients

Konrad

