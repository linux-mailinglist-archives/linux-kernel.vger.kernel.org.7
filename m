Return-Path: <linux-kernel+bounces-776718-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D59E2B2D0C6
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 02:48:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 83EF31C2320E
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 00:48:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E4D81917F1;
	Wed, 20 Aug 2025 00:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="DS4DBU+f"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5996F7FBA2
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 00:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755650911; cv=none; b=Px6Uv4x1Ls0MJvBWeXfDlZtw2WqNDkjuVa0bYGfPSI/Dwm5GOReZgG8oFqrR6HnyXV3GTmcENLHxhqcoaJQX9+ldGYzg4puvlee6nieSLZAh/LcG9SO6CHAMySycIq1csZPhdls81FrnJ8NMENz9mRv0mm0nZBi9AXEBEwoKsyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755650911; c=relaxed/simple;
	bh=1St56b53ZeYdOZcOgShHrWsfC2yRYz2v/yjPzB3zhS4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VHU56VdQC58UQD2eGtBkzj9ZRuZGt2jMo5B9dteBDvxrgDvMtPicRPpl+eUe9wBuOPmXLPyClLvAPFjbXfQVz/9vi4rgD8KMNqg2vqfEamfkXps1YRakUnYNJ0tdyDk0KFAnySXISgI+OE9dVTq4fRxDisTNl4bEsW/csBr9pWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=DS4DBU+f; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57JLAkfY000447
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 00:48:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=zxCsAUhNU6df1F1I++Z1eLGU
	QBDjhswursX1dh2wRaE=; b=DS4DBU+fPa9WHAiMUOpGkzofSujP9EjK7ZVT7lbu
	ONhmP2pBEeUTdtOz50SsGdGJ5CIDDsPI+US9g8QewnxebslM/ZUGgm0MHkwlhT4i
	+X+rbSfB0BHj6HKDpp34G/ScZ0wm/6HOLWmXLm9mPZD7eNUB60qDe8QqO67/Ztja
	jBiZ9C78m6VZAXN46HIW03DOnUFBA1/mjGQvog1c+t/QZ9DMCu+D+eVHJhdyPb9a
	dzgDklgjRevYt6Oop7c3TP3L3VA470/vkYWEZQPVbHbK+rAzv3wC0bLoTPL3X742
	Em5AvC26KypiWz37J8cKk82mSY7AF0kJyrID2DqQxTC8ZA==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48n0y38da1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 00:48:29 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-70a8b32a6e3so119155586d6.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 17:48:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755650908; x=1756255708;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zxCsAUhNU6df1F1I++Z1eLGUQBDjhswursX1dh2wRaE=;
        b=b6WwcxfVqOKHd0U0Y425K2smyZR9mA7njT5MDqkMILJhAaZQwUxxFcs5gcA8CYX6fO
         NW6Y6ZJljd8XUkAyR4Yrdy4zfBgbWVWBQs8Yj0/F2nVfYqfn4oYQrI93QpKN6co+JkVB
         vjIwtAIdDaeWETZJJsI5cYCi5+RKQ45Snucb8KTI0XN1Djs5Yn39GNe8Tr28zCo7DolB
         72GFeMIiZuJcSuc1JUlFaa1/KA+E8jOndV6mGAzlsW/jJMlDWf4uewRrxybAiPqVTTNP
         vmjl28Xi0C915QCbGAf8PUBD8P5VrMuuuWI1zfYduMAXFCOZVJDbFft27Un4r5eI6Lzs
         v8sw==
X-Gm-Message-State: AOJu0YwBoO82Cijp/rv7/25HcjXfLP6oA5tZDoGIZaL9rhdu6QRpMc8i
	HYEn9GfOr+57ST75RD7vkXSBR0q2vO4GxL9MJ6W1z6azAbe9NxRdETyPBHgFcGryer1nG+fuIoH
	HI4ZjSpfJzb6FWWOaKXcmoMZSpX2neVjLY5xHxM9vN5AsE5bU6b/6VbAlnDitD+/eBPEgkHL2sN
	M=
X-Gm-Gg: ASbGnct2Ocw8YtqyGoOt4tReVHjvhGY6SCXwsG3R7t0bJLg4E7NMzTi4BUtSyXcYcvA
	ZgZqjMDTQiaWU20KdvSRtm3j3w1Xz7fOnE3RuSj91CguxUvmtblB6ozupB2G2GwtGkNDq+gOOUG
	rK/YfWCp6hKkN0DWG0OW2CCkHkJ0x5fBBmA+ku7uJ5ala8+BJAF3l6xBUGt/kPxVnpn8MGf31X6
	sjUSHLwQt7zeqqryjak4165UOeRYqT0iUb/0fFBkYjhqJqvIHNkfgDN/LkyYpSvYVv5GNBPGh5Z
	F+GTLCjA0CI3NDerVitT+zHItwUoE3eStkqc00XnazkhnAv9rxZ5+Qu+1ykZdT66IrrG4iqMRxI
	L9lOpKO7638+06bC6hssZaUmhsoPldXVuOJ4xnHN1Qj+Y6JVogQXb
X-Received: by 2002:a05:6214:4119:b0:70b:8a30:ecad with SMTP id 6a1803df08f44-70d76f5d7bbmr13343076d6.7.1755650907734;
        Tue, 19 Aug 2025 17:48:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE3X2dMCwIgfJclfhzbEeQSa5AZSTe1W3Eu1uTsUTeRfUaK1fqK3+wI212pgSqH5x66KOuXag==
X-Received: by 2002:a05:6214:4119:b0:70b:8a30:ecad with SMTP id 6a1803df08f44-70d76f5d7bbmr13342796d6.7.1755650907272;
        Tue, 19 Aug 2025 17:48:27 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55cef3ccaf1sm2411211e87.94.2025.08.19.17.48.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Aug 2025 17:48:26 -0700 (PDT)
Date: Wed, 20 Aug 2025 03:48:24 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Trevor Woerner <twoerner@gmail.com>
Cc: linux-kernel@vger.kernel.org, Russell King <linux@armlinux.org.uk>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Eric Biggers <ebiggers@kernel.org>, Ard Biesheuvel <ardb@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Takashi Iwai <tiwai@suse.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        =?utf-8?B?QW5kcsOp?= Draszik <andre.draszik@linaro.org>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Kory Maincent <kory.maincent@bootlin.com>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        "moderated list:ARM PORT" <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/QUALCOMM SUPPORT" <linux-arm-msm@vger.kernel.org>
Subject: Re: [PATCH] ARM: defconfig: cleanup orphaned CONFIGs
Message-ID: <shrn6yrf6tmx2jog2z2qvwmic3vl2tsauhj6a2pdtodnjcciyz@wssbxvgsrjir>
References: <20250819231652.15938-1-twoerner@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250819231652.15938-1-twoerner@gmail.com>
X-Authority-Analysis: v=2.4 cv=Vud6w+2n c=1 sm=1 tr=0 ts=68a51b5d cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=SBwMwNJHQgdzs6wY48kA:9
 a=CjuIK1q_8ugA:10 a=pJ04lnu7RYOZP9TFuWaZ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE5MDE5NyBTYWx0ZWRfX1+6jpv1z6loN
 gnpRDrsXHJtrRqaoVd7oZRRlmWpSAzrXrGP82aRU90B8DcoA4shX1Y98Re70oSVRSR6+A+urWgm
 dUzClf/v2glZj2UX3vBQg5rYacR8BxtobyZXB9TXG0FYQNdRvL13bqM0xJqugjGH+/QNpzRpStt
 xmeh/mjyAia7M5lE/VdXoCiXR6U8059bpe6QLyx2oHp8qfjM0+fEC51WfjZv4DhWCWAyv3RLu/c
 zJQZijyp+I6/Xoy8Dn5k/491Kcbc/7dflgWh0L1GQTAe2G+cayXN5Budx82/JIBO6hZbSHyMS2n
 SM7esuWzSApK9ogQ8cfpvg6LejsJ5EUcKPRmjkSm1nA15l/Vm6nUn4Mm0Xel6i84QoYxbhr1ytM
 67bO7F+U1Q5e7oC04d8yeaLtGvzJ6A==
X-Proofpoint-GUID: MQj9vUyvPGwhjDo_LTN_6HniJCnqeJUk
X-Proofpoint-ORIG-GUID: MQj9vUyvPGwhjDo_LTN_6HniJCnqeJUk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-19_04,2025-08-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 malwarescore=0 bulkscore=0 priorityscore=1501
 spamscore=0 suspectscore=0 adultscore=0 lowpriorityscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2508110000 definitions=main-2508190197

On Tue, Aug 19, 2025 at 07:16:30PM -0400, Trevor Woerner wrote:
> Drop CONFIG_ARCH_MSM8X60 and CONFIG_ARCH_MSM8960 which were removed in
> commit 99497df59427 ("ARM: qcom: merge remaining subplatforms into sensible
> Kconfig entry").
> 
> Drop CONFIG_ARCH_MSM8916 and CONFIG_ARCH_MSM8974 which were removed in
> commit 85148df36835 ("ARM: qcom: drop most of 32-bit ARCH_QCOM subtypes").
> 
> Signed-off-by: Trevor Woerner <twoerner@gmail.com>
> ---
>  arch/arm/configs/multi_v7_defconfig | 4 ----
>  arch/arm/configs/qcom_defconfig     | 3 ---
>  2 files changed, 7 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry

