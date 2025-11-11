Return-Path: <linux-kernel+bounces-895192-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EBB7C4D29F
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 11:49:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 97AB634ADBD
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 10:49:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFF1C3502A8;
	Tue, 11 Nov 2025 10:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="afUx8KGU";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="DVIHF1mo"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FFD134B1AF
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 10:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762858132; cv=none; b=Ohuq++S2M3O5dO7uuOPIhu/ZBeBEbBDkd6cHsGYwFA3gXkk5/U8vDCJuDL6WsHEMk0DA/FAG5d3tzn3b/ACKZKiUQENX3kohhCMvODfzOzRbQj5mJB+fd44+32dLM9KOiqei2ssGsHdlr36KkNajREJpjdFYXwLoq90hh4Tz8sI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762858132; c=relaxed/simple;
	bh=Hw7WEkYyfmolBo/cx/Bi+H8d4M4g/yfHEl5/k5dvLtY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rXb2QJcxKpvzimgbgmDhu89D4PAFTYdS9yrEhmXpiiht6fhBTZ0dML9uR0hzuCWrOQ1rBC6bkP5EuD5ueqCYiv4Do4mYWqA75ZMFdYEQgUwIJTragJExFB3IwSEvvypW0KME+ytlFs6vbs5a+1UmfNRlRhLNopoYbvf+D16IDb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=afUx8KGU; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=DVIHF1mo; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AB4ZpOi4166747
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 10:48:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=9EItJ5XOQftBUZ4p28CCb/my
	3CzvSqKQjhyPpFTkDrc=; b=afUx8KGU6kXYU5/rvvCLhu9WrLAUTQTH88aJ5JpZ
	eH8L4xr8lru7SjeZz+wvpJ48WZiqLElbeogEr3n74p4n4QU2MLK3Qg1cR+Rf8dmW
	bnQEwS7Cw4dIdqd7DzHJMoLw/5VYByIKjcPJBhOdf14EHrZIUjc9tCO3tjRi/KGA
	3bgzvfVKCVQ0vwbL2Ckedk2zX9UKtQnsb3rVs/1NqQGRyr733quGqd/LnE5pMlDM
	yG5P7m6CcSdrnRBluTrpGOevABMdON3Qzqncl+V8hrLdDhZEP+5t4Q2DaH0f0eaX
	gGomwojRaLAAAcepDPaWaj3DAIMEomERxn4puMN1/4iFog==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4abm4a2nms-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 10:48:49 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-88051c72070so91327196d6.1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 02:48:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762858129; x=1763462929; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9EItJ5XOQftBUZ4p28CCb/my3CzvSqKQjhyPpFTkDrc=;
        b=DVIHF1moRtJ5y0CIiFzGIYZSIQAmQ4nIRUbDEJLUN5DghRYsTPj6HI4fg2nSdQ2oZ1
         m2V3rkFRRdqZEFv5mmsSHCJ7Oblzf8rXm4Y6dFqKGqcxrwS0PGEirzMY9SWqCTLT3O9e
         kCu5uawIm7rdM5WtOmdREPLpIa2HfM/tD7tAjKNe7NyDds5h6r6nPdssib7nB1fRD8Dn
         lQCct0gS0GXzOOD8dt3lGLqN0KbNhEEqJJbRMY1xbLO7uGwDBqqn354bhL9by6vHct5w
         JXraEh9XPEDlv5jB6lc7xhcYPaoBukUdcyKLQCv/1bADOOD0ZKXqxutg91rb91lH3cxA
         1Ndg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762858129; x=1763462929;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9EItJ5XOQftBUZ4p28CCb/my3CzvSqKQjhyPpFTkDrc=;
        b=B4UwaKswEhP7d937D1ofgPbcB+pTVbIAn4XsDk8H+s4fglbitZDNyoJiQgO2zKNOvu
         BWmwH63IFy9FX7HB3YGcfmeIiOLtqP53EYRiF/wJSfTQ9PYyYxYGQ1rDcAC8PhbukCBp
         uqKKl0HfQNx1wzblZKrRCwLy2KTsE0KxubB40yiCdiWSZmatzGWf8PAGqUjLzksZ6rNH
         KWqwNXnYtieiqcAkxPplKuPeJr58zfNNve/RFiS0kcfx38xKWTKSHZ6/VZW44KzqYd3m
         /wu+VGp3x8vtJilGxXOoFozmfLop72VfqTZRkUEEOSm0El6o69Dwa59xV1jAEMO/oIXF
         3Oew==
X-Forwarded-Encrypted: i=1; AJvYcCWe+Yz532hvNlP/CXUmncABscCsVOuoM4r/fHerm8ZHw/fy/QxyVNITARFnurOtf6fnG6lmwK/9jrB6qyg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwIgl7DP2eR8I4++ikMiTEWXmYDCEPKqXZpOrtLGF8NxKeoRj43
	EH6AG5y/ECcQtmW4aa1kirLtOJY7AjmS3saq9cNv/xxN/qiNnMmNMR0z2/5X2TQDRTRMi1FXOMe
	+np3DuOxFe36XmYLgD7vr8i7xAyA8l2CpfkGh0vu0yCxfNRsfnBPw+l1GAnlndnmdwbw=
X-Gm-Gg: ASbGnctC31MXj6e9+mLSfVPOZnKgLrJAlzlc2vCzBIKxono4BArYLX8k9LtVjgQ5Zp7
	5AWZialUD+ii/cDnsqCfolg6MKn6HBrdHPE0jYbH76h4FIDfvV4aviMUcnpgWGyN7/yCoulr3Mj
	pbdzpuyhEA7oCV/Vk03GV4+qgxcpH+bChiL19gvKM+fhLkrB1XicG+4oYQKRh5UFKZPlhTeB1gx
	ovhI/micJAvdzUpfYpfBNVVO9VgXroAylE+GpkY58yVxg6HLyPfY3e9rkuGxMxt7KddtCHsQNO2
	47nreqDL+bSZ37AnRnDXAJp/X5/3qCPugg2Qt1BUG+eXNZoRFs3xOfdSr+jpZiTuRimM9ufdfLI
	v1bWestzM8ddO8IqktbWS7YoGFicWKZ3o3wS0eANH7uf9PoaPznzgeQ9rrwA3XOJtWNznoh7/Nq
	nwtf0ath+FKgil
X-Received: by 2002:a05:6214:1d0d:b0:882:4f53:ed3d with SMTP id 6a1803df08f44-8824f545e1emr99089156d6.36.1762858128902;
        Tue, 11 Nov 2025 02:48:48 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF6DZK5HRkqdWLPvPXUjGlUQbBYjLyUgma8QBrsQcOxkXJuIWMYFM67iw5rk0NIzOjJScMNWw==
X-Received: by 2002:a05:6214:1d0d:b0:882:4f53:ed3d with SMTP id 6a1803df08f44-8824f545e1emr99088906d6.36.1762858128460;
        Tue, 11 Nov 2025 02:48:48 -0800 (PST)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-37a5f0dd32csm45345661fa.35.2025.11.11.02.48.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Nov 2025 02:48:47 -0800 (PST)
Date: Tue, 11 Nov 2025 12:48:46 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Taniya Das <taniya.das@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, jingyi.wang@oss.qualcomm.com,
        aiqun.yu@oss.qualcomm.com, Ajit Pandey <ajit.pandey@oss.qualcomm.com>,
        Imran Shaik <imran.shaik@oss.qualcomm.com>,
        Jagadeesh Kona <jagadeesh.kona@oss.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 6/6] clk: qcom: Add support for Global clock
 controller on Kaanapali
Message-ID: <vomgxeiqctbnezwunxovwznbepmhxbmixkcpi7qkmic4xhhm3t@fwc3rp7r7ylm>
References: <20251030-gcc_kaanapali-v2-v2-0-a774a587af6f@oss.qualcomm.com>
 <20251030-gcc_kaanapali-v2-v2-6-a774a587af6f@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251030-gcc_kaanapali-v2-v2-6-a774a587af6f@oss.qualcomm.com>
X-Proofpoint-GUID: K0IeDfddO3n9flaDOCtGqyfQBH6nktG9
X-Authority-Analysis: v=2.4 cv=G6kR0tk5 c=1 sm=1 tr=0 ts=69131491 cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=NTLD1hAujTJExawGBKAA:9 a=CjuIK1q_8ugA:10
 a=pJ04lnu7RYOZP9TFuWaZ:22
X-Proofpoint-ORIG-GUID: K0IeDfddO3n9flaDOCtGqyfQBH6nktG9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTExMDA4NSBTYWx0ZWRfXyDnO96lQ17Dx
 y8e20aUfVfyM1jhaeOgC1YQ8ZjBDQPWsfL/7+eaMy0969qOtp7XznPsrNYP80deIRfmkGXeOwgz
 ktPsmi25/CxaRP/UNWwXZq5q8HTrjRJnY4Yq7j/4hvbSmC9Nki9k5B95v7nvgZfvLAViH4M789h
 Nj6wJM4tE/jZ0jYxXHWAmhGLsqs6F1S+qF3uSMYGMg1xbDqk2wOr5qBHLnhq09n4mzoo1f97t1M
 kPjjyX149Q4WNs9RlCjdiqQdhRHHUWn+psmfbVH/Q5sgjSFrFPqc9EDoQWZVHDuz00AUy7mbAge
 hSCFvvgf86B7Lp7ptZmlmgdY3XF5Dsf1LrH15HHo2CFfPJfAJlmjE5b1nXphjclCJ44pP4COUib
 K9l1gIP+TR/mW7zOivlLzj3aZYcRwQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-11_01,2025-11-11_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 spamscore=0 bulkscore=0 suspectscore=0
 lowpriorityscore=0 clxscore=1015 malwarescore=0 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511110085

On Thu, Oct 30, 2025 at 04:39:09PM +0530, Taniya Das wrote:
> Add support for Global clock controller for Kaanapali Qualcomm SoC.
> 
> Signed-off-by: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> Signed-off-by: Taniya Das <taniya.das@oss.qualcomm.com>
> ---
>  drivers/clk/qcom/Kconfig         |    9 +
>  drivers/clk/qcom/Makefile        |    1 +
>  drivers/clk/qcom/gcc-kaanapali.c | 3541 ++++++++++++++++++++++++++++++++++++++
>  3 files changed, 3551 insertions(+)
> 
> diff --git a/drivers/clk/qcom/Kconfig b/drivers/clk/qcom/Kconfig
> index 8ec1803af76cb87da59ca3ef28127c06f3e26d2b..5289a3f07379f3cea6f6192bcb0d73117fe51a5b 100644
> --- a/drivers/clk/qcom/Kconfig
> +++ b/drivers/clk/qcom/Kconfig
> @@ -46,6 +46,15 @@ config CLK_GLYMUR_TCSRCC
>  	  Support for the TCSR clock controller on GLYMUR devices.
>  	  Say Y if you want to use peripheral devices such as USB/PCIe/EDP.
>  
> +config CLK_KAANAPALI_GCC
> +	tristate "KAANAPALI Global Clock Controller"

Kaanapali?

> +
> +MODULE_DESCRIPTION("QTI GCC KAANAPALI Driver");

Kaanapali?

Is there a reason for keeping it in CAPITAL LETTERS?

> +MODULE_LICENSE("GPL");
> 
> -- 
> 2.34.1
> 

-- 
With best wishes
Dmitry

