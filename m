Return-Path: <linux-kernel+bounces-835490-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B70EBA7477
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Sep 2025 18:01:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BDCFD179FD9
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Sep 2025 16:01:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49A081F3BA4;
	Sun, 28 Sep 2025 16:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="kHQMOjAt"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF25E1B4236
	for <linux-kernel@vger.kernel.org>; Sun, 28 Sep 2025 16:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759075277; cv=none; b=phDXWNT1sWwqPEYCm8MmxH5aDcxFWZOQqMksqYOg/eWPwQ5MWwP6ZETImhSIhPtSynehZQ3LXa3RT0AjyVaJyBSdsb0yVF6UXV/w1ga70ygdexkFzi9BAUlv8gGhhCTalTRd3lnpoDx8HHJASoqFtX0zHdMeqQYBvn4G38GClIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759075277; c=relaxed/simple;
	bh=EDXvLQhW1MM4RBJJnzx+FgQ0g75nmeKR9tV0uzGD5o0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PYfuhQxSBasDAsj0qPWJhrOfrLOf30ZW+c/Cifo1EBA21yAF84RxuAFugb2mxlWigVkEy9+6kzIDnkLKamp0NnGEz4MIVlwhbl0TDr4BBrfoswQMnAXEa+hzcWWnJoBq4knai/xpjSW9yYNJnMi8Ozbjrska32Tmt/WG5dDGo1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=kHQMOjAt; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58S4PDBI029004
	for <linux-kernel@vger.kernel.org>; Sun, 28 Sep 2025 16:01:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	cPFVpHWsZToVkjvByN8+NS0wTPCw0JUGnzSj+xr+rBc=; b=kHQMOjAt18xVyxOZ
	Gx0lnuqw/oQviTlDkFSmNPUNaSCs2b6RG3JLGtfnQOdI6UHNGdcS6BCJOYgoAhlq
	MhjsfZCZJsw+SAbucEoNdAls4Qvjl4j/a/XbbpQbgLmn4d8zXY7GcUKEavklstNt
	hDxzje0IKWnDSUxLs04YX6mncsUcqdCVl0fGA0W3DitbLH00E4zZm6anmLEEMCTt
	OOqvBM3uCDqCo95O7Q00J+9VtmoTViL6pqirZjIC24CeLNmyYVyLhvbXeJrajPKK
	Gk25qJKuc+C0op4E4BhXGDCYTEAJJ5EFPh9wEadmz1kHa0FsZVEZcXxsTkBqnyR+
	eE/KMA==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49e6x5k0wu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Sun, 28 Sep 2025 16:01:13 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2699ebc0319so38878125ad.3
        for <linux-kernel@vger.kernel.org>; Sun, 28 Sep 2025 09:01:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759075272; x=1759680072;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cPFVpHWsZToVkjvByN8+NS0wTPCw0JUGnzSj+xr+rBc=;
        b=rn7iVjqr4ybXXfDJYggDtYBItIXu9XnBwHOWzFmIGx/3SCbOU4tPzYWhSNAxUgwsx/
         Coojqxb4MVC2ntyC6eeu9y9wtkA4UD2o+crjKH397B2w0bDdVB+yYSzYLAwpaB4Qjw4/
         ew5TWG5eZ8adzyt1sfywsYsJb1T4mAVk7nh+jN1hT+tw+BQJTPYlEL04h4mlrvRIA7M9
         0aVm7NInuy6zjrcq/CylYyWMIiutkj/LNQs7Nus2qlNUGx43IPAMTw/akwPczoaLT9Xd
         ugJEJXMQgjtA5Rp/oVQi/DE9lRsGZshIxucCJ5rBO7pCO3QIJ4MwOX5kGFrzfcPDlTmm
         87oQ==
X-Forwarded-Encrypted: i=1; AJvYcCVDpyI6m8Pv557S/657dSAu9OCXXPRJ8WSBOyYTkE0NUTbFbhQ1UJSXlUEkTjJXG31DJXm9RLw5smDKZeY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/6jXzvyWiI+y2iFyNrNBigbpWIRW5SvSQspKEBCpriDIGcU94
	6A+fXT+FcbV5s7k2d4oTK+zNNjnX99j7x833D6+z564yP9lX9VqX0mYI8n+PIqbbMN7SsaGknhT
	bmAgaoxQQ9ayDDLCH8XUMFlEMkg2cLfEzi9i7HoNwvrSK4wHj6WYerH1fywtGBKHIYGg=
X-Gm-Gg: ASbGncuJxBEJa+TwC471rYv+2nYZkNKChH11GKn9D1n248+r6/CszcgZrAufY6y6UU5
	AIV1uTSfdZIAna29i9eOLCxE80+F8a+z5qaKVsTlAEj/v8bW+P/8qSjJrbXtmcdotvvlKsoMauA
	o/XTpYbUCqYbHbhl3FziGojaxW/THdbUHGrJeiB1AZE4i7k2XdkVwc9Cdm0A1cXv5iCpkvS90+3
	VQyFZuhkRrBeLjK1imXKYkvTzt+IWdwSzDLPjuXBrV+Wb0fsqNjafy/nU5OYkOWlqxRo9NQ/3n7
	7z8pIE7xMIdweQDc3YSLrugoAVNwWsZ+Kktq2pu2ZJ9IPqLdfLvRuhdim6CGdUfeq8xBJA==
X-Received: by 2002:a17:902:da2d:b0:269:8fa3:c227 with SMTP id d9443c01a7336-27ed4a06e11mr127912565ad.8.1759075272314;
        Sun, 28 Sep 2025 09:01:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEKu+Mjlu4lZU0z3b0X20n3n0XWiHLgmlWPxFZKPAgl2BOGgx6FGTyHcwjgZgfLcJLNliYZPQ==
X-Received: by 2002:a17:902:da2d:b0:269:8fa3:c227 with SMTP id d9443c01a7336-27ed4a06e11mr127912335ad.8.1759075271816;
        Sun, 28 Sep 2025 09:01:11 -0700 (PDT)
Received: from [192.168.1.5] ([136.185.249.89])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-27ed68821a0sm106708625ad.85.2025.09.28.09.01.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 28 Sep 2025 09:01:11 -0700 (PDT)
Message-ID: <a3b3f044-5a84-44e6-a2f1-0e590a9beed6@oss.qualcomm.com>
Date: Sun, 28 Sep 2025 21:31:05 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2] mm: swap: check for stable address space before
 operating on the VMA
To: Barry Song <21cnbao@gmail.com>, Chris Li <chrisl@kernel.org>
Cc: david@redhat.com, Liam.Howlett@oracle.com, lorenzo.stoakes@oracle.com,
        akpm@linux-foundation.org, shikemeng@huaweicloud.com,
        kasong@tencent.com, nphamcs@gmail.com, bhe@redhat.com,
        zhangpeng.00@bytedance.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20250924181138.1762750-1-charan.kalla@oss.qualcomm.com>
 <CACePvbW=-KZhU_qi4UUw7Pjbz4o=SQwHmQyEOkxhpMvdetbPCg@mail.gmail.com>
 <CAGsJ_4zhL=4qJDmGA5E-z7=VixkUXOi+qBnN3S-WWH2UbYj=ZA@mail.gmail.com>
Content-Language: en-US
From: Charan Teja Kalla <charan.kalla@oss.qualcomm.com>
In-Reply-To: <CAGsJ_4zhL=4qJDmGA5E-z7=VixkUXOi+qBnN3S-WWH2UbYj=ZA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: nbcgdenz6wvO1GzJcVAHB5dSDcg3BL2a
X-Proofpoint-ORIG-GUID: nbcgdenz6wvO1GzJcVAHB5dSDcg3BL2a
X-Authority-Analysis: v=2.4 cv=ZtPg6t7G c=1 sm=1 tr=0 ts=68d95bc9 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=FbHnbG6Tk0goxvMXmgMzoQ==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=9XW7_0HgatEhwW1_NykA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI3MDAxOCBTYWx0ZWRfXxfwhs5h/0I2e
 BYDLXICYwyj7KWp+GNBVv8XTKchW6x724oL1TeRrolps0Mx7+MdPOqddDUrMnEsyyLOPTP15PYs
 MbPvIqqE7VMruNWPfcSTLbGaJUixXAW9ObwLOrAkPnpUTQY+ejAkuPo4nLCVoqYFfKN/GD++Q0l
 73wTODWRsVx83ASwyOAHs7qPyI+PbuoBc/uxd3HxGFb/HzUHwNa+No8LkaCPSu/d1VnCIjtBdyx
 zBt9vdKcu/8orvXNfHGCTRtZ6h697rd8BlyoT/TSMLGONYUcJ3OnenB3SAWrUmjDlg9tyU7CafN
 WI31t5sJR3mVaK7BpwjQP2caWJ2yzu+gPftxwFFgrZ/2uhOFQOcLBIz0PjtFTvB80JQjOv51T4P
 TTgnrqmYi0LeIUXGWxRuh/atcct4Ow==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-28_06,2025-09-26_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 priorityscore=1501 malwarescore=0 bulkscore=0
 suspectscore=0 clxscore=1015 lowpriorityscore=0 adultscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2509270018

Thanks Barry/Chris for checking it.

On 9/26/2025 2:00 PM, Barry Song wrote:
>> 2)  __oom_reap_task_mm()
>> It holds the mmap read lock when setting the MMF_UNSTABLE as far as I can tell.
>> So checking the MMF_UNSTABLE with another __oom_reap_task_mm() does
>> not exclude each other.
>> This is more of a question for oom reaping.
>> Does MMF_UNSTABLE have the test vs set racing here? It seems this
>> check does not protect against  __oom_reap_task_mm(). I have no idea
>> if this race is triggerable. Just want someone else to double check if
>> my understanding is correct or not.
> I haven’t actually run the code.
> My guess is there’s a race when checking MMF_UNSTABLE against the
> OOM reaper. I think it’s fine either way—whether we skip an OOM-reaped
> mm upfront or take a middle path—since the OOM reaper will handle those
> PTEs with the PTL just like unuse_pte() does and eventually free the mm
> of the reaped process. It’s probably better to skip it early and avoid
> unnecessary unuse_pte() calls.
> 

I am sorry that I can't really see any stability issue b/n oom reaper 
and unuse_mm(), but yes that unnecessary unuse_pte() calls, as Barry 
mentioned, after reaping.

>> I can see this patch does protect the intended race in dup_mm() vs
>> unuse_mm(), it adds value.
> This also seems to add values for OOM-reaped processes to avoid a
> useless unuse(), in case we aren’t skipping this mm right now. I’m
> not sure if we’ve been skipping OOM-reaped processes elsewhere.
> 
I don't see any explicit flags that tells the process is already 
oom-reaped/under it. There is MMF_OOM_REAP_QUEUED, but this doesn't tell 
if it is already reaped.

If the unnecessary calls to unuse_vma() is really of a concern, then 
check the MMF_UNSTABLE while traversing VMA may be a solution but this 
looks ugly.

> Hi Charan, do you have any observations on this? If an additional value is
> added, could we record it in the changelog? Otherwise, can we add some
> description in the changelog to address Chris’ concern?
I do see that Chris ask can go as completely different change as the 
mentioned problem exist even before this change, please CMIW.

Thanks,
Charan

