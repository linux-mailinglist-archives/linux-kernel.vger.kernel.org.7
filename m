Return-Path: <linux-kernel+bounces-725626-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D6E2B001A9
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 14:26:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E3EF1C88433
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 12:26:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 957E024C068;
	Thu, 10 Jul 2025 12:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="NXEEgYd+"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96A1E24DD0E
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 12:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752150375; cv=none; b=DZEQLlB5n0zSGGtUM3tef7r29iTrj3qkSnnGx+cVEUUE2bzUbCcSE2sWxclOgAC6fqCw+5n30Via9/SnSW2Rzy5Bii0IvbUSG3tjR3MEBQ/vygXi69ysb58kVTPsneQmHSZyT3/OmJqMxz2MSrI0x4UWA2LSSnQj4qYiHC6bkao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752150375; c=relaxed/simple;
	bh=at4PJj61Rjxc4Od3ayPh5DnmEL4cEmAZ23qhK0P61rI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dAOjpgEQgexnGMoykiWl0a/ze3woZ+Kob5Taapk5mWBCGoGqcpDU063b5GtSztnd46zg/VbgIAgg0MsXm2Yl3GWcEZ8Sxt5Uf2QS9Yy9fdwvZ/IvFjeCaNwK124aoqSIyjRmXqy8ty4uRA/f4B9ILED4zJwzvsEwKTcIBIFps50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=NXEEgYd+; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56A93w0X014475
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 12:26:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	FbtxCizFqVmxij5XWo+R6iw22/lNiJfKJkPmSZ113lM=; b=NXEEgYd+NswWueGn
	kf2mUE+Mon8YCT33JJSf3IUKY+Olh1LlhK/jbirwF37334gq2xwKoISTazBhDzbc
	2jf0GtiCng+vWYoa+5lP+i+2sNVux0VqjycX6naffBY11yn/U/GiGy80suvXD+Kp
	kUm3VQKes3tTfVGzPTfOozQo0wWqPESkeiof9+y7g7RgSegZ15SJaqUNtBcsCL36
	Jqr6N6nVO1FHS+dxW/12MeWC89YXJ5BlZI5Pcp5OrJZ3HlqEYJRvNnviBAMlHdXa
	HNsmoI/u3yfzKsl5BbUf2XJ3BZ2L2k0zw7zpMEA/ZRmYI0QlGKYLgiQgjIn0lLOc
	1fm1ig==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47r9b15u0a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 12:26:12 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4a804126ed6so3943431cf.1
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 05:26:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752150371; x=1752755171;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FbtxCizFqVmxij5XWo+R6iw22/lNiJfKJkPmSZ113lM=;
        b=QVus9VwcmBIb8MHiTLfwbdqH8oJ99GGob4OjcfT+zUHQausDUABLdKELFZWFPgUMUc
         BtZ2iyQSfbN1RyMGHWyoK5K8CVsIFPHLQFEWJCLSjU9gtXOLTHqXxSELMk1LN2ZV/ilL
         rcFMJFtWrJUYtstthG7pAD0h0QPb/APPr/RdECSu6cRFRlHlZ3S9fltGkRkqvrd2OK3n
         Kp/ILsvs1+s2HVqm5+C6EoYqx+FdNRtSSKQ8xf5PHZcEG9ZR7FnRz+SZryA3IX1RdiEk
         jFY6Og4UqpKQVZqRyc5Kil7ZfOICmHD+iUCP921QAzaHAQgVpFx3BURMKO2XjKzyCfFn
         a+bw==
X-Forwarded-Encrypted: i=1; AJvYcCUoB3XQ3H/FOWesoPP2TqVF9Cq8DzFB81H7jsWkwflHOkPc+0Nw1+sPpvGFPXBlzmwC1esNgsI0v26LX2A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyky+PqOkUKV60AOV/sohShovSGw8RcyL55fS2MwrI/akmxRsmn
	qAMojdedx2pPLJ/sdErEdYLNTLf92kqo1O0EK672CbTyFNafEXGR2A4FrkfxNgKHzj3VwhM4GHp
	nl5rY+iy5V5us7jb12ZERNYI5DdHWou4YD5ojsuSnc2JZ4JcBmqYz4EdCCZsdWNU46uc=
X-Gm-Gg: ASbGncvAxR05H9Svd/z/mOKK4Lq3/zdSaboU64zhSZeL1vwBkn8/REdCf226CRLdog8
	NBCYAZMfQuxYXTeAi+PODVlHl7RStBWXjCOHdIvP1B0FAOcG4TLYBFOjZLPFiQaCwY5sEtuywEY
	lpnAPCMO4pw4z60ctrNt8cHrQYatJ1Ws5NsjHlDqPRHpHaQKGKST2hisC85a9vYBrY2Yoyz6Vcs
	c7+SyV8HMykfEIpXiwy/bw61n3ObeIU66zbp9x7WrvNVVy3ooBShPwBr0p+UA129SxahH0gyNxG
	qSp5tsbqGwk3fM6qfUiHN4X6U8DiXDeGIM9zGPlml3j/pfPnE0iAfkbnwhAEpJZbeIxlLl6OCyy
	Ducc=
X-Received: by 2002:a05:622a:148a:b0:4a4:323a:2d76 with SMTP id d75a77b69052e-4a9decf6af5mr34076931cf.10.1752150371443;
        Thu, 10 Jul 2025 05:26:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF6rD3KBw+n4YbMxLbNBGM2hSLhxtVZ+IZYWVEKjer3BHqjIzVfrtLkflN1y+COvTFzgl5lDA==
X-Received: by 2002:a05:622a:148a:b0:4a4:323a:2d76 with SMTP id d75a77b69052e-4a9decf6af5mr34076541cf.10.1752150370531;
        Thu, 10 Jul 2025 05:26:10 -0700 (PDT)
Received: from [192.168.143.225] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-611c95242e4sm821075a12.26.2025.07.10.05.26.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Jul 2025 05:26:09 -0700 (PDT)
Message-ID: <1f0debc7-bde0-404b-a395-dc72ca4c82c2@oss.qualcomm.com>
Date: Thu, 10 Jul 2025 14:26:07 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 12/12] pinctrl: qcom: make the pinmuxing strict
To: Bartosz Golaszewski <brgl@bgdev.pl>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Alexey Klimov <alexey.klimov@linaro.org>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Sean Wang <sean.wang@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
        Paul Cercueil <paul@crapouillou.net>
Cc: linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
References: <20250709-pinctrl-gpio-pinfuncs-v2-0-b6135149c0d9@linaro.org>
 <20250709-pinctrl-gpio-pinfuncs-v2-12-b6135149c0d9@linaro.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250709-pinctrl-gpio-pinfuncs-v2-12-b6135149c0d9@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=dYuA3WXe c=1 sm=1 tr=0 ts=686fb164 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8
 a=sOBEMjS50dyNa0exkEgA:9 a=QEXdDO2ut3YA:10 a=kacYvNCVWA4VmyqE58fU:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzEwMDEwNiBTYWx0ZWRfX1mIrdMw51A/p
 j+ZVUXVEV5Zz9AWYtTPe25xCZAv5R6p9+q7R0DFtX/1SgGhaMVA0phnlH5WNKV1rg+VLQBmdr48
 GLwynOBCi3RvgLec7y7WW/edNE4ab1g45P3Bk4SF7KGFCKgpT7us82uaEoqeO3Lx1FiPMonutGN
 71Bp+OEQn+6EDajZlDCEi4wLrcasCgQ16HMCkbvmOHeBkr8VC27AW85GzhlGIvhNkQNaOTbgbWk
 FRSYe45fTJldbpy1umx/k7HlaZkrx8ZmK/qFy2hVjJ+9Vq4OEk/RfRtadP3zeD6siQA05t+60t8
 4+1Cw3TQw2eKneTp3JaC/uijnnA3cfu9HlGAk9+a4VecmLMN0tlnGBIw/hpkJnO60Qmz7kN5j00
 8xr2f/FMuOaVR+cPFzj9Xe3yBVQU7+E4v5gZmngh4Zg4qgET2DaWXMsNbvCkW3IZAUiuWvGK
X-Proofpoint-GUID: ydYMcBM-n8kUSeyblgS14d4O9ZKSqcki
X-Proofpoint-ORIG-GUID: ydYMcBM-n8kUSeyblgS14d4O9ZKSqcki
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-10_02,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 suspectscore=0 clxscore=1015 impostorscore=0 lowpriorityscore=0
 priorityscore=1501 spamscore=0 adultscore=0 mlxlogscore=850 malwarescore=0
 mlxscore=0 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507100106

On 7/9/25 4:39 PM, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> The strict flag in struct pinmux_ops disallows the usage of the same pin
> as a GPIO and for another function. Without it, a rouge user-space
> process with enough privileges (or even a buggy driver) can request a
> used pin as GPIO and drive it, potentially confusing devices or even
> crashing the system. Set it globally for all pinctrl-msm users.
> 
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

