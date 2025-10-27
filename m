Return-Path: <linux-kernel+bounces-871216-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79EF5C0CA71
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 10:29:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 269CD3AB37C
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 09:25:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0D372F0C79;
	Mon, 27 Oct 2025 09:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="aCV6x9oH"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74B8F2E92D6
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 09:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761557095; cv=none; b=iZBOWS8/SiAiXRdfXS2JSnF9NgJdklQ21HhvlbIQf7Qr2gWNiBU/brhJ6sGAavOGQHAaEwoPLUAJlvq40fvijzUlz5gQtzPTyabAz7X0qP6CTvErcp5243X3dZ6i4ZkvI3H1JkV8q+IRGKzrPKTpAmMH/hX7tHC2fTBunexOQkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761557095; c=relaxed/simple;
	bh=hgq9c1yD2yEo9HG1HdxUXdZbXXExb9ucX0lGtUfV0DA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BIT0VRtFmy3On9GBmo2Uo6sXDhkX9s6xjX74tFHspYCDgKWnTteYdGlxIhDoj+1AJvPVBWXNYAYjJJ6v64Vw3TIJnlKf9dTtYa3rW0gXviTjpFiuDdn9dTWAnz1BaEtBMapcjNaqThtbz/ooW5B2kXpx3NCUdcbGKeim1VBSIek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=aCV6x9oH; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59R8w8hw841770
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 09:24:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ykKfkihjFSpy5A7Zw6nBytLo5ZdUJJy6OlfC28a04XY=; b=aCV6x9oH2nRvJ00R
	zYQD4TKWRATdIKcDtCd4gpu2C5vs7Xxr+r38/Wb9yP0++UMrSmJu+HqUTCPXXq3k
	QLhYbSjcnrRlKZgZIXohIlDMNYNq/KRJCOXxibfvBc9Xp9Nd5NDm6+H8+k1R66fO
	Jtb+zaRXEzYTU+4kp7MB0rfFxsHyc7OTZB6cBXsic7KuSqgyL0ro7JFzJkXv//qi
	1faZXo11lW/AEZFF+5CiB77UQ9RsKhuA/KTc8qHvcK5kXKthum46e3AxpfHMAFx7
	4vKGeOPrCn1RkMej1SNIQr6YwlF9ANaZrhGJ2PM/ppGR4escNb8spo7b7hYHtdt7
	MoGJ4g==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a1uc59d5j-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 09:24:53 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-286a252bfbfso106528295ad.3
        for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 02:24:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761557093; x=1762161893;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ykKfkihjFSpy5A7Zw6nBytLo5ZdUJJy6OlfC28a04XY=;
        b=O4oh9pISkalyjZDohqCbajWUbbtla6t7Xu+Ckzijn4wiKIQnWCcfUfSU6VnFc3GSDg
         mGj9+JNhBuIQH1K4uUsRuPMy89fmphFolVJvXwmuLqApp9ODhK6cy6u0wPy1wFlCFw5v
         XPXRMwzxGqo51kxDiBq7WeHRJ6znfJHkGS0eSU6SlPeQInx5ZZJC43IETyyZzEWOyhog
         tnNbzH8YjKSTTuyrxHR6nJbxeMe+gaSbD7H+LkjO99FVlE6V2S9Cj+Nf/uWChxHBZuqc
         Tp7lZskHtcoWVCtNiXSetwJ6GCoR0XR3qhDNPTQrvjsjPK2g3F5/o8spQdNO0qF4SMTA
         nMDw==
X-Forwarded-Encrypted: i=1; AJvYcCX/DG3gTvPVjaczJ2SSX6UIp/YVGLsPoKx01fwhpV+MxvWpDjcp/HpnUDbEoTV3x2UTbInPn27r/khWTrI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRNnMQu+mdWwepnMftiwqCrBNnmwA2t11qf9qMiKk/EQm3muoC
	ZfjFw1cI89R/iF/DGKsT1uJWg2MmcbSy41MEK6CTbasamwNEyClqUL5Aw2NOuH5jWPHqPM4NskA
	zepVEMDh/LJWoWz/FRbe4piFXU6xRmvQvM0wOcQ9Y0GmqHUQkxDWE3nX7TjYuLz5zciY=
X-Gm-Gg: ASbGncslQ1k5nFGEonQHUi6/y9OpJl+qP9MWV0FquvwWd8aKDTwc29WXndJWX8Ph6Ob
	13CqndMHnZmCPqSYXWyRuvjyrTAN8IrsywI1xNacTm3JmQ1xTlfhFIG/AdpUywvsWJnWw5pJ/KC
	/7EJC0bNixo7DYPJbip+OAGDy7N6Rl2xnQnAiMn9f1Tg7WgdYhy3xW1sXcn4JYe89a4bkt07C0S
	g5QTJYPyUtTeS/tEvYhB2dLtvfZdVmfkHu7KmW2JFzQwm/RrkkS0db0E1/uc7IpgHID2TNVNFfW
	Qp+bR476sTISdfP+P6umyPl66Q/28bjyhX4AztUEJWfsa59+rfShPv6aZkXa4nqrJWI3vwWpNVn
	PtNayzQtMdzkHBRC4J9ja7F9Djy8f
X-Received: by 2002:a17:902:d510:b0:267:776b:a31a with SMTP id d9443c01a7336-290ca121a37mr489283255ad.29.1761557092853;
        Mon, 27 Oct 2025 02:24:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGoqnglA0UI51Wei68+VK5do5gYXJuNgaPESEhOmXS2bmE6WOPNQO+FVMycseqQCXytLkXHXQ==
X-Received: by 2002:a17:902:d510:b0:267:776b:a31a with SMTP id d9443c01a7336-290ca121a37mr489282905ad.29.1761557092343;
        Mon, 27 Oct 2025 02:24:52 -0700 (PDT)
Received: from [10.218.7.34] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33fed6c4e78sm3943968a91.2.2025.10.27.02.24.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Oct 2025 02:24:52 -0700 (PDT)
Message-ID: <784de75a-2821-46f2-a6d0-a4c4a6a13dfe@oss.qualcomm.com>
Date: Mon, 27 Oct 2025 14:54:45 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/3] spmi: spmi-pmic-arb: add support for PMIC arbiter
 v8
To: Neil Armstrong <neil.armstrong@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        David Collins <david.collins@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, aiqun.yu@oss.qualcomm.com,
        kamal.wadhwa@oss.qualcomm.com, jingyi.wang@oss.qualcomm.com
References: <20251024-pmic_arb_v8-v3-0-cad8d6a2cbc0@oss.qualcomm.com>
 <20251024-pmic_arb_v8-v3-3-cad8d6a2cbc0@oss.qualcomm.com>
 <0cd8f4d4-d418-4634-abaf-f66b350c81eb@linaro.org>
Content-Language: en-US
From: Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>
In-Reply-To: <0cd8f4d4-d418-4634-abaf-f66b350c81eb@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 32vd3oAq082g_lqCJfOdPkF3ErtyUSid
X-Proofpoint-ORIG-GUID: 32vd3oAq082g_lqCJfOdPkF3ErtyUSid
X-Authority-Analysis: v=2.4 cv=Z4Dh3XRA c=1 sm=1 tr=0 ts=68ff3a65 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=3PRCy_2JfRc9Wa6eopEA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=GvdueXVYPmCkWapjIL-Q:22 a=HhbK4dLum7pmb74im6QT:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI3MDA4NyBTYWx0ZWRfX7kRWn7F7hKiE
 8o4cDKk6H+oP3/Q9+2tkhfYZnNce9RqcnYm9aVlIRMFudn+O/j0odbL5sxtbvLy6+7XAvqMICnh
 TcCL8vvIsv9vDEGGHexNX8OGeqEbRZ+tpEpE7j8F4U7VGNambLbskgBI8cLgAal79oBjuvr8k+J
 +ed33HQozquK1CQpbGJ33bQH3aEVTfmU3FCIibDRZ+0FwKHQJnTFcnAiKRmxbqIjZga6A2obLxd
 bV5ElyISgG/TAXi2NfPiMn3k32+UP2RxAzjv3GwW01w6hW4bC34rvY04kg9yJ2WEYJNcCxSWoxa
 lvvY/QCKU2Suoln8j2fQlUG8GH4HLS0nA5wErmtRNdEun0AVuD2qMoPOFBuB6mgrKfHFwEYOQ2h
 G62rq6UQN8n73jmOE3JQ9njGU1mKMA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-27_04,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 spamscore=0 priorityscore=1501 malwarescore=0
 bulkscore=0 adultscore=0 suspectscore=0 lowpriorityscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510020000 definitions=main-2510270087

Hi Neil,

On 10/24/2025 3:48 PM, Neil Armstrong wrote:
> Hi,
> 
> On 10/24/25 11:33, Jishnu Prakash wrote:
>> From: David Collins <david.collins@oss.qualcomm.com>
>>
>> PMIC arbiter v8 supports up to 4 SPMI buses and up to 8192 PMIC
>> peripherals.  Its register map differs from v7 as several fields
>> increased in size. Add support for PMIC arbiter version 8.
>>
>> Signed-off-by: David Collins <david.collins@oss.qualcomm.com>
>> Signed-off-by: Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>
>> Signed-off-by: Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>
>> ---
>>   drivers/spmi/spmi-pmic-arb.c | 324 +++++++++++++++++++++++++++++++++++++++----
>>   1 file changed, 294 insertions(+), 30 deletions(-)
>>
>> diff --git a/drivers/spmi/spmi-pmic-arb.c b/drivers/spmi/spmi-pmic-arb.c
>> index 91581974ef84..612736973e4b 100644
>> --- a/drivers/spmi/spmi-pmic-arb.c
>> +++ b/drivers/spmi/spmi-pmic-arb.c
>> @@ -3,6 +3,7 @@
>>    * Copyright (c) 2012-2015, 2017, 2021, The Linux Foundation. All rights reserved.
>>    */
>>   #include <linux/bitmap.h>
>> +#include <linux/bitfield.h>
>>   #include <linux/delay.h>
>>   #include <linux/err.h>
>>   #include <linux/interrupt.h>
>> @@ -25,10 +26,12 @@
>>   #define PMIC_ARB_VERSION_V3_MIN        0x30000000
>>   #define PMIC_ARB_VERSION_V5_MIN        0x50000000
>>   #define PMIC_ARB_VERSION_V7_MIN        0x70000000
>> +#define PMIC_ARB_VERSION_V8_MIN        0x80000000
>>   #define PMIC_ARB_INT_EN            0x0004
>>     #define PMIC_ARB_FEATURES        0x0004
>>   #define PMIC_ARB_FEATURES_PERIPH_MASK    GENMASK(10, 0)
>> +#define PMIC_ARB_FEATURES_V8_PERIPH_MASK    GENMASK(12, 0)
>>     #define PMIC_ARB_FEATURES1        0x0008
>>   @@ -50,9 +53,10 @@
>>   #define SPMI_MAPPING_BIT_IS_1_RESULT(X)    (((X) >> 0) & 0xFF)
>>     #define SPMI_MAPPING_TABLE_TREE_DEPTH    16    /* Maximum of 16-bits */
>> -#define PMIC_ARB_MAX_PPID        BIT(12) /* PPID is 12bit */
>> +#define PMIC_ARB_MAX_PPID        BIT(13)
>>   #define PMIC_ARB_APID_VALID        BIT(15)
>>   #define PMIC_ARB_CHAN_IS_IRQ_OWNER(reg)    ((reg) & BIT(24))
>> +#define PMIC_ARB_V8_CHAN_IS_IRQ_OWNER(reg)    ((reg) & BIT(31))
>>   #define INVALID_EE                0xFF
>>     /* Ownership Table */
>> @@ -96,30 +100,33 @@ enum pmic_arb_channel {
>>       PMIC_ARB_CHANNEL_OBS,
>>   };
>>   -#define PMIC_ARB_MAX_BUSES        2
>> +#define PMIC_ARB_MAX_BUSES        4
> 
> Why PMIC_ARB_MAX_BUSES is changed to 4 ?

PMIC_ARB_MAX_BUSES is used only in the definition of
struct spmi_pmic_arb, for this member:

	struct spmi_pmic_arb_bus *buses[PMIC_ARB_MAX_BUSES];

The PMIC Arbiter v8 is capable of supporting up to 4
SPMI buses, so this change is needed to support it.

Thanks,
Jishnu

> 
> Neil
> 
> <snip>
> 


