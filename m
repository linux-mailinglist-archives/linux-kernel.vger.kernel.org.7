Return-Path: <linux-kernel+bounces-889988-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E422C3F01E
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 09:45:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 833A7188D1DF
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 08:46:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C28C2D7390;
	Fri,  7 Nov 2025 08:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="j9VKSGL5";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="OlyvRjR1"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBCFF2C0294
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 08:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762505139; cv=none; b=WyjAlwInX5o62E28VkQxW77Odh5YemScyJSuTE8zQiWoPyCWMXIfLPw/aLLM+BoHZLoqc7jnaBgy6HvbNIlodSWiojVtiH6ZnnAicaJndW2SJDggZ0T6kj1F3PePWpjNmfdI8ItUEMPbWCAI2faHJY7ZMAvNiNtLwdNF7JQdADs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762505139; c=relaxed/simple;
	bh=RKIGS9KO0vrK2ZX9kbsgi19599kVH40TuOoD/FFjBG4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KRYUe0oJZ8kmZjxgJiO/A8cjgZ0VRKYzWR3G3yD+fyMtgOpxkeksekAhqvb/n5wOfF16ez2LuBTpNEtY3vlfaVaYfkAf6CnDcXFh3Bu0u25DLxTPmT2eaWbFWEfn3uGBnzCd0yS24IGqtNNpZx9mOuS+FlNYikqM3y0MUSkw1LE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=j9VKSGL5; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=OlyvRjR1; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A74UXJb557105
	for <linux-kernel@vger.kernel.org>; Fri, 7 Nov 2025 08:45:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	QgS5hwRfj2mxPLEmin/RQvyBPkehj/tTh/N9o3Q2CaE=; b=j9VKSGL5ldNhCJw0
	IDsem0Fzr4SZuyQvM/h+H2DD1w1AXbGzSR3pIfo38NsMeard3DiozlihvbgOA8mk
	E6iXrhmwPw+FvmJt6QIA33bRR//xSA+t/4krdqjLlTv+Ktsev+bV4kYprelpwNdF
	GRGMArQuSTUJWlqAla3WFLSuaGWvjhBrDvToC7CMXn0vN+J1xQZllcYOCXarce4g
	qBJRGRQBgZLrKak5prqU40NrNsbZbzxGb2YBYOhfRhU9EAFl2akC7pCJS1EFpvvT
	BJycTnz7G1RABrBE0q3f8B1E86f9WqOUQCb0IEp4y1Fp73PNUYDuiP/x9QZmB2cp
	h7FEuw==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a8yr9tccq-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 07 Nov 2025 08:45:36 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-8adc67e5340so18782485a.2
        for <linux-kernel@vger.kernel.org>; Fri, 07 Nov 2025 00:45:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762505136; x=1763109936; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QgS5hwRfj2mxPLEmin/RQvyBPkehj/tTh/N9o3Q2CaE=;
        b=OlyvRjR1scUYpx0elK70FcvgNMsie2yqvTd3JwwCuBE6dO62ea16VBAw0G77yqywR0
         dCUP77sIHzROUTTuAw+6EMYLSnGwju56++KGde2FpWJBxgTTokydpK/oDODseafWfOSc
         qJUaQQ+6WyvpKr8lttmje/A5nTuOQsfIsXx58yFLST7keYVteYCErxPMXDTihtYbUP+L
         HwSWh1+lulyJHT4qirOJGpgqRoi7VGigqZFzx9CThrsChR8LwdUIaNrsYStJbuu7QYhB
         thwfY50m8ogp5dvzknQUseJdEq/cVLfLkwTWf75rlnM+cLBjoMalZkgIOVOtMqugmQO9
         K7+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762505136; x=1763109936;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QgS5hwRfj2mxPLEmin/RQvyBPkehj/tTh/N9o3Q2CaE=;
        b=G74Fk227xVM4Jh2vf9/tLo0LsDGE6fO7b4rb6L8gewRy7FgfgAfZPUEJscg3BLEnpk
         meaXQccDlPHTfHezzepQMSPqGjcUdHr7nOttxDXVNR35/4bp2MCyBbqXCohMylYjGLtA
         cIJI3ZyWVaqZaRcIwubxWIqT3iBxwDiK0rCNmiEw+pUwwhKZxS2blIyLDHdx/Ddm10te
         oVFjBIlRM22P90QzR+8zQQVUCTy0HVYtteVdux3Vl3uNS9P6HIjed0pyfN7u9HwnqtHW
         qDGU4KW5zPAJGIkThRWMd9Y87eeGA+1A7oTIwxBdZYCrBS/9TQE6UXXXwJrCf5eygSyx
         y5WA==
X-Forwarded-Encrypted: i=1; AJvYcCU5vYLWIDTf8QaLMQUF+5YVqqVCUJXk07JhS4LrA3kdctmcKarq1TECp5LzYEZREthr12KJWLG9LstW8JI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEm3FoFlEdFj5wLNs2/YNMYpuIRlb8MJcQ8xzZee69laeA+w6h
	JfRgwtB7dqgKBCWsXTiWD7PeqLT+mJq+qXN/Vp7ihOY2lwkcfNsjT172T9c/sjbwg/bdlZ1swFk
	lB6nh5+TqutafjrgwK/1DL+HPerHMXKjE4Yo3vKwCj1Hpisn6MJOugtKY9EzIT3q4HE0=
X-Gm-Gg: ASbGnctVfXqdPGao1oQPrcu5BTkoTROBKx48cGWklnTF6bcU3orfz8jGqJr2Q1DS1rF
	5eulnvmtVCC2ppk5xQwVTDVPQqTxjNT8/qbqxFa8Bns/Es7xecj2V8DafoSclWaj11IwyZTxuiW
	v5gmp3p12QwqJFvSJnYqsc1s2FqSTmM7Z2hvuExFeYjcNaV5+lkrTzonPQqZxq5DJPkSntTDihS
	yatuGpknc2t7N3rWzj04QuM1yByq1hYFbzX6cK+0owK5/ytgnHcVc0QmOkF0Vl1PQFY73Dt+IGk
	r76hvOOVj/xapUUrbKewbJUkGtWX3fNpUJIkQa0T6alzYywDhzlinFZmGyL6g4wdYp99x0D9mZZ
	hC+qCJvIWk9T3fdi3Wj8c4T1P97ntEzsdg/R68lr05oZYa3FMVFGxQXkk
X-Received: by 2002:a05:620a:29c6:b0:8b2:fea:21ad with SMTP id af79cd13be357-8b245325b1cmr200932785a.9.1762505136004;
        Fri, 07 Nov 2025 00:45:36 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFvBCF3YyaLzOcN+aoUwXSd+qKgBVW+y3iV9o0DDasJiaqAVotNnEsYQ0f5UYACwqcVlSpGpA==
X-Received: by 2002:a05:620a:29c6:b0:8b2:fea:21ad with SMTP id af79cd13be357-8b245325b1cmr200931685a.9.1762505135491;
        Fri, 07 Nov 2025 00:45:35 -0800 (PST)
Received: from [192.168.119.202] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b72bf97e563sm184419466b.41.2025.11.07.00.45.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Nov 2025 00:45:34 -0800 (PST)
Message-ID: <c7065cd8-9819-4af1-a346-4daaa4e306e9@oss.qualcomm.com>
Date: Fri, 7 Nov 2025 09:45:30 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/13] firmware: qcom: scm: Simplify with
 of_machine_device_match()
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@google.com>,
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
        Thomas Gleixner
 <tglx@linutronix.de>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@tuxon.dev>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        Hans de Goede <hansg@kernel.org>,
        =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-arm-msm@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-tegra@vger.kernel.org
References: <20251106-b4-of-match-matchine-data-v1-0-d780ea1780c2@linaro.org>
 <20251106-b4-of-match-matchine-data-v1-7-d780ea1780c2@linaro.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20251106-b4-of-match-matchine-data-v1-7-d780ea1780c2@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=DrpbOW/+ c=1 sm=1 tr=0 ts=690db1b0 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8
 a=TYptV6U4Xydj_hDeH6gA:9 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: qnJl6EJnQevsC6aVqy9HSTWXjtb-geGd
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA3MDA2OSBTYWx0ZWRfX0BsQrj2AjARU
 Sv19s+7x2cDp8nqdoqEnlgKkRbJhZjzwgrkMrT3jj040QgpzSq45bTQfNCmEQY+DYhZ+aiqLSU6
 VtL1EDNNkFscWYcvCNTSE6x7BozM6O7ymisuMc2CInjFVGfDfbGXa7kXrZuRVzg4GSFhBE8dFFs
 KaRNQjJ3sgmLv3jSRPQCQjkeZJUg+b1TsV3BNjs7OfjlgfkvBBWe/liBgoI6xhWJXso+4o3IRNF
 wWvwHeec4XBD35UdTH7kbJBYTOECpvUTFcUYj3XDu7QNTbFLlpkRxApwzN8mzk4UZWHpp3Qo1C2
 L/Bd1HESccSg7LFGxeMhoPVbjyD6ar6ZDcdmka7gisR6k71FDweUq36G4tkVi+Z6P7f6cD0pd5s
 p5kZTZKRsR/zhP9rkwvbieS0IEgvsQ==
X-Proofpoint-GUID: qnJl6EJnQevsC6aVqy9HSTWXjtb-geGd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-07_02,2025-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 adultscore=0 impostorscore=0 bulkscore=0
 clxscore=1015 priorityscore=1501 lowpriorityscore=0 malwarescore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2511070069

On 11/6/25 8:07 PM, Krzysztof Kozlowski wrote:
> Replace open-coded getting root OF node and matching against it with
> new of_machine_device_match() helper.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

