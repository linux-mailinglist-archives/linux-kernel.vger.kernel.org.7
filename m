Return-Path: <linux-kernel+bounces-886398-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 06575C35761
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 12:49:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7DE733BC7D3
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 11:43:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0D86310647;
	Wed,  5 Nov 2025 11:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="XRYe8JjT";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="IkvOSa7r"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A42A22C08B0
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 11:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762343017; cv=none; b=QuLY0bmL+jzJ3Ob58jo1wNd1qylPJbMi4TwJpwdxlUHFE1N47TbplPFdi3aDpjNjm9y7Kyr/yNTuNSHVQXemvIiUnkoBoi9G9ZlH0ZfdqEmJPvvBQ2HRUVvVedx4gRdTOQg8bxIgdtB3eZW7/xjcJY7bA16VHlnl02uPK2I5DNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762343017; c=relaxed/simple;
	bh=BdMm81xYZiuBh40gc0Ua6efd+2dzC13cTYSHrMpRHXs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=erQWJ0hTaMXB2UNd4KzCuKwzDPIx+tWl9BsQfpFNbgxzmW/zjdnCVfQglmwJwHxqwmaXpAi/D9Q29uDoUzyXuz49RjBro+vPyHi5Tu7/e1Uo472icAbv+6wEorDgMa/jsAzSg5NOFzZlex3miCYt6e/CTYT6/4TPm4i3q7hxiG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=XRYe8JjT; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=IkvOSa7r; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A5818BS3114616
	for <linux-kernel@vger.kernel.org>; Wed, 5 Nov 2025 11:43:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	BdMm81xYZiuBh40gc0Ua6efd+2dzC13cTYSHrMpRHXs=; b=XRYe8JjTZQm1XQ36
	tOSvxyaCtjVUS+hp0JU7p//fVMX4o814+BAQqNrsA/OAtHGZyUJBRdCsRgXMrQ92
	SWKAfVFYjftXjI1DEN7w12Hs0wqpeQuVd23XPILKiQv8XgfpcsKT6tw4arsBDu5B
	1tsyCDJ/uZLfkzHlXqZgU4RiMOPgkvSFgcWFFR3E1OHiRwXKT2RATUwViNnBrjwo
	imVZbC1C6wDZ88co3jBOqeEuuGqk1BvQC4kwmhkTFkt+P/rQs/rmxn5dkTqblIoI
	492cEHvrFBrIIbs3v1c1ApiSRId2Zb/TSg9lSTEkga3awJ28WKRKok5kWO6Q8b72
	8kh+xg==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a7sfdt3s7-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 11:43:34 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-b993eb2701bso3420041a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 03:43:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762343014; x=1762947814; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BdMm81xYZiuBh40gc0Ua6efd+2dzC13cTYSHrMpRHXs=;
        b=IkvOSa7rdK/5qjP/opy4dQuLCC7xg9tY48bEIT/PGJL9k/2xkN7IxRjtWaR444rD+p
         tRwioC5M4JNfa+wQmttuPxudsPJgV0TGpEs2LkOoqZ5tLDeVe1G/dsNPckzXb5rk2QVu
         2fBtKUhJUTldzxSv9MmEUaR7DRmgzc0QxczEyMyWUhvsPZaiJfzMpElIHvlY6A+iY0EN
         sZvFlVWG1iacTXbPgGzVYsVcNCW3QZ/2yOIrwhf7Sm77hiRhymCLHd8BiQk1E3ew7PWo
         s2Z0R7Dp/Qhi1olSnPzKIoUHto4I2RCOGXaZr5/J3Pfsv6mfVbmlc/VqRTG4wvZ+9I0R
         /cdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762343014; x=1762947814;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BdMm81xYZiuBh40gc0Ua6efd+2dzC13cTYSHrMpRHXs=;
        b=VMIrN20XYHZfJAkxgJcF3Ljq+j87T+YdOgdy/CWN/FPhS6LENj5/UqJcAzUEw0JIuw
         Z91zEPS8nk49Zqn9Bt5d8nALDlRkF/JtO9YO2ffQT7XxTyrl85r+amuVw/pYH9E3tiTN
         Fc/fpgc75zQRJT0uw16kKQOU5/2Kq9VIM6It/kISksyyMC/4i4yjrreJ3/bCy4F/qNpk
         j7Y0/BTVpGA+lCTSaTojRQ7PVLYTmlMStczg6i5ZW0hZF5o7uzrwazT6D9oOjy99osvG
         AbvhHER5fuKFlD19CCh4oPbloaXWFRGDJMaa5Ha/6xoaBDhgU5h2jHi/WZ7ymLC1Ib1V
         otxw==
X-Forwarded-Encrypted: i=1; AJvYcCXIvthLg20om7usL9iKmlhOWrSay6hvyVADWBjOUmkwx3v8hqFOu58UuC/RXaImdCyA3fL8Tve9Y1+9TTs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxptafbVZ46ZNIdAinUbdjR5GzoO5naWBEsVgDp5/lJ1vybtTHZ
	51NBqc83aXx9JeQBp85QesQbqYdhEf7iD1+zRdtS8p795FGmtNDi3L0eWP7JTOUXcNa0mOwPdNd
	K6XW5uBMO2NWJpSmyI/Ddr8FEPCnuYoUiTafAk1zgheFCGUT2UEs32C1rsG84t8jNVmM=
X-Gm-Gg: ASbGncvcFQIqQdbvAfFpP2ueXRp651FGGhFXGpgoarlRCydIv37hrXXc9DGDkC627L2
	mVrwOAMcFelEXI62ETOwcQ3xlzx4eBdKtu4kj7ztXTeazh9IFCi7gFoNZMRkE2HtcUDxnmrT9nZ
	db2hdR2qOqU5Zxt+XG3ljPP0jE9GMfSUuUAjGMMvdzu1uBM/mYympmNl1h6YHeVl9fWKKf1PJek
	3W1YdTUM4NW9bfbT7fhbVST/JfQ7WvfetKUhnnPhOqE5sfNzLlJouzjfn0lFp3axrYW1yoSaWF3
	vPsKXoY1Uu5DMOukPnwZi54dCNU5hGC0aByjACERlAbI6chy0Dgvsj3sAt5MpoUJeEdhRj5SyP6
	6yQ5KxcA/tIA3Vt86VD/g8TZcr5EJSfV0
X-Received: by 2002:a05:6a21:338a:b0:344:97a7:8c68 with SMTP id adf61e73a8af0-34f86114a51mr3703186637.54.1762343014259;
        Wed, 05 Nov 2025 03:43:34 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHq1fw6AQRlBdqYRnyUSOmKR0xWysU4bHGiCWZGyF2QQLzwtoZWe/qua4VlMjRvlHnlxSRLyw==
X-Received: by 2002:a05:6a21:338a:b0:344:97a7:8c68 with SMTP id adf61e73a8af0-34f86114a51mr3703149637.54.1762343013781;
        Wed, 05 Nov 2025 03:43:33 -0800 (PST)
Received: from [192.168.0.171] ([49.205.248.32])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-ba1f765eda9sm5265961a12.18.2025.11.05.03.43.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Nov 2025 03:43:33 -0800 (PST)
Message-ID: <ba589a5d-65b8-4980-937a-29598e891dd8@oss.qualcomm.com>
Date: Wed, 5 Nov 2025 17:13:27 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] media: iris: Refine internal buffer reconfiguration
 logic for resolution change
To: Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Bryan O'Donoghue <bod@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil@kernel.org>,
        Stefan Schmidt <stefan.schmidt@linaro.org>
Cc: linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Val Packett <val@packett.cool>
References: <20251105-iris-seek-fix-v3-1-279debaba37a@oss.qualcomm.com>
Content-Language: en-US
From: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
In-Reply-To: <20251105-iris-seek-fix-v3-1-279debaba37a@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: gnuZwP_jzTMfKrnGRafyZBKHuA_neznR
X-Authority-Analysis: v=2.4 cv=MMFtWcZl c=1 sm=1 tr=0 ts=690b3866 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=AzyGrR4UViKNxLVuAS9Z9g==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=e5mUnYsNAAAA:8 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=srhs0GdQF8B2Dv3X-aYA:9 a=QEXdDO2ut3YA:10 a=_Vgx9l1VpLgwpw_dHYaR:22
 a=Vxmtnl_E_bksehYqCbjh:22
X-Proofpoint-GUID: gnuZwP_jzTMfKrnGRafyZBKHuA_neznR
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA1MDA4OCBTYWx0ZWRfX8s0S9aon00uW
 E1xCeNz7DmKdrn6oIax73jkvIBBEDk5FUeOT6LMWm5ztG2lX81+1Se9yOHRh4fwgwNtmIpdcmIa
 BJUpv9HNtA4bLAAc9bTQRViIC54p7gM9UxQe2kkxxg3ZJAuSNMs15WIh73SSvc7n53Ww52EYGEh
 NoyItQoHuroH1Bw0mRJAz38HLq+Eq8jD7SElc6C1lJCVztXg+Q94QtldXvaWb/3ih4bFuCo1RIt
 fhSb5+gKAcCZYT2n3vuw62jdl3w59BjPIvuzW2B+yk0dBLHg4jkCwx+6zn3KXrs8fA7MSqknKSP
 O1PFOPQWZIbDjfU7o/UzqP+tPkF1UL5DEARvGA6x21Pa7F8nB1SPml9IHcp2hIsmeGFWcUuArlK
 33wLP3wAaYoB57A+gslwPzgH7byo2g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-05_04,2025-11-03_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 phishscore=0 adultscore=0 lowpriorityscore=0
 malwarescore=0 suspectscore=0 spamscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511050088

On 11/5/2025 11:17 AM, Dikshita Agarwal wrote:
> Improve the condition used to determine when input internal buffers need
> to be reconfigured during streamon on the capture port. Previously, the
> check relied on the INPUT_PAUSE sub-state, which was also being set
> during seek operations. This led to input buffers being queued multiple
> times to the firmware, causing session errors due to duplicate buffer
> submissions.
>
> This change introduces a more accurate check using the FIRST_IPSC and
> DRC sub-states to ensure that input buffer reconfiguration is triggered
> only during resolution change scenarios, such as streamoff/on on the
> capture port. This avoids duplicate buffer queuing during seek
> operations.
>
> Fixes: c1f8b2cc72ec ("media: iris: handle streamoff/on from client in dynamic resolution change")
> Cc:stable@vger.kernel.org
> Reported-by: Val Packett<val@packett.cool>
> Closes:https://gitlab.freedesktop.org/gstreamer/gstreamer/-/issues/4700
> Signed-off-by: Dikshita Agarwal<dikshita.agarwal@oss.qualcomm.com>

Reviewed-by: Vikash Garodia<vikash.garodia@oss.qualcomm.com>



