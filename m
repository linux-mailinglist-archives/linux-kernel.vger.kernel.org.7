Return-Path: <linux-kernel+bounces-749371-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 81DBAB14D7B
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 14:11:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 891C018A2E68
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 12:12:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8810329008E;
	Tue, 29 Jul 2025 12:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="AOR+HhHO"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB8B928FA83
	for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 12:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753791097; cv=none; b=flXhLIAVDRFobzUYsTrkqgKp5UMHpeOVvrcGXnSNvVN/XeV14/JJTuAhWHiw/2Ku2M4K3O1ornaO4FOvYymtQSVhRPpqq7f3E48rgNOTdNuJtwqBBWPye9ekQiIkBq1FIYgrbkyKsN8gq3HRggSEpYJwjPt180j2zJHUSwLrh6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753791097; c=relaxed/simple;
	bh=WtaahhtHI8wCSsflpowLiUT/PdVdKqZ4oKuS99Kip1g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Bl0tbIrI4RuXqbHbwuN0vgu14o9eXPO7rU1w2DRsVd88nncjEq9sXAuroL42BztK3ibXGyQb2cXnOBv/Hfb7AIXKfvNYoFQ+MjdjeETmgCtkdd94a1vFHIGDB6qUxMUCbujliMwKZGVkxt7rUHaPRnUvlkP+qf5RXk7kLwP5cB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=AOR+HhHO; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56T8Fqtr013440
	for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 12:11:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	4QE9lOzTrqBaaFrVLkONL9bTvaiKUb2/mfEEdEROAZE=; b=AOR+HhHONlZuDO79
	/zflcFlSc2qIq20MTQp0NwDDW1zBi9VnW+ePX2OsI8OPmmEiG99pXmngTl7iwxMc
	soBxgKAHjqc3mNHqC1SosL56HyGtRkBgVLbJv/or5QuN872SroZFk/mpyCa6vU43
	2Q2j4n0dNqE+jnz5kz3CH1iahtjW/YFKTO1v51h4LLA9bN5r/a2wQ3Qdvl10iocT
	7/wUtfPBPa8rs4jAstx/PGhuPL/lHIv4jylWPGvdV4kHnFpvn2/k67oZro2hCKnv
	QKCYVcQN4bYKvLNyUyQmwZuAzSm++XZ4OygYNtAaL7EWMyXDgaSALDWb6g2UhXDx
	5nrdiw==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 484q3xqyj3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 12:11:34 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-31ea430d543so2989599a91.3
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 05:11:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753791093; x=1754395893;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4QE9lOzTrqBaaFrVLkONL9bTvaiKUb2/mfEEdEROAZE=;
        b=oOyozMdPkjRMjmIkLRF935qufGi22XcjR5o0/AbDF3q9TMUbD79lbVfJ2CsX1ri5Dw
         6EN30f/sjZnKn0aQUABNX6r2HTyb6hql2TTEXjcUnk+H8ewh7+56KRSz1x4NTQazS982
         zbO7VU87ei37GXuqvEjtGTqoIOEZxkQr9YqlwWVDvA0empdW/yPT7I1Y4MB4st4dNUTC
         OSfcTHGykxYkmU3Pok4rjQlfr0yURQphVIDygIkZ1Ga11ifsPs8U2ZwUjWYvpXrMi99b
         0OMvStINGKyJwNeA+Y+z/yL5I9z1E/BceiiYedN8xL6jOdyjQA6wDHvqyK63wiGRqibI
         T6ig==
X-Forwarded-Encrypted: i=1; AJvYcCXObkKBHjC1PsEQrfClfIasFbAUWOVrV49+CT6vMeCVR3tL00uN+iDUJ+YoQiTIN3fj+YfLuV9yz2Y6Q00=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPf8DPzTCN5ZVMByhN4odU05ekqCJXPG8kri9SdPy7NIwElccW
	Nw5pBWf/ex3BwJm4aCdAbLC3jOpmy7KFqyTbRn2FzTFuPaHZUfIAquAY6+29VOvWEG5Fu6/P20y
	rZfB6XvS38mfSLnxLIn7unT1XDM7XWKFQNyrcSnTMsTEHXLO6taFpcO8+tOYBwGecUMQ=
X-Gm-Gg: ASbGncu4yMZ9wB3NqZnJ1TordVxUkf9l4K8XFOPr4E/xfBrkdw4WQp4a18+Gck86B53
	g1IHv7XFyp4ygmwzvk1lN1Q1EHaLGRyBbO7ED+8LVaPDXAyX1jd3P2PJBHnOw8kOMfYxKceyTS2
	lZwnfezJ0UHL6sxdKkKENmhtGkOM6TacrBI9NXY0HHKkwA2u6P7CS0+eJLdY3mvJ823zrroO4L2
	+sjU1EsGQ1W5lDeZylUTXITboPphjhcY4VX5WsDhAT3QAnyql0MNHdmhesdrvs4Kv1DOvLkEeoO
	zvgQvmzGrI1k1Gv5NDJKTcUbHgWqMLBjTkIsrdMj1jBYvSx1n41TnJPrNaR5nnrW4hxxMnwR
X-Received: by 2002:a17:90b:1809:b0:31f:42e8:a899 with SMTP id 98e67ed59e1d1-31f42e8ab21mr1328756a91.13.1753791092866;
        Tue, 29 Jul 2025 05:11:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFsgLFy8b++ep6TqapChmczzcUReCy8+FTDkc9tnmCqFhUILVLHVWY3NjRVOTnzXnPonH4Baw==
X-Received: by 2002:a17:90b:1809:b0:31f:42e8:a899 with SMTP id 98e67ed59e1d1-31f42e8ab21mr1328707a91.13.1753791092318;
        Tue, 29 Jul 2025 05:11:32 -0700 (PDT)
Received: from [192.168.1.4] ([122.183.154.151])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31f5262aa05sm69491a91.32.2025.07.29.05.11.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Jul 2025 05:11:32 -0700 (PDT)
Message-ID: <8b7bc371-576b-4a4a-88a4-a4ed47d97778@oss.qualcomm.com>
Date: Tue, 29 Jul 2025 17:41:26 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 2/2] arm64: dts: qcom: add initial support for Samsung
 Galaxy S22
To: Violet <violet@atl.tools>, Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        Bjorn Andersson <andersson@kernel.org>, linux-kernel@vger.kernel.org,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
References: <20250729120331.287245-1-violet@atl.tools>
 <20250729120331.287245-3-violet@atl.tools>
Content-Language: en-US
From: Krishna Kurapati <krishna.kurapati@oss.qualcomm.com>
In-Reply-To: <20250729120331.287245-3-violet@atl.tools>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=JovxrN4C c=1 sm=1 tr=0 ts=6888ba76 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=A1H60L6fWQAu95VAuYzdKw==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=KKAkSRfTAAAA:8 a=ZSXNc6tYleypp-tdgiEA:9 a=QEXdDO2ut3YA:10
 a=rl5im9kqc5Lf4LNbBjHf:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: MtZ5N9DD67dWiVYXoRPXl0bLFNSv3SKX
X-Proofpoint-GUID: MtZ5N9DD67dWiVYXoRPXl0bLFNSv3SKX
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI5MDA5NCBTYWx0ZWRfX+l/8LvKCUNg2
 1YcQ/6OqoMtQ0q5L94HyBcmWgwERgc6rgiGslJufjQJdb+2hyRG7c1tANmt29CLPVQFdU9Euaat
 FrUdyHgTZ6hEf/UfXJ/JJAAysjpqPp70CxIrrU9RYNdyNWaMcXFMZnPYz57pNoQ4kYksaZOT4PA
 KPd6F48GmqAQ8wL3GDeyjCxX1D4WwPv3LgFHP4WYsFQJ7cbATariV+rYT2S5/eWnPTV0BAIji40
 5CUVBoava3da3Gg3ds60H4/KMogqHbhgm81Ki1jAhlGnZmsOgKwLbf0/fXkiA7ObkSuIbul3Kds
 5gqJRd0AK8fRue4ERwfc8Byj3/hzkaEdqDdW54lMOinG+xWw6tXRRpl9lHpZ3ELAcTY6nDcruJx
 gkdwPg0DaM/lABq0z2Hpv4hw0MFRZWloCe3ydt0vl5G6pMk4bex+38RBkb7dcAoMraR4vzXa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-29_03,2025-07-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 priorityscore=1501 bulkscore=0 impostorscore=0
 lowpriorityscore=0 phishscore=0 suspectscore=0 spamscore=0 mlxlogscore=999
 mlxscore=0 adultscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507290094



On 7/29/2025 5:33 PM, Violet wrote:
> Add new device support for the Samsung Galaxy S22 (SM-S901E) phone
> 
> What works:
> - SimpleFB
> - USB
> 
> Signed-off-by: Violet <violet@atl.tools>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>   arch/arm64/boot/dts/qcom/Makefile             |   1 +
>   .../boot/dts/qcom/sm8450-samsung-r0q.dts      | 147 ++++++++++++++++++
>   2 files changed, 148 insertions(+)
>   create mode 100644 arch/arm64/boot/dts/qcom/sm8450-samsung-r0q.dts
> 

[...]

> +
> +&tlmm {
> +	gpio-reserved-ranges = <36 4>; /* SPI (not linked to anything) */
> +};
> +
> +&usb_1 {
> +	/* Keep USB 2.0 only for now */
> +	qcom,select-utmi-as-pipe-clk;
> +
> +	status = "okay";
> +}; > +
> +&usb_1_dwc3 {
> +	dr_mode = "peripheral";
> +	maximum-speed = "high-speed";
> +	/* Remove USB3 phy */
> +	phys = <&usb_1_hsphy>;
> +	phy-names = "usb2-phy";
> +};
> +

Hi Violet,

  The usb node has been flattened recently. Its not merged yet, but it 
was acked: [1]. Can you rebase your changes on top of this patch [1].

[1]: 
https://lore.kernel.org/all/20250715052739.3831549-3-krishna.kurapati@oss.qualcomm.com/

Regards,
Krishna,

> +&usb_1_hsphy {
> +	vdda-pll-supply = <&vreg_l5b_0p88>;
> +	vdda18-supply = <&vreg_l1c_1p8>;
> +	vdda33-supply = <&vreg_l2b_3p07>;
> +
> +	status = "okay";
> +};

