Return-Path: <linux-kernel+bounces-882938-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 03BE7C2C037
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 14:14:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8C68D4E9A82
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 13:04:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8133B30EF72;
	Mon,  3 Nov 2025 13:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Q3ErgN6d";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="UPrUUgYo"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F98130649F
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 13:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762175068; cv=none; b=mvhBrpjhChODF3L1NgYnoAkDYDuYjEYOiL12//gjdDJJcCjGnyqy2Msyr1PnPm1rdyj2D3FeZTG+JDpkgqA3m9w/EkN0uMiu938j10QmVo+Sft382vjQEuYzQxrGVrHbDAJ6WB4bhFfLnTxDgJ8B8xK4hpsUc857kDA1zB/+dLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762175068; c=relaxed/simple;
	bh=3c54EP5IAkw52tZkzmTqv588mC9yLN+3CNs3RYEHqZ0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YKTC2u1If+JpZIBtBLlj0aRk8Pt+P1YXoNntCM8Warvc0oZIchDAUnwiFwE5qc4gv0eHmhjlYNN5xcTH3OkqW6UPcvMcoFO4G+7HxSz/1bHOSycAXvXy67WkLrdJYznwUwCmVlI/OXeQc14sRq/Tcp5QMlPdnWKUuH3Ol4ZJzDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Q3ErgN6d; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=UPrUUgYo; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A36BHZT2267853
	for <linux-kernel@vger.kernel.org>; Mon, 3 Nov 2025 13:04:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	jT/a3Ji9mpcq0m1ZyxECMgjBQ2CkfXVS5sNckHRxbyI=; b=Q3ErgN6dm6gSmcE3
	m+ljPGqdES1WAQJSF6rn7b5WWD47JUj3MX28fHyWKitTt66k0OvjK4cYQPgYQuyR
	NMalKe3qYa+8uiS5ZkUXC8bVF+9JXWweC5l0/R5fk+qU6j0/Ga71x+4AFj58nxMQ
	f3S2Bq1zeWONE/NgyG1qiSAoVD6Zqs1skK+cNy1mU7YqTjcpivSCLAvUR4HUGTRn
	fk87hqBGukyQdHhnJdq1HHum91uHL9EXxI00bftl2k6zUE1UfVt1hp0qyt1lMNG/
	L3gnuy6L7PSrTngDe2RpjiQYhcUAOp4FFrpE7XJTtd1M5FrWDuvven662KbToB64
	GIREKw==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a6pwah5xa-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 03 Nov 2025 13:04:23 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2956510d04cso18473855ad.3
        for <linux-kernel@vger.kernel.org>; Mon, 03 Nov 2025 05:04:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762175063; x=1762779863; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jT/a3Ji9mpcq0m1ZyxECMgjBQ2CkfXVS5sNckHRxbyI=;
        b=UPrUUgYorSB2v1pvBAEb8m8F0DaSx/DXUoopclc7RhZ/+wm0X0RO1YZMQNBvfCnb1i
         wXa+cwWP/d1Tvq0t8WLgOacPziqj2CLRto+ygI+sNeRqkGfVpH/qbl44K6G3pxnlUo5V
         lyEAxXn3xi5P6s4VV0QWj4UMkvTJ05mEKaB5a0LoYUkK3kCfverbQc0yfLU/2gnwGJqr
         RiMIJ3wccHEz75wOw7uwfjA9BBGU1Nx++DjK8+lPsMJY6XMacirqAD2Pvu4pl2mZ5TKd
         +M+XnEIN/sKySje8lrSVdP1G+RYrvo3YH0kuZhgIoSamconGVKBpYMok0dpI9ug3bv8y
         1rwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762175063; x=1762779863;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jT/a3Ji9mpcq0m1ZyxECMgjBQ2CkfXVS5sNckHRxbyI=;
        b=UknqOw9QFDwMjmYWB7ODu2cuIAdTvooKMRPqioOD0aLXOJAYMCQJG4X+tgmU33VODZ
         8kmSgOEog47sLvzinQjiKmzeR1vfm5asZswpUvGGtsRkz7rpE3FY7qsj7cvA7xTNIb3V
         OzNvDl9Fb8exAevjMUPyaCpQPusL3yimP3NRt4bzQpUC1jWqHzdmuVgSTahx29TFIvil
         XOFNjrcf+sptjvH7EMXVinmxf7alawF9RDvkQB7WVuF/uFer831dtm7M9t2O8+8x174i
         N6PjXD1BUbTKM/rgcgTXmQgujXV5bC1imay9GVzrSbuwkehvkuc1lln/unLfPojX/a8O
         Qg3g==
X-Forwarded-Encrypted: i=1; AJvYcCX75Xw4pJSf1qXO5MumZocLxjOwv3ozeRl/m1uUkUIX+OnRQ/X8PEh9EipUG8hjtPin0grMKlOYtDWeP4k=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYziYNurfPjL5SmOxOQRceUCiann31a9QbEQH83n/KtB+a2NkX
	hX5vnAjgCWSUCVO7AIuiBxvdMQCd5QZzLIxIUzTIqsewYqk1yrc9Xq7LwYf4GY2Kj5PPfJHY4Uo
	cUrFQMgNXl8ufkhGD4WFutD79CSVQEE3vhHIySUwxX7etB0CUdlQWDPFNb9QCjv7Z/Ak=
X-Gm-Gg: ASbGncs7LcTiupzRa1TqdqJCGBbRXumAKVt6/f3zAIHw8uV6V+kJL+IjYEHPA4noV54
	RDiFvKa1wdmx6y7vVu29vR8zbEDy9RcZVJatfUwET0JZr2sEk2loAknzs4fvNmB0oUZWDBI5gxa
	ifUPmFSO7fKOHAE6OFMsV1BjdMbE5nTIWYtRIYUvV6aMBQAusDeUcVJ68mctKMC+QT2ZXegPyRo
	0bKO5SuwTz2bfWyOnJMF7fo6P4A283/REi0HqhJhV6dN6ClfSCI1DI6lMDnHaGajvgyrfeVQ5ld
	qsjKKWs1yRMiNZ2syy8UraUsxUUC0bpzVUuOJnQNoVhZVXgyzbfRwLS9hxfjwfHydNeL2VYuT3B
	fRpodHmp917cW2KeeWUcUj15u7WjfQwlqmGAOajTglUUrTnD/dwFoT5kqWJr2YvAa/IXBrA==
X-Received: by 2002:a17:902:ec86:b0:295:b46f:a6c2 with SMTP id d9443c01a7336-295b46fa745mr36867545ad.37.1762175063163;
        Mon, 03 Nov 2025 05:04:23 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEz0jwlEN2SbqhNT4mzZ63FJUWWpupWmg4sZ2wmy+yOiJPvDDb2lPEamXhnh338ITlESy3nqg==
X-Received: by 2002:a17:902:ec86:b0:295:b46f:a6c2 with SMTP id d9443c01a7336-295b46fa745mr36867135ad.37.1762175062590;
        Mon, 03 Nov 2025 05:04:22 -0800 (PST)
Received: from [10.133.33.69] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-295268cb73dsm119737495ad.44.2025.11.03.05.04.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Nov 2025 05:04:22 -0800 (PST)
Message-ID: <49b46127-f74e-47ac-aa4a-e5a5bb013e41@oss.qualcomm.com>
Date: Mon, 3 Nov 2025 21:04:17 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ptp: ocp: Add newline to sysfs attribute output
To: Jakub Kicinski <kuba@kernel.org>,
        Vadim Fedorenko <vadim.fedorenko@linux.dev>
Cc: richardcochran@gmail.com, jonathan.lemon@gmail.com, andrew+netdev@lunn.ch,
        davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        zhongqiu.han@oss.qualcomm.com
References: <20251030124519.1828058-1-zhongqiu.han@oss.qualcomm.com>
 <20251031165903.4b94aa66@kernel.org>
 <aef3b850-5f38-4c28-a018-3b0006dc2f08@linux.dev>
 <20251102160028.42a56bfb@kernel.org>
Content-Language: en-US
From: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
In-Reply-To: <20251102160028.42a56bfb@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=OrdCCi/t c=1 sm=1 tr=0 ts=6908a858 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=8BO9zW7oIjHPe6O9FGIA:9 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-ORIG-GUID: -nKCWJc3pDL1y_YYj-8Bv7CIXs6UHFE8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTAzMDExOCBTYWx0ZWRfX4xSybsJ59FX+
 lk0HlUW8780RQ3dGF+fdrCXP6I0BND8xYurTMtpuch/kWLMZ5cn/6fwZOIR66MCO77YXdvmzEPk
 pJHycB8Pgs/D48HXTcfJr2f6e6+eC/NtqRl/+ad6dkBRJNFuK268tzjZKMnZCGYWgiAV/xGeho+
 gh05+yW3J9Uy32XbsKcK8kUnRr7Tt7Hdc1HEr0dUoqskQXTJJktsOisrrrDjSsjLRoBJYOdHEno
 Q9H/xGRF/KFs7z7SBkMkY1CW+pg0LqEMTCCOCRDNDGu59cVD86q3qDKeo/MSYuRsjYYL278gOuY
 KU7vi+VXgGObI4qDJ5AYbpFNyoYAqZmXQTXdOpSY3cUgT6Kl3S2ePHN9c13DPpOxuut98OO2M11
 Ak+C/v8JfbQ+TFULOkJHopWKoRb7qg==
X-Proofpoint-GUID: -nKCWJc3pDL1y_YYj-8Bv7CIXs6UHFE8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-03_02,2025-11-03_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 lowpriorityscore=0 priorityscore=1501
 malwarescore=0 suspectscore=0 bulkscore=0 impostorscore=0 phishscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2511030118

On 11/3/2025 8:00 AM, Jakub Kicinski wrote:
> On Sat, 1 Nov 2025 23:45:00 +0000 Vadim Fedorenko wrote:
>> On 31/10/2025 23:59, Jakub Kicinski wrote:
>>> On Thu, 30 Oct 2025 20:45:19 +0800 Zhongqiu Han wrote:
>>>> Append a newline character to the sysfs_emit() output in ptp_ocp_tty_show.
>>>> This aligns with common kernel conventions and improves readability for
>>>> userspace tools that expect newline-terminated values.
>>>
>>> Vadim? Is the backward compat here a concern?
>>
>> Well, unfortunately, this patch breaks software we use:
>>
>> openat(AT_FDCWD, "/dev/ttyS4\n", O_RDWR|O_NONBLOCK) = -1 ENOENT (No such
>> file or directory)
>> newfstatat(AT_FDCWD, "/etc/localtime", {st_mode=S_IFREG|0644,
>> st_size=114, ...}, 0) = 0
>> write(2, "23:40:33 \33[31mERROR\33[0m ", 2423:40:33 ERROR ) = 24
>> write(2, "Could not open sa5x device\n", 27Could not open sa5x device
>>
>> So it looks like uAPI change, which is already used...
>>
> 
> Zhongqiu Han please consider sending a patch to add a comment above
> the unfortunate emit() explaining that we can't change it now.
> I get the feeling that otherwise this "fix" may resurface.

Hi Jakub,
Sure, will send the comment patch. Thanks


-- 
Thx and BRs,
Zhongqiu Han

