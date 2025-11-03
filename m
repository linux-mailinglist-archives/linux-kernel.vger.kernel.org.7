Return-Path: <linux-kernel+bounces-882605-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2492BC2ADEE
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 10:53:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E6DB64EF418
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 09:53:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20FB12F9DAB;
	Mon,  3 Nov 2025 09:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="gqvSiMFj";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="WqT89aiv"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B04B72F9D89
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 09:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762163617; cv=none; b=MEgmCCyo1PU3f5pUjF3kZDdDUftGhbubp0qDyGQSKV5UxY2tGAQ2xxfhZplM9lQQdwqrowkyY3/NKT6WRABUu2ENWGxynp81Kv5F04500djjjhqV4+w3+0qVGbDrr3twAAfovAEy6ggz3+4VvrS3rQZ7mSs7QBKW7O8sHjBjm5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762163617; c=relaxed/simple;
	bh=QiXdWdOFVk0UNI+iS1e9rGTlkwTDKfuhkBJCR/MtXbc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=r2dPg1EHIdjZxWu55DoS0Ai0Pm80ZmmWazvrhTXuA2p4frEG8XV+Cy48tjuMX71kHSNZ4+HxUeqwzLt4R1EdEb4MMPlQY6sryJMwVgOTB3Qjc8ouiyWlqdvpigc9/VcowAACjg9IOLm5u+lrOShXharcu9BLc+qPShwD6axyIcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=gqvSiMFj; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=WqT89aiv; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A33DHJ91940955
	for <linux-kernel@vger.kernel.org>; Mon, 3 Nov 2025 09:53:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	e+bc/kwQmC9Ufu0+zVgimIzCzDDf4tsUyHk/1mPjqqQ=; b=gqvSiMFjzPi+MEqR
	cWaC/c5/xKp4Es4wGRrY7ozek7bhv8OVYwJxAazFq3RvouzCRcQBWcO8EgLg6+Vv
	p0U9C6Xg4J+Fvj64nzwV1MAGM2T32iZeKHI9De5VCCQOdbBLEKa5HcRoxkSbQ02m
	S0jp+EXV/KtdMSbe6VQiVuTMkm8TJa1mNHrakP/Z65ip3FdyMWCjoYyYx5pH1+6D
	qUpERfZX+qKSSdU1dHkE//kdqrdVBIbzAeg+cG5MEi8smSghVVAEuI/4AsnBGFYY
	hWvdeyp/8+mEOcGd5nJxZer3UpL2zOajDy2o8GWPD31cczZ2y+JWfu4mpnNlDBIP
	b8HfBQ==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a6m9w91v4-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 03 Nov 2025 09:53:34 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-295952a4dd6so13161065ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 03 Nov 2025 01:53:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762163613; x=1762768413; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=e+bc/kwQmC9Ufu0+zVgimIzCzDDf4tsUyHk/1mPjqqQ=;
        b=WqT89aiv8FveITrhNjE0zC1OxUMzkpkQkJi2Bsn7Socwj52wl+a8tD94Vb8cTaNeYs
         3p4oo8m7ElzworohRB+bEQUv5LcPVUpRD0NcBSsPx+VTNhHZTdtWfQXWzImlb5IbPu7n
         204kXq67JvN3AxPbE6jpz03jMJ9rX+0T4CSmKJMVzkwr2gO10uyUy86mbsu9Khffm/ci
         nCsVZCtfxwA47xp+cFcH3g+6L7+9qwrnZOKrJ3Z3DXx7Q5B5oK4/ZvnYXCxasLo/3FGd
         vkQQ6uRIYx1xxQo0cpDiyF0C2CgPdrVzbgIlfU6ySUqe0hKz0T5mIc0T22Zpvz/k2430
         5CIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762163613; x=1762768413;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=e+bc/kwQmC9Ufu0+zVgimIzCzDDf4tsUyHk/1mPjqqQ=;
        b=A2AgIWiUG/Ud6d/C2UL085zdHHKea/n9KXRjXwcbFGIZF08oYAdL/IjyY+tCJvVotI
         mPEmGTTpT6G5AtkYkA7VzFqmF7siAskRhqAU4SFVnPwh+hPD98XlK13uOdFFj2qyn1WU
         1QkXhu1U57xw6nP+s2HQszHYi38NkwHKLievLWl5mWxUgHZonrd2B8wNNNInV0hShErt
         ICGxOxIAY7xXAFaB1qIU5DZ8eHnZhfuU12eUBeHQmMxCuxoT68JGM5dHSTPch13R6Nx5
         /r+1/SGALVQVNlO9rImjKPRhQ/uGRR+5m3Z1brsFVgNCybleCALHH5FO7kkti22P6Hyp
         PKyw==
X-Forwarded-Encrypted: i=1; AJvYcCU+ymR6C2/pITi4B8W4Qsc2X7bSnL9YowHA6gKCjoutxAKlLcxfP2DrIhrFPxqWHaigKQigLtPT2zbUHzE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFG1zK6Xxzhvj2qtev0zAmHz7BbRlxLcNADLWVvxPKgdB+R7iT
	907lgVuVxIFtxo/ft40gDViqwLZqqz+2UAF54zy2ETYuRu1jzgi+OWEvVtgzi3F6PsOtej29IJY
	n7Stej+f0uL3KLY8qysU/4GfNI2dbiUCjyx7oNTia8tvfR+yW9F1pZR9VAqQbRuXpGaY=
X-Gm-Gg: ASbGncu/luGNZAYSYNPyFJ1i+qrm0C/8n2AUDCD136GWtjJyC0/B8VmoEdfs345MUAD
	QJnkLfx4+rzKwJfLhv2R3HAMNwRBEhrNdvlJyv5Mc9BTpSS3qEnD4B/76Czdb7CG2vNcEdXW+nQ
	OLU5sj0Vd4WgeGt2QeFy1yTdQG0+GT8O5Plgoxrrxck2/893K8/9OfXC0w2giTl2fPwJ2BGXcJt
	bCE/DP80eHe+1FBtTkX+v3p2lqIb9hkd2WD9iyBY7lRffhs4f88l28Hn57XPLwn79Tjg4iVukCt
	IoS7YXXI/m3qeHvYr/fPm1voTGSDpPc17tHtfwUegFcxwUx61s6lVNilwvPYbiytHbqNqkqlHQb
	0TDZYEI8IMgatqF9puvlW9UwgqriBiFMAznXMG5LnXF6oPkowmJm1MuW/5hyIYh5+VFKFFgwi23
	STUJeB/183g8Zu/GuetY7Eqw==
X-Received: by 2002:a17:902:d2c5:b0:295:55fc:67a0 with SMTP id d9443c01a7336-29555fc6b77mr77376585ad.2.1762163613308;
        Mon, 03 Nov 2025 01:53:33 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEoTGYBeKUah6jDo3wMiAEXeCGSXTu9lbrJNR6GODRbD0jwvT0knofuKnPEVNWTYDIrALEjfg==
X-Received: by 2002:a17:902:d2c5:b0:295:55fc:67a0 with SMTP id d9443c01a7336-29555fc6b77mr77376355ad.2.1762163612832;
        Mon, 03 Nov 2025 01:53:32 -0800 (PST)
Received: from [10.190.211.199] (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34159fc0e19sm391835a91.4.2025.11.03.01.53.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Nov 2025 01:53:32 -0800 (PST)
Message-ID: <931eaa75-52f8-4790-9103-02e97b820c7f@oss.qualcomm.com>
Date: Mon, 3 Nov 2025 15:23:27 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/2] soc: qcom: smem: Register gunyah watchdog device
To: Bjorn Andersson <andersson@kernel.org>, Guenter Roeck <linux@roeck-us.net>
Cc: Konrad Dybcio <konradybcio@kernel.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Pavan Kondeti
 <pavan.kondeti@oss.qualcomm.com>,
        Neil Armstrong
 <neil.armstrong@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
References: <20251031-gunyah_watchdog-v4-0-7abb1ee11315@oss.qualcomm.com>
 <20251031-gunyah_watchdog-v4-1-7abb1ee11315@oss.qualcomm.com>
 <9421ff80-bd86-4b29-baca-c86da90c91aa@roeck-us.net>
 <wxdglhtsss4it6gfm3d7nngi6aezcvpcs44oa5mlmdwe34d5o2@qlkri6oknnpe>
Content-Language: en-US
From: Hrishabh Rajput <hrishabh.rajput@oss.qualcomm.com>
In-Reply-To: <wxdglhtsss4it6gfm3d7nngi6aezcvpcs44oa5mlmdwe34d5o2@qlkri6oknnpe>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=P7Q3RyAu c=1 sm=1 tr=0 ts=69087b9e cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8
 a=rzB8HjGg_Mo3OrOr0-EA:9 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: 2YwMYdGcji_t4wnP1W9cBU3Ma59m81h5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTAzMDA5MCBTYWx0ZWRfXwpm3LhtXggvp
 RnjxX6gLXHqSo/Qxu2e0/0U3yQ6Mchifu6Fbw0QYLBQFbvjSHopaOCYp2S9XyvyGQSmsXVfQ7wE
 i1R8y8VjhLbbUhxJHGBOVN25wrUY6lE1nu/OIAPHKNVNzqUsRQntdHG8WbZpzaK891qS+UXTbRz
 5UO7I/J+qtd3e1qQwQQhOr8gwIqvLNOkj5aR7L5olQuZucHogopBhIVDSBvKlGsAAP3qoFD5u1w
 GMzHSyDgvJ2dyPblYBA8552Wec0rcMvE/2lW0mb9p0+BPh5bRXHbS+O55dn4Fow1sk6aoYh96K9
 k2RXS6gcDwW9FDoHWVtFy8bUHUEUcAmWQ302VWC25hF/EB43yueAMLbdcsrSsv4bDj2glhzSJrc
 ZmwsmIKcBgDuO8Nk9hE9Z8oEHpN2aw==
X-Proofpoint-ORIG-GUID: 2YwMYdGcji_t4wnP1W9cBU3Ma59m81h5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-03_01,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 bulkscore=0 spamscore=0 phishscore=0
 clxscore=1015 suspectscore=0 adultscore=0 malwarescore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511030090


On 11/2/2025 12:20 AM, Bjorn Andersson wrote:
> On Fri, Oct 31, 2025 at 08:24:44AM -0700, Guenter Roeck wrote:
>> On 10/31/25 03:18, Hrishabh Rajput via B4 Relay wrote:
>>> From: Hrishabh Rajput <hrishabh.rajput@oss.qualcomm.com>
>>>
>>> To restrict gunyah watchdog initialization to Qualcomm platforms,
>>> register the watchdog device in the SMEM driver.
>>>
>>> When Gunyah is not present or Gunyah emulates MMIO-based
>>> watchdog, we expect Qualcomm watchdog or ARM SBSA watchdog device to be
>>> present in the devicetree. If none of these device nodes are detected,
>>> we register the SMC-based Gunyah watchdog device.
>>>
>> There should also be an explanation why there is no "qcom,gunyah-wdt"
>> devicetree node, both here and in the file.
>>
>>> Signed-off-by: Hrishabh Rajput <hrishabh.rajput@oss.qualcomm.com>
>>> ---
>>>    drivers/soc/qcom/smem.c | 37 +++++++++++++++++++++++++++++++++++++
>>>    1 file changed, 37 insertions(+)
>>>
>>> diff --git a/drivers/soc/qcom/smem.c b/drivers/soc/qcom/smem.c
>>> index cf425930539e..40e4749fab02 100644
>>> --- a/drivers/soc/qcom/smem.c
>>> +++ b/drivers/soc/qcom/smem.c
>>> @@ -1118,6 +1118,34 @@ static int qcom_smem_resolve_mem(struct qcom_smem *smem, const char *name,
>>>    	return 0;
>>>    }
>>> +static int register_gunyah_wdt_device(void)
>>> +{
>>> +	struct platform_device *gunyah_wdt_dev;
>>> +	struct device_node *np;
>>> +
>>> +	/*
>>> +	 * When Gunyah is not present or Gunyah is emulating a memory-mapped
>>> +	 * watchdog, either of Qualcomm watchdog or ARM SBSA watchdog will be
>>> +	 * present. Skip initialization of SMC-based Gunyah watchdog if that is
>>> +	 * the case.
>>> +	 */
>>> +	np = of_find_compatible_node(NULL, NULL, "qcom,kpss-wdt");
>>> +	if (np) {
>>> +		of_node_put(np);
>>> +		return 0;
>>> +	}
>>> +
>>> +	np = of_find_compatible_node(NULL, NULL, "arm,sbsa-gwdt");
>>> +	if (np) {
>>> +		of_node_put(np);
>>> +		return 0;
>>> +	}
>>> +
>>> +	gunyah_wdt_dev = platform_device_register_simple("gunyah-wdt", -1,
>>> +							 NULL, 0);
>>> +	return PTR_ERR_OR_ZERO(gunyah_wdt_dev);
>>> +}
>>> +
>>>    static int qcom_smem_probe(struct platform_device *pdev)
>>>    {
>>>    	struct smem_header *header;
>>> @@ -1236,11 +1264,20 @@ static int qcom_smem_probe(struct platform_device *pdev)
>>>    	if (IS_ERR(smem->socinfo))
>>>    		dev_dbg(&pdev->dev, "failed to register socinfo device\n");
>>> +	ret = register_gunyah_wdt_device();
>>> +	if (ret)
>>> +		dev_dbg(&pdev->dev, "failed to register watchdog device\n");
>>> +
>>>    	return 0;
>>>    }
>>>    static void qcom_smem_remove(struct platform_device *pdev)
>>>    {
>>> +	/*
>>> +	 * Gunyah watchdog is intended to be a persistent module. Hence, the
>>> +	 * watchdog device is not unregistered.
>>> +	 */
>>> +
>> Odd explanation.
>> I would assume that the smem device is supposed to be
>> persistent as well.
> Yes, but it's perfectly possible to run a modern Qualcomm device without
> SMEM, with a fair amount of functionality. So, the reevaluation of this
> decision is grinding in the back of my mind...

One option can be the SCM driver which was suggested by Neil in v3 [1].

Let us know if you have any suggestions where we can register the 
watchdog device?

[1]: 
https://lore.kernel.org/lkml/321f5289-64c0-48f1-91b5-c45e82396ca9@linaro.org/

Thanks,

Hrishabh


