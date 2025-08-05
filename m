Return-Path: <linux-kernel+bounces-756462-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EE70B1B4AE
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 15:17:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9CD1A18A51EE
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 13:17:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5493E27510B;
	Tue,  5 Aug 2025 13:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="j9AJgxDb"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14C51256C84
	for <linux-kernel@vger.kernel.org>; Tue,  5 Aug 2025 13:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754399801; cv=none; b=m28VZIQmzEaljzAIWFt5PJi70CbaJm4ojyt6eqvPFD/0bH6T6B0KVnDv3TcqOH247FpKwZkHoS3J7cx9EMom5r1W+MzJ/13OloU6uT8Aj0rtmtOSjA1DNeUaF/g2Q61v/RlT1FbJVyEC6F2uQa51IP1QQTIAPMLZL9hV++QwtWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754399801; c=relaxed/simple;
	bh=xwxYSJqAOa2dswhRs3rVOJaTQiy6qaWgv8qoNhn4d4Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hX4n4TmYWyAMnZyfllnOZUG+TOqlmjYzUY4seZnQKExBM/UFMHfT5BnKyscxwcO7DIifGYFfORp9J5XprNQRsMQfvb4TNc0y4VFF9RPmYNQrn6hLxSSspm3KQ+ezjJYEKVyDbLQ318Jyfl+SCr5HbcB0eU6HzLKPjGMgVRZUgw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=j9AJgxDb; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57578M7T027684
	for <linux-kernel@vger.kernel.org>; Tue, 5 Aug 2025 13:16:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	vDcLe8zKX/SB4BPYrNHm0fL4uBKyff9MiXQwR+5hmYs=; b=j9AJgxDbOt8KR/kn
	4TnRGrzlbv1hj1bSUBbhlMx4T80D+YTEM1lBw14OaV7tShTMOdUIGKwKkQ9+/moc
	5EVnjH+uSK4C5TDnDDWNtF7BdMSVNIIWSSc3STulfHN4ufMS4tOR1AzphnHin9yZ
	NJ196Xkaq80gc9lkuvK2/lQkmUd+/gEZ6rcmdAX3H4BHbJIFR+kF65t1zTI5TV9e
	eqDlsUdzHxtAwsus2SLCxzvRUoGhbRDzEhDJCw7QnvS2kllNgC3XS+ESqKqiUGt2
	evjtxWfJwWa4UTH9ikQdAWGyUduIh6GdECLfH1DTDqDwxVj2qizjenCZaKT8PIeV
	gZaA3w==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48bd9w905j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 05 Aug 2025 13:16:39 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-7e7f74bb018so39484385a.0
        for <linux-kernel@vger.kernel.org>; Tue, 05 Aug 2025 06:16:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754399798; x=1755004598;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vDcLe8zKX/SB4BPYrNHm0fL4uBKyff9MiXQwR+5hmYs=;
        b=JTp0Rnwp7jbf707Ygo8oMrQQJ90SF2Cf3UVi8WHIYd3BG/2ucxoc5umPxy5GE7q+UC
         jsJQ1UiNZZpxdpG1HSoFzOYu2pXve+VBTi/gLymLoonPNRtwlA5m2qPQoTesbcrz9V16
         pjdgcEe8iOXvsM9bT5Y0e3nY1uqybqdQcSnHAsRhEEhUZ3rw/bmkAbo9AzjcUZ3MO6dS
         nPUB0jxKE2GRs9uzYkt3OhwAo92CMpb/BmVwJxvp3DeFG8m06w8tOMh2OsD0fPKNLDhx
         pL1+C8cuU+3rPQW6CpdToczwQwA1dCNZeteutZx+/tgSoWUeXvaNwLeU/8UC8C721Ieq
         Z3tA==
X-Forwarded-Encrypted: i=1; AJvYcCXQazN32V/h1GIQ8vXpPk0LZs9qeB0WFmGpqY0BC0UcHZ0Hnzycdg0vuuwhOBEGYn7JMwu50mITK5Hx7fY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbRGv15+gu4gBh3NbLaL6dk6Bt5FJ5a2gE8MJJZ1MRCPCCTW/N
	/GQKv+S/oVoxFQsdfwAglcbSWmvh3iBgwuhVTZBAIDyAJRoL3+clM/wbtKAleDGsR6NtAaHmlY2
	0Pl1Fx9e5HLlLlGIJycCWqGqiFLbRUVgTDp8oBjVmGgsjomB8ogoX6miORKemYgpoUGI=
X-Gm-Gg: ASbGnctc4vGGh4mI7zF49FDEqQt4PXnCS9MVhG9lIOyS6vDsNmNDsmTtsUVADIxfONY
	BGYEfVPtOgAMp6QCdhQGSLwcsUSGsv1jtXHBM29gNic/9mmkwVRTNCtlHZu0RSQs9NALhbVxNFS
	S2xVeC512lfDj8fI/1kodcydui8uTxqV9wz+7xADGiGT+q7ZeW1bQHW7jiS7r8gETfS3tmPplET
	/vgO6NOiHkpULUKQgH8+tGa6DCVxEoG7r1f9aIMdvtCLU5GMkxCTwMMd6Q3qxpwURJEfFrbx5aa
	iS1hg/lHMx2QCI+0+1cd+5R33mfNWuqJ0PZvjSps6JmL1suTcvyJtBnEOmGkOnU3jwDh2MxSnbf
	eh/3pU/nqAAvB9R3SAw==
X-Received: by 2002:a05:620a:3910:b0:7e3:3c61:564a with SMTP id af79cd13be357-7e69637b772mr1033215885a.13.1754399797708;
        Tue, 05 Aug 2025 06:16:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF2hUPem8LiGES/LWflDOyfSDfPc6bjk/5uUNypoybLkeo6W/T1Jtee8ToW21iWhAqLFav1wQ==
X-Received: by 2002:a05:620a:3910:b0:7e3:3c61:564a with SMTP id af79cd13be357-7e69637b772mr1033210685a.13.1754399797084;
        Tue, 05 Aug 2025 06:16:37 -0700 (PDT)
Received: from [192.168.43.16] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-615a8f2d554sm8310553a12.27.2025.08.05.06.16.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Aug 2025 06:16:36 -0700 (PDT)
Message-ID: <11ea828a-6d35-4ac6-a207-0284870c28fc@oss.qualcomm.com>
Date: Tue, 5 Aug 2025 15:16:33 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] arm64: dts: qcom: sa8155: Add gear and rate limit
 properties to UFS
To: Manivannan Sadhasivam <mani@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>
Cc: Ram Kumar Dwivedi <quic_rdwivedi@quicinc.com>, alim.akhtar@samsung.com,
        avri.altman@wdc.com, bvanassche@acm.org, robh@kernel.org,
        krzk+dt@kernel.org, conor+dt@kernel.org, andersson@kernel.org,
        konradybcio@kernel.org, James.Bottomley@hansenpartnership.com,
        martin.petersen@oracle.com, agross@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-scsi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250722161103.3938-1-quic_rdwivedi@quicinc.com>
 <20250722161103.3938-3-quic_rdwivedi@quicinc.com>
 <2a3c8867-7745-4f0a-8618-0f0f1bea1d14@kernel.org>
 <jpawj3pob2qqa47qgxcuyabiva3ync7zxnybrazqnfx3vbbevs@sgbegaucevzx>
 <fa1847e3-7dab-45d0-8c1c-0aca1e365a2a@quicinc.com>
 <1701ec08-21bc-45b8-90bc-1cd64401abd8@kernel.org>
 <2nm7xurqgzrnffustrsmswy2rbug6geadaho42qlb7tr2jirlr@uw5gaery445y>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <2nm7xurqgzrnffustrsmswy2rbug6geadaho42qlb7tr2jirlr@uw5gaery445y>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=NN7V+16g c=1 sm=1 tr=0 ts=68920437 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=n5nAzIlM4DwaeDdO57oA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-GUID: sK6Q7aQFFXD1UjJcjGYRgyIn6k1Zkr-M
X-Proofpoint-ORIG-GUID: sK6Q7aQFFXD1UjJcjGYRgyIn6k1Zkr-M
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA1MDA5NSBTYWx0ZWRfX5WPsoSVuU4EC
 ZpGGuNrjZb4p9EPDC9ujQ0Ji97RQHUodDie4s1TiO7M0n7dk+7PiDePDQfJfG8q/TUxn6OrTMyf
 Cxgjq7AbrRYrD2jn3GXMp41lVJeKk36xc2NixIIoLG74965Ye4Cc/JU4YsOCwsE/ZKjyYubyyh2
 YjD+rpd3NqPuwsVVHB1RIi5Uj23OiE3u1h5iEub4utb468Krfb5SrhsvLDnDH3R+fXHIma504pQ
 KqCno2sL+zVcVURHlvBi2LNWqCuF9HmH7vG8ivdVmoMHPy7oCQMRPJkPmGSeV69bENIULmVGtrV
 WYlvcFmn5l1NJZjFNyJMbgumVMhZvlgP+CQDtwhxVrTqVprUdEDY+3bclj/GiWbBw+FViL+xru0
 kMoUH7qMipjgZaxqKHDiDsSTd5lPF/YTHyfyFZNY52MIZbK4nJh3WqmJ5rxYIa95P50ERGtT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-05_03,2025-08-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 adultscore=0 clxscore=1015 spamscore=0
 phishscore=0 priorityscore=1501 mlxscore=0 suspectscore=0 mlxlogscore=999
 bulkscore=0 malwarescore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2508050095

On 8/1/25 2:19 PM, Manivannan Sadhasivam wrote:
> On Fri, Aug 01, 2025 at 11:12:42AM GMT, Krzysztof Kozlowski wrote:
>> On 01/08/2025 11:10, Ram Kumar Dwivedi wrote:
>>>
>>>
>>> On 01-Aug-25 1:58 PM, Manivannan Sadhasivam wrote:
>>>> On Thu, Jul 24, 2025 at 09:48:53AM GMT, Krzysztof Kozlowski wrote:
>>>>> On 22/07/2025 18:11, Ram Kumar Dwivedi wrote:
>>>>>> Add optional limit-hs-gear and limit-rate properties to the UFS node to
>>>>>> support automotive use cases that require limiting the maximum Tx/Rx HS
>>>>>> gear and rate due to hardware constraints.
>>>>>
>>>>> What hardware constraints? This needs to be clearly documented.
>>>>>
>>>>
>>>> Ram, both Krzysztof and I asked this question, but you never bothered to reply,
>>>> but keep on responding to other comments. This won't help you to get this series
>>>> merged in any form.
>>>>
>>>> Please address *all* review comments before posting next iteration.
>>>
>>> Hi Mani,
>>>
>>> Apologies for the delay in responding. 
>>> I had planned to explain the hardware constraints in the next patchset’s commit message, which is why I didn’t reply earlier. 
>>>
>>> To clarify: the limitations are due to customer board designs, not our SoC. Some boards can't support higher gear operation, hence the need for optional limit-hs-gear and limit-rate properties.
>>>
>>
>> That's vague and does not justify the property. You need to document
>> instead hardware capabilities or characteristic. Or explain why they
>> cannot. With such form I will object to your next patch.
>>
> 
> I had an offline chat with Ram and got clarified on what these properties are.
> The problem here is not with the SoC, but with the board design. On some Qcom
> customer designs, both the UFS controller in the SoC and the UFS device are
> capable of operating at higher gears (say G5). But due to board constraints like
> poor thermal dissipation, routing loss, the board cannot efficiently operate at
> the higher speeds.
> 
> So the customers wanted a way to limit the gear speed (say G3) and rate
> (say Mode-A) on the specific board DTS.

I'm not necessarily saying no, but have you explored sysfs for this?

I suppose it may be too late (if the driver would e.g. init the UFS
at max gear/rate at probe time, it could cause havoc as it tries to
load the userland)..

Konrad

