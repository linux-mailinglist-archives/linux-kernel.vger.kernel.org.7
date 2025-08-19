Return-Path: <linux-kernel+bounces-775219-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 00BEDB2BCBD
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 11:14:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 703C519667C8
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 09:12:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26A8531A053;
	Tue, 19 Aug 2025 09:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ALYpNebQ"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCE1F31B12D
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 09:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755594656; cv=none; b=RMjPBh72jFVuxjDafSvOuKGbML48LhtpXcq7KXafM/mQprMHuGfutGnMZbc7YtIPqmKuOiih4Ar3dlPafXDMTGqLfLk/nX8uX4ndtO4b1f8HjiZj2FbChU44eNgvxbMz+s+kyJuLR0fmpRYXg0rGWLFaX3rnln+Wck3c+w4YWgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755594656; c=relaxed/simple;
	bh=c/0xNcgwWCHWAKR+JVYlYWfbwgtw6ExzI4wBauUtpcY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=o1+NfGaYe6yZJmUE8CVtUFWUD7YYtjUGi23H+QTDGuFhX9wac/OAZoUEp2oz7Mn5xOZf8CU5Q3hiG3rf5q3l/qhv5zKvCZ4YXjoRLVtCYS4VUzrIgGVhLwscUcR2kh5mxVeYowYamwOo0TzxIcF6rAipvMSSfh08yNHfi/NbVdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ALYpNebQ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57J90Yj3018016
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 09:10:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	XsV7Sy9k+vwy5ouGV8qiQwIlxBTG3StwfrEciiJABG8=; b=ALYpNebQBBPQijLH
	hUgUj/WaqcCgC6a24ZsazZdY6HSViOWR2cUpffsVfFMQBcwMU/ci0l59/XhzRlMY
	HUDYarrd2Qo24Bh0U5Ir1DBmsNLQ2HuvxLh5Vxa8N/s3vC5vJL5fuU/KWnsSgTU4
	f8QSTKUZOAaEr2gr0R8+bvO54UYch2wljZYFQvx8V8OlMYYbRi0OQVTJTAh9D9V8
	hdENLe9vQNi+00MiYn4UyhMtJ0f4ut0glI52e2q5wSxZCcADoI3eLb1Oe9p1kTdJ
	4fw5+a2ZI4G/BwYxOLUP6EIlTDczbOH8KR655mMtJcvrvXl0uaD5xwyIwaDpXTEX
	tc06/g==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48jhagyv8s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 09:10:52 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-24458121274so61734455ad.2
        for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 02:10:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755594651; x=1756199451;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XsV7Sy9k+vwy5ouGV8qiQwIlxBTG3StwfrEciiJABG8=;
        b=pETaIo1wk4mAc21iXn2bcg0i60uh6g6GVjPx/g4iWH6FnfPm0K9oI8FBICxdGARVnY
         kMjikjHpq6COjJjRteTrA6HdRzIkkCE6IlKYa8dqqRc6jXtTPJKPvmvtYW/5G8OaI/XY
         /c2g/8RRnQfgqWFTd7Zoh1CcvCOnPTrZef++ZSQyLCW/feIythufU3gd2O84gsUQqWMR
         CJaFKog4vHMmUkrhGGzqPymx1WXf96/aAVcZrYzzTOw4JUMDT4/6wGitXcCRA8C5ChDJ
         z9+u9akVBrsEypBMFmfm9LxddmgpkZaMUIBHJdJBF3ty++sjfNw4HhifRVK4FZkYoJPz
         jW6w==
X-Forwarded-Encrypted: i=1; AJvYcCV8QaVoJSCoS38zDDs4JBl5HFR+EroXELbpT6F9nzsrHgHZJQF6p9DfXopggADm4kYQDjZsJjXG9W4DZHk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzG9i8tY7LaVmAcqtw5ero/v2yFuVIYrRazUIS621Qh0mhSdAO4
	C3M9psMrC3BvHoD9WVEdRn0Xru8kX4qmahVudHzNbnpfVNyRzn76dtUqye5d38MX8deRiFrEomE
	oHCwGWu0P5EvZ10NB16+8xi/dGecWi9Dj1NaiCSuQFlGcEPb7GoYzD62S/E4Evdhn7qU=
X-Gm-Gg: ASbGnctXF3l+ivtTBl0MzRBRywdM55Gq3T/Y5lhtvPPT7t0UKxhxylQpcuTOhZlfk0e
	iY7TwDUWo7Z4eho/U37HDaq6Mnv0LE047AjN1AQd5zhSoIHrWUN/DzF0BHthL8W/e7Tn4sOYIf8
	OZ4npuKZJj6uVQU9QSDg9tH5hzlf+Kx29YfgEycIcODgsioz9u5Yf1CfRxgrULfQt5j87SjGHE1
	LEpyuhnw69iUxfQYHE2RX9BwCR1qOObbZcXsO69LUWNwVnkzOpXsHkqPd3cbENAVFstqYfNvzzy
	GiB7irIVa56zXoxK76uQ3x4cNHOYJkQyqaB8UrKZ6Q/bxzCodtjY0Oi+5aN7ty5pIN1s0M3x
X-Received: by 2002:a17:903:2442:b0:225:abd2:5e4b with SMTP id d9443c01a7336-245e0491239mr19189155ad.16.1755594650998;
        Tue, 19 Aug 2025 02:10:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGcIlqBWyX5Tv1soCJZ6KctFg2AezqPzi/p+uzBDvpy7KJX24LI0Ju+K0knNxrEaJDXB3Sarg==
X-Received: by 2002:a17:903:2442:b0:225:abd2:5e4b with SMTP id d9443c01a7336-245e0491239mr19188855ad.16.1755594650142;
        Tue, 19 Aug 2025 02:10:50 -0700 (PDT)
Received: from [10.217.216.215] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2446cb065a6sm103629125ad.52.2025.08.19.02.10.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Aug 2025 02:10:49 -0700 (PDT)
Message-ID: <be066c47-5d94-4182-b8f2-5c353e078227@oss.qualcomm.com>
Date: Tue, 19 Aug 2025 14:40:44 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] arm64: dts: qcom: sa8775p: Add clocks for QoS
 configuration
To: Georgi Djakov <djakov@kernel.org>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Rob Herring
 <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: Raviteja Laggyshetty <quic_rlaggysh@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mike Tipton <mike.tipton@oss.qualcomm.com>
References: <20250808140300.14784-1-odelu.kukatla@oss.qualcomm.com>
 <20250808140300.14784-4-odelu.kukatla@oss.qualcomm.com>
 <857f56a9-0fe7-4c10-a55d-b00740a8be02@oss.qualcomm.com>
 <7c96f881-23ae-484c-82b8-d388a5c637ca@oss.qualcomm.com>
 <04e09739-2462-4a4d-8378-6c6514dca752@kernel.org>
Content-Language: en-US
From: Odelu Kukatla <odelu.kukatla@oss.qualcomm.com>
In-Reply-To: <04e09739-2462-4a4d-8378-6c6514dca752@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=D9xHKuRj c=1 sm=1 tr=0 ts=68a43f9c cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=Oyi9YktmGe5suzeJu0oA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-ORIG-GUID: qJ0LcSM4n7sT9h8DSKi4R7txFTWCXLHJ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE2MDAyNCBTYWx0ZWRfX9XkZLIlXWBQ3
 yylC8y2NYD3KHMcf5nJADk33W+Kr70FbPFpbYw+9jnCVaeE1fiROWqIZgvoWfEQAouZYPrHOKlP
 2ZVbAeeXGgP6nrzJWvC/vtnJkQAgUWuaBwEYvLULYWXQbAzo+qbvXS+JwCsHl6P2URYUTHG5VTt
 euascyskOd7ME8tka8GflNrbYQbaMST4R3bVqabanjwi8qEX993v7D5rLmS4jr+LuIZ/bGcy3uA
 UbtphUt9qJM6cC27hW0jCgqVx10bgtOefu1C1PCLwybmLwFa401953hir9Jfl5sLIOXz9xnxsaE
 EW0bMdEit6F0Mbsgu76wJHnT7Nmc4fGS1ASvtZXjyI8YsJ5fm8dg2RagoLX407FhcRJsznadOp1
 xAaYh3ip
X-Proofpoint-GUID: qJ0LcSM4n7sT9h8DSKi4R7txFTWCXLHJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-19_01,2025-08-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 phishscore=0 impostorscore=0 bulkscore=0
 priorityscore=1501 spamscore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508160024



On 8/15/2025 6:41 PM, Georgi Djakov wrote:
> On 8/13/25 8:45 AM, Odelu Kukatla wrote:
>>
>>
>> On 8/12/2025 3:21 PM, Konrad Dybcio wrote:
>>> On 8/8/25 4:03 PM, Odelu Kukatla wrote:
>>>> Add register addresses and clocks which need to be enabled for
>>>> configuring QoS on sa8775p SoC.
>>>>
>>>> Signed-off-by: Odelu Kukatla <odelu.kukatla@oss.qualcomm.com>
>>>> ---
>>>
>>> [...]
>>>
>>>> +        system_noc: interconnect@01680000 {
>>>
>>> stray leading zero
>>>
>> Thanks for the review, i will address this in next revision.> I also
>> see there's a camera noc.. are these controlled internally
>>> by Titan nowadays?
>>>
>> Yes, camera NoC is controlled internally.
> By internally, do you mean that it's controlled by some camera driver?
> Why the camnoc is not using the interconnect framework?
> 
Camnoc is internal to Camera subsystem and is controlled by Camera FW, i
think it is not by camera driver in kernel. > Thanks,
> Georgi


