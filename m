Return-Path: <linux-kernel+bounces-763829-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DA22FB21AC2
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 04:26:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 626C33BFE48
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 02:26:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D81F2E264F;
	Tue, 12 Aug 2025 02:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Z4ztfkZA"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2B8720C478
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 02:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754965589; cv=none; b=sUKo2SAJSL+a7RpW18K6FjmmI4iwA04VtzzBhxqPeSoEpE5frKBdjD4Y+leb5eJOZMocu1fIEMhYAQrAEtYZZksxskAEmTW++MqH8NcYkGdHEcWuUsm/Jujl2xijRo8D3i7tUzyr+zfv5QJDV2DjJiQRfHgXwOrXR/bq6JqnzEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754965589; c=relaxed/simple;
	bh=freSFYAyQhQP65BjSPgNAU1SLsQMJO6+8Abgq9wkJWs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=P66n2jk6nw27ynE2oGnHMDbeNjzP7gaGWF2wbS/foI5KHc4vv6qhqpApgeMcQ8mb6/Z5zWXhtb4dbkVZ5LrqyIjVLwM1kjyXfU5mPv7Su11bNpemRKdAEFo9PvHQ9z9e2e0Qm4Ity7InTYqnEXO2y4Lef0RSBIH2d6JguDhieQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Z4ztfkZA; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57BGUpSg029350
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 02:26:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	v6NZdONIBjUtWUi4FSVYPVlblg2FpLBgu7iKrRrbobY=; b=Z4ztfkZA0KfnIxOP
	5f02Q+PlHG83WBln1hPZdOBZcfOPrmti5fIQirMyYHoeFVCTXVroawGotLsn8tbP
	vq07WSytrZ0OhanIs9y45pf21J/AL7L8yynd7g16+I/V32COlA9F6XVeJIzBzGld
	NyKrsWchDjM2tm3S+r34VWgeE5bU2M1+G68mCotoSbu0E7ph1gx86LKe+VCeD5mR
	/s+9/RXw8uatqNaqL5vcRPCwz30qH2D08oLMYPL8OFuMYqf5VKCQa9rfYXVxGs8g
	OtrrZ1eI72BCgKITuw/J3zZcAoIWRa2vsU9GNBPtaJ+T6dG4jGphowuzPJX+BFYG
	VvH8+w==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48dygmeekt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 02:26:26 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2407248a180so42144615ad.3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 19:26:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754965585; x=1755570385;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=v6NZdONIBjUtWUi4FSVYPVlblg2FpLBgu7iKrRrbobY=;
        b=wQQ8sr7Wt9OMiVPJBwyQPVFEQKq5iJkdxF7duPJsRN59f/qcO7Kq0XQAVbaf16zEw8
         B0CHO+G/cfrDgAu1npuxTwNZMvkSnI7axaxjr/jyIFVH7LZtJb0trK3GIBJYSw1W0J98
         N/Vs1wqbP+L0D9uZh/Irf9Zf0+o17USDHR/HtLeJTSvoaWTLK/l1+JnnmhaPZvJTHcj2
         gwfSswRuncU1+WfhTPaaJLzABS2EdWZPCyth9M4owyPlEkk+57oLlx6iHTENrw3Y4pu+
         QYAhK3yxWfWAsuK63bS8ydNY7oaDhU0ykJYLbUJo7ftSb4OlKRgUVMvtwRoGudalo/0a
         lyQA==
X-Forwarded-Encrypted: i=1; AJvYcCXQpwkGlEtTAFHyiH4L1Tw800EfX5ILQgViwgbHJWhBBlRIkOziYLpGNWlRfgKcY8dpvV3ZWMDleNvEhnE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwqZKQRSfFUnkzt0eTZsuY4I0TNcnsJAnA7UJGzsp0i4IRmuPK4
	03pETCW6z96svhj2lpNDvmBdDcTJaVuhBcJj/ut+ycKCDJ9jzVm/uf+KcMdeyc0BIDcIx0DZ9Bx
	/3XT9DKmXKDJK/vK30NbSPR6Kw6ot0fyNqy7I2XNsaLM1ym0GjIfMax4E7KLNIS9OCy/wi/sRra
	Y=
X-Gm-Gg: ASbGncuhIQ5lZ68+zvfOE92fpv3k5kj/AideM9GAdKUjz6OmoJwtCr03YOjcbX9GmRA
	s2mEM9wxLZOOPlu9Flu28bHADfZHfZ5CIAGhUk8JJVgWj+CXXJtiQ8E8SsH3aeF9zd8xYYV9dG3
	R/BJ9qyWZo4h+3VUraiOsx9t8SMO6uTLdZ/uIkwcag0a+9AEeZN/qiNlTH2dyulJzaG9EtNf7TN
	NmKJrDhGZJcZw2jv6lrZSPBgRtnuwzJ7TcOT51D5tW/fe82+8L+692OVdwGccwE978Zt8kJniwD
	IkuLyasEt4VoIpuSuqMkzWKieX1dWhh4DtY/u4J76BjvAcThE9UfOKeYDI2U2DxlAjY1j8F9PRJ
	kVSlbbNuPNQizWXEtNVcrpMjdXg4=
X-Received: by 2002:a17:903:2f4d:b0:240:5549:708e with SMTP id d9443c01a7336-242fc38a7f6mr26832155ad.46.1754965585519;
        Mon, 11 Aug 2025 19:26:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IElziGa4LESU7UIAUuAFSLtbgMN9kJ0x1ajc/uQvKZUBNmNNZOq+BaTzJnzKqAKLhkZVEnJ2g==
X-Received: by 2002:a17:903:2f4d:b0:240:5549:708e with SMTP id d9443c01a7336-242fc38a7f6mr26831935ad.46.1754965585083;
        Mon, 11 Aug 2025 19:26:25 -0700 (PDT)
Received: from [10.133.33.53] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241e8977896sm285070595ad.79.2025.08.11.19.26.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Aug 2025 19:26:24 -0700 (PDT)
Message-ID: <60f56455-69cc-4b95-b967-ebeae2d766a0@oss.qualcomm.com>
Date: Tue, 12 Aug 2025 10:26:16 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/4] Initial support for Qualcomm Hamoa IOT EVK board
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Yingying Tang <quic_yintang@quicinc.com>,
        Shuai Zhang <quic_shuaz@quicinc.com>,
        Yongxing Mou <quic_yongmou@quicinc.com>
References: <20250804-hamoa_initial-v4-0-19edbb28677b@oss.qualcomm.com>
Content-Language: en-US
From: Yijie Yang <yijie.yang@oss.qualcomm.com>
In-Reply-To: <20250804-hamoa_initial-v4-0-19edbb28677b@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA5MDAzNSBTYWx0ZWRfX8gOofTSj3YFW
 39g34gp19C3/eNZn8VtvYrkcI4kQlTsRpgq2bdskKR3TJAAWGLa1oT1nS7QCfp8ElIYUl2htSfU
 4VQpnQPzEVYc5Gg1kgRM3XkUDnz5ED4t7a5mO5uEKy2R1NEhur5qKqNVnr2iPeFmvir78jC7psG
 VYraor6TazXjKk3dG9cgC4z09kCDf/nAOQ9kYKND8ntORDtUlY71RcL2C90P+8SdhcEuHQA+YKm
 H1oGBgGQoOkJ28iIxjBEXwhvvZMbd9hcsi3XlU6hY1hWwtqFIiHgKLmnFpvQo5mxUZgPjS88UvH
 s91RXuOb/9xUTYTq9ZluGEXQoZH2wDIybifJX7bbz6UoYqkvmMmZ2nUFF8PhjWBYlNo+FO1W+NM
 qrENw5T8
X-Authority-Analysis: v=2.4 cv=FvMF/3rq c=1 sm=1 tr=0 ts=689aa652 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=zFMGl55XLE5SN6d51FUA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-GUID: 7BxgB3aV1fuSCvzM6hz8q79bP4Yvbm23
X-Proofpoint-ORIG-GUID: 7BxgB3aV1fuSCvzM6hz8q79bP4Yvbm23
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-12_01,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 bulkscore=0 suspectscore=0 phishscore=0
 clxscore=1015 impostorscore=0 spamscore=0 adultscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508090035



On 2025-08-04 09:37, Yijie Yang wrote:
> Introduce the device tree, DT bindings, and driver modifications required
> to bring up the HAMOA-IOT-EVK evaluation board—based on the X1E80100 SoC—to
> a UART shell.
> This patch set focuses on two key hardware components: the HAMOA-IOT-SOM
> and the HAMOA-IOT-EVK carrier board.
> The HAMOA-IOT-SOM is a compact System on Module that integrates the SoC,
> GPIOs, and PMICs. It is designed to be modular and can be paired with
> various carrier boards to support different use cases.
> The HAMOA-IOT-EVK is one such carrier board, designed for IoT scenarios.
> It provides essential peripherals such as UART, on-board PMICs, and
> USB-related components.
> Together, these components form a flexible and scalable platform, and this
> patch set enables their initial bring-up through proper device tree
> configuration and driver support.
> 
[...]

Hi Maintainers,

I’d like to check whether I should rebase my patch set onto the latest 
kernel base and submit a new version, or if it’s better to leave the 
current version as-is and wait for further review.

Please let me know what you prefer.

-- 
Best Regards,
Yijie


