Return-Path: <linux-kernel+bounces-727370-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90463B0190C
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 12:00:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 060053A9BF2
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 10:00:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C86C27F015;
	Fri, 11 Jul 2025 10:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="axw5SR9u"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E604D27D782
	for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 10:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752228023; cv=none; b=nPNFSBmktPw8hiTR32XvURoS+JKnDf22lEATkFEWi2zCIbumw9hX/MB2YlQpLa/qbwLz8iFZkuXpkUv7KiIaVfx9bKq6OcchpJ7gd4eXbs3+WWrcLKi0Bu99rTyeQin1/ZAipzeM4tJyZSdbH+RkjZ6TQh/8J1gCQtHvFerMGL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752228023; c=relaxed/simple;
	bh=zWLtanhvCIpSQaF+swneQUeYFWPTh5F4obnY4lrF7m0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UPftraXETVJTWODWEq+RUYP/+nN3d6uC1AjsrfFdv242IpnAHKTXyVigpYF1Wp8NWUH2yjqV2ClftE2DfA8uSgYu8IDAr7HjWDj8r8w5MKeT1myAAZE28PQ45zvyoIZuO0nRFWuurSdKDRfQGqh6F0F0F06ilM/iKnQYevfBSsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=axw5SR9u; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56B1XLHb003306
	for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 10:00:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	S8yPPRkJL/ZzeV4qZbIKYir/HwBPXfbbXpIoKWUgSDE=; b=axw5SR9uMFk3cf5O
	c65Nu/hMWRZOrxPT5SbOCqJIjVKnOvBhRE8X0fQ6i0KGuZLwsJI0EMBLgz44VhIW
	WcVUXjWHyNwtSFfylk/BbF+Eaf/rUfoS1cG536ujCumN/i+ut4Zxunksp+PYpzh7
	9T05vbaYGayHfh2hWaTcUL5KISKFpUwpRwKtAn9d9LconQakq9FBerVWsIjzrkET
	twVdqZ98NXYE937d6Lqi2sragbZoGI3siTh6HPt3YfEY+J9hwAYplrs+on2CVKB8
	qWsm/cZD23v+ESTat3Gkt/SyuF/AK3Lr8QaRKSrvAKbwTUDr9l5tbRMmg66stqP7
	Qqv/kQ==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47pu2bkb27-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 10:00:20 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-7dfe47423f7so5381085a.2
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 03:00:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752228020; x=1752832820;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=S8yPPRkJL/ZzeV4qZbIKYir/HwBPXfbbXpIoKWUgSDE=;
        b=jGXIm2SsgC9xxVqAWPuRsuMfmqUvN9+4ZFInF73d89DkL1qd/1VDvejCKlo4MeYecJ
         IagXd7Nn7QL+R4nmNhEu0N//U8yY+UFpDBV3sSC2ZXQM7BHzBe2oEjTsNyUxXz44Buhz
         3TidSom/catKBX1Tq2C4zT5GWZMQgOu/9mHFXTcY/8PuYS1oUCKdZfAzvh+/uuJf5/Jy
         yhnSFb1VVXMpErVAm50gmjW8XncVmNy3N3UIoPGCGCkR9OVctLWLlUPmwJ3EfLyTC4it
         GZpWOcIlgr4e4b9YLNMv7H4+Az6HZz/iiyifffu49Q7P5xah5CphZ0dXVSwjDRBTjP72
         oYnA==
X-Forwarded-Encrypted: i=1; AJvYcCXUK/mGzWqpvNUT/0nlloGBKY4MbwavcFeZLmTV/bd9Q7d86p4ZFtpfGEmbkAHxFmSnrU52mRQYilYnXqg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwzPJMOOwq5fEFuhpVhF7sn5PxUhd4asI9citjLGTYuQJI4zF55
	ZEvhkAzwSYXrlgs2zpa/RZnODjNLUWp8RmHvYV0WY698W3vrHaPWuKrvrYUX1BymXapcTFfPVf4
	aZPz4Hqu9iT43bZiTCKlOu8cTc5mjs7ApZh2JlTQB4b+XVfeDsvmsIOnh2A9gi6n+ejw=
X-Gm-Gg: ASbGncuOsvbz8j/bil2sF5TgtoMhkl/R0nRV1KSMjidqJv779udr9UN7L1TD5SxBtii
	3nze1REVn68CyNpK2yFqPDmo6QzdVTVqJjDDddKqoYLFwBixFFF7MLFngbcZRt6/7UByygepjXd
	eF9Pic+ACE6Dnc30RpCo26ZuBSA6oQYrR6AQIXxidFcsOnct8ZjoXB3bTq00Qq+RWk7u5Au7nq6
	tB35s9T1oIBncIu5x8C5tQqf+zvbPtBu595bjsABMg7VttQPqDmvSAT0jA5A/M+uDhnclWPOs21
	Agn8TST9cxkrNOJk/khoI0uEFaK4B5bJN+ssV9A3UIyjOVmysUhuJNifLbCVZTi6vw/5vXnRGjs
	K7eJGoEYhxcjln8od5bCE
X-Received: by 2002:a05:620a:1791:b0:7d4:4353:880 with SMTP id af79cd13be357-7de97c2cee7mr101576385a.6.1752228019706;
        Fri, 11 Jul 2025 03:00:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFlhPKclj6Yn0L7q+F2xj0Xt2MfgZll0J2UP/WxG5I7gSC0cNE/OxkTsOoKzfyHayBKXzvFZg==
X-Received: by 2002:a05:620a:1791:b0:7d4:4353:880 with SMTP id af79cd13be357-7de97c2cee7mr101571885a.6.1752228019106;
        Fri, 11 Jul 2025 03:00:19 -0700 (PDT)
Received: from [192.168.143.225] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae6e7e907c7sm276215566b.17.2025.07.11.03.00.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Jul 2025 03:00:15 -0700 (PDT)
Message-ID: <9b1c3318-7d89-4fcf-99ea-3b446793a758@oss.qualcomm.com>
Date: Fri, 11 Jul 2025 12:00:10 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/9] drm/msm/disp/mdp4/mdp4_lvds_pll: convert from
 round_rate() to determine_rate()
To: Brian Masney <bmasney@redhat.com>, Philipp Zabel
 <p.zabel@pengutronix.de>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Linus Walleij
 <linus.walleij@linaro.org>,
        Rob Clark <robin.clark@oss.qualcomm.com>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar
 <abhinav.kumar@linux.dev>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Yannick Fertre <yannick.fertre@foss.st.com>,
        Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>,
        Philippe Cornu <philippe.cornu@foss.st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Chen-Yu Tsai
 <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>, Stephen Boyd <sboyd@kernel.org>
Cc: dri-devel@lists.freedesktop.org, imx@lists.linux.dev,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        freedreno@lists.freedesktop.org,
        linux-stm32@st-md-mailman.stormreply.com, linux-sunxi@lists.linux.dev
References: <20250710-drm-clk-round-rate-v1-0-601b9ea384c3@redhat.com>
 <20250710-drm-clk-round-rate-v1-3-601b9ea384c3@redhat.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250710-drm-clk-round-rate-v1-3-601b9ea384c3@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzExMDA3MCBTYWx0ZWRfX4nEayg/Gphbt
 6d0gITILI+CFb/RvPczAQlfcuNlafDsrtoqWiZc7ot3K079q1HM8sHzRQIIQEgjcTGPIL2GTJY+
 MRWaTFSWFmlseRLpOIFLB8dSn/Vg3yDaMM3g/KvybbzZS9J/Hdmp9UcjdTEF/R3ofY3AXtgcIO4
 hexi6kZREhJukDYjDiYmW47gz0f1kDVG/+9Z5zqILM+vimag1Sb71P6NPV3fAxoDUcBSEh+cShC
 4Hu2afi4OtGx/A0AdoQ+9Qycw8xiuTfZhcHA7Cn5HVei3nMUYg4C0toJ388yjOPkK6QS/1NZ4Dn
 GGlCV43W00apu7RtD28GPmSfNc54+Mn+G5dhOnzeHq3hYEByx2DJnTjZr4iJ9soZ4HN940VKSr7
 UOlGfjwhcvOP/AKY10YcFpYzcqB92Uzj61axGvygS+6xKFPqPGm1ZA3NxYQ4sDxLMBZgWrJL
X-Proofpoint-ORIG-GUID: IQ1C-9icLcQg-Y7FiEm8euZqNj_DpgVd
X-Proofpoint-GUID: IQ1C-9icLcQg-Y7FiEm8euZqNj_DpgVd
X-Authority-Analysis: v=2.4 cv=erTfzppX c=1 sm=1 tr=0 ts=6870e0b4 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8
 a=Lh8LEGs6nEvmLzq652MA:9 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-11_03,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 clxscore=1015 impostorscore=0 spamscore=0 priorityscore=1501
 mlxlogscore=787 bulkscore=0 adultscore=0 malwarescore=0 phishscore=0
 lowpriorityscore=0 suspectscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507110070

On 7/10/25 7:43 PM, Brian Masney wrote:
> The round_rate() clk ops is deprecated, so migrate this driver from
> round_rate() to determine_rate() using the Coccinelle semantic patch
> on the cover letter of this series.
> 
> Signed-off-by: Brian Masney <bmasney@redhat.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

