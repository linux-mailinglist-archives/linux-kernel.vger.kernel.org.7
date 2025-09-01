Return-Path: <linux-kernel+bounces-794089-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0504EB3DCB3
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 10:39:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B458F3B600E
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 08:39:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 623252FB604;
	Mon,  1 Sep 2025 08:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="jy05AZlF"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1A192FB608
	for <linux-kernel@vger.kernel.org>; Mon,  1 Sep 2025 08:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756715927; cv=none; b=HUYvL5PPz3HlwFGp8hB08Zquv12dfUAc5RMx+/8+2wFxUgm8p7VeNDx1Wob5yQp5zoSmoWNNdLXpwBf6LOFK7DnTlqhbpfEe+XwWe2O0+r2KGayoCH91PbySJF9fXRHTfvdivPadTVhr5AkPWAHh0t+9x5UG29nunt8q15lnxpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756715927; c=relaxed/simple;
	bh=ZO87uo9IYsZLjjt/l7L32ClnCZ4s/EkhmsCq9kk/UMQ=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=RI//Ct6++1B+e6+x6lsApqwaTBsPOU11lNXSrmmJhxdBPKOAft/hDd327uiu9zIr1JVs4Vix7bpRV5G+Qh5i0WftxaNK7Qbn5fPWCoTQJ+M7R0/SMprENF8QX2xHA6FRu9JbgxnxifxlVzYxsFFPOvq2tYFMgXHyFBfIQ/WsmPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=jy05AZlF; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5818P4JA004729
	for <linux-kernel@vger.kernel.org>; Mon, 1 Sep 2025 08:38:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	1J076/LQgI+3eWtUeFftMALqG6G2irnWWLjDqPX+63E=; b=jy05AZlF4U+KbBD4
	TfBvoLftuB4zowARI2w17Xd4334aLgFV0N9EiseTD7BVYVyt1s2s98olfk/rRQ61
	E8BHwT8h/dV70f0+LnMtzZWxg6J0NoiJzfF8H65Cd0UJUgTU9ifXOx/Ur731Sece
	+H39Ax6zrPz/8EE8+xbiW7RA6aWd4iWbixllIWW91gw/G1f7fNREVAH/7ea+IOlq
	Lzma4heZYFjyDENVOOJ5CqDN0AXAd076JioKunxRpsRwLnw9nAwM8gwNeBlIHnJ0
	zA8NbzZlhvhdKiX7peQ7J8+7PD+QmQD8ATQMLkcxMMhmIRqJ4qYIUyvhBxi4Z02u
	F0Dwwg==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48usp7uxm5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 01 Sep 2025 08:38:44 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-772537d9f4aso1136809b3a.2
        for <linux-kernel@vger.kernel.org>; Mon, 01 Sep 2025 01:38:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756715923; x=1757320723;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1J076/LQgI+3eWtUeFftMALqG6G2irnWWLjDqPX+63E=;
        b=UC3KqMTOchAuM4jJZRgsVCBd9Vzbh5PBpIiZ21tuobN/zP9qVxfDjSgMyHRKg1ftSC
         2eGCf/ZguEgccqB83lFe4gmxvbdeAerIInqj6LElLV4KGXHqLDbh9md7qbnE5TCWdSI5
         MpBZzDkQybyrZmyDORIGD8kHlktzcknDKeIuFvUiztj46BxjFR00as6GlccHBss3lDqt
         2T3Jwtuvb+gwc/sTAW/ijcvO0jGAK4LhkBHlBzFmpsHPZP4oSyHZUeRtqGnEoMH4u9uf
         MK7Z0mrVl+zS77Dh5kH8UtIVG54/4BnAdCUeDOT+TMmF1rlM6fI/O12fqosF1WV3Dljc
         hflA==
X-Forwarded-Encrypted: i=1; AJvYcCV5ODJTCIiOC0+p4uZOCs/q9lInnC6BzalciiIYT/oYS3FKvN64i9RgwL1dAzhuw7sDvFinyaRjkqw0akk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRHiSf9kyDF28mCcq46GXuekBmq4PJiQuHNYgo1I30B1gpc+je
	xW5BwIsOHbWQFgTe5tvz3ghrWKcXHyHFlP9luIeuF0z8OU3ju3kyCgGvRnchKjeG2pBBtuJhp/O
	85yJ0xuTyDFEnFR42P9J245JS4wvCIoGd7Jk0qDHUdNZ3Vc4N10HdnrNDyjA97BcjOME=
X-Gm-Gg: ASbGncutwRKcx8vovhzyXFzuoklHCz+qhnKjfM9GHasYHiqAENYbChrJfwIWSNCOENq
	+aV13nIinesscCaCBqxxs/uPHU4NGY5ebqfeLt0KmO9Kattg438K15zVIRchLbPFnz3LHHxJx1o
	H2YbaKe6EDR0bG0PcptZ/pgEUCixrblZ2wPbtHMoZyAO+ceqB7EV/R/45Jp72q8cxxWxnnlUBFz
	PxLv/zWv2nKz0M7mCblb+rWfH4GmAS2JNjmeNTVjYgfXnApyfY+quAdRfvWYCYii+6ZwQHFyLhu
	312LsWynJ4V9yCr9o88hx8T2ERuGKjnJpeL3NzLFF28cYP+dwlJXXkHta0e5WLaVnLTmlz+ViKx
	VTVe2AObbt0IeGM0sNQunCZhpktoY7ecKSg==
X-Received: by 2002:a05:6a00:1789:b0:772:2e00:831f with SMTP id d2e1a72fcca58-7723e1f1deemr10329859b3a.4.1756715923372;
        Mon, 01 Sep 2025 01:38:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHsvQVbqKRANvlU7zeqIf181vFzHz2jPH5oH4pRglmEHl2qc84zDD29EMGRW7zDIDTyLCRwSA==
X-Received: by 2002:a05:6a00:1789:b0:772:2e00:831f with SMTP id d2e1a72fcca58-7723e1f1deemr10329810b3a.4.1756715922864;
        Mon, 01 Sep 2025 01:38:42 -0700 (PDT)
Received: from [10.133.33.247] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7722a4beb72sm9925996b3a.61.2025.09.01.01.38.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Sep 2025 01:38:42 -0700 (PDT)
Message-ID: <15147896-1378-4a3d-85ba-4258046f9e31@oss.qualcomm.com>
Date: Mon, 1 Sep 2025 16:38:39 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/3] coresight-tnoc: Add runtime PM support for
 Interconnect TNOC
From: yuanfang zhang <yuanfang.zhang@oss.qualcomm.com>
To: Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        James Clark <james.clark@linaro.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: kernel@oss.qualcomm.com, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250831-itnoc-v4-0-f0fb0ef822a5@oss.qualcomm.com>
 <20250831-itnoc-v4-3-f0fb0ef822a5@oss.qualcomm.com>
 <b608b4b2-f850-4b49-be65-b2f4e3784dd5@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <b608b4b2-f850-4b49-be65-b2f4e3784dd5@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAzNCBTYWx0ZWRfX7il38wz3EMFg
 RlJEdw9LUZm1ITAxjEOviBYwyUvHVvXmWOvA24OpzfaUZUaUkcJuxg/yoMqDqwd8vnsSZ9TeVrm
 B5yZnnFZfbARNcYfJfVRRQKwUwDQIxyYUGJgoirhEXKVKJKH0Cbf/8dL60pTMO3pN7UXINAFkbn
 QGu4N6XDJ9CH8KwsWur31wdAgECfl/iB7m42Btr8GavocpQicwnqiRiFOERQH6HKyMvko33O6hd
 3eLuhmJRvoDe+njo93/5te6irqrT4eucZZicCVQBJFficIiWBCFVf3vaS3uRblQUsaY+Ws8Sbqr
 7zYMa96aaYswMGVWl0cz5h6jRED4LTaRcpjqjM0loHX6Ozfxg2Q7uF+9eEIkmrMP+I913x70Lrr
 eXt/goLP
X-Authority-Analysis: v=2.4 cv=e6wGSbp/ c=1 sm=1 tr=0 ts=68b55b94 cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=7CQSdrXTAAAA:8
 a=ZZ2O94ThGh-PlZ2E-5gA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=OpyuDcXvxspvyRM73sMx:22 a=a-qgeE7W1pNrGK8U0ZQC:22
X-Proofpoint-GUID: eylrineb3fBvFpFWvNrLWuTKqeI7NvKV
X-Proofpoint-ORIG-GUID: eylrineb3fBvFpFWvNrLWuTKqeI7NvKV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-01_04,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 spamscore=0 clxscore=1015 phishscore=0
 malwarescore=0 bulkscore=0 suspectscore=0 adultscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508300034

Dear all,

Apologies — I mistakenly included an unintended attachment in my previous reply regarding the patch submission.

Please disregard the attachment; it is not relevant to the discussion.

Thank you for your understanding.

Best regards,
Yuanfang Zhang

On 9/1/2025 4:30 PM, yuanfang zhang wrote:
> On 9/1/2025 2:58 PM, Yuanfang Zhang wrote:
>> This patch adds runtime power management support for platform-based
>> CoreSight Interconnect TNOC (ITNOC) devices. It introduces suspend and
>> resume callbacks to manage the APB clock (`pclk`) during device runtime
>> transitions.
>>
>> Signed-off-by: Yuanfang Zhang <yuanfang.zhang@oss.qualcomm.com>
>> ---
>>  drivers/hwtracing/coresight/coresight-tnoc.c | 23 +++++++++++++++++++++++
>>  1 file changed, 23 insertions(+)
>>
>> diff --git a/drivers/hwtracing/coresight/coresight-tnoc.c b/drivers/hwtracing/coresight/coresight-tnoc.c
>> index 5be882300d79bc0173aa6a19d7da1d48c4aaca9c..2c5370497076536bfa868f0d80db775ef242968b 100644
>> --- a/drivers/hwtracing/coresight/coresight-tnoc.c
>> +++ b/drivers/hwtracing/coresight/coresight-tnoc.c
>> @@ -301,6 +301,28 @@ static void itnoc_remove(struct platform_device *pdev)
>>  	pm_runtime_disable(&pdev->dev);
>>  }
>>  
>> +#ifdef CONFIG_PM
>> +static int itnoc_runtime_suspend(struct device *dev)
>> +{
>> +	struct trace_noc_drvdata *drvdata = dev_get_drvdata(dev);
>> +
>> +	clk_disable_unprepare(drvdata->pclk);
>> +
>> +	return 0;
>> +}
>> +
>> +static int itnoc_runtime_resume(struct device *dev)
>> +{
>> +	struct trace_noc_drvdata *drvdata = dev_get_drvdata(dev);
>> +
>> +	return clk_prepare_enable(drvdata->pclk);
>> +}
>> +#endif
>> +
>> +static const struct dev_pm_ops itnoc_dev_pm_ops = {
>> +	SET_RUNTIME_PM_OPS(itnoc_runtime_suspend, itnoc_runtime_resume, NULL)
>> +};
>> +
>>  static const struct of_device_id itnoc_of_match[] = {
>>  	{ .compatible = "qcom,coresight-itnoc" },
>>  	{}
>> @@ -314,6 +336,7 @@ static struct platform_driver itnoc_driver = {
>>  		.name = "coresight-itnoc",
>>  		.of_match_table = itnoc_of_match,
>>  		.suppress_bind_attrs = true,
>> +		.pm = &itnoc_dev_pm_ops,
>>  	},
>>  };
>>  
>>
> 
> missed Reviewed-by: Leo Yan <leo.yan@arm.com> tag.
> 
> thanks,
> yuanfang.


