Return-Path: <linux-kernel+bounces-889727-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A3CD5C3E56A
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 04:20:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 870444E6222
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 03:20:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC7AB2F747F;
	Fri,  7 Nov 2025 03:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="bn/g3237";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="H4nYr1gw"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F5462ECEA5
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 03:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762485598; cv=none; b=VrQ4Rb/TwxD/jip5dqrD0pPjHoh33xCYGTwzI0/XOFyGHF0biy/FR0KCngFkF8ZJiWhfEGxyIrC9x8SkeKnj9TZLzviuRp8K8yefd7VuUUunCPOLkxbMC8GC9d+S6WaFQZMKn9T6LSjAA0HaPtSJgdIqL8va2KbuBGuWhZwLiWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762485598; c=relaxed/simple;
	bh=c8A14Q/V8GEKQyw/Jggt3KvMMi70EOyHMLOV1fzSV98=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gihq64YIhIRAs8SFbDhs+uQ8uKaEZO3SNRKMRgr5QV0Cqu/DV+Sj2FSNLW/qqT/gAuM6KwY6lUHPK0USjoSjMqruKieTs4pat13PYv9DFSAOZehF3I/q6rDfiNZKilHrN9Hp0J/ffgBMTPVYw7IQTzgiiT5H3DG+AX0RLoGi/FQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=bn/g3237; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=H4nYr1gw; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A72lmw93156156
	for <linux-kernel@vger.kernel.org>; Fri, 7 Nov 2025 03:19:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=M80K1COQSKSOsbnYlBiyMzUX
	hbNJGsXiIzf10YFAobU=; b=bn/g3237YhT6RGT/NZXYeOvYm5A3Ef/qBwofC4bb
	ob4Dv/kHYUnPlqmL0Xa1UDS8viZtBnAjyxyHlhbUdzUrYXhO4WGipDF/pR9Akiue
	+PhN6YduFkOcBVFaCl6P/j44ij1qjqOtDIzTtkiR8ARG9UJNrLVau/QwrO4d3Sev
	d5IEuMtiyWEz8BgDIp+/J9i7vls7cUmINJhhat1FNXPnBah8jPCaEUfWi7aXBjKK
	Wb7W4dNnoH3GQCxQF56O02fdue9GWMkmlqu6Ild63nraYcyvLYV/K3nzCadQ0xjj
	RhXXNa2/vwQChQFVbvEhClT+oiAhzPsfv+bBb2rK7oOBLw==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a8pu0kd3y-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 07 Nov 2025 03:19:55 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4e88ddf3cd0so9151491cf.3
        for <linux-kernel@vger.kernel.org>; Thu, 06 Nov 2025 19:19:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762485595; x=1763090395; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=M80K1COQSKSOsbnYlBiyMzUXhbNJGsXiIzf10YFAobU=;
        b=H4nYr1gw8UP/zYarOxiyoDwoDw/ke/mQw8y3zSzCFLystxSDWPj0GSrCUi4veXh08/
         Kb/tZKPLMYZhFiaT2nQmWLzespdO2omch3XGx1aws1WNnKs2lm5+uEQXiPUzsTCNPG6M
         dVVLYQMpM0BqPLObxTPRI+h6PFCHkVg+yiIZAr5tLoRONPzi5j5ctxWTobisoThnJlHZ
         Mx2mZKJwy63WyjRHgR4kV60FsG+ZIFwoEl0NPfrBGNI42/E8DjHmWvwLGsTAXfM6muSm
         QVvZDic8dZOYA0iJ8oIte0PFHDrRVlDy9Fw1Yb9WdqHx5dbZ6qCiXTP6pM+yJZ4rZIUt
         fPHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762485595; x=1763090395;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M80K1COQSKSOsbnYlBiyMzUXhbNJGsXiIzf10YFAobU=;
        b=hX7xmYZ1EO2CwHlwMANaxSq1uHeI4VOm/YuAun3yYaDRqNappU3RDAl843seaLOtzs
         Vk98kpvuPfziRlW4mJU2DUd6Q7Csze9D611rMTceYaut0Y7pP4k3NSD4KgjP8j43NQ8O
         nWoSVa9+F403PD4UYGs7+YJHuaqwycCqK/InhAvNbpp/qp41qqi5VuUyql/4WGJph/33
         1DoPDCUqOP/JHrQL8eMa3dB9m3rZAIbjQmRUE5NTW4Qfoo7n4PG0PCM9+Q1QeiOTljGI
         Aornj6NgcfDc/3PUdhsxIVyEabNfliNlUGJwOy0099HZq3hd1pSDWlC7AHMaKjA0Ql50
         5Ufg==
X-Forwarded-Encrypted: i=1; AJvYcCU8GUxZhWJDbFVKNkumsllPejWFRMWtTif9/Cv0uRVL1z6/OwzwQmnrnLx0wqG0x3vF+xE413c2B8aWUcU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzb6LWgw38jbenGaFf48RQ/eiy9f6ugOBjAtomLpUKopLMafUiR
	wWB6D/m171rubfcUMwMYh5vUj7bmPuQ3/bx/uOyhlw46SKq9SOHv6qoOi1nncAIVvESKiDq2fX0
	vOsF8FDWMWmAb0GrHh6K2uddwlsuR1g9YQcIfoWlUyZNmCCGwzUrQx+gli0XK39A8v2E=
X-Gm-Gg: ASbGncuEMuyl2kD8Ayvw+EPz2NNGbe0nmh6ixhYXVK8gpwOru8rYcXYAqvwM4La/TH4
	VC6GTgvgrljFlLpKdZQaNKp1vY2qAvT5wecXjxYCV5dis6M6zH8GtLqoP3yT7+GYj7J2zP9dsLy
	aIzn2PHY2zdTLpZC5bX+hBwHUtN89d3IIDzHXeKtWDlK1416GicACXJRZbiLKEkscoNRTL6CkLd
	FSiKI5+k3bOS4AIz8RJyGWwn2R5Og7J2RQcheYd+oZWyD1lCb4GTNf44f2GXZZ8AoDjrXGfh5bJ
	uR5vCblv2wOQJEo3OvjiSsJjqV0+CBXSVpiSZKdEB0lAT19F6Q9z8qVnGi4t1CyIKsokC02AkxJ
	noXsn7SFSNLNLYps0pHvD+gMYMqJLHHn4xJae6wRzQtwxp3XHwUOkAGY93yQjzpz/rtKgGPhDKq
	N72jiWyTGavMth
X-Received: by 2002:a05:622a:199e:b0:4b7:8d1c:1be2 with SMTP id d75a77b69052e-4ed94a67750mr18773081cf.50.1762485595173;
        Thu, 06 Nov 2025 19:19:55 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE4pxfXAI2QN5tx3rdS8w62pU9piMwAcGPSHdAchfcF87faMpVG/a4sNiNd3ZJ914ce0ITvXw==
X-Received: by 2002:a05:622a:199e:b0:4b7:8d1c:1be2 with SMTP id d75a77b69052e-4ed94a67750mr18772491cf.50.1762485594416;
        Thu, 06 Nov 2025 19:19:54 -0800 (PST)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5944a593af0sm1136865e87.96.2025.11.06.19.19.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 19:19:52 -0800 (PST)
Date: Fri, 7 Nov 2025 05:19:50 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@google.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
        Yangtao Li <tiny.windzz@gmail.com>, Chen-Yu Tsai <wens@kernel.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@tuxon.dev>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        Hans de Goede <hansg@kernel.org>,
        Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-arm-msm@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-tegra@vger.kernel.org
Subject: Re: [PATCH 12/13] soc: qcom: ubwc: Simplify with
 of_machine_get_match_data()
Message-ID: <zdnlmxrlagpmwcfnzka7zgmrxzya564cjbd56l22fazxxhqpjw@64zf3akyfp4h>
References: <20251106-b4-of-match-matchine-data-v1-0-d780ea1780c2@linaro.org>
 <20251106-b4-of-match-matchine-data-v1-12-d780ea1780c2@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251106-b4-of-match-matchine-data-v1-12-d780ea1780c2@linaro.org>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA3MDAyNCBTYWx0ZWRfX6bH9TtnJ1AnD
 fuyDAbqmFh2PXZdTevitR5HrLeJjwUVZ71t6tCmWLCt9xyz39bqzp0XfVXXAYoNxMuIbMxKORu7
 +wFlGwv5MGIhvGH/3XP3SpdnU2k1x4aV7hd87UtkAC7rxwFV0NjWs8pkeqjpMcFKV7LwmhzPugH
 cnOSHB/ryvJMcIJdtrdxQ4+s7jE/NvdW3rVeunZlVHA1LSOYBA5D1LtKRlzyH185D2QdBlbM9xY
 tqXZGmXVTBB5y/JVGxKn8+J5mn0rJMl8900QcSEuinGGeoM53emR+DegtuvwJxdbOVZ2wSsjR8r
 /Cpe6OQLC1FyfJ3SY5doS9vznVAduds4S3j7WI9j8zMI4EIBCmCFkkXJ9BRLBtAZUKBq4T3WVoY
 zapboAp+XlAFDoUWQryjHap3RJuNTg==
X-Authority-Analysis: v=2.4 cv=bIYb4f+Z c=1 sm=1 tr=0 ts=690d655b cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=228_68lKBFQWPJCgatoA:9 a=CjuIK1q_8ugA:10
 a=uxP6HrT_eTzRwkO_Te1X:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: vTjOjhye3MbpF196achFiagiH_LfNTfr
X-Proofpoint-GUID: vTjOjhye3MbpF196achFiagiH_LfNTfr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-06_05,2025-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 adultscore=0 impostorscore=0 lowpriorityscore=0
 phishscore=0 priorityscore=1501 spamscore=0 malwarescore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511070024

On Thu, Nov 06, 2025 at 08:07:19PM +0100, Krzysztof Kozlowski wrote:
> Replace open-coded getting root OF node, matching against it and getting
> the match data with new of_machine_get_match_data() helper.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> ---
> 
> Depends on the first OF patch.
> ---
>  drivers/soc/qcom/ubwc_config.c | 14 ++++----------
>  1 file changed, 4 insertions(+), 10 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry

