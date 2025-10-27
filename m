Return-Path: <linux-kernel+bounces-871455-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 0168DC0D4A0
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 12:52:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D07F734D01A
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 11:52:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A94772DE6F5;
	Mon, 27 Oct 2025 11:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="J3XNqeZl"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 573E329408
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 11:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761565950; cv=none; b=m5m66PY4nHUvgsdUp5GMLSQV3qf/Z1lpP/utkjHMRsMHDHg+5Gv4Id/JRRSd6AtEXHmHm92/kU26584nCB70BbTlDLWRfhp6ZSMSBmPwDOfssNCuMs3cQw8r3DTSpVJXe83ektv92FrCysmju+PxE8Dx25BCXRF81cs7Yta4J9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761565950; c=relaxed/simple;
	bh=mdgrf+DBgyuvAY2JdB7oZkiPY7ecJmiVFeBaofrEzOI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dtNfetcH+3S2eS7PvhQq5Pp+1p7fhD8zqvlkUdxrXK6XYlodnEHirQzMEdDuF3Y0wPu0wDLXi2KI4POLoqbpaebuvcLEFwoJzwdHw6yAOXaylbxXb4u5IqYZfYRpbHdtS6s0vfB74xswSHiEX7r8Yoa2FWTiuZAh62PgBpyniTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=J3XNqeZl; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59R7jJCN1033987
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 11:52:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=MBKzjZaWWFsbgsj3/CgK2NUT
	dutBHRTWeINDHOpYMbw=; b=J3XNqeZlhxkCJvGfLJNTlPaBfV9/CW2HtblJjmTw
	wRroR/5jC4L6SPeM6hu8dYCPr1YG1PXcthaPvEdK2Jo4qWv81iMEJj6NPj5fG+n3
	jdoYOH5HUR2Bh5T6y1joAqTgpaC2Fh1g/Gl3j/FIxQn+RM7vZI0rXXiWyxaln6f5
	8g35D0fOza4qFPToCFXn8QLjTnpjb+EpY25xi/g8/21RKwhhy6pk/ODcOG6WoCIA
	tTkUkE/QT0GgW64m+E2bhl/mlL62BRgFJLym3vufLyOiYHwfEMlgUNyjIVp4qNiF
	gELwQnCsr1HALvmHLuBcD51VX1h/0tj8VhDV4tLukeR+ug==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a0px6mc86-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 11:52:28 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4e892acc0b3so151284701cf.2
        for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 04:52:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761565948; x=1762170748;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MBKzjZaWWFsbgsj3/CgK2NUTdutBHRTWeINDHOpYMbw=;
        b=ONDctxl6voePiAA1tUVclAefgclcTmgJIB7RM5VuSnjxWzZxy5A6wzFjwN56gky/aj
         WjmNo6abYwDh7PE67R7VpCxZ2/s2aSfHNuZ/z7wsgjEZL+qf3XCdRj4E370gt9Ojf5Bz
         4OWG8KWC9kR61hT5r1bOtiiXpTdmsuDZqhuM+NjZ7KMpLowP3bEsIBQvlrUkVBnNbhJ5
         H8bmnKtYrc1iyagd1+tZYc1uvGqAqTy4gJwLpeRbZol1UVVbygWQ9mj4dy1/eIEnxSwY
         pTP5BTRicXGlL4zRUM6LY0W+o/38NliYiH4byUPMKlEa99OC3/gPjnJt2EQiqul2oQGs
         MiSQ==
X-Forwarded-Encrypted: i=1; AJvYcCV8VBXzu2YvR11BJoj5gbobb8nnWgGBfX6jzgiU+4MqhCL4JLlDUJAhAONqGh3zRofwnDXx+9xkcKKxkhk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMeuBame3TbGw5LUR+3pSfAb3fEw40eij4/4+x3US0Zsz+KMLY
	K3ZHf0DIpDcwp5A/sAaeApirsIS2LVMU9afJCd4O3BqnUykkFCDb1GSsjLhhc+ni4nBBYjKPjFn
	bqi6T99+QULLa6nBCpNAO7c+XH07C/YRFlx/xs6KLnmqdKjA5poWpt+sT+ruIZCyt76c=
X-Gm-Gg: ASbGncsQZzT1k+GQBpLUiFWrkSSTAe1x1pucQU4uYslecpYgTjSruZf2+1zMM2pmuJN
	j0Qg4lleHy6oHh9giJy/wEkSz7AiRXRPkzOXcIFTDHCvHa9oJb15ls0BIw6MgOhnnKVM/GF3XBM
	oQAAlTxYUap1laSPxQSGRwSjVVqyapG9jR6MiK/bCSiMTM29KPCCMZyGEMn/wnj9lMFW0qO77gc
	wqzQXGJqDd5Yu7EvHmZ+migh0K6FBDytnMlgQkCjD9IiHlpLhHsJxMtT7WSz+d2qWg65qFU6kBI
	5dK55p6A4nxfZKvja8905KInfg2V2+vbqJ6qIL026I+Z7nw3q0yaiaMjExjmG+ETQIY0GDevDeL
	L4hIqbNBkrSlY38yOK0btPvQwnJf9weJ0ywPemE0APk6DkEsCSFFbTpqcroyMECDY9MNcbKLmwp
	5ez1wV4OrMfO1m
X-Received: by 2002:a05:622a:1920:b0:4b7:a62d:ef6f with SMTP id d75a77b69052e-4e89d3a4691mr416787231cf.64.1761565947278;
        Mon, 27 Oct 2025 04:52:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGavpCWYKjWaaA8w0dxfApMsNHDEaRffgbBB7gQqEAsTlkalhABoijtu8cBYGS8qrORyH9nbw==
X-Received: by 2002:a05:622a:1920:b0:4b7:a62d:ef6f with SMTP id d75a77b69052e-4e89d3a4691mr416786941cf.64.1761565946775;
        Mon, 27 Oct 2025 04:52:26 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59301f41c3csm2271056e87.15.2025.10.27.04.52.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Oct 2025 04:52:25 -0700 (PDT)
Date: Mon, 27 Oct 2025 13:52:24 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Yongxing Mou <yongxing.mou@oss.qualcomm.com>,
        Rob Clark <robin.clark@oss.qualcomm.com>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kuogee Hsieh <quic_khsieh@quicinc.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v12 3/5] dt-bindings: display/msm: Document MDSS on
 QCS8300
Message-ID: <drmrkeukgua3w4p3jixdwq6dvj4xj36vvgk2kvwvhpqfk6le5g@tschh7rpsg4a>
References: <20250911-qcs8300_mdss-v12-0-5f7d076e2b81@oss.qualcomm.com>
 <20250911-qcs8300_mdss-v12-3-5f7d076e2b81@oss.qualcomm.com>
 <20250918-spectral-seahorse-of-witchcraft-69553c@kuoka>
 <b745c515-2264-42aa-8d92-663efc7f6276@oss.qualcomm.com>
 <6c195b42-d994-4d24-9c40-48d8069304e3@kernel.org>
 <rkuihu3pmhexeahfch6j7bvwn5rn4ecccbhamluh7fas5qgaup@av2foeiwmcz3>
 <8a6861a0-f546-475b-907c-65b691d1d340@kernel.org>
 <cwuecyparlinhtdqckff7vdqpkio2kk7dwemzfao6qkhnuzhul@mfyqdphfvbdg>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cwuecyparlinhtdqckff7vdqpkio2kk7dwemzfao6qkhnuzhul@mfyqdphfvbdg>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI3MDExMSBTYWx0ZWRfX+t9iX3rjH1R/
 QM2JTk3DyUHrLe8NfIUTxBVJYpGe0fMzZsAFWF13SdinLR7DJKveHKTU2PEsqo/u4cj2VYGSW26
 NRRKueq4FMBw92t2nBIjxLVOyG/DTFUkOoVoGAZGzPuNIkPy+Ik3QlxfK/8Sl0KUZMVyHMNnlr7
 nyyz3BWa4HzzIrVUeKcZ/VWKLFqD76QGs84sVjItjS4KAQiH124Gu5rlcvXVaesMChlsSY2GEla
 Jk3ZbKd1JC4DvA0W5UR1/Buoe20aejOAwjihzhek75eLTgz0HBMtWpJtBvbUNGW8fbLMQ8xglME
 NLMcGIzSt2bRqEBDEeP7kV3Df6R9jYRqbVU1yRSk96ppcTlV5ZHG8lP7v2w+v728VeCbddWn/0U
 hkG5XbF5CmGXb1N/5YZLXiJ6UPF51w==
X-Proofpoint-ORIG-GUID: aUcqK-lp3Prk6azWvBAFjkk8fgEaqzeg
X-Proofpoint-GUID: aUcqK-lp3Prk6azWvBAFjkk8fgEaqzeg
X-Authority-Analysis: v=2.4 cv=WqMm8Nfv c=1 sm=1 tr=0 ts=68ff5cfc cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=CcKo3yaoeUO6NfmZTnEA:9
 a=CjuIK1q_8ugA:10 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-27_05,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 impostorscore=0 spamscore=0 phishscore=0
 suspectscore=0 lowpriorityscore=0 malwarescore=0 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510020000 definitions=main-2510270111

On Wed, Oct 08, 2025 at 10:40:39PM +0300, Dmitry Baryshkov wrote:
> On Tue, Oct 07, 2025 at 03:43:56PM +0900, Krzysztof Kozlowski wrote:
> > On 27/09/2025 08:26, Dmitry Baryshkov wrote:
> > > On Fri, Sep 19, 2025 at 01:34:39PM +0900, Krzysztof Kozlowski wrote:
> > >> On 18/09/2025 13:14, Yongxing Mou wrote:
> > >>>
> > > process in other patchsets and in my understanding on how to describe
> > > the particular hardware block. The changes were reflected in the
> > > changelog. If you plan to review this patchset once you get back from
> > > your vacation, that's fine. If you don't plan to, I can ask Yongxing to
> > > send v20 just for that number.
> > 
> > Solution for me could be to ignore Qualcomm patches till they reach some
> > sort of maturity.
> > 
> > I am not planning to review this patch, because:
> > 1. I already reviewed it, so not really necessary, but even if I wanted:
> > 2. It is gone from my inbox...
> 
> So... Should it be resent to get it back to your inbox or should
> Yongxing just restore your tag on the grounds that the changes were not
> significant enough to drop it?

Granted the lack of response, Yongxing, please send the new iteration of
the patchset.

-- 
With best wishes
Dmitry

