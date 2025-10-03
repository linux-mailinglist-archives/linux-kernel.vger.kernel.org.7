Return-Path: <linux-kernel+bounces-841684-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 3278EBB7FDC
	for <lists+linux-kernel@lfdr.de>; Fri, 03 Oct 2025 21:38:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AA6E74EEDA7
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Oct 2025 19:38:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8746221F03;
	Fri,  3 Oct 2025 19:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="T54qu9PL"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A204221B9E0
	for <linux-kernel@vger.kernel.org>; Fri,  3 Oct 2025 19:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759520297; cv=none; b=fJ0C7STfHnvIbEzcoPWiOzIS9JXBKIR2oFr5H15imssjKUaON69HxC2iZG/39n0askZYyD1qjxyQwsCTgfOSvwVKzSNfWJBeOrFggVmSV6415t9GV7k8MqwC10bUeEGMIA9Cl/7ODBuSGl2azBqPcNeIhJnY5FiBV3g7lR63v8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759520297; c=relaxed/simple;
	bh=6PA7/gZ6w/NaM0vZU25LxZi7CVbMutYUKbETi4CKwyE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IwOMgBdZVwSoIK1TnROtHgw3yT2omMcpV1vUB6AQGmJDYMFmuEwLChBNrm4M9R6jkjE0i17p7cvSy5zZRc/67sbTwSqOLPmmbP8fFsVdDyC1y+xkwdXVsvlk0LXZrl1IBTCGv4s9m91bD1n0dHrUN29B43e02mJMIXJRCE1PfYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=T54qu9PL; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 593AFtNK000949
	for <linux-kernel@vger.kernel.org>; Fri, 3 Oct 2025 19:38:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=c/QeD1msDHzyxrlgBhbUPpRV
	r2cqluEXpYx+ZEgqG8E=; b=T54qu9PLdBEo+X3HJs2aoWSGZ7TqW0eB7ilFmhJ5
	XapBW6n0KZJ8cZ6i3VCZk2jJ6NTU91p2S+iW1L5N5Kb8RjNKJrXuLAeOFNLZ2XNl
	0t8KZ7BTlzbqKP0BYOMQwDF7vrAlP/TzHv3/KpoZLkG4/dwHdbuqUOLkMZThXfIc
	d9cA8sXENJV+34ea7aFpkkaPopjjcDIYa9jHrGtXvy53K4LzejRt6PH56iscWHwh
	Z8WlBkJkqSgRMvSjBTeSJSKejxijJNu/6TwR8rUER7LME58YG4nyX8aRuW8MFtRX
	0UxwKgltXZdjImcSxJR24TnY5MLkevMdyXJWJdVC5NB13A==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49e6x63xpw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 03 Oct 2025 19:38:14 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4e484dccaafso65715921cf.1
        for <linux-kernel@vger.kernel.org>; Fri, 03 Oct 2025 12:38:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759520294; x=1760125094;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c/QeD1msDHzyxrlgBhbUPpRVr2cqluEXpYx+ZEgqG8E=;
        b=RRPXb50ctMa/t2Rb8FbmCX7JFn2+PJ1w2hwYZA/JrQvlJAWPYAa5wVJJIy/qxbKzgu
         otb0dMC45nvJ+aGkAufeTW4K1MPGIbznVceLFgHBgFHNeCuzYSte+yLelmq8xA66kEN6
         SAagTVQMcnRzrA0VRF5TBIg7s/NJ99WHJ+vhbh0sdC+qkgmainNHrJgITPatexa72XiH
         ggd9Eakyj9T71sVt9XzE1ryaZI85iI3IE2PZSMaVQusH/VttFfxupjzAXTMQzMmzKoNy
         a2mvW/3No7FZhTnbA9Ypx/SDzFSpuXXejyNtiIBhM65cLbMvHl3GLIw7ZP8PK8sT/rjG
         iSVA==
X-Forwarded-Encrypted: i=1; AJvYcCXepIFzxL7xAKXLgKtoP47cPlzrmq0UpcqKoLE2e0ZhkEJCLfzKgONMAVRCjqtm88mgRGK3tTxqyovCOG8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxY6W3Tij7pJJ80/xLubn9sWx6hGIZ9+tFBpgrPWOmSu2vK0laK
	nIPBEMSy7sx2Xa5WaZlap9w/R3TlWrMD9CcdyUKKzafeKGEBIEqSGc9m4PcNRlz4x+2w6Ao6CvY
	e43hxhieMCG3rd3tkOn5V/x0I5guc+B8HmcGATrucIX93NVlDf+5qBL95YwGp7cx608g=
X-Gm-Gg: ASbGncsoFrYRQV7l2M+MMGHVaanckfhuKjM0xdbzvbU3EpgSqQ0noNEDqnB18MW2J+x
	W+ckgNsq1mboMWHzMWErUmErAFm649upfGaYuPI67wKCIFIJcmd3UsjI8OXeu2BARvui2yOB+sF
	/9aGoQp96mvIQyOUs0O14hnI5Yvtjsd8ZYv7T3PJQirC8RskPHobtAPbkUHZ3ptxpiX0IqrrZHB
	JL7EgwwUr55I7wZdzO3PGSdwy+jXP1+UiVCEuFPwOusxxQ2qtD2Fh6SwNILjIOT7F/6nkFJD2Cc
	P5VcyK1Z6kBwJqaesONL6L/HJenLtP67wUwtk4VLS8M2/MYNn7QENO2/MqmBqLXoXb1GZxij5gO
	9tGNtoIhcVrOMnMWvCtGM/1hUsjD4hXamV09jU+8x/2iMTFjONULwgyH9tQ==
X-Received: by 2002:ac8:574c:0:b0:4d6:c73f:de88 with SMTP id d75a77b69052e-4e5766fa419mr66222901cf.3.1759520291734;
        Fri, 03 Oct 2025 12:38:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHa6kGS9lVlPG9s/2DewNwN4ny2UeX5qnAiNzIzbVl4p+vL4Y447NPSIDi2TcL94+kOw3WYpg==
X-Received: by 2002:ac8:574c:0:b0:4d6:c73f:de88 with SMTP id d75a77b69052e-4e5766fa419mr66220391cf.3.1759520288686;
        Fri, 03 Oct 2025 12:38:08 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-58b011a7e65sm2090376e87.112.2025.10.03.12.38.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Oct 2025 12:38:06 -0700 (PDT)
Date: Fri, 3 Oct 2025 22:38:03 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Konrad Dybcio <konradybcio@kernel.org>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Rajendra Nayak <quic_rjendra@quicinc.com>,
        Wesley Cheng <wesley.cheng@oss.qualcomm.com>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Sibi Sankar <quic_sibis@quicinc.com>, Abel Vesa <abel.vesa@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Bryan O'Donoghue <bod@kernel.org>
Subject: Re: [PATCH v2 3/3] arm64: dts: qcom: x1e80100: Extend the gcc input
 clock list
Message-ID: <xad3x7qn6qxrnfqrhcyqkileh7efwizklmwlj4firdqpkz67em@2bcx44acnpre>
References: <20251003-topic-hamoa_gcc_usb4-v2-0-61d27a14ee65@oss.qualcomm.com>
 <20251003-topic-hamoa_gcc_usb4-v2-3-61d27a14ee65@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251003-topic-hamoa_gcc_usb4-v2-3-61d27a14ee65@oss.qualcomm.com>
X-Proofpoint-GUID: JQ2pEMgnxDSo9NjB1XE-jylyahLRqdHl
X-Proofpoint-ORIG-GUID: JQ2pEMgnxDSo9NjB1XE-jylyahLRqdHl
X-Authority-Analysis: v=2.4 cv=ZtPg6t7G c=1 sm=1 tr=0 ts=68e02626 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=x6icFKpwvdMA:10 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=AeM-GoSWWiRe9qQbtTAA:9
 a=CjuIK1q_8ugA:10 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI3MDAxOCBTYWx0ZWRfXx82BwvtQqJ9I
 onZq7WcyRJIpQs4LYdgN/EMj+fdldX0ndph+EGu0ExF8tqDWCHaAA2aLRO66yMaT8nPnW43MuYD
 QKW4UyRtJTrB3pdZ3T71/wEy16sfL4ec8Rca2dVErssUYZz/pHqbdZefrWzZqGRuxu3zc6eZ8bp
 IOhUlTmzLQ0bm5SXzCRm1qdWhnMQYGNzOikCdl5zor0wT60+ZY/RQLIhQukZVSFcx/1CzuwN/nJ
 2tuxAXcSLqh7OqvMMlhPDkhLKTk+ajo71CASP27oI8Eu7aYyIGLAP1CsvIkz98LSzqpNe3uG99Z
 qbwlVbrEBHYzRX2XLV6Py2x/hIw5+PGHAWvKgYNj6yl8PrpPE2F4pUuWFJPeJUqbzbJ8tdYTX9s
 8gDacnUTPd8RM80PHiu3gvysGcYl9A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-03_06,2025-10-02_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 priorityscore=1501 malwarescore=0 bulkscore=0
 suspectscore=0 clxscore=1015 lowpriorityscore=0 adultscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2509270018

On Fri, Oct 03, 2025 at 08:14:40PM +0200, Konrad Dybcio wrote:
> From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> 
> With the recent dt-bindings update, the missing USB4 clocks have been
> added.
> 
> Extend the existing list to make sure the DT contains the expected
> amount of 'clocks' entries.
> 
> Reviewed-by: Bryan O'Donoghue <bod@kernel.org>
> Signed-off-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> ---
>  arch/arm64/boot/dts/qcom/x1e80100.dtsi | 29 ++++++++++++++++++++++++++++-
>  1 file changed, 28 insertions(+), 1 deletion(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry

