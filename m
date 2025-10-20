Return-Path: <linux-kernel+bounces-861130-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20995BF1DA1
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 16:31:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A52B03AD79D
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 14:31:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE0841E32B9;
	Mon, 20 Oct 2025 14:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="SlqvTeos"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDEB81D88D7
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 14:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760970681; cv=none; b=Nv+Gc78HNAe5Mj6VlTLR4ofiIh+x8tCL8ZribgoQ37NOhwk32jw922shesFozcZiuTXHOMKAPnjcVAuMeENwHYtmXWFzVHWx2tXDa0Fg6q8Hvj/K7IdL6qzoObpAVwYMKvRrnzvFW/ihfydJa5ze2lXwMa7hzC32NC5dGwWqB8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760970681; c=relaxed/simple;
	bh=AWZ5JEQErQEgkIxsRTfnsV0dbvBu3BBNbNNvaGHfU1g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ak4z/MApPyRytxhFg32w7UPD0UEHCiFWbjj+8HmCM54maz2k2Kq+XaXgnrQrmP10eYRuWO6dDnr9CgZLIjk71Prub0ARkIi0BiSQXB9/pDRY8wWgzG9rB2SxzoqECNkJNv1xO/qEJqATAXFZLWm0YfW6DTGwNA2vent+KUoVmPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=SlqvTeos; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59KCDkpR024863
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 14:31:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	WDwzWmcq4AKDGdpNvyveTUSafU4v7snQckB7LNYwDV0=; b=SlqvTeosTjNrJ8Eb
	sO4+qHexPJuy7bWwTF+Ezj/j9GZBx+dQ1f6a0pBbXo/5d7D5JbgcePTZ3iMUJnc7
	44cOs4QlAuJx2EFC8s0D3pwXt/cgbZffLJ3h+yL40mn2OCUOoBcy7gcuqr1P+8Ck
	S8g9juUcJoUjaoanE6I+bUt8x4sbEtUoPjJe1NW/sQehaVJTATCjxWmpY2Tm7eXs
	PYCj7ZWIMRJGW1KmLCR64VSm+NYR8L7K91Po4vrao/Zu2BNyZLDKc6alu5yjnCup
	C2UqdSFVLLoAVp94yhTIS0TSw3D4aWeRrV5dsjWIV0sQjWlMQFIWl1WKu/JWvKlC
	D2D/PQ==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49v1w7w3cp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 14:31:18 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-87c14264340so78054736d6.2
        for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 07:31:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760970677; x=1761575477;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WDwzWmcq4AKDGdpNvyveTUSafU4v7snQckB7LNYwDV0=;
        b=uqoaNqxuEgl//3rJCAe9TLj3fvpgKYKCdNjfCD9pVj+VXmnJEGPzEO0XKoQr68EKup
         FiArMpoUpZ/utyZavYzfDaqZ5ZMR6yW6gtHmLJtIkLJ8ZUoHurKCnRwc0pcGeODSe4uF
         2sWAjN3SsAkrX8EmVl0d07SDSocIUEa7vJhECaTXR46CXNYaZ2Y0AwNBE2jqi+m9kqxk
         03hi3RSPS59WL3h7HSRna+xCnuF5UI0d0m/DSGSYQovrlleQypK77GUf3TRspuTGYTRq
         vetaJH1CBUwvA1xmu+lU7n4YRf+rDo8D+TcHB2AJ7+N4Mtlxhp0h1qRXm7bu495J9Do3
         7N0Q==
X-Forwarded-Encrypted: i=1; AJvYcCVkWTJraURWBEIr6NlstMAW+Rabzue26X3qst9vJ8jjfjHmZEvUvIpl7CH8Pt7H1CHdhFxC7MBNtZvs/EM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDg8LDthvkBs81YCG0BHn+KH2SPHz03WKdUjoaJ0mnBTvKDFYW
	Mnk+hqYhTJ+2sd7QJp7IAJNSYoq7B1X+LWV4JBQL7bAi/KsXBoDyx8JBTtsGD+tSqrmHftTtcDh
	VRFbzl5jF/VcJpcH7jTjBaEcwKCT/0ya3h+L5tCYtCxgy5LXlvKCIcungZiB3rNs2ei0=
X-Gm-Gg: ASbGnctGNkxFAUKkJMtFiHYbKXo+ODLyIhOIbSw8j6MD9IEx5no19iVnQ3G/wPSJlnP
	KCkSW8xZA9z4Cz2/Ho3ZM+p9iV/qU1fbBg5FGQIsZcHHa5YyRwAfguwFsPBhGpBR6eGy5mtFPVe
	izcthm7+m0lM0/s6Vajvkno3D1OSS6kjpPSbDJK3d40IiXfxGiO7g7peOFr1XD8iBf+EB6oECD3
	YBD6n258CrT/Y2odQR2+rzuvSqnjf6LqAJWjybxhvLQ72eugCDDnTTH56hILiBvsjrZs0S7t4q1
	RcQ094SfsDl2iBvtiV6vYo0u1uL76MMaG1DLF9JYnKLaOF21pyosRrm5UmfsYpx2jJwXZGUiIGd
	q852k1/tZBQQGJEr1Y/YgLOF8cA==
X-Received: by 2002:a05:622a:110e:b0:4e8:a9a2:4d50 with SMTP id d75a77b69052e-4e8a9a25039mr160564851cf.41.1760970677202;
        Mon, 20 Oct 2025 07:31:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEos+8Az1kXkegLkZkoK78dfEsCGhaPacnWf31fm6ldL4T9xO4u7snVWYRJLwJrJQGi8f6MRg==
X-Received: by 2002:a05:622a:110e:b0:4e8:a9a2:4d50 with SMTP id d75a77b69052e-4e8a9a25039mr160564271cf.41.1760970676602;
        Mon, 20 Oct 2025 07:31:16 -0700 (PDT)
Received: from [192.168.68.121] ([5.133.47.210])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-471553f8a3asm171487535e9.16.2025.10.20.07.31.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Oct 2025 07:31:16 -0700 (PDT)
Message-ID: <4f394672-c7dc-4fdc-b70a-27fa8e20dd74@oss.qualcomm.com>
Date: Mon, 20 Oct 2025 15:31:15 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] ASoC: qcom: sdw: fix memory leak for
 sdw_stream_runtime
To: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>,
        broonie@kernel.org
Cc: perex@perex.cz, tiwai@suse.com, srini@kernel.org, alexey.klimov@linaro.org,
        linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Stable@vger.kernel.org
References: <20251020131208.22734-1-srinivas.kandagatla@oss.qualcomm.com>
 <20251020131208.22734-2-srinivas.kandagatla@oss.qualcomm.com>
Content-Language: en-US
From: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
In-Reply-To: <20251020131208.22734-2-srinivas.kandagatla@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAxNSBTYWx0ZWRfXyzLA6D9l3fn/
 qhhkMCBp1KU0jXRLQ5UZUtGTYmfEKcGIujqV5RZwTjc2Y6tW9IYWhNQxdIN/ENAdVHgVxGNvWOA
 z59KCnW0enU8a0l6TDXmU/HX7dReVGwQkFtwIvWAiUd3gH7DVSCt8b1sWykmnBxa2YbkumHg3A8
 /QBnT+GquOYObsvq4JEWa6403b7/RmAi6Je1rRMFUEjaPHNkOtuPHnDHzPNnhT4N6cy6kI1DLF0
 iKRCBCXMDue1pY3ks0sf4SkajliXYFvS4k6KKL0jJ6UlS2w4/i/Ds8A7Zzw9/09yxs+872oJQQC
 umaf+0qIWGFRaqaUQB2I1jIlAwciDO61nLOfCBqeiYwUEUlc/tJ3QnnhvIV2k40ZTLKyHdqDPTl
 wo8p76HXPs5psYcLr1ifS2lIyWboQA==
X-Authority-Analysis: v=2.4 cv=bNUb4f+Z c=1 sm=1 tr=0 ts=68f647b6 cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=ZsC4DHZuhs/kKio7QBcDoQ==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=-57JWHKmnLzaxYqXpKAA:9 a=QEXdDO2ut3YA:10 a=OIgjcC2v60KrkQgK7BGD:22
X-Proofpoint-GUID: H8hh6T__J8gQgaYGOaLVhd6BccV4D2Wq
X-Proofpoint-ORIG-GUID: H8hh6T__J8gQgaYGOaLVhd6BccV4D2Wq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-20_04,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0 malwarescore=0 lowpriorityscore=0 clxscore=1015
 priorityscore=1501 suspectscore=0 adultscore=0 spamscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510180015



On 10/20/25 2:12 PM, Srinivas Kandagatla wrote:
> {
> + switch (id) {
> + case WSA_CODEC_DMA_RX_0:
> + case WSA_CODEC_DMA_TX_0:
> + case WSA_CODEC_DMA_RX_1:
> + case WSA_CODEC_DMA_TX_1:
> + case WSA_CODEC_DMA_TX_2:
> + case RX_CODEC_DMA_RX_0:
> + case TX_CODEC_DMA_TX_0:
> + case RX_CODEC_DMA_RX_1:
> + case TX_CODEC_DMA_TX_1:
> + case RX_CODEC_DMA_RX_2:
> + case TX_CODEC_DMA_TX_2:
> + case RX_CODEC_DMA_RX_3:
> + case TX_CODEC_DMA_TX_3:
> + case RX_CODEC_DMA_RX_4:
> + case TX_CODEC_DMA_TX_4:
> + case RX_CODEC_DMA_RX_5:
> + case TX_CODEC_DMA_TX_5:
> + case RX_CODEC_DMA_RX_6:
> + case RX_CODEC_DMA_RX_7:

Looks like we need one more entry here for RB3.
      case SLIMBUS_0_RX...SLIMBUS_6_TX:

Hmm RB3 also has memory leaks for very long time, good that this list is
able to clean up some of that inconsistent handling of dai ids for
soundwire stream.

--srini

> + return true;
> + default:
> + break;
> + }
> +
> + return false;
> +}


