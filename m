Return-Path: <linux-kernel+bounces-831653-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EFB3B9D3EE
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 04:55:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC1722E7B3E
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 02:55:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB34C2E62AF;
	Thu, 25 Sep 2025 02:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="f8AzB8Mu"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BC852E62D4
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 02:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758768939; cv=none; b=Ga+h/QYwHJLbiPOq31rsLBGiF/PNUU8EJd8T2R1AmlxHSUQYcjiCFSBrTXO845WGj9KmxjwgpM6qheKoQ2wJZ1N/FkwhfEXmvdMq+lUrwI2nGsoLPomypnTeXhQh7N5x5eaqjGatlvoQgQssjnJnQzmjJ+Af5XoUXekgZxWhSL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758768939; c=relaxed/simple;
	bh=H3KAcTmwmORg8SJ/xG7H5u+L0tAoDnAnaELg5U+7sqo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kBXtdG3tRCYsvIHzExWmjJTa98h5cfkwoWk13/4u62JACC5Hr5TaMo+3cI0WErSA1jEsYcdGB1uTvXRsYd5hJtk++wfDRp05Jig7+27rsP6nRzkpcur0fssMZqgnR70bXnoL0x+51dJihPrGHYL5iRQlpu8vHheU51Pk5WFsLyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=f8AzB8Mu; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58P0FJ5S025129
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 02:55:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=lbAXN6mA77BRJN0uV3xHHBfz
	VOSuZFy9BYewzxG21Rg=; b=f8AzB8MuyP8nEoEpNuzCVS+vA1YYt3oDHjnpirqc
	Zm+6RCDvbDbmCgdTRc8loA4vgKo9Rvat4uKr9MfR3JrN82i6sBgHX+cyIFZt+Cu9
	0ay654UXCApI5NfFcnSmZRCsn4W5zKeSgrD/R9na4y1Q3maZT8U7TvVcBOYO6CCg
	C42D9F5+R8sWM6vAhGHS3PkzM2lDZFyWW/XJNuZyj7eloXKa8+Axv6DTJtCHOTEX
	OwJQNhXOkEjFSNMPnLqjdKc3ZfklAKvYGK4OagWljoNiyve88/Ot5tkVOUqAYjE4
	1zHnxqcWuyRgMEUDhVH4pteqU52Psq3BvcLGKZKoihCESQ==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 499kv16he2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 02:55:37 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4d8b8c3591fso14398151cf.2
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 19:55:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758768936; x=1759373736;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lbAXN6mA77BRJN0uV3xHHBfzVOSuZFy9BYewzxG21Rg=;
        b=Aw+jtGgcQYW3BIGox8cdIPCm1QB3RitMVAAaZpgHxgQlwNOJaPXdMfw/Si4xX/1Rgu
         bc70rVJ1RX73KlOuUO4RheMZ2nm6claKq76z8U6kACShh8GDGyCMshbvZxrgarAnBzwj
         ipX5I1FjwR0SNcbpPhtGNLwgxNLQ2t3KZzcPS6XgjfBlpa3Tq35TvHdF0cCfZgOSuCzH
         l1+4VcsvYjirNa2HZpHERA92OllfZCeBYKHKgO3mbyooC201jbel0YDgHsnDxqFKtHe9
         cnms4mEW+DQLauBrLkVrGp8ZsL9VSqaeHuuQ/kTLuu1PCLx9sb2xwTyyBJ8tfbUEyE7T
         drcQ==
X-Forwarded-Encrypted: i=1; AJvYcCX6J/TStuyklpD113w7Lj0FR6Odh5p56fR0lN/EQChYyfKVwVNTc1g4i59Lz9xeR3fLmXVdP5CPo550/Aw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZwCIGVo6FM1E0xrlTpXgkF0fuxpgCrD3S77qh3C9GXHSq1RGy
	XcbqQ/ZqiBdIBPiTZ7dsq/cuYMBWkaamShHwX7qU4VmqxNv1oDUZuZ4TizpI6GyFlLlPbgJiNrD
	pWug97fSe1FeCB8eBXKP724/6JAUIeFtAqCKL9f3jE2y5s8o7wvKbUgIcX7hZfdH/IWU=
X-Gm-Gg: ASbGncs49mB4uorfoke4OFwnme0DgTBdkQYgtwsX5CfVmE9aq3NRACGNAx3G4KA6VhM
	igKF1KyFltk6St8ZYUJEiW8XDc9TirmCu48CUr6cnl+VBBDvnrD+9SJnmEoBsb3RgEMVTNZARcZ
	PBeP91OQdZC/AMPi8wQxywPdN1/Zp6QjUMuJvaYjjdc0qIfogiewiafPQhcP47EFBtoo5+9py4u
	j15Cy1dqwbWMJh5GOLpi+ENDhVKaB662sdi5AN9xTt3Z42qEScHqsJ3jEw1cEAqgW06Kc1eMDpJ
	aQzZKMDfyVkFffyuIvGpXaISd6sK8McLyR1SfEtWnoRO9dZ80I7fTdqAoYDPeVNdM2fLO8TULxM
	3Dvb07eEu9v0GZ5oTo6+jYM9TtsayeHotY25x8R3ttjtjWaB0eNOl
X-Received: by 2002:a05:622a:13d3:b0:4d7:e9f2:efb8 with SMTP id d75a77b69052e-4da4cd45987mr26133031cf.58.1758768936455;
        Wed, 24 Sep 2025 19:55:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEDcOH8M6DYCRGbeJRkW/0/SS5z3YW3oZHH0vkC9OBNOaylp5NhxGGlOrhD3KELtaAzAefxGg==
X-Received: by 2002:a05:622a:13d3:b0:4d7:e9f2:efb8 with SMTP id d75a77b69052e-4da4cd45987mr26132861cf.58.1758768935931;
        Wed, 24 Sep 2025 19:55:35 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-58313fc1921sm266870e87.62.2025.09.24.19.55.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 19:55:35 -0700 (PDT)
Date: Thu, 25 Sep 2025 05:55:33 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Wesley Cheng <wesley.cheng@oss.qualcomm.com>
Cc: krzk+dt@kernel.org, conor+dt@kernel.org, kishon@kernel.org,
        vkoul@kernel.org, gregkh@linuxfoundation.org, robh@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 08/10] phy: qualcomm: qmp-usb: Add support for Glymur
 USB UNI PHY
Message-ID: <xunzckmlj2gn7zxvklpwop2v32vmlvr2ri3wnykj45dufqrnzh@hvcuggj55lkf>
References: <20250925022850.4133013-1-wesley.cheng@oss.qualcomm.com>
 <20250925022850.4133013-9-wesley.cheng@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250925022850.4133013-9-wesley.cheng@oss.qualcomm.com>
X-Proofpoint-GUID: At5seubbv5kEkQz-6AOnLuyjbl97a_Au
X-Authority-Analysis: v=2.4 cv=RO2zH5i+ c=1 sm=1 tr=0 ts=68d4af29 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=Es_qMKvyyIjXqoqR7w4A:9 a=CjuIK1q_8ugA:10
 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIwMDAyNSBTYWx0ZWRfXy2gP7oNlh+pT
 JvsLwv48QFiRffpInTeB2FxCpuUlTgIle950peDD6FbMJFC40CV+ISBtu9NEvz/wBrdmYXKEwUh
 0zurVWGtwuOKy2V55ClntuU0YD6wiR55nFqLo0RdIvnEMyInyQhHe12oVkvNzdl5ZSPo2T+JkAw
 3EcDVnmX584wiIhfYSjuwP2wPHA8KB8f+IbTOMaqUBtoY55UvEpmEZz0Fomt0qEduTOV9zDdbZl
 WM6oWgjgbzq1a16ETHDRFpoSieBstOOsnLdv8rtwhSLWkp2DJRXMHDK2PhSI7q4OXz8IV1YWb3N
 mN/d/v6hbCzbcY29qpihqpmAPvE81jHFpAB2gKeccdItYn9b8QjKCvwKSqxGIUPiaG4Q6Usaog2
 QlHb+RUT
X-Proofpoint-ORIG-GUID: At5seubbv5kEkQz-6AOnLuyjbl97a_Au
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-24_07,2025-09-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 suspectscore=0 priorityscore=1501
 impostorscore=0 spamscore=0 adultscore=0 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509200025

On Wed, Sep 24, 2025 at 07:28:48PM -0700, Wesley Cheng wrote:
> Glymur contains a USB multiport controller which supports a QMP UNI PHY.
> These ports do not have typeC capability, so it needs to be differentiated
> in this manner.  Update the QMP PHY sequence required to bring up the UNI
> PHY for Glymur.  The UNI PHY follows mostly the same register field
> definitions as previous SoCs.
> 
> Signed-off-by: Wesley Cheng <wesley.cheng@oss.qualcomm.com>
> ---
>  drivers/phy/qualcomm/phy-qcom-qmp-usb.c | 163 ++++++++++++++++++++++++
>  1 file changed, 163 insertions(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry

