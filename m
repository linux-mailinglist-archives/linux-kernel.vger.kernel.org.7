Return-Path: <linux-kernel+bounces-800704-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 00DE3B43AC1
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 13:51:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 96332189E20E
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 11:52:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B25E12C11DB;
	Thu,  4 Sep 2025 11:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="iqoPVOcO"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 985B92ED170
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 11:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756986695; cv=none; b=UnTFuA/YlVvN8a3lDgpHYhygh8XtEA7QdhkIHSrMipvXzWFsXc/DBeXfra+Bcj9k3JFacpEPHqIRnubezx/CKh+gAFSC0PwHJYOFeyRKB3ewtantJihs3VuNVLsc6iOV2dSzd/6w1B7af1epm5lXnMW5+F42DUxz/hmYRSckVOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756986695; c=relaxed/simple;
	bh=JSAewW8zh+fZ1yWrIB6R0zPGW0XQeqq2H1lJm3a4q3w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qAmjMDlkESKl3xkfMXfo5ucUV+CNwDc4rpR4aeGQQhQkEghfrdfA5by+Y4cC/+fx0bb2VhNvjHwiOMmGQO63NEW3Wy++BSxfm0u50/x5OG0gXJJYlxovIlIgZ9kk7iR1uZiZAK6ZnUP/zdDtrWW2GWQCoYou0nQ9wcNdcnKhYvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=iqoPVOcO; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5849XF7U024601
	for <linux-kernel@vger.kernel.org>; Thu, 4 Sep 2025 11:51:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	R584vso3cXH+lZvw8QUqkj0DVoP99aWNoUcXQnm1Bos=; b=iqoPVOcOymn9TzJw
	ev9hVa9paR1Bu/l3KDd8xXCkudVJcQnKdARp0wjkqgE5Ji5oJXNHZToxR+8s037T
	U+XCLWZj6sT3PuAYLcflUyN4YlmLAgPS1pPcvwQMZC8Ip1BgTmsyW0VZksperwGP
	EB9ED036mlEHy7VcxDD6RUaYEcNlKPlYf4fna0SM68P3zyynlfFc6MkcxorOu6Ez
	6mYrBIiKxm5dKHiWcmUPX38kSlTHrkH7DigmqUwEw0Vqznvce8GzdFWuejvlCyBA
	dIPRkxdC7ZV7MvazlRdzpnpqFgQM80Mm1mWseqMyGiOz9Ycr2rgIOG8542YxxB23
	logJKg==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48ut2fq7b8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 04 Sep 2025 11:51:32 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4b331150323so2313621cf.0
        for <linux-kernel@vger.kernel.org>; Thu, 04 Sep 2025 04:51:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756986691; x=1757591491;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=R584vso3cXH+lZvw8QUqkj0DVoP99aWNoUcXQnm1Bos=;
        b=ed2Fbj7CcU0OuSSIQj/NzegEE6iTTldn4rUvvUwIN08VOb5N0R2VuNadV3tsSXOFL8
         AsTUoHwJ/J+wrhHdEuL38ZAdnLi7uQHhrqDw7hZu0/d6EoTUW5i9zbICjeIqwELobO2Y
         yohWFsZ+2w8jrT6KuKBhFi3UnLsGB+Ooo4ML0x2qSVACwmPDrFZ30V46HUcUFtrgcWT8
         rDO346bJfD3F3r1+vj0Cph7HbLjE9x1I2T7C4rJcNA8AX0R7Vxoi1yDDL8hebBuEle80
         5dnA19vd8Byds9qNJ4tmuWphMnr9eXSy+6pO6w6FWARrPdeODMqfMKXyvftmc9HtCp5G
         /6Vg==
X-Forwarded-Encrypted: i=1; AJvYcCWUbpqHBdwb97FViPuTgYtf0Wb9uo0EUNsXEP0H+DkLbHo+e63Tmy9EPWg1TooMdPYLpMRXjrwIXYhPyqE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6LTiIqum4tkxZVcltJfnT4MXg0DNnB2wH+GU4BTqrw98HmvtK
	9PoC7COikdrRPdvhQYFGWgAMwuNOcnZket19vVNg47aRZFeHhZ23Hoc864R08A2HYdaV7zgRPPP
	MZ0UpYU+mBBfra4aQ2+YSsC4R6QRkmoAOmFcZKxLuqDdKJ6bD2RapwsO5I/vjvMpkJm4=
X-Gm-Gg: ASbGnctAQj9A/amnViYauyZDIvptLPAkhXHVBobuDr/jDRF3Qy/AD5wzh8a94RQRh5+
	Jy5dcmp30b5Uuk6R8sZ7LY/C28ChCVKhI2VYvYyAsmloRsjkQ7VFDGQ4LVBM0CYawnTDtkV4JMv
	wPTmCRHD1fHW1kIHxmJ/5/IePq4qpeGp12DS9t0RelCoyOpoUAojKwwzhZcgikHJ9XR4sJtSW6J
	nkBh1vT9bfkC5xNnGK3J5S6Zh4dlQS8gTTSjAB/dAc4HH0mZPH9uWL90IS/4HhbG29+KomcWcas
	3b9fcRXx4cStEV0Rp8EiWP4HJnug7TRKZ7vL3MByG39PuyDidS65H0cnA9YaNe8gBh6wsxK0Nbv
	NiR8M6c6d12L8CTct4ad1Qg==
X-Received: by 2002:a05:622a:1183:b0:4a9:9695:64c0 with SMTP id d75a77b69052e-4b30e98a593mr167186541cf.8.1756986691124;
        Thu, 04 Sep 2025 04:51:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGtk32uxf4nTUrAFGKTvW4bcrfE5iHxFvZZlL7ScTS2HEnwcL8cjqjvnygnT0gm/C5S7hxpyA==
X-Received: by 2002:a05:622a:1183:b0:4a9:9695:64c0 with SMTP id d75a77b69052e-4b30e98a593mr167186321cf.8.1756986690665;
        Thu, 04 Sep 2025 04:51:30 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aff12a6b404sm1434629966b.88.2025.09.04.04.51.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Sep 2025 04:51:30 -0700 (PDT)
Message-ID: <72a24049-81e4-4ce9-8bdf-63315209be7a@oss.qualcomm.com>
Date: Thu, 4 Sep 2025 13:51:27 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/7] i2c: qcom-cci: Add msm8953 compatible
To: Luca Weiss <luca@lucaweiss.eu>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: Loic Poulain <loic.poulain@oss.qualcomm.com>,
        Robert Foss <rfoss@kernel.org>, Andi Shyti <andi.shyti@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-i2c@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250810-msm8953-cci-v1-0-e83f104cabfc@lucaweiss.eu>
 <20250810-msm8953-cci-v1-2-e83f104cabfc@lucaweiss.eu>
 <aJnefpETGJm_cuRY@shikoro> <f956eccec6b8ae2737b1e758b8357051@lucaweiss.eu>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <f956eccec6b8ae2737b1e758b8357051@lucaweiss.eu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAzOCBTYWx0ZWRfX1ZrTj5QwnuFt
 LbcEATK84iBduPiS4Q/ZhCc9yVQ2y7lFzeMg8kzexQ3Th12bUXPCQNuPhJNrNDHUdbJofeScttZ
 VR7MmR0mZYRdaqb3OXDyfT+KSZfY46UEzG5j3sqo5kbR/6hAHWF9WjCc0HSIccuY/KyBUhE9hdi
 TVGclzfdEOx+cihiivgdqmappZABMO0yAjGVmcJyEA7+ii0L0k1vjUGbkO9XwiwJdBYrFtiDbLJ
 SFGUvWaUDeUfeud4m5V9plwS+tuHikiw3nMpQPd+eOhsFlWXkryEV0LS3zP8XWb5Mu6JfWOPHfy
 nKaSwrVjcHuWefuJjuskGyZGi8SdTplIv2vqFl1KCVnq9N63jPn0i2jA0INFJrus7p8G2ikeFFi
 VW4doi6z
X-Proofpoint-ORIG-GUID: NwM59UwHfjBcz28QrtUXaYLOvH6sgaHt
X-Proofpoint-GUID: NwM59UwHfjBcz28QrtUXaYLOvH6sgaHt
X-Authority-Analysis: v=2.4 cv=U7iSDfru c=1 sm=1 tr=0 ts=68b97d44 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=_dxgTR6_AXVo8Bd06IIA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-04_04,2025-09-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 clxscore=1015 impostorscore=0 suspectscore=0
 malwarescore=0 priorityscore=1501 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508300038

On 8/15/25 9:12 AM, Luca Weiss wrote:
> Hi Wolfram,
> 
> On 2025-08-11 14:13, Wolfram Sang wrote:
>> On Sun, Aug 10, 2025 at 05:37:53PM +0200, Luca Weiss wrote:
>>> Add a config for the v1.2.5 CCI found on msm8953 which has different
>>
>> Given the above version number...
>>
>>>  static const struct of_device_id cci_dt_match[] = {
>>>      { .compatible = "qcom,msm8226-cci", .data = &cci_v1_data},
>>> +    { .compatible = "qcom,msm8953-cci", .data = &cci_msm8953_data},
>>
>> ... why don't we use it here to stay consistent? cci_v1_2_5_data?
> 
> I don't think the existing 'v2' or 'v1' configs have much to do with the actual
> HW_VERSION of the IP block. For example on of the newer Qualcomm SoCs has HW
> version 1.7.0 and is many years newer than the msm8996 which was called 'v2'.

Most of the i2c-speed-dependent configs are electrical and therefore may
be configured as you wish.. I recall Sony Xperia kernels made changes to
that rather often, whether really necessary - I don't know.
The programming guide suggests a couple sets of values, picked in order
to meet the I2C spec.

The queue depths and max r/w lengths are per-instance (SoC specific) and
change very rarely.

> 
> I'm also not sure what these parameters depend on, if it's CCI HW version, or
> something else. So naming it after the SoC should be a safer bet. Also the
> msm8974-cci was only named 'v1.5' because it's an inbetween mix of the v1 and
> v2 that were already upstream so arguably that one shouldn't have been called
> v1.5 in the first place either.

AFAICS there is no "v2" CCI in existence, msm8996 is v1.4.0 and newer
platforms are v1.x.y.

JFYI there's a revision ID register at (base + 0x0) which the driver's probe
function conveniently reads and prints with dev_dbg.

Konrad


