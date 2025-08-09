Return-Path: <linux-kernel+bounces-761021-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CDFAFB1F33F
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Aug 2025 10:20:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A139B189CF51
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Aug 2025 08:21:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9D8927E04B;
	Sat,  9 Aug 2025 08:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="MAGfaBA8"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA89014F125
	for <linux-kernel@vger.kernel.org>; Sat,  9 Aug 2025 08:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754727643; cv=none; b=OdNK+nd+XB6nkiuT45m/02GKGnwsvW1oWNNaE5A8jVKJYRX80aBVGfTVdHQaJRSlxvbRelVbdzpPTv2Ea03CQL853ul6hjnQN3XVV0wTGBaWdLHtF5FFkS030zVSdi94uLddPTKyOrxxIck3u1EuKgHZCHlK1JHpexxTB60UYww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754727643; c=relaxed/simple;
	bh=SGjFGOE4lQDZczOSBQm6XCZj/aKwb7yDyErC94c8G/0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QGPkoZWWYirFx/N6ivAKCJX1qbKojVBa658LzfPvoPuiZ4+CC/bJI1YFcMUP/GxQE1KXFHDy1YqPFMSeBNVzEZ4K7JOwqISG53L6wN4WMv6NUb9vQN/FVjRew7u2TPANNtlbs/i/xB1Z4G13Qi/1Ba/Rpc6By428El4o05r/snI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=MAGfaBA8; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5794e2lE010478
	for <linux-kernel@vger.kernel.org>; Sat, 9 Aug 2025 08:20:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=2H9KRizh8IleLkCoQjNl9JsL
	yZ+FWKuglV3/DdZPO8Q=; b=MAGfaBA8T+Ra1m1wA7iBsHcVPnWichOrkJ6Hwa2P
	MDJWxFoJIyAChoNv7Whs+9DgoVdmCqEWVu91q0gSjXWHwtBMxxa7RuLZiUtG8Fag
	QMcPIvqAgLjCrqE+tFwUV9trMjCN/M9RtQpFw/Z9rPC9azPkItP4yxOT2P00z3dO
	+CHGX8SCr3dCjUy7dEKxEjs01qM7fNulbQI6Js+koHbfqr0p4BNRbI0ecCQoCLI1
	1GsUbAyQKCLD1ohKLTUErVQCdGt89ERmq7byNZcOKB6YrpPAFQHOFn8Zqzkt/SJk
	EVpAvcE8TihcMBj3HLOMv+ayG5eEIRvv2Pku9ZniMjOZKA==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48dygm88b8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Sat, 09 Aug 2025 08:20:40 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4aedd0b5af9so58304271cf.0
        for <linux-kernel@vger.kernel.org>; Sat, 09 Aug 2025 01:20:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754727639; x=1755332439;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2H9KRizh8IleLkCoQjNl9JsLyZ+FWKuglV3/DdZPO8Q=;
        b=ddrj/7Ipk81RqFKshdKac3L8ppIZvoiA5/bINQLGmDHjczzKj6S+Cl2cT1QEEtfNIx
         aabVIpkNd+G8pK2jfbQ5Y1nLswl0lTycBOQtFKy19BJjnLmBgo91oJJ+Ixc9tqedBPXi
         V9pZ7htfPaNP+zboKpHw0+zgDI6GlrCZUna4s8CuAucgiTjLKbP48cxyfKty6kUcBIBX
         9cLong5hNMR3YY2BGj42cH8wGskz2oJw4C9Dy4MOCy0D2+IzcfVO4SzyCzQDqdun1S6A
         jsf0/AJTO+Jx3HviG3cbwsl8JPq0UjYA66VSC9BXkTFwylFK2/zW+TNFCJihn9ckDChL
         VkLw==
X-Forwarded-Encrypted: i=1; AJvYcCVLKITGwQxyFqOl/gju0yxXNaFOvHt2oQwIrfjzbu9/brT+YJT8IKTYp5uQKOxUOMKeKIp3Cw5a5H1gwPM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEsahr25pU4bAbKu53jXhXuoTMADofaKMv8Mq+qs+XGFgLpKBY
	WTI2LZiM/z48QQJc9yvyxvV++t3CdudCCGy2BEf8vLbcLCJJwROVwi9dIyU2ueGlEeTpjXahqe9
	Wbiy8kPnV+7H6BdWGPTYv48zGA7HMjK9RjXn+758cpMrorDZ7msWfjpUNnaNB9UB/Ptk=
X-Gm-Gg: ASbGncsP5l+y4Gmu/KQ7MxI375Pewq6Yd6XIeybOcVYYvBDxKxWHxdvnZuJM5YlXtIe
	7AzMZWDGhO8KnSUdhtZXusk4SRSSAmQ18GKRxyFjGLctzUHdwSSZYp7DrLCgv6z0xTvIgR6SzQq
	77LOr4Mt0XrfmQy9kny0rMaxjaBnSBDRuux5uOsBS/ZfxXdOV3g1BJOpsvPX84kJVRrfiyxqhDp
	cWVeTvKAPIg8ernClFKsScPm0m08DTrlkaVHgGVPRytqJ8pkm7EgT6zhriTFg3T9n4DjUy5vO78
	Tz5NAteztnePuMy0f4m1hqjbJ3cSisoqu4TdmZEORPP+ISgkToQjkpw/ICu/ewkHhJLyOcHOZ6H
	SnZL7yUnO99mhw4w431KGunSpXLLt4NVVKQ5AcTA5cfTTQsjI0Suv
X-Received: by 2002:a05:622a:20c:b0:4b0:6d53:a0fc with SMTP id d75a77b69052e-4b0af4deaafmr103917411cf.7.1754727639476;
        Sat, 09 Aug 2025 01:20:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGaybZqS8e1II26PBLtR2MEev8RqN/YcLWWOjMTMd4jMxYQpAM2kTd+wUuQlaFFQ87m9qtgiQ==
X-Received: by 2002:a05:622a:20c:b0:4b0:6d53:a0fc with SMTP id d75a77b69052e-4b0af4deaafmr103917111cf.7.1754727638990;
        Sat, 09 Aug 2025 01:20:38 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55cc8d64512sm146866e87.11.2025.08.09.01.20.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Aug 2025 01:20:36 -0700 (PDT)
Date: Sat, 9 Aug 2025 11:20:34 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Nathan Chancellor <nathan@kernel.org>
Cc: Arnd Bergmann <arnd@kernel.org>, Rob Clark <robin.clark@oss.qualcomm.com>,
        Dmitry Baryshkov <lumag@kernel.org>, David Airlie <airlied@gmail.com>,
        Simona Vetter <simona@ffwll.ch>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Arnd Bergmann <arnd@arndb.de>, Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
        Bill Wendling <morbo@google.com>,
        Justin Stitt <justinstitt@google.com>,
        Antonino Maniscalco <antomani103@gmail.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Jun Nie <jun.nie@linaro.org>, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH] drm/msm/dpu: avoid uninitialized variable use
Message-ID: <fcgmsw66wi6eqtcwhcz5yc6migoauygaztqumztseo7uu4a62g@bg5xnnd4eosw>
References: <20250807072016.4109051-1-arnd@kernel.org>
 <ouan6tfmoefwuvs7wmhpzjdwmxfhqh3ad26j5tmwdugnq7ieda@ddw6dfqtq27g>
 <20250807143444.GA1009053@ax162>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250807143444.GA1009053@ax162>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA5MDAzNSBTYWx0ZWRfX6H5dJFEB0ykt
 xvzIIvrs1HGwopHFcf+zC4lALMXU+z4HCLZeuLIFrn4sWmtYhD++XgJ8Q1cogIksnuoMN3HvDJs
 lGhiHHCXeBX3nTw3O2U5fTuOQAbgXroPymGtpXEgv3v+QzmuhlfEVBeX42pjAnWR7Pf4WDwx7te
 SnrLRlk+T7tMhUcGFU5hTBvTX3ZlKuzX0lTdw2ba5hMIDOuSkPChcDMYAsg1veD3eteKXTzV1B6
 kT25xKusRFyEMuT5OI9PIguU8tGWAHUnM7soRoWaxQ21n+9oW5VcJMZ+RfzwJPMzitnKPsT2rJj
 lCQgixKqj5hPJN+OG42jswwqpHAxkJVPcRwTKlr+1hd+FTQDGCtPFZU5566bpw+v6ePNrjqlEWP
 otZj1Ekv
X-Authority-Analysis: v=2.4 cv=FvMF/3rq c=1 sm=1 tr=0 ts=689704d8 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8 a=yl-pN8RVu-4QMKwhACwA:9 a=CjuIK1q_8ugA:10
 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-GUID: WxFGFA9wBtZ_m9Ulbg9mWJiTT7CGzpts
X-Proofpoint-ORIG-GUID: WxFGFA9wBtZ_m9Ulbg9mWJiTT7CGzpts
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-09_02,2025-08-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 bulkscore=0 suspectscore=0 phishscore=0
 clxscore=1015 impostorscore=0 spamscore=0 adultscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508090035

On Thu, Aug 07, 2025 at 07:34:44AM -0700, Nathan Chancellor wrote:
> On Thu, Aug 07, 2025 at 11:09:38AM +0300, Dmitry Baryshkov wrote:
> > Having no plane->crtc is a valid setting and it is handled inside
> > drm_atomic_helper_check_plane_state() by setting plane_state->visible =
> > false and returning early. Setting crtc_state to NULL is a correct fix.
> > Could you please send it?
> 
> I sent this fix three weeks ago, could this be applied?

It will be picked up for -rc2 (hopefully)

> 
> https://lore.kernel.org/20250715-drm-msm-fix-const-uninit-warning-v1-1-d6a366fd9a32@kernel.org/
> 
> Cheers,
> Nathan

-- 
With best wishes
Dmitry

