Return-Path: <linux-kernel+bounces-739503-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 03993B0C708
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 16:56:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C1055188BB3D
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 14:55:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8EAB2DCC13;
	Mon, 21 Jul 2025 14:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="PNXilcgU"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80FF32D5A01
	for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 14:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753109709; cv=none; b=jOH0kuqbKojBRGiFzoPGxog4aGnlPko2NYRmhBqa6nAuGHEG8C/0XUMfVLA+iPlaRJwaIbXQFLTFo0LYpC9kofOM/8LrcFDfvb0IyVv9ccFEy419M9ZbB1KCEkPlI4MEpEFDiS6/rACAk8IW2ugnw5StVu2JzjUTTSbRuvLLh7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753109709; c=relaxed/simple;
	bh=eu38xfBfAicNC4yirAnVz/9TXXLd3ffTXfWGMol/+Sg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mpE+45bqO1HHLtyGOEQyea0DYF/4ixLuyQZsF7q95bTCDAXVel7IyD2h0LHoTKn6nJtVhh5FkvwqKK5QB12AJbSQpvErwEh4+Fjk0JI6Yfdx1Hl0cOxv+NaFxPAR9HyOiTt8pHxsvhomsUu4qNGsl52iLGMv+0Td+fi/RSXXJmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=PNXilcgU; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56LEfJ4A012944
	for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 14:55:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	FejjzcessRXamuxdGef6IiWtk5XK9CE9N5H4NCWgoR4=; b=PNXilcgUTbMv1ouq
	A1YYn1t4ZKuvtrEsH12jT5n1aov+zYfP8o8+0WQP6+kg+4OMdpBurm8ataI9Yw75
	bbL0Yuj0mw33YiN+G0TsVc/fEtdvAlMObpiKSDHgHN/kWSajdPZTh3fpciqa6t8C
	qL+bU5nSd7BjCvu2t8EM85mbo79+Us41V0/xkeqOzmqQVcJPubC47CzFtQxj7Hhp
	eLjnJ3Mb8iHwtdJJ6ZiWLFTen9nj9Fupt1Anrm7QLGUHBPiPp3hwY8sljekyf+iM
	bP2He1bdTd/PcUuemlCkKHgrM4DrGv2NGBWc143uV/VLaZFYJX6GQAyu92P8iToY
	r4oAkA==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 481qh6g1ud-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 14:55:06 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2355651d204so38510845ad.2
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 07:55:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753109705; x=1753714505;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FejjzcessRXamuxdGef6IiWtk5XK9CE9N5H4NCWgoR4=;
        b=JLVg0KMCl8zVrxgoi8tNjQgphV2goS2ssAjl5sSMxUlPdnlE51iW/96MnqITeER4Q6
         gf6+mey03gDVCrBTpxVN4C2kYYznbkVGaUUfeIN1CGfDp9OFJfJweP+47kZcW+P3Kkq9
         DXv2kQI6/JJWTrRRdljLs/vrHF5Jdt9c2dsARZCrGLoY68QaH2MTmFyhRObEz9vI5oNi
         GaggbGLQB0lte52cknRtvHRbclIkkEu6Fs4z+Cv683cSxZy07ILPLyTUQaBx7jBXJ4Hn
         Bsqooa6NWAg00gQWqiV24yzO3RVp0WYLqA91HX5xh4e1DLgTMWW5zPtJUfcgTkzk2aaM
         2aaA==
X-Forwarded-Encrypted: i=1; AJvYcCWt+Mabkle3xKShhMdUK5nD67+HiaOUcwgUJ+WGtoR0FxRgpGeA9SN7jwA6Ns71SMsrm5YO+KKTXnVPFQw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwT3evsHNlE9Ze4GymgG/ss+mv/bCo+DbLOT+PX49Pa4iRvqU7K
	fct+QJELvN+fEHhikNpUa817keySod5kGqGKzAhiu4vS4VkDVlhGvFdON/rKEqAXDwdIpsc4llN
	MCf2v1V6oxKW4FkiUSGDqXZ185ZfohX33cEUOwejb0tU7FXbunL6twwC7VSREJXAPr48=
X-Gm-Gg: ASbGncuPtysYScsuB0s8ppzK0C/lGg37i8Wx8WOYPZvKSJk8wBc4oaClhh9cZtt4COI
	rKPeOQRW5Ajlt1up4qqTe2FxHU6gyKSXU24xElLF/1sJz7LXlIKtxG28shSdN6RmROEd+WxrgXC
	gyNWfOwtvXKOoq+nqUrYUTloEW3Vi/gWOS7OpugcacaPzWEq2fISeUOEGPsaB6NGLehn/hUTOjt
	4C+juMzlIwRdqGYPGvtouQJrMwBgF/lH5pYG8G4Ca9F8Eeexihd0jUIMZ/VlMNkWvQjHGHMfD6Z
	LN01FhxyrucwhjnRXu5URgMvrLEIM13YEM3YwYg9EuaNGuBTxsDbwvuDU05cGVJhGnt7zxkn1Ox
	RTuJ7WlUngLEF/g==
X-Received: by 2002:a17:903:284d:b0:234:f580:9f8 with SMTP id d9443c01a7336-23e24ec73bdmr227526155ad.3.1753109705038;
        Mon, 21 Jul 2025 07:55:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGJ97391DW7uxpfMEy3HG26NDZaHXwi2jparAOfw5+iKlWu2Jnai8JQP+g81zAyqSEzBAX4EA==
X-Received: by 2002:a17:903:284d:b0:234:f580:9f8 with SMTP id d9443c01a7336-23e24ec73bdmr227525925ad.3.1753109704562;
        Mon, 21 Jul 2025 07:55:04 -0700 (PDT)
Received: from [10.226.59.182] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23e3b6cfa0esm59073595ad.145.2025.07.21.07.55.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Jul 2025 07:55:04 -0700 (PDT)
Message-ID: <b48c6694-2bd1-44d0-9dd1-1b7a67e22d87@oss.qualcomm.com>
Date: Mon, 21 Jul 2025 08:55:01 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 00/10] New DRM accel driver for Rockchip's RKNN NPU
To: Tomeu Vizoso <tomeu@tomeuvizoso.net>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
        Oded Gabbay <ogabbay@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Nicolas Frattaroli <nicolas.frattaroli@collabora.com>,
        Kever Yang <kever.yang@rock-chips.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Daniel Stone <daniel@fooishbar.org>, Da Xue <da@libre.computer>,
        Philipp Zabel <p.zabel@pengutronix.de>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org,
        linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org,
        Robert Foss <rfoss@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
References: <20250721-6-10-rocket-v9-0-77ebd484941e@tomeuvizoso.net>
Content-Language: en-US
From: Jeff Hugo <jeff.hugo@oss.qualcomm.com>
In-Reply-To: <20250721-6-10-rocket-v9-0-77ebd484941e@tomeuvizoso.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=CZ4I5Krl c=1 sm=1 tr=0 ts=687e54ca cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=e5mUnYsNAAAA:8 a=DISFzqtZAAAA:8
 a=I0N-cO3Jf6GV4mgy0ZYA:9 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10
 a=GvdueXVYPmCkWapjIL-Q:22 a=Vxmtnl_E_bksehYqCbjh:22 a=aug85vrO5LANNmmtkfAW:22
X-Proofpoint-ORIG-GUID: YF29v4WaX9kMKnecUdcjygeXbQ1iMgU8
X-Proofpoint-GUID: YF29v4WaX9kMKnecUdcjygeXbQ1iMgU8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIxMDEzMyBTYWx0ZWRfX2JmRIADrCxPd
 cb3B0mg57pszj+sdOKi/pLQPaENPWhRhRwLoUFIqTQ02/MjmaRtuAaiBYkzwX6zefIw30cbICNK
 LSuoWgR8US/VaJg501hVIelhYVeOCCHAjZiVpGOu2uNqPUMu0XdqNjDWdEwYyD/0ub4lY+PUv5c
 zJSahAlWNJbMLS9aXmm1jdpb8U+oQaQiM9oXB4P8uSU4p7bFCX/XvULLIlWrx2UJDOBjMpNy+Kq
 7ZTwuwpGIxYO8Z2fJTmtSO7PFxLaOwcR+iChlPCsRqfLWzy4Uz+OGdyl3hO4boVBO7Lz8eLblSl
 qvuqJYiGmmvtF4cJ6oOZ2XbuZJlUPfmf94WgyeAiac1Hiqsbz/vXO6osZPtt8cvN3+X8XeNrX9c
 F6uci78RfhPPFkkWz8fLWV75xLeyFLqAII6KsFvg3CDIEO0sOQEt2G+GNLG6t7pxkfvVEfw5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-21_04,2025-07-21_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 mlxlogscore=799 impostorscore=0
 clxscore=1015 mlxscore=0 lowpriorityscore=0 phishscore=0 adultscore=0
 bulkscore=0 spamscore=0 malwarescore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507210133

On 7/21/2025 3:17 AM, Tomeu Vizoso wrote:
> This series adds a new driver for the NPU that Rockchip includes in its
> newer SoCs, developed by them on the NVDLA base.
> 
> In its current form, it supports the specific NPU in the RK3588 SoC.
> 
> The userspace driver is part of Mesa and an initial draft can be found at:
> 
> https://gitlab.freedesktop.org/mesa/mesa/-/merge_requests/29698
> 
> Signed-off-by: Tomeu Vizoso <tomeu@tomeuvizoso.net>

This (and the userspace component) appear ready for merge from what I 
can tell. Tomeu is still working on his drm-misc access so I've offered 
to merge on his behalf. Planning on waiting until Friday for any final 
feedback to come in before doing so.

-Jeff

