Return-Path: <linux-kernel+bounces-775061-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 24B18B2BAD4
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 09:34:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BD43C7AA76D
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 07:31:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1CA626F443;
	Tue, 19 Aug 2025 07:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="NSTtg6xn"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D723223DC6
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 07:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755588783; cv=none; b=M4hljbcsmYcL48OI1X0Km7Nk58D65p5ZFuIv20PkUb1wd/rF34CR9Nx1VqWdgqaB6nVMfIASWsi1q5vvsBFxle4NHH/oTOLBTCUjJo1d2haMZevB1hsmbElA7ofRVt4pCdtJIUAmbeg+VOaQBJKKITgzTpRGshSWtLy1SvXDWn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755588783; c=relaxed/simple;
	bh=7LtQWvcQJhrI24KKihIlYQ+gpANvE9h2hMEGq8NEW+Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YC6Leah5zpfVaQtuWnuMA9gY+iIC+k7rB5OZKtyJ71VFei1uSUpBW28pul9zAwLcRBpqL0s2uIYc2ADrCdmcO+Vebns6ydD4itBuJaKcxHZBAUaYm37W70wNTatSW1IvvNaEuEQvo6qOcQgGiDDaMJyhmssRzGBQTMARuaQKfF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=NSTtg6xn; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57J0veCG003400
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 07:33:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ZX4WHq0FHGuUzi7xR9JeLuPrT8yDI2/1ljZuVcjfQm8=; b=NSTtg6xnzXxYa0kH
	8N/Jl0r+Xq75clwMHnd5LFr21nLPlHJ4FJT+hTd3glAdegUGxZ2O2MJX33ZxZFWG
	fmn/JNLUW6Ef/jQ92sM0OIQoDVXYl53KDrGSRt90gKHKpNgapHOkSIvyFxJaGggt
	xbwVrs+h0ChA1wNj3feLRbsagfoIZKabNqFm4OD8yIuiTVcCOLh1Xz3UtRLLEssW
	KKcWbq2iJd/59RYhpz9qsZZOzR+s9cTgAuzmOFcfwnmFpKPOybM9Uci6eMRPK5sF
	BxUqa2RdOrQx/iBa4tY73Xyz9OpuFrqplXhwFMGCD51sl+8iY979EfvNmuvFPBZU
	0buA5A==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48jhjyfn2c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 07:33:00 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-323266ce853so9314151a91.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 00:33:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755588779; x=1756193579;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZX4WHq0FHGuUzi7xR9JeLuPrT8yDI2/1ljZuVcjfQm8=;
        b=Hr4wbAmSY76XUL6dEO2aAyLgDphqXcOB+zk3Mb+LJW/EDDiTpt8a9/ELfhwylrTlBj
         C5ke35cQlTqD3SznP9srzFUkghU/QCsW6lrQxcQ1ISqzhf0alTIW4Hm4+ZA3a/+2IJN+
         YIO4nUziVesASJULAAiGlwDpUZsfu3KwGdBk80ileIV/+viUtsHWScC1Yp0HyEUZRcrj
         Y18OzJ2lFnz/ZQz1G0a4RZ3A9pWSsLvmtyCDrOValI/v/6Rep4FGqLQv9xl3X7jODjVS
         AgCfGZOyTPiDwmL4JU+pFvfwKRpGJaGI5aabWA6JMELQEvgZCpN0nQ9GLpKkVL4pIGaP
         RFfA==
X-Forwarded-Encrypted: i=1; AJvYcCVJYeUQyclsz7vOZPcQScNS7q9Cn1WGcbmxMs47yuHWwAgHNx5+80uPeGJVsmTYd250toaSxzK9VpWY2Nk=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywj4rnsEB9KzGk9Ia9ZEaGh06MgjdWr2HW5Tb2bxi0xVpGP/VeZ
	DJ8Cg8wMfoihqxvY6rrfgn87lbH3aucRmymHQ9mAug1t3rm8Q48XuOYNhCqT+c+qeVQpCLM7I55
	g3ylEqw30O4lrt9Zy/JsQyTVRvqJmTthnKnSyf77YK/b5YnHgu9KqqfSVdy9ZsyBnErk=
X-Gm-Gg: ASbGncssBilk+6gRmIKWZChUGrFfkSrnBbKQMnumcDO4aw7vy6332Y1CRpDUMnfDmae
	u1p0hfmsmXW8NvhYCOaAFPWV/GPOoiW9Wi5+NnB+ylljzMM7wlll4S88pcoQX2RiqAy5hSv22GL
	CNGI/QsAj8qUxrn6K6kzolse26VFu7YZAavPVLNVl6fWpBIQ8FKfH3HJJaMHvV4teqDJzLcdS3S
	m/TCkyoEQhXtVe/eWrFkzh5Hw8cpH1k5fpWq8JJUc0s+6coWCmQr9YYqTuhS2C+qWRFsKy9RCEJ
	iK0N/6JQVVZGCFXA0898GD6D/WyJQb8hkeoPYKDLo/HCXT934NlYFA/tupsacpdUAwg5IRHjFbE
	cRlRvqM8ty6+Bmc+ZgPhaWXrPlhizQmRc
X-Received: by 2002:a17:90b:560b:b0:321:a2cf:9da9 with SMTP id 98e67ed59e1d1-32476a4fd20mr2605852a91.15.1755588779167;
        Tue, 19 Aug 2025 00:32:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGhfH3UlxhiOYhnFv9vS+sUYiu5emcuumytoT8Wd2+lqdseeUtaxzogf3ZBo6T/gdJDJ/I08Q==
X-Received: by 2002:a17:90b:560b:b0:321:a2cf:9da9 with SMTP id 98e67ed59e1d1-32476a4fd20mr2605819a91.15.1755588778666;
        Tue, 19 Aug 2025 00:32:58 -0700 (PDT)
Received: from [10.133.33.73] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3237e3c3063sm1988856a91.1.2025.08.19.00.32.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Aug 2025 00:32:58 -0700 (PDT)
Message-ID: <754f2025-11da-4747-a98a-74c992006946@oss.qualcomm.com>
Date: Tue, 19 Aug 2025 15:32:53 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] coresight-tnoc: Add runtime PM support for
 Interconnect TNOC
To: Leo Yan <leo.yan@arm.com>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        James Clark <james.clark@linaro.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        kernel@oss.qualcomm.com, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250815-itnoc-v1-0-62c8e4f7ad32@oss.qualcomm.com>
 <20250815-itnoc-v1-3-62c8e4f7ad32@oss.qualcomm.com>
 <20250818143011.GB8071@e132581.arm.com>
Content-Language: en-US
From: yuanfang zhang <yuanfang.zhang@oss.qualcomm.com>
In-Reply-To: <20250818143011.GB8071@e132581.arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: rQ7g2fpTowPUgk-WovpTt_MACE5hv6Al
X-Authority-Analysis: v=2.4 cv=ZJHXmW7b c=1 sm=1 tr=0 ts=68a428ac cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8
 a=Zm1HM0GOZpLsNU_EOA4A:9 a=QEXdDO2ut3YA:10 a=iS9zxrgQBfv6-_F4QbHw:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: rQ7g2fpTowPUgk-WovpTt_MACE5hv6Al
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE2MDAyOCBTYWx0ZWRfX0wo0pMlcOvL3
 dCYoYcXsm1iRtHkm4U+JuLAQQUG6/ip+gtntfe4KsLwmaa8BghVHqZ1wYq6UBTZtc+F7gU9nWbq
 ImKoLKZutAtWtKFXeYd3fxvj7XlCj6OwZw2fGOJQ5vrJEjp7GjzmuWPuniz2vZaMmPUWqJ+g+7O
 d4Nq2CcbfEXjvUK1EvcoI1RIH97rcFBz3ant8OQM/lyctkFrgoQ3SBr+AGPkcEQdWXeGNTec+M6
 XNg7sqUO4Pbkg8bUM6+oT7HlMv4O3nCdi0xw4HTbgFh3D46Oktli5ur/yTxule0keKyILahxADi
 Cn+6WZWpDtoeAvzL2Kt+6iodH+QLoyN9qtC4UeNjwquf0tZyqVN+Ao/n6nTEKpfXSnrr4RewUjE
 VLGfZpLd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-19_01,2025-08-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 phishscore=0 suspectscore=0 clxscore=1015
 bulkscore=0 spamscore=0 impostorscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508160028



On 8/18/2025 10:30 PM, Leo Yan wrote:
> On Fri, Aug 15, 2025 at 06:18:14AM -0700, Yuanfang Zhang wrote:
>> This patch adds runtime power management support for platform-based
>> CoreSight Interconnect TNOC (ITNOC) devices. It introduces suspend and
>> resume callbacks to manage the APB clock (`pclk`) during device runtime
>> transitions.
>>
>> Signed-off-by: Yuanfang Zhang <yuanfang.zhang@oss.qualcomm.com>
>> ---
>>  drivers/hwtracing/coresight/coresight-tnoc.c | 26 ++++++++++++++++++++++++++
>>  1 file changed, 26 insertions(+)
>>
>> diff --git a/drivers/hwtracing/coresight/coresight-tnoc.c b/drivers/hwtracing/coresight/coresight-tnoc.c
>> index aa6f48d838c00d71eff22c18e34e00b93755fd82..f12a1698824bc678545319a3f482fd27e67a7352 100644
>> --- a/drivers/hwtracing/coresight/coresight-tnoc.c
>> +++ b/drivers/hwtracing/coresight/coresight-tnoc.c
>> @@ -270,6 +270,31 @@ static void itnoc_remove(struct platform_device *pdev)
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
>> +	int ret;
>> +
>> +	ret = clk_prepare_enable(drvdata->pclk);
>> +
>> +	return ret;
> 
> Here can be simplified:
> 
>     return clk_prepare_enable(drvdata->pclk);
> 
sure, will update.
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
>> @@ -282,6 +307,7 @@ static struct platform_driver itnoc_driver = {
>>  	.driver = {
>>  		.name = "coresight-itnoc",
>>  		.of_match_table = itnoc_of_match,
>> +		.pm = &itnoc_dev_pm_ops,
>>  	},
>>  };
>>  
>>
>> -- 
>> 2.34.1
>>
>> _______________________________________________
>> CoreSight mailing list -- coresight@lists.linaro.org
>> To unsubscribe send an email to coresight-leave@lists.linaro.org


