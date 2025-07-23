Return-Path: <linux-kernel+bounces-742400-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D44DEB0F13D
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 13:32:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F03454606A
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 11:32:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C1FB212D83;
	Wed, 23 Jul 2025 11:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="BpYID8r8"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9FE02DA743
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 11:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753270368; cv=none; b=exlwH0Ht8LnQXIlCeZuV2U/ccfJATwKBaz4j9JA+VhakCN0poNHw5JF+Ezt8RYtPBVI6gbz96F8bvmJY592JX58gbt0dUaLVdU6w+pWZMB0FLvQSBdgN2/JCuQxnEsJyBQYrr9pXy/Fgm8YAYD6RyzysrJordXhBuBTl6CL3U9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753270368; c=relaxed/simple;
	bh=9rj1cVhx4thgC/2OWJ4kbD+Kw0LtrOjEdbA4NWu6Chg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=St0hCc4RPJiJX0780zLWyJZ7ri7YWO9dGZzq7N/OYjoQb9Dzfr7zllIf8m35MWHl/f+gJ5q4hzl2mCqD5IWdwvztIk77qTeSS7GS+js5LrXwy+IhBL73uGKiPn3guXBXxB/+kN8u3ZIJK4Xg3XtyH20IlDNYIMiRLc5L8r2WZQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=BpYID8r8; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56N9pHRv019472
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 11:32:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	gEq8YYhXL7FoLLBpSRO5bvtuwnmRSOR3fjHvCA+iHcM=; b=BpYID8r85zvNYYr8
	CnQdseHOG2/afwfYo9JkfUfV9U4SUMSGXRDBF5k9gdR+yg9SdSMuglXPr16l6Vb2
	mcJQUtUvQAqCA4OHOhq694bkKimwBMh1sAfKpvG89CH7x4OPlvIKm95E1nenZmiW
	k0rLAZEzbCnBqCUSK3PFLTnTA3Uh2yGurttAbvn1zKt82FDer4tPUjPktaNKm6Xj
	vs4bh0clF+Qi5hB58ggXfwbFykkW8ZAM/9VSD/VYeG29Wc5EABXIxzBCTroTvuOm
	CzEUitSBoLJO6cbM4bMEcxNGCoQ4w+48T3QQOQ/NKM70inypUCJpQTO9fveh84N6
	gpXDKg==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 481qh6q5d7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 11:32:45 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4ab3ab7f74bso22554641cf.2
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 04:32:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753270344; x=1753875144;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gEq8YYhXL7FoLLBpSRO5bvtuwnmRSOR3fjHvCA+iHcM=;
        b=UZPXoa2enN+3vbXVEfY6+ANEfXtGEP2avRpbVe4eVZKk2PVmb6OxTxvXh74vmaoTot
         phCIXPyY4rQZpU1EZLTGeObeJtrowEizV8pBFKxMJzJY/K0s1jKxpGey6axkRq43jFRM
         y/E3A96N4zcyWlayyLeC483a7a3Oa50PW8Af6oG/nYs7MZ0cCCze8vjTScUB4iiQ7VzP
         n8TRu53nwf7/yjrSoIEDwY1UDB50T/FOna4/dg/j3CvXWu0syFbzohzJtnf01p/bHrth
         Vrm7EbvHjPqlY8UhACv/4KJrWo3o8B6+cAUFaBRrbDQUirXdgMGff8pfuGNb3p2PTYSf
         0EhQ==
X-Forwarded-Encrypted: i=1; AJvYcCV4Edhpum6bTnfYjWtfzdAtWX6i64H6azDYOT3PVprpThi0SuEJzrCoX0BujQrHyASIrBkpnr+R44E4wOM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzpu5fQM6y4qxIZ4tHdKeUW0DmMyzL5jtl87dHAPJsUOjaoj9Dd
	KX+lxx46beu6cV9vKVt179UprjoJ3/RuZWIN3hIc6R1/2gOnP+u8cONhX6CxyXS8dyFWtWqiN6Y
	wZU8WryPcY4iLigH51r9+LZS/vmXjqaBL9zUm7H8Zz9SLNdNxAYchLFWmwfWoArGpCAY=
X-Gm-Gg: ASbGncsMVE5iRFB2taBkeR/fz4wLGVHFdOC8Yn0uyDS3urUg5n74mFByZpZob3hwGbO
	3ppohya+IpLuGt9RZrnqAxdSE2rCdSPan5FhPPTHckXHRcu/VDoh0azmtrj8rKu6lwB3Jjl6GXX
	ZZygiZDjsN7ztsP/hKHO5z5mjQkPwKE4QrRsf8wQNPAIyY+7ttgePORZM5MFfkA7XdES8bEqz/n
	E+aXeGbc+NdubIiyn7/pZ5B3C0G+1Nl8JzFMi8ePgD2VEaNNnSd0tymv7c1wuDrLY+bFoaBjLwH
	FsRkS+UvaujLXveQB/xO6wY+gyXd9SXHWPs2gIy1Jk7hPsBPXVdFzR5tp1FHLsutDR8XSEMCTBf
	P2zcX3zrdXsx21+XKlA==
X-Received: by 2002:a05:622a:1485:b0:4ab:5d26:db92 with SMTP id d75a77b69052e-4ae6df26e46mr14600021cf.10.1753270343606;
        Wed, 23 Jul 2025 04:32:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF8bELZd2/Tj5DlsN6hPJW9HVlRJ0K7QJZgVKD+12MwYax4hBvWftddN6G7Ot0hdS4s12N1Tw==
X-Received: by 2002:a05:622a:1485:b0:4ab:5d26:db92 with SMTP id d75a77b69052e-4ae6df26e46mr14599761cf.10.1753270343048;
        Wed, 23 Jul 2025 04:32:23 -0700 (PDT)
Received: from [192.168.43.16] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-612c907a5b1sm8427012a12.53.2025.07.23.04.32.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Jul 2025 04:32:22 -0700 (PDT)
Message-ID: <d80ebfbb-5fb5-4dde-a79b-adb22231a63e@oss.qualcomm.com>
Date: Wed, 23 Jul 2025 13:32:19 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] rust: Add initial interconnect framework abstractions
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Benno Lossin <lossin@kernel.org>,
        Andreas Hindborg <a.hindborg@kernel.org>,
        Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
        Danilo Krummrich <dakr@kernel.org>, Georgi Djakov <djakov@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
        linux-pm@vger.kernel.org
References: <20250722-topic-icc_rs-v1-0-9da731c14603@oss.qualcomm.com>
 <20250722-topic-icc_rs-v1-1-9da731c14603@oss.qualcomm.com>
 <CANiq72nPLn+3V_DhN9_dmKnRrb5mfjzQ67Utz7HdtOY3McpweA@mail.gmail.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <CANiq72nPLn+3V_DhN9_dmKnRrb5mfjzQ67Utz7HdtOY3McpweA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=CZ4I5Krl c=1 sm=1 tr=0 ts=6880c85d cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=PfD2oos9AAAA:8 a=n7DJBcn5hHOibpQQY_QA:9
 a=QEXdDO2ut3YA:10 a=kacYvNCVWA4VmyqE58fU:22 a=oXWlT9oWAVMySZ1Hvsws:22
X-Proofpoint-ORIG-GUID: lOgrmLzC8ZzeFt4pyy_ZCu52i3THkEvg
X-Proofpoint-GUID: lOgrmLzC8ZzeFt4pyy_ZCu52i3THkEvg
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIzMDA5OCBTYWx0ZWRfX3FtSMw394Ka6
 4G3QE+26xeb4hgOKph6vafpToB6PgxD2rsDAuNtvnytVCejZflKYe/RlEMfEC/wf7MiSfBVbaVz
 tPCYyzPgRucYJkhHpEr5haGju1WrWsvYMDiLEywdrKNTFIe6/ZvNO1pANvjTsitgb3bvx2IkL0u
 JqaRULLBtBMmruDOUtcl/w1ZDMaL5HJPDA+WjbhBSICZr1LI9M71XWM5deDslz4njoregb2bC2K
 BEj+MaoSx2ZoCUc2McFHIgeh5uyqFWZBq+sZQ5sOlj6YYMPNR8WmErh8h9x9p5strdGRmqwKuIe
 6f5UcC1gpBA0aHODlATrdl3PjAyw42guuZZ2Y5n7ymbVLun3uFjRRi3xAbXDgvOlElcsXGpj3KL
 ctL4m/zFtgABxl+7SadeunBX0/9Dw/FoCVHfDBCQ3yPAxG+J1npGmW51+wQZH9CJW8RFPcrb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-23_02,2025-07-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 mlxlogscore=999 impostorscore=0
 clxscore=1015 mlxscore=0 lowpriorityscore=0 phishscore=0 adultscore=0
 bulkscore=0 spamscore=0 malwarescore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507230098

On 7/23/25 12:42 PM, Miguel Ojeda wrote:
> Hi Konrad,
> 
> Some quick mostly doc-related comments...

[...]

>> +    /// Create a new instance from gigabytes (GB) per second
>> +    pub const fn from_gigabytes_per_sec(gbps: u32) -> Self {
>> +        Self(gbps * 1000 * 1000)
>> +    }
> 
> I guess this means callers must call this with reasonable numbers and
> otherwise it is considered a bug, right? i.e. this could overflow, and
> thus panic under `CONFIG_RUST_OVERFLOW_CHECKS=y`.

The C framework makes no effort to check for that, so panicking is at
least something.. That said, what would you suggest to do here?

[...]

>> +#[cfg(CONFIG_INTERCONNECT)]
>> +mod icc_path {
> 
> Maybe a different file?

I was debating that. icc_path represents the interconnect consumer part
(i.e. used in device drivers that just need to toggle a bus endpoint),
whereas the corresponding provider part (which manages said bus) is not
yet abstracted.

It would make logical sense to split these two.. with the latter going
to icc_provider.rs, perhaps?

[...]

>> +// SAFETY: An `IccPath` is always reference-counted and can be released from any thread.
>> +unsafe impl Send for IccPath {}
> 
> This gives an error, right? Was it meant to be inside the other Rust module?

No, it compiles fine here.. Strangely, I didn't get any warnings or 
errors with this patch. Maybe because the struct is pub and within the
same file?

Should I move it into the module scope for sanity?

> 
> Also, please also run `make .... rustfmt`.
> 
> Finally, the examples in the docs are converted automatically into
> KUnit tests (under `CONFIG_RUST_KERNEL_DOCTESTS=y`) -- the examples
> currently have build errors.

I was missing this config, yeah..

> 
> We have some extra notes at:
> 
>     https://rust-for-linux.com/contributing#submit-checklist-addendum
> 
> on things that are useful to test/check.

I almost wanna say `make rustfmt` produced slightly different results
(one or two lines of difference) than make rust-analyzer + vscode
extension.. hmm.. Perhaps PEBKAC..

Konrad

