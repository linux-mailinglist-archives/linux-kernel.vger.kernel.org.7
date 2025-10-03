Return-Path: <linux-kernel+bounces-841791-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 11AC5BB83D4
	for <lists+linux-kernel@lfdr.de>; Fri, 03 Oct 2025 23:51:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A2866188E656
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Oct 2025 21:51:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58B822727FA;
	Fri,  3 Oct 2025 21:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="eqm3RKvr"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E2D133F6
	for <linux-kernel@vger.kernel.org>; Fri,  3 Oct 2025 21:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759528259; cv=none; b=EBTsPi92aqnxd8DMrfvCvXt4xZMeWM/44WqdSchJskuP/+XRSfJZCH0KIUK9+cAUN6i4zQKL1pqZNj1m0yQCmLNgSx9rYaNZ6utJSe3m86JymdQcgSBEzOHN6RrUI3QOQXXcI0gmeLyAflxKLO0w35m6Zs/wq6sptcgviqL0BdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759528259; c=relaxed/simple;
	bh=2+Qx4TvvkyhDYLhaS2hPHaAOwTarJmhD8/45A6LfgP8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dvYhz3FTinRRoKyDobcqdzg5rnMgJ3Q14vdEDkDyjKliak/hmUao4fPxD84ljEKpj2xwSmUVxTRxFZOYZj+a0wFRXsO/Z/dg6+sBbbZCRleN17+hg9eourPvM6I6c0MkfpXbF04tQbHyfTBXBfySqMxNrlPihVz0HSFBRGT+hT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=eqm3RKvr; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 593Aame0019964
	for <linux-kernel@vger.kernel.org>; Fri, 3 Oct 2025 21:50:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=dMwDleF2rEGTBFbEEiU5Yhas
	7ke7oirsC8DK/6N2dXI=; b=eqm3RKvr7KraUO4Rza3bsiOE5tvK2i/tL19oyWFK
	cFUle3SSZ1YXnvej7kY95+vF+jfZmoDOMJClzxyFUzQsprU45zNmjzs2rC28sH5f
	4nG+Lt18CthRMhpVft6tbgW/mw1T7AvHRFk4oLbdauxDPdaOU/zG0/vjHouNG6AU
	mFdysk9RQjva8InOKND4/wJgiwvEPPfLcBjEBTKnFxfwSWlwmpIRUhJtWt85JR2p
	Nmn2ft0C0oOwryGjzCE8kE8vA+E8RCEEelh5ZShH8MmMmZeMN441bHUAoKbSCbOq
	DYPuGgodnhVhTLgyqu/+1sLHK11NB29isYOhKUdP+860RQ==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49gyu1gbxq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 03 Oct 2025 21:50:57 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4e1015c48c8so71928181cf.1
        for <linux-kernel@vger.kernel.org>; Fri, 03 Oct 2025 14:50:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759528256; x=1760133056;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dMwDleF2rEGTBFbEEiU5Yhas7ke7oirsC8DK/6N2dXI=;
        b=uS0AQU8LXfxALaoGOHI3t2bdqJ/VjRrynoCh/crgd4qsc2EkQ/9tuMyMnSbNbch1nb
         Fq+hw1NF3EwhkXXKt4SdfxbgPVxlBf4tqnlJPal7a8vKp3gyVJhQ3iffU3jRS+G9mhLi
         1MPyMcKr9EsqBfGz2HvxAp+Ly74LKSnw6wbI1nIY/3tz5UrOOFUJ+ne2MqPmOiMuswTd
         UPtpWRR+/3ZpK5IzLHtc2FENxRUL/Q/V9S91YnubREo9FbmYPuvTmbPL4z+06/r3Trqw
         8QyTU4tO6eP3v9UyVp7YLc9Sg9OKwTlT1euDqCxBDyk1dtWrXRTZZx6GU8Sx0HDJWTjv
         tcPg==
X-Forwarded-Encrypted: i=1; AJvYcCXpqZzI5kW+zT1t3f/VDF4u7IjgoHRESph8ZWZJ3mj7IozOErie5M9e2PbhXVIEnFqZ7xIUHxFuGoKf5B4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFRj15q0bffaZ+bQhfiv/2izSF6uG3NZq3gDVEeUdgVRxkR1yB
	ZOXXYyjpwflxI5jz5u0wvPN5aiNmmA+Fzp95EI3s2q2jzjHvfT3Qu+7Ls9A3+HM5NY8gUL0nzIm
	tWYERyS2o8G0vMIbc9+iEy8T57JjXDdQU50yE3YQCSRU4lx/yhFknw+5ukBY/da/H/wU=
X-Gm-Gg: ASbGncvxUV+KXw0MkHklAFZR+p5wiRYpStroVeAi4V7RAlrjnhMUyo1FtdNcqqE+Hcg
	LRJtOhhB4OGTpUyeN+huM1iMByRgsRV0E/gJ/UPOLbKFxMnWL7lfwWKqrqhv4XjD0+vSaO7MRx8
	8/VzBJYUwUENeJoLIgxi6WUTsmpQZHeRzZaJWZNISocK4i5jLWBZv+5bXBHLZbwIyV4rgg3USE1
	L1/Z+WCftRgXCNb/GjDZKKa9z/dqGJahlMyCMBiOiEOyqQWFLIepbp8hi54v1VgmOjKuUpBHShw
	uICletuahVFDLS4v7NUpwXBJF/PB0InoPJo6U4Gwg1nrZg0IPAya9J8oOoV2FxcVk+Fb8sQmNzw
	/g6rAZ0YreJuyGsIzVO1/Yp0AsfzWB5tAcx9KeO67UFlYf4ScJLlKvr7UXA==
X-Received: by 2002:ac8:5952:0:b0:4b4:9531:8a8a with SMTP id d75a77b69052e-4e563b6866cmr113183351cf.38.1759528256367;
        Fri, 03 Oct 2025 14:50:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGi4tK4Ey95PC2GedwCZ2MhCcVKB0hyCtFcuRedprkbRea3U2e1PifERn9nC1Yryiua1m/vKg==
X-Received: by 2002:ac8:5952:0:b0:4b4:9531:8a8a with SMTP id d75a77b69052e-4e563b6866cmr113183211cf.38.1759528255910;
        Fri, 03 Oct 2025 14:50:55 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-58b0118d6f3sm2197351e87.77.2025.10.03.14.50.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Oct 2025 14:50:54 -0700 (PDT)
Date: Sat, 4 Oct 2025 00:50:51 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Paul Sajna <sajattack@postmarketos.org>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, David Heidelberg <david@ixit.cz>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, phone-devel@vger.kernel.org,
        Amir Dahan <system64fumo@protonmail.com>,
        Christopher Brown <crispybrown@gmail.com>
Subject: Re: [PATCH v3 10/11] arm64: dts: qcom: sdm845-lg-judyln: Add lab/ibb
Message-ID: <mtz4owbmukfo2zkgkzjckkisy52trmimlmy3kfngg2n3ej45c7@crkidtvm6o26>
References: <20250928-judyln-dts-v3-0-b14cf9e9a928@postmarketos.org>
 <20250928-judyln-dts-v3-10-b14cf9e9a928@postmarketos.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250928-judyln-dts-v3-10-b14cf9e9a928@postmarketos.org>
X-Authority-Analysis: v=2.4 cv=RfGdyltv c=1 sm=1 tr=0 ts=68e04541 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=x6icFKpwvdMA:10 a=Gbw9aFdXAAAA:8 a=DjAeRk3aBtCqIWsq8ncA:9 a=CjuIK1q_8ugA:10
 a=dawVfQjAaf238kedN5IG:22 a=9vIz8raoGPyDa4jBFAYH:22
X-Proofpoint-ORIG-GUID: MW57Dw59hb1pcBavfCUGSepv2fOS3uk-
X-Proofpoint-GUID: MW57Dw59hb1pcBavfCUGSepv2fOS3uk-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDAxMDA1OCBTYWx0ZWRfX0g8V5JlR72hs
 KEUkKlzPnji/nyEqhpPrrn8VQCFtY3C+EJiiTbZs0tUvvdnIGu0ZVwf/Zv8t3heKkZe0GwekSmQ
 lvzOXAcrd2gObpNes8xfNiLzYzdvMGyQ7HIKHTg1Thr9kr5ec6N3dJAbjwyS71iRMdcIzbKFkGb
 VbI3q4m93JgPUfU/K3WACRsK9O4itbUnvtRG2+mpd85s/lN9ZuTcCDBZ7GwwVQgFPYJr3IOuv2Y
 gBebScJ7k9wjQPTx29wwkZLHrjXVpPL6s4otc4NSxzwDEkv2HsHDubYnA7tqoF4PxlgPlVxpeUk
 hD/DJzt83XdXtbPMjKQv9pJGjAxsY/2E/eTwEayx64GdeYTIJiH0FjvbET0EPDEZCiu3QsfKfxV
 PsZNwMPcU8NeEb853VQ8bquxqvUFoQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-03_07,2025-10-02_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 malwarescore=0 adultscore=0
 priorityscore=1501 suspectscore=0 phishscore=0 bulkscore=0 clxscore=1015
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2509150000
 definitions=main-2510010058

On Sun, Sep 28, 2025 at 10:05:33PM -0700, Paul Sajna wrote:
> These regulators seemingly help the lcd to work better

What does it mean? Also are they board-specific or should they be a part
of lg-common?

> 
> Signed-off-by: Paul Sajna <sajattack@postmarketos.org>
> ---
>  arch/arm64/boot/dts/qcom/sdm845-lg-judyln.dts | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
> 

-- 
With best wishes
Dmitry

