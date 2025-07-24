Return-Path: <linux-kernel+bounces-744271-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 275BDB10A5E
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 14:38:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F3AC584B0B
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 12:38:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3686B2D4B5F;
	Thu, 24 Jul 2025 12:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="OT7nSb+t"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D01F2D29B1
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 12:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753360621; cv=none; b=DsmR3lDerR2dUOVfENaJTaHU3F8fas3rOYNdE7Rwy1B+S22DorpAeGQJ0gWKv6X4JrLZoiml0Steq281CYaK7e6G5CByNE0zRrWf0TvTAkdEklLox24QSKmZoKnUjYd8PlMBuWHJV8mfggg9Z6aOx6bNFtj+RHhgrv/dAPo4jhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753360621; c=relaxed/simple;
	bh=LcSIW0NY6oVfU7XhBiAcCwSmXdrPSxDV38BCQfAwyXg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AbNaRauYj3ig0M/45FMOAzmehB9WZmofIM8MJ4Tt26OjZRkTrPEiVIYWkFnG+O+t6aGqIPH8P6SPCeBf5iP5k5UtqaR7kw7c4NBaiTNExPNosGodz7kJoCD4ttQdAnwREe0uFI5/qn1LiJ6gm8+QC2bQhvMcRD+L5HfqJ/SOWlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=OT7nSb+t; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56O9afC2029601
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 12:36:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	dSR4gbUU/2tBPcpsP9lRCwcwfrmXksikVD3aXPQ1sts=; b=OT7nSb+tMmsWHalP
	bvt32Eq5DE67wqxcWNQ7RmlVdqStcAEJFIjE2DJFh+TcX4H4wuzmlNY8+wFQMBHu
	fHjjjd63XJZ9fnZtWr/Yb4tOKntSmW2GmhE2Xrmklb6qU25PTFD9RqJfMw7B4Lvy
	GORgShFwNatTr4X70ZqzDU/YpFjkRrBMYxfitQzC/Efda7iKJYgCkBZeWk/MzVyS
	dpwB4WatGXFuqgXc/srS110j5GcI4rjehJG8KyVFJvDRACxL8dGkbf5YCWn/Qo9j
	J6W9buqT+4WaYjBTTXEaLeq4HS6zIixg6DrYqJzVqSTk/fHNTFFmzeA6ewEG/QGK
	CY/Icg==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4826t1g1rr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 12:36:58 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-7e33e133f42so28468485a.3
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 05:36:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753360618; x=1753965418;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dSR4gbUU/2tBPcpsP9lRCwcwfrmXksikVD3aXPQ1sts=;
        b=OQvwENwsKl+fOccSQAuA1kf5AYsR5WFO/Amh7e2OvRZA+rjvQJNw0zl4NETr1I3jW3
         TJjIDyrgCkijhruR99aeMD5urvVLfv1hlV+Fgtme7PM1qWXkM5rf4thyQQE4OkNMsjgI
         Ul3BTQD7on86Co5kh8YpOB05ZZvj/hkwsj7jxpQX8z9cGJG+JU5y3+f4kDP6nKNS5iww
         1tuKoRor0xjrZIKxmMGCjrBn9nPrf/xgK1agPuRRVhz9afzGY9I8QbY4MOkVYlnj+Yu/
         fi95ySISfsqFntlbhuSPGXAbhjgy0JFf1ssB2a9qChEvJwPc5bDzx3Z7GkMmD6yqjkf2
         Md3Q==
X-Forwarded-Encrypted: i=1; AJvYcCXbP8NW6V9mZujcG8DqP0DuDRIkUtlOeS/DU8WcOm/S7Vn4OyKc/kGH1itBfkvdVfF4hnQaJ5oy8gxK4Rs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyb1W+2ZrBf46fgd65FnLS+B/2jbvWnNhq338x0SI4Ml86pysXq
	54Q1Tow51xlQNf5Qt3Co15DPUtgkSip5OyE7ZScaorRg+ZnT+8KJOYXOaU41a0PC+2ArOu0qTsW
	cbNu2UHNH5xvZDrAlIb6njFK7vLGamB/skHrNeZDy3FMLFzdc8Crz9Hol/8Q03G0gt74=
X-Gm-Gg: ASbGncvEzYX0ZnddGcMJ8NIyVrAuLqxS0IOQKEtm0Qg38spxB2BhXameTeiwdft5hnl
	utpR2lYjmrqIPvfLairA513KEeeqKayK84UqbG7ut9iUtGCEbfb6L4IWlEe31t/GN0ZQh+icQdL
	GNf+80hmK7s84B6tndCTdAxR2e0eEXh7K4OR0K7Js2yLLTgWSLAG81nmRMtjMUpTPvm1nkc/3o5
	wGISSt5VCeIImoxBiJ3Pd4r4IN5EKqCkDdMIKQj1HTVAiSINEwnav2q6RMFGrRYXkjyWI3CAX3c
	VWephWTQoIcQSVuFx0KWCZbWFWK16V2sujQmr2mexmQ+e+qq55d2TRDEgsd/Uak+9QgDKbkiutW
	4yORuX+vIbiULjMqcIw==
X-Received: by 2002:a05:620a:d88:b0:7e2:ee89:205a with SMTP id af79cd13be357-7e62a0e4ff5mr305362185a.5.1753360618062;
        Thu, 24 Jul 2025 05:36:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFtobSdcxMw45bMRgVyfiSZ4iD7n9YDnCcddnf4qk7/DbB2ZWWg10WQWjbeX0X1bWYDwrezTw==
X-Received: by 2002:a05:620a:d88:b0:7e2:ee89:205a with SMTP id af79cd13be357-7e62a0e4ff5mr305359385a.5.1753360617552;
        Thu, 24 Jul 2025 05:36:57 -0700 (PDT)
Received: from [192.168.43.16] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af47c496eefsm108992066b.25.2025.07.24.05.36.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Jul 2025 05:36:53 -0700 (PDT)
Message-ID: <9884efc6-c6c5-49f1-b582-55bba8397521@oss.qualcomm.com>
Date: Thu, 24 Jul 2025 14:36:49 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] Add initial interconnect (icc_path) Rust abstractions
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
 <CANiq72kxcEywL4L6HEqn7AZa-jOBsw08jr+Kvjdwrd+iTOO_uQ@mail.gmail.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <CANiq72kxcEywL4L6HEqn7AZa-jOBsw08jr+Kvjdwrd+iTOO_uQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: hBeYzsSxlg9iRpzW4xCd5ecjmw7ZDhq_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI0MDA5NSBTYWx0ZWRfXwp7DXHXEtNO0
 ytMRfmuuC+/5ZZcaG6c384X3pdUVU8ppnaLWMJ7IZTqm4onEuift/ye3sbMEpIxvOV86ROAAvuj
 VRgaTg84mssCpVfV3HUcC3PjfSMYVdyxEGWuxgdtI9pRPIU4WLPCaeUQRk3hfo2d5mganA1BLNW
 bGmCcPeJhxl7tKBDjFlLI1hNtHZXGW/G+p+X8ETSCMberNsz+Y62KHrAvLsYXxT94gITjaQOJSZ
 Uq4ioh5JYx3xghesgMSWiW1UCeM9lR7Pd5QjvbN6fgwNOA//q1kMI5Wh0buTr6uxu7dcADu2l3L
 g4+gaS+dXKyNBT1FqVL/5VOc/3xj0Tz1bzSZ7SAaVNpeeKEx1kJ5LMpNDA3c9gZFkFDi47wuWqE
 QW3U1wTPZl0ojm/xDM7k3QiXOq20Nr60Pn+9vsiDEiorqCgRyaiwyCzwoy5IJlsKj4/LqPRa
X-Authority-Analysis: v=2.4 cv=E8/Npbdl c=1 sm=1 tr=0 ts=688228ea cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=VwQbUJbxAAAA:8 a=1ihfflFO6Zl3b22XxKoA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-ORIG-GUID: hBeYzsSxlg9iRpzW4xCd5ecjmw7ZDhq_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-24_02,2025-07-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 spamscore=0 bulkscore=0 lowpriorityscore=0
 priorityscore=1501 adultscore=0 suspectscore=0 clxscore=1015 phishscore=0
 mlxlogscore=927 mlxscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507240095

On 7/23/25 12:22 PM, Miguel Ojeda wrote:
> On Tue, Jul 22, 2025 at 11:14 PM Konrad Dybcio <konradybcio@kernel.org> wrote:
>>
>> icc_path is in essence very similar to `struct clk`, so the newly
>> propsed bindings are understandably based on the corresponding
>> common_clk module.
>> This is the interconnect consumer part, with the corresponding ICC
>> provider changes coming in some near future.
>>
>> I attached a sample driver making use of these, to ease any testing
>> or CI work (as the title says, please don't merge it though).
> 
> Thanks!
> 
> The usual two main questions for new abstractions are whether the
> maintainers of the C side want to see this happen (and how will it be
> maintained etc.) and what users of the abstractions are expected
> upstream.

I haven't talked to Georgi about this. I can volunteer for
code-janitoring, but as you can tell I'll still need your oversight

Regarding the users, I don't have any specific promises on a consumer
of these abstractions in a short term, although the ICC API is rather
common (especially across the major arm-based SoCs), so it shouldn't be
long before someone needs it.

Konrad

> 
> For the first part, some subsystems prefer to maintain it themselves,
> others prefer to have someone else lead a separate sub-entry in
> `MAINTAINERS` (e.g. "... [RUST]"), possibly with its own branch too.
> 
> Cheers,
> Miguel

