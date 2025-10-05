Return-Path: <linux-kernel+bounces-842484-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4869ABBCD0B
	for <lists+linux-kernel@lfdr.de>; Mon, 06 Oct 2025 00:16:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F0C911892A6D
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Oct 2025 22:16:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A951C2248A8;
	Sun,  5 Oct 2025 22:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="QE980k69"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68C2328E9
	for <linux-kernel@vger.kernel.org>; Sun,  5 Oct 2025 22:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759702550; cv=none; b=j/LJa4CiXgCHVQeAQqIhFSazZLZHqNJSip4cdV5rJ+ev4469Tb3Wy25v1UynpUmKbMe4ylIY8sitzyhVGGgfgL77+CFxS72U4ThzKqkiGXbpHzrIal4uxeK5n0UYeM9u7AXOboobqHrmxTBPm8Dh2VarEXUWkXQFlqz3FsOWlUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759702550; c=relaxed/simple;
	bh=xEWS61a2W99U0FR8E3x3kodksyeF0rh0cZZdFbXsHY8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=plrUzafJUB1/6nFx4Js1sJD2Y2u5DIUrz/l7HoWwb8bMtDQy/kFgEYamO02JW170pZkgT2eQbSWpb/H71OMFoMqEbBTOWu7+T6eiklcxX3PLDG7reZ4JkWOKaqQqy0IXoIANv5niNy9gXSoaUgkaO2lG5kF+mHhDtW3PCQjw2wk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=QE980k69; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 595LpsiM017997
	for <linux-kernel@vger.kernel.org>; Sun, 5 Oct 2025 22:15:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=VJUbsyaaIROflytwFFiVYJmL
	inzHbu2KHVVpREbT6A0=; b=QE980k69CKbI9niutUlMnXSl0A+Rir0+uv82IJpf
	5mebkPijbqTt7R965NZHpSGy622iUh5L8jik2KRntY5PDRg1jl+0rHK8GAlzmo5M
	2+SwWB3U2utDOlvt3jRjtYFE/aAtZB0rw+M98vvwZyHevyi7lHeDZrclBlN3Kg+r
	l/tKFkMW8tEOk+lO1bKQTw0F2bqru7xVifLVMg/068lO1QA08nIHG+mnGThyaJEe
	TepOvDYbZeqlPopM3CjQZYpUlqzy+zvrip8l+EeYYxkfmw5pZYxY90XQdHm8w77V
	ePooF8pLRXg3DrsLFUNmlkrQKfCBF0/0YLGIjuk+OaexGw==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49jtk6tn39-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Sun, 05 Oct 2025 22:15:47 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4e576157d54so64998241cf.1
        for <linux-kernel@vger.kernel.org>; Sun, 05 Oct 2025 15:15:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759702546; x=1760307346;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VJUbsyaaIROflytwFFiVYJmLinzHbu2KHVVpREbT6A0=;
        b=ir5wU2Rb7QfPcrcDFIaAjO6VoPKd5O2zCRPZ+7RNsRwsPp15xMMZIE+NBAkCE3eeGx
         MlzMzxoA3MVViGm8cajuGsAWkvKQlhzjGId1NAz1OF02vME8ohbhykjO1LZxb7gWeXSL
         yle33Ba1J3ql/PEJdyN1qSUSmh2YNJ3BbHNzdnNcDaeo+2CefPrtj1L/vHk+pOs4o+Bz
         oS+buXxvhxNGGzE4z3Ty9Vt8ow2ThnIO8xASYTY5GvSGIYlzhRIiUtAR4edUl+oTB0xd
         mhM2TMJtOKp21zA/++7IHDGIVPpyJ0uHAk7N/rvF8r+xJ5cvX8eiGJ8/uLrFbLZLiDY6
         PUNA==
X-Forwarded-Encrypted: i=1; AJvYcCUDlaElZ9wHJddNKJSme+U6dUmkYBgz3xUDK46+Ll6qgAQEwXMIbKyaVi98Qms3euFwOUWitCQ9qiFj394=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyv7GhJjOx7ZbeUTVXk2o9Rw3wzKyBa4GEnVPE5ru6v+yMlCi2I
	p2DsZBxsp59Tjv+5X33JzEbYzYEr8I0SsETR+pDOtewqh5tiavgTwiXU3WJS/NtKaoBSBh11Dx9
	sp6KSHTxNBi1mFd7RiUYYWJ5u5x4M5ZYHziRZgk9xA5H8TmykFOgmMPCih+K1InHoDfc=
X-Gm-Gg: ASbGncv6YAjKIOCxiE40BfuaqvI8XqNIhBQ3Fq5knrgbRcVnB21Uogyes++PjAVgQkV
	Y6BQIv4Tf63nM31+8fKjWdyX4YXKxygkSqW/Id4XPR8RVmeDff5m/32O/PDGB8ocfK0rMMxQeB9
	rbDwhHKnlK+lqEIG2Zvxgb/LIgwGZSVGYzHM8ENMXa9IZiAxPPOjWbiPgpEhgmMabRcNJKHLO5p
	WTv3r7wZKI1yjIiI6a2uhUoRym9fYMlzGzyOaFqOLBW52OCDNvMg1EXFpOZUrEG664RtgK6gvw9
	kpS+h4APSvk9sjCIg1cvLnNLC8SC7aMML6jLYgtwf0phdLZhv1aF15YAKYUu2g1nDk/Dayj18IO
	sR3E7MIg1JSLsoWZ5EDQrz/+jN7BxqlkBuQdNsgSIZs8CMYGal2/2hhUs1g==
X-Received: by 2002:a05:622a:54d:b0:4cf:a3fa:47a0 with SMTP id d75a77b69052e-4e576a2b02amr122037161cf.15.1759702546235;
        Sun, 05 Oct 2025 15:15:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG/hjIRCKpgA5/wC3I2UjF4e5C3tbZcHLIczKTDjDnqATpz07KN9JMZb0PamftkW+1bmXunkw==
X-Received: by 2002:a05:622a:54d:b0:4cf:a3fa:47a0 with SMTP id d75a77b69052e-4e576a2b02amr122036891cf.15.1759702545763;
        Sun, 05 Oct 2025 15:15:45 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-373ba2739ccsm38465521fa.10.2025.10.05.15.15.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Oct 2025 15:15:44 -0700 (PDT)
Date: Mon, 6 Oct 2025 01:15:42 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: david@ixit.cz
Cc: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Amit Pundir <amit.pundir@linaro.org>,
        Casey Connolly <casey@connolly.tech>,
        Joel Selvaraj <foss@joelselvaraj.com>,
        Sumit Semwal <sumit.semwal@linaro.org>, Vinod Koul <vkoul@kernel.org>
Subject: Re: [PATCH 0/2] Add support for Pixel 3 and Pixel 3 XL
Message-ID: <gqjkvczi6fpmjpqvdv4hrndr5ie4le3dvlxjjd7q2okcfau4s2@iz43eczdagc6>
References: <20251005-pixel-3-v1-0-ab8b85f6133f@ixit.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251005-pixel-3-v1-0-ab8b85f6133f@ixit.cz>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA0MDAxNyBTYWx0ZWRfX7eo+maoAb4NJ
 oLZOMC5UJRlifRfELlXHGDSGpyJgs+rK4voyoa69emokcbtsLOUChhfF7cBO9FE5v49d5wE64wi
 vYApr96KBCTbTT8FNJKTTQ/LHNA9KoST6Xx/D9odZr7J7WD0MBEFx9TGlIPKpIu58OzIjs1AOQq
 jZjXUKpEYn8DDU8OH3dqryh2a3R2iyMXtgc9FLSihqLHfVjSQ0k+tdRiWQHbNqBEaR/hYQPJLhM
 /rl1ihajz+0fHMEcSEhuNnbSAIp/qXEnlHxz++wod/K7024VUBe2xWb543dbLsoC7LpfcZeqNsW
 sUelCu0cdvci0IhToT7Thzff3TroA5y19sOv7TFTXuTj3WBFgeRHM/handopwTY4VlixQqCcShi
 xmqJV3XJc2YIIp7dE686QTKBK8TQMg==
X-Authority-Analysis: v=2.4 cv=do3Wylg4 c=1 sm=1 tr=0 ts=68e2ee13 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=x6icFKpwvdMA:10 a=FwhAVFQIucHvz-KIkSoA:9 a=CjuIK1q_8ugA:10
 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-GUID: gLjDynuxKVfgHk9ZP3_iVt6lURuDxjLx
X-Proofpoint-ORIG-GUID: gLjDynuxKVfgHk9ZP3_iVt6lURuDxjLx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-05_07,2025-10-02_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 lowpriorityscore=0 phishscore=0 clxscore=1015
 malwarescore=0 spamscore=0 impostorscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2510040017

On Sun, Oct 05, 2025 at 03:16:27PM +0200, David Heidelberg via B4 Relay wrote:
> This adds initial device tree support for the following phones:
> 
>  - Google Pixel 3 (blueline)
>  - Google Pixel 3 XL (crosshatch)
> 
> Both phone boards use the same identifiers and differ only slightly
> in their connected peripherals.
> 
> Supported functionality includes:
>  - Debug UART
>  - UFS
>  - Charger
>  - USB-C (peripheral mode)
>  - Display (Pixel 3 only)
> 
> This is mainly focused to get the base functionality of the board and
> being able to use the upstream DTS within Linux and u-boot.
> 
> Booting
> -------
> For older Pixel 3 bootloaders, bootloader-compatible board and MSM IDs are
> required for the kernel to boot, so these have been added.
> 
> For recent Pixel 3 bootloaders,
> a) you want chainloaded proper bootloader (f.e. u-boot),
> b) you can also boot kernel when adding back TEXT_OFFSET
>    (partial revert of 120dc60d).

Maybe I should send a patch fixing the TEXT_OFFSET. Let's see what kind
of reaction will it get.

> 
> This series is a beggining of cleaning up and transitioning support from
> sdm845 close to mainline tree to the mainline.
> 
> Signed-off-by: David Heidelberg <david@ixit.cz>
> ---
> David Heidelberg (2):
>       Documentation: dt-bindings: arm: qcom: Add Pixel 3 and 3 XL
>       arm64: dts: qcom: Add support for Pixel 3 and Pixel 3 XL
> 
>  Documentation/devicetree/bindings/arm/qcom.yaml    |   5 +-
>  arch/arm64/boot/dts/qcom/Makefile                  |   2 +
>  .../arm64/boot/dts/qcom/sdm845-google-blueline.dts | 128 ++++++
>  arch/arm64/boot/dts/qcom/sdm845-google-common.dtsi | 467 +++++++++++++++++++++
>  .../boot/dts/qcom/sdm845-google-crosshatch.dts     | 137 ++++++
>  5 files changed, 736 insertions(+), 3 deletions(-)
> ---
> base-commit: e5f0a698b34ed76002dc5cff3804a61c80233a7a
> change-id: 20250419-pixel-3-511edc2a4607
> 
> Best regards,
> -- 
> David Heidelberg <david@ixit.cz>
> 
> 

-- 
With best wishes
Dmitry

