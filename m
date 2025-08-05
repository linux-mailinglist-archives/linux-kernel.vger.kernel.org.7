Return-Path: <linux-kernel+bounces-756427-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29D1EB1B3D4
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 14:52:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4A9647A5155
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 12:51:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 550B526E701;
	Tue,  5 Aug 2025 12:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="LrNUMBlq"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 556F92701D6
	for <linux-kernel@vger.kernel.org>; Tue,  5 Aug 2025 12:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754398367; cv=none; b=ptQV7SFNkQcKVDmRXEt+ubEf1ctPIrsPVcYjTUysVQXnCi1riSYVW96Uibz0IKHDZXYAFQlmcUWrKGJOg+a80B9DoUNCf2zQfoYXR0gv9utzFZYSK+FKjyj+HtlNxxQs5mifmOHFO3LW05rW6hNbbRLorAJipzn99nPNZw/6dU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754398367; c=relaxed/simple;
	bh=q/Pf+LImqDPEmSBNRozyIBQYPrPbtMCscyQ+teS4krA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Iau2LAw7mnHVU8wwdEyKXi054aF+SZPzbTo08Iok2M7LQs57pkW0tvMgSmEMhKM1eVyqOB7PCv3PyjRTbwuNKuTKhA1QXoqXtlOcjna/b1imVslncEFZhfJcAXERJMMCRokZYicOAgvdTziY8ie51MjftFpqhrYZr3sppM/9IJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=LrNUMBlq; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5759Yaf5016890
	for <linux-kernel@vger.kernel.org>; Tue, 5 Aug 2025 12:52:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	5b/KVm/YPT8bnDkJ9iHVahvY3D/dDdc9qRh6qym7lX8=; b=LrNUMBlqeOSxq0ZF
	WzsZwhMS0pS4eshYXzoVJkKV/KNNkBj2IPuMownBSBtPg/1UOJKNAbHceHoGRwVn
	HAz5oeNRubyeAWDK28t1QKv1jRZnnb8U7b/3On5tclzkfxvA3SXL3YsBIm3IOFPq
	wE1nHp3BIVKW0puMdwWLGRu05KFZfJEqpwkJ4uxzlbhhQwgps0dn9U0eXYLsOFhl
	9fBmfK1ctLvEHXTbTyz6T28Wldr0NzoVm5UYP/o1maA43iGNRD7r/F2JSDce3MmK
	EEi1e08GQOa4cY3J7EAdhD9Izth2nW8tMv9OAbI3Tw6b/Z7yS14b6zCg6JpkAvH+
	Ljxe/Q==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48aqyv4r6x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 05 Aug 2025 12:52:45 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-7e7fe59cffdso10961085a.0
        for <linux-kernel@vger.kernel.org>; Tue, 05 Aug 2025 05:52:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754398364; x=1755003164;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5b/KVm/YPT8bnDkJ9iHVahvY3D/dDdc9qRh6qym7lX8=;
        b=EFhwaNd3rtwpwWxdX/SckV4I8eC+ySXq6EeePURyW2odYOBybWGwlogT3kuAju+WWb
         FSXXyxKGD7OceEdEk9PXUw03s7EKDKiD6E/5NQIizIwx9TogjDLbJby1TkNEJzrLH0cj
         hRArjSnb6w15kQq6d5i8BjL72INCc73ap8gWXV0q2bgaI6lZCsLbIXjn3VhHcZVZs1q1
         vRbYpCs8qC3YIySNoIMYhTbUqKWpf8LJ1lpoUJxATjdsjeY5QJswU+ruuydzbryTSS7W
         rEMsVn6Mt8DFGWEHxdBgp8ADGGWttxOcuPKqpIRI5ovg/llc7TV1N/bdmlHL07vbyCbU
         VYRg==
X-Forwarded-Encrypted: i=1; AJvYcCWQbzNMFd97xTZ2faVI3qyV7Bo1YyOAx40cP68An+oGTINVqNmun8fKMJ97wlCKz+ZOZccV5u6TC/mWt5s=@vger.kernel.org
X-Gm-Message-State: AOJu0YwyJENcvcg/YRlM8J4luCobd4tv3ht8BfqlavY9DbpEM+BSEp9J
	lSbka9+2h4eYLsLTKNY3FcBwESNn2oTWkWBrzigzzOk42+3GkDZbIsbdlJ0oOelaZQJde6dz9VO
	Axs7IpSSnExeV+z/rwtlC9gZMRRFfkcRodz/yVQn3pNpDd9UcmwLd3FgJM0RgfJGm13Y=
X-Gm-Gg: ASbGncvF7eRlDwuHFMyd4bJJb8U+1FddNrOwIbhhorXhFbvhuWfxHxZmHNV6T1xPWZ9
	VCzA/sgiS0PQFw/5W0hP8ILwdvg76+wo5i5hDBIPQjE5NpQ0fT7lEFdoPkjuH4+Rz47ErdAgJsV
	tWq5NF0pZybvUdktd7mySe87cVEkWzr5SmLa9Ph5t4kIto1J/sLit5lSPhFx/McqGMRKZYX9Nj+
	Lu2gjRBTZ05pU/MZztuMc/BvLKQvHyzV6lhgo4G/hDqY41GQ2jIFRGsfqS4kGx06oNxq3Ykf3Lz
	9+q9WpQdmm8Bju84WVO+FB1+gM2UUsFhh+3uP6YVGMDNcQBvOaWFa8UtcDfgKLEpr9iE+XR3MFg
	5xlkEcA0nYmSBZ210eQ==
X-Received: by 2002:a05:620a:3192:b0:7e1:79eb:18a3 with SMTP id af79cd13be357-7e696361ef6mr813930385a.10.1754398363913;
        Tue, 05 Aug 2025 05:52:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGuaX+C0DFmFpdGCDTY1iuKXIqocyyPPc/GJdm4mkE4siPVWTnaA7sBVdxF+3YWQveqC0ePBA==
X-Received: by 2002:a05:620a:3192:b0:7e1:79eb:18a3 with SMTP id af79cd13be357-7e696361ef6mr813927885a.10.1754398363491;
        Tue, 05 Aug 2025 05:52:43 -0700 (PDT)
Received: from [192.168.43.16] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af91a0763d8sm914523366b.2.2025.08.05.05.52.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Aug 2025 05:52:42 -0700 (PDT)
Message-ID: <b0e13823-a654-4a1d-88af-0f485bc79fe6@oss.qualcomm.com>
Date: Tue, 5 Aug 2025 14:52:41 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 2/2] arm64: dts: qcom: Add Monaco evaluation kit
 initial board support
To: Umang Chheda <umang.chheda@oss.qualcomm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rakesh Kota <quic_kotarake@quicinc.com>,
        Nirmesh Kumar Singh <quic_nkumarsi@quicinc.com>
References: <20250801163607.1464037-1-umang.chheda@oss.qualcomm.com>
 <20250801163607.1464037-3-umang.chheda@oss.qualcomm.com>
 <4rxy4iuqy3dstfuv744gw327gf5n5g6notjpmkspjme2w4sd3j@5sbqfoumb5y7>
 <588f29a8-827f-412e-b525-a1bd3f6c2d87@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <588f29a8-827f-412e-b525-a1bd3f6c2d87@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: BulOhndWv7EZfYdFwOGgZaUNoJPzH9sX
X-Authority-Analysis: v=2.4 cv=F/xXdrhN c=1 sm=1 tr=0 ts=6891fe9d cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=KvKYKMb6mzjDDU26cbsA:9
 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-ORIG-GUID: BulOhndWv7EZfYdFwOGgZaUNoJPzH9sX
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA1MDA5MyBTYWx0ZWRfX7Votj1VJxe7k
 oW2su7IQ1eBuAlQgweJWnGCW3FDzrNmev1jQ8XIHeqL/lBz+BoA/1w93cBIVzwdCqzmw8PKPVoi
 5/gNvD+E5b0JH47KxIaGwsI4MxhbuFv+gaKLE6ipwT+DxqwSS22TE9OR/4lghEh1tg86mQpa+Od
 0prtDiMZdOg7lwQI3WGP2gDTN1ZglqT2X4F9nWZRKJUXyzypWBT8q+F3NsydnRwDF33MtBf2rwC
 lbupRjWPUdETk4udyovTA73Z6wCw8t+/oM7eh7UN2adTwxjxNBOsO/dm++mDI7gf+F9a3caQ7o8
 wzFu7mKSwU3fr7588P9naoLSu0gzcGXBoXXky6E19H62VZJFsKKGXcHPv42GzYLihSSY5FRU1y5
 HK31Fq/Tkg2ikm6gyekw8tOlBODnhpqgifANFMW2sZpPSDBhRdVI8+1G33JsJeWUP+hvJoei
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-05_03,2025-08-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 mlxscore=0 phishscore=0 bulkscore=0 adultscore=0
 clxscore=1015 mlxlogscore=999 priorityscore=1501 impostorscore=0
 malwarescore=0 lowpriorityscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2508050093

On 8/4/25 8:18 PM, Umang Chheda wrote:
> Hi Dmitry,
> 
> On 8/1/2025 10:44 PM, Dmitry Baryshkov wrote:
>> On Fri, Aug 01, 2025 at 10:06:07PM +0530, Umang Chheda wrote:
>>> Add initial device tree support for Monaco EVK board, based on
>>> Qualcomm's QCS8300 SoC.
>>>
>>> Implement basic features like uart/ufs to enable 'boot to shell'.
>>
>> "boot to shell" only makes sense if the platform is new and not all
>> devices are enabled in the Linux kernel. Granted by the current level of
>> the platform support, DT files for the EVK should have much more
>> features. Please submit a full DT at once.
>>
> Currently upstream aligned changes for other peripherals are not yet ready
> for this platform, hence posted base DT support, will subsequently post other patches
> when they are ready.

Dmitry refers to non-groundbreaking features, such as USB or SD Card
which are a 5 minute job to enable (since the SoC bits are in place),
mostly just requiring confirming with schematics that regulator
assignment hasn't changed versus other reference boards..

Please keep in mind that the more fragmented your changes are, the
longer it will take for them to be accepted upstream, as separate
patches carry a lot of overhead compared to what they offer.

Konrad

