Return-Path: <linux-kernel+bounces-813021-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 73EB8B53FC4
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 03:18:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA4A11B27761
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 01:18:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F119318C31;
	Fri, 12 Sep 2025 01:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ML384WLP"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1D21219E8
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 01:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757639901; cv=none; b=eNHJVxlvGKe+fSEuikX+ASe0zt0/fII4RyJtuqu5lfFGikDEyajrFHQqdXsCIiC4XGZr1Jz7AbfBdympy3HVqU79Pk49/2EPl8iS3oJUrD+nJ+AK+qy58mzoymLJFGgU07qBEH14QhElKUR7YhIC61itA1UNNV0aqdQqkY7mCYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757639901; c=relaxed/simple;
	bh=h9qaaXSqvN9cBSTuj957sTTg4kjY5I2KZ2UivSEhI8Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BzszPwnmDPQdoQziNk5R738Psk7q6EVettvpALyJ6cEonUkokI2iMPidgaW1CAhrzpOKfnUHKwDA0HZRrUrUX9fy//6hlYVTwJQCbF+cYGC3JzCh2Q3Oa9J15O+s3n8ulNRmMW9P8Q9vfRIs+BMDrgyKfjcx8PAn5FrlBK6O50Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ML384WLP; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58BNKTa6002431
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 01:18:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	7MDT5wpotH29qgokGXIt19ncw6IhYm6XttDNFxIDNqI=; b=ML384WLPI0lO26Tj
	lQZxrvI1G9I3++QNOnGlZ+fA15ERR9k2GoRmpZkq/B/lkw7aGXEeDDeOcCc4dPLf
	15sVugOVbRg5sIuAl64tVghq+8GU4i3V26VXgjxiYLP/NkVLmQM+bUDvTI+AfCEF
	4H8emOm6W0ZNDmGc/yYxUWBy/Aby/bqYH2ZUFSJaWZY0bqQHVFIwbBMjVgmLF3ZJ
	RNcldacG/x0KGKSRgavKfQUalRkleLquSiVyJM/xGQ41R0BOOxLYKwfMK4kM2WuG
	fSWGr3iHLTUWFhfyOE/5l7/Ul6syRO4YKwBqrPU+aktCTirMO1abuyQEyQejCNHg
	ePlHxw==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 493ydv1y0f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 01:18:16 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-8178135137fso384791685a.2
        for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 18:18:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757639896; x=1758244696;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7MDT5wpotH29qgokGXIt19ncw6IhYm6XttDNFxIDNqI=;
        b=Y9sKLpQpHpdiGB3lFGtTZTbt/4wLQXAzq/3I4DZqERsYkbqNlbWfqnMcyaB8nHK29B
         9kCcGUD8qS+hvOByxfVLpTXjwENwVYJZAUK5PonETAQzo2Xg+yKy+fkePsuEITxb+Lge
         XI/gHHXm6TTWyR+uTZcr0KMRhSevL9V0pSH6waKbDUQGMhHZwhfDAX7GFOUKM4PiHIjg
         bnShmfHROZBgo2cResKlsdb2WFUaday57KtaZWiC+LfR5Sl1fHGcRH2BLWym1qG7EhRs
         s0PvnQs7MLceFS3l38G58Fts6QEu+pPcD+mO24f0Ut1RBTk8vbC40LZ5w3v32K8yltdX
         FWJA==
X-Forwarded-Encrypted: i=1; AJvYcCWCcP5IjV98h2cm370w7+srNq6tjoMAO2tAtUtZh33A9bR3zJ4g/xHgVqcaDrwFRNQZ7YqmQ/RNQvM1toU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYqE2xUIZ00fB9uSNN0tYwErFR3qsVBqmpQBQFUuLTNpp3A1Ip
	6jcLIB+Bb5S3srF4+QC3UUZOZBWq9zslyppOXXSg05/ke+zh6lBPwJ6zfdpvb+nLlM8IdVKh3Sp
	EGEbytdE8N2Zf1RY5K69HFmRxyb4GIHQg63IWo6QpwiO8YXAnXfdvABvJ0+9hJgw08Jc=
X-Gm-Gg: ASbGnct/MFl2sEPF79imgDq+BAH0PpeqPiwbMfUTcS3/p6VUYHorILUTrodMq5jxaGs
	IzdOYtvJMCsz3K3t+thDnrLdxaXi+iYKlQ8nmClKsPrhl8SIgyCs7UYYBu9YPnWxNoeqT1Kco1P
	AJb0aYQ+Dfq6oQ4nnSfYnwxV6Yxh2Py59jVZR0WssRRl5PTbSi0Qjhkw7CutQennoH0eNYfTCQG
	8XVx2NwKKqdeug61zWP2Fr7ROvqJ/8cbCoknpA/MDhYQSCj+D57lp+nzUrx9MCh/qI4rPaBdRyW
	WFjFsE5J3sq3rPAagT4jYWpduMczZmesLwKoBwdEro9/R0C3B6WCC3OGZKmDWRkKI1toGQmgueC
	Qd8KedXa6/a8bzAUXCnDFi50whZ1SYHyUYJhdjf3A6DZ/WfkyqScd
X-Received: by 2002:a05:620a:ab06:b0:816:461c:f9bd with SMTP id af79cd13be357-8240084e246mr159508785a.44.1757639895674;
        Thu, 11 Sep 2025 18:18:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFZHSKnYlZZHqZR6Hj9n+C0UmRrNSc/yTGeOKw7+RBx03laoFH6xZ7XxJqWCd7NVxlWZWClAg==
X-Received: by 2002:a05:620a:ab06:b0:816:461c:f9bd with SMTP id af79cd13be357-8240084e246mr159506485a.44.1757639895218;
        Thu, 11 Sep 2025 18:18:15 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-34f1c6cabedsm5830451fa.69.2025.09.11.18.18.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Sep 2025 18:18:13 -0700 (PDT)
Date: Fri, 12 Sep 2025 04:18:10 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Eric =?utf-8?Q?Gon=C3=A7alves?= <ghatto404@gmail.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RESEND PATCH v8 1/1] arm64: dts: qcom: add initial support for
 Samsung Galaxy S22
Message-ID: <l3c4hjgcjmc3fsxcyanskvy2rotewk6hdj7wbvcs7gcdfcpfoq@f3rgc2zak33n>
References: <20250911224734.51415-1-ghatto404@gmail.com>
 <20250911224734.51415-2-ghatto404@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250911224734.51415-2-ghatto404@gmail.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTExMDEyMCBTYWx0ZWRfX+eiRpWOrYcnX
 1jXVcQVs9PzOeGP9wr5gyYxXZakJXsTrP1x9adBdDlg9XSLhzlHZG7o7qtDjcfFuss4JJSq55PV
 BMKftaBMAHnP+HCCR121gKVORQSWxt3uVHVXS0SQJWbSIgiEAWb5dB4uG6vODuNkFljzI5/EBxv
 Pf0d0sPQ0Rl1MiKwDjVRSHAsoVxbtlnVuH2g/n+R6ENVICepY9sCAsAm+oibd7DPORZNXLLAnmq
 7pMStQYX0cpo9b0i9yXsWKWYOTq1f1d1nI1Mo+Ao6LHt7C86zZuqoamlCEOmVGhwxi3K2QtLSAm
 +wCGe/STvVi1h3YQvmK2nK8TKmHCCEZPRV8WaCxWxjCudnDy9qPwingkjmR42yhjibWFfYPiZ0M
 j+NPO0B8
X-Proofpoint-GUID: 0QWdUqvhDmhA53KmSq0W7KDQ3kPjXU4t
X-Proofpoint-ORIG-GUID: 0QWdUqvhDmhA53KmSq0W7KDQ3kPjXU4t
X-Authority-Analysis: v=2.4 cv=LoaSymdc c=1 sm=1 tr=0 ts=68c374d8 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10
 a=yJojWOMRYYMA:10 a=pGLkceISAAAA:8 a=QWxc95z4xnr1JtQ8ubcA:9 a=3ZKOabzyN94A:10
 a=wPNLvfGTeEIA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-11_04,2025-09-11_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 spamscore=0 impostorscore=0 suspectscore=0 clxscore=1015
 malwarescore=0 phishscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509110120

On Thu, Sep 11, 2025 at 10:47:29PM +0000, Eric Gonçalves wrote:
> Add new device support for the Samsung Galaxy S22 (SM-S901E) phone
> 
> What works:
> - SimpleFB
> - USB
> 
> Signed-off-by: Eric Gonçalves <ghatto404@gmail.com>
> ---
>  arch/arm64/boot/dts/qcom/Makefile             |   1 +
>  .../boot/dts/qcom/sm8450-samsung-r0q.dts      | 145 ++++++++++++++++++
>  2 files changed, 146 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/qcom/sm8450-samsung-r0q.dts
> 
> diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
> index 94a84770b080..d311e637327e 100644
> --- a/arch/arm64/boot/dts/qcom/Makefile
> +++ b/arch/arm64/boot/dts/qcom/Makefile
> @@ -285,6 +285,7 @@ dtb-$(CONFIG_ARCH_QCOM)	+= sm8350-sony-xperia-sagami-pdx214.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= sm8350-sony-xperia-sagami-pdx215.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= sm8450-hdk.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= sm8450-qrd.dtb
> +dtb-$(CONFIG_ARCH_QCOM)	+= sm8450-samsung-r0q.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= sm8450-sony-xperia-nagara-pdx223.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= sm8450-sony-xperia-nagara-pdx224.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= sm8550-hdk.dtb
> diff --git a/arch/arm64/boot/dts/qcom/sm8450-samsung-r0q.dts b/arch/arm64/boot/dts/qcom/sm8450-samsung-r0q.dts
> new file mode 100644
> index 000000000000..b7533c2287b7
> --- /dev/null
> +++ b/arch/arm64/boot/dts/qcom/sm8450-samsung-r0q.dts
> @@ -0,0 +1,145 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +
> +/dts-v1/;
> +
> +#include <dt-bindings/regulator/qcom,rpmh-regulator.h>
> +
> +#include "sm8450.dtsi"
> +#include "pm8350.dtsi"
> +#include "pm8350c.dtsi"
> +
> +/ {
> +	model = "Samsung Galaxy S22 5G";
> +	compatible = "samsung,r0q", "qcom,sm8450";
> +	chassis-type = "handset";
> +
> +	chosen {
> +		#address-cells = <2>;
> +		#size-cells = <2>;
> +		ranges;
> +
> +		framebuffer: framebuffer@b8000000 {
> +			compatible = "simple-framebuffer";
> +			reg = <0x0 0xb8000000 0x0 0x2b00000>;
> +			width = <1080>;
> +			height = <2340>;
> +			stride = <(1080 * 4)>;
> +			format = "a8r8g8b8";
> +		};
> +	};
> +
> +	vph_pwr: vph-pwr-regulator {

Could you please change this to regulator-vph-pwr? This keeps all
regulator nodes together.

LGTM otherwise

> +		compatible = "regulator-fixed";
> +		regulator-name = "vph_pwr";
> +		regulator-min-microvolt = <3700000>;
> +		regulator-max-microvolt = <3700000>;
> +		regulator-always-on;
> +		regulator-boot-on;
> +	};
> +

-- 
With best wishes
Dmitry

