Return-Path: <linux-kernel+bounces-741210-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F3AA4B0E17C
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 18:17:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 425401C85DEA
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 16:17:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54A3B27A92B;
	Tue, 22 Jul 2025 16:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="IFqYFtca"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAA2421E097
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 16:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753201054; cv=none; b=eFUpYKI3BTjleNcbR7dNnT88+udZnK/u/eFsQjAhV+Oa9zAJzO5agFnK5W+VB5A94P4t2UpCygynQRRJou2gTZXoPC9qADZ87ga5eFi7uX5jVWb9t9yHjBW7pUMO9pGjYXrF/7Ier8eWolHGLAoZYLdTafRFCm1rg8CpFt9Lask=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753201054; c=relaxed/simple;
	bh=w4dpdLGtoBj80ExZtaOkPcAQU61LkwxmuI3CYMvS53c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PziHZtVl7oL9STFEBUsCMDESNcI1WRYA0CZv8O36eaoFd2FLwbZAU8ckSfi4uL5aDOlYDwQoGrs0SjKxJC1GCH3ckfkLnAXIH+a/7dX+aAjn6tdQw3cJMYECoWTL1wh2xhWbwoypYfA12QXdmBygw/58HEoTWq2b2hUFfvkB83g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=IFqYFtca; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56MF9Jvu013299
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 16:17:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	9nCrpRv1Mz+G5QXSFlJHgBDudrIiUMOp8bzN0yyhpp4=; b=IFqYFtcaX36DN33z
	f3HQlKpeuDNBFnpQMHdxfv6Y7ay3qM99z2oZ9kwZOvd3r6kd3umiMUjGG5nYXiJ6
	x7bpCfI6TXNNDis7RbkPo9vSsgZcikqTK8VWuWttIXDNorCWGO7xPj5s98tj2yCf
	7uo3pSTDbmLEHM8a+OI0B7HgDWHaubFS1efZGCZohoJXQuNobWBy7L+d4CO4sGUb
	ou1nAFt5Z1qqm0RXzj9lcGtmNIj91oupeYr9Rj2znT8zsetyjurawRl/YKGWEFnD
	eHYNX+3X8ZCzFJ9AOXVliTRdoO33tr+713q9EMz6AA30nnnrz7EJW727Lo0/w8Pq
	cQrEFg==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 481g3emxu5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 16:17:30 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-75e28bcec3bso2458938b3a.1
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 09:17:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753201050; x=1753805850;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9nCrpRv1Mz+G5QXSFlJHgBDudrIiUMOp8bzN0yyhpp4=;
        b=cryON5HjARye7vd0SY4kOUQmKQ3GqghQKwijE+T4uh2OejKMUG1fcsf1FlRT5UCxBw
         +HPAfT+Wh3x9g7dqspLxCOd1tFojZS4OHEqZt9xWolo3w1ispJKG4aq7Le7ZeJztDGRD
         VNiW4j/FUjagOvQZ1aS2oLL7AgtpUa556TKX4bTXPUlkSGn8HpYzuEmtlGWLZK2PxNRm
         BGHjlsJg8TH9Ws+2uXUKOuFzHso6MRTHoNrzZY+YBHDVJwLwy2fw3VAZRPUE7aHhQk8U
         eGlo9o64I85qdVCuq8wWrKQHxT0QISY//MnP6EZrVf0OglmiCF3UrwR8g92YWCueh8rt
         RgtQ==
X-Forwarded-Encrypted: i=1; AJvYcCW1iZI97m5T8EBYZpcI3c1Fn+TGtAQC4WZeL5mSSItIjhDHl7j0SwVsEjoRzmdgNM3PKXS/HcEb26T5Xc4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTzSF4XFHcDZ3wxMcslh36sAw5cyyoLSAEPOBUiOW7La/+0PcW
	/bGoZtvmpXUQ8WxH0p3cS1O0nmFQBcV9+xMnRmxe3XAUyG5KcU/Q8lfZSOET2oGQb2j6TVhCP7l
	1NRQ3HqYAsJlBqsqCpgy4Vto+jIFyh3M42aMkTMyndjhH6udxDWuQ85F0CEra0Ddo22I=
X-Gm-Gg: ASbGncu+niZMkgqgT5RqR+B4nbGRfnq9QnXPMfrok0TIyYrXtjozuA60ia+Tyz5/iFY
	CQCj2F2AYLCO39TojDf3BXdNvQ/7RndLyCilqyePcEaIhq9A2VoUDuWTJhj7MWAYWOMwvYY7R3L
	CC0V2XEWD2RYXQCy+Igm4pEbJ0MGLN43aeruy3jQirqEYigS2kh/Bq3gYz2oLoJB1FVjSuwxIQf
	+e2F0VWyBjpGXC3X+ACqlajDlwC9dlyCohQ3x5PfAWH0TZynIMz2kPFIDNFBN2YcfHf2GQTBbQX
	pONk7ncfwwutyXV5S1WM9tvAm5zBNTM9kAr3F2LR7EN9ZFFyzgBL48nKAw7lzZDhOSiJ8eFk5yc
	O1AoKAQQ=
X-Received: by 2002:a05:6a00:3d07:b0:756:d026:10a7 with SMTP id d2e1a72fcca58-75725a89319mr35996865b3a.21.1753201050084;
        Tue, 22 Jul 2025 09:17:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFm++ZLMXmAYAQkNZgMSqeo/I7WJon6D9QhDXy0vQr/omCJkB9Jb05Hhf+LFMrk9yKOHj21Ug==
X-Received: by 2002:a05:6a00:3d07:b0:756:d026:10a7 with SMTP id d2e1a72fcca58-75725a89319mr35996814b3a.21.1753201049597;
        Tue, 22 Jul 2025 09:17:29 -0700 (PDT)
Received: from [10.211.220.100] ([152.57.179.174])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-759cb76d5d8sm7849327b3a.112.2025.07.22.09.17.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Jul 2025 09:17:29 -0700 (PDT)
Message-ID: <13b6be8a-9cd6-e49d-2311-142f79c27328@oss.qualcomm.com>
Date: Tue, 22 Jul 2025 21:47:08 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH v12 1/8] power: reset: reboot-mode: Add device tree
 node-based registration
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Souvik Chakravarty <Souvik.Chakravarty@arm.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Andy Yan <andy.yan@rock-chips.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Konrad Dybcio <konradybcio@kernel.org>,
        cros-qcom-dts-watchers@chromium.org, Vinod Koul <vkoul@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Andre Draszik
 <andre.draszik@linaro.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        Elliot Berman <quic_eberman@quicinc.com>,
        Srinivas Kandagatla <srini@kernel.org>
References: <20250721-arm-psci-system_reset2-vendor-reboots-v12-0-87bac3ec422e@oss.qualcomm.com>
 <20250721-arm-psci-system_reset2-vendor-reboots-v12-1-87bac3ec422e@oss.qualcomm.com>
 <33gq4iyx5jxrr6f5w3ctgy7l7om53jdvb4tmfmxzourhfvpc3t@cr5re2dab4tc>
Content-Language: en-US
From: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
In-Reply-To: <33gq4iyx5jxrr6f5w3ctgy7l7om53jdvb4tmfmxzourhfvpc3t@cr5re2dab4tc>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: rrZKRcOA-54U82Iy3xl6xCtQqMf5glBO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIyMDEzNiBTYWx0ZWRfX/vwS/yxRWryL
 p/URUOzkY2/325DWL/SGaTHNaIovy/N814zdTAoJYNqfJwrgb2st/fakRUDdN+iCQUSk5/v7P+U
 RBieCekk5TWTw2uOEXh97I/0rnSPz45erjWoMQUBl49SqXdvM1R5p4a9vYfpQwTWjnhTxP6sJm7
 Z4HlwnE/zl+J7dA2m54puhR3cNrj8dmV+WQhEZ0qxcS3FcoGPDjj6u8iOKZZMtVLXHMdueAUaxc
 ODOJjIq+cyfKpw4BCO0hcttbx8HZQYorG7nO22gQeuAYhO4h/I7VwwT+1/9H1SRtA6HKVINRIxJ
 h7klM6gvNYdcgP5xCU2nxWoanp6/tAn6hGR+xYn/qtu0tdMu3W8sGTDdRMXFBfTh+eUZ6GsARXy
 SVr7mIJCXZcX8aePH4j/oKTMBeMbqty9XKo0X6cNoB9E4YhJSx+G452tx2gsAYoQexECl5qj
X-Authority-Analysis: v=2.4 cv=Q+fS452a c=1 sm=1 tr=0 ts=687fb99b cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=p0YknvR/5ooNN0yes+ndXg==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=33cFMSo4UqZHzB7ybJ8A:9
 a=QEXdDO2ut3YA:10 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-GUID: rrZKRcOA-54U82Iy3xl6xCtQqMf5glBO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-22_02,2025-07-21_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 phishscore=0 mlxscore=0 lowpriorityscore=0
 mlxlogscore=999 suspectscore=0 spamscore=0 priorityscore=1501 malwarescore=0
 bulkscore=0 impostorscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507220136



On 7/22/2025 3:06 AM, Dmitry Baryshkov wrote:
> On Mon, Jul 21, 2025 at 11:58:48PM +0530, Shivendra Pratap wrote:
>> The reboot-mode driver does not have a strict requirement for
>> device-based registration. It primarily uses the device's of_node
>> to read mode-<cmd> properties and the device pointer for logging.
>>
>> Remove the dependency on struct device and introduce support for
>> Device Tree (DT) node-based registration. This enables drivers
>> that are not associated with a struct device to leverage the
>> reboot-mode framework.
>>
>> Signed-off-by: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
>> ---
>>  drivers/power/reset/reboot-mode.c | 45 +++++++++++++++++++++++++++++----------
>>  include/linux/reboot-mode.h       |  6 +++++-
>>  2 files changed, 39 insertions(+), 12 deletions(-)
>>
>> diff --git a/drivers/power/reset/reboot-mode.c b/drivers/power/reset/reboot-mode.c
>> index fba53f638da04655e756b5f8b7d2d666d1379535..5dd3f06ca88cb28606d9fd2100ce03383c14d215 100644
>> --- a/drivers/power/reset/reboot-mode.c
>> +++ b/drivers/power/reset/reboot-mode.c
>> @@ -3,13 +3,17 @@
>>   * Copyright (c) 2016, Fuzhou Rockchip Electronics Co., Ltd
>>   */
>>  
>> +#define pr_fmt(fmt)	"reboot-mode: " fmt
>> +
>>  #include <linux/device.h>
>>  #include <linux/init.h>
>>  #include <linux/kernel.h>
>> +#include <linux/list.h>
>>  #include <linux/module.h>
>>  #include <linux/of.h>
>>  #include <linux/reboot.h>
>>  #include <linux/reboot-mode.h>
>> +#include <linux/slab.h>
>>  
>>  #define PREFIX "mode-"
>>  
>> @@ -55,7 +59,9 @@ static int reboot_mode_notify(struct notifier_block *this,
>>  	unsigned int magic;
>>  
>>  	reboot = container_of(this, struct reboot_mode_driver, reboot_notifier);
>> +	mutex_lock(&reboot->rb_lock);
> 
> This one should go into the get_reboot_mode_magic() function, otherwise
> it's not obvious why do you need it here.
sure. will update.
> 
> Also, please split mutex addition to a separate patch.
Ack.
> 
>>  	magic = get_reboot_mode_magic(reboot, cmd);
>> +	mutex_unlock(&reboot->rb_lock);
>>  	if (magic)
>>  		reboot->write(reboot, magic);
>>  
> 

