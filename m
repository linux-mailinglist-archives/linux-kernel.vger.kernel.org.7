Return-Path: <linux-kernel+bounces-890237-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 49B92C3F953
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 11:50:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 783C64E5044
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 10:50:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F00D31A810;
	Fri,  7 Nov 2025 10:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="B1EYSsnG";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="LErrStSJ"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACD68209F5A
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 10:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762512641; cv=none; b=GZgA32VoZibpYXu1FDPyhVFRBFBVhNlEwt2djMrdsBoisLMRGqHmpufhF0xQfnf9W4OAyJpOZ5/7gMoAnlqtWx9zXOX/SYgJanlsDvj5JxHF4nfoqhPyCfyRppC43W/cUNHgDN8WqBb/PkigubhkPTgyNY0tq381sYS+0ZsnMGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762512641; c=relaxed/simple;
	bh=H38bo1o8KZgtlMyhOjvzTVZdaXQkA/mCrkUJu/FTaCQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rpebp/Az8nLhYIqB+83l/TiS2vQbywojshr9AUOv1eSlF6dkX/2Awv1LzdLEdlJDiGGQHdDSdqqzU9kO2vF8yJ7MW7FjI4wmrn1THO9no15WDOdK7P/uUbUU8wu3GVdmzY0SLWb7Ls0e/F0E+7X3hhGPi88xJYVMgAaY6GFkmd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=B1EYSsnG; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=LErrStSJ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A79EJP81709810
	for <linux-kernel@vger.kernel.org>; Fri, 7 Nov 2025 10:50:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	K+LRkelT4LAUbuxVybXtmeX0JCfHUQudQjQlnzvpOmA=; b=B1EYSsnG47lGPxvn
	zAiOxrAmz/Wz/9UGbFmZFaJUsrfmtRJdHGCRNLO8nK188PAywHZCZ/Czv8tlM8ve
	CGTbIUMThDuTRN2SNFnJdG0FxRGnW+6oQLaE1SUNcHDxkH1p3qM+XKbF6+ZvwhuC
	2xSpWB1caS7pSkxWxhHPfYew/g/o0fF2xf0FwgXZJ9fl/vku5K0YWUR2Bzn1GvAJ
	SLreBdufu7mVgG3gE+Go0RhRFhZFyzFhMp9WBxMVB5AfBt5uh9btC4+Yx9NldHxh
	YgAVAW7chm0tTXTd4tmqkRL7pByvT7vcNlH8wK7Ctms8y6dh9igwU/62YLoua5H6
	vkifZg==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a96ue1jbk-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 07 Nov 2025 10:50:38 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-87ff7511178so1398996d6.2
        for <linux-kernel@vger.kernel.org>; Fri, 07 Nov 2025 02:50:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762512638; x=1763117438; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=K+LRkelT4LAUbuxVybXtmeX0JCfHUQudQjQlnzvpOmA=;
        b=LErrStSJdEkYoWE281QcbKE6B0ryO0iCFykA5UQ5uzeRckQpRGbx88lDuuBlBGnxE9
         41xOLBgsZ3NxWp6GOjqpFKmRLz7nHnZjui2zUerQULoyIz2TRy53Bw6FDHZrCKyN7DgU
         a8GPK7UBS5Bw93msfBVfMWu6m84TgEf9Ti0B8F5hYMGnWgTeDz0BdGJUCwwZ0uwKkg9L
         y2cY2PjaY5gi6ozb4rzE0cuUl2t1d4U9kAUfKeHgLUNdWWlwiS2eh/YpY/MnQGtaX0tI
         MgvHLNH7/GE7OKEFPlfzJWtp8OiVxG0qQZjR3UnXIU/mU3frZeLp4pExPRpTVs8Vg4Yr
         8WnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762512638; x=1763117438;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=K+LRkelT4LAUbuxVybXtmeX0JCfHUQudQjQlnzvpOmA=;
        b=sbDEAROcC7IzagY9GCDTYyQfcvGXDJVdm3uUvOBmFcP+KRvsIlgD1IFsz6rAo5PNgr
         fr/N4c9ctwbnbVw/c6FahODlbAWDgHogBh8LtB4QBZxo02h3Zt7fIUfRWhOul/7Kfukh
         HKgCxOpqhHhNbBEkLeVfOo5IL01at1QAzB8fyH2z7i/0Ow1XSGFrGb0zoCdB3xDGLk/M
         FWeEa/uzMEvIps0ltybBuXYw797WkyVCHUZ9Ca8GZoMno7WlsRHYliS3nXhcKCp40oaA
         7bGQvPD5yTLB2VFWlbPirjiWCtkagQ1AbzwVek5swH3KBGRmH2/kKgAMYlE3Vd6e6FBi
         POJA==
X-Forwarded-Encrypted: i=1; AJvYcCWhedvpg1n70fr6iACREZ7FkmRPj3Tj+qy+io4vORidQGg9LCyTVVhRKDFUXVzupMbqLcZ/zx7Cx/3GWe0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxucbI0s8h7z61pi7HoZ3UIr7OmI8Hw2nOvb7fzajrNfnS3mqg1
	0fM1yu8hxgil8+gqjpXWfhiu7VLdSJO8qWwD1dOn7CtLGfQr4YOl+Kfadr5VCmnvOmuN2swqowf
	WWufvDaustSdkmxAzWYCxB/bG2W+CNelO5rs1Wo3/EWh2sEdWtk3997nNbDJKwmdOTpI=
X-Gm-Gg: ASbGncvAWl+dXFRNaIDwqMeuD7a74gS3JvIAXZc4vs1/GIktiEkImU98SZge7g+8jvZ
	NqI4ij+w6DP5yXBX2YXl0HEIXJHEg+I9l2vjBu/ZdgF/DgOBI3bJNNWo+EzlxmnuPDA/LQJy3oE
	DN6dGM8L3KFX07vryfcrVrKHDtO0xG4bcu3UoYAaB30wKriGK7yah8BsvlpN3abhWUyTibeUe2+
	Y+ipQ5hOum+efQC6ekVYy5A4se28TTc7IKvhu1NIQO4LqVjdsYRtbu6j+UvwlJqeOCtRmIa3awA
	RQ08Q9ZiqvLY76LsORgn+XCxC5UPVanfBDSS4cvzn2M7d5msgh/a7DK9ookiDElOW4wLe6NwR0o
	SOxc3NyNzQdIz64cGKueSF6ETve3lt4049Mx++TMeeizyhPBcRYiR/tfB
X-Received: by 2002:a05:622a:411:b0:4ec:ed46:9268 with SMTP id d75a77b69052e-4ed94a41994mr19484701cf.13.1762512637970;
        Fri, 07 Nov 2025 02:50:37 -0800 (PST)
X-Google-Smtp-Source: AGHT+IECQ+rghHeVgkMsgvUMsj4lxwZEJlBOwE/naarHWq7nH8xBHgoJZQqQzG8SkQO4ghE/Xbce/w==
X-Received: by 2002:a05:622a:411:b0:4ec:ed46:9268 with SMTP id d75a77b69052e-4ed94a41994mr19484181cf.13.1762512637527;
        Fri, 07 Nov 2025 02:50:37 -0800 (PST)
Received: from [192.168.119.202] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b72bdbcaeaasm219104466b.1.2025.11.07.02.50.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Nov 2025 02:50:36 -0800 (PST)
Message-ID: <9805b902-95bb-4b18-b65f-f6efdfb6807a@oss.qualcomm.com>
Date: Fri, 7 Nov 2025 11:50:29 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 3/8] net: stmmac: qcom-ethqos: improve typing in devres
 callback
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
 <20251107-qcom-sa8255p-emac-v5-3-01d3e3aaf388@linaro.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20251107-qcom-sa8255p-emac-v5-3-01d3e3aaf388@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=fYKgCkQF c=1 sm=1 tr=0 ts=690dcefe cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=KKAkSRfTAAAA:8 a=Xr3OHDAqYAD4YnyFvXYA:9
 a=QEXdDO2ut3YA:10 a=pJ04lnu7RYOZP9TFuWaZ:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: WFmgG70hGtwt1dXM8R7STtTWwCd-XZIL
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA3MDA4NyBTYWx0ZWRfXy+U6czVidVJX
 6iKPqD5+nYNjCcsi8tYx3XadjbDtBhXc8aiweiDkoNb7Fu97t5N0S+z7sPy6SHnPYlCYz3syEiF
 gAZlZzSxVE4tBs/zDIt1/oPCruPSeYjwWLzBC1YnEPOg9dGG2gYC4nHju8mUFHQCownmrVcw6eU
 3733cw3RHsGhmIgOmLrvy5wsVF+k1vlBRQxhpdSJHBbjrDSl+nTD16WnIbV+2gzI8yS/71Qkgni
 sS1KETtQevChlnyBSyUqIm8cL26TyuzLucqI78adT68wlpWQJ37jcibuH9cZnZNoDNupAEd0zd7
 VCpLNdMQbFBh+dJbJino9Jz3yUxuajPtlVFoqdEaHqrESkIKwfKmA7vHFK6nwehvBKpPAMRlin3
 g5XSOktsWPSjzZIEWxDw7OwhAmeDnQ==
X-Proofpoint-GUID: WFmgG70hGtwt1dXM8R7STtTWwCd-XZIL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-07_02,2025-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 priorityscore=1501 malwarescore=0 spamscore=0
 lowpriorityscore=0 bulkscore=0 impostorscore=0 clxscore=1015 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511070087

On 11/7/25 11:29 AM, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> It's bad practice to just directly pass void pointers to functions which
> expect concrete types. Make it more clear what type ethqos_clks_config()
> expects.
> 
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> ---
>  drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
> index 8578a2df8cf0d1d8808bcf7e7b57c93eb14c87db..8493131ca32f5c6ca7e1654da0bbf4ffa1eefa4e 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
> @@ -726,7 +726,9 @@ static int ethqos_clks_config(void *priv, bool enabled)
>  
>  static void ethqos_clks_disable(void *data)
>  {
> -	ethqos_clks_config(data, false);
> +	struct qcom_ethqos *ethqos = data;
> +
> +	ethqos_clks_config(ethqos, false);

ethqos_clks_config() takes a voidptr too

Konrad

