Return-Path: <linux-kernel+bounces-781455-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46894B312B0
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 11:16:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 85A997BABC0
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 09:14:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03E4E2E54A8;
	Fri, 22 Aug 2025 09:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="idq4NFJM"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06A5E25F7A7
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 09:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755854160; cv=none; b=QwXi9isyKS5s1fHOExhpKqUn8CfAv00yNf3ZnyECwOirs8LMGfks7WnqAaDuMF4vHiXU4fuv1oY5UL0xmGnfmW0SBb9B8pW6ZQ+OZhp6EVR9vdkXfKpcthSHyHmFo0B2inTbhcmLf9ePvxhtI3RFSs7gZNUxArPm6bxeunX2q+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755854160; c=relaxed/simple;
	bh=CR0b2qpCl7xTZdz+j9G328pzRVF08m42rB23Y1CiaaU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=edF5KNtc+mCrZWGpnvWf8Tj75VuTnoamlrCgNrhyuW8cwr86wAGIlJ021nJjW5ZZLtwpFPDdFF5w0NNDckmrVDNNdcUExAFHwTZjGdUFwU7q7YdiKtWumR8amtoghOhXd2M4FEMc4F6nlCRI/cLiRYVe+iGQTzBVaG2P1N+SaHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=idq4NFJM; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57M8UJMk024107
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 09:15:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Owu3/M/QJUQDNXTeSSRokvKyc2i7GLtBqRsTbdP1fWA=; b=idq4NFJMc+tr/fdY
	zWuINNDSyNrAvT9BXHQj5b99ZSok3elH6zqi3IHLPMeWmX26zrhet9z5LUclHbtw
	obed0iqjKVwyCDlGJMkh6gQ0FSBtZ/iVNkjUvzkeVphjA1uIcC+7rCRvvHwmZaww
	WLxOIu+ASuEZRSUxH71hlXnvt+PAS/RiXuzWfCu1i1JmsKGT2O2UnFIHttGLy3Zg
	M+3QNv1v/ujmjupYAv0GH780Rc3K8RMh1oHV1tuq1RU9+iqG+6WLu3uokrmWlLYX
	F41BR2d3aFGe0RMahjQ81w7nqRMEky6DWSwwAYA8TCK6A6tlWLyQv/2BWQ7NWpMx
	O06wHA==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48n52agq1f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 09:15:56 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-70d9a65c239so9961976d6.3
        for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 02:15:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755854155; x=1756458955;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Owu3/M/QJUQDNXTeSSRokvKyc2i7GLtBqRsTbdP1fWA=;
        b=WPuEaZ1JcBAgerRyY9rm/ulgD3lJss2NCvsqPE8aN/Rzs6fGnJy2sOaksqKualdl5F
         Y+luDteY5rwdfZcdos5pJBhCBYW5/zaWSdRopNCsT2Om6RrH1JS87ne/qRFarh4WHjmN
         SNwM9VnuwzGqowrx2I/2Csmch6J85/wy3QchJeo/OpoDi6jK7CBGJhvC/KSAS9YDLii+
         zzJX3tysf/LwS/or/dBiPToguhrBvOhxZPZBo7kOG1fYuK2Erv7jMQJ8ThtHDI1fECDQ
         jVobMvWEpMMf+DPvrcCuKPr/1zLDuKoDGoK6sj6gL9IZPzQGe32+CBhDETS+I0afLYzW
         o7EA==
X-Forwarded-Encrypted: i=1; AJvYcCVHxMwjIfwmscNvoN723jqyWeEsHmYZ1mUL1LjaUrgB+oAmOMY+VkgWwEZEerfIjbW6AUqhqJt/o2rOqDE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5HUIEjnXWbKuyN9JJe7SeyzgIPT6tfOtSWob9JySg8q7kHaGb
	ooMoWTMxWz+b98HdsLOEORFj2VtvhmQd3to+oYEdNUsyfxN1nfw98RmdylOJE6WUObceEbmGpuh
	8tO8uK9Ida5ck/b8kPSnkZozfENeIYL3F0xEbWgsIZW95X9pSXpT9+9AsTkJEX0EEwOA=
X-Gm-Gg: ASbGncsLAdCV34jBfRt6teYl299pZWP0A6XrKGSnwogb/v5RxhOWG/MB9RcCOqzqQ0k
	IBxynhDFBc79BKknqNIJioO78H6hZj6/Qp8TYhcQLBiEOdGdgwHFWLEdwKu0wWwrCDLQUbhQpg2
	/oZwnd19//10WYoujMp5JvL/edBRmXm7WYdVNvQM2rM+0ux16u+kHAxJe0mzf1XrXB5+cUpTfDr
	pY/8A0ASoHnVTAYGnE7N2W4PNObbJnH24mABnyDF9GXPYB169VLFzZKxebr1g7RtrItVSPISKhR
	f4imFnHMgDI2mXLlffvkDbJTdOpvfAoParlx8QXZm4lR8D1wvK8+s5g88G5/kPnHWXBnwhRDw7t
	g82aYKrZvvvHMYexOkw==
X-Received: by 2002:a05:6214:b67:b0:70d:6df3:9a79 with SMTP id 6a1803df08f44-70d97243921mr26581396d6.57.1755854154749;
        Fri, 22 Aug 2025 02:15:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFy6Sek65h6xKz1DLTC1s5MdUClmKKfK9XaTQ1Rq47IFeeZrXNrNYv71xD4mfgWHSn1waZlmQ==
X-Received: by 2002:a05:6214:b67:b0:70d:6df3:9a79 with SMTP id 6a1803df08f44-70d97243921mr26581156d6.57.1755854154151;
        Fri, 22 Aug 2025 02:15:54 -0700 (PDT)
Received: from [10.207.49.70] (84-253-220-51.bb.dnainternet.fi. [84.253.220.51])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55cef35fb15sm3412573e87.52.2025.08.22.02.15.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Aug 2025 02:15:53 -0700 (PDT)
Message-ID: <761c97bb-ee90-4ace-acd3-08349831aade@oss.qualcomm.com>
Date: Fri, 22 Aug 2025 12:15:54 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 2/2] phy: qcom-qmp-ufs: Add regulator loads for SM8650
 and SM8750
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: Nitin Rawat <quic_nitirawa@quicinc.com>, vkoul@kernel.org,
        kishon@kernel.org, andersson@kernel.org, konradybcio@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20250819222832.8471-1-quic_nitirawa@quicinc.com>
 <20250819222832.8471-3-quic_nitirawa@quicinc.com>
 <ger4kizeltjwalfuwu4dpfjiskrv2okgo5c7d6n3pb24yaxgfo@nkcndblyx3il>
 <xir3u3hlmcvfu6uasijz6g2oialoasmuu4bno6ctxpscqcebz6@6kw6xpm5bxbd>
Content-Language: en-US
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
In-Reply-To: <xir3u3hlmcvfu6uasijz6g2oialoasmuu4bno6ctxpscqcebz6@6kw6xpm5bxbd>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: 59apQA-kOJWlpNb0ZM8zkWOUjAYJxCTI
X-Authority-Analysis: v=2.4 cv=B83gEOtM c=1 sm=1 tr=0 ts=68a8354c cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=JdIsBVl79nXNK9flUcZCTw==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=EhswbOTC6dfh6Ow5hwMA:9
 a=QEXdDO2ut3YA:10 a=1HOtulTD9v-eNWfpl4qZ:22
X-Proofpoint-GUID: 59apQA-kOJWlpNb0ZM8zkWOUjAYJxCTI
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIwMDAxMyBTYWx0ZWRfXzwz1B3DaaNHZ
 BuE8/r+CHc42jrMd/kD5oM6d3s9/nlITm1bL87pgaF1G1ajbHruoRk3eHfVjm6d0MCBhU3jdLUw
 +QFr3KCW1ehvVqd25n2eSWHNrNhUMbF6KPQ+DsV2GPQw+4jmyKtnZ4SlhXRqo4So99RVZHPb/5K
 WfZOGtmTU5zH0FN6whu8p/LMKn24acz+WZn1gUBg+NH69yMJfYnI3I5NStBWXEHdMhcPAo4d4iE
 2AzYCBo/gr0gb6YCFFtt+shL99GmBMCIqRjRZe0/vsV8fh2+LcGevgpWMg3BRg1G+Gz9KRSwxFC
 MFn+PU0HnWEm5N1xr9FHtLvp1JdXJhCotx8zCtZFKXmghpG1W87NMcR+TXhpmpGHWHob6bev68x
 UwGxFpBpF6Xp6fGoMXdFHQ3jpS4X8g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-22_03,2025-08-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 priorityscore=1501 suspectscore=0 malwarescore=0
 lowpriorityscore=0 adultscore=0 impostorscore=0 clxscore=1015 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2508110000 definitions=main-2508200013

On 22/08/2025 11:53, Manivannan Sadhasivam wrote:
> On Wed, Aug 20, 2025 at 03:49:31AM GMT, Dmitry Baryshkov wrote:
>> On Wed, Aug 20, 2025 at 03:58:26AM +0530, Nitin Rawat wrote:
>>> Add regulator load voting support for SM8650 and SM8750 platforms by
>>> introducing dedicated regulator bulk data arrays with their load
>>> values.
>>>
>>> The load requirements are:
>>> - SM8650: vdda-phy (205mA), vdda-pll (17.5mA)
>>> - SM8750: vdda-phy (213mA), vdda-pll (18.3mA)
>>>
>>> This ensures stable operation and proper power management for these
>>> platforms where regulators are shared between the QMP USB PHY and
>>> other IP blocks by setting appropriate regulator load currents during PHY
>>> operations.
>>>
>>> Configurations without specific load requirements will continue to work
>>> unchanged, as init_load_uA remains zero-initialized when .init_load_uA
>>> is not provided.
>>
>> Can we please get configuration for the rest of the platforms?
>>
> 
> Only if the rest of the platforms require setting the load... It is not very
> clear if the older platforms share the regulators with other IPs or not.

Yes, they are usually shared. USB. PCIe and DSI frequently sit on the 
same voltage rails.


-- 
With best wishes
Dmitry

