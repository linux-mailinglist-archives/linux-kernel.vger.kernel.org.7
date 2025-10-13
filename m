Return-Path: <linux-kernel+bounces-851369-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 891DABD64BA
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 22:55:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 0F6D0350731
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 20:55:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F2462EFDAF;
	Mon, 13 Oct 2025 20:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="IXcIkoB5"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43D3D2EFD95
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 20:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760388946; cv=none; b=qsBFHYjyJF6RC7PbMZ3TeX80mr4r9mSOOTePAwBk8YaivkvlcQ7gAdd76oeKAxBSKWPLc9bcpiMnzu/Nzhnexc1P894LTObSs9ZuSgNyof5zc+My8oOGJ4DKCfxqMFtjQT3pnwWLQMU+bFD9UUWZqwPpjhIiPTpDOGgpKnWU4w8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760388946; c=relaxed/simple;
	bh=QBc9HprA5H2kM+OyBnK4VsuU2TvzkA1lWdb9SFoGZyY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qQGIPw5/PL0DJ8byx38cwnsslhlpedMLofAqgXI9gdz5E3fhO1jSJuEnu2nz6BZka/xeQvFJ0uXFZB7gC3xjNfLOICaNFDaQ4D7M+qxZVjJwrYstq40OayaQOeTmttusNgMGjTNBYyU0jvAWh31RExcJzdAUJJBjrDKKxt17RVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=IXcIkoB5; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59DHD7Mb002445
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 20:55:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=h8b2DwudIexdSRYipqQ13kew
	J4gE/3CuV6C5IduoJwc=; b=IXcIkoB5lrzUNaD+HgdJcATWOkoQEcKeijyYxvoD
	CpeyXaCk6w8+tWGSjAMZkwZPw21qV3u1O1ltWg3VKydAx41BIaj7yET94j763QQv
	8I/Z2cRYqYJmZn5/9eQ44X518qWYT5ZOFYKy3uNI51mU8RGIcH5aJXPaF6WalADn
	CQvvpW+LgmFNa3+Kd6KgxOEkAEfo7BF8PvuLAhkdz7sjsigzp91+nUOOWeZRs5Ur
	hTq6JnBjke4ZYvn2gSX73qtSxdXDOyfUBOxqavidkmAIGZY60iZgEHSDfa3UaFJw
	+67xrf28nPjY7xEv2qBa52P21z2FZ4jz6ZD12F4OiNNcoA==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49qfbhx4yd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 20:55:43 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-8635d475527so3161221985a.0
        for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 13:55:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760388943; x=1760993743;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h8b2DwudIexdSRYipqQ13kewJ4gE/3CuV6C5IduoJwc=;
        b=ePS+aXwBPM8zNcIhubsKmAI6wrgT8r+NCEpCbn/twMZmfI7kDFMirUxGtcFmarTILq
         9Yrng6bF3t1IJPqfVmtjCkrIxS23V7/Dblsbc9WhZIVWAbKbjm/61hWZdKsfM10i59Q0
         RYRDpxQntCQFhRWL7zAkQkeVjizg4QV+ElUj6C4+VFBfDfEQ2XWhgox9CMAiFxZIhZ2e
         EMJtOagYUZzqepqwLZ5qqMjPcaXuKaXUKl4h9xYnB21GRLTDvtZ8ebRlmqBetOXQG8cc
         Ip9DZyxDEVhdrzq5Sy75P9kB99ePS16e/RcDdPLWKF+Y3c5lYYJ6mJu1C0wSuUuRUE/X
         xF5w==
X-Forwarded-Encrypted: i=1; AJvYcCVgwUnnk0LfA31y0ESKibKZB63gQxErDmNEb70ns+tWoJ8WzKpTbVLZflcjILy2IhjhNfQCcmz2bJ3W8NI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxlCdkldb9LTBrOJme8oZF0+yShgAzHCiaHgvP4P+mfwhgcGN48
	+a10AAPpAuiRAv3d2Pnf7SQJ5QntxgPdY0FMsI4FsPUmdJb7sGZWeRFHuTg2cfAgdSZigrfcSdB
	GO0zhHSzlLbeVpfTRryBBKlQRqvowgeFTZR0+09hdBAt+2e6X73CT0+D+r9TPw2vzpKc=
X-Gm-Gg: ASbGncsrIw8wrbrZMYejn8wqC12BzS93jCjFYwRM/ZAvupaXLwDS4ytBOd6cbSox8zq
	dQV+lun/11ev+iCX/B0cGfR1LI6DbqiGbC7+u+UQICaYFOClv+GML6TH6hq39l5Xj24heGraJ8o
	DEot38BUHBIXzWUQsXN+isSZHv1+0+TSpJeuG+vFIG25yaG+0ujWcd4OR081+dv9/7pCEqCVFiK
	AAB9bk2rHNhq7+yT7/TEhlBkEAH3lci08Y1sh/Rz1GWlfIXuHdf9KvlwNvIkRXvI2jomzsl8bpT
	7qyxRFJ/anY4kaUT87OP6ly4BUvVBzhR+aGm7vhJxPx1shpP4F0cRLIP8LmTSpHgiaxi3QD0EN1
	uvL5g/BzYbrb0Nt/io6o9R2gb9BI88XOTMM0fTWlu4xXLyRYQP+AE
X-Received: by 2002:a05:620a:40ca:b0:850:95d4:db01 with SMTP id af79cd13be357-88352f83c1cmr2928836985a.21.1760388942669;
        Mon, 13 Oct 2025 13:55:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEp6cEaL5p5bxM9BKec5c/+vKMAwKsA7FMuN565mKfxMvwbeeumVcMSCt/OjDjFwBqiUk+E3g==
X-Received: by 2002:a05:620a:40ca:b0:850:95d4:db01 with SMTP id af79cd13be357-88352f83c1cmr2928833585a.21.1760388942214;
        Mon, 13 Oct 2025 13:55:42 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-590881f8c6csm4493487e87.28.2025.10.13.13.55.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Oct 2025 13:55:41 -0700 (PDT)
Date: Mon, 13 Oct 2025 23:55:39 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Sandy Huang <hjc@rock-chips.com>,
        Heiko =?utf-8?Q?St=C3=BCbner?= <heiko@sntech.de>,
        Andy Yan <andy.yan@rock-chips.com>,
        Robert Mader <robert.mader@collabora.com>, kernel@collabora.com,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org,
        Matt Roper <matthew.d.roper@intel.com>
Subject: Re: [PATCH v2 0/2] Introduce BACKGROUND_COLOR DRM CRTC property
Message-ID: <x33zabb5un2boben6r4qp3vvrgca5s37gmseespdwwbajumdxx@mcxe6or5p63m>
References: <20251013-rk3588-bgcolor-v2-0-25cc3810ba8c@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251013-rk3588-bgcolor-v2-0-25cc3810ba8c@collabora.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAxOCBTYWx0ZWRfXxGQqFT6d71WA
 noI64euJwo6MRdmzs91KGJOJJIcib9W6v1BWKMi+AEGa1RFAJCwMQP8LNfZwYQJR5w5I3LWzFmB
 TdDWvYqBIeCCn5VvmyA4M4HuFP4SX1jqtLjdO8qiLvhs3FFcJPW8OadWmtwsir9waIGapRlQQIC
 TBGYCtCARKLpB68r/4V0Hi5rb3CjUAtJUhwRT7zNI5AhH3r603unz054cNy80H+KMBCwxu0fXOM
 9UNp/sjZrkBeMuD3TLkBWbJVQJPaZ5BYZKa6M4fVBjNAbP1lkl+sSIfWIYtenIFNhD88Lu2QD4o
 sAKfxGqAd1ockfxFKKAfBVKHW/csqgOechA5xKYpAZBizoQ0JXnxNiO+QaJHuLNO6T7T+qH4NUW
 ZK/cZ6njo2B7dVmxtWw+sUH8roI0LQ==
X-Proofpoint-ORIG-GUID: PsGAD2lqlw9PAuhcD4nzWlHIV1_3DaTA
X-Authority-Analysis: v=2.4 cv=bodBxUai c=1 sm=1 tr=0 ts=68ed674f cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=x6icFKpwvdMA:10 a=VwQbUJbxAAAA:8 a=COk6AnOGAAAA:8 a=6rgqHx4lmTWDBTbEgdMA:9
 a=CjuIK1q_8ugA:10 a=IoWCM6iH3mJn3m4BftBB:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: PsGAD2lqlw9PAuhcD4nzWlHIV1_3DaTA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-13_07,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 adultscore=0 impostorscore=0 suspectscore=0
 bulkscore=0 priorityscore=1501 clxscore=1015 malwarescore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510110018

On Mon, Oct 13, 2025 at 09:27:17PM +0300, Cristian Ciocaltea wrote:
> Some display controllers can be hardware-configured to present non-black
> colors for pixels which are not covered by any plane (or are exposed
> through transparent regions of higher planes).
> 
> The first patch of the series introduces the BACKGROUND_COLOR DRM
> property that can be attached to a CRTC via a dedicated helper function.
> A 64-bit ARGB color value format is also defined and can be manipulated
> with the help of a few utility macros.


Please provide IGT tests. I'd at least check that using the
BACKGROUND_COLOR results in the same CRC as then one when there is a
plane covering the whole screen.

Additional note. I see a value in having the CRTC property for the
background colour. However it might be more flexible to reuse old
proposal for solid fill planes ([1]) and instead implement the lowest
Z-order plane supporting only solid fill colour as an image source.

[1] https://lore.kernel.org/dri-devel/20231027-solid-fill-v7-0-780188bfa7b2@quicinc.com/

-- 
With best wishes
Dmitry

