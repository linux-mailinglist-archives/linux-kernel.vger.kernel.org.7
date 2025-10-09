Return-Path: <linux-kernel+bounces-846532-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B60FBC8422
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 11:19:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id F3E4235326B
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 09:19:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7990C2D5A0C;
	Thu,  9 Oct 2025 09:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="pTAlmZbQ"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AD4327602C
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 09:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760001578; cv=none; b=pEXbuEj6W+gutGJmq688C0RotNHGJA0J1WGyNX06H10L503Dlcy8Ein0cAv6rYzdP3hX+SulJtKBfbhUyb/KEovPXN+6IkqZp8COtUK7MTXQpEvqoGuVN2gCSd41+wxl7bRvS/QWGAha8ELOoFTpKQH1KWbtGhjoDsBL5A7Q5qM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760001578; c=relaxed/simple;
	bh=rL2huFCoecuT5szCUTmVqW1ZGomFSlEpfa9WmNVvulI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=B9z7dbGqH0TyxHxuWOmccdN/PqZ3k8MReF9vEKF2S5TxtYzFf8hayj+OwKLQUDSYgUUE66z/dyE4P6IHfzsGkElhBDGddlbQlJweSYiklkqMalGm8nbifxQYfw8YLHbewJ2oJB3VfYkfnV2fP4OG6JIpimRpVfU67r5LUgo+83g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=pTAlmZbQ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5996ER3o028608
	for <linux-kernel@vger.kernel.org>; Thu, 9 Oct 2025 09:19:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	3s2fVbPRluI7eDHiaLG3gvuhMixD8+CyT+KTHVqigFY=; b=pTAlmZbQptxQFEKv
	8jRisGHCORuqRmA9o2/5JouEE+y8ybJ9itpSvdmP0hmhqGTJ3BUrT1iWKbXsxzIJ
	hJSRjIumHn6lK0+X1FZRRT1ipls/dnj13KJkpB9oKEHMzRD3fNopCTGbXbQTkXeZ
	5PayGovQS1QYVvR2HPV1ePEVwhpRh/Q3cwwMu6ZUONAUVg2QRahH0XR7p7EtxXrF
	LXI7/wAayVO900/G/VK7QT/sJoVILIIf6tDy8o8xe+iU3HxIOZFO5YG92tUVYziG
	dVjEdGn3oz9yV3IwyfO8/xmxFf13yOyk7pmnnwIMsQy/pprlzLoTwuIvmnbhkToc
	evvTgg==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49nv4kt6f3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 09 Oct 2025 09:19:36 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-879826c55c8so2774076d6.2
        for <linux-kernel@vger.kernel.org>; Thu, 09 Oct 2025 02:19:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760001574; x=1760606374;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3s2fVbPRluI7eDHiaLG3gvuhMixD8+CyT+KTHVqigFY=;
        b=oUBypbreW1sDuOU4W/n/fvv6NFfkikt+3dIbQBgzkkConVQTg2RQITbDoReRAmmESH
         8S1VV2nzDwTDf2j46YaTxhXIpAN1wfPPsW5cA13xGdMn/cMTbZRa6uR0ikpYfBhITm38
         /t/4yOsRoH0+UEEQfLvkg4h8o4NFhzYF/Am8s0VFiX4/RXihz48QNj/VKDqXY6kBv8y2
         CPv4RxoPRMqlnafFnFxVxfTxfKb6HeG3J6osrz6TOgvW84HLVrL741rWILQg9sj6GQeD
         L9MD5FYkWwBMLSYUOuTfFS/4loJQm1FsbTH/RdoSdQ4OW7kNUaxhjCThdm7Mc4ncxlnq
         gfgw==
X-Forwarded-Encrypted: i=1; AJvYcCVvRwXehfZPRuPobwTFmHy12my2EB55Iw9f+s/gkyev5gmiCIdTBco1yZm/8i+sNiV/dwyeKsBOwiSd1dw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3TFjRYfvA5g9XruY6i1mJ+RsJmmFe4Ojra6tw+PCX6GS3Uhe4
	ZxOkkAMzMCBaEHLVqV2SybyeJxaGtJqNvpmJ83LS4C3tIfXJIkHscRC4Gy1hp+rmTvTwXHDBaC/
	rdSFtNrnr/C2r5RRmNCtU5SkFiVVxqDOv/aK9v2LIq8cmAWZTMD1F2lg3lSOHQB7ghzM=
X-Gm-Gg: ASbGnct05Fs5ZrxSy3CFa3MzcbIfyIWQn3B7W09v+XBjDR3pWjvNZJtMl0D6VuCAcK/
	jK0JnN09LRxlIgmjVZu2e7UMVX8nM26YonmGdefqsgy38ELYktUao1aIU95ySpYRVqL6fQeVoSh
	iDgND1PiicsCGxDQj2kY1QrlC2C6ncEw3cwpqE0rphEKRc7oyxeaxr0gj10R/8yCPQUHq0EC9z6
	bYUYcab2KrH2eSjN881K5BmSxz+P3wPQj10NBC9iRdZgSrgfTvuyMaWpcA51Aod3hHPz9IqcHrF
	mAnh3iQ6jQhTYXo2LAlzXXF0jGpR3GX/7FWRtmqmP+NaeTYPIRXynhMlc+N2QWNRczAEc0KFa9C
	/rfX2W5UxeGLusLLwN5/f0fexsec=
X-Received: by 2002:a05:6214:20ca:b0:78d:8226:756b with SMTP id 6a1803df08f44-87b2ef6cfbamr57118256d6.5.1760001574280;
        Thu, 09 Oct 2025 02:19:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH2A1qU6LGjzQ74Et+6jXPQ4yzYwrsyoGAKooxWn5Jtt1h+1kAwu/8fhUl8mDlFd2X7Bmfg6Q==
X-Received: by 2002:a05:6214:20ca:b0:78d:8226:756b with SMTP id 6a1803df08f44-87b2ef6cfbamr57118096d6.5.1760001573829;
        Thu, 09 Oct 2025 02:19:33 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-639f4106c60sm1931662a12.43.2025.10.09.02.19.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Oct 2025 02:19:33 -0700 (PDT)
Message-ID: <1118c126-4332-4f9b-afb8-d3da4fa7fa87@oss.qualcomm.com>
Date: Thu, 9 Oct 2025 11:19:31 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 8/8] media: iris: enable support for SC7280 platform
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
        Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Bryan O'Donoghue <bod@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20251008-iris-sc7280-v1-0-def050ba5e1f@oss.qualcomm.com>
 <20251008-iris-sc7280-v1-8-def050ba5e1f@oss.qualcomm.com>
 <3f1979d4-1438-4c9d-99db-d97a09c5c35b@oss.qualcomm.com>
 <gdui5coiazt5ynuz6c6mr5slau33vuewr55vx53m5zzyi537at@cs7dbgirijuw>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <gdui5coiazt5ynuz6c6mr5slau33vuewr55vx53m5zzyi537at@cs7dbgirijuw>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA4MDEyMSBTYWx0ZWRfX+8xM42L6/rF8
 DQ1uSnrGE2AHUc+FqdAEQ+9zU+Pc5aRskRN/8gvN2m3gm2SX4DFwj+jqrs3Q1KcwS6zFSE+bkD9
 kHnkm4pZbceOgGK1N3UGkG6fHnrim3hiPOcVobZGbEhuMk4qj9KmDRFCLksHtPMv0x2dBtyQy9Y
 Yjrfi+5GkqQHboEl2mcuufYN3UlipcD5sh0hNzAWNPnkT9qeuenqzLyuhMCrHWlkh6iOD5HrhgH
 2wyayUAgy9lcvOx7PUxeatnCkgsWsqiraUiiPt6y2joXoAfVIElJBHZU+bcIFNJNOJNfTnjcrll
 lJNQJkVTwWpz2D2wDZV5nT/GGkKm1YrHhRgUPnIJL1bcHAgFKSkQ5ZIhqc1FJLSuPImssyNwqA/
 NuLhFwQD5H2mE5nWz2+hrTRaCqvCDg==
X-Proofpoint-GUID: 4IXV5BhDz93Hk5XxgAeEEq1C0B7GncrP
X-Proofpoint-ORIG-GUID: 4IXV5BhDz93Hk5XxgAeEEq1C0B7GncrP
X-Authority-Analysis: v=2.4 cv=SJxPlevH c=1 sm=1 tr=0 ts=68e77e28 cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=LpQP-O61AAAA:8 a=4qWUmPOJchojXs7f-_4A:9
 a=QEXdDO2ut3YA:10 a=1HOtulTD9v-eNWfpl4qZ:22 a=pioyyrs4ZptJ924tMmac:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-09_03,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 impostorscore=0 spamscore=0 phishscore=0
 clxscore=1015 bulkscore=0 lowpriorityscore=0 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510080121

On 10/8/25 9:25 PM, Dmitry Baryshkov wrote:
> On Wed, Oct 08, 2025 at 10:26:02AM +0200, Konrad Dybcio wrote:
>> On 10/8/25 6:33 AM, Dmitry Baryshkov wrote:
>>> As a part of migrating code from the old Venus driver to the new Iris
>>> one, add support for the SC7280 platform. It is very similar to SM8250,
>>> but it (currently) uses no reset controls (there is an optional
>>> GCC-generated reset, it will be added later) and no AON registers
>>> region. The Venus driver names this platform "IRIS2_1", so the ops in
>>
>> Which we've learnt in the past is "IRIS2, 1-pipe"
> 
> Well, I'm open for better suggestions. iris_vpu2_no_aon_ops?

[...]

>>> +	writel(CTL_AXI_CLK_HALT | CTL_CLK_HALT,
>>> +	       core->reg_base + WRAPPER_TZ_CTL_AXI_CLOCK_CONFIG);
>>> +	writel(RESET_HIGH, core->reg_base + WRAPPER_TZ_QNS4PDXFIFO_RESET);
>>> +	writel(0x0, core->reg_base + WRAPPER_TZ_QNS4PDXFIFO_RESET);
>>> +	writel(0x0, core->reg_base + WRAPPER_TZ_CTL_AXI_CLOCK_CONFIG);
>>> +
>>> +disable_power:
>>> +	iris_disable_unprepare_clock(core, IRIS_AHB_CLK);
>>
>> ..for this line
> 
> Not only. You missed the absense of AON_WRAPPER_MVP_NOC_LPI_CONTROL /
> AON_WRAPPER_MVP_NOC_LPI_STATUS. Which in theory can become a flag in
> iris_platform_data.
> 
>>
>> but this could be added to that one instead, since both clk APIs and the
>> Iris wrappers around it are happy to consume a null pointer (funnily
>> enough this one returns !void and is never checked)
>>
>> similar story for other func additions
> 
> In fact, initially I had them merged, but then I couldn't find an
> elegant way to handle AON regs. I can squash them back, if that's the
> consensus. Any idea regarding AON regs?

Digging in techpack/video, I found:

commit c543f70aca8d40c593b8ad342d42e913a422c552
Author: Priyanka Gujjula <pgujjula@codeaurora.org>
Date:   Fri Feb 14 13:38:31 2020 +0530

    msm: vidc: Skip AON register programming for lagoon
    
    AON register programming is used to set NOC to low
    power mode during IRIS2 power off sequence. However
    AON register memory map is not applicable and hence
    skipping AON register programming for lagoon.
    
    Change-Id: Ib63248d118ed9fecfa5fa87925e8f69625dc1ba8
    Signed-off-by: Priyanka Gujjula <pgujjula@codeaurora.org>


lagoon being a downstream codename of the aforementioned sm6350

Meaning yeah it's bus topology.. so I think an if-statement within
a common flow would be what we want here..

perhaps

if (core->iris_platform_data->num_vpp_pipe == 1)

just like venus and downstream do for the most part, and kick the
can down the road.. In an unlikely event someone decides to implement
IRIS2_1 on a brand new SoC, we can delay our worries..

Konrad

