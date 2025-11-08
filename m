Return-Path: <linux-kernel+bounces-891649-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 59762C4327D
	for <lists+linux-kernel@lfdr.de>; Sat, 08 Nov 2025 18:46:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A9723AFD90
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Nov 2025 17:46:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB0EF26E6E8;
	Sat,  8 Nov 2025 17:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="kqaV966a";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="NY6/HBUn"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BDB62557A
	for <linux-kernel@vger.kernel.org>; Sat,  8 Nov 2025 17:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762624002; cv=none; b=a5wpBR3Xxg42jvaWH7/w3EYn7v5i8zcSLiRTbFVbWQXNlsokHkvGhazMNDFiTj5hi2Dnb5JU9LRoJLVpBgkys93T37rZ+9J98uHzpDKgSvxNVZm5gC6gbcymorqbUQO3cP/7qeIP2Py2mQzWxol2lrASzaeNFbFkxFDV/+ZNGRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762624002; c=relaxed/simple;
	bh=+ZUsB5M51qDmuvpf3r45CIqwqV+m3ss8PCxlWPkYE2A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f2FYZibZx3ErZbTUkIut+aeKk0yXwZswxcg8GkMEM2a8JDBRE1Isy8nPB+DHQ2cF1APzSL91dklbjfOgcD2bXDsb427OgIVRyMab+4SK4GUip6+5SZj2wbhq+0vsJAnBOhgAzimW22OTd8X5p3iRwZ4PAnU3rnYQcLohUSkBQrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=kqaV966a; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=NY6/HBUn; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A8DsRvW1955842
	for <linux-kernel@vger.kernel.org>; Sat, 8 Nov 2025 17:46:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=+xrystILNHZkjAAh5vxxqwIr
	I4Y2QLvNADKRQLrs180=; b=kqaV966a68Y/fYw1+a+MB+ggm42f92SirHWUuS/D
	9YI3LHl4607ks/hyQbQt048+BfaI+3+cynJ8vavtD9Uc8GRfUz/O+RkaiEModCaM
	yB97+tgny4mbgdsVY4fhwLutIoNgsXBxPDHc1jottQzsJc6WWw3M6VezfTayne5/
	nBfy49Mfh0d1Cm2fd+UJTIeubmQcAhqSg51SaWGAPJkh9g/bOl2/lXzOQ5jKfsTY
	yyJa8/kVdPmPcvaUqBDmk6bxLAIShSGmCmkqtLfTvIpJK/qJ19h/0uuwodvWV9/8
	Al7LTCLTKKAy8lg21BQ8cd1W3JMsk8Jx4CpXAGTFx+dnZQ==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a9xw58xn2-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Sat, 08 Nov 2025 17:46:39 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4ed793c1f20so43346221cf.1
        for <linux-kernel@vger.kernel.org>; Sat, 08 Nov 2025 09:46:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762623999; x=1763228799; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+xrystILNHZkjAAh5vxxqwIrI4Y2QLvNADKRQLrs180=;
        b=NY6/HBUnGTyi1461L8EZ7j45aAXtYK1kBrorLYvcVzqw++7q40VdTsCHeQsbOQoUnB
         Ci3Lr+RwqaozgBEglOBwe9N0Gc9ebJATri6x2SjO2htTNwfWu06XocIsM9kxAL/f1KRn
         C+rnLkE7nfoYF0dcCzoMcpdfRB4QgUqauq5JqX5oxDWRPj6kYgCUhBv+yogLAyvJ4+6+
         uFSELXtoQAGc1F1Eu+49d6AzN51ueupLljSh7EqBy+wdJE/5h6EIkfK6ppgA5RALmdJA
         vTwQxmZ85j72rO/OcCw9+gDPc76fUda2B1PEsbgGO+0DlKG5c4wRporQWNBjWPxxNoh2
         a+6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762623999; x=1763228799;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+xrystILNHZkjAAh5vxxqwIrI4Y2QLvNADKRQLrs180=;
        b=pvnpPi7U43LHJcyzdyHBfHOikq/jqjZ6HGD3EDhXvdKoGGpgvx0vOMRbPfcHuA0Phh
         KhZLPT5nr28Nz51zRAG+fkDom+rL2nPlrIy8Me51S5Q9F1PGX12EH9drOu6kG3sFawRF
         eZsQhx6pW98Fb7ipN78hELY7V8wXaNmfGWPyLszM+WmjnFoULjNMDbKtWLmh1QtxN2zs
         xJ5tzHRvPuRYpCyEWPmKGBmiIRro3WbMLZxRQj+INanmbRG7t6przMMhO+NRraCyzf1o
         uTny7pBaYDhKL1E7QCEpmTYkCvJjhKBIlbIqKEr8vHh3GaLYL4ZDYKL+UaNHKaHnxUZn
         yLhA==
X-Forwarded-Encrypted: i=1; AJvYcCVsyB/8vX730b9j5ieioiS1RBTQBBAaM6lEaDU53YirIIApH07+hqHCo6Zid/fgTXR4PrbiNrVy0YsX7kE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxhOQsHlvsOpbU5HJJSIyBi1WoWM0I9t9DbKH28TIdwHgJiGHEQ
	9Cy26hBLJRj9G8uRvM7SF9hqNwnkFh+p4FjS7J0ZRH+JZUTs1STAM5MJzQk8Ry+t3dGpcEC8YPg
	AovON7FA45eXjpQ9+E9ebuBztpS3gTPa/iFuVu02bk+EUU+mPJIiE3atoZN2+J7WLX50=
X-Gm-Gg: ASbGnctjriLIHHHqloMTERE1dyKr7jdkSf0D0iO9HHy8lXwxIYbPm58EWSc4PGCq/zR
	zpa12l6MTViKVTSQvR3lJ3rFpRpivsr6euyQFV5pKNfW4P03le1r3/ZMhMXAnmgeLKqvbqwCUpO
	G0ET1v47bAEcy5BtfRjnH4sziOrmTLBp6p93LKI1YTTb1fRa0Kbxu3GsziCkt0b5M3ED5eTgWwJ
	IhodyJwe1T3XFBlYcvO9+LI552Wski5yDIGMGwnRqXK+8vAVSc+EshqtWC1Slx93+0WTau77T/H
	V5KGslqneTIZN8hYG3k6jFUyA/b9+BnjQRYouCWf52RKoH2jNB/ztbObzfkYT/xfD6Ipk75rofF
	+vHZKTyeS6vqt9YIHLf0uNsKiWlaX+cLlQbKDGj1H3zz3FgNYd/Vk3NEiXZmbjXLc+vy2FW6tSu
	cBGYM+UexOhm+G
X-Received: by 2002:ac8:5756:0:b0:4ed:680e:29cd with SMTP id d75a77b69052e-4eda4ed8fdbmr41131441cf.27.1762623998740;
        Sat, 08 Nov 2025 09:46:38 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFIjMlHccRu36QczAFr/a+/xcMuuk9BDbrD4T6DRX0eS6Ya3buU3tlxLwTOcZIDMnaIUucI2A==
X-Received: by 2002:ac8:5756:0:b0:4ed:680e:29cd with SMTP id d75a77b69052e-4eda4ed8fdbmr41131111cf.27.1762623998303;
        Sat, 08 Nov 2025 09:46:38 -0800 (PST)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-37a5f058262sm21427801fa.11.2025.11.08.09.46.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Nov 2025 09:46:36 -0800 (PST)
Date: Sat, 8 Nov 2025 19:46:34 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Luca Weiss <luca.weiss@fairphone.com>
Cc: Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/5] interconnect: qcom: icc-rpmh: Get parent's regmap
 for nested NoCs
Message-ID: <iwlvslb3yzmal7m5dpks46s2jv2v72hhrtrmirtptjmt3pgvks@bs6ohfgefmro>
References: <20251107-sm6350-icc-qos-v1-0-8275e5fc3f61@fairphone.com>
 <20251107-sm6350-icc-qos-v1-2-8275e5fc3f61@fairphone.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251107-sm6350-icc-qos-v1-2-8275e5fc3f61@fairphone.com>
X-Proofpoint-ORIG-GUID: TvnNZORUoVvUDjRcxLjgSoJErpWZBwhI
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA4MDE0NCBTYWx0ZWRfX4xoinbNKxU75
 aNO9VKbC+pLjrNjnlLwNvNW4z0JXFX7AddxiUcrecogjvntk67wNV7XS4C2rnddu9ub9i/80Xcg
 a+Bp931sP4vhytQoCt85aAiUgRWizeJRmmHbL9ifbXGdbuiKszR8YJU0ryacvFWTMNpcZ99bPhv
 ro5coZsfCRfDSNxttcZtu62l7t8mYilDkhr/Gm+qkKUBb4Gqe1Ustf2O9u0zChKOG+FXt/qx6oT
 sW2KrBc5RNZP/AEQz68s0AsG0ai0pOy0G53wk2/LK65m5/q2JxqiBVLZNZ3at+4lzJf+BKU0OZE
 nKg9HCLHUWmaK7gHLTzoxluUXiqcuPdw3/ONNmyGUWNogCHwg+1eX7pqkOUqLpi3wYMv10NfjYC
 Eb642AYjNpdbn5An5HrKKpMzcRgUuw==
X-Proofpoint-GUID: TvnNZORUoVvUDjRcxLjgSoJErpWZBwhI
X-Authority-Analysis: v=2.4 cv=FoQIPmrq c=1 sm=1 tr=0 ts=690f81ff cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=6H0WHjuAAAAA:8 a=u_fiScQ_Z3bZvJszJhYA:9 a=CjuIK1q_8ugA:10
 a=uxP6HrT_eTzRwkO_Te1X:22 a=Soq9LBFxuPC4vsCAQt-j:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-08_05,2025-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 priorityscore=1501 adultscore=0 clxscore=1015
 malwarescore=0 impostorscore=0 phishscore=0 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511080144

On Fri, Nov 07, 2025 at 05:08:48PM +0100, Luca Weiss wrote:
> Since commit 57eb14779dfd ("interconnect: qcom: icc-rpmh: Support child
> NoC device probe") the icc-rpmh driver supports initializing child NoCs,
> but those child NoCs also need to be able to get the parent's regmap in
> order to enable QoS.
> 
> Change the driver to support that and support programming QoS register.
> 
> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
> ---
>  drivers/interconnect/qcom/icc-rpmh.c | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/interconnect/qcom/icc-rpmh.c b/drivers/interconnect/qcom/icc-rpmh.c
> index f90c29111f48..2103185a44a5 100644
> --- a/drivers/interconnect/qcom/icc-rpmh.c
> +++ b/drivers/interconnect/qcom/icc-rpmh.c
> @@ -308,7 +308,16 @@ int qcom_icc_rpmh_probe(struct platform_device *pdev)
>  		struct resource *res;
>  		void __iomem *base;
>  
> -		base = devm_platform_get_and_ioremap_resource(pdev, 0, &res);
> +		res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +		if (!res) {
> +			/* Try parent's regmap */
> +			qp->regmap = dev_get_regmap(dev->parent, NULL);
> +			if (qp->regmap)
> +				goto regmap_done;

And this turns into spaghetty. What about:

	qp->regmap = dev_get_regmap();
	if (!qp->regmap) {
	   base = devm_platform_get_and_ioremap_resource();
	   // handle the error
	   qp->regmap = devm_regmap_init_mmio();
	   // handle the error, goto skip_qos_config
	}


> +			goto skip_qos_config;
> +		}
> +
> +		base = devm_ioremap_resource(dev, res);
>  		if (IS_ERR(base))
>  			goto skip_qos_config;
>  
> @@ -318,6 +327,7 @@ int qcom_icc_rpmh_probe(struct platform_device *pdev)
>  			goto skip_qos_config;
>  		}
>  
> +regmap_done:
>  		qp->num_clks = devm_clk_bulk_get_all(qp->dev, &qp->clks);
>  		if (qp->num_clks == -EPROBE_DEFER)
>  			return dev_err_probe(dev, qp->num_clks, "Failed to get QoS clocks\n");
> 
> -- 
> 2.51.2
> 

-- 
With best wishes
Dmitry

