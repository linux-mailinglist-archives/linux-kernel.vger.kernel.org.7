Return-Path: <linux-kernel+bounces-798719-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 89871B421ED
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 15:37:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 73A25188844A
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 13:38:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 303D73093D8;
	Wed,  3 Sep 2025 13:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="LsmQHOXI"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B6B32F4A09
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 13:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756906652; cv=none; b=Tk45zPIdeAd8/6gx5ezZj+uuEhjue+7dyy2y1QsCiTHKPI0HWcBTOOI6SiUeESf36Mu9H53j3yhyXg7ZfM2BBKy/JrRJXqOPWI242kaT/8K5A33BtPef5kwbQrhKn79gnqBNzY15g8Y3nmljcqvLQ4sKfWvrXdvtXlt3Rnid9HA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756906652; c=relaxed/simple;
	bh=tacXb3I7sD82JjGMbS8Dqgx1hL17l0hk8fOJ6PMQcq4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jOdgYE/ycOGm0/Ozb6V35qdCKmX1lcuLdbc6lDyHfOIisrebdM3CPkgYEN7m5Rrnfmwsb8Jq5IIsl8umpBDguSmFuDmatm5f5DJlREtTTlkEJxVgcJmbo33BBwLIw+GKoky6LVzXiB77ZHT8gcpSjBGgLNkmNonhBv4vA1KRDvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=LsmQHOXI; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 583BExCu000809
	for <linux-kernel@vger.kernel.org>; Wed, 3 Sep 2025 13:37:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	G6WxjVs+4qB1wpptnxje/lLl2BWE/gnMjf/dmXAtLn4=; b=LsmQHOXIM/ofd/2i
	Gk9P9qYur8B8+LvatykrcBUBrN7ecmvdxnI4IekSsM26hRqjzhy0Q4lcw0+tH2XD
	D0PU7/PjIpqbMxMLzKkpC765oMelSfI3HaSgloqXsqrIyKinaOLLokmJdTPcMf5a
	Mfi3nl5T1UWSQQeyjQ+wTjpwGnIEYFwcg0YqaCkrNjGZseUL9enRcIWi1FubdYzY
	WY7iS4wDK+vvi9vkP4fmqzngE8oZDbgSc6mlCDJNA0ee4UAyr/Ju+GF01dZ0jd6Z
	Sl6Q5jJxYrn6RWgNABOffNV1vPKQA3BtkXIUt9Z6N5mWZjCBQeQwpTsNk+qIGdXx
	VlKBnw==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48ush33qk4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 13:37:29 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4b3387c826eso12459881cf.2
        for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 06:37:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756906648; x=1757511448;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=G6WxjVs+4qB1wpptnxje/lLl2BWE/gnMjf/dmXAtLn4=;
        b=Pq7+YlJ1TfQoVPYhhlz/xHQlKZ3nFDt8CSdE5pM67DJyJdy05ayp/0KWd9g/Y18Vh4
         FJizxGJmbsxwW03oV5ZC7w7WXuoA093cxxs0lfFlUIDGPUIrvooczqiRSwWoGzLFBv/L
         69/08vOiLH26VJiDHByzt2wvqqWmYKWKUGgRrPDW7GUh2h1aGQ4hhza9hKMZEGFizlpu
         4io+dsKhEX/NruNfX5Nq8BoalBc3EDzVOeXtK6zQGu84kBVMLhH4GIxXDFHwprAheLDx
         NRK4mybmHL9xlJe43ZIbIfpSp+QSMTgewcTuO+OusMCeuUlRhysGAez9Xt9n2KGUS9h3
         qeHA==
X-Forwarded-Encrypted: i=1; AJvYcCXLwuxagrWA7Un9Aq2bXRbD2aapy/uFfJ8aFmDrcQYGLjdWBXW0kN1TE6FOGfBj85f9O4Dgsy7uq9+e89g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz13/1uEglO0WIUrKGN3g+XKfeTVpI46gnXDwIZs4wp4Vdj4G1f
	e5TZUNrH9XY7CnR14E2CwKLGnYP2BjZ5iDx5bkb/W/DxeP2FP1k7crK2IsE5GPmAEd2R3dnKz0s
	VMfVR8gNGTbbXKYzQ52x1ks6Hx8rGxg08Ot7NcQLpDaBZvO4XCoChhg5GzQ93hC2NoLM=
X-Gm-Gg: ASbGncsbQiyoYQktsGCR8/kfldvqa+IpGD52Ql1dtbnirh91ogg5UYAGp8H5RDPke0q
	0+ikfmWijBTl25rh3x7nqWPAg7tP5SdQv65iuZ8A+kuBZFgkB86RxV6jlLQbrCyyGZYOgyCgSRz
	QGd8o6Xlap0uCi5stxZRssV5VzKjOBPFUwJVXjI5M/Fm2cE2MQBf+XrJbhd0HYmtw1AkLSukT9J
	TMAc1BM6K/jJPLotelRrdLBkdTcGxEYWZmqGx1rdxgxGILD5GN5inLZZ2mWezU68PiiGc28bq3G
	VPPH2xJGkwm+uM2iMVZ5fqZ1bzIljccgM2O9cz19gNmbJAOF9alSZzujk8/olholMPOsmlZF4sQ
	2qalnlPsOngKyul1yihCn9g==
X-Received: by 2002:a05:622a:5f0c:b0:4b4:9655:9343 with SMTP id d75a77b69052e-4b49655aba8mr8680541cf.3.1756906648252;
        Wed, 03 Sep 2025 06:37:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE9aESjDi7u3ikl+t7p2SljGJv1hsVA1MO3GfCrupQw910Ny+G82IIly/jBPP+7T98Yksz3kw==
X-Received: by 2002:a05:622a:5f0c:b0:4b4:9655:9343 with SMTP id d75a77b69052e-4b49655aba8mr8680251cf.3.1756906647585;
        Wed, 03 Sep 2025 06:37:27 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b0431832a98sm699384166b.80.2025.09.03.06.37.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Sep 2025 06:37:27 -0700 (PDT)
Message-ID: <11155d6c-cc11-4c5b-839b-2456e88fbb7f@oss.qualcomm.com>
Date: Wed, 3 Sep 2025 15:37:25 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] dt-bindings: phy: qcom-edp: Add missing clock for
 X Elite
To: Abel Vesa <abel.vesa@linaro.org>, Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Sibi Sankar <quic_sibis@quicinc.com>,
        Rajendra Nayak <quic_rjendra@quicinc.com>
Cc: Johan Hovold <johan@kernel.org>, Taniya Das <quic_tdas@quicinc.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
References: <20250903-phy-qcom-edp-add-missing-refclk-v2-0-d88c1b0cdc1b@linaro.org>
 <20250903-phy-qcom-edp-add-missing-refclk-v2-1-d88c1b0cdc1b@linaro.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250903-phy-qcom-edp-add-missing-refclk-v2-1-d88c1b0cdc1b@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAzMiBTYWx0ZWRfX1L+A0+ci4Qg1
 Sct5FH5FeeKCQBYkiIkpyiztbyxDF5qpP7fY+HsNU9SMql9irQHivRpA3ku6ggxUMl7vGe1zbLZ
 Cs8kemdkJ8a+/toSWqi4UPRr0AB5pB6xK2SWnOaHd27Cw/2+0Gu2AJc/jDeWyqztpA0hUetaq8E
 gxogACrHMk60+dSebi7UCQlSVJFQLTeGUZYuxwWjUNhC+LurCzk9MEvY5cArbOkEnZlduxGNqi9
 MVglNiCfri8u8R3RPv8XVK0mG8G9ZpkihVOnZ9dc0+Jmi/XSNigpX+VSvfM1Vh0m0pyWWKWavke
 yN/ovzACdlpLZnh4aRfbMLvc4Z8ZDVdaKJRzpDp3xN3lDbSde56yf2x6gxqZ8En4FsS0B+4i6Hm
 8HtHjWyD
X-Proofpoint-ORIG-GUID: WJnAVgbZqr-JBFzBY_mYFXlqJgILVvo2
X-Proofpoint-GUID: WJnAVgbZqr-JBFzBY_mYFXlqJgILVvo2
X-Authority-Analysis: v=2.4 cv=M9NNKzws c=1 sm=1 tr=0 ts=68b84499 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8
 a=D1QSBg5h22RYVcxFYwcA:9 a=QEXdDO2ut3YA:10 a=uxP6HrT_eTzRwkO_Te1X:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-03_07,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 spamscore=0 priorityscore=1501 malwarescore=0
 clxscore=1015 suspectscore=0 phishscore=0 bulkscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508300032

On 9/3/25 2:37 PM, Abel Vesa wrote:
> On X Elite platform, the eDP PHY uses one more clock called
> refclk. Add it to the schema.
> 
> Cc: stable@vger.kernel.org # v6.10
> Fixes: 5d5607861350 ("dt-bindings: phy: qcom-edp: Add X1E80100 PHY compatibles")
> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> ---
>  .../devicetree/bindings/phy/qcom,edp-phy.yaml      | 28 +++++++++++++++++++++-
>  1 file changed, 27 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/phy/qcom,edp-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,edp-phy.yaml
> index eb97181cbb9579893b4ee26a39c3559ad87b2fba..a8ba0aa9ff9d83f317bd897a7d564f7e13f6a1e2 100644
> --- a/Documentation/devicetree/bindings/phy/qcom,edp-phy.yaml
> +++ b/Documentation/devicetree/bindings/phy/qcom,edp-phy.yaml
> @@ -37,12 +37,15 @@ properties:
>        - description: PLL register block
>  
>    clocks:
> -    maxItems: 2
> +    minItems: 2
> +    maxItems: 3
>  
>    clock-names:
> +    minItems: 2
>      items:
>        - const: aux
>        - const: cfg_ahb
> +      - const: refclk

"ref"?

Konrad

