Return-Path: <linux-kernel+bounces-747714-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D4BADB13722
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 11:01:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C56353B84D2
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 09:01:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 386D31F1505;
	Mon, 28 Jul 2025 09:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="i7HWWHsn"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4315C1A314E
	for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 09:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753693285; cv=none; b=Cg1N+gCJndNiH8x9imtbLPPAtl2aY7OWj4EA+IGOGDxhPw5g6+C5zRcSTEfJZgKFvwtJb0n3Bxc3nbyPsumZfoZNRQmQwUMP4W6ACxCRuQTNKoP08mvJBaFNjtq33pfgPy0+uQhZth10IoI4EDFYHfcz+BdJmYJhwUR1m4COx/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753693285; c=relaxed/simple;
	bh=DOpWV3j/ivSyz613vitYyQcD73ODySR5nCwI+BZUqD0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tJ6x1epWn3JJ3bQlDhj/cDWptvlD/k7KW4fJQbme0VC7cCmCVQw5b8nY3rj5g1Q4WjredQ4/y14aFTqRZpcjxBP1w1ktmbsX7dKJsxjkRflVBUbtlAQtD3Wy/MCt/O/sODSL8jBsQ9B1MNH0JvJ7IktjuX2EQI1xrEqNYpfn894=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=i7HWWHsn; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56S4rN2p013196
	for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 09:01:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	6vQAPLcTUVH4AQVLgM1wtAxa4apQYHMVU8A15RHKLZw=; b=i7HWWHsnufJlvS7a
	KKJ6m48OFWmcAm6GM8t/fuLp2jFAsaEvgYGpPtAGKRlr67QjXsOQNxu2OMxdXabh
	dDFiAtoyNWqlZWuptPviUELUJLe3tKF/L/BQDgrnaGN1bRPoMRqMZeWvQ0GjZNls
	dCrbb2pymKrXqDUG+1hy04c1M2KcJL0ObBxHJDCykhmsnd/Ud3UccrHa78RTF+ea
	8iCne8DrufMGCBNLcPsWd3mv3BVQolRtWT/zSIAQ2BDiSqfHOAW1g2ODo/70Q4oB
	UqNicSYI5Rr82mbTD7UumyPhtw9WCT5F89aLKdX6NrEEq5E+CY8Ixk+bmnOfuMmf
	LYmKzg==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 484q85uxy0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 09:01:23 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-7e48325048aso6044585a.3
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 02:01:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753693282; x=1754298082;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6vQAPLcTUVH4AQVLgM1wtAxa4apQYHMVU8A15RHKLZw=;
        b=ul1z6gwsTAdpG8D5iz/tj4vvgNFL+8I6kIZZu/3Veyvhql3YMCsNJFUgiNPd/b3dBi
         WN59BCPL9yWHqrki9LFV36Cjxw5l4stpPJVE0TNzHz4tjcPRq/7mP5oXYQeWL2xV9Z0F
         5e978TFzRC4IJpmTaav0r1ft6aluphL8xnfVREuQZgmwDqOqCGuDmlQFKDqtlAYOxnA9
         5OGDrxqHFE/kF5fTVvvl9pw5K2dXtYRwwXEzJZZxOIJk3f3An7IXR1NuZu6bMkBxEwT1
         lAM+CZPnhXgvEnxDQ8+EwimCDM1dW0BC7mulYfj9uC9uQbUmHIZQP4GIFyoG98WJhZjX
         a2Rw==
X-Forwarded-Encrypted: i=1; AJvYcCV2nH+4UlK3bRVsVu2oGT0bKvD3D7s4Ke+k1kUFZJ2MwboHsvNf0g2/QEh6MXKF+4Z9eTh3BsBoGGwuVBI=@vger.kernel.org
X-Gm-Message-State: AOJu0YypuF1T8Ogl+NEOE56rMZf2TeUbEIzAydY0/C7npfkZxtFl001M
	sBVWHUpskv+41Aq1LwMqxwGGf2jgvBy3vGTJrnSx+xrtUxUcAEE5K4RZ6CLh6rSu0Rgs4BitN55
	Bhbd9A8Hofja0vTNM1MrL71qZdChyo8pnRP7Vc/i3Yrfgxtte5eKPYxnR1WfK3Bu+tPQ=
X-Gm-Gg: ASbGncsmb86gHQeEMbFcCZh8+q7JDp9DTk8DF3MTxDmlmODbvtrSXpY+hO/qpmoHrfF
	yBB+sT5OxfZNr9EzZT8CK114+Oz1ArtDAhP+NUKtn5BoNTCcfw8RZ8K4E6Q4B5M3eFoVUR6oWy6
	xWPsc6NlLyjJe5L9AK5W5v1AFmRmEh705RUOvN9cE/9TfwS5HyuMhblDaPRJBZItFbn24jvHaQ4
	VBWktSZ4FLQUf87cgJkbRhm/FyGNoXhumRyNuvGRUa60gtVoNBTtmk2gZS2FoVJJMSZRy5QlABa
	dQenfpVe4UPbIrHIl/1oCFa8zc/5mojt2qlV/ry08Prxsw2a9VOmFspuviM4aihZbTj2SJz1Wxg
	/M3nNrWlZxae0VYeY6A==
X-Received: by 2002:a05:620a:2688:b0:7e3:4410:84a3 with SMTP id af79cd13be357-7e63bdbaccamr519234585a.0.1753693281894;
        Mon, 28 Jul 2025 02:01:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGW9Zwig52JJH5E0MTQnvyd1Ouf3JAunM2rIuU1Hsc/Nq6qa924x7/1jw2iWAx4hMANazUNcQ==
X-Received: by 2002:a05:620a:2688:b0:7e3:4410:84a3 with SMTP id af79cd13be357-7e63bdbaccamr519230685a.0.1753693281073;
        Mon, 28 Jul 2025 02:01:21 -0700 (PDT)
Received: from [192.168.43.16] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af6358a1aa1sm384888666b.36.2025.07.28.02.01.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Jul 2025 02:01:20 -0700 (PDT)
Message-ID: <ea796218-fa8b-42b1-b10e-87f2b6b92c06@oss.qualcomm.com>
Date: Mon, 28 Jul 2025 11:01:17 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: make ARCH=arm64 rustdoc fails on a x86 host with SCS enabled
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Benno Lossin <lossin@kernel.org>,
        Andreas Hindborg <a.hindborg@kernel.org>,
        Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
        Danilo Krummrich <dakr@kernel.org>, rust-for-linux@vger.kernel.org,
        lkml <linux-kernel@vger.kernel.org>
References: <36cdc798-524f-4910-8b77-d7b9fac08d77@oss.qualcomm.com>
 <CANiq72nvbKiWiMx6XwRyLUOWxZAEAQgTY9MdqtpjAG+kbk72Sg@mail.gmail.com>
 <CANiq72=d-X8WiDqBfVChaXUR0Opx+N6T__iiS8WHKdh3v9y+zg@mail.gmail.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <CANiq72=d-X8WiDqBfVChaXUR0Opx+N6T__iiS8WHKdh3v9y+zg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI4MDA2NCBTYWx0ZWRfX1HHyI4GmRM0o
 NVx4EqXD4BUaV6+paBEALjYV0/iiwg7gZ1cpWExRtemFhCpvbVpejaDeQPza/FMfvgitbgLEiFq
 UEd5G946nQ782xVe+U/7UfrBr4CNC9tLvC0qt8Bls4kmtIX/n6zBiLokLBypcjaXciLmoLVP2GR
 n/yh9jQKXuUZn2jrx4j8ZSsE6emoF1mEAtaCtapjGmqwkSDkyl20zJm9y2tzs3NDlPKC1WMKrh3
 fbcuCBC1zsT57RSCPGhw1OnjLXajF5HEpiqQoP5bYupuGtJpSfjiqNc3tzhQnLrS3v5XhEDeI9X
 UxRA/bXTOfoL2ubhcf9KW6VezSjXGgtnTdDJuVv9PtvYSIPSFConNEtJZ2Kd5Rj67tOmEkwwNlT
 JKbZImJNqc/Lv901KbWUCnmA5DyDXQty6JW1RfjqeAs4oReL2uPGEepdGTP4xwJzBBuvLguS
X-Authority-Analysis: v=2.4 cv=TqLmhCXh c=1 sm=1 tr=0 ts=68873c63 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=NEAV23lmAAAA:8 a=VwQbUJbxAAAA:8
 a=pGLkceISAAAA:8 a=ltSnH8gx0hiH1buuJPgA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-ORIG-GUID: -PabXOt002YGeRdiPqxeCMnR9VGeVR7d
X-Proofpoint-GUID: -PabXOt002YGeRdiPqxeCMnR9VGeVR7d
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-28_03,2025-07-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 phishscore=0 bulkscore=0 lowpriorityscore=0 suspectscore=0
 malwarescore=0 adultscore=0 spamscore=0 priorityscore=1501 clxscore=1015
 impostorscore=0 mlxlogscore=975 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507280064

On 7/27/25 11:25 AM, Miguel Ojeda wrote:
> On Tue, Jul 22, 2025 at 2:40 PM Miguel Ojeda
> <miguel.ojeda.sandonis@gmail.com> wrote:
>>
>> Thanks, I can reproduce it -- I will send a patch.
> 
> It turns out it is a Rust compiler (`rustdoc`) bug -- filled:
> 
>     https://github.com/rust-lang/rust/issues/144521
> 
> I also sent a fix upstream, with a test similar to the kernel case:
> 
>     https://github.com/rust-lang/rust/pull/144523
> 
> And this is the patch to workaround it in the kernel for the time being:
> 
>     https://lore.kernel.org/rust-for-linux/20250727092317.2930617-1-ojeda@kernel.org/

Thanks for taking care of this!

Konrad

