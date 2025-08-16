Return-Path: <linux-kernel+bounces-772232-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 733E0B2903A
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 21:24:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2EA4DAA3216
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 19:24:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8D9A21171D;
	Sat, 16 Aug 2025 19:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="BV9ycCQZ"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6597199EAD
	for <linux-kernel@vger.kernel.org>; Sat, 16 Aug 2025 19:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755372247; cv=none; b=DeRTtJ6h0/CchIPfq457tPskNOjr+kiqLdPr7zd5ygkI4ZR6l50+WEban9mK3mlInzti969HAi7AtdY1W9MUCvr0WduGg8fCi0CU9nVDwAxG/31GsUvk7XUtA5RGoVvx4SBSoljl1HthZLdyWGvXvj3tyLJlNsOniMDhFJTpI0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755372247; c=relaxed/simple;
	bh=d8kBTUP+cXe8grXCNZxvlKllhDpMbvdYapPyTbD+IKo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JjGMv+jzkn+GJ6Zq1u6eUNbMaJG6lRO6TUvNU7l7ZeVfC3TnkY61e/Vf6hDiHCmK/29EmxcvXHOZtLrtUbuMA2vWv9riuZjcB7l1VJbi5XIPs+F7V+di23sWh7IlswEUOQ9KIdUJcxHekEEu9bdotEJ4XfsKi7kphcDop6+XtiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=BV9ycCQZ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57G3FJb9016534
	for <linux-kernel@vger.kernel.org>; Sat, 16 Aug 2025 19:24:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=h9FIIsmv/7ttG/eOuvbCp6ss
	2ccMsfkWjjZLaH87VIg=; b=BV9ycCQZMZA7pVI5vVpfzlDOejNePlKJzrabeD5O
	YIB2H3SWZc0mdXPr8j42QhqvS680Wzmu9N/wUK5PAjtctipmddUd3LAlOXmmHcNW
	E+3P1O1EqQE7IxVDbPgKnaEGI8Vwo5LJlnoUdJFsSYfUxXQnDBUXFe4lFizodd6N
	NFvrrtXnjk/KB8jYbBNU9kdn7Ps8jVx8WTqSmeDSM86tYTPUfLUQl+XTAkd//BvX
	Q8Ec9tQgxHnDCuvilj9BGLO3wPLCG3jaTcUsylOgrRn03KB6yoxgb8gQKfzV7/wg
	o8PBW+BBUXp4H0F9gsGOBhqJto/+W9CdZNuayrv9cSFkRw==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48jfpf19vc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Sat, 16 Aug 2025 19:24:04 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-70a927f4090so65389126d6.1
        for <linux-kernel@vger.kernel.org>; Sat, 16 Aug 2025 12:24:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755372243; x=1755977043;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h9FIIsmv/7ttG/eOuvbCp6ss2ccMsfkWjjZLaH87VIg=;
        b=ur08vC7rpgVAvOq8NWcy5R6GJSMxXVnLjKYH9doQEexICvJuZ+MRC3kxNJcjiGEhcS
         kgzZQh5KMPY8TZya/iCBzPesfzqeQ/dhf+JH2ofe/QFS6/dm1eord2kEbNsvLjtIYAjS
         NEmUUKgAGvh9WAq6qX4uutt0RJOWUDj1p8dl6rjic6Wc3pDvi+Fan1Pga+fWV8of1Z5w
         Zl1hNcgthNS4RWedrl7tkM/qcCFkSlH6wc+BDOO2Axcp/7MnA0MrrFfzZCemE5CI6F9M
         L162P7N0kP9C09n72PxMWSF1MHTsIXn7jUNvZnJX97g4nyVCCn1fDQ7tRFwrJd8l7Zea
         e6Eg==
X-Forwarded-Encrypted: i=1; AJvYcCUTAv4HpcBFbEFPLzpR5Semkt1f82KLb0fyAnRl9nZkDxh+TNB1OXBnjCBXJKmiI3qp0athYvoV2PrZQxo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHtEeTr9Vr8kWN+in6zZ7YM/kJ+cDp3loJf08lYdlj7bFDmpYA
	eVNxWvEuNLdgPp1HIxc0UlYf/+176GMb9W9l9peNnJtVDYT1Ni0rbsliHhQh+ei8y5b3TVClFqi
	Xl3MQBhUC7CxMMgKVoxuYBJ/ByJhg8fodAorS86W8vO6zQQ2qzdjSBQilvgVGJQ7QUG8=
X-Gm-Gg: ASbGncsgiAXtry9Ji3812Q0P8NKtEZKTUpNxTuPUDJ2djwlZtSbl9T10rdlIcQdedWj
	wpRLOvwzbob6pB8FJ60epG8i/q3KtFsP/VoTSALDNvvNcy8liyI8AfJPlIJRlaX9eho29S9CLM5
	rpEYGnLxANApKbVEFHA/gsbYkTXhyt82PLih03Mz0Zp2Ywk2kVkVxlNShBVttJLnQlywvf4MoA0
	8wL1UK6ylZ1w3CieAE86SrWxBaCbXYVV4ZkAudUQiG7NK4U8T8LDQaRFn5mTRlPvg6KTeOUeBMM
	p1k1fflaYWV17ognUICzI2K7T+e4BA8NZmhBBOUUwjF6jEkmaZDWqsID358pAMQkrSiSp87QdWv
	23xD/8a5rMXRe07sJZSk62/FzKpHNz7qwUbCJiJO8Qne4c19JMBMc
X-Received: by 2002:ad4:5c49:0:b0:709:e60f:660f with SMTP id 6a1803df08f44-70ba7cfedd2mr79180666d6.48.1755372243600;
        Sat, 16 Aug 2025 12:24:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEU1T8GX9d3vlil2IFVf1gPtNRW4ZnXRmzfAHLK1FScZEwKU3dYeX2nuZnKX/AcDL+mnRIH2Q==
X-Received: by 2002:ad4:5c49:0:b0:709:e60f:660f with SMTP id 6a1803df08f44-70ba7cfedd2mr79180376d6.48.1755372243146;
        Sat, 16 Aug 2025 12:24:03 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3340a60452bsm10851301fa.46.2025.08.16.12.23.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Aug 2025 12:24:01 -0700 (PDT)
Date: Sat, 16 Aug 2025 22:23:57 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Nishanth Menon <nm@ti.com>
Cc: Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Rob Herring <robh@kernel.org>, David Airlie <airlied@gmail.com>,
        Maxime Ripard <mripard@kernel.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        Robert Nelson <robertcnelson@gmail.com>,
        Jason Kridner <jkridner@beagleboard.org>, afd@ti.com,
        tomi.valkeinen@ideasonboard.com, devarsht@ti.com
Subject: Re: [PATCH V3 2/4] drm/bridge: it66121: Drop ftrace like dev_dbg()
 prints
Message-ID: <bq2x74sityy4gxyrxaytkhtbjunenhwjv7tci73zhxqsoo3u5w@u5w6omfh2uhm>
References: <20250815034105.1276548-1-nm@ti.com>
 <20250815034105.1276548-3-nm@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250815034105.1276548-3-nm@ti.com>
X-Proofpoint-ORIG-GUID: Biarj_dGDc7Z-_9MUK81UQjBlrE74IJZ
X-Proofpoint-GUID: Biarj_dGDc7Z-_9MUK81UQjBlrE74IJZ
X-Authority-Analysis: v=2.4 cv=X9tSKHTe c=1 sm=1 tr=0 ts=68a0dad5 cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=sozttTNsAAAA:8 a=EUspDBNiAAAA:8 a=PazEZd4TbqGcHQaGJ14A:9
 a=CjuIK1q_8ugA:10 a=OIgjcC2v60KrkQgK7BGD:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE2MDAwNSBTYWx0ZWRfX24HVNnqAUe+Q
 kVKCZ/HgAqxbJOuMc16DkPg5caZDueuRykqh9TVWYZ4Ci6nRLpo8Wb/SgmQCF/dX9H7ZWkrlFH9
 Z6q3usZt34zkvCEgYCvnc4m9AOeEH5ANYoxajw0jAZCpW4sS295YcyCgI7gztLQvEEVdgbiH189
 tORDiPotwxFPR3n6rpIGGJ/nON6ORU5WvFVz+MthcFEew3olkTeDz7sNWvnZP+BNvwrlPe2JUql
 PkgMmv/8id51OhLqycYqA6mBERqgF+ro0qzS0buVetf+h29PHcPgTmRx12JG8Kxm/QOrEUiFl38
 KAaNuz7wl3Rfs9iA28TR3cFBmgpY0jBFxc+3loR1l42dgfe53lfpMUOSMADiRBFNrhsFGqg55Qg
 si3KOH6b
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-16_05,2025-08-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 bulkscore=0 phishscore=0 spamscore=0
 suspectscore=0 adultscore=0 clxscore=1015 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508160005

On Thu, Aug 14, 2025 at 10:41:03PM -0500, Nishanth Menon wrote:
> Drop the ftrace like dev_dbg() that checkpatch --strict complains about:
> 
> WARNING: Unnecessary ftrace-like logging - prefer using ftrace
> +	dev_dbg(dev, "%s\n", __func__);
> 
> WARNING: Unnecessary ftrace-like logging - prefer using ftrace
> +	dev_dbg(dev, "%s\n", __func__);
> 
> WARNING: Unnecessary ftrace-like logging - prefer using ftrace
> +	dev_dbg(dev, "%s\n", __func__);
> 
> Signed-off-by: Nishanth Menon <nm@ti.com>
> ---
> Changes in V3:
> * New patch
> 
>  drivers/gpu/drm/bridge/ite-it66121.c | 6 ------
>  1 file changed, 6 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry

