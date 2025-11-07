Return-Path: <linux-kernel+bounces-890243-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 577B1C3F980
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 11:54:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2557E3B253E
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 10:54:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 362C831AF34;
	Fri,  7 Nov 2025 10:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="D3ciq7sL";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Lgi612pc"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D59D430F7E0
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 10:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762512886; cv=none; b=iYNJFr5oiBO0j9aFaUle6Ce9ozZfYZbac7R9bxtXLGGtMWL/jF9hpRpAYbUc/UjoNkIz6PONDlfBpu1LoD+YLUGzOe7XSJ+izKMyHU+KD5TzDCI1zzJxfi66Hhq1vHaaPJVzw54i7ulC/ohs4QcgtPNVlqkSeqsLvrgAvxSV4yI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762512886; c=relaxed/simple;
	bh=GbYCIblRZKH7/U4QkVZcpYd2o4yIEdeSQYJGqNKsE6A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FOKzXs4bfOH37ZdeXHTIf8suOwUZ50CI6a7202FT/4nYxS/30yFxzhpW2zz1Nbag8tgrWdzOtEhb0dMtznQDMjc4LY/41bnT4VQ64j8AQGORTVl63XwYyU1KoGMJQO2vpyjsZjW44OwNqZnVN2SNW3X7F3qTJqGlged9rjbc33I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=D3ciq7sL; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Lgi612pc; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A7AjS8Z1864656
	for <linux-kernel@vger.kernel.org>; Fri, 7 Nov 2025 10:54:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	t3IKVzBz5JQK8wTUX7NukAcRSdlW+wFpDRAPikZl4+E=; b=D3ciq7sL0T/1mqDA
	KQOUvXh3Mhxuk859eyTuTtyDlTSts27cCw5jo0Qy/Kqfi0+9EEgGjO78tdJgcjiI
	/ZYPn7i8YLL/cNB3YOhXlcFlNRonkS1KARKEuwJrURUm79wZUJENvHCzLGPw3vJc
	sS2fL7+89HTzvn+w8+6DMz910/EXVZ1KhlcmAk6+G8RfEVGfOiJfWEu9s2rqXdfY
	npR/UpgRmaHsmNeiItvcsNJ4uFfteDzCHsTZdCMFaDW+0I45vW7sXMrAK0mQkULJ
	PcBbv6BEOI8XYuVJ4nEOxTArWjAXQf/S/5TbwBToT9e+cq273Msh3ToXZlizm4UK
	z0AxXw==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a98ta17xs-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 07 Nov 2025 10:54:43 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-8906754b823so23252985a.0
        for <linux-kernel@vger.kernel.org>; Fri, 07 Nov 2025 02:54:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762512883; x=1763117683; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=t3IKVzBz5JQK8wTUX7NukAcRSdlW+wFpDRAPikZl4+E=;
        b=Lgi612pc3ZQn65enEljcUKaU18LEWIDbueff+LXplpkShu1aqx06Hs7mfsrY9Zo/IN
         mRWpBK4ROQq+xPoHQp8EiclpnX4ifG+kX9VMphNwDl7iDIoYXYlDVogCp7yIwhFkCaXA
         sJzZF69UNTPCuQ1GgsWAQP6CrsfsnXLKVJbtZZ/t62YgyKFHjZlB4aya38rxM/gOar32
         C/+uJtX7OzR9/n1OQSP5/98zi7swNsXoZOmfXj0wcu4ensmUyXeFc1sDYDkwrBfXuXu/
         2EEpidttHYaaKpiBtopcE5MMNxNfto5g42bQOYHIyEYvIzw3nyOz+K30Y0e9izpNxb4q
         7/3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762512883; x=1763117683;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=t3IKVzBz5JQK8wTUX7NukAcRSdlW+wFpDRAPikZl4+E=;
        b=DbGRYcEytSKyMtoPp/pPtzoMfTgtHftSgoP/CE8ZUMUkK3Wpf5GGPKAFc92YTfWrbH
         pbMcB2/vMMCOItbviR6GH4axisTn5Rb2COztpsBJD1JEVj5ZNwwxBwtDGfO9vzDR3uqB
         q3diSiU7fNNqgJqvTGF5AHV2IhNTyLXgqWrRgBOESCa5tXGrgfwNMQ6axmk2b9fZW8QR
         UVFf/LTZGWajgIpaIdF0THgHxNL4EjQ/WFQYGB1hsCHIJq6B9RJlOokGJzuaJKZWmKGC
         zSsYNLj+r21Lz9FPNa8RXueezjCqoEFqSQbDB7XHG96MgFaz/2D1GVgDqEL2Ccq7sSY/
         E+jw==
X-Forwarded-Encrypted: i=1; AJvYcCW1m+uau3tUdxSGbbiHKj1TnFo9vNAkhXDs9Gbo41Ou0f8uSsxEdXq9x7nen/ExS596F4Qlyto6n2JRzzI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzaMqOUayqCZw3w9QSLflrIdIE8Mp6gNO3nvM9SpYkuVayR8T58
	Frl6I/blar7eKrw6bwYCNnAMDMG4BPXagNHqccQD0Dv+w67fsEg2PTxOxuXo4pooo+3oZSOvFbR
	kwSvaUAv6FeDzr/sVt3HU8lrXv0FSn5HP3HOlDxskYiMCjyPDU1CVGcl1Cm7oNripaFA=
X-Gm-Gg: ASbGncv1zK3EJDlNFpecCWwNz9Hx7jEOsEsgRcl9Dmn0ZiDHkk3YZOhlg/UFeiv2vXu
	vLyZFf9BRa4KrQP7iJVfIIZIw0ZKV5HJkRFt1Q6gCmRHE5UU6FCuzaauGMHapehmJG9YkSHO7FZ
	o5Sb8FU5roV5kjG7r3ez8eyE0wbXU2uVBh17JPBcyCNrVojhinfvy0S6ENBHGs9rWu9VuT/XCXj
	LD7/Y7seo45ZD5Fss4RBuFc3J+UrpAg2c0kmSer9XFqWCe9T76Lg6KcqGun8R6bW3fSO+R02AVr
	cDXIUFsC3RoPsKe8K0bGkUvdWIHvA/+V+xSAeJAHdhXZgIqUEaVdi2vY99wWaK8W8gGKk+UN91t
	8BQCIjAekmnFume9jog+EYllmq3RnuNwBrSHvwf7hSGXN2JZ4SaJefJUX
X-Received: by 2002:a05:620a:2a08:b0:8a2:a5b2:e3bf with SMTP id af79cd13be357-8b245297214mr216407285a.6.1762512882712;
        Fri, 07 Nov 2025 02:54:42 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFi7mPq0na085cioUOvqXq74YCfsRc6NxnJgSblNj9scHFLGnEvxVACu852vb4CayQn6idLew==
X-Received: by 2002:a05:620a:2a08:b0:8a2:a5b2:e3bf with SMTP id af79cd13be357-8b245297214mr216399685a.6.1762512882057;
        Fri, 07 Nov 2025 02:54:42 -0800 (PST)
Received: from [192.168.119.202] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b72bfa11367sm205508166b.68.2025.11.07.02.54.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Nov 2025 02:54:41 -0800 (PST)
Message-ID: <86df9697-af58-4486-93de-b01df5ba13a6@oss.qualcomm.com>
Date: Fri, 7 Nov 2025 11:54:33 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 4/8] net: stmmac: qcom-ethqos: wrap emac driver data in
 additional structure
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
 <20251107-qcom-sa8255p-emac-v5-4-01d3e3aaf388@linaro.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20251107-qcom-sa8255p-emac-v5-4-01d3e3aaf388@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA3MDA4OCBTYWx0ZWRfX/QKWJQ/l9cx8
 hjutA+s8bzNdkdn/Y23fQhIhDU4imXAglZ6oMIJXjNZjNS6B9SjaRDF6V0Lj9ydPnMlFPVXW9vq
 VlYmzi1bHMsz1P8wY3gFI+yJXoK8au7D8zxyb4SlWFQO+XiAq3T1pc5ADi48IUO4E5NHICTOwDJ
 Gv/rCDHoo0mIA+EsoPdhH9upw86n3LeYBYaI2ONJRn+0+4FwUDicZ6ULGqrM8JkC0VCwytj646O
 T6jWQ1hF1Y97f40IhETFdGq9S3GQPbnKiu6pWj5IIYwOrt42/YV6VKLrnYhn5n6tMB+hU67i9vd
 jHwvwFK6oZIhd2H08G3XyDNHkAxNy+2lKj9qLRa2hWC4ChvvLCbATQ2i6/goZmw5RP0ADEVyWdq
 k/l9YDoJAOMB0tX8ldW4B/Kor7eyog==
X-Proofpoint-ORIG-GUID: n0gVePF7D7F0wp8dBIl9tkbSjImQ2DTc
X-Proofpoint-GUID: n0gVePF7D7F0wp8dBIl9tkbSjImQ2DTc
X-Authority-Analysis: v=2.4 cv=G9IR0tk5 c=1 sm=1 tr=0 ts=690dcff4 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8
 a=4r4FsD-561SDv7fJwu0A:9 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-07_02,2025-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 bulkscore=0 lowpriorityscore=0
 impostorscore=0 suspectscore=0 malwarescore=0 clxscore=1015 spamscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2511070088

On 11/7/25 11:29 AM, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> As the first step in enabling power domain support in the driver, we'll
> split the device match data and runtime data structures into their
> general and power-management-specific parts. To allow that: first wrap
> the emac driver data in another layer which will later be expanded.
> 
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> ---

[...]

>  static int qcom_ethqos_probe(struct platform_device *pdev)
>  {
> -	const struct ethqos_emac_driver_data *data;
> +	const struct ethqos_emac_driver_data *drv_data;
> +	const struct ethqos_emac_match_data *data;>  	struct plat_stmmacenet_data *plat_dat;
>  	struct stmmac_resources stmmac_res;
>  	struct device *dev = &pdev->dev;
> @@ -801,13 +822,15 @@ static int qcom_ethqos_probe(struct platform_device *pdev)
>  	ethqos->mac_base = stmmac_res.addr;
>  
>  	data = device_get_match_data(dev);

This change could be made much smaller if you kept a drv_data
pointer named 'data' and called the new one match_data

but I don't really care either way

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

