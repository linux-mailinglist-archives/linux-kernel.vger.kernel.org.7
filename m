Return-Path: <linux-kernel+bounces-878906-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E7FFAC21BE0
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 19:22:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id ED8F54F158D
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 18:17:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D2902F25E8;
	Thu, 30 Oct 2025 18:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="CsJLpYV6";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="d/RUqlv3"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17B301548C
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 18:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761848236; cv=none; b=U+IWKvG4xtf/5VCPAeIlMWnZa8/PLd3OWzh5JXDPV9X8VrkKhJBSMc1phHFErfJeMZUhbOG8R7MVhXdIg7U56rzWIV6u0A8GIfAYOzuVQiaQ7smgSVpQT6Ha/5GqDZEws1DpO4UC2NC8RBgtakNAWf7ZuU608XVduh6+FOGVQM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761848236; c=relaxed/simple;
	bh=kg2axgcnpW6DqaCJznMnqgUT9/KOPAXong7uCAh4+yM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CT/QkS9o7xdcEocqyOY4X3GYE50pWPt0IPmqRoqHhdcMNrDHqHv0NLZ9bBy2xRCEzwtlI2G7v1luPFRtVjRo/lsGUiz8RXspps8r7CHE0FCs7MQPo+b7RbyzbIQZm1WrcCV5UEUyuhGmGQkGZ7JDMPW2Yu1cVMm43K1TJ3K2dGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=CsJLpYV6; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=d/RUqlv3; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59UHhAtL3117126
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 18:17:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ukOAiwegom4AE2DEzGWyvCrTZUu6l9n/cjr5gBCddxQ=; b=CsJLpYV65PXyyhOW
	stK5fWK5ToutD6M5bdb0sn6ErWtTB7MZ4ojsH8d/38UtqQPcujj7WVDgLmG/h07X
	8ybW1fOj7hXBQNDksBbJH0byMlxyoeGUK8JYBTh8gmL6Hwxrk5VYT6KtMP83e1f9
	9OmIKmq3+LalMUeLDd//R/quGXGmRoTxGQZHQFqNLHIA2cW448QBlp93+pRp3z9C
	AotsvEB7NQwCgNf4Hogb+oKi0vrdM0V5BhbgJDz2T2SSmY65UKyk9CK0O5ExPcDO
	o37aysexbFrO4aZhLYOh9i33xRTQ9TiRQ6Xwvdl4HqZ/iasEWXMsszVN9rR/D0St
	I2iCZA==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a45frhgbn-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 18:17:13 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-272b7bdf41fso18119245ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 11:17:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1761848233; x=1762453033; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ukOAiwegom4AE2DEzGWyvCrTZUu6l9n/cjr5gBCddxQ=;
        b=d/RUqlv3e1kRHwBR1eA8BsIVkaQaqisPX4cE6m5VN4wswe/KAKCp9coJx6iAdMZti3
         X4atolyjAwLPWxZ+GSOs33Vr7jf0cc+LtrLt87jh67dbAbLQZmyXxsnLiAg1vMJcNQ0S
         RyM0svEzYxOm01BGMXdPcmWwqIL9OxPYWSDq/+BaqZthMCqlgaFsKGG+EExHJmrcTlQB
         cFewzgkaJecBRMTb2omsivKGycRM7enALPcp8sd6yaXZour7qgTnjiO3SY4Xlr6iUEtq
         wWVb9IdthB/cf9egnbyzanfLabD0rhJwSLOdxNl8XLuFfgHlU0ocIt0KYYUM7kjuKwpM
         w14w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761848233; x=1762453033;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ukOAiwegom4AE2DEzGWyvCrTZUu6l9n/cjr5gBCddxQ=;
        b=t9yUF3/6oNEw+GdItGmoPHGxjJczLLEYzgpf4lrx/i6XqKfisiUmqvsj+scrvqijbT
         3Jx4J/zLleUCfWMYK9455yRNM9xCtoY/ijB6eE0U0DL0rRpmB9vJBO2fZLG2BRQCpI+R
         3+ZpsYyDYSgdS78P21OPYCK0Xg2uNzmU8D6kVDDgSF6+xT69joS4ho2GA6bAR7ZVUP6L
         hEPjx7d7BTJ7LoIbXPiNZbzArdzORYVDpzA7SFXXUnScCZf4gVCP8xR6ZElddoIAtOx6
         hU4u4EONREp351YGtIEdSDqTDiUVZuubhPmGGmKHT/wv5H8R48xXfhCYvbKUV87j0tWe
         /bXw==
X-Gm-Message-State: AOJu0YwmLqw4IXhN0alYfjC60XCVTOnXB1gZ14mN93vIiq7I010bA8RT
	tRnUe30hNGfXs/1WcbZYoMkDkyGWjS8SmsSRmSmU/Ka/j2MHva4utQ5rz18ueCz05RAFc8p/tqI
	eyv+rGDAnI3jeEHHJ/uO5CZ3wusaDDva1gaB95FZdzB7PsC1lbBsjsxPl1ZJyaVGl8yQ=
X-Gm-Gg: ASbGnct8Fqn/WT28Ixwzw3HW4i9Lp7gwgQAqqazQMwx0qS/w/klRBI94K9cCNtYQK1s
	AIdAu+4tMzHywW6WLFXeiGXxDYcrrL2tuame5XJ2NNTwpOYOXLOh1oCTK7n3IKwSsEEmigIr/25
	em0crYTHTKQXjM+4uE9OZUl1yI/x69dinv4djtfO3JY+HBgA+ZcMXk2O8Vq0Oz9hGeNOjcTCzGg
	lgDLuTELVY8R4Dc6lf24qMYSsXbnSON/E5Zq9ZMjB3wyZkbwox3nPPaj5HdIRHvHLfP9neAfJZe
	UMvL0s+MAxmItowRyQvEgWZwo1+USSuGwwnEx3QRWenCxJTNtErtbQHW9jpcW1El+I+YjLa2h5y
	82CQ2H99VJxBubZj1DngzwzD2J/xfVQfkId9hlqP4y2DTVvtlqEc=
X-Received: by 2002:a17:903:3c23:b0:294:7048:643 with SMTP id d9443c01a7336-2951a3981fcmr9783705ad.15.1761848232673;
        Thu, 30 Oct 2025 11:17:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHLtTmQxZPJXadN3yxRt1WMDsinLARvPN+Zc4Ke3Ur2NA0AUQYwVjva0B1WQ9P3HPSMFkp6xA==
X-Received: by 2002:a17:903:3c23:b0:294:7048:643 with SMTP id d9443c01a7336-2951a3981fcmr9783085ad.15.1761848232055;
        Thu, 30 Oct 2025 11:17:12 -0700 (PDT)
Received: from [192.168.225.142] ([157.49.207.190])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29498cf4b0csm192683585ad.10.2025.10.30.11.17.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Oct 2025 11:17:11 -0700 (PDT)
Message-ID: <3a06ddc1-39ad-1192-e44b-0dbaa1352f76@oss.qualcomm.com>
Date: Thu, 30 Oct 2025 23:47:08 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH ath-next 0/6] wifi: ath11k: Add single shot/periodic CFR
 capture support
Content-Language: en-US
To: "Yu Zhang(Yuriy)" <yu.zhang@oss.qualcomm.com>, jjohnson@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
        ath11k@lists.infradead.org
References: <20251030043150.3905086-1-yu.zhang@oss.qualcomm.com>
From: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>
In-Reply-To: <20251030043150.3905086-1-yu.zhang@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=KupAGGWN c=1 sm=1 tr=0 ts=6903aba9 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=CMr6UP9dfYAYc02HN5pMZg==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8
 a=dwuvWDSKMyNAM4JwnMMA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: U5uGHmDqXGll1f9ZC2_-FAt08_0qGomE
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDMwMDE1MiBTYWx0ZWRfX4r/fzljm2BbR
 c85T32wS6ltjQg2L96QSXE+85c+uisok/dSiT5JTeu++CzDpFjTVlMRlUpLjmjdWPAf/cCD5FtV
 Efo4xgERdXqx3EwcODPW8480wxFCdAqruc4y3+3rjPatneN4VPNUjbcLInHBCxYpcmRnWpT8Pec
 qi6qa/UQfTgbAwX/G80UXiHCaf64tQJXoGDFs8S0VgWgULQRtVBGFiA5KhraQDql1/zQ87cTBmx
 b/OnxhtZqWWF54LO4y0XtE/cFqNBc0GnK+0d9l6UtDsAEONoDg3e7Q3gcDSiPAvY6+p378UbZXI
 9V+k51tGU9sVya2s13r6foTsGrp5rJEftuniKLfhAbf6H0Sc92bRCCzlMWSt4fbkOTSCCQ9gdkV
 AFQ2U3lLpsJULfQgv8hP9lqL+/ys7g==
X-Proofpoint-GUID: U5uGHmDqXGll1f9ZC2_-FAt08_0qGomE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-10-30_06,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 suspectscore=0 bulkscore=0 priorityscore=1501
 clxscore=1015 spamscore=0 impostorscore=0 adultscore=0 phishscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2510300152



On 10/30/2025 10:01 AM, Yu Zhang(Yuriy) wrote:
> To enable/disable cfr feature use command,
> 
> echo <val> > /sys/kernel/debug/ieee80211/phyX/ath11k/enable_cfr
> 
> where, val: 0 to disable CFR and 1 to enable CFR.
> 
> To enable CFR capture for associated peers,
> 
> echo "<val> <bw> <periodicity> <method>"
>   >
> /sys/kernel/debug/ieee80211/phyX/netdev\:wlanx/stations/<mac>/cfr_capture
> 
> val: 0 - stop CFR capture
>       1 - start CFR capture
> bw: CFR capture bandwidth
>       0 - 20MHZ
>       1 - 40MHZ
>       2 - 80MHZ
> Periodicity: Periodicity at which hardware is expceted to collect CFR
> dump.
>       0 - single shot capture.
>       non zero - for Periodic captures (value should be multiple of 10
> ms)
> method: Method used by hardware to collect the CFR dump.
>       0 - from the ACKs of QOS NULL packets.
> 
> To enable CFR capture for unassociated clients,
> 
> echo “<mac address> <val> <periodicity>”
>   > /sys/kernel/debug/ieee80211/phyX/ath11k/cfr_unassoc
> 
> Mac address: mac address of the client.
> Val: 0 - start CFR capture
>       1 – stop CFR capture
> Periodicity: Periodicity at which hardware is expceted to collect CFR
> dump.
>       0 - single shot capture.
>       non zero - for Periodic captures (value should be multiple of 10
> ms)
> 
> To collect the cfr dump,
> cat /sys/kernel/debug/ieee80211/phy0/ath11k/cfr_capture0 > /tmp/cfr.bin
> 
> Previous link:
> https://lore.kernel.org/all/1645005922-7252-1-git-send-email-quic_vnaralas@quicinc.com/
> 
> Signed-off-by: Yu Zhang(Yuriy) <yu.zhang@oss.qualcomm.com>
> ---
> Venkateswara Naralasetty (6):
>    wifi: ath11k: Add initialization and deinitialization sequence for CFR
>      module
>    wifi: ath11k: Register debugfs for CFR configuration
>    wifi: ath11k: Add support unassociated client CFR
>    wifi: ath11k: Register relayfs entries for CFR dump
>    wifi: ath11k: Register DBR event handler for CFR data
>    wifi: ath11k: Register handler for CFR capture event
> 
>   drivers/net/wireless/ath/ath11k/Kconfig       |  11 +
>   drivers/net/wireless/ath/ath11k/Makefile      |   1 +
>   drivers/net/wireless/ath/ath11k/cfr.c         | 991 ++++++++++++++++++
>   drivers/net/wireless/ath/ath11k/cfr.h         | 301 ++++++
>   drivers/net/wireless/ath/ath11k/core.c        |  41 +-
>   drivers/net/wireless/ath/ath11k/core.h        |  19 +-
>   drivers/net/wireless/ath/ath11k/dbring.c      |  50 +-
>   drivers/net/wireless/ath/ath11k/dbring.h      |   8 +-
>   drivers/net/wireless/ath/ath11k/debug.h       |   8 +-
>   drivers/net/wireless/ath/ath11k/debugfs_sta.c | 143 ++-
>   drivers/net/wireless/ath/ath11k/hal.c         |   3 +-
>   drivers/net/wireless/ath/ath11k/hw.h          |   5 +-
>   drivers/net/wireless/ath/ath11k/mac.c         |  17 +-
>   drivers/net/wireless/ath/ath11k/wmi.c         | 147 ++-
>   drivers/net/wireless/ath/ath11k/wmi.h         |  97 +-
>   15 files changed, 1816 insertions(+), 26 deletions(-)
>   create mode 100644 drivers/net/wireless/ath/ath11k/cfr.c
>   create mode 100644 drivers/net/wireless/ath/ath11k/cfr.h
> 

Reviewed-by: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>

