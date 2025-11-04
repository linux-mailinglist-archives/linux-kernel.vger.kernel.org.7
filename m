Return-Path: <linux-kernel+bounces-884595-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 18668C308DB
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 11:41:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8390D3BC06C
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 10:41:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C1172D63F6;
	Tue,  4 Nov 2025 10:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="GTTStkpl";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="TMZFUPa5"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 068312BFC7B
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 10:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762252871; cv=none; b=rUKu2+wAt52W0kTdYKuI+p3Aa9tqekQU56Ows9W4lEL5VKogpX1oh6ox/9NP6S3x16qhWh/Cj6QEedpowcMPxbdLUTla9oGFBSf5JMt8Un54RRdk/qCM+X5U4vVER5IqRPnKMWM2SL6PfGneZfji5oiDFOJpjlUd3TN1X8JO+qw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762252871; c=relaxed/simple;
	bh=VTjNoC7IJCKV9izbGkIXJaFPw6/9a+4YuIGIkNRYd2Y=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=MsKHw/B0WxAaFRyCtM8xWluP9DEu1JOClRLDik3gB+PDKbryqQVJbmGjM3Xk1f+IOJll/sfK1elGJiwl283TYYF4PykcRHufuSoJtllr9nybMa424xigWWisnAEATof6pkFh1ULkrCYthoEu16urdEJpUHWYfetdpMwTzERZtjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=GTTStkpl; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=TMZFUPa5; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A48g1e71505465
	for <linux-kernel@vger.kernel.org>; Tue, 4 Nov 2025 10:41:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=NxeTrlmBGDcG3gSpVZGnFsRW
	wF5/0SQwtqpCcXOXmnE=; b=GTTStkplAIar+1KrYgT13I9D9xUOchzeymgJggRR
	z3nQ+s1rcd7WuApRidTe+zx+GKpgsZGHd8qEq4glVuDJrURzKKj7fNX6MV+cg8zf
	BJCyuKB9AOqa9ycgV92ZLXU0lZDFnIJZ25PKLmsqzEft+mtW7drqT93WWw47kfhd
	VaKX/XsbR/WeFCS7f+UVv4eoSyc4Y7PEsoEBrzQJxjFDB59JnDvJcXUnqZVenoki
	v7zVe8VYSEhIF2gM5xJXlDPUYcaCv8K1G6GmxHj1aMhQAu1uwa30tBiEfQ1LNKBy
	PIlUwwYWZdRbpWBFdiKwHFMj59c7X34ws9aUOopSQ/1hUg==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a7b6prvxk-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 04 Nov 2025 10:41:06 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4eba930d6ecso154502241cf.3
        for <linux-kernel@vger.kernel.org>; Tue, 04 Nov 2025 02:41:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762252865; x=1762857665; darn=vger.kernel.org;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NxeTrlmBGDcG3gSpVZGnFsRWwF5/0SQwtqpCcXOXmnE=;
        b=TMZFUPa5ikI3DP5/ZnQRaxLhoQ72CbHfT8gVfT0Qt+ak9HTCd9wvlz12zDZdk6BvOl
         c5LvaCRitM1eVxWKOsnu72ChvPGEffjqp/qeEJgnhQssrecG6EQt76od44e2toH0Ub5q
         JvxOy/e6Kbq05wpxuRSY0IsjCyc4QEz3Id2hbYI+RK8vSJcAa5pyQ2MpcDk/1rPBC+TZ
         wnMkXRhL3AkWknKbxrZ+D2xbPQRXs4ka+ulqXx+tockRd0MqK+nhPAk4DrSzaP2RNjqB
         gJYbm9EEzxNVeVyDEpKmTOZ8iQ6+dH0R8ai2c85c09OxX63Vu/UVNezrs/Z5xp+bHZr/
         w/bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762252865; x=1762857665;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NxeTrlmBGDcG3gSpVZGnFsRWwF5/0SQwtqpCcXOXmnE=;
        b=S/ZBK4ZHJY0ofLb95H9FKcM4pYgR2ApbHhInvJFB88lS8PU73CmOFD2ZRvvXouDrQy
         yVpwbi1ooq9YWM7K5CmBL1Pbo2iLC9Jna4Qg6Xrwot17ahhUM/1K48B/QXsxVxoXEkyi
         0kzrZVrjrk57z4Gr1xNmooeiRS9Cy9PN6IyNeB5/1TdOwsNM++u4JC6LYRzgfzmYrXRy
         RkxwdfSofmekp3Kf7IAYQsjXpMWg3I7ID0Jve2pKx/MJkLpsnmeTe+xRNOopibRmUKwQ
         nDGGFVDnR/Jh+v1mpGJ/J3wRFsT4Xqp4EyectAs9ZObXOwLCD/kVbYG5xfs1uxYeiQ5J
         oLWA==
X-Forwarded-Encrypted: i=1; AJvYcCVQKHu6/6zjau+RJdh+1ov6dau44d0ZWeo9m8+G9IzbaA/sieEV0PJ3w0LhvBk42iElxkpUcSLEU3MO7W4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzzvzbHQJkaG8Rp0khLrIDuqJ8DFZy+Zpxskh6Elz28JHyyjJO1
	X+/ZggQdX/HTaO1u4AtpS/GvPeJ6w8A/8f38/D2Yk/FFVLEfatEZrVFoYdrZTSkTRHPUkGRYMvH
	UDuRkyccHJg3wiCRh9fUCfSC79QODd+AXJJ+A0+TGGMMmdz09p3sjgdnwP7aHxuXlTsM=
X-Gm-Gg: ASbGncs8MXI5+sR7eICv2hWICSXSPt5mgX4c7ketjWkMVi7dQE2Pj9E4El6k8eYv/JF
	zCpewoxuouNSU5ZtfFYrcFpVIP8sjM0ajE5/pb5cuFyiVK980md4TE4s1xS2Ns6+mwYMD2J6nNQ
	A+ZDR/WS0VyqlpHS7CuqalcV2O06ApxG1i7cXJVlXJOAhD/71zfOls3gKekOmdcjpW6VBpAM/zf
	g2AZvDCV7bxMObMe37S6yVS0HA2tIwCdBBWVl1a7lWnct2I7v4DkoirYefiPRu0uaAcNO1vFUaN
	I5mOevG/NafnmtOSUWeTLA30qEnKJvEGIRXTvAG+/W1OQAd6U3CQ2J4oDBAe87OIJGwnEN40bzf
	CdZIKcMPqLfNRmg==
X-Received: by 2002:a05:622a:5c16:b0:4e8:b764:366f with SMTP id d75a77b69052e-4ed31002a0fmr162818761cf.62.1762252864931;
        Tue, 04 Nov 2025 02:41:04 -0800 (PST)
X-Google-Smtp-Source: AGHT+IELQ0fZGkTyXHjx104daNaqdc/vSTBykqMsRR10C2OMCEZm2HQNkog9k2/0p9cvSTq2cRY0Jw==
X-Received: by 2002:a05:622a:5c16:b0:4e8:b764:366f with SMTP id d75a77b69052e-4ed31002a0fmr162818551cf.62.1762252864465;
        Tue, 04 Nov 2025 02:41:04 -0800 (PST)
Received: from localhost ([2a01:4b00:b703:c200:1ac0:4dff:fe39:5426])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-429dc1f9cdbsm3817388f8f.34.2025.11.04.02.41.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Nov 2025 02:41:04 -0800 (PST)
From: Punit Agrawal <punit.agrawal@oss.qualcomm.com>
To: Yang Shi <yang@os.amperecomputing.com>
Cc: catalin.marinas@arm.com, will@kernel.org, ryan.roberts@arm.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: kprobes: check the return value of set_memory_rox()
In-Reply-To: <20251103194505.4077265-1-yang@os.amperecomputing.com> (Yang
	Shi's message of "Mon, 3 Nov 2025 11:45:05 -0800")
References: <20251103194505.4077265-1-yang@os.amperecomputing.com>
Date: Tue, 04 Nov 2025 10:41:03 +0000
Message-ID: <878qgmaxmo.fsf@stealth>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA0MDA4NyBTYWx0ZWRfXykedMnmrSohc
 VKZUeiLSrUa50sT1VFxD2YulByi9OimO9n6aPf/hIgwnwE8fDEDm2ERc39M0HPhu9Y/y1zu4soU
 ce2ngrcyiZXF0jjcflFXifMVZqxX8QO9WU1rURsgE7CVSReMJmEj9tJ1WeMfdLzJKwkmhizhGhi
 jYmCNOj98mOfgrIHBsT8qrPMlOsF4Vk1thh/tGmFuHsyDahd7hgcEchDUDLbxVL64TRnYgMTfKR
 S/Z1Nw2LMzQvAJBWj/GMWiTuyKRogPx07hx1F8FmdqvI9MzxKsHILfvSS3F6jOsuu+urlwfse+y
 hYggIAdWXTg8rzlX6x8yHjvJz1W6U83QvBnFHtknzc5fCsnWqa3F6cGPxVXupdbcuaQQKyJK9v4
 AV8U8RcUO6Eed+WROMfoFIKQiXUO7Q==
X-Proofpoint-GUID: L9AsKrcghqzKSSccTF9KQ005qoOihkH-
X-Proofpoint-ORIG-GUID: L9AsKrcghqzKSSccTF9KQ005qoOihkH-
X-Authority-Analysis: v=2.4 cv=Y4L1cxeN c=1 sm=1 tr=0 ts=6909d842 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=6UeiqGixMTsA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=vzhER2c_AAAA:8
 a=n3fbpKS34vtD236G7o0A:9 a=kacYvNCVWA4VmyqE58fU:22 a=0YTRHmU2iG2pZC6F1fw2:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-03_06,2025-11-03_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 suspectscore=0 phishscore=0 bulkscore=0
 impostorscore=0 spamscore=0 adultscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511040087

Noticed a typo in the commit log while catching up with the rodata BBM
optimizations.

Yang Shi <yang@os.amperecomputing.com> writes:

> Since commit a166563e7ec3 ("arm64: mm: support large block mapping when
> rodata=full"), __change_memory_common has more chance to fail due to
> memory allocation fialure when splitting page table. So check the return

Typo:               failure                    

> value of set_memory_rox(), then bail out if it fails otherwise we may have
> RW memory mapping for kprobes insn page.
>
> Fixes: 195a1b7d8388 ("arm64: kprobes: call set_memory_rox() for kprobe page")
> Signed-off-by: Yang Shi <yang@os.amperecomputing.com>
> ---
> I actually epxected 195a1b7d8388 ("arm64: kprobes: call set_memory_rox()
> for kprobe page") can be merged in 6.17-rcX, so I just restored it to
> before commit 10d5e97c1bf8 ("arm64: use PAGE_KERNEL_ROX directly in
> alloc_insn_page"), however it turned out to be merged in 6.18-rc1 and it
> is after commit a166563e7ec3 ("arm64: mm: support large block mapping when
> rodata=full"). So I made the fix tag point to it.
> And I don't think we need to backport this patch to pre-6.18.
>
>  arch/arm64/kernel/probes/kprobes.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/arch/arm64/kernel/probes/kprobes.c b/arch/arm64/kernel/probes/kprobes.c
> index 8ab6104a4883..43a0361a8bf0 100644
> --- a/arch/arm64/kernel/probes/kprobes.c
> +++ b/arch/arm64/kernel/probes/kprobes.c
> @@ -49,7 +49,10 @@ void *alloc_insn_page(void)
>  	addr = execmem_alloc(EXECMEM_KPROBES, PAGE_SIZE);
>  	if (!addr)
>  		return NULL;
> -	set_memory_rox((unsigned long)addr, 1);
> +	if (set_memory_rox((unsigned long)addr, 1)) {
> +		execmem_free(addr);
> +		return NULL;
> +	}
>  	return addr;
>  }

