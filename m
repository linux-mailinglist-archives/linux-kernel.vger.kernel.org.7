Return-Path: <linux-kernel+bounces-750561-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF2E8B15E0C
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 12:21:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0CE1D16A728
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 10:21:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A29C2741DA;
	Wed, 30 Jul 2025 10:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="gjFWxtb7"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B83526FA4C
	for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 10:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753870869; cv=none; b=a6XaE5ZaWIadrBFMxG8iRm78wMxL3KOnU6YLISEXf/CiWZ6riVaMPCW4+H2PyqPKMHMf5DQrnS7CP6oa+AX/zd5ylZEeDgswUk1nx1jDm8eHEpsPr6ogY6tE5JI7Zz6ntxcWqhCIbmGr03BcmKHOrCbTmC3zrBdkEItkla3HLJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753870869; c=relaxed/simple;
	bh=j+9hz4E+vsPZjdDrRd0sik2x2f8tzkAgQtvmJSLMoTo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kPV1AifcAl3wZ3TUinx2vKhzr5EUlMQGkldgx1+M9fHvRHa5UfO9xMI3Y8z1tk1nIA4EC2JUY9MeCKWkIVNsm0Y4POZkj4kOE0pkIhtrILTRHGWumSxqMRNlRYPP3EW5ZyUQQBohX7h5MswVZakjCFixJW8KhZsmJ+eEVxOD8AM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=gjFWxtb7; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56U682dR027594
	for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 10:21:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	j+9hz4E+vsPZjdDrRd0sik2x2f8tzkAgQtvmJSLMoTo=; b=gjFWxtb75Y4ca+Pm
	hr+/9aMcZL3+9Rehg/l2Oo/STEYeqKjwwL4bMFNtBWU/lcMoHNuSIYtHSFQwqwFW
	SQ9QnRLg359/kpOH05QewnxLi78qgfBVsK0QmPKmn3gPEQHJG3fHLuNIV50A5wwR
	0eBhNyzx67ZQLYqpjJbzXguJRZ+xm0eWAaBKMiAkAQt0mBsevuwMl8vn2/ajsTbe
	hmEZ6E8mpBR3w7D0O7AAlEHBVZVAIOXt83e8l1APvnj2XvI/LLa1rfZwEf0HLtSf
	qmb8f9W58H/u3hNxZYDQAPlX90iyx2/ShRitSc1oD5d0Fc+ajTAP5KHULLtV/jzg
	obcPPw==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4860ep0pyn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 10:21:07 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-748f3d4c7e7so6352129b3a.3
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 03:21:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753870867; x=1754475667;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=j+9hz4E+vsPZjdDrRd0sik2x2f8tzkAgQtvmJSLMoTo=;
        b=LIcLj7zAxtlZpolCVBO8sSGvw+6FLCR3r7X5C+lF7gjdiEaE27x3xMq2urAmnI9TJr
         HUNqzV/oA4OC6lbdF4T0f33m5LlbC3I/bT92nDbqZxKgVgnC4ygB7kR5sgKi+6OajkGG
         11296HXMwE/tfzn8QDB6zNiPOKyK3gDh8vFDNlBfjQUQn5LGWido0m3l9ROyYdYoN5MK
         9aDPV628Q2pv0T185mwPbeoa/bp5tJLu0H6PHrwfqxSx0qxYIWsnHThMANZ8w3Tgve0a
         RPik5ZT34o4jWBgmis/xNhSlNyyMl+Ys2Gv1+tljW0QD9AEA97YY+0CUFDmRGoFWbZfA
         2zqQ==
X-Forwarded-Encrypted: i=1; AJvYcCVj9LeV7sTIeE5ZCHLHotjuT3mOgJERKI1DNMmLz2mACeP8CU58kEiN/uSQnjRCVqKVmgOh/wjrj/rQlF8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzfJYviKEZm0HRbw2xQehzRYRRsuZMIJiiRIAmxgzxtHXePG26w
	jEvJZTP7e+KHe8fwL/SBN3T1KW3/ufN2j9dOse0mU0S/Uv1B0TX0SaY68yianeisHMit/yO5cT8
	Fd6IuyB7LYUhoAjpf+AeiVCMVHV2pz7OXAkIpd3cPHdTtszqwdJYb55ST7k5cbpRIQWg=
X-Gm-Gg: ASbGncvpFRw1NTMrSUcbW4WNCEfEtXpbuKLher3Df5yBwlcQtN0faT0/GCgX+y3E2SG
	pEAVYkJ8kJPNtncWJUlxpCEfWRFY2iGL+bhoKzJQqMJYryThXfsLSZyG1QUOzx1Wh3XsJHxv5nA
	xmA4FDJqFnLKAhSVj/NRHCGFcqeA/yZspNXyk5y7lEv2FnWfn9B1WRRl4Bm1MVS8K5nUHf9qhpk
	i/XOf8rFZEh0VI19Ok16CI5wWKxY/eC+Kd3zXs/WhsyZD2fEeUJDbs89F/3pib5hks7nAoLdcnX
	14XwizGnCtwAugAjtbqIP4u/d/GiAQfY8K+YdwtjyVp1SjDh1MXjZ/lMEvRYcji29Epq1mms8CA
	pL5M+noxF
X-Received: by 2002:a05:6a20:7d8b:b0:220:2a64:bce1 with SMTP id adf61e73a8af0-23dc105d19dmr4848589637.35.1753870866931;
        Wed, 30 Jul 2025 03:21:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHikeRjft5Kl0sNlMQ4iyepVjoUKBt1kzPNi1m1KyVzj+vIRXPgqn0nhGvehtzp5/D9BIPtRQ==
X-Received: by 2002:a05:6a20:7d8b:b0:220:2a64:bce1 with SMTP id adf61e73a8af0-23dc105d19dmr4848538637.35.1753870866416;
        Wed, 30 Jul 2025 03:21:06 -0700 (PDT)
Received: from [10.152.207.84] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b3f7f58f15esm8958739a12.20.2025.07.30.03.21.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Jul 2025 03:21:05 -0700 (PDT)
Message-ID: <91100136-bb4d-47e0-b910-b9c940775747@oss.qualcomm.com>
Date: Wed, 30 Jul 2025 15:51:00 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] i2c: qcom-geni: fix I2C frequency table to achieve
 accurate bus rates
To: Andi Shyti <andi.shyti@kernel.org>
Cc: Mukesh Kumar Savaliya <quic_msavaliy@quicinc.com>,
        Viken Dadhaniya <quic_vdadhani@quicinc.com>,
        Manikanta Mylavarapu <quic_mmanikan@quicinc.com>,
        Bjorn Andersson <andersson@kernel.org>, linux-i2c@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@kernel.org
References: <20250513-i2c-bus-freq-v1-1-9a333ad5757f@oss.qualcomm.com>
 <kt372ehgwt3kjaxkdk47rri4s525pr4a6fvtjxy5c7rsf2ad6s@ebeaygqihe5k>
Content-Language: en-US
From: Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>
In-Reply-To: <kt372ehgwt3kjaxkdk47rri4s525pr4a6fvtjxy5c7rsf2ad6s@ebeaygqihe5k>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 1lEHKI9Uyf3Cbg6UZRk8GWyewMJ8d86q
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzMwMDA3MiBTYWx0ZWRfX1hvTbW1m9IYK
 D/q8VjEFnKjc2NqmIyGr5zmHET9MO/g5/8gheyblkzrrv184rHuQ6KyepIC33z+FYGz+uU4Wno1
 j+iRAG0R0cWZm3f9o8Szva3ACab2eQ6GEQ/mpfeAUJTNzurSV6D1W/rNr50lC6AdJEnZvI5WRbg
 BS0e8QmROv9N5Z6HoH/ei0g+S6VlBT3AhD652Jp85Xm+PXzkVBDOuNM1nR+L/ms0Yz7x/RZr7Nj
 fMyKykjNcNj1FuFXlJcUox4dTK0wDKqanFJePFZflSBw4/udmbJNBOwXFOxeZkmHLUmXhihMTB5
 RdeL4L2wx7uSnZdZwVym+NyCIoeeaAKpBEZ/c5+bglUWnQf3hGgB2qp9078DSOseKvXuaiaLwH8
 qRvtItphZDF0cNJKx44uvGspsXHE7wkGtkF5lGn4PnJTZx6A1lKoTZhLuFZKATU24QSJmTJS
X-Authority-Analysis: v=2.4 cv=DIWP4zNb c=1 sm=1 tr=0 ts=6889f213 cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=Q61XbrR-VouMIcKfwD4A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-ORIG-GUID: 1lEHKI9Uyf3Cbg6UZRk8GWyewMJ8d86q
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-30_04,2025-07-30_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1015 bulkscore=0 mlxscore=0 mlxlogscore=999
 spamscore=0 impostorscore=0 suspectscore=0 malwarescore=0 priorityscore=1501
 adultscore=0 phishscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507300072


On 7/30/2025 4:12 AM, Andi Shyti wrote:
> Hi Kathiravan,
>
> On Tue, May 13, 2025 at 04:38:33PM +0530, Kathiravan Thirumoorthy wrote:
>> Update the I2C frequency table to match the recommended values
>> specified in the I2C hardware programming guide. In the current IPQ5424
>> configuration where 32MHz is the source clock, the I2C bus frequencies do
>> not meet expectations—for instance, 363KHz is achieved instead of the
>> expected 400KHz.
>>
>> Cc: stable@kernel.org
>> Fixes: 506bb2ab0075 ("i2c: qcom-geni: Support systems with 32MHz serial engine clock")
>> Signed-off-by: Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>
> I was sure I did apply this patch, but for some reason it has
> completely slipped from my sight.


Thanks Andi! I was about to remind you on this today :)


>
> Now it's applied in i2c/i2c-host.


Hope it will be part of 6.17 PR.


>
> Thanks,
> Andi

