Return-Path: <linux-kernel+bounces-875648-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 5226FC19850
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 10:57:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B6A285614A5
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 09:50:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 623873254A7;
	Wed, 29 Oct 2025 09:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="h1gm3zXY";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="XjNNiYUd"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DEB720C48A
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 09:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761731451; cv=none; b=gR+VGxc5FerNH5d96dNZur+BXC2cWT56e1oEDJU1Ze/V0d2Q+YXZOIAk9qFMih8Y6+18/P3gpxUqRvQK/EJPKBhrv71g4vsVAB/zkHWJKdcanwMpcHRImiQVGTJGkCNR5FFI7gbJA6B2IwnKi2deeKy5uTQLywl0YYLDjpt24Pw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761731451; c=relaxed/simple;
	bh=m+K2E2l4iyF27lT14P7iUzF9fXE6h6Xbvzl9E6FRmuk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sk5B/nJ4Uo5fuOjYBrKokiYmx+cMF5N2TSMHBKVxMQ/alpKui9/KV9yL20gST5fMn1A4aWzsQk9saOrKks6AgQetLmsUsN+E5YlZFfgq/hJQZy5KvrVIHN877MBqXUuNrzJ2XV/eonn3ZyaNrf9vtRo+bRq21EPiG2tN4YgVnWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=h1gm3zXY; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=XjNNiYUd; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59T4uq853642844
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 09:50:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	AK8xApIPZV53Vmukr4jQmYsVprz7msuMmOtXRbWCxIA=; b=h1gm3zXYV/dDC12/
	JKjfMmf/xnzeHyODAEFB4ciht0ErqsapTzgntWfXCvrUPkLkBjoCwCBNctGVgQ/+
	/XM7Eigu7gPURttTBB6Be85q/VX7PEsJ4fBP522Jj641iAp4bPElzr219PIr9Y47
	PRDf77D+2E38uWa01BipmSw/SMVm1ahTNEIy97xYv5DZrUXnzDeb9QY/TwBGlFp7
	t1NGNSEM6y5TfVYZsD8Bw6EdvSKhbsxfII49YX+p9zKFfwQGtNJHZnxRKER6gyEZ
	kPASmZsqwdYCT9u6GLcnPPiJPbtP5uwZ5dTXU7ECVvDq2EsIP/O5RbvgzspFMFm5
	RsIDUw==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a34a1j37r-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 09:50:48 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-87df3a8cab8so20791496d6.0
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 02:50:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1761731448; x=1762336248; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AK8xApIPZV53Vmukr4jQmYsVprz7msuMmOtXRbWCxIA=;
        b=XjNNiYUdR50GTH+VMUjFxvS6zVSfUk7LxKUh+c1vPX1YewfAuSNRdYWI02Dbml6jc6
         hixd+JWJYgJVlwRxhylEQKxU65LQ77q68x7RXYWIAjEQI1WADgCW/yrK2ARgIhAlI0v4
         WalqpabuezfBJacmYTagsfcurajsuw/BiKHPAPiJ+6qv2Jaa3d0pF3ETl5bAs71aMj56
         6ZjLOJ7GXIW3Zp/1+6iKO5M7ifeLQLppQ79nBomgCDwnL4XetTq/AxG1ziBIT1ZLd+0V
         ThNwOzljkc+8VzPNmgLV3JfQ4GCyOmgJJ9wadHNL8zKk6DoCrOG0z+54jMlvjnggoURu
         51Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761731448; x=1762336248;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AK8xApIPZV53Vmukr4jQmYsVprz7msuMmOtXRbWCxIA=;
        b=slpxv1V1/rlprP7ByFM1EiEkWrNZUEi5yv3/vZC8PTmuO2aDjM30JfrJoZkJFYrDon
         Huzm87LHzukMrS26N652oCk3k9EKauX/i0O/0ktlIN3FGbo5K1DIugOAxwAiUVxS3he5
         nhSMQ7k7CgoaoV2rWaLzzX8mdU6x2Lgod9JP6UXTPnJll1o2UwdBSMRlN809reQugyc4
         jN3IZ/XwhduQqdlZgTrHaD8zubYg68IARufEXlrV/bz/AyogXMplq+nOtXEl8Icl4xPC
         AeZF3C0vb+SIvmUM62EPR4JRhPIP6wp8RgAMo8OHxrxnMy6ehFf8bviKwH+cQqhGaes7
         EKPw==
X-Forwarded-Encrypted: i=1; AJvYcCWyst4rgTJY3wQk86cwmKWB4hv3PRO11EtEeusKYHlkoiKkvoCDf3MCADnqYdvFuRkOK8jcs1HwExG/1LI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOYsbqGMNqmDtF+4zONjtfi7ODSVLNlaBEZMn/0UoBsaY63lhW
	TeLpUPVx8TJDDqMmbbGWes1WcX1q+bJ6BOVm673wGwGuyFRmFeJVP/HynpOjQ0foIm1vgspYzdw
	77WtRRiakm7Aiq8KhDQ/QmdoVzaSp5lhncrmPYjrEFhnM1GIgBpOSd3UKgW0y5du6ssQ=
X-Gm-Gg: ASbGncuPkocT3mpkgH3c84RTCCcmNgq0i0NtQqVbnM3DWYBMYFtLKFT2K2mqe8xTuxA
	u2lQLnaq/PWl4ph3OE12ggalrBmb5hBIjY1Tnmsa9VITkq2dnLmDcNo2OujQiozvucdIUIuzfEP
	wr1hrUnJlhZss3epCX+tdQzSm9qPYUvNxrxPjZ1XF1CpHBNvY7LVQ1iFGQeR5itfGsYMRlEUWKq
	92uSEWfcg1emnwKTjcHlQshzJdn3b2L2hxiXEQHuerx91rqNXwdh0egO1elR9NpkNs/qLUhkIWP
	fRTGLAwSy7uuHPaIG1vltGdZAxv7uNW8QlhOKCyvjV4qblTTmQbZrXzYdzzH5uFy3yrzZH35x6W
	6YDuO+rpovrglEx+RMuTOhdVVPJp2temSeRbm5xnK/5dpWQyNP04xkEX8
X-Received: by 2002:a05:6214:c6c:b0:815:e14a:1f44 with SMTP id 6a1803df08f44-880099ac8d8mr19088696d6.0.1761731448031;
        Wed, 29 Oct 2025 02:50:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFHaoGM53+H/DIS3b61zDDV7ZizCu35jzvHkOhXniCFDNUlOtrRNUd8LciFsL5yWYUgUD9NXA==
X-Received: by 2002:a05:6214:c6c:b0:815:e14a:1f44 with SMTP id 6a1803df08f44-880099ac8d8mr19088556d6.0.1761731447525;
        Wed, 29 Oct 2025 02:50:47 -0700 (PDT)
Received: from [192.168.119.202] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b6d853696aesm1401251666b.30.2025.10.29.02.50.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Oct 2025 02:50:47 -0700 (PDT)
Message-ID: <a04742f3-8a1b-4d69-acd9-5d8dbd5a8886@oss.qualcomm.com>
Date: Wed, 29 Oct 2025 10:50:45 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/6] arm64: dts: qcom: r0q: add touchscreen support
To: =?UTF-8?Q?Eric_Gon=C3=A7alves?= <ghatto404@gmail.com>
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
 <73d30994-3ec3-41bc-9b07-638d4173dfe6@oss.qualcomm.com>
 <7C2DF8E1-D84C-428C-B064-3D8CA16FEA29@gmail.com>
 <7e5f753d-a26d-40fb-9cde-ec17eff85c27@oss.qualcomm.com>
 <E9C95D16-18DB-4AE9-8C50-BE3481A25FB3@gmail.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <E9C95D16-18DB-4AE9-8C50-BE3481A25FB3@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=dbiNHHXe c=1 sm=1 tr=0 ts=6901e378 cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=NEAV23lmAAAA:8 a=fGO4tVQLAAAA:8 a=EUspDBNiAAAA:8
 a=3FLXhauJO0Qb1WIU7LsA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=pJ04lnu7RYOZP9TFuWaZ:22
X-Proofpoint-ORIG-GUID: RU4k2KwFRnvyvRyjeVYdxudA_C7c4j2l
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI5MDA3MyBTYWx0ZWRfX+uGKJSlsA+mc
 LovCB2XqMXsEt5ujWjQJ6xW0gV/X81xFO6x2+B9l0+OHghk0O5/TVYE6fwBkuT/FAWCcUqqAMFl
 XEvMyjNpcgtr8qQxWs7GpIbU9rqYDlDflXDvxFja2mC3HVlN1AlwvtjCv7zgAFdnHU7cd+EbQqD
 HH+c7FmQ6c6x+w0SzOJc9TpNBJV5dVW2t7Hvf9Cb+scAbdMhyrFg1vlxjx4o64KrUdM8+AwQH/6
 mGzjR2YnRlaxkBfkiNtjTDAgifqb14OTBEcMfYAjBV3HyE9C4IIouVbQ7sEtL11E2v3GYYGDq1o
 jImkGWfbjES9KfVyeuT/gOYebuEXPEpGnE43hbDBkkYbYxk1MNiNnu7fRelB0HzJt8PeC4+JTGP
 XhLpp1G/WsRiGV11EuOSDl5QkbOZ+g==
X-Proofpoint-GUID: RU4k2KwFRnvyvRyjeVYdxudA_C7c4j2l
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-29_04,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 suspectscore=0 lowpriorityscore=0 impostorscore=0 adultscore=0
 malwarescore=0 bulkscore=0 priorityscore=1501 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2510290073

On 10/27/25 7:32 PM, Eric Gonçalves wrote:
> 
> 
> On October 20, 2025 9:18:18 AM GMT-03:00, Konrad Dybcio <konrad.dybcio@oss.qualcomm.com> wrote:
>> On 10/17/25 8:22 PM, Eric Gonçalves wrote:
>>>
>>>
>>> On October 17, 2025 5:20:43 AM GMT-03:00, Konrad Dybcio <konrad.dybcio@oss.qualcomm.com> wrote:
>>>> On 10/16/25 10:08 PM, Ghatto wrote:
>>>>> On Thu, Oct 16, 2025 at 6:06 AM Konrad Dybcio
>>>>> <konrad.dybcio@oss.qualcomm.com> wrote:
>>>>>>
>>>>>>
>>>>>>
>>>>>> On 10/14/25 9:04 PM, Ghatto wrote:
>>>>>>> On Tue, Oct 14, 2025 at 11:18 AM Konrad Dybcio
>>>>>>> <konrad.dybcio@oss.qualcomm.com> wrote:
>>>>>>>>
>>>>>>>> On 10/14/25 5:10 PM, Ghatto wrote:
>>>>>>>>> On Tue, Oct 14, 2025 at 7:01 AM Konrad Dybcio
>>>>>>>>> <konrad.dybcio@oss.qualcomm.com> wrote:
>>>>>>>>>>
>>>>>>>>>> On 10/14/25 6:41 AM, Eric Gonçalves wrote:
>>>>>>>>>>> Enable the ST-Microelectronics FTS2BA61Y touchscreen. This patch
>>>>>>>>>>> depends on "Input: add support for the STM FTS2BA61Y touchscreen".
>>>>>>>>>>
>>>>>>>>>> The second sentence doesn't really make sense to be included in
>>>>>>>>>> the git log
>>>>>>>>> I'll keep it to the cover letter then
>>>>>>>>>>
>>>>>>>>>>> The device has an issue where SPI 8 (the bus which the touchscreen is
>>>>>>>>>>> connected to) is not working properly right now, so
>>>>>>>>>>> spi-gpio is used instead.
>>>>>>>>>>
>>>>>>>>>> Some Samsung devices used to use spi/i2c-gpio intentionally, also
>>>>>>>>>> on downstream. I'm assuming this isn't the case for r0q.
>>>>>>>>> It isn't, the device uses fts2ba61y on the spi8 bus - I hosted the
>>>>>>>>> DT at https://github.com/ghatt-o/ss_experiments/blob/main/r0q.dts if you
>>>>>>>>> want to take a look.
>>>>>>>>>>
>>>>>>>>>> Did you enable gpi_dma1, qupv3_id_1 before spi8, when testing
>>>>>>>>> The driver probes, but it fails to recognize the touchscreen device
>>>>>>>>
>>>>>>>> Could you post a complete dmesg and the precise DT diff you used?
>>>>>>> https://pastebin.com/QkYa8nMp (android dmesg) mainline dmesg doesn't have
>>>>>>
>>>>>> The link has expired 🙁
>>>>> https://pastebin.com/s4abJS9M shouldn't expire now!
>>>>
>>>> And yet it did!
>>>>
>>>> Feel free to just attach it to your message.. the list may bounce
>>>> it, but it will still reach the To/Cc recipients
>>> Attached the dmesg.txt file.
>>
>> I'm interested in what happens early when the SPI hosts are programmed,
>> whether there's any additional debug messages.
>>
>> If your log buffer is overrunning, you can add log_buf_len=8M to your
>> cmdline (which will make the buffer 8MiB long)
> Is it that big of a deal though? spi-gpio
> works just fine for touchscreen.

It's like using CPU rendering even though your computer has a GPU in it..

Plus we don't expect the upstream driver to have such odd issues, so I'd
really like to get to the bottom of it

Konrad

