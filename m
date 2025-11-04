Return-Path: <linux-kernel+bounces-884728-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AB2DFC30EF0
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 13:16:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 14776189FBDF
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 12:14:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDF572C21D4;
	Tue,  4 Nov 2025 12:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="O0lTtuMK";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="DfCcmA4j"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7511F2EDD60
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 12:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762258438; cv=none; b=I9W/18hBRtU3zKrllJC8aZXDiq9RZ4/zZOAARXFis6iNQ8/KhhnToANB03jE/I0FTQ/C5G0gEiw9ckImOTVZycR/hWorPmU9BbuBxzLwJFGN7oHvudJbKc0jqSUyJDMx02gjVJ+ZGQ8PLSbG6sihRx7gz8HcilDp9zKJAverpec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762258438; c=relaxed/simple;
	bh=JE7DOtpr7ITJlPf8byrRLaTgyDpLMDlPpNKa7BnbAaU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=foqE4kz/H34hc1PyWECa61Ikynujl5EsqzmC3WV/TB6nCazMS8TTizEVmNtSr9+F4nqgDu45AUXea0pa7rQvkMtQ8FnNMXsSVWgnm97Ci+Ovgcka5ef83LyTUDigmDz/5/n6VzgWFVNtsBdAOkBIiCQXTPOAYvKIqnHVfiqVha4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=O0lTtuMK; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=DfCcmA4j; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A48gb6P1458855
	for <linux-kernel@vger.kernel.org>; Tue, 4 Nov 2025 12:13:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	C6bQ2/OXa3s0d++jskzDVbMIDhfmlWkdwhbo6GHDRt8=; b=O0lTtuMKRaVw+kkt
	IGYhvZAE1FirDAzLs7//Pi0pqIbYcm607gnhP6aauo5gQ701w6uEoKOi02wKKYBS
	TcK+sXoEXIaGX7/oV+D4fQE0Y1+clJB7w6yl6daU6srsRIOl8Zo84u3yvDlu5Vst
	kjfoTPK0z+SA+/ZQ/scad8c8gV7KR+HGjPRpg3JIXvpyjU4AwVWuH78COMahXmGr
	9pU0AEFAIyo7fEcW7DSi0vItwRIoSbFJYxh4TKlFNJo2Q1pqrv4wrlPjk/s/cUNN
	pyfXln6+AvYKXh16jn+lg0GN/nz/JksyUmloh6+HK7p2sTFhlwWwphU0/WxK5XFJ
	kbviIg==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a70geatpx-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 04 Nov 2025 12:13:56 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-8a79a3e23d5so105625085a.1
        for <linux-kernel@vger.kernel.org>; Tue, 04 Nov 2025 04:13:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762258435; x=1762863235; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=C6bQ2/OXa3s0d++jskzDVbMIDhfmlWkdwhbo6GHDRt8=;
        b=DfCcmA4jOkedeb+E3tQxWviMt5R0LsEYTRwhaoE9TpVM0Ti0YZWJOIRwjvUWR9obh2
         wVptF5sfwTyyxu8Zf+yg9xpGxfVDjIeSpMJS3xAI906wG0bqaDP6rNlgcm3zCZIZoqcp
         lK8mhkku9YQ8S8xiXCSCspWC/4+CXK7eZuUo0jdM4/tdmtf0fNp7r0U4fs6kkR1Yxyt1
         kUOa/gOOWmtu1nFK/r/3rxA0QGNGgI5q/zn8sKusH8527ci0EfOYq05P1InRKlu42Rjr
         b98+YS87PgZYiqa4+oj2EMlEGVQNJa2uJyPLfXkQD4GULpSvSHSDnqDsB7JfrB+3vxTv
         42Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762258435; x=1762863235;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=C6bQ2/OXa3s0d++jskzDVbMIDhfmlWkdwhbo6GHDRt8=;
        b=pPhSppUdd+MwgNJ05f8EVGUIGtQdIYiTnt670PKSRoUEp4x+Hs6aWgrQRLQN0+voJ3
         N6bttKSwsmsM04maj5pc2Ze0xx20CVrOlNqUMP48dc6J1/9sFNXx5GHP995R+txVWjh4
         c2LKIDIvS1GG4rwNWGqsbFZyoxVdGoHva6rjs3lCr9VndwqSiISBrky7bpZX7vw/A/1q
         3Bnj1uoOHEgJQE25fXa+iN8spr1RNSE3agQeE/ogZXeIdC/q/Uaoc59FYf/w2V83uTLG
         +nYTSBu9N+CIGKiRlsGp6UFTPD/1ccg/cqYLJ3cqGS14FowmCCS1vPTmUd+Qg1jEchQ1
         0JMw==
X-Forwarded-Encrypted: i=1; AJvYcCUAxBZfrfAxgVk73Mw0SfVGpoyq8jylbbJ/Z9cQiYwfxnTC6GYkOYFOLoCjRYdp7nOlyJY+vQYEpTLam40=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxa5zcTgePqps/SXO1XTbpUBtR6SqwFfN4/6nDL24jJ/fR/qVFi
	XO0xP6ssDxP+O44deJ+D2A9akTOo+vFGpMoaENZLq3JdyBxJFoHwYOsNoSRTFVk5ewY+ijsniPL
	+2anVt2KZYXFz4rXBDJ8NpO8pDncH+lQxBSCB4JzaeJbr3a5Rxgtp9IMd4DtYlScPKKv6kRHk/A
	U=
X-Gm-Gg: ASbGnctGrtUuilDQ+RALb377MZf4EWEvn0BzaGYNDqr66NACFN6EPQXZQAdw2LyCpUK
	8lp/8eNKqulumzdxACFIACJ520tbmkWycdLK7hCNXqxVcqEdMpoJm7QO7HWy9gE/QiUCO/P4umq
	vVtxcRSDCJ8kp+YwozYQ5s5g3cHa2UUVtMag92Sco5MnbYB7R4IlLn07FDGwBqql6pWA1i6nK2v
	OQvvXE89/nyi4TRdSrACpBBo3fRZ0yxOWXrqhDWN+4G9gAqj7Fmko1U/mXpLbJUNYTTbQu9hNq7
	/vHeiaHjSTRe+Cnw/ENRl8Zj+zRi9Y1Rso4GjVLKkPOdOg4HVx4XR4dwIiUFPGa985LmF3xPgMU
	hnFWltCqRZWJyWDKHoeTLIJq/Ny+O7FRYfpeZLBLeFTds4GixT3Njq/D1
X-Received: by 2002:a05:620a:4493:b0:89d:4a69:1502 with SMTP id af79cd13be357-8ab98ec0098mr1526322985a.3.1762258435426;
        Tue, 04 Nov 2025 04:13:55 -0800 (PST)
X-Google-Smtp-Source: AGHT+IElJoqWX2xrJV5ag5CnmreVfKvqZQk0wt43HdbcV3tEqeG9gBU7GfIBlEbi5qoANhqsgYZfbg==
X-Received: by 2002:a05:620a:4493:b0:89d:4a69:1502 with SMTP id af79cd13be357-8ab98ec0098mr1526317685a.3.1762258434614;
        Tue, 04 Nov 2025 04:13:54 -0800 (PST)
Received: from [192.168.119.202] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b723d3a336asm197311766b.7.2025.11.04.04.13.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Nov 2025 04:13:54 -0800 (PST)
Message-ID: <1bd7da17-ae41-4d86-9f80-960f68821ee4@oss.qualcomm.com>
Date: Tue, 4 Nov 2025 13:13:51 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] cpufreq: qcom-nvmem: add compatible fallback for
 ipq806x for no SMEM
To: Christian Marangi <ansuelsmth@gmail.com>,
        Bjorn Andersson <andersson@kernel.org>
Cc: Ilia Lin <ilia.lin@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Raag Jadav <raag.jadav@intel.com>, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20251031130835.7953-1-ansuelsmth@gmail.com>
 <20251031130835.7953-4-ansuelsmth@gmail.com>
 <qael7opoqary2n5iqefxxp42v3qoudfhfvcgjyxfe3t7353zge@ahgvniscxl7v>
 <6909eabc.050a0220.54944.cd03@mx.google.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <6909eabc.050a0220.54944.cd03@mx.google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: MaGIjw5cFL7e0CtDlAVVQE_D0btDxYds
X-Authority-Analysis: v=2.4 cv=bqBBxUai c=1 sm=1 tr=0 ts=6909ee04 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=pGLkceISAAAA:8 a=VwQbUJbxAAAA:8
 a=CWkO6e9Jn2YNH3FdQYoA:9 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA0MDEwMSBTYWx0ZWRfX9DfFNBl9b/o0
 OMOJmfgHb1e5uPvOlQhaHdyMgK1Ni980C5sLs24x0S/Dd5I3QUHlDpoflyWTpQbAR9su6ys4MoY
 v4C58KLrawX+Kkj02pLw92NsJCZTLshUKhuaU0P6NG9FZh2wlAFZl3GIjXtyg69GDE0UOzOpsLs
 Ml4UtmE7TW89cVm1zfDy59Rhagh7M22UcGML+IiTt0oxVtHk+sXICql8bybJIp5E8mU/P8uJ9eW
 U7mHdFJ+CX3c363oIqWHRie/BtJo8ecaoNwoGBk3My25HbJqJC4sDlk/SillS45hO311yrOVem9
 hKrwEGeKImVJf4Eh37cZ3ro2vUe/WhxeJr5kVLUEhCktMjDdj6JmZh3tRGuI078CSHwi5r3Mg7E
 HTPtzU5QshjxNZrgnlZrNTkAzDOynw==
X-Proofpoint-GUID: MaGIjw5cFL7e0CtDlAVVQE_D0btDxYds
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-04_01,2025-11-03_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 adultscore=0 bulkscore=0 malwarescore=0
 impostorscore=0 spamscore=0 priorityscore=1501 clxscore=1015
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2511040101

On 11/4/25 12:59 PM, Christian Marangi wrote:
> On Sat, Nov 01, 2025 at 12:42:55PM -0500, Bjorn Andersson wrote:
>> On Fri, Oct 31, 2025 at 02:08:34PM +0100, Christian Marangi wrote:
>>> On some IPQ806x SoC SMEM might be not initialized by SBL. This is the
>>> case for some Google devices (the OnHub family) that can't make use of
>>> SMEM to detect the SoC ID.
>>>
>>> To handle these specific case, check if the SMEM is not initialized (by
>>> checking if the qcom_smem_get_soc_id returns -ENODEV) and fallback to
>>> OF machine compatible checking to identify the SoC variant.
>>>
>>> Notice that the checking order is important as the machine compatible
>>> are normally defined with the specific one following the generic SoC
>>> (for example compatible = "qcom,ipq8065", "qcom,ipq8064").
>>>
>>> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
>>
>> Reviewed-by: Bjorn Andersson <andersson@kernel.org>
>>
>> And as mentioned in v1, this (cpufreq) patch can be merged independently
>> of the first two patches. So please merge it through the cpufreq tree.
>>
> 
> I will send a new revision just for this patch so I can use
> of_match_node()
> 
> Should be ok since it hasn't been picked right?

Yes, this is desired, even

Konrad

