Return-Path: <linux-kernel+bounces-860782-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id AF628BF0ED7
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 13:53:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 910D74E844C
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 11:53:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 931B3303C9D;
	Mon, 20 Oct 2025 11:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="VSo6KXkl"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53CE92F6929
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 11:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760961218; cv=none; b=VOdqycTVVkVyOuLATn/4FV6jN9KAmGpwDk+SFuwADwGlSa/BT2AhEtzs3mkeagYR5SEYumG5nLnhOfKYW2UpwibKXErWOOP8XJKbesiFnnYrfRcP4du+UNOCZxkCXhAXITSXcFDDwp656jOtD1xCj+GNqK3zIOPVRyB7TOCkIuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760961218; c=relaxed/simple;
	bh=D9TMjnoCdpB0xJo4Os4Kj35sbq3Hlt8HHvrpYmYCTe4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=L/z0LI6A6ulnYnl+fBFrg8vUHhCT1cvoo6TkURKisnX+6XRah0TsEF+D34i+RbFd6VMtu+hVOTqZ+L/HfdBz4ygO3FFsGIX9q3kbnS9Qlh35DzXcXmUcGuj6v/iCgWkq9wMkiCoI2hfs3L0ItMCSx6Z3aC5/aQwb/t3hUS+G6i0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=VSo6KXkl; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59JNbRg8016504
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 11:53:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	E2hvjL5IfGISuHnMb6jxRMJ8xyIxhKauJ5pFs9sdJn8=; b=VSo6KXklsgrfjL/g
	b3Itux7ZaduSJGS6N+6gGDdBPxbgxYieE3El/09k7pK1xzp+eOeJXEjKVLNe/wZ7
	39M9jZOQWaIvNpYZ/TCLP0noggfKcTwxkaOh19+wXldJoy6+lJ1eb7STb4m/ABfR
	uDKjt6J1RK0ay5IVqtUunXJv/6+04PqKd9+PwJc1a5Kn0vC+zec9RePXlxA127sB
	j00bk2p5mA91bxFsAuJQ/YlDLY1f3LaVERQVV5DrL7qhlYQ5Rjl1K2gmXE0zluNs
	PPO82rjiqUmeTTctTNqS20epgM8bxNbrh4K2A/BSPIg/7+K8VRHCzBL20xsLxlWs
	uJhepA==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49v1w7vq2w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 11:53:36 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-88f3a065311so155721685a.0
        for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 04:53:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760961215; x=1761566015;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=E2hvjL5IfGISuHnMb6jxRMJ8xyIxhKauJ5pFs9sdJn8=;
        b=XuRNTbTS47mCqdIaFDVsP/Ddy0eVG0nQ/4gkQw54fW+Y4xA6tme6v7rbAm/hG8O5GJ
         1x9WpxjT3nPVQ//uuvnzZqO0RmR49oDJ1ZwGDMKm+zs1qYUk4F4u6d4d5Aj/VPcjf9bY
         udMvpOJH9aC5gIoIpe5WS/ocJXmG1dzfZgSYUHMsjOALXGbRg5cw9kwpfh14K6GGkrKC
         Up3rJUNvHOlyJdu4w/uQTbsW9SlVFD7m/zKI8WZ+pjduN9kycm9ZGCuIlBUv2vMs0jZM
         OnidgDRLr62jagNZvNRQov7IS1S/HGSYxMAy3AVsstI+IjN8hYMv9SJeCkb7xd2QTpP+
         PWCg==
X-Forwarded-Encrypted: i=1; AJvYcCVgk8ip2UFWFd+T14b7syZVgnn2ic4D3HJXtvAhSn3Yvy1TN/YxUYU1txVbUYzNZQq5qy0nMERzB/Nq83U=@vger.kernel.org
X-Gm-Message-State: AOJu0YyiJn6OYFKXxYzNLt5WBCeUXfZlVDO0sF6o75H3O5hHNCK5vqqE
	A985RWPi7BlgNje5LorFtza3VWzzoLl1uhz4RLFKMFp3GrCfj1vk1PLlX1YyKesm80Q3KWclfBz
	mI+rv9iOMYhdLLcXmzocNQjG9dF2drpjXkiwmlOKVZWL3KXktU8bX9h7rf/y4Lh25k0M=
X-Gm-Gg: ASbGnctnbhT0LmHnTGvT2bSfWKRbRlHYqAygLXGG0VYuyIoBjeJ5iewhGQw+ZFFpXzo
	MB+g+BN523k6+f2z9vcKg6X/4yJawj0ZrcjYaiMIA7MFM8Siwc5OsWzuhbcO6J2Y8lLURPjggZC
	yzgOs0adCU0J7/FcVB+Os41bi2Yr+A34lFUsC2gMd2x8ucSsks6NWelUnrays09eUkXx4z8P8uU
	3EXmyIvx/sFq7tZd9RNHZIuAQABrZkwJTuBLk2o3gR34ROxJazPsKHVwjCWFoPHZC1DIFKzYOCU
	z7wXzMGHCtknAiJ1lQxYWgJ4tbU+IFmLXgbHLhKTbockfmCqskOf7h5JMPPqPtwITbFCQtCNKW3
	D6FVIYfvbz7Nq1H+cwVO671uouXSja0lvRGQHXcBCJ2XZAR92VyKfGq0c
X-Received: by 2002:ac8:5908:0:b0:4e8:90f4:c3aa with SMTP id d75a77b69052e-4e89d35acfcmr92980121cf.8.1760961215339;
        Mon, 20 Oct 2025 04:53:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGDF5w2J/DkfstxpZTbyf16Joh/f/CYfZXYRWhNuKRmYKNA/7K5jpwJVAYOdOKa21qBZqycgA==
X-Received: by 2002:ac8:5908:0:b0:4e8:90f4:c3aa with SMTP id d75a77b69052e-4e89d35acfcmr92979771cf.8.1760961214780;
        Mon, 20 Oct 2025 04:53:34 -0700 (PDT)
Received: from [192.168.119.202] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-63c48a928c3sm6568672a12.3.2025.10.20.04.53.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Oct 2025 04:53:34 -0700 (PDT)
Message-ID: <079b0120-efe2-43f9-b31e-8d65f6d7859b@oss.qualcomm.com>
Date: Mon, 20 Oct 2025 13:53:32 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/24] arm64: dts: qcom: glymur-crd: Add RPMH regulator
 rails
To: Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>
Cc: Pankaj Patil <pankaj.patil@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250925-v3_glymur_introduction-v1-0-24b601bbecc0@oss.qualcomm.com>
 <20250925-v3_glymur_introduction-v1-9-24b601bbecc0@oss.qualcomm.com>
 <a49f3f75-c882-4635-9be3-a433b7fe32c8@oss.qualcomm.com>
 <20251015154031.hbifj6khno3gi3mz@hu-kamalw-hyd.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20251015154031.hbifj6khno3gi3mz@hu-kamalw-hyd.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAxNSBTYWx0ZWRfX3WNozBFRdhtt
 7uDrfPN5X+0wh2OCL9d86urbwbgpfusqoZmBBYx7+qItaU0cpBDjtqVQ+ZQc+GUZfgsDxBoLgQ7
 06kw5G0rk7eSgLjsfkLzAaPN1ZjJGtsqlHRQlrtEfzpPfKqstdX0m2AfQlC5qm6Vaa7ohEpfi4L
 KSRnfjf7FjqQSchBYlaldtK3P1nu/lhjAweJGMZeoj9aIwGVUHxJ+nqJisDB9nSP4LKdv2osS/8
 AqBv22uoVEN51OdMRzE2R8sIUWdUfWVo+0ic3u60QOrBh/CRXvndoXyN/7ZgY5XzEUpeRLqkGgn
 7mxBqMEBlCBjxmVEeqs89VkGiOxI1QGbPq0XqjgriGrslfEzv36n5GjxV9hdA3OYmOa7Nb7kZmL
 +FUafgF/H7zjqqw0BX+TpycGqP+DjA==
X-Authority-Analysis: v=2.4 cv=bNUb4f+Z c=1 sm=1 tr=0 ts=68f622c0 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=FuG2qi5Kk0EKLw-Bb9sA:9 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-GUID: GMQuo2_nkHnZ3v0xuqP2N6Q4hCNvlWPs
X-Proofpoint-ORIG-GUID: GMQuo2_nkHnZ3v0xuqP2N6Q4hCNvlWPs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-20_02,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0 malwarescore=0 lowpriorityscore=0 clxscore=1015
 priorityscore=1501 suspectscore=0 adultscore=0 spamscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510180015

On 10/15/25 5:40 PM, Kamal Wadhwa wrote:
> On Thu, Sep 25, 2025 at 01:01:56PM +0200, Konrad Dybcio wrote:
>> On 9/25/25 8:32 AM, Pankaj Patil wrote:
>>> From: Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>
>>>
>>> Add RPMH regulator rails for Glymur CRD.
>>>
>>> Signed-off-by: Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>
>>> Signed-off-by: Pankaj Patil <pankaj.patil@oss.qualcomm.com>
>>> ---
>>
>> [...]
>>
>>> +	regulators-1 {
>>> +		compatible = "qcom,pmcx0102-rpmh-regulators";
>>> +		qcom,pmic-id = "C_E0";
>>> +		vdd-s1-supply = <&vph_pwr>;
>>> +		vdd-s8-supply = <&vph_pwr>;
>>> +
>>> +		vreg_s1c_e0_0p3: smps1 {
>>> +			regulator-name = "vreg_s1c_e0_0p3";
>>> +			regulator-min-microvolt = <300000>;
>>> +			regulator-max-microvolt = <1200000>;
>>> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
>>> +		};
>>> +
>>> +		vreg_s8c_e0_0p3: smps8 {
>>> +			regulator-name = "vreg_s8c_e0_0p3";
>>> +			regulator-min-microvolt = <300000>;
>>> +			regulator-max-microvolt = <1200000>
>>
>> Both of these regulators, having no consumers, will be parked to 0.3 V
>> (the lower bound)
>>
>> There are other similar cases in this patch
> 
> Ok. I will remove the unused rails.
> But just wanted to let you know currently i have exposed all the rails that
> are allowed to be controlled from APPS, mostly these rails will be staying
> OFF if no clients in SW are there to vote on them.
> 
> But do note that some of the clients may be getting added as more features
> get added, as lot of these rails are not unused in the HW. The client driver
> just isnt enabled as of now.
> 
> So wanted to check if I should remove ALL rails that are unused in SW?
>  or
> Can i keep the ones for which clients will be getting added in near future.
> 
> (i would prefer the later option, if that is ok with you?)

Please keep them but restrict them to the actually useful range, not just
what the hardware can do.

Most of them are presumably hardwired to specific peripherals and need
e.g. 1.8 V
>> Does the board still boot with all the expected functionality with only
>> patches 1-9 applied?
> 
> No. just tested, it seems not able to boot properly with just 1-9 patches.
> is your concern about squashing of the patches?
> (just trying to understand)

Yes, all boards must boot and not regress at any point, including at the
introductory commit. Otherwise bisecting is impossible.

Konrad

