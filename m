Return-Path: <linux-kernel+bounces-871038-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 03A3EC0C4A8
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 09:26:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A931A4F0565
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 08:25:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE7FD2E7BCB;
	Mon, 27 Oct 2025 08:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="mfUx5/xt"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99F842E7BC0
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 08:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761553544; cv=none; b=HYM9fLVMwwfB3HagX4jMm3ArxsML3pKMMxEEO+jVstOw9soKkgmneccmruES02whruQUH/khmKUPie1R/Oe40OLbjVUTpAZy2GSVAolQmgV1romx5/xyT0siN2Oq4ghwRaFnoPlW6WyE7jhxKSYER6HpSzS7QzTyRLrgaSbFLpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761553544; c=relaxed/simple;
	bh=s4/hEnLDptpri3LLhBNbmPdbIKv3lBAyCY4x+nkms1A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AO6qC/oxYoAMj1KgOtLjL+/2SacjT/Pojr8GmWSnqJAOWRqK6fxpFhKY4vdq2q6tAZ5aeIzAh1r25oMJJJoYoZYH9C1rZNtp0hTr4n0+sjKejwgdLI8SIBB0Gt3YEfGHLPkx9FechI7RwJz8UBCmG/Jzug42Ihf5NE/bDHoQ0I4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=mfUx5/xt; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59R84otW2232270
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 08:25:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Rsb5IoKjQNN5TuHEex46Q/ZW+nK+3INVuz35ePkitGI=; b=mfUx5/xtkaV10vGm
	8STGARjNiwYeRqX0bwBI6nbAxM1A0AsGAuM5ibwEdS3wHqDp56/oQMXN56nSVWMI
	I6x4oEnzNHDHxrQxp/mpGIBJJFbbr1lpJrzzbJMU4n3MkwmOYorWC05mvEU7NVOp
	W+BTO0vjq9MDUsCzpAHIGoB8Ee783w59+dU0t5Sq8eaOz1ihkQgkUWKDnjxBy7/S
	QzQoMbfCxcAiE7xu25oUYgwBv1UqWOMjG0oqBbFj1W1eR8bP9/4lChyZcri5lEwI
	Bm0elhYmdACDw/b6xCBLRxZZt4ab8gjLOkaHqVudwBJNVzphNAhI+bs1CX5BzWF4
	9/zZ9Q==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a24wn81x5-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 08:25:41 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-7f5798303b3so11186296d6.3
        for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 01:25:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761553541; x=1762158341;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Rsb5IoKjQNN5TuHEex46Q/ZW+nK+3INVuz35ePkitGI=;
        b=Vv0dVGY8f18klQZipUPM+07lwNGHzgyUkdPhj+fEr81S4jj++CYiwG5sjcntt2UCBW
         z7atK9IMnkXYkZrfAdG3YG07dezmzva5s3kIxovLw8w8jHqr6ucLXqTR7xIjMRbu27cD
         MtotZ8gWUejomfsDkTLMmCmRbb4yR2Brfp1dN07qyvbqf8te+jZm3Zzc+nFf49U5zLED
         Bf77+3WURmlybDwzRtfGYns9OT9NRiSBEK0n5mDm20ksB8O1L1ljnjLhuf/OIE7crqtw
         DJ+hIxl1YI2xb0NV3qcB2uz9A/oAXCIxyGXI3vmKfS5jNKMLKExrNVbuakmpt7MbEch6
         Sksw==
X-Forwarded-Encrypted: i=1; AJvYcCV9sSZNLhums2WfL/PpQ5nOVjgbLgqV8UyGEnTXWrYLDPxQ4fKGjMNdTjxYs8ivaf9j3haGBq88DVVnIQ0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/VjbreLIs4jMCDNxwlkymalc++PcPAbKtLcr+N0YmCXeBG59O
	l2ffRS6C1s9wcI+94ngaOzevIt0RAIuwSEILdvKH3AZVRHDLJthLxVJEDiAWM39a8EdONthROvJ
	ryOnFzErOKMw2u7Dc8YrJcFXZXyVcRlqk4iD5dPMhSnw0TNexONolYlup5y3rnayjsDE=
X-Gm-Gg: ASbGncv4i9Q1Lla7ljr0rpo42hirWJ5cgASSk/CONkoLLF0YzCatMipOk2EbitzrETD
	nj5z2P2ZUBR5/kba6/N0oDVzyScpCoanP6N4D0SnA/UJQxGCMb3jH/1s18efC19pDkSzgt+ADvr
	4VvPNhqwfRhjz/blbt4I/FIzoNnqCDRTPNweqaVDIX7EcZuuAfCo9LPvfa6DbOEcxC2hNdtS8w9
	MGwYcFnt9z20zKyQ3hI/0IeCX2PSuxE2pEiVkk1XL8WTgIkW4IPt7MqneB8BFCm1+lhmR0SanCP
	nqb42NZXyutbQvw39a/CJHxLXbdoAzjMzPn42wcgc9zpXmnNpKHRN4yZvH/9RGd2eP90r/nZdF0
	KvvF1uMNJk8hmc004on5jqE4jo5P2J/hXrWU2d7PzZx6YfTRjGfCEBm2Z
X-Received: by 2002:a05:6214:f05:b0:81f:3abf:dc1f with SMTP id 6a1803df08f44-87c206aa6f8mr294428586d6.8.1761553540837;
        Mon, 27 Oct 2025 01:25:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFWO4UfxTU1BX5oTeeqL0Gs4K66cPeHuRqQeCNBm97cuVqGohCsQt/0ok7E7/fOVHrIRAJiJg==
X-Received: by 2002:a05:6214:f05:b0:81f:3abf:dc1f with SMTP id 6a1803df08f44-87c206aa6f8mr294428506d6.8.1761553540138;
        Mon, 27 Oct 2025 01:25:40 -0700 (PDT)
Received: from [192.168.119.202] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b6d85359c0bsm704420366b.24.2025.10.27.01.25.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Oct 2025 01:25:39 -0700 (PDT)
Message-ID: <daf0055b-7caf-4ace-8a06-071468273a37@oss.qualcomm.com>
Date: Mon, 27 Oct 2025 09:25:38 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] phy: qualcomm: m31-eusb2: Add runtime pm ops
To: Prashanth K <prashanth.k@oss.qualcomm.com>, Vinod Koul
 <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20251027062458.1411096-1-prashanth.k@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20251027062458.1411096-1-prashanth.k@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=XIY9iAhE c=1 sm=1 tr=0 ts=68ff2c85 cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=k3wdqr90-_sLWsnx9DcA:9 a=QEXdDO2ut3YA:10
 a=pJ04lnu7RYOZP9TFuWaZ:22
X-Proofpoint-GUID: WCKJcJvsneRVoWHrT_pQFRbQ12nAvXlB
X-Proofpoint-ORIG-GUID: WCKJcJvsneRVoWHrT_pQFRbQ12nAvXlB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI3MDA3NyBTYWx0ZWRfXzdPhCAziyxOc
 T+POj6rlrhBY6QrNMcZ7JFIH92n2pOb1gb5f7FXoou4FamZsOnSn80mD0bg4DRdl83N4sB8061J
 DzN6awqwb3IhIZp7DY1AyakULPpohlrW3oqNePEgy055QFf6bu5obmuoXYv/3aBUbwahDExlcFJ
 EVR9bDbHhqbHBml7NPq+aWwCIuote6cQJRSR+iZ8zInp++J9anhHg2g2ku5Qt430BRg3xE8MQ+V
 btCRY7wl54q+wNL8MGrh7zUJYtVUekbA/1sS+cVrMcNAJcMm8mqVFDR+wOFadmu2MAD1KGV9skP
 kKvaNdHeMuxAMVoSEXshKI+C6k/2CC7BXZXJVqHSOgggVHKOG93JviyCh8Is6BIbjA7D6zCQVtZ
 9QZtjVhnY2KzhPXGoBzSdCQBgbZKZw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-27_04,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 suspectscore=0 priorityscore=1501 bulkscore=0
 clxscore=1015 impostorscore=0 adultscore=0 spamscore=0 malwarescore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510020000
 definitions=main-2510270077

On 10/27/25 7:24 AM, Prashanth K wrote:
> Add runtime power management operation callbacks for M31 EUSB2 PHY.
> Enable/disable the clocks based on the runtime suspend/resume calls.
> 
> Signed-off-by: Prashanth K <prashanth.k@oss.qualcomm.com>
> ---

[...]

>  static int m31eusb2_phy_probe(struct platform_device *pdev)
>  {
>  	struct phy_provider *phy_provider;
> @@ -270,6 +298,17 @@ static int m31eusb2_phy_probe(struct platform_device *pdev)
>  		return dev_err_probe(dev, PTR_ERR(phy->clk),
>  				     "failed to get clk\n");
>  
> +	dev_set_drvdata(dev, phy);
> +	pm_runtime_set_active(dev);
> +	pm_runtime_enable(dev);
> +
> +	/*
> +	 * Prevent runtime pm from being ON by default. Users can enable
> +	 * it using power/control in sysfs.
> +	 */
> +	pm_runtime_forbid(dev);

This screams "this patch is broken" or "there are bad issues" which
you did not describe at all.

Konrad

