Return-Path: <linux-kernel+bounces-757444-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ABF2B1C233
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 10:32:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 329843AFFB2
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 08:32:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36945286D4B;
	Wed,  6 Aug 2025 08:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="iEjhkFMU"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0DEC285CBA
	for <linux-kernel@vger.kernel.org>; Wed,  6 Aug 2025 08:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754469140; cv=none; b=sWqZLoH1VST648yi+krtn6I2iplhENtY/xVlwA0IroREVfg1jxJWgiCVqsmQJ/ahOQTEt0hzSrewzksfaU//UPbfMiXZZ6zGiU4UwCnXlBt4QetFtZ9fpdKgvtkwLbrV9XvE12W5Kc1VX2QGreN1P7mfAUp5tpGwlJku+IAo8Bg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754469140; c=relaxed/simple;
	bh=Gx9xYOEF6Hf8A4r6Jo6DWJlA8lab2iYthQr2Pd1bih8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Oq7U5FLohMW4Z+BWxYUzF8ED97rpuVjmYV5xKuHotOBpPd5GslHVm39yBtJaSQaSAYSbIW/MdFUUiLFFvNsRLJJKlTeG525Fx9+6S4OnVDQHM98z7ceQPnHNhkzgE5a5uXPPEk+Cq4pJHpuK/9xsFWWObjZ6uL6CvnjbDE2KteY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=iEjhkFMU; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5765j1u3028373
	for <linux-kernel@vger.kernel.org>; Wed, 6 Aug 2025 08:32:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	gVl7KxhpUlQVfwGSCI7uwJIxFW0XwW0xZf2nUDVHT9c=; b=iEjhkFMUTvcNo9ab
	GOcPwI87/CjUigO4zD+nwaSU3vs3ZnMjZKoct81/nobk5IjdSWYZMHGegA1zr9Xp
	Lnw+xq1wj/kyL7YsE0CV6nqYE1UUpQoglz7N1EjgCAOv8ckeGtOj+R8HKaymqXhV
	CIV7FYDSWg/iLq4NI5wgsSFABUwg5NF0m3RRilELVin+mXRU21CgkQeQGWz3owbV
	DEwI1Z90KmzvqVtb/KKCLM/0gXfsPs6zmzUHjuT0oLuxEdN7lF6NG++lwFM//S8i
	AicbCtS37zT9JNFeyMBMlb0HDP+DwNi42iMjtM2XK+5DcjBNrUCcDCmg6Cjj39+f
	2uk3Jw==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48bpvxt40s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 06 Aug 2025 08:32:17 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-b423dcff27aso8022226a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 06 Aug 2025 01:32:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754469136; x=1755073936;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gVl7KxhpUlQVfwGSCI7uwJIxFW0XwW0xZf2nUDVHT9c=;
        b=o13Sp8UVCgF0Y2HI9Vedq9/l1NsDJjg6bFh5sXn7Q288evjcyhejxKGiy1myXgvAWf
         XCNcVKICiw8f3XDLyosMIClve6H/Iu1eEjaIV1j9QXxf2aWxAPreOOtOMkTrHKXPMAbL
         p0hC+mbnRCLbQZcJLj73dteR34YhtKKiwtOw+T69FM0Ce1G2cPUNxupqb3UV5H71X4yv
         buIrHs5zBYHfS8Mb3mCn6Klje3gx6aZS3bShn+K/yBU+aakF797oyYUEE2MJZ1UoW+Ic
         RoTrpycNklhaUlvw5kolO6cxhbjyma1WfOUuwMwpduCNjT5wq8phCGe9FIWZp2jTD/Lc
         CGlg==
X-Forwarded-Encrypted: i=1; AJvYcCXcAPhJQh/jhsohs33mOXFvVPr+pUC/LxkkQlmNtk9DMFuaAqo5kUbbuaZFAYkm1RERgGpO70kOj5II49o=@vger.kernel.org
X-Gm-Message-State: AOJu0YwnljhFPu0wuR6YzJWq2dNvvzvw5tML7dwjzI4qMGOLHQJSQsty
	/pF3l044VrKPpCrM4xQxLV7MJ8byAsPnOjrYAZ3aw6/V35+g3W2e0QSk8TC2f+Kc+tq5ZDRXFOV
	SMfzDp4bXRWWCofqfxy495c9GvXrasvAOCMhr7Poqsa48Q6EVwQmRqJ7TqIzSMTnNtbc=
X-Gm-Gg: ASbGncvV/jJKpBltpx3QV7wzB6SdQw4gLGCFMd8lYOvN3RioF9rezD7zRlvUq2KOp3U
	x/voR8oyO5Odin7sEy9du/+iuEAgVWuikB2N4b9ozxrDLb7ODZduBimYr9gRU+CQLQMeHMzhQi2
	amgx6MWamyJE2aVKG3QaKwSaK0tvmka2GGwyECx6QGFYk/kcq5ix2lqSyodkkbzz0wVGwaQmyPp
	MDFKFhHn0d2hkOT/hqaK6pB7jlWAvDkCJO54yrswtvqLy4j1FYjaX065idx3QLWn1j9YhcU5dnj
	JRsnRbVloiKCaWTfqaUC2FoPl5EVMJy00Z8O9PHg852rwGHm9RZgPQzCPTwIj11oRKDN1mGjDPY
	kX1PIdp8xL6aQlGfrpONufkwU
X-Received: by 2002:a17:902:cf0e:b0:23f:c760:fdf0 with SMTP id d9443c01a7336-242a0b8c6dfmr24782505ad.45.1754469136375;
        Wed, 06 Aug 2025 01:32:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG6aanRzxuxOdDFDL6IEoz3tFt0aU9YroEKfjh1dTfuTkVQmyF6r8Xa1vDHzKckrxBfjAPC+A==
X-Received: by 2002:a17:902:cf0e:b0:23f:c760:fdf0 with SMTP id d9443c01a7336-242a0b8c6dfmr24782245ad.45.1754469135862;
        Wed, 06 Aug 2025 01:32:15 -0700 (PDT)
Received: from [10.133.33.195] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241e899b5e5sm150607895ad.124.2025.08.06.01.32.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Aug 2025 01:32:15 -0700 (PDT)
Message-ID: <33b6aa57-9675-4b4e-9ecd-f82ed7f6c380@oss.qualcomm.com>
Date: Wed, 6 Aug 2025 16:32:10 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 08/10] coresight: add a new function in helper_ops
To: Jie Gan <jie.gan@oss.qualcomm.com>, Mike Leach <mike.leach@linaro.org>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>,
        James Clark <james.clark@linaro.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Tingwei Zhang <tingwei.zhang@oss.qualcomm.com>,
        Jinlong Mao <jinlong.mao@oss.qualcomm.com>, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org
References: <20250725100806.1157-1-jie.gan@oss.qualcomm.com>
 <20250725100806.1157-9-jie.gan@oss.qualcomm.com>
 <CAJ9a7Vi8qpHH2SjmKNjgeY4gdRXY9wnQXhkjN71EcbYSKqayuw@mail.gmail.com>
 <40c8c2d0-1ac3-4944-b509-d23f21687476@oss.qualcomm.com>
Content-Language: en-US
From: Jie Gan <jie.gan@oss.qualcomm.com>
In-Reply-To: <40c8c2d0-1ac3-4944-b509-d23f21687476@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA2MDAwOSBTYWx0ZWRfXx7oTKFCzQ+pL
 xCNGjubPubyxAb7hdtilRali8DFnnZJfwmxw/JL6uWGSDwSwervis/qIEq69UHEmSwQwZHAmoeb
 MV8M05O2EwEULEGUbrdnYI+ObZZN42WZkFoHjWgszx7IxNWemAJvseVbLkanUcctZYk5/fMvTua
 pTseberbUiHQwTGPzDxl/nF86jYegfZQEjE3OZpmkSD/5eDp8cYQ9PlN1xDhT4uAYWIbEXNqX1Y
 e+wMoTmW9J3C1isgs/ImtdgsbbwsXirtYRwikH3nm9KzwgDWCx04iy4mHkKpDfGAt8hQf5p7rRT
 Z9gUTxc8EYCWc4y4zhM2DfYCCD51q3vx92WjADcR+Ob8iM/ivel+Wt75o1WdFuxBHFsfJKKSxoF
 JXZndpFB
X-Proofpoint-ORIG-GUID: sZZyDpSyjES9GKRowxCAVwWYSGghh1dr
X-Proofpoint-GUID: sZZyDpSyjES9GKRowxCAVwWYSGghh1dr
X-Authority-Analysis: v=2.4 cv=U5WSDfru c=1 sm=1 tr=0 ts=68931311 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=y1r4oU-oRDH_k5QpEX0A:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-06_02,2025-08-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0 adultscore=0 clxscore=1015 priorityscore=1501
 phishscore=0 impostorscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508060009



On 8/6/2025 8:35 AM, Jie Gan wrote:
> 
> 
> On 8/5/2025 8:30 PM, Mike Leach wrote:
>> Hi,
>>
>> On Fri, 25 Jul 2025 at 11:08, Jie Gan <jie.gan@oss.qualcomm.com> wrote:
>>>
>>> Add a new function to identifiy whether the byte-cntr function is
>>> enabled or not in helper_ops.
>>>
>>> The byte-cntr's read_ops is expected if the byte-cntr is enabled when
>>> the user try to read trace data via sysfs node.
>>>
>>> Signed-off-by: Jie Gan <jie.gan@oss.qualcomm.com>
>>> ---
>>>   .../hwtracing/coresight/coresight-ctcu-core.c | 35 +++++++++++++++++++
>>>   include/linux/coresight.h                     |  3 ++
>>>   2 files changed, 38 insertions(+)
>>>
>>> diff --git a/drivers/hwtracing/coresight/coresight-ctcu-core.c b/ 
>>> drivers/hwtracing/coresight/coresight-ctcu-core.c
>>> index 8fc08e42187e..dec911980939 100644
>>> --- a/drivers/hwtracing/coresight/coresight-ctcu-core.c
>>> +++ b/drivers/hwtracing/coresight/coresight-ctcu-core.c
>>> @@ -234,9 +234,44 @@ static int ctcu_disable(struct coresight_device 
>>> *csdev, void *data)
>>>          return ctcu_set_etr_traceid(csdev, path, false);
>>>   }
>>>
>>> +static bool ctcu_qcom_byte_cntr_in_use(struct coresight_device *csdev,
>>> +                                      void **data)
>>> +{
>>> +       struct ctcu_byte_cntr *byte_cntr_data;
>>> +       struct coresight_device *helper;
>>> +       struct ctcu_drvdata *drvdata;
>>> +       int port;
>>> +
>>> +       if (!csdev)
>>> +               return false;
>>> +
>>> +       helper = coresight_get_helper(csdev, 
>>> CORESIGHT_DEV_SUBTYPE_HELPER_CTCU);
>>> +       if (!helper)
>>> +               return false;
>>> +
>>> +       port = coresight_get_in_port_dest(csdev, helper);
>>> +       if (port < 0)
>>> +               return false;
>>> +
>>> +       drvdata = dev_get_drvdata(helper->dev.parent);
>>> +       /* Something wrong when initialize byte_cntr_read_ops */
>>> +       if (!drvdata->byte_cntr_read_ops)
>>> +               return false;
>>> +
>>> +       byte_cntr_data = &drvdata->byte_cntr_data[port];
>>> +       /* Return the pointer of the ctcu_drvdata if byte-cntr has 
>>> enabled */
>>> +       if (byte_cntr_data && byte_cntr_data->thresh_val) {
>>> +               *data = (void *)drvdata->byte_cntr_read_ops;
>>> +               return true;
>>> +       }
>>> +
>>> +       return false;
>>> +}
>>> +
>>>   static const struct coresight_ops_helper ctcu_helper_ops = {
>>>          .enable = ctcu_enable,
>>>          .disable = ctcu_disable,
>>> +       .qcom_byte_cntr_in_use = ctcu_qcom_byte_cntr_in_use,
>>
>> These ops structures are for generic functions used throughout the
>> devices. Do not put this function here.
>>
>> This is a specific ctcu helper. Make it external to the file and
>> declare it in coresight-ctcu.h
> 
> Will address the comment in next version.

Hi Mike
Cant add an external function in ctcu-core.c and called in tmc-core.c 
because there is a cycle dependency error:
depmod: ERROR: Cycle detected: coresight_tmc -> coresight_ctcu -> 
coresight_tmc
depmod: ERROR: Found 2 modules in dependency cycles!

How about I add a function in tmc-core.c to directly retrieving the 
sysfs_read_ops of the byte-cntr?

like below:
/* Return the byte-cntr's sysfs_read_ops if in use */
static const struct sysfs_read_ops *tmc_qcom_byte_cntr_in_use(struct 
tmc_drvdata *drvdata)
{
         struct ctcu_byte_cntr *byte_cntr_data;
         struct ctcu_drvdata *ctcu_drvdata;
         struct coresight_device *helper;
         int port;

         helper = coresight_get_helper(drvdata->csdev, 
CORESIGHT_DEV_SUBTYPE_HELPER_CTCU);
         if (!helper)
                 return NULL;

         port = coresight_get_in_port_dest(drvdata->csdev, helper);
         if (port < 0)
                 return NULL;

         ctcu_drvdata = dev_get_drvdata(helper->dev.parent);
         byte_cntr_data = &ctcu_drvdata->byte_cntr_data[port];
         if (byte_cntr_data && byte_cntr_data->thresh_val)
                 return ctcu_drvdata->byte_cntr_sysfs_read_ops;

         return NULL;
}

Thanks,
Jie

> 
> Thanks,
> Jie
> 
>>
>> Mike
>>
>>>   };
>>>
>>>   static const struct coresight_ops ctcu_ops = {
>>> diff --git a/include/linux/coresight.h b/include/linux/coresight.h
>>> index 4ac65c68bbf4..b5f052854b08 100644
>>> --- a/include/linux/coresight.h
>>> +++ b/include/linux/coresight.h
>>> @@ -419,11 +419,14 @@ struct coresight_ops_source {
>>>    *
>>>    * @enable     : Enable the device
>>>    * @disable    : Disable the device
>>> + * @qcom_byte_cntr_in_use:     check whether the byte-cntr is enabled.
>>>    */
>>>   struct coresight_ops_helper {
>>>          int (*enable)(struct coresight_device *csdev, enum cs_mode 
>>> mode,
>>>                        void *data);
>>>          int (*disable)(struct coresight_device *csdev, void *data);
>>> +       bool (*qcom_byte_cntr_in_use)(struct coresight_device *csdev,
>>> +                                     void **data);
>>>   };
>>>
>>>
>>> -- 
>>> 2.34.1
>>>
>>
>>
> 


