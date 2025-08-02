Return-Path: <linux-kernel+bounces-754138-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 03B67B18E8B
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Aug 2025 14:50:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A0D517B8DC
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Aug 2025 12:50:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 353FA233733;
	Sat,  2 Aug 2025 12:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="AEWjyQz2"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DFF91EEA31
	for <linux-kernel@vger.kernel.org>; Sat,  2 Aug 2025 12:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754139005; cv=none; b=kQms9T+iQfUdwA5xewDlMZQANtuUSSI2p5HRCBgh101N/OHSXhIu4xCkSRmFmsNCWq1M4tpQ/zmK70Bjtrr3pYOuFowngt8ThQ9sHFLfglHafa/9KeSsDF9axORr8v6ZescNGbLx33aQjXGMWKQ5t3/mT+gmLolr+WLM5krGe6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754139005; c=relaxed/simple;
	bh=DDMxBlOpeXigU7SdNlj4+9RZ77YTA2Gt3b2HP27L7dI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jRgRhZQNE+TGxHg7ZvtKC8yLpVG3G1tK+tmYmhW3yAOWpxvfdTtf6hoqt5qP+Cwk8ALUQjBcTUzoh0H1RZckGX1fN6fLQh8t0DSYqtywpt5QW+c3fL8xBnWVM4cI2oYRyYXLgqjIvW9bNgAsyXljNb5KL8GuRtLUbQNfcvKdXKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=AEWjyQz2; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5728qL8v016953
	for <linux-kernel@vger.kernel.org>; Sat, 2 Aug 2025 12:50:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=shOOynL8Ccw5asfZKPoZ1X7+
	Lw+OuwsF+Sk8PffaCnU=; b=AEWjyQz2hvb5rWPynNineWgSEZK/fr1jF4IE+SL4
	z0gqtSCLUozdo4OnnS0C7mIqXPNpDCA8cfnv4otHy90lH/iLlYICv2KHev50N1lC
	gF8chnEef6WBTLezUB4Gwc8GAtLJHK32q+dNTRGRMOt/wWJxREh+GDG7zeh/NrPS
	KhHCfML0n+e7oc+AhPxpDk/d+2NJtnie+P7OoSqriQXvrI4u5QezcOGlkqW46Ymw
	vja6NQCtHdF1byJ1aGvgbkNCgRUtTWIyKPaexBvVujf+9UEgXs+CAwSX0Fd7cFFb
	MJHyV/DIqnd/s2wXGv7x+n0o6emUrHAiSyEGM47W9NR8Aw==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4898cjh0hn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Sat, 02 Aug 2025 12:50:03 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4aef237945fso50088261cf.3
        for <linux-kernel@vger.kernel.org>; Sat, 02 Aug 2025 05:50:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754139002; x=1754743802;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=shOOynL8Ccw5asfZKPoZ1X7+Lw+OuwsF+Sk8PffaCnU=;
        b=rWQ1rf0IQCOeR3YuldwzF7PLnLlkbsKmEsOIrx+3tRLsqeQaDilvFzY/+Esr1aMbZY
         5pc0NAHE9EybHQ1EwqvJPzYGRf7wtToqfxvGEB4YKFgfz3CNNDbj/nMOuZVGhpo0nX+P
         Qy9Yx4cGxiW2CdCITeflLNBHtM7iP2XL77TEPV+2EQedzwPSxE+hqTRUTTYrrr5bMMc7
         bdNvqrrbXkjrzkRx29rUrnlgf9U8sVccyJrANLIz4+HRyZm+O05xPtMpz8/iUXxeZqaQ
         8vi2xqt1ksIx9nxDF+RB3ASFn3SYG+TjPBaYWoiPrZMjsuM5hO5/VKmclvOQFamWV9pI
         R+fA==
X-Forwarded-Encrypted: i=1; AJvYcCXtWZgjLFJDZRwJk7COWD/WNUvAgxJb0b46bQMZ+6XuBRpnNNICq1ut4dJtHqHf6gV++5rJiJjdAn0nLdg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzi8XJvlw2lg283/vAeda1aZ4/I7wT+JPdPzlAdRRMuhFbzJ9dZ
	GDHRg1BIjjzOCjxlacNqvSJmIsZTQrfbe9h6Kf1TBEUtKt+gCBb5VVnuG+w9oGoLA9paDoiPYDt
	KBEve5058tJCqxF7bgjpcN0eKSXWyXdxblCeHx0zGb7+WQQmyOfU9NDzv7RC7Jq6vwvw=
X-Gm-Gg: ASbGncsSjtkuo9GczacyetWdoQk7EIYQSVEkz/EViBDumzhE9EWziUvZqcnUlvzNnhs
	66RlBxbShWnP8X0W8uHHTibBw9v25iwSDBA/bMlWDCZOIp9TOOJTGjZSfyNZXf0RZHze5iC4MRe
	wv4F7iCNAgEzIJw8nJEszR7HYGpZSFZbMB2TKB37mD6Yh08YcTujfaYc3uNRWdpX+0en2QvBgsO
	yerTrxyrQIHXP+Od3Lp2FTRcFrALiJUDCe7jsQF0FJS5UVIWKAMbYSVcdfuaIEsyHdO7pJ5ZGLa
	BVFrJap0weknnWI2aXahjS/q0NWkAE/5jBs/Zun58CroRmbHk2d/kJjZVGvT1lAd/WxcBeRlsHD
	C+sqiNWWzuu/9K1fZHh+MSDlu/7+OAFwG4zZD2vAp5iNVksHpi7eE
X-Received: by 2002:a05:622a:1ba3:b0:4ab:3b66:55dd with SMTP id d75a77b69052e-4af1092f38cmr51204821cf.17.1754139001838;
        Sat, 02 Aug 2025 05:50:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFkTUAPmdqW3GA3NPJwI8LqzCsK5Fu9z5hE49dbLUGEiD4djuJtZr6faz2CbncWbE7dsaBxlg==
X-Received: by 2002:a05:622a:1ba3:b0:4ab:3b66:55dd with SMTP id d75a77b69052e-4af1092f38cmr51204371cf.17.1754139001330;
        Sat, 02 Aug 2025 05:50:01 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55b88daec97sm975399e87.189.2025.08.02.05.50.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Aug 2025 05:50:00 -0700 (PDT)
Date: Sat, 2 Aug 2025 15:49:58 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Konrad Dybcio <konradybcio@kernel.org>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Subject: Re: [PATCH] clk: qcom: Remove double-space after assignment operator
Message-ID: <dnph3mrkujlutt3bqvahvby2fmmmyfzxk7ighvx5kqqfbbctuo@akernmcqntdb>
References: <20250802-topic-clk_qc_doublespace-v1-1-2cae59ba7d59@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250802-topic-clk_qc_doublespace-v1-1-2cae59ba7d59@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=MNBgmNZl c=1 sm=1 tr=0 ts=688e097b cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=wXdJWVuGbmjov8BqX20A:9 a=CjuIK1q_8ugA:10
 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-ORIG-GUID: KAQBwIH-veC25cb5PY_GTgO1eqG4eC2s
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODAyMDEwNSBTYWx0ZWRfX1J+h0l2ug7QK
 2ZqnE4eMTSllw3EQpeM38xBTWd+kZ1ztF7C4Lwvz1ka0NCN6Ebckt5ZefW/f0J0XWHmq0F2PThI
 QzyKlNe0CJWjuVTw7qnVPHCUs0S2Au54IPVfP9AOVzkh2pLxLNky/y2BvDLHXceh0CYkt+gmNkT
 wtcA5J2YkZR23tYNq8jdnnNyI52NQxhGT7k5y4AN46RGDG4OeLqt+zC6i01mfUuG1Zbr1H35FqK
 CgnoU0qJNopz6EncgqYLy4D/1rSWhjIUGgh/yZPlZtR5BLVdzqwcGE10QpDpZG1HI4HG/awVP7g
 qhBASCFBU3dwkk1pn8q7mTQjhcjdcF+rpDwEBRc34s/TH2LUG3Xdyz4U0BnCzFx79eal0crx5Th
 1FpQedM9uA5bjDDW5N3UgCCFqWepfXlgoqRJla2wZppzaVJE4CGvKXuuu8se1E6ooBl4t6PX
X-Proofpoint-GUID: KAQBwIH-veC25cb5PY_GTgO1eqG4eC2s
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-01_08,2025-08-01_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 phishscore=0 mlxlogscore=928 suspectscore=0
 spamscore=0 mlxscore=0 priorityscore=1501 clxscore=1015 adultscore=0
 lowpriorityscore=0 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2508020105

On Sat, Aug 02, 2025 at 01:44:44PM +0200, Konrad Dybcio wrote:
> From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> 
> This is an oddly common hiccup across clk/qcom.. Remove it in hopes to
> reduce spread through copy-paste.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> ---
>  drivers/clk/qcom/a7-pll.c              |  2 +-
>  drivers/clk/qcom/clk-alpha-pll.c       | 26 +++++++++++++-------------
>  drivers/clk/qcom/clk-rcg.c             |  2 +-
>  drivers/clk/qcom/clk-rcg2.c            |  8 ++++----
>  drivers/clk/qcom/clk-rpmh.c            |  6 +++---
>  drivers/clk/qcom/clk-smd-rpm.c         |  8 ++++----
>  drivers/clk/qcom/gcc-qcs404.c          |  2 +-
>  drivers/clk/qcom/gpucc-sa8775p.c       |  6 +++---
>  drivers/clk/qcom/gpucc-sc7180.c        |  2 +-
>  drivers/clk/qcom/gpucc-sm6350.c        |  4 ++--
>  drivers/clk/qcom/gpucc-sm8150.c        |  2 +-
>  drivers/clk/qcom/gpucc-sm8250.c        |  2 +-
>  drivers/clk/qcom/lpassaudiocc-sc7280.c |  4 ++--
>  drivers/clk/qcom/lpasscc-sc8280xp.c    |  4 ++--
>  drivers/clk/qcom/lpasscc-sm6115.c      |  2 +-
>  drivers/clk/qcom/lpasscorecc-sc7180.c  |  2 +-
>  drivers/clk/qcom/mmcc-sdm660.c         |  2 +-
>  drivers/clk/qcom/nsscc-ipq9574.c       |  2 +-
>  18 files changed, 43 insertions(+), 43 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>

> 

-- 
With best wishes
Dmitry

