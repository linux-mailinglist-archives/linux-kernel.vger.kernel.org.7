Return-Path: <linux-kernel+bounces-762368-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D267B205A0
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 12:36:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE2184237EE
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 10:35:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A7D62797B1;
	Mon, 11 Aug 2025 10:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="muJKlt2Q"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E9A62797A9
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 10:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754908446; cv=none; b=f8IyFi4K42g+ZSOHX6zlv0+x6FNhDmsp2+OAK3BHAcqWfhGy/juvpFh4briu6qoY2ePW8TnEwK6yBvRO4jvEMeOoWPdx3F6mIyvYTik7mduzFmrJ9syjwWk+oQuFLQoOpefEb1NwM781OBunyb203j8vCIQ/HnpXpG+hKoM8fQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754908446; c=relaxed/simple;
	bh=n6bYWBbuvYgd7Of4AkNGNr2HVdrMAtKaVoR0TN1D2LE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RynPb9RzYDWXeuVlIkSNGSDuZNnBCqijy3M+RXkHrp1SV2B6YBntRbkgeKL1445N4QLk8KfoZdMa2i5wFWDk5IbwjpLwyWisDbFu2SMG9gS1q3kkyLN8nNtSy4aMfOZzQ/YD88dH62pBzcyqptL70W4fe76Dy9TifjCz1JQBJjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=muJKlt2Q; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57B9dKgb018342
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 10:34:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	wsD7GGJiNnfcvjretasZ/pNIYgJDbc71adqR86O7WrU=; b=muJKlt2QHD30b0PW
	KCf4MMfDmKz/Chb2p8V2b1lzpymdYwgT5IafpJ8GsAtII2dqKbGBQ2V75pI5FEuA
	6gTh7QPlryeJRU5t1F0EDOoeZnG0+tsbNzZlrfbzoioXA3mBaHW49S/lSgCfqRFo
	9d3ac/8ptkZ4+Bfdr4OMEb81n3U+eyKPRYj2BvyF77YDfIJ9DowsHzMu8ZEYbHeJ
	HPWS+xpa7XOsdYt6MAcAEtut6r/+tvsHpe2KNqpvB8OVFhxwnxWKAjXrFrq8qo5a
	ZOrHnnQTio8fCBfr2yj5ItOMkO3olR0aNOXQ9e/XFBOXwWtyTInSVOOecJQ8AN5C
	/wkNxA==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48dy3g406q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 10:34:04 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-707641946ecso10704796d6.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 03:34:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754908443; x=1755513243;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wsD7GGJiNnfcvjretasZ/pNIYgJDbc71adqR86O7WrU=;
        b=ev/rXEM/frI/sRuUEvA3HoBCvmkejZJEKCDaHGw+twfppTzPv7aIrLXaZwufvYvLZe
         hIUadCeVMoMyFzR5ZAQJ+NwHo7gmzVdjIIrepYxqy1Ymev6wT65eWEIoEU4ulT8Zw0el
         igQ7r1xD/Fz6h4NUoB2UQpJoCQioFQjPTAHFTlev6vJE+46K5F9OYskMu1FZniP9qhDY
         yUZj3PE16oH80+LmPujmXjw8jLJmweVKaAllAtxL89HFqYcm++If+tIhKN+cgNBwy8Od
         f5Een2c4UNm6hZQ3vfrUgRKZBuE5yJw9SgL9ojSWQtYg3thAij5cgADRlaKOCZtRYzKI
         9/mQ==
X-Forwarded-Encrypted: i=1; AJvYcCVgm9R4iQjy5+nbarJYU2jDfm2HT6QqmmRDk2ptlhAoxVYCiM18HdCPCV6H2OgnOIN3IoVEwc4GxGboD9Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbPJBSTRtZAgS2Yw5OGsc9kVUQ7BbmfoDUDGSAWW70ezAOYucf
	1fWUpgwIM060DR37FFvozkHrokC94uvi6mZHaRqytFeZclP7ppVZ8e8Jy7r8N8QUpFKwmiK4EkS
	YX+DBBnuLz2eF3V6vwGydVS1T9zW17Rm2b35FKIvdBIeRXrE4U7T2gWhhW4zhwHtB2vE=
X-Gm-Gg: ASbGncsCqifm6v8dG5uTPL4U5ru0egkFX8qYhdAnS0RVBapynInFeKEQGHHHWlMmJR1
	pWcP4YjzbLzK63kGSxkmHxl212mpZC4yBMqs1wiAA/C1b0GMq0cGiytoNGaL9+699Wm091HLsDo
	A/nKTcGk9NhqhUG8KkkRhbKRCYnNrie3or/CPjR2nHCQgb1Q2nl0Bq5JXXxs8LITy+nsNcszV97
	yjlSBbPcqBKEDWIhvrBHSpAcb/OcTKM1xtg9c+3Bk67K2Fq7m9r/jwf0JLW6W9hnR3q1QEaTUiz
	J0p756PxlMEiog7kc2Y+hjZFpqH8KKYEAow2MWug9V9X3Q7I3FiHi4vFosPTYfbc+voIKgkakLJ
	EpV/z4hughH46jzznYQ==
X-Received: by 2002:a05:6214:2608:b0:709:23f0:f50 with SMTP id 6a1803df08f44-709b094cbe7mr53402236d6.8.1754908443214;
        Mon, 11 Aug 2025 03:34:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFpXju1O/sKkYY/b3BkoXU3yRD84XzBcfZoJ/QUx+rjP0trH4Je3JcbjdMDL95C2fO2CoviQQ==
X-Received: by 2002:a05:6214:2608:b0:709:23f0:f50 with SMTP id 6a1803df08f44-709b094cbe7mr53401926d6.8.1754908442594;
        Mon, 11 Aug 2025 03:34:02 -0700 (PDT)
Received: from [192.168.43.16] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-615a8eff60esm18546387a12.13.2025.08.11.03.33.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Aug 2025 03:34:02 -0700 (PDT)
Message-ID: <0a3698bd-01bf-4882-b41c-426bca328e40@oss.qualcomm.com>
Date: Mon, 11 Aug 2025 12:33:59 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/7] drm/msm/dsi_phy_14nm: convert from round_rate() to
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
 <20250810-drm-msm-phy-clk-round-rate-v2-2-0fd1f7979c83@redhat.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250810-drm-msm-phy-clk-round-rate-v2-2-0fd1f7979c83@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=X4lSKHTe c=1 sm=1 tr=0 ts=6899c71c cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8
 a=aS93HcZ8ji4XsMPHnqgA:9 a=QEXdDO2ut3YA:10 a=pJ04lnu7RYOZP9TFuWaZ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA5MDAzMSBTYWx0ZWRfX4p5ZTPPa/Xjm
 wN+XS92m6cgJNxNDEQ31s9U0eVBK9Y6zucbbCJmkqsbB3BOdoGo7I9mpva5dDOJ4tMYLuen/15h
 vO0CB2kFWHlgbgPJZmgyZc1lC+7cnqRdknuGJva1BANKWBXegzMkVDNAVLTdIneRUq75pawYp3x
 Xwg5M/96/nGZJAG72C+2ak/OGXkneNL+ePNj4hQgKT1BgwM4WMAl0cVygabr/uj2F63dm014Zjx
 kD4VU9g2sgdipJZJa47wftyLewa0JmMQBkLiPmHMBpeqvXdcNYCa6GnrLSFh+WNOlb76kPyZbB0
 0Ds2itbeQE1eFDnH6RcV0TMC0Og75wRJ1fUqgguRu60T8EjjER3NxG5/hPrb1hgcHOr8MJPmt9y
 s1He45Ob
X-Proofpoint-GUID: NkQV9r96jLdlcrXQfvk7i4Na_G69YvtF
X-Proofpoint-ORIG-GUID: NkQV9r96jLdlcrXQfvk7i4Na_G69YvtF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-11_01,2025-08-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 clxscore=1015 malwarescore=0 adultscore=0
 spamscore=0 bulkscore=0 suspectscore=0 impostorscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508090031

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

