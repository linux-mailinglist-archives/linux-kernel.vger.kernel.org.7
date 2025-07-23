Return-Path: <linux-kernel+bounces-742411-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E164B0F158
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 13:37:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7EDC5562607
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 11:37:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39F652E5410;
	Wed, 23 Jul 2025 11:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="doXDgixg"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3759B2E4990
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 11:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753270576; cv=none; b=BHEjZUXvQ/07j9uctEYBjRuoSo3M3tHkZyQ0ykBxnHG+smpKwmcUnfBxyvxSsL1/yFmj0tJQv6NaJTgyVJlKo5CbI5VZwZfrJznPSVb79iM7KdtMUTLg62GmfboULMhefbYoQ6P2i55gW7Z91A0JHRRlzGMmAUQqJqwIHSUMutI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753270576; c=relaxed/simple;
	bh=c/WzVS3BxxqqUyDpRQdZZNUiCTCg42qpfZXwRgmlsHA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Yi8jVIQ08o7BaIaMuRdSl2lcUfSiw1BRtEah+p6129G/gebj9pZa0Fs7zIIk/5O/nKv6piurZJVDPu3jMmUTz4NX2pW8zk8gKLnxTSMUyR+U/VqY4SjxWqLzbpKdfQxvHnGu0npyM4Xc9/nsibLGnXzy1UFBe5cg8UP5yR4RZ3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=doXDgixg; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56N9YL3b005825
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 11:36:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	v/+LX2Br0HcxWpeQNFvo9+zMaxGCsu0EitMyNJknY4g=; b=doXDgixgydfbbcIb
	AnehZn7eJpS8ykciZy6ndwkejrN6cuy7JEeZ/7J7FBme+IeHK9MCqv1Lz+IRBACa
	wUg6d5XVnMWnAQTftDJX3QNEOxrKE85sOKVj7ZevWL0edJ4Y+OdMkmYMdhi8jiZo
	0/iyl0EIgkv878Ru/FuSSJ8H6L8jim1NxrFBQic23+0nBsxc/s8ZR00CKWOq2Rcv
	nO/YEqCI6PWCLajfasGag2nswW8nUWhjzWZ2ccZ4Nv/ymCPhesKEA2NkETkuz71d
	qaoTovJFxhKcFwvdSCDg1+FbIHKc0yxnYtBS72s1i2WiV9+PjrwaRXTF518JXroS
	gFWICw==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 481t6w64ba-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 11:36:14 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4abc1e8bd11so15682381cf.3
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 04:36:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753270572; x=1753875372;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=v/+LX2Br0HcxWpeQNFvo9+zMaxGCsu0EitMyNJknY4g=;
        b=gywJh+WfJxBlsFwOdnJD6Pl9No6/A1uFbgaU326ZIZjuaqm95ci31kpj0lLohK7tBy
         pt1K568UoRFwgcxmIQFXbnkHvIMgwgrIO5+CiEjhfLD/kzBf1iUnhEVa8PGnFFonwFKq
         ItBAuhSo1CEcAq975axQ8qUOaq3O9Inb02RQhBgZWcWpL86VUg0JIJh3lMtFMjmQi4pU
         o8ERM7VPBlmenX6s8VsPLgNyr2RyDMqopNvuHIx6CBSIlR8NLJQe6XF7HW2oxPq+Bm1V
         FFG+WgMGHPmpIrexZkkJhYojbnxTJl/X/BEm1a1OF37yWiylzz7fiC59OGwYMIH/G8lP
         zwZw==
X-Forwarded-Encrypted: i=1; AJvYcCWaR3mz3j2yQQMqo1fYKtj1975/JGsNnzu7DMtybMpg78uQfDZ3VCFKJBgOrOSXrGXxo3XCStW8Nf2jFtg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyN4qWhr7ZZ6N+/u9433bynYPZbn/gRm6UUdPq1uQSOrTDdYVAX
	8394y/bypvVZZy76+YbKQfPctqgbmMNXW0LqsaQmWuWORkXzaZaAZxa2Qkrp3k8FWarwnAb//AV
	dMWd03ovGSVgY0pHkfmZZVGm18lY8/DbzjSoRzGWQVQH+uMQtYHygjozODH+JYNNim4o=
X-Gm-Gg: ASbGnct7lrRZxgWpj4UJx8uWTGZ+YMwcTEw4exI3D5x3TRcVGg89/O+rJ0fwniXbTa6
	TR+zMaWS2YRaYo7FjOecISxRe2HFn332ZJMvtQB/B3h/UF8Oxq40sQ4YyDUsU5RKrlQHGRLbC1h
	e8bHKVskA852jPQwBQng9Vv9kRIiG9PeBz+zKyKWDKr4gs/o1W/YTPaITYyGxG4iQqQ41S6JuoE
	vHG4CNtknev9q7XE8LDtC0cILoW91gHvTahYaL1g040l7YQSXBPDSXtpuaO7Bc5RDa7Jev38Bvr
	qbUbI4b+GBkj83NxNOSOZqoV/sV+JkZFbCnEakaKWHe1tWWDLEu8tGou/O0a1hkr97OyBSxxnLY
	XkS4iCZY2fmpBAmU+pA==
X-Received: by 2002:a05:622a:1106:b0:4ab:723e:fba7 with SMTP id d75a77b69052e-4ae6de9dbb9mr15700631cf.7.1753270572550;
        Wed, 23 Jul 2025 04:36:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHR4S+bL9miquXomxV9VKxD2CcoJYbXVfZFmCyuX8EEm2w+oH90eAsBPG5+1QxHMv4uoZZRJw==
X-Received: by 2002:a05:622a:1106:b0:4ab:723e:fba7 with SMTP id d75a77b69052e-4ae6de9dbb9mr15700351cf.7.1753270572017;
        Wed, 23 Jul 2025 04:36:12 -0700 (PDT)
Received: from [192.168.43.16] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aec6c7d972esm1039437366b.66.2025.07.23.04.36.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Jul 2025 04:36:11 -0700 (PDT)
Message-ID: <4c9e4399-7337-43dd-9efc-c530d0989bbb@oss.qualcomm.com>
Date: Wed, 23 Jul 2025 13:36:08 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] rust: Add initial interconnect framework abstractions
To: Daniel Sedlak <daniel@sedlak.dev>, Konrad Dybcio
 <konradybcio@kernel.org>,
        Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>,
        Benno Lossin <lossin@kernel.org>,
        Andreas Hindborg <a.hindborg@kernel.org>,
        Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
        Danilo Krummrich <dakr@kernel.org>, Georgi Djakov <djakov@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>
Cc: Marijn Suijten <marijn.suijten@somainline.org>,
        linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
        linux-pm@vger.kernel.org
References: <20250722-topic-icc_rs-v1-0-9da731c14603@oss.qualcomm.com>
 <20250722-topic-icc_rs-v1-1-9da731c14603@oss.qualcomm.com>
 <d0891c62-6c9a-4036-bf63-f5070ebba084@sedlak.dev>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <d0891c62-6c9a-4036-bf63-f5070ebba084@sedlak.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=SPpCVPvH c=1 sm=1 tr=0 ts=6880c92e cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=omgFRP16qxrcmm5CSNgA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIzMDA5OCBTYWx0ZWRfXxQ7uOKRHktMI
 aecHMpEFHVwWKjjatnwTADamC8iCHu9FDWQGWJhWlBtX3YtEV7IPuC9i28uuxpHuteVEVoSVYwU
 LrXQsF3MdDqp/MJ9MHbQz59JBudoQmAVB9cxE5C4XU/L5CpnGx8FGEguxoUwMGFwjx94tpNL39u
 XnaJtmbkhZ3cBupIg2Pq6NqYmj6raWYjZmKKtDAno/fkm67iukLH+HMK6UruONkaOIUkBJCfg7a
 w0m+dtnJDq87mDMl52khRKST8TUmrDrlRt2x9Q1923YfL32YHp4cU+vEVdrVj/p4GB23iPiScu7
 D9HnJ8ZizMM0ewjjiLqetdbUIgWr90plxeQJ2TXQl54f3cVK78rjj8cF0GkOAspRdy8oZ3xCdBC
 hm4lwKdnqPfa652WINYdl9TLSxjZU4UyA7kPaQq8Dc5mXMwV6dCH/rf4XV5bhYvHwup1caW5
X-Proofpoint-ORIG-GUID: uKceE4zvjFp8tVwHt_BkJLU_MtD7PMWC
X-Proofpoint-GUID: uKceE4zvjFp8tVwHt_BkJLU_MtD7PMWC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-23_02,2025-07-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 suspectscore=0 adultscore=0 phishscore=0 malwarescore=0
 mlxscore=0 bulkscore=0 clxscore=1015 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 mlxlogscore=999 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507230098

On 7/23/25 12:44 PM, Daniel Sedlak wrote:
> Hi Konrad,

[...]

>> +    /// Create a new instance from bits (b) per second
>> +    pub const fn from_bits_per_sec(_bps: u32) -> Self {
>> +        Self(1)
>> +    }
> 
> This is a very shady API. If I were to call
> 
>     let bw = IccBwUnit::from_bits_per_sec(16);
> 
> I would expect.
> 
>     assert_eq!(bw.as_bytes_per_sec(), 2);
> 
> But it would fail (assuming that 8 bits = 1 byte), since IccBwUnit::from_bits_per_sec(), always assigns 1.

I followed the C api:

include/linux/interconnect.h
18:#define bps_to_icc(x)        (1)

But indeed, something like bw.div_ceil(8) makes more logical sense


>> diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
>> index 87bcaa1c6b8a6291e71905e8dde60d945b654b98..60f6ac6e79cce57a8538ea0ad48f34f51af91731 100644
>> --- a/rust/kernel/lib.rs
>> +++ b/rust/kernel/lib.rs
>> @@ -89,6 +89,7 @@
>>   pub mod fmt;
>>   pub mod fs;
>>   pub mod init;
>> +pub mod icc;
> 
> Nit: formatting/missing space?

No, it's actually fine.. git decided that context lines shall begin
with a space

Konrad

