Return-Path: <linux-kernel+bounces-732302-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CEEAAB064DC
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 19:04:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 327711AA70CD
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 17:04:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1F46283CBF;
	Tue, 15 Jul 2025 17:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="XUHQzie5"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9238B2417F8
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 17:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752599029; cv=none; b=p0Krx9d4ZI9ysa+W6k4acwTVLeL8Aks7XDRZUrjoddtdBQiqyhpvhJDJtHbrUlwolBDXUUqrd8nta05v5GcY+ZAzegmx9INDhw3Zy1GgVdSUtMe3/C4nw5e+jrHJ+GE+m5LW1j4e81CaQH0ObKejJL7W3L98U078uWavp7jVAEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752599029; c=relaxed/simple;
	bh=dicjAlJPe6baE6YbcoZnBwLfYS+y9yn57Ov6Q6RToYU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=gof3x2xPKLGqNz88PFKoTVlqbv7V6stf1f7o4uN3hHX9Qbt5BccUCfqwmswhS2jmdrDIoQ1X1+7Z6ZoIqgTs+4rPgx0C4V7C/hnzZ6lQGZo3KGVxdvNKuXS9NcyWeB7IJkNfURLxdx8URbcrcwC2mcC1sQaV5fncjoE8Zk6jTgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=XUHQzie5; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56FGDD8c024478
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 17:03:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	90GpV8+hUwlfdrE85xu/G/2AfYKG3ln+ooGRMjQFTQI=; b=XUHQzie5MoNqwmRZ
	LEjEvfT5o7uDvBOnW2CgImO7Q56a+i5SNOUEKJCmWjRKvlfV4m6Pv9b/I/7ZWpMD
	0GQpLkMI46EoOqou9u/rnzUfmCAPUwiIMiQIPrViTsxVyUj4vvo5EUtFv792PUbF
	NFkn6CkYc6xO8x1GpYuCHWUw4H7w5wd4GjFnJA4c5MM44q6zK96U6X/K9udNeBiz
	UCcXmhBYaIaJqh73jtHsj7RPjKcT2mpVDq3eoLzD+j8mOg/22jc1DvKi9XAUam8S
	UUHz9NZvOeSTWsp7EJolVr6rZ6f8syqQTRW3phQm3c07bG7kP0Gv9Ss7uoi07RHk
	KanEWw==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47w5dpbxbs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 17:03:46 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-237f8d64263so58568525ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 10:03:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752599026; x=1753203826;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=90GpV8+hUwlfdrE85xu/G/2AfYKG3ln+ooGRMjQFTQI=;
        b=QQxEK/VA06mKVQybhybBLlXV4x6LmWq6NXOK6+pEW1tIQMndLBxfbqxL2KzRap3SA/
         qykTjcbKOtQg2V+JpB5v3Cg2sr+fkvhC67F59eKik4CDck2IyPWNhsHp7qLsuVW3l9U1
         /cOhHpMvbnzAqtX2r27RrcwCBatAWCoBuDqRSE+sqAYaYPxlu3Z76ExyE4uCdapPFYrL
         Hbr+sDk6KbSMLqJoXzTNS7NJP9DbZUUoF3gbkvvdmxI+/CkYBXlXC/J1FhgnKJXsDH8c
         5U+59/gQgX7YdGhmcztFYGA/Fpy+abF5EZO6W8rMjGjonBmSLO3tv9qO8BIFT3N7+UPL
         GF2g==
X-Forwarded-Encrypted: i=1; AJvYcCUEmyqqMt2Wv6MSQ+wyq8RGXy9sc1x8z3I6xRm9UyK1qUDEFM2e/oCjQKwo6FVR8aCipJVXMrgjO1VY2mg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7GeMUCqv1jcs1RIwW+h1WHKvAvoJQs4KUgCK7ifoOvcKrie0e
	iG6mvxftOXpOxY88GIGhV2hWuQcc7Z3KveFWmUqkP9t0d9xczHwXflMH/CstLqRpsaRTtNRRLpX
	2zruduSiuqIg4iGPapMqO7yU8/22cApVeOhNT+IK0J55srflyFGI5Yl8Wwp9Y73kztfU=
X-Gm-Gg: ASbGncsA3byW7eFVe08ZDmbLNFrRKeQnY1aJ0RUKYeu4ML9pIR4zu+3NbwOdOwmTEMv
	0kfRxxzzt1kWAGoAKKVW/+Md2iRXU6vW92TLX9PzXqGd0j5zWSmCNwuwoIm4mRkq/0+o1vi32VR
	Ia5gbGdNT4ruqdTU3tbWufOTtzbn5zndw5qyB4qLxPFHM4qRD5hmZ7ADLMjPTo7rfobccJdh1hn
	6K5b7Rh9iXZkXRYDgDkDp+eTOQJYyjpJToevqLLAQzYjalJ86CsI/1NFnZx9VySSY+yRGWoBZiC
	60S8pzqt6hAqrZtDsnzxHQyCzRLQzNcz+RsJ/Mdlt88QUWGOV6c/y2/YcGO58l8wROqSGPnOntz
	T
X-Received: by 2002:a17:903:1448:b0:234:cc7c:d2e2 with SMTP id d9443c01a7336-23df07da8b3mr303638935ad.1.1752599025830;
        Tue, 15 Jul 2025 10:03:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF+5ygamHAh1vx+QECJOZ2mYRZ3B1D8qXh5iQiUIr+MN993YDsA1qSa7iS48ILhmJyiSBMqUQ==
X-Received: by 2002:a17:903:1448:b0:234:cc7c:d2e2 with SMTP id d9443c01a7336-23df07da8b3mr303638435ad.1.1752599025297;
        Tue, 15 Jul 2025 10:03:45 -0700 (PDT)
Received: from [169.254.0.1] (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23de4322cbcsm118733715ad.137.2025.07.15.10.03.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jul 2025 10:03:44 -0700 (PDT)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: Jeff Johnson <jjohnson@kernel.org>,
        Baochen Qiang <quic_bqiang@quicinc.com>
Cc: linux-wireless@vger.kernel.org, ath11k@lists.infradead.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20250603-ath11k-use-non-atomic-iterator-v1-1-d75762068d56@quicinc.com>
References: <20250603-ath11k-use-non-atomic-iterator-v1-1-d75762068d56@quicinc.com>
Subject: Re: [PATCH ath-next] wifi: ath11k: fix sleeping-in-atomic in
 ath11k_mac_op_set_bitrate_mask()
Message-Id: <175259902445.3668196.7323548526989354054.b4-ty@oss.qualcomm.com>
Date: Tue, 15 Jul 2025 10:03:44 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE1MDE1NiBTYWx0ZWRfX13hkdBlcG77o
 mqZVd2wJa0mHZGkNT/3AiDcRxwMvRHd2f6qOgsJOfdErREjxOGzTROVlJbsMqGPYM6UKtwX/6Hm
 6SjcPo9syPzxe7rKYT05O0FHPD1jxLQWRiysYk5/X15MSSujrF9RP9FuJxPftYxBw3+SJfT+xTh
 A3Dr+reCcShTERjYe+zKNwWNHYxujHNDdyoHSPldXbqYpXlq++rSY4wUVgjYie3Ip90UBzy/ox8
 Hvig1zQpfqivi+MirvaiM920UH7FDJTHlsemWDDMQOTRZvHL8BujWtYFJXOQa2d/XEROtI72nUf
 NroBiHMcfkgDah7T6OejVpkpyIeARTHUCOZnx9DE87EIhFp62W/QHwrV5TIzdxr9zxnQA+zoL3e
 Jly2zADaxY4U9uLWmShbqbSAHxSp1xX6F4lfAG4sqgpk8T5rgFzapjK1LINQyBTeqWbYgHex
X-Proofpoint-GUID: _vqqC0w7mJKQXRgTMsjw-1WMzfkg-qmE
X-Proofpoint-ORIG-GUID: _vqqC0w7mJKQXRgTMsjw-1WMzfkg-qmE
X-Authority-Analysis: v=2.4 cv=Y+r4sgeN c=1 sm=1 tr=0 ts=687689f2 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=MkI95_h35qG_dB8Vl04A:9
 a=QEXdDO2ut3YA:10 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-15_04,2025-07-15_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 mlxlogscore=835 phishscore=0 malwarescore=0 priorityscore=1501
 adultscore=0 impostorscore=0 mlxscore=0 suspectscore=0 lowpriorityscore=0
 bulkscore=0 spamscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507150156


On Tue, 03 Jun 2025 10:25:28 +0800, Baochen Qiang wrote:
> ath11k_mac_disable_peer_fixed_rate() is passed as the iterator to
> ieee80211_iterate_stations_atomic(). Note in this case the iterator is
> required to be atomic, however ath11k_mac_disable_peer_fixed_rate() does
> not follow it as it might sleep. Consequently below warning is seen:
> 
> BUG: sleeping function called from invalid context at wmi.c:304
> Call Trace:
>  <TASK>
>  dump_stack_lvl
>  __might_resched.cold
>  ath11k_wmi_cmd_send
>  ath11k_wmi_set_peer_param
>  ath11k_mac_disable_peer_fixed_rate
>  ieee80211_iterate_stations_atomic
>  ath11k_mac_op_set_bitrate_mask.cold
> 
> [...]

Applied, thanks!

[1/1] wifi: ath11k: fix sleeping-in-atomic in ath11k_mac_op_set_bitrate_mask()
      commit: 65c12b104cb942d588a1a093acc4537fb3d3b129

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>


