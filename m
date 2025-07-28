Return-Path: <linux-kernel+bounces-747461-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 93481B1341B
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 07:22:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A16CA188D8AD
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 05:22:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C5DF21C166;
	Mon, 28 Jul 2025 05:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="B6GN/Shq"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6110B217733
	for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 05:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753680127; cv=none; b=EkAWH8/EpDVbk5kC3f4Nvt3aIzN5VqfdOrDeODYQ4IO1GqXSqEoQeJosah6IXtqOzoqVoSa4fiNf47MCn5CQdx8Ze7R95Lp4ApcoG4QY9NdaMGKNMapqjqPN+DOHezzJ9lWXxBbHwMOort2TFsf27bl8SXwqi0lo2geUR7nReFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753680127; c=relaxed/simple;
	bh=Zvvygo8cmThuzdFqssYldBEg/xvDHBhqBt2QHtqYmr4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=e7Ct059PDv5yCF2eH70+HjrRDklPvchxEKMk+Rp5MYeifj8PSvB/RGPGlK4QC0CID6PD8Y7arKtPZr3uiqICXsh+GplhCUQ9jx0bCntSMtkinIOGgwC2ELP7EBDzDUUsi86TDZvW6+5gqciZSuBwy/VrQ/k/WZs4giWWPaimW2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=B6GN/Shq; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56S4rVf9019678
	for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 05:22:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	0iashDcqdonuYgX5reL1ipejS0IkYuXFhOiQyjV1mw4=; b=B6GN/ShqMDW8YS49
	dsfiRGlnp4ieHIF5GnYp4Hz9wu8IslawzJ20AmThYYG1FuWS19F6B43NgY7Mp6Pi
	18ZEEf389Ga1O9p0mSKeWNPW0uw++He/5tIkVTLHwqZx/EhjRSE0nk7kQOhIEOKy
	bJpvhgAbHxf9lJwNTZdfAt/pYLf/fSb5ZZ/THKWAWwGleDm1a6e2hhGq4jYbqxp1
	k+TXJkyNq5Ueco4jGF9knL4II7GcZ9aXJE+iDwYVE3OFBCcZXLgIixK4NdqEbZRc
	kzranmJ6ay2LtqB8u52FSzO817Iz+ouWMV6APDDafa6S4OWw+QOXOi+DUVUNQskH
	zNFS0g==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 484r6qk6yn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 05:22:04 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-237e6963f70so68946315ad.2
        for <linux-kernel@vger.kernel.org>; Sun, 27 Jul 2025 22:22:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753680123; x=1754284923;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0iashDcqdonuYgX5reL1ipejS0IkYuXFhOiQyjV1mw4=;
        b=mFwDwJj/yVMGCSStfZHNUnD3ezXoXfu2DfhD6qIaBm814vi/DFhFlFxCNDivj9H90T
         Zhx/nfPQ1Z8+sw0QeeHwOoWpotmTSohC+0OU8vOZG9/IuEGqMWKEeRH8L8R+trz4O2tm
         NTAKZbOrMr3dJD3BFy/wLjkQfbhMEdFSmU9FFYzzAC86kaTCcVxQCTFkfdO8GfZlmEDP
         pj3NjErRr9Tbm0dAroQVWqf8eAYzPnrk0zITImDc5ClOh/voqXycukDess+8uh2lu/k7
         QzLJ7E+CbYn8scjXa/+3cNRsS/nZnw6jXRTe7kClZhApm+BMjaliRiR6KUiYF3CtGGsc
         VFjA==
X-Forwarded-Encrypted: i=1; AJvYcCV7mK1wkt2gS4RN8GZxL7F9R2oC5gPncbMkZDduOzdhqn+Y06sR6jUr/JoZw1XrK5/NMKtQQ81UVQArNcY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzzrX6/LVLpEcAjkgM611XpEsh1ZwPG+iYSH9uTzfzjpsWnIknH
	ac2QnIiQTAgzHvjiEcg8PaIvZIXrJ/iwQJ+oTyFTgbyWUpmurorhfPM7t7AHFWcmtaHk1frM9VD
	nZ4pggHma9updmuMJ43bSvp3dpKiDaQhK4NDgxmsqXHPIARSw44mv4lbXCc9dv39MKnE=
X-Gm-Gg: ASbGncuTr1j1VhVH8cOt7iJmzsKoAV3eqQ+fspCLlMvHw6zK2Ca5FFJ1lcugldV4Krv
	RsOlwtMeOFE3PQsTcI6wEm8dR8Casx/smDdNYRm7S5zw8B5rZe4H/697Cd1RP4X2FbYvmgD7Vzd
	2rQumQSfhsDrdQTp4iYYXMieGQ65ffQe3qKSkn8U9njpXVZ6om1ui63hseEYT097wrZ3NKk8Viq
	HF8Nf2iHhUuTkKTwhtRSKnN1sw7v4qRUCTg5azUqADysY0BUxpxrgX9AfeEUTWTZ4mFoyDwmRO1
	Wtl4V357Pp5rQ7JbOfkct3W7P1dHurKH4cp4v3Z3DH9S/2VGKJdPi3QgIXovYCvEEPKh
X-Received: by 2002:a17:902:dac5:b0:240:aba:fe3b with SMTP id d9443c01a7336-2400abb2552mr49797625ad.16.1753680123574;
        Sun, 27 Jul 2025 22:22:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF4i7EeJSuO1D44ijkfE6ZA/xsHWXErw8REmKW3YdUqmY+1Q7QDXpvC4Qxp+5wiVjvcbcLZQw==
X-Received: by 2002:a17:902:dac5:b0:240:aba:fe3b with SMTP id d9443c01a7336-2400abb2552mr49797385ad.16.1753680123123;
        Sun, 27 Jul 2025 22:22:03 -0700 (PDT)
Received: from [10.218.10.142] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24009e53876sm21357455ad.2.2025.07.27.22.22.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 27 Jul 2025 22:22:02 -0700 (PDT)
Message-ID: <6159dcff-f6cf-416f-9573-d8753ed58a6c@oss.qualcomm.com>
Date: Mon, 28 Jul 2025 10:51:59 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] usb: dwc3: qcom: Add shutdown handler
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>,
        Krishna Kurapati <krishna.kurapati@oss.qualcomm.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250725062158.2418961-1-prashanth.k@oss.qualcomm.com>
 <2025072542-bleep-parting-3e7a@gregkh>
 <852ff03d-84cf-42f1-a428-ec747bea835e@oss.qualcomm.com>
 <2025072512-hertz-dentist-67dc@gregkh>
Content-Language: en-US
From: Prashanth K <prashanth.k@oss.qualcomm.com>
In-Reply-To: <2025072512-hertz-dentist-67dc@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI4MDAzNyBTYWx0ZWRfX/s0LImyusbFU
 zHfzAxLGMNYHy/OMVPLe7sdT11YZWMSET7EQFlpXWMUyyrBEIFOCKYjV2ZbItjX1ZON0uPeG6gf
 Ya40Fo0+YYOJt11AYJ7Nhou/jzu2lQix75tWwZPE0gNrYl+WtGOe4ahlIMseH7Q31/9rIFr3JEB
 YLPBUsVpWef8qzfUoTLF0Q2UEbgasbg18UVoThHvwk3mctRa6BpkbeXLps0NPqhe+Wx2Bp0efWe
 i6tnlN4USLWf7QH6zbYvcyB4lQ8CRCeH9mBGrFsN1+w/qtQW2kkSIXwsNLD7YP4BHoeriC038D3
 wbQ+L0E/DVtwojem7NU5cTtjeQavIVccfmgYEiWLExXzaVdK04rc25okM3FGxQoe6wU4Ec7Ifgk
 F+bqgfAYwkKt9O/qpXBnWtfYo8MUivK0MFlZjvdLPONFjKYj/p2QXlBe+dVLkWPg3Ri72aab
X-Proofpoint-ORIG-GUID: kFVacw_ojx-3_xron_7wnrMZ5YWcyo1q
X-Authority-Analysis: v=2.4 cv=ea89f6EH c=1 sm=1 tr=0 ts=688708fc cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=MBHFPv6fxAc3HuZYMuEA:9
 a=QEXdDO2ut3YA:10 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-GUID: kFVacw_ojx-3_xron_7wnrMZ5YWcyo1q
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-28_02,2025-07-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 priorityscore=1501 impostorscore=0 lowpriorityscore=0 phishscore=0
 malwarescore=0 suspectscore=0 bulkscore=0 adultscore=0 clxscore=1015
 spamscore=0 mlxlogscore=888 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507280037



On 7/25/2025 5:29 PM, Greg Kroah-Hartman wrote:
> On Fri, Jul 25, 2025 at 03:28:12PM +0530, Prashanth K wrote:
>>
>>
>> On 7/25/2025 2:18 PM, Greg Kroah-Hartman wrote:
>>> On Fri, Jul 25, 2025 at 11:51:58AM +0530, Prashanth K wrote:
>>>> Currently during system reboot, SMMU disables its translations
>>>> while devices like USB may still be actively using DMA buffers.
>>>> This can lead to NOC errors and system crashes due to invalid
>>>> memory access.
>>>>
>>>> Address this by adding a shutdown callback to dwc3-qcom, which
>>>> ensures proper teardown of UDC stack and prevents DWC3 controller
>>>> from accessing memory after SMMU translation is disabled. Reuse
>>>> the existing remove callback for this purpose.
>>>>
>>>> Signed-off-by: Prashanth K <prashanth.k@oss.qualcomm.com>
>>>> ---
>>>>  drivers/usb/dwc3/dwc3-qcom.c | 8 ++++++--
>>>>  1 file changed, 6 insertions(+), 2 deletions(-)
>>>
>>> What commit id does this fix?  Or is this just a new feature?
>>>
>>> thanks,
>>>
>>> greg k-h
>>
>> I didn't Fixes tag because a small dilemma. This patch is rebased on top
>> of the flattening series, specifically commit 1881a32fe14d ("usb: dwc3:
>> qcom: Transition to flattened model").
>> However, I don't think that this commit caused this issue.
>>
>> Let me know if you want the Fixes tag.
> 
> If you don't need/want this backported to any stable tree, then leave it
> as-is.  Your choice.
> 

Lets not take it to stable now, because it will cause conflicts.
If we encounter any issue in future, we can manually resolve the
conflict and backport to stable.

Regards,
Prashanth K

