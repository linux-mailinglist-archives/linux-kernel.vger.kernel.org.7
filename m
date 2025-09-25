Return-Path: <linux-kernel+bounces-831607-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EACFAB9D1C3
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 04:14:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 694043AA0FE
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 02:14:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B0722E1F0E;
	Thu, 25 Sep 2025 02:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="kKhpgsH7"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16310255F31
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 02:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758766487; cv=none; b=feK+W4wkTRi7/Fp//cYnLJQsveYH+eDajsdI94i0miFMnSrlpvClK5HpUT88TNN2Svpjf95XJyqKQXPB4WjsVyruSY09SArDtfEU9aD7y7IzV/I8hkZEyUaYwndTz7HTNtkuvUqy1vVICQ+W/tpl04E6E4MGy40hn0j5J4+X/64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758766487; c=relaxed/simple;
	bh=naJzm2+LZbO2Y4ZMy0R9T9gNZ+PyIaodhhZMYTmfbPI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=duv9DY/vJm5y/OzARNrziRjNz6T9qJI9yoyK183IEZmGpzlAlzgherUD5L0pVD+dbBUXe1rsIMcX6OYfidoRrDXgR1CvB5IF3FMXarQvO6R95+xTR0kB2OCXS3uBWHSGaXw1YjLjj5wTQnNB6PqYmGTT4wS3JoumMKbbWjrWKmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=kKhpgsH7; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58P1SdjM030031
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 02:14:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	qYb74ctst0DsXsUARWUIqV3xVpP3o9baTa7sSWce5hQ=; b=kKhpgsH75HlNeOxk
	JJu+Dp6XTSisBBn8B/4goRuEfU7cfMca3PCQCbxShW2KngxSRgOn1b8xjr/XRVeL
	DYS9pW9gt5fIuC33/ewU4hQ8RDGSL0QorY3dFngQDl7GAPtdrj3xq+xrOZf6x0BJ
	+g3iaggg9LQHiyF//c3vWCXNIyX29dOtykoQASiuKOgE8hwdKRYg+wZJeEZdLT5a
	1JUBIwlXZ1MmGhrfn/B/BKDW1/jS7cCpSPB332QXjxCw0m+dNIA9qTw2uEWkgSEw
	Tlis3v3S1c1spkGgUdJqD3tEZhhI1l/XBso6TIPdiLPZxGajhpF0Rx6iIGfZE0fB
	rbezBg==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 499n1fp9mc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 02:14:45 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-272b7bdf41fso5096635ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 19:14:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758766484; x=1759371284;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qYb74ctst0DsXsUARWUIqV3xVpP3o9baTa7sSWce5hQ=;
        b=rOuCMPuE5HM9FhtUuCT7U4i3HY9mOcuxTUDgEZd2MxSVBwF5qD1A9pm1i+Hxkpax6R
         inHN75VXkBl7S/cW00W+6ilisQ5k19vn5kxoTlQ4K09NPPeT+J6Qznlv/z/CQ3OPuYqX
         pJEz466/m9K7eN+4ejtC5VF4jvU8J8T3vOtpRt0SGZ1tfGcEbFHNuGsFqPs29UD91BE5
         s6Zl0RjAoxJ26KMxf1MSTkibuy1+8tsbb4jVvwbAFPLEZdTJveqIzka/Za3NIOsBVMaS
         YpCzNEHU8IqxCV0hMTJvYqqpKoD5i0EZoX0ZpePv+8icusS3qVJ5jAtxxn5fUFAoISmC
         JOPQ==
X-Forwarded-Encrypted: i=1; AJvYcCVu/ZLIw8ALQqXxbyP15pV4dowomVpGVUfkS1WlqUhE5a0wj3jcA2GktMxneYMyT5sSMYXUetGImsMgY7E=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKL4oq+KiUgyd6KvRS4BKZKwnpn3iORMvR8etSEFHAXoz2pcTj
	GC+zKucUeB+L/ef2iLuA42d4YiTEKkdqnm1g6otss+md+EO2XsQ/K8UtDZbFq6hkMzvQIPyRJlC
	mIaDsLN+Mq+jB3z0ZLeVPTTQ6Lfk8YDS1JkiytyEPnBgTcyon3u90qqbUnx7B+NDEq8g=
X-Gm-Gg: ASbGncvGpBqsUYb3NJL0+bw9/HSmgeF6YIgI28AMCw4zCsz7akkO3gxSH4G7XqioW3L
	vsckW84KewDJfs5znM4x1rbKpuKqD+Ty7cjxS1cLIQ5v7kbddmuSzlJW+uP9LhcDGBgleVo7PWT
	UI3TwyEaEF0NU2yWeBsKF8mw937mTr00aVLqrCJZOUDtLyaLqUJyIj1hbNRXzqtKDE4Z4XiKjQy
	YGmwU6nP1f5Din2VuMHNmsPooRnCI/xv9Mkene36sGRsueUeM6yxf/GB1HysGPUFRQHkYi5Ct+a
	+r6nlD5NFPkC4McjCmie9/2fOd0WZfJJ83luWeEkaBgHEmUBx4lzsHon/gQTAphhG4UJlpb+PQZ
	+GXbkOw==
X-Received: by 2002:a17:902:c94d:b0:272:dee1:c137 with SMTP id d9443c01a7336-27ed49d2c42mr16317155ad.13.1758766484502;
        Wed, 24 Sep 2025 19:14:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEyxJuLNtLq/o0cb418AiMSRh+W0XoH4JxAaKBFGhkZ92bPDHbrLdzEVGWl23fcg0V3B8oWOQ==
X-Received: by 2002:a17:902:c94d:b0:272:dee1:c137 with SMTP id d9443c01a7336-27ed49d2c42mr16316785ad.13.1758766484006;
        Wed, 24 Sep 2025 19:14:44 -0700 (PDT)
Received: from [10.73.52.96] (pat_11.qualcomm.com. [192.35.156.11])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-27ed688226asm6880855ad.65.2025.09.24.19.14.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Sep 2025 19:14:42 -0700 (PDT)
Message-ID: <5a6b3a3e-c6f6-ba39-9edf-eab3e1815862@oss.qualcomm.com>
Date: Wed, 24 Sep 2025 19:14:41 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v2 07/10] phy: qualcomm: qmp-combo: Update QMP PHY with
 Glymur settings
Content-Language: en-US
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: krzk+dt@kernel.org, conor+dt@kernel.org, kishon@kernel.org,
        vkoul@kernel.org, gregkh@linuxfoundation.org, robh@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20250925005228.4035927-1-wesley.cheng@oss.qualcomm.com>
 <20250925005228.4035927-8-wesley.cheng@oss.qualcomm.com>
 <un3pulyn7tv3qihdnqmktsctped32am2eglxzfpwyz3u3tqspf@fnieck3i67j2>
From: Wesley Cheng <wesley.cheng@oss.qualcomm.com>
In-Reply-To: <un3pulyn7tv3qihdnqmktsctped32am2eglxzfpwyz3u3tqspf@fnieck3i67j2>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: UGgf1d14CXjkJUFdRj0ku2D4TJL0tTTP
X-Proofpoint-GUID: UGgf1d14CXjkJUFdRj0ku2D4TJL0tTTP
X-Authority-Analysis: v=2.4 cv=No/Rc9dJ c=1 sm=1 tr=0 ts=68d4a595 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=ZdW6uxA9NKXbfdqeeS2OGA==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=GfICSpz_d4rxbVQ3OkEA:9
 a=QEXdDO2ut3YA:10 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIwMDAzNyBTYWx0ZWRfX90xN9rkZVpQn
 UzB98HLlWMmk4Xd6LuWSz78fgxtnwIbctL6SnJIERTtLSXQdLri0AbtdtPKSbtDs7m62zYrl1OM
 RxzWwjk6nVikCZR36OqLSC0cxwPigxtOQxenE7RnPb/9j5w1cEn7MAPVWxOeOXJP4CyqHJsn71Y
 SQAvUyaB/QFPwnjCxLq/GPzHCm05h88EBo7yXwJbHGHy4KtJwDms+wEO8WyX6X7g4DHjbDnudLx
 e4wAa/IdRM2/rtPi65hBKWiUilEtPzIlBUkltoYCNjPRfGt5KGvJD4LY7cseZ2+BL7nWQhr8JND
 JGzGt66BjtM9UAKEvCf0zS1oqW4JLUT1No87M11B70pUdZhmmz2VlaS8QqUQ03kUGnqyFJ7pZ7T
 LSiAnKod
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-24_07,2025-09-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 suspectscore=0 adultscore=0 malwarescore=0
 phishscore=0 bulkscore=0 priorityscore=1501 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509200037



On 9/24/2025 6:30 PM, Dmitry Baryshkov wrote:
> On Wed, Sep 24, 2025 at 05:52:25PM -0700, Wesley Cheng wrote:
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
>>   drivers/phy/qualcomm/phy-qcom-qmp-combo.c     | 311 ++++++++-
>>   .../phy/qualcomm/phy-qcom-qmp-pcs-aon-v6.h    |  12 +
>>   .../phy/qualcomm/phy-qcom-qmp-pcs-aon-v8.h    |  17 +
>>   .../phy/qualcomm/phy-qcom-qmp-pcs-misc-v5.h   |  12 +
>>   .../qualcomm/phy-qcom-qmp-qserdes-lalb-v8.h   | 639 ++++++++++++++++++
>>   .../phy/qualcomm/phy-qcom-qmp-usb43-pcs-v8.h  |  33 +
>>   .../phy-qcom-qmp-usb43-qserdes-com-v8.h       | 224 ++++++
>>   drivers/phy/qualcomm/phy-qcom-qmp.h           |   4 +
> 
> I think yo've squashed too many changes here. V5 and V6 headers should
> be a part of the previous patch.
> 

Hmm, not sure what went wrong there, but I will fix it shortly and 
submit as v3.

>>   8 files changed, 1251 insertions(+), 1 deletion(-)
>>   create mode 100644 drivers/phy/qualcomm/phy-qcom-qmp-pcs-aon-v6.h
>>   create mode 100644 drivers/phy/qualcomm/phy-qcom-qmp-pcs-aon-v8.h
>>   create mode 100644 drivers/phy/qualcomm/phy-qcom-qmp-pcs-misc-v5.h
>>   create mode 100644 drivers/phy/qualcomm/phy-qcom-qmp-qserdes-lalb-v8.h
>>   create mode 100644 drivers/phy/qualcomm/phy-qcom-qmp-usb43-pcs-v8.h
>>   create mode 100644 drivers/phy/qualcomm/phy-qcom-qmp-usb43-qserdes-com-v8.h
>>

