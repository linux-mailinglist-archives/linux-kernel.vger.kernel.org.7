Return-Path: <linux-kernel+bounces-753299-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C01FB18132
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 13:37:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 017733B771A
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 11:37:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDC5823E334;
	Fri,  1 Aug 2025 11:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="laVbsFeT"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4351C23B60B
	for <linux-kernel@vger.kernel.org>; Fri,  1 Aug 2025 11:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754048224; cv=none; b=FAWBl7PbqAuxxafKTNde2rm9Noj/wSLBwZtEE8uEqPn7CFpApmrv3et7od3ONLxaqqA3DsMmViMCr81I2i5Mj/Saxcmx4ns4anFs1fKMbwOGFkjwI7Q7FJdJI7Eh8/xuZgmmTKG3snuk0oC6cPvT8Zkt8Y4EiW3g1mZ+Maz31tg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754048224; c=relaxed/simple;
	bh=S+OUPbutuw7eeLKJnK8PAXGqLsNg1a/WjTPWGFI+L2M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CXuAaw0mq6Kyl8wE7iJj5Xx6AGjyxBG+4Y8dgDoMIuFGA7u0qzanp02tHrrA+uPD6POgP4Mx8ToGdDvE4xVpNdgfHgNAnGfdJnMXTHmcmna9KuuowJPbanHjJKO4n0mTl6tz9lK+TB0lsuzzZc0NZsj/RT5rPr49FiBs10LIBAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=laVbsFeT; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5718jf5l001430
	for <linux-kernel@vger.kernel.org>; Fri, 1 Aug 2025 11:37:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Ib4lVo6bA5cxWNHRPcfBAhasx6+Tv4uNCb8kn2zACc4=; b=laVbsFeTSRGnvXcG
	VQ2dm5mVML9HBSszJSDpmG0jaePCntW0E7z1mjKqtg6++Z8M5HFFov1sjM/X9D2G
	Nkyl2xrjKsHMMLVk50u2aG46qOUQ45/z/qpRp8VKWzRkHc9hQUIZLXI14r4wvrH+
	WV1Z9xgZ7lYxJmlU/UJ9qzE2KefWiCSKps3+QqzjfxonfEFUamwEs+a1+2kOIGcu
	ofac97tI2++OhGEXEfinA9bnQfmZkWXzufN8lb/uBUEtqby9IQ4H/3xZ0XOJ0SZf
	fErNHoj4BWUjLc3siW8Qws/nSq9LSKUsgkheVYL2HdcctmL4Wiac7NJVOjrbZuO9
	2rFvag==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 484nyuc4vq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 01 Aug 2025 11:37:01 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-6f539358795so5637546d6.3
        for <linux-kernel@vger.kernel.org>; Fri, 01 Aug 2025 04:37:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754048220; x=1754653020;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ib4lVo6bA5cxWNHRPcfBAhasx6+Tv4uNCb8kn2zACc4=;
        b=Z0p5PHH/8g1omYi4WTsAIE7yFH9phNsiGqTNiM0Eqgo/UKnn3eUM4StYkCe98VNfHD
         I0bel1fYPc7fy3wNIilbgf3nr0tvHhXTk4QSaL3DzJL8wRllAh7CeEaRpbHQHfCrziGQ
         I/zzDwLIYwmmxyHLSxHmXj08KBaaCLerDkEtDMoe1181FhyVP5uMWLm3BDNwNFQrgA3u
         /sd05t1ktWXCWZsE3A/zPqe5BY7pJyyiCkgPmU1bncJ9afc2SZujixbY6EYmBA/iQcIB
         jVDtDjOcaKeA4SyYTqpNgVDY7eOpSfHWxnW6xk3yUSwOTqO2/1ukpJr1jSKw6RkVC9dZ
         Tk8A==
X-Forwarded-Encrypted: i=1; AJvYcCWvOEcK1IULXa2q1eovWnDiaGwalAHtPYJh6laEOSaJbU2iF7d5ivWHmfibI0uqGO42aEnGI4G2nj0mWoY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwALVFHGS+vjcT/7Biu8OuxgMw99ByyZdaZMLpt0ZZgFWO4VATh
	d+GklG04f90rMf5zgHpCSj6cEuCK61sKtTVWHGeqXk0FxaVn0wk+Tu1j2I43qqTw3aA9A1Deci9
	4CWo4jaRYUca1C4SwEaFPnnBZ6Ph04CT7ReF4b5Se8/o/XggFrFZhFkW9wmQKdxxOpl8=
X-Gm-Gg: ASbGncuWC2YK0vYP8Zj0AQ2YWHSDdDJYXZ6T9uDAy0phGXPb2xwKy1lw00PEFCRknOv
	8y7fUvilPO+u/RdUEH7gWKYMGT8YVAvpuEcNp4/Q6kPvawgZxxD3fCL5ctUercGogXZ0+LaG/8R
	P08LuXvaqYNZzNuVoj89c2atH4UvqqdpXtvRm8ujPthYblckR8LhAqu30/gHxFc5p6k6bJNalew
	ppnorIborLIraADMc3opuxdV/fGDY9nVDczXCowIotvigyOEN9/bSAUrumm6XVX1GFaIU70te8v
	bsVkrI0DnrNgyEYIpu1tyDBct2A8RTUSA/xqWmlCW5awKmHSPLMoAZ2Ef3kWxLP3QWJ9QKXmhK9
	9UaZHS/qGYiSAidClNw==
X-Received: by 2002:a05:620a:469f:b0:7e1:ba5:6ee0 with SMTP id af79cd13be357-7e66eec27a7mr809611285a.0.1754048219812;
        Fri, 01 Aug 2025 04:36:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGISRK3LCNP6LCJEXt6pbFs22LciSzSSA6wDhhyR/ABPjUX2hHCx0gXfYiLZNNNjNHw2rNI9w==
X-Received: by 2002:a05:620a:469f:b0:7e1:ba5:6ee0 with SMTP id af79cd13be357-7e66eec27a7mr809604985a.0.1754048219285;
        Fri, 01 Aug 2025 04:36:59 -0700 (PDT)
Received: from [192.168.43.16] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af91a0a3981sm272166466b.35.2025.08.01.04.36.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Aug 2025 04:36:58 -0700 (PDT)
Message-ID: <a1040dfd-00be-4f20-92e9-533a74803e9d@oss.qualcomm.com>
Date: Fri, 1 Aug 2025 13:36:50 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 1/6] dt-bindings: dma: qcom,gpi: Retire passing the
 protocol ID
To: Rob Herring <robh@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>
Cc: Vinod Koul <vkoul@kernel.org>, Sven Peter <sven@kernel.org>,
        Janne Grunau <j@jannau.net>, Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Neal Gompa <neal@gompa.dev>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>,
        Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>,
        Paul Cercueil <paul@crapouillou.net>,
        Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
        Viresh Kumar <vireshk@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Frank Li <Frank.Li@nxp.com>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Taichi Sugaya <sugaya.taichi@socionext.com>,
        Takao Orito <orito.takao@socionext.com>,
        =?UTF-8?Q?Andreas_F=C3=A4rber?=
 <afaerber@suse.de>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Patrice Chotard <patrice.chotard@foss.st.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        =?UTF-8?Q?Am=C3=A9lie_Delaunay?= <amelie.delaunay@foss.st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Chen-Yu Tsai
 <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Laxman Dewangan
 <ldewangan@nvidia.com>,
        Jon Hunter <jonathanh@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Peter Ujfalusi <peter.ujfalusi@gmail.com>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Michal Simek <michal.simek@amd.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Saravana Kannan <saravanak@google.com>,
        =?UTF-8?Q?Martin_Povi=C5=A1er?= <povik+lin@cutebit.org>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Mukesh Kumar Savaliya <quic_msavaliy@quicinc.com>,
        Viken Dadhaniya <quic_vdadhani@quicinc.com>,
        Andi Shyti <andi.shyti@kernel.org>,
        Krzysztof Kozlowski
 <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        linux-rpi-kernel@lists.infradead.org, linux-mips@vger.kernel.org,
        imx@lists.linux.dev, linux-actions@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com, linux-sunxi@lists.linux.dev,
        linux-tegra@vger.kernel.org, devicetree@vger.kernel.org,
        linux-sound@vger.kernel.org, linux-i2c@vger.kernel.org,
        linux-spi@vger.kernel.org
References: <20250730-topic-dma_genise_cookie-v1-0-b505c1238f9f@oss.qualcomm.com>
 <20250730-topic-dma_genise_cookie-v1-1-b505c1238f9f@oss.qualcomm.com>
 <20250730234631.GA1899887-robh@kernel.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250730234631.GA1899887-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: EGbzTrYJ2w-SIvUfroYcvr66tLLgLBT7
X-Proofpoint-ORIG-GUID: EGbzTrYJ2w-SIvUfroYcvr66tLLgLBT7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODAxMDA4NSBTYWx0ZWRfXxRuStmzLyH0n
 PXo8G3TLwuN1NDkxMU90ATgsVmXCgvKhXXxedMgfp4NhqtJN92mHvZdnR34oVZI+D/k1rI93n/w
 3f1R3wGYnKEXm5aa1jGTFZIlEZeb9EBv6QUY2tk2sNhREw4L/ByUN46slof5/pJDzSLhNb34fuq
 cdPhUlQi+180ZQhabtAC3SQ4dutwmMoKed4dgwnzihuIN4cwHtxKOPkS+YGF6g+5d21mRQbdWWY
 KQ0MPXQ4r0QPAwnO+4ECCqs2KjfeYme3MAOdU544IwOPvPyO2U5vnCyN7ZDYD3H+laG4t5dhMHI
 ty3Txx8DALR9ol08iwTM6/CulfVGY5VxBQfTqByKY9Gu6cweXk7XxI3MLoTsJd7uLoLN/fSWBbt
 yYgSx4DA/Hwl3xI4DSkuhx9qNt4xZ4H4s/6McB4Ya72hCC3XtYFNOZId9XwRsvQ1kYSpeShW
X-Authority-Analysis: v=2.4 cv=CLoqXQrD c=1 sm=1 tr=0 ts=688ca6dd cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=RNpRkCq-AmGuj0ryOp4A:9
 a=QEXdDO2ut3YA:10 a=pJ04lnu7RYOZP9TFuWaZ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-01_03,2025-07-31_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 adultscore=0 suspectscore=0 mlxlogscore=902 spamscore=0
 priorityscore=1501 phishscore=0 lowpriorityscore=0 malwarescore=0 bulkscore=0
 clxscore=1015 impostorscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2508010085

On 7/31/25 1:46 AM, Rob Herring wrote:
> On Wed, Jul 30, 2025 at 11:33:28AM +0200, Konrad Dybcio wrote:
>> From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
>>
>> This is a software construct that has no business being expressed in
>> dt-bindings. Drivers can be constructed to retrieve the protocol ID at
>> runtime or hardcode them per protocol.
>>
>> Remove it, as a pre-requisite for further simplifying the GENI
>> bindings.
>>
>> Signed-off-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
>> ---
>>  Documentation/devicetree/bindings/dma/qcom,gpi.yaml | 5 ++---
>>  1 file changed, 2 insertions(+), 3 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/dma/qcom,gpi.yaml b/Documentation/devicetree/bindings/dma/qcom,gpi.yaml
>> index bbe4da2a11054f0d272017ddf5d5f7e47cf7a443..745613b93b210afd38946030f7477e91e08c907a 100644
>> --- a/Documentation/devicetree/bindings/dma/qcom,gpi.yaml
>> +++ b/Documentation/devicetree/bindings/dma/qcom,gpi.yaml
>> @@ -61,14 +61,13 @@ properties:
>>      maxItems: 13
>>  
>>    "#dma-cells":
>> -    const: 3
>> +    const: 2
> 
> I think you need to keep 3 and note it is deprecated. Does an existing 
> kernel support this being 2 already. If not, ABI break...

Hm, I thought this is a case of relaxing the requirements, although I
suppose some software might have had a "if n_cells != 3" (and not < 3)
check

Konrad

