Return-Path: <linux-kernel+bounces-758686-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CEEBB1D2A1
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 08:49:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BDD11724E9B
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 06:49:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA4772222D6;
	Thu,  7 Aug 2025 06:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="RBpnyMs3"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC9581E5B60
	for <linux-kernel@vger.kernel.org>; Thu,  7 Aug 2025 06:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754549338; cv=none; b=sWaND2+5tVtdKmG2fVwi1HglofgZnLZhWxV4t8AbaS9eD5bUarha5hSpOi+/wBexduWMqN1bzgT/aj3EUAFfTkALCg9GQkfFazFXa0zV8TRK6lAFOvbYmxIHjLvGuFTDiObaVCtW0tsxo65/9O2lbvrm1paOCF+B59oV3/nU7Hw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754549338; c=relaxed/simple;
	bh=aZrNzzQLDAEnGHKbIl3kMoz+DHiDzbdiBzd6iB8M95U=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jVOpJxUWNKX5HimnGKx4DmJ2k+0VYJnBbpWO03+v1d6Oj+1zyYqnjJw+/EdJXKQ4xNIdlh98KPDntLPB13d626DgO+G3Op1/DUaMwy7iQC49dUh6bPajbxmQEPsqJyamHmEZm8dxvAS+D0XGFjDW0tnnuIPOkGG+uiS+Y6Tt+hE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=RBpnyMs3; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5772tTE0003968
	for <linux-kernel@vger.kernel.org>; Thu, 7 Aug 2025 06:48:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=IIrAD+p6ljX7tc226RXg54qe
	tKyZ/GO0KJyMxB2uPLQ=; b=RBpnyMs3uocDtG0EGSOllwX924wT2wNgOSY2LFnp
	XL5CjlUjYJcgvMNKItuL3hT4uIKs7vmqk+mZA1rpBcft21tqn9Gf2jS3nTdOUpOp
	m5FagWttN1b01DX+icz5eNYX0+gB2KrmskU7J8DkoTkjiE7R60Xqry2ka25tMGuE
	BfMqxZxsCJQKUPpYCK2Ge1UozMv9IK91CUtblPsnp9mDefK19sMzeZ4kOFfP2O7V
	Buhg0Fa8GuD7dpdvvsQ17EzQ4DyI2L0l8DY6amevN7blPWNqx84EgP4pWoOSaGCI
	jTvO61xDswIE4iox/RYrAJOGm1XB2s2PKn8/LO3Q81XEUg==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48c8u22awx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 07 Aug 2025 06:48:56 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4af156a27b1so25183771cf.3
        for <linux-kernel@vger.kernel.org>; Wed, 06 Aug 2025 23:48:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754549335; x=1755154135;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IIrAD+p6ljX7tc226RXg54qetKyZ/GO0KJyMxB2uPLQ=;
        b=IT8Z+MgsuRrr9FyjFqyWGcDubz1coO6d/nLv2O0ZUb1wIvUjgoCjzPuZn/cVg7BaLS
         uUNTOlUPk80Wlv1Mu2c1AsIY/y0E2kfqEYTEcDwLJYFCEhuZRrfRZFY7poeMTKj9WG2D
         cpf9HvqOt8zG73/WEsSx3fpUW/2O1BFRxW2KvzPIYJRNHcMZOMjG8bsULbLspkh45khV
         A95+XjlCXM4IwZEjYs4JGsUjVCRGzb6yXXWVQqp+ca6mWuZ12y7PUtBhLSdZt/686ZYQ
         Byd0Rr9zqdBukxwwKxUNdD0V0Ty5iLIVuYye5m230ONoLzmn/QoCpqU8WHLLLp5mq4Jm
         IRKw==
X-Forwarded-Encrypted: i=1; AJvYcCUVF88d4vFQvIxCcZM+SB/HGrSLhBTR89BTao8oPIVztPRDamaxxO0cO4QRmPtKLRRRZhtuKEGGTVwYXEw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNU2DZVR9yp/gJcViWSSD/DA6AY+gxr9kRoLqpQ2pIlS4wnEFp
	r/a9wPFlUFzyUJvVPdunhcIJcDQ3UzHQQEUM6dHb2D87kB9lNlCB5HJOf6xbnRyxMKMTUSmYm+E
	2y/Tstfpri1htPtfaHVbQ0BsRuRv+2A0IarttxWw8hvdkX5w9kqYQ1uEwx41BjPdBwNE=
X-Gm-Gg: ASbGncvQ3X2v9+DZB6QXal5frpwMW+q0JEpk43jSRWVPj0ycPNf775w9Z9Sb5qXNg38
	+Q7erNWDMSOr8RjPw2jhH2HbdshuV9Z9pwUlfsEZ1O+FCsl3EeZoiOzjUv9kSerE/jzwdUsGLOq
	N9Akv0bPoMAmWgTCRCpPvtSDKlwgUdk6ZYqjt+JGlB0gDWZ1xKG5NS3z94n3Z9e6I4z/BKj1lZe
	F930FJfDn8NQPJ5rhMpXOFWNoSMiA/W9fJA21c966m7NqWnRUMZHn2S7Dr7ApnC4Tzpcf5x8HNz
	6PSIIoxhiEZ0d78zhBNcWgFxoRx92p01g+3MJf3lDXCNK25B5R23guJCiRnnxAEVzv+o3g==
X-Received: by 2002:a05:622a:848a:b0:4b0:9814:e225 with SMTP id d75a77b69052e-4b09814e67bmr45500421cf.0.1754549334373;
        Wed, 06 Aug 2025 23:48:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEP0oJoncPJHaap5fxItHw99SW/LCLWUFYaaiyhrRJkYhI9cF/QkF/Nfho8pad+5TlCldgaog==
X-Received: by 2002:a05:622a:848a:b0:4b0:9814:e225 with SMTP id d75a77b69052e-4b09814e67bmr45500251cf.0.1754549333839;
        Wed, 06 Aug 2025 23:48:53 -0700 (PDT)
Received: from trex (205.red-83-60-94.dynamicip.rima-tde.net. [83.60.94.205])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-459e5c40eb1sm36362705e9.6.2025.08.06.23.48.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Aug 2025 23:48:53 -0700 (PDT)
From: Jorge Ramirez <jorge.ramirez@oss.qualcomm.com>
X-Google-Original-From: Jorge Ramirez <JorgeRamirez-Ortiz>
Date: Thu, 7 Aug 2025 08:48:51 +0200
To: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Cc: Jorge Ramirez <jorge.ramirez@oss.qualcomm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        quic_dikshita@quicinc.com, quic_vgarodia@quicinc.com,
        konradybcio@kernel.org, krzk+dt@kernel.org, mchehab@kernel.org,
        conor+dt@kernel.org, andersson@kernel.org, linux-media@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 5/7] media: venus: core: Add qcm2290 DT compatible and
 resource data
Message-ID: <aJRMUzF0GN2LFIZd@trex>
References: <20250805064430.782201-1-jorge.ramirez@oss.qualcomm.com>
 <20250805064430.782201-6-jorge.ramirez@oss.qualcomm.com>
 <4chbcvub4scnv4jxjaagbswl74tz4ygovn3vhktfodakysbgy3@kukktkwd2zsr>
 <aJHgh8mon9auOHzi@trex>
 <ce9cf017-5447-457c-9579-700782f9f0c2@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ce9cf017-5447-457c-9579-700782f9f0c2@linaro.org>
X-Proofpoint-GUID: Qkqm7vgCR3X3ZMKrrSSq614diO_cBPUP
X-Authority-Analysis: v=2.4 cv=Q/TS452a c=1 sm=1 tr=0 ts=68944c58 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=Rr2dNH5/fcnoRoBmcVUeRg==:17
 a=kj9zAlcOel0A:10 a=2OwXVqhp2XgA:10 a=p0WdMEafAAAA:8 a=z1Oz6Vkx26DYFd3kf8sA:9
 a=CjuIK1q_8ugA:10 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-ORIG-GUID: Qkqm7vgCR3X3ZMKrrSSq614diO_cBPUP
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA2MDA5MCBTYWx0ZWRfX4nrWYHIHwFdg
 vJYEjlCpgkZ8sesNXgtQoyQSbBbfRa45sH0biViYtn1+POMvAGKfisFuEHlS0YAd7x3hj5Yajp3
 IHW/oFsaT3qgUzA/4CUjrFxZOyP2Z0EClVp3ldRo+kG8e+kM+vl1FDTu6x8u/u3g+J+eubwsgHM
 gAsmQxXN3OnafHZwtpdDe1BV+thkoTYGRzfj0rOZvdJVk53UiwZGSIPQGNEt2ejr3Auf5SGVPHl
 fHuStpiUNTvL80vRmiRAljInGOdN/TGvkcoFEorAAY5lRd6hL/3jLXN7SKSRp1AVMqAwFJvGkQh
 vPmvIw1SIbegqDfq2XJarwwwCgZ32LrsVuKutMsO+aASlwEsymnpg/h6WoddLoqcdy3qmYErMAG
 3LQv4OBj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-06_05,2025-08-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 clxscore=1015 suspectscore=0 malwarescore=0
 priorityscore=1501 impostorscore=0 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508060090

On 07/08/25 07:35:35, Bryan O'Donoghue wrote:
> On 05/08/2025 11:44, Jorge Ramirez wrote:
> > yes, in V7 I did implement this functionality plus a fix for EOS
> > handling (broken in pre 6.0.55 firmwares).
> > 
> > This added some complexity to the driver. And so in internal discussions
> > it was agreed that it was not worth to carry it and that it should be dropped.
> > 
> > I'll let Vikash and Bryan comment on the decision.
> 
> TBH I think there's not alot of value in supporting a broken firmware which
> only does decode.
> 
> There's not alot of value to the user in that configuration.

I dont know the user base but when I originally did the code (v7) I was
thinking about security conscious users (signed firmwares) who might not
be able to switch to the new fw release so easily (unnaccessible key
management and updates).

But I dont have those numbers so it might be none.

> 
> Provided you have done the work to get the fixed firmware into
> linux-firmware just cut at that point and have the driver reject lesser
> versions.

yep, that went smoothly:

https://gitlab.com/kernel-firmware/linux-firmware/-/commit/8ecf764788f8dbf33fc1c483ddf91f882ad792b6

> 
> I as a user have no use-case or value in a broken old firmware which
> supports decode only, I'd much rather have the full transcoder.
> 
> Its Vikash/Dikshita's call though.

I'll keep on holding v9 until then.

