Return-Path: <linux-kernel+bounces-762367-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AFA9B2059A
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 12:35:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9AA427A8704
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 10:34:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C7D0279323;
	Mon, 11 Aug 2025 10:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Aj2ELdzs"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D32E1277804
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 10:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754908441; cv=none; b=F4a5F3v2c7PXD54Q2ZBn9D+Fo3eIJqZp2Fe3/pWvPymsrfTxbUx6HNXWqMp4rh1RNwRGA/EvQ+zmJ/GN0mT8eNe5kESZjCaywgy8RZ7Psc5ZGU4uDe7uXN5/EPO1XRoYdgxHS2blLKetvhN8/lwUN8XABoIGsyHaVH/7LlW4HOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754908441; c=relaxed/simple;
	bh=n6bYWBbuvYgd7Of4AkNGNr2HVdrMAtKaVoR0TN1D2LE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cWWbPQ6BcxXESqJwtSJCxjW5WHIcnrTgqGDO41PxF//30J8j2oxtzRIEdhY8qrvFcF50F8REGGtrqFu+9ScGIbQpwkYNoA5oTT4qvIVbD/wy+egX5FFSd45Zu+mcxBXNBOnpoEXlO0ppysFyPYubc5sFM+ck+9XKa0uTfGetLPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Aj2ELdzs; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57B9dCAP029204
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 10:33:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	wsD7GGJiNnfcvjretasZ/pNIYgJDbc71adqR86O7WrU=; b=Aj2ELdzsgekhYgRt
	ClktyV2PtJ2CPU1+yHxzLljbB7VL8jO6/Qu75jWuF4fCwLZRtRfpwD2z+8UHaQlR
	F91dHXHznoR/VAZnbcxOhAUWozo1E/eSg7+hcF4UbaaP1SS8dX3A3ul8wwIvfskb
	kAQKD2pNqF5Ooj94/JJfwt0Adj5BvQ99j7X7bZlnKoz6n05iJ5U0uT2yhvQsERrj
	OPufcVYx7EdUIj9e+yP6ogpa/JGZLbfNiHq5zeUzmzO6ksgpYxhYFm8dXIuLIxOM
	ZaqxieeJm4j532hLK/vWcm7CSL9NeRS7c2KyCBW+NCpiuXBPao/WoB81t22D9wFK
	aerQIQ==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48dw9sm4q0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 10:33:58 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-7074b13178eso12948676d6.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 03:33:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754908437; x=1755513237;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wsD7GGJiNnfcvjretasZ/pNIYgJDbc71adqR86O7WrU=;
        b=bZhQqHvUtP+MiVgTHBDB5VSE2r9rcVvBrKzLasbQ1+D8AbKNC9iICU0dfp1Pw78qxc
         UxopWExkvJ+0E/ZRoVzeu9d/75abjQZ3YnGaWS7284Ft8RWZ1SyYLgRUENKKnqaUTbyl
         5V5jzhglvXAMqZkmEn4wb5YauDnuHyaZXt7Sxk9LMExNoy+LdkXHGA7WSScc3jLlknBX
         7BbSq9n23Q80KQu0ANON4RyXdql5jV6HLuKbLaZhNxqLMmLFvZkNqPTYfn6JoMvsY5gI
         UX1hywW+XWIlO3l5ar/7V6+MPRxHkRKjNdmEUnjn/0MRskEkWqUZVyPfxk/F6XPxyJnt
         5zww==
X-Forwarded-Encrypted: i=1; AJvYcCWoc79xnr0kBY8QkUFf5/gTUy9UoJr+tA1BrfjVa/CH39Rms1TxZR0Mr7Fz/QLfe7T/yczwHGCwmHwwuSk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTNL/eMWfGTZDrl6Mgf3gNDRKiij2BL4XKLoO6lSVKxgM5OMHi
	R1WnooMHdyuLBIxt+HBEAs+gst38IM8GiubjsxhTzkgJ0SUtYY0Q56869LwFZqKS9MUYVYQAgVM
	r3jB9b2RXWyCwTmkpTe8ZOkUIXlvvZJCSul4fKAtZTuzculNUUdefJjCBq7LHjlZBem0=
X-Gm-Gg: ASbGncvaHZtrQ/4HJjmNuE4Q5OMJ8Bg6Liv5VFV34WMHg5OFiwcA+zfDOAGGYY3SO0j
	K9Nm4UrxMEMg+HEI75x/stnT3rylbWh9sl4G8Gol2D5vLVHqR1lvEtB+sEOcHEMpyhVC4E4TPd5
	FtPNDtz0fYXDdcUiNnl3qCT/eUHT5CvrHDXUN8+eWxtAYjlaR8hJjKJtBRkolSu/8g12v/feoVt
	Vmi5S51B84b74PgBtjCcR6nba3mGz0TzxTxjLjsdkCBim2eo8s+iot9hw7/1dvWdxnWsY3xKrBB
	9K/k5r06rERvtxisfPdnYhsvMXdPsguSnpJZqdrapxOnUavOFa2HnsPu2YQK6JJ2PNL9ytAcJKH
	Sx7uTelRwkYZkXJw++g==
X-Received: by 2002:a05:6214:21c9:b0:707:76b6:2135 with SMTP id 6a1803df08f44-709ac152639mr49721836d6.4.1754908437523;
        Mon, 11 Aug 2025 03:33:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFZPUcFhvJ+o3XZIPZBMeA11da0VhO9plin+aeS/4AZ3/QDcw95Q3QsJu+fTZO17e7WElJo9g==
X-Received: by 2002:a05:6214:21c9:b0:707:76b6:2135 with SMTP id 6a1803df08f44-709ac152639mr49721596d6.4.1754908437064;
        Mon, 11 Aug 2025 03:33:57 -0700 (PDT)
Received: from [192.168.43.16] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-615a8eff60esm18546387a12.13.2025.08.11.03.33.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Aug 2025 03:33:56 -0700 (PDT)
Message-ID: <1442a1f1-8cba-4f63-a9c8-85118d728365@oss.qualcomm.com>
Date: Mon, 11 Aug 2025 12:33:54 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/7] drm/msm/dsi_phy_10nm: convert from round_rate() to
 determine_rate()
To: Brian Masney <bmasney@redhat.com>,
        Rob Clark <robin.clark@oss.qualcomm.com>,
        Dmitry Baryshkov
 <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Maxime Ripard <mripard@kernel.org>, Stephen Boyd <sboyd@kernel.org>
Cc: linux-clk@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
References: <20250810-drm-msm-phy-clk-round-rate-v2-0-0fd1f7979c83@redhat.com>
 <20250810-drm-msm-phy-clk-round-rate-v2-1-0fd1f7979c83@redhat.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250810-drm-msm-phy-clk-round-rate-v2-1-0fd1f7979c83@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=J+Wq7BnS c=1 sm=1 tr=0 ts=6899c717 cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8
 a=aS93HcZ8ji4XsMPHnqgA:9 a=QEXdDO2ut3YA:10 a=iYH6xdkBrDN1Jqds4HTS:22
X-Proofpoint-ORIG-GUID: T8H6HNwQBpd1zIHT7lG_QGEDiK8wDjnn
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA5MDAxNSBTYWx0ZWRfXyl8lMnWfmnVH
 P2fJwpDFvlq9h5KZVSZG3VnvVzphAU3508PQJp7d15OUoMZaonfADQNf4lWrfBQ9i8KinrC0jn6
 MtjTO5Heh8Z2mwksO2fWiDjuCM63+MXfmtG6khaBPZQQHt6543V4rjjRoLbAQZavMte0UDggKIr
 YMc7qKriZalxYOXtEfHRWILvyilQe6g1labhQLZChSICRMGZlqzTj5tA8A+3Y3X+YYZ9LXv4YRx
 8ZoISyt2yP9vN8G5BQBE2qeMdNHZEATv3CMIIUeL+gFAlhPdce6WzjeL2Eq3VY1PwS7MGAyZ1tx
 6qLQygeGcwlZS7JPLQdtPnrY8sBWxuWoJphTF8WFG/57iq9ioY1i44XqOK+nbjf2HJFoXro+vFW
 RmdXvoU9
X-Proofpoint-GUID: T8H6HNwQBpd1zIHT7lG_QGEDiK8wDjnn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-11_01,2025-08-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 malwarescore=0 impostorscore=0 bulkscore=0
 phishscore=0 suspectscore=0 spamscore=0 clxscore=1015 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508090015

On 8/11/25 12:57 AM, Brian Masney wrote:
> The round_rate() clk ops is deprecated, so migrate this driver from
> round_rate() to determine_rate() using the Coccinelle semantic patch
> on the cover letter of this series. The change to use clamp_t() was
> done manually.
> 
> Signed-off-by: Brian Masney <bmasney@redhat.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

