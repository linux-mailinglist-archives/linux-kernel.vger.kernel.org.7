Return-Path: <linux-kernel+bounces-890252-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BF029C3F9CF
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 12:00:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6CA5B3B0B63
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 11:00:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E772A31B833;
	Fri,  7 Nov 2025 11:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="meYRNVo/";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="X7eXUY9j"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91CD631B82E
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 11:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762513229; cv=none; b=paG0mHrka76PvfNLQavusY1QgjnKkCpO+M0mgSG6uMSsHdPB9LRCDbr57Yc5KXIfgMYHzv/RRzguxSpm+HcQ34h840nIA/RN481KRExgO9bYM/48mLITG1rz2g3SYzhTh9rvJhvwQoU/I6FC8gwoE7+FgbPTi0he+SkRT1pjV5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762513229; c=relaxed/simple;
	bh=YP5Kx7k+Nd09x0w4SUTnReHV8qPMtlpM4hSGSOzvfg8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PGYFN7cnJS7bTHkKuHddxJ+Rbt8cIMCu6pvehzHtBj1ukTF/16wtpkyiywEVYJOUDl8EIlXvx1p1wSVwAB3ZIrKpgTrZqzGasaivu6k/E5DkviytzWqNSxXUvS0HCryLcN7qXjwsNNrnuC8j4jyT2zIf8C4EkMNC5tI5VvvM3b0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=meYRNVo/; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=X7eXUY9j; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A7B0QSE2878530
	for <linux-kernel@vger.kernel.org>; Fri, 7 Nov 2025 11:00:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	3Yxrppr7/emo5nMkfpN1y9e7bjiQLYqkReu/RHenH+8=; b=meYRNVo/ytmsLIw3
	9yLlW7GI4+rmzu1SkLLhvRhvP8rWpFv8etdCh6oOI0eghmA6tDSc4+hVriUcpmbT
	bvUyQrcf9TgGLMtQn9G+DabVKcab8kJVoyw9dkotpbWXALEFwxkESHu9/xGv20VL
	nacxkzyq6bconr1T4lWp2oNzE6cnmBNsSKhavXJQtBCa7T+USx4Ja6Uje777/aBI
	6S25I9Inyk4w65tWzgHYtI+hnsskEBJILnxbA1HqfHj1VXyZUvwbpaTp6JPz2umy
	TUX/veb7bU/ued1EGhEUm+QNtaAtvgdwI55azNJSswoyx0dkp6JjaiBc//hM8H2d
	w5LLEA==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a9fh1r00c-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 07 Nov 2025 11:00:25 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-8b184fa3ffbso20630085a.3
        for <linux-kernel@vger.kernel.org>; Fri, 07 Nov 2025 03:00:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762513224; x=1763118024; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3Yxrppr7/emo5nMkfpN1y9e7bjiQLYqkReu/RHenH+8=;
        b=X7eXUY9jhcys6rCJKfWotZD5Wt6XLsFNZzhmExcenT54Ewgatl+zppHG4iTptUzHMq
         wu+EN+m/nYrv1wxWffmJcVrBxusDeXl9u6DihAtSYrMREzt3jAeCv94BW7bgm57UBOP9
         3GlNOXEN01GWK4f8CUN1cgvdB/b7TU7taLJoy2P1gfCbMDh0bCr3w1FltKUei+jjWtFU
         qLOf9n0UUxTMGGJ4BqWdgw6jjYlQfNhaoo4jxbzTOTDUvXpDlFrKjZQARPPLjnEnbWvf
         hK1J6AB9XW9d8hZzSMXXh6LBM6UUKnLAlBkU7NxWBJUjBveUStrHG+69YYYfEren+j8T
         ROcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762513224; x=1763118024;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3Yxrppr7/emo5nMkfpN1y9e7bjiQLYqkReu/RHenH+8=;
        b=tActKFfcpNj4kXnU1eDfpHMCMQBjJ51z1v/nrwqcmeyFBB1FhE8GYV0C12mLM8zCnW
         zHGt+MVwbYj5s9ydUNHSe+00zHBY1hiEtHY+He7P8UTRYwqY1UlVw9Q6p6QjarYzQJTK
         IlNYP3pLd7TbS55QBxEf3FqW44uSjYETgZZDeU8Rn0tD0csPcCWGM9epCNv1BYQHkq/3
         vP/NfyGGDO4J2Y3+Sfrg7+N3sfUp1mLypjejjDOYs0Qhz4pJ+alJ89O312buU/uKYONa
         8gRsFXlOuc6PssLsj/HSoBdqzsPfM1Wslk8LwKC3Y7JbWj0ddOLk9LCGSUmQb2A1Rebm
         MuxQ==
X-Forwarded-Encrypted: i=1; AJvYcCU0HR8tyl4GQwKpQ7I67dmixfKtBcta/geIR/CMqMWzDWXFnhiTVycQJjMcSouykfiNH5WWJYMW3KX2Meo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxjNhAR8fz4jnKJBqSdXjmR1cwWI/xk4uw2vAfcXIfhlswLkk3F
	Du9/VOlCHLXzDe6D59WojC8NQZsJ9B7lc0ppRDR/fFseqWRJd89KxZ1XseYZGQhTtHt9yAvRqzK
	h3K1r8jfKk2aYQHD+vY3lrI+C/xT3Z3TzdzRuiIhnAFPHcOXRuuDEWsMjKLoim+vSP/k=
X-Gm-Gg: ASbGncslrvlli5QWxQ/ZcD1yQC5RhywKroP+mNvhPKEZdyJQGHtep8REx+TA2LZs8RN
	coey+QR5N+qot9JYA76fmsCpCOr/KjWYRnIto63WgfEMgjJwiEV9GA3httKS/Vt9cm9td32JbZZ
	WEMgPfPOMl75jNNq9+OOTE35eRA5ucjGGIBo7sfnSV1bkoleZVz/eXlRQ7xb4DsbKHrxLCg9i1x
	z49CzyUfzb1qmNdtN98FHSWH04tShKE4N5MESh2S/sZOSm7QyUnPf2u9XtI/GjDDhnx3wvGIfen
	lADHynhhWfea/sRe8XSnzx4tuWa85mzXZY9Z3lWDrCC8v81lO7QiSQ/e6u0rE/tMwkS3moFCxxd
	h5anfOB05MWxDzAoIPzoQw/gPUKFDdElM+BSIVsntopGFlat32kZH7bdC
X-Received: by 2002:a05:620a:4049:b0:85f:89:e114 with SMTP id af79cd13be357-8b245280933mr239712085a.1.1762513223924;
        Fri, 07 Nov 2025 03:00:23 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH34Ma6AlYFANasFLA7REiIDlipeT0LBwxV1S1iyIGEImmErkoaBKdKchVkLndS6HBNKbTjKQ==
X-Received: by 2002:a05:620a:4049:b0:85f:89:e114 with SMTP id af79cd13be357-8b245280933mr239705785a.1.1762513223227;
        Fri, 07 Nov 2025 03:00:23 -0800 (PST)
Received: from [192.168.119.202] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b72bf9bc874sm216910666b.54.2025.11.07.03.00.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Nov 2025 03:00:21 -0800 (PST)
Message-ID: <14f95efb-0eb0-48ee-9132-df35abddfcc7@oss.qualcomm.com>
Date: Fri, 7 Nov 2025 12:00:12 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 6/8] net: stmmac: qcom-ethqos: split power management
 context into a separate struct
To: Bartosz Golaszewski <brgl@bgdev.pl>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Richard Cochran <richardcochran@gmail.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller"
 <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Vinod Koul <vkoul@kernel.org>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Jose Abreu <joabreu@synopsys.com>, Chen-Yu Tsai <wens@kernel.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Matthew Gerlach <matthew.gerlach@altera.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Keguang Zhang <keguang.zhang@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Jan Petrous <jan.petrous@oss.nxp.com>, s32@nxp.com,
        Romain Gantois <romain.gantois@bootlin.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Heiko Stuebner <heiko@sntech.de>, Chen Wang <unicorn_wang@outlook.com>,
        Inochi Amaoto <inochiama@gmail.com>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Minda Chen <minda.chen@starfivetech.com>,
        Drew Fustini <fustini@kernel.org>, Guo Ren <guoren@kernel.org>,
        Fu Wei <wefu@redhat.com>,
        Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Maxime Ripard <mripard@kernel.org>,
        Shuang Liang <liangshuang@eswincomputing.com>,
        Zhi Li <lizhi2@eswincomputing.com>,
        Shangjuan Wei <weishangjuan@eswincomputing.com>,
        "G. Jaya Kumaran" <vineetha.g.jaya.kumaran@intel.com>,
        Clark Wang <xiaoning.wang@nxp.com>, Linux Team <linux-imx@nxp.com>,
        Frank Li <Frank.Li@nxp.com>, David Wu <david.wu@rock-chips.com>,
        Samin Guo <samin.guo@starfivetech.com>,
        Christophe Roullier <christophe.roullier@foss.st.com>,
        Swathi K S <swathi.ks@samsung.com>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org,
        Drew Fustini
 <dfustini@tenstorrent.com>, linux-sunxi@lists.linux.dev,
        linux-amlogic@lists.infradead.org, linux-mips@vger.kernel.org,
        imx@lists.linux.dev, linux-renesas-soc@vger.kernel.org,
        linux-rockchip@lists.infradead.org, sophgo@lists.linux.dev,
        linux-riscv@lists.infradead.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
References: <20251107-qcom-sa8255p-emac-v5-0-01d3e3aaf388@linaro.org>
 <20251107-qcom-sa8255p-emac-v5-6-01d3e3aaf388@linaro.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20251107-qcom-sa8255p-emac-v5-6-01d3e3aaf388@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA3MDA4OCBTYWx0ZWRfX8oRftBEDGrPt
 yDCzalrcbVcPRIthxGhZXcmXBgK5S6Bd26REETnQ3P9yYHfNG6cdv9PDgroPjaMQrtLTsb/4g1U
 6v6E3ejCLxT7WvNVTd99iUOyjzngj+uQFN0sfM782Op+ljTZ57I9XE8QFoTznR0MrpVdS9LZN1Q
 uF2Snz0U8ysUEHALvIDnvkvyJqLAmWfe5TtzcPILUZEfs7acFdQeEzVd5mvByksEJjm3ltOc/yz
 GnRhy+9GyWCDVPPB3NeHWNaylJnCMy+aDLr2Tc9oRh/MIzZKz0xnC/mSlu/CReLk9QqxGITCtEk
 1n3MMSEwF0uYN79m1l1Ly5WilXwhGuc+fbXEqmCrviyanObfLBeDp1y38ChDgMi0qZj5oJ/CLOr
 LarT0ozXZkDVabqd6vb8Omu7IIDV7Q==
X-Proofpoint-GUID: wwo-jN6--NsLAzJEcguSUmODU3oatg5Y
X-Proofpoint-ORIG-GUID: wwo-jN6--NsLAzJEcguSUmODU3oatg5Y
X-Authority-Analysis: v=2.4 cv=IcuKmGqa c=1 sm=1 tr=0 ts=690dd149 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=KKAkSRfTAAAA:8 a=iTm1nGh4yTgqJnnOKdQA:9
 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-07_02,2025-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 suspectscore=0 spamscore=0 priorityscore=1501
 phishscore=0 clxscore=1015 impostorscore=0 adultscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511070088

On 11/7/25 11:29 AM, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> With match data split into general and power-management sections, let's
> now do the same with runtime device data.
> 
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> ---
>  .../ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c    | 46 ++++++++++++----------
>  1 file changed, 25 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
> index 1f00556bbad997e2ec76b521cffe2eb14fabb79e..09f122062dec87aa11804af2769ddff4964e6596 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
> @@ -105,17 +105,21 @@ struct ethqos_emac_match_data {
>  	const struct ethqos_emac_pm_data *pm_data;
>  };
>  
> +struct ethqos_emac_pm_ctx {
> +	struct clk *link_clk;
> +	unsigned int link_clk_rate;
> +	struct phy *serdes_phy;

What is the benefit of doing this? PHY APIs happily consume a nullptr
and NOP out, and the PHY is already retrieved with _optional(),
similarly with clk

Konrad

