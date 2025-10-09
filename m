Return-Path: <linux-kernel+bounces-846907-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id EECDDBC9646
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 15:58:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DE8084EE299
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 13:58:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59CC32E9737;
	Thu,  9 Oct 2025 13:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="hyMWHI91"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E3AD1DE8B3
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 13:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760018315; cv=none; b=RhgxKoY442Nf+RDLJ4hJitwM83437PdSUzuBeaRCxsX7SslQIyWmDfndNS0sO5fRpVelZ54OIADQzF5jFrQbSFHZEgKgUbl+6lapGh6YN0J6gs78fu9CrSe+qdn8OkSVpATCo3jYJ7nMQ/zxa/OJrXys/TeK4Edg6j8IJE/VQ0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760018315; c=relaxed/simple;
	bh=8JF62Q3C+EsRAxzwX7Jr8Qg61aBRsdXSa3AMc4TtLOo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pNAeelwUDHg/Wz4ZcdoimwBWMDXYSbT0m1CkCZ+4h+8PQ644kVUUrIQn51zjfZFF8ZkHEb7O4ymPk2hn5ubuFPTCznjzRc4aazZo1qHn26ZqAPqt5wr3+mUy6pM8CRD9QN4t9CuL2mMtx/Fnx+N52H4MJUfgxAUaUoi4CTrleDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=hyMWHI91; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5996FSEW006842
	for <linux-kernel@vger.kernel.org>; Thu, 9 Oct 2025 13:58:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	eU4S/oCfNeusIxb1UAWsZP5JLwrWFLZZqFtcDi2NAvY=; b=hyMWHI911Bg/deAq
	3gKBoudkK3m18jJ7bnZzBu+YyEx3m4fMlNEaJpGHe7EoJYFiFxQFeT4hFeKbn1aR
	LQZumZmA43rLt73EORs/HnjCbK9FVrKWnDTI7zRQZF0YRPi79FOFHMElUIwMMD76
	/sDzah68bVV7JVyOZ3CtivzJ5OrJt3lX0geAJc+drwoGwxe95dP6LSuNkCAyKi2Y
	plCb9ONBsS7oxLSFVnz8Vpaqn2W0xv3cVSGLRbwkpa7W5VIywyqtHXpMUcNPvV7z
	k1G3ARnl7JQRI4NkZnOOACgAkW3fkd7H+m52bwAryevCTcJjRzugj7JrmWobCAXd
	bmeVMg==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49nv4u327d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 09 Oct 2025 13:58:32 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4ddf2a2d95fso3735961cf.3
        for <linux-kernel@vger.kernel.org>; Thu, 09 Oct 2025 06:58:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760018312; x=1760623112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eU4S/oCfNeusIxb1UAWsZP5JLwrWFLZZqFtcDi2NAvY=;
        b=ZwMctiW4A7O2sttInSDS/oMFY1pqxXdxicwsEI4ZB4po92eWLe+W0cWw2OMnUjhHc8
         7wbTgleX+3Z6/mlSrKm2cBd2QiVlxCkgxIfM4AnI/8ylZyYlXzXgHAJceV57kl6Tecr6
         GD6ww6AxThhlkXWVgbVejwdRYW6WBJ61JHkuBAXYM6p9zml93ke1KGF7D1jQYsBVJF7Z
         pc9DnWiWi8xXxSuvhM7DOkje1APEZEKvyJppEJ6JHv9+ByGobW6oSvUP5+B4NXOCcqJr
         5qOiD+4xPVUvcFlYkSsWXYmjGe00uy4oYfU0o+EFgUtmSnDlBRT8JBp7/I4ugqjQQ/zx
         KQBg==
X-Forwarded-Encrypted: i=1; AJvYcCVU5EWOz0tk0CwUX8mOCAxlwN98iMsy2kZL6OQPD5ulv7VxMdRNxrbL9I87eOwqZQhx9TvQGuxLEhe6/5c=@vger.kernel.org
X-Gm-Message-State: AOJu0YxejELaNDlO/toF0isVAGsnA3/mAUcDKf5hTjNQ9sok7l2ObAVf
	2PHIe9DS318mQVTxom/4mLA2B1ZbwxOYxkY8FvbTPdJVJ9HSpxOqSen7HCHeMoAcSQmZnUxXUYq
	knXX1+xDZzy9cXI+KauTY4LXxQ//H/OJ8HK/Dd1l9UU6eQRs9BIlDKYv5kF0lyEC31JQ=
X-Gm-Gg: ASbGncsRHMrA1wmJuPxhArVztW9XH4Tx+aA33CEl4tDKhnsafh/GLb/fmmWD0Br4+ST
	hQTJb51CnPRmrG2RtEhdXF8gKUbfk82NcqnDluV5OmeHe3NEUdhv1D4KEZkb3i4zKBORQ3tz4SG
	vaZpTxbTjoZyd6LGl+JCi+HzahvzI0Q6GUnorm4w3Bjuj+Onq8xkITbvxVLEiBWGUk6t9qsrgqG
	ny0F5lY/zbqvgeuZHoi9CYk4eUityQD1z0JClHfZffDAvVZ/Q7p7lI79Ntjay9UnFUjXNe+Gqlq
	HrcR2NF5x1gkgFJO8FcRY0C/7ErExn6y6dzevIc+C0J8LjKulI7yJ9/u92knopYH8r21SydaTMu
	4I7JDiZykwotFBoMJdTeDcKmUC14=
X-Received: by 2002:ac8:5fc3:0:b0:4b5:e9b6:c96 with SMTP id d75a77b69052e-4e6ead1deb0mr69214691cf.7.1760018312110;
        Thu, 09 Oct 2025 06:58:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFDlmAQ1SSqslLTs4Timgj6hjNiMNGuRJ654mshuUwvTPhL0bouZZ4Wr6ouAI/YTdADv8YPbQ==
X-Received: by 2002:ac8:5fc3:0:b0:4b5:e9b6:c96 with SMTP id d75a77b69052e-4e6ead1deb0mr69214221cf.7.1760018311376;
        Thu, 09 Oct 2025 06:58:31 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b486a173a5dsm1916364966b.85.2025.10.09.06.58.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Oct 2025 06:58:30 -0700 (PDT)
Message-ID: <c6880fe5-029a-4f8d-a08e-81a066a79450@oss.qualcomm.com>
Date: Thu, 9 Oct 2025 15:58:29 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 2/2] arm64: dts: qcom: Add support for Huawei MateBook
 E 2019
To: Jingzhou Zhu <newwheatzjz@zohomail.com>
Cc: andersson@kernel.org, konradybcio@kernel.org, robh@kernel.org,
        krzk+dt@kernel.org, conor+dt@kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20251008130052.11427-1-newwheatzjz@zohomail.com>
 <20251008130052.11427-3-newwheatzjz@zohomail.com>
 <6ede6425-6b99-4505-a231-de819bab9ada@oss.qualcomm.com>
 <6199698.lOV4Wx5bFT@debian-vmware>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <6199698.lOV4Wx5bFT@debian-vmware>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=Vrcuwu2n c=1 sm=1 tr=0 ts=68e7bf89 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=EUspDBNiAAAA:8 a=XCp-TdQE-aPcymyUR0sA:9
 a=QEXdDO2ut3YA:10 a=zgiPjhLxNE0A:10 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-GUID: iy0Z8oZWncityGHwNPbQIY-Ky0ONg5wi
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA4MDEyMSBTYWx0ZWRfX+ot4B+fXCdr3
 b9QOa3MJMecorXYsrziy30DnW+vPg0DdNH5ON6wPL/U2BR/7r0i8JfDKZ6/Q7gOZ1FAwciwogFW
 ZD/mqmlqJW6L8T3MeFaxIAvyi6mJhIJBipfoR+afgSA5yxFwg8rlnKhopqD2Opr6x9ikuKqvYId
 l9tn0T0MjJYThC8BowJ1+F31vYYyI2Rwd2SF/fvzBG0GaItcKD/wXGfhcH8+4S4b5ZpdP4bZyWt
 Iq6Ea1oGSWl//NvEZoNwt1ZTnkzkFzZl/vGrdBzMW8NbD/nKEvyiPDPQYiFzXholl8yI0Yd1cDr
 GK+KY+S9oY03j4oO2Fxguj9xJ6d3snKSTY9/EBhEnai3ihVfGnlloSTFJo17JvYisRfzOAs5tBU
 CGQbPuEhi8BsdLoYzU/j88lgsxqrPg==
X-Proofpoint-ORIG-GUID: iy0Z8oZWncityGHwNPbQIY-Ky0ONg5wi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-09_04,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 impostorscore=0 clxscore=1015 adultscore=0
 bulkscore=0 spamscore=0 suspectscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510080121

On 10/9/25 3:49 PM, Jingzhou Zhu wrote:
> On Thursday, 9 October 2025 20:41:19 CST, Konrad Dybcio wrote:
>> On 10/8/25 3:00 PM, Jingzhou Zhu wrote:
>>> Add device tree for Huawei MateBook E 2019, which is a 2-in-1 tablet based
>>> on Qualcomm's sdm850 platform.
>>>
>>> Supported features:
>>>  - ADSP, CDSP and SLPI
>>>  - Volume Key
>>>  - Power Key
>>>  - Tablet Mode Switching
>>>  - Display
>>>  - Touchscreen
>>>  - Stylus
>>>  - WiFi [1]
>>>  - Bluetooth [2]
>>>  - GPU
>>>  - USB
>>>  - Keyboard
>>>  - Touchpad
>>>  - UFS
>>>  - SD Card
>>>  - Audio (right internal mic and headphone mic not working)
>>>  - Mobile Network
>>
>> Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
>>
>> Konrad
>>
> 
> Thanks! will add Reviewed-by tag in v7.

Please refrain from resending if it's just to apply tags, maintainer
tools do it for you

Konrad

