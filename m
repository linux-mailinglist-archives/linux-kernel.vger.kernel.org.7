Return-Path: <linux-kernel+bounces-857061-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2484EBE5CB8
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 01:29:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 075BB4E7AA0
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 23:29:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E616D2E1F08;
	Thu, 16 Oct 2025 23:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Wn0ylk4L"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE08523C4E0
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 23:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760657331; cv=none; b=cZTGltK8YEjWHAeCWtqW/8oqIq1z2B5/n5bFjauTysTnEp8W/JdZXUVZNKjxxVrVQqgrveijDLGAAEo8Vw/OGDFH1oaWOg2wCXKbT91+xFEUMA9K068ODDvrDdmlpmDI6V884qeNNgvO2kH4s62zlFV8oRzWd9T+XowM3XJEyu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760657331; c=relaxed/simple;
	bh=rlxaqT8IZi7KLirboMOLoCUue9uOBkoS1ATRvMw3124=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=i8PAjNoHkNNYTvS6G8t+8DKIXMWfhw6Mcb4f9Dr48ghOQSYrQNPTyrepNNptU+HPn2rTVairvsRnRjnnl+N3PQjQS0temNLZYPB00Go2OdKZ41yWB5cCTi3A4lh0j2r/JG8GDgJ8zpwcIeFLjO+nM0y0K8YMf576nN9ChwQZbzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Wn0ylk4L; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59GKLM1w001686
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 23:28:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	RX63coALBF5N8Qboq9T43pP2xBguL49cxoQ5B66uUGw=; b=Wn0ylk4L0yHcTEw3
	hSsSZgRBCk7b0eVs7kla4J1QEZxdQzZCVyRbchPhwLMPfuo/XgKno9QUm80REGMG
	tXbOVy4R2/AKIiUvm/vgxVF7hNy2EVmkSsOE63jcRpchmzE3rMTIFImS7KVq7DIq
	kmfZjALBfHIYuYZYVzLVT2jifl4okqHm/tl4ydFN/ntqPRP/fcXsH7oYPNs7JAkz
	0lF7oAGu3fQDcgD0EeT3UdRh3Dx1OfD9tehiLYShpfK5Y+22OESV4rCz4SniI/al
	fDhJFfoflNwNglaa5JTImU4P4f/nFEmoMIioGzGJOKlJ+AH4pho2bf/4OzzT8Yd0
	bkKivA==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49qfd9a8fs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 23:28:49 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-3324538ceb0so2308921a91.1
        for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 16:28:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760657328; x=1761262128;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RX63coALBF5N8Qboq9T43pP2xBguL49cxoQ5B66uUGw=;
        b=wHDgjCJa1b5rn2epBeLEe9adrFmjvhmyN00jzkZBTJE+jF5E3RnJ5wmD68I2I9Bih8
         8gSyRxGLjaB3RIExoyMutBu8PmwOBPCJbmJqVRRRb5R+aHlspvykn07/Cih48hGXL4zR
         2z55Se+CfeWsAksFgv4pzuncoCsRl+EOhq7IfasMBdSuEurf59RxP4qpzlsQUwSgxpKF
         +e5s/U0Zf37mFphwm3oFIzO4fBkieBt4N1qUrrX8x73E6bMbhcW29hqt8m5mluMIGrZa
         TVj4rGA+muCRsezPo6Mt0BVRf2GGIc8J/FYmZk7/yQcYlbYVqO14qTkKQclTQYogOBcB
         tAOQ==
X-Forwarded-Encrypted: i=1; AJvYcCUqQg9kDldqvhWT4pHSfbBd69Hf4uudzgo0oIjioS/q8RHBErM4OtV17iFBOFdb7I1t4s+fYyM1XtqBslQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxzsUGYZzAcfpBCPVpsbnMiuDPc5IQOFW1LExys/j3+xTThzqY+
	j3lmJAxBTxv2q3MfQIOOvM5AMT+IM39F+bNGTtMkFmv8W7KkjQTainIrH13tf/kwqYEaaOz2I72
	pP2mF8JLVANJTuBpcqJmGHoRD3Nscq07tknk9YxDeUFaE0zW4KchmyTD1wXpTh7vPB14=
X-Gm-Gg: ASbGncv03hj3pQ9bOuBFQMBfJ8ZuHea+Y79LPihJ8T2q3O+YSsg/g1Jw1h2y+EDdADq
	fTbsS7VtYZVQLr1kpAUh0Wfz9WcuQIzUGWAi2nSpuLeL194hOisvCGp6MJZRdRlKo2F2r8IUVfx
	wqLzws5Qok/yZd1i6dS0lNnXoz8Ip0peRiJTMyyW7ELRddohY8AuyAmUQ4y6oX8m1IWAcArizlg
	Tdga7GgORnB6nPq3up94yeOsORZpdyXndQB/PsfHej1giekio9qCltdFqsmVtKmBHXLvZqSLD0L
	AvbGXdTT0gOU3YYfeQfmuhfteuItS70HSbBuqRgU+coGAXCYpEv8TTQA7L8tQ1dMkjckQ3p9VYO
	/3+uUp7G3DLFYSjmHTwKai468bSZVmLy3jEY4qgoGGSDqS7i+Lg8afQ==
X-Received: by 2002:a17:90b:2b4b:b0:335:28ee:eebe with SMTP id 98e67ed59e1d1-33bcf908bc8mr1568418a91.30.1760657328177;
        Thu, 16 Oct 2025 16:28:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFdlkJr++vWqphZc58l1HehQD9BXRaRbHvW5CoQYUc4yrWbI39Sys1IV5VOEPFpE87k3sOOng==
X-Received: by 2002:a17:90b:2b4b:b0:335:28ee:eebe with SMTP id 98e67ed59e1d1-33bcf908bc8mr1568392a91.30.1760657327731;
        Thu, 16 Oct 2025 16:28:47 -0700 (PDT)
Received: from [10.62.37.19] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33bcfc12fa0sm359020a91.13.2025.10.16.16.28.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Oct 2025 16:28:47 -0700 (PDT)
Message-ID: <662a21a3-de8b-406f-a15d-b8a572aa79ab@oss.qualcomm.com>
Date: Thu, 16 Oct 2025 16:28:45 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 6/6] media: qcom: camss: vfe: Add support for VFE 1080
To: Bryan O'Donoghue <bod@kernel.org>,
        Hangxiang Ma <hangxiang.ma@oss.qualcomm.com>,
        Loic Poulain <loic.poulain@oss.qualcomm.com>,
        Robert Foss
 <rfoss@kernel.org>, Andi Shyti <andi.shyti@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Todor Tomov <todor.too@gmail.com>,
        Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: linux-i2c@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, aiqun.yu@oss.qualcomm.com,
        tingwei.zhang@oss.qualcomm.com, trilok.soni@oss.qualcomm.com,
        yijie.yang@oss.qualcomm.com,
        Jingyi Wang <jingyi.wang@oss.qualcomm.com>,
        Atiya Kailany <atiya.kailany@oss.qualcomm.com>
References: <20251014-add-support-for-camss-on-kaanapali-v2-0-f5745ba2dff9@oss.qualcomm.com>
 <20251014-add-support-for-camss-on-kaanapali-v2-6-f5745ba2dff9@oss.qualcomm.com>
 <8d61f29b-ba02-4757-b8cd-5fb51b998acb@kernel.org>
 <FA4lDfkvC1Bdn7xJsoLXyWUEackUIfrSW4vn_6Q5YA5pDcNJ0QZ8EeU0CuEqKQuzdnYLC-AIvy9RhoY2ba5sbQ==@protonmail.internalid>
 <1aa133b9-2a99-47cb-8309-7e49b5dc4f85@oss.qualcomm.com>
 <f5df1c29-a1cd-4cc7-8ac4-b4aefc4225b0@kernel.org>
Content-Language: en-US
From: Vijay Kumar Tumati <vijay.tumati@oss.qualcomm.com>
In-Reply-To: <f5df1c29-a1cd-4cc7-8ac4-b4aefc4225b0@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: xJrwjOdOVWWrfRVF50xolKKaLgjTJ70p
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAxOCBTYWx0ZWRfX6tT2Dv5fT5j8
 oz9YRKrdSV1yOepRBFYbO6sv0dzkPfrRGhLJUBHAHmQoAYVT0lCNCbOKbol5TfYMceCre4APaIU
 tColo1a3BQi7wqyTdvYIyrgmbI1XTCddf4pEoLlUL9+aJLj5EnT6QEYnSG+wOAbQNVYQevbnnlA
 VPe4QnCMeWckO79oubzEmacCp//OAE+LEIrmkxmhqWctytJgdFzLYGHkchTmtOcNhv7TZrTzm8O
 PjU5tBG/W35BvH1hOY+wpcRnwTye+OeTYVAWazC/++fEdm5b94cj9RrqtA8dkemuHqGdOS8Vh6Z
 QSoOJRO5AhIp/MURxKR2d4HLbx4RE8SKjU90qKuCncDzhj2oG72IBI9+Bo5syOe5DlhLG54oKWr
 m5Qr8kUIMQ1ZhIgaIyVFmVOc7LuGyw==
X-Proofpoint-GUID: xJrwjOdOVWWrfRVF50xolKKaLgjTJ70p
X-Authority-Analysis: v=2.4 cv=PdTyRyhd c=1 sm=1 tr=0 ts=68f17fb1 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=blchzdlE1R3GHN3_IVwA:9 a=QEXdDO2ut3YA:10 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-16_04,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 bulkscore=0 clxscore=1015 adultscore=0
 lowpriorityscore=0 impostorscore=0 priorityscore=1501 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510020000
 definitions=main-2510110018


On 10/16/2025 3:54 AM, Bryan O'Donoghue wrote:
> On 16/10/2025 11:33, Hangxiang Ma wrote:
>>> But why ?
>>>
>>> ---
>>> bod
>> That a story. When testing the RDI path on Kaanapali, we found one image
>> buffer starved at 19/20 stage. We want to capture 20 images but only 19
>> received.
>>
>> On Kaanapali, the AUP and RUP are split into two separate registers not
>> a single one. Maybe this hardware change impacts something. Calling
>> ops->reg_update() in vfe_enable_output_v2 function only applies one
>> buffer address. The downstream code defers AUP and RUP to CSID
>> configuration stage. We mimic that and find it can solve this issue.
>>
>> ---
>> Hangxiang
>
> So this is the type of interesting detail that I'd go looking for in a 
> commit log, a comment in the code or a footnote in the cover letter.
>
> One or two sentences in the commit log will do.
>
> ---
> bod
>
@Bryan, let me throw a bit more light here. I don't think the 19/20 
buffers issue or the AUP-RUP register separation has anything to do 
about this (at least not the first for sure). Fundamentally, on 
Kaanapali architecture (or any architecture for that matter), the HW 
guidance is to issue the reg_update (corresponding register write) after 
all of the CSID configuration registers are written. It had always been 
working for other chip sets to write to this register first and then 
write the CSID registers but Kaanapali seems to have very strict 
dependency in the hardware about this sequence and with the original 
sequence, no RUP DONE or BUF DONE events are received at all. Hence the 
need for this change. The 19/20 buffer issue that Hangxiang mentioned 
about is a follow up of this where we enqueue two buffers to the RDI 
write master from 'vfe_enable_output_v2()' but issue only one AUP update 
after the CSID config. That was when we needed to add 
'CAMSS_INIT_BUF_COUNT' and use consistently at both places. Hope this 
makes sense now. Please let us know if you have any questions still. 
Thank you.

