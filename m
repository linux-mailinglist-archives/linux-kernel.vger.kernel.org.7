Return-Path: <linux-kernel+bounces-865630-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C9D7BFDA2E
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 19:39:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D2E8D4EF18B
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 17:39:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC7642D7DE5;
	Wed, 22 Oct 2025 17:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ovU/kvt+"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F00622C3247
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 17:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761154775; cv=none; b=MhHXyp3JeDv0uQ98jlJMJo6n+AabpK3YD7YvTD0attKLdUIahbmTN6zkwQkq5dePbyJ5BMLjgXp/8lLywSUWP5IrtLWUMYE07dc6EKVkzWBfjXqRj/4CAxakiL0W7HGJVipHysQMV0w7AhEFWKqanXTifbCK3K6mY2u5hCpQ0Zo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761154775; c=relaxed/simple;
	bh=fLelTF8/0IqQy3P2oy26e3VdYKHcJQv0D7rNT0G0sf8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=m34I27ZUwzj6MkDweLrs1iEqQXZM/h+QVh0zaKZXMOrlLzuqeCo0vNmRrmBXOEJafI79Yh4QZIELPDNnimn0w1mxWsBXt4BSlEBwnVX+0LTCovCmfx7PxLusHo0EcmVqUVxYxezIf54AM7XHILrE0ru2+Co7R4yfzGHtGy6+5zk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ovU/kvt+; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59MBvLDq024209
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 17:39:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	fLelTF8/0IqQy3P2oy26e3VdYKHcJQv0D7rNT0G0sf8=; b=ovU/kvt+Fe8mZ9v8
	wxfn21NP7PS5PYIcvFEMP6qaEOzjvhnt2Ub7h1coPJ2U8o2htWenlKudNmzQPscC
	PDisyCc0KYada3aJxGQQCtzmVUoUnz6rGFLRM8zcrGUGLUITkIuzfnBmDBg8Qttk
	LiP6F+LpEy1YSJurL01oM7T9u72wAX19C7EueYvIwNvxCKIp9Lcyc86f6d6tPEay
	AI9wn+78QRP6LNjkjuYY0vlKC46mPH3LVLh4erZdVtKuKH5Kt+gXUFYM7QfNZqEM
	pW9PEP1h3savFphn6QPBNiMW9qKXP1DPqcffITKspcicy3CHa/2w7Y2wfyIIQGd+
	pJBbMA==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49v1w85kvq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 17:39:32 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-33d75897745so3491055a91.0
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 10:39:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761154771; x=1761759571;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fLelTF8/0IqQy3P2oy26e3VdYKHcJQv0D7rNT0G0sf8=;
        b=bjLJmKs+etD4rUpOFNX/mG+YQoELaQeCZH1T1zSYhzQxZ3+rGvu1E43OgQUrBI2S66
         Hz21ifHQC0D24Evhg4sN1dEYWiSON+wffSt/KGSUzW1QOOdE1ZeG3gpkvNahTPWemHMJ
         TCeR4+ENJCUtXJcBQBtrogsqhxv+e9UxrhKoz7huP8jax7Q4sWnK4rAOH/8XkWCf7s4e
         x6qKSE79chDiS1Xl/AILexjaMVug1MuD5OIt5l8DHqBw7qUs9Lc9RM2VNM20OM5h9DBq
         oqdMYoamw/MlRBFxZcsFqOJdUlPIab9C7oJUXvPvRTZXZu5m3PG4Iv0dhUUZv0jO3535
         tbeQ==
X-Forwarded-Encrypted: i=1; AJvYcCXjhDyoVdrQp/syI1Tx1Jv0DilHjpVCfMgS52BHvEL2TIhlQ0m7fyL3HvbIXsWE+nMIoUSbGMkkVVgy9Tg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZYk4S/+ANBalvjNXT5Ihy2mJMYMtUV/SjZz0eVePGUdMDq9TK
	H/hJrSfn315E24w6xi7EaMgfd63eNk/ypve3qeCGTbEchxVvXZlGqEfeqqnfck7ZdAwX02kaDmy
	Fc4MX1RHdMbBjQzPYX6WKGe65MYEHIf7cv106aC14tw/sve4d1nF1ByG1VKhDJ2yWN+g=
X-Gm-Gg: ASbGnctyI1SLgIXKv1GgoYoVRapOxbdaRS5lTjw1fKZPn+srqw0d4aDhj99wN2aOUxC
	09duDflJC/OanyE/Vj1qQJQZHgQq9WwxkjJFQKTs6Unkd9wDEOemD4VrKpHH+9Td1tWpfRH/AQ8
	PQswkNWYUmcG/eW6mg3B4MkE/vH5Ql8iDCztNALwtFVf/SC9NlC3IxIEiHH6i9zlzILC8HfpnuA
	q8InvkoOsD/lefN8Qb7b2+QfjWU4WQjgFoy4PDBGWoX1NGCfCgxnYVAg6OwaDKp8RJlTk5l8CC/
	ZglpffXdlHjGFuACkLoQLwToP5+RgtA7WlwOUCnLCtuwn3l/GsI4BREJeWYhiCP6tNle1oWRQcS
	5j2pzIzvHqc7VV2HZuGTikbiHnJYjEF9cs/zLseNSotCe+OLgLi1ZzQ==
X-Received: by 2002:a17:90a:e70d:b0:32b:6eed:d203 with SMTP id 98e67ed59e1d1-33bcf8f14demr27496761a91.24.1761154771537;
        Wed, 22 Oct 2025 10:39:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFzmMG9fdaAA2inrKULTHZS4DJ1sZoPnRULNrfeFDnHK+yfYZ15yMpfN1cpGbPHSU0rFRLuNQ==
X-Received: by 2002:a17:90a:e70d:b0:32b:6eed:d203 with SMTP id 98e67ed59e1d1-33bcf8f14demr27496726a91.24.1761154771059;
        Wed, 22 Oct 2025 10:39:31 -0700 (PDT)
Received: from [10.62.37.19] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33dfb7f8310sm2728378a91.5.2025.10.22.10.39.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Oct 2025 10:39:30 -0700 (PDT)
Message-ID: <95538ded-d2d3-44bb-8aba-cc55ab0d4ea1@oss.qualcomm.com>
Date: Wed, 22 Oct 2025 10:39:29 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] media: qcom: camss: Enable setting the rate to
 camnoc_rt_axi clock
To: Bryan O'Donoghue <bod@kernel.org>,
        Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
        Hangxiang Ma <hangxiang.ma@oss.qualcomm.com>,
        Loic Poulain <loic.poulain@oss.qualcomm.com>
Cc: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Krzysztof Kozlowski <krzk@kernel.org>, Robert Foss <rfoss@kernel.org>,
        Andi Shyti <andi.shyti@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>, Todor Tomov <todor.too@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>, linux-i2c@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org
References: <20251014-add-new-clock-in-vfe-matching-list-v1-1-0d965ccc8a3a@oss.qualcomm.com>
 <9984bc23-05ef-4d46-aeb8-feb0a18e5762@kernel.org>
 <bc0caeb8-c99b-4bef-a69e-5ce433e6b890@oss.qualcomm.com>
 <c4fd6bfc-cc9a-4f37-99b3-f36466691a1e@linaro.org>
 <CAFEp6-2=GJL-gc+PSyAL4=prp_sXdZJS=Ewg5nP2kcp_Gu85Fw@mail.gmail.com>
 <33513b43-f6d1-4c76-887b-39611a75e1f4@kernel.org>
 <WnfCknsSyJK68PQZkE2q7COZHRpsLOFlr3dcbwiVR6SBWtF9iRQ4MGzp_9q31O0kyhZwoncQWfHjJQvpz7nyfw==@protonmail.internalid>
 <ab43c5c9-edc5-459e-8ef7-2aa8bec559c0@oss.qualcomm.com>
 <0e6e1b8a-d9ae-42d1-b1ad-4314e0d76ab7@kernel.org>
 <2c0011d3-a692-457c-9ac0-a445fc82df37@oss.qualcomm.com>
 <48bede40-584a-409a-9bca-7ae3cc420667@linaro.org>
 <124be1cd-1cc8-4c04-8aca-eede808e736c@oss.qualcomm.com>
 <wQXRQmbUmfMvej8K6_8vXS41CKntPY998YjO9D3oixzxaMuV4isW-ebPocmhNjppbBpEvXx1524Q-BT-UHfh7Q==@protonmail.internalid>
 <6efe686a-fdd5-4f17-a0dd-d44a16a67a36@oss.qualcomm.com>
 <3d2b0de7-4c39-42d3-a6fd-d41386559e1a@kernel.org>
Content-Language: en-US
From: Vijay Kumar Tumati <vijay.tumati@oss.qualcomm.com>
In-Reply-To: <3d2b0de7-4c39-42d3-a6fd-d41386559e1a@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAxNSBTYWx0ZWRfX8u32WKrMPkSJ
 Ys+5qpnflymzgnUtbpx2BuCvapz8lt0YFyRCDHLaCnKmp2GCdbYldtj2GRQ3aKf4lx6o+a30sBy
 uEDAFfNHC39MN/su6XLia+ruZrqxU6j/cR54svqFxrNVYf+JkuG1s8fpGOAxPS3dWV200OeQj9a
 Z2G5PRQ9ZCpmrom53/htVpPl68+dIYrkGxrRtntquYTYCkGfHwDEsbUC6PfxFuJSoiFmW/x40p0
 eOIsSWkUJeO3pB3OuD8PxOGlWbNmi8ZVtbtNABL2zpCEJkskh3TpwWSFGXindk0RCB755v2VJ5W
 0m2yrjBPF0mIu5IPgbREr+oNJ2hEGqK73X0RD2TYhtdBhle0cfBZIvGAbnGN3aDeVk49yLyWyyx
 Pn/Cqhvpb6x/neRwaA04f2B3CaP0yA==
X-Authority-Analysis: v=2.4 cv=bNUb4f+Z c=1 sm=1 tr=0 ts=68f916d4 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=apREhrRnQ4vd8KJXgwIA:9 a=QEXdDO2ut3YA:10 a=QYH75iMubAgA:10
 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-GUID: 1MOIuncVtAwO1UjoBfG7ARryJLuV6as7
X-Proofpoint-ORIG-GUID: 1MOIuncVtAwO1UjoBfG7ARryJLuV6as7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-22_07,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0 malwarescore=0 lowpriorityscore=0 clxscore=1015
 priorityscore=1501 suspectscore=0 adultscore=0 spamscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510180015


On 10/22/2025 9:00 AM, Bryan O'Donoghue wrote:
> On 21/10/2025 20:19, Vijay Kumar Tumati wrote:
>> Hope this clarifies. Please let us know if you have any further
>> questions. Thank you very much.
>
> Eh.
>
> So can I take this statement as Review-by: from you ?
>
> That's basically all I really need here, RB or NAK.
>
> ---
> bod
Sorry, yes.
Reviewed-by: Vijay Kumar Tumati <vijay.tumati@oss.qualcomm.com>

