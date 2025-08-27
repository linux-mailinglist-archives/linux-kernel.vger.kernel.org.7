Return-Path: <linux-kernel+bounces-787515-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 38316B3775B
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 03:46:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 25B461B64CA3
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 01:46:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC1D185260;
	Wed, 27 Aug 2025 01:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="kCN82tVp"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE38514A0B5
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 01:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756259183; cv=none; b=bcpqO3khRvOdVw3TaFjtt0khgLTA3klNy1sGMIrXhCK1gWtoPxjkPWL+uK+CMfvbM6K35t+JBUBxsKlaXlwT2X7qIjXT+NwrfysPQ/fWI3cfLgXwSTB2bjw1HX8M65aOiqmnZf4IC/PcsQagjC5qluPGiAASvsWfiHEXZPNLZMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756259183; c=relaxed/simple;
	bh=uHzyck+siLD+tOu/TdoRD1xQ1q3Iueco2prBlfJYitU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZF+0KlAXqBXv/l4MS87V+V7blr+jmqd30gOvkXMUvOSgzhZGZYOAjEYy/Xelluf/tPx2Axrqx3ess8tT2x84wthPRpepa8e4bfO0sZsjjcPcQJWR8GJ4LIUBQNCv4NAknIwAuv+EKeX+uYuhSF084jk/uznmPRDw3C4YjLttc8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=kCN82tVp; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57QGC5Uw004416
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 01:46:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=Oz3En/JYTYFCxC2EmpZCft1U
	VWMM+pon7GAYlfebkqQ=; b=kCN82tVpnjlVlG+5GA8hsW14OHO79lBv+sxnNDcK
	8hTYBY6cdapB8qYp5TbEjSPS8Y13xllvVGp5st+bYKxEMf3tFQT4EuYLbPwm/Eat
	RLTvV6HGesV/WEc76RCg/jl2IRDvCS4AkTUDxuvXQ5dSoWCtflXcQdVvnSfMAGMj
	jujoIx8y/+3JMMSmYXj6KGH8na3rTbK8poD4vtiYVeR8fSHtbyYccmezELC9086X
	Q9jcX0IO+8+oLfgbo6pnNK0aIN7taEiZ36xoKXKpuHW24XgKOMa8kdTKoZYWkKv3
	61Cpe+ACYsqKLu4KLTw0PMp1n8AmH9y1xuVvBd4wmGbu8Q==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48q5we2s0b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 01:46:20 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4b109ad4998so237231681cf.1
        for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 18:46:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756259180; x=1756863980;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Oz3En/JYTYFCxC2EmpZCft1UVWMM+pon7GAYlfebkqQ=;
        b=bhZEhD1Nq3Ad1zWZYbPWf5QCG3E2RjfSZXQqGaOshAI9PY7qKwxSkY34SwnoQ03gva
         9u1ajnLmrlnu+XFs7cnifbL8iRz4wLksQ71wNj2UquK/s4wVsf5uSE8GwilpyrBqyOqj
         1xAidog93PjZK3W8sPXao7eQ10koBO8jvc1Tay7Ca9IuytYsuvZjIqu/3FG7u9GNxB+8
         3mNkmMJ6HtxANjB6tB6pCc8l0CR7r/b6KnyXp2L1pvqMN8GsbJ1nZiTHfauvkId8iWCU
         Dk9sJLeSELUh3NFTnpqwr3BqHFdrdSHUK8L+x59lXt5jBdPgb6JnEbRPRfWeGL47ZXEy
         eiEA==
X-Forwarded-Encrypted: i=1; AJvYcCUOirsNuGonz9GPdGkYyiZtF7J3Uz+n7JmOLfld/0POMRMUt74IcJGeHlhIoO0m6u/amPZG5Sk0VKbJd5w=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywi2ah2zEU9qpSiDfQ5Pxd/YPQBoSuCbzjAwuPIsAQZykEo3hFi
	7AB2p5s1CLniOZE33Jnbj21uztmAILdvCh69RHFVkThwI90DG4y9X8M3/isHNXmQz/4+RVEFNF0
	nkSOHn1U7sS+xx+OhqUn1KdF30FhaQmFtPNOqg+4Ob6NOOgf0XWAHXKcH69aB2Z4XM6w=
X-Gm-Gg: ASbGncsuwjeU42rDbgflPI8phaQMFfhovzXWMMFy7K2RsGNlImKRQxKpWF0JSvNez8u
	Ffm66GkQGxkiZmElGo0LQu5ON0ehBO3xVEAw6VsfgLioXqaw9DcBojW6xUqahD5Cl6kx/NEJkSh
	aG4r0Wb+KoCUWT1bPez5selJc9Cxhpe3mSFd+SVcqC5sJoevbbotot/CMLq4lVSOfixtRNS/Xtx
	19OqetPjmsgxS31dFGpn0PgXPu0KaHXgV/qe0LK727U6xPEpPbFrDVh5IR9kxrwdLtiKOfvCRyh
	YecLK6h3sRmrQ7i52N8ZEl0NT35TiDOCFn0NZdoUm1hQlda0YqrGxxRbKOoWo3JqiJfI2DwSNbn
	ZZzg7FRI0CHq9wBBhBjI5Q66kI7r9A5SQ0OpA+2m15Co1h8U83KKU
X-Received: by 2002:a05:622a:11c8:b0:4b2:8ac5:27c0 with SMTP id d75a77b69052e-4b2aab513cdmr197290031cf.75.1756259179948;
        Tue, 26 Aug 2025 18:46:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE1nVQaEjGAMalegWCB9er9TFUBVM0KcU+1uQdurKxeqheISmPpprI81hhufUBXLp81Ki2Q8Q==
X-Received: by 2002:a05:622a:11c8:b0:4b2:8ac5:27c0 with SMTP id d75a77b69052e-4b2aab513cdmr197289811cf.75.1756259179417;
        Tue, 26 Aug 2025 18:46:19 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3365e5d1e5fsm26038931fa.52.2025.08.26.18.46.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Aug 2025 18:46:18 -0700 (PDT)
Date: Wed, 27 Aug 2025 04:46:16 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: setotau@yandex.ru
Cc: Bjorn Andersson <andersson@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht
Subject: Re: [PATCH v3 1/3] pinctrl: qcom: lpass-lpi: Introduce pin_offset
 callback
Message-ID: <o2vsj7rfovoo6adwx7nhhi5g6vwowquux72m7do75g6sw3fkwf@jw5hxi4v6e3o>
References: <20250825-sdm660-lpass-lpi-v3-0-65d4a4db298e@yandex.ru>
 <20250825-sdm660-lpass-lpi-v3-1-65d4a4db298e@yandex.ru>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250825-sdm660-lpass-lpi-v3-1-65d4a4db298e@yandex.ru>
X-Proofpoint-GUID: hnWAZeAklu5lbh7Lpylxn25pG5kpu5aj
X-Proofpoint-ORIG-GUID: hnWAZeAklu5lbh7Lpylxn25pG5kpu5aj
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIzMDAzMyBTYWx0ZWRfX3EohpWvH5Wo8
 uYfRbB2obtHzpnCNMOKFuXsfMc+wjt+lUl7RAvPWwZQI4KIjWezQwtV8UeyYGzDp93YO8gYszsQ
 m4Vq73LZk5+HDDYyfFilrFX0LFE9DvidvgZsV0nrp5vKstJ1gLDB0yGnPDRN8EeHikScO/wra3v
 xuaAcpmT4K5q6okIB6cSKw2rXL3tnJsJM/weM6O6or5LmDB9h8t0ZZy0a4Ae7oTkM9zWHXXLujp
 sXNgpHTq14GGv8ewGpx9FJCcYjQLmPbc9llQZkPwmrRcIPLE/LlSuLgWbPshLunAETsgFzQrx+S
 RMckjPdpaAFNc+2FgNU1XifJfaOx7FQbgeA61+urAsJHsIJpW3OD1J4jtEYNG+8mXl0PAFvBceF
 AzHVtxnz
X-Authority-Analysis: v=2.4 cv=BJazrEQG c=1 sm=1 tr=0 ts=68ae636c cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=qC_FGOx9AAAA:8 a=vaJtXVxTAAAA:8 a=EUspDBNiAAAA:8
 a=Hv2uq9k-kH7IJJ9oAfsA:9 a=CjuIK1q_8ugA:10 a=uxP6HrT_eTzRwkO_Te1X:22
 a=fsdK_YakeE02zTmptMdW:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-26_02,2025-08-26_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 priorityscore=1501 clxscore=1015 impostorscore=0
 bulkscore=0 phishscore=0 suspectscore=0 spamscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508230033

On Mon, Aug 25, 2025 at 03:32:28PM +0300, Nickolay Goppen via B4 Relay wrote:
> From: Nickolay Goppen <setotau@yandex.ru>
> 
> By default pin_offset is calculated by formula: LPI_TLMM_REG_OFFSET * pin_id.
> However not all platforms are using this pin_offset formula (e.g. SDM660 LPASS
> LPI uses a predefined array of offsets [1]), so add a callback to the default
> pin_offset function to add an ability for some platforms to use their own quirky
> pin_offset functions and add callbacks to pin_offset_default function for other
> platforms.
> 
> [1] https://git.codelinaro.org/clo/la/kernel/msm-4.4/-/blob/LA.UM.7.2.c27-07400-sdm660.0/drivers/pinctrl/qcom/pinctrl-lpi.c#L107
> 
> Signed-off-by: Nickolay Goppen <setotau@yandex.ru>
> ---
>  drivers/pinctrl/qcom/pinctrl-lpass-lpi.c | 18 ++++++++++++++++--
>  drivers/pinctrl/qcom/pinctrl-lpass-lpi.h |  7 +++++++
>  2 files changed, 23 insertions(+), 2 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry

