Return-Path: <linux-kernel+bounces-852208-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EF73BD8706
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 11:31:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 88B9E351D4A
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 09:31:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F2DC2E3B03;
	Tue, 14 Oct 2025 09:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="PBTLhYiX"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5BD4222587
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 09:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760434267; cv=none; b=SmpEECIj7U3QoDIPgMLQnMvtI9lh1ltrJMANqde5jWEpwl6hyx8wYB3Vv70+nzDTUTh6FomL9QNCOcclH3L8cWj8oQVqzaYfvO39PvkY9Zot9HrpAKz1iNKWDhqVu4cbIq93Mp/qhwD+XMUtwukR9GgAHAXFIjaitUoISUXgDkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760434267; c=relaxed/simple;
	bh=vEcNDQBWVve4pED0SSI+pK4Wz6MIFUxUaJOPOR2Js7I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=M7Q7D+KCP/h/2Qk7AUZ2eMgAzAH87/RePJXEd3llQETjfKqMJzfoddEd3h/7p0mp69YnYrYhOFTKl7Nd1m5QlSBnksPnwN7mbAQf4LWJIOk7hNKUJN/pNAFDx3toZD38nO13Ru4sFi9sp03hgT5sjbNW3vSFczJXPa4uoEgM9ZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=PBTLhYiX; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59E87H4n005372
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 09:31:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	gwVihZd/2iWoLKh+aG/GWvUZ17cfyK3TQmRX3H96tos=; b=PBTLhYiXWAM6/TVS
	2c7pLVWvFwQdQFLJc4npJYRm+ilzD0axObBksB7cENkqOf1CQPhGpWtDlZiI5X2t
	t90RcLSLl1hdLYbYOkZKGn4VPUhv7Ia/z5ejs14M8ICqSKx1b6jrR7BU16fEvtQx
	Oyv0RHV9DcMiILuIs9WOwbLpIo/0RVkPW6SgQY90vv2ZP5vPCoj9dg5xfyeGWrut
	1d2TV+eDVa9movwvsvbFbOt0oPPiwHEH5jQA04/wEWyh++QObHNBKVZelazAO/qg
	t7OdrWyac0D2SCSL4xRzXZxNg2M96sKpbvkP008xbF2u/kZ4LokajIgEZ3qYVs0H
	/LFnfg==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49qfbhywuk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 09:31:02 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-8747323272dso27791216d6.2
        for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 02:31:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760434262; x=1761039062;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gwVihZd/2iWoLKh+aG/GWvUZ17cfyK3TQmRX3H96tos=;
        b=J55cbrC0JifOOWN+4Usq/XxFVKn9IuMxFU+DxCZgt3s3oq77Mn1emj7pMLFIwnpESj
         rIjmEPRKQ/wkuOrX9k4qrvbslzopuROhsB8PcItHKPaQOIGk/Lkj5Cjq5CUhEm2YZklg
         blxphzeNoLw+flsQ71pD2wK96H1KxBEP+cXO4ukDhc54Mce6inRsYOLuC7pI9f6PWhFL
         X3iOUZkRn+0Yvb641YRiMTBeiCf491dz+s3qf7Ai+WA8I4SWc4MlwE2IM2/oapoed7bU
         NcAKrhjMOnYU3HY/N0/vYMqM/RmLwGJ5rgBZpHCSa9jp8cZ6ZyCTEuFPajrPRBe50ahC
         /4Bg==
X-Forwarded-Encrypted: i=1; AJvYcCXuIwu2viHGBjKpL5xxYeTlGEFwbajmBP2Hlb5OWrRHK36t5afT+2GczaU0an/2J3EESRXh3SXftjqX5bE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwaKYtiBm6KOvuYYyYbQcXND85WfgmmT5cWzWdokeScBMkLU/BT
	8EJgAooQTPrza1hwcnhBoGFauw+Nh2HJGk152TvGSBQqaWmhyk1zVgph79fm8glxj8LiCeKi5nY
	cIOM+LK4mPUdXqWoLgyZ09/XOp7uIFkVwRi5RdSWyydZOcRNr8sEb8VBz0rhy32e+LQs=
X-Gm-Gg: ASbGncsJ2vP444Hpekm0D5ezJFlTu/YYCzA4WBmPdZxR9QIcox9L5KaPPzdjB7Ku0MF
	1lGSwSxLgS/mv7W3qby84bCpyk4JcDpZRMvt8N+QJn/4suWtH94eVqEdcKlC9cNPYQzxymySmv/
	AIiZcIiFfSzXyiLe1UFs5Uu9PKx6VuuHiwFQkxQAsAEk9eF5f8eFqbDjOBnKYmU7WZxwwgAD34J
	upM4AnwCAPFhRbGA6ppZ5s+WXMFmBtcwB5yQXs6bOtzlDOndyN9YGkCq8qYKcrV3vuSj96GEwVR
	mVp0pfDfdxs0QFj/sbq97LmIHy8l9KPDjjPzO91FGmXetckN4tVNOIVWaEDAjC6yKB0gvtG+0kH
	LilKa7RhgXjkM0tg1ZvDtTw==
X-Received: by 2002:a05:6214:4102:b0:773:84c1:396 with SMTP id 6a1803df08f44-87b20ff9b56mr227829096d6.1.1760434261603;
        Tue, 14 Oct 2025 02:31:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHl3KAIznNTpy4D/RymiqPy5IHzi3DP+VRMfli8rFMYCBBw3Vk/qI+qF6NtAwDHFqtlwZaUqQ==
X-Received: by 2002:a05:6214:4102:b0:773:84c1:396 with SMTP id 6a1803df08f44-87b20ff9b56mr227828876d6.1.1760434261162;
        Tue, 14 Oct 2025 02:31:01 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-63bdfec82ebsm136980a12.24.2025.10.14.02.30.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Oct 2025 02:31:00 -0700 (PDT)
Message-ID: <2af5b96f-eb24-4a37-8f5d-a6911e256a9a@oss.qualcomm.com>
Date: Tue, 14 Oct 2025 11:30:58 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] soc: qcom: pd-mapper: Add Kaanapali compatible
To: prasad.kumpatla@oss.qualcomm.com, Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Jingyi Wang <jingyi.wang@oss.qualcomm.com>
References: <20251014-knp-pdmapper-v2-v2-1-ba44422ac503@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20251014-knp-pdmapper-v2-v2-1-ba44422ac503@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAxOCBTYWx0ZWRfX8ywbzcZfyxFr
 vNPi73EcIrknl+mpvXhZ1hcH2L8iqp13rHDZrQaoFae14SAqKCduGKf28yCWuwB73N+ElXWxegO
 5Z0Zk7h/trcfZLOgCo2nhAFqENrt57yPL27slCa+Qd17AAaPLO+4XkSn32xoXsRcl98eLaMwU+3
 YYzRKlj3GVovh6n8C5xXTJNYO+Kcb5u2nrF+xIVWDMwF3fU/HY0sE4OLAnltvv8FA1fIEI8Yb9r
 HtA3nQgyl9BbTiYeAp7zQBeo73dYHvFDTg3i+nhtamTS9LPWjHy0z5godlSDrV5ADch+ASapHCV
 GBIkYReAp8u5h67T6F5wkCdWprebxKSflj919vooyvlHzXy1u/MGD2NSVmkbYY9ul4lNPpH5JEy
 q73rHXVXrTIIQp6Bqbn5sxH92BoMeg==
X-Proofpoint-ORIG-GUID: h6_iTzpQQm_De_zVehxsisF-uV6y8ux-
X-Authority-Analysis: v=2.4 cv=bodBxUai c=1 sm=1 tr=0 ts=68ee1856 cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=5CMVg1e2JDiE4ByGS8wA:9 a=QEXdDO2ut3YA:10
 a=OIgjcC2v60KrkQgK7BGD:22
X-Proofpoint-GUID: h6_iTzpQQm_De_zVehxsisF-uV6y8ux-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-14_02,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 adultscore=0 impostorscore=0 suspectscore=0
 bulkscore=0 priorityscore=1501 clxscore=1015 malwarescore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510110018

On 10/14/25 11:27 AM, Prasad Kumpatla via B4 Relay wrote:
> From: Prasad Kumpatla <prasad.kumpatla@oss.qualcomm.com>
> 
> Add support for the Qualcomm Kaanapali SoC to the protection
> domain mapper. Kaanapali shares the same protection domain
> configuration as SM8550, except charger_pd as it move to SoCCP.
> 
> Signed-off-by: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
> Signed-off-by: Prasad Kumpatla <prasad.kumpatla@oss.qualcomm.com>
> ---
> Changes in v2:
> - Add separate pd domain data for Kaanapali SoC.
> - Link to v1: https://lore.kernel.org/r/20250924-knp-pdmapper-v1-1-fcf44bae377a@oss.qualcomm.com
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

