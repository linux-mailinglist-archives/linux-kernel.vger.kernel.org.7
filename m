Return-Path: <linux-kernel+bounces-839893-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B603EBB2ABC
	for <lists+linux-kernel@lfdr.de>; Thu, 02 Oct 2025 09:15:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E885F1925E29
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Oct 2025 07:15:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44F6D28BAA6;
	Thu,  2 Oct 2025 07:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="T0cTGpVk"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3BD82BDC3B
	for <linux-kernel@vger.kernel.org>; Thu,  2 Oct 2025 07:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759389290; cv=none; b=r34v4ORsnFD/eAf56PDlW5uwjJoIGRBu+ak5t5SGjnVeGSy/CXG/q3Gl6TILqPYk7TGCyQsPjugjrR3SOWbKza9nvn/KmfadYV4CNHy+ZMan2X2I7lOqWDALFJM4HW+7aWu6iRV0ljfRnFomfAxD7KcFVyn4g9FBZmjLTXO/Mho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759389290; c=relaxed/simple;
	bh=h5CrAYIynZVv2O7NpU57ZuvsG4aarAwdD45iSeTC3eI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dqF5CkheDoERq0hHkr9MJKTnkyfGZvllwhCBnwS9AqABdJMBblf0EmG7ktW3H9E3r8CJiA2j3gtRXoSdLmS5x761ihKs1ZTrfGG7cfWLR5fR+t92ec57xeWWfqJ3ZiKH8YtBE1/iZxAc/OmzxOwco8gP7fnjneQagLF5Yq1zbEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=T0cTGpVk; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 591IcSI2024148
	for <linux-kernel@vger.kernel.org>; Thu, 2 Oct 2025 07:14:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	wsrDpj5hUw4YEIy6N4WOTSRjb0/flPiO/cgRAbN+m0U=; b=T0cTGpVkUSK/3Zx/
	w+TJQr4hv4y+243iJyTp4LqSp2ohJ/i4HGZVrMXTEP+nYl3jvG027aNh7YBHzGsb
	/SXP5cyk6AnZ+12zvbXidUjOgNif0mSMtDgKmWJ/zYUpzGrZw9eTdQBmyigv6c0V
	pRhRk7aLnwYa3whwOSvviELvLkdNn0917Rzb/O9HRvm/A42k4kVG3oItY3EeMu3p
	CQmjPiA3weTgP9MsTSNDvRti4254wuTxREynUHA1bht8XaxYZLB9lItZXchoDnGi
	3RInFliwhqgU5Mauu+i9VCWwQJ2avP1jMkJgptqHzFR44TsI6FaxwojynxRyHFNr
	Ct9G0Q==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49e8a671hj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 02 Oct 2025 07:14:42 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-269880a7bd9so6776005ad.3
        for <linux-kernel@vger.kernel.org>; Thu, 02 Oct 2025 00:14:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759389281; x=1759994081;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wsrDpj5hUw4YEIy6N4WOTSRjb0/flPiO/cgRAbN+m0U=;
        b=eF/L27n6mG84xyeS4lySBBrxnY24L9W1K6eCm3/LzkxK9tvl9Olhi9cbMbMMjkX3Qx
         X/J9bBgqov4mDjxjbQ0bnO+ZHnbsKMluzJ75TP9BMZeebqXbQVznZh6GOeCZpamZTHto
         Uej/r6x+QWHmE9HzbQeAjoBrP+mkg9003BsfUdmUBFN3vpfip8R4su1JlAzC7hl4hbyn
         KEB8qcbcZtuwNGVSAmkQ11IqWSB1Ejj7CgaCzw0abzj6mfnTmrvPq3GAdcP1LjW8jC0V
         bmX15/9CqXYra9PGeHwlMkrB5OMGXUfSr69fqwU3Dc32C8IQqaTVqg9nvIQKtxMZjiYD
         hXJA==
X-Forwarded-Encrypted: i=1; AJvYcCUuKyvwazCtsxSL+L+wiyGZ+snlpM60y169usqrs0Ah1Jxq4rknoa6z9uwAmUdE4aU9agj8N+xpe5lJ75g=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGeEhIbMXd3eCgEoolwTKvWPvPGQ/ei7jhLrtLuGvSPshAMJC5
	anI3XsG02EMYs6TEGjvFwHafkSx6bqiWbxA2+8cSTyUaZkqcj4HteHEA5Lewg0SGE7gJ3RYHOdr
	BxvHfI7EZKrhWa5eJ1IwMrfaxej1ZS5lzkTo4ZnzXqVjios+p4odDVMS41hdEny6K77w=
X-Gm-Gg: ASbGncvAWV32578S45pCCllKwZuy4m3OYUec8aC0J2NO6QZwAXze8VIeM7KRiprcncl
	I18BK9g8W1NWkkwNAybPjWjcNNgTlfJgdjsPiwe3n066s2IvU4/gUtSSvI/rbrTCscUtd32zss/
	QHjjomX4P9G/WIpWqhw/7qEKIHcHvdLNEQ0jE4ZuB2LG6t6WOniRdPxiSL/hdXQ076DEpjXsc0I
	iKXVCoGVmbHJ/cKo6f0P+M60XiIullI14stXPIv4H4N0NkT/h0qBII3UAeW6D+wU/Hi7SP2n8PG
	TzdtnFrFw0zP/BL4HE6AR8BC2WED4BQQcZHwpZyMEoQChdiTaOlKNF0tvE8gqAbSxUpmOchNF5B
	UgZSr3OzsjEOkk2Zo5h8SZz5ZyKRMdvYCF8LZ
X-Received: by 2002:a17:902:ce0f:b0:27e:f16f:618b with SMTP id d9443c01a7336-28e7f2a6437mr75646245ad.24.1759389280945;
        Thu, 02 Oct 2025 00:14:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFBqcQoIzfkxTOkZwP9SZ5axnu1siGWGEzipZSpgfQ+MGK5IUYqzt2bTf5JM9Q+kuHEuFeBsQ==
X-Received: by 2002:a17:902:ce0f:b0:27e:f16f:618b with SMTP id d9443c01a7336-28e7f2a6437mr75645935ad.24.1759389280423;
        Thu, 02 Oct 2025 00:14:40 -0700 (PDT)
Received: from [192.168.1.239] (syn-075-080-180-230.res.spectrum.com. [75.80.180.230])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-28e8d1d5680sm15167845ad.96.2025.10.02.00.14.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Oct 2025 00:14:39 -0700 (PDT)
Message-ID: <8996bd96-0660-70ba-63f4-51111219d146@oss.qualcomm.com>
Date: Thu, 2 Oct 2025 00:14:37 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v4 07/10] phy: qualcomm: qmp-combo: Update QMP PHY with
 Glymur settings
Content-Language: en-US
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: krzk+dt@kernel.org, conor+dt@kernel.org, konrad.dybcio@oss.qualcomm.com,
        kishon@kernel.org, vkoul@kernel.org, gregkh@linuxfoundation.org,
        robh@kernel.org, linux-arm-msm@vger.kernel.org,
        linux-phy@lists.infradead.org, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20251001220534.3166401-1-wesley.cheng@oss.qualcomm.com>
 <20251001220534.3166401-8-wesley.cheng@oss.qualcomm.com>
 <ra3bq7guxunk2n7mbrjlefxvxu45clmwzp74vq7bqd2xvp2fv5@z5skxjxs4yxp>
From: Wesley Cheng <wesley.cheng@oss.qualcomm.com>
In-Reply-To: <ra3bq7guxunk2n7mbrjlefxvxu45clmwzp74vq7bqd2xvp2fv5@z5skxjxs4yxp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=RZKdyltv c=1 sm=1 tr=0 ts=68de2662 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=agQD+r7xwyS+FYqxhQjztw==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=JfrnYn6hAAAA:8 a=EUspDBNiAAAA:8
 a=INxguLwuHvTa_v7rZvUA:9 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22
 a=1CNFftbPRP8L7MoqJWF3:22
X-Proofpoint-GUID: CKEY8y0ysba8JWe8QjYUI8s2dNsoI_LR
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI3MDAzMyBTYWx0ZWRfX1UJ4LaQHjCBt
 t7tSpWlmbub154zc8MDKuiTFX28//iw5QVqyo6hmWnnZrkq0gR+zK5cEvIpXEaQ/t2AgZydGDsI
 GCUMKZ7WypkJdZ+a1T8L+r/yZfRH15lWUSuq4ecC1vf3kQVr9+J4DQXOM3jIfqJ1JwSe3MyYYgK
 Ac5eo+EfR1as6fEALaxiWpVJn48hvWZYCCCebl1MJlknO1lHdeH3JeU1X/jcnpSV3/IQFP2pMeW
 6qms/hfcp4EgWCxW8irGnLfUmYUWxxjX4NN+90BjARgZbc6Z1XhUaWp2EswaCJGko8Bsy3gISYO
 ucf9RWrJuPPliSEUo8Hy72rGc2cF7uw14qqkuXFdVD3sGkrERTYwfSFcbopoIU4EY+YVkNZ/PRx
 P/Re0jlWUql1kqOGFz10x9jM9f74Sg==
X-Proofpoint-ORIG-GUID: CKEY8y0ysba8JWe8QjYUI8s2dNsoI_LR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-02_03,2025-09-29_04,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 priorityscore=1501 adultscore=0 phishscore=0
 impostorscore=0 spamscore=0 bulkscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2509270033



On 10/1/2025 5:58 PM, Dmitry Baryshkov wrote:
> On Wed, Oct 01, 2025 at 03:05:31PM -0700, Wesley Cheng wrote:
>> For SuperSpeed USB to work properly, there is a set of HW settings that
>> need to be programmed into the USB blocks within the QMP PHY.  Ensure that
>> these settings follow the latest settings mentioned in the HW programming
>> guide.  The QMP USB PHY on Glymur is a USB43 based PHY that will have some
>> new ways to define certain registers, such as the replacement of TXA/RXA
>> and TXB/RXB register sets.  This was replaced with the LALB register set.
>>
>> There are also some PHY init updates to modify the PCS MISC register space.
>> Without these, the QMP PHY PLL locking fails.
>>
>> Signed-off-by: Wesley Cheng <wesley.cheng@oss.qualcomm.com>
>> ---
>>   drivers/phy/qualcomm/phy-qcom-qmp-combo.c     | 312 ++++++++-
>>   .../phy/qualcomm/phy-qcom-qmp-pcs-aon-v8.h    |  17 +
>>   .../phy/qualcomm/phy-qcom-qmp-pcs-misc-v8.h   |  12 +
>>   .../qualcomm/phy-qcom-qmp-qserdes-lalb-v8.h   | 639 ++++++++++++++++++
>>   .../phy/qualcomm/phy-qcom-qmp-usb43-pcs-v8.h  |  33 +
>>   .../phy-qcom-qmp-usb43-qserdes-com-v8.h       | 224 ++++++
>>   drivers/phy/qualcomm/phy-qcom-qmp.h           |   4 +
>>   7 files changed, 1240 insertions(+), 1 deletion(-)
>>   create mode 100644 drivers/phy/qualcomm/phy-qcom-qmp-pcs-aon-v8.h
>>   create mode 100644 drivers/phy/qualcomm/phy-qcom-qmp-pcs-misc-v8.h
>>   create mode 100644 drivers/phy/qualcomm/phy-qcom-qmp-qserdes-lalb-v8.h
>>   create mode 100644 drivers/phy/qualcomm/phy-qcom-qmp-usb43-pcs-v8.h
>>   create mode 100644 drivers/phy/qualcomm/phy-qcom-qmp-usb43-qserdes-com-v8.h
>>
>> diff --git a/drivers/phy/qualcomm/phy-qcom-qmp.h b/drivers/phy/qualcomm/phy-qcom-qmp.h
>> index da2a7ad2cdcc..7211c71fe68c 100644
>> --- a/drivers/phy/qualcomm/phy-qcom-qmp.h
>> +++ b/drivers/phy/qualcomm/phy-qcom-qmp.h
>> @@ -32,7 +32,9 @@
>>   #include "phy-qcom-qmp-qserdes-txrx-v7.h"
>>   
>>   #include "phy-qcom-qmp-qserdes-com-v8.h"
>> +#include "phy-qcom-qmp-usb43-qserdes-com-v8.h"
>>   #include "phy-qcom-qmp-qserdes-txrx-v8.h"
>> +#include "phy-qcom-qmp-qserdes-lalb-v8.h"
>>   
>>   #include "phy-qcom-qmp-qserdes-pll.h"
>>   
>> @@ -60,6 +62,8 @@
>>   
>>   #include "phy-qcom-qmp-pcs-v8_50.h"
>>   
>> +#include "phy-qcom-qmp-usb43-pcs-v8.h"
> 
> Let's not include USB-specific header into the generic header.

Hi Dmitry,

This is actually referring to the QMP PCS register set for the USB43 
based PHYs.  Even though it is a QMP PHY v8 (ie phy-qcom-qmp-pcs-v8), 
there are some offset differences between the existing one and the one 
being added.  In that case, should we still have it in the USB specific 
QMP combo driver?  I guess it might make sense to have it there, as 
technically the usb43 based phy is only really going to be there for 
USB4 capable cores, and I don't think there's much that is common 
between usb43 and other HW that utilize/share the QMP PHY.

Thanks
Wesley Cheng

> 
> With that fixed:
> 
> 
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> 
> 
> 
>> +
>>   /* QPHY_SW_RESET bit */
>>   #define SW_RESET				BIT(0)
>>   /* QPHY_POWER_DOWN_CONTROL */
>>
>> -- 
>> linux-phy mailing list
>> linux-phy@lists.infradead.org
>> https://lists.infradead.org/mailman/listinfo/linux-phy
> 

