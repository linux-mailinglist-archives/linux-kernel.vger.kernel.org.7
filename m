Return-Path: <linux-kernel+bounces-842599-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FE49BBD200
	for <lists+linux-kernel@lfdr.de>; Mon, 06 Oct 2025 08:22:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1EFF03B53B5
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Oct 2025 06:21:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BC671C84BD;
	Mon,  6 Oct 2025 06:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="B/a1/I8Q"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D83B8EEBD
	for <linux-kernel@vger.kernel.org>; Mon,  6 Oct 2025 06:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759731689; cv=none; b=NIDIHOf/VMmuqKJsybYZjQkDQbZl+2JuER/ntKe+NHns3IMoENIzHQh937ye0DYD3n8nPvCw4kcAhdS4PPBikKH7BNjOJ/IQF84weXV9uDj4UMMRu+lIKO16oZDhMbQQJKrbIco4F1XzjYJ9hLm0DTJJVE+BL9utpeW8uZX5OH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759731689; c=relaxed/simple;
	bh=1gKxYH6G5703madal3BzI9ccK5agAPITpacuVJtUDxA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pV0AhNoiLIYQdeWAope49Xx1dhXLSz6zATiBlpx5LJ9S3MJ9PWlFcwmMWFwQ99xnLX2hS0tRMHJwdq6mkGBHAxNiRmihV+KpwIYngjIIGAjEmR4WlbWvCwPu3E3TOhU79YtUucBteSwf56GpQ6Y3z9wmBKTcRhR3dH+NX1XQWKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=B/a1/I8Q; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 595KUTiI006173
	for <linux-kernel@vger.kernel.org>; Mon, 6 Oct 2025 06:21:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	pqBw6X+mphTJzKyTEbGzv9tl5aN8eM1+7umqmrnpPgc=; b=B/a1/I8QjwiXtAR0
	3U1kPjqkQDtCYhk68ISIl1rsAok2FZ4xylS4QL/Dt3EKtIySw8lzbSxDffV4iCX7
	vQubHp0xBsToZK9wfEUBQGfeW5QHLoBVwzABb12DzZLgi5zIqsQ9TZAuPKwl9x4h
	CLiXN1Kr9kGAtFE5pfCeqKU4QFulpaTO/uiIMnyWPz0fbhdiU2xDuBoKc4g1nQaF
	BR73AcsawyyjohiUuixAkxw42SHyixZcRS096VfAZywlqMhYd68MfZxBo1TrA+Yr
	bWuWojtOt8nvzJ9M+EjOF/r9UgKQoQ6Gi52vpFeDVfr0w11v9vBH2zyp1lmoquvA
	4nqJkA==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49jtk6u6kr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 06 Oct 2025 06:21:26 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-28973df6a90so44145275ad.2
        for <linux-kernel@vger.kernel.org>; Sun, 05 Oct 2025 23:21:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759731685; x=1760336485;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pqBw6X+mphTJzKyTEbGzv9tl5aN8eM1+7umqmrnpPgc=;
        b=KS9XusQxfm2GVbGjRWH/nsbUvws6wPCAaKMNRs1dkO8YFStBKcgUkFnEvRJDdrTqmB
         1GnDcuB0fHeZbQ48/ROPqQ2HBS3i82+BvH9l4PXK0lGBRA/D58XVNUjywO+lkXWDsvgU
         pQ3chky1ONLiG8WX3gS4Frfb2EPM2XaUSHqFD+rQqf2J+r/Fqze5fK+N9C9ZTyyGhf57
         WpWKhMGMab1EVMvg3g5f7BcA/sFYsXpULkSFW94B9xxDXS++as0DzXEqan51XocxwBtK
         pDEutwHfk/zUyQ964sJHjnqf17gjw2MZYKoXjkMh3zmvZLp77Wd+YVL55aRE2TQ34wIW
         mUKQ==
X-Forwarded-Encrypted: i=1; AJvYcCVI4T6PKunev415Dl3msj44E9VcICiwgSd4YDXqX2mvybB532iun9NZsy3+lcps5RuBg58oEbv+RIVoXPw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFLpx4rDQULtB0SS3BnSey6HE8wQeY/cVBCyXIsdgO+NJz8Bcq
	dtzaPLU8frlma9cfgERFMT879TPbYFjc/LtKLQJ0DOWz5TZ90rS9mNokjyK+tJtoqyPfowAYjsx
	cEf18IQq3p3xdYlzKdtSfid3aJwpT28UnMFIrNGwgmiFOx8mvJ9kkna3mXD0cIvBN30g=
X-Gm-Gg: ASbGnctr71LGbAgZS8wr9Pf6fLGeKIltNghv2b2SdGhh6ugXo7JY1/volrDvVdFxqcC
	LiMV/93erKc3soCptXtuBs8eTr968XLJv0behlX8ipQSoz8KbJqxz5gQMUKafzLZuDjF/+khLHt
	1Yu4nLcT11SywNyF9tT6zFBSYQWEKEWa/Sr+lfBNVyYPhdE9LYCYkuhPePHGGTEasYxRfi2MQMH
	QUqR2awtF0x+6XxiQijukWDpDr3e5n/oanJmIpSCZT9fsSBTqoPUZ/Nd7eksO4XjuXabNiWY12i
	7V9MFRDzuyG5GN4b5TvpM3Du95Bn2vlODEMZk7yPci3Eg93f4s+MS8GOgytC2N0Gey2uLRCgVl9
	3dK+ntQ==
X-Received: by 2002:a17:902:ef09:b0:261:6d61:f28d with SMTP id d9443c01a7336-28e9a645b1amr126922535ad.50.1759731685348;
        Sun, 05 Oct 2025 23:21:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFGDksJqEPnSCh/NIBWbkuUWFPnHcA9o8p5jALbq1jKgZg83zpF/wA8wpZbS8GZG8Ail/L3Gw==
X-Received: by 2002:a17:902:ef09:b0:261:6d61:f28d with SMTP id d9443c01a7336-28e9a645b1amr126922195ad.50.1759731684742;
        Sun, 05 Oct 2025 23:21:24 -0700 (PDT)
Received: from [10.204.101.149] ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-339a6ff0d4esm15497887a91.17.2025.10.05.23.21.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 05 Oct 2025 23:21:24 -0700 (PDT)
Message-ID: <66d3b851-5b29-ca88-53de-a4126c2b5366@oss.qualcomm.com>
Date: Mon, 6 Oct 2025 11:51:19 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 1/2] media: iris: Add support for QC08C format for decoder
Content-Language: en-US
To: Bryan O'Donoghue <bod@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20250919-video-iris-ubwc-enable-v1-0-000d11edafd8@oss.qualcomm.com>
 <OyMR2y907eHs6rnnO6bzy52LY_t8KXKscM-nTPu48x3NCYFU4mza-uz0HqnQlYqPg2JtDB8AhCtGAa26Cbq4PA==@protonmail.internalid>
 <20250919-video-iris-ubwc-enable-v1-1-000d11edafd8@oss.qualcomm.com>
 <27e36fdb-3107-4e7b-b402-fd72ea5c4d61@kernel.org>
 <mL8al4KIcE6PTrBxdJa_2UyBCdazqiqrW-cNH0h4hU0lxL9e1BBoPQwqSqafI_KMAHfhK014iRoKVkQmrds0dw==@protonmail.internalid>
 <5e7f20ee-7960-4a1b-bbf2-b5f5330e1527@linaro.org>
 <d603c0d3-4dd5-4ea0-8a31-47e6dd03ffd7@kernel.org>
From: Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>
In-Reply-To: <d603c0d3-4dd5-4ea0-8a31-47e6dd03ffd7@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA0MDAxNyBTYWx0ZWRfX2hi0SxVDENFQ
 NpAyAfQjaPS26ePFdTt8emjj6EENSp9jOYJ19TutGWV+SW2yorv8LjQn75awlc3rTV8NzM5KdT0
 1CFd5hMceRgg4av53VGzHBACzD+uOWzmcuX9XaBvtkcE43hZbqpOBWUio8yHqnBDbyBdW7dTJq1
 JRCQFaHSBueM9xLMWNsITwsDHt+VCIxbrf8bcbfENzwctvnXBH7C+ipX9u4UR61m3a7NkEjlLi5
 GussEw3gx0dn8MKbH0GY22afsJ1zeFuo5aniq2QuI3ARS+PlLDr3tu5eFWyD6jSxoHREW1bH4/u
 qpinldXWFiuVRcxzuatqOGHaVCFwXjah5MCN1/wqOBOPiA3rqve6XxoSZcdGVrFfKhYLzvK46//
 3BYgjpTZqe8FW6NcQtUTomzJS5Lvpw==
X-Authority-Analysis: v=2.4 cv=do3Wylg4 c=1 sm=1 tr=0 ts=68e35fe6 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8
 a=EUspDBNiAAAA:8 a=VHB8iGSYPZFVdnVCWEgA:9 a=QEXdDO2ut3YA:10
 a=uG9DUKGECoFWVXl0Dc02:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: aafKAVG1wsWc9qlaq5d0rE8UrhYPcs6J
X-Proofpoint-ORIG-GUID: aafKAVG1wsWc9qlaq5d0rE8UrhYPcs6J
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-06_02,2025-10-02_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 lowpriorityscore=0 phishscore=0 clxscore=1015
 malwarescore=0 spamscore=0 impostorscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2510040017



On 10/1/2025 8:34 PM, Bryan O'Donoghue wrote:
> On 01/10/2025 09:36, Neil Armstrong wrote:
>> On 9/24/25 15:28, Bryan O'Donoghue wrote:
>>> On 19/09/2025 16:47, Dikshita Agarwal wrote:
>>>> Introduce handling for the QC08C format in the decoder.
>>>> Update format checks and configuration to enable decoding of QC08C
>>>> streams.
>>>
>>> Since QC08C is a Qualcomm specific pixel format, you should detail in
>>> your commit log exactly what the packing/ordering of pixels is.
>>>
>>> In other words tell the reader more about QC08C.
>>
>> This has been upstreamed 3y ago for venus, which is the same as iris:
>> https://lore.kernel.org/all/20220117155559.234026-1-stanimir.varbanov@linaro.org/
>>
>> No need to re-explain it for iris, the format is the same.
>>
>> Neil
> Yeah no, at a minimum the explanation of NV12 + UBWC should appear in the
> commit log for this format.

Please see [1] in case it was missed

[1]:
https://lore.kernel.org/linux-media/10bb819d-105b-5471-b3a6-774fce134eb6@oss.qualcomm.com/

Thanks,
Dikshita
> 
> thx
> ---
> bod

