Return-Path: <linux-kernel+bounces-604741-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DF1D8A897FC
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Apr 2025 11:29:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 29CA6188FF3C
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Apr 2025 09:29:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15A1F284660;
	Tue, 15 Apr 2025 09:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="HaJ9E2iI"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 765312820DA
	for <linux-kernel@vger.kernel.org>; Tue, 15 Apr 2025 09:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744709371; cv=none; b=j76qbBa6WSZPSYjo9XohJN8QKnsnrHad+gJzWGyqzKFyUi6Texodivbw9O4/I/1BwC3ri6yWANTAHnGRWxShq72G7aQ5EdiCIkCNhIo3FgdcIMxa2wNZRB+86jqvo6Tkd3+cQGmE6ja7n/ZPg7ccYlrvwJF4bwT4ze5ABWXoCFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744709371; c=relaxed/simple;
	bh=NC5DCaREdjauFdpQNc0ev1qolVFUfP5OhphwHgwEVKc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Po0EccKCZ6wawWyom+mhD5Dkm7sR/6I1WyqSmXyblgpiGsXh5plXg31L8/r1xD4btnO0YbGi8YzYGTy0V2rXdE41zvgzV04AJVJYjlgiScDZIvJZsUJ0ONCASz8ncnNXUw5PJwh9SMUmuey2xNBTU46gshJmViuic3aHEcLbmUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=HaJ9E2iI; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53F8tCWS022962
	for <linux-kernel@vger.kernel.org>; Tue, 15 Apr 2025 09:29:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	+DQx+6nDYoMWkFAXLYdIlJNZxYtgpOoe+Wc439AsM1s=; b=HaJ9E2iItwmtVZb7
	hnM/qvXYEnujd45SmZ55VlJ4IF81QQcrspbgH4yuSz7tZoBe9u6y948xZr7vjbZx
	sUP7SNptYAW2RAsIRDuDR6S5wrQhyqbjWoUn9WyCqK82CZcYyl9YYEo5aCO7por3
	N0uBfw0ARjEIlrZox9D1//df7jBQP4VzViZ1NgZ8/+vauZJmvahTTaaSI2Qa5ZcJ
	1KXpeMc9o1b2ITDJ+JPfbAy7JmEZ3dHPJDWKVzNjoecfRz8JJtpBgBj5GpAYG+/0
	ynGW17OczbIwxYwualJ/8ljarFfi+xblNcVlKQ3FDYDWXLLpm5A0OTI03Dp4w0NE
	XK0OYg==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45ygj97fg7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 15 Apr 2025 09:29:28 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-7c548e16909so477848485a.2
        for <linux-kernel@vger.kernel.org>; Tue, 15 Apr 2025 02:29:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744709367; x=1745314167;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+DQx+6nDYoMWkFAXLYdIlJNZxYtgpOoe+Wc439AsM1s=;
        b=S9X3XThY1+OiF8ddCOqdsP6q41mm9sz+pV6DFJPr/bneqKT5ClyqpgH0uTi/B8LSSX
         xvGHboGIXxgQGclF/aoAjB4H0QA/XzTwpSB5bZOqlOERAPprJOFNn42GIze8OVJlcXWI
         dXLlNmVn06qTRvHtSfSOnUp6572EiCx+OcWeUj9UWiQFyzHN47uPRjkNvgvIx5uZ6ezT
         PM96sX3+CNw5k+QTVFxczQS6VWD3Uk2AU2B8vh84pV3R/Ff1C2C4Ceh/Wrm01k6YzIt7
         H6adhTxY6rhwGythNpyIX2rrk+VSDv4CQ4NFVInwTVfu+LX/wKOWIlqq6BrkhigtaNtZ
         sa2w==
X-Forwarded-Encrypted: i=1; AJvYcCVY1PGJMrY/3oBIw+sYh8D2D78YfgqsSR2ritCXUZecrWlRbnyiUQWp4OOft+xBj7jyXkRMcabunxT1B4M=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJO9+MA+agnC/rkw7StgQZjyfyoO9HcPYsY//rEjdMR727TIr5
	EBwZqIaL0vhchAOqzGq2LXJCAEDIX6ILSUcT6gAmnrTPE7Bh/IcpGDeBqatJdCaFuyuClDsWdEv
	kKpvuY6+guVL+lCY1mZQP1gWmzfi7Vd/03GvlIF4PeywAj4vxRxs/aWHg43ZEAVE=
X-Gm-Gg: ASbGncsL7hZv2Yirj6BHPiinBE57W5+AMctSpOWbDSzbs2RgzJ1mmh7fOh9cSqUqaTZ
	RAaLoJv9L+j6yeDtRmRXqJlk+QyMVUdOILnGRBUWuAOYNmuwOgpojeJrvybm+xmOH4XE+NVnICg
	HDUHdlPYSbcg9OHnn82vjUH/BXp1m0hmjPhekew62d8DEJZsvxg5xZCwPgxXYZKGQZhef9t2yyQ
	23RvZ/9vmlt/KOi6lBdVWuy46/9qM5Lg6tIJ6huS4DX0+sTOVwbfxng4akYEj0QbTT/ndS1As45
	yd41XYDVvZioA4npkbpxZaBeTLuwmh6qhBJa1EoPIXLkmeax4JfCIpmAyYyH+WK68WNdM5BhoXr
	BMaPRcSM/Ua96AlpktR2u5ckw76ZqoirLH23GQE6CtoFpiNF+/7y/kNuA9Pau
X-Received: by 2002:a05:620a:4316:b0:7c5:60c7:346 with SMTP id af79cd13be357-7c7af0b97c3mr2006009685a.10.1744709367189;
        Tue, 15 Apr 2025 02:29:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFujg27qdYNPJcN55cZ+HIN0mfrHoNU47hlImWynWN+yTG5SH9uM9PPLNNq6/CYxgOEVjDfag==
X-Received: by 2002:a05:620a:4316:b0:7c5:60c7:346 with SMTP id af79cd13be357-7c7af0b97c3mr2006006985a.10.1744709366781;
        Tue, 15 Apr 2025 02:29:26 -0700 (PDT)
Received: from ?IPV6:2001:14bb:aa:77bc:64e0:30e4:f6ff:5bd? (2001-14bb-aa-77bc-64e0-30e4-f6ff-5bd.rev.dnainternet.fi. [2001:14bb:aa:77bc:64e0:30e4:f6ff:5bd])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54d3d50270csm1387967e87.114.2025.04.15.02.29.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Apr 2025 02:29:25 -0700 (PDT)
Message-ID: <c2ec6b7c-421d-43c3-8c0a-de4f7bdd867c@oss.qualcomm.com>
Date: Tue, 15 Apr 2025 12:29:23 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 4/9] phy: qcom-qmp-ufs: Refactor UFS PHY reset
To: Nitin Rawat <quic_nitirawa@quicinc.com>
Cc: vkoul@kernel.org, kishon@kernel.org, manivannan.sadhasivam@linaro.org,
        James.Bottomley@hansenpartnership.com, martin.petersen@oracle.com,
        bvanassche@acm.org, bjorande@quicinc.com, neil.armstrong@linaro.org,
        konrad.dybcio@oss.qualcomm.com, quic_rdwivedi@quicinc.com,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
References: <20250410090102.20781-1-quic_nitirawa@quicinc.com>
 <20250410090102.20781-5-quic_nitirawa@quicinc.com>
 <pur4y63xhfmqlyymg4pehk37ry4gg22h24zceoqjbsxp3hj4yf@4kptase3c4qp>
 <317faeaa-3130-4e28-8c5d-441a76aa79b4@quicinc.com>
 <CAO9ioeXnnbNzriVOYPUeBiWdrPfYUcMk+pVWYv0vZpJbFeByoQ@mail.gmail.com>
 <2820908b-4548-4e0a-94b2-6065cb5ff1f3@quicinc.com>
Content-Language: en-US
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
In-Reply-To: <2820908b-4548-4e0a-94b2-6065cb5ff1f3@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: KRH9ytbmN2ea3wDA8WSrGThuJrdVn0-0
X-Authority-Analysis: v=2.4 cv=PruTbxM3 c=1 sm=1 tr=0 ts=67fe26f8 cx=c_pps a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=COk6AnOGAAAA:8 a=BcQP8Xzm53tihf4Fw6EA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: KRH9ytbmN2ea3wDA8WSrGThuJrdVn0-0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-15_04,2025-04-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 bulkscore=0
 priorityscore=1501 malwarescore=0 adultscore=0 lowpriorityscore=0
 impostorscore=0 clxscore=1015 spamscore=0 mlxscore=0 mlxlogscore=999
 phishscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504150065

On 14/04/2025 23:34, Nitin Rawat wrote:
> 
> 
> On 4/11/2025 4:38 PM, Dmitry Baryshkov wrote:
>> On Fri, 11 Apr 2025 at 13:50, Nitin Rawat <quic_nitirawa@quicinc.com> 
>> wrote:
>>>
>>>
>>>
>>> On 4/11/2025 1:38 AM, Dmitry Baryshkov wrote:
>>>> On Thu, Apr 10, 2025 at 02:30:57PM +0530, Nitin Rawat wrote:
>>>>> Refactor the UFS PHY reset handling to parse the reset logic only once
>>>>> during probe, instead of every resume.
>>>>>
>>>>> Move the UFS PHY reset parsing logic from qmp_phy_power_on to
>>>>> qmp_ufs_probe to avoid unnecessary parsing during resume.
>>>>
>>>> How did you solve the circular dependency issue being noted below?
>>>
>>> Hi Dmitry,
>>> As part of my patch, I moved the parsing logic from qmp_phy_power_on to
>>> qmp_ufs_probe to avoid unnecessary parsing during resume. I'm uncertain
>>> about the circular dependency issue and whether if it still exists.
>>
>> It surely does. The reset controller is registered in the beginning of
>> ufs_qcom_init() and the PHY is acquired only a few lines below. It
>> creates a very small window for PHY driver to probe.
>> Which means, NAK, this patch doesn't look acceptable.
> 
> Hi Dmitry,
> 
> Thanks for pointing this out. I agree that it leaves very little time 
> for the PHY to probe, which may cause issues with targets where 
> no_pcs_sw_reset is set to true.
> 
> As an experiment, I kept no_pcs_sw_reset set to true for the SM8750, and 
> it caused bootup probe issues in some of the iterations I ran.
> 
> To address this, I propose updating the patch to move the 
> qmp_ufs_get_phy_reset call to phy_calibrate, just before the 
> reset_control_assert call.

Will it cause an issue if we move it to phy_init() instead of 
phy_calibrate()?

> 
> This change will delay the UFS PHY reset as much as possible in the 
> code. Additionally, moving it from phy_power_on to calibrate will ensure 
> that qmp_ufs_get_phy_reset is called only once during boot, rather than 
> during each phy_power_on call.
> 
> Please let me know your thoughts.
> =====================================================================================================
>   static int qmp_ufs_phy_calibrate(struct phy *phy)
>   {
>          struct qmp_ufs *qmp = phy_get_drvdata(phy);
> @@ -1793,6 +1826,12 @@ static int qmp_ufs_phy_calibrate(struct phy *phy)
>          unsigned int val;
>          int ret;
> 
> +       pr_err("%s %d\n", __func__, __LINE__);
> +
> +       ret = qmp_ufs_get_phy_reset(qmp);
> +        if (ret)
> +                return ret;
> +
>          ret = reset_control_assert(qmp->ufs_reset);
>          if (ret)
>                  return ret;
> @@ -1817,7 +1856,7 @@ static int qmp_ufs_phy_calibrate(struct phy *phy)
>                  dev_err(qmp->dev, "phy initialization timed-out\n");
>                  return ret;
> =====================================================================================================
> 
> 
> Regards.
> Nitin
>>
>>>
>>> Regards,
>>> Nitin
>>>
>>>
>>>>
>>>>>
>>>>> Co-developed-by: Ram Kumar Dwivedi <quic_rdwivedi@quicinc.com>
>>>>> Signed-off-by: Ram Kumar Dwivedi <quic_rdwivedi@quicinc.com>
>>>>> Signed-off-by: Nitin Rawat <quic_nitirawa@quicinc.com>
>>>>> ---
>>>>>    drivers/phy/qualcomm/phy-qcom-qmp-ufs.c | 61 ++++++++++++ 
>>>>> +------------
>>>>>    1 file changed, 33 insertions(+), 28 deletions(-)
>>>>>
>>>>> diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-ufs.c b/drivers/phy/ 
>>>>> qualcomm/phy-qcom-qmp-ufs.c
>>>>> index 636dc3dc3ea8..12dad28cc1bd 100644
>>>>> --- a/drivers/phy/qualcomm/phy-qcom-qmp-ufs.c
>>>>> +++ b/drivers/phy/qualcomm/phy-qcom-qmp-ufs.c
>>>>> @@ -1799,38 +1799,11 @@ static int qmp_ufs_com_exit(struct qmp_ufs 
>>>>> *qmp)
>>>>>    static int qmp_ufs_power_on(struct phy *phy)
>>>>>    {
>>>>>       struct qmp_ufs *qmp = phy_get_drvdata(phy);
>>>>> -    const struct qmp_phy_cfg *cfg = qmp->cfg;
>>>>>       int ret;
>>>>>       dev_vdbg(qmp->dev, "Initializing QMP phy\n");
>>>>>
>>>>> -    if (cfg->no_pcs_sw_reset) {
>>>>> -            /*
>>>>> -             * Get UFS reset, which is delayed until now to avoid a
>>>>> -             * circular dependency where UFS needs its PHY, but 
>>>>> the PHY
>>>>> -             * needs this UFS reset.
>>>>> -             */
>>>>> -            if (!qmp->ufs_reset) {
>>>>> -                    qmp->ufs_reset =
>>>>> -                            devm_reset_control_get_exclusive(qmp- 
>>>>> >dev,
>>>>> -                                                             
>>>>> "ufsphy");
>>>>> -
>>>>> -                    if (IS_ERR(qmp->ufs_reset)) {
>>>>> -                            ret = PTR_ERR(qmp->ufs_reset);
>>>>> -                            dev_err(qmp->dev,
>>>>> -                                    "failed to get UFS reset: %d\n",
>>>>> -                                    ret);
>>>>> -
>>>>> -                            qmp->ufs_reset = NULL;
>>>>> -                            return ret;
>>>>> -                    }
>>>>> -            }
>>>>> -    }
>>>>> -
>>>>>       ret = qmp_ufs_com_init(qmp);
>>>>> -    if (ret)
>>>>> -            return ret;
>>>>> -
>>>>> -    return 0;
>>>>> +    return ret;
>>>>>    }
>>>>>
>>>>>    static int qmp_ufs_phy_calibrate(struct phy *phy)
>>>>> @@ -2088,6 +2061,34 @@ static int qmp_ufs_parse_dt(struct qmp_ufs 
>>>>> *qmp)
>>>>>       return 0;
>>>>>    }
>>>>>
>>>>> +static int qmp_ufs_get_phy_reset(struct qmp_ufs *qmp)
>>>>> +{
>>>>> +    const struct qmp_phy_cfg *cfg = qmp->cfg;
>>>>> +    int ret;
>>>>> +
>>>>> +    if (!cfg->no_pcs_sw_reset)
>>>>> +            return 0;
>>>>> +
>>>>> +    /*
>>>>> +     * Get UFS reset, which is delayed until now to avoid a
>>>>> +     * circular dependency where UFS needs its PHY, but the PHY
>>>>> +     * needs this UFS reset.
>>>>> +     */
>>>>> +    if (!qmp->ufs_reset) {
>>>>> +            qmp->ufs_reset =
>>>>> +            devm_reset_control_get_exclusive(qmp->dev, "ufsphy");
>>>>
>>>> Strange indentation.
>>>>
>>>>> +
>>>>> +            if (IS_ERR(qmp->ufs_reset)) {
>>>>> +                    ret = PTR_ERR(qmp->ufs_reset);
>>>>> +                    dev_err(qmp->dev, "failed to get PHY reset: 
>>>>> %d\n", ret);
>>>>> +                    qmp->ufs_reset = NULL;
>>>>> +                    return ret;
>>>>> +            }
>>>>> +    }
>>>>> +
>>>>> +    return 0;
>>>>> +}
>>>>> +
>>>>>    static int qmp_ufs_probe(struct platform_device *pdev)
>>>>>    {
>>>>>       struct device *dev = &pdev->dev;
>>>>> @@ -2114,6 +2115,10 @@ static int qmp_ufs_probe(struct 
>>>>> platform_device *pdev)
>>>>>       if (ret)
>>>>>               return ret;
>>>>>
>>>>> +    ret = qmp_ufs_get_phy_reset(qmp);
>>>>> +    if (ret)
>>>>> +            return ret;
>>>>> +
>>>>>       /* Check for legacy binding with child node. */
>>>>>       np = of_get_next_available_child(dev->of_node, NULL);
>>>>>       if (np) {
>>>>> -- 
>>>>> 2.48.1
>>>>>
>>>>
>>>
>>
>>
> 


-- 
With best wishes
Dmitry

