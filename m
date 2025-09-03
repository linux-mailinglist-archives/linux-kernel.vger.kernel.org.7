Return-Path: <linux-kernel+bounces-798481-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D911DB41E91
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 14:15:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9DD5C5442AB
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 12:15:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B52372FAC1E;
	Wed,  3 Sep 2025 12:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="AqcM/3TH"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 643092FD7D8
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 12:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756901669; cv=none; b=ilJcjrv/yjDJgq1e2pEi5krCXvlcNyiGVh7rVGCHwkuW/SjlTzkYsVjYQ0Fe9YN6CnhHDjvmNqWBmrpW6+j5TwhuRH+S202C6ne9A5UQ7/OqI/3bAVmsy2RxLjtNY5Tm5Ivtgs0L1qLxJASCjhRExrEDoQKZGMqeKhSInYMwf90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756901669; c=relaxed/simple;
	bh=rhcG8/VPnpbFKNJE/RJEZ6fxiaJwxSbJPaO6Ku2gAGE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OeYmCVCD6VGQ1nK9zgpEbH6DRv6b5utPYh4PBsVI6nkYxJlUvrKP35RgylbiFXTXXdI/qZuU3Yp5pMgIqp5/80zai9VA7/GaF7ZzsOeCTnH6yb52jI8vuj+bT795/3E6ex7TUvKTDBtVyQ1Z/uTQEY4oEj321Sj4FMHeHUjJMxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=AqcM/3TH; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 583BF3PP004538
	for <linux-kernel@vger.kernel.org>; Wed, 3 Sep 2025 12:14:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	mC6An3ACH4+NSeazLfe9JFoE+xEhWTvXPq1zxofMuEo=; b=AqcM/3THpaYT+ams
	5CYDdDcz8nDnksCpBVAPELLmtnVfkHuuv16SkmyGQ+IuK/C/iPq8tqJ8rYSiq2/j
	KoyyfhYDHrq0yE1a0QkOpaWmKxINXvoNmZpq+sscYDaACcHYyxGUNbpK64wkyW0A
	OjEsYBIcOzaoNJM+tFKQ6QeKyIw3DF/OwA7pH/Mi2Ef44gsg/AAI18P4tVvyushr
	xVBvrX8x+GgYv6XPoicQW7Iz7y2VXz+p+GNx7ZsDmepCvu0kGjNofa07S0JBefSa
	/pSFppoi3l0sQWv2OPo2sIqRfHlL+ktsGBtSsendSRjHcO3KUYnZc5HoV1dKU62h
	gQIWVA==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48upnpbrd2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 12:14:24 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4b48f648249so2762531cf.3
        for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 05:14:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756901663; x=1757506463;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mC6An3ACH4+NSeazLfe9JFoE+xEhWTvXPq1zxofMuEo=;
        b=dxL4LnQCkK42cRq0gHRLVyeA3wt/tzVO1lsWVMBMXimrkhOqOpxDnU0nkE6u7UvL2d
         yF4D4QBRH3k8jTkCLcRQ/wu3XO/Sd2MD/Q89W3l52zRtTKTJLupE0TMhD66HWkMNCqsx
         bl9+FxteK4Z85gQeE2WB/ik8yeAegTi/UIW5C/K+jWiyABDhKa86cqtSYBPWQnd7yumy
         B9zosr63gG4dWfb72GkyJTl9zAVjsRS+HSF6XP8DRtpfdztgTjvva67RbUls6/l77m+n
         TZsynR7SYaH10/xAalC8TY5wpOYpdlVCWtVPKn6ubwABSg4knsDv48zMkpry0sVr1BiT
         ShAg==
X-Forwarded-Encrypted: i=1; AJvYcCU63FJcl5HYEM1h7Xu1ivTE8/uxFGLMD2dRLYXn5xA8NMMidMzd2Rpu6rhTgcBpxm7IJsoOcvCxOpUDhu0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZbMW0TGWnC4KBh7mGmmVgNjPtm8RnNgUFn1RzJ4P/78PUnmnk
	9dK3P1BiR7AuXT7RHt+QbeARBioXfjS8YuB1BVb92iQQgvMSJEnmPitFNfmamzFyAOa9UWV2vhS
	SSJTdcxB/aF89IDjBCqNpPAf0AQ7b60Kh4afJCY7Sz8XiqSN+gYJmpRFHboenRFFxiIvT4dbjiO
	8=
X-Gm-Gg: ASbGncukB0MEhYfSZRhM3lz3Z0hQrea4WUsicz9/zBY9rJzLTtVXRWMfSnvYfAFNfuH
	sZ7T9uWEiQndvrLXXy9y2ghWDiaqYSJn86LtXBX/O6ccsJQOqcOGVlxUTeXyHYQMCVbLz6lZozw
	/8DHn/is6gtvhSvIpoDhjW+X1FXKqzKPL1a0YvkdYQk6AuPoITw6J7FAEu8I4II5DCPaF3fui4X
	RCM9z1MHI9i0FHqcaK1ScUakwvFhZ3/D4MdEhPwrEv7aveYZTCX4W1FzehofFeJu6hnW/O5N7+Z
	341rrw8xi0XohLqrbJKNT+t7wok4+oTlQQJiUCAHeUFJh2r4E2Mn7lNd05yz5BL9P6TqGfTg3N6
	/kABWHynx6b5vN4OsTYdXGg==
X-Received: by 2002:a05:622a:314:b0:4b2:9c61:4925 with SMTP id d75a77b69052e-4b313f6f611mr137985541cf.11.1756901663142;
        Wed, 03 Sep 2025 05:14:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFbGyRaZCILk5AbzkX5S7+FiK0ezTAsGQ11EcJB+LA2KwdbsAkKq1MEodJHRCgys5k9RkRULQ==
X-Received: by 2002:a05:622a:314:b0:4b2:9c61:4925 with SMTP id d75a77b69052e-4b313f6f611mr137985251cf.11.1756901662589;
        Wed, 03 Sep 2025 05:14:22 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b046e6c630fsm97561366b.55.2025.09.03.05.14.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Sep 2025 05:14:22 -0700 (PDT)
Message-ID: <b4b6678b-46dd-4f57-9c26-ff0e4108bf79@oss.qualcomm.com>
Date: Wed, 3 Sep 2025 14:14:19 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/2] arm64: dts: qcom: lemans-evk: Add sound card
To: Mohammad Rafi Shaik <mohammad.rafi.shaik@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@oss.qualcomm.com
References: <20250822131902.1848802-1-mohammad.rafi.shaik@oss.qualcomm.com>
 <20250822131902.1848802-3-mohammad.rafi.shaik@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250822131902.1848802-3-mohammad.rafi.shaik@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: oUBjojDPY_nU-QB9foCOWM1topTc4b6X
X-Authority-Analysis: v=2.4 cv=Jt/xrN4C c=1 sm=1 tr=0 ts=68b83120 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=3ui42MrppmT3PW2QgFQA:9
 a=QEXdDO2ut3YA:10 a=zgiPjhLxNE0A:10 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-ORIG-GUID: oUBjojDPY_nU-QB9foCOWM1topTc4b6X
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAwMSBTYWx0ZWRfX+pRJDbExr8R+
 A7Tp2xf9VxuZdjOjbRQqs/CzwzLZ5uMMZHPYGW+cmSH5QFb5xNDXhY0/MGfvhhp9gL0jFjaGnjg
 ykpXXxiLkOE05EYFr7DlTpBViEvG4OHxkyHVWAgupN7E9fiHYbJsWT4RtKPRHy0D8wZKuwsy1Om
 PljjjzbExPiT6XxvEHT7Nlt6HWzSLm+8Op0DNpcHlQMK1MdsrQacUp3CGSYZZUyC20FCNx7l5Xh
 1U2F78xZamECIxZ9pA2WMFgAnESzovyMui1zEPh0KnhdU345XhKCgrZgKRS5fV2IzkTFxuPTQeM
 vr8TM3TzoGpjaj4uMt2VmB2MC1KqLRZAntmF9MOqt8vGAsuKim/diem0iBqYoHzRxpxqwuj3M88
 9+vY8/lz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-03_06,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 clxscore=1015 bulkscore=0 impostorscore=0
 spamscore=0 phishscore=0 suspectscore=0 malwarescore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508300001

On 8/22/25 3:19 PM, Mohammad Rafi Shaik wrote:
> Add the sound card node with tested playback over max98357a
> I2S speakers amplifier and I2S mic.
> 
> Introduce HS (High-Speed) MI2S pin control support.
> The I2S max98357a speaker amplifier is connected via HS0 and I2S
> microphones utilize the HS2 interface.
> 
> Signed-off-by: Mohammad Rafi Shaik <mohammad.rafi.shaik@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

