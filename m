Return-Path: <linux-kernel+bounces-744128-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D235EB10846
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 12:57:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 02E365A5383
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 10:57:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35859266B59;
	Thu, 24 Jul 2025 10:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="MCM9U+EI"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1288D1C3C08
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 10:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753354669; cv=none; b=du/NiKwZicUFv269NzhwLcChzOsQsms0fkt45iirux03tt1+lGHo2fhpveZdL2wBPt5FEO5sP3YL0bZSCtgYb2a2kjIstdFIUH84dl8akASM7AImd26CX9apo9SmaqtV4jzTGi0Kq8R9WRwDpHsVrv5CMOBrQ6KVKs5qnUhisLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753354669; c=relaxed/simple;
	bh=FHUm8JgjLCIAyUcbE9ObMrZ2uKu/jiL8r01fKXYzPAY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=M7OGnFJu2kYRbL8KB5ptDwmQ19KoAl6h3ad5LPMGkbJHE5/V4q2Rp/3qLdEDL+lBD9oGyh4i03uvkWuJN0mQsxSr8x0R2ndZl0TEkg2MqPTIUY3j9V5r9h6w/pW8i/p8BFdfxgNTntXFWul9bwnCKQrCu1K0zxAegYBb3Exn6tc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=MCM9U+EI; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56OAMJVG014473
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 10:57:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	frgttlq1wUpHfs85c6sOB8oFTBM5O4TFBHJ8W4S/2Zg=; b=MCM9U+EIRXdUhkkj
	RnaQHyphmlwj8ufux4uRqT1CeeRyh4WJeQyMhFCoM7HUZE8B54OyMur9MQ7pLAHK
	q7Q1KVrS7BFGTDMUnHwdUrmlCjNOXtf0Rp/Gdwturu54n0TsR+qJU3AtKnFv2WhV
	Ajeq9g9mm1HxhnKm5PMSdv09h5GF5GTeKQLa+UREcjMI+vHbBSZEp5ZsQOJYdrBc
	29cuk/jHFBZqdsYWQeB8ET0R6F2HpIBhXtEQ0eTVFTrqxXZJKuhGlQ4XUWQjybWw
	SQmEEyV1+dpeOxXC5puV3gSzpq8fRjewj3wouaPKzcYBH4zMbbbQ82M9zd+81FQV
	uLJMxQ==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 482d3hxerx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 10:57:46 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-6fb030f541bso2733446d6.1
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 03:57:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753354666; x=1753959466;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=frgttlq1wUpHfs85c6sOB8oFTBM5O4TFBHJ8W4S/2Zg=;
        b=lBLNUHdYJ7Z5FnrwV3zVNuxhoHg2YVLgtqv1SoXWpwdVmlI40pVV7vM1P+6zhgAWMZ
         D4jPHeNn0t3aGYrH1kYl6DJ1ujLDx7oHO+eENYvqbao5F5EzJFHwRGHxQCj/OaKpqWaN
         JNFQs2R9/g9ZLDqUB0iszukSv3RvYdBB1SnaRGfaupBCnxgzEWq2+yortm+COHi3c+I0
         WKxPFokTE5s785cdoUreFQkmalCbt7W+O6mvBiQwZqzz9Xkfc6mNylvFssUkLvcMZ4yL
         IFkHCYYkdlThPsV7FtEY6GXjmaSI1G5IQKNK2rUTn5cXuxPTVd7l7MavTiSh+y9Ad+OC
         5Wuw==
X-Forwarded-Encrypted: i=1; AJvYcCUUFAGmoDnuhXJl+xogKPj1+gNfDsLOalTuDuHmh2VpNP8tcQEJl3ZAmg4zp1+fOv0YeZN66W6UQVDV7v0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwAQcGYZlRDk3KzSosRlQRKKFaeDYq7kp/S4adPVHuoEQMc9sVS
	lEsUsq0g9F1E4vvhDX96Cf1E9xc7QaodvcOTM5TqbfYg/2KejYvC7RdUdGFDEXeWQ493VryVSFJ
	VAniEw2drfpCDqvoI7fJK4SrDuScgbe01RYNDMtfTSyhMXB1E1c9X9aDao5KrVcREltw=
X-Gm-Gg: ASbGncswhZuCe4xmd1+PjEHArW6nMMg72tMcy7McwsHZkCSFjGCSpYYjHDWKrTyVtMM
	8prv0vTFSSSRB/0hUz1czj1PKlP986jGQ21rXFGwxA5TDY6HIfT8ARa3sXju5SHWIcA1YkIxpG+
	WKmxyrOQkCFhJ2lox/6DBle8EaUtYGdPyDesg7TKNqXugplXpXoeRrLghM6d876aO3GTHZFQxjk
	pxh9oMOOm1VLEMqnPC6aXmhiz4vlPmRU15/efGDoZ/2yxN4VQZ7APCg/sykOIqYE6KqJymfmLqR
	a/P82YE4lygoGXF6rOx94MW248PLKy7b3bPqljccgT4LqbBfOkTlpRvrbkwdbIh5+siYwuIyApT
	rHPTmREPydl5AnmTHNg==
X-Received: by 2002:a05:6214:1d2f:b0:702:d3c5:2bf1 with SMTP id 6a1803df08f44-70700537849mr43874866d6.3.1753354666065;
        Thu, 24 Jul 2025 03:57:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGOPUGD8doV9+jglxqU2GB0DYEWEF7aTYg/TWGqOaOfQBWULvPms9oF3r1fFWzU0hBkNoKlEg==
X-Received: by 2002:a05:6214:1d2f:b0:702:d3c5:2bf1 with SMTP id 6a1803df08f44-70700537849mr43874396d6.3.1753354665532;
        Thu, 24 Jul 2025 03:57:45 -0700 (PDT)
Received: from [192.168.43.16] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af47cc6e753sm95191866b.50.2025.07.24.03.57.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Jul 2025 03:57:44 -0700 (PDT)
Message-ID: <bbb07270-cf7d-4fc6-9a74-334fcaf00f05@oss.qualcomm.com>
Date: Thu, 24 Jul 2025 12:57:39 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 11/15] pinctrl: qcom: use generic pin function helpers
To: Bartosz Golaszewski <brgl@bgdev.pl>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Alexey Klimov <alexey.klimov@linaro.org>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Sean Wang <sean.wang@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
        Paul Cercueil <paul@crapouillou.net>, Kees Cook <kees@kernel.org>,
        Andy Shevchenko <andy@kernel.org>,
        Andrew Morton
 <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka
 <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Fabio Estevam <festevam@gmail.com>, Shawn Guo <shawnguo@kernel.org>,
        Jacky Bai <ping.bai@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP S32 Linux Team <s32@nxp.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Tony Lindgren <tony@atomide.com>,
        Haojian Zhuang
 <haojian.zhuang@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>
Cc: linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org,
        linux-hardening@vger.kernel.org, linux-mm@kvack.org,
        imx@lists.linux.dev, linux-omap@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
References: <20250724-pinctrl-gpio-pinfuncs-v3-0-af4db9302de4@linaro.org>
 <20250724-pinctrl-gpio-pinfuncs-v3-11-af4db9302de4@linaro.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250724-pinctrl-gpio-pinfuncs-v3-11-af4db9302de4@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=G8UcE8k5 c=1 sm=1 tr=0 ts=688211aa cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8
 a=jpok1_DMC_Ne8w05vhoA:9 a=QEXdDO2ut3YA:10 a=iYH6xdkBrDN1Jqds4HTS:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI0MDA4MiBTYWx0ZWRfX/q0lydaaKuT6
 SMcq+FhbKuvi29D+pgHCEMs3QSjAUYMatLJj37+9mtbZ6qNyOBTPA7D0lhxu1qhQ0wAk6t41ByH
 TSGjr/xztA13Fz1DVuO8qrlHuXVkSA+Axqo54MlNAcBC80PjgUaYvi/UVy01gI4QaA+mVB9R0Gq
 4CUUfisHIcOmFkbDsNbiGAPwr8yWy0ZeiWSZlUfg72HGnsLI4ftTvek8/9DYMoE8gEkpjIuxewI
 XwSi1crQ+YVhlFl6n2hVWm6/oV6B+yMxFQhFR/Vf/zi/508DRpS0see4aV6mAiha8JmEmt9Vg9Q
 prz0fV6758Wyav+cek5oK08MxUxtO+8lIyTeApBqmpAGGj+ogSQnRa9AeSdZXI0XG2aYHqMJaXn
 QMfXb5v7LQGSFH61/GUBTGjAvyt+abRaDU9RPRnpGfTtNIk6LyyrPoFuyL2yKz0pXprrzn0d
X-Proofpoint-GUID: zWsWgmZwnOyKYXePBImx4ceyORsdpw7G
X-Proofpoint-ORIG-GUID: zWsWgmZwnOyKYXePBImx4ceyORsdpw7G
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-24_01,2025-07-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 mlxscore=0 suspectscore=0 priorityscore=1501 clxscore=1015
 bulkscore=0 impostorscore=0 phishscore=0 spamscore=0 lowpriorityscore=0
 mlxlogscore=465 adultscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507240082

On 7/24/25 11:24 AM, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> With the pinmux core no longer duplicating memory used to store the
> struct pinfunction objects in .rodata, we can now use the existing
> infrastructure for storing and looking up pin functions in qualcomm
> drivers. Remove hand-crafted callbacks.
> 
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

