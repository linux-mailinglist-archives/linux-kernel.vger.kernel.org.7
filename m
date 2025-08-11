Return-Path: <linux-kernel+bounces-762139-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55508B2028F
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 11:03:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD6E1420893
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 09:03:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE40E2DCF6E;
	Mon, 11 Aug 2025 09:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="FfYtt73T"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B9D52DBF49
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 09:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754902975; cv=none; b=BgDxtT2jNWujow7A3MDOdn6emNAGd0le1oYW4HD6nZOhEZZhM9UBj4UlmtntjmTkMiInKYHK5+2tNt8jfBi0qV4u7Z/rwn4VlpMbda/4DAdFWgPWoTfgQ2Vg19m1VjwDRPLZxr07TvIFPDQxwETo7vlIKr2oiK8Todl+Ewvn93g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754902975; c=relaxed/simple;
	bh=tdgwIQdJG+orKkZyHmIqAu1docbT/zmwkliWXBBtmGE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NZfNsqZJU9+HpzHDFlEfhQezFGV/AX6bt/M6etXthrgDSxThPTEhz1y1DZ1u//La/q3bt8mj6EbcZ9pyKRZjjXrBoGYqk/N+MjwTqv1+hCw1AK/xdMxZpwz4IXelbUhuZ2FUyDPIBKNQx2oRHFIKzfB+Tqtk66Xh41Jog3SxKw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=FfYtt73T; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57ALoHBW005177
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 09:02:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	tdgwIQdJG+orKkZyHmIqAu1docbT/zmwkliWXBBtmGE=; b=FfYtt73TZBF5+9/z
	qDBn8YF/XFOCvLK8+/qPa/2rX2ieN8UifIMXB6c0XGgtZc1uOHxrG9sMzXaVOTMW
	ODfXLj1cqgiE94V7Sea1ZRVhXpTDS/YT6vK+Yvf9qP58EoLphFNO4V/PM5YrTbWf
	FafAbgxCz2Qt8Yw7MP+UTHtXhHT+jMd/ERgqL2Zs9FTpY1iCxL63eu3dJfUX9Lvn
	ZNby5h2tNk1xx+IBNHTohCpm3kk82W7QcvKl6CL1SXR2Ar9b2D8DTx7Dlc4J1rRz
	koCBHRw1vEqu+UufFE7wk4xUFFporON534+10M3shJ38oZofnfetpOYD09MFP//G
	+w1TSw==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48dygmbp8k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 09:02:51 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4b0938f0dabso11190351cf.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 02:02:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754902970; x=1755507770;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tdgwIQdJG+orKkZyHmIqAu1docbT/zmwkliWXBBtmGE=;
        b=EeK/Mywbzq4T9sfbkVkaii+v+ZrwQFN/41rygDDaYAmKh2d2KnSrJEw7s9djRuux0j
         XCCnffLI/ACh3jTjoWX75IUECijNwUk3NWU8HyqTUHxltBSN1XNWEcKSgmG4bX49GHRm
         4R+3BMV6xxhs74kQezfw3WGEkPa7jfqvAHVeaBrCFdrBx19XyM5+bUHx8A22r9wut2SM
         VMtRpNrfRq144idziqFA/owB5ECeXjfa8ZNCPgSEpN0F9xPFqVVutlpGFF5dOspy7+6P
         LknXy/9G5ABrI0ppoDCGIoYxacd5gAHw9TnF1NyUR3pmfPe1ngrQQy2pJfqYdhJKd3dm
         Rhrw==
X-Forwarded-Encrypted: i=1; AJvYcCUmbfChqxWgOh3IWNKtGs8z5o8/afECHvm2JHomIJtVJaXh4Dq3jh1eoJ9tmKPE7Z2CXBT7XSYciLQgShM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyqYkkVtEzN9WBeFOq9Gu3U09c78ogIf4Li8EzTSE1u/0BT3Utd
	JUq9MLSlrJ0MqaZniPGQmQefUUp1jNvLlh7koN1ghr3zTy58WnTCDAtdwCEIxhUBpFDkLg7WMe0
	kuSa9cCzgLW8ZsXZCF8Wcr2UNbWGZohyTak8tRq0UkthcOcm8R4wO84ZtUsN3jQzWRAA=
X-Gm-Gg: ASbGnct6pN+kJ2TAjhOXZwUeGt6zf4z4cyxSo+VlI4TMfGVYzbF7Re0grVjzGEI2IVc
	1GcQyTQzfZfB2sQBXDrxSdSZQ5te95WHRA8nkSxW97Nhqv+l6i517A93X5u0LEkTL26ItDaksTx
	voRn2yQOXNVFBgRUPUVZQewlJgA7TmnH1cdCvAeD11NwhVVg5sMUMMXP5qfp55PX2BXgQ1zA0NS
	vAzjxHErfvGEpSdl/Mtbh8sePqvzeYOtJAI2dUnX/AJwN8eLSuQaS7IxAV3XjzIvzMC2XKOqugo
	FJoBOrP8xnkgGvk4SZBLV/0+8E5nSvoEWncG/A16wVfu6ibDaRonHOR1LyaUVmlLirPoURIvA9A
	HGi40ZiBK1MQ95A0IRQ==
X-Received: by 2002:ac8:5d51:0:b0:4a9:9695:64c0 with SMTP id d75a77b69052e-4b0c1b28bf5mr48920821cf.8.1754902970257;
        Mon, 11 Aug 2025 02:02:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH5TWRviyLEMQPzvh4QVbqH5jPy1ZuqxzZtRDTRJ9JxfjUgmBuPx6tAaaAYzS0THJjvJINbNA==
X-Received: by 2002:ac8:5d51:0:b0:4a9:9695:64c0 with SMTP id d75a77b69052e-4b0c1b28bf5mr48920671cf.8.1754902969784;
        Mon, 11 Aug 2025 02:02:49 -0700 (PDT)
Received: from [192.168.43.16] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af91a21c0afsm1977783566b.117.2025.08.11.02.02.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Aug 2025 02:02:49 -0700 (PDT)
Message-ID: <d00689fb-8074-48df-ae95-bcdf5e756111@oss.qualcomm.com>
Date: Mon, 11 Aug 2025 11:02:46 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/7] drm/msm/dsi/phy: convert from clk round_rate() to
 determine_rate()
To: Brian Masney <bmasney@redhat.com>,
        Rob Clark <robin.clark@oss.qualcomm.com>,
        Dmitry Baryshkov
 <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Maxime Ripard <mripard@kernel.org>, Stephen Boyd <sboyd@kernel.org>
Cc: linux-clk@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
References: <20250810-drm-msm-phy-clk-round-rate-v2-0-0fd1f7979c83@redhat.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250810-drm-msm-phy-clk-round-rate-v2-0-0fd1f7979c83@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA5MDAzNSBTYWx0ZWRfXzffcNuwolGWG
 ClCwqz35t8SCwh7xWU75Zjw+UFr5Z1wUo9RD8GcZGxb7ww2UxnjJBgK0PwWahaRgaM/cbVgToMg
 n4GSrYRd/1WJd6R2zw15zGAU/juIQzRd4WuTjrqZpZGSKAgwwEer/94n/nFBxOV4Qyi0uvXvaN3
 96+gKAo0Ndmj4IFWPtbCKtqDbgCKpKbtrlxNExwINN6boS1ZaxOq9g9Zf81mJbWfx2y2HUZz8s+
 uDJzbm28+Lve++cWekA/5/CnNxMa+mFB1yUcM8+J3i4VvlKApA922/VzR9wDQhgmRX2xRX/rdKs
 cTQhuA+xJ/Eu4YD5dGlxJWwKxVhxVWEFHiNeU+Ax5erf/OhsNkjqres+rY96+W83nNdwWtFekG0
 xLvfySd/
X-Authority-Analysis: v=2.4 cv=FvMF/3rq c=1 sm=1 tr=0 ts=6899b1bb cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=aS93HcZ8ji4XsMPHnqgA:9
 a=QEXdDO2ut3YA:10 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-GUID: WjvNPi7f7tGwuDOm3uxzOBAcUndSpqi7
X-Proofpoint-ORIG-GUID: WjvNPi7f7tGwuDOm3uxzOBAcUndSpqi7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-11_01,2025-08-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 bulkscore=0 suspectscore=0 phishscore=0
 clxscore=1015 impostorscore=0 spamscore=0 adultscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508090035

On 8/11/25 12:57 AM, Brian Masney wrote:
> The round_rate() clk ops is deprecated in the clk framework in favor
> of the determine_rate() clk ops, so let's go ahead and convert the
> drivers in the drm/msm/dsi/phy subsystem using the Coccinelle semantic
> patch posted below. I did a few minor cosmetic cleanups of the code in a
> few cases.


Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

