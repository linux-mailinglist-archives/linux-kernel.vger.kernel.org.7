Return-Path: <linux-kernel+bounces-883002-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D3432C2C360
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 14:45:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B9F3F18998CB
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 13:44:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 754122FFFB4;
	Mon,  3 Nov 2025 13:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="VArMdJbt";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="fLGhTajr"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E11E2737F4
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 13:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762177407; cv=none; b=nsv7ZEtCz0NivwT9/6LWC4fbN6d28DoGTaPcy/KCpexxvHcgHJdegNVrKLdT5WnDIW2HeRl9+dd2iWNboyDf3T+68FvBACNGj+N8S9Gesi8IoM67FA67BjsQHMavvy/2EO3Fx21/A+0NutsVR7lx/RmMylVFF3VPPRafKNV8N80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762177407; c=relaxed/simple;
	bh=zUtA6R+JPYG4mbgwph8rcDX1royzxAWJNx7buInOXR0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PK9wlYze1rPiFLdq5ibDzGWvabUxGLcmkDm6qSIxJW6k0mOAHtUrwdIYIDRw8uSCpDSZqlMiBmtsqHT6TNFv8tcChgUD5jfSjN+lL4l/nl2pe3A2jbZ1XJcUS4cJXkeoI0VoiAaonhQrgfQ2bMRZCRegGvJdP3tdKZrOD06X2bQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=VArMdJbt; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=fLGhTajr; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A385YAI939301
	for <linux-kernel@vger.kernel.org>; Mon, 3 Nov 2025 13:43:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	jMCxq6CcBjZE3OosUccrGATpFNoIma7Au7rvuKy9TK0=; b=VArMdJbtvSCwCYmP
	JjY4MRAhktSYnAPRVgqvShgLijevcuXH0TUrU1S4H3GyJp2fFox6LUHqnYoQQMeV
	v1dyB6eq1SZ1PhoXM5VmI4JwoWmFJ4/m90/8VxlNvLmQ4WpozZv5z9A/s8fL8uF3
	W3lM1Ux2aMGms3YemU7JWUThzWRfdomU3MgZelzovdMNDIKebghn6uN8C6XYOBA8
	AmbrBBbMPldaX0UoQH/8jufcdLIzDR3jzMETIrULig9tpydxtStWBqXEm6F/Ps7U
	MZYtja3ProIzs05vlLm53YLFDIq+oCC4eZYcdB2K9IeyXhpoWW8QrDMfBcJP2SjY
	6+EhtQ==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a5bcm4ppu-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 03 Nov 2025 13:43:25 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-29557f43d56so20129155ad.3
        for <linux-kernel@vger.kernel.org>; Mon, 03 Nov 2025 05:43:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762177404; x=1762782204; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jMCxq6CcBjZE3OosUccrGATpFNoIma7Au7rvuKy9TK0=;
        b=fLGhTajr5iH9tTR/KvOhURbc+wjWYDecHBB2Zoj8nhZuhFkmmQ7Y+DWcLOoHP7iFUo
         +HezYpxJxzSrHVbmQIi7CnK/r394vEeQl/1QvrC2/QgR9aZkJXbHXuBatqMyqMiPeoG7
         dON5izVOor2J8PkNQL3lb6n4l6R41C4KD9e+j/y3V+YTf6JCqVLuH4Oc8zyuVjZTiFAQ
         NYnRiwgIK0tFGz3kytaj68RzNTBCsB33l9vcGk+/rD7KRF4k2iYXrWvyAF44PG40u7WH
         8mchykgAwiP7r9Cg0JgE6P27YEFpNj7FWu0ipcuuBvn9VRgfumjgiz2LOR7WoykXj9RF
         BQFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762177404; x=1762782204;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jMCxq6CcBjZE3OosUccrGATpFNoIma7Au7rvuKy9TK0=;
        b=DMCldkfyjTyoSCVaFIp01XURV55j0YJqW1qvvQPOoOvmoVB0O/8P2q5/0rcU/pidQf
         llP5pQ6SH9bUH006NjmGQoxxvhtEn1ag/lWaXJiU+vEjiwQ3Ji4ADAqUk7QHPUrDQLzz
         yF3X/o/5y8ECimhXaLaa0d2+Szo+NNADWgMGxyQ7+PC8tos7WF8wgTTkK6ntKs2dVkIq
         VVkakGdlcll4uBQVW4ZGIZjdoBplM2QYTntO9JzpSHCT3aCrP01xvm4BeaE8/0clq3y1
         WyXzxOV1WMdS0FeWzFPGxmgCWxGf6offqc2xBS4mqzDzGNr/UNa34kzYkVwdt4/GiVn4
         TkfA==
X-Forwarded-Encrypted: i=1; AJvYcCWHcNhsK+FYhYW1XjSNic6hkPcPlKCV4WCyx8Edr+LVq2/3mMfia4OlIfo+R0R8W8gCgpfzPbZrSREL0mk=@vger.kernel.org
X-Gm-Message-State: AOJu0YytYasb3raGEznmqQgBHAw8mhwE6bmEE42FZFhM75h4BoRtrDQX
	w05ifZjstsZ+6QeRQpvt0d1HMEhgjfaC02W6r+viACxzvS1c3/rpAYI9jeHt0oZ2Vd32/e8suSk
	9l1y5WvxAL/CTBhoRtEVrf4OANiuJK365G6R265BZmbmHcTfdJvFKPP00/rf7y6jetKs=
X-Gm-Gg: ASbGncvWv25uBWh47tfub1zIMVWb+iaXmOBAEKdb6JfGWqG2txc3bpAcnGR93sraR8C
	6xU3dlv5Eb+uVsM6IjCvhxesX82GdBzj9p8NK0xB9z2E+M81GFsXWLPsDK7mYZF3kCBgJr/IeSr
	Nm9uVJoOv3HI2oreH0ZQhzJHHP3Gzt50KuBQsYjyiTgvfuUbLPxTtsvheoHxq+pSuVHp2bgc9BE
	6Y7ALF61Oegb/jJzutXVuDOh+s0utripBWctwTLbDkQaxcPkUMrdG53q3jSOUhyj0Eam2juhNVS
	fvoVQCh8koesO1Uj2NugpFhIX2Ei9o4PLCXgbTxU8mXUwMhBpTlDlZc7zYa0Z4n9NLhjKn3x0bF
	neWPBnhpWt1HF3io56bZ5Ai65jO3vDIsXeKVqs0+mqpcOzbmpbO6jBwgrImKMKOSNO4Wamd8=
X-Received: by 2002:a17:902:f68b:b0:294:fb47:b623 with SMTP id d9443c01a7336-2951a371247mr185632145ad.11.1762177404249;
        Mon, 03 Nov 2025 05:43:24 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFUFmas/gPYs6MgA1pgBHifU3EYpSRYgys79U7UBZ8GX2aiZyPKiMdMDx8bj/25LSMysjWBmQ==
X-Received: by 2002:a17:902:f68b:b0:294:fb47:b623 with SMTP id d9443c01a7336-2951a371247mr185631675ad.11.1762177403575;
        Mon, 03 Nov 2025 05:43:23 -0800 (PST)
Received: from [10.133.33.121] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-295268b5530sm122090725ad.40.2025.11.03.05.43.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Nov 2025 05:43:22 -0800 (PST)
Message-ID: <59e1e555-ae29-46a8-b247-a2d986a1d26f@oss.qualcomm.com>
Date: Mon, 3 Nov 2025 21:43:19 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mei: bus: Add newline to sysfs attribute outputs
To: Greg KH <gregkh@linuxfoundation.org>
Cc: alexander.usyskin@intel.com, arnd@arndb.de, linux-kernel@vger.kernel.org,
        zhongqiu.han@oss.qualcomm.com
References: <20251030123000.1701700-1-zhongqiu.han@oss.qualcomm.com>
 <2025103052-taking-shredding-c77a@gregkh>
 <83d8d2bb-767a-4dd6-8e1b-de96164cad4c@oss.qualcomm.com>
 <2025110319-activist-register-d119@gregkh>
Content-Language: en-US
From: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
In-Reply-To: <2025110319-activist-register-d119@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTAzMDEyNCBTYWx0ZWRfX15HnpOTZXXIG
 xaiZJbrOG3tXVp02+yDy+jvBlOCi6VX4PHCfjX1ol7tlXhw0tyrf96pI2qVdN3cLxJ1gVYnLXHq
 mHHlb0ahM0qpiimhPZr5K8euPjmRlPU2om53k3/JnJqb0phAtKaW8MrAtN0UNvQHcFlXCiuwfrJ
 28bg256RMiR/rjm7cMdFY4XEXV3NlEfZlci+seOdzB/YQ5nvkbDsN36nxLxCOz3vy46iYvKf4cF
 g/1EySyVx7x+vvJ0emsew66/XJi131tpaLm6ioBWKw1zHDzIb0YV06RV1qZh6fKBI98mxwjlFvT
 yk2Js6miNAA4OLK2CvUWaaFINmnWDk2XIkN4wTp6lMvy2rc3OcpIxOMAShMdWJPjCsuJHCGrJ1K
 +PeWB++QxMvUE4SInsGZZ9EaTwKa1w==
X-Authority-Analysis: v=2.4 cv=EszfbCcA c=1 sm=1 tr=0 ts=6908b17d cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=9JT2Vqw4ERehwdN-jP0A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-GUID: KG95nNeLK70qsmcHnkabCraNVqPAXw6V
X-Proofpoint-ORIG-GUID: KG95nNeLK70qsmcHnkabCraNVqPAXw6V
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-03_02,2025-11-03_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 priorityscore=1501 spamscore=0 phishscore=0
 malwarescore=0 lowpriorityscore=0 suspectscore=0 clxscore=1015
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2511030124

On 11/3/2025 8:25 AM, Greg KH wrote:
> On Thu, Oct 30, 2025 at 09:11:34PM +0800, Zhongqiu Han wrote:
>> On 10/30/2025 8:32 PM, Greg KH wrote:
>>> On Thu, Oct 30, 2025 at 08:30:00PM +0800, Zhongqiu Han wrote:
>>>> Append newline characters to sysfs_emit() outputs in func max_conn_show(),
>>>> fixed_show(), and vtag_show(). This aligns with common kernel conventions
>>>> and improves readability for userspace tools that expect
>>>> newline-terminated values.
>>>
>>> What userspace tool reads these values today?  Will this user/kernel api
>>> break them?  How was this tested?
>>>
>>> thanks,
>>>
>>> greg k-h
>>
>> Hi Greg,
>> Thanks for your review~
>>
>> Apologies for the confusion in the commit message — there isn't
>> actually a userspace tool that depends on the newline in this case. I
>> just made the change to follow common sysfs formatting practices and
>> improve consistency.
> 
> That's fine, but please work with the people that wrote the tools that
> depend on these files today to verify it will not break anything, and
> then resubmit the patch with that information in the changelog.
> 
> thanks,
> 
> greg k-h

Hi Greg,

Thank you for your feedback. I’m happy to work on this, but I’m
currently not aware of any userspace tools that depend on these sysfs
interfaces, so I can’t confirm the impact right now. I will check and
monitor it and make sure to verify before next resubmitting.


-- 
Thx and BRs,
Zhongqiu Han

