Return-Path: <linux-kernel+bounces-596663-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FE24A82ED9
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Apr 2025 20:35:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 788BE1B66FA5
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Apr 2025 18:35:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF9C92777F8;
	Wed,  9 Apr 2025 18:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="BEcxr57E"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3F00277010
	for <linux-kernel@vger.kernel.org>; Wed,  9 Apr 2025 18:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744223738; cv=none; b=plKBfC9BH0kfFK1GKg06jNlozFZTnRxcL+KKPXcXFRj3AlZyowwigIs9FzNJzJ/EX6HjKwVAohMKdmluaqsB5vIo+qb2yJ4gXJqrJRRTzVZ+jprxOg1L+9bdwTl0t0kfsm9PEAz49xNteIFkAWTi97dyeRQF5Cw8OcxUHpJr9vk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744223738; c=relaxed/simple;
	bh=7Gjf3kNoqw4NDEeMWlInggMGwDMJo9EfjfQf9ny+m+4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=txB2v6pmjOqoUJrijWlXbYm1fSkkR1MlK+nO51MVXofpAW7dBtoEwDnE1CyIQOywiWCNb/veM420wHA9mJf4Xou11Yz8F64CaDPeFgDSYGzq0WHlgjMJLKfd3Su4sUtMu0MReZLCS/aaPk/JEvKXIWAOWQFHoht2Yx29x9MnWzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=BEcxr57E; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 539I3cql023950
	for <linux-kernel@vger.kernel.org>; Wed, 9 Apr 2025 18:35:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	h3tN8Xg2pRwFhKBUhJyoFYaiPiYIFv7y7hpbU+APvsA=; b=BEcxr57EUiJY5Zym
	kVNSxVwdl1/G+WnKZuK+rrrBokydGO/Oh3UpLZWk4kL3VGv2SmZR3i/K6wuf2YOI
	MpodShpD7Ukn+eqF+kTxaEAW5tLuv0RTNDEG9lR31fCxF4wwsbIh54Tb+rDBzvkY
	R02dOpwLQyR09UacSpshxRb/Aa1t9Sa0cqYNVnm+UUMJN9lkCsaHQecEQDnqKyfr
	M9Tj2Ei9EZY3qDpuDSHjXEdH5VGK/kupDdwYPBVBtsL4/Cr+/793ixrAqiOXu9ea
	C2RawlFXomCZxJWIpKE0WahyzSIVh5Ehs76kZRSWUp/xi6CvdT3uLQ6bdG2ibQCP
	I2IDfQ==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45twfkm95v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 09 Apr 2025 18:35:35 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-7c552802e9fso490985a.0
        for <linux-kernel@vger.kernel.org>; Wed, 09 Apr 2025 11:35:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744223734; x=1744828534;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=h3tN8Xg2pRwFhKBUhJyoFYaiPiYIFv7y7hpbU+APvsA=;
        b=oyG/3gnr1NlFOy9vZ7AKKZT3sjjS91Mfy8BSVWZirvxcioK3E5RzOssOuLFA6M3QJ5
         YTdHVP5Xq0qtsnMuSbv2qE2ezRgp4ohtei9OY/t2x5iH9T/KIBLoaLQHZa/94UCsR+p+
         DZDr9sEPWKVJw01ngNdZdQaAuUo0GwCYK8HToM1XIeYW234J5d1uM4xd2Y9Nx7pOAEC7
         KnNkEgsuu/S1Mlqq4pE/6D+ksgXUoiP9a7qT7m0CNEaFbB3373RW2PDr+w/TJdLByfJx
         KFr/1wvW/ZG/0DuWCV4FrSexta4Td3H5cwBjDJt45ETxUkN0E0Z4kmbF4pYtdYFmPPjQ
         dV2g==
X-Forwarded-Encrypted: i=1; AJvYcCUrMTxXcLm4cN0E4R/lS9ufFK1CviIAnFqvXCnQm3IvNo1JwkNUdTI6Obwdm9Z4Ko/MI9vxjdeYUKVIA4Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YzaPCu2DHFeBEgaukjAVEX/rjv0Odfm0ES0SztjkdQJ+bS3jftg
	fJP/Bl1RpqP5mQj1L2UuUOWjw6c4S2ME4o8kzdssafAUGHcb6AT4452gtO26S9IrpUzhcNmr/j+
	9iVLWn0vgbQLMG3TTUGSCgihMMrUmwrsTt5sAMMkllGtlvCLZ9femAOg7CaCJAzg=
X-Gm-Gg: ASbGncuF4nfzeRtlGXBhOdv0z7v30oRvqFeXkV9TNft9zpm4L0i6TOswg5g9jio/mzg
	cGMbyUq550dZCKdC6tgCuZTzGtCdLQ3RCGO89/KqD64oBK+mQqae7wUaI+2O3azkUsCgQxTiiGR
	NgolJcirtldABc8ioIy0I+319o2r8GDYlNyR3SD9Z7GvskvZkC1XB/L7hI7N7MCP7IpXNAfMDeP
	Blj+klZl39laOWKtS+wxEe+fILrYEM2FeERG86CRDqMyAcKyQRKcItB2XGQRmSH4eKfYvZ2h3Pz
	vqCyEZ4K+jdUdgpktqkO1EVGooVTcoxAr6bM/WeIfjGLB4sTHUte/If7r7WQWIq/XA==
X-Received: by 2002:a05:620a:319f:b0:7c3:c4ba:d8a6 with SMTP id af79cd13be357-7c79cc4fb3amr237223485a.14.1744223734663;
        Wed, 09 Apr 2025 11:35:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFP4Nhv309/CRScfglwzxDlYjCREIsnQLZ9iN6mVMw3ZcNyjL93Zpdnb8GcZSJKHfk6DuunWg==
X-Received: by 2002:a05:620a:319f:b0:7c3:c4ba:d8a6 with SMTP id af79cd13be357-7c79cc4fb3amr237218585a.14.1744223734222;
        Wed, 09 Apr 2025 11:35:34 -0700 (PDT)
Received: from [192.168.65.90] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-acaa1bb3167sm134011966b.21.2025.04.09.11.35.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Apr 2025 11:35:33 -0700 (PDT)
Message-ID: <66f8d957-f7a5-4aec-b8e7-5bcc7ff7f569@oss.qualcomm.com>
Date: Wed, 9 Apr 2025 20:35:29 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/19] arm: dts: qcom: sdx55/sdx65: Fix CPU
 power-domain-names
To: Ulf Hansson <ulf.hansson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: "Rob Herring (Arm)" <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        "Rafael J. Wysocki"
 <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Liviu Dudau <liviu.dudau@arm.com>, Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>, zhouyanjie@wanyeetech.com,
        Conor Dooley <conor@kernel.org>,
        Nicolas Ferre
 <nicolas.ferre@microchip.com>,
        Claudiu Beznea <claudiu.beznea@tuxon.dev>,
        Steen Hegelund <Steen.Hegelund@microchip.com>,
        Daniel Machon <daniel.machon@microchip.com>,
        UNGLinuxDriver@microchip.com, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>, Heiko Stuebner <heiko@sntech.de>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        linux-mips@vger.kernel.org, imx@lists.linux.dev,
        linux-rockchip@lists.infradead.org, linux-amlogic@lists.infradead.org,
        linux-renesas-soc@vger.kernel.org
References: <20250403-dt-cpu-schema-v1-0-076be7171a85@kernel.org>
 <20250403-dt-cpu-schema-v1-9-076be7171a85@kernel.org>
 <03011a33-174b-4027-bdd2-043aa685380b@oss.qualcomm.com>
 <CAPDyKFoZ7NfN+pkCPnusvTOEaxbQhr=1FJqzdDGrLcKAzBpGyQ@mail.gmail.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <CAPDyKFoZ7NfN+pkCPnusvTOEaxbQhr=1FJqzdDGrLcKAzBpGyQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: zpPsjL5X089he5rExBauDrMuTB-OEXHz
X-Proofpoint-ORIG-GUID: zpPsjL5X089he5rExBauDrMuTB-OEXHz
X-Authority-Analysis: v=2.4 cv=b7Oy4sGx c=1 sm=1 tr=0 ts=67f6bdf7 cx=c_pps a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=OWbFrMhi_jq_UiG4ISsA:9 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-09_06,2025-04-08_04,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 malwarescore=0
 priorityscore=1501 suspectscore=0 mlxscore=0 impostorscore=0 phishscore=0
 clxscore=1015 spamscore=0 mlxlogscore=788 bulkscore=0 lowpriorityscore=0
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504090122

On 4/7/25 6:27 PM, Ulf Hansson wrote:
> On Fri, 4 Apr 2025 at 22:41, Konrad Dybcio
> <konrad.dybcio@oss.qualcomm.com> wrote:
>>
>> On 4/4/25 4:59 AM, Rob Herring (Arm) wrote:
>>> "rpmhpd" is not documented nor used anywhere. As the enable-method is
>>> "psci" use "psci" for the power-domain name.
>>>
>>> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
>>> ---
>>
>> "psci" is what we want here, but these platforms require some more
>> massaging..
> 
> So this isn't for CPU performance scaling?

Nope!

> 
>>
>> These SoCs don't seem to have any PSCI idle states (deeper than WFI)
>> described, which is no bueno, as they support some..
> 
> If PSCI PC mode is the only supported CPU suspend mode, we don't need
> the power-domain topology to be described in DT as it's optional to
> use.
> 
> Is this a PC or OSI based platform?
Unfortunately it seems like only PC mode is implemented.

Konrad

