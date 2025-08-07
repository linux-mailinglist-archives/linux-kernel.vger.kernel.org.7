Return-Path: <linux-kernel+bounces-759009-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59B3DB1D70B
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 13:54:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 75DAE16B9D9
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 11:54:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC3D123BF83;
	Thu,  7 Aug 2025 11:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="fDzMOl7x"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BACF3BA36
	for <linux-kernel@vger.kernel.org>; Thu,  7 Aug 2025 11:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754567645; cv=none; b=nSOOTu9YhgYjgMJ2uQJXDp11FCAV+Gi059StfruFOUKFlc3Z36Gkv3CLlHIpM5fEIC76rEoszpi3sBdnNRdf+XA1Gltyxe1zBLNcrGR7mhUSOyxqDdvp2SHqOa3uck/2a7rZZG060aEiiLwKm4/rdY13mA97erucpywY5Qw49YY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754567645; c=relaxed/simple;
	bh=ZZJ+58v5xVPIVDkFEIoUq75jX+V+PSTGi4Gi+0x9868=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NnTg+1/Ueb9+yaE1LKwy0AmBg7+e8Iw/5fyp4D1s3+zIURYf7XZkblOEfMsTPVN2GMQPfgIr6KQjPYmLgAD0XeLQ8vhnDMLa+G8nqedT7wqz36gU5d2NTokctoPfgPLa3L0EVk6JdM9IPen5EhS/Ba0nRcDgC7Tbv4RaLXSAA3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=fDzMOl7x; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5779DFST020568
	for <linux-kernel@vger.kernel.org>; Thu, 7 Aug 2025 11:54:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=JmsYXKB6unnEWfBMH3uLtxy/
	JZx2U35Fps5OvfGfeC8=; b=fDzMOl7xqzlv7RYzExEPyE1icsp+4hkb+9Whd0jU
	e7PGg2yS3ezCbYrHaKmmIC4RapiJMwvGHJ5IywhH1TeZ9lXiprHRHKLmXUiuqVZt
	dcShI5rNTAMeVPpcJVFpNtD3P/KvQuhvxkoB38huTwb92DG5+kmF+0cS9bthmtsV
	MGga/q16G77lPAW1UAncjlUI3S+OhgWXBbJWzUBOozYVO8uLeL8faIA8tCME28X5
	1S8AXB6QyRH0DmhhN40mQekaOH7eL8FNCld5VP1Qut0+j1gCAM76O9oZFmuuZlbv
	CXoBPsY74I8oxMOfE9UD7Hm8wxTjkazXrLNqSTjk7mZ8tA==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48bpy8e566-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 07 Aug 2025 11:54:03 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4b06b67d99cso23257681cf.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 Aug 2025 04:54:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754567642; x=1755172442;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JmsYXKB6unnEWfBMH3uLtxy/JZx2U35Fps5OvfGfeC8=;
        b=kwQGRFyU1EVqJuyoG8nMdBS0nXKiCdO1CLXWzntvNF6m3inaGbKOajCI7FIMZ+LBAa
         m7SuuSJq7XbjmWYRwHyxoQ5b5T+Qxxofuqkyifz8qsT6fpzsdIPDpkoEuSF+XojOVOF6
         PjO2KXOnH7D4y15T2Ze/G10gP8WQ98uQHcE1VXbYAvhXwIO9dexhHtk8IAElkbE4VmZ8
         IfOOQdE2XT9ukOdFKMdSQoBh6YeMoCZwBJmSr565mxPuefC36k2QclfoW9rO3yZBImUD
         w/j31lg6Vo+Q1yCUBHP2tp2XbGAl2UImm+od+KOOOeUgLTjoriBgudChZq863qT2rzsi
         W7Wg==
X-Forwarded-Encrypted: i=1; AJvYcCV158Ohke4ojfxTWtDwbND59zNxiP3d1INiVmug11zlHxgln/eJbJrmNWGQabSG5Qsw9TQ+hrhE4DlBWcQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6hxuu1ih5ImEklLV1bMvbLsaPQCOUoXrOVXZ96CrkRx36Gou3
	j1q0TraE9Dmm+Bwr7P/seZGBeIgV3Q8Zxf7Fz5b6NP6DIUQYVUOix4Lwkt9Di81Heh5MbA0gBnJ
	U3/E6WAHEhnp+k2iuWr0Z9VEQWVsWtZctTeGEAwswqPbq1n8ab+SwwY+7QzcgKvesbMQ=
X-Gm-Gg: ASbGncs6wWh5QyDFMEk12NeaRGawkIgIqbE2BugoFNvZrfskdLuHIUB1aAezmgCKdpl
	qsohfWAPC7Rli41x+l+uDnlrNQ2pYpWUPnZmm201GjDy/7R/xZSJtf5nWxWGMipkurZeQME9rJg
	ZUVTsLiNRoK0YpWbLmR5+4IBkzT0yPMcQ6KyPhlnxpAWe2RQNOvujdG4PyyLD9uIASbD4BdGj4u
	C7oosAvaiXETQY7uz1qJQxmLhjJWM3k0/2CK3o/ofp7tmVahR4Pbe3ajKyblWKeabLMZgHO5yns
	ZlE2zXUFx/PAPbuwjhGLf0AyAEMNK1+OjvNozd0VHf/1y+xCaO91UivqM8DqPvXaNLzng8GUk+9
	uzyFg7LXixpAuPSPFW7z04Nngqube2PXVdlT1EXxjR2N24smy3H8S
X-Received: by 2002:ac8:5a12:0:b0:4b0:7170:8559 with SMTP id d75a77b69052e-4b0915a001cmr123089111cf.40.1754567641733;
        Thu, 07 Aug 2025 04:54:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGa8xjZrgk7JKGa+kcJ7fkcp9cBxJaas2DISbCOZ14pSOMtXEioAO7a/COluo9VEZGCXO56jg==
X-Received: by 2002:ac8:5a12:0:b0:4b0:7170:8559 with SMTP id d75a77b69052e-4b0915a001cmr123088521cf.40.1754567641205;
        Thu, 07 Aug 2025 04:54:01 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55b8899ebd2sm2602768e87.42.2025.08.07.04.54.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Aug 2025 04:54:00 -0700 (PDT)
Date: Thu, 7 Aug 2025 14:53:58 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Cc: Jorge Ramirez <jorge.ramirez@oss.qualcomm.com>, quic_dikshita@quicinc.com,
        quic_vgarodia@quicinc.com, konradybcio@kernel.org, krzk+dt@kernel.org,
        mchehab@kernel.org, conor+dt@kernel.org, andersson@kernel.org,
        linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 5/7] media: venus: core: Add qcm2290 DT compatible and
 resource data
Message-ID: <pt7dlwbxcipukwc734ftspj6ekehtnzfwndb7rqx2ihpxqwyzn@m2pyqy6nugdd>
References: <20250805064430.782201-1-jorge.ramirez@oss.qualcomm.com>
 <20250805064430.782201-6-jorge.ramirez@oss.qualcomm.com>
 <4chbcvub4scnv4jxjaagbswl74tz4ygovn3vhktfodakysbgy3@kukktkwd2zsr>
 <aJHgh8mon9auOHzi@trex>
 <ce9cf017-5447-457c-9579-700782f9f0c2@linaro.org>
 <aJRMUzF0GN2LFIZd@trex>
 <40d543e4-e53d-4289-9b87-5ca8c0139bbb@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40d543e4-e53d-4289-9b87-5ca8c0139bbb@linaro.org>
X-Proofpoint-GUID: kfXHM7c9f7FUb-wuF0Zes_k3W5n27TwK
X-Proofpoint-ORIG-GUID: kfXHM7c9f7FUb-wuF0Zes_k3W5n27TwK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA2MDAwOSBTYWx0ZWRfX8RSUPj4Gth6B
 wzlhOP+sIxSdjmc7MbFzRSSiYruXuGaCb6oi2VwiOWOOsEfZFPKoUxt9JZa1pUXiesuQmoLQbA3
 0GDX5YENNib20Fzel6mUtaV5UDvTjkEqGmS744+BBRlt05v18P2qyhkT/XE7l3Bi9FYPz4mgXNK
 IU7GT9TOofZZURKBCObByRE4cEprD3X3kE8nENndcxJvx2QL41kKqU2/lfbSFEl0CMAnzHPFqCZ
 XLkzeeatDzyhU42OIhta0JZ6kPR/vLOo8WFsDdolQEszClA6E/xeextPkufIePiLU0dp1y4tgA2
 HJApUo6cPdtPxRimY2jcK5+VHFIvqpHmlO/9dhycFQLwfGAVas7dQ4Eur/RWRL5ravrotbbckCc
 MUiycLfq
X-Authority-Analysis: v=2.4 cv=GrlC+l1C c=1 sm=1 tr=0 ts=689493db cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=7TY_VEaP9L5SwCdglBoA:9 a=CjuIK1q_8ugA:10
 a=ZXulRonScM0A:10 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-07_02,2025-08-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0 clxscore=1015 suspectscore=0 priorityscore=1501
 phishscore=0 adultscore=0 bulkscore=0 impostorscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508060009

On Thu, Aug 07, 2025 at 11:11:31AM +0100, Bryan O'Donoghue wrote:
> On 07/08/2025 07:48, Jorge Ramirez wrote:
> > > There's not alot of value to the user in that configuration.
> > I dont know the user base but when I originally did the code (v7) I was
> > thinking about security conscious users (signed firmwares) who might not
> > be able to switch to the new fw release so easily (unnaccessible key
> > management and updates).
> 
> Since the driver for the LITE hasn't been upstreamed the # of users must be
> ... zero

The question is about the firmware side: if we support decoder for
6.0.55, users can get video decoding using existing distro firmware (and
just update the kernel).

-- 
With best wishes
Dmitry

