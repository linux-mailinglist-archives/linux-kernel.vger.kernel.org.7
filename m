Return-Path: <linux-kernel+bounces-811142-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 25537B524E2
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 02:01:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD0443B44E1
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 00:01:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0EB015E8B;
	Thu, 11 Sep 2025 00:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="lxAooDmc"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BC95DDD2
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 00:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757548912; cv=none; b=seOtDRP1BVooqOtgb3jcQAtSffdDxmUPnFJqpHPUSzL//7rKfFDRJXKKyODjj9W8pvKHUX6Ijm1bCipOS8iWiIILm3I3fOOKy5i/fvinQQrwdg06DZIuBUks16sRdh9qVCK8npLDR6RzHxdmoMgUc0iClwIW/f4gwdT7QVDwXfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757548912; c=relaxed/simple;
	bh=SB9N+sI+8G4mvBryp4BJKi1IVFXxHA3hyZok3VfZH5k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H822lyQlVOCG3KqSy/Q3C1u+eNAaLCR1OELehjWRVJUdKMxZXAV2G59I8VtD5HOJVciAQKG0h82PGrfaNeScEHR/VfhzvGpDFo7/35I8EBuewuapI9LBAp8JyQ+UtedkqqMIWVcB12ax7zM9tWLsRh6wiSYeI4Eg1vNIjAzpBYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=lxAooDmc; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58AJ65pY024136
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 00:01:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=1ssHk0MR3leUPXS1eErL4m3b
	O9D30qutJLy5o4w/GPI=; b=lxAooDmcJkqWlFAR3sT3tUYa5zRZReqxaKjyx+q+
	fXc4aIS9YXzA9rjRBeVguyP5oD/fRETDwAaiZJ2owTDfwUmJMKNvzDs2kjR4gU50
	vje6i9sBgsk/V6DPYOO2EUbRJ0lc3kJMGiuf9HQ1TcvuZEfVa031NmDtAaJFoSO1
	42kBKst4YJ2SaBd/ZWylyeA4CpcaG8e+1zVBTHtKc/f84usjLmsyXCQ2glitC0qp
	cLvDX9Q74IOLujgVCldtcYddIrXKFZoHyWAx9/6kuWxVDpKJ1k9fHgZkH3wgfXDl
	CyhkMoHw8j1uSZk5ZYHOfUuggdTMIe1QtYLxJm2A0pbISg==
Received: from mail-vk1-f199.google.com (mail-vk1-f199.google.com [209.85.221.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 493f6h0ms3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 00:01:43 +0000 (GMT)
Received: by mail-vk1-f199.google.com with SMTP id 71dfb90a1353d-544b12e328fso17171e0c.2
        for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 17:01:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757548902; x=1758153702;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1ssHk0MR3leUPXS1eErL4m3bO9D30qutJLy5o4w/GPI=;
        b=YKJpwHJhd8W/0aOszczY2m2LCexznfq8hSRZ4PssGp2S4gpjGinsqS21MImhGEYbaB
         66l7JM5HpNU5vJH2LpM9AUV836Dn4CUwBxiWlla6twWEyaxh3x1fbj5s+7lz8t3kaR99
         FqbIPny1shYdFjYxiPypSOpxeauKNAr0x9FeLIBSOgHsZbN3ybwcuD70a6oNRwAQDfiQ
         mpYpXll1lJzHMWcWDv357/M6B9AYgFP7wg6Ib95hALyEwxg1fjOFy9p82sKbcBGSRr7T
         4YdGsBWG/kX8vKZC+RvHd5c+T6P0LQSSUyOOBblJTjRy4l8l4X4YnMoCT+QKFSdJs8yD
         mr9g==
X-Forwarded-Encrypted: i=1; AJvYcCVAGTMSSsen705AgENc7Wew3mzGMaEiI/O3JSL0z7aZ5vMaeTAx+qkoy0EU1lUWGfNuM6gzRjbviI3vcfw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzR0XvHYdSWzs73CbYww9Bl15LquOj2o201UtvQpg3FrSNB5nGY
	TxwxvOpn62KgGiBnktvrvMMkMLIaeTq3gpmASIGpQAKclZAZHxuS+GzSVxwzNgysxpNPxx95R1X
	H7xcnlCjnFmAD5blH4gHH5qielU/ebslSo+6qrSwWvEhI4UcCr6MQGFc1sxlrZysMBu8=
X-Gm-Gg: ASbGnct1j51pUNDXln9areX/+ImSfoaID/W319pBr8mf70YwFROso0n1IhE2Z9dImx1
	vB61Z/q1nT6rf1cih9UgeUJaD1V69kB/XFqPViTXRvCzjDPoB5mYLZIcW4b9gyJVGzuNFbz1wTx
	bTrYnHWMRomqUnS47Zdsa2OK6MLBJlhwfq3YTGQ6YzJf5uWSpUTp6fNrqxei2TSkENGTBf1Ehh2
	meJfAL5dwYO4oCkgjQz4Od6F2oH/gstRC1irXueibEfSyUIYJ3V8KKm71FeUAId6VNhbFmniZA5
	KQT5OBE/yUJIcOJtqHQscugUyR6rBmrO+nTZ/A4ZJEKLH/hQp23qYOYtwCqCShOe8l2ZlPNJEdB
	OkPRdOldg0jwZZIoMKMENsJ4myM22cTul5Tl8gK64b6KR4dbgEHcR
X-Received: by 2002:a05:6122:3d05:b0:53c:6d68:1cce with SMTP id 71dfb90a1353d-5473d47bf22mr5786024e0c.16.1757548901579;
        Wed, 10 Sep 2025 17:01:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEaJQlOSyFqlengO9hG1qMSeWHYmCMLahQJhuHv+8HeoNe1vwHzEtQ3ebepX/z3Qg2HtnLVGA==
X-Received: by 2002:a05:6122:3d05:b0:53c:6d68:1cce with SMTP id 71dfb90a1353d-5473d47bf22mr5785971e0c.16.1757548901152;
        Wed, 10 Sep 2025 17:01:41 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-34f1a8211a4sm202201fa.39.2025.09.10.17.01.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Sep 2025 17:01:38 -0700 (PDT)
Date: Thu, 11 Sep 2025 03:01:35 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] arm64: dts: qcom: qcm6490: Introduce Particle Tachyon
Message-ID: <2tnzsjw3xy5jct4bcmahcwhjbzlmyxgcx6fzlz5qrzxume2uoy@phpcz6mnydlt>
References: <20250910-tachyon-v1-0-5090bfd133e0@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250910-tachyon-v1-0-5090bfd133e0@oss.qualcomm.com>
X-Proofpoint-ORIG-GUID: TQgrzOiNqcINvOxymxLF9_L_qfYJY31X
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTEwMDE3NyBTYWx0ZWRfX8jJaaNii905T
 0RjTDzFs6g67pDt2BkmJ3tTaAU7UapwpPRaWECkicv2BmJI+Y89Qj74+fC0oZaNwfj8yT0oAmE3
 uMx0XESef48cBQ0ZdK1wZ7k3RzvMRvwcJad7ff2BSOhNg1FpMZAYPvBXfWcRVh6+C/YwhdyJ1rb
 7Aa6fmR+tUOUINc6tA46p80JJ0D1U9dDe96CJT7yXWvqWI95PRfgcHD0CrO8eR0+oEdqlBk7KhY
 lLyP9wf+cpIzhAIIFHNBjXdGhRpbHGBHwtdtu9651mUS5hCh5cWT0TcLU1jsSXWNguBHcDgCMwv
 I3JuDDWjdDaFaL+BGb5MO+VyjcZXn9R3VQcxzS4+Rz6KCVprqCajsbxwAXa8g07LAhBAzPLwhuN
 FYtDgVPO
X-Authority-Analysis: v=2.4 cv=WPB/XmsR c=1 sm=1 tr=0 ts=68c21167 cx=c_pps
 a=+D9SDfe9YZWTjADjLiQY5g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=7AODkVuKAAAA:8 a=NEAV23lmAAAA:8 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=ZljO1qPqrEt1h5dnOlAA:9 a=CjuIK1q_8ugA:10
 a=vmgOmaN-Xu0dpDh8OwbV:22 a=sRHRY8H3vKB1GfNvUtpx:22
X-Proofpoint-GUID: TQgrzOiNqcINvOxymxLF9_L_qfYJY31X
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-10_04,2025-09-10_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 clxscore=1015 priorityscore=1501 adultscore=0
 bulkscore=0 phishscore=0 suspectscore=0 malwarescore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509100177

On Wed, Sep 10, 2025 at 06:05:36PM -0500, Bjorn Andersson wrote:
> Introduce the Particle Tachyon board (https://www.particle.io/tachyon/),
> a single board compute with 5G connectivity and AI accelerator.
> 
> The boards currently ships with the Android Boot Loader, but replacing
> this with abl2esp allows writing a EFI System Parition and OS partitions
> to all of LUN0, and a more UEFI boot experience. A prebuilt version of
> abl2esp is provided at [1], as abl2esp-v6.elf.
> 
> With a (very) recent version of QDL, a flash programmer from a Tachyon
> software release, and a full distro image, this can be achieved with:
> 
>   qdl prog_firehose_ddr.elf write abl_a abl2esp-v6.elf write abl_b abl2esp-v6.elf write 0 image.raw
> 
> The following firmware files are currently used, on top of what's in
> linux-firmware already:
>   qcom/qcm6490/particle/tachyon/a660_zap.mbn
>   qcom/qcm6490/particle/tachyon/adsp.mbn
>   qcom/qcm6490/particle/tachyon/cdsp.mbn
>   qcom/qcm6490/particle/tachyon/ipa_fws.mbn
>   qcom/qcm6490/particle/tachyon/modem.mbn

Is it locked? Would it be possible to Particle-signed firmware into
linux-firmware?

> 
> In addition to bug fixes that has landed in v6.17-rc this depends on
> [2], which is available in linux-next.
> 
> [1] https://github.com/qualcomm/abl2esp/releases/tag/v1.0
> [2] https://lore.kernel.org/all/20250811-sc7280-mdss-reset-v1-0-83ceff1d48de@oss.qualcomm.com/
> 
> Signed-off-by: Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>
> ---
> Bjorn Andersson (3):
>       dt-bindings: vendor-prefixes: Add Particle Industries
>       dt-bindings: arm: qcom: Add Particle Tachyon
>       arm64: dts: qcom: qcm6490: Introduce the Particle Tachyon
> 
>  Documentation/devicetree/bindings/arm/qcom.yaml    |   1 +
>  .../devicetree/bindings/vendor-prefixes.yaml       |   2 +
>  arch/arm64/boot/dts/qcom/Makefile                  |   1 +
>  .../boot/dts/qcom/qcm6490-particle-tachyon.dts     | 877 +++++++++++++++++++++
>  4 files changed, 881 insertions(+)
> ---
> base-commit: 5f540c4aade9f1d58fb7b9490b4b7d5214ec9746
> change-id: 20250910-tachyon-e3548941397d
> 
> Best regards,
> -- 
> Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>
> 

-- 
With best wishes
Dmitry

