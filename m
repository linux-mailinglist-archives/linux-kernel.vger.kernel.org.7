Return-Path: <linux-kernel+bounces-822007-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B3269B82D5B
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 05:56:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 53FDD1C069E3
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 03:56:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6163243964;
	Thu, 18 Sep 2025 03:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="bhAB/6RQ"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 506C423CF12
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 03:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758167765; cv=none; b=fMCs7f7k43bQUFbRA9pjdeudDia3bTydW711M1q9d8BtjzlubpRT6egbVl/T1lbW+wn1F49yv/ZDm1rS8lGdwMjo5VWOhP+JG/0Ze7scM2kBfCb4eAIqM6dgrZoHrvfFWQRlvyt+Eny4IqQ7oLeKIMKBsiMpQKN+dBDyoCObfO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758167765; c=relaxed/simple;
	bh=CkhYshgCl2KU7HmPUDrBkaUy/oLRIyiOgdxz9omSVB0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AzFxxypW5Id+7Z7MvwWjVO43ZAU5dtiTBQT7ouH1CYqp9axu8RsZ6R9dVMfumxunTg6x4D34Yth/R4YsU4dh0ZIRVdshq55JJYc07gMt3h9bX35HADvj/OJtZHCHyScTd3hjNDqzKLH5LDQxg5Qwh4GbafsqUmxg7GJ6DkagDDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=bhAB/6RQ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58I2mJO7020437
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 03:56:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	+Fxa1cerSNF4zeWZMShDjw5WL2sJeXA2U30jnp3Uor8=; b=bhAB/6RQAe8RaVSS
	v/LvLcGIUaR231QOhk/OK0b7dFDgVYCExk2LPypmHa2G4BI4QKGk/5Z72BdVywzE
	xa2c2FGFi4iCQvw0n76Ur02laHxUl9jTQR3i68PRwAiytrdI0o2sZuphmwpfnK/V
	zeB4BaIoGAmOB49+Y4BwzcHP6XAyPCdD6sSDphsV1zVrBIfQsDB+1URGi9kKRwad
	PROq0+m6Qlsd6+Bgu8rQj0A/VsV5EnZdUCc01cXoTZ1mAMkD/dwGIV48+Y6OLvQc
	Sp4LepmaOd5hVaJ2ZMRhBCu/s5QHkbmC9YRYlL31Fspr6sefcQ8EMhd/wwRVObyi
	cTqCxQ==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 497fy1vwrg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 03:56:01 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-262f626d62dso3454365ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 20:56:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758167760; x=1758772560;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+Fxa1cerSNF4zeWZMShDjw5WL2sJeXA2U30jnp3Uor8=;
        b=GH0JSeWhYsFjMxr8gUohNdDeYeGfWLPvg5HZGHa9Oun9lis5rESC5X8PG1TqkAeb0B
         7M13yqdMp4RCAvV/E5QwlWfNFsaOHDsWmNUotewLqoRQ6GBu0d5Zkw0ex+qBXI1sDSky
         wfzaSOyY0AGB7SSs8DDu+Fn68I/CaHHiTjDgJBvsvnc3ubRmM4zyEfN4c12dKYprdq/3
         c7tnje8Nd3qDszMTkdPDVcagMJS6M1dmv2UDLlGbewDwLieoGWXrCInQzlbHl/0G9Sjr
         zYGcWmkUvmtIxkMd49xFISth0r/a54WSakSCjcJ/mthBe5c2UP8u0jVywbPdDnERZFqp
         Btww==
X-Forwarded-Encrypted: i=1; AJvYcCX5JjgeEiBX8ZPNxMzhOGyy8TK+55jdluHJrEWStBC+xVDXTHvsT0nFNqAEthwUOTlksaGCf+f1lx86yxs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw81GtECt/5RjmZXH3H10KJxqpTvpAF+3nQNjXcYH9NdHES3cCC
	ezJE/6q/BxdsSqIUlfeJ0Rryfjix7vmcLHPtoZ9zLQp0KYkjqL6LS+nw/scnp50mBT591EX4sTS
	jYENnD35aLMOhtRcHnvl45zaeJpiM9byrH+zcQwq8j2ZxNMqElkSKK/Reaq6lbsTYPTo=
X-Gm-Gg: ASbGnctzyrMieEEBDpWybHyIXGL6QO4cH/qdIFxbUCtu5o3n1uFm27GOK3TOSJJqqdt
	D3uzDK4hKG9IW8c/Ouni4Laznb+Zp4m5hfnBzbxeewqZc0FXTba6mw2RaEoeQzSxghqfUY8ej+E
	k8ulnqgN8ogMuYp8qolD1foH5GOjti0ixDmSDcDlT5HucrBmgNlLcEC9bnDXE4v2cBRD0wYx/Kg
	MtJZUgqwlA4xrweXnOVLiZXAaY2z5exwLj6sDJ0deCJJuhmuM+qvXsH93qGOigTsWedXveMOCJ+
	8uwHMNfGgfPBO3bI5MreK9ybKaga31v36dohIGH9CRq0FkeB7z49rkyB7jXAtRISqOMJSNPJ
X-Received: by 2002:a17:903:2350:b0:25c:ae94:f49e with SMTP id d9443c01a7336-268137ee3e8mr53353295ad.37.1758167759811;
        Wed, 17 Sep 2025 20:55:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGUQIsj/bvrGJKX2t8jqtl7qhNRFzVuedqKZIiWt2E4pbwp4s0RwP4y+TkO5jslvFAE+Up5Ew==
X-Received: by 2002:a17:903:2350:b0:25c:ae94:f49e with SMTP id d9443c01a7336-268137ee3e8mr53352995ad.37.1758167759201;
        Wed, 17 Sep 2025 20:55:59 -0700 (PDT)
Received: from [10.218.32.171] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-26980329745sm10566025ad.121.2025.09.17.20.55.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Sep 2025 20:55:58 -0700 (PDT)
Message-ID: <8e2781ae-34d2-4009-bf8c-56aa1bb6fe85@oss.qualcomm.com>
Date: Thu, 18 Sep 2025 09:25:53 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] serial: qcom_geni: Fix pinctrl deadlock on runtime
 resume
To: Krzysztof Kozlowski <krzk@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Praveen Talari <quic_ptalari@quicinc.com>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org, alexey.klimov@linaro.org,
        jorge.ramirez@oss.qualcomm.com, dmitry.baryshkov@oss.qualcomm.com,
        andersson@kernel.org
Cc: psodagud@quicinc.com, djaggi@quicinc.com, quic_msavaliy@quicinc.com,
        quic_vtanuku@quicinc.com, quic_arandive@quicinc.com,
        quic_shazhuss@quicinc.com, quic_cchiluve@quicinc.com
References: <20250917185102.3763398-1-praveen.talari@oss.qualcomm.com>
 <dab18f70-4017-4c06-92c1-91cfd2229540@kernel.org>
Content-Language: en-US
From: Praveen Talari <praveen.talari@oss.qualcomm.com>
In-Reply-To: <dab18f70-4017-4c06-92c1-91cfd2229540@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 8Oj1ehjJPfLVXAvwb1JG5r7PXpeLvwB-
X-Proofpoint-ORIG-GUID: 8Oj1ehjJPfLVXAvwb1JG5r7PXpeLvwB-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE2MDIwMiBTYWx0ZWRfX9W/ChZ+KsQdE
 nWKSMmu2jdxyBxEqHhh/1t7ITImntFlnJj9X0k8pOUYXB8gRq8C4Hd/bP8hNFWZJ6rAB+hXXa1W
 EiJAzP8iXkXVI1rBCrqS4YRaYDcztfhyR2Xrg182wSUks+o8Ren46e8JxyMehDBMqyVtpUo9cd3
 7tdiXHJ99YfOqp/qJR5/GEA9upfqq4icSec0F6SAqhFiFo0tV/IXI0FtWVUxe/3uYm5rbY5W8Sz
 DdgzGF6/E45h9yDKbLZBPM4RkMhCaLLjF/dmK1uE9Dwif1JQR2LqyF4Z2WMMQY9MCe0JzsObMp3
 lPm/mOHLsz2iyI/sG9S/9p4qfJQV01uHN5zWZDwpfeKQm54d2kU9UFl4wc4FyunU233kPBpNKlQ
 CMJ26lXp
X-Authority-Analysis: v=2.4 cv=cf7SrmDM c=1 sm=1 tr=0 ts=68cb82d1 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8
 a=EUspDBNiAAAA:8 a=cBlBuNp7yuU5UAWV944A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-17_01,2025-09-17_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 adultscore=0 bulkscore=0 priorityscore=1501
 spamscore=0 phishscore=0 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509160202

Hi Krzysztof,

On 9/18/2025 5:28 AM, Krzysztof Kozlowski wrote:
> On 18/09/2025 03:51, Praveen Talari wrote:
>> A stall was observed in disable_irq() during
>> pinctrl_pm_select_default_state(), triggered by wakeup IRQ being active
>> while the UART port was not yet active. This led to a hang in
>> __synchronize_irq(), as shown in the following trace:
>>
>> Call trace:
>>      __switch_to+0xe0/0x120
>>      __schedule+0x39c/0x978
>>      schedule+0x5c/0xf8
>>      __synchronize_irq+0x88/0xb4
>>      disable_irq+0x3c/0x4c
>>      msm_pinmux_set_mux+0x508/0x644
>>      pinmux_enable_setting+0x190/0x2dc
>>      pinctrl_commit_state+0x13c/0x208
>>      pinctrl_pm_select_default_state+0x4c/0xa4
>>      geni_se_resources_on+0xe8/0x154
>>      qcom_geni_serial_runtime_resume+0x4c/0x88
>>      pm_generic_runtime_resume+0x2c/0x44
>>      __genpd_runtime_resume+0x30/0x80
>>      genpd_runtime_resume+0x114/0x29c
>>      __rpm_callback+0x48/0x1d8
>>      rpm_callback+0x6c/0x78
>>      rpm_resume+0x530/0x750
>>      __pm_runtime_resume+0x50/0x94
>>      handle_threaded_wake_irq+0x30/0x94
>>      irq_thread_fn+0x2c/0xa8
>>      irq_thread+0x160/0x248
>>      kthread+0x110/0x114
>>      ret_from_fork+0x10/0x20
>>
>> To fix this, wakeup IRQ setup is moved from probe to UART startup,
>> ensuring it is only configured when the port is active. Correspondingly,
>> the wakeup IRQ is cleared during shutdown. This avoids premature IRQ
>> disable during pinctrl setup and prevents the observed stall. The probe
>> and remove pathsare simplified by removing redundant wakeup IRQ handling.
>>
>> Fixes: 1afa70632c39 ("serial: qcom-geni: Enable PM runtime for serial driver")
>> Reported-by: Alexey Klimov <alexey.klimov@linaro.org>
>> Closes: https://lore.kernel.org/all/DC0D53ZTNOBU.E8LSD5E5Z8TX@linaro.org/
>> Tested-by: Jorge Ramirez <jorge.ramirez@oss.qualcomm.com>
> 
> Where did you receive this tag for this patch exactly?

Since Jorge was involved in validating the change, I’ve added him under 
the Tested-by tag.

Please correct me if I’m not supposed to add this tag myself.

Thanks,
Praveen Talari

> 
> Best regards,
> Krzysztof

