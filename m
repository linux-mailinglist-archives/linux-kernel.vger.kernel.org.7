Return-Path: <linux-kernel+bounces-875567-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 23992C194C2
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 10:08:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 55FE518937FA
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 09:07:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEB151C5F1B;
	Wed, 29 Oct 2025 09:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="GiY0piTp";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="AYlvD/V8"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4CDB2F99B8
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 09:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761728818; cv=none; b=HUlCBd66hUnfI1COGF7EmPQoWf2vAOobc1DPmR4eihqVUx7hC9fBRlrKMz0bTe9M2xWZjsIiMtTeT7cEjipvQtV5TR3+5dAybWxL++r8NTNtTEeL8tO5A+rrm05dGfWpL+cUr3CzbUOHYh9gm6llPU5Ysh7evgJtHjR2Hs7DcD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761728818; c=relaxed/simple;
	bh=/aOcHy2cGKnKF0qFCj1+5HOdnIw5VqiLSzrAYeaYa2g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=V+0F+Smi4OzmLpiTKlt7lvx/IyE+xdBuBjKu7Z1/LSwkm9GhQkBzeFrrRiHcDZ+JCDBgBCouOKis9FKRF9CpLdfK/YXXfaH2oKpv3GWppBz917GEuaIpWL2G8CVO/3h2IEzUe4JbWm3NEV/5zgp5QRMNAdvo1eCh94UdPXiQARU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=GiY0piTp; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=AYlvD/V8; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59T4v0MX3664603
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 09:06:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Ej0L6LKhytRGlWJ7FZb9k2KB7kgXNOZxH5vlNiTRSCw=; b=GiY0piTpqDsnY58A
	/KxblI9qLdx5MjhzLMYbTxvASq1uH5/oOG5H4jAX7VFBl0UkD/GdyUwtg0NfDYmv
	0CQEm8hrfYCX762DYg/0WPbGDKZF+z2rvwIXQ5zZPmcWwyQOhWiJd5fFRaFHvAWG
	PGutwSt4OBQmFXipMiHsSaCtePW3dY3HD2QEeP9Lauijyw8HswD055767l71dJRF
	qG3tQesJISb8dSup3KHshn+OjGIc/WCx7oohXiXWhd6VvyCQa+l+363MufggwpXP
	J034m+SD6YbwxmZMPndCSHpXMy+gaJk7s6FbCbrQFEL6kGkEgIUotS946fYdayng
	CTX/WQ==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a34a3swu6-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 09:06:55 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-8a22b021830so119444885a.2
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 02:06:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1761728815; x=1762333615; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ej0L6LKhytRGlWJ7FZb9k2KB7kgXNOZxH5vlNiTRSCw=;
        b=AYlvD/V82FVLJQ9BToy16UnUg6E8Jdotf73V+ZH3eWKyOeySYz5dXpCq1AuVwAABW3
         NuY7ybEixiC/kbR5L10IhjJ/1CYOEMA/WKP4TwubmPCI8R5ztpRRAiBWIJgC6jt1iY2+
         tAu06UofjCAcVerJLZO5DdhA2Pvm8JKk12eyU9NwvGpusshQXDPQ8JAQakCyRd7JdTJJ
         Gk3ge8tN87F0bSjzTpSVc+UKukmykIuM4nPsHdLMwaDV6AFK55JoDizkgLV4jEFIXR/X
         lqmDJqEr5l2p24lN7A9itw58Q4nQtWc516/2BuulCK5yl4c9utBtzhtA8VN7mY1eMAVv
         bj7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761728815; x=1762333615;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ej0L6LKhytRGlWJ7FZb9k2KB7kgXNOZxH5vlNiTRSCw=;
        b=s2XB0zizcp/saXFwCPlC6skL9OMdDifHBE6H5GgxObB6vKwsPG30TQRIwAqunqAtsk
         dAaUEFSZvHlP8RcqWdkEkb+iN2In3qp50df2Rmkzfnq5s1hu5qLbjAArnflmpGVO3dkJ
         rhp5eIGjcOA+Cdb4Gn34jfz+jW+Tr8ZCmaOXfG+00ZnB6w74N6+8kQW8WZqrwhjqFA2C
         5X6UcikRjBNPKx5igzVk8tG1Aa4cFp4GsE+v8WOG+8KKmQa9euG2Vui00Z0Slz4wilTM
         NJAnGCO5deT/3lBNJMmYNJNx9ABjw+Fw+n9amjAvGevCFIwAoOo3e/XLDhranWvK8Mff
         Eb0Q==
X-Forwarded-Encrypted: i=1; AJvYcCWZa+fhm+DywicBW86e9Bm+GhCl5r9L+w/cNBYUe5aLp051eQBQpB0+9TiPbQVig2JO9vWJYz5x+yoQk2M=@vger.kernel.org
X-Gm-Message-State: AOJu0YwpZd6V28QowIUzYkPW0EJqX5Uj1FKab+UOH6JhC9CDnK2jfx1Q
	Ntt093/gAMB6VgZNuMvDVE3W6InK6cHCU0bZANBPt6I6KHYa7H+IlIUNkmvLwuiwjANylLi4oVm
	8l5bu8qPapZkPOr6Rk1qxkD/jhOgZYPpAbJEsrl6LbIzi155P4e5wVl9i3bK8ETT0iGPN9+VR2O
	w=
X-Gm-Gg: ASbGncvr55JrbOVrJ3Jv4flb1GsSd+nWDNgBcNJ00Gk+ktMUbpAhCw6DyJzhqa9oprN
	/lRJZQO3O/vqrwNNKTbuv8q3yitMU5iQ7DSY2T/8CtGs5+0x2nrqklUod4UOuDO/wNwWMpiaIaS
	pptMtAw9yWJbfnz5uND//z2rjwN7sep2whGAjwzy89ecZEoBEKSv3Bh49IUhvdgeRtX8bHfZ7QQ
	15RsipME5DR9/Q+A0Tb1LzCCfltkCAGRUhKR+9smVXcMN9hZBkyHcnw93GcutgmwdAz927YNNMH
	UCQm9y3volMlVTCq7NA4G8wtp7WUZxWErT0eHINtmqhmW/wW0wOzMny++bsBY18EIjsfkCO7dtU
	jxqU3zqPJWnOezeSeEWdEYgH847fl9nb2HCnWO8Ewl4Vg3UB42xiYCt4F
X-Received: by 2002:ac8:70d4:0:b0:4ec:fc4d:372f with SMTP id d75a77b69052e-4ed175111dcmr8545221cf.10.1761728814726;
        Wed, 29 Oct 2025 02:06:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IElbt4qWPPUXpf4p9NUocwcarMsftG2aY1qck6zgu/XgkjJgWeUk2ELHyKmZMN1dhAIjOB7Sg==
X-Received: by 2002:ac8:70d4:0:b0:4ec:fc4d:372f with SMTP id d75a77b69052e-4ed175111dcmr8544951cf.10.1761728814248;
        Wed, 29 Oct 2025 02:06:54 -0700 (PDT)
Received: from [192.168.119.202] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b6d853fb3bdsm1348086466b.52.2025.10.29.02.06.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Oct 2025 02:06:53 -0700 (PDT)
Message-ID: <d99b03f4-ae44-4b7d-b4d0-45e2c3058db0@oss.qualcomm.com>
Date: Wed, 29 Oct 2025 10:06:50 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] arm64: dts: qcom: sm8150: Add support for Xiaomi
 Redmi K20 Pro
To: Piyush Raj Chouhan <pc1598@mainlining.org>, linux-arm-msm@vger.kernel.org
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org, andersson@kernel.org,
        konradybcio@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
        conor+dt@kernel.org, tony.luck@intel.com, gpiccoli@igalia.com
References: <20251022054026.22816-1-pc1598@mainlining.org>
 <20251022054026.22816-2-pc1598@mainlining.org>
 <ccdd5d44-2382-44e9-a56d-cbc5da23b13f@oss.qualcomm.com>
 <5C7DC3D9-8DBB-409C-8672-6388EE01C320@mainlining.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <5C7DC3D9-8DBB-409C-8672-6388EE01C320@mainlining.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: A2doUDPkluXbGpQUphC_iLs_CwPKSXuD
X-Authority-Analysis: v=2.4 cv=HM3O14tv c=1 sm=1 tr=0 ts=6901d92f cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=OuZLqq7tAAAA:8
 a=_p6pwalp-NRVsU-s1EEA:9 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22
 a=AKGiAy9iJ-JzxKVHQNES:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI5MDA2NyBTYWx0ZWRfX8lUqzWPMp/LN
 VfaepKxt+xrvUSI5M/vUaHzHlYCMmij1IYFwOFWxkvW/IZf1isOLtq1/tLNxkwleJnQGpOXZWOy
 k8s0Hs2eQsqE8YUg9Jpu70wx8CS5UT4GJj8tnXUHGmyOQiMjLn65frtLVs2iQtGtzXrfDJRczf7
 EWpYCoo7w7rMABvE7/ScUQnxeB91KGKm5F4YJInO8LRra9jz/qEBGPMfVyu1pz20Z2DOA36J/yy
 5mH403k+EMSTGtBY5lYOhTeKbu1O+EVnrwuteIJXV9XvcRzE9f+5JLA7SDkKW3nT68xUqun9XRc
 4VLRhp3FJgxHOtMm5m6vvQqrUHNbABzo+aINQM3x9sX+utwLWmMRFZaTuMb7oeZnycjCHyZipE4
 nlMCOgFUHbDQloHP33ovtQ9MeWCybQ==
X-Proofpoint-GUID: A2doUDPkluXbGpQUphC_iLs_CwPKSXuD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-29_04,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 priorityscore=1501 malwarescore=0 adultscore=0 phishscore=0
 spamscore=0 lowpriorityscore=0 impostorscore=0 clxscore=1015 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2510290067

On 10/28/25 5:13 PM, Piyush Raj Chouhan wrote:
> Hi, konrad 
> 
> 
>>> +
>>> +&i2c19 {
>>> +	/* goodix,gt9886 @5d  */
>>
>> I see there's driver support for the GT98*97* - is there a chance you can
>> reuse some of it?
>>
> 
> I am currently testing touch on gtx8 driver which currently is in lkml, once its merged we could add support for it.
> 
> https://lore.kernel.org/linux-input/20250918-gtx8-v1-0-cba879c84775@mainlining.org

That's great!

[...]

>>> +	led@2 {
>>> +		reg = <2>;
>>> +		color = <LED_COLOR_ID_RED>;
>>> +		function = LED_FUNCTION_STATUS;
>>> +		function-enumerator = <0>;
>>> +	};
>>> +
>>> +	led@3 {
>>> +		reg = <3>;
>>> +		color = <LED_COLOR_ID_RED>;
>>> +		function = LED_FUNCTION_STATUS;
>>> +		function-enumerator = <1>;
>>> +	};
>>
>> Are there really two separate red LEDs?
> 
> Yes, it has popup camera with an LED on both side, i have verified functionality of both LEDs. 

OK, would you mind adding a label= entry with perhaps "Pop-up camera
front/back"?

Konrad

