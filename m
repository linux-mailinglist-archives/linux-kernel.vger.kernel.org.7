Return-Path: <linux-kernel+bounces-737220-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EDE85B0A964
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 19:26:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 17CA15A37F7
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 17:26:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D02752E6D2F;
	Fri, 18 Jul 2025 17:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="E/yaTaz0"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ADC12E6D0A
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 17:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752859582; cv=none; b=YKe/pZQzqsO9YqSABDLYBvZWCJ52UvND0hAAFuf+Ns9XxZJTiP+oRjsi3aqxS8kXYLh5jt8eClGCufL3WCZEZ0KDvq+6LjbI0++//9XA8LhaYfnyDTdn4qyAXGJ8Z3rDG79w+PMwTuqdua6iVHcQqYzB+IVlk1B8g2W9sqD0boU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752859582; c=relaxed/simple;
	bh=A0Hft1j6L216tZxWQlcBGOLV5bZ4wJTunGM4c9VS3mw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=H3w5P86hGJAIY+pwCHV2VcCD+VIMX7cCZDwRuGwhLwqYOEevj6p0cpk8N6+uJSyUu9mPSQeCRAoWGJIiTeiwuYlYxtOLrl4T2Vp4Ifx1uw+0hOMSOa+p/b/KG2/kstJzDqJ37B4xDEKPWbR8f4bFfTdu1QvZGwwm/zRe80AIAXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=E/yaTaz0; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56I9HoFc016243
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 17:26:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	GduJ5YbGzanNXFF24/hf0EZK6UZ8V5SkZA+qLy9SUOU=; b=E/yaTaz0qmZcflgQ
	ctre4pLpfFrslHbuc7XQoHQTgHl0YNlN+IidqMkkjdpQuguWXzzE/pVa+OzPQJMU
	hYkqsYm/hZFRo15mndzXQsmVc7hdCmPVb4kgIJQFIkE3s3J7mbAyvmb/Y+HS51UY
	HnJNAV0b7q3NUlRljd6AX5NCN+14QnoWKzHHLXqlq0gViykiGAZ0TH+SGl1JUR4A
	bWx7b79CHFfXYWYozKj6PHJMrrCn0ObVKzvA/cGCYxcUwwD2TG98QdfBnlJLpKie
	W7m7f4nRdVIOuhChZGHhpG888hB6PBnc36y/y9ONTpFQyadreH9nj77l50o+iaGf
	/1Y5dA==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47y3tc4aqm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 17:26:19 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-23494a515e3so19650955ad.2
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 10:26:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752859579; x=1753464379;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GduJ5YbGzanNXFF24/hf0EZK6UZ8V5SkZA+qLy9SUOU=;
        b=Am9jPEA0GT0k2aAKmiB2j5ZUwYXA8iRI2x6BkI/spQxar7+lE22d2SUD3DwQSJURIj
         QrH1yI31hKXKCATscSLb7W2paNfxIwwuvItIIrTilu2wI3tnRrrC/H2UMfwYkLWVaBiL
         n9mFGbdYvuTIijdqQ6InNCj5M2SqDERR+2iE1tZAhuFSEVD7XVih5UN3UoBtIvPIlcYl
         eSvtxOHceODdeFFRo/2khg1AQFK9PdwCz8KH+2EgD1ckol1Z0tXA8a8GBqv5toaDJ1Yf
         6X+1vOZUYdt48EuPymTDIKCdMekqm0+BaViEf4c6oBS9eI1FDOyq6rhDR+yS35mRBLvR
         LVpw==
X-Forwarded-Encrypted: i=1; AJvYcCXgExi7sQw1xhOPEvbHcys7Foc+3+ytO0c6ZOIbQEuf2HS6Ibp9sKmv9juP9BMmggctQdjOJfwKcRyV+60=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTjoH/sZidj/Yz+dzxsNPBrZaiHf7z4YpwvXUtRdMld3Vo26ZG
	zyz7tFkWFz8NEg3APk++EYST4btIalZXon1x6TPTLfVZaRVcxzjrcNKhyNFk9YozIk0qnlmg7Ox
	3znN8YtM1VnDre/MlLP+ri8R6TZL3EjKokR6orGmc7I3WU8qNBLYZgS8UoMw3T58yEao=
X-Gm-Gg: ASbGncsmHyIuFz30P4xkGiv5TDYI2dNVw0dCRjXwAzchPYv0+mLtzCH1ZSwv+K4C+Jk
	75v/Jk4dhPino7uPTVeQn7WmXfE3GMqMAIFr+T26buzAafLwT2Cyo/GWdoRet2fRYe0VAm95pl2
	o58QBLEuhuuC4fFwHOy1KJahUJOQtbbKbwBVHA7bq32G2SfD5r1pjRpR3HkUl6vzYYNIqSp5a2L
	kNLd7bdITKZFwbexrb4CLTy1nVvKJ4USS76eC3tjgq4fFHHvD2H+9KSv2Y9QoohZXnEVMZhFmMJ
	NgCrc/JRzAVmjt9SvaIIgEBTFDCHseDPtBe8GQvkGe10nmYF2Y67Z3PxljVe17LD8NU=
X-Received: by 2002:a17:902:d60b:b0:235:dd54:bce1 with SMTP id d9443c01a7336-23e24f49451mr169690395ad.15.1752859578706;
        Fri, 18 Jul 2025 10:26:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEBiuApPui+DrCZGh1uQCxP+63mJXtxF2yZeaEggDdwLKQBX3di0tn4hyxBqo1Jj6zmyDWaeg==
X-Received: by 2002:a17:902:d60b:b0:235:dd54:bce1 with SMTP id d9443c01a7336-23e24f49451mr169690055ad.15.1752859578204;
        Fri, 18 Jul 2025 10:26:18 -0700 (PDT)
Received: from [192.168.0.195] ([49.204.28.43])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23e3b6d19acsm16005375ad.144.2025.07.18.10.26.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Jul 2025 10:26:17 -0700 (PDT)
Message-ID: <e36a9e5b-f6af-4266-98f0-a82489fa5d72@oss.qualcomm.com>
Date: Fri, 18 Jul 2025 22:56:11 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/7] clk: qcom: gcc: Add support for Global Clock
 Controller
To: Krzysztof Kozlowski <krzk@kernel.org>,
        Pankaj Patil <pankaj.patil@oss.qualcomm.com>, sboyd@kernel.org,
        mturquette@baylibre.com, andersson@kernel.org, robh@kernel.org,
        krzk+dt@kernel.org, conor+dt@kernel.org, quic_rjendra@quicinc.com
Cc: linux-clk@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250716152017.4070029-1-pankaj.patil@oss.qualcomm.com>
 <20250716152017.4070029-8-pankaj.patil@oss.qualcomm.com>
 <28ea2b11-a269-4536-8306-185bf272bd60@kernel.org>
Content-Language: en-US
From: Taniya Das <taniya.das@oss.qualcomm.com>
In-Reply-To: <28ea2b11-a269-4536-8306-185bf272bd60@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=Z5PsHGRA c=1 sm=1 tr=0 ts=687a83bb cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=tMiizUMu9hGndvLFPAJAbA==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=IDfOk1lORozFkaJI5SoA:9
 a=QEXdDO2ut3YA:10 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-ORIG-GUID: hXi4K_ff04YP5AK_75MIHAUUZC9WO4LU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE4MDEzOCBTYWx0ZWRfXzhhpT6j7DE3N
 dGnNXCicO9pYQr4AjX9fyON/ZNclpmmtPbbANXZtLdaveu8BrM0sSWym76ZliptR7Bf8HiCwDeI
 VLKM0Ek7GprkMffp4QeMkWnlaoa0/okNlEnwM9ZkPkXzl2MG0YggaT0tq9UEwEYD1ACrMaZTRpq
 AR+XFCS6YqkPdzXMhMV0eXQO1uLkTvQ6d4IoeSP9cpKBAsBy8bkE8AXWeLRN/UEJC5T7NMH9fde
 zWI3GblPm5KjdAxpzuH8yVekvZ6HzA/gmZCUfpDaBnpkPeqFuqw6pMgJEGyjsAP3qzrHQqoxcEZ
 vrlQKcQ9KG4RQSLsnd0JffNtfDMycn0g8gb8x0EzWTGs+k5qSqVs8RC3vqW3Vuu5AvZN8fENxA+
 WxD2zdmrN2QiOL9V8MJADcnYPCdLKIrLhi6MyXtWN5oQKxUuKNsCuuf7De9afW2Iqv7MRQIE
X-Proofpoint-GUID: hXi4K_ff04YP5AK_75MIHAUUZC9WO4LU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-18_04,2025-07-17_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 mlxlogscore=999 suspectscore=0 spamscore=0 clxscore=1015
 mlxscore=0 malwarescore=0 phishscore=0 lowpriorityscore=0 adultscore=0
 priorityscore=1501 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507180138



On 7/16/2025 9:58 PM, Krzysztof Kozlowski wrote:
> On 16/07/2025 17:20, Pankaj Patil wrote:
>> From: Taniya Das <taniya.das@oss.qualcomm.com>
>>
>> Add support for Global clock controller for Glymur platform.
>>
>> Signed-off-by: Taniya Das <taniya.das@oss.qualcomm.com>
>> Signed-off-by: Pankaj Patil <pankaj.patil@oss.qualcomm.com>
>> ---
>>  drivers/clk/qcom/Kconfig      |   10 +
>>  drivers/clk/qcom/Makefile     |    1 +
>>  drivers/clk/qcom/gcc-glymur.c | 8623 +++++++++++++++++++++++++++++++++
>>  3 files changed, 8634 insertions(+)
>>  create mode 100644 drivers/clk/qcom/gcc-glymur.c
>>
>> diff --git a/drivers/clk/qcom/Kconfig b/drivers/clk/qcom/Kconfig
>> index 051301007aa6..1d9e8c6aeaed 100644
>> --- a/drivers/clk/qcom/Kconfig
>> +++ b/drivers/clk/qcom/Kconfig
>> @@ -645,6 +645,16 @@ config SAR_GPUCC_2130P
>>  	  Say Y if you want to support graphics controller devices and
>>  	  functionality such as 3D graphics.
>>  
>> +config SC_GCC_GLYMUR
> 
> G > 7, please order alphanumerically.
> 

Sure, will update.

>> +	tristate "GLYMUR Global Clock Controller"
>> +	select QCOM_GDSC
>> +	depends on COMMON_CLK_QCOM
>> +	depends on ARM64 || COMPILE_TEST
>> +	help
>> +	  Support for the global clock controller on GLYMUR devices.
>> +	  Say Y if you want to use peripheral devices such as UART, SPI,
>> +	  I2C, USB, UFS, SDCC, etc.
>> +
>>  config SC_GCC_7180
>>  	tristate "SC7180 Global Clock Controller"
>>  	select QCOM_GDSC
>> diff --git a/drivers/clk/qcom/Makefile b/drivers/clk/qcom/Makefile
>> index bf95729678f6..cdc3d9ba9024 100644
>> --- a/drivers/clk/qcom/Makefile
>> +++ b/drivers/clk/qcom/Makefile
>> @@ -94,6 +94,7 @@ obj-$(CONFIG_SA_GPUCC_8775P) += gpucc-sa8775p.o
>>  obj-$(CONFIG_SA_VIDEOCC_8775P) += videocc-sa8775p.o
>>  obj-$(CONFIG_SAR_GCC_2130P) += gcc-sar2130p.o
>>  obj-$(CONFIG_SAR_GPUCC_2130P) += gpucc-sar2130p.o
>> +obj-$(CONFIG_SC_GCC_GLYMUR) += gcc-glymur.o
> 
> Same here

Will take care.

> 
>>  obj-$(CONFIG_SC_GCC_7180) += gcc-sc7180.o
>>  obj-$(CONFIG_SC_GCC_7280) += gcc-sc7280.o
>>  obj-$(CONFIG_SC_GCC_8180X) += gcc-sc8180x.o
>> diff --git a/drivers/clk/qcom/gcc-glymur.c b/drivers/clk/qcom/gcc-glymur.c
>> new file mode 100644
>> index 000000000000..a1a6da62ed35
>> --- /dev/null
>> +++ b/drivers/clk/qcom/gcc-glymur.c
>> @@ -0,0 +1,8623 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +/*
>> + * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
> 
> Missing date.
> 

will add the date.

> 
> Best regards,
> Krzysztof

-- 
Thanks,
Taniya Das


