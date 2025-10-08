Return-Path: <linux-kernel+bounces-845710-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F033BC5E45
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 17:55:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 72947189F50B
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 15:55:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB1F729D279;
	Wed,  8 Oct 2025 15:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="bqtc6BoB"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63122261B70
	for <linux-kernel@vger.kernel.org>; Wed,  8 Oct 2025 15:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759938926; cv=none; b=uHbeoqzTJhMo7bBexycpV97LcMcOSUym/2PeWdqeC6ew2rddbF33air5Ohyms4h+z7BZjRgQS2504KwGFB5LKVvg/n6JcH1r6vh1OozYpQuUex8zEftUlzInYx+e4U7E8NcjSfUH37hR9G4vMed+B7aVlg//wq22Bcqit7G41l8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759938926; c=relaxed/simple;
	bh=j2UkhdzbAn9EpuVUW5MA9K6q+5RVw8aI7MKuXDaeTZM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SJ2BSJAmM0tzyNqrbJzKMb/PHrtMuaFFCQRO7h5n2KwrMZPzrGM6KZJ0SQ8TrUkEXnwrHSTYUBJTqext0e2BoGioCzRTOpH5ZVuiEV8wg4o3pjB8QTqTtAxT1Kgto8sdC1mWDkRzMV6UGTVubMT8MjAnwXlvEoNLP/N8a2aoGIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=bqtc6BoB; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59890O1X015715
	for <linux-kernel@vger.kernel.org>; Wed, 8 Oct 2025 15:55:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=7QjSXtuoTslSkSiHaByDppgS
	FC/oYSQl2GRnyEf5CaQ=; b=bqtc6BoBneIssJCr2G+gDAAsfflb4UqeRYNviNao
	LYpbWE6+rDflxbz/4DkOuZ6cI/4B5KVUqj7i/xxoT91ERIGgWyTtLREXxfLFBN+y
	l2sILqj94/xMxvsxy+TL3POxnTSzjSqzIUQfucaQlufUOfU608uRAO68C0XUVghv
	NqzLkdvZCU+wQLGfDdd+gyU3ixSvQ/YFpkYPuWI+FgnrqTryAa9G5KFdjCpBSuSW
	k1MeLas04k7HzHkmTwQZurhnMc7yybrexHydqa+JL5gE7hAsna8P6cE52cxcNwGe
	zdY8Vo6S1pmT5fp6qt0xoIbM6eL8IopracBY/Xb6kWQQ6Q==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49jtk735cj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 08 Oct 2025 15:55:24 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4e0e7caf22eso211730911cf.3
        for <linux-kernel@vger.kernel.org>; Wed, 08 Oct 2025 08:55:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759938923; x=1760543723;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7QjSXtuoTslSkSiHaByDppgSFC/oYSQl2GRnyEf5CaQ=;
        b=hvxhQgECR0dTKoyPq8Ia9jmk1bcdI8UnIuCU+bihA9kcepTQ99/P9hibdRG45w8K+b
         +RIrSYznlIPr0cIfvDwkGt5om+B5Saqddo6qABIEy1/Wbkqc1mlLJkYTxsA8VRFkgCU1
         eZ95UCTVXa85eLDbUqY5Gi/HW7wOe2172MW3XN3WG99Z36yGTUpP7iUgtLaaIR9FKXGf
         ff7HnME9pugYB4AqCw6G51jkxVrY7kGmdJAIrTb+36QPRjPXSIWMu1h7hPXXOjyLoxU+
         EyiciyPSnT5OW9LTgjj18Ci7dx7x58AxQB+uNc+X80T2bBGmqG30syOT88HEtoqpUhmo
         53Xg==
X-Forwarded-Encrypted: i=1; AJvYcCWgbwhC1c2sz7vzihJY6TDifu7kJUO3AP/tW6aSY/CMqMDRB+lyqgId0iDEE76t+MUwsL9xMaNHHq7rQ6Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXrQb6PNmWJ2Vb7sk11kd5IOu67aupz0c9KDuYLtkiJ2Dulb6/
	4rnyyfInwrh3ciwW7CioqvyHCdI1Z3YCePkmmdlPLux/K4FAC9zpVlCDSBzSxoLeJ80ZLTpbL4w
	55xZMlQ2nBYdOaQvRMixwqgboQ4KycLo8lD6PIYPJOtDdw5DTAIJ0GPGGnDA2mE8dmkHy8GgBCg
	8=
X-Gm-Gg: ASbGncudSdqEj5AdwCDappZpzDwghYoG1sbJAR/vGmUOnMrmYlktX8juzTtvuYd8blk
	Cfn+TUMDhweXHFMX8jQ/WXWH7WtqJsmgqFwWG1HNhQQBC00RO+6ALeJ27m/zawu/EAQTqazdFxy
	sEyLKfAvR9k9aQMPQza6x1CQQ+iTvKbqnpdYebepwyYV7rU4ay2g7HAdVT7VYbhB4JV3NyNnUel
	i5F3GUzfDuzVb3QgYc+PKyuhzwZwPJz+UUCg+LMmnIV2/2vOKOvLlkE6YgtDG+GYiY9+g6PHiBY
	Q9ISGCpAEs07NtwkMIafK7MvfshTCyJad5vhLNIZyqgDzvWc57z/6VfdOh9MZc8Hm4p5yGRB77W
	icWLBoEGFQGSRwbXl5IY6EtWZwLy20K7WCTWtnLICe+2L7gPV9xMhAdAGog==
X-Received: by 2002:ac8:5f0c:0:b0:4b3:4457:feca with SMTP id d75a77b69052e-4e6eacb4141mr57977061cf.6.1759938922522;
        Wed, 08 Oct 2025 08:55:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHOShZ0ze3T5km1xT0ymN/qoSgsYewOl/wO5Q/jb1euMKp59BWlgXFYBrUMUcmS0FFrbWSJug==
X-Received: by 2002:ac8:5f0c:0:b0:4b3:4457:feca with SMTP id d75a77b69052e-4e6eacb4141mr57976651cf.6.1759938921997;
        Wed, 08 Oct 2025 08:55:21 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5907ad9e092sm108082e87.79.2025.10.08.08.55.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Oct 2025 08:55:21 -0700 (PDT)
Date: Wed, 8 Oct 2025 18:55:18 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Pankaj Patil <pankaj.patil@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 03/24] arm64: dts: qcom: Introduce Glymur base dtsi and
 CRD dts
Message-ID: <xn4cu5vhptfi6ptz3e4w62p3wk52dlquhhdna4nwkqvxm3bpz4@hakz5m2t2b52>
References: <20250925-v3_glymur_introduction-v1-0-24b601bbecc0@oss.qualcomm.com>
 <20250925-v3_glymur_introduction-v1-3-24b601bbecc0@oss.qualcomm.com>
 <p4ajadn2xytkt6hycm4te3sgxg3mern4uq7ce6bfpzgquer5ys@tcvcyuuk6lr2>
 <cdc7fa94-4cfa-4664-92a9-d89654f53d11@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cdc7fa94-4cfa-4664-92a9-d89654f53d11@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA0MDAxNyBTYWx0ZWRfX8qGMECGnJ2WO
 oeEgT+iGcdZQVZ1bu2sN+ctXTUY8ujgRlMMNfrzAeQJxxIB4qsd8aspUAmWb9RfIMjikb5qhGsa
 OlY4jx/DS32QWwU1OMi8nj+GaZ7QIuZT+XJJimy0/kl5AjG/tqwft0P9AXkLSILKiKtAaF/Fp2C
 V6mEhIzkFMAZ9Z6f+oMrBtDmDvQ9Ic844OSCXE+XhD6GcxFrAxxTp2KlNII7Gvjp2si1sRQMjEe
 VSoistptGdFfZ6jiLt1pvQLb2aQ3AhCZ2IDP6B5wAPf9J/bVY3gp1lD8g7evyxfeFGzl+o8EYAj
 dz2rU0HXeaMUNh9fNSmTsLczDMZ9KLHaQXp+/DIbj3+kmuHDD+frlviYCM3OU9HGZpg3cFB9I+w
 IFxt9X4XY7PnyEzTRRfP/adXQHvFJw==
X-Authority-Analysis: v=2.4 cv=do3Wylg4 c=1 sm=1 tr=0 ts=68e6896c cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=x6icFKpwvdMA:10 a=EUspDBNiAAAA:8 a=CFAA7QO4UmtJTJAWpEYA:9 a=CjuIK1q_8ugA:10
 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-GUID: E34ft42bTmS2eaq49rw7tDJGGzxpzFOf
X-Proofpoint-ORIG-GUID: E34ft42bTmS2eaq49rw7tDJGGzxpzFOf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-08_05,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 lowpriorityscore=0 phishscore=0 clxscore=1015
 malwarescore=0 spamscore=0 impostorscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2510040017

On Wed, Oct 08, 2025 at 05:06:16PM +0530, Pankaj Patil wrote:
> On 9/25/2025 11:14 PM, Dmitry Baryshkov wrote:
> > On Thu, Sep 25, 2025 at 12:02:11PM +0530, Pankaj Patil wrote:
> >> Introduce initial device tree support for Glymur - Qualcomm's
> >> next-generation compute SoC and it's associated Compute Reference
> >> Device (CRD) platform.
> >>
> >> The dt describes CPUs, CPU map, GCC and RPMHCC clock controllers,
> >> geni UART, interrupt controller, TLMM, reserved memory,
> >> interconnects, SMMU, firmware scm, watchdog, apps rsc, RPMHPD,
> >> SRAM, PSCI and pmu nodes.
> >>
> >> Signed-off-by: Pankaj Patil <pankaj.patil@oss.qualcomm.com>
> >> ---
> >>  arch/arm64/boot/dts/qcom/Makefile       |    1 +
> >>  arch/arm64/boot/dts/qcom/glymur-crd.dts |   25 +
> >>  arch/arm64/boot/dts/qcom/glymur.dtsi    | 1320 +++++++++++++++++++++++++++++++
> > I think it's usually two separate patches
> 
> Yes, for the next revision planning on separating patches
> in a manner where this commit will have bare-bone board
> dts so compilation doesn't break and singular commit
> to the board dts which enables required functionality.

One commit for SoC.dtsi and another one for the board.dts.

> 
> >>  3 files changed, 1346 insertions(+)
> >>
> >> diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
> >> index 296688f7cb26550f75bce65826f234bc24110356..15f31a7d3ac4a60224c43cfa52e9cc17dc28c49f 100644
> >> --- a/arch/arm64/boot/dts/qcom/Makefile
> >> +++ b/arch/arm64/boot/dts/qcom/Makefile
> >> @@ -13,6 +13,7 @@ dtb-$(CONFIG_ARCH_QCOM)	+= apq8039-t2.dtb
> >>  dtb-$(CONFIG_ARCH_QCOM)	+= apq8094-sony-xperia-kitakami-karin_windy.dtb
> >>  dtb-$(CONFIG_ARCH_QCOM)	+= apq8096-db820c.dtb
> >>  dtb-$(CONFIG_ARCH_QCOM)	+= apq8096-ifc6640.dtb
> >> +dtb-$(CONFIG_ARCH_QCOM)	+= glymur-crd.dtb
> >>  dtb-$(CONFIG_ARCH_QCOM)	+= hamoa-iot-evk.dtb
> >>  dtb-$(CONFIG_ARCH_QCOM)	+= ipq5018-rdp432-c2.dtb
> >>  dtb-$(CONFIG_ARCH_QCOM)	+= ipq5018-tplink-archer-ax55-v1.dtb
> >> diff --git a/arch/arm64/boot/dts/qcom/glymur-crd.dts b/arch/arm64/boot/dts/qcom/glymur-crd.dts
> >> new file mode 100644
> >> index 0000000000000000000000000000000000000000..a1714ec8492961b211ec761f16b39245007533b8
> >> --- /dev/null
> >> +++ b/arch/arm64/boot/dts/qcom/glymur-crd.dts
> >> @@ -0,0 +1,25 @@
> >> +// SPDX-License-Identifier: GPL-2.0-only
> >> +/*
> >> + * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
> >> + */
> >> +
> >> +/dts-v1/;
> >> +
> >> +#include "glymur.dtsi"
> >> +
> >> +/ {
> >> +	model = "Qualcomm Technologies, Inc. Glymur CRD";
> >> +	compatible = "qcom,glymur-crd", "qcom,glymur";
> >> +
> >> +	aliases {
> >> +		serial0 = &uart21;
> >> +	};
> >> +
> >> +	chosen {
> >> +		stdout-path = "serial0:115200n8";
> >> +	};
> >> +};
> >> +
> >> +&tlmm {
> >> +	gpio-reserved-ranges = <4 4>, <10 2>, <44 4>; /*Security SPI (TPM)*/
> >> +};
> >> diff --git a/arch/arm64/boot/dts/qcom/glymur.dtsi b/arch/arm64/boot/dts/qcom/glymur.dtsi
> >> new file mode 100644
> >> index 0000000000000000000000000000000000000000..f1c5a0cb483670e9f8044e250950693b4a015479
> >> --- /dev/null
> >> +++ b/arch/arm64/boot/dts/qcom/glymur.dtsi
> >> @@ -0,0 +1,1320 @@
> >> +// SPDX-License-Identifier: GPL-2.0-only
> >> +/*
> >> + * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
> >> + */
> >> +
> >> +#include <dt-bindings/clock/qcom,glymur-gcc.h>
> >> +#include <dt-bindings/clock/qcom,glymur-tcsr.h>
> >> +#include <dt-bindings/clock/qcom,rpmh.h>
> >> +#include <dt-bindings/dma/qcom-gpi.h>
> >> +#include <dt-bindings/gpio/gpio.h>
> >> +#include <dt-bindings/interconnect/qcom,icc.h>
> >> +#include <dt-bindings/interconnect/qcom,glymur-rpmh.h>
> >> +#include <dt-bindings/interrupt-controller/arm-gic.h>
> >> +#include <dt-bindings/phy/phy-qcom-qmp.h>
> >> +#include <dt-bindings/power/qcom-rpmpd.h>
> >> +#include <dt-bindings/soc/qcom,rpmh-rsc.h>
> >> +#include <dt-bindings/spmi/spmi.h>
> >> +
> >> +/ {
> >> +	interrupt-parent = <&intc>;
> >> +	#address-cells = <2>;
> >> +	#size-cells = <2>;
> >> +
> >> +	chosen { };
> >> +
> >> +	clocks {
> >> +		xo_board: xo-board {
> >> +			compatible = "fixed-clock";
> >> +			clock-frequency = <38400000>;
> >> +			#clock-cells = <0>;
> >> +		};
> >> +
> >> +		sleep_clk: sleep-clk {
> >> +			compatible = "fixed-clock";
> >> +			clock-frequency = <32000>;
> > Can we please adapt a single style here? I think, at least frequency
> > should go to the board file.
> 
> Sure, will do.
> 
> >> +			#clock-cells = <0>;
> >> +		};
> >> +	};
> >> +
> 

-- 
With best wishes
Dmitry

