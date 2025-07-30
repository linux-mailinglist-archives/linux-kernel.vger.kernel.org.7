Return-Path: <linux-kernel+bounces-750690-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 317DAB15FE3
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 13:59:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 606DB188962C
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 11:59:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89D8F286430;
	Wed, 30 Jul 2025 11:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="crORyQp4"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DB0326FDB6
	for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 11:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753876745; cv=none; b=hdUFJqAeb03w/LpYIwMUKpQ0nZxKBSv4LyuWreHVmSXgZ4RUZFfU4/t8ApXZA6z8jR+A45dZhM/TwAe2R++qoIlvH3VDP/mLuXA7uul7pr/dNDSiFryiQy3FXzsmP98wp41d6IM8CDeAbNc3wjA5gTJjeGE6klTOVoIQ80SYV0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753876745; c=relaxed/simple;
	bh=HQDIFLaL7om6a5f7K5WAYN1xBKXB6S74doNDZJgGVJA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JBPaYvEjeSQwilHo5xKDrarhEyxIA4Q4zlUjj+QIGwQP3jxzEZ82q4f2b9odJq8meGpqi8PJ2xxKEWZLL0F+NsorWuvnq3cfbRJxE0kL0rXnIaR0SytxJk7FRKS7tNfGfb02CPqgoHW823kfZCCISNTwxXPKpmJ6WO9POJdAdxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=crORyQp4; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56UBqvoP007632
	for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 11:59:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Gk5vGXil7RKOKTWhaZMiJw3ByMsUyxc9oWInTblZhxs=; b=crORyQp4VZYYq5OJ
	vXVC7Wpf33iPtrORDiTeGescorvgBNvzaX4JO8AvZP8vQDXOCg/Ow3SnuduUbFNz
	5lDV1TGFjX5DcZ5nsVlQrUMDFdelzDcKVx67ta3K2GGceIKhf68wIH6yE5v7Jssl
	vhr5j5BcVHsX7UVDX0w2HFlTruIJOVRDdbXUq64BVvHHNliW41/NnqWfsvvzDHom
	rTUCBP2VIvo7Y5edUNpOZAKSZRS4mM8ICO7mr6sLV78K2xWxEl0gsz2xVIoeYN3R
	D8Q+xHdxpbPFgeoFoqx4iVrQwUtpQKOnAws3Cr5yn0m6Ray+fyJpKE5sGd0vwHS+
	doS0Eg==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 487jwer0jx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 11:59:03 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-707428e0cd2so3778806d6.3
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 04:59:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753876743; x=1754481543;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Gk5vGXil7RKOKTWhaZMiJw3ByMsUyxc9oWInTblZhxs=;
        b=oNXRnRddNSlY+TAvdz3XehYxI3QFRRyXfkUL3NfP1owRNx/bWbQjIWMNSZD9KqVbo7
         1GwLIRDbBwen+zP4mdKeUyURv/NqWviXs1leEWbnjZcrNvXUWBR3jeM8WBA8VMLfMqdX
         cNcjrpb84k1sy7n+mjuLvD/7idw+FsdZEuLdFwcbZNGE27pxXeMgWdwqsI1cejcQm6EB
         rF6xEBUGzh8ECF7jROxUud65xlZHPCEw+Xf1fyoIcwLdAIz70cggYVVK1DyjOWp8k6lk
         bQIVUzfLfPuMRxueAVmSVnXX3lfcQBCXd+VaXCV1arrPqJ1lpkjd30nP8AHfTTBQJXWz
         +dbA==
X-Forwarded-Encrypted: i=1; AJvYcCXUcXxun+z8pPNlQ2WuOYL8xNW6lomZJTzc/WTNLsza0B6/SO/B6h0aX9dWOXe0Nfxz3QCFm36JIjXVxJ4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYLm52F+26ihxd3nV41L2jwnLdg9YGrB+mskYiVNvW/twGGuYF
	6QazEzKt+wE8ZkF9b90b5N+b6v2xk1sGVnMNs4x++oZQpkBcJas8yBb+0zgVRPLWVe33oxqJs0h
	wk4IEawtzrVOTf026gkF0UqpUukCUK9mU5yj2HJRvM7ajsHafaNAVXc90GLyDzKyLszM=
X-Gm-Gg: ASbGncuDQb1I5efEbvKuSfSPcyRrU38VYZH4XWkrk9HPH5D/xCs7uja1sYX1+tu4txJ
	TjmW+FaEGdiQMaczQB1WQhsjUJGQ926H/exgdsmpvE4jYtV9wZi3X2t4c506kdSKpjNTRQVXc0C
	GI0LNz8Wh7oIFD/8MZKdRSeVHIiiKy5IBXYNyAHKWM63ZmIGMTpAvAP5BfUuvyvfLo+yXsl582S
	Pwm2X/504ieRS5G4npGDJcsfdE5QbR+R3LXzxSgbCXdJo1rBnlljujtifG7fXE+R+wgRRD3fspH
	kZzhRzGZXoJIHqI5goKspTi+gzZeZ9hI2m34dWHN00S1qsJ82KpNt3RELb28hDEFY6bGk934Hfu
	P3NtUB2ayWKnyZB0fGg==
X-Received: by 2002:a05:620a:2546:b0:7e6:39a2:3ebe with SMTP id af79cd13be357-7e66ef831b1mr218066185a.1.1753876742520;
        Wed, 30 Jul 2025 04:59:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEy3Ac2RJmbNiBhetSgsrV4zyrjPh4J4l/19B5GXz/9xAxchLE62srybp1Dcr/TAc04N6REnA==
X-Received: by 2002:a05:620a:2546:b0:7e6:39a2:3ebe with SMTP id af79cd13be357-7e66ef831b1mr218063685a.1.1753876742082;
        Wed, 30 Jul 2025 04:59:02 -0700 (PDT)
Received: from [192.168.43.16] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af635ad9cb9sm741180666b.123.2025.07.30.04.58.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Jul 2025 04:59:01 -0700 (PDT)
Message-ID: <e7952a9e-23db-45fc-9abf-0373fa26f2ee@oss.qualcomm.com>
Date: Wed, 30 Jul 2025 13:58:58 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] phy: qcom: edp: Add missing refclk for X1E80100
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
References: <20250730-phy-qcom-edp-add-missing-refclk-v1-0-6f78afeadbcf@linaro.org>
 <20250730-phy-qcom-edp-add-missing-refclk-v1-2-6f78afeadbcf@linaro.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250730-phy-qcom-edp-add-missing-refclk-v1-2-6f78afeadbcf@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: HVFImX3WcgaAwt7TLxhClZP0o2NG4gK1
X-Authority-Analysis: v=2.4 cv=Wv0rMcfv c=1 sm=1 tr=0 ts=688a0907 cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8
 a=C9jaBoPFOhspESL_4l8A:9 a=QEXdDO2ut3YA:10 a=1HOtulTD9v-eNWfpl4qZ:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: HVFImX3WcgaAwt7TLxhClZP0o2NG4gK1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzMwMDA4NSBTYWx0ZWRfX0RCsp4Qs0TC8
 apF2rF8jfvcXy8NVYPt4EMMOQueYj89EiWWpz01vEp8sCwUAzt+eLDtWhvn4pBAw3fWPW5ACV0N
 xg+kdL/H18F5yVk6fuBz5zN+R9YS8g1dzToog1seiOptAuGhfxwjXZzVRFvHGFoXfdkSLrlW1S6
 q6Hp0+kcVQbR3wxis/npeD73QpZZB7h2fV9YiQBJ+3H4eTnSRXWtuS/W3jiX2dYrj71euK6TTSN
 eDZ8tExmg4SyUMx4cfL4//zbPrI1GC9iCFfrh+ERbKIgN2EUfiaN7wERC4Br4SUKj552ogfJjSj
 N8G/OdkmGebjITdi64PwFTNvRtgINc/NM2CUvKfBzsTZj4HyICLGcciwosWTrY8NIN4oa8C/zuy
 OGRuDBJ0AZweESt5fKO6iVKuFAaQySSf7mpuXFFtnqMzP+m4NRuuyoNIBJ4/H02uyahrow9Q
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-30_04,2025-07-30_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 malwarescore=0 clxscore=1015
 lowpriorityscore=0 bulkscore=0 mlxscore=0 adultscore=0 impostorscore=0
 phishscore=0 mlxlogscore=763 suspectscore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507300085

On 7/30/25 1:46 PM, Abel Vesa wrote:
> On X Elite, the DP PHY needs another clock called refclk.
> Rework the match data to allow passing different number of clocks and
> add the refclk to the X1E80100 config data.
> 
> Cc: stable@vger.kernel.org # v6.10
> Fixes: db83c107dc29 ("phy: qcom: edp: Add v6 specific ops and X1E80100 platform support")
> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> ---

[...]

> +	edp->num_clks = edp->cfg->num_clks;
> +
> +	ret = devm_clk_bulk_get(dev, edp->num_clks, edp->clks);

Go with devm_clk_bulk_get_all() instead, no need to be so stringent

Konrad

