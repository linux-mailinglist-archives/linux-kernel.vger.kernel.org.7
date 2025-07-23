Return-Path: <linux-kernel+bounces-742436-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 94528B0F1AA
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 13:54:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 790E93AABF0
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 11:53:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 724E3290BD5;
	Wed, 23 Jul 2025 11:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="XaMN/MU2"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 466232DEA68
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 11:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753271644; cv=none; b=AJhh4/jzOL9/4vTAhW8c8GI1E06qYmHH395SRZ+/C2f7x8lEmw/65+WHLkTnAkkLC415EIsjxqCLrb9vMC2O3OKN47HEqP8AevrLOY5xj00yui0OGrlbAfnKziBDgOPmJbnIF66X2RBT0dvmLXbNPKnyleSbKL1mEGyp5wx9pps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753271644; c=relaxed/simple;
	bh=rXySEoTU7KAtMiOjzXdxrSBeSA0gWffUUZ3JRxa5cik=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=flxf/lOy5JwDsPWRCCl1mP3gjI6V5gI/6GFlbAZS6rBm4dOFGGShhpC7LuhnAaadwNYd4YU2Fw4zf2pg9l9txqKhFZDlEvqyro9333/6F3l06RZPTeCeQLEYmPoyymMoPaGol2DrktwDClorSMGwABR9VFwbTY2kl06kIvccplY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=XaMN/MU2; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56N9XpES022571
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 11:54:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	1HOOC0bNmR+F/460DnWW5L8q0MQlsL1rN/kFiHrS7M4=; b=XaMN/MU2c9d3gc8P
	SNYJIrYv/YPjShDxUqam3XnyolOXfZHOH7KePwLOR5BalXr+3ybCdhXTkdZr/wfQ
	JkaNyLbbE0ovBMHF5X4PhnJBTnsN/e5FY1yzWBaRy+OPEPM5tkYQiEXFQIKTmSWp
	eG1BLTF4LEUVXYa0gyTEmkClJbxoG/SBYHfB4O+p1fuxw1giSRS22Bmxl2ACOPZh
	kbrJTO30zouVyRUEedp+JvfMgN6463O4QVG+oy4xYxzLq5G3V0ohwdAOFfRs9f2b
	Hv7v1iLgW3mMEjeQu+e8HVYyDk5ZFRtsD8RswnESP9Bu+2Pj0+hXLpUaSVOk+u0t
	ZrNPEQ==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 482b1ubja1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 11:54:02 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-6fabbaa1937so14085066d6.0
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 04:54:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753271641; x=1753876441;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1HOOC0bNmR+F/460DnWW5L8q0MQlsL1rN/kFiHrS7M4=;
        b=BznLs1tAlHeZLFFw6aG682+cGS/A10P3rVq/GQLr44HD8Fj2qV9Xo9Zlo1tFUOpvrz
         6B5oetHeLzWSgj3aaD5JghOy/ok20/651+aJS8JqG2SYG5dymwfqTHaJtrkvSUF+uKts
         UomTVrBO+XiokUYptkhiaU/NG5jkDVkhpcHfwjUplcCZaOuz9NiVAS5QfDlG7HI8nwKA
         cv0Ls6uSbwJa6pxu9cjskSqOvoUFl+4KybJLXmrLC8W+ugQsHsQ4ys8xy/zVSxd3aLVz
         vsLLaT0Q4n8+J5UZ9rhvNgK4NoVMC9Sx5d4IbnDDcMfe0hb2yr4UCX9XpLTHuSxzYvDA
         4ffA==
X-Forwarded-Encrypted: i=1; AJvYcCXglAwSOOIwQjC8YQMFxdC69D4/IRlL3bSp8Qz0unmJPOPMqrbcx6ur3TvbVw8VH1exYkoBmkO0VAT+Zf4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxu7eHa2apTEn6y2jINXW9bQFh0Ja7GYeg3TSppFyLSZ5YyEjoo
	Lu0VVhFbtrAEBb2l1iGahxlDm3ckt6+DE91GrwDfXLvbrmDqDwrHw6D9WS+JfcGI0XybqrfbUn+
	x+5DBioEB1vAskTBlDKoxzmhZK3NrQpPvsz/LYcoddT7J59v1w3tC/57Poz5IIhaVHc8=
X-Gm-Gg: ASbGncu6V7GB4YGZhHuCH1UzgG9x+UUIA2pdpOf+DFXhWpcSDdx75hQ2jDjlluBorU2
	QGkG5/8cmdDGijAqo5ETCMMERCr5zVJIlykbVWoltH6Mb/qofrOXA2VhsA8iKdQydnWyOv0jJFo
	aBR5aGha4st0YnTZdUD9f/++0/+QljKhjsczuTQpQzRvjCDJ4UFZv0Mi4K2J5Xup1SABao1YEtB
	TEjLEze3IPlcPX1MGaqRgwEX7x8P+4QtMI25eYzo6fLWhxE2MhuVC257NPlOiRJrSPQBej2th9a
	/9MTe2MDmsmjA6jUWh+OPp3Gz+YLQ3M9dXYh7PXRZU51EDR4Ye18E746zBpKw8XooHpOHXcVInM
	e8D5aoRTVBY0Jl/RBgQ==
X-Received: by 2002:ad4:574e:0:b0:6fa:be81:e18f with SMTP id 6a1803df08f44-70700247566mr16107256d6.0.1753271640979;
        Wed, 23 Jul 2025 04:54:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IErsIXK4HHXqWtzyFC/KxLwjfOu4VWCmFUGD5W3/VG0i9+BCNgG9KSeh+I3EPIKfADs2zQJlw==
X-Received: by 2002:ad4:574e:0:b0:6fa:be81:e18f with SMTP id 6a1803df08f44-70700247566mr16106956d6.0.1753271640335;
        Wed, 23 Jul 2025 04:54:00 -0700 (PDT)
Received: from [192.168.43.16] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aec6cad5a85sm1038648966b.152.2025.07.23.04.53.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Jul 2025 04:53:59 -0700 (PDT)
Message-ID: <aaf6dff3-30fc-44a9-b88f-da7347e0b7d4@oss.qualcomm.com>
Date: Wed, 23 Jul 2025 13:53:56 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] rust: Add initial interconnect framework abstractions
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Konrad Dybcio <konradybcio@kernel.org>, Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>,
        Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>,
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
 <d80ebfbb-5fb5-4dde-a79b-adb22231a63e@oss.qualcomm.com>
 <CANiq72m8QZCAC4ouwTCvOE26gmoTSZ5fgc9uTw0pxkcNnX+4CA@mail.gmail.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <CANiq72m8QZCAC4ouwTCvOE26gmoTSZ5fgc9uTw0pxkcNnX+4CA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=LdY86ifi c=1 sm=1 tr=0 ts=6880cd5a cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=3-_8KK4-WcFyCo7UW4AA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=OIgjcC2v60KrkQgK7BGD:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIzMDEwMSBTYWx0ZWRfXzxBY8/UJO6r2
 /5EYPT9JDiP1BafzCg1nXxyE9Fv1/F6SYrT60+V69OzEaNpxN8/SW6o3r+8n7nJ/kjZTHbUdaPk
 7QFrm2PU/o2wvAxvFXw4BD7wpQrsEAie8JWBFrxBwsvROXbucbSnNEzZ9/ASzg2gn6bxFKXC9Be
 vct69dPKJ3Q0H1YTSntBowbhElT6oCDJN9/tkgoT3mxNqO519fi2nRvSqyiXDo93xViLKbcPZLR
 tCiGrc6tIOPTj7AtSHvUL6l3ylRxMerl7eAhl7PdvIb5n3oy8A7MmQNh02QCGOxitooz9mZORI1
 Gr3cS015Lpqb/+qKM0/ACj2xyqaE6FXXvyNQX+wqk7dciQj8sZfSMElcEyCQQE5PGWSkLb6IM0z
 exZqk0telUiNHxDj1gS+UR1+uz3HPKH/DGDyMfn0GJcfo5971BRBVwVQNQF+j7TJQ2JFO0mr
X-Proofpoint-ORIG-GUID: _XwK8aZMCYiwkXqLrwZy3jfTTuJ6oNqC
X-Proofpoint-GUID: _XwK8aZMCYiwkXqLrwZy3jfTTuJ6oNqC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-23_02,2025-07-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 mlxscore=0 priorityscore=1501 adultscore=0 phishscore=0
 malwarescore=0 lowpriorityscore=0 mlxlogscore=999 bulkscore=0 spamscore=0
 suspectscore=0 clxscore=1015 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507230101

On 7/23/25 1:41 PM, Miguel Ojeda wrote:
> On Wed, Jul 23, 2025 at 1:32 PM Konrad Dybcio
> <konrad.dybcio@oss.qualcomm.com> wrote:
>>
>> The C framework makes no effort to check for that, so panicking is at
>> least something.. That said, what would you suggest to do here?
> 
> If you want to mimic the C side, then you will need to use one of the
> non-panicking operations, such as e.g. `wrapping_mul()`.
> 
> Otherwise, you could make it a fallible method, i.e. return `Result`.
> 
> Otherwise, I think the panic should be documented in the docs of the
> methods (because callers then really need to be careful).
> 
> Which option to takes depends a bit on the use case and what C
> maintainers consider best for a particular operation.
> 
> For instance, sometimes people have used `build_assert!` because they
> expect that the value is always known at compile-time (after
> optimizations).

build_assert sounds nice, but the value is often retrieved dynamically
(e.g. from the device tree itself). Result seems like the best option.
I'll also add a verse in the docs about the return variants.

> 
>> I was debating that. icc_path represents the interconnect consumer part
>> (i.e. used in device drivers that just need to toggle a bus endpoint),
>> whereas the corresponding provider part (which manages said bus) is not
>> yet abstracted.
>>
>> It would make logical sense to split these two.. with the latter going
>> to icc_provider.rs, perhaps?
> 
> Ah, so I just meant that you could have the `icc_path` as a `mod
> icc_path;`, and move it to its own file, rather than inline. Other
> reorganizations makes sense, but I was only suggesting that :)

So, IccBwUnit stays in icc.rs and icc_path -> icc_path.rs?

> 
>> No, it compiles fine here.. Strangely, I didn't get any warnings or
>> errors with this patch. Maybe because the struct is pub and within the
>> same file?
> 
> It likely happens if `CONFIG_INTERCONNECT` is not set, because then
> the entire module above is gone.

OK that makes sense!

> 
>> I almost wanna say `make rustfmt` produced slightly different results
>> (one or two lines of difference) than make rust-analyzer + vscode
>> extension.. hmm.. Perhaps PEBKAC..
> 
> In mainline we currently enforce that code is formatted with `make ...
> rustfmt` (there is `make ... rustfmtcheck` to check, too), so if some
> extension gives you different formatting, please double-check before
> submitting the code.

I assumed that since the extension name is the same as the make target,
they were meant to be ;)

Konrad

