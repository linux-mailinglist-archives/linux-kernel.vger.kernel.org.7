Return-Path: <linux-kernel+bounces-871585-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D8BBEC0DAB9
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 13:48:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8FC58188F03B
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 12:49:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05D71231858;
	Mon, 27 Oct 2025 12:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="KPomL/Tu"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFE53226CFD
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 12:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761569320; cv=none; b=PIVd9jDFfXyZNE2vft4bmeJ66v2xCtn0prV/QtTvZc+5mDNKQ31ueinL3dN9uGX5yVbXOB9qrHByE/C5jarouMfgC7j11EwGJhiB/KIbekaTEoPCW9WCzTMjWOQGtyshoPa/CbEnDUW30uTDQu/lkXeVSpbZ1sMpDzEYbTif5Cc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761569320; c=relaxed/simple;
	bh=kwPqXPxICWQRqS6XskDw01xKA1aAhRRks5SxMx/NbcI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=L1hVQrmweXCzXpl8D9wlJgF7iRYqQRfvqCrDl0R5aLdfsOh+vSBQxyvaA7Znsk2b6b6/Z4NVkMU7ApSeJu3Z5/2vK0ocgiGtj8Ggmzcj91f+vBs72ZQ2t/A08nyP6eWH2C9xFBpvpmhdQ7bun9ehh17/Way1iSzSeHqrcC6Gxyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=KPomL/Tu; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59R774Vf026725
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 12:48:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	r/Uv8H0003TgVcInLi9IzeOjAS6Ozviq/41bAtMg430=; b=KPomL/TuboAPo+sl
	OFjAhcmiPhBOLe+KzbXBZfPL1GnTUPWJxo3IeZghUFgrUJN8pOvrMZSuAReHdxQR
	wckDlE/ZATkF1VKg50GPZ4TkORxLDdZyjCnBB9/b6kHx1x1OUncnc9gSYpNLHxpo
	x7aTMuHYd1OW4Ftn8Ge1Mx1Gb7j5CpM14Bgi9tBOtneblcI6Zkv5edK367lv4MF2
	qJX2BOfmw9GhI6Q8f/Q2ZyEPeD1vjUXO0x9japLYzIltFG/BfZWeSDwZJEQoMFxq
	5uWewu7IIky6BmISPqHJJ1OTis7rfcSEVczyxtnKvR7/znZ390THbegPFAs1bEON
	JDPmOw==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a0nkamkxw-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 12:48:37 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4e890deecf6so6029721cf.0
        for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 05:48:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761569317; x=1762174117;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=r/Uv8H0003TgVcInLi9IzeOjAS6Ozviq/41bAtMg430=;
        b=tXD+T12HKLPm9OoSeRDtsQjle0BW459VeUCfOxL8SZVFeO2r67tDPwFqibkBubj0sb
         KZYHh+cRiP/Y7OhMuVrAf+WWYDOia1/MhP6MZO0Ie8gj4RyfoaohaZcs+K0nPiuIYfAz
         88eDBCvpZfOrN3gr6doBip2aqTG0JIWo5qLyNkGP2dG4m8mxXY4V4JK8d3rjHboqk8Kt
         AQ8O5Y75dE6ffFG1lNZmozqPSz7/m4HuQxr2rzu5Rq3tlGKpt4ETrdjf7Aa8My/drOEy
         CIpK2WRoNVW7H5/lH5N5j97st8k8oj/akznsRc4eqizWSIEMt4m6vwvwpIDBThQzhJxX
         Y+hA==
X-Forwarded-Encrypted: i=1; AJvYcCVHLZiPJA0JXXAqFIQdFsSlyY3Mkb374M7wi16AJn577+1aCyroS9BY24tksxj0DbdL7M00QJW7dkXa9aE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzwGKIITDqPLTLzqvkY6Np/qtiRBGKmfnJHx2HF0ZmXUnxlTXbW
	sxsEgohNRShtdrQ9GdV9lK2KltXEgju0TZPEU083n5gI+aoT4N6Xffr9nZgCoyFfHCsA1ZTYmve
	EGwWkxballZX7Tc8NFPZWLPjKmvYF0zmVqNpesnVGGFNR1ZkfwS4ElqbPW8rrlrKglaA=
X-Gm-Gg: ASbGncva8PFxtFnONqJX6OE0pEqzFWzHnblACzwPql+yC3z6saOcDhGYckwBXUWV+M+
	7zTtViddy1v9m1yrbhwbW5AKemjri0GfGJmLMBM+EPU3vDfDln3GNlUT9Kwu3t7FyIJGfx29tvz
	0w8NAYZRSNxDEJTtgeosQaA4Nv6Hmprnyy8XwNiLOBSvUc5VxlsOlST7PLQIlexNxDjvNbg0NfC
	tBigyozRkcet+wZPdu+/cW4E3AkmCvMS3dfCbrWMgEgo+DfSu51FcdgkIKwUC9VZVDl3YiN3Wjv
	47oCtwHwCS//CcLYV4V3Q8blZvswZGK5mC1xFSOvBYYv3IqJRIWOi8JHtXjDzK9EQ1mPJGB1Kmh
	i888waECeaDLZqrUATGvRA8k7FN+QK9eBTgc+F02RLeIwZhbFTnS8ez/M
X-Received: by 2002:ac8:5704:0:b0:4ec:eef1:52f7 with SMTP id d75a77b69052e-4eceef16c1emr48423431cf.11.1761569317117;
        Mon, 27 Oct 2025 05:48:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHdTHwN9Gandf3Nr8idY1T2xhuzqElR3BXPKvTHU3HR+2RoVvlDvxy/LNpNChn+i95pgTzFOQ==
X-Received: by 2002:ac8:5704:0:b0:4ec:eef1:52f7 with SMTP id d75a77b69052e-4eceef16c1emr48423031cf.11.1761569316647;
        Mon, 27 Oct 2025 05:48:36 -0700 (PDT)
Received: from [192.168.119.202] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b6d8544f8eesm736062166b.69.2025.10.27.05.48.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Oct 2025 05:48:36 -0700 (PDT)
Message-ID: <c8cac801-574b-4e4d-b233-56dc5cdbaa26@oss.qualcomm.com>
Date: Mon, 27 Oct 2025 13:48:32 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/12] drm/msm/dsi/phy: Add support for Kaanapali
To: yuanjiey <yuanjie.yang@oss.qualcomm.com>
Cc: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        robin.clark@oss.qualcomm.com, lumag@kernel.org,
        abhinav.kumar@linux.dev, sean@poorly.run,
        marijn.suijten@somainline.org, airlied@gmail.com, simona@ffwll.ch,
        maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de, robh@kernel.org, krzk+dt@kernel.org,
        conor+dt@kernel.org, quic_mkrishn@quicinc.com, jonathan@marek.ca,
        quic_khsieh@quicinc.com, neil.armstrong@linaro.org,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, tingwei.zhang@oss.qualcomm.com,
        aiqun.yu@oss.qualcomm.com, yongxing.mou@oss.qualcomm.com
References: <20251023075401.1148-1-yuanjie.yang@oss.qualcomm.com>
 <20251023075401.1148-2-yuanjie.yang@oss.qualcomm.com>
 <omlhiywjr46ik6bj2aiutgcf4aifen4vsvtlut7b44ayu4g4vl@zn4u3zkf6cqx>
 <ad906eb5-c08f-4b66-9e37-aaba99889ad4@oss.qualcomm.com>
 <aPryORKIuSwtXpon@yuanjiey.ap.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <aPryORKIuSwtXpon@yuanjiey.ap.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=AYW83nXG c=1 sm=1 tr=0 ts=68ff6a25 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=f1DJfOMeYKxADSZecjwA:9 a=QEXdDO2ut3YA:10
 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-ORIG-GUID: TetygMivnDANhgvZ0_r9Agp4La0rNStL
X-Proofpoint-GUID: TetygMivnDANhgvZ0_r9Agp4La0rNStL
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI3MDExOSBTYWx0ZWRfX0h/3frj9lIsv
 YuMI+NJ2rwwKLEJfA8WIkmwl9d+aqwhCyBFiiEG6/or729nfFacukqGQnp2VomRW/3rpRboZGij
 RTfC+QrMlfWsz4YGCZHQTJkN47fQQniB0CDkVlmmu6+1of4LoF4C20ox6I0sqRgLkW5j87Alvxh
 g60AXVvt2EpbvUCYA6pDOEiL1152n+Jn4A+/lh2XKyaD9ZDm4k8SOWVg6qjnDfJhneYiqIkWWGN
 0eHWkrnQzzLUCXKepbd1swGohNNSwk5krQLdzhRDV93hHA1SisqPnWoWwlCRdVsQAjiN9wds1d0
 9G8Vtj+x2VByv+QWTS9+xqz5qqHWF04hgLLF6C5d9KSfM3CC6pzRMI/fzWIC0loM7TiGhTgZSUZ
 HctN5Wg0c6pAixDtDS4NGMy2GgoxQg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-27_05,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 suspectscore=0 malwarescore=0 adultscore=0
 priorityscore=1501 lowpriorityscore=0 bulkscore=0 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510020000 definitions=main-2510270119

On 10/24/25 5:27 AM, yuanjiey wrote:
> On Thu, Oct 23, 2025 at 02:02:45PM +0200, Konrad Dybcio wrote:
>> On 10/23/25 1:48 PM, Dmitry Baryshkov wrote:
>>> On Thu, Oct 23, 2025 at 03:53:50PM +0800, yuanjie yang wrote:
>>>> From: Yuanjie Yang <yuanjie.yang@oss.qualcomm.com>
>>>>
>>>> Add DSI PHY support for the Kaanapali platform.
>>>>
>>>> Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
>>>> Signed-off-by: Yuanjie Yang <yuanjie.yang@oss.qualcomm.com>
>>>> ---
>>
>> [...]
>>
>>>> +	.io_start = { 0x9ac1000, 0xae97000 },
>>>
>>> These two addresses are very strange. Would you care to explain? Other
>>> than that there is no difference from SM8750 entry.
>>
>> They're correct.
>> Although they correspond to DSI_0 and DSI_2..
>>
>> Yuanjie, none of the DSI patches mention that v2.10.0 is packed with
>> new features. Please provide some more context and how that impacts
>> the hw description.
> 
> Thanks for your reminder.
> 
> Correct here:
> io_start = { 0x9ac1000, 0x9ac4000 }  DSI_Phy0 DSI_phy1
> 
> And v2.10.0 no clearly meaningful changes compared to v2.9.0.
> just some register address change.

Sorry, you're correct. v2.9 had a number of changes instead.

Konrad

