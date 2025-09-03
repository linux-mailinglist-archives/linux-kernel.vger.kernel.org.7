Return-Path: <linux-kernel+bounces-798396-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EE7BB41D45
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 13:45:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D2E51BA3BEC
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 11:45:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 848FF2FB984;
	Wed,  3 Sep 2025 11:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="XG/cnvoE"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63F811A314B
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 11:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756899906; cv=none; b=Ny0Q0yREPXcqNX6absmpKFqXGxyeGTZlEr41RRK4xhg4tjbhX+U618AUCTa6874KB0ha13Y0K7jEMqt5srU0Ase3NHZZJr6ZAfuDhq471iOsFEZd6tftDbD3LE84/zYb7ZfXdwHhOoIhWEuOg9wqLs7d1JPVLHLIe4bv3vgQKQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756899906; c=relaxed/simple;
	bh=ZFslkzkzaO3P6RbCdZ+X+S96dhqu96FyFhmeWdrTj9s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ltkfh/Fm8Qf7eL65lZp40r6aMD4GiKN/2sWkKQinH0H9XHWGNmHrtV291WQvqqkw4lOVkKL0onR8uFjRvf/2T+Ywvv8T2+gJwjjJ1fCRt3RBQq8bF1xznd1ycXP8ckbDPHmpMvjgQZ7uN7uRxNKEguZ9m8LKX10R7MbQaMgXeUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=XG/cnvoE; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 583BEuo1004899
	for <linux-kernel@vger.kernel.org>; Wed, 3 Sep 2025 11:45:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	8Jvu4Jo+Bcxn48m/sFZ4fPyHv1yzkWG77RqatHLjJQY=; b=XG/cnvoEHIXbnjYz
	At85xcBTmQvHSJkXbLBmeazu3gEoWD29R/XJ5+ljMYfrRhnA50NVc3afFEiRyB1F
	gjQw19lxa0+DtHiQGeVdB3J+poF+v4gRR5gfnyIg9I83ht8cP1htZHVIf2xvaqbq
	0KY3dorzCg+5rLhsf7AVbREdpQCu7QHu5GTVjfqrqOnhl927m2jxn0CJYlbmRJfs
	0k+YKJoM7ymZOspOE8BeRwqrHGLS9P5yW3GOpVB16BsatTvOMCga1SfQ8Sagmuzl
	3XHmXMAKhj54DJYp1rFZpZCzfyimbKeypOKi1aEwjLoiToBS9NOD/Ea1FFYVUkmM
	qA4bXw==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48ur8s3jhw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 11:45:04 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4b32dfb5c6fso15447901cf.1
        for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 04:45:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756899903; x=1757504703;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8Jvu4Jo+Bcxn48m/sFZ4fPyHv1yzkWG77RqatHLjJQY=;
        b=g+Q4tOswknCvGIizOu4+ELxQ2SOVoUEqc/kyXvECKeUx7VUchYbg7U8Y6D3yEDzrms
         6QytRSRCqt4w6ztpPCw4r72zmyP+GrkZEJy7Xj/PrRjCtn7BuQDA7okvRaJRRorcA1z3
         UGwjkhub3dnLxTpG8SpoNiXGQes8V6bD8kIuAA+4F1qyKR0abss+w1LRhA2++6VUjsbT
         k2FNTWmEKktAkhhzytnrdPQ/VWM3Xb5x/8UPzbWzXBNkmi+sV96vEwOC6apRTr/H/Yk2
         S0PX51NY/f/V4GN6poeuv4NGJawCndX2PwSS7pjvimWkS/GMgMbD5v82vQqKqGQRoAEN
         888w==
X-Forwarded-Encrypted: i=1; AJvYcCVFKfdn6LkdqkoaJh2aHM7DnWn+nJz3mQN6brdrBeS1Pyhsu7HhtMghxilLdLiKaornjooV6ANEgLjvnRY=@vger.kernel.org
X-Gm-Message-State: AOJu0YykQOxMLsru2HeKjrkwAzLVXdzfXUHn+YdJEEeHHBvJqoMgGt6k
	E9vNUneWTm3DxUmh3tlTniav/w6SRNhyl3lmgHkqG9Kj0CfofxI5CXfrjDpAXOVZ0yP6z9PXjSY
	FUiw9+rHzlXcNJsb1Wi2X7MMMw9QV4f3JwbaYD2/0Om4bfvQb08QRl5EULjaVnpEaXFM=
X-Gm-Gg: ASbGncustJm2sU6SkX2KRClUDEZhr2+3/4KT9IAebbkhJvTfEpZBu03ENPKEbmb55uk
	LX2SRF+9UWUie8TngkOtJv5JSdrDhQtylkQi9dHRN+CldjSI+QFU1jsXBCxEcizJikyxEqeYpVQ
	wpgJYWp/1Syn7/tVAc7iFcxe43GGxv673T/269X5fVKStVcY6g9oHDS7M4Df9QI0bma/OZDDBBn
	WmjjbBlfYeUVxnFBNkBh0XUjMjW9iXJkzWioVjQPEFCCzP0ZndMWY0DV/gNrfjbm18CmtsmYbXN
	QfYSfqFd8sTArin55jnKa8+HMdfXqKriUP7EvyZJ/7re7VVtZSUVfepe2QV8OJRanrxZ3lLMnML
	rT0i964TGlxEJlSLzSw2s3Q==
X-Received: by 2002:a05:622a:15d4:b0:4b2:d8e5:b6e3 with SMTP id d75a77b69052e-4b313dfd74dmr142095801cf.1.1756899903009;
        Wed, 03 Sep 2025 04:45:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGIcR47zNDXHKfbpE1KNZpjx/ssXLf8dHQ7yihm/3EKuTDfb+SvfOKxZop6+eyhWbcM3uGoFw==
X-Received: by 2002:a05:622a:15d4:b0:4b2:d8e5:b6e3 with SMTP id d75a77b69052e-4b313dfd74dmr142095421cf.1.1756899902272;
        Wed, 03 Sep 2025 04:45:02 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b0432937e0esm701176566b.3.2025.09.03.04.45.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Sep 2025 04:45:01 -0700 (PDT)
Message-ID: <b3455529-1356-43f4-9d5c-ba6ddc52a250@oss.qualcomm.com>
Date: Wed, 3 Sep 2025 13:44:59 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/3] pinctrl: qcom: Add SDM660 LPASS LPI TLMM
To: setotau@yandex.ru, Bjorn Andersson <andersson@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        Richard Acayan <mailingradian@gmail.com>
References: <20250828-sdm660-lpass-lpi-v4-0-af4afdd52965@yandex.ru>
 <20250828-sdm660-lpass-lpi-v4-3-af4afdd52965@yandex.ru>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250828-sdm660-lpass-lpi-v4-3-af4afdd52965@yandex.ru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAxOSBTYWx0ZWRfX8/6uFDZgP/PN
 SKSSFFEdr4zQSiEnpxCKXo/gzDF1vk+7jDi59wL5vpP5BWFAc+uz5TBecRIdSB0+mWDLaa5xmdZ
 lITmVBfcGVJRjELldD+udLF9mZNE/FsOvoZJ0zPDSmPAr3Key2vFUegz34DQ8hWQUmtZYJaePhx
 5Gaij+0TfaWZrf41hQ8FQwWhADWUoX0IuDcW6js2Vez7iTarwx+HfbJtMJL9o1SQdZ5K0J07mV+
 Pmn7MzTJCXhIg2nG+2ywiikGJtnwGbQDHyTzNKu1maUhBia7xXsRf7i3TSpgP+JwRHvub1OQHJx
 y4KMJKyK7NxlHIZrqyVyWTqF4HZFQeIHj337EAIQATVZyiXxU4/I254d8Q3xdAVRn/8r4L4zz6d
 yRwIxT0q
X-Proofpoint-GUID: qWr4cuanAR8gqJZoLXnCot0l9YPN7EoE
X-Proofpoint-ORIG-GUID: qWr4cuanAR8gqJZoLXnCot0l9YPN7EoE
X-Authority-Analysis: v=2.4 cv=PNkP+eqC c=1 sm=1 tr=0 ts=68b82a40 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=qC_FGOx9AAAA:8 a=pGLkceISAAAA:8
 a=vaJtXVxTAAAA:8 a=30MhwtsY_Fg2L1vrzq4A:9 a=QEXdDO2ut3YA:10
 a=kacYvNCVWA4VmyqE58fU:22 a=fsdK_YakeE02zTmptMdW:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-03_06,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 priorityscore=1501 impostorscore=0 clxscore=1015
 suspectscore=0 adultscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508300019

On 8/28/25 9:23 PM, Nickolay Goppen via B4 Relay wrote:
> From: Richard Acayan <mailingradian@gmail.com>
> 
> The Snapdragon 660 has a Low-Power Island (LPI) TLMM for configuring
> pins related to audio. Add the driver for this.
> Also, this driver uses predefined pin_offsets for each pin taken from
> downstream driver, which does not follow the usual 0x1000 distance
> between pins and uses an array with predefined offsets that do not
> follow any regular pattern [1].
> 
> [1] https://git.codelinaro.org/clo/la/kernel/msm-4.4/-/blob/LA.UM.7.2.c27-07400-sdm660.0/drivers/pinctrl/qcom/pinctrl-lpi.c#L107
> 
> Signed-off-by: Richard Acayan <mailingradian@gmail.com>
> Co-developed-by: Nickolay Goppen <setotau@yandex.ru>
> Signed-off-by: Nickolay Goppen <setotau@yandex.ru>
> ---

[...]

> +	/* The function names of the PDM GPIOs are derived from SDM670 */
> +	LPI_PINGROUP_OFFSET(18, LPI_NO_SLEW, pdm_clk, mclk0, _, _, 0x8000),
> +	LPI_PINGROUP_OFFSET(19, LPI_NO_SLEW, pdm_sync, _, _, _, 0x8010),
> +	LPI_PINGROUP_OFFSET(20, LPI_NO_SLEW, pdm_2_gpios, _, _, _, 0x8020),

pdm_tx

> +	LPI_PINGROUP_OFFSET(21, LPI_NO_SLEW, pdm_rx, _, _, _, 0x8030),
> +	LPI_PINGROUP_OFFSET(22, LPI_NO_SLEW, comp_rx, _, _, _, 0x8040),
> +	LPI_PINGROUP_OFFSET(23, LPI_NO_SLEW, pdm_rx, _, _, _, 0x8050),
> +	LPI_PINGROUP_OFFSET(24, LPI_NO_SLEW, comp_rx, _, _, _, 0x8060),
> +	LPI_PINGROUP_OFFSET(25, LPI_NO_SLEW, pdm_rx, _, _, _, 0x8070),
> +	LPI_PINGROUP_OFFSET(26, LPI_NO_SLEW, dmic12, _, _, _, 0x9000),

dmic1_clk

> +	LPI_PINGROUP_OFFSET(27, LPI_NO_SLEW, dmic34, _, _, _, 0x9010),

dmic1_data

> +	LPI_PINGROUP_OFFSET(28, LPI_NO_SLEW, dmic12, _, _, _, 0xa000),

dmic2_clk

> +	LPI_PINGROUP_OFFSET(29, LPI_NO_SLEW, dmic34, _, _, _, 0xa010),

dmic2_data

FWIW there are (multiple) additional functions for each of these, but
I would expect most remained unused (or perhaps unusable even)

Konrad

