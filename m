Return-Path: <linux-kernel+bounces-878095-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BEE2FC1FC55
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 12:17:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B35F33B3674
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 11:16:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51F6D2C11E0;
	Thu, 30 Oct 2025 11:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Sdz5w1Gh";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="OPKG45LN"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 364382DA743
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 11:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761822995; cv=none; b=cGUxEgiLfrs+2jHb2cWVETUJ0O5bWwSa+wYfsxnnos2QR8GGlMGY3WeoaLidySTAHqF6+l8s8+qninU1/gliXtrgyRsD1zsBTKs/18Hb+2BKnPve9GJnQpiEiEdcJ4SILCvTZ/YT5yQPSq0O83sFxGHAcXDYn58Qlvab6ctZ25I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761822995; c=relaxed/simple;
	bh=DRfRYtgUYqxz8TUV0m/TBZ6HbgED3u2tIokjfT2eR9M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=E8jXUQhDk5sbobM+ZnnHoEh34I9g6i5/6wnGAZ8DQCDVDxgShoXqUT3wMo7/18niGWbYh0Zb8MkTwBu7QQWkEBIxfEaG6SksMPCo6jEXJN1Mbd5LMvHBafpWlTeSO+fu+4f8/wmF+ZYUp9m/PbXFV+JbYvrTVGKH28Ejk0PdWZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Sdz5w1Gh; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=OPKG45LN; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59U7kPBc1697111
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 11:16:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	qEvXH7NyTRQr3w1mpQQJn3NxfkM6XT+NGTBGigfqyDg=; b=Sdz5w1GhnLODA6su
	wrYYdFXi7sT4fBijAWsXTaRFSOEpVFOrZYxhwTh6YBVmaT51rzZEXNqKzaH6Akts
	U+WxcX1y+y9u3DbPjA1/6KaV0+Zaa2mgI8V+y10U2dkiahe9PgkcrscidaFj5Pz3
	VM+fTfASA595rDvoHQIxFISyVY27JU0PFAHfN5mZv6aAHuA5Ass90U5e+A3N4UXM
	qlWLQDfmWt4vI+ANXsy97iME9Hn7Y63Jk7iGqhqabbBgWLiTO0OAykSO3hHeEYbk
	cHdDv/rxtFvUNv4kTlSEgbDbjdC+1AAwudKWmVTlVLv3bjPxV2w6qo4srpF+2gQN
	uUoMMQ==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a3trv23q3-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 11:16:33 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-8801e695903so1347496d6.1
        for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 04:16:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1761822992; x=1762427792; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qEvXH7NyTRQr3w1mpQQJn3NxfkM6XT+NGTBGigfqyDg=;
        b=OPKG45LNTOx/vTu/MOKw4PQ6I9LgVSFLAl4/tOMa8j7/KRpNptz3bs3+aEJtcG4zYj
         sau9WOR+OSRA1XjWKCLKe3gYH8w6R4L0CpuPFNAR/KnBQzbvYMVYDa62NnMiy/wwUwUW
         IfnuM83cdNS86fHLvfJu1mJB9BZyg2RFx+tXFJ54HUvPboSVrxhH19vmDIk24rpHEk1w
         by4q7uoY5Nqdhd4G/3DKjL6A590Fl9qiAnoHjT2g3Bwz5mUraXBz0U3yoYQ6xuFTx7Pr
         UQsUHFbMFsYwerI6ZFOVrmc8XMU7/ouDmW98g466AmAo+XaUPAShMp9lL6a32EX/jVOH
         f8dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761822992; x=1762427792;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qEvXH7NyTRQr3w1mpQQJn3NxfkM6XT+NGTBGigfqyDg=;
        b=uSoFrrj4RUu+/5twPCAe6YOksIsg/sBzpokUmwzfk33bueJYV5DH43cfHPdqUD5WXG
         zP+6KbjZFxmXmnzB1kxms2sAwX93goe0gX/F4fCls6SoBGKI/+xEGNCx3qRHhmOMRu6T
         xHOmkPkETuGRbzFQuffkdInepsTtVZu12urseMVziJLRio6DBKdg9cfLRwA/wDFgYigu
         Q5Q3VgY80AaryOllPXaLg9mmfmaFrvUC7vlki3ny95VH6Ms3Ev69WaPJuyUijLyVMkP2
         +2+YAoELIJlhs1HRGM/TmlwCtpnPgcxpbg+mGxiKiIJE37nZvvyv4ig38pHhKy31pmq/
         gb0A==
X-Forwarded-Encrypted: i=1; AJvYcCXqyvHjrbexD4okDUakSrtUHgoxVI/kKYGdU/k+dzuJLRH8U9MQ5KbSSGxj1lWQ8MurW/QULYeuAimH6wg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyr7hVZXoZXOYRkbsklxl8qCUCbGJBEtgjbHSzluulqLE0nOeIb
	1aRXmPRFMj8QoVPKffod8nnG/mSertsUk294Yt1yOv1/yZVz/Cw/KkvsC0D4YwaFczNhDuhJwFz
	Q06zQx04tNZXo2PTqW5geQvBS5CSEvXZQln1dGL2a431cjixXBRbBGJZm4cM1cWcqWV8=
X-Gm-Gg: ASbGnctIS+Q67XG58LdlbPbuH7cp6XUq6hsSu2d+XQHdPu9iw6FTBQ4kHPmQhoFP8kq
	JpSgjHMDJporBQq3spN//pywT2ab5fR2bmCFANy9Dh2Bfe+HhyRVtHZT4a7EMA7ysdAEQSkqNob
	iWyCph0LOpjMo2/7lS8cIqiYjyPB5bxzEBbWOOD5AZWu7mxWxn9lZkXBEdQajZd14iocI8qYYZS
	hRKEKV1WoZdYo+in8Cfa6STjJmDV+wohh/Hy0zCUcovkf9Qi3IRVNu00P4EVugZ0o1nd6nsu1xT
	RdvJXeR/uvagARumGfyrMr3NOpRrkjran7yB9X3DkNTGH0egDeWqDhSQTWAeafAFzaBMgFLkQs3
	8bWvdYuJfZDTGo+zQZhWl1HtB6o3+nshbwII3X7wNGPbjPsVCn5Vy2ef2
X-Received: by 2002:a05:622a:49:b0:4e8:b910:3a7f with SMTP id d75a77b69052e-4ed15c340c3mr54346441cf.13.1761822992168;
        Thu, 30 Oct 2025 04:16:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGNH0/G04cXM4zXhXAtmihNv8SAEWKC/gCapUSD8HUGSNuEAisqi1Y23cPEhSyifAoWpOj8ug==
X-Received: by 2002:a05:622a:49:b0:4e8:b910:3a7f with SMTP id d75a77b69052e-4ed15c340c3mr54345961cf.13.1761822991480;
        Thu, 30 Oct 2025 04:16:31 -0700 (PDT)
Received: from [192.168.119.202] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b6d853386d8sm1697324166b.18.2025.10.30.04.16.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Oct 2025 04:16:31 -0700 (PDT)
Message-ID: <bcff0cc8-8950-4cbc-9af4-8e5787ad0253@oss.qualcomm.com>
Date: Thu, 30 Oct 2025 12:16:29 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] cpufreq: qcom-nvmem: add compatible fallback for
 ipq806x for no SMEM
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Ilia Lin <ilia.lin@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Raag Jadav <raag.jadav@intel.com>, Arnd Bergmann <arnd@arndb.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20251029133323.24565-1-ansuelsmth@gmail.com>
 <20251029133323.24565-3-ansuelsmth@gmail.com>
 <9343108b-7796-4783-afb1-afe758f78414@oss.qualcomm.com>
 <69033de7.050a0220.34ea6.780b@mx.google.com>
 <c9801322-2184-4f04-9459-960580ecf6a7@oss.qualcomm.com>
 <690347ee.050a0220.21ee29.8092@mx.google.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <690347ee.050a0220.21ee29.8092@mx.google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: xOS_hNHf-eLHnjMtkwUpNSDzKb3Ud7Fq
X-Authority-Analysis: v=2.4 cv=D+ZK6/Rj c=1 sm=1 tr=0 ts=69034911 cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Oh2cFVv5AAAA:8 a=Y_B3j33kTYjxkw6TFJcA:9
 a=QEXdDO2ut3YA:10 a=pJ04lnu7RYOZP9TFuWaZ:22 a=7KeoIwV6GZqOttXkcoxL:22
X-Proofpoint-ORIG-GUID: xOS_hNHf-eLHnjMtkwUpNSDzKb3Ud7Fq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDMwMDA5MSBTYWx0ZWRfX6tXQ69DPUMyX
 KliyAJfPR2wnBLGpWJOtbuFRFllK7XdMs6DEe8X39fVAQMQpsIsU2PhWoKNPZ56EuaYeooFJ9nb
 jtA5vIntu3IspL+CaabXgHDiSSs4IKD4MQtaCRkEUTStj102T8aPYONsGvPSVsrv9+93N56uX8R
 2xUzviZ8GtAp0Cuc1vVmwR9IfchN6mwyTy9wBSTvJrQD5OGtJkGxj/FH1wZdQAOn/B7/TII+Co8
 vq9TxhBzD8CJyk9NoiyDxe2dDLOQ/47h9yDQRoq3SQaCsosOUGKd2EloKfjCbGC+tsgH1bhIvFC
 czr+l3oFNjyiI9cbBx4pfeP/Rw8HFESEPDDiaSXpQAug/VE0lGKK1R3ovbBkcO4d8fu1FpouYKv
 Pt5CHunrlyG58gsVuI7y884gIOeErw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-10-30_03,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 suspectscore=0 malwarescore=0 phishscore=0 lowpriorityscore=0
 priorityscore=1501 adultscore=0 clxscore=1015 impostorscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2510300091

On 10/30/25 12:11 PM, Christian Marangi wrote:
> On Thu, Oct 30, 2025 at 11:54:41AM +0100, Konrad Dybcio wrote:
>> On 10/30/25 11:28 AM, Christian Marangi wrote:
>>> On Thu, Oct 30, 2025 at 09:56:24AM +0100, Konrad Dybcio wrote:
>>>> On 10/29/25 2:33 PM, Christian Marangi wrote:
>>>>> On some IPQ806x SoC SMEM might be not initialized by SBL. This is the
>>>>> case for some Google devices (the OnHub family) that can't make use of
>>>>> SMEM to detect the SoC ID.
>>>>
>>>> Oh this is (the unpleasant kind of ) interesting.. Is there any sort
>>>> of uboot/kernel tree for these machines available?
>>>>
>>>
>>> There is some sort of source but quite confusing. From the info they use
>>> coreboot and chromeos.
>>>
>>> Looking at the source they comment everything related to SMEM
>>> (confirming the fact that they actually don't init it)
>>>
>>> [1] https://chromium.googlesource.com/chromiumos/platform/depthcharge/+/refs/heads/firmware-storm-6315.B/src/board/storm
>>> [2] https://chromium.googlesource.com/chromiumos/third_party/coreboot/+/firmware-storm-6315.B
>>
>> Hmm odd..
>>
>> The patch itself looks mostly good, although you e.g. assign
>> qcom,ipq8069 -> QCOM_ID_IPQ8065 even though QCOM_ID_IPQ8069 exists
>>
>> This doesn't cause any difference in behavior within this driver but
>> looks slightly funky
>>
> 
> Well yes I did to simplify the logic.

I'm fine with it I think.. it's just a small hack after all

>> Should we perhaps do this patching in smem.c instead, in case other
>> drivers try to retrieve the ID in the future?
>>
> 
> Well we would hide the fact that SMEM is not available. SMEM gives
> precise info while this operates on some kind of fallback measure. If
> someone wrongly sets the compatible and use the most generic one
> (qcom,ipq8064) then we would parse the wrong ID.
> 
> Also looking at the user of those API it's really just cpufreq and apss
> for ipq60xx so maybe not worth? (we would also have to add additional
> logic to fallback only for some specific SoC)

Right, maybe this patch is the right approach

Let's see if others have any reservations

Konrad

