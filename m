Return-Path: <linux-kernel+bounces-833652-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 24227BA28FC
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 08:44:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D8DFD5602AE
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 06:44:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C15827A469;
	Fri, 26 Sep 2025 06:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="gv7kMLG7"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8FB91DC1AB
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 06:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758869044; cv=none; b=Psn+RhxyOQlYoF8phd/04l9yB9l6qQZ19lSfDSF+MPiiOxK2EZm4KTzdb8MQlOOPiyFCZzO4uGiTgNe/zzqkjc50rWLnszLe+XsdGQ/RoPb0wgPDyIQBBK/dqdx5tfV6SbslKMweeGSwGvAnYzIwtxyI7Ln6dah2JpzPVHS68vk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758869044; c=relaxed/simple;
	bh=FOe/NOS0bVJ6sIXlzze34one+JrpzOiKRfBtIMT7KL8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cG1a2IMRoQZX8gQ9gTg4jVOyg9Xwb+mWFvdPoPoqEv2XWuFlxIVYEjsvdQ1VPwM/19JF46YZVm0dntjT4fdxJKKJ6JJMlK+Qw5BuuHcDK0GzxfcqGiYxBc6bwVxFb2MA2wKTNNPUIDqbKSgS3xGZvYy7iy5Qoa+X/nvUzUlNdvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=gv7kMLG7; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58PIQOtm008118
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 06:44:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	6Ah7Hu/NIQtxfI1ZNYkMT85MCSf1K+iZhD9pTHSkz8c=; b=gv7kMLG753nHJm6h
	IifTCB5W3TxX+9cE4sIMjk52wWV4CjJHaepVXxtW0aKS9F4JDgYLEWOkQ75riPFn
	f9Eje/zx4s/YNE3fM03th/9Vzanymgwh0dOG8oqbsryJvu5JwZvwjKC+39GsD0W2
	yIIbfEvroJ95//NwQGhiTlHc0I962LLFnU3HuhT4Qv9CXErlmmaMjwBH9UJW1542
	hOTvatanXnz2pU3OuFKA7BmiwlCChusODnKvsFua/qQkvlzeUpK2hgtZVuWVHpDi
	BSdvpIm33GomGO2JzUxh+RV1VHS57NzY10gVcRggOic9QI8BTsM2ny6VU7qua3tM
	n/hfrQ==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49db0vsq6u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 06:44:01 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-780f9cc532bso1612746b3a.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 23:44:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758869040; x=1759473840;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6Ah7Hu/NIQtxfI1ZNYkMT85MCSf1K+iZhD9pTHSkz8c=;
        b=kWGPIJNgmHOx/8qqCc0eROJL4My7z1TXiF1d1pm+5XcKXMjH3VKN+ZLJephX659KZY
         JRwnkPEESEVh6Lkb1Nww60ob5T5Iw96JMIgF6RaIpT+TJ8QxoXP4Uku5kRV45J21DxfJ
         Qq0ZKjNeCzVfDu7y15UDiN2aZ35v89bs4SXZINrPM81Vz1T4DND+UtUvztxcRdg+vE4R
         PvTAbklyDW23j/djcSfn5JQV3I1R7db2JpHMIMgTNLeII5WcEdx2oZ6T+pTjajXCBaX1
         pnhenw+rhRITlpdl3N6bi29Yt40UJMJYw8YyYIvSmfSyaR8PQQLMLTk1CsPfN8yPoSbe
         s1+g==
X-Forwarded-Encrypted: i=1; AJvYcCWLKB79tFWcT5SvJ42aPsNzvYsSEiv5xJbGDWyhRt/z+l09HWsfHEuQYFqq0KOuE76AnH/HbEFGjvTMyKg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLCd8hSRCkL+rg/abpOPhCRMjzM/XmOYVG0nyc+FPht0x+cSap
	2xWKgsJGk5ZRlZkBLNi0fp7jz22aQc3lHKP6CW1BcEi2X3IDwvN7NxcTy1xuiHTBGE9Kdc0aAUw
	yarPCf7sn9Ne/pal7cQ7qJrPjZIlT1+qDlSiAB0X51+VoD33EE8j/8E99O8eeFiWoqXc=
X-Gm-Gg: ASbGncvaj2iu4nUX+pD5P0JQbP/zMKbMhYRZzU4Vx3BatMlDO5NM3DQ/mpBlj57az5j
	4e183U0RvII6OY5k25trOpndqf1aJdux5sHE4Q2Zz6KSLl+pfIDsLEDRw4oVRxiIxhGPGP/tytz
	HjjxJUthZDXNatd+LA3onHDZ8DLSdKRNniTz+74RmT4pwQvMbELujtwhOvnE7jsAiN+MZpQpRCM
	2jpJgdRt0mf6SESHryBEqt5z0sNh3W48ywJZl1LlZT3e69/3l2XW1zmOCL271fJbnKcDu8vN/S3
	63iOTNKehfpJNMJbzMOL8I8zSPhi0rhcaILnULqM3bIEK+AH5XcWXAIU6nMjDUfdybO8qvzJPiE
	A
X-Received: by 2002:a05:6a00:8684:b0:77e:6a93:71b5 with SMTP id d2e1a72fcca58-78100d090c2mr3814172b3a.2.1758869040159;
        Thu, 25 Sep 2025 23:44:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH83U8CldMXHetQ3laSeCGOU3ou7saMPmIGLdNDqQLrgkOKrsymG7SBpJEFJGicltHH5ioJ2Q==
X-Received: by 2002:a05:6a00:8684:b0:77e:6a93:71b5 with SMTP id d2e1a72fcca58-78100d090c2mr3814153b3a.2.1758869039655;
        Thu, 25 Sep 2025 23:43:59 -0700 (PDT)
Received: from [192.168.0.104] ([49.205.253.122])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7810238c1e8sm3674908b3a.12.2025.09.25.23.43.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Sep 2025 23:43:59 -0700 (PDT)
Message-ID: <f016d47f-919c-2944-ab8f-68e450e5836a@oss.qualcomm.com>
Date: Fri, 26 Sep 2025 12:13:53 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v1] arm64: dts: qcom: monaco-evk: Add firmware-name to
 QUPv3 nodes
Content-Language: en-US
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>, andersson@kernel.org,
        konradybcio@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
        conor+dt@kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: mukesh.savaliya@oss.qualcomm.com, anup.kulkarni@oss.qualcomm.com
References: <20250925042605.1388951-1-viken.dadhaniya@oss.qualcomm.com>
 <9b887bc5-eaa4-4271-8770-3458efb528bf@oss.qualcomm.com>
From: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
In-Reply-To: <9b887bc5-eaa4-4271-8770-3458efb528bf@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: AOo801pts9UQR8IKvn7MCByR5DZMZs2t
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI1MDE3MSBTYWx0ZWRfXwLU9u0UQqyMn
 01saFlWWCvAJJbN5TN+m8ylTZBxhOet5ozUmnoX/DKxKodvXVbE/XvQZwM+ZRSWjZHM8q28MXjs
 X7bjOf+4TKb8poIJj9QeDWTBEXKLUtWhoOt5dfAAdNtUVfYwxqaM+RlEpuIpvpyTndeJN6LWamX
 UAbeT0kMLXK+LVznaWSHDH/sppDVjpMUiFRwuitZ3093BYEBthvo2/SYdsLD3tlQKVSVJIneNUs
 oqTyKgnwmh8S2R7OSA96MK09lRWP/4CrV6AkdhaniwpCjFGsKGENPh3UaCAMT0fLlIqXVPx8sLL
 xBxDjPbqJxdEO/LEgXOxhVJlfG8OIUYTGM6K61KFdxvl2a9MYmaeg6ExrsDdZz1UtCz1ReMCJa0
 CYQl2+U+2QXJ395ysMB3CwjSBrXxow==
X-Authority-Analysis: v=2.4 cv=OstCCi/t c=1 sm=1 tr=0 ts=68d63631 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=RtG+38I8ePlRmB+m5sTI6w==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=YuaoIEpex40H7-UsjHgA:9
 a=QEXdDO2ut3YA:10 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-GUID: AOo801pts9UQR8IKvn7MCByR5DZMZs2t
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-26_01,2025-09-26_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 suspectscore=0 lowpriorityscore=0
 priorityscore=1501 malwarescore=0 bulkscore=0 spamscore=0 phishscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2509150000
 definitions=main-2509250171



On 9/25/2025 2:22 PM, Konrad Dybcio wrote:
> On 9/25/25 6:26 AM, Viken Dadhaniya wrote:
>> Traditionally, firmware loading for Serial Engines (SE) in the QUP hardware
>> of Qualcomm SoCs has been managed by TrustZone (TZ). While this approach
>> ensures secure SE assignment and access control, it limits flexibility for
>> developers who need to enable various protocols on different SEs.
>>
>> Add the firmware-name property to QUPv3 nodes in the device tree to enable
>> firmware loading from the Linux environment. Handle SE assignments and
>> access control permissions directly within Linux, removing the dependency
>> on TrustZone.
>>
>> Signed-off-by: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
>> ---
> 
> Viken, you've posted a lot of patches like these lately for
> specific boards.
> 
> Should we instead push this to the SoC DTSI, to limit the boilerplate?

The firmware load from Linux feature is applicable only to devkit boards
(RB3 Gen2 and EVK), and therefore, it is being added exclusively to the
board-specific device tree files.

> 
> If I recall correctly, you said these ELFs are not vendor-signed, so
> it should be OK to have them be assigned globally
> 

This feature is intended solely for use with the development kit and is not
intended for commercialization. Therefore, vendor sign-off is currently not
applicable.

> Konrad

