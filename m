Return-Path: <linux-kernel+bounces-844253-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C7A2BC1620
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 14:39:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 769894F5A67
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 12:39:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD62B2DF71E;
	Tue,  7 Oct 2025 12:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="deNIUuG6"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 651142D97B8
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 12:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759840771; cv=none; b=d9RKKa1siM7h9yAGXPWBbAgPvljYRwkqbQgzYDPvyGBzZGDG/nm2FEmqJIYV3cntMjMaVl9ZZohBYkrqz0rCTBE2KVeOsxxrZlIrJJmRzQQHRZ9SKN5NXp1y6J5QlSekXYAWXTy1658GyJ8r+zJasXfLkHAzqhpk/t+lrJjRVMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759840771; c=relaxed/simple;
	bh=UPnFCkbAAqYodYYvidAkc2Mw5hSlfS7wopk3IkQjvIY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HyYu8elLRKUFopH3O5Ig+degtprXVQEQBT3hw4m0LFUVBRPG9/N9BGyyETJex+Uk4F1xStJXcdpt22ayranshVC+SokaRPQ6W9je9PijqoaCLmaBnjhnqOyOSizXWMYiRm2BbPUiGtFxPbmoVQ4YE+SzNjxsm0G8j5YmegW+1/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=deNIUuG6; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5974LptX000498
	for <linux-kernel@vger.kernel.org>; Tue, 7 Oct 2025 12:39:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ZrWyGE3gs9+GLL34onELkx++qF0tEM4y9SytX+wbbUM=; b=deNIUuG6MAaSiEih
	79Yj7xhMjsEva8COdIUzR3DRV2L/fgm7E3AiEFExXhnGZnQPmEcGj49XqoXHYeD0
	OSIqf6rMzFTdQwNpTW6lGZ7l6Ek7CZmVSf3EYzlHiL//MGbxZtvIzMSXW4+rmoQU
	oQLJUGvR1rxirkbUCyiOzPwja6p0qrH+3QmC6SDp+Rt2qAD0jDdgM3boVpYQUHba
	IN28eXrStO8O3aS9brbJXluFZ2OnuRBJrcGZOsT7pcKmt4XFu/a2atwa0Hcf0TTm
	ONbLovEQumn7FZ0oJEil0lIZxe1i61Y6yJ6tJbceuf0D/IlIaGGNKKuVIfASHsHN
	N1+4xw==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49jvrhq0xk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 07 Oct 2025 12:39:27 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4ddf2a2d95fso21832841cf.3
        for <linux-kernel@vger.kernel.org>; Tue, 07 Oct 2025 05:39:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759840766; x=1760445566;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZrWyGE3gs9+GLL34onELkx++qF0tEM4y9SytX+wbbUM=;
        b=sFMS+Be8rzzYsXAHsHOJ8NY2ie0xPv4pbmAhWM3GyPYUmIFqiNj3Kkd5FqKUEGXX7d
         hZ57O91FMb8kLf0STC8eKtkxbkGt2xU//0PUvy9dvcR0xNyIBqxbrO7+O04a3UsCUR2P
         XIRYfNgyert69pW9cUq5av1Hc62gebrwiN0VX/W0/LcIV+EvG9MlNGE2HoUJDMVsZmyI
         FKT8PqouugnFff+0J7o3yPiZksKiBku2EBsTJ3iFFOaIOqF1LqEUVuD4ESOcLUnuh174
         cHxvABBDjWWc7qH08wn9lsFbEki6h48zimn236pog6IU21aoHKS3kGRsSdKmloh9LZgz
         k2DA==
X-Forwarded-Encrypted: i=1; AJvYcCUM0YNIs2AN90e2UYymLn/3IaRNWDpQEe2+10Aa9HLcP56drrK5Z7zba65hPtyHOlWpWhNjSGPhrykb41Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHzaIoxJMnK1MUFdRv8ZHC1NjjMR/6sDbw4aeOCU4ZYWP6n0PT
	YznhN86ryjABKzISZdmcCM+0oU98T+VCZUthYM91hd3kH2SsNWeJruP+elnFXF8FzEo9H/qWNgt
	PqK5Y0RmQ4cf+eWTvsQFnJsu5lf2fxNb030U+dA+gBYYYP7Qkxb97ZAvFjJvbcu51zBE=
X-Gm-Gg: ASbGncuLHlM4EoOKlRQ0caSuwM0Up25ck/yF0EGsIEOZUKvh0zudNwC33QhPmnHNn4P
	6kCx9HH/XAENYQZQ9BFhV+lWfJi0uofgtBr0sGS0pk+hJp5d7DhPMB/w8s9ehMmGLw3ANiu8Zga
	g2LW5k8f5NpttibN+qrNO6lvzT8nUt7MrztYmxjrQVrElscnEmf3ouy/fw9rousSr9H4VT28RxU
	j7nO6hkOhQ09NM5UQrkQVzIwjeW9RTjh92lovyVjeQR8OtsbjOM82WT7xHAewBEOwxrgsmSNx5p
	KZ0X4uvt9MyrNAI+8DBf9wuXHdG7abh+mEkkCXnT5tzFcq0Ra6qRnw8tF5U7Xia25Snm0A3+kA2
	xf1vGbTWI4c5jTxRmzVhVktF1Vq8=
X-Received: by 2002:ac8:5a96:0:b0:4d2:c24f:8495 with SMTP id d75a77b69052e-4e576ab6f37mr145453691cf.10.1759840766101;
        Tue, 07 Oct 2025 05:39:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFBOfqIkALCYby5/GHjIjhxo1RktcdDyNxe0vMnZPbSP14BURV+Jd5BfDc/NgetMniX/+yEhQ==
X-Received: by 2002:ac8:5a96:0:b0:4d2:c24f:8495 with SMTP id d75a77b69052e-4e576ab6f37mr145453201cf.10.1759840765488;
        Tue, 07 Oct 2025 05:39:25 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b486970b2basm1386434866b.51.2025.10.07.05.39.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Oct 2025 05:39:24 -0700 (PDT)
Message-ID: <b6223af9-2d9e-4ccd-b297-79f63167242b@oss.qualcomm.com>
Date: Tue, 7 Oct 2025 14:39:21 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/4] arm64: dts: qcom: qcm2290: add LPASS LPI pin
 controller
To: Alexey Klimov <alexey.klimov@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Srinivas Kandagatla <srini@kernel.org>
Cc: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-sound@vger.kernel.org
References: <20251007-rb1_hdmi_audio-v2-0-821b6a705e4c@linaro.org>
 <20251007-rb1_hdmi_audio-v2-3-821b6a705e4c@linaro.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20251007-rb1_hdmi_audio-v2-3-821b6a705e4c@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA0MDAzNiBTYWx0ZWRfX3fXmidC1Bq6p
 cGDEyQkqGEFCcVEJ+7rNVcvONZXwbuZpICeEKSkIwN5ONfeFTHv8s0Y1tQCx0tVFElTG69LH+4V
 gh9rwEkbx73CGaq+NNeGZsdtGIqJ2bKWWW9TZ1VfYzddG+SGGdIJu/RP6Va/MPIU/0cFmCpN0C4
 53zUnRqBF6gvORAaxvtnt1e01njL7K0LRNdtHCmq6fhmAd+qLV24+v1OOmagR5HDF2fJNXa1qOl
 5LtGTqVhQ0K/RQ42LBGNpUKWws1ZApqWml6Yy2i7ftBvXq8FWkasN6t1HPIQeYE5u5htKMX/gaC
 I+8juUJALvYzhViT7Qqs1/ahXCWuP1Oksy52tp3y4X3s6dHggLo+4Kw/UqkM+sczMbdf0kMoUXp
 ACXTc2K2g6/9yhbPH6e7gO1Zsa+NgQ==
X-Proofpoint-GUID: yNdXa6Yfuol1dUtu4SP2sba31Y7LOutg
X-Authority-Analysis: v=2.4 cv=XIQ9iAhE c=1 sm=1 tr=0 ts=68e509ff cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8
 a=83KosTCz9JabPjGXDAIA:9 a=QEXdDO2ut3YA:10 a=5XHQ0vS7sDUA:10
 a=kacYvNCVWA4VmyqE58fU:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: yNdXa6Yfuol1dUtu4SP2sba31Y7LOutg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-07_01,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 suspectscore=0 lowpriorityscore=0 impostorscore=0 phishscore=0
 clxscore=1015 adultscore=0 spamscore=0 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2510040036

On 10/7/25 4:03 AM, Alexey Klimov wrote:
> Add the Low Power Audio SubSystem Low Power Island (LPASS LPI) pin
> controller device node required for audio subsystem on Qualcomm
> QRB2210 RB1. QRB2210 is based on qcm2290 which is based on sm6115.
> 
> While at this, also add description of lpi_i2s2 pins (active state)
> required for audio playback via HDMI/I2S.
> 
> Cc: Srinivas Kandagatla <srini@kernel.org>
> Signed-off-by: Alexey Klimov <alexey.klimov@linaro.org>
> ---

[...]

> +			lpi_i2s2_active: lpi-i2s2-active-state {
> +				data-pins {
> +					pins = "gpio12";
> +					function = "i2s2_data";
> +					bias-disable;
> +					drive-strength = <8>;
> +					output-high;

I.. doubt output-high is what you want?

> +				};
> +
> +				sck-pins {
> +					pins = "gpio10";
> +					function = "i2s2_clk";
> +					bias-disable;
> +					drive-strength = <8>;
> +					output-high;
> +				};
> +
> +				ws-pins {
> +					pins = "gpio11";

Please re-sort pin entries by the gpio index

https://docs.kernel.org/devicetree/bindings/dts-coding-style.html#order-of-nodes

Konrad

