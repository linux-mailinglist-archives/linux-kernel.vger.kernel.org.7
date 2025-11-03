Return-Path: <linux-kernel+bounces-883314-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5157C2D19D
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 17:25:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 68F4C3BC566
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 16:16:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 597AA315D5A;
	Mon,  3 Nov 2025 16:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="UqfDVAnV";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="f+IowJFu"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CB092836A4
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 16:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762186586; cv=none; b=AlhCyviFXFI9Af6iZaCT0WzLsMKwL6Qo/fz61uqaBDWAprNWsPoPNUm/O37pomvgm8O2v6OqgH7ejqP/puLMC48HlVHF8Y/AspQF90yMeO5o/moR/3lxkTYHJPLRk87fzAI/r9s0Yo2qkNW2GyTP7jJV5KQXhHLzuI3uXfifxWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762186586; c=relaxed/simple;
	bh=0jpXIqxzH2ZZX5QeF7Q7S5vGPUY9pP98uq1sW5fKLNY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UeP19prPVSB5C60jcGUs0MAfaQttrUWBUQl5gL197jlx7olGyjYJVtFySF2dKKVT5PlD4c/6E8f1qQdKM7aVYhaBQAjtCDBR44VZSkUXl2n63URAKSd5IwtMBn1yFuvM4HF7TCvUaSuO7wjV9P5W1rp3hpbD4wcQC0fJoj2JO8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=UqfDVAnV; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=f+IowJFu; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A3G4fTv564683
	for <linux-kernel@vger.kernel.org>; Mon, 3 Nov 2025 16:16:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	LdcvW589MblNcpGME+8yqSm+KMPX7JkIf/mEmjfl5nE=; b=UqfDVAnVnTRhkPiM
	suknEGR1qO7C1SYTpu/u0kars0WkplsSC5ZSQ2yXsVdosiqL5FQRyLr54OghBKDf
	kjattXM3nlWZDFmK21oh59wzx2Rl5BCocLPK61SyLGtQ4MuKPJd7+vULGPlRbrlx
	acIEWCZk6sifaNwIlfUjaXWovOhxF3qrikO/M9caftbEJH5TpN/6jC1Jnsmu3AyD
	f20jXrL/2gmAxwMK3shkza4Ji64Ic4kZ8I+ChfG7OXdVUEJGHsFUE52K778pG8ZB
	ULcLJnr6WvO6TmhjYBNcIqw0+tLyRlr3oPGhiyhmJH34tMSynB++NPdbPge3kb/c
	IOJSfA==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a5bcm5578-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 03 Nov 2025 16:16:24 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-78105c10afdso5431960b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 03 Nov 2025 08:16:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762186583; x=1762791383; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LdcvW589MblNcpGME+8yqSm+KMPX7JkIf/mEmjfl5nE=;
        b=f+IowJFuP5BzbUX7oDJBd1no/0kQpEvU6IUDAKTDJXL9zoZU7WGqWdUNySzJucNK1O
         1gwSHY2NKaSEhmAfzytzoQWBoPf19MIheSy8N2sg0ighkxc8jZtLR3uNmqMdRlQO3YMn
         9giSEsihg3UySBW0TpfccThB1eFBNwGMa60Nsh5QD4QpjQEnvFAboUAhA7RB0IzYX2GE
         hzmWBlt/+XvfAvS3cCmQD0tEUDXde5vuouVGDRmrwiNkuRiaoV6pUWHiT8uF2wsuOnaw
         qn3Po+C7zXZpzRkvg5vjYy9w2LY4yVtegX/lgbjVTqRyjNEe5giCWpOHdmDoDoRr0Fpr
         U2Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762186583; x=1762791383;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LdcvW589MblNcpGME+8yqSm+KMPX7JkIf/mEmjfl5nE=;
        b=C/IYqA1KHjXuaJMjUPaJVdLpxSsOBFUzMQMHK8LQBHcSM1ke/qmwicL6qZMahqquPe
         IT/jKofv+ME7tJ9CgukPeG1qXsNZG+s9X7nxHV2otzwDd+7MHoUow4SzWbylD0SyQkqO
         koZwXj+ync4IHJ6kHiTyHdSmUGBWNQVuccCSqrpQZgnS/YaJ9KcpQTUpPBDgHhVdrvou
         FX4IeS2/2snLiNJqrY2BHLhkh8NPDLH/cY0GgK+z4MfqnfTDjPWZSfgyDXT5FWEe+Rnd
         JIo+dNH6MykcAMbZXakobi9UYYH8j9viqy+MjeyWYyQ2NRa2HWNFYng5hn8BVdjInCiE
         2nVw==
X-Forwarded-Encrypted: i=1; AJvYcCW6bAzWmK1aEQ7SJ989dkFB+/xrpVNswizvV291btnT8f4875tKyuiCizMKLzQ3ObUezjzYnPzodvjhnDc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3U4KJNcaj1mhk3KqtKha0lZXJYB4ITioca+N14Gialckoj0KZ
	hBw1A404XAzmKHETFpT/pOoMi/ZlUpvKJninKnetyEZiNKddX0eQ06JdaqAB49JxWG16KyiWKfA
	bHIkpip4NTMUH7KAGMFrh7LhVYa+rK3PYu8F6WF1EgQQM7GTFy/OX4T0Gx1y6KNFfupeP0Pv1HQ
	Y=
X-Gm-Gg: ASbGncvZo/atye753ku4V78v37oNI8D47ggEDjBumpzCJf1jVZikKGrzmuCi7ee7s3f
	6QaFxflH4Xwz2RryStGltKe80X1qzwpxbS5HGxOYMnZ1rZUJzQkj6cxrBUWMrzv7wVQi/iS6MH/
	+pq9L4ciaC6i9qWi9a4WbcE4ab6RPNOqvu53tQQmnn/xpmbwJVoIkZyryY/lT/LPBll+0OtvWaF
	NQr+TuJhf6hVlahFeQY50ylAnogkXHcRJlNEbRi+3r2YyCU+7hUdwZyg1UxLH8WaMjio9Xb+LHT
	Mz0+xjKqhkBcIBj5zq1KBRIpWAQVSA5T7p79aMbe9zd8fQCTm58k9N6DGkH56PG34YIthfYqogJ
	ioXDYvwUpT4jyZFj3z37s10YXKl04hwMdGg==
X-Received: by 2002:a05:6a20:72a6:b0:2db:f868:22c with SMTP id adf61e73a8af0-348cd20baa6mr18430545637.40.1762186582795;
        Mon, 03 Nov 2025 08:16:22 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF9/B6M7mt8CtWVyJzrPwOK0l0sUdXjqJsKuje1nItIKT6qHk3qWszOLI4NbHKTsmM4uDw2Mg==
X-Received: by 2002:a05:6a20:72a6:b0:2db:f868:22c with SMTP id adf61e73a8af0-348cd20baa6mr18430496637.40.1762186582187;
        Mon, 03 Nov 2025 08:16:22 -0800 (PST)
Received: from [10.216.41.187] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a7d8e6fa5bsm11885136b3a.27.2025.11.03.08.16.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Nov 2025 08:16:21 -0800 (PST)
Message-ID: <da04aa57-f3dc-9bcd-5ba3-05088a6661ab@oss.qualcomm.com>
Date: Mon, 3 Nov 2025 21:46:17 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH v8 2/3] firmware: qcom_scm: Support multiple waitq
 contexts
Content-Language: en-US
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Unnathi Chalicheemala <unnathi.chalicheemala@oss.qualcomm.com>
References: <20251102-multi_waitq_scm-v8-0-d71ee7b93b62@oss.qualcomm.com>
 <20251102-multi_waitq_scm-v8-2-d71ee7b93b62@oss.qualcomm.com>
 <CAMRc=Mfh+WQx-vasZed6jWi5nUjg=K+ScVRBMCiFgK397=JbVg@mail.gmail.com>
From: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
In-Reply-To: <CAMRc=Mfh+WQx-vasZed6jWi5nUjg=K+ScVRBMCiFgK397=JbVg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTAzMDE0NiBTYWx0ZWRfX2ggMtZFTcmKn
 d40jqdclNOFGexCCuYv/y62dSpFXuSBhj4yQuWixxa1vCg71TBjBW8teKYTM9KsVbzDpVvvAguE
 RcCGdLj+ckVynBcsKP9M2LLo96vz5xunEAYWtbGkxu0pEpleCkZISibzAk/dxsdfahNa1fZJHK4
 HfqU714wXLLOcRZck9dc/doN4BU1al/dkfhAJk8erE1VjcYuQnFLDGkyKmx1+zejSyrfGfTy4b5
 mecdcrQC98MKxk+S8sAWhzo57FBYCfGEo2P4F+6+zIPN+ahhA1tVKqcn5VAyNisi9X7FU2l1kPY
 9jF6wP+X8xGIan9Ue5Ohb79SZOKFYct8t2/Rwsd8OImUTp0P+0k7aisTZTNVMFse8OkA8wK6RZa
 eQLeGTGdn5IsZFiflf5cJk3KLdya9A==
X-Authority-Analysis: v=2.4 cv=EszfbCcA c=1 sm=1 tr=0 ts=6908d558 cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=fzkneX8sAZvuw6kD2IUA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-GUID: 19xi0w6MUPA5XM3frmftnw8sI65_l6YV
X-Proofpoint-ORIG-GUID: 19xi0w6MUPA5XM3frmftnw8sI65_l6YV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-03_03,2025-11-03_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 priorityscore=1501 spamscore=0 phishscore=0
 malwarescore=0 lowpriorityscore=0 suspectscore=0 clxscore=1015
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2511030146



On 11/3/2025 9:16 PM, Bartosz Golaszewski wrote:
> On Sun, Nov 2, 2025 at 9:19 AM Shivendra Pratap
> <shivendra.pratap@oss.qualcomm.com> wrote:
>>
>> From: Unnathi Chalicheemala <unnathi.chalicheemala@oss.qualcomm.com>
>>
>> Currently, only a single waitqueue context exists in the driver.
>> Multi-waitqueue mechanism is added in firmware to support the case,
>> when multiple VMs make SMC calls or single VM making multiple calls on
>> same CPU. Enhance the driver to support multiple waitqueue when
>> support is present in the firmware.
>>
>> When VMs make a SMC call, firmware allocates a waitqueue context,
>> assuming the SMC call to be a blocking call. The SMC calls that cannot
>> acquire resources, while execution in firmware, are returned to sleep
>> in the calling VM. When the resource becomes available in the
>> firmware, the VM gets notified to wake the sleeping thread and resume
>> SMC call. The current qcom_scm driver supports single waitqueue as the
>> old firmwares support only single waitqueue with waitqueue id zero.
>> Multi-waitqueue mechanism is added in firmware starting SM8650 to
>> support the case when multiple VMs make SMC calls or single VM making
>> multiple calls on same CPU. To enable this support in qcom_scm driver,
>> add support for handling multiple waitqueues. For instance, SM8650
>> firmware can allocate two such waitq contexts, so the driver needs to
>> implement two waitqueue contexts. For a generalized approach, the
>> number of supported waitqueues can be queried from the firmware using
>> a SMC call.
>>
>> Introduce qcom_scm_query_waitq_count to get the number of waitqueue
>> contexts supported by the firmware and allocate “N” unique waitqueue
>> contexts with a dynamic sized array where each unique wq_ctx is
>> associated with a struct completion variable for easy lookup. Older
>> targets which support only a single waitqueue, may return an error for
>> qcom_scm_query_waitq_count, set the wq_cnt to one for such failures.
>>
>> Signed-off-by: Unnathi Chalicheemala <unnathi.chalicheemala@oss.qualcomm.com>
>> Signed-off-by: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
>> ---
>>  drivers/firmware/qcom/qcom_scm.c | 75 ++++++++++++++++++++++++++++------------
>>  1 file changed, 53 insertions(+), 22 deletions(-)
>>
>> diff --git a/drivers/firmware/qcom/qcom_scm.c b/drivers/firmware/qcom/qcom_scm.c
>> index 28979f95e51fbee94b84c1570a4d88a76f72db4e..0b6efa7c2bdc25a3ba152c25d5451d1154779ddd 100644
>> --- a/drivers/firmware/qcom/qcom_scm.c
>> +++ b/drivers/firmware/qcom/qcom_scm.c
>> @@ -47,7 +47,7 @@ struct qcom_scm {
>>         struct clk *iface_clk;
>>         struct clk *bus_clk;
>>         struct icc_path *path;
>> -       struct completion waitq_comp;
>> +       struct completion *waitq;
> 
> Why this change? This makes the name less descriptive if not misleading.

Want to make it dynamic array of waitq`s. Should the name be kept as 
struct completion *waitq_comp; ?

thanks,
Shivendra

