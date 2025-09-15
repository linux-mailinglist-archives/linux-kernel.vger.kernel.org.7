Return-Path: <linux-kernel+bounces-817650-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 83A85B584E6
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 20:45:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B23843B0315
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 18:45:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B176A1F09AD;
	Mon, 15 Sep 2025 18:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="PlXw/uhj"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3C61BA3D
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 18:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757961934; cv=none; b=s643k9QMBfalTVKtYRPJDWYggOAVzfB6YNr7EEtQq5+Sy7F0sIQsp0YO4aTFkLu97ZokM0kpkyB+PGEaOn3tTj0CWHGgga3rBBztRfp/uAp3fcapcxfrKBNqOw6Rc57Nv3SoUDiq4mWilZVftCNIVm+rLgpQ2S1ykRLR8PosL30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757961934; c=relaxed/simple;
	bh=eVVT+OxYy8BaWr+WuHhr2eCvLn9jLLFM0mzTODfs9z4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=GvmpFX8kU6/iJL6kJXUcdDrRgu5NvOLnX2SrrQcwG8kHZJVWyxjmRD8U3n/agFgC9vGzS/Fgi2A533Wl+dPbfeRS29NwGsuM9//h5JYHQ1cUPUaIWisMyNzaK4gKfVelUPbFXJHNco3y/qcJdrO6RKs1Vqsw50J/hBEBQJcpb44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=PlXw/uhj; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58FErnBU027143
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 18:45:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	IhG4O/EXd8muCOughfBp0STWT3L0CUbcXi2YvRH227g=; b=PlXw/uhjfpTRIatW
	GBRmkdtL2xVg+JWPktWzlbnf6QonLDYTB5l9BrI446vZCBceWt4CRZLsNWeLxU28
	aXb9DLC5qi38DHIiWXLHiqNGhmDh/JQPhis7LIvMuWWus7ZTCIOh1LgaRkwWJf4g
	wJEwpjfgb9+uQh5o3HOoocW4pWK9d2KssUXmoGQFyDoFa2NbWCPvkmKDEOEqnjmI
	bQaOwvyQN7MShcB5QoI96zpzW5Z9ZPCpnQSKGge7bmeg34GFBGMiLnpG3aee0prk
	D6upArbrr0DvaIPpz/Vj4Y1BHmO4q/8jI989UPgoHw5EjjNsdO3PbhCx5ovEHZOQ
	G+GkWA==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 495072p2ue-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 18:45:31 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-7863bb60feaso16477716d6.2
        for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 11:45:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757961931; x=1758566731;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IhG4O/EXd8muCOughfBp0STWT3L0CUbcXi2YvRH227g=;
        b=lwYhZovpouBpZ2/darZIhwHd8yR+pCsIhxwGPEIn4hU53GvFV1AvdrzRWFxu7Os3zH
         ullZ4f5t9DvcCqeE40pwoF42ZA4L5uqNjpKwAYkLaEAIFFVqyfuaVHLYsO3MmNFE012q
         8+3XK+8xtMuW4NzvOxEGXfYTzjgXClPGDDoJLnZI/jGo6p6B8T5lJsWEI0Ni+Y85QKbS
         N38mKto/4/BAqE+g/IRzYZzBFlNeVZy3AsEwfZ7XP0mP32t+wT0kZ/P4BbT8p1bTldsB
         HBC8DFVc4FoOYpdOQWp59z4hK50pZKOuTSpcJ3AQIzVviDhOhnGsaBYMzamaPWE0i53n
         DkBg==
X-Forwarded-Encrypted: i=1; AJvYcCUp2+hyo8627YaSZbcdjhzk0SbpcFOhSoiDOcOsvk3Bzn5GUk+CRHfgVyhab4I6K67iDOifkP7Zu3F8zfA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyzaUQp7e+rh3XY3kTPufOezN5fJyc64DmKWvME6fENcVxvhT+z
	Rqvx1CyybJq6CSewIbSFnokUGZt0NAPsO6iPk60EKX0kGGPvCxZoYZURBPzOKqCpPtTzFhrv4LY
	BHFMSkjH3kPT5lH35XOwMW1gR2VcCeUMYEfyHdV2N7CiEg/p6niaRR9Xdv2U1Gbade/M=
X-Gm-Gg: ASbGncs+P2CpKkVSCk7CFeSFKKVc7AXFn7MfZ51tE/88/uaTZDS39xokqCueKC5yuo0
	ombA5S+0A05IiZyCD/y8a184iJKEOsliBbsGKh8WLyEbE3QII9TmCJXbc2eD0voZvVdqz8B4vAr
	qygp0NOEESnDv7OWc5u1baqykGfANwBE1UqGw1phxfmZ+M+Os+1muHrN+28e41PIXSvv0d1URtP
	Vb6Hpka7/j5y0xyPDNxO8tKSa+CJmMCD6lBEWWD/fvn4vQROWcveRO5gVoyQ3Lb7nwzHA5CUAP0
	JduBBNqY+H2HGc5tmLXjYyiQmpT4+UA4OZttChMBg+JxMOLAFuO702QfifKJYXSy+HXu7bCzvy+
	QwiweVs1ePyQFMSPSmUAxXCJY3igCtB2ln3Fgnvi8oE6y5Dh6yNP3
X-Received: by 2002:a05:6214:d4e:b0:766:769e:8c79 with SMTP id 6a1803df08f44-767c2be8032mr189965596d6.31.1757961930366;
        Mon, 15 Sep 2025 11:45:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFmrWfIl7CmMGW/DaMc1BVI1dcDXfE//3x+Mq8gnVVnpv/GMQWg0bopFFbSV8m5IJZDs/ZvVQ==
X-Received: by 2002:a05:6214:d4e:b0:766:769e:8c79 with SMTP id 6a1803df08f44-767c2be8032mr189965146d6.31.1757961929677;
        Mon, 15 Sep 2025 11:45:29 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-56e5c3b623asm3815434e87.11.2025.09.15.11.45.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Sep 2025 11:45:28 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: andrzej.hajda@intel.com, neil.armstrong@linaro.org, rfoss@kernel.org,
        Loic Poulain <loic.poulain@oss.qualcomm.com>
Cc: lumag@kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Laurent.pinchart@ideasonboard.com,
        jonas@kwiboo.se, maarten.lankhorst@linux.intel.com, mripard@kernel.org
In-Reply-To: <20250709085438.56188-1-loic.poulain@oss.qualcomm.com>
References: <20250709085438.56188-1-loic.poulain@oss.qualcomm.com>
Subject: Re: [PATCH] gpu: drm: bridge: anx7625: Fix NULL pointer
 dereference with early IRQ
Message-Id: <175796192787.524478.12029336262395393555.b4-ty@oss.qualcomm.com>
Date: Mon, 15 Sep 2025 21:45:27 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTEzMDAyNSBTYWx0ZWRfX7Oq/j0rm1TNP
 0UfHbcaOoVNDoPM3EO7/4Yi2X7dAyxx8BuL5molD/FfwIWUAS7r9jYhV2PnrgdlVpkfbBAZ/5l6
 o4keSkyIWjkYIAwHE1pE+qIRo1eibYMAHSds+WIKuu4I3RUqNzwDCareLiVAOoqsOPxufO8D2P0
 sJbDOdfXO3zZdWadslwSrPi1aQK3d9dLVhpaUxOxrEuewhEv2Y9JdcMkTVch2VNuQk+GWjVSC5R
 58/lWVAHEcoS8g6IjHdv2DMsMEfDSJtY1x6cyd9xntm3nIdydYxwugLD1Rp5j+CB8X3y1RMEJ82
 IfUh3h/69b8NHkPsDXcoT2c+/IB5MJcoezXddCH3JnWxwfcPN+l82nvKrJUMKqaCdnCJXuAddqW
 7nfxE8ji
X-Proofpoint-GUID: yxsplfNzpXwxiH6RzkpYoANSHkJ82-N2
X-Authority-Analysis: v=2.4 cv=WcsMa1hX c=1 sm=1 tr=0 ts=68c85ecb cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=yJojWOMRYYMA:10 a=LWE9zbpONBY6LCXfEiwA:9 a=QEXdDO2ut3YA:10
 a=zZCYzV9kfG8A:10 a=1HOtulTD9v-eNWfpl4qZ:22
X-Proofpoint-ORIG-GUID: yxsplfNzpXwxiH6RzkpYoANSHkJ82-N2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-15_07,2025-09-12_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 adultscore=0 bulkscore=0 spamscore=0
 suspectscore=0 phishscore=0 clxscore=1015 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509130025

On Wed, 09 Jul 2025 10:54:38 +0200, Loic Poulain wrote:
> If the interrupt occurs before resource initialization is complete, the
> interrupt handler/worker may access uninitialized data such as the I2C
> tcpc_client device, potentially leading to NULL pointer dereference.
> 
> 

Applied to drm-misc-fixes, thanks!

[1/1] gpu: drm: bridge: anx7625: Fix NULL pointer dereference with early IRQ
      commit: a10f910c77f280327b481e77eab909934ec508f0

Best regards,
-- 
With best wishes
Dmitry



