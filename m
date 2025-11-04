Return-Path: <linux-kernel+bounces-885163-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2286EC32260
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 17:53:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5FAEC18930BF
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 16:54:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14C10337BA3;
	Tue,  4 Nov 2025 16:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="g9eRI008";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Q2fSv7xh"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E222E33343D
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 16:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762275212; cv=none; b=MYrsGOCXoscHChitmO2EA8Ipugr79lszT4YhYUfFylKstm0X86gpLXiZqHXOTSw8cQQAtXcGJ0mwd74J1hBFJe46ZPY1b0flDZBB2Dxba28kq9XN2SHjBbuk8MjD+wEEr9qsvbnpHrr7w6N0esIdETLZopaWT+w9d1Dw83kmg3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762275212; c=relaxed/simple;
	bh=7P7W731zeNvxsQqEWXDnrHlI5KkVRc5xJVwTpnzTHCE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rLNwufgaI8APFmdlpAE4U/gl3GBveTld9DADoDOcv3v9nIQFsia4aJnqqq8rqWIp9KpKQ/ES3G0rppdl0/rNVu/dsnRTsqlH+vkRlCRUEJT1IavHenMcUbSDNmLtZQ4rOFblbWxvVOduPEYDycVK08xRrxReg++L3lMv6lk/mf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=g9eRI008; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Q2fSv7xh; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A4Gg9Re2482705
	for <linux-kernel@vger.kernel.org>; Tue, 4 Nov 2025 16:53:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	R+O3Oa1E8J1GUWFxBhezCIckqOm9wrjtwYcxUezuXF0=; b=g9eRI008jL4pPcOE
	+46sWq0PdagmgdVM9YjFa+cqeq/LIPFKqs/Kz5Nr3yFGW5YteUwtQ+cPdaeibsAF
	MAjpSC9C+BS0vVDp4rfCzLQ5HHkcIT/RNDQugcdPR2R8i4cQOMANnm2WlfPArnh9
	AcpO8b8zvqBDbp6BQ0ekadUFwvPnnCChB1oHc1EQHRlFolx1LF6f/Uk/cuMZeGcd
	SE7oRdrl63ICzzXcPtR+1yZwrJJoEjZeNQNxch3XGuoIkDro4vloWI98D6v6NFyM
	fDjIw8i13OQpF4BJ+uzqLQIHYNAIUTSb5wO/SdWBNZi07o5QeQQqrwekb4b/re6K
	Btp3tQ==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a7heagse4-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 04 Nov 2025 16:53:30 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-8b184fa3ffbso27438585a.3
        for <linux-kernel@vger.kernel.org>; Tue, 04 Nov 2025 08:53:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762275209; x=1762880009; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=R+O3Oa1E8J1GUWFxBhezCIckqOm9wrjtwYcxUezuXF0=;
        b=Q2fSv7xhdgE2nHrAX/FuRVq0vW1wVQHoZYA5mzXRrsl9xaokWb/kiZZ5vOzSqUt7V4
         PHQJNqZL6DtapGIa46s4FlZIKp2rN+rKX4HraBHixypABkHQA0gkOBgtS2bAQhgjzZZG
         NgWt5Jb+uymR/PSZru0RDFx+wvrljbwwQ/Un5BGa3++DPrfZfe+GCJ+tieaqtc2/6/r1
         DyYQxwT8/tyV6FlZbJvp82RWXDN34BvWnlwjTzTikYgLdAgXUGQD9njIEXyl3xEkf1mE
         Gmc3kuwHyKOSmtjiZuMw+m+EU1wGbQ9yvFloeE251E8VmGTHo80BI+wICPiAmb5PZlNO
         J1Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762275209; x=1762880009;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=R+O3Oa1E8J1GUWFxBhezCIckqOm9wrjtwYcxUezuXF0=;
        b=diPkIo4bbei5CY6jgYnd7TnXWMVqCzYAKHBSfc+8Ul1xjbfKvOH41EeeZQu/87KUn3
         BeF/D9xa0GT7MIm43uco65AIBMX1si2tM8j7wA0iz1cPyGa6kUuc8C5+T6hDLDa4BNUi
         OIHr4mHlxSGrBQb6XC5zXu2hnhV9/UrNk9Gc7UPQyBuO3KmDhMhmx/wFQ13JHqGYkxbZ
         5XNERyWDSfH7IGYBoM1l01BzZUHKwzplgTNhQFnpHE8uCkgzi7tCGh7T6VdiedfPZXF3
         3ftzr3t1ev8ySrWzTwDP681rYq5+VFflC3eRmSqeLUsFcJ8aKpPpglOXpOMEid2O8WbA
         f+Sg==
X-Forwarded-Encrypted: i=1; AJvYcCVJXufRznJ08BMd2Y3jjQIvV69P3Z95bEMYJSP+5KP20oXYrZX+5P8LrApHjnDngJgbC9WUgcyWttKaShk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwIWVK9PGPXd+0pluhBNxviC5PW2Qcl6x65R+ruPttZgJdCVlM4
	qZzi2Udfb0MCix7lseIZK6FON/ee2ebdg8pLGFCA2LUWLFNMtEe+++AJF+gkEduuBF/8k9FwRqr
	Q3LIEVFjDX2jXR1EYM9FGP5F0AGZU0dWOWB6XxLwXGw+07HIVKakKyGAY4V0ez/XjpdY=
X-Gm-Gg: ASbGncuKHzMGK9vRPpJ87ezy0XTywb8oNchUMYqeCb4itSYeYzE0AidOxvRB+0ej28V
	SRA9p9q96W6YGjXl5U7ZGm/E2IUah3Zc2LvFkAp+/QD82+WJIKGJB1J8Ax6sF9vpZ79fMoFlsF1
	SWXSMLpUmA/Sb39HIqaR2+nMXPc2wL4VDs8q7pT3feC+Spk+syZTOfI2Toj0ZH5XHBZ54YyQ1bI
	pcXdJenhaLYgGOHpqD8ZfnmLGix66Rqtm6dmFX8HRSQMZFRVNz94TCN0YYt4Iy3l5Q9qanHUXzG
	ufV3pHmKI6Llv8upH33nsN4/1wDCtcj3L8E+ZugPrv6LQzwkC+8E8CKXWuJdqpVBBU0O/BX3cVB
	b23qjFVMVleuMm/jUZwLk7KDdIklPtxgZz2sCk8HGGeJQgXeHQqF3pj3G
X-Received: by 2002:ac8:7dc5:0:b0:4b5:eaee:1c04 with SMTP id d75a77b69052e-4ed719178fbmr2058731cf.0.1762275209085;
        Tue, 04 Nov 2025 08:53:29 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEN2skvlMhiQhF0AzCAsR1RRCaYjN6hvzSRCOly3Dh32Qg2SQPxamGM3AJTpIbTuiUQBYBplg==
X-Received: by 2002:ac8:7dc5:0:b0:4b5:eaee:1c04 with SMTP id d75a77b69052e-4ed719178fbmr2058521cf.0.1762275208621;
        Tue, 04 Nov 2025 08:53:28 -0800 (PST)
Received: from [192.168.119.202] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-640e6a71559sm2413634a12.31.2025.11.04.08.53.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Nov 2025 08:53:28 -0800 (PST)
Message-ID: <89aae84a-f779-4b89-81ca-ab42a595d196@oss.qualcomm.com>
Date: Tue, 4 Nov 2025 17:53:26 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] arm64: dts: qcom: monaco-evk: Add firmware-name to
 QUPv3 nodes
To: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>, andersson@kernel.org,
        konradybcio@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
        conor+dt@kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: mukesh.savaliya@oss.qualcomm.com, anup.kulkarni@oss.qualcomm.com
References: <20250925042605.1388951-1-viken.dadhaniya@oss.qualcomm.com>
 <9b887bc5-eaa4-4271-8770-3458efb528bf@oss.qualcomm.com>
 <f016d47f-919c-2944-ab8f-68e450e5836a@oss.qualcomm.com>
 <be816a6d-c4e6-4cf1-b5dd-fd59515a42ef@oss.qualcomm.com>
 <f2ea3da2-4582-a2d7-9a90-8050b3e8a27f@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <f2ea3da2-4582-a2d7-9a90-8050b3e8a27f@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=GekaXAXL c=1 sm=1 tr=0 ts=690a2f8a cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=kXeBfYxH--zQBEzzCVoA:9
 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA0MDE0MSBTYWx0ZWRfX28uCDYx5/y/3
 euERrZzHEL3K+wq3dwXCY0kUqsJ39j/fxjW1nZ3pRZpPTuPYBEiIkp4tjrASTe7qit2jR0eAd+v
 W0+qO4T7legeAk3QK9LYx/fSND6BLUNNnv/McDYnWl0tOl1Bgi/i1Th3IdP1PKh+Wd3Q5wk3hfY
 WRKSYyZvztQVdAIMUnKYS4hp1yAAdTaUSH0n+cRwJ1AtOpswtGFS5iYtu83KXQP1guiKOXJgann
 jdakSQGNJ5APC+sK56qFE0eglRnUyjh40n8sHsm0DtJxMUs7WEWO2uZoh4ch1yNZmIKfDrUgu0E
 yrdaPeTxDMR2agc4pMa2F0y60UEHMj/gnEhz0RfJbZOJ1jPQvr9+qFAJ+JwYH+fi9kg0taRuI4C
 /nbS9qu811/p4HaflB6grJpMIPGEGA==
X-Proofpoint-GUID: 2lb4TyyqZLXAgF80JkBz1S7vZexT2tQ2
X-Proofpoint-ORIG-GUID: 2lb4TyyqZLXAgF80JkBz1S7vZexT2tQ2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-04_02,2025-11-03_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 adultscore=0 spamscore=0 malwarescore=0
 phishscore=0 priorityscore=1501 suspectscore=0 clxscore=1015 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511040141

On 10/24/25 1:37 PM, Viken Dadhaniya wrote:
> 
> 
> On 10/22/2025 10:30 PM, Konrad Dybcio wrote:
>> On 9/26/25 8:43 AM, Viken Dadhaniya wrote:
>>>
>>>
>>> On 9/25/2025 2:22 PM, Konrad Dybcio wrote:
>>>> On 9/25/25 6:26 AM, Viken Dadhaniya wrote:
>>>>> Traditionally, firmware loading for Serial Engines (SE) in the QUP hardware
>>>>> of Qualcomm SoCs has been managed by TrustZone (TZ). While this approach
>>>>> ensures secure SE assignment and access control, it limits flexibility for
>>>>> developers who need to enable various protocols on different SEs.
>>>>>
>>>>> Add the firmware-name property to QUPv3 nodes in the device tree to enable
>>>>> firmware loading from the Linux environment. Handle SE assignments and
>>>>> access control permissions directly within Linux, removing the dependency
>>>>> on TrustZone.
>>>>>
>>>>> Signed-off-by: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
>>>>> ---
>>>>
>>>> Viken, you've posted a lot of patches like these lately for
>>>> specific boards.
>>>>
>>>> Should we instead push this to the SoC DTSI, to limit the boilerplate?
>>>
>>> The firmware load from Linux feature is applicable only to devkit boards
>>> (RB3 Gen2 and EVK), and therefore, it is being added exclusively to the
>>> board-specific device tree files.
>>
>> Do we expect GENI_SE_INVALID_PROTO to ever show up on hardware that
>> can't make use of fw loading though?
> 
> If TZ (TrustZone) does not load firmware for any SE, the SE protocol status will
> remain GENI_SE_INVALID_PROTO. In such cases, Linux can load the firmware to
> initialize the SE and set the required protocol.

So.. where is the problem?

Konrad

